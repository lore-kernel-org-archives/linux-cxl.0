Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E255C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Apr 2022 14:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377862AbiD2OvU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Apr 2022 10:51:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377864AbiD2OvQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Apr 2022 10:51:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FD5B42EB
        for <linux-cxl@vger.kernel.org>; Fri, 29 Apr 2022 07:47:53 -0700 (PDT)
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KqZyf6F3Zz67mY5;
        Fri, 29 Apr 2022 22:44:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 16:47:50 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 15:47:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>, <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <k.jensen@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v10 13/45] cxl: Machine level control on whether CXL support is enabled
Date:   Fri, 29 Apr 2022 15:40:38 +0100
Message-ID: <20220429144110.25167-14-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml727-chm.china.huawei.com (10.201.108.78) To
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/core/machine.c    | 28 ++++++++++++++++++++++++++++
 hw/i386/pc.c         |  1 +
 include/hw/boards.h  |  2 ++
 include/hw/cxl/cxl.h |  4 ++++
 4 files changed, 35 insertions(+)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index cb9bbc844d..6ae2997f16 100644
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
@@ -550,6 +551,20 @@ static void machine_set_nvdimm_persistence(Object *obj, const char *value,
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
@@ -782,6 +797,8 @@ static void machine_class_init(ObjectClass *oc, void *data)
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
 
+    /* Few machines support CXL, so default to off */
+    mc->cxl_supported = false;
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
      */
@@ -927,6 +944,16 @@ static void machine_initfn(Object *obj)
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
@@ -961,6 +988,7 @@ static void machine_finalize(Object *obj)
     g_free(ms->device_memory);
     g_free(ms->nvdimms_state);
     g_free(ms->numa_state);
+    g_free(ms->cxl_devices_state);
 }
 
 bool machine_usb(MachineState *machine)
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 23bba9d82c..b752339beb 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1761,6 +1761,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->default_cpu_type = TARGET_DEFAULT_CPU_TYPE;
     mc->nvdimm_supported = true;
     mc->smp_props.dies_supported = true;
+    mc->cxl_supported = true;
     mc->default_ram_id = "pc.ram";
 
     object_class_property_add(oc, PC_MACHINE_MAX_RAM_BELOW_4G, "size",
diff --git a/include/hw/boards.h b/include/hw/boards.h
index d64b5481e8..f756a1d5fc 100644
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

