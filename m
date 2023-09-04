Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 129D8C83F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Sep 2023 13:28:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbjIDN2o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Sep 2023 09:28:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjIDN2n (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Sep 2023 09:28:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D6D19B
        for <linux-cxl@vger.kernel.org>; Mon,  4 Sep 2023 06:28:40 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RfTqv6skKz67l04;
        Mon,  4 Sep 2023 21:24:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 4 Sep 2023 14:28:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>
CC:     Li Zhijian <lizhijian@cn.fujitsu.com>,
        Dave Jiang <dave.jiang@intel.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        <linuxarm@huawei.com>
Subject: [PATCH 1/4] hw/cxl: Fix CFMW config memory leak
Date:   Mon, 4 Sep 2023 14:28:03 +0100
Message-ID: <20230904132806.6094-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
References: <20230904132806.6094-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Li Zhijian <lizhijian@cn.fujitsu.com>

Allocate targets and targets[n] resources when all sanity checks are
passed to avoid memory leaks.

Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 034c7805b3..f0920da956 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -39,12 +39,6 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         return;
     }
 
-    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
-    for (i = 0, target = object->targets; target; i++, target = target->next) {
-        /* This link cannot be resolved yet, so stash the name for now */
-        fw->targets[i] = g_strdup(target->value);
-    }
-
     if (object->size % (256 * MiB)) {
         error_setg(errp,
                    "Size of a CXL fixed memory window must be a multiple of 256MiB");
@@ -64,6 +58,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
         fw->enc_int_gran = 0;
     }
 
+    fw->targets = g_malloc0_n(fw->num_targets, sizeof(*fw->targets));
+    for (i = 0, target = object->targets; target; i++, target = target->next) {
+        /* This link cannot be resolved yet, so stash the name for now */
+        fw->targets[i] = g_strdup(target->value);
+    }
+
     cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows,
                                              g_steal_pointer(&fw));
 
-- 
2.39.2

