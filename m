Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E827C7EE23
	for <linux-cxl@archiver.kernel.org>; Sun,  4 Jun 2023 23:33:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232482AbjFDXdE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 4 Jun 2023 19:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjFDXdD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 4 Jun 2023 19:33:03 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28C44AC
        for <linux-cxl@vger.kernel.org>; Sun,  4 Jun 2023 16:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685921583; x=1717457583;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=piV+njjI6bQYgoLcj0DVqmQ+LL+Tr7HsKtqSV3UJv9A=;
  b=TKGDb7r1JvT8PQ2LXP9YRSVdnw9EEwpk/XPaU9OU8qQTalNrRewBt9pj
   t6/ycwLx23t5npfV6AnokzlBhiiKK5sKBYxG/9fumy4oQdieU5XXs/Fs4
   bK4rj/KDcR+BmJrZABAQO7CKzxz84xTlihehOWWZvBFoJqLIbVcWxJSN6
   nin7q9huORJOPh1r77OSMuH3iXh+YFdHDkmYPEggD/o6CNsaolRrjPcWV
   Be6mlzQ+dXvdhEwDM0BRMUHBtKip/fNIbgnCLzSSUhz0yWgOaY7rbZ1jc
   I4MoIdlKmfYK4xhioboG0TX1LOP7NLeFPkl1EqV5vGxqvvLlVTO6fD6F+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="353734226"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="353734226"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10731"; a="658874822"
X-IronPort-AV: E=Sophos;i="6.00,217,1681196400"; 
   d="scan'208";a="658874822"
Received: from ezaker-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.85.189])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2023 16:33:02 -0700
Subject: [PATCH 15/19] cxl/region: Specify host-only vs device memory at
 region creation time
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com, navneet.singh@intel.com
Date:   Sun, 04 Jun 2023 16:33:01 -0700
Message-ID: <168592158192.1948938.1274727683021213802.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In preparation for supporting device-memory (HDM-D[B]) region creation,
convey the endpoint-decoder target type to devm_cxl_add_region().

Note that none of the existing sysfs ABIs allow for HDM-D[B] region
creation. The expectation is that HDM-D[B] region creation requires a
kernel-internal region creation flow, for example, driven by an
accelerator driver.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/region.c |   14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index defc2f0e43e3..75c5de627868 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -2120,7 +2120,8 @@ static ssize_t create_ram_region_show(struct device *dev,
 }
 
 static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
-					  enum cxl_decoder_mode mode, int id)
+					  int id, enum cxl_decoder_mode mode,
+					  enum cxl_decoder_type type)
 {
 	int rc;
 
@@ -2133,7 +2134,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
 		return ERR_PTR(-EBUSY);
 	}
 
-	return devm_cxl_add_region(cxlrd, id, mode, CXL_DECODER_HOSTMEM);
+	return devm_cxl_add_region(cxlrd, id, mode, type);
 }
 
 static ssize_t create_pmem_region_store(struct device *dev,
@@ -2148,7 +2149,8 @@ static ssize_t create_pmem_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_PMEM, id);
+	cxlr = __create_region(cxlrd, id, CXL_DECODER_PMEM,
+			       CXL_DECODER_HOSTMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2168,7 +2170,7 @@ static ssize_t create_ram_region_store(struct device *dev,
 	if (rc != 1)
 		return -EINVAL;
 
-	cxlr = __create_region(cxlrd, CXL_DECODER_RAM, id);
+	cxlr = __create_region(cxlrd, id, CXL_DECODER_RAM, CXL_DECODER_HOSTMEM);
 	if (IS_ERR(cxlr))
 		return PTR_ERR(cxlr);
 
@@ -2703,8 +2705,8 @@ construct_region_begin(struct cxl_root_decoder *cxlrd,
 	int err = 0;
 
 	do {
-		cxlr = __create_region(cxlrd, cxled->mode,
-				       atomic_read(&cxlrd->region_id));
+		cxlr = __create_region(cxlrd, atomic_read(&cxlrd->region_id),
+				       cxled->mode, cxled->cxld.target_type);
 	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
 
 	if (IS_ERR(cxlr)) {

