Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E06E0C77B73
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 02:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjEaCY6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEaCY4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 22:24:56 -0400
Received: from esa7.hc1455-7.c3s2.iphmx.com (esa7.hc1455-7.c3s2.iphmx.com [139.138.61.252])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6008811D
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 19:24:54 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="97629897"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="97629897"
Received: from unknown (HELO oym-r1.gw.nic.fujitsu.com) ([210.162.30.89])
  by esa7.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 11:24:51 +0900
Received: from oym-m1.gw.nic.fujitsu.com (oym-nat-oym-m1.gw.nic.fujitsu.com [192.168.87.58])
        by oym-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id A0509D29EA
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:24:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id D238CD5014
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:24:48 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 47DC12007CA97;
        Wed, 31 May 2023 11:24:48 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, dave.jiang@intel.com,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2 2/2] README.md: document CXL unit tests
Date:   Wed, 31 May 2023 10:24:14 +0800
Message-Id: <20230531022414.7604-2-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230531022414.7604-1-lizhijian@fujitsu.com>
References: <20230531022414.7604-1-lizhijian@fujitsu.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.004
X-TMASE-Result: 10--6.086700-10.000000
X-TMASE-MatchedRID: 9ruk7ESG09bRTAZ5iUYfyaqHmm/V4M/Pe7Z0UyQO5TPAuQ0xDMaXkH4q
        tYI9sRE/T1fsjZmF+qy4Dzk272eIPLhPu4tF1R7B/sUSFaCjTLz0swHSFcVJ6MgVyTd/p+/IB82
        GyGpZHXsR1Wjctg+PdYAy6p60ZV62yA7duzCw6dLdB/CxWTRRu/558CedkGIvqcoAhihTwvjy9H
        anYSITr4ePUgtHdQGaNEff0CGCMGfOXGmKP0nW9wgOZpnHHSxQ
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

It requires some CLX specific kconfigs and testing purpose module

Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: Add separate CXL unit test entry # Dave
---
 README.md | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/README.md b/README.md
index 7c7cf0dd065d..4874430a023b 100644
--- a/README.md
+++ b/README.md
@@ -82,6 +82,32 @@ loaded.  To build and install nfit_test.ko:
    sudo make modules_install
    ```
 
+1. CXL test
+
+   The unit tests will also run CXL test by default. In order to make the
+   CXL test work smoothly, we need to install the cxl_test.ko as well.
+
+   Obtain the CXL kernel source(optional).  For example,
+   `git clone -b pending git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git`
+
+   Enable CXL specific kernel configurations
+   ```
+   CONFIG_CXL_BUS=m
+   CONFIG_CXL_PCI=m
+   CONFIG_CXL_ACPI=m
+   CONFIG_CXL_PMEM=m
+   CONFIG_CXL_MEM=m
+   CONFIG_CXL_PORT=m
+   CONFIG_CXL_REGION=y
+   CONFIG_CXL_REGION_INVALIDATION_TEST=y
+   CONFIG_DEV_DAX_CXL=m
+   ```
+   Install cxl_test.ko
+   ```
+   make M=tools/testing/cxl
+   sudo make M=tools/testing/cxl modules_install
+   sudo make modules_install
+   ```
 1. Now run `meson test -C build` in the ndctl source directory, or `ndctl test`,
    if ndctl was built with `-Dtest=enabled` as a configuration option to meson.
 
-- 
2.29.2

