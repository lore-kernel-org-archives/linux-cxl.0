Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E938C7EE26
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 06:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjEVGym (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 02:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbjEVGyQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 02:54:16 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83FAA1
        for <linux-cxl@vger.kernel.org>; Sun, 21 May 2023 23:52:01 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="118607963"
X-IronPort-AV: E=Sophos;i="6.00,183,1681138800"; 
   d="scan'208";a="118607963"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:51:59 +0900
Received: from oym-m2.gw.nic.fujitsu.com (oym-nat-oym-m2.gw.nic.fujitsu.com [192.168.87.59])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 37A91CD7E4
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:57 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id 6AAD8BF4A9
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:56 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id C31EC1145B82;
        Mon, 22 May 2023 15:51:55 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2 1/6] cxl/monitor: Enable default_log and refactor sanity check
Date:   Mon, 22 May 2023 14:51:43 +0800
Message-Id: <20230522065148.818977-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230522065148.818977-1-lizhijian@fujitsu.com>
References: <20230522065148.818977-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27642.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27642.005
X-TMASE-Result: 10--14.214300-10.000000
X-TMASE-MatchedRID: MY+gfqSKTkYmIUsxKhH73B1kSRHxj+Z5+gx7Y6zr6DlXPwnnY5XL5K/n
        cbbeKXJgGch0Pdb2B17LcexyZRDdfKHtbfqnw/DJCKFDk1kJexLRNIyGX0EQxMnJhTYnTng9jcR
        qQigdY12nsveNgW5ycFeCc7s6V0VH+gtEW3D/QKYgFhzkd+/gE8E5XPQnBzGXq8KsbROd9VQhvk
        2mor77msw/xnPT4YLVIAkHRTl/xj3Tyr0pKxS1VwKDWtq/hHcNwRdjnTeqAAGbKItl61J/yZ+in
        TK0bC9eKrauXd3MZDX4ZcfVYTi075uYg5Ct0VxwxI3Ud3GIUJsWYvASVaWCkRyARZvsalY4
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The default_log(/var/log/cxl-monitor.log) should be used when no '-l'
argument is specified in daemon mode, but it was not working at all.

Here we assigned it a default log per its arguments, and simplify the
sanity check so that it can be consistent with the document.

Please note that i also removed following addition stuff, since we have
added this prefix if needed during parsing the FILENAME in
parse_options_prefix().
if (strncmp(monitor.log, "./", 2) != 0)
    fix_filename(prefix, (const char **)&monitor.log);

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: exchange order of previous patch1 and patch2 # Alison
    a few commit log updated
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 cxl/monitor.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/cxl/monitor.c b/cxl/monitor.c
index e3469b9a4792..c6df2bad3c53 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -164,6 +164,7 @@ int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
 	};
 	const char *prefix ="./";
 	int rc = 0, i;
+	const char *log;
 
 	argc = parse_options_prefix(argc, argv, prefix, options, u, 0);
 	for (i = 0; i < argc; i++)
@@ -171,32 +172,33 @@ int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
 	if (argc)
 		usage_with_options(u, options);
 
+	// sanity check
+	if (monitor.daemon && monitor.log && !strncmp(monitor.log, "./", 2)) {
+		error("standard or relative path for <file> will not work for daemon mode\n");
+		return -EINVAL;
+	}
+
 	log_init(&monitor.ctx, "cxl/monitor", "CXL_MONITOR_LOG");
-	monitor.ctx.log_fn = log_standard;
+	if (monitor.log)
+		log = monitor.log;
+	else
+		log = monitor.daemon ? default_log : "./standard";
 
 	if (monitor.verbose)
 		monitor.ctx.log_priority = LOG_DEBUG;
 	else
 		monitor.ctx.log_priority = LOG_INFO;
 
-	if (monitor.log) {
-		if (strncmp(monitor.log, "./", 2) != 0)
-			fix_filename(prefix, (const char **)&monitor.log);
-		if (strncmp(monitor.log, "./standard", 10) == 0 && !monitor.daemon) {
-			monitor.ctx.log_fn = log_standard;
-		} else {
-			const char *log = monitor.log;
-
-			if (!monitor.log)
-				log = default_log;
-			monitor.log_file = fopen(log, "a+");
-			if (!monitor.log_file) {
-				rc = -errno;
-				error("open %s failed: %d\n", monitor.log, rc);
-				goto out;
-			}
-			monitor.ctx.log_fn = log_file;
+	if (strncmp(log, "./standard", 10) == 0)
+		monitor.ctx.log_fn = log_standard;
+	else {
+		monitor.log_file = fopen(log, "a+");
+		if (!monitor.log_file) {
+			rc = -errno;
+			error("open %s failed: %d\n", log, rc);
+			goto out;
 		}
+		monitor.ctx.log_fn = log_file;
 	}
 
 	if (monitor.daemon) {
-- 
2.29.2

