Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65B8DC4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Nov 2022 00:07:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232151AbiKJAHz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 9 Nov 2022 19:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232163AbiKJAHx (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 9 Nov 2022 19:07:53 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80BA618E1C
        for <linux-cxl@vger.kernel.org>; Wed,  9 Nov 2022 16:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668038872; x=1699574872;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0Kq7b8Z3+KZEttxPX6Z4PVMSmmT8ijpwlx3QuzqVpc0=;
  b=iOA7zggSITqXq1yu6HiRLwxFqKfl/xccO5zVeqWSnMdYVslAG2sW8LUV
   +fcadA3C95+gMmiTTAKoIrtD0urPPvFRMU4R+mJOKhzIIGbI1K1gAjE9q
   sgYrLaXMcwv9KK7NzJ4Nb4Q6tFFjCOJhf6VnjOeB5Y8t+jrog8WIjy29g
   cFvBbJNbRGI9R6oMZ7jZ3Lt/+lAP8K8CZwEEauobaX7lZ83Lf1E8T236n
   583GeH/NEU7i0iHQu5TW6wkPL4ksVHjyKw+dTiraNTRhwrsf3fE6ot6IE
   sz9LGOafEHTrGhr+aJshHt35H77u2GiVDdXzo3vJhOzr2jnOykrk8VRLF
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="337909827"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="337909827"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:52 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="882130216"
X-IronPort-AV: E=Sophos;i="5.96,152,1665471600"; 
   d="scan'208";a="882130216"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2022 16:07:51 -0800
Subject: [PATCH v5 4/7] ndctl: move common logging functions from
 ndctl/monitor.c to util/log.c
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 09 Nov 2022 17:07:51 -0700
Message-ID: <166803887168.145141.3780565277727044591.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
References: <166803877747.145141.11853418648969334939.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Since cxl/monitor.c will be using same logging functions that
ndctl/monitor.c will be using, move common functions to util/log.c.

Signed-off-by: Dave Jiang <dave.jiang@gmail.com>
---
 ndctl/monitor.c |   41 ++++-------------------------------------
 util/log.c      |   34 ++++++++++++++++++++++++++++++++++
 util/log.h      |    8 +++++++-
 3 files changed, 45 insertions(+), 38 deletions(-)

diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 54678d6100b9..89903def63d4 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -33,7 +33,6 @@ static struct monitor {
 	const char *log;
 	const char *configs;
 	const char *dimm_event;
-	FILE *log_file;
 	bool daemon;
 	bool human;
 	bool verbose;
@@ -61,38 +60,6 @@ do { \
 			VERSION, __func__, __LINE__, ##__VA_ARGS__); \
 } while (0)
 
-static void log_syslog(struct log_ctx *ctx, int priority, const char *file,
-		int line, const char *fn, const char *format, va_list args)
-{
-	vsyslog(priority, format, args);
-}
-
-static void log_standard(struct log_ctx *ctx, int priority, const char *file,
-		int line, const char *fn, const char *format, va_list args)
-{
-	if (priority == 6)
-		vfprintf(stdout, format, args);
-	else
-		vfprintf(stderr, format, args);
-}
-
-static void log_file(struct log_ctx *ctx, int priority, const char *file,
-		int line, const char *fn, const char *format, va_list args)
-{
-	FILE *f = monitor.log_file;
-
-	if (priority != LOG_NOTICE) {
-		struct timespec ts;
-
-		clock_gettime(CLOCK_REALTIME, &ts);
-		fprintf(f, "[%10ld.%09ld] [%d] ", ts.tv_sec, ts.tv_nsec, getpid());
-		vfprintf(f, format, args);
-	} else
-		vfprintf(f, format, args);
-
-	fflush(f);
-}
-
 static struct json_object *dimm_event_to_json(struct monitor_dimm *mdimm)
 {
 	struct json_object *jevent, *jobj;
@@ -648,8 +615,8 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 		else if (strncmp(monitor.log, "./standard", 10) == 0)
 			monitor.ctx.log_fn = log_standard;
 		else {
-			monitor.log_file = fopen(monitor.log, "a+");
-			if (!monitor.log_file) {
+			monitor.ctx.log_file = fopen(monitor.log, "a+");
+			if (!monitor.ctx.log_file) {
 				error("open %s failed\n", monitor.log);
 				rc = -errno;
 				goto out;
@@ -694,8 +661,8 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 
 	rc = monitor_event(ctx, &mfa);
 out:
-	if (monitor.log_file)
-		fclose(monitor.log_file);
+	if (monitor.ctx.log_file)
+		fclose(monitor.ctx.log_file);
 	if (path)
 		free(path);
 	return rc;
diff --git a/util/log.c b/util/log.c
index 61ac509f4ac5..d4eef0a1fc5c 100644
--- a/util/log.c
+++ b/util/log.c
@@ -2,11 +2,45 @@
 // Copyright (C) 2016-2020, Intel Corporation. All rights reserved.
 #include <syslog.h>
 #include <stdlib.h>
+#include <unistd.h>
 #include <ctype.h>
 #include <string.h>
 #include <errno.h>
+#include <time.h>
 #include <util/log.h>
 
+void log_syslog(struct log_ctx *ctx, int priority, const char *file, int line,
+		const char *fn, const char *format, va_list args)
+{
+	vsyslog(priority, format, args);
+}
+
+void log_standard(struct log_ctx *ctx, int priority, const char *file, int line,
+		  const char *fn, const char *format, va_list args)
+{
+	if (priority == 6)
+		vfprintf(stdout, format, args);
+	else
+		vfprintf(stderr, format, args);
+}
+
+void log_file(struct log_ctx *ctx, int priority, const char *file, int line,
+	      const char *fn, const char *format, va_list args)
+{
+	FILE *f = ctx->log_file;
+
+	if (priority != LOG_NOTICE) {
+		struct timespec ts;
+
+		clock_gettime(CLOCK_REALTIME, &ts);
+		fprintf(f, "[%10ld.%09ld] [%d] ", ts.tv_sec, ts.tv_nsec,
+			getpid());
+	}
+
+	vfprintf(f, format, args);
+	fflush(f);
+}
+
 void do_log(struct log_ctx *ctx, int priority, const char *file,
 		int line, const char *fn, const char *format, ...)
 {
diff --git a/util/log.h b/util/log.h
index 28f1c7bfcea4..6e09b0dc6494 100644
--- a/util/log.h
+++ b/util/log.h
@@ -14,9 +14,15 @@ struct log_ctx {
 	log_fn log_fn;
 	const char *owner;
 	int log_priority;
+	FILE *log_file;
 };
 
-
+void log_syslog(struct log_ctx *ctx, int priority, const char *file, int line,
+		const char *fn, const char *format, va_list args);
+void log_standard(struct log_ctx *ctx, int priority, const char *file, int line,
+		  const char *fn, const char *format, va_list args);
+void log_file(struct log_ctx *ctx, int priority, const char *file, int line,
+	      const char *fn, const char *format, va_list args);
 void do_log(struct log_ctx *ctx, int priority, const char *file, int line,
 		const char *fn, const char *format, ...)
 	__attribute__((format(printf, 6, 7)));


