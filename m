Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DE69C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  8 Nov 2022 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbiKHSaa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:30:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbiKHSaa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 8 Nov 2022 13:30:30 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ABC51E72F
        for <linux-cxl@vger.kernel.org>; Tue,  8 Nov 2022 10:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667932229; x=1699468229;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=geA5FvpKwrTuUY42W1nUPqEFsiD3A9hLebU6OboB/Qc=;
  b=ht2V4PIr3Ofxo+JqJhYPaAbb1Nhm0y9HxrD/rbv8UvwX0uHf/Z62Ffwv
   D01JIJuNGurXBWprtnZ4eDwbr77XKKd6tK2lbHS53uChLzgvdV0PSN42V
   ilNBN+cC3GKaZRwIc17A+iba4JMdHsFRNCnX8AN2VbI8Ai/gvbktj8Whu
   qSvBscYtCy6XoCOwIB+XWw8iin4r/Nbyp9qiOKPLpt4Xh4C+vxJ1VdJDU
   uKjdcDmmKY2ivW7oAXZ38v4H3D+JpbVabLstogO1Zr5Hh67afrgozc5SF
   TBtIs3IzgiQLU3HT50r+Rvf8MWiYJ9EzMV9QbhDX7LDDvzG+BgOPthh4H
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="291159797"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="291159797"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:29 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10525"; a="705400112"
X-IronPort-AV: E=Sophos;i="5.96,148,1665471600"; 
   d="scan'208";a="705400112"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2022 10:30:28 -0800
Subject: [PATCH v4 07/10] cxl: add monitor command to cxl
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Tue, 08 Nov 2022 11:30:28 -0700
Message-ID: <166793222841.3768752.2390044444606875734.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
References: <166793212765.3768752.4370741471494095451.stgit@djiang5-desk3.ch.intel.com>
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
 cxl/monitor.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+)

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
index 518d8142e40d..d8e498392ed7 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -32,11 +32,15 @@
 #include "event_trace.h"
 
 static const char *cxl_system = "cxl";
+const char *default_log = "/var/log/cxl-monitor.log";
 
 static struct monitor {
+	const char *log;
 	struct log_ctx ctx;
 	FILE *log_file;
 	bool human;
+	bool verbose;
+	bool daemon;
 } monitor;
 
 static void log_standard(struct log_ctx *ctx, int priority, const char *file,
@@ -163,3 +167,74 @@ epoll_err:
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
+		if (strncmp(monitor.log, "./standard", 10) == 0 && !monitor.daemon) {
+			monitor.ctx.log_fn = log_standard;
+		} else {
+			const char *log = monitor.log;
+
+			if (!monitor.log)
+				log = default_log;
+			monitor.log_file = fopen(log, "a+");
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


