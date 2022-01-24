Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A69C433F5
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:30:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244620AbiAXRa4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:30:56 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4472 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244618AbiAXRaz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:30:55 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH335j5Qz67ws7;
        Tue, 25 Jan 2022 01:26:39 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:30:53 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:30:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 27/42] hw/cxl/device: Implement get/set Label Storage Area (LSA)
Date:   Mon, 24 Jan 2022 17:16:50 +0000
Message-ID: <20220124171705.10432-28-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

Implement get and set handlers for the Label Storage Area
used to hold data describing persistent memory configuration
so that it can be ensured it is seen in the same configuration
after reboot.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 54 +++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 56 ++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |  5 ++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4009152b7e..0df2a8492a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -55,6 +55,8 @@ enum {
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
         #define GET_PARTITION_INFO     0x0
+        #define GET_LSA       0x2
+        #define SET_LSA       0x3
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -136,8 +138,11 @@ declare_mailbox_handler(LOGS_GET_SUPPORTED);
 declare_mailbox_handler(LOGS_GET_LOG);
 declare_mailbox_handler(IDENTIFY_MEMORY_DEVICE);
 declare_mailbox_handler(CCLS_GET_PARTITION_INFO);
+declare_mailbox_handler(CCLS_GET_LSA);
+declare_mailbox_handler(CCLS_SET_LSA);
 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
+#define IMMEDIATE_DATA_CHANGE (1 << 1)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
 
@@ -156,6 +161,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     CXL_CMD(LOGS, GET_LOG, 0x18, 0),
     CXL_CMD(IDENTIFY, MEMORY_DEVICE, 0, 0),
     CXL_CMD(CCLS, GET_PARTITION_INFO, 0, 0),
+    CXL_CMD(CCLS, GET_LSA, 0, 0),
+    CXL_CMD(CCLS, SET_LSA, ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE),
 };
 
 #undef CXL_CMD
@@ -368,6 +375,53 @@ define_mailbox_handler(CCLS_GET_PARTITION_INFO)
     return CXL_MBOX_SUCCESS;
 }
 
+define_mailbox_handler(CCLS_GET_LSA)
+{
+    struct {
+        uint32_t offset;
+        uint32_t length;
+    } __attribute__((packed, __aligned__(8))) *get_lsa;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
+    uint32_t offset, length;
+
+    get_lsa = (void *)cmd->payload;
+    offset = get_lsa->offset;
+    length = get_lsa->length;
+
+    *len = 0;
+    if (offset + length > cvc->get_lsa_size(ct3d)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    *len = cvc->get_lsa(ct3d, get_lsa, length, offset);
+    return CXL_MBOX_SUCCESS;
+}
+
+define_mailbox_handler(CCLS_SET_LSA)
+{
+    struct {
+        uint32_t offset;
+        uint32_t rsvd;
+    } __attribute__((packed, __aligned__(8))) *set_lsa = (void *)cmd->payload;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
+    uint16_t plen = *len;
+
+    *len = 0;
+    if (!plen) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    if (set_lsa->offset + plen > cvc->get_lsa_size(ct3d) + sizeof(*set_lsa)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    cvc->set_lsa(ct3d, (void *)set_lsa + sizeof(*set_lsa),
+                 plen - sizeof(*set_lsa), set_lsa->offset);
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4835524f89..e99d84c92d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -8,6 +8,7 @@
 #include "qapi/error.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "qemu/pmem.h"
 #include "qemu/range.h"
 #include "qemu/rcu.h"
 #include "sysemu/hostmem.h"
@@ -114,6 +115,11 @@ static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
     memory_region_set_enabled(mr, true);
     host_memory_backend_set_mapped(ct3d->hostmem, true);
     ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
+
+    if (!ct3d->lsa) {
+        error_setg(errp, "lsa property must be set");
+        return;
+    }
 }
 
 
@@ -168,12 +174,58 @@ static Property ct3_props[] = {
     DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
     DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
+    DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
 static uint64_t get_lsa_size(CXLType3Dev *ct3d)
 {
-    return 0;
+    MemoryRegion *mr;
+
+    mr = host_memory_backend_get_memory(ct3d->lsa);
+    return memory_region_size(mr);
+}
+
+static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
+                                uint64_t offset)
+{
+    assert(offset + size <= memory_region_size(mr));
+    assert(offset + size > offset);
+}
+
+static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
+                    uint64_t offset)
+{
+    MemoryRegion *mr;
+    void *lsa;
+
+    mr = host_memory_backend_get_memory(ct3d->lsa);
+    validate_lsa_access(mr, size, offset);
+
+    lsa = memory_region_get_ram_ptr(mr) + offset;
+    memcpy(buf, lsa, size);
+
+    return size;
+}
+
+static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
+                    uint64_t offset)
+{
+    MemoryRegion *mr;
+    void *lsa;
+
+    mr = host_memory_backend_get_memory(ct3d->lsa);
+    validate_lsa_access(mr, size, offset);
+
+    lsa = memory_region_get_ram_ptr(mr) + offset;
+    memcpy(lsa, buf, size);
+    memory_region_set_dirty(mr, offset, size);
+
+    /*
+     * Just like the PMEM, if the guest is not allowed to exit gracefully, label
+     * updates will get lost.
+     */
 }
 
 static void ct3_class_init(ObjectClass *oc, void *data)
@@ -194,6 +246,8 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     device_class_set_props(dc, ct3_props);
 
     cvc->get_lsa_size = get_lsa_size;
+    cvc->get_lsa = get_lsa;
+    cvc->set_lsa = set_lsa;
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index effbfa106a..0426714e9b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -251,6 +251,11 @@ struct CXLType3Class {
 
     /* public */
     uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
+
+    uint64_t (*get_lsa)(CXLType3Dev *ct3d, void *buf, uint64_t size,
+                        uint64_t offset);
+    void (*set_lsa)(CXLType3Dev *ct3d, const void *buf, uint64_t size,
+                    uint64_t offset);
 };
 
 #endif
-- 
2.32.0

