Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B71EC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:18:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244271AbiAXRSG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:18:06 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4447 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244261AbiAXRSG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:18:06 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGrl5BQxz67bVy;
        Tue, 25 Jan 2022 01:17:43 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:18:04 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:18:03 +0000
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
Subject: [PATCH v4 02/42] hw/cxl/component: Introduce CXL components (8.1.x, 8.2.5)
Date:   Mon, 24 Jan 2022 17:16:25 +0000
Message-ID: <20220124171705.10432-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

A CXL 2.0 component is any entity in the CXL topology. All components
have a analogous function in PCIe. Except for the CXL host bridge, all
have a PCIe config space that is accessible via the common PCIe
mechanisms. CXL components are enumerated via DVSEC fields in the
extended PCIe header space. CXL components will minimally implement some
subset of CXL.mem and CXL.cache registers defined in 8.2.5 of the CXL
2.0 specification. Two headers and a utility library are introduced to
support the minimum functionality needed to enumerate components.

The cxl_pci header manages bits associated with PCI, specifically the
DVSEC and related fields. The cxl_component.h variant has data
structures and APIs that are useful for drivers implementing any of the
CXL 2.0 components. The library takes care of making use of the DVSEC
bits and the CXL.[mem|cache] registers. Per spec, the registers are
little endian.

None of the mechanisms required to enumerate a CXL capable hostbridge
are introduced at this point.

Note that the CXL.mem and CXL.cache registers used are always 4B wide.
It's possible in the future that this constraint will not hold.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/Kconfig                     |   1 +
 hw/cxl/Kconfig                 |   3 +
 hw/cxl/cxl-component-utils.c   | 212 +++++++++++++++++++++++++++++++++
 hw/cxl/meson.build             |   3 +
 hw/meson.build                 |   1 +
 include/hw/cxl/cxl.h           |  16 +++
 include/hw/cxl/cxl_component.h | 196 ++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_pci.h       | 138 +++++++++++++++++++++
 8 files changed, 570 insertions(+)

diff --git a/hw/Kconfig b/hw/Kconfig
index ad20cce0a9..50e0952889 100644
--- a/hw/Kconfig
+++ b/hw/Kconfig
@@ -6,6 +6,7 @@ source audio/Kconfig
 source block/Kconfig
 source char/Kconfig
 source core/Kconfig
+source cxl/Kconfig
 source display/Kconfig
 source dma/Kconfig
 source gpio/Kconfig
diff --git a/hw/cxl/Kconfig b/hw/cxl/Kconfig
new file mode 100644
index 0000000000..8e67519b16
--- /dev/null
+++ b/hw/cxl/Kconfig
@@ -0,0 +1,3 @@
+config CXL
+    bool
+    default y if PCI_EXPRESS
diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
new file mode 100644
index 0000000000..5007b29ebb
--- /dev/null
+++ b/hw/cxl/cxl-component-utils.c
@@ -0,0 +1,212 @@
+/*
+ * CXL Utility library for components
+ *
+ * Copyright(C) 2020 Intel Corporation.
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "qemu/log.h"
+#include "hw/pci/pci.h"
+#include "hw/cxl/cxl.h"
+
+static uint64_t cxl_cache_mem_read_reg(void *opaque, hwaddr offset,
+                                       unsigned size)
+{
+    CXLComponentState *cxl_cstate = opaque;
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+
+    assert(size == 4);
+
+    if (cregs->special_ops && cregs->special_ops->read) {
+        return cregs->special_ops->read(cxl_cstate, offset, size);
+    } else {
+        return cregs->cache_mem_registers[offset / 4];
+    }
+}
+
+static void cxl_cache_mem_write_reg(void *opaque, hwaddr offset, uint64_t value,
+                                    unsigned size)
+{
+    CXLComponentState *cxl_cstate = opaque;
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+
+    assert(size == 4);
+
+    if (cregs->special_ops && cregs->special_ops->write) {
+        cregs->special_ops->write(cxl_cstate, offset, value, size);
+    } else {
+        cregs->cache_mem_registers[offset / 4] = value;
+    }
+}
+
+/*
+ * 8.2.3
+ *   The access restrictions specified in Section 8.2.2 also apply to CXL 2.0
+ *   Component Registers.
+ *
+ * 8.2.2
+ *   • A 32 bit register shall be accessed as a 4 Bytes quantity. Partial
+ *   reads are not permitted.
+ *   • A 64 bit register shall be accessed as a 8 Bytes quantity. Partial
+ *   reads are not permitted.
+ *
+ * As of the spec defined today, only 4 byte registers exist.
+ */
+static const MemoryRegionOps cache_mem_ops = {
+    .read = cxl_cache_mem_read_reg,
+    .write = cxl_cache_mem_write_reg,
+    .endianness = DEVICE_LITTLE_ENDIAN,
+    .valid = {
+        .min_access_size = 4,
+        .max_access_size = 8,
+        .unaligned = false,
+    },
+    .impl = {
+        .min_access_size = 4,
+        .max_access_size = 4,
+    },
+};
+
+void cxl_component_register_block_init(Object *obj,
+                                       CXLComponentState *cxl_cstate,
+                                       const char *type)
+{
+    ComponentRegisters *cregs = &cxl_cstate->crb;
+
+    memory_region_init(&cregs->component_registers, obj, type,
+                       CXL2_COMPONENT_BLOCK_SIZE);
+
+    /* io registers controls link which we don't care about in QEMU */
+    memory_region_init_io(&cregs->io, obj, NULL, cregs, ".io",
+                          CXL2_COMPONENT_IO_REGION_SIZE);
+    memory_region_init_io(&cregs->cache_mem, obj, &cache_mem_ops, cregs,
+                          ".cache_mem", CXL2_COMPONENT_CM_REGION_SIZE);
+
+    memory_region_add_subregion(&cregs->component_registers, 0, &cregs->io);
+    memory_region_add_subregion(&cregs->component_registers,
+                                CXL2_COMPONENT_IO_REGION_SIZE,
+                                &cregs->cache_mem);
+}
+
+static void ras_init_common(uint32_t *reg_state)
+{
+    reg_state[R_CXL_RAS_UNC_ERR_STATUS] = 0;
+    reg_state[R_CXL_RAS_UNC_ERR_MASK] = 0x1cfff;
+    reg_state[R_CXL_RAS_UNC_ERR_SEVERITY] = 0x1cfff;
+    reg_state[R_CXL_RAS_COR_ERR_STATUS] = 0;
+    reg_state[R_CXL_RAS_COR_ERR_MASK] = 0x3f;
+
+    /* CXL switches and devices must set */
+    reg_state[R_CXL_RAS_ERR_CAP_CTRL] = 0;
+}
+
+static void hdm_init_common(uint32_t *reg_state)
+{
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT, 0);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 1);
+    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_GLOBAL_CONTROL,
+                     HDM_DECODER_ENABLE, 0);
+}
+
+void cxl_component_register_init_common(uint32_t *reg_state, enum reg_type type)
+{
+    int caps = 0;
+    switch (type) {
+    case CXL2_DOWNSTREAM_PORT:
+    case CXL2_DEVICE:
+        /* CAP, RAS, Link */
+        caps = 2;
+        break;
+    case CXL2_UPSTREAM_PORT:
+    case CXL2_TYPE3_DEVICE:
+    case CXL2_LOGICAL_DEVICE:
+        /* + HDM */
+        caps = 3;
+        break;
+    case CXL2_ROOT_PORT:
+        /* + Extended Security, + Snoop */
+        caps = 5;
+        break;
+    default:
+        abort();
+    }
+
+    memset(reg_state, 0, CXL2_COMPONENT_CM_REGION_SIZE);
+
+    /* CXL Capability Header Register */
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ID, 1);
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, VERSION, 1);
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 1);
+    ARRAY_FIELD_DP32(reg_state, CXL_CAPABILITY_HEADER, ARRAY_SIZE, caps);
+
+
+#define init_cap_reg(reg, id, version)                                        \
+    _Static_assert(CXL_##reg##_REGISTERS_OFFSET != 0, "Invalid cap offset\n");\
+    do {                                                                      \
+        int which = R_CXL_##reg##_CAPABILITY_HEADER;                          \
+        reg_state[which] = FIELD_DP32(reg_state[which],                       \
+                                      CXL_##reg##_CAPABILITY_HEADER, ID, id); \
+        reg_state[which] =                                                    \
+            FIELD_DP32(reg_state[which], CXL_##reg##_CAPABILITY_HEADER,       \
+                       VERSION, version);                                     \
+        reg_state[which] =                                                    \
+            FIELD_DP32(reg_state[which], CXL_##reg##_CAPABILITY_HEADER, PTR,  \
+                       CXL_##reg##_REGISTERS_OFFSET);                         \
+    } while (0)
+
+    init_cap_reg(RAS, 2, 1);
+    ras_init_common(reg_state);
+
+    init_cap_reg(LINK, 4, 2);
+
+    if (caps < 3) {
+        return;
+    }
+
+    init_cap_reg(HDM, 5, 1);
+    hdm_init_common(reg_state);
+
+    if (caps < 5) {
+        return;
+    }
+
+    init_cap_reg(EXTSEC, 6, 1);
+    init_cap_reg(SNOOP, 8, 1);
+
+#undef init_cap_reg
+}
+
+/*
+ * Helper to creates a DVSEC header for a CXL entity. The caller is responsible
+ * for tracking the valid offset.
+ *
+ * This function will build the DVSEC header on behalf of the caller and then
+ * copy in the remaining data for the vendor specific bits.
+ */
+void cxl_component_create_dvsec(CXLComponentState *cxl, uint16_t length,
+                                uint16_t type, uint8_t rev, uint8_t *body)
+{
+    PCIDevice *pdev = cxl->pdev;
+    uint16_t offset = cxl->dvsec_offset;
+
+    assert(offset >= PCI_CFG_SPACE_SIZE &&
+           ((offset + length) < PCI_CFG_SPACE_EXP_SIZE));
+    assert((length & 0xf000) == 0);
+    assert((rev & ~0xf) == 0);
+
+    /* Create the DVSEC in the MCFG space */
+    pcie_add_capability(pdev, PCI_EXT_CAP_ID_DVSEC, 1, offset, length);
+    pci_set_long(pdev->config + offset + PCIE_DVSEC_HEADER1_OFFSET,
+                 (length << 20) | (rev << 16) | CXL_VENDOR_ID);
+    pci_set_word(pdev->config + offset + PCIE_DVSEC_ID_OFFSET, type);
+    memcpy(pdev->config + offset + sizeof(struct dvsec_header),
+           body + sizeof(struct dvsec_header),
+           length - sizeof(struct dvsec_header));
+
+    /* Update state for future DVSEC additions */
+    range_init_nofail(&cxl->dvsecs[type], cxl->dvsec_offset, length);
+    cxl->dvsec_offset += length;
+}
diff --git a/hw/cxl/meson.build b/hw/cxl/meson.build
new file mode 100644
index 0000000000..00c3876a0f
--- /dev/null
+++ b/hw/cxl/meson.build
@@ -0,0 +1,3 @@
+softmmu_ss.add(when: 'CONFIG_CXL', if_true: files(
+  'cxl-component-utils.c',
+))
diff --git a/hw/meson.build b/hw/meson.build
index b3366c888e..9992c5101e 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -6,6 +6,7 @@ subdir('block')
 subdir('char')
 subdir('core')
 subdir('cpu')
+subdir('cxl')
 subdir('display')
 subdir('dma')
 subdir('gpio')
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
new file mode 100644
index 0000000000..8c738c7a2b
--- /dev/null
+++ b/include/hw/cxl/cxl.h
@@ -0,0 +1,16 @@
+/*
+ * QEMU CXL Support
+ *
+ * Copyright (c) 2020 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_H
+#define CXL_H
+
+#include "cxl_pci.h"
+#include "cxl_component.h"
+
+#endif
diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
new file mode 100644
index 0000000000..30e576351d
--- /dev/null
+++ b/include/hw/cxl/cxl_component.h
@@ -0,0 +1,196 @@
+/*
+ * QEMU CXL Component
+ *
+ * Copyright (c) 2020 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_COMPONENT_H
+#define CXL_COMPONENT_H
+
+/* CXL 2.0 - 8.2.4 */
+#define CXL2_COMPONENT_IO_REGION_SIZE 0x1000
+#define CXL2_COMPONENT_CM_REGION_SIZE 0x1000
+#define CXL2_COMPONENT_BLOCK_SIZE 0x10000
+
+#include "qemu/range.h"
+#include "qemu/typedefs.h"
+#include "hw/register.h"
+
+enum reg_type {
+    CXL2_DEVICE,
+    CXL2_TYPE3_DEVICE,
+    CXL2_LOGICAL_DEVICE,
+    CXL2_ROOT_PORT,
+    CXL2_UPSTREAM_PORT,
+    CXL2_DOWNSTREAM_PORT
+};
+
+/*
+ * Capability registers are defined at the top of the CXL.cache/mem region and
+ * are packed. For our purposes we will always define the caps in the same
+ * order.
+ * CXL 2.0 - 8.2.5 Table 142 for details.
+ */
+
+/* CXL 2.0 - 8.2.5.1 */
+REG32(CXL_CAPABILITY_HEADER, 0)
+    FIELD(CXL_CAPABILITY_HEADER, ID, 0, 16)
+    FIELD(CXL_CAPABILITY_HEADER, VERSION, 16, 4)
+    FIELD(CXL_CAPABILITY_HEADER, CACHE_MEM_VERSION, 20, 4)
+    FIELD(CXL_CAPABILITY_HEADER, ARRAY_SIZE, 24, 8)
+
+#define CXLx_CAPABILITY_HEADER(type, offset)                  \
+    REG32(CXL_##type##_CAPABILITY_HEADER, offset)             \
+        FIELD(CXL_##type##_CAPABILITY_HEADER, ID, 0, 16)      \
+        FIELD(CXL_##type##_CAPABILITY_HEADER, VERSION, 16, 4) \
+        FIELD(CXL_##type##_CAPABILITY_HEADER, PTR, 20, 12)
+CXLx_CAPABILITY_HEADER(RAS, 0x4)
+CXLx_CAPABILITY_HEADER(LINK, 0x8)
+CXLx_CAPABILITY_HEADER(HDM, 0xc)
+CXLx_CAPABILITY_HEADER(EXTSEC, 0x10)
+CXLx_CAPABILITY_HEADER(SNOOP, 0x14)
+
+/*
+ * Capability structures contain the actual registers that the CXL component
+ * implements. Some of these are specific to certain types of components, but
+ * this implementation leaves enough space regardless.
+ */
+/* 8.2.5.9 - CXL RAS Capability Structure */
+
+/* Give ample space for caps before this */
+#define CXL_RAS_REGISTERS_OFFSET 0x80
+#define CXL_RAS_REGISTERS_SIZE   0x58
+REG32(CXL_RAS_UNC_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET)
+REG32(CXL_RAS_UNC_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x4)
+REG32(CXL_RAS_UNC_ERR_SEVERITY, CXL_RAS_REGISTERS_OFFSET + 0x8)
+REG32(CXL_RAS_COR_ERR_STATUS, CXL_RAS_REGISTERS_OFFSET + 0xc)
+REG32(CXL_RAS_COR_ERR_MASK, CXL_RAS_REGISTERS_OFFSET + 0x10)
+REG32(CXL_RAS_ERR_CAP_CTRL, CXL_RAS_REGISTERS_OFFSET + 0x14)
+/* Offset 0x18 - 0x58 reserved for RAS logs */
+
+/* 8.2.5.10 - CXL Security Capability Structure */
+#define CXL_SEC_REGISTERS_OFFSET \
+    (CXL_RAS_REGISTERS_OFFSET + CXL_RAS_REGISTERS_SIZE)
+#define CXL_SEC_REGISTERS_SIZE   0 /* We don't implement 1.1 downstream ports */
+
+/* 8.2.5.11 - CXL Link Capability Structure */
+#define CXL_LINK_REGISTERS_OFFSET \
+    (CXL_SEC_REGISTERS_OFFSET + CXL_SEC_REGISTERS_SIZE)
+#define CXL_LINK_REGISTERS_SIZE   0x38
+
+/* 8.2.5.12 - CXL HDM Decoder Capability Structure */
+#define HDM_DECODE_MAX 10 /* 8.2.5.12.1 */
+#define CXL_HDM_REGISTERS_OFFSET \
+    (CXL_LINK_REGISTERS_OFFSET + CXL_LINK_REGISTERS_SIZE)
+#define CXL_HDM_REGISTERS_SIZE (0x20 + HDM_DECODE_MAX + 10)
+#define HDM_DECODER_INIT(n)                                                    \
+  REG32(CXL_HDM_DECODER##n##_BASE_LO,                                          \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x10)                          \
+            FIELD(CXL_HDM_DECODER##n##_BASE_LO, L, 28, 4)                      \
+  REG32(CXL_HDM_DECODER##n##_BASE_HI,                                          \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x14)                          \
+  REG32(CXL_HDM_DECODER##n##_SIZE_LO,                                          \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x18)                          \
+  REG32(CXL_HDM_DECODER##n##_SIZE_HI,                                          \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x1C)                          \
+  REG32(CXL_HDM_DECODER##n##_CTRL,                                             \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x20)                          \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, IG, 0, 4)                         \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, IW, 4, 4)                         \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, LOCK_ON_COMMIT, 8, 1)             \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, COMMIT, 9, 1)                     \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, COMMITTED, 10, 1)                 \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, ERROR, 11, 1)                     \
+            FIELD(CXL_HDM_DECODER##n##_CTRL, TYPE, 12, 1)                      \
+  REG32(CXL_HDM_DECODER##n##_TARGET_LIST_LO,                                   \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x24)                          \
+  REG32(CXL_HDM_DECODER##n##_TARGET_LIST_HI,                                   \
+        CXL_HDM_REGISTERS_OFFSET + (0x20 * n) + 0x28)
+
+REG32(CXL_HDM_DECODER_CAPABILITY, CXL_HDM_REGISTERS_OFFSET)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, DECODER_COUNT, 0, 4)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 4, 4)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, INTERLEAVE_256B, 8, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, INTELEAVE_4K, 9, 1)
+    FIELD(CXL_HDM_DECODER_CAPABILITY, POISON_ON_ERR_CAP, 10, 1)
+REG32(CXL_HDM_DECODER_GLOBAL_CONTROL, CXL_HDM_REGISTERS_OFFSET + 4)
+    FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, POISON_ON_ERR_EN, 0, 1)
+    FIELD(CXL_HDM_DECODER_GLOBAL_CONTROL, HDM_DECODER_ENABLE, 1, 1)
+
+HDM_DECODER_INIT(0);
+
+/* 8.2.5.13 - CXL Extended Security Capability Structure (Root complex only) */
+#define EXTSEC_ENTRY_MAX        256
+#define CXL_EXTSEC_REGISTERS_OFFSET \
+    (CXL_HDM_REGISTERS_OFFSET + CXL_HDM_REGISTERS_SIZE)
+#define CXL_EXTSEC_REGISTERS_SIZE   (8 * EXTSEC_ENTRY_MAX + 4)
+
+/* 8.2.5.14 - CXL IDE Capability Structure */
+#define CXL_IDE_REGISTERS_OFFSET \
+    (CXL_EXTSEC_REGISTERS_OFFSET + CXL_EXTSEC_REGISTERS_SIZE)
+#define CXL_IDE_REGISTERS_SIZE   0x20
+
+/* 8.2.5.15 - CXL Snoop Filter Capability Structure */
+#define CXL_SNOOP_REGISTERS_OFFSET \
+    (CXL_IDE_REGISTERS_OFFSET + CXL_IDE_REGISTERS_SIZE)
+#define CXL_SNOOP_REGISTERS_SIZE   0x8
+
+_Static_assert((CXL_SNOOP_REGISTERS_OFFSET + CXL_SNOOP_REGISTERS_SIZE) < 0x1000,
+               "No space for registers");
+
+typedef struct component_registers {
+    /*
+     * Main memory region to be registered with QEMU core.
+     */
+    MemoryRegion component_registers;
+
+    /*
+     * 8.2.4 Table 141:
+     *   0x0000 - 0x0fff CXL.io registers
+     *   0x1000 - 0x1fff CXL.cache and CXL.mem
+     *   0x2000 - 0xdfff Implementation specific
+     *   0xe000 - 0xe3ff CXL ARB/MUX registers
+     *   0xe400 - 0xffff RSVD
+     */
+    uint32_t io_registers[CXL2_COMPONENT_IO_REGION_SIZE >> 2];
+    MemoryRegion io;
+
+    uint32_t cache_mem_registers[CXL2_COMPONENT_CM_REGION_SIZE >> 2];
+    MemoryRegion cache_mem;
+
+    MemoryRegion impl_specific;
+    MemoryRegion arb_mux;
+    MemoryRegion rsvd;
+
+    /* special_ops is used for any component that needs any specific handling */
+    MemoryRegionOps *special_ops;
+} ComponentRegisters;
+
+/*
+ * A CXL component represents all entities in a CXL hierarchy. This includes,
+ * host bridges, root ports, upstream/downstream switch ports, and devices
+ */
+typedef struct cxl_component {
+    ComponentRegisters crb;
+    union {
+        struct {
+            Range dvsecs[CXL20_MAX_DVSEC];
+            uint16_t dvsec_offset;
+            struct PCIDevice *pdev;
+        };
+    };
+} CXLComponentState;
+
+void cxl_component_register_block_init(Object *obj,
+                                       CXLComponentState *cxl_cstate,
+                                       const char *type);
+void cxl_component_register_init_common(uint32_t *reg_state,
+                                        enum reg_type type);
+
+void cxl_component_create_dvsec(CXLComponentState *cxl_cstate, uint16_t length,
+                                uint16_t type, uint8_t rev, uint8_t *body);
+
+#endif
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
new file mode 100644
index 0000000000..40c7329afe
--- /dev/null
+++ b/include/hw/cxl/cxl_pci.h
@@ -0,0 +1,138 @@
+/*
+ * QEMU CXL PCI interfaces
+ *
+ * Copyright (c) 2020 Intel
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#ifndef CXL_PCI_H
+#define CXL_PCI_H
+
+#include "hw/pci/pci.h"
+#include "hw/pci/pcie.h"
+
+#define CXL_VENDOR_ID 0x1e98
+
+#define PCIE_DVSEC_HEADER1_OFFSET 0x4 /* Offset from start of extend cap */
+#define PCIE_DVSEC_ID_OFFSET 0x8
+
+#define PCIE_CXL_DEVICE_DVSEC_LENGTH 0x38
+#define PCIE_CXL1_DEVICE_DVSEC_REVID 0
+#define PCIE_CXL2_DEVICE_DVSEC_REVID 1
+
+#define EXTENSIONS_PORT_DVSEC_LENGTH 0x28
+#define EXTENSIONS_PORT_DVSEC_REVID 0
+
+#define GPF_PORT_DVSEC_LENGTH 0x10
+#define GPF_PORT_DVSEC_REVID  0
+
+#define PCIE_FLEXBUS_PORT_DVSEC_LENGTH_2_0 0x14
+#define PCIE_FLEXBUS_PORT_DVSEC_REVID_2_0  1
+
+#define REG_LOC_DVSEC_LENGTH 0x24
+#define REG_LOC_DVSEC_REVID  0
+
+enum {
+    PCIE_CXL_DEVICE_DVSEC      = 0,
+    NON_CXL_FUNCTION_MAP_DVSEC = 2,
+    EXTENSIONS_PORT_DVSEC      = 3,
+    GPF_PORT_DVSEC             = 4,
+    GPF_DEVICE_DVSEC           = 5,
+    PCIE_FLEXBUS_PORT_DVSEC    = 7,
+    REG_LOC_DVSEC              = 8,
+    MLD_DVSEC                  = 9,
+    CXL20_MAX_DVSEC
+};
+
+struct dvsec_header {
+    uint32_t cap_hdr;
+    uint32_t dv_hdr1;
+    uint16_t dv_hdr2;
+} __attribute__((__packed__));
+_Static_assert(sizeof(struct dvsec_header) == 10,
+               "dvsec header size incorrect");
+
+/*
+ * CXL 2.0 devices must implement certain DVSEC IDs, and can [optionally]
+ * implement others.
+ *
+ * CXL 2.0 Device: 0, [2], 5, 8
+ * CXL 2.0 RP: 3, 4, 7, 8
+ * CXL 2.0 Upstream Port: [2], 7, 8
+ * CXL 2.0 Downstream Port: 3, 4, 7, 8
+ */
+
+/* CXL 2.0 - 8.1.5 (ID 0003) */
+struct cxl_dvsec_port_extensions {
+    struct dvsec_header hdr;
+    uint16_t status;
+    uint16_t control;
+    uint8_t alt_bus_base;
+    uint8_t alt_bus_limit;
+    uint16_t alt_memory_base;
+    uint16_t alt_memory_limit;
+    uint16_t alt_prefetch_base;
+    uint16_t alt_prefetch_limit;
+    uint32_t alt_prefetch_base_high;
+    uint32_t alt_prefetch_base_low;
+    uint32_t rcrb_base;
+    uint32_t rcrb_base_high;
+};
+_Static_assert(sizeof(struct cxl_dvsec_port_extensions) == 0x28,
+               "extensions dvsec port size incorrect");
+#define PORT_CONTROL_OFFSET          0xc
+#define PORT_CONTROL_UNMASK_SBR      1
+#define PORT_CONTROL_ALT_MEMID_EN    4
+
+/* CXL 2.0 - 8.1.6 GPF DVSEC (ID 0004) */
+struct cxl_dvsec_port_gpf {
+    struct dvsec_header hdr;
+    uint16_t rsvd;
+    uint16_t phase1_ctrl;
+    uint16_t phase2_ctrl;
+};
+_Static_assert(sizeof(struct cxl_dvsec_port_gpf) == 0x10,
+               "dvsec port GPF size incorrect");
+
+/* CXL 2.0 - 8.1.8/8.2.1.3 Flexbus DVSEC (ID 0007) */
+struct cxl_dvsec_port_flexbus {
+    struct dvsec_header hdr;
+    uint16_t cap;
+    uint16_t ctrl;
+    uint16_t status;
+    uint32_t rcvd_mod_ts_data_phase1;
+};
+_Static_assert(sizeof(struct cxl_dvsec_port_flexbus) == 0x14,
+               "dvsec port flexbus size incorrect");
+
+/* CXL 2.0 - 8.1.9 Register Locator DVSEC (ID 0008) */
+struct cxl_dvsec_register_locator {
+    struct dvsec_header hdr;
+    uint16_t rsvd;
+    uint32_t reg0_base_lo;
+    uint32_t reg0_base_hi;
+    uint32_t reg1_base_lo;
+    uint32_t reg1_base_hi;
+    uint32_t reg2_base_lo;
+    uint32_t reg2_base_hi;
+};
+_Static_assert(sizeof(struct cxl_dvsec_register_locator) == 0x24,
+               "dvsec register locator size incorrect");
+
+/* BAR Equivalence Indicator */
+#define BEI_BAR_10H 0
+#define BEI_BAR_14H 1
+#define BEI_BAR_18H 2
+#define BEI_BAR_1cH 3
+#define BEI_BAR_20H 4
+#define BEI_BAR_24H 5
+
+/* Register Block Identifier */
+#define RBI_EMPTY          0
+#define RBI_COMPONENT_REG  (1 << 8)
+#define RBI_BAR_VIRT_ACL   (2 << 8)
+#define RBI_CXL_DEVICE_REG (3 << 8)
+
+#endif
-- 
2.32.0

