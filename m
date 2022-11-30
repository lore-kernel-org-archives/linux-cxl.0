Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484A6C4321E
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Nov 2022 23:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiK3XUn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Nov 2022 18:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiK3XUP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Nov 2022 18:20:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D3FA0568
        for <linux-cxl@vger.kernel.org>; Wed, 30 Nov 2022 15:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669849989; x=1701385989;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jAn1SeLPPxEKDZ8cws4fwvhUj1/nKqsbUdc5a4YG8O4=;
  b=RX/em8qktzjIeDOSa4SYnExfs/rmuV96fHPYIxkAdcvdj+0uKu8qZ82o
   d1VAijF92nOOC6x+cwHt4V4PomqvIwCbYIHkqlVR6aVwMWH4qi2ta9MsV
   SQ32a+6NeTiEAlfJEUTUvmIsKQr5AxyBL5BSeY8crV1YT2PRomx5TA44N
   Ai8GCmCI+POcKecTMXtna5t7pK21B5ubUNTSHPN2WS9lwVNKwuuTDiRiF
   RGeyASRuvlKLrxzx7Drc52scDIoDvkJKbrexWtf+crqdd8Lh/kcplvc3I
   JT5i9Cki3+wtC7Qj+JKbNE98DmLv18+hZa7tLB4RqbzIO1X4gpyaAGrz5
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="379812000"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="379812000"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:39 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10547"; a="733171035"
X-IronPort-AV: E=Sophos;i="5.96,207,1665471600"; 
   d="scan'208";a="733171035"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2022 15:12:38 -0800
Subject: [RFC PATCH 4/8] cxl: emulate HDM decoder from DVSEC range registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rrichter@amd.com, terry.bowman@amd.com
Date:   Wed, 30 Nov 2022 16:12:38 -0700
Message-ID: <166984995817.2805382.13166060288973761642.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
References: <166984987659.2805382.17264896576424996856.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In the case where HDM decoder register block exists but is not programmed
and at the same time the DVSEC range register range is active, populate the
CXL decoder object 'cxl_decoder' with info from DVSEC range registers.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/hdm.c |   33 ++++++++++++++++++++++++++++++---
 drivers/cxl/core/pci.c |   12 ------------
 drivers/cxl/cxl.h      |    3 ++-
 drivers/cxl/port.c     |    2 +-
 4 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index d1d2caea5c62..9773a5efaefd 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -674,9 +674,31 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
 	return 0;
 }
 
+static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
+					    struct cxl_decoder *cxld, int which,
+					    struct cxl_endpoint_dvsec_info *info)
+{
+	if (!is_cxl_endpoint(port))
+		return -EOPNOTSUPP;
+
+	if (info->dvsec_range[which].start == CXL_RESOURCE_NONE)
+		return -ENXIO;
+
+	cxld->target_type = CXL_DECODER_ACCELERATOR;
+
+	cxld->hpa_range = (struct range) {
+		.start = info->dvsec_range[which].start,
+		.end = info->dvsec_range[which].end,
+	};
+
+	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	port->commit_end = cxld->id;
+	return 0;
+}
+
 static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 			    int *target_map, void __iomem *hdm, int which,
-			    u64 *dpa_base)
+			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_endpoint_decoder *cxled = NULL;
 	u64 size, base, skip, dpa_size;
@@ -712,6 +734,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
+	if (cxled && !committed &&
+	    info->dvsec_range[which].start != CXL_RESOURCE_NONE)
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
@@ -785,7 +811,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
  * @cxlhdm: Structure to populate with HDM capabilities
  */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
@@ -837,7 +864,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxld = &cxlsd->cxld;
 		}
 
-		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
+		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base, info);
 		if (rc) {
 			put_device(&cxld->dev);
 			return rc;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 385dbe9bd5f2..5e44fe23fa76 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -412,18 +412,6 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 		info->mem_enabled = 0;
 	}
 
-	/*
-	 * Per CXL 2.0 Section 8.1.3.8.3 and 8.1.3.8.4 DVSEC CXL Range 1 Base
-	 * [High,Low] when HDM operation is enabled the range register values
-	 * are ignored by the device, but the spec also recommends matching the
-	 * DVSEC Range 1,2 to HDM Decoder Range 0,1. So, non-zero info->ranges
-	 * are expected even though Linux does not require or maintain that
-	 * match. If at least one DVSEC range is enabled and allowed, skip HDM
-	 * Decoder Capability Enable.
-	 */
-	if (info->mem_enabled)
-		return -EBUSY;
-
 	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 	if (rc)
 		return rc;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b6caf1cfb3e9..3fe1043a7796 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -605,7 +605,8 @@ struct cxl_endpoint_dvsec_info {
 
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 int cxl_dvsec_rr_decode(struct pci_dev *pdev, int dvsec,
 			struct cxl_endpoint_dvsec_info *info);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index f899d62a91af..3dedf3dd534a 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -79,7 +79,7 @@ static int cxl_port_probe(struct device *dev)
 		}
 	}
 
-	rc = devm_cxl_enumerate_decoders(cxlhdm);
+	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc) {
 		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
 		return rc;


