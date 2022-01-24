Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60128C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232076AbiAXRZt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:25:49 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4462 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244513AbiAXRZr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:25:47 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjGx81J0Sz6FBMZ;
        Tue, 25 Jan 2022 01:21:32 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:25:45 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:25:44 +0000
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
Subject: [PATCH v4 17/42] cxl: Machine level control on whether CXL support is enabled
Date:   Mon, 24 Jan 2022 17:16:40 +0000
Message-ID: <20220124171705.10432-18-Jonathan.Cameron@huawei.com>
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

From: Jonathan Cameron <jonathan.cameron@huawei.com>

There are going to be some potential overheads to CXL enablement,
for example the host bridge region reserved in memory maps.
Add a machine level control so that CXL is disabled by default.

Signed-off-by: Jonathan Cameron <jonathan.cameron@huawei.com>
---
 hw/arm/virt.c        |  1 +
 hw/core/machine.c    | 26 ++++++++++++++++++++++++++
 hw/i386/microvm.c    |  1 +
 hw/i386/pc.c         |  1 +
 hw/ppc/spapr.c       |  1 +
 include/hw/boards.h  |  2 ++
 include/hw/cxl/cxl.h |  4 ++++
 7 files changed, 36 insertions(+)

diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 2b6cc7aa9e..cbb18dcba6 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -2856,6 +2856,7 @@ static void virt_machine_class_init(ObjectClass *oc, void *data)
     hc->unplug = virt_machine_device_unplug_cb;
     mc->nvdimm_supported = true;
     mc->smp_props.clusters_supported = true;
+    mc->cxl_supported = false;
     mc->auto_enable_numa_with_memhp = true;
     mc->auto_enable_numa_with_memdev = true;
     mc->default_ram_id = "mach-virt.ram";
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d856485cb4..01b7e1aa37 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -31,6 +31,7 @@
 #include "sysemu/qtest.h"
 #include "hw/pci/pci.h"
 #include "hw/mem/nvdimm.h"
+#include "hw/cxl/cxl.h"
 #include "migration/global_state.h"
 #include "migration/vmstate.h"
 #include "exec/confidential-guest-support.h"
@@ -545,6 +546,20 @@ static void machine_set_nvdimm_persistence(Object *obj, const char *value,
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
@@ -922,6 +937,16 @@ static void machine_initfn(Object *obj)
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
@@ -956,6 +981,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
+    g_free(ms->cxl_devices_state);
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/hw/i386/microvm.c b/hw/i386/microvm.c
index 4b3b1dd262..6381d833fa 100644
--- a/hw/i386/microvm.c
+++ b/hw/i386/microvm.c
@@ -685,6 +685,7 @@ static void microvm_class_init(ObjectClass *oc, void *data)
     mc->auto_enable_numa_with_memdev = false;
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = false;
+    mc->cxl_supported = false;
     mc->default_ram_id = "microvm.ram";
 
     /* Avoid relying too much on kernel components */
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index c8696ac01e..b6800a511a 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1739,6 +1739,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
+    mc->cxl_supported = true;
     mc->default_ram_id = "pc.ram";
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 72f5dce751..56f135833d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4569,6 +4569,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
+    mc->cxl_supported = false;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
     fwc->get_dev_path = spapr_get_fw_dev_path;
     nc->nmi_monitor_handler = spapr_nmi;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index c92ac8815c..680718dafc 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -269,6 +269,7 @@ struct MachineClass {
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
+    bool cxl_supported;
     bool numa_mem_supported;
     bool auto_enable_numa;
     SMPCompatProps smp_props;
@@ -360,6 +361,7 @@ struct MachineState {
     CPUArchIdList *possible_cpus;
     CpuTopology smp;
     struct NVDIMMState *nvdimms_state;
+    struct CXLState *cxl_devices_state;
     struct NumaState *numa_state;
 };
 
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 554ad93b6b..31af92fd5e 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -17,4 +17,8 @@
 #define CXL_COMPONENT_REG_BAR_IDX 0
 #define CXL_DEVICE_REG_BAR_IDX 2
 
+typedef struct CXLState {
+    bool is_enabled;
+} CXLState;
+
 #endif
-- 
2.32.0

