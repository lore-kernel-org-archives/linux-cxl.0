Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 860CF810
	for <linux-cxl@vger.kernel.org>; Wed, 11 Oct 2023 01:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtpZYBfB"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FA89B
	for <linux-cxl@vger.kernel.org>; Tue, 10 Oct 2023 18:06:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696986396; x=1728522396;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NaLChICiLZ/Z0LB0WxH2wHcFfwCojmt1VJkWgz6qihQ=;
  b=gtpZYBfB9OZLuv15LneyCeMHSOyaYHzxR/wtppCsRTVZgICtNyYYpXwo
   6k0DrJTSLK7/wphQR+WJ5Pa7Nln7gd0H1KTlZMdyzs891/tn5Zjn/fSyq
   tYtwmapIRV6WcAD3Fhj/6a3NVeCJjU4pe0cmHSvkYSPG9E0IJEJeVMTcg
   5vlaitxPfLTp5uW6ZLsQitLoiZd0ltcr1wdaIsq/sIT/9lEr+VwASKaIq
   nOwTbUU9JTXTZMiTuDmI+P+8TOha3IjzbI3ELkXBXL/QHwfoZVoDKuwiA
   UT4NUdG4agWwNdWrGwoPdDLWPlg7Nm4mMFz9PLsGqOtDymw6zodRUGTq9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451043434"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451043434"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:06:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="753647069"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="753647069"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.35.251])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 18:06:35 -0700
Subject: [PATCH v10 16/22] cxl: Calculate and store PCI link latency for the
 downstream ports
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com,
 ira.weiny@intel.com, vishal.l.verma@intel.com, alison.schofield@intel.com,
 Jonathan.Cameron@huawei.com, dave@stgolabs.net
Date: Tue, 10 Oct 2023 18:06:35 -0700
Message-ID: <169698639504.1991735.3354586175699511632.stgit@djiang5-mobl3>
In-Reply-To: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
References: <169698612949.1991735.1140524325982776941.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The latency is calculated by dividing the flit size over the bandwidth. Add
support to retrieve the flit size for the CXL switch device and calculate
the latency of the PCIe link. Cache the latency number with cxl_dport.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c  |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    6 ++++
 drivers/cxl/cxl.h       |    4 +++
 drivers/cxl/cxlpci.h    |   15 ++++++++++
 4 files changed, 98 insertions(+)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index c86bcc181a5d..bf244ce1d11f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/units.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
@@ -783,3 +784,75 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
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
+ * @pdev - PCI device
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
+EXPORT_SYMBOL_NS_GPL(cxl_pci_get_latency, CXL);
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 23403538505b..3b45da2b425e 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -793,6 +793,9 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (parent_dport && dev_is_pci(uport_dev))
+		port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport_dev));
+
 	return port;
 
 err:
@@ -1067,6 +1070,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (dev_is_pci(dport_dev))
+		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
+
 	return dport;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 587677fc597c..f1c43f02d65e 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -586,6 +586,7 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @pci_latency: Upstream latency in picoseconds
  */
 struct cxl_port {
 	struct device dev;
@@ -609,6 +610,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	long pci_latency;
 };
 
 struct cxl_root_ops {
@@ -654,6 +656,7 @@ struct cxl_rcrb_info {
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @coord: access coordinates (performance) for switch from CDAT
+ * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
 	struct device *dport_dev;
@@ -663,6 +666,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct access_coordinate coord;
+	long link_latency;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 0fa4799ea316..466563536a92 100644
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
@@ -93,4 +106,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+long cxl_pci_get_latency(struct pci_dev *pdev);
+
 #endif /* __CXL_PCI_H__ */


