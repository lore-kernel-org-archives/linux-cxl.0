Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DF2C64EC4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 15:12:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjCCPMR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 10:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjCCPMR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 10:12:17 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41BE45FEA0
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 07:12:15 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSrx44FzBz67PMg;
        Fri,  3 Mar 2023 23:09:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Fri, 3 Mar 2023 15:12:12 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v4 6/6] hw/cxl: Add clear poison mailbox command support.
Date:   Fri, 3 Mar 2023 15:09:08 +0000
Message-ID: <20230303150908.27889-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
References: <20230303150908.27889-1-Jonathan.Cameron@huawei.com>
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

Current implementation is very simple so many of the corner
cases do not exist (e.g. fragmenting larger poison list entries)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v4:
- Fix off by one on check of edge of vmr (cut and paste from similar
  but long fixed in the volatile memory series)
- Drop unnecessary overflow check.
- Ensure that even in case of overflow we still delete the element
  replaced (in the hole punching case)
---
 hw/cxl/cxl-mailbox-utils.c  | 77 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 36 +++++++++++++++++
 include/hw/cxl/cxl_device.h |  1 +
 3 files changed, 114 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 64a3f3c1bf..0b30307fa3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -65,6 +65,7 @@ enum {
     MEDIA_AND_POISON = 0x43,
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
+        #define CLEAR_POISON           0x2
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -511,6 +512,80 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len)
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
+    if (dpa + 64 > cxl_dstate->mem_size) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    /* Always exit loop on entry removal so no need for safe variant */
+    QLIST_FOREACH(ent, poison_list, node) {
+        /*
+         * Test for contained in entry. Simpler than general case
+         * as clearing 64 bytes and entries 64 byte aligned
+         */
+        if ((dpa < ent->start) || (dpa >= ent->start + ent->length)) {
+            continue;
+        }
+        /* Do accounting early as we know one will go away */
+        ct3d->poison_list_cnt--;
+        if (dpa > ent->start) {
+            CXLPoison *frag;
+            /* Cannot overflow as replacing existing entry */
+
+            frag = g_new0(CXLPoison, 1);
+
+            frag->start = ent->start;
+            frag->length = dpa - ent->start;
+            frag->type = ent->type;
+
+            QLIST_INSERT_HEAD(poison_list, frag, node);
+            ct3d->poison_list_cnt++;
+        }
+        if (dpa + 64 < ent->start + ent->length) {
+            CXLPoison *frag;
+
+            if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+                cxl_set_poison_list_overflowed(ct3d);
+            } else {
+                frag = g_new0(CXLPoison, 1);
+
+                frag->start = dpa + 64;
+                frag->length = ent->start + ent->length - frag->start;
+                frag->type = ent->type;
+                QLIST_INSERT_HEAD(poison_list, frag, node);
+                ct3d->poison_list_cnt++;
+            }
+        }
+        /* Any fragments have been added, free original entry */
+        QLIST_REMOVE(ent, node);
+        g_free(ent);
+        break;
+    }
+    /* Clearing a region with no poison is not an error so always do so */
+    if (cvc->set_cacheline)
+        if (!cvc->set_cacheline(ct3d, dpa, in->data)) {
+            return CXL_MBOX_INTERNAL_ERROR;
+        }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -542,6 +617,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_get_poison_list, 16, 0 },
     [MEDIA_AND_POISON][INJECT_POISON] = { "MEDIA_AND_POISON_INJECT_POISON",
         cmd_media_inject_poison, 8, 0 },
+    [MEDIA_AND_POISON][CLEAR_POISON] = { "MEDIA_AND_POISON_CLEAR_POISON",
+        cmd_media_clear_poison, 72, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 21e3a84785..0d9de0ee03 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -919,6 +919,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
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
+    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
+        return false;
+    }
+
+    if (vmr) {
+        if (dpa_offset < int128_get64(vmr->size)) {
+            as = &ct3d->hostvmem_as;
+        } else {
+            as = &ct3d->hostpmem_as;
+            dpa_offset -= vmr->size;
+        }
+    } else {
+        as = &ct3d->hostpmem_as;
+    }
+
+    address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64);
+    return true;
+}
+
 void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
 {
         ct3d->poison_list_overflowed = true;
@@ -1140,6 +1175,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
+    cvc->set_cacheline = set_cacheline;
 }
 
 static const TypeInfo ct3d_info = {
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
-- 
2.37.2

