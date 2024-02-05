Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDFD2421C
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142843; cv=none; b=HnBKOELMlQx/35tL/2Q9zP64VI7WatMhuxzMMOdr1Cv4ZTagS6yA37hfsMWlIUphHPZNNrsRPBoO/PfSKLTFNwMY0AjGSC53F5oNfz/07oJ2xKnPX8CUu2jnRO9ToZMe0N8Ebi6bJ9tgFd9lvs4hkuW7szaaS9NJdm0Qb7efewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142843; c=relaxed/simple;
	bh=X7pB3uBCtZRWQxFZfhgOdDKGCn1MpdjhMtXU3ciVGNM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A5gj7Lu16w0lfsQY+/Jj+3bqLKmJ5J3vJz1/O3kcJIA/uGewtY2K3cUnJyA8H8GB3cqGbrwH7gfz80zGo99BYRPgx3GvBBwU1N0SCDQrE4sjS4gg1d3JTg8WsIermTDLKSDxkKlylstWIOQh8kt0+pWZaUAktN5qg/l3DE1CzO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7kC5Shxz6K9Bl;
	Mon,  5 Feb 2024 22:17:23 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D9232140A9C;
	Mon,  5 Feb 2024 22:20:37 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:20:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 02/11] hw/acpi: Allow GPEX _OSC to keep fw first control of AER and CXL errors.
Date: Mon, 5 Feb 2024 14:19:31 +0000
Message-ID: <20240205141940.31111-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
References: <20240205141940.31111-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/cxl.h      |  2 +-
 include/hw/pci-host/gpex.h |  1 +
 hw/acpi/cxl-stub.c         |  2 +-
 hw/acpi/cxl.c              | 31 +++++++++++++++++++++++++++----
 hw/i386/acpi-build.c       |  2 +-
 hw/pci-host/gpex-acpi.c    | 17 +++++++++++------
 hw/pci-host/gpex.c         |  1 +
 7 files changed, 43 insertions(+), 13 deletions(-)

diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
index 8f22c71530..38714147ec 100644
--- a/include/hw/acpi/cxl.h
+++ b/include/hw/acpi/cxl.h
@@ -24,7 +24,7 @@
 void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
                     BIOSLinker *linker, const char *oem_id,
                     const char *oem_table_id, CXLState *cxl_state);
-void build_cxl_osc_method(Aml *dev);
+void build_cxl_osc_method(Aml *dev, bool fw_first);
 void build_cxl_dsm_method(Aml *dev);
 
 #endif
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index dce883573b..866ae71ba0 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -47,6 +47,7 @@ struct GPEXConfig {
     MemMapEntry pio;
     int         irq;
     PCIBus      *bus;
+    bool        fw_first_ras;
 };
 
 struct GPEXHost {
diff --git a/hw/acpi/cxl-stub.c b/hw/acpi/cxl-stub.c
index 15bc21076b..0ec5c48850 100644
--- a/hw/acpi/cxl-stub.c
+++ b/hw/acpi/cxl-stub.c
@@ -6,7 +6,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/cxl.h"
 
-void build_cxl_osc_method(Aml *dev)
+void build_cxl_osc_method(Aml *dev, bool fw_first)
 {
     g_assert_not_reached();
 }
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index d0e6a4b45e..526cfe961a 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -27,6 +27,7 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/bios-linker-loader.h"
 #include "hw/acpi/cxl.h"
+#include "hw/acpi/ghes.h"
 #include "qapi/error.h"
 #include "qemu/uuid.h"
 
@@ -222,11 +223,12 @@ void cxl_build_cedt(GArray *table_offsets, GArray *table_data,
     acpi_table_end(linker, &table);
 }
 
-static Aml *__build_cxl_osc_method(void)
+static Aml *__build_cxl_osc_method(bool fw_first)
 {
     Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
     Aml *a_ctrl = aml_local(0);
     Aml *a_cdw1 = aml_name("CDW1");
+    Aml *cxl_ctrl = aml_local(2);
 
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
     /* CDW1 is used for the return value so is present whether or not a match occurs */
@@ -260,7 +262,11 @@ static Aml *__build_cxl_osc_method(void)
      * Allows OS control for all 5 features:
      * PCIeHotplug SHPCHotplug PME AER PCIeCapability
      */
-    aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+    if (fw_first) {
+        aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x17), a_ctrl));
+    } else {
+        aml_append(if_uuid, aml_and(a_ctrl, aml_int(0x1F), a_ctrl));
+    }
 
     /*
      * Check _OSC revision.
@@ -290,6 +296,23 @@ static Aml *__build_cxl_osc_method(void)
     aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(12), "CDW4"));
     /* CXL capabilities */
     aml_append(if_cxl, aml_create_dword_field(aml_arg(3), aml_int(16), "CDW5"));
+
+    aml_append(if_cxl, aml_store(aml_name("CDW5"), cxl_ctrl));
+    if (fw_first) {
+        aml_append(if_cxl, aml_and(cxl_ctrl, aml_int(0x0), cxl_ctrl));
+    } else {
+        /* Only allow CXL Memory Error Reporting */
+        aml_append(if_cxl, aml_and(cxl_ctrl, aml_int(0x1), cxl_ctrl));
+    }
+
+    if_caps_masked = aml_if(aml_lnot(aml_equal(aml_name("CDW5"), cxl_ctrl)));
+
+    /* Capability bits were masked */
+    aml_append(if_caps_masked, aml_or(a_cdw1, aml_int(0x10), a_cdw1));
+    aml_append(if_cxl, if_caps_masked);
+
+    aml_append(if_cxl, aml_store(cxl_ctrl, aml_name("CDW5")));
+
     aml_append(if_cxl, aml_store(aml_name("CDW4"), aml_name("SUPC")));
     aml_append(if_cxl, aml_store(aml_name("CDW5"), aml_name("CTRC")));
 
@@ -316,11 +339,11 @@ static Aml *__build_cxl_osc_method(void)
     return method;
 }
 
-void build_cxl_osc_method(Aml *dev)
+void build_cxl_osc_method(Aml *dev, bool fw_first)
 {
     aml_append(dev, aml_name_decl("SUPP", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRL", aml_int(0)));
     aml_append(dev, aml_name_decl("SUPC", aml_int(0)));
     aml_append(dev, aml_name_decl("CTRC", aml_int(0)));
-    aml_append(dev, __build_cxl_osc_method());
+    aml_append(dev, __build_cxl_osc_method(fw_first));
 }
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 58e4c54f31..2fbac1d826 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -1655,7 +1655,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
                 aml_append(aml_pkg, aml_eisaid("PNP0A08"));
                 aml_append(aml_pkg, aml_eisaid("PNP0A03"));
                 aml_append(dev, aml_name_decl("_CID", aml_pkg));
-                build_cxl_osc_method(dev);
+                build_cxl_osc_method(dev, false);
             } else if (pci_bus_is_express(bus)) {
                 aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
                 aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index f69413ea2c..f003669975 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -49,7 +49,7 @@ static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq)
     }
 }
 
-static void acpi_dsdt_add_pci_osc(Aml *dev)
+static void acpi_dsdt_add_pci_osc(Aml *dev, bool fw_first_aer)
 {
     Aml *method, *UUID, *ifctx, *ifctx1, *elsectx, *buf;
 
@@ -79,8 +79,13 @@ static void acpi_dsdt_add_pci_osc(Aml *dev)
      * Allow OS control for all 5 features:
      * PCIeHotplug SHPCHotplug PME AER PCIeCapability.
      */
-    aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
-                              aml_name("CTRL")));
+    if (fw_first_aer) {
+        aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x17),
+                                  aml_name("CTRL")));
+    } else {
+        aml_append(ifctx, aml_and(aml_name("CTRL"), aml_int(0x1F),
+                                  aml_name("CTRL")));
+    }
 
     ifctx1 = aml_if(aml_lnot(aml_equal(aml_arg(1), aml_int(0x1))));
     aml_append(ifctx1, aml_or(aml_name("CDW1"), aml_int(0x08),
@@ -186,9 +191,9 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
             aml_append(dev, aml_name_decl("_CRS", crs));
 
             if (is_cxl) {
-                build_cxl_osc_method(dev);
+                build_cxl_osc_method(dev, cfg->fw_first_ras);
             } else {
-                acpi_dsdt_add_pci_osc(dev);
+                acpi_dsdt_add_pci_osc(dev, cfg->fw_first_ras);
             }
 
             aml_append(scope, dev);
@@ -263,7 +268,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
     }
     aml_append(dev, aml_name_decl("_CRS", rbuf));
 
-    acpi_dsdt_add_pci_osc(dev);
+    acpi_dsdt_add_pci_osc(dev, cfg->fw_first_ras);
 
     Aml *dev_res0 = aml_device("%s", "RES0");
     aml_append(dev_res0, aml_name_decl("_HID", aml_string("PNP0C02")));
diff --git a/hw/pci-host/gpex.c b/hw/pci-host/gpex.c
index e9cf455bf5..49fc69eec6 100644
--- a/hw/pci-host/gpex.c
+++ b/hw/pci-host/gpex.c
@@ -166,6 +166,7 @@ static Property gpex_host_properties[] = {
                        gpex_cfg.mmio64.base, 0),
     DEFINE_PROP_SIZE(PCI_HOST_ABOVE_4G_MMIO_SIZE, GPEXHost,
                      gpex_cfg.mmio64.size, 0),
+    DEFINE_PROP_BOOL("fw_first_ras", GPEXHost, gpex_cfg.fw_first_ras, false),
     DEFINE_PROP_END_OF_LIST(),
 };
 
-- 
2.39.2

