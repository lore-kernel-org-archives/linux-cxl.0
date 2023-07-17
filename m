Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36B7AC001DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:23:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjGQRXM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbjGQRW5 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:22:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE42E4C
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:22:54 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TN84xhVz67T1b;
        Tue, 18 Jul 2023 01:19:36 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:22:51 +0100
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
Subject: [RFC PATCH 12/17] HACK: hw/arm/virt: Add ACPI support for aspeed-i2c / mctp
Date:   Mon, 17 Jul 2023 18:16:41 +0100
Message-ID: <20230717171646.8972-13-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Enable this for FM-API testing for CXL devices via MCTP over I2C

Example DSDT block:

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
        Memory32Fixed (ReadWrite,
            0x0B000080,         // Address Base
            0x00000080,         // Address Length
            )
        Interrupt (ResourceConsumer, Level, ActiveHigh, Exclusive, ,, )
        {
            0x0000002A,
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

Tests not updated given I'm not currently proposing this for upstream.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/arm/virt-acpi-build.c | 60 ++++++++++++++++++++++++++++++++++++++++
 hw/i2c/meson.build       |  2 +-
 2 files changed, 61 insertions(+), 1 deletion(-)

diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index e4a74324b8..ad31e2055e 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -78,6 +78,65 @@ static void acpi_dsdt_add_cpus(Aml *scope, VirtMachineState *vms)
     }
 }
 
+static void acpi_dsdt_add_mctp(Aml *scope, VirtMachineState *vms)
+{
+    uint32_t interrupt = vms->irqmap[VIRT_I2C] + ARM_SPI_BASE;
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
+    aml_append(crs, aml_memory32_fixed(vms->memmap[VIRT_I2C].base + 0x80,
+                                      0x80, AML_READ_WRITE));
+    aml_append(crs,
+               aml_interrupt(AML_CONSUMER, AML_LEVEL, AML_ACTIVE_HIGH,
+                             AML_EXCLUSIVE, &interrupt, 1));
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
 static void acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
                                            uint32_t uart_irq)
 {
@@ -888,6 +947,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
      */
     scope = aml_scope("\\_SB");
     acpi_dsdt_add_cpus(scope, vms);
+    acpi_dsdt_add_mctp(scope, vms);
     acpi_dsdt_add_uart(scope, &memmap[VIRT_UART],
                        (irqmap[VIRT_UART] + ARM_SPI_BASE));
     if (vmc->acpi_expose_flash) {
diff --git a/hw/i2c/meson.build b/hw/i2c/meson.build
index d707ec58f7..75db13c10e 100644
--- a/hw/i2c/meson.build
+++ b/hw/i2c/meson.build
@@ -4,7 +4,7 @@ i2c_ss.add(when: 'CONFIG_MCTP_I2C', if_true: files('mctp.c'))
 i2c_ss.add(when: 'CONFIG_SMBUS', if_true: files('smbus_slave.c', 'smbus_master.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_SMBUS', if_true: files('pm_smbus.c'))
 i2c_ss.add(when: 'CONFIG_ACPI_ICH9', if_true: files('smbus_ich9.c'))
-i2c_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_i2c.c'))
+i2c_ss.add(when: 'CONFIG_I2C', if_true: files('aspeed_i2c.c'))
 i2c_ss.add(when: 'CONFIG_BITBANG_I2C', if_true: files('bitbang_i2c.c'))
 i2c_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210_i2c.c'))
 i2c_ss.add(when: 'CONFIG_IMX_I2C', if_true: files('imx_i2c.c'))
-- 
2.39.2

