Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B784C433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Feb 2022 14:22:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbiBBOWz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Feb 2022 09:22:55 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4641 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344872AbiBBOWz (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Feb 2022 09:22:55 -0500
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpkXC6ty3z67Pmr;
        Wed,  2 Feb 2022 22:22:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 15:22:53 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 2 Feb 2022 14:22:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>, <linuxarm@huawei.com>,
        "Shameerali Kolothum Thodi" <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v5 24/43] acpi/cxl: Create the CEDT (9.14.1)
Date:   Wed, 2 Feb 2022 14:10:18 +0000
Message-ID: <20220202141037.17352-25-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
References: <20220202141037.17352-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The CXL Early Discovery Table is defined in the CXL 2.0 specification as
a way for the OS to get CXL specific information from the system
firmware.

CXL 2.0 specification adds an _HID, ACPI0016, for CXL capable host
bridges, with a _CID of PNP0A08 (PCIe host bridge). CXL aware software
is able to use this initiate the proper _OSC method, and get the _UID
which is referenced by the CEDT. Therefore the existence of an ACPI0016
device allows a CXL aware driver perform the necessary actions. For a
CXL capable OS, this works. For a CXL unaware OS, this works.

CEDT awaremess requires more. The motivation for ACPI0017 is to provide
the possibility of having a Linux CXL module that can work on a legacy
Linux kernel. Linux core PCI/ACPI which won't be built as a module,
will see the _CID of PNP0A08 and bind a driver to it. If we later loaded
a driver for ACPI0016, Linux won't be able to bind it to the hardware
because it has already bound the PNP0A08 driver. The ACPI0017 device is
an opportunity to have an object to bind a driver will be used by a
Linux driver to walk the CXL topology and do everything that we would
have preferred to do with ACPI0016.

There is another motivation for an ACPI0017 device which isn't
implemented here. An operating system needs an attach point for a
non-volatile region provider that understands cross-hostbridge
interleaving. Since QEMU emulation doesn't support interleaving yet,
this is more important on the OS side, for now.

As of CXL 2.0 spec, only 1 sub structure is defined, the CXL Host Bridge
Structure (CHBS) which is primarily useful for telling the OS exactly
where the MMIO for the host bridge is.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---

v5: Part of this patch moved earlier to fix a reset issue.

 hw/acpi/cxl.c                       | 68 +++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                | 27 ++++++++++++
 hw/pci-bridge/pci_expander_bridge.c | 18 --------
 include/hw/acpi/cxl.h               |  5 +++
 include/hw/pci/pci_bridge.h         | 20 +++++++++
 5 files changed, 120 insertions(+), 18 deletions(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 7124d5a1a3..442f836a3e 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -18,7 +18,11 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/sysbus.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_host.h"
 #include "hw/cxl/cxl.h"
+#include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi.h"
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
@@ -26,6 +30,70 @@
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 
+static void cedt_build_chbs(GArray *table_data, PXBDev *cxl)
+{
+    SysBusDevice *sbd = SYS_BUS_DEVICE(cxl->cxl.cxl_host_bridge);
+    struct MemoryRegion *mr = sbd->mmio[0].memory;
+
+    /* Type */
+    build_append_int_noprefix(table_data, 0, 1);
+
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 1);
+
+    /* Record Length */
+    build_append_int_noprefix(table_data, 32, 2);
+
+    /* UID - currently equal to bus number */
+    build_append_int_noprefix(table_data, cxl->bus_nr, 4);
+
+    /* Version */
+    build_append_int_noprefix(table_data, 1, 4);
+
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    /* Base - subregion within a container that is in PA space */
+    build_append_int_noprefix(table_data, mr->container->addr + mr->addr, 8);
+
+    /* Length */
+    build_append_int_noprefix(table_data, memory_region_size(mr), 8);
+}
+
+static int cxl_foreach_pxb_hb(Object *obj, void *opaque)
+{
+    Aml *cedt = opaque;
+
+    if (object_dynamic_cast(obj, TYPE_PXB_CXL_DEVICE)) {
+        cedt_build_chbs(cedt->buf, PXB_CXL_DEV(obj));
+    }
+
+    return 0;
+}
+
+void cxl_build_cedt(MachineState *ms, GArray *table_offsets, GArray *table_data,
+                    BIOSLinker *linker, const char *oem_id,
+                    const char *oem_table_id)
+{
+    Aml *cedt;
+    AcpiTable table = { .sig = "CEDT", .rev = 1, .oem_id = oem_id,
+                        .oem_table_id = oem_table_id };
+
+    acpi_add_table(table_offsets, table_data);
+    acpi_table_begin(&table, table_data);
+    cedt = init_aml_allocator();
+
+    /* reserve space for CEDT header */
+
+    object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
+
+    /* copy AML table into ACPI tables blob and patch header there */
+    g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
+    free_aml_allocator();
+
+    acpi_table_end(linker, &table);
+}
+
 static Aml *__build_cxl_osc_method(void)
 {
     Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index cec7465267..0479bf4444 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -76,6 +76,8 @@
 #include "hw/acpi/hmat.h"
 #include "hw/acpi/viot.h"
 
+#include "hw/acpi/cxl.h"
+
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
  * a little bit, there should be plenty of free space since the DSDT
@@ -1429,6 +1431,22 @@ static void init_pci_acpi(Aml *dev, int uid, PCIBusType type,
     }
 }
 
+static void build_acpi0017(Aml *table)
+{
+    Aml *dev, *scope, *method;
+
+    scope =  aml_scope("_SB");
+    dev = aml_device("CXLM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+    method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+    aml_append(method, aml_return(aml_int(0x01)));
+    aml_append(dev, method);
+
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1448,6 +1466,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 #ifdef CONFIG_TPM
     TPMIf *tpm = tpm_find();
 #endif
+    bool cxl_present = false;
     int i;
     VMBusBridge *vmbus_bridge = vmbus_bridge_find();
     AcpiTable table = { .sig = "DSDT", .rev = 1, .oem_id = x86ms->oem_id,
@@ -1616,12 +1635,17 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 MemoryRegion *mr = &machine->cxl_devices_state->host_mr;
                 uint64_t base = mr->addr;
 
+                cxl_present = true;
                 crs_range_insert(crs_range_set.mem_ranges, base,
                                  base + memory_region_size(mr) - 1);
             }
         }
     }
 
+    if (cxl_present) {
+        build_acpi0017(dsdt);
+    }
+
     /*
      * At this point crs_range_set has all the ranges used by pci
      * busses *other* than PCI0.  These ranges will be excluded from
@@ -2675,6 +2699,9 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           x86ms->oem_id, x86ms->oem_table_id);
     }
 
+    cxl_build_cedt(machine, table_offsets, tables_blob, tables->linker,
+                   x86ms->oem_id, x86ms->oem_table_id);
+
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker, x86ms->oem_id, x86ms->oem_table_id);
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index 164bdeff9f..9a2710c067 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -57,30 +57,12 @@ DECLARE_INSTANCE_CHECKER(PXBDev, PXB_DEV,
 DECLARE_INSTANCE_CHECKER(PXBDev, PXB_PCIE_DEV,
                          TYPE_PXB_PCIE_DEVICE)
 
-#define TYPE_PXB_CXL_DEVICE "pxb-cxl"
-DECLARE_INSTANCE_CHECKER(PXBDev, PXB_CXL_DEV,
-                         TYPE_PXB_CXL_DEVICE)
-
 typedef struct CXLHost {
     PCIHostState parent_obj;
 
     CXLComponentState cxl_cstate;
 } CXLHost;
 
-
-struct PXBDev {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    uint8_t bus_nr;
-    uint16_t numa_node;
-    bool bypass_iommu;
-    struct cxl_dev {
-        CXLHost *cxl_host_bridge;
-    } cxl;
-};
-
 static PXBDev *convert_to_pxb(PCIDevice *dev)
 {
     /* A CXL PXB's parent bus is PCIe, so the normal check won't work */
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index 7b8f3b8a2e..0c496538c0 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -18,6 +18,11 @@
 #ifndef HW_ACPI_CXL_H
 #define HW_ACPI_CXL_H
 
+#include "hw/acpi/bios-linker-loader.h"
+
+void cxl_build_cedt(MachineState *ms, GArray *table_offsets, GArray *table_data,
+                    BIOSLinker *linker, const char *oem_id,
+                    const char *oem_table_id);
 void build_cxl_osc_method(Aml *dev);
 
 #endif
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index 30691a6e57..ba4bafac7c 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -28,6 +28,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/cxl/cxl.h"
 #include "qom/object.h"
 
 typedef struct PCIBridgeWindows PCIBridgeWindows;
@@ -80,6 +81,25 @@ struct PCIBridge {
 #define PCI_BRIDGE_DEV_PROP_CHASSIS_NR "chassis_nr"
 #define PCI_BRIDGE_DEV_PROP_MSI        "msi"
 #define PCI_BRIDGE_DEV_PROP_SHPC       "shpc"
+typedef struct CXLHost CXLHost;
+
+struct PXBDev {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    uint8_t bus_nr;
+    uint16_t numa_node;
+    bool bypass_iommu;
+    struct cxl_dev {
+        CXLHost *cxl_host_bridge; /* Pointer to a CXLHost */
+    } cxl;
+};
+
+typedef struct PXBDev PXBDev;
+#define TYPE_PXB_CXL_DEVICE "pxb-cxl"
+DECLARE_INSTANCE_CHECKER(PXBDev, PXB_CXL_DEV,
+                         TYPE_PXB_CXL_DEVICE)
 
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
-- 
2.32.0

