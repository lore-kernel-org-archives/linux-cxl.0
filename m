Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44FAEC433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Jun 2022 15:22:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244314AbiFHPWB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Jun 2022 11:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245145AbiFHPUJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Jun 2022 11:20:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FB01FC836
        for <linux-cxl@vger.kernel.org>; Wed,  8 Jun 2022 08:17:03 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LJ9BL5KKnz67x9D;
        Wed,  8 Jun 2022 22:50:18 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 16:55:04 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2375.24; Wed, 8 Jun 2022 15:55:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v3 1/8] hw/cxl: Make the CXL fixed memory window setup a machine parameter.
Date:   Wed, 8 Jun 2022 15:54:33 +0100
Message-ID: <20220608145440.26106-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608145440.26106-1-Jonathan.Cameron@huawei.com>
References: <20220608145440.26106-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Paolo Bonzini requested this change to simplify the ongoing
effort to allow machine setup entirely via RPC.

Includes shortening the command line form cxl-fixed-memory-window
to cxl-fmw as the command lines are extremely long even with this
change.

The json change is needed to ensure that there is
a CXLFixedMemoryWindowOptionsList even though the actual
element in the json is never used. Similar to existing
SgxEpcProperties.

Update qemu-options.hx to reflect that this is now a -machine
parameter.  The bulk of -M / -machine parameters are documented
under machine, so use that in preference to M.

Update cxl-test and bios-tables-test to reflect new parameters.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ben Widawsky <ben@bwidawsk.net>
Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
---
 docs/system/devices/cxl.rst         |  4 +-
 hw/core/machine.c                   | 22 ---------
 hw/cxl/cxl-host-stubs.c             |  6 +--
 hw/cxl/cxl-host.c                   | 72 ++++++++++++++++++++++++++--
 hw/i386/pc.c                        |  3 ++
 hw/pci-bridge/pci_expander_bridge.c |  2 +-
 include/hw/boards.h                 |  1 +
 include/hw/cxl/cxl.h                |  7 +--
 include/hw/cxl/cxl_host.h           | 21 +++++++++
 qapi/machine.json                   | 13 +++++
 qemu-options.hx                     | 73 ++++++++++++++---------------
 softmmu/vl.c                        | 44 -----------------
 tests/qtest/bios-tables-test.c      |  4 +-
 tests/qtest/cxl-test.c              |  4 +-
 14 files changed, 150 insertions(+), 126 deletions(-)

diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
index 9293cbf01a..bcbfe8c490 100644
--- a/docs/system/devices/cxl.rst
+++ b/docs/system/devices/cxl.rst
@@ -251,7 +251,7 @@ A very simple setup with just one directly attached CXL Type 3 device::
   -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
   -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
   -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
-  -cxl-fixed-memory-window targets.0=cxl.1,size=4G
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
 
 A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
 interleave across 2 CXL host bridges.  Each host bridge has 2 CXL Root Ports, with
@@ -277,7 +277,7 @@ the CXL Type3 device directly attached (no switches).::
   -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
   -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
   -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
-  -cxl-fixed-memory-window targets.0=cxl.1,targets.1=cxl.2,size=4G,interleave-granularity=8k
+  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
 
 Kernel Configuration Options
 ----------------------------
diff --git a/hw/core/machine.c b/hw/core/machine.c
index c53548d0b1..2e589d99e9 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -629,20 +629,6 @@ static void machine_set_nvdimm_persistence(Object *obj, const char *value,
     nvdimms_state->persistence_string = g_strdup(value);
 }
 
-static bool machine_get_cxl(Object *obj, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    return ms->cxl_devices_state->is_enabled;
-}
-
-static void machine_set_cxl(Object *obj, bool value, Error **errp)
-{
-    MachineState *ms = MACHINE(obj);
-
-    ms->cxl_devices_state->is_enabled = value;
-}
-
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
 {
     QAPI_LIST_PREPEND(mc->allowed_dynamic_sysbus_devices, g_strdup(type));
@@ -929,8 +915,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
 
-    /* Few machines support CXL, so default to off */
-    mc->cxl_supported = false;
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
      */
@@ -1092,13 +1076,7 @@ static void machine_initfn(Object *obj)
     }
 
     if (mc->cxl_supported) {
-        Object *obj = OBJECT(ms);
-
         ms->cxl_devices_state = g_new0(CXLState, 1);
-        object_property_add_bool(obj, "cxl", machine_get_cxl, machine_set_cxl);
-        object_property_set_description(obj, "cxl",
-                                        "Set on/off to enable/disable "
-                                        "CXL instantiation");
     }
 
     if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index 24465a52ab..de3e8894d5 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -6,11 +6,9 @@
 #include "qemu/osdep.h"
 #include "qapi/error.h"
 #include "hw/cxl/cxl.h"
-
-void cxl_fixed_memory_window_config(MachineState *ms,
-                                    CXLFixedMemoryWindowOptions *object,
-                                    Error **errp) {};
+#include "hw/cxl/cxl_host.h"
 
 void cxl_fixed_memory_window_link_targets(Error **errp) {};
+void cxl_machine_init(Object *obj, CXLState *state) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 469b3c4ced..3a79c32b42 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -15,14 +15,15 @@
 
 #include "qapi/qapi-visit-machine.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "hw/pci/pcie_port.h"
 
-void cxl_fixed_memory_window_config(MachineState *ms,
-                                    CXLFixedMemoryWindowOptions *object,
-                                    Error **errp)
+static void cxl_fixed_memory_window_config(CXLState *cxl_state,
+                                           CXLFixedMemoryWindowOptions *object,
+                                           Error **errp)
 {
     CXLFixedWindow *fw = g_malloc0(sizeof(*fw));
     strList *target;
@@ -62,8 +63,7 @@ void cxl_fixed_memory_window_config(MachineState *ms,
         fw->enc_int_gran = 0;
     }
 
-    ms->cxl_devices_state->fixed_windows =
-        g_list_append(ms->cxl_devices_state->fixed_windows, fw);
+    cxl_state->fixed_windows = g_list_append(cxl_state->fixed_windows, fw);
 
     return;
 }
@@ -220,3 +220,65 @@ const MemoryRegionOps cfmws_ops = {
         .unaligned = true,
     },
 };
+
+static void machine_get_cxl(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    CXLState *cxl_state = opaque;
+    bool value = cxl_state->is_enabled;
+
+    visit_type_bool(v, name, &value, errp);
+}
+
+static void machine_set_cxl(Object *obj, Visitor *v, const char *name,
+                            void *opaque, Error **errp)
+{
+    CXLState *cxl_state = opaque;
+    bool value;
+
+    if (!visit_type_bool(v, name, &value, errp)) {
+        return;
+    }
+    cxl_state->is_enabled = value;
+}
+
+static void machine_get_cfmw(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    CXLFixedMemoryWindowOptionsList **list = opaque;
+
+    visit_type_CXLFixedMemoryWindowOptionsList(v, name, list, errp);
+}
+
+static void machine_set_cfmw(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    CXLState *state = opaque;
+    CXLFixedMemoryWindowOptionsList *cfmw_list = NULL;
+    CXLFixedMemoryWindowOptionsList *it;
+
+    visit_type_CXLFixedMemoryWindowOptionsList(v, name, &cfmw_list, errp);
+    if (!cfmw_list) {
+        return;
+    }
+
+    for (it = cfmw_list; it; it = it->next) {
+        cxl_fixed_memory_window_config(state, it->value, errp);
+    }
+    state->cfmw_list = cfmw_list;
+}
+
+void cxl_machine_init(Object *obj, CXLState *state)
+{
+    object_property_add(obj, "cxl", "bool", machine_get_cxl,
+                        machine_set_cxl, NULL, state);
+    object_property_set_description(obj, "cxl",
+                                    "Set on/off to enable/disable "
+                                    "CXL instantiation");
+
+    object_property_add(obj, "cxl-fmw", "CXLFixedMemoryWindow",
+                        machine_get_cfmw, machine_set_cfmw,
+                        NULL, state);
+    object_property_set_description(obj, "cxl-fmw",
+                                    "CXL Fixed Memory Windows (array)");
+}
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7c39c91335..98e63347f2 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -76,6 +76,7 @@
 #include "hw/mem/pc-dimm.h"
 #include "hw/mem/nvdimm.h"
 #include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-common.h"
 #include "qapi/qapi-visit-machine.h"
@@ -1682,6 +1683,7 @@ static void pc_machine_set_max_fw_size(Object *obj, Visitor *v,
 static void pc_machine_initfn(Object *obj)
 {
     PCMachineState *pcms = PC_MACHINE(obj);
+    MachineState *ms = MACHINE(obj);
 
 #ifdef CONFIG_VMPORT
     pcms->vmport = ON_OFF_AUTO_AUTO;
@@ -1706,6 +1708,7 @@ static void pc_machine_initfn(Object *obj)
     pcms->pcspk = isa_new(TYPE_PC_SPEAKER);
     object_property_add_alias(OBJECT(pcms), "pcspk-audiodev",
                               OBJECT(pcms->pcspk), "audiodev");
+    cxl_machine_init(obj, ms->cxl_devices_state);
 }
 
 static void pc_machine_reset(MachineState *machine)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 69244decdb..02032360f5 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -468,7 +468,7 @@ static void pxb_cxl_dev_realize(PCIDevice *dev, Error **errp)
         error_setg(errp, "pxb-cxl devices cannot reside on a PCI bus");
         return;
     }
-    if (!ms->cxl_devices_state->is_enabled) {
+    if (!ms->cxl_devices_state || !ms->cxl_devices_state->is_enabled) {
         error_setg(errp, "Machine does not have cxl=on");
         return;
     }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index fa57bac4fb..dd9fc56df2 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -362,6 +362,7 @@ struct MachineState {
     struct NVDIMMState *nvdimms_state;
     struct CXLState *cxl_devices_state;
     struct NumaState *numa_state;
+    CXLFixedMemoryWindowOptionsList *cfmws_list;
 };
 
 #define DEFINE_MACHINE(namestr, machine_initfn) \
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 21d28ca110..84078a484d 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -12,6 +12,7 @@
 
 
 #include "qapi/qapi-types-machine.h"
+#include "qapi/qapi-visit-machine.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_host.h"
 #include "cxl_pci.h"
@@ -40,6 +41,7 @@ typedef struct CXLState {
     MemoryRegion host_mr;
     unsigned int next_mr_idx;
     GList *fixed_windows;
+    CXLFixedMemoryWindowOptionsList *cfmw_list;
 } CXLState;
 
 struct CXLHost {
@@ -51,11 +53,6 @@ struct CXLHost {
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 
-void cxl_fixed_memory_window_config(MachineState *ms,
-                                    CXLFixedMemoryWindowOptions *object,
-                                    Error **errp);
 void cxl_fixed_memory_window_link_targets(Error **errp);
 
-extern const MemoryRegionOps cfmws_ops;
-
 #endif
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
new file mode 100644
index 0000000000..87a6933de2
--- /dev/null
+++ b/include/hw/cxl/cxl_host.h
@@ -0,0 +1,21 @@
+/*
+ * QEMU CXL Host Setup
+ *
+ * Copyright (c) 2022 Huawei
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2. See the
+ * COPYING file in the top-level directory.
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cxl/cxl.h"
+#include "hw/boards.h"
+
+#ifndef CXL_HOST_H
+#define CXL_HOST_H
+
+void cxl_machine_init(Object *obj, CXLState *state);
+
+extern const MemoryRegionOps cfmws_ops;
+
+#endif
diff --git a/qapi/machine.json b/qapi/machine.json
index f750a16396..6afd1936b0 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -523,6 +523,19 @@
       '*interleave-granularity': 'size',
       'targets': ['str'] }}
 
+##
+# @CXLFMWProperties:
+#
+# List of CXL Fixed Memory Windows.
+#
+# @cxl-fmw: List of CXLFixedMemoryWindowOptions
+#
+# Since 7.1
+##
+{ 'struct' : 'CXLFMWProperties',
+  'data': { 'cxl-fmw': ['CXLFixedMemoryWindowOptions'] }
+}
+
 ##
 # @X86CPURegister32:
 #
diff --git a/qemu-options.hx b/qemu-options.hx
index 60cf188da4..377d22fbd8 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -36,7 +36,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                nvdimm=on|off controls NVDIMM support (default=off)\n"
     "                memory-encryption=@var{} memory encryption object to use (default=none)\n"
     "                hmat=on|off controls ACPI HMAT support (default=off)\n"
-    "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n",
+    "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
+    "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -124,6 +125,38 @@ SRST
             -object memory-backend-ram,id=pc.ram,size=512M,x-use-canonical-path-for-ramblock-id=off
             -machine memory-backend=pc.ram
             -m 512M
+
+    ``cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]``
+        Define a CXL Fixed Memory Window (CFMW).
+
+        Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
+
+        They are regions of Host Physical Addresses (HPA) on a system which
+        may be interleaved across one or more CXL host bridges.  The system
+        software will assign particular devices into these windows and
+        configure the downstream Host-managed Device Memory (HDM) decoders
+        in root ports, switch ports and devices appropriately to meet the
+        interleave requirements before enabling the memory devices.
+
+        ``targets.X=target`` provides the mapping to CXL host bridges
+        which may be identified by the id provied in the -device entry.
+        Multiple entries are needed to specify all the targets when
+        the fixed memory window represents interleaved memory. X is the
+        target index from 0.
+
+        ``size=size`` sets the size of the CFMW. This must be a multiple of
+        256MiB. The region will be aligned to 256MiB but the location is
+        platform and configuration dependent.
+
+        ``interleave-granularity=granularity`` sets the granularity of
+        interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
+        4096KiB, 8192KiB and 16384KiB granularities supported.
+
+        Example:
+
+        ::
+
+            -machine cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=128G,cxl-fmw.0.interleave-granularity=512k
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
@@ -467,44 +500,6 @@ SRST
         -numa hmat-cache,node-id=1,size=10K,level=1,associativity=direct,policy=write-back,line=8
 ERST
 
-DEF("cxl-fixed-memory-window", HAS_ARG, QEMU_OPTION_cxl_fixed_memory_window,
-    "-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]\n",
-    QEMU_ARCH_ALL)
-SRST
-``-cxl-fixed-memory-window targets.0=firsttarget,targets.1=secondtarget,size=size[,interleave-granularity=granularity]``
-    Define a CXL Fixed Memory Window (CFMW).
-
-    Described in the CXL 2.0 ECN: CEDT CFMWS & QTG _DSM.
-
-    They are regions of Host Physical Addresses (HPA) on a system which
-    may be interleaved across one or more CXL host bridges.  The system
-    software will assign particular devices into these windows and
-    configure the downstream Host-managed Device Memory (HDM) decoders
-    in root ports, switch ports and devices appropriately to meet the
-    interleave requirements before enabling the memory devices.
-
-    ``targets.X=firsttarget`` provides the mapping to CXL host bridges
-    which may be identified by the id provied in the -device entry.
-    Multiple entries are needed to specify all the targets when
-    the fixed memory window represents interleaved memory. X is the
-    target index from 0.
-
-    ``size=size`` sets the size of the CFMW. This must be a multiple of
-    256MiB. The region will be aligned to 256MiB but the location is
-    platform and configuration dependent.
-
-    ``interleave-granularity=granularity`` sets the granularity of
-    interleave. Default 256KiB. Only 256KiB, 512KiB, 1024KiB, 2048KiB
-    4096KiB, 8192KiB and 16384KiB granularities supported.
-
-    Example:
-
-    ::
-
-        -cxl-fixed-memory-window targets.0=cxl.0,targets.1=cxl.1,size=128G,interleave-granularity=512k
-
-ERST
-
 DEF("add-fd", HAS_ARG, QEMU_OPTION_add_fd,
     "-add-fd fd=fd,set=set[,opaque=opaque]\n"
     "                Add 'fd' to fd 'set'\n", QEMU_ARCH_ALL)
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 4c1e94b00e..ff0ad9ab54 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -147,12 +147,6 @@ typedef struct BlockdevOptionsQueueEntry {
 
 typedef QSIMPLEQ_HEAD(, BlockdevOptionsQueueEntry) BlockdevOptionsQueue;
 
-typedef struct CXLFMWOptionQueueEntry {
-    CXLFixedMemoryWindowOptions *opts;
-    Location loc;
-    QSIMPLEQ_ENTRY(CXLFMWOptionQueueEntry) entry;
-} CXLFMWOptionQueueEntry;
-
 typedef struct ObjectOption {
     ObjectOptions *opts;
     QTAILQ_ENTRY(ObjectOption) next;
@@ -179,8 +173,6 @@ static int snapshot;
 static bool preconfig_requested;
 static QemuPluginList plugin_list = QTAILQ_HEAD_INITIALIZER(plugin_list);
 static BlockdevOptionsQueue bdo_queue = QSIMPLEQ_HEAD_INITIALIZER(bdo_queue);
-static QSIMPLEQ_HEAD(, CXLFMWOptionQueueEntry) CXLFMW_opts =
-    QSIMPLEQ_HEAD_INITIALIZER(CXLFMW_opts);
 static bool nographic = false;
 static int mem_prealloc; /* force preallocation of physical target memory */
 static const char *vga_model = NULL;
@@ -1072,24 +1064,6 @@ static void parse_display(const char *p)
     }
 }
 
-static void parse_cxl_fixed_memory_window(const char *optarg)
-{
-    CXLFMWOptionQueueEntry *cfmws_entry;
-    Visitor *v;
-
-    v = qobject_input_visitor_new_str(optarg, "cxl-fixed-memory-window",
-                                      &error_fatal);
-    cfmws_entry = g_new(CXLFMWOptionQueueEntry, 1);
-    visit_type_CXLFixedMemoryWindowOptions(v, NULL, &cfmws_entry->opts,
-                                           &error_fatal);
-    if (!cfmws_entry->opts) {
-        exit(1);
-    }
-    visit_free(v);
-    loc_save(&cfmws_entry->loc);
-    QSIMPLEQ_INSERT_TAIL(&CXLFMW_opts, cfmws_entry, entry);
-}
-
 static inline bool nonempty_str(const char *str)
 {
     return str && *str;
@@ -1948,20 +1922,6 @@ static void qemu_create_late_backends(void)
     qemu_semihosting_console_init();
 }
 
-static void cxl_set_opts(void)
-{
-    while (!QSIMPLEQ_EMPTY(&CXLFMW_opts)) {
-        CXLFMWOptionQueueEntry *cfmws_entry = QSIMPLEQ_FIRST(&CXLFMW_opts);
-
-        loc_restore(&cfmws_entry->loc);
-        QSIMPLEQ_REMOVE_HEAD(&CXLFMW_opts, entry);
-        cxl_fixed_memory_window_config(current_machine, cfmws_entry->opts,
-                                       &error_fatal);
-        qapi_free_CXLFixedMemoryWindowOptions(cfmws_entry->opts);
-        g_free(cfmws_entry);
-    }
-}
-
 static void qemu_resolve_machine_memdev(void)
 {
     if (ram_memdev_id) {
@@ -2789,9 +2749,6 @@ void qemu_init(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
-            case QEMU_OPTION_cxl_fixed_memory_window:
-                parse_cxl_fixed_memory_window(optarg);
-                break;
             case QEMU_OPTION_display:
                 parse_display(optarg);
                 break;
@@ -3598,7 +3555,6 @@ void qemu_init(int argc, char **argv, char **envp)
 
     qemu_resolve_machine_memdev();
     parse_numa_opts(current_machine);
-    cxl_set_opts();
 
     if (vmstate_dump_file) {
         /* dump and exit */
diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
index a4a46e97f0..8a3a320aea 100644
--- a/tests/qtest/bios-tables-test.c
+++ b/tests/qtest/bios-tables-test.c
@@ -1567,8 +1567,8 @@ static void test_acpi_q35_cxl(void)
                              " -device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3"
                              " -device cxl-rp,port=1,bus=cxl.2,id=rp4,chassis=0,slot=6"
                              " -device cxl-type3,bus=rp4,memdev=cxl-mem4,lsa=lsa4"
-                             " -cxl-fixed-memory-window targets.0=cxl.1,size=4G,interleave-granularity=8k"
-                             " -cxl-fixed-memory-window targets.0=cxl.1,targets.1=cxl.2,size=4G,interleave-granularity=8k",
+                             " -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k,"
+                             "cxl-fmw.1.targets.0=cxl.1,cxl-fmw.1.targets.1=cxl.2,cxl-fmw.1.size=4G,cxl-fmw.1.interleave-granularity=8k",
                              tmp_path, tmp_path, tmp_path, tmp_path,
                              tmp_path, tmp_path, tmp_path, tmp_path);
     test_acpi_one(params, &data);
diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
index 079011af6a..2133e973f4 100644
--- a/tests/qtest/cxl-test.c
+++ b/tests/qtest/cxl-test.c
@@ -10,12 +10,12 @@
 
 #define QEMU_PXB_CMD "-machine q35,cxl=on " \
                      "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
-                     "-cxl-fixed-memory-window targets.0=cxl.0,size=4G "
+                     "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.size=4G "
 
 #define QEMU_2PXB_CMD "-machine q35,cxl=on "                            \
                       "-device pxb-cxl,id=cxl.0,bus=pcie.0,bus_nr=52 "  \
                       "-device pxb-cxl,id=cxl.1,bus=pcie.0,bus_nr=53 " \
-                      "-cxl-fixed-memory-window targets.0=cxl.0,targets.1=cxl.1,size=4G "
+                      "-M cxl-fmw.0.targets.0=cxl.0,cxl-fmw.0.targets.1=cxl.1,cxl-fmw.0.size=4G "
 
 #define QEMU_RP "-device cxl-rp,id=rp0,bus=cxl.0,chassis=0,slot=0 "
 
-- 
2.32.0

