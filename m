Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86016C83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 13:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239721AbjIDNaQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237498AbjIDNaP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 09:30:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571A5EB
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 06:30:11 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfTxJ1vs1z6D957;
        Mon,  4 Sep 2023 21:28:52 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 14:30:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 4/4] docs/cxl: Change to lowercase as others
Date:   Mon, 4 Sep 2023 14:28:06 +0100
Message-ID: <20230904132806.6094-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Using the same style as elsewhere for topology / topo

Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Link: https://lore.kernel.org/r/20230519085802.2106900-2-lizhijian@cn.fujitsu.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 docs/system/devices/cxl.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index f12011e230..b742120657 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -157,7 +157,7 @@ responsible for allocating appropriate ranges from within the CFMWs
 and exposing those via normal memory configurations as would be done
 for system RAM.
 
-Example system Topology. x marks the match in each decoder level::
+Example system topology. x marks the match in each decoder level::
 
   |<------------------SYSTEM PHYSICAL ADDRESS MAP (1)----------------->|
   |    __________   __________________________________   __________    |
@@ -187,8 +187,8 @@ Example system Topology. x marks the match in each decoder level::
        ___________|___   __________|__   __|_________   ___|_________
    (3)|  Root Port 0  | | Root Port 1 | | Root Port 2| | Root Port 3 |
       |  Appears in   | | Appears in  | | Appears in | | Appear in   |
-      |  PCI topology | | PCI Topology| | PCI Topo   | | PCI Topo    |
-      |  As 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
+      |  PCI topology | | PCI topology| | PCI topo   | | PCI topo    |
+      |  as 0c:00.0   | | as 0c:01.0  | | as de:00.0 | | as de:01.0  |
       |_______________| |_____________| |____________| |_____________|
             |                  |               |              |
             |                  |               |              |
@@ -272,7 +272,7 @@ Example topology involving a switch::
       |  Root Port 0  |
       |  Appears in   |
       |  PCI topology |
-      |  As 0c:00.0   |
+      |  as 0c:00.0   |
       |___________x___|
                   |
                   |
-- 
2.39.2

