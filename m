Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 673EEC05027
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Feb 2023 10:04:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbjBAKEV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Feb 2023 05:04:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjBAKEV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Feb 2023 05:04:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AA4ED23
        for <linux-cxl@vger.kernel.org>; Wed,  1 Feb 2023 02:04:19 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6HVD4Fk7z6J6Dq;
        Wed,  1 Feb 2023 18:00:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.34; Wed, 1 Feb 2023 10:04:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>
CC:     Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>,
        <linuxarm@huawei.com>, Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [RFC PATCH v2 1/3] hw/cxl: QMP based poison injection support
Date:   Wed, 1 Feb 2023 10:03:48 +0000
Message-ID: <20230201100350.23263-2-Jonathan.Cameron@huawei.com>
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

Inject poison using qmp command cxl-inject-poison to add an entry to the
poison list.

For now, the poison is not returned CXL.mem reads, but only via the
mailbox command Get Poison List.

See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)

Kernel patches to use this interface here:
https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/

To inject poison using qmp (telnet to the qmp port)
{ "execute": "qmp_capabilities" }

{ "execute": "cxl-inject-poison",
    "arguments": {
         "path": "/machine/peripheral/cxl-pmem0",
         "start": 2048,
         "length": 256
    }
}

Adjusted to select a device on your machine.

Note that the poison list supported is kept short enough to avoid the
complexity of state machine that is needed to handle the MORE flag.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
Moved to QMP to allow for single command.
Update reference in coverletter
Added specific setting of type for this approach to injection.
Drop the unnecessary ct3d class get_poison_list callback.
Block overlapping regions from being injected
Handle list overflow
Use Ira's utility function to get the timestamps
---
 hw/cxl/cxl-mailbox-utils.c  | 82 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  3 ++
 hw/mem/meson.build          |  2 +
 include/hw/cxl/cxl_device.h | 20 +++++++++
 qapi/cxl.json               | 11 +++++
 6 files changed, 174 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 580366ed2f..cf3cfb10a1 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -62,6 +62,8 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    MEDIA_AND_POISON = 0x43,
+        #define GET_POISON_LIST        0x0
 };
 
 struct cxl_cmd;
@@ -267,6 +269,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
     id->persistent_capacity = cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER;
     id->volatile_capacity = cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER;
     id->lsa_size = cvc->get_lsa_size(ct3d);
+    id->poison_list_max_mer[1] = 0x1; /* 256 poison records */
+    id->inject_poison_limit = 0; /* No limit - so limited by main poison record limit */
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
@@ -356,6 +360,82 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * This is very inefficient, but good enough for now!
+ * Also the payload will always fit, so no need to handle the MORE flag and
+ * make this stateful. We may want to allow longer poison lists to aid
+ * testing that kernel functionality.
+ */
+static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
+                                            CXLDeviceState *cxl_dstate,
+                                            uint16_t *len)
+{
+    struct get_poison_list_pl {
+        uint64_t pa;
+        uint64_t length;
+    } QEMU_PACKED;
+
+    struct get_poison_list_out_pl {
+        uint8_t flags;
+        uint8_t rsvd1;
+        uint64_t overflow_timestamp;
+        uint16_t count;
+        uint8_t rsvd2[0x14];
+        struct {
+            uint64_t addr;
+            uint32_t length;
+            uint32_t resv;
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_poison_list_pl *in = (void *)cmd->payload;
+    struct get_poison_list_out_pl *out = (void *)cmd->payload;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    uint16_t record_count = 0, i = 0;
+    uint64_t query_start = in->pa;
+    uint64_t query_length = in->length;
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent;
+    uint16_t out_pl_len;
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        /* Check for no overlap */
+        if (ent->start >= query_start + query_length ||
+            ent->start + ent->length <= query_start) {
+            continue;
+        }
+        record_count++;
+    }
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    QLIST_FOREACH(ent, poison_list, node) {
+        uint64_t start, stop;
+
+        /* Check for no overlap */
+        if (ent->start >= query_start + query_length ||
+            ent->start + ent->length <= query_start) {
+            continue;
+        }
+
+        /* Deal with overlap */
+        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
+        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
+                   query_start + query_length);
+        out->records[i].addr = start | (ent->type & 0x3);
+        out->records[i].length = (stop - start) / 64;
+        i++;
+    }
+    if (ct3d->poison_list_overflowed) {
+        out->flags = (1 << 1);
+        out->overflow_timestamp = ct3d->poison_list_overflow_ts;
+    }
+    out->count = record_count;
+    *len = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -383,6 +463,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
+        cmd_media_get_poison_list, 16, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index beb931d59a..20f8d8e8aa 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -925,6 +925,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
      */
 }
 
+void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d)
+{
+        ct3d->poison_list_overflowed = true;
+        ct3d->poison_list_overflow_ts =
+            cxl_device_get_timestamp(&ct3d->cxl_dstate);
+}
+
+void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
+                           Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLType3Dev *ct3d;
+    CXLPoison *p;
+
+    if (length % 64) {
+        error_setg(errp, "Poison injection must be in multiples of 64 bytes");
+        return;
+    }
+    if (start % 64) {
+        error_setg(errp, "Poison start address must be 64 byte aligned");
+        return;
+    }
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path does not point to a CXL type 3 device");
+        return;
+    }
+
+    ct3d = CXL_TYPE3(obj);
+
+    QLIST_FOREACH(p, &ct3d->poison_list, node) {
+        if (((start >= p->start) && (start < p->start + p->length)) ||
+            ((start + length > p->start) &&
+             (start + length <= p->start + p->length))) {
+            error_setg(errp, "Overlap with existing poisoned region not supported");
+            return;
+        }
+    }
+
+    if (ct3d->poison_list_cnt == CXL_POISON_LIST_LIMIT) {
+        cxl_set_poison_list_overflowed(ct3d);
+        return;
+    }
+
+    p = g_new0(CXLPoison, 1);
+    p->length = length;
+    p->start = start;
+    p->type = CXL_POISON_TYPE_INTERNAL; /* Different from injected via the mbox */
+
+    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+    ct3d->poison_list_cnt++;
+}
+
 /* For uncorrectable errors include support for multiple header recording */
 void qmp_cxl_inject_uncorrectable_errors(const char *path,
                                          CXLUncorErrorRecordList *errors,
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index b6b51ced54..6055190ca6 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -2,6 +2,9 @@
 #include "qemu/osdep.h"
 #include "qapi/qapi-commands-cxl.h"
 
+void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
+                           Error **errp) {}
+
 void qmp_cxl_inject_uncorrectable_errors(const char *path,
                                          CXLUncorErrorRecordList *errors,
                                          Error **errp) {}
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 56c2618b84..930c67e390 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -10,3 +10,5 @@ softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
 softmmu_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
+softmmu_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 44fea2d649..3cb77fe8a5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -270,6 +270,18 @@ typedef struct CXLError {
 
 typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
 
+typedef struct CXLPoison {
+    uint64_t start, length;
+    uint8_t type;
+#define CXL_POISON_TYPE_EXTERNAL 0x1
+#define CXL_POISON_TYPE_INTERNAL 0x2
+#define CXL_POISON_TYPE_INJECTED 0x3
+    QLIST_ENTRY(CXLPoison) node;
+} CXLPoison;
+
+typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
+#define CXL_POISON_LIST_LIMIT 256
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -292,6 +304,12 @@ struct CXLType3Dev {
 
     /* Error injection */
     CXLErrorList error_list;
+
+    /* Poison Injection - cache */
+    CXLPoisonList poison_list;
+    unsigned int poison_list_cnt;
+    bool poison_list_overflowed;
+    uint64_t poison_list_overflow_ts;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
@@ -317,4 +335,6 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
+void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
+
 #endif
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 3c18556ee8..5b995db255 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -5,6 +5,17 @@
 # = CXL devices
 ##
 
+##
+# @cxl-inject-poison:
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @start: Start address
+# @length: Length of poison to inject
+##
+{ 'command': 'cxl-inject-poison',
+  'data': { 'path': 'str', 'start': 'uint64', 'length': 'uint64' }}
+
 ##
 # @CxlUncorErrorType:
 #
-- 
2.37.2

