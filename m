Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C05ECC64ED6
	for <linux-cxl@archiver.kernel.org>; Mon, 27 Feb 2023 18:22:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbjB0SWO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 13:22:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjB0SWO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 13:22:14 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3853525941
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 10:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677522131; x=1709058131;
  h=subject:from:to:cc:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VqpzgnBk6JTEe6MW4LLPk+RGqS8sr+ozOD/wW053xns=;
  b=G1TukS/k88lOjY4SA5Rg7j6rYMSiI0T2rVpwKucpXCo4DcNBdBo3I+kE
   p60hFTwtiamXtkouhNdI7IW32EhdvIMIQGr9dhHeG5GZ+/fvn0giDt6l5
   hP3810krQGzTyREXaS5OeoXq+plCraLW0KFzSiGTn6sTkH4xk79audzaH
   RTDNdd9Y/pxdjo7eHwozGZTgK6dG1Jyms3Z/Cr8akhN/QJGu1SJVnKEMp
   Kqtyah28/iEUMtsqXJjlHTQ2NScZqDegTlrg7/r9D4s/n2kJvrMB5oqTl
   E8wxq+EgwnY6ksmJEjM1hlyX1QSDxFJC1P/SC53icqNela4KyQwvhRYLe
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="314359876"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="314359876"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 10:21:13 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10634"; a="704114783"
X-IronPort-AV: E=Sophos;i="5.98,219,1673942400"; 
   d="scan'208";a="704114783"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.113.7])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2023 10:21:12 -0800
Subject: [RFC PATCH] hw/acpi: Add support for Generic Port Affinity Structure
 to SRAT
From:   Dave Jiang <dave.jiang@intel.com>
To:     jonathan.cameron@huawei.com
Cc:     linux-cxl@vger.kernel.org
Date:   Mon, 27 Feb 2023 11:21:10 -0700
Message-ID: <167752189501.2142629.5945611780614317355.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The Generic Port Affinity Structure is added for the System Resource
Affinity Table in ACPI r6.4. It provides information on the proximity
domain that's associated with a device handle. This information in
combination with HMAT can be used by the CXL driver to calculate the
bandwidth and latency information between the CPU and the CXL Host Bridge
(HB).

Add a list to account for the ACPI0016 (CXL HB ACPI devices) being
created. Create GAPS entries equivalent to the number of HB devices
constructed by qemu using the list and inject the relevant device handle.

The proximity domain will be set to 0 for simplicity to enable Linux kernel
side debugging and usage of the new SRAT sub-tables.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

Hi Jonathan,
I hacked together the SRAT support for generic port on qemu. Wasn't sure if
it's ok to define a global list for the ACPI0016 devices. I don't see how
we can parse the created table instead. Please let me know if this is the right
way to go. Thanks!

 hw/acpi/aml-build.c         |   19 +++++++++++++++++++
 hw/i386/acpi-build.c        |   25 +++++++++++++++++++++++++
 include/hw/acpi/aml-build.h |   27 +++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index ea331a20d131..2a43b24796a7 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1938,6 +1938,25 @@ void build_srat_memory(GArray *table_data, uint64_t base,
     build_append_int_noprefix(table_data, 0, 8); /* Reserved */
 }
 
+/*
+ * ACPI spec, Revision 6.5
+ * 5.2.16.7 Generic Port Affinity Structure
+ */
+void build_srat_generic_port_affinity(GArray *table_data, uint8_t htype, int node,
+                                      ACPIDeviceHandle *handle,
+                                      GenericAffinityFlags flags)
+{
+    build_append_int_noprefix(table_data, 6, 1); /* Type */
+    build_append_int_noprefix(table_data, 32, 1); /* Length */
+    build_append_int_noprefix(table_data, 0, 1); /* Reserved */
+    build_append_int_noprefix(table_data, htype, 1); /* Device Handle Type */
+    build_append_int_noprefix(table_data, node, 4); /* Proximity Domain */
+    build_append_int_noprefix(table_data, handle->raw[0], 8); /* Device Handle part 1 */
+    build_append_int_noprefix(table_data, handle->raw[1], 8); /* Device Handle part 2 */
+    build_append_int_noprefix(table_data, flags, 4); /* Flags */
+    build_append_int_noprefix(table_data, 0, 4); /* Reserved */
+}
+
 /*
  * ACPI spec 5.2.17 System Locality Distance Information Table
  * (Revision 2.0 or later)
diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index d449e5b76f30..3c9b2e9e4bfe 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -132,6 +132,13 @@ const struct AcpiGenericAddress x86_nvdimm_acpi_dsmio = {
     .bit_width = NVDIMM_ACPI_IO_LEN << 3
 };
 
+typedef struct CxlHBDev {
+    uint32_t uid;
+    QSLIST_ENTRY(CxlHBDev) entry;
+} CxlHBDev;
+
+static QSLIST_HEAD(, CxlHBDev) cxl_hb_list_head;
+
 static void init_common_fadt_data(MachineState *ms, Object *o,
                                   AcpiFadtData *data)
 {
@@ -1507,8 +1514,13 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
             aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
             aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
             if (pci_bus_is_cxl(bus)) {
+                CxlHBDev *hb_entry;
                 struct Aml *pkg = aml_package(2);
 
+                hb_entry = g_malloc0(sizeof(*hb_entry));
+                hb_entry->uid = bus_num;
+                QSLIST_INSERT_HEAD(&cxl_hb_list_head, hb_entry, entry);
+
                 aml_append(dev, aml_name_decl("_HID", aml_string("ACPI0016")));
                 aml_append(pkg, aml_eisaid("PNP0A08"));
                 aml_append(pkg, aml_eisaid("PNP0A03"));
@@ -1866,6 +1878,7 @@ static void
 build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 {
     int i;
+    CxlHBDev *hb_entry;
     int numa_mem_start, slots;
     uint64_t mem_len, mem_base, next_base;
     MachineClass *mc = MACHINE_GET_CLASS(machine);
@@ -1973,6 +1986,16 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
 
     sgx_epc_build_srat(table_data);
 
+    QSLIST_FOREACH(hb_entry, &cxl_hb_list_head, entry) {
+        ACPIDeviceHandle handle = {
+                .hid = "ACPI0016",
+                .uid = hb_entry->uid,
+        };
+        uint32_t flags = GEN_AFFINITY_ENABLED;
+
+        build_srat_generic_port_affinity(table_data, 0, 0, &handle, flags);
+    }
+
     /*
      * TODO: this part is not in ACPI spec and current linux kernel boots fine
      * without these entries. But I recall there were issues the last time I
@@ -2728,6 +2751,8 @@ void acpi_setup(void)
         return;
     }
 
+    QSLIST_INIT(&cxl_hb_list_head);
+
     build_state = g_malloc0(sizeof *build_state);
 
     acpi_build_tables_init(&tables);
diff --git a/include/hw/acpi/aml-build.h b/include/hw/acpi/aml-build.h
index d1fb08514bfa..46a31469ebe2 100644
--- a/include/hw/acpi/aml-build.h
+++ b/include/hw/acpi/aml-build.h
@@ -204,6 +204,10 @@ typedef enum {
     AML_PULL_NONE = 3,
 } AmlPinConfig;
 
+/*
+ * ACPI 6.5: Table 5-68 Flags - Generic Initiator/Port Affinity Structure
+ * Flags field definition
+ */
 typedef enum {
     MEM_AFFINITY_NOFLAGS      = 0,
     MEM_AFFINITY_ENABLED      = (1 << 0),
@@ -211,6 +215,25 @@ typedef enum {
     MEM_AFFINITY_NON_VOLATILE = (1 << 2),
 } MemoryAffinityFlags;
 
+/*
+ * ACPI 6.5: Table 5-65 Device Handle - ACPI
+ * Device Handle definition
+ */
+typedef union ACPIDeviceHandle {
+    struct {
+        uint8_t hid[8];
+        uint32_t uid;
+        uint32_t reserved;
+    };
+    uint64_t raw[2];
+} ACPIDeviceHandle;
+
+typedef enum {
+    GEN_AFFINITY_NOFLAGS      = 0,
+    GEN_AFFINITY_ENABLED      = (1 << 0),
+    GEN_AFFINITY_ARCH_TRANS   = (2 << 0),
+} GenericAffinityFlags;
+
 typedef
 struct AcpiBuildTables {
     GArray *table_data;
@@ -486,6 +509,10 @@ Aml *build_crs(PCIHostState *host, CrsRangeSet *range_set, uint32_t io_offset,
 void build_srat_memory(GArray *table_data, uint64_t base,
                        uint64_t len, int node, MemoryAffinityFlags flags);
 
+void build_srat_generic_port_affinity(GArray *table_data, uint8_t htype, int node,
+                                      ACPIDeviceHandle *handle,
+                                      GenericAffinityFlags flags);
+
 void build_slit(GArray *table_data, BIOSLinker *linker, MachineState *ms,
                 const char *oem_id, const char *oem_table_id);
 


