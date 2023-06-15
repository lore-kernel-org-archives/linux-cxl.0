Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A83FEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jun 2023 01:30:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236982AbjFOBal (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jun 2023 21:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237002AbjFOBaj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Jun 2023 21:30:39 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA7E2126
        for <linux-cxl@vger.kernel.org>; Wed, 14 Jun 2023 18:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686792638; x=1718328638;
  h=subject:from:to:date:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding;
  bh=Xzbx2MaTy7+nsoWz96KwWQPWBuu38Xit9S1rfjRehIA=;
  b=m1OUQdPSqZLbS+JlNvjwV/TtuO46wYbfXuJ6XGZzSWI1SEtdD5cIdOu8
   s+fqyyQondxtJi9In0aIbm9m9yuoxn2KXWmvDligJYPC79knRmfk28rTj
   rOtRyyf4gEFsN5y0EqoZOT/jKIr3ZFGFA1sZjTjnSTZLcMS7rpQ7oIV0J
   NaCHaQ6KYTqLVoQTGavIe3EIk4f5KIUW6UfkUOuSJFLpLj78XSMc/jZX3
   tzo87Y0Qaj2jxhleGux8z4nycvFvgugUvZjX5Fo8Yml8tGOtt3euFAupc
   rGnDOY+2wSvsnrCp5mW2zwwUQUUldTQGL55R8iiLS6CNaGKodbMnXor7m
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="338412439"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="338412439"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="782307551"
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="782307551"
Received: from rtpearso-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.87.28])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 18:30:37 -0700
Subject: [PATCH v2 11/12] cxl/port: Enumerate cxl link capabilities
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Date:   Wed, 14 Jun 2023 18:30:37 -0700
Message-ID: <168679263707.3436160.10946564604121831708.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
References: <168679257511.3436160.9707734364766526576.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Per CXL 3.0 9.14 "Back-Invalidation Configuration", in order to enable
an HDM-DB range (CXL.mem region with device initiated back-invalidation
support), all ports in the path between the endpoint and the host bridge
must be in 256-bit flit-mode.

Even for typical Type-3 class devices it is useful to enumerate link
capabilities through the topology for debug purposes.

See CXL 3.0 Table-64 "256B Flit Mode vs. 68B Flit Mode Operation", for
how to determine 64B vs 256B Flit mode operation.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/pci.c  |  113 +++++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/core/port.c |    6 ++
 drivers/cxl/cxl.h       |    7 +++
 drivers/cxl/cxlpci.h    |   24 +++++++++-
 drivers/cxl/port.c      |    5 ++
 5 files changed, 153 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 67f4ab6daa34..7440f84be6c8 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -519,6 +519,119 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
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
+	u16 cap, en, lnksta, lnksta2, parent_features;
+	struct pci_dev *pdev = cxl_port_to_pci(port);
+	struct cxl_port *parent_port;
+	unsigned long features;
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
+	 * Cache the link features for future determination of 256B Flit
+	 * mode dependent operation support e.g. HDM-DB.
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
+	features = en & cap & CXL_DVSEC_FLEXBUS_ENABLE_MASK;
+	if ((features & CXL_DVSEC_FLEXBUS_CXL_MASK) == 0)
+		goto no_cxl;
+
+	/* Determine flit mode from link speed and CXL active */
+	rc = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA, &lnksta);
+	if (rc)
+		return rc;
+
+	rc = pcie_capability_read_word(pdev, PCI_EXP_LNKSTA2, &lnksta2);
+	if (rc)
+		return rc;
+
+	/* CXL 3.0 Table-64 256B Flit Mode vs. 68B Flit Mode Operation */
+	switch (FIELD_GET(PCI_EXP_LNKSTA_CLS, lnksta)) {
+	case PCI_EXP_LNKSTA_CLS_2_5GB:
+	case PCI_EXP_LNKSTA_CLS_5_0GB:
+		break;
+	case PCI_EXP_LNKSTA_CLS_8_0GB:
+	case PCI_EXP_LNKSTA_CLS_16_0GB:
+	case PCI_EXP_LNKSTA_CLS_32_0GB:
+		if ((lnksta2 & PCI_EXP_LNKSTA2_FLIT) == 0) {
+			features |= CXL_PORT_FEATURE_FLIT68;
+			break;
+		}
+		fallthrough;
+	case PCI_EXP_LNKSTA_CLS_64_0GB:
+	default:
+		features |= CXL_PORT_FEATURE_FLIT256;
+		break;
+	}
+
+no_cxl:
+	parent_port = to_cxl_port(port->dev.parent);
+	parent_features = parent_port->features;
+
+	/* Enforce port features are plumbed through to the host bridge */
+	features &= parent_features;
+
+	dev_dbg(dev, "features:%s%s%s%s%s%s%s%s%s\n",
+		features & CXL_DVSEC_FLEXBUS_CACHE_ENABLED ? " cache" : "",
+		features & CXL_DVSEC_FLEXBUS_IO_ENABLED ? " io" : "",
+		features & CXL_DVSEC_FLEXBUS_MEM_ENABLED ? " mem" : "",
+		features & CXL_DVSEC_FLEXBUS_VH_ENABLED ? " vh" : "",
+		features & CXL_DVSEC_FLEXBUS_MLD_ENABLED ? " mld" : "",
+		features & CXL_DVSEC_FLEXBUS_LATOPT_ENABLED ? " latopt" : "",
+		features & CXL_DVSEC_FLEXBUS_PBR_ENABLED ? " pbr" : "",
+		features & CXL_PORT_FEATURE_FLIT68 ? " flit68" : "",
+		features & CXL_PORT_FEATURE_FLIT256 ? " flit256" : "");
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_probe_link, CXL);
+
 #define CXL_DOE_TABLE_ACCESS_REQ_CODE		0x000000ff
 #define   CXL_DOE_TABLE_ACCESS_REQ_CODE_READ	0
 #define CXL_DOE_TABLE_ACCESS_TABLE_TYPE		0x0000ff00
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 6d7811b26b5a..bf8f25063914 100644
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
index f309b1387858..74548f8f5f4c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -536,6 +536,10 @@ struct cxl_dax_region {
 	struct range hpa_range;
 };
 
+/* These start after CXL_DVSEC_FLEXBUS_*_ENABLED bits in port->features */
+#define CXL_PORT_FEATURE_FLIT68 BIT(16)
+#define CXL_PORT_FEATURE_FLIT256 BIT(17)
+
 /**
  * struct cxl_port - logical collection of upstream port devices and
  *		     downstream port devices to construct a CXL memory
@@ -557,6 +561,8 @@ struct cxl_dax_region {
  * @depth: How deep this port is relative to the root. depth 0 is the root.
  * @cdat: Cached CDAT data
  * @cdat_available: Should a CDAT attribute be available in sysfs
+ * @features: active link features (see CXL_DVSEC_FLEXBUS_*_ENABLED +
+ *  CXL_PORT_FEATURE_*)
  */
 struct cxl_port {
 	struct device dev;
@@ -579,6 +585,7 @@ struct cxl_port {
 		size_t length;
 	} cdat;
 	bool cdat_available;
+	unsigned long features;
 };
 
 static inline struct cxl_dport *
diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
index 7c02e55b8042..0da6618e0df7 100644
--- a/drivers/cxl/cxlpci.h
+++ b/drivers/cxl/cxlpci.h
@@ -45,8 +45,27 @@
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
+#define     CXL_DVSEC_FLEXBUS_VH_CAPABLE	BIT(5)
+#define     CXL_DVSEC_FLEXBUS_MLD_CAPABLE	BIT(6)
+#define     CXL_DVSEC_FLEXBUS_LATOPT_CAPABLE	BIT(13)
+#define     CXL_DVSEC_FLEXBUS_PBR_CAPABLE	BIT(14)
+#define   CXL_DVSEC_FLEXBUS_STATUS_OFFSET	0xE
+#define     CXL_DVSEC_FLEXBUS_CACHE_ENABLED	BIT(0)
+#define     CXL_DVSEC_FLEXBUS_IO_ENABLED	BIT(1)
+#define     CXL_DVSEC_FLEXBUS_MEM_ENABLED	BIT(2)
+#define     CXL_DVSEC_FLEXBUS_VH_ENABLED	BIT(5)
+#define     CXL_DVSEC_FLEXBUS_MLD_ENABLED	BIT(6)
+#define     CXL_DVSEC_FLEXBUS_LATOPT_ENABLED	BIT(13)
+#define     CXL_DVSEC_FLEXBUS_PBR_ENABLED	BIT(14)
+#define     CXL_DVSEC_FLEXBUS_ENABLE_MASK \
+	(GENMASK(2, 0) | GENMASK(6, 5) | GENMASK(14, 13))
+#define CXL_DVSEC_FLEXBUS_CXL_MASK GENMASK(2, 0)
 
 /* CXL 2.0 8.1.9: Register Locator DVSEC */
 #define CXL_DVSEC_REG_LOCATOR					8
@@ -88,6 +107,7 @@ int devm_cxl_port_enumerate_dports(struct cxl_port *port);
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

