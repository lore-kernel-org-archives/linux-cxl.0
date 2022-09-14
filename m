Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBEFCC6FA82
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Sep 2022 20:48:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiINUse (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Sep 2022 16:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiINUsc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 14 Sep 2022 16:48:32 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B506B6D55D
        for <linux-cxl@vger.kernel.org>; Wed, 14 Sep 2022 13:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1663188511; x=1694724511;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=v8mPJn8gFZzMEnNWpvc6BDFuNYCMsTNXHqtEXGLSSMk=;
  b=AB85Rt3A17PzORakQGwwfgebXzBzXv+COH85BDq9k+zIThThgreT/XhN
   UUbUXdxHcpupJsAVOEsgpQKaXchVwsESpd/Nrv7H3sEdoT1TCacTMdSGR
   rQNeL8jZ7H21ivQZhFZTI/7zBau5Z/0n0yk+63Cx9GTeA5My83NCor13t
   ns5Fl8cLlrCVT2WW9xR8grY+nvXa0rt04DXGNDtxPFkMGGSF4wm+5T9xs
   DZucXfQP1Kbg+EPIJ/PrMLcEPF9fmalKXi/dn1hEM1ZMQECS8VDiQR+KH
   tkQ3KzDwwsx2CkCUZXwHy42EdcITF4IOOENYPlbzRb6kq9//dUzsdwC5x
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10470"; a="360278068"
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="360278068"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:31 -0700
X-IronPort-AV: E=Sophos;i="5.93,315,1654585200"; 
   d="scan'208";a="685449289"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2022 13:48:30 -0700
Subject: [PATCH 7/7] ndctl: cxl: add monitor command to cxl
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     alison.schofield@intel.com, vishal.l.verma@intel.com,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com
Date:   Wed, 14 Sep 2022 13:48:30 -0700
Message-ID: <166318851033.3087953.1487642256782771767.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
References: <166318836385.3087953.6809315284050736931.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Connect the monitoring functionality to the cxl monitor command. Add basic
functionality to the cxl monitor command where it can be launched as a daemon
and logging can be designated to stdout or a file.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 cxl/builtin.h |    1 +
 cxl/cxl.c     |    1 +
 cxl/monitor.c |   70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/cxl/builtin.h b/cxl/builtin.h
index b28c2213993b..34c5cfb49051 100644
--- a/cxl/builtin.h
+++ b/cxl/builtin.h
@@ -22,4 +22,5 @@ int cmd_create_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_enable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_disable_region(int argc, const char **argv, struct cxl_ctx *ctx);
 int cmd_destroy_region(int argc, const char **argv, struct cxl_ctx *ctx);
+int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx);
 #endif /* _CXL_BUILTIN_H_ */
diff --git a/cxl/cxl.c b/cxl/cxl.c
index dd1be7a054a1..3be7026f43d3 100644
--- a/cxl/cxl.c
+++ b/cxl/cxl.c
@@ -76,6 +76,7 @@ static struct cmd_struct commands[] = {
 	{ "enable-region", .c_fn = cmd_enable_region },
 	{ "disable-region", .c_fn = cmd_disable_region },
 	{ "destroy-region", .c_fn = cmd_destroy_region },
+	{ "monitor", .c_fn = cmd_monitor },
 };
 
 int main(int argc, const char **argv)
diff --git a/cxl/monitor.c b/cxl/monitor.c
index e030542a3fe8..e185d15254ec 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -34,9 +34,12 @@
 const char *systems[] = { "cxl_events", "cxl_aer", NULL };
 
 static struct monitor {
+	const char *log;
 	struct log_ctx ctx;
 	FILE *log_file;
 	bool human;
+	bool verbose;
+	bool daemon;
 } monitor;
 
 static void log_standard(struct log_ctx *ctx, int priority, const char *file,
@@ -163,3 +166,70 @@ epoll_err:
 	free(events);
 	return rc;
 }
+
+int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
+{
+	const struct option options[] = {
+		OPT_FILENAME('l', "log", &monitor.log,
+				"<file> | standard",
+				"where to output the monitor's notification"),
+		OPT_BOOLEAN('\0', "daemon", &monitor.daemon,
+				"run cxl monitor as a daemon"),
+		OPT_BOOLEAN('u', "human", &monitor.human,
+				"use human friendly output formats"),
+		OPT_BOOLEAN('v', "verbose", &monitor.verbose,
+				"emit extra debug messages to log"),
+		OPT_END(),
+	};
+	const char * const u[] = {
+		"cxl monitor [<options>]",
+		NULL
+	};
+	const char *prefix ="./";
+	int rc = 0, i;
+
+	argc = parse_options_prefix(argc, argv, prefix, options, u, 0);
+	for (i = 0; i < argc; i++)
+		error("unknown parameter \"%s\"\n", argv[i]);
+	if (argc)
+		usage_with_options(u, options);
+
+	log_init(&monitor.ctx, "cxl/monitor", "CXL_MONITOR_LOG");
+	monitor.ctx.log_fn = log_standard;
+
+	if (monitor.verbose)
+		monitor.ctx.log_priority = LOG_DEBUG;
+	else
+		monitor.ctx.log_priority = LOG_INFO;
+
+	if (monitor.log) {
+		if (strncmp(monitor.log, "./", 2) != 0)
+			fix_filename(prefix, (const char **)&monitor.log);
+		if (strncmp(monitor.log, "./standard", 10) == 0) {
+			monitor.ctx.log_fn = log_standard;
+		} else {
+			monitor.log_file = fopen(monitor.log, "a+");
+			if (!monitor.log_file) {
+				rc = -errno;
+				error("open %s failed: %d\n", monitor.log, rc);
+				goto out;
+			}
+			monitor.ctx.log_fn = log_file;
+		}
+	}
+
+	if (monitor.daemon) {
+		if (daemon(0, 0) != 0) {
+			err(&monitor, "daemon start failed\n");
+			goto out;
+		}
+		info(&monitor, "cxl monitor daemon started.\n");
+	}
+
+	rc = monitor_event(ctx);
+
+out:
+	if (monitor.log_file)
+		fclose(monitor.log_file);
+	return rc;
+}


