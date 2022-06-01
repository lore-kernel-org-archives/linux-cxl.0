Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3E0C43334
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Jun 2022 16:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350313AbiFAQqJ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239231AbiFAQqI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Jun 2022 12:46:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664899D07B
        for <linux-cxl@vger.kernel.org>; Wed,  1 Jun 2022 09:46:07 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCw482Fj0z6H6lG;
        Thu,  2 Jun 2022 00:45:12 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 18:46:05 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 17:46:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 7/8] hw/cxl: Move the CXLState from MachineState to machine type specific state.
Date:   Wed, 1 Jun 2022 17:42:34 +0100
Message-ID: <20220601164235.2117-8-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
References: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This removes the last of the CXL code from the MachineState where it
is visible to all Machines to only those that support CXL (currently i386/pc)
As i386/pc always support CXL now, stop allocating the state independently.

Note the pxb register hookup code runs even if cxl=off in order to detect
pxb_cxl host bridges and fail to start if any are present as they won't
have the control registers available.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/core/machine.c    |  6 ------
 hw/i386/acpi-build.c |  6 +++---
 hw/i386/pc.c         | 33 ++++++++++++++++-----------------
 include/hw/boards.h  |  1 -
 include/hw/i386/pc.h |  2 ++
 5 files changed, 21 insertions(+), 27 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 87787b5604..eb3f1b5302 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -33,7 +33,6 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
-#include "hw/cxl/cxl.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
 #include "exec/confidential-guest-support.h"
@@ -1074,10 +1073,6 @@ static void machine_initfn(Object *obj)
                                         "Valid values are cpu, mem-ctrl");
     }
 
-    if (mc->cxl_supported) {
-        ms->cxl_devices_state = g_new0(CXLState, 1);
-    }
-
     if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state = g_new0(NumaState, 1);
         object_property_add_bool(obj, "hmat",
@@ -1115,7 +1110,6 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
-    g_free(ms->cxl_devices_state);
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2e3b1dd9a2..e8b7844841 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1633,7 +1633,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
             /* Handle the ranges for the PXB expanders */
             if (pci_bus_is_cxl(bus)) {
-                MemoryRegion *mr = &machine->cxl_devices_state->host_mr;
+                MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
                 uint64_t base = mr->addr;
 
                 cxl_present = true;
@@ -2711,9 +2711,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           machine->nvdimms_state, machine->ram_slots,
                           x86ms->oem_id, x86ms->oem_table_id);
     }
-    if (machine->cxl_devices_state->is_enabled) {
+    if (pcms->cxl_devices_state.is_enabled) {
         cxl_build_cedt(table_offsets, tables_blob, tables->linker,
-                       x86ms->oem_id, x86ms->oem_table_id, machine->cxl_devices_state);
+                       x86ms->oem_id, x86ms->oem_table_id, &pcms->cxl_devices_state);
     }
 
     acpi_add_table(table_offsets, tables_blob);
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 9f48d02739..a0c0d69698 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -733,12 +733,12 @@ void pc_machine_done(Notifier *notifier, void *data)
     PCMachineState *pcms = container_of(notifier,
                                         PCMachineState, machine_done);
     X86MachineState *x86ms = X86_MACHINE(pcms);
-    MachineState *ms = MACHINE(pcms);
 
-    if (ms->cxl_devices_state) {
-        cxl_hook_up_pxb_registers(pcms->bus, ms->cxl_devices_state,
-                                  &error_fatal);
-        cxl_fmws_link_targets(ms->cxl_devices_state, &error_fatal);
+    cxl_hook_up_pxb_registers(pcms->bus, &pcms->cxl_devices_state,
+                              &error_fatal);
+
+    if (pcms->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&pcms->cxl_devices_state, &error_fatal);
     }
 
     /* set the number of CPUs */
@@ -908,8 +908,8 @@ void pc_memory_init(PCMachineState *pcms,
                                     &machine->device_memory->mr);
     }
 
-    if (machine->cxl_devices_state->is_enabled) {
-        MemoryRegion *mr = &machine->cxl_devices_state->host_mr;
+    if (pcms->cxl_devices_state.is_enabled) {
+        MemoryRegion *mr = &pcms->cxl_devices_state.host_mr;
         hwaddr cxl_size = MiB;
 
         if (pcmc->has_reserved_memory && machine->device_memory->base) {
@@ -927,12 +927,12 @@ void pc_memory_init(PCMachineState *pcms,
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_resv_end = cxl_base + cxl_size;
-        if (machine->cxl_devices_state->fixed_windows) {
+        if (pcms->cxl_devices_state.fixed_windows) {
             hwaddr cxl_fmw_base;
             GList *it;
 
             cxl_fmw_base = ROUND_UP(cxl_base + cxl_size, 256 * MiB);
-            for (it = machine->cxl_devices_state->fixed_windows; it; it = it->next) {
+            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
                 CXLFixedWindow *fw = it->data;
 
                 fw->base = cxl_fmw_base;
@@ -974,7 +974,7 @@ void pc_memory_init(PCMachineState *pcms,
             res_mem_end += memory_region_size(&machine->device_memory->mr);
         }
 
-        if (machine->cxl_devices_state->is_enabled) {
+        if (pcms->cxl_devices_state.is_enabled) {
             res_mem_end = cxl_resv_end;
         }
         *val = cpu_to_le64(ROUND_UP(res_mem_end, 1 * GiB));
@@ -1010,12 +1010,12 @@ uint64_t pc_pci_hole64_start(void)
     X86MachineState *x86ms = X86_MACHINE(pcms);
     uint64_t hole64_start = 0;
 
-    if (ms->cxl_devices_state->host_mr.addr) {
-        hole64_start = ms->cxl_devices_state->host_mr.addr +
-            memory_region_size(&ms->cxl_devices_state->host_mr);
-        if (ms->cxl_devices_state->fixed_windows) {
+    if (pcms->cxl_devices_state.host_mr.addr) {
+        hole64_start = pcms->cxl_devices_state.host_mr.addr +
+            memory_region_size(&pcms->cxl_devices_state.host_mr);
+        if (pcms->cxl_devices_state.fixed_windows) {
             GList *it;
-            for (it = ms->cxl_devices_state->fixed_windows; it; it = it->next) {
+            for (it = pcms->cxl_devices_state.fixed_windows; it; it = it->next) {
                 CXLFixedWindow *fw = it->data;
                 hole64_start = fw->mr.addr + memory_region_size(&fw->mr);
             }
@@ -1691,7 +1691,6 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
-    MachineState *ms = MACHINE(obj);
 
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
@@ -1716,7 +1715,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
-    cxl_machine_init(obj, ms->cxl_devices_state);
+    cxl_machine_init(obj, &pcms->cxl_devices_state);
 }
 
 static void pc_machine_reset(MachineState *machine)
diff --git a/include/hw/boards.h b/include/hw/boards.h
index dd9fc56df2..031f5f884d 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -360,7 +360,6 @@ struct MachineState {
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
-    struct CXLState *cxl_devices_state;
     struct NumaState *numa_state;
     CXLFixedMemoryWindowOptionsList *cfmws_list;
 };
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index ffcac5121e..21be7aff26 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -14,6 +14,7 @@
 #include "qom/object.h"
 #include "hw/i386/sgx-epc.h"
 #include "hw/firmware/smbios.h"
+#include "hw/cxl/cxl.h"
 
 #define HPET_INTCAP "hpet-intcap"
 
@@ -55,6 +56,7 @@ typedef struct PCMachineState {
     hwaddr memhp_io_base;
 
     SGXEPCState sgx_epc;
+    CXLState cxl_devices_state;
 } PCMachineState;
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
-- 
2.32.0

