Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A489EB64DD
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 11:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjGKLyL (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 07:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjGKLyK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 07:54:10 -0400
Received: from esa8.hc1455-7.c3s2.iphmx.com (esa8.hc1455-7.c3s2.iphmx.com [139.138.61.253])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE591702
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 04:53:59 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10767"; a="112243792"
X-IronPort-AV: E=Sophos;i="6.01,196,1684767600"; 
   d="scan'208";a="112243792"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa8.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2023 20:53:56 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 2C631C68E4
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 20:53:55 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 70595D3F08
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 20:53:54 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id A5DAB20077BBB;
        Tue, 11 Jul 2023 20:53:53 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev, alison.schofield@intel.com
Cc:     linux-cxl@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [ndctl PATCH v4 1/4] cxl/monitor: Enable default_log and refactor sanity check
Date:   Tue, 11 Jul 2023 19:53:41 +0800
Message-Id: <20230711115344.562823-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230711115344.562823-1-lizhijian@fujitsu.com>
References: <20230711115344.562823-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27744.006
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27744.006
X-TMASE-Result: 10--9.228600-10.000000
X-TMASE-MatchedRID: MY+gfqSKTkYmIUsxKhH73B1kSRHxj+Z5+gx7Y6zr6DlUjspoiX02F43E
        akIoHWNdDpuaKSg+ijD6y7jwF7EdbcpWUr5kPi0PqhcdnP91eXEbbhhV65kaY5npTtCGSpGe90i
        bxL4bz6DZrD+LZeBO4leCc7s6V0VH+gtEW3D/QKYgFhzkd+/gE8E5XPQnBzGXq8KsbROd9VQhvk
        2mor77msw/xnPT4YLV8PwIYNh8Bn2wYF3neS0lugKDWtq/hHcNwRdjnTeqAAGbKItl61J/yZ+in
        TK0bC9eKrauXd3MZDVzn+zl+8zIOPQxAz5EUTEG0ctbNC7L8a/RmuIhBu8NLYQqxT6ztOEj
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The default_log(/var/log/cxl-monitor.log) should be used when no '-l'
argument is specified in daemon mode, but it was not working at all.

Simplify the sanity checks so that the default log file is assigned
correctly, and the behavior is consistent with the documentation.

Remove the unnecessary fix_filename() for monitor.log since
parse_options_prefix() has done similar stuff if needed.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V4: add reviewed tag and minor fixes: comment style and change log.
V2: exchange order of previous patch1 and patch2 # Alison
    a few commit log updated
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
 cxl/monitor.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/cxl/monitor.c b/cxl/monitor.c
index e3469b9a4792..d8245ed8d0e9 100644
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
 
+	/* sanity check */
+	if (monitor.daemon && monitor.log && !strncmp(monitor.log, "./", 2)) {
+		error("relative path or 'standard' are not compatible with daemon mode\n");
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

