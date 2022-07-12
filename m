Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77B56C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Jul 2022 19:32:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbiGLTcq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Jul 2022 15:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233756AbiGLTc1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Jul 2022 15:32:27 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2780EFB8EC
        for <linux-cxl@vger.kernel.org>; Tue, 12 Jul 2022 12:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657652896; x=1689188896;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2SMMm41uIRd5DJN5abWRnM6MsMByqAH5tJ7qm43uuc=;
  b=NjyH7j9Av7ZKqjNSmzmYxmOIO0e4ePi306f04UD9tCfJ586BizD5wspz
   uYigYzOVDBN13pF4WbUnqhNBb1/B4EzJ4G0lcc/+/D0pjhLfjlzomsAfA
   JwRTWIkxTvLb0qicuZSYC+O1xJt2SOjYJY4xc0t50YiPXFB3BHbwhz0MC
   xG8inc56D+j0cG4I6GkN7H5SgTENajZdog34FZ07SVc5KcDNkqvqeN9Yq
   H4r4nPKqnvTBzr2aa4dAuvfmGtdKcqmI7JDy/7tVU/XltvT+bP+J0BoCk
   buJWpEPFy5ASYanl4vcSOOzOiyjQRirajFk+G6Gb3WVh4/jztcKEDW2AJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10406"; a="286150423"
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="286150423"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:59 -0700
X-IronPort-AV: E=Sophos;i="5.92,266,1650956400"; 
   d="scan'208";a="599484287"
Received: from sheyting-mobl3.amr.corp.intel.com (HELO [192.168.1.117]) ([10.212.147.156])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2022 12:07:58 -0700
Subject: [ndctl PATCH 06/11] cxl/memdev: Fix json for multi-device
 partitioning
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Tue, 12 Jul 2022 12:07:58 -0700
Message-ID: <165765287829.435671.4715059086458230262.stgit@dwillia2-xfh>
In-Reply-To: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
References: <165765284365.435671.13173937566404931163.stgit@dwillia2-xfh>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

In the case when someone partitions several devices at once, collect all
the affected memdevs into a json array.

With the move to use util_display_json_array() that also requires a set of
flags to be specifiied. Apply the UTIL_JSON_HUMAN flag for all interactive
command result output to bring this command in line with other tools.

Cc: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/memdev.c |   26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/cxl/memdev.c b/cxl/memdev.c
index 91d914db5af6..9fcd8ae5724b 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -19,6 +19,7 @@
 struct action_context {
 	FILE *f_out;
 	FILE *f_in;
+	struct json_object *jdevs;
 };
 
 static struct parameters {
@@ -339,12 +340,13 @@ out:
 }
 
 static int action_setpartition(struct cxl_memdev *memdev,
-		struct action_context *actx)
+			       struct action_context *actx)
 {
 	const char *devname = cxl_memdev_get_devname(memdev);
 	enum cxl_setpart_type type = CXL_SETPART_PMEM;
 	unsigned long long size = ULLONG_MAX;
 	struct json_object *jmemdev;
+	unsigned long flags;
 	struct cxl_cmd *cmd;
 	int rc;
 
@@ -396,10 +398,12 @@ out_err:
 	if (rc)
 		log_err(&ml, "%s error: %s\n", devname, strerror(-rc));
 
-	jmemdev = util_cxl_memdev_to_json(memdev, UTIL_JSON_PARTITION);
-	if (jmemdev)
-		printf("%s\n", json_object_to_json_string_ext(jmemdev,
-		       JSON_C_TO_STRING_PRETTY));
+	flags = UTIL_JSON_PARTITION;
+	if (actx->f_out == stdout && isatty(1))
+		flags |= UTIL_JSON_HUMAN;
+	jmemdev = util_cxl_memdev_to_json(memdev, flags);
+	if (actx->jdevs && jmemdev)
+		json_object_array_add(actx->jdevs, jmemdev);
 
 	return rc;
 }
@@ -446,6 +450,9 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 		err++;
 	}
 
+	if (action == action_setpartition)
+		actx.jdevs = json_object_new_array();
+
 	if (err == argc) {
 		usage_with_options(u, options);
 		return -EINVAL;
@@ -528,6 +535,15 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	if (actx.f_in != stdin)
 		fclose(actx.f_in);
 
+	if (actx.jdevs) {
+		unsigned long flags = 0;
+
+		if (actx.f_out == stdout && isatty(1))
+			flags |= UTIL_JSON_HUMAN;
+		util_display_json_array(actx.f_out, actx.jdevs, flags);
+	}
+
+
  out_close_fout:
 	if (actx.f_out != stdout)
 		fclose(actx.f_out);

