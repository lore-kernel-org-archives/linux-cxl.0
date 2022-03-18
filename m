Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A0B5C433EF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Mar 2022 15:18:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237906AbiCRPUH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Mar 2022 11:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237901AbiCRPUG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Mar 2022 11:20:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00851788EE
        for <linux-cxl@vger.kernel.org>; Fri, 18 Mar 2022 08:18:46 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KKngz2DyQz67N2W;
        Fri, 18 Mar 2022 23:17:51 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 18 Mar 2022 16:18:44 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 18 Mar 2022 15:18:43 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linuxarm@huawei.com>, <qemu-devel@nongnu.org>,
        =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
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
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>
Subject: [PATCH v8 24/46] acpi/cxl: Add _OSC implementation (9.14.2)
Date:   Fri, 18 Mar 2022 15:06:13 +0000
Message-ID: <20220318150635.24600-25-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

CXL 2.0 specification adds 2 new dwords to the existing _OSC definition
from PCIe. The new dwords are accessed with a new uuid. This
implementation supports what is in the specification.

iasl -d decodes the result of this patch as:

Name (SUPP, Zero)
Name (CTRL, Zero)
Name (SUPC, Zero)
Name (CTRC, Zero)
Method (_OSC, 4, NotSerialized)  // _OSC: Operating System Capabilities
{
    CreateDWordField (Arg3, Zero, CDW1)
    If (((Arg0 == ToUUID ("33db4d5b-1ff7-401c-9657-7441c03dd766") /* PCI Host Bridge Device */) || (Arg0 == ToUUID ("68f2d50b-c469-4d8a-bd3d-941a103fd3fc") /* Unknown UUID */)))
    {
        CreateDWordField (Arg3, 0x04, CDW2)
        CreateDWordField (Arg3, 0x08, CDW3)
        Local0 = CDW3 /* \_SB_.PC0C._OSC.CDW3 */
        Local0 &= 0x1F
        If ((Arg1 != One))
        {
            CDW1 |= 0x08
        }

        If ((CDW3 != Local0))
        {
            CDW1 |= 0x10
        }

        SUPP = CDW2 /* \_SB_.PC0C._OSC.CDW2 */
        CTRL = CDW3 /* \_SB_.PC0C._OSC.CDW3 */
        CDW3 = Local0
        If ((Arg0 == ToUUID ("68f2d50b-c469-4d8a-bd3d-941a103fd3fc") /* Unknown UUID */))
        {
            CreateDWordField (Arg3, 0x0C, CDW4)
            CreateDWordField (Arg3, 0x10, CDW5)
            SUPC = CDW4 /* \_SB_.PC0C._OSC.CDW4 */
            CTRC = CDW5 /* \_SB_.PC0C._OSC.CDW5 */
            CDW5 |= One
        }

        Return (Arg3)
    }
    Else
    {
        CDW1 |= 0x04
        Return (Arg3)
    }

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/acpi/Kconfig       |   5 ++
 hw/acpi/cxl-stub.c    |  12 ++++
 hw/acpi/cxl.c         | 130 ++++++++++++++++++++++++++++++++++++++++++
 hw/acpi/meson.build   |   4 +-
 hw/i386/acpi-build.c  |  15 +++--
 include/hw/acpi/cxl.h |  23 ++++++++
 6 files changed, 183 insertions(+), 6 deletions(-)

diff --git a/hw/acpi/Kconfig b/hw/acpi/Kconfig
index 19caebde6c..3703aca212 100644
--- a/hw/acpi/Kconfig
+++ b/hw/acpi/Kconfig
@@ -5,6 +5,7 @@ config ACPI_X86
     bool
     select ACPI
     select ACPI_NVDIMM
+    select ACPI_CXL
     select ACPI_CPU_HOTPLUG
     select ACPI_MEMORY_HOTPLUG
     select ACPI_HMAT
@@ -66,3 +67,7 @@ config ACPI_ERST
     bool
     default y
     depends on ACPI && PCI
+
+config ACPI_CXL
+    bool
+    depends on ACPI
diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
new file mode 100644
index 0000000000..15bc21076b
--- /dev/null
+++ b/hw/acpi/cxl-stub.c
@@ -0,0 +1,12 @@
+
+/*
+ * Stubs for ACPI platforms that don't support CXl
+ */
+#include "qemu/osdep.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/cxl.h"
+
+void build_cxl_osc_method(Aml *dev)
+{
+    g_assert_not_reached();
+}
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
new file mode 100644
index 0000000000..ca1f04f359
--- /dev/null
+++ b/hw/acpi/cxl.c
@@ -0,0 +1,130 @@
+/*
+ * CXL ACPI Implementation
+ *
+ * Copyright(C) 2020 Intel Corporation.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>
+ */
+
+#include "qemu/osdep.h"
+#include "hw/cxl/cxl.h"
+#include "hw/acpi/acpi.h"
+#include "hw/acpi/aml-build.h"
+#include "hw/acpi/bios-linker-loader.h"
+#include "hw/acpi/cxl.h"
+#include "qapi/error.h"
+#include "qemu/uuid.h"
+
+static Aml *__build_cxl_osc_method(void)
+{
+    Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
+    Aml *a_ctrl = aml_local(0);
+    Aml *a_cdw1 = aml_name("CDW1");
+
+    method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
+    /* CDW1 is used for the return value so is present whether or not a match occurs */
+    aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+
+    /*
+     * Generate shared section between:
+     * CXL 2.0 - 9.14.2.1.4 and
+     * PCI Firmware Specification 3.0
+     * 4.5.1. _OSC Interface for PCI Host Bridge Devices
+     * The _OSC interface for a PCI/PCI-X/PCI Express hierarchy is
+     * identified by the Universal Unique IDentifier (UUID)
+     * 33DB4D5B-1FF7-401C-9657-7441C03DD766
+     * The _OSC interface for a CXL Host bridge is
+     * identified by the UUID 68F2D50B-C469-4D8A-BD3D-941A103FD3FC
+     * A CXL Host bridge is compatible with a PCI host bridge so
+     * for the shared section match both.
+     */
+    if_uuid = aml_if(
+        aml_lor(aml_equal(aml_arg(0),
+                          aml_touuid("33DB4D5B-1FF7-401C-9657-7441C03DD766")),
+                aml_equal(aml_arg(0),
+                          aml_touuid("68F2D50B-C469-4D8A-BD3D-941A103FD3FC"))));
+    aml_append(if_uuid, aml_create_dword_field(aml_arg(3), aml_int(4), "CDW2"));
+    aml_append(if_uuid, aml_create_dword_field(aml_arg(3), aml_int(8), "CDW3"));
+
+    aml_append(if_uuid, aml_store(aml_name("CDW3"), a_ctrl));
+
+    /*
+     *
+     * Allows OS control for all 5 features:
+     * PCIeHotplug SHPCHotplug PME AER PCIeCapability
+     */
+    aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+
+    /*
+     * Check _OSC revision.
+     * PCI Firmware specification 3.3 and CXL 2.0 both use revision 1
+     * Unknown Revision is CDW1 - BIT (3)
+     */
+    if_arg1_not_1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
+    aml_append(if_arg1_not_1, aml_or(a_cdw1, aml_int(0x08), a_cdw1));
+    aml_append(if_uuid, if_arg1_not_1);
+
+    if_caps_masked = aml_if(aml_lnot(aml_equal(aml_name("CDW3"), a_ctrl)));
+
+    /* Capability bits were masked */
+    aml_append(if_caps_masked, aml_or(a_cdw1, aml_int(0x10), a_cdw1));
+    aml_append(if_uuid, if_caps_masked);
+
+    aml_append(if_uuid, aml_store(aml_name("CDW2"), aml_name("SUPP")));
+    aml_append(if_uuid, aml_store(aml_name("CDW3"), aml_name("CTRL")));
+
+    /* Update DWORD3 (the return value) */
+    aml_append(if_uuid, aml_store(a_ctrl, aml_name("CDW3")));
+
+    /* CXL only section as per CXL 2.0 - 9.14.2.1.4 */
+    if_cxl = aml_if(aml_equal(
+        aml_arg(0), aml_touuid("68F2D50B-C469-4D8A-BD3D-941A103FD3FC")));
+    /* CXL support field */
+    aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(12), "CDW4"));
+    /* CXL capabilities */
+    aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(16), "CDW5"));
+    aml_append(if_cxl, aml_store(aml_name("CDW4"), aml_name("SUPC")));
+    aml_append(if_cxl, aml_store(aml_name("CDW5"), aml_name("CTRC")));
+
+    /* CXL 2.0 Port/Device Register access */
+    aml_append(if_cxl,
+               aml_or(aml_name("CDW5"), aml_int(0x1), aml_name("CDW5")));
+    aml_append(if_uuid, if_cxl);
+
+    aml_append(if_uuid, aml_return(aml_arg(3)));
+    aml_append(method, if_uuid);
+
+    /*
+     * If no UUID matched, return Unrecognized UUID via Arg3 DWord 1
+     * ACPI 6.4 - 6.2.11
+     * Unrecognised UUID - BIT(2)
+     */
+    else_uuid = aml_else();
+
+    aml_append(else_uuid,
+               aml_or(aml_name("CDW1"), aml_int(0x4), aml_name("CDW1")));
+    aml_append(else_uuid, aml_return(aml_arg(3)));
+    aml_append(method, else_uuid);
+
+    return method;
+}
+
+void build_cxl_osc_method(Aml *dev)
+{
+    aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
+    aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
+    aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
+    aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
+    aml_append(dev, __build_cxl_osc_method());
+}
diff --git a/hw/acpi/meson.build b/hw/acpi/meson.build
index 8bea2e6933..cea2f5f93a 100644
--- a/hw/acpi/meson.build
+++ b/hw/acpi/meson.build
@@ -13,6 +13,7 @@ acpi_ss.add(when: 'CONFIG_ACPI_MEMORY_HOTPLUG', if_false: files('acpi-mem-hotplu
 acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_true: files('nvdimm.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_NVDIMM', if_false: files('acpi-nvdimm-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_PCI', if_true: files('pci.c'))
+acpi_ss.add(when: 'CONFIG_ACPI_CXL', if_true: files('cxl.c'), if_false: files('cxl-stub.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_VMGENID', if_true: files('vmgenid.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HW_REDUCED', if_true: files('generic_event_device.c'))
 acpi_ss.add(when: 'CONFIG_ACPI_HMAT', if_true: files('hmat.c'))
@@ -33,4 +34,5 @@ softmmu_ss.add_all(when: 'CONFIG_ACPI', if_true: acpi_ss)
 softmmu_ss.add(when: 'CONFIG_ALL', if_true: files('acpi-stub.c', 'aml-build-stub.c',
                                                   'acpi-x86-stub.c', 'ipmi-stub.c', 'ghes-stub.c',
                                                   'acpi-mem-hotplug-stub.c', 'acpi-cpu-hotplug-stub.c',
-                                                  'acpi-pci-hotplug-stub.c', 'acpi-nvdimm-stub.c'))
+                                                  'acpi-pci-hotplug-stub.c', 'acpi-nvdimm-stub.c',
+                                                  'cxl-stub.c'))
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 0b7d06e107..042532bd6d 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -67,6 +67,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/utils.h"
 #include "hw/acpi/pci.h"
+#include "hw/acpi/cxl.h"
 
 #include "qom/qom-qobject.h"
 #include "hw/i386/amd_iommu.h"
@@ -1582,11 +1583,15 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_cxl(bus)) {
-                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
-                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
-
-                /* Expander bridges do not have ACPI PCI Hot-plug enabled */
-                aml_append(dev, build_q35_osc_method(true));
+                struct Aml *pkg = aml_package(2);
+
+                aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
+                aml_append(pkg, aml_eisaid("PNP0A08"));
+                aml_append(pkg, aml_eisaid("PNP0A03"));
+                aml_append(dev, aml_name_decl("_CID", pkg));
+                aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
+                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
+                build_cxl_osc_method(dev);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
                 aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
new file mode 100644
index 0000000000..7b8f3b8a2e
--- /dev/null
+++ b/include/hw/acpi/cxl.h
@@ -0,0 +1,23 @@
+/*
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+
+ * You should have received a copy of the GNU General Public License along
+ * with this program; if not, see <http://www.gnu.org/licenses/>.
+ */
+
+#ifndef HW_ACPI_CXL_H
+#define HW_ACPI_CXL_H
+
+void build_cxl_osc_method(Aml *dev);
+
+#endif
-- 
2.32.0

