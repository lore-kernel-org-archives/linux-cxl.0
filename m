Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D341C0015E
	for <linux-cxl@archiver.kernel.org>; Wed, 19 Jul 2023 16:31:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbjGSQbP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 19 Jul 2023 12:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbjGSQbO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 19 Jul 2023 12:31:14 -0400
Received: from esa9.hc1455-7.c3s2.iphmx.com (esa9.hc1455-7.c3s2.iphmx.com [139.138.36.223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C41BFD
        for <linux-cxl@vger.kernel.org>; Wed, 19 Jul 2023 09:31:13 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10776"; a="113335889"
X-IronPort-AV: E=Sophos;i="6.01,216,1684767600"; 
   d="scan'208";a="113335889"
Received: from unknown (HELO yto-r4.gw.nic.fujitsu.com) ([218.44.52.220])
  by esa9.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2023 01:31:11 +0900
Received: from yto-m2.gw.nic.fujitsu.com (yto-nat-yto-m2.gw.nic.fujitsu.com [192.168.83.65])
        by yto-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 58701D772C
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 01:31:09 +0900 (JST)
Received: from aks-ab2.gw.nic.fujitsu.com (aks-ab2.gw.nic.fujitsu.com [192.51.207.12])
        by yto-m2.gw.nic.fujitsu.com (Postfix) with ESMTP id A2A56D5E96
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 01:31:08 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.215.54])
        by aks-ab2.gw.nic.fujitsu.com (Postfix) with ESMTP id B7D2385A48;
        Thu, 20 Jul 2023 01:31:07 +0900 (JST)
From:   Xiao Yang <yangx.jy@fujitsu.com>
To:     linux-cxl@vger.kernel.org
Cc:     Xiao Yang <yangx.jy@fujitsu.com>
Subject: [PATCH] tools/testing/cxl: Remove unused SZ_512G macro
Date:   Thu, 20 Jul 2023 00:31:03 +0800
Message-Id: <20230719163103.3392-1-yangx.jy@fujitsu.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1408-9.0.0.1002-27762.000
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1408-9.0.1002-27762.000
X-TMASE-Result: 10--5.180300-10.000000
X-TMASE-MatchedRID: yKCfkewtMJMtNVV5XI3AlDZoNXJMbH+nMVx/3ZYby7/AuQ0xDMaXkH4q
        tYI9sRE/L2EYbInFI5vOFmC5kH12Jpe/bF1ays2SngIgpj8eDcBpkajQR5gb3savT21DsLD/UEh
        Wy9W70AEgBwKKRHe+r2rqdYurbf2H/HN/KodQL4IiuMmzUrqt7oZH1R4TGabY18xg7B+OniY=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

SZ_512G macro has become useless since commit b2f3b74e1072
("tools/testing/cxl: Move cxl_test resources to the top of memory")
so remove it directly.

Signed-off-by: Xiao Yang <yangx.jy@fujitsu.com>
---
 tools/testing/cxl/test/cxl.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
index 0e78d8e19895..fb6ab9cef84f 100644
--- a/tools/testing/cxl/test/cxl.c
+++ b/tools/testing/cxl/test/cxl.c
@@ -999,10 +999,6 @@ static void mock_companion(struct acpi_device *adev, struct device *dev)
 #define SZ_64G (SZ_32G * 2)
 #endif
 
-#ifndef SZ_512G
-#define SZ_512G (SZ_64G * 8)
-#endif
-
 static __init int cxl_rch_init(void)
 {
 	int rc, i;
-- 
2.40.1

