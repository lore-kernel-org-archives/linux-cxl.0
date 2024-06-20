Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9EA1B142C
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 16:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899656; cv=none; b=VAEa7LS1QdL9pupcDWx2nu8yhE/isnOHddXEBU+0ehZZdpG/5Ljpww2UX8gY3K+n2jKHdhuOilACEXZ0K+FAtyRSbOHPfMH3igHCAtH7p/jPRukXCTLzTEmhjVCknjX/nMi2Fr4foTuuX3UCfFyLP8zMTPxFpv0adxfB7B5mziQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899656; c=relaxed/simple;
	bh=e4yT3i4/7uYKROnYA4p3zBbFbTvt+5ETXR1KQqhmY6s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ij4Bmwf9U0N9YzPYTPDnzxGc4RqhCczQ0RtOVlcncwmPFKNROHjKUi7OG5kQFJLx6ysb1kTSF8RHzrPwZcwMMla7vIBWnhD8T7X3SlOjFTAwzjjdYVUcQRoXGXZNDUP3vqMAzc4KUW1q5O8h5CUPxwhhGW9xT9wlrH6cvlRdQok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4lkT4x9kz6GD50;
	Fri, 21 Jun 2024 00:07:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E1F2D140B2A;
	Fri, 21 Jun 2024 00:07:31 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:07:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 08/11] hw/acpi: Generic Port Affinity Structure support
Date: Thu, 20 Jun 2024 17:03:16 +0100
Message-ID: <20240620160324.109058-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
References: <20240620160324.109058-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

These are very similar to the recently added Generic Initiators
but instead of representing an initiator of memory traffic they
represent an edge point beyond which may lie either targets or
initiators.  Here we add these ports such that they may
be targets of hmat_lb records to describe the latency and
bandwidth from host side initiators to the port.  A discoverable
mechanism such as UEFI CDAT read from CXL devices and switches
is used to discover the remainder of the path, and the OS can build
up full latency and bandwidth numbers as need for work and data
placement decisions.

Acked-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v3: Move to hw/acpi/pci.c
    Rename the funciton to actually registers both types
    of generic nodes to reflect it isn't GI only.
    Note that the qom part is unchanged and other changes are mostly
    code movement so I've kept Markus' Ack.
---
 qapi/qom.json                            |  34 ++++
 include/hw/acpi/acpi_generic_initiator.h |  35 ++++
 include/hw/acpi/aml-build.h              |   4 +
 include/hw/acpi/pci.h                    |   3 +-
 include/hw/pci/pci_bridge.h              |   1 +
 hw/acpi/acpi_generic_initiator.c         | 216 +++++++++++++++++++++++
 hw/acpi/aml-build.c                      |  40 +++++
 hw/acpi/pci.c                            | 110 +++++++++++-
 hw/arm/virt-acpi-build.c                 |   2 +-
 hw/i386/acpi-build.c                     |   2 +-
 hw/pci-bridge/pci_expander_bridge.c      |   1 -
 11 files changed, 443 insertions(+), 5 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 8bd299265e..8fa6bbd9a7 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -826,6 +826,38 @@
   'data': { 'pci-dev': 'str',
             'node': 'uint32' } }
 
+##
+# @AcpiGenericPortProperties:
+#
+# Properties for acpi-generic-port objects.
+#
+# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
+#     this SRAT Generic Port Affinity Structure.  This is the same as
+#     the bus parameter for the root ports attached to this host
+#     bridge.  The resulting SRAT Generic Port Affinity Structure will
+#     refer to the ACPI object in DSDT that represents the host bridge
+#     (e.g.  ACPI0016 for CXL host bridges).  See ACPI 6.5 Section
+#     5.2.16.7 for more information.
+#
+# @node: Similar to a NUMA node ID, but instead of providing a
+#     reference point used for defining NUMA distances and access
+#     characteristics to memory or from an initiator (e.g. CPU), this
+#     node defines the boundary point between non-discoverable system
+#     buses which must be described by firmware, and a discoverable
+#     bus.  NUMA distances and access characteristics are defined to
+#     and from that point.  For system software to establish full
+#     initiator to target characteristics this information must be
+#     combined with information retrieved from the discoverable part
+#     of the path.  An example would use CDAT (see UEFI.org)
+#     information read from devices and switches in conjunction with
+#     link characteristics read from PCIe Configuration space.
+#
+# Since: 9.1
+##
+{ 'struct': 'AcpiGenericPortProperties',
+  'data': { 'pci-bus': 'str',
+            'node': 'uint32' } }
+
 ##
 # @RngProperties:
 #
@@ -1019,6 +1051,7 @@
 { 'enum': 'ObjectType',
   'data': [
     'acpi-generic-initiator',
+    'acpi-generic-port',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -1092,6 +1125,7 @@
   'discriminator': 'qom-type',
   'data': {
       'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
+      'acpi-generic-port':          'AcpiGenericPortProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
new file mode 100644
index 0000000000..92a39ad303
--- /dev/null
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -0,0 +1,35 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#ifndef ACPI_GENERIC_INITIATOR_H
+#define ACPI_GENERIC_INITIATOR_H
+
+#include "qom/object_interfaces.h"
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
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
+#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
+
+typedef struct AcpiGenericPort {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_bus;
+    uint16_t node;
+} AcpiGenericPort;
+
+void build_srat_generic_pci_initiator(GArray *table_data);
+
+#endif
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index 9ba3a21c13..fb8cf6c415 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -490,6 +490,10 @@ void build_srat_pci_generic_initiator(GArray *table_date, int node,
                                       uint16_t segment, uint8_t bus,
                                       uint8_t devfn);
 
+void build_srat_acpi_generic_port(GArray *table_data, int node,
+                                  const char *hid,
+                                  uint32_t uid);
+
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
diff --git a/include/hw/acpi/pci.h b/include/hw/acpi/pci.h
index 9adf1887da..182095d104 100644
--- a/include/hw/acpi/pci.h
+++ b/include/hw/acpi/pci.h
@@ -43,7 +43,8 @@ void build_append_pci_bus_devices(Aml *parent_scope, PCIBus *bus);
 void build_pci_bridge_aml(AcpiDevAmlIf *adev, Aml *scope);
 
 #define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
 
-void build_srat_generic_pci_initiator(GArray *table_data);
+void build_srat_generic_affinity_structures(GArray *table_data);
 
 #endif
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 5cd452115a..5456e24883 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -102,6 +102,7 @@ typedef struct PXBPCIEDev {
     PXBDev parent_obj;
 } PXBPCIEDev;
 
+#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 #define TYPE_PXB_DEV "pxb"
 OBJECT_DECLARE_SIMPLE_TYPE(PXBDev, PXB_DEV)
 
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
new file mode 100644
index 0000000000..8491aaf5ec
--- /dev/null
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -0,0 +1,216 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, NVIDIA CORPORATION & AFFILIATES. All rights reserved
+ */
+
+#include "qemu/osdep.h"
+#include "hw/acpi/acpi_generic_initiator.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/boards.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_device.h"
+#include "qemu/error-report.h"
+#include "qapi/error.h"
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
+typedef struct AcpiGenericPortClass {
+    ObjectClass parent_class;
+} AcpiGenericPortClass;
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                   ACPI_GENERIC_PORT, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
+
+static void acpi_generic_port_init(Object *obj)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    gp->node = MAX_NODES;
+    gp->pci_bus = NULL;
+}
+
+static void acpi_generic_port_finalize(Object *obj)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    g_free(gp->pci_bus);
+}
+
+static void acpi_generic_port_set_pci_bus(Object *obj, const char *val,
+                                          Error **errp)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    gp->pci_bus = g_strdup(val);
+}
+
+static void acpi_generic_port_set_node(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
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
+    gp->node = value;
+}
+
+static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-bus", NULL,
+        acpi_generic_port_set_pci_bus);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_port_set_node, NULL, NULL);
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
+    bus = object_property_get_uint(o, "bus", &error_fatal);
+    devfn = object_property_get_uint(o, "addr", &error_fatal);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
+
+    return 0;
+}
+
+static int build_acpi_generic_port(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const char *hid = "ACPI0016";
+    GArray *table_data = opaque;
+    AcpiGenericPort *gp;
+    uint32_t uid;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
+        return 0;
+    }
+
+    gp = ACPI_GENERIC_PORT(obj);
+
+    if (gp->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_PORT, gp->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
+    if (!o) {
+        error_printf("%s: device must be a CXL host bridge.\n",
+                     TYPE_ACPI_GENERIC_PORT);
+        exit(1);
+    }
+
+    uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
+    build_srat_acpi_generic_port(table_data, gp->node, hid, uid);
+
+    return 0;
+}
+
+void build_srat_generic_pci_initiator(GArray *table_data)
+{
+    object_child_foreach_recursive(object_get_root(),
+                                   build_acpi_generic_initiator,
+                                   table_data);
+    object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
+                                   table_data);
+}
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 968b654e58..4067100dd6 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1955,6 +1955,19 @@ static void build_append_srat_pci_device_handle(GArray *table_data,
     build_append_int_noprefix(table_data, 0, 12);
 }
 
+static void build_append_srat_acpi_device_handle(GArray *table_data,
+                                                 const char *hid,
+                                                 uint32_t uid)
+{
+    assert(strlen(hid) == 8);
+    /* Device Handle - ACPI */
+    for (int i = 0; i < sizeof(hid); i++) {
+        build_append_int_noprefix(table_data, hid[i], 1);
+    }
+    build_append_int_noprefix(table_data, uid, 4);
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec, Revision 6.3
  * 5.2.16.6 Generic Initiator Affinity Structure
@@ -1982,6 +1995,33 @@ void build_srat_pci_generic_initiator(GArray *table_data, int node,
     build_append_int_noprefix(table_data, 0, 4);
 }
 
+/*
+ * ACPI spec, Revision 6.5
+ * 5.2.16.7 Generic Port Affinity Structure
+ *   With ACPI Device Handle.
+ */
+void build_srat_acpi_generic_port(GArray *table_data, int node,
+                                  const char *hid,
+                                  uint32_t uid)
+{
+    /* Type */
+    build_append_int_noprefix(table_data, 6, 1);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Device Handle Type: ACPI */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Device Handle */
+    build_append_srat_acpi_device_handle(table_data, hid, uid);
+    /* Flags - GP Enabled */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
diff --git a/hw/acpi/pci.c b/hw/acpi/pci.c
index f68be9ea17..b9e2776966 100644
--- a/hw/acpi/pci.c
+++ b/hw/acpi/pci.c
@@ -29,6 +29,7 @@
 #include "hw/boards.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_device.h"
 #include "hw/pci/pcie_host.h"
 
@@ -171,9 +172,116 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     return 0;
 }
 
-void build_srat_generic_pci_initiator(GArray *table_data)
+typedef struct AcpiGenericPort {
+    /* private */
+    Object parent;
+
+    /* public */
+    char *pci_bus;
+    uint16_t node;
+} AcpiGenericPort;
+
+typedef struct AcpiGenericPortClass {
+    ObjectClass parent_class;
+} AcpiGenericPortClass;
+
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                   ACPI_GENERIC_PORT, OBJECT,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
+
+static void acpi_generic_port_init(Object *obj)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    gp->node = MAX_NODES;
+    gp->pci_bus = NULL;
+}
+
+static void acpi_generic_port_finalize(Object *obj)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    g_free(gp->pci_bus);
+}
+
+static void acpi_generic_port_set_pci_bus(Object *obj, const char *val,
+                                          Error **errp)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
+
+    gp->pci_bus = g_strdup(val);
+}
+
+static void acpi_generic_port_set_node(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
+{
+    AcpiGenericPort *gp = ACPI_GENERIC_PORT(obj);
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
+    gp->node = value;
+}
+
+static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+{
+    object_class_property_add_str(oc, "pci-bus", NULL,
+        acpi_generic_port_set_pci_bus);
+    object_class_property_add(oc, "node", "int", NULL,
+        acpi_generic_port_set_node, NULL, NULL);
+}
+
+static int build_acpi_generic_port(Object *obj, void *opaque)
+{
+    MachineState *ms = MACHINE(qdev_get_machine());
+    const char *hid = "ACPI0016";
+    GArray *table_data = opaque;
+    AcpiGenericPort *gp;
+    uint32_t uid;
+    Object *o;
+
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_PORT)) {
+        return 0;
+    }
+
+    gp = ACPI_GENERIC_PORT(obj);
+
+    if (gp->node >= ms->numa_state->num_nodes) {
+        error_printf("%s: node %d is invalid.\n",
+                     TYPE_ACPI_GENERIC_PORT, gp->node);
+        exit(1);
+    }
+
+    o = object_resolve_path_type(gp->pci_bus, TYPE_PXB_CXL_BUS, NULL);
+    if (!o) {
+        error_printf("%s: device must be a CXL host bridge.\n",
+                     TYPE_ACPI_GENERIC_PORT);
+       exit(1);
+    }
+
+    uid = object_property_get_uint(o, "acpi_uid", &error_fatal);
+    build_srat_acpi_generic_port(table_data, gp->node, hid, uid);
+
+    return 0;
+}
+
+void build_srat_generic_affinity_structures(GArray *table_data)
 {
     object_child_foreach_recursive(object_get_root(),
                                    build_acpi_generic_initiator,
                                    table_data);
+    object_child_foreach_recursive(object_get_root(), build_acpi_generic_port,
+                                   table_data);
 }
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 1a5aa0d55d..31956410ed 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -504,7 +504,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
         }
     }
 
-    build_srat_generic_pci_initiator(table_data);
+    build_srat_generic_affinity_structures(table_data);
 
     if (ms->nvdimms_state->is_enabled) {
         nvdimm_build_srat(table_data);
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0d37b9238a..446adcc602 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -2046,7 +2046,7 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
         build_srat_memory(table_data, 0, 0, 0, MEM_AFFINITY_NOFLAGS);
     }
 
-    build_srat_generic_pci_initiator(table_data);
+    build_srat_generic_affinity_structures(table_data);
 
     /*
      * Entry is required for Windows to enable memory hotplug in OS
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 92d39b917a..1c51f3f5b6 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
                          TYPE_PXB_CXL_BUS)
 
-- 
2.43.0

