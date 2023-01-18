Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07E5DC678D6
	for <linux-cxl@archiver.kernel.org>; Wed, 18 Jan 2023 18:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjARSKN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 18 Jan 2023 13:10:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231334AbjARSJ2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 18 Jan 2023 13:09:28 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341B05A80E
        for <linux-cxl@vger.kernel.org>; Wed, 18 Jan 2023 10:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674065338; x=1705601338;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BDl2J/rFkGj2mUeS3fBGRjxrCY6xZMC6num+gC9vkgI=;
  b=Uj9thhaZTMVmEbe9nD47vdnY8Vt7P6UZGPcqVcdNAsWhvVOD6fGgp5jV
   COY7ugnY6Ij/n5ZODm85pPIZCQ6ME+Tvyds3nWoN6W5lQkVWhW0lqoGvV
   qW9LZB8iVWIAHoWzy0XTUlE1IKSKTtN5SfKQTfWoqboleRCNyCKIA8hy+
   BGmCNc2dIOnPezMjt67zIAsfckMtIikKtSsUcHnh8HIGt9F7yN7sstTLH
   tQiqWMaaK3D4DheNc4rjt3qFd91aKa2v9oteZcxueIa4iPqVI2Klw1WwR
   4Ng4v1/EZRFBrsf1p0J/5bHFsvFyTSA16Dys8PF3RQ3ikrzhRhVYeo62c
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="387406108"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="387406108"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767852032"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767852032"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.213.179.103])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 10:08:57 -0800
Subject: [PATCH v3 4/8] cxl: emulate HDM decoder from DVSEC range registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        jonathan.cameron@huawei.com
Date:   Wed, 18 Jan 2023 11:08:55 -0700
Message-ID: <167406533420.1455071.7180353856174143346.stgit@djiang5-mobl3.local>
In-Reply-To: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
References: <167406522720.1455071.8837344641950166822.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In the case where HDM decoder register block exists but is not programmed
and at the same time the DVSEC range register range is active, populate the
CXL decoder object 'cxl_decoder' with info from DVSEC range registers.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>

---
v2:
- Set target_type to CXL_DECODER_EXPANDER (type 3). (Jonathan)
- Skip HDM enabling if DVSEC range is active. (Jonathan)
---
 drivers/cxl/core/hdm.c |   36 +++++++++++++++++++++++++++++++++---
 drivers/cxl/core/pci.c |    2 +-
 drivers/cxl/cxl.h      |    3 ++-
 drivers/cxl/port.c     |    2 +-
 4 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index dcc16d7cb8f3..af1f5f906f52 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -679,9 +679,34 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
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
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->commit = NULL;
+	cxld->reset = NULL;
+
+	cxld->hpa_range = (struct range) {
+		.start = info->dvsec_range[which].start,
+		.end = info->dvsec_range[which].end,
+	};
+
+	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
+	port->commit_end = cxld->id;
+
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
@@ -717,6 +742,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
+	if (cxled && !committed &&
+	    info->dvsec_range[which].start != CXL_RESOURCE_NONE)
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
@@ -790,7 +819,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
  * @cxlhdm: Structure to populate with HDM capabilities
  */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
@@ -842,7 +872,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxld = &cxlsd->cxld;
 		}
 
-		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
+		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base, info);
 		if (rc) {
 			put_device(&cxld->dev);
 			return rc;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 97690c429e05..81882ea94adf 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -427,7 +427,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * Decoder Capability Enable.
 	 */
 	if (info->mem_enabled)
-		return -EBUSY;
+		return 0;
 
 	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 	if (rc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1057affb2db0..ea9548cbc7eb 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -644,7 +644,8 @@ struct cxl_endpoint_dvsec_info {
 
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 int cxl_dvsec_rr_decode(struct pci_dev *pdev, int dvsec,
 			struct cxl_endpoint_dvsec_info *info);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 404639a1c3d0..7f1b71c5cf15 100644
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


