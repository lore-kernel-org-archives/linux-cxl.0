Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k8MP7TOm"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD1B8E
	for <linux-cxl@vger.kernel.org>; Wed, 13 Dec 2023 08:42:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702485753; x=1734021753;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=rN3xUsoQR9x4rGo61u3iiFEWPHoPRdReRL0lpvzXg5o=;
  b=k8MP7TOmC7U2SkDpwAJzBCYUXXKJU9gxOZjJ0SIukGf9SsVvgz5GQhnO
   4HESp1d/MHerw40dg9PLH1uRIMGUX2YV7okgK38NL2CfkYuxkF7WkJhEr
   y/M5EnRKlODGDFJERZZ2hv8uu0HIy1pjk89HFQBzKE/NC1kiqcXIZp2TU
   4GeSWlMq3659VkDpDokR2hmV484p/D27ef4gyi7927pWagtB0ZKm/TAXn
   NBkGnyG3UMahvnqUBAfGQO7PXjqbAPem4mF4rcbBSeq+U3Q5mJjsGKpoB
   wdxXns1/SrafeBaB14xakfSQNnhH04F4QlRs2t2N8+6JfOBJxYMrLHGPy
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="398833653"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="398833653"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="774009734"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="774009734"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.76.225])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 08:42:32 -0800
Subject: [PATCH v14 12/19] cxl: Calculate and store PCI link latency for the
 downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Wed, 13 Dec 2023 09:42:32 -0700
Message-ID: <170248575204.801570.14393126326503978965.stgit@djiang5-mobl3>
In-Reply-To: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
References: <170248552797.801570.14580769385012396142.stgit@djiang5-mobl3>
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
v14:
- Remove symbol export for cxl_pci_get_latency (Dan)
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


