Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06C16C4332B
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D864F64E31
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbhBBBBo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:44 -0500
Received: from mga06.intel.com ([134.134.136.31]:21903 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229732AbhBBBBn (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:43 -0500
IronPort-SDR: jdoWniSeRm1+l/Gw7sgxOoGkb+DivM6LHmbQzmXTjn396lS/wU2O4Xtp0k1+f7EuT9n5bhVck5
 xcAUqy1zrECg==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294646"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294646"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:15 -0800
IronPort-SDR: seOBrf+c3vsF1vfxF+wKU7/Fr/1gbkOglHHQ+5k0SR2XYu7rZuslZmzxVQu80/pw7BahOv/Zuk
 aSHI/3rzzdxw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764224"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:14 -0800
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
Subject: [RFC PATCH v3 21/31] hw/cxl/device: Add a memory device (8.2.8.5)
Date:   Mon,  1 Feb 2021 16:59:38 -0800
Message-Id: <20210202005948.241655-22-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

A CXL memory device (AKA Type 3) is a CXL component that contains some
combination of volatile and persistent memory. It also implements the
previously defined mailbox interface as well as the memory device
firmware interface.

Although the memory device is configured like a normal PCIe device, the
memory traffic is on an entirely separate bus conceptually (using the
same physical wires as PCIe, but different protocol).

The guest physical address for the memory device is part of a larger
window which is owned by the platform. Currently, this is hardcoded as
an object property on host bridge (PXB) creation, but that will need to
change for interleaving.

The following example will create a 256M device in a 512M window:
-object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
-device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0,size=256M"

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/core/numa.c             |   3 +
 hw/cxl/cxl-mailbox-utils.c |  41 ++++++
 hw/i386/pc.c               |   1 +
 hw/mem/Kconfig             |   5 +
 hw/mem/cxl_type3.c         | 281 +++++++++++++++++++++++++++++++++++++
 hw/mem/meson.build         |   1 +
 hw/pci/pcie.c              |  30 ++++
 include/hw/cxl/cxl.h       |   2 +
 include/hw/cxl/cxl_pci.h   |  22 +++
 include/hw/pci/pci_ids.h   |   1 +
 monitor/hmp-cmds.c         |  15 ++
 qapi/machine.json          |   1 +
 12 files changed, 403 insertions(+)
 create mode 100644 hw/mem/cxl_type3.c

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 68cee65f61..cd7df371e6 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -770,6 +770,9 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
                 node_mem[pcdimm_info->node].node_plugged_mem +=
                     pcdimm_info->size;
                 break;
+            case MEMORY_DEVICE_INFO_KIND_CXL:
+                /* FINISHME */
+                break;
             case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
                 vpi = value->u.virtio_pmem.data;
                 /* TODO: once we support numa, assign to right node */
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3f0ae8b9e5..f92dfad882 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -49,6 +49,8 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+    IDENTIFY    = 0x40,
+        #define MEMORY_DEVICE 0x0
 };
 
 /* 8.2.8.4.5.1 Command Return Codes */
@@ -127,6 +129,7 @@ declare_mailbox_handler(TIMESTAMP_GET);
 declare_mailbox_handler(TIMESTAMP_SET);
 declare_mailbox_handler(LOGS_GET_SUPPORTED);
 declare_mailbox_handler(LOGS_GET_LOG);
+declare_mailbox_handler(IDENTIFY_MEMORY_DEVICE);
 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -144,6 +147,7 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     CXL_CMD(TIMESTAMP, SET, 8, IMMEDIATE_POLICY_CHANGE),
     CXL_CMD(LOGS, GET_SUPPORTED, 0, 0),
     CXL_CMD(LOGS, GET_LOG, 0x18, 0),
+    CXL_CMD(IDENTIFY, MEMORY_DEVICE, 0, 0),
 };
 
 #undef CXL_CMD
@@ -255,6 +259,43 @@ define_mailbox_handler(LOGS_GET_LOG)
     return CXL_MBOX_SUCCESS;
 }
 
+/* 8.2.9.5.1.1 */
+define_mailbox_handler(IDENTIFY_MEMORY_DEVICE)
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
+    } __attribute__((packed)) *id;
+    _Static_assert(sizeof(*id) == 0x43, "Bad identify size");
+
+    if (memory_region_size(cxl_dstate->pmem) < (256 << 20)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    id = (void *)cmd->payload;
+    memset(id, 0, sizeof(*id));
+
+    /* PMEM only */
+    snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
+    id->total_capacity = memory_region_size(cxl_dstate->pmem);
+    id->persistent_capacity = memory_region_size(cxl_dstate->pmem);
+
+    *len = sizeof(*id);
+    return CXL_MBOX_SUCCESS;
+}
+
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5458f61d10..5d41809b37 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,7 @@
 #include "acpi-build.h"
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/cxl/cxl.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/visitor.h"
diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
index a0ef2cf648..7d9d1ced3e 100644
--- a/hw/mem/Kconfig
+++ b/hw/mem/Kconfig
@@ -10,3 +10,8 @@ config NVDIMM
     default y
     depends on (PC || PSERIES || ARM_VIRT)
     select MEM_DEVICE
+
+config CXL_MEM_DEVICE
+    bool
+    default y if CXL
+    select MEM_DEVICE
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
new file mode 100644
index 0000000000..4e9a016448
--- /dev/null
+++ b/hw/mem/cxl_type3.c
@@ -0,0 +1,281 @@
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
+typedef struct cxl_type3_dev {
+    /* Private */
+    PCIDevice parent_obj;
+
+    /* Properties */
+    uint64_t size;
+    HostMemoryBackend *hostmem;
+
+    /* State */
+    CXLComponentState cxl_cstate;
+    CXLDeviceState cxl_dstate;
+} CXLType3Dev;
+
+#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
+
+static void build_dvsecs(CXLType3Dev *ct3d)
+{
+    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    uint8_t *dvsec;
+
+    dvsec = (uint8_t *)&(struct dvsec_device){
+        .cap = 0x1e,
+        .ctrl = 0x6,
+        .status2 = 0x2,
+        .range1_size_hi = 0,
+        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | ct3d->size,
+        .range1_base_hi = 0,
+        .range1_base_lo = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
+                               PCIE_CXL_DEVICE_DVSEC,
+                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
+
+    dvsec = (uint8_t *)&(struct dvsec_register_locator){
+        .rsvd         = 0,
+        .reg0_base_lo = RBI_COMPONENT_REG | COMPONENT_REG_BAR_IDX,
+        .reg0_base_hi = 0,
+        .reg1_base_lo = RBI_CXL_DEVICE_REG | DEVICE_REG_BAR_IDX,
+        .reg1_base_hi = 0,
+    };
+    cxl_component_create_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
+                               REG_LOC_DVSEC_REVID, dvsec);
+}
+
+static void ct3_instance_init(Object *obj)
+{
+    /* MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(obj); */
+}
+
+static void ct3_finalize(Object *obj)
+{
+    CXLType3Dev *ct3d = CT3(obj);
+
+    g_free(ct3d->cxl_dstate.pmem);
+}
+
+#ifdef SET_PMEM_PADDR
+static void cxl_set_addr(CXLType3Dev *ct3d, hwaddr addr, Error **errp)
+{
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_GET_CLASS(ct3d);
+    mdc->set_addr(MEMORY_DEVICE(ct3d), addr, errp);
+}
+#endif
+
+static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
+{
+    MemoryRegionSection mrs;
+    MemoryRegion *pmem;
+    MemoryRegion *mr;
+    uint64_t offset = 0;
+    size_t remaining_size;
+
+    if (!ct3d->hostmem) {
+        error_setg(errp, "memdev property must be set");
+        return;
+    }
+
+    /* FIXME: need to check mr is the host bridge's MR */
+    mr = host_memory_backend_get_memory(ct3d->hostmem);
+
+    /* Create our new subregion */
+    pmem = g_new(MemoryRegion, 1);
+
+    /* Find the first free space in the window */
+    WITH_RCU_READ_LOCK_GUARD()
+    {
+        mrs = memory_region_find(mr, offset, 1);
+        while (mrs.mr && mrs.mr != mr) {
+            offset += memory_region_size(mrs.mr);
+            mrs = memory_region_find(mr, offset, 1);
+        }
+    }
+
+    remaining_size = memory_region_size(mr) - offset;
+    if (remaining_size < ct3d->size) {
+        g_free(pmem);
+        error_setg(errp,
+                   "Not enough free space (%zd) required for device (%" PRId64  ")",
+                   remaining_size, ct3d->size);
+    }
+
+    memory_region_set_nonvolatile(pmem, true);
+    memory_region_set_enabled(pmem, false);
+    memory_region_init_alias(pmem, OBJECT(ct3d), "cxl_type3-memory", mr, 0,
+                             ct3d->size);
+    ct3d->cxl_dstate.pmem = pmem;
+
+#ifdef SET_PMEM_PADDR
+    /* This path will initialize the memory device as if BIOS had done it */
+    cxl_set_addr(ct3d, mr->addr + offset, errp);
+    memory_region_set_enabled(pmem, true);
+#endif
+}
+
+static MemoryRegion *cxl_md_get_memory_region(MemoryDeviceState *md,
+                                              Error **errp)
+{
+    CXLType3Dev *ct3d = CT3(md);
+
+    if (!ct3d->cxl_dstate.pmem) {
+        cxl_setup_memory(ct3d, errp);
+    }
+
+    return ct3d->cxl_dstate.pmem;
+}
+
+static void ct3_realize(PCIDevice *pci_dev, Error **errp)
+{
+    CXLType3Dev *ct3d = CT3(pci_dev);
+    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    ComponentRegisters *regs = &cxl_cstate->crb;
+    MemoryRegion *mr = &regs->component_registers;
+    uint8_t *pci_conf = pci_dev->config;
+
+    if (!ct3d->cxl_dstate.pmem) {
+        cxl_setup_memory(ct3d, errp);
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
+                                      TYPE_CXL_TYPE3_DEV);
+
+    pci_register_bar(
+        pci_dev, COMPONENT_REG_BAR_IDX,
+        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
+
+    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
+    pci_register_bar(pci_dev, DEVICE_REG_BAR_IDX,
+                     PCI_BASE_ADDRESS_SPACE_MEMORY |
+                         PCI_BASE_ADDRESS_MEM_TYPE_64,
+                     &ct3d->cxl_dstate.device_registers);
+}
+
+static uint64_t cxl_md_get_addr(const MemoryDeviceState *md)
+{
+    CXLType3Dev *ct3d = CT3(md);
+    MemoryRegion *pmem = ct3d->cxl_dstate.pmem;
+
+    assert(pmem->alias);
+    return pmem->alias_offset;
+}
+
+static void cxl_md_set_addr(MemoryDeviceState *md, uint64_t addr, Error **errp)
+{
+    CXLType3Dev *ct3d = CT3(md);
+    MemoryRegion *pmem = ct3d->cxl_dstate.pmem;
+
+    assert(pmem->alias);
+    memory_region_set_alias_offset(pmem, addr);
+    memory_region_set_address(pmem, addr);
+}
+
+static void ct3d_reset(DeviceState *dev)
+{
+    CXLType3Dev *ct3d = CT3(dev);
+    uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
+
+    cxl_component_register_init_common(reg_state, CXL2_TYPE3_DEVICE);
+    cxl_device_register_init_common(&ct3d->cxl_dstate);
+}
+
+static Property ct3_props[] = {
+    DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
+    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
+                     HostMemoryBackend *),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
+static void pc_dimm_md_fill_device_info(const MemoryDeviceState *md,
+                                        MemoryDeviceInfo *info)
+{
+    PCDIMMDeviceInfo *di = g_new0(PCDIMMDeviceInfo, 1);
+    const DeviceClass *dc = DEVICE_GET_CLASS(md);
+    const DeviceState *dev = DEVICE(md);
+    CXLType3Dev *ct3d = CT3(md);
+
+    if (dev->id) {
+        di->has_id = true;
+        di->id = g_strdup(dev->id);
+    }
+
+    di->hotplugged = dev->hotplugged;
+    di->hotpluggable = dc->hotpluggable;
+    di->addr = cxl_md_get_addr(md);
+    di->slot = 0;
+    di->node = 0;
+    di->size = memory_device_get_region_size(md, NULL);
+    di->memdev = object_get_canonical_path(OBJECT(ct3d->hostmem));
+
+    info->u.cxl.data = di;
+    info->type = MEMORY_DEVICE_INFO_KIND_CXL;
+}
+
+static void ct3_class_init(ObjectClass *oc, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(oc);
+    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
+    MemoryDeviceClass *mdc = MEMORY_DEVICE_CLASS(oc);
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
+
+    mdc->get_memory_region = cxl_md_get_memory_region;
+    mdc->get_addr = cxl_md_get_addr;
+    mdc->fill_device_info = pc_dimm_md_fill_device_info;
+    mdc->get_plugged_size = memory_device_get_region_size;
+    mdc->set_addr = cxl_md_set_addr;
+}
+
+static const TypeInfo ct3d_info = {
+    .name = TYPE_CXL_TYPE3_DEV,
+    .parent = TYPE_PCI_DEVICE,
+    .class_init = ct3_class_init,
+    .instance_size = sizeof(CXLType3Dev),
+    .instance_init = ct3_instance_init,
+    .instance_finalize = ct3_finalize,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_MEMORY_DEVICE },
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
index 0d22f2b572..d13c3ed117 100644
--- a/hw/mem/meson.build
+++ b/hw/mem/meson.build
@@ -3,5 +3,6 @@ mem_ss.add(files('memory-device.c'))
 mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
 mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
 mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
+mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
 
 softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
index d4010cf8f3..1ecf6f6a55 100644
--- a/hw/pci/pcie.c
+++ b/hw/pci/pcie.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "hw/mem/memory-device.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie.h"
 #include "hw/pci/msix.h"
@@ -27,6 +28,8 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pcie_regs.h"
 #include "hw/pci/pcie_port.h"
+#include "hw/cxl/cxl.h"
+#include "hw/boards.h"
 #include "qemu/range.h"
 
 //#define DEBUG_PCIE
@@ -419,6 +422,28 @@ void pcie_cap_slot_pre_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
     }
 
     pcie_cap_slot_plug_common(PCI_DEVICE(hotplug_dev), dev, errp);
+
+#ifdef CXL_MEM_DEVICE
+    /*
+     * FIXME:
+     * if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_TYPE3_DEV)) {
+     *    HotplugHandler *hotplug_ctrl;
+     *   Error *local_err = NULL;
+     *  hotplug_ctrl = qdev_get_hotplug_handler(dev);
+     *  if (hotplug_ctrl) {
+     *      hotplug_handler_pre_plug(hotplug_ctrl, dev, &local_err);
+     *      if (local_err) {
+     *          error_propagate(errp, local_err);
+     *          return;
+     *      }
+     *  }
+     */
+
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_TYPE3_DEV)) {
+        memory_device_pre_plug(MEMORY_DEVICE(dev), MACHINE(qdev_get_machine()),
+                               NULL, errp);
+    }
+#endif
 }
 
 void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
@@ -455,6 +480,11 @@ void pcie_cap_slot_plug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
         pcie_cap_slot_event(hotplug_pdev,
                             PCI_EXP_HP_EV_PDC | PCI_EXP_HP_EV_ABP);
     }
+
+#ifdef CXL_MEM_DEVICE
+    if (object_dynamic_cast(OBJECT(dev), TYPE_CXL_TYPE3_DEV))
+        memory_device_plug(MEMORY_DEVICE(dev), MACHINE(qdev_get_machine()));
+#endif
 }
 
 void pcie_cap_slot_unplug_cb(HotplugHandler *hotplug_dev, DeviceState *dev,
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index b1e5f4a8fa..809ed7de60 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -17,6 +17,8 @@
 #define COMPONENT_REG_BAR_IDX 0
 #define DEVICE_REG_BAR_IDX 2
 
+#define TYPE_CXL_TYPE3_DEV "cxl-type3"
+
 #define CXL_HOST_BASE 0xD0000000
 #define CXL_WINDOW_MAX 10
 
diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
index a53c2e5ae7..9ec28c9feb 100644
--- a/include/hw/cxl/cxl_pci.h
+++ b/include/hw/cxl/cxl_pci.h
@@ -64,6 +64,28 @@ _Static_assert(sizeof(struct dvsec_header) == 10,
  * CXL 2.0 Downstream Port: 3, 4, 7, 8
  */
 
+/* CXL 2.0 - 8.1.3 (ID 0001) */
+struct dvsec_device {
+    struct dvsec_header hdr;
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
+};
+_Static_assert(sizeof(struct dvsec_device) == 0x38,
+               "dvsec device size incorrect");
+
 /* CXL 2.0 - 8.1.5 (ID 0003) */
 struct extensions_dvsec_port {
     struct dvsec_header hdr;
diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
index 11f8ab7149..76bf3ed590 100644
--- a/include/hw/pci/pci_ids.h
+++ b/include/hw/pci/pci_ids.h
@@ -53,6 +53,7 @@
 #define PCI_BASE_CLASS_MEMORY            0x05
 #define PCI_CLASS_MEMORY_RAM             0x0500
 #define PCI_CLASS_MEMORY_FLASH           0x0501
+#define PCI_CLASS_MEMORY_CXL             0x0502
 #define PCI_CLASS_MEMORY_OTHER           0x0580
 
 #define PCI_BASE_CLASS_BRIDGE            0x06
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index a48bc1e904..1c8edfb136 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1884,6 +1884,21 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
                 monitor_printf(mon, "  hotpluggable: %s\n",
                                di->hotpluggable ? "true" : "false");
                 break;
+            case MEMORY_DEVICE_INFO_KIND_CXL:
+                di = value->u.cxl.data;
+                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
+                               MemoryDeviceInfoKind_str(value->type),
+                               di->id ? di->id : "");
+                monitor_printf(mon, "  addr: 0x%" PRIx64 "\n", di->addr);
+                monitor_printf(mon, "  slot: %" PRId64 "\n", di->slot);
+                monitor_printf(mon, "  node: %" PRId64 "\n", di->node);
+                monitor_printf(mon, "  size: %" PRIu64 "\n", di->size);
+                monitor_printf(mon, "  memdev: %s\n", di->memdev);
+                monitor_printf(mon, "  hotplugged: %s\n",
+                               di->hotplugged ? "true" : "false");
+                monitor_printf(mon, "  hotpluggable: %s\n",
+                               di->hotpluggable ? "true" : "false");
+                break;
             case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
                 vpi = value->u.virtio_pmem.data;
                 monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
diff --git a/qapi/machine.json b/qapi/machine.json
index 330189efe3..aa96d662bd 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1394,6 +1394,7 @@
 { 'union': 'MemoryDeviceInfo',
   'data': { 'dimm': 'PCDIMMDeviceInfo',
             'nvdimm': 'PCDIMMDeviceInfo',
+            'cxl': 'PCDIMMDeviceInfo',
             'virtio-pmem': 'VirtioPMEMDeviceInfo',
             'virtio-mem': 'VirtioMEMDeviceInfo'
           }
-- 
2.30.0

