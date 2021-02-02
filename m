Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 939F7C4332B
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64A9864EDA
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229819AbhBBBCN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:02:13 -0500
Received: from mga06.intel.com ([134.134.136.31]:21898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229825AbhBBBCM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:12 -0500
IronPort-SDR: 85E033X8LsZ/N2r5J1DvUtTELUwmQRjAZPXh7b8lcSfPjiLDTgtYKV1RrNYh8qMjllmw6nwEYa
 cMyCjvLDB3Eg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294668"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294668"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:22 -0800
IronPort-SDR: k0REhMz+lyLKzjTCvQ7dQ6nkrBk5hl9cmIC4smyfGvqNkxh1rni2rHirnyBDBREHQJVHL5eo+/
 C8Y0AfBE7XZQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764279"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:21 -0800
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
Subject: [RFC PATCH v3 28/31] hw/cxl/device: Plumb real LSA sizing
Date:   Mon,  1 Feb 2021 16:59:45 -0800
Message-Id: <20210202005948.241655-29-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This should introduce no change. Subsequent work will make use of this
new class member.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  4 ++++
 hw/mem/cxl_type3.c          | 24 +++++++++---------------
 include/hw/cxl/cxl.h        |  1 -
 include/hw/cxl/cxl_device.h | 24 ++++++++++++++++++++++++
 4 files changed, 37 insertions(+), 16 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index dc8e0eb08e..2637250c7b 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -321,6 +321,9 @@ define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
     } __attribute__((packed)) *id;
     _Static_assert(sizeof(*id) == 0x43, "Bad identify size");
 
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
+
     if (memory_region_size(cxl_dstate->pmem) < (256 << 20)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
@@ -332,6 +335,7 @@ define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
     id->total_capacity = memory_region_size(cxl_dstate->pmem);
     id->persistent_capacity = memory_region_size(cxl_dstate->pmem);
+    id->lsa_size = cvc->get_lsa_size(ct3d);
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index fe02c3b63c..074d1dd41f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -13,21 +13,6 @@
 #include "sysemu/hostmem.h"
 #include "hw/cxl/cxl.h"
 
-typedef struct cxl_type3_dev {
-    /* Private */
-    PCIDevice parent_obj;
-
-    /* Properties */
-    uint64_t size;
-    HostMemoryBackend *hostmem;
-
-    /* State */
-    CXLComponentState cxl_cstate;
-    CXLDeviceState cxl_dstate;
-} CXLType3Dev;
-
-#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
-
 static void build_dvsecs(CXLType3Dev *ct3d)
 {
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
@@ -310,11 +295,17 @@ static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
     info->type = MEMORY_DEVICE_INFO_KIND_CXL;
 }
 
+static uint64_t get_lsa_size(CXLType3Dev *ct3d)
+{
+    return 0;
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
     MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
@@ -332,11 +323,14 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     mdc->fill_device_info = pc_dimm_md_fill_device_info;
     mdc->get_plugged_size = memory_device_get_region_size;
     mdc->set_addr = cxl_md_set_addr;
+
+    cvc->get_lsa_size = get_lsa_size;
 }
 
 static const TypeInfo ct3d_info = {
     .name = TYPE_CXL_TYPE3_DEV,
     .parent = TYPE_PCI_DEVICE,
+    .class_size = sizeof(struct CXLType3Class),
     .class_init = ct3_class_init,
     .instance_size = sizeof(CXLType3Dev),
     .instance_init = ct3_instance_init,
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 809ed7de60..c7ca42930f 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -23,4 +23,3 @@
 #define CXL_WINDOW_MAX 10
 
 #endif
-
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ca5328a581..a79a0f106c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -219,4 +219,28 @@ REG32(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+typedef struct cxl_type3_dev {
+    /* Private */
+    PCIDevice parent_obj;
+
+    /* Properties */
+    uint64_t size;
+    HostMemoryBackend *hostmem;
+    HostMemoryBackend *lsa;
+
+    /* State */
+    CXLComponentState cxl_cstate;
+    CXLDeviceState cxl_dstate;
+} CXLType3Dev;
+
+#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
+
+struct CXLType3Class {
+    /* Private */
+    PCIDeviceClass parent_class;
+
+    /* public */
+    uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
+};
+
 #endif
-- 
2.30.0

