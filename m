Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABEDCC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 19:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjBHTV3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 14:21:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbjBHTV2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 14:21:28 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1EAA58283
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 11:21:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675884084; x=1707420084;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aoEfltS4GgF62g2DKrrfcBDhh11UB+LhYQwIo4p6yoo=;
  b=SwtRtm9ukAHltHHUU0UebvtcsiY39R5gzm4JhtY/dupnJRFXRU17zToR
   dX38gsWHbXoln0EDuNPCuT0gldXZutLrOpWlbftLhPFYC5XDUbzVrhNWm
   ItVq+bLvVX65TBV+Jp4oJkywrRLtMptwx+pp5gjqzvxvb93jMhAZThnmb
   ptaMZ8ObA1Zv1gHwvnN6esf77JIFR7OVRtJn0wEH3uGDrHKuDRZmh5P1S
   jBMLuB7KNaQjNbU7FzpIlfL/4Vv1Zq7t3f4Ha8X5yJNBYX4O0LySE0FP2
   Z96oy+6+AA8BoZV6bYFGY/v6Mt9SZjsuk8R018uVZiQvlhjeDy7G+asxn
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357298505"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357298505"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:24 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="730998596"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="730998596"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.48.215])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 11:21:23 -0800
Subject: [PATCH v4 4/7] cxl: emulate HDM decoder from DVSEC range registers
From:   Dave Jiang <dave.jiang@intel.com>
To:     dan.j.williams@intel.com
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-cxl@vger.kernel.org
Date:   Wed, 08 Feb 2023 12:21:21 -0700
Message-ID: <167588408051.1155956.11059438224070853644.stgit@djiang5-mobl3.local>
In-Reply-To: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
References: <167588394236.1155956.8466475582138210344.stgit@djiang5-mobl3.local>
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
v4:
- Direct assign range to range. (Dan)
- Add comment for why emulated decoder is locked. (Dan)
- Check range_len() instead of content of .start. (Dan)
- Fix too long line formatting. (Dan)
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
index dcc16d7cb8f3..c0f224454447 100644
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
+	if (!range_len(&info->dvsec_range[which]))
+		return -ENOENT;
+
+	cxld->target_type = CXL_DECODER_EXPANDER;
+	cxld->commit = NULL;
+	cxld->reset = NULL;
+	cxld->hpa_range = info->dvsec_range[which];
+
+	/*
+	 * Set the emulated decoder as locked pending additional support to
+	 * change the range registers at run time.
+	 */
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
@@ -717,6 +742,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
 		.end = base + size - 1,
 	};
 
+	if (cxled && !committed && range_len(&info->dvsec_range[which]))
+		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
+
 	/* decoders are enabled if committed */
 	if (committed) {
 		cxld->flags |= CXL_DECODER_F_ENABLE;
@@ -790,7 +818,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
  * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
  * @cxlhdm: Structure to populate with HDM capabilities
  */
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info)
 {
 	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
 	struct cxl_port *port = cxlhdm->port;
@@ -842,7 +871,8 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
 			cxld = &cxlsd->cxld;
 		}
 
-		rc = init_hdm_decoder(port, cxld, target_map, hdm, i, &dpa_base);
+		rc = init_hdm_decoder(port, cxld, target_map, hdm, i,
+				      &dpa_base, info);
 		if (rc) {
 			put_device(&cxld->dev);
 			return rc;
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 2e86c209e24d..2e0976446053 100644
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


