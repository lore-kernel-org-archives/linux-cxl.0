Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD8C1CA83
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 14:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707143116; cv=none; b=IpJ4Qgwrbll4MglOQFcDohyHbcWUSF/TNAOFeLbLLVHkH9gtHgqz8M8jG+E1si8nNQU3OY+ZBx3Qg/DFN8I/bl36K0IIZn5c3MDPn1XagRaY3bOcNdqhFFYUa71LBBQk8jtWAIkr3Efvnx4U/3Gn/sRZEAPiKLdb3wYArAVQku0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707143116; c=relaxed/simple;
	bh=v2icC4rBD/bBllfp6HIPBxj7N8Y0Wt+D1/naHq/cLrs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jv+R7W41nUUsDCrSJwcHH39jvEHB+TPyNZjXilokCm9jffl1uquS6wNNXZeK+TXc8wdcZDlwxG5tAJNA8bdYAyw7Xnlgx9Mo31Uxjpp2nbCTNF5xWYnQ79swq1Sm4TCord1cupW8jLodpV8I1lpbwnq+iyiMkRbTlM0L6Puzn3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TT7qV6gndz6D8gC;
	Mon,  5 Feb 2024 22:21:58 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9ED2C140A36;
	Mon,  5 Feb 2024 22:25:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 14:25:12 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <qemu-devel@nongnu.org>
CC: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
	Shannon Zhao <shannon.zhaosl@gmail.com>, Dongjiu Geng
	<gengdongjiu1@gmail.com>, <linuxarm@huawei.com>, "Michael S . Tsirkin"
	<mst@redhat.com>, Ira Weiny <ira.weiny@intel.com>, Peter Maydell
	<peter.maydell@linaro.org>, Fan Ni <fan.ni@samsung.com>, Marcel Apfelbaum
	<marcel.apfelbaum@gmail.com>
Subject: [RFC PATCH 11/11] cxl/type3: Add firmware first error reporting for general media events.
Date: Mon, 5 Feb 2024 14:19:40 +0000
Message-ID: <20240205141940.31111-12-Jonathan.Cameron@huawei.com>
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

Initial code for Firmware First injection of general media events.
PoC level only - issue to be solved include:
* Mapping to CPER error types (recoverable etc).
* Some record details are tricky to establish so for now are not
  provided.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/acpi/ghes.h |   3 ++
 hw/acpi/ghes-stub.c    |   6 +++
 hw/acpi/ghes.c         | 120 +++++++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c     |  14 +++--
 4 files changed, 140 insertions(+), 3 deletions(-)

diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
index 3426697ecd..171c3e9dad 100644
--- a/include/hw/acpi/ghes.h
+++ b/include/hw/acpi/ghes.h
@@ -83,6 +83,9 @@ typedef struct CXLError CXLError;
 bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *err,
                             CXLError *cxl_err, uint32_t notify);
 
+typedef struct CXLEventGenMedia CXLEventGenMedia;
+bool ghes_record_cxl_event_gm(PCIDevice *dev,
+                           CXLEventGenMedia *gem, uint32_t notify);
 /**
  * acpi_ghes_present: Report whether ACPI GHES table is present
  *
diff --git a/hw/acpi/ghes-stub.c b/hw/acpi/ghes-stub.c
index cbc7d57465..34940c6441 100644
--- a/hw/acpi/ghes-stub.c
+++ b/hw/acpi/ghes-stub.c
@@ -25,6 +25,12 @@ bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *err,
     return false;
 }
 
+bool ghes_record_cxl_event_gm(PCIDevice *dev, CXLEventGenMedia *gen,
+                              uint32_t notify)
+{
+    return false;
+}
+
 bool acpi_ghes_present(void)
 {
     return false;
diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
index c6e863d375..34d8b8a518 100644
--- a/hw/acpi/ghes.c
+++ b/hw/acpi/ghes.c
@@ -281,6 +281,49 @@ static void build_append_aer_cper(PCIDevice *dev, GArray *table)
     }
 }
 
+static void build_append_cxl_event_cper(PCIDevice *dev, CXLEventGenMedia *gen,
+                                  GArray *table)
+{
+    PCIDeviceClass *pci_class = PCI_DEVICE_GET_CLASS(dev);
+    uint16_t sn_cap_offset = pcie_find_capability(dev, 0x3);
+    int i;
+
+    build_append_int_noprefix(table, 0x90, 4); /* Length */
+    build_append_int_noprefix(table,
+                              (1UL << 0) | /* Device ID */
+                              ((sn_cap_offset ? 1UL : 0UL) << 1) |
+                              (1UL << 2), /* Event Log entry */
+                              8);
+    /* Device id - differnet syntax from protocol error - sigh */
+    build_append_int_noprefix(table, pci_class->vendor_id, 2);
+    build_append_int_noprefix(table, pci_class->device_id, 2);
+    build_append_int_noprefix(table, PCI_FUNC(dev->devfn), 1);
+    build_append_int_noprefix(table, PCI_SLOT(dev->devfn), 1);
+    build_append_int_noprefix(table, pci_dev_bus_num(dev), 1);
+    build_append_int_noprefix(table, 0 /* Seg */, 2);
+    /*
+     * TODO: figure out how to get the slot number as the slot number
+     * capabiltiy is deprecated so it only really exists via _DSM
+     */
+    build_append_int_noprefix(table, 0, 2);
+
+    /* Reserved */
+    build_append_int_noprefix(table, 0, 1);
+
+    if (sn_cap_offset) {
+        uint32_t dw = pci_get_long(dev->config + sn_cap_offset + 4);
+
+        build_append_int_noprefix(table, dw, 4);
+        dw = pci_get_long(dev->config + sn_cap_offset + 8);
+        build_append_int_noprefix(table, dw, 4);
+    } else {
+        build_append_int_noprefix(table, 0, 8);
+    }
+    for (i = offsetof(typeof(*gen), hdr.length); i < sizeof(*gen); i++) {
+        build_append_int_noprefix(table, ((uint8_t *)gen)[i], 1);
+    }
+}
+
 static void build_append_cxl_cper(PCIDevice *dev, CXLError *cxl_err,
                                   GArray *table)
 {
@@ -501,6 +544,52 @@ static int ghes_record_aer_error(PCIDevice *dev, uint64_t error_block_address)
     return true;
 }
 
+static int ghes_record_cxl_gen_media(PCIDevice *dev, CXLEventGenMedia *gem,
+                                     uint64_t error_block_address)
+{
+    QemuUUID fru_id = {0};
+    GArray *block;
+    uint32_t data_length;
+    uint32_t event_length = 0x90;
+    const uint8_t section_id_le[] = { 0x77, 0x0a, 0xcd, 0xfb,
+                                      0x60, 0xc2,
+                                      0x7f, 0x41,
+                                      0x85, 0xa9,
+                                      0x08, 0x8b, 0x16, 0x21, 0xeb, 0xa6 };
+    block = g_array_new(false, true, 1);
+        /* Read the current length in bytes of the generic error data */
+    cpu_physical_memory_read(error_block_address + 8, &data_length, 4);
+
+    /* Add a new generic error data entry*/
+    data_length += ACPI_GHES_DATA_LENGTH;
+    data_length += event_length;
+
+    /*
+     * Check whether it will run out of the preallocated memory if adding a new
+     * generic error data entry
+     */
+    if ((data_length + ACPI_GHES_GESB_SIZE) > ACPI_GHES_MAX_RAW_DATA_LENGTH) {
+        error_report("Record CPER out of boundary!!!");
+        return false;
+    }
+    /* Build the new generic error status block header */
+    acpi_ghes_generic_error_status(block, ACPI_GEBS_UNCORRECTABLE, 0, 0,
+                                   data_length, ACPI_CPER_SEV_RECOVERABLE);
+
+    /* Build the new generic error data entry header */
+    acpi_ghes_generic_error_data(block, section_id_le,
+                                 ACPI_CPER_SEV_RECOVERABLE, 0, 0,
+                                 0x90, fru_id, 0);
+
+    /* Build the CXL CPER */
+    build_append_cxl_event_cper(dev, gem, block); /* 0x90 long */
+    /* Write back above whole new generic error data entry to guest memory */
+    cpu_physical_memory_write(error_block_address, block->data, block->len);
+    g_array_free(block, true);
+
+    return 0;
+}
+
 static int ghes_record_cxl_error(PCIDevice *dev, CXLError *cxl_err,
                                  uint64_t error_block_address)
 {
@@ -858,6 +947,37 @@ bool ghes_record_aer_errors(PCIDevice *dev, uint32_t notify)
     return ghes_record_aer_error(dev, error_block_addr);
 }
 
+bool ghes_record_cxl_event_gm(PCIDevice *dev, CXLEventGenMedia *gem,
+                              uint32_t notify)
+{
+    int read_ack_register = 0;
+    uint64_t read_ack_register_addr = 0;
+    uint64_t error_block_addr = 0;
+
+    if (!ghes_get_addr(notify, &error_block_addr, &read_ack_register_addr)) {
+        return false;
+    }
+
+    cpu_physical_memory_read(read_ack_register_addr,
+                             &read_ack_register, sizeof(uint64_t));
+    /* zero means OSPM does not acknowledge the error */
+    if (!read_ack_register) {
+        error_report("Last time OSPM does not acknowledge the error,"
+                     " record CPER failed this time, set the ack value to"
+                     " avoid blocking next time CPER record! exit");
+        read_ack_register = 1;
+        cpu_physical_memory_write(read_ack_register_addr,
+                                  &read_ack_register, sizeof(uint64_t));
+        return false;
+    }
+
+    read_ack_register = cpu_to_le64(0);
+    cpu_physical_memory_write(read_ack_register_addr,
+                              &read_ack_register, sizeof(uint64_t));
+
+    return ghes_record_cxl_gen_media(dev, gem, error_block_addr);
+}
+
 bool ghes_record_cxl_errors(PCIDevice *dev, PCIEAERErr *aer_err,
                             CXLError *cxl_err, uint32_t notify)
 {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3a7881118a..1cc58293a2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1734,6 +1734,8 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         const char *component_id,
                                         Error **errp)
 {
+    MachineState *machine = MACHINE(qdev_get_machine());
+    MachineClass *mc = MACHINE_GET_CLASS(machine);
     Object *obj = object_resolve_path(path, NULL);
     CXLEventGenMedia gem;
     CXLEventRecordHdr *hdr = &gem.hdr;
@@ -1792,9 +1794,15 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     }
 
     stw_le_p(&gem.validity_flags, valid_flags);
-
-    if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
-        cxl_event_irq_assert(ct3d);
+    if (!acpi_fw_first_pci()) {
+        if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
+            cxl_event_irq_assert(ct3d);
+        }
+    } else {
+        ghes_record_cxl_event_gm(PCI_DEVICE(ct3d), &gem, ACPI_GHES_NOTIFY_GPIO);
+        if (mc->set_error) {
+            mc->set_error();
+        }
     }
 }
 
-- 
2.39.2

