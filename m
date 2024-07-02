Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0B1ABCDF
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jul 2024 13:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719926173; cv=none; b=C1VrKj0dHsSH9O6E0Cgp0TFO6elNCIDRotInL7Ip3nCiJlPl3bqI/UuWVQhimAUFfZ9/imrRvHMA5ZyJRk6dKDIq5ExHkYozQIJopfZPZacZH1wTvQJFw669ZUoBdldMHFPxCRZOW+xBJE3KwVzxE+4uLuvVwsJuhSFKbf4vR2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719926173; c=relaxed/simple;
	bh=nRH0PAIDuiHsA4KjbnQ9sWnnH6ToZEP9QOW7gpSedb0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E4IVuWlTbdRudN8DX452aI7malhBcgIsOLKTXWeVhLxYjyMOTCAHgPEBgQYYE/HnAyoFZNRssKMJlAG64C5dzL6Y8YkP87TDQxSYy0fYMajoXZb9T2idFjkBQJ+xk9hoBERfN5JkvwJV/rV/2YIZkl93TQDQyzLLOnqz8gygQUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WD3LT62Jbz6JBwD;
	Tue,  2 Jul 2024 21:15:29 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 92023140AB8;
	Tue,  2 Jul 2024 21:16:05 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 14:16:01 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 03/13] hw/acpi: Move AML building code for Generic Initiators to aml_build.c
Date: Tue, 2 Jul 2024 14:14:08 +0100
Message-ID: <20240702131428.664859-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
References: <20240702131428.664859-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Rather than attempting to create a generic function with mess of the two
different device handle types, use a PCI handle specific variant.  If the
ACPI handle form is needed then that can be introduced alongside this
with little duplicated code.

Drop the PCIDeviceHandle in favor of just passing the bus, devfn
and segment directly.  devfn kept as a single byte because ARI means
that in this case it is just an 8 bit function number.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Link: https://lore.kernel.org/qemu-devel/20240618142333.102be976@imammedo.users.ipa.redhat.com/
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v4: table_date typo fixed.
    Patch description tweaked to make more sense.
---
 include/hw/acpi/acpi_generic_initiator.h | 23 -------------
 include/hw/acpi/aml-build.h              |  4 +++
 hw/acpi/acpi_generic_initiator.c         | 39 ++-------------------
 hw/acpi/aml-build.c                      | 44 ++++++++++++++++++++++++
 4 files changed, 51 insertions(+), 59 deletions(-)

diff --git a/include/hw/acpi/acpi_generic_initiator.h b/include/hw/acpi/acpi_generic_initiator.h
index a304bad73e..7b98676713 100644
--- a/include/hw/acpi/acpi_generic_initiator.h
+++ b/include/hw/acpi/acpi_generic_initiator.h
@@ -19,29 +19,6 @@ typedef struct AcpiGenericInitiator {
     uint16_t node;
 } AcpiGenericInitiator;
 
-/*
- * ACPI 6.3:
- * Table 5-81 Flags – Generic Initiator Affinity Structure
- */
-typedef enum {
-    /*
-     * If clear, the OSPM ignores the contents of the Generic
-     * Initiator/Port Affinity Structure. This allows system firmware
-     * to populate the SRAT with a static number of structures, but only
-     * enable them as necessary.
-     */
-    GEN_AFFINITY_ENABLED = (1 << 0),
-} GenericAffinityFlags;
-
-/*
- * ACPI 6.3:
- * Table 5-80 Device Handle - PCI
- */
-typedef struct PCIDeviceHandle {
-    uint16_t segment;
-    uint16_t bdf;
-} PCIDeviceHandle;
-
 void build_srat_generic_pci_initiator(GArray *table_data);
 
 #endif
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index a3784155cb..33eef85791 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -486,6 +486,10 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
+void build_srat_pci_generic_initiator(GArray *table_data, int node,
+                                      uint16_t segment, uint8_t bus,
+                                      uint8_t devfn);
+
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 
diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 4a02c19468..7665b16107 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -74,40 +74,11 @@ static void acpi_generic_initiator_class_init(ObjectClass *oc, void *data)
         acpi_generic_initiator_set_node, NULL, NULL);
 }
 
-/*
- * ACPI 6.3:
- * Table 5-78 Generic Initiator Affinity Structure
- */
-static void
-build_srat_generic_pci_initiator_affinity(GArray *table_data, int node,
-                                          PCIDeviceHandle *handle)
-{
-    uint8_t index;
-
-    build_append_int_noprefix(table_data, 5, 1);  /* Type */
-    build_append_int_noprefix(table_data, 32, 1); /* Length */
-    build_append_int_noprefix(table_data, 0, 1);  /* Reserved */
-    build_append_int_noprefix(table_data, 1, 1);  /* Device Handle Type: PCI */
-    build_append_int_noprefix(table_data, node, 4);  /* Proximity Domain */
-
-    /* Device Handle - PCI */
-    build_append_int_noprefix(table_data, handle->segment, 2);
-    build_append_int_noprefix(table_data, PCI_BUS_NUM(handle->bdf), 1);
-    build_append_int_noprefix(table_data, PCI_BDF_TO_DEVFN(handle->bdf), 1);
-    for (index = 0; index < 12; index++) {
-        build_append_int_noprefix(table_data, 0, 1);
-    }
-
-    build_append_int_noprefix(table_data, GEN_AFFINITY_ENABLED, 4); /* Flags */
-    build_append_int_noprefix(table_data, 0, 4);     /* Reserved */
-}
-
 static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
 {
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDeviceHandle dev_handle;
     PCIDevice *pci_dev;
     Object *o;
 
@@ -130,13 +101,9 @@ static int build_all_acpi_generic_initiators(Object *obj, void *opaque)
     }
 
     pci_dev = PCI_DEVICE(o);
-
-    dev_handle.segment = 0;
-    dev_handle.bdf = PCI_BUILD_BDF(pci_bus_num(pci_get_bus(pci_dev)),
-                                   pci_dev->devfn);
-
-    build_srat_generic_pci_initiator_affinity(table_data,
-                                              gi->node, &dev_handle);
+    build_srat_pci_generic_initiator(table_data, gi->node, 0,
+                                     pci_bus_num(pci_get_bus(pci_dev)),
+                                     pci_dev->devfn);
 
     return 0;
 }
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 6d4517cfbe..968b654e58 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1938,6 +1938,50 @@ void build_srat_memory(GArray *table_data, uint64_t base,
     build_append_int_noprefix(table_data, 0, 8); /* Reserved */
 }
 
+/*
+ * ACPI Spec Revision 6.3
+ * Table 5-80 Device Handle - PCI
+ */
+static void build_append_srat_pci_device_handle(GArray *table_data,
+                                                uint16_t segment,
+                                                uint8_t bus, uint8_t devfn)
+{
+    /* PCI segment number */
+    build_append_int_noprefix(table_data, segment, 2);
+    /* PCI Bus Device Function */
+    build_append_int_noprefix(table_data, bus, 1);
+    build_append_int_noprefix(table_data, devfn, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 12);
+}
+
+/*
+ * ACPI spec, Revision 6.3
+ * 5.2.16.6 Generic Initiator Affinity Structure
+ *    With PCI Device Handle.
+ */
+void build_srat_pci_generic_initiator(GArray *table_data, int node,
+                                      uint16_t segment, uint8_t bus,
+                                      uint8_t devfn)
+{
+    /* Type */
+    build_append_int_noprefix(table_data, 5, 1);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 1);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+    /* Device Handle Type: PCI */
+    build_append_int_noprefix(table_data, 1, 1);
+    /* Proximity Domain */
+    build_append_int_noprefix(table_data, node, 4);
+    /* Device Handle */
+    build_append_srat_pci_device_handle(table_data, segment, bus, devfn);
+    /* Flags - GI Enabled */
+    build_append_int_noprefix(table_data, 1, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
-- 
2.43.0

