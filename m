Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A51155E73
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 10:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545228; cv=none; b=Wb1OgFya/a+1/TFyvqcQk7N1iDI1o1qrkrTXZsidOz9EoyjZmnVwMYFa/ArGb1aofjXH3CLdSWYjyV4vVaItfJ0FXc9d9aTMlyz51nPDQ8El5ic7z/aMiR1z2d/wyjCq7Bc53Cko5mKbqZiG6lPdVr1E+Q9m63Nkacscvva0aPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545228; c=relaxed/simple;
	bh=O6r5M2ex0CF7zL1m34GgIL5hMnOVA3Zn9nVb4gXMC44=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=df9JxChRWOgef8wiA6GraMjTkGThJLZsqN5Bgpr1vYADVP9V+QOGfCAfEQhqHx7KrPuKJHOYqS/vzwWOdxoAMMH3mDRGYjU6RoGUMBmeriEngh/DYWPhiK+mEyfPZcC/CUsIx46R1mOGH7sFN7cxCa6kaTXPXUINCTKbtCbjP38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vm0zc0bqsz6K6J4;
	Fri, 24 May 2024 18:05:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id BF024140B54;
	Fri, 24 May 2024 18:06:40 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:06:40 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 3/6] hw/acpi: Generic Port Affinity Structure support
Date: Fri, 24 May 2024 11:05:04 +0100
Message-ID: <20240524100507.32106-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

These are very similar to the recently added Generic Initiators
but instead of representing an initiator of memory traffic they
represent an edge point beyond which may lie either targets or
initiators.  Here we add these ports such that they may
be targets of hmat_lb records to describe the latency and
bandwidth from host side initiators to the port.  A descoverable
mechanism such as UEFI CDAT read from CXL devices and switches
is used to discover the remainder fo the path and the OS can build
up full latency and bandwidth numbers as need for work and data
placement decisions.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Updates to QMP documentation to provide a lot more information
    on the parameters.
---
 qapi/qom.json                            |  35 ++++++
 include/hw/acpi/acpi_generic_initiator.h |  18 ++-
 include/hw/pci/pci_bridge.h              |   1 +
 hw/acpi/acpi_generic_initiator.c         | 141 +++++++++++++++++------
 hw/pci-bridge/pci_expander_bridge.c      |   1 -
 5 files changed, 158 insertions(+), 38 deletions(-)

diff --git a/qapi/qom.json b/qapi/qom.json
index 38dde6d785..9d1d86bdad 100644
--- a/qapi/qom.json
+++ b/qapi/qom.json
@@ -826,6 +826,39 @@
   'data': { 'pci-dev': 'str',
             'node': 'uint32' } }
 
+
+##
+# @AcpiGenericPortProperties:
+#
+# Properties for acpi-generic-port objects.
+#
+# @pci-bus: QOM path of the PCI bus of the hostbridge associated with
+#     this SRAT Generic Port Affinity Structure.  This is the same as
+#     the bus parameter for the root ports attached to this host bridge.
+#     The resulting SRAT Generic Port Affinity Structure will refer to
+#     the ACPI object in DSDT that represents the host bridge (e.g.
+#     ACPI0016 for CXL host bridges.) See ACPI 6.5 Section 5.2.16.7 for
+#     more information.
+#
+# @node: Similar to a NUMA node ID, but instead of providing a reference
+#     point used for defining NUMA distances and access characteristics
+#     to memory or from an initiator (e.g. CPU), this node defines the
+#     boundary point between non-discoverable system buses which must be
+#     described by firmware, and a discoverable bus.  NUMA distances
+#     and access characteristics are defined to and from that point.
+#     For system software to establish full initiator to target
+#     characteristics this information must be combined with information
+#     retrieved from the discoverable part of the path.  An example would
+#     use CDAT (see UEFI.org) information read from devices and switches
+#     in conjunction with link characteristics read from PCIe
+#     Configuration space.
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
@@ -953,6 +986,7 @@
 { 'enum': 'ObjectType',
   'data': [
     'acpi-generic-initiator',
+    'acpi-generic-port',
     'authz-list',
     'authz-listfile',
     'authz-pam',
@@ -1025,6 +1059,7 @@
   'discriminator': 'qom-type',
   'data': {
       'acpi-generic-initiator':     'AcpiGenericInitiatorProperties',
+      'acpi-generic-port':          'AcpiGenericPortProperties',
       'authz-list':                 'AuthZListProperties',
       'authz-listfile':             'AuthZListFileProperties',
       'authz-pam':                  'AuthZPAMProperties',
diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index dd4be19c8f..1a899af30f 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -30,6 +30,12 @@ typedef struct AcpiGenericInitiator {
     AcpiGenericNode parent;
 } AcpiGenericInitiator;
 
+#define TYPE_ACPI_GENERIC_PORT "acpi-generic-port"
+
+typedef struct AcpiGenericPort {
+    AcpiGenericInitiator parent;
+} AcpiGenericPort;
+
 /*
  * ACPI 6.3:
  * Table 5-81 Flags – Generic Initiator Affinity Structure
@@ -49,8 +55,16 @@ typedef enum {
  * Table 5-80 Device Handle - PCI
  */
 typedef struct PCIDeviceHandle {
-    uint16_t segment;
-    uint16_t bdf;
+    union {
+        struct {
+            uint16_t segment;
+            uint16_t bdf;
+        };
+        struct {
+            uint64_t hid;
+            uint32_t uid;
+        };
+    };
 } PCIDeviceHandle;
 
 void build_srat_generic_pci_initiator(GArray *table_data);
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
index c054e0e27d..85191e90ab 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -7,6 +7,7 @@
 #include "hw/acpi/acpi_generic_initiator.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/boards.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
@@ -18,6 +19,10 @@ typedef struct AcpiGenericInitiatorClass {
      AcpiGenericNodeClass parent_class;
 } AcpiGenericInitiatorClass;
 
+typedef struct AcpiGenericPortClass {
+    AcpiGenericInitiatorClass parent;
+} AcpiGenericPortClass;
+
 OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
                             ACPI_GENERIC_NODE, OBJECT)
 
@@ -30,6 +35,13 @@ OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
+OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericPort, acpi_generic_port,
+                   ACPI_GENERIC_PORT, ACPI_GENERIC_NODE,
+                   { TYPE_USER_CREATABLE },
+                   { NULL })
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericPort, ACPI_GENERIC_PORT)
+
 static void acpi_generic_node_init(Object *obj)
 {
     AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
@@ -53,6 +65,14 @@ static void acpi_generic_initiator_finalize(Object *obj)
 {
 }
 
+static void acpi_generic_port_init(Object *obj)
+{
+}
+
+static void acpi_generic_port_finalize(Object *obj)
+{
+}
+
 static void acpi_generic_node_set_pci_device(Object *obj, const char *val,
                                              Error **errp)
 {
@@ -79,42 +99,61 @@ static void acpi_generic_node_set_node(Object *obj, Visitor *v,
     }
 
     gn->node = value;
-    ms->numa_state->nodes[gn->node].has_gi = true;
+    if (object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+        ms->numa_state->nodes[gn->node].has_gi = true;
+    }
 }
 
 static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
 {
-    object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_node_set_pci_device);
     object_class_property_add(oc, "node", "int", NULL,
         acpi_generic_node_set_node, NULL, NULL);
 }
 
 static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
 {
+    object_class_property_add_str(oc, "pci-dev", NULL,
+        acpi_generic_node_set_pci_device);
+}
+
+static void acpi_generic_port_class_init(ObjectClass *oc, void *data)
+{
+    /*
+     * Despite the ID representing a root bridge bus, same storage
+     * can be used.
+     */
+    object_class_property_add_str(oc, "pci-bus", NULL,
+        acpi_generic_node_set_pci_device);
 }
 
 /*
  * ACPI 6.3:
  * Table 5-78 Generic Initiator Affinity Structure
+ * ACPI 6.5:
+ * Table 5-67 Generic Port Affinity Structure
  */
 static void
-build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
-                                          PCIDeviceHandle *handle)
+build_srat_generic_node_affinity(GArray *table_data, int node,
+                                 PCIDeviceHandle *handle, bool gp, bool pci)
 {
-    uint8_t index;
-
-    build_append_int_noprefix(table_data, 5, 1);  /* Type */
+    build_append_int_noprefix(table_data, gp ? 6 : 5, 1);  /* Type */
     build_append_int_noprefix(table_data, 32, 1); /* Length */
     build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
-    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
+    /* Device Handle Type: PCI / ACPI */
+    build_append_int_noprefix(table_data, pci ? 1 : 0, 1);
     build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
 
     /* Device Handle - PCI */
-    build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, handle->bdf, 2);
-    for (index = 0; index < 12; index++) {
-        build_append_int_noprefix(table_data, 0, 1);
+    if (pci) {
+        /* Device Handle - PCI */
+        build_append_int_noprefix(table_data, handle->segment, 2);
+        build_append_int_noprefix(table_data, handle->bdf, 2);
+        build_append_int_noprefix(table_data, 0, 12);
+    } else {
+        /* Device Handle - ACPI */
+        build_append_int_noprefix(table_data, handle->hid, 8);
+        build_append_int_noprefix(table_data, handle->uid, 4);
+        build_append_int_noprefix(table_data, 0, 4);
     }
 
     build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
@@ -127,37 +166,69 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
     GArray *table_data = opaque;
     PCIDeviceHandle dev_handle;
     AcpiGenericNode *gn;
-    PCIDevice *pci_dev;
     Object *o;
 
-    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
+    if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_NODE)) {
         return 0;
     }
 
     gn = ACPI_GENERIC_NODE(obj);
-    if (gn->node >= ms->numa_state->num_nodes) {
-        error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
-        exit(1);
-    }
 
-    o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
-    if (!o) {
-        error_printf("%s: Specified device must be a PCI device.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
-        exit(1);
-    }
-
-    pci_dev = PCI_DEVICE(o);
-
-    dev_handle.segment = 0;
-    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                   pci_dev->devfn);
+    if (object_dynamic_cast(OBJECT(gn), TYPE_ACPI_GENERIC_INITIATOR)) {
+        PCIDevice *pci_dev;
+
+        if (gn->node >= ms->numa_state->num_nodes) {
+            error_printf("%s: Specified node %d is invalid.\n",
+                         TYPE_ACPI_GENERIC_INITIATOR, gn->node);
+            exit(1);
+        }
+
+        o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
+        if (!o) {
+            error_printf("%s: Specified device must be a PCI device.\n",
+                         TYPE_ACPI_GENERIC_INITIATOR);
+            exit(1);
+        }
+        pci_dev = PCI_DEVICE(o);
+
+        dev_handle.segment = 0;
+        dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
+                                       pci_dev->devfn);
+        build_srat_generic_node_affinity(table_data,
+                                         gn->node, &dev_handle, false, true);
 
-    build_srat_generic_pci_initiator_affinity(table_data,
-                                              gn->node, &dev_handle);
+        return 0;
+    } else { /* TYPE_ACPI_GENERIC_PORT */
+        PCIBus *bus;
+        const char *hid = "ACPI0016";
+
+        if (gn->node >= ms->numa_state->num_nodes) {
+            error_printf("%s: Specified node %d is invalid.\n",
+                         TYPE_ACPI_GENERIC_PORT, gn->node);
+            exit(1);
+        }
+
+        o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_BUS, NULL);
+        if (!o) {
+            error_printf("%s: Specified device must be a PCI Host Bridge.\n",
+                         TYPE_ACPI_GENERIC_PORT);
+            exit(1);
+        }
+        bus = PCI_BUS(o);
+        /* Need to know if this is a PXB Bus so below an expander bridge */
+        if (!object_dynamic_cast(OBJECT(bus), TYPE_PXB_CXL_BUS)) {
+            error_printf("%s: Specified device is not a bus below a host bridge.\n",
+                         TYPE_ACPI_GENERIC_PORT);
+            exit(1);
+        }
+        /* Copy without trailing NULL */
+        memcpy(&dev_handle.hid, hid, sizeof(dev_handle.hid));
+        dev_handle.uid = pci_bus_num(bus);
+        build_srat_generic_node_affinity(table_data,
+                                         gn->node, &dev_handle, true, false);
 
-    return 0;
+        return 0;
+    }
 }
 
 void build_srat_generic_pci_initiator(GArray *table_data)
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 0411ad31ea..f5431443b9 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -38,7 +38,6 @@ DECLARE_INSTANCE_CHECKER(PXBBus, PXB_BUS,
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_PCIE_BUS,
                          TYPE_PXB_PCIE_BUS)
 
-#define TYPE_PXB_CXL_BUS "pxb-cxl-bus"
 DECLARE_INSTANCE_CHECKER(PXBBus, PXB_CXL_BUS,
                          TYPE_PXB_CXL_BUS)
 
-- 
2.39.2

