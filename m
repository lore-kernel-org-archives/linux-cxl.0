Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1495C433EF
	for <linux-cxl@archiver.kernel.org>; Sun,  6 Mar 2022 17:50:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231596AbiCFRvf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 6 Mar 2022 12:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230335AbiCFRve (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 6 Mar 2022 12:51:34 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F6D03E5DB
        for <linux-cxl@vger.kernel.org>; Sun,  6 Mar 2022 09:50:41 -0800 (PST)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KBTcJ5JVLz67N6g;
        Mon,  7 Mar 2022 01:49:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 18:50:39 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Sun, 6 Mar 2022 17:50:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v7 18/46] hw/cxl/device: Implement MMIO HDM decoding (8.2.5.12)
Date:   Sun, 6 Mar 2022 17:41:09 +0000
Message-ID: <20220306174137.5707-19-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
References: <20220306174137.5707-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

A device's volatile and persistent memory are known Host Defined Memory
(HDM) regions. The mechanism by which the device is programmed to claim
the addresses associated with those regions is through dedicated logic
known as the HDM decoder. In order to allow the OS to properly program
the HDMs, the HDM decoders must be modeled.

There are two ways the HDM decoders can be implemented, the legacy
mechanism is through the PCIe DVSEC programming from CXL 1.1 (8.1.3.8),
and MMIO is found in 8.2.5.12 of the spec. For now, 8.1.3.8 is not
implemented.

Much of CXL device logic is implemented in cxl-utils. The HDM decoder
however is implemented directly by the device implementation.
Whilst the implementation currently does no validity checks on the
encoder set up, future work will add sanity checking specific to
the type of cxl component.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
v7:
* Drop pointless void * cast. (Alex)
* Add assertion but without the suggested >> 2 as unit is bytes here (Alex)

 hw/mem/cxl_type3.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index a8d7cfcc81..16b113d5ed 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -46,6 +46,57 @@ static void build_dvsecs(CXLType3Dev *ct3d)
                                REG_LOC_DVSEC_REVID, dvsec);
 }
 
+static void hdm_decoder_commit(CXLType3Dev *ct3d, int which)
+{
+    ComponentRegisters *cregs = &ct3d->cxl_cstate.crb;
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+
+    assert(which == 0);
+
+    /* TODO: Sanity checks that the decoder is possible */
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMIT, 0);
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, ERR, 0);
+
+    ARRAY_FIELD_DP32(cache_mem, CXL_HDM_DECODER0_CTRL, COMMITTED, 1);
+}
+
+static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
+                           unsigned size)
+{
+    CXLComponentState *cxl_cstate = opaque;
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+    CXLType3Dev *ct3d = container_of(cxl_cstate, CXLType3Dev, cxl_cstate);
+    uint32_t *cache_mem = cregs->cache_mem_registers;
+    bool should_commit = false;
+    int which_hdm = -1;
+
+    assert(size == 4);
+    g_assert(offset <= CXL2_COMPONENT_CM_REGION_SIZE);
+
+    switch (offset) {
+    case A_CXL_HDM_DECODER0_CTRL:
+        should_commit = FIELD_EX32(value, CXL_HDM_DECODER0_CTRL, COMMIT);
+        which_hdm = 0;
+        break;
+    default:
+        break;
+    }
+
+    stl_le_p((uint8_t *)cache_mem + offset, value);
+    if (should_commit) {
+        hdm_decoder_commit(ct3d, which_hdm);
+    }
+}
+
+static void ct3_finalize(Object *obj)
+{
+    CXLType3Dev *ct3d = CT3(obj);
+    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    ComponentRegisters *regs = &cxl_cstate->crb;
+
+    g_free(regs->special_ops);
+}
+
 static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     MemoryRegion *mr;
@@ -86,6 +137,9 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ct3d->cxl_cstate.pdev = pci_dev;
     build_dvsecs(ct3d);
 
+    regs->special_ops = g_new0(MemoryRegionOps, 1);
+    regs->special_ops->write = ct3d_reg_write;
+
     cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
                                       TYPE_CXL_TYPE3_DEV);
 
@@ -138,6 +192,7 @@ static const TypeInfo ct3d_info = {
     .parent = TYPE_PCI_DEVICE,
     .class_init = ct3_class_init,
     .instance_size = sizeof(CXLType3Dev),
+    .instance_finalize = ct3_finalize,
     .interfaces = (InterfaceInfo[]) {
         { INTERFACE_CXL_DEVICE },
         { INTERFACE_PCIE_DEVICE },
-- 
2.32.0

