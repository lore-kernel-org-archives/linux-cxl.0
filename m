Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 971FCC77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 02:21:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjEaCU7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 22:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjEaCU7 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 22:20:59 -0400
Received: from esa5.hc1455-7.c3s2.iphmx.com (esa5.hc1455-7.c3s2.iphmx.com [68.232.139.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00459EC
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 19:20:57 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="118391388"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="118391388"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa5.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 11:19:51 +0900
Received: from yto-m3.gw.nic.fujitsu.com (yto-nat-yto-m3.gw.nic.fujitsu.com [192.168.83.66])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 03D69C68E8
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:19:49 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by yto-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 4EA1D11C5E
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:19:48 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 59D6868957;
        Wed, 31 May 2023 11:19:47 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, dave.jiang@intel.com,
        alison.schofield@intel.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v3 6/6] ndctl/monitor: use strcmp to compare the reserved word
Date:   Wed, 31 May 2023 10:19:36 +0800
Message-Id: <20230531021936.7366-7-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230531021936.7366-1-lizhijian@fujitsu.com>
References: <20230531021936.7366-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.004
X-TMASE-Result: 10--6.853400-10.000000
X-TMASE-MatchedRID: D4Z888FpREt15zj/0di3Qx1kSRHxj+Z5RpgtqnD1BD4yiHqxwIX2MV3w
        KTJCsiojZpCaFaIgtCAIA0tg8Os0LyfB+/OOFhyOTuctSpiuWyUUi4Ehat05499RlPzeVuQQzws
        ZM0WpYpo6hUOcTonr9IAy6p60ZV62yA7duzCw6dLdB/CxWTRRu25FeHtsUoHuwyEzNyV871FEbM
        ZjtbJBC3bWBYXYTOQ2MEvv6EqsnWqwFMlIPaIBbQ==
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

According to the tool's documentation, when '-l standard' is specified,
log would be output to the stdout. But since it's using strncmp(a, b, 10)
to compare the former 10 characters, it will also wrongly detect a
filename starting with a substring 'standard' as stdout.

For example:
$ ndctl monitor -l standard.log

User is most likely want to save log to ./standard.log instead of stdout.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V3: Improve commit log # Dave
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

