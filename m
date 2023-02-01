Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B9BEC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 10:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbjBAKEy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:04:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbjBAKEw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 05:04:52 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6324ED23
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 02:04:50 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6HV83MGmz6J7f1;
        Wed,  1 Feb 2023 18:00:32 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 10:04:47 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [RFC PATCH v2 2/3] hw/cxl: Add poison injection via the mailbox.
Date:   Wed, 1 Feb 2023 10:03:49 +0000
Message-ID: <20230201100350.23263-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230201100350.23263-1-Jonathan.Cameron@huawei.com>
References: <20230201100350.23263-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cf3cfb10a1..7d3f7bcd3a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -64,6 +64,7 @@ enum {
         #define SET_LSA       0x3
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
+        #define INJECT_POISON          0x1
 };
 
 struct cxl_cmd;
@@ -436,6 +437,43 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
+                                          CXLDeviceState *cxl_dstate,
+                                          uint16_t *len)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent;
+    struct inject_poison_pl {
+        uint64_t dpa;
+    };
+    struct inject_poison_pl *in = (void *)cmd->payload;
+    CXLPoison *p;
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        if (ent->start == in->dpa && ent->length == 64) {
+            return CXL_MBOX_SUCCESS;
+        }
+    }
+
+    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+        return CXL_MBOX_INJECT_POISON_LIMIT;
+    }
+    p = g_new0(CXLPoison, 1);
+
+    p->length = 64;
+    p->start = in->dpa;
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
@@ -465,6 +503,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
         cmd_media_get_poison_list, 16, 0 },
+    [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
+        cmd_media_inject_poison, 8, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
-- 
2.37.2

