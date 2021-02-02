Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E719EC433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C22A564EE4
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbhBBBCN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:02:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:21901 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhBBBCN (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:13 -0500
IronPort-SDR: I9c8iiJq0J5QYOO39CrckYd5+XswvPGlbFUYuvY+fsPWDGCFaBs9bdFHPyHd68f8bT8EEe5SYJ
 wXFDuoL8Hfew==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294670"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294670"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:23 -0800
IronPort-SDR: K5rtL84rOMlfk3+mYrpCwOa5uyv/QLL33wWhM5EoS8q+XBr6WDnBBL6tm/IqjH58lyNIVy9R8i
 7tqIK7pfGqbQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764287"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:22 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 29/31] hw/cxl/device: Implement get/set LSA
Date:   Mon,  1 Feb 2021 16:59:46 -0800
Message-Id: <20210202005948.241655-30-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 50 +++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          | 56 ++++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |  9 ++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 2637250c7b..c133cf0341 100644
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
@@ -365,6 +372,49 @@ define_mailbox_handler(CCLS_GET_PARTITION_INFO)
     return CXL_MBOX_SUCCESS;
 }
 
+define_mailbox_handler(CCLS_GET_LSA)
+{
+    struct {
+        uint32_t offset;
+        uint32_t length;
+    } __attribute__((packed, __aligned__(16))) *get_lsa;
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
+        void *data;
+    } __attribute__((packed, __aligned__(16))) *set_lsa = (void *)cmd->payload;
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
+    uint16_t plen = *len;
+
+    *len = 0;
+    if ((set_lsa->offset + plen) > cvc->get_lsa_size(ct3d)) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    cvc->set_lsa(ct3d, set_lsa->data, plen, set_lsa->offset);
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 074d1dd41f..d091e645aa 100644
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
@@ -148,6 +149,11 @@ static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         return;
     }
 
+    if (!ct3d->lsa) {
+        error_setg(errp, "lsa property must be set");
+        return;
+    }
+
     /* FIXME: need to check mr is the host bridge's MR */
     mr = host_memory_backend_get_memory(ct3d->hostmem);
 
@@ -267,6 +273,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
     DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
                      HostMemoryBackend *),
+    DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -297,7 +305,51 @@ static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
 
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
@@ -325,6 +377,8 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     mdc->set_addr = cxl_md_set_addr;
 
     cvc->get_lsa_size = get_lsa_size;
+    cvc->get_lsa = get_lsa;
+    cvc->set_lsa = set_lsa;
 }
 
 static const TypeInfo ct3d_info = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a79a0f106c..1869876ef6 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -233,7 +233,11 @@ typedef struct cxl_type3_dev {
     CXLDeviceState cxl_dstate;
 } CXLType3Dev;
 
+#ifndef TYPE_CXL_TYPE3_DEV
+#define TYPE_CXL_TYPE3_DEV "cxl-type3"
+#endif
 #define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
+OBJECT_DECLARE_TYPE(CXLType3Device, CXLType3Class, CXL_TYPE3_DEV)
 
 struct CXLType3Class {
     /* Private */
@@ -241,6 +245,11 @@ struct CXLType3Class {
 
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
2.30.0

