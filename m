Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85B433C7
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jul 2024 11:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720782675; cv=none; b=dWqdv4Q6RIhuIzs7tAYQFfKRHxDs3vpu0DH2tK6jtHtNNtSO8aOEPpsixYFslqO2i/ugYJhFCl44crBJOUohSAklCng+28wkQqiegENzHmEHtw5oDe4ah6oq4w4e64lJE+PG2XFt+6+YAO8jA4/jeurbKKTcTnXaboY1bhcuD3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720782675; c=relaxed/simple;
	bh=2eVJktb7xcJ0pIryoRK0svE9KcrQpwI/x79Fv/Bwl1c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FCkPaVo3MSrjntDuK1qaCM212SZ4qvDZk+w/zmx9LtJ0y1ZOBhRILBRVg1LdIBes/hcGd3F/874rperGh35tQvuxUnpoqqpLkt01ikJ6ORFuexbP7ZvgtPhfvdCNVRw+ZVimQvxlfP6X0uI9sYsoocKxaRrt4NyZCY23oCbQPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WL85C0qbqz6JB4X;
	Fri, 12 Jul 2024 19:10:07 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 122B014058E;
	Fri, 12 Jul 2024 19:11:11 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 12 Jul 2024 12:11:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <imammedo@redhat.com>, <mst@redhat.com>, Markus Armbruster
	<armbru@redhat.com>, <qemu-devel@nongnu.org>, <ankita@nvidia.com>
CC: <linuxarm@huawei.com>, <linux-cxl@vger.kernel.org>,
	<marcel.apfelbaum@gmail.com>, <philmd@linaro.org>, Richard Henderson
	<richard.henderson@linaro.org>, Dave Jiang <dave.jiang@intel.com>, Huang Ying
	<ying.huang@intel.com>, Paolo Bonzini <pbonzini@redhat.com>,
	<eduardo@habkost.net>, Michael Roth <michael.roth@amd.com>, Ani Sinha
	<anisinha@redhat.com>
Subject: [PATCH v5 05/13] hw/pci: Add a busnr property to pci_props and use for acpi/gi
Date: Fri, 12 Jul 2024 12:08:09 +0100
Message-ID: <20240712110837.1439736-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
References: <20240712110837.1439736-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Using a property allows us to hide the internal details of the PCI device
from the code to build a SRAT Generic Initiator Affinity Structure with
PCI Device Handle.

Suggested-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V5: Add assert() to catch if devfn is out of permissible range of
    0 to 255.
---
 hw/acpi/acpi_generic_initiator.c | 14 +++++++++-----
 hw/pci/pci.c                     | 14 ++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/hw/acpi/acpi_generic_initiator.c b/hw/acpi/acpi_generic_initiator.c
index 73bafaaaea..365feb527f 100644
--- a/hw/acpi/acpi_generic_initiator.c
+++ b/hw/acpi/acpi_generic_initiator.c
@@ -9,6 +9,7 @@
 #include "hw/boards.h"
 #include "hw/pci/pci_device.h"
 #include "qemu/error-report.h"
+#include "qapi/error.h"
 
 typedef struct AcpiGenericInitiatorClass {
     ObjectClass parent_class;
@@ -79,7 +80,8 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
     MachineState *ms = MACHINE(qdev_get_machine());
     AcpiGenericInitiator *gi;
     GArray *table_data = opaque;
-    PCIDevice *pci_dev;
+    int32_t devfn;
+    uint8_t bus;
     Object *o;
 
     if (!object_dynamic_cast(obj, TYPE_ACPI_GENERIC_INITIATOR)) {
@@ -100,10 +102,12 @@ static int build_acpi_generic_initiator(Object *obj, void *opaque)
         exit(1);
     }
 
-    pci_dev = PCI_DEVICE(o);
-    build_srat_pci_generic_initiator(table_data, gi->node, 0,
-                                     pci_bus_num(pci_get_bus(pci_dev)),
-                                     pci_dev->devfn);
+    bus = object_property_get_uint(o, "busnr", &error_fatal);
+    devfn = object_property_get_int(o, "addr", &error_fatal);
+    /* devfn is constrained in PCI to be 8 bit but storage is an int32_t */
+    assert(devfn >= 0 && devfn < PCI_DEVFN_MAX);
+
+    build_srat_pci_generic_initiator(table_data, gi->node, 0, bus, devfn);
 
     return 0;
 }
diff --git a/hw/pci/pci.c b/hw/pci/pci.c
index 4c7be52951..e3d1a83e31 100644
--- a/hw/pci/pci.c
+++ b/hw/pci/pci.c
@@ -67,6 +67,19 @@ static char *pcibus_get_fw_dev_path(DeviceState *dev);
 static void pcibus_reset_hold(Object *obj, ResetType type);
 static bool pcie_has_upstream_port(PCIDevice *dev);
 
+static void prop_pci_busnr_get(Object *obj, Visitor *v, const char *name,
+                             void *opaque, Error **errp)
+{
+    uint8_t busnr = pci_dev_bus_num(PCI_DEVICE(obj));
+
+    visit_type_uint8(v, name, &busnr, errp);
+}
+
+static const PropertyInfo prop_pci_busnr = {
+    .name = "busnr",
+    .get = prop_pci_busnr_get,
+};
+
 static Property pci_props[] = {
     DEFINE_PROP_PCI_DEVFN("addr", PCIDevice, devfn, -1),
     DEFINE_PROP_STRING("romfile", PCIDevice, romfile),
@@ -85,6 +98,7 @@ static Property pci_props[] = {
                     QEMU_PCIE_ERR_UNC_MASK_BITNR, true),
     DEFINE_PROP_BIT("x-pcie-ari-nextfn-1", PCIDevice, cap_present,
                     QEMU_PCIE_ARI_NEXTFN_1_BITNR, false),
+    { .name = "busnr", .info = &prop_pci_busnr },
     DEFINE_PROP_END_OF_LIST()
 };
 
-- 
2.43.0

