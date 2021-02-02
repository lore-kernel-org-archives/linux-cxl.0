Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E270C433E6
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC38A64E31
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBBBBZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:25 -0500
Received: from mga06.intel.com ([134.134.136.31]:21901 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhBBBBY (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:24 -0500
IronPort-SDR: LCA1txOeqVpH1pRH8UwHObHuBe8aVJkcywMzQQzpKIQFtcEgFZn/pxW5LBgHPmBtl8GqePajTy
 uzc+uDwqCmIQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294625"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294625"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:07 -0800
IronPort-SDR: 55TZ0ovYLRe5Qef1wyRQSM8qlunqtTzUIbMUttc0SZJ0amwZRlJdbHAJCl36WcG2WDZ4Dqs+TK
 Up1ujQQ1yXfw==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764166"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:06 -0800
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
Subject: [RFC PATCH v3 14/31] acpi/pci: Consolidate host bridge setup
Date:   Mon,  1 Feb 2021 16:59:31 -0800
Message-Id: <20210202005948.241655-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This cleanup will make it easier to add support for CXL to the mix.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/i386/acpi-build.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index f56d699c7f..cf6eb54c22 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1194,6 +1194,20 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
     aml_append(table, scope);
 }
 
+enum { PCI, PCIE };
+static void init_pci_acpi(Aml *dev, int uid, int type)
+{
+    if (type == PCI) {
+        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+    } else {
+        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
+        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
+        aml_append(dev, aml_name_decl("_UID", aml_int(uid)));
+        aml_append(dev, build_q35_osc_method());
+    }
+}
+
 static void
 build_dsdt(GArray *table_data, BIOSLinker *linker,
            AcpiPmInfo *pm, AcpiMiscInfo *misc,
@@ -1222,9 +1236,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     if (misc->is_piix4) {
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
-        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
+        init_pci_acpi(dev, 0, PCI);
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
         aml_append(sb_scope, dev);
         aml_append(dsdt, sb_scope);
 
@@ -1238,11 +1251,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
     } else {
         sb_scope = aml_scope("_SB");
         dev = aml_device("PCI0");
-        aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-        aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
+        init_pci_acpi(dev, 0, PCIE);
         aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
-        aml_append(dev, aml_name_decl("_UID", aml_int(0)));
-        aml_append(dev, build_q35_osc_method());
         aml_append(sb_scope, dev);
 
         if (pm->smi_on_cpuhp) {
@@ -1345,15 +1355,8 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
 
             scope = aml_scope("\\_SB");
             dev = aml_device("PC%.02X", bus_num);
-            aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
-            if (pci_bus_is_express(bus)) {
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-                aml_append(dev, build_q35_osc_method());
-            } else {
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A03")));
-            }
+            init_pci_acpi(dev, bus_num, pci_bus_is_express(bus) ? PCIE : PCI);
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
-- 
2.30.0

