Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CB2DC001B0
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Aug 2023 01:16:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjHKBQ3 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 21:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231317AbjHKBQ2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 21:16:28 -0400
Received: from esa10.hc1455-7.c3s2.iphmx.com (esa10.hc1455-7.c3s2.iphmx.com [139.138.36.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BD42D47
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 18:16:27 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="115615497"
X-IronPort-AV: E=Sophos;i="6.01,163,1684767600"; 
   d="scan'208";a="115615497"
Received: from unknown (HELO yto-r2.gw.nic.fujitsu.com) ([218.44.52.218])
  by esa10.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 10:16:25 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r2.gw.nic.fujitsu.com (Postfix) with ESMTP id 8C8BAC68E4
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 10:16:22 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id D1053D3F2F
        for <linux-cxl@vger.kernel.org>; Fri, 11 Aug 2023 10:16:21 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.54])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E2F8E200649E2;
        Fri, 11 Aug 2023 10:16:20 +0900 (JST)
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     vishal.l.verma@intel.com, fan.ni@gmx.us, nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH v2] daxctl: Remove unused memory_zone and mem_zone
Date:   Fri, 11 Aug 2023 09:16:18 +0800
Message-Id: <20230811011618.17290-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27806.003
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27806.003
X-TMASE-Result: 10--2.672500-10.000000
X-TMASE-MatchedRID: xRVQIH6ETKBlJTodqNqEzhFbgtHjUWLywTlc9CcHMZerwqxtE531VIpb
        wG9fIuITDzcc9hL6UiAXWBETjFf6a8MF9KO3qJTAGYJhRh6ssev5UnqVnIHSz6SIGrjDxszFo8W
        MkQWv6iV3LAytsQR4e42j49Ftap9ExlblqLlYqXLyyUWKNF5ySLbvNPCk69ACEWiMUb7t52yZno
        lNeuquWy8EQGKJu2Tn7P6dqhLRTWUG4ciDXFfbboqXdq6k8aGvyY7NiLRL/fsRZbRsQk5MBUB1Q
        Pq9bxnWZkAxAwjIrrMHz/H0kiLyEqGAtHMDjkk9
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The enum memory_zone definition and mem_zone variable
have never been used so remove them.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 daxctl/device.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index d2d206b..8391343 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -55,12 +55,6 @@ static unsigned long flags;
 static struct mapping *maps = NULL;
 static long long nmaps = -1;
 
-enum memory_zone {
-	MEM_ZONE_MOVABLE,
-	MEM_ZONE_NORMAL,
-};
-static enum memory_zone mem_zone = MEM_ZONE_MOVABLE;
-
 enum device_action {
 	ACTION_RECONFIG,
 	ACTION_ONLINE,
@@ -469,8 +463,6 @@ static const char *parse_device_options(int argc, const char **argv,
 				align = __parse_size64(param.align, &units);
 		} else if (strcmp(param.mode, "system-ram") == 0) {
 			reconfig_mode = DAXCTL_DEV_MODE_RAM;
-			if (param.no_movable)
-				mem_zone = MEM_ZONE_NORMAL;
 		} else if (strcmp(param.mode, "devdax") == 0) {
 			reconfig_mode = DAXCTL_DEV_MODE_DEVDAX;
 			if (param.no_online) {
@@ -494,9 +486,6 @@ static const char *parse_device_options(int argc, const char **argv,
 			align = __parse_size64(param.align, &units);
 		/* fall through */
 	case ACTION_ONLINE:
-		if (param.no_movable)
-			mem_zone = MEM_ZONE_NORMAL;
-		/* fall through */
 	case ACTION_DESTROY:
 	case ACTION_OFFLINE:
 	case ACTION_DISABLE:
-- 
2.40.1

