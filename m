Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19773C433E6
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA7E064EE6
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbhBBBCP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:02:15 -0500
Received: from mga06.intel.com ([134.134.136.31]:21903 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229832AbhBBBCP (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:02:15 -0500
IronPort-SDR: rzm651cOQgdjviDllgdaMKw7xZ8r8o/5HYdqu1yg/bUUp98jbN90AEywY6+5+H2FTK0B68FmAT
 Zu/XfU0QqugA==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294676"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294676"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:26 -0800
IronPort-SDR: pID+Kk5wCa5xaL+elfLvZdOkQuGpMMDz8H4DHkOjyytAIxzDnvaSzejO8eGDm8HB+SuaiPLV+k
 +ZKSh/sVum1w==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764297"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:25 -0800
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
Subject: [RFC PATCH v3 31/31] WIP: i386/cxl: Initialize a host bridge
Date:   Mon,  1 Feb 2021 16:59:48 -0800
Message-Id: <20210202005948.241655-32-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This patch allows initializing the primary host bridge as a CXL capable
hostbridge.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

--
This patch is WIP.
---
 hw/arm/virt.c        |  1 +
 hw/core/machine.c    | 26 ++++++++++++++++++++++++++
 hw/i386/acpi-build.c |  8 +++++++-
 hw/i386/microvm.c    |  1 +
 hw/i386/pc.c         |  1 +
 hw/ppc/spapr.c       |  2 ++
 include/hw/boards.h  |  2 ++
 include/hw/cxl/cxl.h |  4 ++++
 8 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 399da73454..fd5f5b656c 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2547,6 +2547,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug_request = virt_machine_device_unplug_request_cb;
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
+    mc->cxl_supported = false;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     mc->default_ram_id = "mach-virt.ram";
diff --git a/hw/core/machine.c b/hw/core/machine.c
index de3b8f1b31..c739803854 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -30,6 +30,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/cxl/cxl.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
 
@@ -502,6 +503,20 @@ static void machine_set_nvdimm_persistence(Object *obj, const char *value,
     nvdimms_state->persistence_string = g_strdup(value);
 }
 
+static bool machine_get_cxl(Object *obj, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    return ms->cxl_devices_state->is_enabled;
+}
+
+static void machine_set_cxl(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms = MACHINE(obj);
+
+    ms->cxl_devices_state->is_enabled = value;
+}
+
 void machine_class_allow_dynamic_sysbus_dev(MachineClass *mc, const char *type)
 {
     QAPI_LIST_PREPEND(mc->allowed_dynamic_sysbus_devices, g_strdup(type));
@@ -903,6 +918,16 @@ static void machine_initfn(Object *obj)
                                         "Valid values are cpu, mem-ctrl");
     }
 
+    if (mc->cxl_supported) {
+        Object *obj = OBJECT(ms);
+
+        ms->cxl_devices_state = g_new0(CXLState, 1);
+        object_property_add_bool(obj, "cxl", machine_get_cxl, machine_set_cxl);
+        object_property_set_description(obj, "cxl",
+                                        "Set on/off to enable/disable "
+                                        "CXL instantiation");
+    }
+
     if (mc->cpu_index_to_instance_props && mc->get_default_cpu_node_id) {
         ms->numa_state = g_new0(NumaState, 1);
         object_property_add_bool(obj, "hmat",
@@ -939,6 +964,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
+    g_free(ms->cxl_devices_state);
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 7706856c49..2250e6d27b 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -53,6 +53,7 @@
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 #include "hw/hyperv/vmbus-bridge.h"
+#include "hw/cxl/cxl.h"
 
 /* Supported chipsets: */
 #include "hw/southbridge/piix.h"
@@ -1277,8 +1278,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_piix4_pci0_int(dsdt);
     } else {
         sb_scope = aml_scope("_SB");
+        /*
+         * XXX: CXL spec calls this "CXL0", but that would require lots of
+         * changes throughout and so even for CXL enabled, we call it "PCI0"
+         */
         dev = aml_device("PCI0");
-        init_pci_acpi(dev, 0, PCIE);
+        init_pci_acpi(dev, 0,
+                machine->cxl_devices_state->is_enabled ? CXL : PCIE);
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
         aml_append(sb_scope, dev);
 
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index edf2b0f061..970b299a69 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -688,6 +688,7 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->auto_enable_numa_with_memdev = false;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = false;
+    mc->cxl_supported = false;
     mc->default_ram_id = "microvm.ram";
 
     /* Avoid relying too much on kernel components */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5d41809b37..7350eeea9c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1725,6 +1725,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = pc_machine_device_unplug_cb;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
+    mc->cxl_supported = true;
     mc->default_ram_id = "pc.ram";
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6c47466fc2..9773dbd83c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4440,6 +4440,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
+    mc->cxl_supported = false;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
@@ -4600,6 +4601,7 @@ static void spapr_machine_4_2_class_options(MachineClass *mc)
     smc->default_caps.caps[SPAPR_CAP_FWNMI] = SPAPR_CAP_OFF;
     smc->rma_limit = 16 * GiB;
     mc->nvdimm_supported = false;
+    mc->cxl_supported = false;
 }
 
 DEFINE_SPAPR_MACHINE(4_2, "4.2", false);
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 17b1f3f0b9..808f73e134 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -206,6 +206,7 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
+    bool cxl_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
     const char *default_ram_id;
@@ -292,6 +293,7 @@ struct MachineState {
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
+    struct CXLState *cxl_devices_state;
     struct NumaState *numa_state;
 };
 
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index c7ca42930f..784b4f7a04 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -22,4 +22,8 @@
 #define CXL_HOST_BASE 0xD0000000
 #define CXL_WINDOW_MAX 10
 
+typedef struct CXLState {
+    bool is_enabled;
+} CXLState;
+
 #endif
-- 
2.30.0

