Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F3D8C7EE2C
	for <linux-cxl@archiver.kernel.org>; Wed, 31 May 2023 02:24:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230296AbjEaCY6 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 30 May 2023 22:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233964AbjEaCY4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 30 May 2023 22:24:56 -0400
Received: from esa6.hc1455-7.c3s2.iphmx.com (esa6.hc1455-7.c3s2.iphmx.com [68.232.139.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED7B10E
        for <linux-cxl@vger.kernel.org>; Tue, 30 May 2023 19:24:53 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10726"; a="120056771"
X-IronPort-AV: E=Sophos;i="6.00,205,1681138800"; 
   d="scan'208";a="120056771"
Received: from unknown (HELO oym-r4.gw.nic.fujitsu.com) ([210.162.30.92])
  by esa6.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2023 11:24:52 +0900
Received: from oym-m3.gw.nic.fujitsu.com (oym-nat-oym-m3.gw.nic.fujitsu.com [192.168.87.60])
        by oym-r4.gw.nic.fujitsu.com (Postfix) with ESMTP id 4CB91DDC60
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:24:49 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com [192.51.206.21])
        by oym-m3.gw.nic.fujitsu.com (Postfix) with ESMTP id 846F0D947A
        for <linux-cxl@vger.kernel.org>; Wed, 31 May 2023 11:24:48 +0900 (JST)
Received: from localhost.localdomain (unknown [10.167.234.230])
        by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id E9A592007AA82;
        Wed, 31 May 2023 11:24:47 +0900 (JST)
From:   Li Zhijian <lizhijian@fujitsu.com>
To:     nvdimm@lists.linux.dev
Cc:     linux-cxl@vger.kernel.org, dave.jiang@intel.com,
        Li Zhijian <lizhijian@fujitsu.com>
Subject: [ndctl PATCH v2 1/2] CONTRIBUTING.md: document cxl mailing list
Date:   Wed, 31 May 2023 10:24:13 +0800
Message-Id: <20230531022414.7604-1-lizhijian@fujitsu.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-27662.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-27662.004
X-TMASE-Result: 10--7.585600-10.000000
X-TMASE-MatchedRID: E/g93qo2P+FTorztX3wKRKoXHZz/dXlxwTlc9CcHMZerwqxtE531VIPc
        XuILVCbaGBKlWUwuGkazIl9yuO/5TfWzx4I556JguFdP7vaalM1AApRfVHzqNBHfiujuTbedAVU
        qe0H38EqAAna+Q7+KBIfO35fV1SF6buWRvIwrG23lMFX0LZQzce9Bi8r8zoNMmfCW/sLDo1BrqM
        MR8f2KK9hjV/rOEii5gts6uXSYOZ6XBXaJoB9JZxRFJJyf5BJe3QfwsVk0UbtuRXh7bFKB7tmP2
        EOiWBNtkvU19ytASnPtIcbc5zr2DDYIHp9W/7lPsBTJSD2iAW0=
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Any change and question relevant to should also CC to the CXL mailing
list.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
---
V2: add reviewed tag
---
 CONTRIBUTING.md | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/CONTRIBUTING.md b/CONTRIBUTING.md
index 4f4865db9da4..7d1e7f64984f 100644
--- a/CONTRIBUTING.md
+++ b/CONTRIBUTING.md
@@ -5,15 +5,21 @@ Thank you for taking the time to contribute to ndctl.
 The following is a set of guidelines that we adhere to, and request that
 contributors follow.
 
+1. **NOTE**: ndctl utils have extended to support CXL CLI, so any change
+   and question relevant to CXL should also CC to the CXL mailing list
+   **```linux-cxl@vger.kernel.org```**.
+
 1. The libnvdimm (kernel subsystem) and ndctl developers primarily use
    the [nvdimm](https://subspace.kernel.org/lists.linux.dev.html)
    mailing list for everything. It is recommended to send patches to
-   **```nvdimm@lists.linux.dev```**
-   An archive is available on [lore](https://lore.kernel.org/nvdimm/)
+   **```nvdimm@lists.linux.dev```** and CC **```linux-cxl@vger.kernel.org```** if needed.
+   The archives are available on [nvdimm](https://lore.kernel.org/nvdimm/) and
+   [cxl](https://lore.kernel.org/linux-cxl/)
 
 1. Github [issues](https://github.com/pmem/ndctl/issues) are an acceptable
    way to report a problem, but if you just have a question,
-   [email](mailto:nvdimm@lists.linux.dev) the above list.
+   [email](mailto:nvdimm@lists.linux.dev) the above list and CC
+   `linux-cxl@linux-cxl@vger.kernel.org` if needed.
 
 1. We follow the Linux Kernel [Coding Style Guide][cs] as applicable.
 
-- 
2.29.2

