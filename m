Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 817E4CCA47B
	for <linux-cxl@archiver.kernel.org>; Thu, 14 Jul 2022 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239526AbiGNRCg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 14 Jul 2022 13:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232491AbiGNRCg (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 14 Jul 2022 13:02:36 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D553B57250
        for <linux-cxl@vger.kernel.org>; Thu, 14 Jul 2022 10:02:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657818154; x=1689354154;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=z2SMMm41uIRd5DJN5abWRnM6MsMByqAH5tJ7qm43uuc=;
  b=bTVPbIVbHwSqS58F7uDIaMM6e0asAtR1FPu73AJeHCD/eX/yuVolADxx
   bYgOmTltJedm8J0lVahx7TDchoaXajo5TEJUxdcNEG/47S7oO9iRM2ePB
   4ao53qnJur+56Q5EgJGa9Gaz+uYXAMB3irHM1Nz6Ofxgt7O5qFzuh8AIy
   IIu+t/Zfgwfy9Rq8vVNbLx4WwI1Y64hARgKuU1cMAl96d7ydu01k6cTxG
   JNOf5M1M8n5yrib3yQ3qQ6NS51qr3dTk24QrCbT0SfAsx5X6h3DiegY0p
   M/AwcAA2gKM5s6Q4HSi7IZVt8jH0I7mvUqbylvv7kNYVtj1Owwm7wrgyJ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="268602692"
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="268602692"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:28 -0700
X-IronPort-AV: E=Sophos;i="5.92,271,1650956400"; 
   d="scan'208";a="653953199"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 10:02:27 -0700
Subject: [ndctl PATCH v2 07/12] cxl/memdev: Fix json for multi-device
 partitioning
From:   Dan Williams <dan.j.williams@intel.com>
To:     vishal.l.verma@intel.com
Cc:     Alison Schofield <alison.schofield@intel.com>,
        nvdimm@lists.linux.dev, linux-cxl@vger.kernel.org
Date:   Thu, 14 Jul 2022 10:02:27 -0700
Message-ID: <165781814737.1555691.889129128205037941.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
References: <165781810717.1555691.1411727384567016588.stgit@dwillia2-xfh.jf.intel.com>
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

