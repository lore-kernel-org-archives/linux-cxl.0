Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26663C433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:53:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240660AbiAXAx4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:53:56 -0500
Received: from mga03.intel.com ([134.134.136.65]:63601 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240666AbiAXAx4 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:53:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985636; x=1674521636;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sMsLzmYBgttFdjviGx5xgfqy1//K1RcepiYwrO8ge/Q=;
  b=Z/qGEbaAm8djPLVcwvzLlghTNkcrNWLeMR6canqJ8HXhQJHaCQLEQitC
   ZEe4w30adw54wU492mJ11dtvfdg3bj1P/W3j8SzpMOxR218pyRUwF0slW
   dv56WtrRh9BGz92d/62Zb2FqX1r3oUD8i4VUvom+3LGUp5eG/+FsxLuWa
   eaWoduSAvl4Ffqd6liZ6TEowhttcptiy4r6mzMCdJ0qL0kQhpejcTXjvH
   /eVG4MS71Qei36RtnMMU0tE+I6eBFCiZ74pVW0cvDntxl02zx/s+I+M+h
   MlTkd37zpT2QobqK1x+E8YjqLT04jZ96bS5TQaCRxitPWDbvBRqCKhzT5
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="245880918"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="245880918"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:56 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617065085"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:53:55 -0800
Subject: [ndctl PATCH 24/37] cxl/memdev: Use a local logger for debug
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:53:55 -0800
Message-ID: <164298563547.3021641.16504008034705274247.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The "fail()" macro skips some of the nicer features of the centralized
logger. Add one to supplement the library logger.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 cxl/memdev.c |   48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/cxl/memdev.c b/cxl/memdev.c
index b9141be62c87..327c2608f179 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -26,11 +26,7 @@ static struct parameters {
 	bool verbose;
 } param;
 
-#define fail(fmt, ...) \
-do { \
-	fprintf(stderr, "cxl-%s:%s:%d: " fmt, \
-			VERSION, __func__, __LINE__, ##__VA_ARGS__); \
-} while (0)
+static struct log_ctx ml;
 
 #define BASE_OPTIONS() \
 OPT_BOOLEAN('v',"verbose", &param.verbose, "turn on debug")
@@ -79,7 +75,7 @@ static int action_zero(struct cxl_memdev *memdev, struct action_context *actx)
 		size = cxl_memdev_get_label_size(memdev);
 
 	if (cxl_memdev_nvdimm_bridge_active(memdev)) {
-		fprintf(stderr,
+		log_err(&ml,
 			"%s: has active nvdimm bridge, abort label write\n",
 			cxl_memdev_get_devname(memdev));
 		return -EBUSY;
@@ -87,7 +83,7 @@ static int action_zero(struct cxl_memdev *memdev, struct action_context *actx)
 
 	rc = cxl_memdev_zero_label(memdev, size, param.offset);
 	if (rc < 0)
-		fprintf(stderr, "%s: label zeroing failed: %s\n",
+		log_err(&ml, "%s: label zeroing failed: %s\n",
 			cxl_memdev_get_devname(memdev), strerror(-rc));
 
 	return rc;
@@ -100,7 +96,7 @@ static int action_write(struct cxl_memdev *memdev, struct action_context *actx)
 	int rc;
 
 	if (cxl_memdev_nvdimm_bridge_active(memdev)) {
-		fprintf(stderr,
+		log_err(&ml,
 			"%s: has active nvdimm bridge, abort label write\n",
 			cxl_memdev_get_devname(memdev));
 		return -EBUSY;
@@ -114,7 +110,7 @@ static int action_write(struct cxl_memdev *memdev, struct action_context *actx)
 		fseek(actx->f_in, 0L, SEEK_SET);
 
 		if (size > label_size) {
-			fprintf(stderr,
+			log_err(&ml,
 				"File size (%zu) greater than label area size (%zu), aborting\n",
 				size, label_size);
 			return -EINVAL;
@@ -133,7 +129,7 @@ static int action_write(struct cxl_memdev *memdev, struct action_context *actx)
 
 	rc = cxl_memdev_write_label(memdev, buf, size, param.offset);
 	if (rc < 0)
-		fprintf(stderr, "%s: label write failed: %s\n",
+		log_err(&ml, "%s: label write failed: %s\n",
 			cxl_memdev_get_devname(memdev), strerror(-rc));
 
 out:
@@ -158,7 +154,7 @@ static int action_read(struct cxl_memdev *memdev, struct action_context *actx)
 
 	rc = cxl_memdev_read_label(memdev, buf, size, param.offset);
 	if (rc < 0) {
-		fprintf(stderr, "%s: label read failed: %s\n",
+		log_err(&ml, "%s: label read failed: %s\n",
 			cxl_memdev_get_devname(memdev), strerror(-rc));
 		goto out;
 	}
@@ -188,6 +184,7 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	};
 	unsigned long id;
 
+	log_init(&ml, "cxl memdev", "CXL_MEMDEV_LOG");
 	argc = parse_options(argc, argv, options, u, 0);
 
 	if (argc == 0)
@@ -200,8 +197,8 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 		}
 
 		if (sscanf(argv[i], "mem%lu", &id) != 1) {
-			fprintf(stderr, "'%s' is not a valid memdev name\n",
-					argv[i]);
+			log_err(&ml, "'%s' is not a valid memdev name\n",
+				argv[i]);
 			err++;
 		}
 	}
@@ -216,8 +213,8 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	else {
 		actx.f_out = fopen(param.outfile, "w+");
 		if (!actx.f_out) {
-			fprintf(stderr, "failed to open: %s: (%s)\n",
-					param.outfile, strerror(errno));
+			log_err(&ml, "failed to open: %s: (%s)\n",
+				param.outfile, strerror(errno));
 			rc = -errno;
 			goto out;
 		}
@@ -228,15 +225,18 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	} else {
 		actx.f_in = fopen(param.infile, "r");
 		if (!actx.f_in) {
-			fprintf(stderr, "failed to open: %s: (%s)\n",
-					param.infile, strerror(errno));
+			log_err(&ml, "failed to open: %s: (%s)\n", param.infile,
+				strerror(errno));
 			rc = -errno;
 			goto out_close_fout;
 		}
 	}
 
-	if (param.verbose)
+	if (param.verbose) {
 		cxl_set_log_priority(ctx, LOG_DEBUG);
+		ml.log_priority = LOG_DEBUG;
+	} else
+		ml.log_priority = LOG_INFO;
 
 	rc = 0;
 	err = 0;
@@ -299,8 +299,8 @@ int cmd_write_labels(int argc, const char **argv, struct cxl_ctx *ctx)
 	int count = memdev_action(argc, argv, ctx, action_write, write_options,
 			"cxl write-labels <memdev> [-i <filename>]");
 
-	fprintf(stderr, "wrote %d mem%s\n", count >= 0 ? count : 0,
-			count > 1 ? "s" : "");
+	log_info(&ml, "wrote %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
 
@@ -309,8 +309,8 @@ int cmd_read_labels(int argc, const char **argv, struct cxl_ctx *ctx)
 	int count = memdev_action(argc, argv, ctx, action_read, read_options,
 			"cxl read-labels <mem0> [<mem1>..<memN>] [-o <filename>]");
 
-	fprintf(stderr, "read %d mem%s\n", count >= 0 ? count : 0,
-			count > 1 ? "s" : "");
+	log_info(&ml, "read %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }
 
@@ -319,7 +319,7 @@ int cmd_zero_labels(int argc, const char **argv, struct cxl_ctx *ctx)
 	int count = memdev_action(argc, argv, ctx, action_zero, zero_options,
 			"cxl zero-labels <mem0> [<mem1>..<memN>] [<options>]");
 
-	fprintf(stderr, "zeroed %d mem%s\n", count >= 0 ? count : 0,
-			count > 1 ? "s" : "");
+	log_info(&ml, "zeroed %d mem%s\n", count >= 0 ? count : 0,
+		 count > 1 ? "s" : "");
 	return count >= 0 ? 0 : EXIT_FAILURE;
 }

