Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CD1AC7EE2E
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 06:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232126AbjEVGyn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 02:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjEVGyR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 02:54:17 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0261B10D7
        for <linux-cxl@vger.kernel.org>; Sun, 21 May 2023 23:52:02 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="105181860"
X-IronPort-AV: E=Sophos;i="6.00,183,1681138800"; 
   d="scan'208";a="105181860"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:52:00 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id DC043DB399
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:58 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 3AC19D3F04
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:58 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 857701145B82;
        Mon, 22 May 2023 15:51:57 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2 6/6] ndctl/monitor: use strcmp to compare the reserved word
Date:   Mon, 22 May 2023 14:51:48 +0800
Message-Id: <20230522065148.818977-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230522065148.818977-1-lizhijian@fujitsu.com>
References: <20230522065148.818977-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27642.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27642.005
X-TMASE-Result: 10--6.270400-10.000000
X-TMASE-MatchedRID: 5cMIDPsUQeR/s7IOpKdgtx1kSRHxj+Z5RpgtqnD1BD4yiHqxwIX2MWeX
        mwoqwyphxQTdQMAU4mRZrjNEQuAJgh/Qfe1gmZY9IBYc5Hfv4BPBOVz0Jwcxl6vCrG0TnfVU2d8
        mtRIRsUMfM4ErvgcIi9wU8VHXGipCHxPMjOKY7A+u65UDD0aDgsRB0bsfrpPIfiAqrjYtFiSx/9
        vUDvOCOmlRG1njmJZzyf/EPDnEuQ0UAG/EuUqq1X7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

According to its document, when '-l standard' is specified, log would be
output to the stdout. But actually, since it's using strncmp(a, b, 10)
to compare the former 10 characters, it will also wrongly treat a filename
starting with a substring 'standard' to stdout.

For example:
$ ndctl monitor -l standard.log

User is most likely want to save log to ./standard.log instead of stdout.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: commit log updated # Dave
---
 ndctl/monitor.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/ndctl/monitor.c b/ndctl/monitor.c
index 89903def63d4..bd8a74863476 100644
--- a/ndctl/monitor.c
+++ b/ndctl/monitor.c
@@ -610,9 +610,9 @@ int cmd_monitor(int argc, const char **argv, struct ndctl_ctx *ctx)
 	if (monitor.log) {
 		if (strncmp(monitor.log, "./", 2) != 0)
 			fix_filename(prefix, (const char **)&monitor.log);
-		if (strncmp(monitor.log, "./syslog", 8) == 0)
+		if (strcmp(monitor.log, "./syslog") == 0)
 			monitor.ctx.log_fn = log_syslog;
-		else if (strncmp(monitor.log, "./standard", 10) == 0)
+		else if (strcmp(monitor.log, "./standard") == 0)
 			monitor.ctx.log_fn = log_standard;
 		else {
 			monitor.ctx.log_file = fopen(monitor.log, "a+");
-- 
2.29.2

