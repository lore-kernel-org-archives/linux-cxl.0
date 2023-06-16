Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8B9AEB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 21:42:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230122AbjFPVmM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 17:42:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjFPVmL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 17:42:11 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A635A6
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 14:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686951729; x=1718487729;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gp7f1kW2h8rkm4rFhwWgsYi0Co9c97gvIrkbHduxBGU=;
  b=RQQ2G0z/ZvlxSF5k/cRxchb4ZxzrJXi/5uKod9U6HqzQHssfmgCNZ872
   hC7F87fkYV/S8qopRB/tOUZ3yt+i7FY36T26KTkFqYJShleGGrEOcHy7o
   7cXIkPwfV2bmtdFwTXi65ZSjEA8LmKrqeL/DIm0z4qLmNYk/K14sdL0+I
   7u25Tb++c8ixdz59vVEW9PoqOKEG2ErsiJ/LW2wQJbXG7JZaIb2OESQhN
   7t6QnHpxo1kkmODPbMmOjRq8U5E0YjXMTfqnH1JVFvbxCwXmSMk+v7TvS
   f0yBD036ELDygrSchb7gv47T9MJpS2e8oBQ3Lob6/30BZ/YmsXLIQ8Bm4
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="362733594"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="362733594"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="959757332"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="959757332"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [192.168.1.177]) ([10.212.16.91])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 14:42:08 -0700
Subject: [PATCH v7 05/11] cxl: Calculate and store PCI link latency for the
 downstream ports
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
Date:   Fri, 16 Jun 2023 14:42:08 -0700
Message-ID: <168695172882.3031571.3267144362710377933.stgit@djiang5-mobl3>
In-Reply-To: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
References: <168695160531.3031571.4875512229068707023.stgit@djiang5-mobl3>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The latency is calculated by dividing the flit size over the bandwidth. Add
support to retrieve the flit size for the CXL switch device and calculate
the latency of the PCIe link. Cache the latency number with cxl_dport.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v5:
- Store the latency numbers under dports. (Dan)
- Use defines instead of magic numbers. (Jonathan)
v2:
- Fix commit log issues. (Jonathan)
- Fix var declaration issues. (Jonathan)
---
 drivers/cxl/core/pci.c  |   73 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    6 ++++
 drivers/cxl/cxl.h       |    4 +++
 drivers/cxl/cxlpci.h    |   15 ++++++++++
 drivers/cxl/pci.c       |   13 --------
 5 files changed, 98 insertions(+), 13 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 50b6fc0afc7e..84c2c9a1dd86 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
+#include <linux/units.h>
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/delay.h>
@@ -802,3 +803,75 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
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
index dd18c6eb3833..73aa8ebb36e6 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -750,6 +750,9 @@ static struct cxl_port *__devm_cxl_add_port(struct device *host,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (parent_dport && dev_is_pci(uport))
+		port->pci_latency = cxl_pci_get_latency(to_pci_dev(uport));
+
 	return port;
 
 err:
@@ -1006,6 +1009,9 @@ __devm_cxl_add_dport(struct cxl_port *port, struct device *dport_dev,
 	if (rc)
 		return ERR_PTR(rc);
 
+	if (dev_is_pci(dport_dev))
+		dport->link_latency = cxl_pci_get_latency(to_pci_dev(dport_dev));
+
 	return dport;
 }
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 6733569afac3..208e98225abf 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -562,6 +562,7 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @pci_latency: Upstream latency in picoseconds
  */
 struct cxl_port {
 	struct device dev;
@@ -584,6 +585,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	long pci_latency;
 };
 
 struct qtg_dsm_input {
@@ -635,6 +637,7 @@ cxl_find_dport_by_dev(struct cxl_port *port, const struct device *dport_dev)
  * @rch: Indicate whether this dport was enumerated in RCH or VH mode
  * @port: reference to cxl_port that contains this downstream port
  * @coord: access coordinates (performance) for switch from CDAT
+ * @link_latency: calculated PCIe downstream latency
  */
 struct cxl_dport {
 	struct device *dport;
@@ -644,6 +647,7 @@ struct cxl_dport {
 	bool rch;
 	struct cxl_port *port;
 	struct access_coordinate coord;
+	long link_latency;
 };
 
 /**
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 7c02e55b8042..1772cd226108 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -84,6 +84,19 @@ struct cdat_entry_header {
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
@@ -92,4 +105,6 @@ void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
 				    pci_channel_state_t state);
+long cxl_pci_get_latency(struct pci_dev *pdev);
+
 #endif /* __CXL_PCI_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0872f2233ed0..5f1b2f7239bc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -365,19 +365,6 @@ static bool is_cxl_restricted(struct pci_dev *pdev)
 	return pci_pcie_type(pdev) == PCI_EXP_TYPE_RC_END;
 }
 
-/*
- * CXL v3.0 6.2.3 Table 6-4
- * The table indicates that if PCIe Flit Mode is set, then CXL is in 256B flits
- * mode, otherwise it's 68B flits mode.
- */
-static bool cxl_pci_flit_256(struct pci_dev *pdev)
-{
-	u16 lnksta2;
-
-	pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
-	return lnksta2 & PCI_EXP_LNKSTA2_FLIT;
-}
-
 static int cxl_pci_ras_unmask(struct pci_dev *pdev)
 {
 	struct pci_host_bridge *host_bridge = pci_find_host_bridge(pdev->bus);


