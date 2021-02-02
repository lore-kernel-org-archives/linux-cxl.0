Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 917E5C433E0
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6919064EDE
	for <linux-cxl@archiver.kernel.org>; Tue,  2 Feb 2021 01:01:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbhBBBBj (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Feb 2021 20:01:39 -0500
Received: from mga06.intel.com ([134.134.136.31]:21898 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229641AbhBBBBj (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 1 Feb 2021 20:01:39 -0500
IronPort-SDR: xC2XBmk+7DVD8A2HuTQxampp/yjnL4fOkL9FBJH/FhPwLWCHGtpRJIx6cbdmbx5urlK2JXSwVF
 dyKAyxgHPCGw==
X-IronPort-AV: E=McAfee;i="6000,8403,9882"; a="242294633"
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="242294633"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:12 -0800
IronPort-SDR: fF9IOuRHIl0X7iApqGnvAC4ei7SpfPO8/Kg9lnCYwux8Ixg6T8RxdYYooUTRp0rYFWm3fkelpT
 ec8R3eUHYXrQ==
X-IronPort-AV: E=Sophos;i="5.79,393,1602572400"; 
   d="scan'208";a="581764204"
Received: from jambrizm-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.15])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2021 17:00:11 -0800
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
Subject: [RFC PATCH v3 18/31] acpi/pxb/cxl: Reserve host bridge MMIO
Date:   Mon,  1 Feb 2021 16:59:35 -0800
Message-Id: <20210202005948.241655-19-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210202005948.241655-1-ben.widawsky@intel.com>
References: <20210202005948.241655-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

For all host bridges, reserve MMIO space with _CRS. The MMIO for the
host bridge lives in a magically hard coded space in the system's
physical address space. The standard mechanism to tell the OS about
regions which can't be used for host bridges is _CRS.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 hw/i386/acpi-build.c | 22 +++++++++++++++++++---
 1 file changed, 19 insertions(+), 3 deletions(-)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 145a503e92..ecdc10b148 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -28,6 +28,7 @@
 #include "qemu/bitmap.h"
 #include "qemu/error-report.h"
 #include "hw/pci/pci.h"
+#include "hw/cxl/cxl.h"
 #include "hw/core/cpu.h"
 #include "target/i386/cpu.h"
 #include "hw/misc/pvpanic.h"
@@ -1194,7 +1195,7 @@ static void build_smb0(Aml *table, I2CBus *smbus, int devnr, int func)
     aml_append(table, scope);
 }
 
-enum { PCI, PCIE };
+enum { PCI, PCIE, CXL };
 static void init_pci_acpi(Aml *dev, int uid, int type)
 {
     if (type == PCI) {
@@ -1344,20 +1345,28 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             uint8_t bus_num = pci_bus_num(bus);
             uint8_t numa_node = pci_bus_numa_node(bus);
             int32_t uid = pci_bus_uid(bus);
+            int type;
 
             /* look only for expander root buses */
             if (!pci_bus_is_root(bus)) {
                 continue;
             }
 
+            type = pci_bus_is_cxl(bus) ? CXL :
+                                         pci_bus_is_express(bus) ? PCIE : PCI;
+
             if (bus_num < root_bus_limit) {
                 root_bus_limit = bus_num - 1;
             }
 
             scope = aml_scope("\\_SB");
-            dev = aml_device("PC%.02X", bus_num);
+            if (type == CXL) {
+                dev = aml_device("CXL%.01X", pci_bus_uid(bus));
+            } else {
+                dev = aml_device("PC%.02X", bus_num);
+            }
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
-            init_pci_acpi(dev, uid, pci_bus_is_express(bus) ? PCIE : PCI);
+            init_pci_acpi(dev, uid, type);
 
             if (numa_node != NUMA_NODE_UNASSIGNED) {
                 aml_append(dev, aml_name_decl("_PXM", aml_int(numa_node)));
@@ -1369,6 +1378,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_CRS", crs));
             aml_append(scope, dev);
             aml_append(dsdt, scope);
+
+            /* Handle the ranges for the PXB expanders */
+            if (type == CXL) {
+                uint64_t base = CXL_HOST_BASE + uid * 0x10000;
+                crs_range_insert(crs_range_set.mem_ranges, base,
+                                 base + 0x10000 - 1);
+            }
         }
     }
 
-- 
2.30.0

