Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D89D6C4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 21:20:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbiKBVUq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 17:20:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230242AbiKBVUp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 17:20:45 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127CA2638
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 14:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667424045; x=1698960045;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BRZtJNmphtVvmiJbn99fy0ZvFYP43rtG/SU4/NRjh7M=;
  b=WWraEK2fLH5RN2PUlihhQnxEfvCd0IY+ywH6fhwRRIkShP2sKlk03Pu3
   3HURYZFtfmlPO4QhBdk7XSls6nHJNnjlxeKYyl2270Awpa1qOD9r/i3cy
   USGjne7J/LCvQXnDca9sWJ8FPIChcMLAXyWq+fpQoKnniPCtaPOnlTwBc
   IPITWsnAJCvOp3PpGg4cdceGhjFZR1a1v6n0O7xumm6NcK5MCjq6tUoyA
   wyg64woyzPUaaSemmHfrQ/+yzpslvQMofUix1SKCyll0WLqjqxWsNEOe0
   807SBz/eVOq79TbxH1qx3+LPDOuW1hszzTGgHtiJTKUY+yt59y5vFAnQk
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="307137970"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="307137970"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:44 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10519"; a="634418668"
X-IronPort-AV: E=Sophos;i="5.95,235,1661842800"; 
   d="scan'208";a="634418668"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2022 14:20:44 -0700
Subject: [PATCH v3 07/10] cxl: add monitor command to cxl
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rostedt@goodmis.org
Date:   Wed, 02 Nov 2022 14:20:43 -0700
Message-ID: <166742404371.2654617.14474171139466272787.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
References: <166742389426.2654617.4404053893427481848.stgit@djiang5-desk3.ch.intel.com>
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
index 9af12954b89b..1ca8540d887f 100644
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


