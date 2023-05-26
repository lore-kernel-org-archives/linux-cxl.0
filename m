Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F939C7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 17:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjEZRCQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 13:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjEZRCP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 13:02:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E579BC
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 10:02:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWLd5GCJz6J74w;
        Sat, 27 May 2023 00:57:29 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 18:02:12 +0100
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
Subject: [PATCH v8 4/4] hw/cxl: Add clear poison mailbox command support.
Date:   Fri, 26 May 2023 18:00:10 +0100
Message-ID: <20230526170010.574-5-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
References: <20230526170010.574-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Current implementation is very simple so many of the corner
cases do not exist (e.g. fragmenting larger poison list entries)

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 37 +++++++++++++++++
 3 files changed, 120 insertions(+)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 32c234ea91..73328a52cf 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -298,6 +298,7 @@ struct CXLType3Class {
                         uint64_t offset);
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
+    bool (*set_cacheline)(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data);
 };
 
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6c476ad7f4..e3401b6be8 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -65,6 +65,7 @@ enum {
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
+        #define CLEAR_POISON           0x2
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -512,6 +513,85 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len_unused)
+{
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    struct clear_poison_pl {
+        uint64_t dpa;
+        uint8_t data[64];
+    };
+    CXLPoison *ent;
+    uint64_t dpa;
+
+    struct clear_poison_pl *in = (void *)cmd->payload;
+
+    dpa = ldq_le_p(&in->dpa);
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /* Clearing a region with no poison is not an error so always do so */
+    if (cvc->set_cacheline) {
+        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+    }
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        /*
+         * Test for contained in entry. Simpler than general case
+         * as clearing 64 bytes and entries 64 byte aligned
+         */
+        if ((dpa >= ent->start) && (dpa < ent->start + ent->length)) {
+            break;
+        }
+    }
+    if (!ent) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    QLIST_REMOVE(ent, node);
+    ct3d->poison_list_cnt--;
+
+    if (dpa > ent->start) {
+        CXLPoison *frag;
+        /* Cannot overflow as replacing existing entry */
+
+        frag = g_new0(CXLPoison, 1);
+
+        frag->start = ent->start;
+        frag->length = dpa - ent->start;
+        frag->type = ent->type;
+
+        QLIST_INSERT_HEAD(poison_list, frag, node);
+        ct3d->poison_list_cnt++;
+    }
+
+    if (dpa + CXL_CACHE_LINE_SIZE < ent->start + ent->length) {
+        CXLPoison *frag;
+
+        if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+            cxl_set_poison_list_overflowed(ct3d);
+        } else {
+            frag = g_new0(CXLPoison, 1);
+
+            frag->start = dpa + CXL_CACHE_LINE_SIZE;
+            frag->length = ent->start + ent->length - frag->start;
+            frag->type = ent->type;
+            QLIST_INSERT_HEAD(poison_list, frag, node);
+            ct3d->poison_list_cnt++;
+        }
+    }
+    /* Any fragments have been added, free original entry */
+    g_free(ent);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -543,6 +623,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
         cmd_media_inject_poison, 8, 0 },
+    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
+        cmd_media_clear_poison, 72, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ab600735eb..d751803188 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -947,6 +947,42 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
      */
 }
 
+static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
+{
+    MemoryRegion *vmr = NULL, *pmr = NULL;
+    AddressSpace *as;
+
+    if (ct3d->hostvmem) {
+        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+    }
+    if (ct3d->hostpmem) {
+        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+    }
+
+    if (!vmr && !pmr) {
+        return false;
+    }
+
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+        return false;
+    }
+
+    if (vmr) {
+        if (dpa_offset < memory_region_size(vmr)) {
+            as = &ct3d->hostvmem_as;
+        } else {
+            as = &ct3d->hostpmem_as;
+            dpa_offset -= memory_region_size(vmr);
+        }
+    } else {
+        as = &ct3d->hostpmem_as;
+    }
+
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
+                        CXL_CACHE_LINE_SIZE);
+    return true;
+}
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
 {
         ct3d->poison_list_overflowed = true;
@@ -1168,6 +1204,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
+    cvc->set_cacheline = set_cacheline;
 }
 
 static const TypeInfo ct3d_info = {
-- 
2.39.2

