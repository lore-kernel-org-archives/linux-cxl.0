Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54D3FC433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 00:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240666AbiAXAyH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Jan 2022 19:54:07 -0500
Received: from mga07.intel.com ([134.134.136.100]:6530 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240668AbiAXAyG (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Sun, 23 Jan 2022 19:54:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642985646; x=1674521646;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bz+nZmy5ZWyfZbPxruY+qRQpcN773rl+hSXf6yyFCuw=;
  b=nHOyRB51G655oA5CyuSzlFWgkElt6+gsQ93FfQsoN3L/gAkfSzDSWeXM
   S9XVf+re3I/1pAIgewYSSDTpk5uRpvlf6Sl5FAKZLE977aqA/1PHoQVMm
   mG6Zk7ROukiph+e2LxI17O19DbkxRCDm/KQIiVfXdquM9LXkpczXetcJh
   isRE3MG1ibuUHRamW8UtkxRTqcYZgU8MRx8iX7I1RFYr2naj5bTYtMli4
   aGJD4O6wSg3lSKdrjMMUI8OTR84sl8AW2gJrBjJ+oUIfAOj+bGixf4xO9
   x6ThvQPrJVdTfPzuGyy8HxO4xFVrzukqI+A7mJqARl7CGr90ZVj382ucD
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="309257415"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="309257415"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="534005241"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:54:06 -0800
Subject: [ndctl PATCH 26/37] cxl/memdev: Add serial support for
 memdev-related commands
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com
Date:   Sun, 23 Jan 2022 16:54:06 -0800
Message-ID: <164298564631.3021641.5552442288217413180.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298550885.3021641.11210386002804544864.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Allow for a "-s, --serial" option to turn the argument list into serial
identifiers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/cxl/memdev-option.txt |    5 ++++
 Documentation/cxl/meson.build       |    4 ++-
 cxl/memdev.c                        |   45 ++++++++++++++++++++++++++---------
 3 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/Documentation/cxl/memdev-option.txt b/Documentation/cxl/memdev-option.txt
index e7785827ab4c..64348bed1791 100644
--- a/Documentation/cxl/memdev-option.txt
+++ b/Documentation/cxl/memdev-option.txt
@@ -2,3 +2,8 @@
 A 'memX' device name, or a memdev id number. Restrict the operation to
 the specified memdev(s). The keyword 'all' can be specified to indicate
 the lack of any restriction.
+
+-S::
+--serial::
+	Rather an a memdev id number, interpret the <memdev> argument(s)
+	as a list of serial numbers.
diff --git a/Documentation/cxl/meson.build b/Documentation/cxl/meson.build
index 64ce13f59012..0a6346bc47ca 100644
--- a/Documentation/cxl/meson.build
+++ b/Documentation/cxl/meson.build
@@ -19,7 +19,9 @@ else
 endif
 
 filedeps = [
-        '../copyright.txt',
+  '../copyright.txt',
+  'memdev-option.txt',
+  'labels-options.txt',
 ]
 
 cxl_manpages = [
diff --git a/cxl/memdev.c b/cxl/memdev.c
index 4cca8b8c10be..ef5343ad892b 100644
--- a/cxl/memdev.c
+++ b/cxl/memdev.c
@@ -24,12 +24,14 @@ static struct parameters {
 	unsigned len;
 	unsigned offset;
 	bool verbose;
+	bool serial;
 } param;
 
 static struct log_ctx ml;
 
 #define BASE_OPTIONS() \
-OPT_BOOLEAN('v',"verbose", &param.verbose, "turn on debug")
+OPT_BOOLEAN('v',"verbose", &param.verbose, "turn on debug"), \
+OPT_BOOLEAN('S', "serial", &param.serial, "user serials numbers to id memdevs")
 
 #define READ_OPTIONS() \
 OPT_STRING('o', "output", &param.outfile, "output-file", \
@@ -172,8 +174,9 @@ out:
 }
 
 static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
-		int (*action)(struct cxl_memdev *memdev, struct action_context *actx),
-		const struct option *options, const char *usage)
+			 int (*action)(struct cxl_memdev *memdev,
+				       struct action_context *actx),
+			 const struct option *options, const char *usage)
 {
 	struct cxl_memdev *memdev, *single = NULL;
 	struct action_context actx = { 0 };
@@ -190,16 +193,25 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 	if (argc == 0)
 		usage_with_options(u, options);
 	for (i = 0; i < argc; i++) {
-		if (strcmp(argv[i], "all") == 0) {
-			argc = 1;
-			break;
+		if (param.serial) {
+			char *end;
+
+			strtoull(argv[i], &end, 0);
+			if (end[0] == 0)
+				continue;
+		} else {
+			if (strcmp(argv[i], "all") == 0) {
+				argc = 1;
+				break;
+			}
+			if (sscanf(argv[i], "mem%lu", &id) == 1)
+				continue;
+			if (sscanf(argv[i], "%lu", &id) == 1)
+				continue;
 		}
-		if (sscanf(argv[i], "mem%lu", &id) == 1)
-			continue;
-		if (sscanf(argv[i], "%lu", &id) == 1)
-			continue;
 
-		log_err(&ml, "'%s' is not a valid memdev name\n", argv[i]);
+		log_err(&ml, "'%s' is not a valid memdev %s\n", argv[i],
+			param.serial ? "serial number" : "name");
 		err++;
 	}
 
@@ -244,7 +256,16 @@ static int memdev_action(int argc, const char **argv, struct cxl_ctx *ctx,
 
 	for (i = 0; i < argc; i++) {
 		cxl_memdev_foreach(ctx, memdev) {
-			if (!util_cxl_memdev_filter(memdev, argv[i], NULL))
+			const char *memdev_filter = NULL;
+			const char *serial_filter = NULL;
+
+			if (param.serial)
+				serial_filter = argv[i];
+			else
+				memdev_filter = argv[i];
+
+			if (!util_cxl_memdev_filter(memdev, memdev_filter,
+						    serial_filter))
 				continue;
 
 			if (action == action_write) {

