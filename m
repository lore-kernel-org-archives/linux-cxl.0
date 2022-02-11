Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECA32C433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Feb 2022 12:22:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240058AbiBKMWk (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Feb 2022 07:22:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234260AbiBKMWi (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Feb 2022 07:22:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80029F26
        for <linux-cxl@vger.kernel.org>; Fri, 11 Feb 2022 04:22:37 -0800 (PST)
Received: from fraeml744-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JwCR13qQnz67rJb;
        Fri, 11 Feb 2022 20:21:49 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml744-chm.china.huawei.com (10.206.15.225) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 13:22:35 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 11 Feb 2022 12:22:34 +0000
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
Subject: [PATCH v6 29/43] hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
Date:   Fri, 11 Feb 2022 12:07:33 +0000
Message-ID: <20220211120747.3074-30-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
References: <20220211120747.3074-1-Jonathan.Cameron@huawei.com>
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

This adds code to instantiate the slightly extended ACPI root port
description in DSDT as per the CXL 2.0 specification.

Basically a cut and paste job from the i386/pc code.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/arm/Kconfig          |  1 +
 hw/pci-host/gpex-acpi.c | 22 +++++++++++++++++++---
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2e0049196d..3df419fa6d 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -29,6 +29,7 @@ config ARM_VIRT
     select ACPI_APEI
     select ACPI_VIOT
     select VIRTIO_MEM_SUPPORTED
+    select ACPI_CXL
 
 config CHEETAH
     bool
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index e7e162a00a..fb60aa517f 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -5,6 +5,7 @@
 #include "hw/pci/pci_bus.h"
 #include "hw/pci/pci_bridge.h"
 #include "hw/pci/pcie_host.h"
+#include "hw/acpi/cxl.h"
 
 static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
 {
@@ -139,6 +140,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
         QLIST_FOREACH(bus, &bus->child, sibling) {
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
+            bool is_cxl;
 
             if (!pci_bus_is_root(bus)) {
                 continue;
@@ -153,9 +155,19 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                 nr_pcie_buses = bus_num;
             }
 
+            is_cxl = pci_bus_is_cxl(bus);
+
             dev = aml_device("PC%.02X", bus_num);
-            aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
-            aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
+            if (is_cxl) {
+                struct Aml *pkg = aml_package(2);
+                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
+                aml_append(pkg, aml_eisaid("PNP0A08"));
+                aml_append(pkg, aml_eisaid("PNP0A03"));
+                aml_append(dev, aml_name_decl("_CID", pkg));
+            } else {
+                aml_append(dev, aml_name_decl("_HID", aml_string("PNP0A08")));
+                aml_append(dev, aml_name_decl("_CID", aml_string("PNP0A03")));
+            }
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_STR", aml_unicode("pxb Device")));
@@ -175,7 +187,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
                             cfg->pio.base, 0, 0, 0);
             aml_append(dev, aml_name_decl("_CRS", crs));
 
-            acpi_dsdt_add_pci_osc(dev);
+            if (is_cxl) {
+                build_cxl_osc_method(dev);
+            } else {
+                acpi_dsdt_add_pci_osc(dev);
+            }
 
             aml_append(scope, dev);
         }
-- 
2.32.0

