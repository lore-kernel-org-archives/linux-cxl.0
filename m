Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 000751B14EE
	for <linux-cxl@vger.kernel.org>; Thu, 20 Jun 2024 16:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899563; cv=none; b=UV+0z2bh7UoxIqhklds3I7eDb9Mpsjzklt8Etn9jsc9hf1KdpwPPpRz2DHtm3fdoBhuKdz9G/lN3YBOJPTSppwuvJyBiNiraOhCu2dGXSXxosvx72GKTfXqw0gC3LmIMghQ6h1r4RqCNdOP+K1KwbXXwl0sMWjELNJQU5YFi7Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899563; c=relaxed/simple;
	bh=JEbOEB4F2iNjE2XDsP1dJTTXpuRERYIOKvmX2EM1Uu0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VCfqRzHFw6QUHtKGhAjA7iUKg7nIuP3TyL8lJab0Hyhif1yGy0jlaaXB2zDwWTzHJDj0DfFxaFjeMF1mwGaNPi3FofCacb37pC9r0C8yMTgNSGTosOFuxJKCcJQpaeZcpQVIBMwJvsK2PVFxxF/ehRZEjUxGobdRrvf+/bk58Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4W4lhH6Y2pz6K6S4;
	Fri, 21 Jun 2024 00:05:35 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9C19B140C72;
	Fri, 21 Jun 2024 00:05:59 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Jun 2024 17:05:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>
CC: <linuxarm@huawei.com>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, <linux-cxl@vger.kernel.org>, Michael Roth
	<michael.roth@amd.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 05/11] hw/pci: Add a bus property to pci_props and use for acpi/gi
Date: Thu, 20 Jun 2024 17:03:13 +0100
Message-ID: <20240620160324.109058-6-Jonathan.Cameron@huawei.com>
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

Using a property allows us to hide the internal details of the PCI device
from the code to build a SRAT Generic Initiator Affinity Structure with
PCI Device Handle.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V3: New patch
---
 hw/acpi/acpi_generic_initiator.c | 11 ++++++-----
 hw/pci/pci.c                     | 14 ++++++++++++++
 2 files changed, 20 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 73bafaaaea..34284359f0 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 typedef struct AcpiGenericInitiatorClass {
     ObjectClass parent_class;
@@ -79,7 +80,7 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDevice *pci_dev;
+    uint8_t bus, devfn;
     Object *o;
 
     if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
@@ -100,10 +101,10 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
         exit(1);
     }
 
-    pci_dev = PCI_DEVICE(o);
-    build_srat_pci_generic_initiator(table_data, gi->node, 0,
-                                     pci_bus_num(pci_get_bus(pci_dev)),
-                                     pci_dev->devfn);
+    bus = object_property_get_uint(o, "bus", &error_fatal);
+    devfn = object_property_get_uint(o, "addr", &error_fatal);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 324c1302d2..b4b499b172 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void prop_pci_bus_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t bus = pci_dev_bus_num(PCI_DEVICE(obj));
+
+    visit_type_uint8(v, name, &bus, errp);
+}
+
+static const PropertyInfo prop_pci_bus = {
+    .name = "bus",
+    .get = prop_pci_bus_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -85,6 +98,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    { .name = "bus", .info = &prop_pci_bus },
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0

