Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B2B1B4C23
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 13:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926265; cv=none; b=aVGX2LEQVq1gUDpLENxupB+yfTkZXob+3lmnRPYtCPHSxPaNMve7xCEEVNfTOu5GuhnninKti9VPtnvaIpH7zbxr+fWipObWbfsepymKeEj/3Fa6c0r6e0OPJSXgjY/U7gXEHuBkKDOF9mNqAfb6ZQCDDrd1m8i34Fs4hXrBLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926265; c=relaxed/simple;
	bh=F/0soM9ZeOFQG4ZGE+K76MAPA0HdkaSzYz0MgM43CF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V6VLgmC9gyellcLOFJsqKKWZsruuP8wSClz78lmnpG9ci2ZV7RGZC+bLGRHwJuHwkoozObVv7LJUNEDJ88nc60a1G9o6fpDwZPMFkt9TkjD6i4BdKx+DQNHctOoNCKp1DyfPH9tr7e6BLWxYlRKWnOAOeeYmPqSHHu+uXW5E31Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3Lq0Bhvz6K9pV;
	Tue,  2 Jul 2024 21:15:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 47B22140680;
	Tue,  2 Jul 2024 21:17:38 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:17:37 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 06/13] acpi/pci: Move Generic Initiator object handling into acpi/pci.*
Date: Tue, 2 Jul 2024 14:14:11 +0100
Message-ID: <20240702131428.664859-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Whilst ACPI SRAT Generic Initiator Afinity Structures are able to refer to
both PCI and ACPI Device Handles, the QEMU implementation only implements
the PCI Device Handle case.  For now move the code into the existing
hw/acpi/pci.c file and header.  If support for ACPI Device Handles is
added in the future, perhaps this will be moved again.

Also push the struct AcpiGenericInitiator down into the c file as not
used outside pci.c.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v4: Update busnr naming
---
 include/hw/acpi/acpi_generic_initiator.h |  24 -----
 include/hw/acpi/pci.h                    |   6 ++
 hw/acpi/acpi_generic_initiator.c         | 117 ----------------------
 hw/acpi/pci.c                            | 118 +++++++++++++++++++++++
 hw/arm/virt-acpi-build.c                 |   1 -
 hw/i386/acpi-build.c                     |   1 -
 hw/acpi/meson.build                      |   1 -
 7 files changed, 124 insertions(+), 144 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
deleted file mode 100644
index 7b98676713..0000000000
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ /dev/null
@@ -1,24 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
- */
-
-#ifndef ACPI_GENERIC_INITIATOR_H
-#define ACPI_GENERIC_INITIATOR_H
-
-#include "qom/object_interfaces.h"
-
-#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
-
-typedef struct AcpiGenericInitiator {
-    /* private */
-    Object parent;
-
-    /* public */
-    char *pci_dev;
-    uint16_t node;
-} AcpiGenericInitiator;
-
-void build_srat_generic_pci_initiator(GArray *table_data);
-
-#endif
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 467a99461c..9adf1887da 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -28,6 +28,7 @@
 
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/acpi_aml_interface.h"
+#include "qom/object_interfaces.h"
 
 typedef struct AcpiMcfgInfo {
     uint64_t base;
@@ -40,4 +41,9 @@ Aml *aml_pci_device_dsm(void);
 
 void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
 void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
 #endif
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
deleted file mode 100644
index f2711c91ef..0000000000
--- a/hw/acpi/acpi_generic_initiator.c
+++ /dev/null
@@ -1,117 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
- */
-
-#include "qemu/osdep.h"
-#include "hw/acpi/acpi_generic_initiator.h"
-#include "hw/acpi/aml-build.h"
-#include "hw/boards.h"
-#include "hw/pci/pci_device.h"
-#include "qemu/error-report.h"
-#include "qapi/error.h"
-
-typedef struct AcpiGenericInitiatorClass {
-    ObjectClass parent_class;
-} AcpiGenericInitiatorClass;
-
-OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
-                   ACPI_GENERIC_INITIATOR, OBJECT,
-                   { TYPE_USER_CREATABLE },
-                   { NULL })
-
-OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
-
-static void acpi_generic_initiator_init(Object *obj)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    gi->node = MAX_NODES;
-    gi->pci_dev = NULL;
-}
-
-static void acpi_generic_initiator_finalize(Object *obj)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    g_free(gi->pci_dev);
-}
-
-static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
-                                                  Error **errp)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    gi->pci_dev = g_strdup(val);
-}
-
-static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
-{
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-    MachineState *ms = MACHINE(qdev_get_machine());
-    uint32_t value;
-
-    if (!visit_type_uint32(v, name, &value, errp)) {
-        return;
-    }
-
-    if (value >= MAX_NODES) {
-        error_printf("%s: Invalid NUMA node specified\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    gi->node = value;
-    ms->numa_state->nodes[gi->node].has_gi = true;
-}
-
-static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
-{
-    object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_initiator_set_pci_device);
-    object_class_property_add(oc, "node", "int", NULL,
-        acpi_generic_initiator_set_node, NULL, NULL);
-}
-
-static int build_acpi_generic_initiator(Object *obj, void *opaque)
-{
-    MachineState *ms = MACHINE(qdev_get_machine());
-    AcpiGenericInitiator *gi;
-    GArray *table_data = opaque;
-    uint8_t bus, devfn;
-    Object *o;
-
-    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
-        return 0;
-    }
-
-    gi = ACPI_GENERIC_INITIATOR(obj);
-    if (gi->node >= ms->numa_state->num_nodes) {
-        error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
-        exit(1);
-    }
-
-    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
-    if (!o) {
-        error_printf("%s: Specified device must be a PCI device.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    bus = object_property_get_uint(o, "busnr", &error_fatal);
-    devfn = object_property_get_uint(o, "addr", &error_fatal);
-
-    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
-
-    return 0;
-}
-
-void build_srat_generic_pci_initiator(GArray *table_data)
-{
-    object_child_foreach_recursive(object_get_root(),
-                                   build_acpi_generic_initiator,
-                                   table_data);
-}
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index 20b70dcd81..174b490e5f 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -24,8 +24,12 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
+#include "hw/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
+#include "hw/pci/pci_device.h"
 #include "hw/pci/pcie_host.h"
 
 /*
@@ -59,3 +63,117 @@ void build_mcfg(GArray *table_data, BIOSLinker *linker, AcpiMcfgInfo *info,
 
     acpi_table_end(linker, &table);
 }
+
+typedef struct AcpiGenericInitiator {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_dev;
+    uint16_t node;
+} AcpiGenericInitiator;
+
+typedef struct AcpiGenericInitiatorClass {
+    ObjectClass parent_class;
+} AcpiGenericInitiatorClass;
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
+                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
+
+static void acpi_generic_initiator_init(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->node = MAX_NODES;
+    gi->pci_dev = NULL;
+}
+
+static void acpi_generic_initiator_finalize(Object *obj)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    g_free(gi->pci_dev);
+}
+
+static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
+                                                  Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+
+    gi->pci_dev = g_strdup(val);
+}
+
+static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
+                                            const char *name, void *opaque,
+                                            Error **errp)
+{
+    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    MachineState *ms = MACHINE(qdev_get_machine());
+    uint32_t value;
+
+    if (!visit_type_uint32(v, name, &value, errp)) {
+        return;
+    }
+
+    if (value >= MAX_NODES) {
+        error_printf("%s: Invalid NUMA node specified\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    gi->node = value;
+    ms->numa_state->nodes[gi->node].has_gi = true;
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_initiator_set_pci_device);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_initiator_set_node, NULL, NULL);
+}
+
+static int build_acpi_generic_initiator(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    AcpiGenericInitiator *gi;
+    GArray *table_data = opaque;
+    uint8_t bus, devfn;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        return 0;
+    }
+
+    gi = ACPI_GENERIC_INITIATOR(obj);
+    if (gi->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: Specified node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    if (!o) {
+        error_printf("%s: Specified device must be a PCI device.\n",
+                     TYPE_ACPI_GENERIC_INITIATOR);
+        exit(1);
+    }
+
+    bus = object_property_get_uint(o, "busnr", &error_fatal);
+    devfn = object_property_get_uint(o, "addr", &error_fatal);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
+
+    return 0;
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   build_acpi_generic_initiator,
+                                   table_data);
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b2366f24f9..138514b26a 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -57,7 +57,6 @@
 #include "migration/vmstate.h"
 #include "hw/acpi/ghes.h"
 #include "hw/acpi/viot.h"
-#include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/virtio/virtio-acpi.h"
 #include "target/arm/multiprocessing.h"
 
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f4e366f64f..ee92783836 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -68,7 +68,6 @@
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/cxl.h"
-#include "hw/acpi/acpi_generic_initiator.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index fa5c07db90..5441c9b1e4 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -1,6 +1,5 @@
 acpi_ss = ss.source_set()
 acpi_ss.add(files(
-  'acpi_generic_initiator.c',
   'acpi_interface.c',
   'aml-build.c',
   'bios-linker-loader.c',
-- 
2.43.0

