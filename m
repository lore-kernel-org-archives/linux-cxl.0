Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B14412B8C
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707142964; cv=none; b=Jy59wLMqasHdZvMYFsGmCO4EsuvFMwaLCZx/n9gwO5bLv4Xr8qaAP8c4DI7TOSTga0NVyGJ91/X023wWcAEkHOwX4nMHSpYtsEzqxdHIrRUJ/7nW8qPhsKrMNlZfe2eJlXkcPnf5KOwgRi1ZTswTRozyxRLXRF1TdODd/dH/qSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707142964; c=relaxed/simple;
	bh=E+TvrOLTiwMmyctyZpIuJze8j7Qf3GOpv3i0Azh6AaU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2ckxw17+cjaNuu5f7oFmJyKyM5qxigdcPQqa5BZ/f/gVhlxowQ+WdcEa8x4+cx9DjdjW0lmrFK7Gr5mS4bklVj4CLSYW3A6o7wr0kYrdP/v8yuEI0sBEtiZMuIbw4tjaVxVoSTf5qM+mC71riB7WBwvCAkIFovBfEt67y44rqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7mb4xTgz6J66m;
	Mon,  5 Feb 2024 22:19:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id F2A0D1404F5;
	Mon,  5 Feb 2024 22:22:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:22:39 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 06/11] acpi: pci/cxl: Stash the OSC control parameters.
Date: Mon, 5 Feb 2024 14:19:35 +0000
Message-ID: <20240205141940.31111-7-Jonathan.Cameron@huawei.com>
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

Allow QEMU to know what was successfully requested by the OS
via _OSC.  Note this handling is very minimal and assumes last
written Control parameters were accepted (which they should be
if the OS is obeying the rules for negotiating this stuff).

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/ghes.h   |  3 +++
 hw/acpi/cxl.c            | 16 +++++++++++++++
 hw/acpi/ghes-stub.c      | 10 +++++++++
 hw/acpi/ghes.c           | 44 ++++++++++++++++++++++++++++++++++++++++
 hw/arm/virt-acpi-build.c | 41 ++++++++++++++++++++++++++++++++++++-
 5 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 4f1ab1a73a..3210c19c14 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -66,6 +66,7 @@ enum {
 typedef struct AcpiGhesState {
     uint64_t ghes_addr_le;
     bool present; /* True if GHES is present at all on this board */
+    uint64_t pci_osc_addr_le;
 } AcpiGhesState;
 
 void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker);
@@ -82,4 +83,6 @@ int acpi_ghes_record_errors(uint8_t notify, uint64_t error_physical_addr);
  * safe to call acpi_ghes_record_errors() to record a memory error.
  */
 bool acpi_ghes_present(void);
+bool acpi_fw_first_pci(void);
+bool acpi_fw_first_cxl_mem(void);
 #endif
diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
index 1d6dadbddd..2ce3488943 100644
--- a/hw/acpi/cxl.c
+++ b/hw/acpi/cxl.c
@@ -228,11 +228,27 @@ static Aml *__build_cxl_osc_method(bool fw_first)
     Aml *method, *if_uuid, *else_uuid, *if_arg1_not_1, *if_cxl, *if_caps_masked;
     Aml *a_ctrl = aml_local(0);
     Aml *a_cdw1 = aml_name("CDW1");
+    Aml *cxl_osc_mem = aml_local(1);
     Aml *cxl_ctrl = aml_local(2);
 
+    Aml *field;
+
     method = aml_method("_OSC", 4, AML_NOTSERIALIZED);
     /* CDW1 is used for the return value so is present whether or not a match occurs */
     aml_append(method, aml_create_dword_field(aml_arg(3), aml_int(0), "CDW1"));
+    if (acpi_ghes_present()) {
+        aml_append(method, aml_store(aml_name("COSC"), cxl_osc_mem));
+        aml_append(method, aml_operation_region("CXLA", AML_SYSTEM_MEMORY,
+                                                cxl_osc_mem, 64));
+
+        field = aml_field("CXLA", AML_DWORD_ACC, AML_NOLOCK, AML_PRESERVE);
+        aml_append(field, aml_named_field("ODW1", 32));
+        aml_append(field, aml_named_field("ODW2", 32));
+        aml_append(method, field);
+        /* Store the value for querying later */
+        aml_append(method, aml_store(aml_name("CTRL"), aml_name("ODW1")));
+        aml_append(method, aml_store(aml_name("CTRC"), aml_name("ODW2")));
+    }
 
     /*
      * Generate shared section between:
diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index c315de1802..1ad7b9f776 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -20,3 +20,13 @@ bool acpi_ghes_present(void)
 {
     return false;
 }
+
+bool acpi_fw_first_pci(void)
+{
+    return false;
+}
+
+bool acpi_fw_first_cxl_mem(void)
+{
+    return false;
+}
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index 5b8bc6eeb4..9f99202e1f 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -462,3 +462,47 @@ bool acpi_ghes_present(void)
     ags = &acpi_ged_state->ghes_state;
     return ags->present;
 }
+
+bool acpi_fw_first_pci(void)
+{
+    if (acpi_ghes_present()) {
+        AcpiGhesState *ags =
+            &ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                               NULL))->ghes_state;
+        uint32_t pci_osc;
+
+        cpu_physical_memory_read(le64_to_cpu(ags->pci_osc_addr_le),
+                                 &pci_osc, sizeof(pci_osc));
+        if (pci_osc == 0) {
+            printf("OSC not called yet\n");
+            return true; /* OSC not run yet */
+        }
+        printf("OSC has been called %x\n", pci_osc);
+        return !(pci_osc & (1 << 3));
+    }
+    return false;
+}
+
+bool acpi_fw_first_cxl_mem(void)
+{
+    if (!acpi_fw_first_pci()) {
+        return false;
+    }
+    if (acpi_ghes_present()) {
+        AcpiGhesState *ags =
+            &ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                               NULL))->ghes_state;
+        uint32_t cxl_osc;
+
+        cpu_physical_memory_read(le64_to_cpu(ags->pci_osc_addr_le) +
+                                 sizeof(uint32_t),
+                                 &cxl_osc, sizeof(cxl_osc));
+        if (cxl_osc == 0) {
+            printf("CXL OSC not called yet or memory error not requested\n");
+            return true; /* OSC not run yet */
+        }
+        printf("OSC has been called %x\n", cxl_osc);
+        return !(cxl_osc & (1 << 0));
+    }
+    return false;
+}
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index 297fa5f8b2..93ec095b0f 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -916,6 +916,7 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     const int *irqmap = vms->irqmap;
     AcpiTable table = { .sig = "DSDT", .rev = 2, .oem_id = vms->oem_id,
                         .oem_table_id = vms->oem_table_id };
+    int mem_addr_offset;
 
     acpi_table_begin(&table, table_data);
     dsdt = init_aml_allocator();
@@ -972,6 +973,16 @@ build_dsdt(GArray *table_data, BIOSLinker *linker, VirtMachineState *vms)
     /* copy AML table into ACPI tables blob */
     g_array_append_vals(table_data, dsdt->buf->data, dsdt->buf->len);
 
+    /* Outside of the DSDT creation because we need the final address */
+    mem_addr_offset = build_append_named_dword(table_data, "COSC");
+    /* Patch COSC to point to the cxl-osc FW_CFG file */
+    bios_linker_loader_add_pointer(linker, ACPI_BUILD_TABLE_FILE,
+                                   mem_addr_offset, sizeof(uint32_t),
+                                   "etc/acpi/cxl-osc", 0);
+    /* Store address of cxl-osc FW_CFG file in cxl-osc-addr FW_CFG file */
+    bios_linker_loader_write_pointer(linker, "etc/acpi/cxl-osc-addr", 0,
+                                     sizeof(uint64_t), "etc/acpi/cxl-osc", 0);
+
     acpi_table_end(linker, &table);
     free_aml_allocator();
 }
@@ -995,6 +1006,8 @@ static void acpi_align_size(GArray *blob, unsigned align)
     g_array_set_size(blob, ROUND_UP(acpi_data_len(blob), align));
 }
 
+static GArray *test;
+
 static
 void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
 {
@@ -1004,6 +1017,10 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
     GArray *tables_blob = tables->table_data;
     MachineState *ms = MACHINE(vms);
 
+    /* Load the cxl-osc FW_CFG file into guest memory */
+    bios_linker_loader_alloc(tables->linker, "etc/acpi/cxl-osc",
+                             test, 64, false);
+
     table_offsets = g_array_new(false, true /* clear */,
                                         sizeof(uint32_t));
 
@@ -1202,6 +1219,10 @@ void virt_acpi_setup(VirtMachineState *vms)
 
     build_state = g_malloc0(sizeof *build_state);
 
+    test = g_array_new(false, true, 4);
+    acpi_data_push(test, sizeof(uint64_t));
+    *((uint64_t *)test->data) = 0xdeadbeefdeadbeef;
+
     acpi_build_tables_init(&tables);
     virt_acpi_build(vms, &tables);
 
@@ -1234,7 +1255,25 @@ void virt_acpi_setup(VirtMachineState *vms)
     virt_acpi_build_reset(build_state);
     vmstate_register(NULL, 0, &vmstate_virt_acpi_build, build_state);
 
-    /* Cleanup tables but don't free the memory: we track it
+    if (acpi_ghes_present()) {
+        AcpiGhesState *ags =
+            &ACPI_GED(object_resolve_path_type("", TYPE_ACPI_GED,
+                                               NULL))->ghes_state;
+
+        /* Add a cxl-osc FW_CFG file that will be used to stash osc outcomes */
+        fw_cfg_add_file(vms->fw_cfg, "etc/acpi/cxl-osc",
+                        test->data, test->len);
+        /*
+         * Add a cxl-osc-addr FW_CFG file that will be used to get to the
+         * address of cxl-osc FW_CFG file.  Can be written by FW.
+         */
+        fw_cfg_add_file_callback(vms->fw_cfg, "etc/acpi/cxl-osc-addr",
+                                 NULL, NULL, NULL,
+                                 &ags->pci_osc_addr_le, sizeof(uint64_t),
+                                 false);
+    }
+    /*
+     * Cleanup tables but don't free the memory: we track it
      * in build_state.
      */
     acpi_build_tables_cleanup(&tables, false);
-- 
2.39.2

