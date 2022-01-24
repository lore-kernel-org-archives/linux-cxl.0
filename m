Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C41FC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jan 2022 17:24:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbiAXRYs (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jan 2022 12:24:48 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4460 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244491AbiAXRYp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jan 2022 12:24:45 -0500
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JjH0Q5ZyJz687S6;
        Tue, 25 Jan 2022 01:24:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 18:24:44 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 24 Jan 2022 17:24:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Peter Maydell <peter.maydell@linaro.org>,
        <linuxarm@huawei.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        "Dan Williams" <dan.j.williams@intel.com>
Subject: [PATCH v4 15/42] acpi/pci: Consolidate host bridge setup
Date:   Mon, 24 Jan 2022 17:16:38 +0000
Message-ID: <20220124171705.10432-16-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
References: <20220124171705.10432-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

This cleanup will make it easier to add support for CXL to the mix.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/i386/acpi-build.c | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index ce823e8fcb..1d8ee988f2 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1398,6 +1398,23 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
     aml_append(table, scope);
 }
 
+enum { PCI, PCIE };
+static void init_pci_acpi(Aml *dev, int uid, int type, bool native_pcie_hp)
+{
+    if (type == PCI) {
+        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
+        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+    } else {
+        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
+        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
+        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
+        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+        /* Expander bridges do not have ACPI PCI Hot-plug enabled */
+        aml_append(dev, build_q35_osc_method(native_pcie_hp));
+    }
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1429,9 +1446,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     if (misc->is_piix4) {
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
-        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
+        init_pci_acpi(dev, pcmc->pci_root_uid, PCI, false);
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -1447,11 +1462,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     } else {
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
-        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-        aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(pcmc->pci_root_uid)));
-        aml_append(dev, build_q35_osc_method(!pm->pcihp_bridge_en));
+        init_pci_acpi(dev, pcmc->pci_root_uid, PCIE, !pm->pcihp_bridge_en);
         aml_append(sb_scope, dev);
         if (mcfg_valid) {
             aml_append(sb_scope, build_q35_dram_controller(&mcfg));
@@ -1562,17 +1573,10 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
             scope = aml_scope("\\_SB");
             dev = aml_device("PC%.02X", bus_num);
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
-            if (pci_bus_is_express(bus)) {
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
 
-                /* Expander bridges do not have ACPI PCI Hot-plug enabled */
-                aml_append(dev, build_q35_osc_method(true));
-            } else {
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-            }
+            init_pci_acpi(dev, bus_num,
+                          pci_bus_is_express(bus) ? PCIE : PCI, true);
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
-- 
2.32.0

