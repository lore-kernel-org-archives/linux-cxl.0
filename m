Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D38B4C77B73
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 17:01:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjEZRBq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 13:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEZRBp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 13:01:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6D35A3
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 10:01:43 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWL31cQQz6J75M;
        Sat, 27 May 2023 00:56:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 18:01:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v8 3/4] hw/cxl: Add poison injection via the mailbox.
Date:   Fri, 26 May 2023 18:00:09 +0100
Message-ID: <20230526170010.574-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Very simple implementation to allow testing of corresponding
kernel code. Note that for now we track each 64 byte section
independently.  Whilst a valid implementation choice, it may
make sense to fuse entries so as to prove out more complex
corners of the kernel code.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 42 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1f74b26ea2..6c476ad7f4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -64,6 +64,7 @@ enum {
         #define SET_LSA       0x3
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
+        #define INJECT_POISON          0x1
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -472,6 +473,45 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
+                                          CXLDeviceState *cxl_dstate,
+                                          uint16_t *len_unused)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent;
+    struct inject_poison_pl {
+        uint64_t dpa;
+    };
+    struct inject_poison_pl *in = (void *)cmd->payload;
+    uint64_t dpa = ldq_le_p(&in->dpa);
+    CXLPoison *p;
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        if (dpa >= ent->start &&
+            dpa + CXL_CACHE_LINE_SIZE <= ent->start + ent->length) {
+            return CXL_MBOX_SUCCESS;
+        }
+    }
+
+    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+        return CXL_MBOX_INJECT_POISON_LIMIT;
+    }
+    p = g_new0(CXLPoison, 1);
+
+    p->length = CXL_CACHE_LINE_SIZE;
+    p->start = dpa;
+    p->type = CXL_POISON_TYPE_INJECTED;
+
+    /*
+     * Possible todo: Merge with existing entry if next to it and if same type
+     */
+    QLIST_INSERT_HEAD(poison_list, p, node);
+    ct3d->poison_list_cnt++;
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -501,6 +541,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
+    [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
+        cmd_media_inject_poison, 8, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
-- 
2.39.2

