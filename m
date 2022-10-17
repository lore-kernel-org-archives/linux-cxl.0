Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C03B7C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Oct 2022 16:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbiJQQs2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Oct 2022 12:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiJQQs1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Oct 2022 12:48:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950103AB26
        for <linux-cxl@vger.kernel.org>; Mon, 17 Oct 2022 09:48:25 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Mrjb00SC0z682wj;
        Tue, 18 Oct 2022 00:47:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 18:48:23 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 17 Oct 2022 17:48:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>
CC:     <linux-cxl@vger.kernel.org>, Michael Tsirkin <mst@redhat.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>, <linuxarm@huawei.com>
Subject: [RFC PATCH v2] hw/cxl: Initial emulated CXL poison injection support
Date:   Mon, 17 Oct 2022 17:48:25 +0100
Message-ID: <20221017164825.9596-1-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
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

Inject poison using qmp command cxl-inject-poison to
add an entry to the poison list.

For now, the poison is not returned CXL.mem reads, but only via
the mailbox command Get Poison List.

See CXL rev 3.0, sec 8.2.9.8.4.1 Get Poison list (Opcode 4300h)

Kernel patches to use this interface here:
https://lore.kernel.org/linux-cxl/cover.1665606782.git.alison.schofield@intel.com/

RFC for now as likely the implementation will change as
support for mailbox based poison injection and media scanning are added.

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

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v2:
Moved to QMP to allow for single command.
Update reference in coverletter

Part of purpose for sending this out at this point is to illustrate how
simple it would be to added per event injection support to Ira's patch
set on CXL event injection.

Slightly odd base for now as the tree is a state of flux.

Replace the existing poison injection patch on tree
at gitlab.com/jic23/qemu/ cxl-2022-10-14

I'll post a new version of that tree shortly with today's date.

---
 hw/cxl/cxl-mailbox-utils.c  | 85 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 34 +++++++++++++++
 hw/mem/cxl_type3_stubs.c    |  6 +++
 hw/mem/meson.build          |  2 +
 include/hw/cxl/cxl_device.h | 13 ++++++
 qapi/cxl.json               | 17 ++++++++
 qapi/meson.build            |  1 +
 qapi/qapi-schema.json       |  1 +
 8 files changed, 159 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index bc1bb18844..c7e1a88b44 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -59,6 +59,8 @@ enum {
         #define GET_PARTITION_INFO     0x0
         #define GET_LSA       0x2
         #define SET_LSA       0x3
+    MEDIA_AND_POISON = 0x43,
+        #define GET_POISON_LIST        0x0
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -296,6 +298,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     id->total_capacity = size / (256 << 20);
     id->persistent_capacity = size / (256 << 20);
     id->lsa_size = cvc->get_lsa_size(ct3d);
+    id->poison_list_max_mer[1] = 0x1; /* 256 poison records */
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
@@ -382,6 +385,86 @@ static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * This is very inefficient, but good enough for now!
+ * Also thed payload will always fit, so no need to handle the MORE flag and
+ * make this stateful.
+ */
+static ret_code cmd_media_get_poison_list(struct cxl_cmd *cmd,
+                                          CXLDeviceState *cxl_dstate,
+                                          uint16_t *len)
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
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    uint16_t record_count = 0, i = 0;
+    uint64_t query_start = in->pa;
+    uint64_t query_length = in->length;
+    CXLPoisonList *poison_list;
+    CXLPoison *ent;
+    uint16_t out_pl_len;
+
+    poison_list = cvc->get_poison_list(ct3d);
+
+    QLIST_FOREACH(ent, poison_list, node) {
+        /* Check for no overlap */
+        if (ent->start >= query_start + query_length ||
+            ent->start + ent->length <= query_start) {
+            continue;
+        }
+        if (record_count == 256) {
+            /* For now just return 256 max */
+            break;
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
+        if (i == 256) {
+            break;
+        }
+        /* Deal with overlap */
+        start = MAX(ent->start & 0xffffffffffffffc0, query_start);
+        stop = MIN((ent->start & 0xffffffffffffffc0) + ent->length,
+                   query_start + query_length);
+        out->records[i].addr = start | 0x2; /* internal error */
+        out->records[i].length = (stop - start) / 64;
+        i++;
+    }
+    out->count = record_count;
+    *len = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -409,6 +492,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
     [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
         ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
+    [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
+        cmd_media_get_poison_list, 16, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 37a54b0257..c13a1eab73 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1,6 +1,7 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
+#include "qapi/qapi-commands-cxl.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/pci/pci.h"
@@ -730,6 +731,37 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
      */
 }
 
+static CXLPoisonList *get_poison_list(CXLType3Dev *ct3d)
+{
+    /* This will get more complex  - for now it's a bit pointless */
+    return &ct3d->poison_list;
+}
+
+void qmp_cxl_inject_poison(const char *path, uint64_t start, uint64_t length,
+                           Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLType3Dev *ct3d;
+    CXLPoison *p;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path does not point to a CXL type 3 device");
+    }
+    ct3d = CXL_TYPE3(obj);
+    p = g_new0(CXLPoison, 1);
+    if (!p) {
+        return;
+    }
+    p->length = length;
+    p->start = start;
+
+    QLIST_INSERT_HEAD(&ct3d->poison_list, p, node);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
@@ -754,6 +786,8 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     cvc->get_lsa_size = get_lsa_size;
     cvc->get_lsa = get_lsa;
     cvc->set_lsa = set_lsa;
+    cvc->get_poison_list = get_poison_list;
+
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
new file mode 100644
index 0000000000..68ed972527
--- /dev/null
+++ b/hw/mem/cxl_type3_stubs.c
@@ -0,0 +1,6 @@
+
+#include "qemu/osdep.h"
+#include "qapi/qapi-commands-cxl.h"
+
+void qmp_cxl_inject_poison(const char * path, uint64_t start, uint64_t length,
+                           Error **errp) {}
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 609b2b36fc..1bb70d9e46 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -8,3 +8,5 @@ mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
 softmmu_ss.add(when: 'CONFIG_SPARSE_MEM', if_true: files('sparse-mem.c'))
+softmmu_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_false: files('cxl_type3_stubs.c'))
+softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('cxl_type3_stubs.c'))	
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cdf1fd4696..c3d62710b1 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -230,6 +230,14 @@ REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+typedef struct CXLPoison {
+    uint64_t start, length;
+    uint8_t type;
+    QLIST_ENTRY(CXLPoison) node;
+} CXLPoison;
+
+typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -249,6 +257,9 @@ struct CXLType3Dev {
     DOECap doe_comp;
     uint16_t spdm_port;
     DOECap doe_spdm;
+
+    /* Poison Injection - cache */
+    CXLPoisonList poison_list;
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
@@ -265,6 +276,8 @@ struct CXLType3Class {
                         uint64_t offset);
     void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
                     uint64_t offset);
+
+    CXLPoisonList* (*get_poison_list)(CXLType3Dev *ct3d);
 };
 
 MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
diff --git a/qapi/cxl.json b/qapi/cxl.json
new file mode 100644
index 0000000000..ff38f3f2ba
--- /dev/null
+++ b/qapi/cxl.json
@@ -0,0 +1,17 @@
+# -*- Mode: Python -*-
+# vim: filetype=python
+
+##
+# = CXL devices
+##
+
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
diff --git a/qapi/meson.build b/qapi/meson.build
index 9a36c15c04..f073bbdc5e 100644
--- a/qapi/meson.build
+++ b/qapi/meson.build
@@ -31,6 +31,7 @@ qapi_all_modules = [
   'compat',
   'control',
   'crypto',
+  'cxl',
   'dump',
   'error',
   'introspect',
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index f000b90744..079f2a402a 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -95,3 +95,4 @@
 { 'include': 'pci.json' }
 { 'include': 'stats.json' }
 { 'include': 'virtio.json' }
+{ 'include': 'cxl.json' }
-- 
2.37.2

