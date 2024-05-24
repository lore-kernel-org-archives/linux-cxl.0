Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A397055E73
	for <linux-cxl@vger.kernel.org>; Fri, 24 May 2024 10:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716545174; cv=none; b=hZvvAUyvWI7LJlUkDCloKzeJISxmiXs0FVqcUSilNenEAT4f4Ood+GpIJLHYjZG0dKBzlv3ccaiLuwCfZSFO0s3BWeUhhE4HvCbVkO9w08NDPkdWNLQ88PLhYF2zpvDPUF6Pq3elhXsNYwd6w8LY/mBq2VjSr5XmgJZw2mkWAjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716545174; c=relaxed/simple;
	bh=0s1UHXeTyQzljPkV6NqMFv7/jioBtx4s0jxJMdBVMc8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hV2wRD777hQcOjxPY16mRTDJOos+3BYsGKUbzgbk4l/1eJSMdo+kZNznW3emWRZIwzEwFTuZHU1nThOCJNmGD4yPi7srOIUomznENWyR1z7E3ACxYzqe5FVpYquPkBmNwzdsPPINaCEkKOxMFIg/3KVdhJubhhhtSMSutDcPMqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vm0vj2jYqz6JBV9;
	Fri, 24 May 2024 18:02:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id ECA3F1400C9;
	Fri, 24 May 2024 18:06:09 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 24 May 2024 11:06:09 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>,
	<qemu-devel@nongnu.org>, <ankita@nvidia.com>, <marcel.apfelbaum@gmail.com>,
	<philmd@linaro.org>
CC: Dave Jiang <dave.jiang@intel.com>, Huang Ying <ying.huang@intel.com>,
	Paolo Bonzini <pbonzini@redhat.com>, <eduardo@habkost.net>,
	<imammedo@redhat.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
	Michael Roth <michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v2 2/6] hw/acpi: Insert an acpi-generic-node base under acpi-generic-initiator
Date: Fri, 24 May 2024 11:05:03 +0100
Message-ID: <20240524100507.32106-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
References: <20240524100507.32106-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

This will simplify reuse when adding acpi-generic-port.
Note that some error_printf() messages will now print acpi-generic-node
whereas others will move to type specific cases in next patch so
are left alone for now.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
v2: Fix a typo in comment.
---
 include/hw/acpi/acpi_generic_initiator.h | 15 ++++-
 hw/acpi/acpi_generic_initiator.c         | 78 +++++++++++++++---------
 2 files changed, 62 insertions(+), 31 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index a304bad73e..dd4be19c8f 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -8,15 +8,26 @@
 
 #include "qom/object_interfaces.h"
 
-#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+/*
+ * Abstract type to be used as base for
+ * - acpi-generic-initiator
+ * - acpi-generic-port
+ */
+#define TYPE_ACPI_GENERIC_NODE "acpi-generic-node"
 
-typedef struct AcpiGenericInitiator {
+typedef struct AcpiGenericNode {
     /* private */
     Object parent;
 
     /* public */
     char *pci_dev;
     uint16_t node;
+} AcpiGenericNode;
+
+#define TYPE_ACPI_GENERIC_INITIATOR "acpi-generic-initiator"
+
+typedef struct AcpiGenericInitiator {
+    AcpiGenericNode parent;
 } AcpiGenericInitiator;
 
 /*
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 18a939b0e5..c054e0e27d 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -10,45 +10,61 @@
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
 
-typedef struct AcpiGenericInitiatorClass {
+typedef struct AcpiGenericNodeClass {
     ObjectClass parent_class;
+} AcpiGenericNodeClass;
+
+typedef struct AcpiGenericInitiatorClass {
+     AcpiGenericNodeClass parent_class;
 } AcpiGenericInitiatorClass;
 
+OBJECT_DEFINE_ABSTRACT_TYPE(AcpiGenericNode, acpi_generic_node,
+                            ACPI_GENERIC_NODE, OBJECT)
+
+OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericNode, ACPI_GENERIC_NODE)
+
 OBJECT_DEFINE_TYPE_WITH_INTERFACES(AcpiGenericInitiator, acpi_generic_initiator,
-                   ACPI_GENERIC_INITIATOR, OBJECT,
+                   ACPI_GENERIC_INITIATOR, ACPI_GENERIC_NODE,
                    { TYPE_USER_CREATABLE },
                    { NULL })
 
 OBJECT_DECLARE_SIMPLE_TYPE(AcpiGenericInitiator, ACPI_GENERIC_INITIATOR)
 
+static void acpi_generic_node_init(Object *obj)
+{
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
+
+    gn->node = MAX_NODES;
+    gn->pci_dev = NULL;
+}
+
 static void acpi_generic_initiator_init(Object *obj)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+}
+
+static void acpi_generic_node_finalize(Object *obj)
+{
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
 
-    gi->node = MAX_NODES;
-    gi->pci_dev = NULL;
+    g_free(gn->pci_dev);
 }
 
 static void acpi_generic_initiator_finalize(Object *obj)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
-
-    g_free(gi->pci_dev);
 }
 
-static void acpi_generic_initiator_set_pci_device(Object *obj, const char *val,
-                                                  Error **errp)
+static void acpi_generic_node_set_pci_device(Object *obj, const char *val,
+                                             Error **errp)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
 
-    gi->pci_dev = g_strdup(val);
+    gn->pci_dev = g_strdup(val);
 }
-
-static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
-                                            const char *name, void *opaque,
-                                            Error **errp)
+static void acpi_generic_node_set_node(Object *obj, Visitor *v,
+                                       const char *name, void *opaque,
+                                       Error **errp)
 {
-    AcpiGenericInitiator *gi = ACPI_GENERIC_INITIATOR(obj);
+    AcpiGenericNode *gn = ACPI_GENERIC_NODE(obj);
     MachineState *ms = MACHINE(qdev_get_machine());
     uint32_t value;
 
@@ -58,20 +74,24 @@ static void acpi_generic_initiator_set_node(Object *obj, Visitor *v,
 
     if (value >= MAX_NODES) {
         error_printf("%s: Invalid NUMA node specified\n",
-                     TYPE_ACPI_GENERIC_INITIATOR);
+                     TYPE_ACPI_GENERIC_NODE);
         exit(1);
     }
 
-    gi->node = value;
-    ms->numa_state->nodes[gi->node].has_gi = true;
+    gn->node = value;
+    ms->numa_state->nodes[gn->node].has_gi = true;
 }
 
-static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+static void acpi_generic_node_class_init(ObjectClass *oc, void *data)
 {
     object_class_property_add_str(oc, "pci-dev", NULL,
-        acpi_generic_initiator_set_pci_device);
+        acpi_generic_node_set_pci_device);
     object_class_property_add(oc, "node", "int", NULL,
-        acpi_generic_initiator_set_node, NULL, NULL);
+        acpi_generic_node_set_node, NULL, NULL);
+}
+
+static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
+{
 }
 
 /*
@@ -104,9 +124,9 @@ build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
 static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
-    AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
     PCIDeviceHandle dev_handle;
+    AcpiGenericNode *gn;
     PCIDevice *pci_dev;
     Object *o;
 
@@ -114,14 +134,14 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
         return 0;
     }
 
-    gi = ACPI_GENERIC_INITIATOR(obj);
-    if (gi->node >= ms->numa_state->num_nodes) {
+    gn = ACPI_GENERIC_NODE(obj);
+    if (gn->node >= ms->numa_state->num_nodes) {
         error_printf("%s: Specified node %d is invalid.\n",
-                     TYPE_ACPI_GENERIC_INITIATOR, gi->node);
+                     TYPE_ACPI_GENERIC_INITIATOR, gn->node);
         exit(1);
     }
 
-    o = object_resolve_path_type(gi->pci_dev, TYPE_PCI_DEVICE, NULL);
+    o = object_resolve_path_type(gn->pci_dev, TYPE_PCI_DEVICE, NULL);
     if (!o) {
         error_printf("%s: Specified device must be a PCI device.\n",
                      TYPE_ACPI_GENERIC_INITIATOR);
@@ -135,7 +155,7 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
                                    pci_dev->devfn);
 
     build_srat_generic_pci_initiator_affinity(table_data,
-                                              gi->node, &dev_handle);
+                                              gn->node, &dev_handle);
 
     return 0;
 }
-- 
2.39.2

