Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B52AC433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:23:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378525AbiDDPZX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:25:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378540AbiDDPZS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:25:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D6363ED2A
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:23:21 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXDy704jQz6863G;
        Mon,  4 Apr 2022 23:21:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:23:19 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:23:18 +0100
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
Subject: [PATCH v9 17/45] hw/cxl/device: Add a memory device (8.2.8.5)
Date:   Mon, 4 Apr 2022 16:14:17 +0100
Message-ID: <20220404151445.10955-18-Jonathan.Cameron@huawei.com>
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

A CXL memory device (AKA Type 3) is a CXL component that contains some
combination of volatile and persistent memory. It also implements the
previously defined mailbox interface as well as the memory device
firmware interface.

Although the memory device is configured like a normal PCIe device, the
memory traffic is on an entirely separate bus conceptually (using the
same physical wires as PCIe, but different protocol).

Once the CXL topology is fully configure and address decoders committed,
the guest physical address for the memory device is part of a larger
window which is owned by the platform.  The creation of these windows
is later in this series.

The following example will create a 256M device in a 512M window:
-object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
-device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0"

Note: Dropped PCDIMM info interfaces for now.  They can be added if
appropriate at a later date.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  46 +++++++++++
 hw/mem/Kconfig              |   5 ++
 hw/mem/cxl_type3.c          | 159 ++++++++++++++++++++++++++++++++++++
 hw/mem/meson.build          |   1 +
 include/hw/cxl/cxl_device.h |  15 ++++
 include/hw/cxl/cxl_pci.h    |  21 +++++
 include/hw/pci/pci_ids.h    |   1 +
 7 files changed, 248 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index db473135c7..4ae0561dfc 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -50,6 +50,8 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+    IDENTIFY    = 0x40,
+        #define MEMORY_DEVICE 0x0
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -214,6 +216,48 @@ static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* 8.2.9.5.1.1 */
+static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
+                                           CXLDeviceState *cxl_dstate,
+                                           uint16_t *len)
+{
+    struct {
+        char fw_revision[0x10];
+        uint64_t total_capacity;
+        uint64_t volatile_capacity;
+        uint64_t persistent_capacity;
+        uint64_t partition_align;
+        uint16_t info_event_log_size;
+        uint16_t warning_event_log_size;
+        uint16_t failure_event_log_size;
+        uint16_t fatal_event_log_size;
+        uint32_t lsa_size;
+        uint8_t poison_list_max_mer[3];
+        uint16_t inject_poison_limit;
+        uint8_t poison_caps;
+        uint8_t qos_telemetry_caps;
+    } QEMU_PACKED *id;
+    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
+
+    uint64_t size = cxl_dstate->pmem_size;
+
+    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    id = (void *)cmd->payload;
+    memset(id, 0, sizeof(*id));
+
+    /* PMEM only */
+    snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
+
+    id->total_capacity = size / (256 << 20);
+    id->persistent_capacity = size / (256 << 20);
+
+    *len = sizeof(*id);
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
@@ -231,6 +275,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
+        cmd_identify_memory_device, 0, 0 },
 };
 
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index 03dbb3c7df..73c5ae8ad9 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -11,3 +11,8 @@ config NVDIMM
 
 config SPARSE_MEM
     bool
+
+config CXL_MEM_DEVICE
+    bool
+    default y if CXL
+    select MEM_DEVICE
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
new file mode 100644
index 0000000000..329a6ea2a9
--- /dev/null
+++ b/hw/mem/cxl_type3.c
@@ -0,0 +1,159 @@
+#include "qemu/osdep.h"
+#include "qemu/units.h"
+#include "qemu/error-report.h"
+#include "hw/mem/memory-device.h"
+#include "hw/mem/pc-dimm.h"
+#include "hw/pci/pci.h"
+#include "hw/qdev-properties.h"
+#include "qapi/error.h"
+#include "qemu/log.h"
+#include "qemu/module.h"
+#include "qemu/range.h"
+#include "qemu/rcu.h"
+#include "sysemu/hostmem.h"
+#include "hw/cxl/cxl.h"
+
+static void build_dvsecs(CXLType3Dev *ct3d)
+{
+    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    uint8_t *dvsec;
+
+    dvsec = (uint8_t *)&(CXLDVSECDevice){
+        .cap = 0x1e,
+        .ctrl = 0x6,
+        .status2 = 0x2,
+        .range1_size_hi = ct3d->hostmem->size >> 32,
+        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+        (ct3d->hostmem->size & 0xF0000000),
+        .range1_base_hi = 0,
+        .range1_base_lo = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
+                               PCIE_CXL_DEVICE_DVSEC,
+                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
+
+    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
+        .reg0_base_hi = 0,
+        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
+        .reg1_base_hi = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, dvsec);
+    dvsec = (uint8_t *)&(CXLDVSECDeviceGPF){
+        .phase2_duration = 0x603, /* 3 seconds */
+        .phase2_power = 0x33, /* 0x33 miliwatts */
+    };
+    cxl_component_create_dvsec(cxl_cstate,
+                               GPF_DEVICE_DVSEC_LENGTH, GPF_PORT_DVSEC,
+                               GPF_DEVICE_DVSEC_REVID, dvsec);
+}
+
+static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
+{
+    MemoryRegion *mr;
+
+    if (!ct3d->hostmem) {
+        error_setg(errp, "memdev property must be set");
+        return false;
+    }
+
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+    if (!mr) {
+        error_setg(errp, "memdev property must be set");
+        return false;
+    }
+    memory_region_set_nonvolatile(mr, true);
+    memory_region_set_enabled(mr, true);
+    host_memory_backend_set_mapped(ct3d->hostmem, true);
+    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
+
+    return true;
+}
+
+static void ct3_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
+    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    ComponentRegisters *regs = &cxl_cstate->crb;
+    MemoryRegion *mr = &regs->component_registers;
+    uint8_t *pci_conf = pci_dev->config;
+
+    if (!cxl_setup_memory(ct3d, errp)) {
+        return;
+    }
+
+    pci_config_set_prog_interface(pci_conf, 0x10);
+    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
+
+    pcie_endpoint_cap_init(pci_dev, 0x80);
+    cxl_cstate->dvsec_offset = 0x100;
+
+    ct3d->cxl_cstate.pdev = pci_dev;
+    build_dvsecs(ct3d);
+
+    cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
+                                      TYPE_CXL_TYPE3);
+
+    pci_register_bar(
+        pci_dev, CXL_COMPONENT_REG_BAR_IDX,
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
+
+    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
+    pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &ct3d->cxl_dstate.device_registers);
+}
+
+static void ct3d_reset(DeviceState *dev)
+{
+    CXLType3Dev *ct3d = CXL_TYPE3(dev);
+    uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
+
+    cxl_component_register_init_common(reg_state, CXL2_TYPE3_DEVICE);
+    cxl_device_register_init_common(&ct3d->cxl_dstate);
+}
+
+static Property ct3_props[] = {
+    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void ct3_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+
+    pc->realize = ct3_realize;
+    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
+    pc->vendor_id = PCI_VENDOR_ID_INTEL;
+    pc->device_id = 0xd93; /* LVF for now */
+    pc->revision = 1;
+
+    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
+    dc->desc = "CXL PMEM Device (Type 3)";
+    dc->reset = ct3d_reset;
+    device_class_set_props(dc, ct3_props);
+}
+
+static const TypeInfo ct3d_info = {
+    .name = TYPE_CXL_TYPE3,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = ct3_class_init,
+    .instance_size = sizeof(CXLType3Dev),
+    .interfaces = (InterfaceInfo[]) {
+        { INTERFACE_CXL_DEVICE },
+        { INTERFACE_PCIE_DEVICE },
+        {}
+    },
+};
+
+static void ct3d_registers(void)
+{
+    type_register_static(&ct3d_info);
+}
+
+type_init(ct3d_registers);
diff --git a/hw/mem/meson.build b/hw/mem/meson.build
index 82f86d117e..609b2b36fc 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -3,6 +3,7 @@ mem_ss.add(files('memory-device.c'))
 mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
+mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
 
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 797a22ddb4..d8da2c7b68 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -230,4 +230,19 @@ REG64(CXL_MEM_DEV_STS, 0)
     FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
     FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
 
+struct CXLType3Dev {
+    /* Private */
+    PCIDevice parent_obj;
+
+    /* Properties */
+    HostMemoryBackend *hostmem;
+
+    /* State */
+    CXLComponentState cxl_cstate;
+    CXLDeviceState cxl_dstate;
+};
+
+#define TYPE_CXL_TYPE3 "cxl-type3"
+OBJECT_DECLARE_SIMPLE_TYPE(CXLType3Dev, CXL_TYPE3)
+
 #endif
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index 3f7e44daac..01cf002096 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -67,6 +67,27 @@ QEMU_BUILD_BUG_ON(sizeof(DVSECHeader) != 10);
  * CXL 2.0 Downstream Port: 3, 4, 7, 8
  */
 
+/* CXL 2.0 - 8.1.3 (ID 0001) */
+typedef struct CXLDVSECDevice {
+    DVSECHeader hdr;
+    uint16_t cap;
+    uint16_t ctrl;
+    uint16_t status;
+    uint16_t ctrl2;
+    uint16_t status2;
+    uint16_t lock;
+    uint16_t cap2;
+    uint32_t range1_size_hi;
+    uint32_t range1_size_lo;
+    uint32_t range1_base_hi;
+    uint32_t range1_base_lo;
+    uint32_t range2_size_hi;
+    uint32_t range2_size_lo;
+    uint32_t range2_base_hi;
+    uint32_t range2_base_lo;
+} CXLDVSECDevice;
+QEMU_BUILD_BUG_ON(sizeof(CXLDVSECDevice) != 0x38);
+
 /* CXL 2.0 - 8.1.5 (ID 0003) */
 typedef struct CXLDVSECPortExtensions {
     DVSECHeader hdr;
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 11abe22d46..898083b86f 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -53,6 +53,7 @@
 #define PCI_BASE_CLASS_MEMORY            0x05
 #define PCI_CLASS_MEMORY_RAM             0x0500
 #define PCI_CLASS_MEMORY_FLASH           0x0501
+#define PCI_CLASS_MEMORY_CXL             0x0502
 #define PCI_CLASS_MEMORY_OTHER           0x0580
 
 #define PCI_BASE_CLASS_BRIDGE            0x06
-- 
2.32.0

