Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C501C0015E
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:22:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjGQRWZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:22:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQRWY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:22:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5AD132
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:22:23 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TNT2LRHz6J75J;
        Tue, 18 Jul 2023 01:19:53 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:22:20 +0100
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
Subject: [RFC PATCH 11/17] HACK: arm/virt: Add aspeed-i2c controller and MCTP EP to enable MCTP testing
Date:   Mon, 17 Jul 2023 18:16:40 +0100
Message-ID: <20230717171646.8972-12-Jonathan.Cameron@huawei.com>
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

As the only I2C emulation in QEMU that supports being both
a master and a slave, suitable for MCTP over i2c is aspeed-i2c
add this controller to the arm virt model and hook up our new
i2c_mctp_cxl_fmapi device.

The current Linux driver for aspeed-i2c has a hard requirement on
a reset controller.  Throw down the simplest reset controller
I could find so as to avoid need to make any changes to the kernel
code.

Patch also builds appropriate device tree.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/arm/virt.h |  2 +
 hw/arm/virt.c         | 86 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 88 insertions(+)

diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
index 9fc582fc5f..ea3a64f4a8 100644
--- a/include/hw/arm/virt.h
+++ b/include/hw/arm/virt.h
@@ -72,6 +72,8 @@ enum {
     VIRT_SMMU,
     VIRT_UART,
     VIRT_MMIO,
+    VIRT_I2C,
+    VIRT_RESET_FAKE,
     VIRT_RTC,
     VIRT_FW_CFG,
     VIRT_PCIE,
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 5512ad4ba4..67e694550e 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -85,6 +85,8 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 #include "qemu/guest-random.h"
+#include "hw/i2c/i2c.h"
+#include "hw/i2c/aspeed_i2c.h"
 
 #define DEFINE_VIRT_MACHINE_LATEST(major, minor, latest) \
     static void virt_##major##_##minor##_class_init(ObjectClass *oc, \
@@ -161,6 +163,8 @@ static const MemMapEntry base_memmap[] = {
     [VIRT_PVTIME] =             { 0x090a0000, 0x00010000 },
     [VIRT_SECURE_GPIO] =        { 0x090b0000, 0x00001000 },
     [VIRT_MMIO] =               { 0x0a000000, 0x00000200 },
+    [VIRT_I2C] =                { 0x0b000000, 0x00004000 },
+    [VIRT_RESET_FAKE] =         { 0x0b004000, 0x00000010 },
     /* ...repeating for a total of NUM_VIRTIO_TRANSPORTS, each of that size */
     [VIRT_PLATFORM_BUS] =       { 0x0c000000, 0x02000000 },
     [VIRT_SECURE_MEM] =         { 0x0e000000, 0x01000000 },
@@ -203,6 +207,7 @@ static const int a15irqmap[] = {
     [VIRT_GPIO] = 7,
     [VIRT_SECURE_UART] = 8,
     [VIRT_ACPI_GED] = 9,
+    [VIRT_I2C] = 10,
     [VIRT_MMIO] = 16, /* ...to 16 + NUM_VIRTIO_TRANSPORTS - 1 */
     [VIRT_GIC_V2M] = 48, /* ...to 48 + NUM_GICV2M_SPIS - 1 */
     [VIRT_SMMU] = 74,    /* ...to 74 + NUM_SMMU_IRQS - 1 */
@@ -2268,6 +2273,85 @@ static void virt_cpu_post_init(VirtMachineState *vms, MemoryRegion *sysmem)
     }
 }
 
+static void create_mctp(MachineState *ms)
+{
+    VirtMachineState *vms = VIRT_MACHINE(ms);
+    MemoryRegion *sysmem = get_system_memory();
+    AspeedI2CState *aspeedi2c;
+    struct DeviceState  *dev;
+    char *nodename_i2c_master;
+    char *nodename_i2c_sub;
+    char *nodename_reset;
+    uint32_t clk_phandle, reset_phandle;
+    MemoryRegion *sysmem2;
+
+    dev = qdev_new("aspeed.i2c-ast2600");
+    aspeedi2c = ASPEED_I2C(dev);
+    object_property_set_link(OBJECT(dev), "dram", OBJECT(ms->ram),
+                             &error_fatal);
+    sysbus_realize_and_unref(SYS_BUS_DEVICE(dev), &error_fatal);
+    sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, vms->memmap[VIRT_I2C].base);
+    sysbus_connect_irq(SYS_BUS_DEVICE(&aspeedi2c->busses[0]), 0,
+                       qdev_get_gpio_in(vms->gic, vms->irqmap[VIRT_I2C]));
+
+    /* I2C bus DT */
+    reset_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+    nodename_reset = g_strdup_printf("/reset@%" PRIx64,
+                                     vms->memmap[VIRT_RESET_FAKE].base);
+    qemu_fdt_add_subnode(ms->fdt, nodename_reset);
+    qemu_fdt_setprop_string(ms->fdt, nodename_reset,
+                            "compatible", "snps,dw-low-reset");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename_reset, "reg",
+                                 2, vms->memmap[VIRT_RESET_FAKE].base,
+                                 2, vms->memmap[VIRT_RESET_FAKE].size);
+    qemu_fdt_setprop_cell(ms->fdt, nodename_reset, "#reset-cells", 0x1);
+    qemu_fdt_setprop_cell(ms->fdt, nodename_reset, "phandle", reset_phandle);
+    sysmem2 =  g_new(MemoryRegion, 1);
+    memory_region_init_ram(sysmem2, NULL, "reset",
+                           vms->memmap[VIRT_RESET_FAKE].size, NULL);
+    memory_region_add_subregion(sysmem,
+                                vms->memmap[VIRT_RESET_FAKE].base, sysmem2);
+
+    clk_phandle = qemu_fdt_alloc_phandle(ms->fdt);
+
+    qemu_fdt_add_subnode(ms->fdt, "/mclk");
+    qemu_fdt_setprop_string(ms->fdt, "/mclk", "compatible", "fixed-clock");
+    qemu_fdt_setprop_cell(ms->fdt, "/mclk", "#clock-cells", 0x0);
+    qemu_fdt_setprop_cell(ms->fdt, "/mclk", "clock-frequency", 24000);
+    qemu_fdt_setprop_string(ms->fdt, "/mclk", "clock-output-names", "bobsclk");
+    qemu_fdt_setprop_cell(ms->fdt, "/mclk", "phandle", clk_phandle);
+
+    nodename_i2c_master = g_strdup_printf("/i2c@%" PRIx64,
+                                          vms->memmap[VIRT_I2C].base);
+    qemu_fdt_add_subnode(ms->fdt, nodename_i2c_master);
+    qemu_fdt_setprop_string(ms->fdt, nodename_i2c_master,
+                            "compatible",  "aspeed,ast2600-i2c-bus");
+    qemu_fdt_setprop_cells(ms->fdt, nodename_i2c_master, "multi-master");
+    qemu_fdt_setprop_cell(ms->fdt, nodename_i2c_master, "#size-cells", 0);
+    qemu_fdt_setprop_cell(ms->fdt, nodename_i2c_master, "#address-cells", 1);
+    qemu_fdt_setprop_cell(ms->fdt, nodename_i2c_master, "clocks", clk_phandle);
+    qemu_fdt_setprop_string(ms->fdt, nodename_i2c_master,
+                            "clock-names", "bobsclk");
+    qemu_fdt_setprop(ms->fdt, nodename_i2c_master, "mctp-controller", NULL, 0);
+    qemu_fdt_setprop_cells(ms->fdt, nodename_i2c_master,
+                           "interrupts", GIC_FDT_IRQ_TYPE_SPI,
+                           vms->irqmap[VIRT_I2C], GIC_FDT_IRQ_FLAGS_LEVEL_HI);
+    /* Offset to the first bus is 0x80, next one at 0x100 etc */
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename_i2c_master, "reg",
+                                 2, vms->memmap[VIRT_I2C].base + 0x80,
+                                 2, 0x80);
+    qemu_fdt_setprop_cells(ms->fdt, nodename_i2c_master,
+                           "resets", reset_phandle,  0);
+
+    nodename_i2c_sub = g_strdup_printf("/i2c@%" PRIx64 "/mctp@%" PRIx64,
+                                       vms->memmap[VIRT_I2C].base, 0x50l);
+    qemu_fdt_add_subnode(ms->fdt, nodename_i2c_sub);
+    qemu_fdt_setprop_string(ms->fdt, nodename_i2c_sub,
+                            "compatible",  "mctp-i2c-controller");
+    qemu_fdt_setprop_sized_cells(ms->fdt, nodename_i2c_sub,
+                                 "reg", 1, 0x50 | 0x40000000);
+}
+
 static void machvirt_init(MachineState *machine)
 {
     VirtMachineState *vms = VIRT_MACHINE(machine);
@@ -2555,6 +2639,8 @@ static void machvirt_init(MachineState *machine)
         create_gpio_devices(vms, VIRT_SECURE_GPIO, secure_sysmem);
     }
 
+    create_mctp(machine);
+
      /* connect powerdown request */
      vms->powerdown_notifier.notify = virt_powerdown_req;
      qemu_register_powerdown_notifier(&vms->powerdown_notifier);
-- 
2.39.2

