Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 199D0C433EF
	for <linux-cxl@archiver.kernel.org>; Mon,  4 Apr 2022 15:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240157AbiDDPb2 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 4 Apr 2022 11:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378573AbiDDPb1 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 4 Apr 2022 11:31:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154A5252A4
        for <linux-cxl@vger.kernel.org>; Mon,  4 Apr 2022 08:29:31 -0700 (PDT)
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KXF4F3LDnz67PvV;
        Mon,  4 Apr 2022 23:26:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 17:29:29 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 4 Apr 2022 16:29:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        "Peter Maydell" <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        "Samarth Saxena" <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "k . jensen @ samsung . com" <k.jensen@samsung.com>,
        Tong Zhang <t.zhang2@samsung.com>, <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>
Subject: [PATCH v9 29/45] hw/pci-host/gpex-acpi: Add support for dsdt construction for pxb-cxl
Date:   Mon, 4 Apr 2022 16:14:29 +0100
Message-ID: <20220404151445.10955-30-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
References: <20220404151445.10955-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml717-chm.china.huawei.com (10.201.108.68) To
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
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
---
 hw/arm/Kconfig          |  1 +
 hw/pci-host/gpex-acpi.c | 20 +++++++++++++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 97f3b38019..219262a8da 100644
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
index e7e162a00a..7c7316bc96 100644
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
+            bool is_cxl = pci_bus_is_cxl(bus);
 
             if (!pci_bus_is_root(bus)) {
                 continue;
@@ -154,8 +156,16 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             }
 
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
@@ -175,7 +185,11 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
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

