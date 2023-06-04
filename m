Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60988C77B73
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231454AbjFDXcY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232535AbjFDXcX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:32:23 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43A0BAB
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921542; x=1717457542;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aP10+lYsdU01IYI2mxRKd+bd+jKq+BRDy/ldtWPQilM=;
  b=FXd/NyG5Tkehpyxrc9YxHhf7xn/LOt7OTsWbIdzwZ1/WDlWikI6Jl/3Q
   DzEB3PXzyq6r/1dIHDV8IKtjz58MEnYv1APVzzCH/zw2vtGeGGzPO2PU7
   FxmT9nFdKZjbcV3s+hvkupybZE8sWeUfT9oKuanZ2H1+OqIz68NmxHP7v
   +qh9p4nKZ2pH9nAlREsILl7RoPLsLCHkTjPlWMN5MltMm3V96YQ8g8z6l
   7DUuRhPlfiL1NAFO0lx4o3oGFC0LHx5A2vLyKR26t8jywTm4dUdB/yqQM
   d9d6hIhaAtOXXywIYBZ7R3Ey2ockJ0+WX//nOjSh18YQb5g1V3vc2UhAA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="384534759"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="384534759"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="832611452"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="832611452"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:32:21 -0700
Subject: [PATCH 08/19] cxl/port: Enumerate flit mode capability
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:32:21 -0700
Message-ID: <168592154146.1948938.12085726872761686977.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Per CXL 3.0 Section 9.14 Back-Invalidation Configuration, in order to
enable an HDM-DB range (CXL.mem region with device initiated
back-invalidation support), all ports in the path between the endpoint and
the host bridge must be in 256-bit flit-mode.

Even for typical Type-3 class devices it is useful to enumerate link
capabilities through the chain for debug purposes.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c  |    2 +
 drivers/cxl/core/pci.c  |   84 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    6 +++
 drivers/cxl/cxl.h       |    2 +
 drivers/cxl/cxlpci.h    |   25 +++++++++++++-
 drivers/cxl/port.c      |    5 +++
 6 files changed, 122 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ca3b99c6eacf..91ab3033c781 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -3,8 +3,10 @@
 #include <linux/seq_file.h>
 #include <linux/device.h>
 #include <linux/delay.h>
+#include <linux/pci.h>
 
 #include "cxlmem.h"
+#include "cxlpci.h"
 #include "core.h"
 
 /**
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 67f4ab6daa34..b62ec17ccdde 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -519,6 +519,90 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
 
+static struct pci_dev *cxl_port_to_pci(struct cxl_port *port)
+{
+	struct device *dev;
+
+	if (is_cxl_endpoint(port))
+		dev = port->uport->parent;
+	else
+		dev = port->uport;
+
+	if (!dev_is_pci(dev))
+		return NULL;
+
+	return to_pci_dev(dev);
+}
+
+int cxl_probe_link(struct cxl_port *port)
+{
+	struct pci_dev *pdev = cxl_port_to_pci(port);
+	u16 cap, en, parent_features;
+	struct cxl_port *parent_port;
+	struct device *dev;
+	int rc, dvsec;
+	u32 hdr;
+
+	if (!pdev) {
+		/*
+		 * Assume host bridges support all features, the root
+		 * port will dictate the actual enabled set to endpoints.
+		 */
+		return 0;
+	}
+
+	dev = &pdev->dev;
+	dvsec = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
+					  CXL_DVSEC_FLEXBUS_PORT);
+	if (!dvsec) {
+		dev_err(dev, "Failed to enumerate port capabilities\n");
+		return -ENXIO;
+	}
+
+	/*
+	 * Cache the link features for future determination of HDM-D or
+	 * HDM-DB support
+	 */
+	rc = pci_read_config_dword(pdev, dvsec + PCI_DVSEC_HEADER1, &hdr);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_CAP_OFFSET,
+				  &cap);
+	if (rc)
+		return rc;
+
+	rc = pci_read_config_word(pdev, dvsec + CXL_DVSEC_FLEXBUS_STATUS_OFFSET,
+				  &en);
+	if (rc)
+		return rc;
+
+	if (PCI_DVSEC_HEADER1_REV(hdr) < 2)
+		cap &= ~CXL_DVSEC_FLEXBUS_REV2_MASK;
+
+	if (PCI_DVSEC_HEADER1_REV(hdr) < 1)
+		cap &= ~CXL_DVSEC_FLEXBUS_REV1_MASK;
+
+	en &= cap;
+	parent_port = to_cxl_port(port->dev.parent);
+	parent_features = parent_port->features;
+
+	/* Enforce port features are plumbed through to the host bridge */
+	port->features = en & CXL_DVSEC_FLEXBUS_ENABLE_MASK & parent_features;
+
+	dev_dbg(dev, "features:%s%s%s%s%s%s%s\n",
+		en & CXL_DVSEC_FLEXBUS_CACHE_ENABLED ? " cache" : "",
+		en & CXL_DVSEC_FLEXBUS_IO_ENABLED ? " io" : "",
+		en & CXL_DVSEC_FLEXBUS_MEM_ENABLED ? " mem" : "",
+		en & CXL_DVSEC_FLEXBUS_FLIT68_ENABLED ? " flit68" : "",
+		en & CXL_DVSEC_FLEXBUS_MLD_ENABLED ? " mld" : "",
+		en & CXL_DVSEC_FLEXBUS_FLIT256_ENABLED ? " flit256" : "",
+		en & CXL_DVSEC_FLEXBUS_PBR_ENABLED ? " pbr" : "");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_probe_link, CXL);
+
 #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
 #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
 #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 432a4ac38f36..71a7547a8d6f 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -665,6 +665,12 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
 	} else
 		dev->parent = uport;
 
+	/*
+	 * Assume all CXL link capabilities for root-device-to-host-bridge link,
+	 * cxl_probe_link() will fix this up later in cxl_probe_link() for all
+	 * other ports.
+	 */
+	port->features = CXL_DVSEC_FLEXBUS_ENABLE_MASK;
 	port->component_reg_phys = component_reg_phys;
 	ida_init(&port->decoder_ida);
 	port->hdm_end = -1;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e2d0ae228cba..258c90727dd2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -557,6 +557,7 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @features: active link features (see CXL_DVSEC_FLEXBUS_*_ENABLED)
  */
 struct cxl_port {
 	struct device dev;
@@ -579,6 +580,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	u16 features;
 };
 
 static inline struct cxl_dport *
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 7c02e55b8042..7f82ffb5b4be 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -45,8 +45,28 @@
 /* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
 #define CXL_DVSEC_DEVICE_GPF					5
 
-/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
-#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+/* CXL 3.0 8.2.1.3: PCIe DVSEC for Flex Bus Port */
+#define CXL_DVSEC_FLEXBUS_PORT					7
+#define   CXL_DVSEC_FLEXBUS_CAP_OFFSET		0xA
+#define     CXL_DVSEC_FLEXBUS_CACHE_CAPABLE	BIT(0)
+#define     CXL_DVSEC_FLEXBUS_IO_CAPABLE	BIT(1)
+#define     CXL_DVSEC_FLEXBUS_MEM_CAPABLE	BIT(2)
+#define     CXL_DVSEC_FLEXBUS_FLIT68_CAPABLE	BIT(5)
+#define     CXL_DVSEC_FLEXBUS_MLD_CAPABLE	BIT(6)
+#define     CXL_DVSEC_FLEXBUS_REV1_MASK		GENMASK(6, 5)
+#define     CXL_DVSEC_FLEXBUS_FLIT256_CAPABLE	BIT(13)
+#define     CXL_DVSEC_FLEXBUS_PBR_CAPABLE	BIT(14)
+#define     CXL_DVSEC_FLEXBUS_REV2_MASK		GENMASK(14, 13)
+#define   CXL_DVSEC_FLEXBUS_STATUS_OFFSET	0xE
+#define     CXL_DVSEC_FLEXBUS_CACHE_ENABLED	BIT(0)
+#define     CXL_DVSEC_FLEXBUS_IO_ENABLED	BIT(1)
+#define     CXL_DVSEC_FLEXBUS_MEM_ENABLED	BIT(2)
+#define     CXL_DVSEC_FLEXBUS_FLIT68_ENABLED	BIT(5)
+#define     CXL_DVSEC_FLEXBUS_MLD_ENABLED	BIT(6)
+#define     CXL_DVSEC_FLEXBUS_FLIT256_ENABLED	BIT(13)
+#define     CXL_DVSEC_FLEXBUS_PBR_ENABLED	BIT(14)
+#define     CXL_DVSEC_FLEXBUS_ENABLE_MASK \
+	(GENMASK(2, 0) | GENMASK(6, 5) | GENMASK(14, 13))
 
 /* CXL 2.0 8.1.9: Register Locator DVSEC */
 #define CXL_DVSEC_REG_LOCATOR					8
@@ -88,6 +108,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
 struct cxl_dev_state;
 int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 			struct cxl_endpoint_dvsec_info *info);
+int cxl_probe_link(struct cxl_port *port);
 void read_cdat_data(struct cxl_port *port);
 void cxl_cor_error_detected(struct pci_dev *pdev);
 pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index c23b6164e1c0..5ffe3c7d2f5e 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -140,6 +140,11 @@ static int cxl_endpoint_port_probe(struct cxl_port *port)
 static int cxl_port_probe(struct device *dev)
 {
 	struct cxl_port *port = to_cxl_port(dev);
+	int rc;
+
+	rc = cxl_probe_link(port);
+	if (rc)
+		return rc;
 
 	if (is_cxl_endpoint(port))
 		return cxl_endpoint_port_probe(port);

