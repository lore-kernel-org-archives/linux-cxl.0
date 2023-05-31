Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10E1CC77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 02:19:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234010AbjEaCT4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 22:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234007AbjEaCTz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 22:19:55 -0400
Received: from esa4.hc1455-7.c3s2.iphmx.com (esa4.hc1455-7.c3s2.iphmx.com [68.232.139.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02DBEC
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 19:19:53 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="118879845"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="118879845"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa4.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 11:19:51 +0900
Received: from oym-m4.gw.nic.fujitsu.com (oym-nat-oym-m4.gw.nic.fujitsu.com [192.168.87.61])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id EA594CD7E2
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:19:47 +0900 (JST)
Received: from kws-ab4.gw.nic.fujitsu.com (kws-ab4.gw.nic.fujitsu.com [192.51.206.22])
        by oym-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id 2F661D4C33
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:19:47 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab4.gw.nic.fujitsu.com (Postfix) with ESMTP id 84D0E68957;
        Wed, 31 May 2023 11:19:46 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, dave.jiang@intel.com,
        alison.schofield@intel.com, Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v3 4/6] cxl/monitor: always log started message
Date:   Wed, 31 May 2023 10:19:34 +0800
Message-Id: <20230531021936.7366-5-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230531021936.7366-1-lizhijian@fujitsu.com>
References: <20230531021936.7366-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.004
X-TMASE-Result: 10--12.232700-10.000000
X-TMASE-MatchedRID: fqEte1jlzl/mh3qTH3T2BBlxrtI3TxRkTfK5j0EZbyt9hFikHEFf1nER
        bS7OZpEDwKkZaLNGSWov47gJfywVWSfB+/OOFhyOTuctSpiuWyUUi4Ehat05499RlPzeVuQQE0o
        8W+GU3zDOG+e9aAIpHqepbdVIZ/l3HxPMjOKY7A/+HHE8LDNSg8RB0bsfrpPIfiAqrjYtFiRAzV
        rWwNWPwOq11iEZvCJi7mcbYkc9NgBKL3Fna1bs1X7cGd19dSFd
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Tell people monitor is starting rather only daemon mode will log this
message before. It's a minor fix so that whatever stdout or logfile
is specified, people can see a *normal* message.

After this patch
 # cxl monitor
 cxl monitor started.
 ^C
 # cxl monitor -l standard.log
 ^C
 # cat standard.log
 [1684735993.704815571] [818499] cxl monitor started.
 # cxl monitor --daemon -l /var/log/daemon.log
 # cat /var/log/daemon.log
 [1684736075.817150494] [818509] cxl monitor started.

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: commit log updated # Dave
---
 cxl/monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/cxl/monitor.c b/cxl/monitor.c
index 179646562187..0736483cc50a 100644
--- a/cxl/monitor.c
+++ b/cxl/monitor.c
@@ -205,8 +205,8 @@ int cmd_monitor(int argc, const char **argv, struct cxl_ctx *ctx)
 			err(&monitor, "daemon start failed\n");
 			goto out;
 		}
-		info(&monitor, "cxl monitor daemon started.\n");
 	}
+	info(&monitor, "cxl monitor started.\n");
 
 	rc = monitor_event(ctx);
 
-- 
2.29.2

