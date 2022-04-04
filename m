Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04137C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239630AbiDDP0v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:26:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358767AbiDDP0v (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:26:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C01193EA
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:24:54 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDyw41zMz67xsC;
        Mon,  4 Apr 2022 23:22:00 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:24:51 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:24:50 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 20/45] hw/cxl/device: Plumb real Label Storage Area (LSA) sizing
Date:   Mon, 4 Apr 2022 16:14:20 +0100
Message-ID: <20220404151445.10955-21-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
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
 hw/mem/cxl_type3.c          |  9 +++++++++
 include/hw/cxl/cxl_device.h | 11 ++++++++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c8188d7087..492739aef3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -277,6 +277,8 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     } QEMU_PACKED *id;
     QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
 
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint64_t size = cxl_dstate->pmem_size;
 
     if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
@@ -291,6 +293,7 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
 
     id->total_capacity = size / (256 << 20);
     id->persistent_capacity = size / (256 << 20);
+    id->lsa_size = cvc->get_lsa_size(ct3d);
 
     *len = sizeof(*id);
     return CXL_MBOX_SUCCESS;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5c93fbbd9b..14d8b0c503 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -176,10 +176,16 @@ static Property ct3_props[] = {
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
+    CXLType3Class *cvc = CXL_TYPE3_CLASS(oc);
 
     pc->realize = ct3_realize;
     pc->exit = ct3_exit;
@@ -192,11 +198,14 @@ static void ct3_class_init(ObjectClass *oc, void *data)
     dc->desc = "CXL PMEM Device (Type 3)";
     dc->reset = ct3d_reset;
     device_class_set_props(dc, ct3_props);
+
+    cvc->get_lsa_size = get_lsa_size;
 }
 
 static const TypeInfo ct3d_info = {
     .name = TYPE_CXL_TYPE3,
     .parent = TYPE_PCI_DEVICE,
+    .class_size = sizeof(struct CXLType3Class),
     .class_init = ct3_class_init,
     .instance_size = sizeof(CXLType3Dev),
     .interfaces = (InterfaceInfo[]) {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d8da2c7b68..ea2571a69b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -236,6 +236,7 @@ struct CXLType3Dev {
 
     /* Properties */
     HostMemoryBackend *hostmem;
+    HostMemoryBackend *lsa;
 
     /* State */
     CXLComponentState cxl_cstate;
@@ -243,6 +244,14 @@ struct CXLType3Dev {
 };
 
 #define TYPE_CXL_TYPE3 "cxl-type3"
-OBJECT_DECLARE_SIMPLE_TYPE(CXLType3Dev, CXL_TYPE3)
+OBJECT_DECLARE_TYPE(CXLType3Dev, CXLType3Class, CXL_TYPE3)
+
+struct CXLType3Class {
+    /* Private */
+    PCIDeviceClass parent_class;
+
+    /* public */
+    uint64_t (*get_lsa_size)(CXLType3Dev *ct3d);
+};
 
 #endif
-- 
2.32.0

