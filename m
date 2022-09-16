Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5BBFECAAD8
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiIPXLh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiIPXLg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Sep 2022 19:11:36 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CD5FA9C21
        for <linux-cxl@vger.kernel.org>; Fri, 16 Sep 2022 16:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663369895; x=1694905895;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gg+3iSAVq1tvnupycmQNEBwDWW4jqnVdykYo+TLrFlk=;
  b=jwA2nU8IIR2h+NCZu4KJPUKMXa79uk0mPmsn6XQm3+cKbpBstVNB8Vdv
   TB1FEAGQJfYA66+LT1gTXLe/7LL4go0YdiHnWoplUMPS1Shr64seZ67R0
   rLC6Oiliy8VBEnqC+/5PJBmxfWi8AYTYAZqugSqx3qZq9iYejK3fVR+4F
   y1yPBEIn/NyOEd3E42Cn+JU+JQc+2xa2Fy5IV0FRAP9Q8Uz05HUrzDqV9
   +DuzydVnLex/082alCeVdTUWL0Oi52j2f9in2w8yPYFLH2llCmBlNTpSu
   araytP6WvVGaoCbsJ7vvVeANWUmGmCb2tHa2Mn3QIEduDAFsmuYQo+Nxb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10472"; a="325374920"
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="325374920"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:34 -0700
X-IronPort-AV: E=Sophos;i="5.93,321,1654585200"; 
   d="scan'208";a="686305358"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Sep 2022 16:11:34 -0700
Subject: [PATCH RFC v2 7/9] cxl/pci: Find and map the RAS Capability Structure
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, dan.j.williams@intel.com,
        jonathan.cameron@huawei.com, shiju.jose@huawei.com,
        rrichter@amd.com
Date:   Fri, 16 Sep 2022 16:11:34 -0700
Message-ID: <166336989411.3803215.14064525665389671272.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

The RAS Capability Structure has some ancillary information that may be
relevant with respect to AER events, link and protcol error status
registers. Map the RAS Capability Registers in support of defining a
'struct pci_error_handlers' instance for the cxl_pci driver.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |    7 +++++++
 drivers/cxl/cxl.h       |   19 +++++++++++++++++++
 drivers/cxl/pci.c       |    8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 97e8f4201493..b10f8b79ec40 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -83,6 +83,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			rmap = &map->hdm_decoder;
 			break;
 		}
+		case CXL_CM_CAP_CAP_ID_RAS:
+			dev_dbg(dev, "found RAS capability (0x%x)\n",
+				offset);
+			length = CXL_RAS_CAPABILITY_LENGTH;
+			rmap = &map->ras;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -196,6 +202,7 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 		void __iomem **addr;
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
+		{ &map->component_map.ras, &regs->ras },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index c2bf1759d55c..ce17ccd8b125 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -33,6 +33,7 @@
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
@@ -119,6 +120,21 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 	return 0;
 }
 
+/* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
+#define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
+#define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
+#define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
+#define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
+#define   CXL_RAS_CORRECTABLE_STATUS_MASK GENMASK(6, 0)
+#define CXL_RAS_CORRECTABLE_MASK_OFFSET 0x10
+#define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
+#define CXL_RAS_CAP_CONTROL_OFFSET 0x14
+#define CXL_RAS_HEADER_LOG_OFFSET 0x18
+#define CXL_RAS_CAPABILITY_LENGTH 0x58
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -153,9 +169,11 @@ struct cxl_regs {
 	/*
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
+		void __iomem *ras;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -177,6 +195,7 @@ struct cxl_reg_map {
 
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
+	struct cxl_reg_map ras;
 };
 
 struct cxl_device_reg_map {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index aba31c2291c4..610b3a77f205 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -311,6 +311,9 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
 			return -ENXIO;
 		}
 
+		if (!comp_map->ras.valid)
+			dev_dbg(dev, "RAS registers not found\n");
+
 		dev_dbg(dev, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
@@ -444,6 +447,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	devm_cxl_pci_create_doe(cxlds);
 
+	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
+				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;


