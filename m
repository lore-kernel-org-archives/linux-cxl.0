Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7CC77F20
	for <linux-cxl@vger.kernel.org>; Thu, 21 Dec 2023 22:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n/nSoxP7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703196221; x=1734732221;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xKNXDFKxVqypjFdgZlCeePSWig6y+Cl2imTZ1L/Fxyg=;
  b=n/nSoxP7NclKOoktMj7luS5Tr3HLIExbquQGDnYqcJfVRuAUHx7NK6UF
   fylBFq3NK/+4xCQk0L07qT9/GXfthToroK3H0XLUeTYeUSmsd6irt60YM
   udxf8KOjSccsfIhM8JTNJ8mclgFFMdb7yFILcquBCdtIy0XfQ7chzy2Wk
   PK3JsALysj/nfOLK3BEtv5/nh0uF65VtzzNoUJtnYV76VvTZqic0MVQuj
   Ue+FM589UbuVrcCbw+rqGbjzoX0h51h5o6ih67f0AsGcrhHfonYljwT1d
   oykcxp+pIExx18A2GyAjyUctTheSStW4fnp9OYezc6UlStkzb1XC7ld51
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10931"; a="376184515"
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="376184515"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,294,1695711600"; 
   d="scan'208";a="25116201"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.31.86])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 14:03:40 -0800
Subject: [PATCH v15 12/19] cxl: Calculate and store PCI link latency for the
 downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Thu, 21 Dec 2023 15:03:39 -0700
Message-ID: <170319621931.2212653.6800240203604822886.stgit@djiang5-mobl3>
In-Reply-To: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
References: <170319606771.2212653.5435838660860735129.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The latency is calculated by dividing the flit size over the bandwidth. Add
support to retrieve the flit size for the CXL switch device and calculate
the latency of the PCIe link. Cache the latency number with cxl_dport.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h |    2 +
 drivers/cxl/core/pci.c  |   72 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    6 ++++
 drivers/cxl/cxl.h       |    4 +++
 drivers/cxl/cxlpci.h    |   13 ++++++++
 5 files changed, 97 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 86d7ba23235e..3b64fb1b9ed0 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -88,4 +88,6 @@ enum cxl_poison_trace_type {
 	CXL_POISON_TRACE_CLEAR,
 };
 
+long cxl_pci_get_latency(struct pci_dev *pdev);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index eff20e83d0a6..a014d49d2f12 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/units.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
@@ -980,3 +981,74 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 	return PCI_ERS_RESULT_NEED_RESET;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_error_detected, CXL);
+
+extern const unsigned char pcie_link_speed[];
+
+static enum pci_bus_speed get_link_speed(struct pci_dev *pdev)
+{
+	u16 linkstat;
+	int err;
+
+	err = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &linkstat);
+	if (err)
+		return -EINVAL;
+
+	return pcie_link_speed[linkstat & PCI_EXP_LNKSTA_CLS];
+}
+
+static int pci_bus_speed_to_mbps(enum pci_bus_speed speed)
+{
+	switch (speed) {
+	case PCIE_SPEED_2_5GT:
+		return 2500;
+	case PCIE_SPEED_5_0GT:
+		return 5000;
+	case PCIE_SPEED_8_0GT:
+		return 8000;
+	case PCIE_SPEED_16_0GT:
+		return 16000;
+	case PCIE_SPEED_32_0GT:
+		return 32000;
+	case PCIE_SPEED_64_0GT:
+		return 64000;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
+static int cxl_flit_size(struct pci_dev *pdev)
+{
+	if (cxl_pci_flit_256(pdev))
+		return 256;
+
+	return 68;
+}
+
+/**
+ * cxl_pci_get_latency - calculate the link latency for the PCIe link
+ * @pdev: PCI device
+ *
+ * return: calculated latency or 0 for no latency
+ *
+ * CXL Memory Device SW Guide v1.0 2.11.4 Link latency calculation
+ * Link latency = LinkPropagationLatency + FlitLatency + RetimerLatency
+ * LinkProgationLatency is negligible, so 0 will be used
+ * RetimerLatency is assumed to be negligible and 0 will be used
+ * FlitLatency = FlitSize / LinkBandwidth
+ * FlitSize is defined by spec. CXL rev3.0 4.2.1.
+ * 68B flit is used up to 32GT/s. >32GT/s, 256B flit size is used.
+ * The FlitLatency is converted to picoseconds.
+ */
+long cxl_pci_get_latency(struct pci_dev *pdev)
+{
+	long bw;
+
+	bw = pci_bus_speed_to_mbps(get_link_speed(pdev));
+	if (bw < 0)
+		return 0;
+	bw /= BITS_PER_BYTE;
+
+	return cxl_flit_size(pdev) * MEGA / bw;
+}
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 955a99cff22d..9829f95ed77e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -856,6 +856,9 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (parent_dport && dev_is_pci(uport_dev))
+		port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));
+
 	return port;
 
 err:
@@ -1139,6 +1142,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (dev_is_pci(dport_dev))
+		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
+
 	return dport;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index abbdcd3a7596..7da8db919a20 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -591,6 +591,7 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @pci_latency: Upstream latency in picoseconds
  */
 struct cxl_port {
 	struct device dev;
@@ -613,6 +614,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	long pci_latency;
 };
 
 struct cxl_root_ops {
@@ -659,6 +661,7 @@ struct cxl_rcrb_info {
  * @port: reference to cxl_port that contains this downstream port
  * @regs: Dport parsed register blocks
  * @sw_coord: access coordinates (performance) for switch from CDAT
+ * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -669,6 +672,7 @@ struct cxl_dport {
 	struct cxl_port *port;
 	struct cxl_regs regs;
 	struct access_coordinate sw_coord;
+	long link_latency;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0fa4799ea316..711b05d9a370 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -85,6 +85,19 @@ struct cdat_entry_header {
 	__le16 length;
 } __packed;
 
+/*
+ * CXL v3.0 6.2.3 Table 6-4
+ * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
+ * mode, otherwise it's 68B flits mode.
+ */
+static inline bool cxl_pci_flit_256(struct pci_dev *pdev)
+{
+	u16 lnksta2;
+
+	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
+}
+
 int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,


