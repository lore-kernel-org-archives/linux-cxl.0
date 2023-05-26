Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFB57C77B73
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 17:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjEZRBR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 13:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236835AbjEZRBQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 13:01:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC1E19A
        for <linux-cxl@vger.kernel.org>; Fri, 26 May 2023 10:01:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QSWKS58dKz6J736;
        Sat, 27 May 2023 00:56:28 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 18:01:11 +0100
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
Subject: [PATCH v8 2/4] hw/cxl: QMP based poison injection support
Date:   Fri, 26 May 2023 18:00:08 +0100
Message-ID: <20230526170010.574-3-Jonathan.Cameron@huawei.com>
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

Inject poison using QMP command cxl-inject-poison to add an entry to the
poison list.

For now, the poison is not returned CXL.mem reads, but only via the
mailbox command Get Poison List. So a normal memory read to an address
that is on the poison list will not yet result in a synchronous exception
(and similar for partial cacheline writes).
That is left for a future patch.

See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)

Kernel patches to use this interface here:
https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/

To inject poison using QMP (telnet to the QMP port)
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

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 qapi/cxl.json               | 21 +++++++++
 include/hw/cxl/cxl.h        |  1 +
 include/hw/cxl/cxl_device.h | 20 +++++++++
 hw/cxl/cxl-mailbox-utils.c  | 90 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 56 +++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  6 +++
 6 files changed, 194 insertions(+)

diff --git a/qapi/cxl.json b/qapi/cxl.json
index b21c9b4c1c..ed1c7eea3a 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -5,6 +5,27 @@
 # = CXL devices
 ##
 
+##
+# @cxl-inject-poison:
+#
+# Poison records indicate that a CXL memory device knows that a
+# particular memory region may be corrupted.  This may be because of
+# locally detected errors (e.g. ECC failure) or poisoned writes
+# received from other components in the system.  This injection
+# mechanism enables testing of the OS handling of poison records which
+# may be queried via the CXL mailbox.
+#
+# @path: CXL type 3 device canonical QOM path
+#
+# @start: Start address; must be 64 byte aligned.
+#
+# @length: Length of poison to inject; must be a multiple of 64 bytes.
+#
+# Since: 8.1
+##
+{ 'command': 'cxl-inject-poison',
+  'data': { 'path': 'str', 'start': 'uint64', 'length': 'size' }}
+
 ##
 # @CxlUncorErrorType:
 #
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index c453983e83..56c9e7676e 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -18,6 +18,7 @@
 #include "cxl_component.h"
 #include "cxl_device.h"
 
+#define CXL_CACHE_LINE_SIZE 64
 #define CXL_COMPONENT_REG_BAR_IDX 0
 #define CXL_DEVICE_REG_BAR_IDX 2
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 02befda0f6..32c234ea91 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -242,6 +242,18 @@ typedef struct CXLError {
 
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
@@ -264,6 +276,12 @@ struct CXLType3Dev {
 
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
@@ -289,4 +307,6 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
 
+void cxl_set_poison_list_overflowed(CXLType3Dev *ct3d);
+
 #endif
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 702e16ca20..1f74b26ea2 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -62,6 +62,8 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    MEDIA_AND_POISON = 0x43,
+        #define GET_POISON_LIST        0x0
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -295,6 +297,10 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
     stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
     stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
+    /* 256 poison records */
+    st24_le_p(id->poison_list_max_mer, 256);
+    /* No limit - so limited by main poison record limit */
+    stw_le_p(&id->inject_poison_limit, 0);
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
@@ -384,6 +390,88 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
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
+    uint64_t query_start, query_length;
+    CXLPoisonList *poison_list = &ct3d->poison_list;
+    CXLPoison *ent;
+    uint16_t out_pl_len;
+
+    query_start = ldq_le_p(&in->pa);
+    /* 64 byte alignemnt required */
+    if (query_start & 0x3f) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    query_length = ldq_le_p(&in->length) * CXL_CACHE_LINE_SIZE;
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
+        start = MAX(ROUND_DOWN(ent->start, 64ull), query_start);
+        stop = MIN(ROUND_DOWN(ent->start, 64ull) + ent->length,
+                   query_start + query_length);
+        stq_le_p(&out->records[i].addr, start | (ent->type & 0x7));
+        stl_le_p(&out->records[i].length, (stop - start) / CXL_CACHE_LINE_SIZE);
+        i++;
+    }
+    if (ct3d->poison_list_overflowed) {
+        out->flags = (1 << 1);
+        stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts);
+    }
+    stw_le_p(&out->count, record_count);
+    *len = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -411,6 +499,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
+        cmd_media_get_poison_list, 16, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2adacbd01b..ab600735eb 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -947,6 +947,62 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
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
index d574c58f9a..fd1166a610 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -3,6 +3,12 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-cxl.h"
 
+void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
+                           Error **errp)
+{
+    error_setg(errp, "CXL Type 3 support is not compiled in");
+}
+
 void qmp_cxl_inject_uncorrectable_errors(const char *path,
                                          CXLUncorErrorRecordList *errors,
                                          Error **errp)
-- 
2.39.2

