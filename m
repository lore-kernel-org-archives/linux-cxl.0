Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2F06C61DA4
	for <linux-cxl@archiver.kernel.org>; Tue, 14 Feb 2023 19:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjBNTl1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 14 Feb 2023 14:41:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjBNTl0 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 14 Feb 2023 14:41:26 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BB8F2D143
        for <linux-cxl@vger.kernel.org>; Tue, 14 Feb 2023 11:41:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676403685; x=1707939685;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=akF4V/Uewjf1PzR1TXbVcPq4DNVXOFVo/yGkbc4BEEI=;
  b=YL+7HgqHcS5fajzB1oT8untANxT++sfjpKKnGMjn8OvMR+wnQyg1Rzay
   m9KQyZo3CV7iyPkrMtQLxaEFod9qGg9Ite/9qr56AYWk1bqAm90/pM71N
   ivQ+OA+0yzbHL/zCYT7pjuutxOF8HtOr6KvQsNwImoWHJRIkwLgxv7vzF
   7bf9SWeMp9B6t1VH0//oDPE2GF+YDf+Q3syG5KsQrtFKfch0JtX/AvMz9
   VORl2kOux2DithSwwC/7vKjhe2GnGipZCxHERR1ui3ai5Myfiw4RKaXqH
   0SUQTblo+TgnorLKv42OMniPUXhy7rsu44kEJhr6SsYOqgVkSYTXJZqbJ
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="333384892"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="333384892"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10621"; a="793207922"
X-IronPort-AV: E=Sophos;i="5.97,297,1669104000"; 
   d="scan'208";a="793207922"
Received: from mofarooq-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.68.16])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2023 11:41:24 -0800
Subject: [PATCH v5 4/7] cxl/hdm: Emulate HDM decoder from DVSEC range
 registers
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dave Jiang <dave.jiang@intel.com>
Date:   Tue, 14 Feb 2023 11:41:24 -0800
Message-ID: <167640368454.935665.13806415120298330717.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Dave Jiang <dave.jiang@intel.com>

In the case where HDM decoder register block exists but is not programmed
and at the same time the DVSEC range register range is active, populate the
CXL decoder object 'cxl_decoder' with info from DVSEC range registers.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/hdm.c        |   36 +++++++++++++++++++++++++++++++++---
 drivers/cxl/core/pci.c        |    2 +-
 drivers/cxl/cxl.h             |    3 ++-
 drivers/cxl/port.c            |    2 +-
 tools/testing/cxl/test/cxl.c  |    3 ++-
 tools/testing/cxl/test/mock.c |    7 ++++---
 tools/testing/cxl/test/mock.h |    3 ++-
 7 files changed, 45 insertions(+), 11 deletions(-)

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
index d0b25481bdce..4df0b35c9b1a 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -426,7 +426,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
 	 * Decoder Capability Enable.
 	 */
 	if (info->mem_enabled)
-		return -EBUSY;
+		return 0;
 
 	rc = devm_cxl_enable_hdm(&port->dev, cxlhdm);
 	if (rc)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fc01ce96d326..fe9d75989c8a 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -644,7 +644,8 @@ struct cxl_endpoint_dvsec_info {
 
 struct cxl_hdm;
 struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port);
-int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm);
+int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				struct cxl_endpoint_dvsec_info *info);
 int devm_cxl_add_passthrough_decoder(struct cxl_port *port);
 int cxl_dvsec_rr_decode(struct device *dev, int dvsec,
 			struct cxl_endpoint_dvsec_info *info);
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index 9e09728b20d9..d3a708e32565 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -78,7 +78,7 @@ static int cxl_port_probe(struct device *dev)
 		}
 	}
 
-	rc = devm_cxl_enumerate_decoders(cxlhdm);
+	rc = devm_cxl_enumerate_decoders(cxlhdm, &info);
 	if (rc) {
 		dev_err(dev, "Couldn't enumerate decoders (%d)\n", rc);
 		return rc;
diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 30ee680d38ff..3b4916adf29c 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -701,7 +701,8 @@ static int mock_decoder_reset(struct cxl_decoder *cxld)
 	return 0;
 }
 
-static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
+static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				       struct cxl_endpoint_dvsec_info *info)
 {
 	struct cxl_port *port = cxlhdm->port;
 	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
index 2a13f4722891..3116c9f07c5d 100644
--- a/tools/testing/cxl/test/mock.c
+++ b/tools/testing/cxl/test/mock.c
@@ -162,16 +162,17 @@ int __wrap_devm_cxl_add_passthrough_decoder(struct cxl_port *port)
 }
 EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_passthrough_decoder, CXL);
 
-int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
+int __wrap_devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm,
+				       struct cxl_endpoint_dvsec_info *info)
 {
 	int rc, index;
 	struct cxl_port *port = cxlhdm->port;
 	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
 
 	if (ops && ops->is_mock_port(port->uport))
-		rc = ops->devm_cxl_enumerate_decoders(cxlhdm);
+		rc = ops->devm_cxl_enumerate_decoders(cxlhdm, info);
 	else
-		rc = devm_cxl_enumerate_decoders(cxlhdm);
+		rc = devm_cxl_enumerate_decoders(cxlhdm, info);
 	put_cxl_mock_ops(index);
 
 	return rc;
diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
index ef33f159375e..e377ced5f1b3 100644
--- a/tools/testing/cxl/test/mock.h
+++ b/tools/testing/cxl/test/mock.h
@@ -25,7 +25,8 @@ struct cxl_mock_ops {
 	int (*devm_cxl_port_enumerate_dports)(struct cxl_port *port);
 	struct cxl_hdm *(*devm_cxl_setup_hdm)(struct cxl_port *port);
 	int (*devm_cxl_add_passthrough_decoder)(struct cxl_port *port);
-	int (*devm_cxl_enumerate_decoders)(struct cxl_hdm *hdm);
+	int (*devm_cxl_enumerate_decoders)(
+		struct cxl_hdm *hdm, struct cxl_endpoint_dvsec_info *info);
 };
 
 void register_cxl_mock_ops(struct cxl_mock_ops *ops);

