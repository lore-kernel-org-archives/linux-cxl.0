Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20FE4EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:23:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjGQRX2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjGQRX1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:23:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EA4E47
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:23:24 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TPf490yz6J74j;
        Tue, 18 Jul 2023 01:20:54 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:23:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 13/17] HACK: hw/i386/pc: Add Aspeed i2c controller + MCTP with ACPI tables
Date:   Mon, 17 Jul 2023 18:16:42 +0100
Message-ID: <20230717171646.8972-14-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

CXL devices provide a standard Fabric Management API - FM-API.
See CXL specification r3.0 from https://www.computeexpresslink.org
In many real setups that will be used by a separate host from the
one actually using the CXL devices (BMC or similar) but it is
helpful to be able to use the main CXL emulation and the
Fabric Management emulation on a single host.  This 'hack' enables
that (with minor kernel driver changes).

There are many many things wrong with how this is done but for
now it enables use of this aspeed controller with ACPI FW
on an x86 host.  That is useful for testing MCTP over I2C.

If anyone has either:
1) Docs for an I2C controller with MCTP support that might actually
   appear on an x86 host.
2) A nice solution for how wrap this up in a device whilst minimising
   kernel changes.
3) A guide / reference example to how to do the interrupt 'right'
   (I'm an ARM focused developer so got lost in the x86 interrupt
    stuff).
then let me know.

For now this works and I will carry it out of tree on
gitlab.com/jic23/qemu.

DSDT blob - as this is a hack I haven't included test updates

Scope (_SB)
{
    Device (MCTP)
    {
        Name (_HID, "PRP0001")  // _HID: Hardware ID
        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
            Package (0x03)
            {
                Package (0x02)
                {
                    "compatible",
                    "aspeed,ast2600-i2c-bus"
                },

                Package (0x02)
                {
                    "bus-frequency",
                    0x00061A80
                },

                Package (0x02)
                {
                    "mctp-controller",
                    One
                }
            }
        })
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            QWordMemory (ResourceProducer, PosDecode, MinFixed, MaxFixed, NonCacheable, ReadWrite,
                0x0000000000000000, // Granularity
                0x00000004800FC080, // Range Minimum
                0x00000004800FC0FF, // Range Maximum
                0x0000000000000000, // Translation Offset
                0x0000000000000080, // Length
                ,, , AddressRangeMemory, TypeStatic)
            Interrupt (ResourceConsumer, Level, ActiveHigh, Shared, ,, )
            {
                0x00000007,
            }
        })
    }

    Device (MCTS)
    {
        Name (_HID, "PRP0001")  // _HID: Hardware ID
        Name (_CRS, ResourceTemplate ()  // _CRS: Current Resource Settings
        {
            I2cSerialBusV2 (0x0050, DeviceInitiated, 0x000186A0,
                AddressingMode7Bit, "\\_SB.MCTP",
                0x00, ResourceProducer, , Exclusive,
                )
        })
        Name (_DSD, Package (0x02)  // _DSD: Device-Specific Data
        {
            ToUUID ("daffd814-6eba-4d8c-8a91-bc9bbf4aa301") /* Device Properties for _DSD */,
            Package (0x01)
            {
                Package (0x02)
                {
                    "compatible",
                     "mctp-i2c-controller"
                }
            }
        })
    }
}

To add devices to the bus use something like:
 -device i2c_mctp_cxl_switch,bus=aspeed.i2c.bus.0,address=4,target=us0

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/i386/pc.h |  1 +
 hw/i386/acpi-build.c | 65 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 20 +++++++++++++-
 3 files changed, 85 insertions(+), 1 deletion(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index d54e8b1101..d60c3d44a7 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -56,6 +56,7 @@ typedef struct PCMachineState {
 
     SGXEPCState sgx_epc;
     CXLState cxl_devices_state;
+    hwaddr i2c_base;
 } PCMachineState;
 
 #define PC_MACHINE_ACPI_DEVICE_PROP "acpi-device"
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index c791fb2760..481ad87438 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1424,6 +1424,68 @@ static void build_acpi0017(Aml *table)
     aml_append(table, scope);
 }
 
+static void acpi_dsdt_add_mctp(Aml *scope, PCMachineState *pcms)
+{
+    uint32_t interrupt = 7;
+    Aml *main_dev = aml_device("MCTP");
+    Aml *sub_dev = aml_device("MCTS");
+    Aml *dsd_pkg = aml_package(2);
+    Aml *props_pkg = aml_package(3);
+    Aml *pkg = aml_package(2);
+    Aml *crs = aml_resource_template();
+
+    aml_append(main_dev, aml_name_decl("_HID", aml_string("PRP0001")));
+
+    aml_append(pkg, aml_string("compatible"));
+    aml_append(pkg, aml_string("aspeed,ast2600-i2c-bus"));
+    aml_append(props_pkg, pkg);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_string("bus-frequency"));
+    aml_append(pkg, aml_int(400000));
+    aml_append(props_pkg, pkg);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_string("mctp-controller"));
+    aml_append(pkg, aml_int(1));
+    aml_append(props_pkg, pkg);
+
+    aml_append(dsd_pkg, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+    aml_append(dsd_pkg, props_pkg);
+    aml_append(main_dev, aml_name_decl("_DSD", dsd_pkg));
+
+    aml_append(crs, aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                     AML_READ_WRITE, 0, pcms->i2c_base + 0x80,
+                                     pcms->i2c_base + 0x80 + 0x80 - 1,
+                                     0, 0x80));
+    aml_append(crs,
+               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                             AML_SHARED, &interrupt, 1));
+    aml_append(main_dev, aml_name_decl("_CRS", crs));
+
+    aml_append(sub_dev, aml_name_decl("_HID", aml_string("PRP0001")));
+
+    dsd_pkg = aml_package(2);
+    aml_append(dsd_pkg, aml_touuid("DAFFD814-6EBA-4D8C-8A91-BC9BBF4AA301"));
+
+    props_pkg = aml_package(1);
+
+    pkg = aml_package(2);
+    aml_append(pkg, aml_string("compatible"));
+    aml_append(pkg, aml_string("mctp-i2c-controller"));
+    aml_append(props_pkg, pkg);
+    aml_append(dsd_pkg, props_pkg);
+
+    crs = aml_resource_template();
+    aml_append(crs, aml_i2c_slv_serial_bus_device(0x50, "\\_SB.MCTP"));
+    aml_append(sub_dev, aml_name_decl("_CRS", crs));
+    aml_append(sub_dev, aml_name_decl("_DSD", dsd_pkg));
+
+    aml_append(scope, main_dev);
+    aml_append(scope, sub_dev);
+}
+
 /*
  * Precompute the crs ranges and bus numbers that will be used in PXB entries
  * in PXB SSDT.
@@ -1652,6 +1714,9 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
         build_hpet_aml(dsdt);
     }
 
+    sb_scope = aml_scope("_SB");
+    acpi_dsdt_add_mctp(sb_scope, pcms);
+    aml_append(dsdt, sb_scope);
     if (vmbus_bridge) {
         sb_scope = aml_scope("_SB");
         aml_append(sb_scope, build_vmbus_device_aml(vmbus_bridge));
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 3109d5e0e0..335b6f1265 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -93,6 +93,7 @@
 #include "hw/i386/kvm/xen_evtchn.h"
 #include "hw/i386/kvm/xen_gnttab.h"
 #include "hw/i386/kvm/xen_xenstore.h"
+#include "hw/i2c/aspeed_i2c.h"
 #include "sysemu/replay.h"
 #include "target/i386/cpu.h"
 #include "e820_memory_layout.h"
@@ -1074,6 +1075,8 @@ void pc_memory_init(PCMachineState *pcms,
         memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
         memory_region_add_subregion(system_memory, cxl_base, mr);
         cxl_resv_end = cxl_base + cxl_size;
+        pcms->i2c_base = cxl_resv_end - 0x4000;
+
         if (pcms->cxl_devices_state.fixed_windows) {
             hwaddr cxl_fmw_base;
             GList *it;
@@ -1157,7 +1160,7 @@ uint64_t pc_pci_hole64_start(void)
     ram_addr_t size = 0;
 
     if (pcms->cxl_devices_state.is_enabled) {
-        hole64_start = pc_get_cxl_range_end(pcms);
+        hole64_start = pc_get_cxl_range_end(pcms) + 0x4000;
     } else if (pcmc->has_reserved_memory && (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &hole64_start, &size);
         if (!pcmc->broken_reserved_end) {
@@ -1354,6 +1357,21 @@ void pc_basic_device_init(struct PCMachineState *pcms,
     /* Super I/O */
     pc_superio_init(isa_bus, create_fdctrl, pcms->i8042_enabled,
                     pcms->vmport != ON_OFF_AUTO_ON);
+
+    {
+        AspeedI2CState *aspeed_i2c;
+        struct DeviceState *dev;
+
+        dev = qdev_new("aspeed.i2c-ast2600");
+        aspeed_i2c = ASPEED_I2C(dev);
+        object_property_set_link(OBJECT(dev), "dram",
+                                 OBJECT(MACHINE(pcms)->ram), &error_fatal);
+        sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+        sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, pcms->i2c_base);
+        /* Hack ;) - Steal unused interrupt 7 */
+        sysbus_connect_irq(SYS_BUS_DEVICE(&aspeed_i2c->busses[0]), 0,
+                           x86ms->gsi[7]);
+    }
 }
 
 void pc_nic_init(PCMachineClass *pcmc, ISABus *isa_bus, PCIBus *pci_bus)
-- 
2.39.2

