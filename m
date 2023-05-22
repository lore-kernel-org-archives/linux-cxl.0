Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C33EC77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 22 May 2023 06:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjEVGzn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 22 May 2023 02:55:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjEVGzN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 22 May 2023 02:55:13 -0400
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55CF21FCB
        for <linux-cxl@vger.kernel.org>; Sun, 21 May 2023 23:53:08 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10717"; a="117471415"
X-IronPort-AV: E=Sophos;i="6.00,183,1681138800"; 
   d="scan'208";a="117471415"
Received: from unknown (HELO oym-r2.gw.nic.fujitsu.com) ([210.162.30.90])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2023 15:52:03 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id ACEA5CD7E8
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:58 +0900 (JST)
Received: from kws-ab1.gw.nic.fujitsu.com (kws-ab1.gw.nic.fujitsu.com [192.51.206.11])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id DC8CFD947D
        for <linux-cxl@vger.kernel.org>; Mon, 22 May 2023 15:51:57 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.226.45])
        by kws-ab1.gw.nic.fujitsu.com (Postfix) with ESMTP id 2031B11456CA;
        Mon, 22 May 2023 15:51:57 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>
Subject: [ndctl PATCH v2 5/6] Documentation/cxl/cxl-monitor.txt: Fix inaccurate description
Date:   Mon, 22 May 2023 14:51:47 +0800
Message-Id: <20230522065148.818977-6-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230522065148.818977-1-lizhijian@fujitsu.com>
References: <20230522065148.818977-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27642.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27642.005
X-TMASE-Result: 10--4.632400-10.000000
X-TMASE-MatchedRID: AuCKiGuH5B4hYREeQEM9SU7nLUqYrlslFIuBIWrdOePfUZT83lbkEI/M
        VY+TBf96aL3qKCUFEDH4O/wkN6cR6ZH0YXYnbGozFEUknJ/kEl5jFT88f69nG/oLR4+zsDTtjoc
        zmuoPCq29LyQ4JDCFvHvtfn+qRSOv/hWfCcPVmFI4RMKVeGL9ywIImSWafD+p41H+5mLWxCEZTW
        qHEry1oU0T3u5Cfou4AEVn2YJISkkVwbf5lERMgI/2RRfVn5u4Tcu6aRtCI3BUKpNI+7y1VHsDE
        gQ63iHZ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

No syslog is supported by cxl-monitor

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: add Reviewed-by tag
---
 Documentation/cxl/cxl-monitor.txt | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/Documentation/cxl/cxl-monitor.txt b/Documentation/cxl/cxl-monitor.txt
index 3fc992e4d4d9..c284099f16c3 100644
--- a/Documentation/cxl/cxl-monitor.txt
+++ b/Documentation/cxl/cxl-monitor.txt
@@ -39,8 +39,7 @@ OPTIONS
 --log=::
 	Send log messages to the specified destination.
 	- "<file>":
-	  Send log messages to specified <file>. When fopen() is not able
-	  to open <file>, log messages will be forwarded to syslog.
+	  Send log messages to specified <file>.
 	- "standard":
 	  Send messages to standard output.
 
-- 
2.29.2

