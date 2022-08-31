Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4269ECAAD1
	for <linux-cxl@archiver.kernel.org>; Wed, 31 Aug 2022 15:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231768AbiHaPfM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 31 Aug 2022 11:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231804AbiHaPfL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 31 Aug 2022 11:35:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 443B12D1E5
        for <linux-cxl@vger.kernel.org>; Wed, 31 Aug 2022 08:35:08 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MHpBc11Knz67mgD;
        Wed, 31 Aug 2022 23:34:32 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 17:35:06 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 31 Aug 2022 16:35:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC:     Ben Widawsky <bwidawsk@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [RFC PATCH 3/3] hw/cxl: CXL Performance Monitoring Unit (CPMU) Emulation
Date:   Wed, 31 Aug 2022 16:33:36 +0100
Message-ID: <20220831153336.16165-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220831153336.16165-1-Jonathan.Cameron@huawei.com>
References: <20220831153336.16165-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL 3.0 introduces a CXL Performance Monitoring Unit.
Add basic emulation of such units and instantiate 2 in
CXL Type 3 devices.

Limitations:
 - Random selection of supported events.
 - Mixture of fixed purpose and configurable counters is intended
   to hit some edge cases in the discovery code, not to make any
   practical sense.
 - Currently no per CPMU configuration so the two instances are
   currently identical. Not sure it's worth putting a configuration
   interface in place as it would be very complex to use.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-cpmu.c           | 295 ++++++++++++++++++++++++++++++++++++
 hw/cxl/meson.build          |   1 +
 hw/mem/cxl_type3.c          |  15 +-
 include/hw/cxl/cxl.h        |   1 +
 include/hw/cxl/cxl_cpmu.h   |  99 ++++++++++++
 include/hw/cxl/cxl_device.h |  31 +++-
 include/hw/cxl/cxl_pci.h    |   7 +-
 7 files changed, 441 insertions(+), 8 deletions(-)

diff --git a/hw/cxl/cxl-cpmu.c b/hw/cxl/cxl-cpmu.c
new file mode 100644
index 0000000000..ee647de607
--- /dev/null
+++ b/hw/cxl/cxl-cpmu.c
@@ -0,0 +1,295 @@
+/*
+ * CXL Performance Monitoring Unit
+ *
+ * Copyright(C) 2022 Jonathan Cameron - Huawei
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/cxl/cxl.h"
+
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
+
+static uint64_t cpmu_read(void *opaque, hwaddr offset, unsigned size)
+{
+    CPMUState *cpmu = opaque;
+    uint64_t retval = 0;
+    int index;
+
+    /* I'm lazy - lets assume 4 or 8 byte reads only - fix that up later. */
+    switch (offset) {
+    case A_CXL_CPMU_CAP:
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP,
+                            NUM_COUNTERS, CPMU_NUM_COUNTERS - 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, COUNTER_WIDTH, 48);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP,
+                            NUM_EVENT_GROUPS, CPMU_NUM_EVENT_GROUPS - 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, FILTERS_SUP, 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, MSI_N, cpmu->msi_n);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, WRITEABLE_WHEN_EN, 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, FREEZE, 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CAP, INT, 1);
+        break;
+    case A_CXL_CPMU_OVERFLOW_STS:
+        retval = cpmu->overflow_status_bm;
+        break;
+    case A_CXL_CPMU_FREEZE:
+        retval = cpmu->freeze_status_bm;
+        break;
+    case A_CXL_CPMU_EVENT_CAP0:
+        /* Event group 0, clock ticks */
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, SUPPORTED_EVENTS, 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0, EVENT_GROUP_ID, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP0,
+                            EVENT_VENDOR_ID, 0x1e98);
+        break;
+    case A_CXL_CPMU_EVENT_CAP1:
+        /* Random mashup */
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, SUPPORTED_EVENTS,
+                            0xFF);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_GROUP_ID, 0x10);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_VENDOR_ID,
+                            0x1e98);
+        break;
+    case A_CXL_CPMU_EVENT_CAP2:
+        /* Random mashup */
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, SUPPORTED_EVENTS,
+                            0xFF);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_GROUP_ID, 0x12);
+        retval = FIELD_DP64(retval, CXL_CPMU_EVENT_CAP1, EVENT_VENDOR_ID,
+                            0x1e98);
+        break;
+
+    case A_CXL_CPMU_CNT0_CFG:
+        /* Lets' make this a fixed function counter doing only the first set */
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, TYPE,
+                            CXL_CPMU_CNT_CFG_TYPE_FIXED_FUN);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, ENABLE,
+                            cpmu->counter_enable[0]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, INT_ON_OVERFLOW,
+                            cpmu->int_en[0]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, FREEZE_ON_OVERFLOW,
+                            cpmu->freeze_en[0]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, EDGE, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, INVERT, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, THRESHOLD, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, EVENTS, 1);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT0_CFG, EVENT_GROUP_ID_IDX, 0);
+        break;
+    case A_CXL_CPMU_CNT1_CFG:
+    case A_CXL_CPMU_CNT2_CFG:
+        /* A couple of configurable counters */
+        index = (offset - A_CXL_CPMU_CNT0_CFG) / sizeof(uint64_t);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, TYPE,
+                            CXL_CPMU_CNT_CFG_TYPE_CONFIGURABLE);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, ENABLE,
+                            cpmu->counter_enable[index]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, INT_ON_OVERFLOW,
+                            cpmu->int_en[index]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, FREEZE_ON_OVERFLOW,
+                            cpmu->freeze_en[index]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, EDGE, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, INVERT, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, THRESHOLD, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG, EVENTS, 0xFF);
+        /* Fixme - perhaps make this flexible at somepoint */
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT1_CFG,
+                            EVENT_GROUP_ID_IDX, 1);
+        break;
+    case A_CXL_CPMU_CNT3_CFG:
+        /* Try to break my code! */
+        index = (offset - A_CXL_CPMU_CNT0_CFG) / sizeof(uint64_t);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG,
+                            TYPE, CXL_CPMU_CNT_CFG_TYPE_FIXED_FUN);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG,
+                            ENABLE, cpmu->counter_enable[index]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG,
+                            INT_ON_OVERFLOW, cpmu->int_en[index]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG,
+                            FREEZE_ON_OVERFLOW, cpmu->freeze_en[index]);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG, EDGE, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG, INVERT, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG, THRESHOLD, 0);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG, EVENTS, 1 << 3);
+        retval = FIELD_DP64(retval, CXL_CPMU_CNT3_CFG,
+                            EVENT_GROUP_ID_IDX, 1);
+        break;
+    case A_CXL_CPMU_FILTER0_CNT0_CFG:
+        retval = FIELD_DP64(retval, CXL_CPMU_FILTER0_CNT0_CFG, VALUE, 0xffff);
+        break;
+    case A_CXL_CPMU_FILTER0_CNT1_CFG:
+        index = 1;
+        retval = FIELD_DP64(retval, CXL_CPMU_FILTER0_CNT1_CFG, VALUE,
+                            cpmu->filter_value[0][index]);
+        break;
+    case A_CXL_CPMU_FILTER0_CNT2_CFG:
+        index = 2;
+        retval = FIELD_DP64(retval, CXL_CPMU_FILTER0_CNT2_CFG, VALUE,
+                            cpmu->filter_value[0][index]);
+        break;
+    case A_CXL_CPMU_FILTER0_CNT3_CFG:
+        index = 3;
+        retval = FIELD_DP64(retval, CXL_CPMU_FILTER0_CNT3_CFG, VALUE,
+                            cpmu->filter_value[0][index]);
+        break;
+    case A_CXL_CPMU_CNT0:
+    case A_CXL_CPMU_CNT1:
+    case A_CXL_CPMU_CNT2:
+    case A_CXL_CPMU_CNT3:
+        index = (offset - A_CXL_CPMU_CNT0) / sizeof(uint64_t);
+        retval = cpmu->counter[index] & 0xffffffffffff;
+
+        break;
+    default:
+        break;
+    }
+
+    return retval;
+}
+
+static void cpmu_write(void *opaque, hwaddr offset, uint64_t value,
+                       unsigned size)
+{
+    CPMUState *cpmu = opaque;
+    int index;
+
+    /* Lazy and assume correct size reads and writes for now  */
+    switch (offset) {
+    case 0:
+        break;
+    case 8:
+        break;
+    case A_CXL_CPMU_FREEZE:
+        cpmu->freeze_status_bm = value;
+        break;
+    case A_CXL_CPMU_OVERFLOW_STS:
+        cpmu->overflow_status_bm &= ~value;
+        break;
+    case A_CXL_CPMU_CNT0_CFG:
+    case A_CXL_CPMU_CNT1_CFG:
+    case A_CXL_CPMU_CNT2_CFG:
+    case A_CXL_CPMU_CNT3_CFG:
+        index = (offset - A_CXL_CPMU_CNT0_CFG) / sizeof(uint64_t);
+        cpmu->int_en[index] =
+            FIELD_EX32(value, CXL_CPMU_CNT0_CFG, INT_ON_OVERFLOW);
+        cpmu->freeze_en[index] =
+            FIELD_EX32(value, CXL_CPMU_CNT0_CFG, FREEZE_ON_OVERFLOW);
+        cpmu->counter_enable[index] =
+            FIELD_EX32(value, CXL_CPMU_CNT0_CFG, ENABLE);
+        break;
+    case A_CXL_CPMU_FILTER0_CNT1_CFG:
+        index = 1;
+        cpmu->filter_value[0][index] =
+            FIELD_EX32(value, CXL_CPMU_FILTER0_CNT1_CFG, VALUE);
+        break;
+    case A_CXL_CPMU_FILTER0_CNT2_CFG:
+        index = 2;
+        break;
+    case A_CXL_CPMU_FILTER0_CNT3_CFG:
+        index = 3;
+        cpmu->filter_value[0][index] =
+            FIELD_EX32(value, CXL_CPMU_FILTER0_CNT1_CFG, VALUE);
+        break;
+    case A_CXL_CPMU_CNT0:
+    case A_CXL_CPMU_CNT1:
+    case A_CXL_CPMU_CNT2:
+    case A_CXL_CPMU_CNT3:
+        index = (offset - A_CXL_CPMU_CNT0) / sizeof(uint64_t);
+        cpmu->counter[index] = value & 0xffffffffffff;
+        break;
+    }
+
+    return;
+}
+
+static const MemoryRegionOps cpmu_ops = {
+    .read = cpmu_read,
+    .write = cpmu_write,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 1,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+    },
+};
+
+
+static void cpmu_counter_update(void *opaque)
+{
+    CPMUState *cpmu = opaque;
+    CXLDeviceState *cxl_dstate = cpmu->private;
+    bool interrupt_needed = false;
+    int i;
+
+    timer_del(cpmu->timer);
+
+    for (i = 0; i < CPMU_NUM_COUNTERS; i++) {
+        /*
+         * TODO: check enabled, not frozen etc
+         *
+         * Hack to make the numbers get bigger!  Ideally for at least
+         * some types of event we could hook it up to actual accesses.
+         */
+        uint64_t previous = cpmu->counter[i];
+        if (cpmu->counter_enable[i]) {
+            switch (i) {
+            case 0:
+                cpmu->counter[i] += (1ULL << 44) * 1 + 7;
+                break;
+            case 1:
+                cpmu->counter[i] += (1ULL << 43) * 1 + 3;
+                break;
+            case 2:
+                cpmu->counter[i] += (1ULL << 43) * 1 + 7;
+                break;
+            default:
+                cpmu->counter[i] += 30;
+                break;
+            }
+            if (cpmu->counter[i] / (1ULL << 48) != previous / (1ULL << 48)) {
+                cpmu->overflow_status_bm |= (1 << i);
+                if (cpmu->int_en[i]) {
+                    interrupt_needed = true;
+                }
+            }
+        }
+    }
+    timer_mod(cpmu->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 100000000);
+    if (interrupt_needed) {
+        CXLType3Dev *dev = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+
+        if (msix_enabled(&dev->parent_obj)) {
+            msix_notify(&dev->parent_obj, cpmu->msi_n);
+        } else if (msi_enabled(&dev->parent_obj)) {
+            msi_notify(&dev->parent_obj, cpmu->msi_n);
+        }
+    }
+}
+
+void cxl_cpmu_register_block_init(Object *obj, CXLDeviceState *cxl_dstate,
+                                  int id, uint8_t msi_n)
+{
+    CPMUState *cpmu = &cxl_dstate->cpmu[id];
+    MemoryRegion *registers = &cxl_dstate->cpmu_registers[id];
+    g_autofree gchar *name = g_strdup_printf("cpmu%d-registers", id);
+
+    cpmu->msi_n = msi_n;
+    cpmu->private = cxl_dstate;
+    memory_region_init_io(registers, obj, &cpmu_ops, cpmu,
+                          name, pow2ceil(CXL_CPMU_SIZE));
+    cpmu->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, cpmu_counter_update,
+                               &cxl_dstate->cpmu[id]);
+    timer_mod(cpmu->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + 100000000);
+
+    /* Need to force 64k Alignment in the bar */
+    memory_region_add_subregion(&cxl_dstate->device_registers,
+                                CXL_CPMU_OFFSET(id), registers);
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
index f117b99949..26ac763e8f 100644
--- a/hw/cxl/meson.build
+++ b/hw/cxl/meson.build
@@ -4,6 +4,7 @@ softmmu_ss.add(when: 'CONFIG_CXL',
                    'cxl-device-utils.c',
                    'cxl-mailbox-utils.c',
                    'cxl-host.c',
+                   'cxl-cpmu.c',
                ),
                if_false: files(
                    'cxl-host-stubs.c',
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 5d29d2595c..9242290bfe 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -25,7 +25,9 @@
 static void build_dvsecs(CXLType3Dev *ct3d)
 {
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    CXLDVSECRegisterLocator *regloc_dvsec;
     uint8_t *dvsec;
+    int i;
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
         .cap = 0x1e,
@@ -42,16 +44,21 @@ static void build_dvsecs(CXLType3Dev *ct3d)
                                PCIE_CXL_DEVICE_DVSEC,
                                PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
 
-    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
+    regloc_dvsec = &(CXLDVSECRegisterLocator){
         .rsvd         = 0,
         .reg_base[0].lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
         .reg_base[0].hi = 0,
         .reg_base[1].lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
         .reg_base[1].hi = 0,
     };
+    for (i = 0; i < CXL_NUM_CPMU_INSTANCES; i++) {
+        regloc_dvsec->reg_base[2 + i].lo = CXL_CPMU_OFFSET(i) |
+            RBI_CXL_CPMU_REG | CXL_DEVICE_REG_BAR_IDX;
+        regloc_dvsec->reg_base[2 + i].hi = 0;
+    }
     cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
                                REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
-                               REG_LOC_DVSEC_REVID, dvsec);
+                               REG_LOC_DVSEC_REVID, (uint8_t *)regloc_dvsec);
     dvsec = (uint8_t *)&(CXLDVSECDeviceGPF){
         .phase2_duration = 0x603, /* 3 seconds */
         .phase2_power = 0x33, /* 0x33 miliwatts */
@@ -148,7 +155,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 1;
+    unsigned short msix_num = 4;
     int i;
 
     if (!cxl_setup_memory(ct3d, errp)) {
@@ -180,6 +187,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
 
     cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
+    cxl_cpmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate, 0, 3);
+    cxl_cpmu_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate, 1, 3);
     pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 38e0e271d5..97aa379d18 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -17,6 +17,7 @@
 #include "hw/pci/pci_host.h"
 #include "cxl_pci.h"
 #include "cxl_component.h"
+#include "cxl_cpmu.h"
 #include "cxl_device.h"
 
 #define CXL_COMPONENT_REG_BAR_IDX 0
diff --git a/include/hw/cxl/cxl_cpmu.h b/include/hw/cxl/cxl_cpmu.h
new file mode 100644
index 0000000000..d68b15c965
--- /dev/null
+++ b/include/hw/cxl/cxl_cpmu.h
@@ -0,0 +1,99 @@
+/*
+ * QEMU CXL Performance Monitoring Unit
+ *
+ * Copyright (c) 2021 Jonathan Cameron - Huawei
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "hw/register.h"
+
+#ifndef _CXL_CPMU_H_
+#define _CXL_CPMU_H_
+
+REG32(CXL_CPMU_CAP, 0)
+    FIELD(CXL_CPMU_CAP, NUM_COUNTERS, 0, 6)
+    FIELD(CXL_CPMU_CAP, COUNTER_WIDTH, 8, 8)
+    FIELD(CXL_CPMU_CAP, NUM_EVENT_GROUPS, 20, 5)
+    FIELD(CXL_CPMU_CAP, FILTERS_SUP, 32, 8)
+    FIELD(CXL_CPMU_CAP, MSI_N, 44, 4)
+    FIELD(CXL_CPMU_CAP, WRITEABLE_WHEN_EN, 48, 1)
+    FIELD(CXL_CPMU_CAP, FREEZE, 49, 1)
+    FIELD(CXL_CPMU_CAP, INT, 50, 1)
+/* Register at offset 0x8 is reserved */
+REG32(CXL_CPMU_OVERFLOW_STS, 0x10)
+REG32(CXL_CPMU_FREEZE, 0x18)
+/* Registers at offset 20 + reserved */
+
+#define CXL_CPMU_EVENT_CAP(n) \
+    REG64(CXL_CPMU_EVENT_CAP##n, 0x100 + 8 * (n))               \
+        FIELD(CXL_CPMU_EVENT_CAP##n, SUPPORTED_EVENTS, 0, 32)   \
+        FIELD(CXL_CPMU_EVENT_CAP##n, EVENT_GROUP_ID, 32, 16)    \
+        FIELD(CXL_CPMU_EVENT_CAP##n, EVENT_VENDOR_ID, 48, 16)
+
+CXL_CPMU_EVENT_CAP(0)
+CXL_CPMU_EVENT_CAP(1)
+CXL_CPMU_EVENT_CAP(2)
+CXL_CPMU_EVENT_CAP(3)
+
+#define CXL_CPMU_CNT_CFG(n) \
+    REG64(CXL_CPMU_CNT##n##_CFG, 0x200 + 8 * (n))                     \
+        FIELD(CXL_CPMU_CNT##n##_CFG, TYPE, 0, 2)                      \
+        FIELD(CXL_CPMU_CNT##n##_CFG, ENABLE, 8, 1)                    \
+        FIELD(CXL_CPMU_CNT##n##_CFG, INT_ON_OVERFLOW, 9, 1)           \
+        FIELD(CXL_CPMU_CNT##n##_CFG, FREEZE_ON_OVERFLOW, 10, 1)       \
+        FIELD(CXL_CPMU_CNT##n##_CFG, EDGE, 11, 1)                     \
+        FIELD(CXL_CPMU_CNT##n##_CFG, INVERT, 12, 1)                   \
+        FIELD(CXL_CPMU_CNT##n##_CFG, THRESHOLD, 16, 8)                \
+        FIELD(CXL_CPMU_CNT##n##_CFG, EVENTS, 24, 32)                  \
+        FIELD(CXL_CPMU_CNT##n##_CFG, EVENT_GROUP_ID_IDX, 59, 5)
+
+#define CXL_CPMU_CNT_CFG_TYPE_FREE_RUN 0
+#define CXL_CPMU_CNT_CFG_TYPE_FIXED_FUN 1
+#define CXL_CPMU_CNT_CFG_TYPE_CONFIGURABLE 2
+CXL_CPMU_CNT_CFG(0)
+CXL_CPMU_CNT_CFG(1)
+CXL_CPMU_CNT_CFG(2)
+CXL_CPMU_CNT_CFG(3)
+
+#define CXL_CPMU_FILTER_CFG(n, f)                                       \
+    REG64(CXL_CPMU_FILTER##f##_CNT##n##_CFG, 0x400 + 4 * ((f) + (n) * 8)) \
+        FIELD(CXL_CPMU_FILTER##f##_CNT##n##_CFG, VALUE, 0, 16)
+
+/* Only HDM decoder filter suppored - no effect on first counter */
+CXL_CPMU_FILTER_CFG(0, 0)
+CXL_CPMU_FILTER_CFG(1, 0)
+CXL_CPMU_FILTER_CFG(2, 0)
+CXL_CPMU_FILTER_CFG(3, 0)
+
+#define CXL_CPMU_CNT(n)                     \
+    REG64(CXL_CPMU_CNT##n, 0xc00 + 8 * (n))
+
+CXL_CPMU_CNT(0)
+CXL_CPMU_CNT(1)
+CXL_CPMU_CNT(2)
+CXL_CPMU_CNT(3)
+
+typedef struct CPMUState {
+#define CPMU_NUM_COUNTERS 4
+#define CPMU_NUM_EVENT_GROUPS 3
+#define CPMU_NUM_FILTERS 1
+    bool counter_enable[CPMU_NUM_COUNTERS];
+    bool int_en[CPMU_NUM_COUNTERS];
+    bool freeze_en[CPMU_NUM_COUNTERS];
+    bool filter_value[CPMU_NUM_FILTERS][CPMU_NUM_COUNTERS];
+    uint64_t counter[CPMU_NUM_COUNTERS];
+    uint64_t overflow_status_bm;
+    uint64_t freeze_status_bm;
+    uint8_t msi_n;
+    QEMUTimer *timer;
+    void *private;
+} CPMUState;
+
+typedef struct cxl_device_state CXLDeviceState;
+void cxl_cpmu_register_block_init(Object *obj,
+                                  CXLDeviceState *cxl_dstate,
+                                  int id, uint8_t msi_n);
+
+#endif
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e4d221cdb3..84c7728a96 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -12,6 +12,7 @@
 
 #include "hw/register.h"
 
+#include "hw/cxl/cxl_cpmu.h"
 /*
  * The following is how a CXL device's Memory Device registers are laid out.
  * The only requirement from the spec is that the capabilities array and the
@@ -24,6 +25,16 @@
  *
  *                       +---------------------------------+
  *                       |                                 |
+ *                       |             CPMU1               |
+ *                       |                                 |
+ *                       +---------------------------------+
+ *                       |                                 |
+ *                       |             CPMU0               |
+ *                       |                                 |
+ *                       +---------------------------------+
+ *                       |     Padding to 64k Aligned      |
+ *                       +---------------------------------+
+ *                       |                                 |
  *                       |    Memory Device Registers      |
  *                       |                                 |
  * n + PAYLOAD_SIZE_MAX  -----------------------------------
@@ -76,13 +87,26 @@
     (CXL_MAILBOX_REGISTERS_OFFSET + CXL_MAILBOX_REGISTERS_LENGTH)
 #define CXL_MEMORY_DEVICE_REGISTERS_LENGTH 0x8
 
+#define CXL_NUM_CPMU_INSTANCES 2
+#define CXL_CPMU_SIZE          0x8f8
+#define CXL_CPMU_OFFSET(x)                                              \
+    QEMU_ALIGN_UP(CXL_MEMORY_DEVICE_REGISTERS_OFFSET +                  \
+                  CXL_MEMORY_DEVICE_REGISTERS_LENGTH +                  \
+                  (x) * (1 << 16),                                      \
+                  1 << 16)
+
 #define CXL_MMIO_SIZE                                                   \
-    (CXL_DEVICE_CAP_REG_SIZE + CXL_DEVICE_STATUS_REGISTERS_LENGTH +     \
-     CXL_MAILBOX_REGISTERS_LENGTH + CXL_MEMORY_DEVICE_REGISTERS_LENGTH)
+    QEMU_ALIGN_UP(CXL_DEVICE_CAP_REG_SIZE +                             \
+                  CXL_DEVICE_STATUS_REGISTERS_LENGTH +                  \
+                  CXL_MAILBOX_REGISTERS_LENGTH +                        \
+                  CXL_MEMORY_DEVICE_REGISTERS_LENGTH +                  \
+                  CXL_NUM_CPMU_INSTANCES * (1 << 16),                   \
+                  (1 << 16))
 
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
+    MemoryRegion cpmu_registers[CXL_NUM_CPMU_INSTANCES];
     /* mmio for device capabilities array - 8.2.8.2 */
     MemoryRegion device;
     MemoryRegion memory_device;
@@ -119,6 +143,9 @@ typedef struct cxl_device_state {
 
     /* memory region for persistent memory, HDM */
     uint64_t pmem_size;
+
+    /* Move me later */
+    CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 8cbeb61142..b7b3620a9f 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -35,7 +35,7 @@
 #define PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0 0x14
 #define PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0  1
 
-#define REG_LOC_DVSEC_LENGTH 0x24
+#define REG_LOC_DVSEC_LENGTH 0x2c
 #define REG_LOC_DVSEC_REVID  0
 
 enum {
@@ -144,9 +144,9 @@ typedef struct CXLDVSECRegisterLocator {
     struct {
             uint32_t lo;
             uint32_t hi;
-    } reg_base[3];
+    } reg_base[4];
 } CXLDVSECRegisterLocator;
-QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x24);
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x2C);
 
 /* BAR Equivalence Indicator */
 #define BEI_BAR_10H 0
@@ -161,5 +161,6 @@ QEMU_BUILD_BUG_ON(sizeof(CXLDVSECRegisterLocator) != 0x24);
 #define RBI_COMPONENT_REG  (1 << 8)
 #define RBI_BAR_VIRT_ACL   (2 << 8)
 #define RBI_CXL_DEVICE_REG (3 << 8)
+#define RBI_CXL_CPMU_REG   (4 << 8)
 
 #endif
-- 
2.32.0

