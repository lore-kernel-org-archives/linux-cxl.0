Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39248C433E6
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 12F9764EDA
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:02:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBBBB7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:59 -0500
Received: from mga06.intel.com ([134.134.136.31]:21915 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229786AbhBBBB7 (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:59 -0500
IronPort-SDR: 64owz2tDLXdB/peMOn73vrBVrCiGNRT0XOCylSlbbEzQkuejSXYwdhwLyhic6hNQ2X1SnihVoD
 859u9pnIFuYw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294658"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294658"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:19 -0800
IronPort-SDR: NgEq2Mwl/JcOSGg864CBT/HUUoL6e4npNZM+RZu8acCb3VhepGbNBRPNaCCl1PvOgoxY+jtdIP
 9hadoR1T4+Gw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764257"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:18 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     qemu-devel@nongnu.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-cxl@vger.kernel.org,
        Chris Browy <cbrowy@avery-design.com>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 25/31] acpi/cxl: Create the CEDT (9.14.1)
Date:   Mon,  1 Feb 2021 16:59:42 -0800
Message-Id: <20210202005948.241655-26-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

v2: Update CHBS to spec released definition
v3: squash ACPI0017 in now that it's ratified.

Link: https://lore.kernel.org/linux-cxl/20210115034911.nkgpzc756d6qmjpl@intel.com/T/#t
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/acpi/cxl.c                       | 69 +++++++++++++++++++++++++++++
 hw/i386/acpi-build.c                | 25 ++++++++++-
 hw/pci-bridge/pci_expander_bridge.c | 21 +--------
 include/hw/acpi/cxl.h               |  4 ++
 include/hw/pci/pci_bridge.h         | 25 +++++++++++
 5 files changed, 123 insertions(+), 21 deletions(-)

diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 7124d5a1a3..68db0fe3a8 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -18,14 +18,83 @@
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
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/cxl.h"
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
+    /* UID */
+    build_append_int_noprefix(table_data, cxl->uid, 4);
+
+    /* Version */
+    build_append_int_noprefix(table_data, 1, 4);
+
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+
+    /* Base */
+    build_append_int_noprefix(table_data, mr->addr, 8);
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
+        PXBDev *pxb = PXB_CXL_DEV(obj);
+
+        cedt_build_chbs(cedt->buf, pxb);
+    }
+
+    return 0;
+}
+
+void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
+                    BIOSLinker *linker)
+{
+    const int cedt_start = table_data->len;
+    Aml *cedt;
+
+    cedt = init_aml_allocator();
+
+    /* reserve space for CEDT header */
+    acpi_add_table(table_offsets, table_data);
+    acpi_data_push(cedt->buf, sizeof(AcpiTableHeader));
+
+    object_child_foreach_recursive(object_get_root(), cxl_foreach_pxb_hb, cedt);
+
+    /* copy AML table into ACPI tables blob and patch header there */
+    g_array_append_vals(table_data, cedt->buf->data, cedt->buf->len);
+    build_header(linker, table_data, (void *)(table_data->data + cedt_start),
+                 "CEDT", table_data->len - cedt_start, 1, NULL, NULL);
+    free_aml_allocator();
+}
+
 static Aml *__build_cxl_osc_method(void)
 {
     Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 2c2293b55f..7706856c49 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -75,6 +75,8 @@
 #include "hw/acpi/ipmi.h"
 #include "hw/acpi/hmat.h"
 
+#include "hw/acpi/cxl.h"
+
 /* These are used to size the ACPI tables for -M pc-i440fx-1.7 and
  * -M pc-i440fx-2.0.  Even if the actual amount of AML generated grows
  * a little bit, there should be plenty of free space since the DSDT
@@ -1219,6 +1221,19 @@ static void init_pci_acpi(Aml *dev, int uid, int type)
     }
 }
 
+static void build_acpi0017(Aml *table)
+{
+    Aml *dev;
+    Aml *scope;
+
+    scope =  aml_scope("_SB");
+    dev = aml_device("CXLM");
+    aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+
+    aml_append(scope, dev);
+    aml_append(table, scope);
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1235,6 +1250,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     int root_bus_limit = 0xFF;
     PCIBus *bus = NULL;
     TPMIf *tpm = tpm_find();
+    bool cxl_present = false;
     int i;
     VMBusBridge *vmbus_bridge = vmbus_bridge_find();
 
@@ -1371,7 +1387,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
             scope = aml_scope("\\_SB");
             if (type == CXL) {
-                dev = aml_device("CXL%.01X", pci_bus_uid(bus));
+                dev = aml_device("CXL%.01X", uid);
             } else {
                 dev = aml_device("PC%.02X", bus_num);
             }
@@ -1391,6 +1407,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
             /* Handle the ranges for the PXB expanders */
             if (type == CXL) {
+                cxl_present = true;
                 uint64_t base = CXL_HOST_BASE + uid * 0x10000;
                 crs_range_insert(crs_range_set.mem_ranges, base,
                                  base + 0x10000 - 1);
@@ -1398,6 +1415,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         }
     }
 
+    if (cxl_present) {
+        build_acpi0017(dsdt);
+    }
+
     /*
      * At this point crs_range_set has all the ranges used by pci
      * busses *other* than PCI0.  These ranges will be excluded from
@@ -2278,6 +2299,8 @@ void acpi_build(AcpiBuildTables *tables, MachineState *machine)
                           machine->nvdimms_state, machine->ram_slots);
     }
 
+    cxl_build_cedt(table_offsets, tables_blob, tables->linker);
+
     acpi_add_table(table_offsets, tables_blob);
     build_waet(tables_blob, tables->linker);
 
diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
index af1450c69d..6458d5b76e 100644
--- a/hw/pci-bridge/pci_expander_bridge.c
+++ b/hw/pci-bridge/pci_expander_bridge.c
@@ -57,26 +57,6 @@ DECLARE_INSTANCE_CHECKER(PXBDev, PXB_DEV,
 DECLARE_INSTANCE_CHECKER(PXBDev, PXB_PCIE_DEV,
                          TYPE_PXB_PCIE_DEVICE)
 
-#define TYPE_PXB_CXL_DEVICE "pxb-cxl"
-DECLARE_INSTANCE_CHECKER(PXBDev, PXB_CXL_DEV,
-                         TYPE_PXB_CXL_DEVICE)
-
-struct PXBDev {
-    /*< private >*/
-    PCIDevice parent_obj;
-    /*< public >*/
-
-    uint8_t bus_nr;
-    uint16_t numa_node;
-    int32_t uid;
-    struct cxl_dev {
-        HostMemoryBackend *memory_window[CXL_WINDOW_MAX];
-
-        uint32_t num_windows;
-        hwaddr *window_base[CXL_WINDOW_MAX];
-    } cxl;
-};
-
 typedef struct CXLHost {
     PCIHostState parent_obj;
 
@@ -351,6 +331,7 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
         bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_CXL_BUS);
         bus->flags |= PCI_BUS_CXL;
         PXB_CXL_HOST(ds)->dev = PXB_CXL_DEV(dev);
+        PXB_CXL_DEV(dev)->cxl.cxl_host_bridge = ds;
     } else {
         bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
         bds = qdev_new("pci-bridge");
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index 7b8f3b8a2e..db2063f8c9 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -18,6 +18,10 @@
 #ifndef HW_ACPI_CXL_H
 #define HW_ACPI_CXL_H
 
+#include "hw/acpi/bios-linker-loader.h"
+
+void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
+                    BIOSLinker *linker);
 void build_cxl_osc_method(Aml *dev);
 
 #endif
diff --git a/include/hw/pci/pci_bridge.h b/include/hw/pci/pci_bridge.h
index a94d350034..50dd7fdf33 100644
--- a/include/hw/pci/pci_bridge.h
+++ b/include/hw/pci/pci_bridge.h
@@ -28,6 +28,7 @@
 
 #include "hw/pci/pci.h"
 #include "hw/pci/pci_bus.h"
+#include "hw/cxl/cxl.h"
 #include "qom/object.h"
 
 typedef struct PCIBridgeWindows PCIBridgeWindows;
@@ -81,6 +82,30 @@ struct PCIBridge {
 #define PCI_BRIDGE_DEV_PROP_MSI        "msi"
 #define PCI_BRIDGE_DEV_PROP_SHPC       "shpc"
 
+struct PXBDev {
+    /*< private >*/
+    PCIDevice parent_obj;
+    /*< public >*/
+
+    uint8_t bus_nr;
+    uint16_t numa_node;
+    int32_t uid;
+
+    struct cxl_dev {
+        HostMemoryBackend *memory_window[CXL_WINDOW_MAX];
+
+        uint32_t num_windows;
+        hwaddr *window_base[CXL_WINDOW_MAX];
+
+        void *cxl_host_bridge; /* Pointer to a CXLHost */
+    } cxl;
+};
+
+typedef struct PXBDev PXBDev;
+#define TYPE_PXB_CXL_DEVICE "pxb-cxl"
+DECLARE_INSTANCE_CHECKER(PXBDev, PXB_CXL_DEV,
+                         TYPE_PXB_CXL_DEVICE)
+
 int pci_bridge_ssvid_init(PCIDevice *dev, uint8_t offset,
                           uint16_t svid, uint16_t ssid,
                           Error **errp);
-- 
2.30.0

