Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51F6FC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:30:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235779AbiAXRaY (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:30:24 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4471 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235612AbiAXRaY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:30:24 -0500
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH6x2Vvbz67MTk;
        Tue, 25 Jan 2022 01:30:01 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:30:22 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:30:21 +0000
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
Subject: [PATCH v4 26/42] hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
Date:   Mon, 24 Jan 2022 17:16:49 +0000
Message-ID: <20220124171705.10432-27-Jonathan.Cameron@huawei.com>
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

This should introduce no change. Subsequent work will make use of this
new class member.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  3 +++
 hw/mem/cxl_type3.c          | 24 +++++++++---------------
 include/hw/cxl/cxl_device.h | 29 +++++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 15 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index cbda963d8c..4009152b7e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -321,6 +321,8 @@ define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
     } __attribute__((packed)) *id;
     _Static_assert(sizeof(*id) == 0x43, "Bad identify size");
 
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_GET_CLASS(ct3d);
     uint64_t size = cxl_dstate->pmem_size;
 
     if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
@@ -335,6 +337,7 @@ define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
 
     id->total_capacity = size / (256 << 20);
     id->persistent_capacity = size / (256 << 20);
+    id->lsa_size = cvc->get_lsa_size(ct3d);
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 0033b1b28e..4835524f89 100644
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
@@ -186,10 +171,16 @@ static Property ct3_props[] = {
     DEFINE_PROP_END_OF_LIST(),
 };
 
+static uint64_t get_lsa_size(CXLType3Dev *ct3d)
+{
+    return 0;
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
     PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+    CXLType3Class *cvc = CXL_TYPE3_DEV_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
@@ -201,11 +192,14 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     dc->desc = "CXL PMEM Device (Type 3)";
     dc->reset = ct3d_reset;
     device_class_set_props(dc, ct3_props);
+
+    cvc->get_lsa_size = get_lsa_size;
 }
 
 static const TypeInfo ct3d_info = {
     .name = TYPE_CXL_TYPE3_DEV,
     .parent = TYPE_PCI_DEVICE,
+    .class_size = sizeof(struct CXLType3Class),
     .class_init = ct3_class_init,
     .instance_size = sizeof(CXLType3Dev),
     .instance_finalize = ct3_finalize,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 3dde7fb1fb..effbfa106a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -224,4 +224,33 @@ REG32(CXL_MEM_DEV_STS, 0)
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
+#ifndef TYPE_CXL_TYPE3_DEV
+#define TYPE_CXL_TYPE3_DEV "cxl-type3"
+#endif
+
+#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
+OBJECT_DECLARE_TYPE(CXLType3Device, CXLType3Class, CXL_TYPE3_DEV)
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
2.32.0

