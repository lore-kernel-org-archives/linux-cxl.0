Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD082C001DB
	for <linux-cxl@archiver.kernel.org>; Thu, 10 Aug 2023 05:41:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbjHJFlM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 10 Aug 2023 01:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjHJFlL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 10 Aug 2023 01:41:11 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 22:41:10 PDT
Received: from esa2.hc1455-7.c3s2.iphmx.com (esa2.hc1455-7.c3s2.iphmx.com [207.54.90.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CC6BF3
        for <linux-cxl@vger.kernel.org>; Wed,  9 Aug 2023 22:41:10 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="127799046"
X-IronPort-AV: E=Sophos;i="6.01,161,1684767600"; 
   d="scan'208";a="127799046"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
  by esa2.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 14:40:05 +0900
Received: from yto-m4.gw.nic.fujitsu.com (yto-nat-yto-m4.gw.nic.fujitsu.com [192.168.83.67])
        by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id BF76BDB3C3
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 14:40:02 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by yto-m4.gw.nic.fujitsu.com (Postfix) with ESMTP id E8C5ED3F22
        for <linux-cxl@vger.kernel.org>; Thu, 10 Aug 2023 14:40:01 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.54])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 5AE29200649E0;
        Thu, 10 Aug 2023 14:40:01 +0900 (JST)
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     vishal.l.verma@intel.com, nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, Xiao Yang <yangx.jy@fujitsu.com>
Subject: [NDCTL PATCH 1/2] daxctl: Don't check param.no_movable when param.no_online is set
Date:   Thu, 10 Aug 2023 13:39:57 +0800
Message-Id: <20230810053958.14992-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27804.005
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27804.005
X-TMASE-Result: 10--5.252800-10.000000
X-TMASE-MatchedRID: T/UKjKdt5dO1Hdke1yr59x1kSRHxj+Z5TFQnI+epPIbAuQ0xDMaXkH4q
        tYI9sRE/7wJL2+8U4LEQMsrEt9MpLGfwTtWE8r6mh5kaQXRvR9dAApRfVHzqNJsoi2XrUn/J8m+
        hzBStansUGm4zriL0oQtuKBGekqUpI/NGWt0UYPAib5v3wiVe9VdYGfzWX7ubeHFxVLR7sXq8HT
        8Ap0Ak7Ed5hikrcf0r
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

param.no_movable is used to online memory in ZONE_NORMAL but
param.no_online is used to not online memory. So it's unnecessary
to check param.no_movable when param.no_online is set.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 daxctl/device.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/daxctl/device.c b/daxctl/device.c
index 360ae8b..ba31eb6 100644
--- a/daxctl/device.c
+++ b/daxctl/device.c
@@ -711,7 +711,7 @@ static int reconfig_mode_system_ram(struct daxctl_dev *dev)
 	const char *devname = daxctl_dev_get_devname(dev);
 	int rc, skip_enable = 0;
 
-	if (param.no_online || !param.no_movable) {
+	if (param.no_online) {
 		if (!param.force && daxctl_dev_will_auto_online_memory(dev)) {
 			fprintf(stderr,
 				"%s: error: kernel policy will auto-online memory, aborting\n",
-- 
2.40.1

