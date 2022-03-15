Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40511C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 15 Mar 2022 01:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbiCOBX4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Mar 2022 21:23:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241657AbiCOBX4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Mar 2022 21:23:56 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC8FC16
        for <linux-cxl@vger.kernel.org>; Mon, 14 Mar 2022 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647307364; x=1678843364;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hb6dl8PX7NGSKgQvwoUymTUVDfyh8lyKKNolQsunB30=;
  b=kbSSuhBY5Z3t4yQt0PaOaqxTE+bTG/QjgzADb7USNWeVKLRz7hpp4PKv
   hVPDbN8pAh/HZEq1Wsp6RHi9cR2hgTKV/7ueMMpyukIjas00HH/wnUpD1
   8dO5XdtySa1MCIOFbuQzOZ0cpcZGW1HffhL5VJ5TEj5TvQmaCaVb6xhmP
   pgpZmTTZMGuLavqQ7Fc9Dxef14UeM738oUiy9T78XIh4Ib0e7Wy8drn3e
   dTVYDu67VoKJLukOE+x9zKv2DhTTlD8oyjuxQQqWViIosKaSCK5ZzntAy
   ccgctSZneGXIHJROPgecIgYzhNKDOnJ5AX8uu8zrZlKmhqaujJnz/9a0f
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255914753"
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="255914753"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:44 -0700
X-IronPort-AV: E=Sophos;i="5.90,182,1643702400"; 
   d="scan'208";a="580334429"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:22:44 -0700
Subject: [PATCH v2 5/6] cxl/mem: Rename cxl_dvsec_decode_init() to
 cxl_hdm_decode_init()
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Date:   Mon, 14 Mar 2022 18:22:44 -0700
Message-ID: <164730736435.3806189.2537160791687837469.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_dvsec_decode_init() is tasked with checking whether legacy DVSEC
range based decode is in effect, or whether HDM can be enabled / already
is enabled. As such it either succeeds or fails and that result is the
return value. The @do_hdm_init variable is misleading in the case where
HDM operation is already found to be active, so just call it @retval.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c            |   12 ++++++------
 tools/testing/cxl/mock_mem.c |    2 +-
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 50704deb2ff0..3baae1332760 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -68,7 +68,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
 }
 
 /**
- * cxl_dvsec_decode_init() - Setup HDM decoding for the endpoint
+ * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
  * @cxlds: Device state
  *
  * Additionally, enables global HDM decoding. Warning: don't call this outside
@@ -79,12 +79,12 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
  * decoders, or if it can not be determined if DVSEC Ranges are in use.
  * Otherwise, returns true.
  */
-__mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
+__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
 {
 	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
 	struct cxl_register_map map;
 	struct cxl_component_reg_map *cmap = &map.component_map;
-	bool global_enable, do_hdm_init = false;
+	bool global_enable, retval = false;
 	void __iomem *crb;
 	u32 global_ctrl;
 
@@ -113,7 +113,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
 		goto out;
 	}
 
-	do_hdm_init = true;
+	retval = true;
 
 	/*
 	 * Permanently (for this boot at least) opt the device into HDM
@@ -129,7 +129,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
 
 out:
 	iounmap(crb);
-	return do_hdm_init;
+	return retval;
 }
 
 static int cxl_mem_probe(struct device *dev)
@@ -160,7 +160,7 @@ static int cxl_mem_probe(struct device *dev)
 	 * If DVSEC ranges are being used instead of HDM decoder registers there
 	 * is no use in trying to manage those.
 	 */
-	if (!cxl_dvsec_decode_init(cxlds)) {
+	if (!cxl_hdm_decode_init(cxlds)) {
 		dev_err(dev,
 			"Legacy range registers configuration prevents HDM operation.\n");
 		return -EBUSY;
diff --git a/tools/testing/cxl/mock_mem.c b/tools/testing/cxl/mock_mem.c
index d1dec5845139..69946f678cfa 100644
--- a/tools/testing/cxl/mock_mem.c
+++ b/tools/testing/cxl/mock_mem.c
@@ -4,7 +4,7 @@
 #include <linux/types.h>
 
 struct cxl_dev_state;
-bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
+bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
 {
 	return true;
 }

