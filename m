Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1378D35B65D
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775521; cv=none; b=sRB0eJHxtGoeDEvPvAbHmUJonfvA0Pwc2Xk1UhgOuXe7M8Xa4YaLx3zeglpq4YmyKeg5SkoAAgq+VmZzH5dvEQ2GBc9E5xwJdKN+G6upP6StwNx62PlIENAh8IkQGwuHzeWjKR79Vp2d+N2ks+4pZAu6u9W4P7ywpDT3aIVArsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775521; c=relaxed/simple;
	bh=ly1Bjxk+YPhkI+0pSMSVeOwtAKnosevT/k4jQWA/wpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZuUgMjMXKyd1lDWwrVqgnPSWrq+xNnlZ33wukotZlYg8MjeFFx7S6NAL7GJLzuLs30o9B5AsfgWC7bV+Oh915MKNewV4pNceo07qZ8GYnJNRoOqiM1sWCPwo2UDCkh2rdeWkVUl02BFqEsfStsO2+OflsDK+t/BJd4o7qi1kxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=yc4x5MXF; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="yc4x5MXF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781775516; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=XL9ehYAlIK5xBXPqBRCJ62qfknRHEuXN3NuX5sOY1Uo=;
	b=yc4x5MXFh14hGaSJ62duT3ubJQ+kyqqLM+oAjKRDpUlsQVni5qWXy0FJT2BOFrF0xkfn/jjaE/8EEWlq3Z07XIN7bAdABNmrwxm8mXVVeWgorksERHETShiYuj/f7dkoC8G3k11aTg7jotl0VenedPqdM/MMw+3TedmqXh3ckiE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X56RwMW_1781775515;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X56RwMW_1781775515 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:38:35 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: jic23@kernel.org,
	pbonzini@redhat.com,
	palmer@dabbelt.com,
	alistair.francis@wdc.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu.zevorn@gmail.com,
	sunilvl@ventanamicro.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	imammedo@redhat.com,
	mst@redhat.com,
	guoren@kernel.org
Cc: qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Thu, 18 Jun 2026 17:38:23 +0800
Message-ID: <20260618093827.3507-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618093827.3507-1-cp0613@linux.alibaba.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable CXL support on the RISC-V virt machine following the same
approach used by the ARM virt machine:
- Add PXB and ACPI_CXL Kconfig selections
- Add CXLState and PCIBus pointer to RISCVVirtState
- Register CXL machine properties via cxl_machine_init()
- Create CXL host register region above the PCIe high MMIO region
- Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
  machine_done time
- Map Fixed Memory Windows above the CXL host register region
- Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/riscv/Kconfig           |  2 ++
 hw/riscv/virt-acpi-build.c | 20 +++++++++++++++++++
 hw/riscv/virt.c            | 40 ++++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  3 +++
 4 files changed, 65 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index 2518b04175..ebd0355f09 100644
--- a/hw/riscv/Kconfig
+++ b/hw/riscv/Kconfig
@@ -66,8 +66,10 @@ config RISCV_VIRT
     select VIRTIO_MMIO
     select FW_CFG_DMA
     select PLATFORM_BUS
+    select PXB
     select ACPI
     select ACPI_PCI
+    select ACPI_CXL
 
 config SHAKTI_C
     bool
diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
index 413d47d70e..309d64b322 100644
--- a/hw/riscv/virt-acpi-build.c
+++ b/hw/riscv/virt-acpi-build.c
@@ -29,12 +29,16 @@
 #include "hw/acpi/aml-build.h"
 #include "hw/acpi/pci.h"
 #include "hw/acpi/utils.h"
+#include "hw/acpi/cxl.h"
 #include "hw/intc/riscv_aclint.h"
 #include "hw/nvram/fw_cfg_acpi.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/riscv/virt.h"
 #include "hw/riscv/numa.h"
 #include "hw/virtio/virtio-acpi.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "kvm/kvm_riscv.h"
 #include "migration/vmstate.h"
 #include "qapi/error.h"
@@ -503,6 +507,17 @@ static void build_dsdt(GArray *table_data,
         acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + VIRT_IRQCHIP_NUM_SOURCES * 2);
     }
 
+    if (s->cxl_devices_state.is_enabled) {
+        Aml *cxl_dev = aml_device("CXLM");
+        aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
+        Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
+        aml_append(method, aml_return(aml_int(0x0B)));
+        aml_append(cxl_dev, method);
+        build_cxl_dsm_method(cxl_dev);
+
+        aml_append(scope, cxl_dev);
+    }
+
     aml_append(dsdt, scope);
 
     /* copy AML table into ACPI tables blob and patch header there */
@@ -910,6 +925,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
                    s->oem_table_id);
     }
 
+    if (s->cxl_devices_state.is_enabled) {
+        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
+                       s->oem_id, s->oem_table_id, &s->cxl_devices_state);
+    }
+
     if (ms->numa_state->num_nodes > 0) {
         acpi_add_table(table_offsets, tables_blob);
         build_srat(tables_blob, tables->linker, s);
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index ce64eaaef7..84b91b4322 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -55,6 +55,8 @@
 #include "hw/pci/pci.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 #include "hw/acpi/aml-build.h"
 #include "qapi/qapi-visit-common.h"
 #include "hw/virtio/virtio-iommu.h"
@@ -1259,9 +1261,27 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     }
 
     GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
+    s->pci_bus = PCI_HOST_BRIDGE(dev)->bus;
     return dev;
 }
 
+static void create_cxl_host_reg_region(RISCVVirtState *s)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *mr = &s->cxl_devices_state.host_mr;
+    hwaddr base;
+
+    if (!s->cxl_devices_state.is_enabled) {
+        return;
+    }
+
+    base = virt_high_pcie_memmap.base + virt_high_pcie_memmap.size;
+    base = ROUND_UP(base, 64 * KiB);
+
+    memory_region_init(mr, OBJECT(s), "cxl_host_reg", 64 * KiB * 16);
+    memory_region_add_subregion(sysmem, base, mr);
+}
+
 static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
@@ -1426,6 +1446,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
                                      machine_done);
     MachineState *machine = MACHINE(s);
     hwaddr start_addr = s->memmap[VIRT_DRAM].base;
+
+    cxl_hook_up_pxb_registers(s->pci_bus, &s->cxl_devices_state,
+                              &error_fatal);
+
+    if (s->cxl_devices_state.is_enabled) {
+        cxl_fmws_link_targets(&error_fatal);
+    }
     hwaddr firmware_end_addr;
     vaddr kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
@@ -1663,6 +1690,17 @@ static void virt_machine_init(MachineState *machine)
             ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
     }
 
+    create_cxl_host_reg_region(s);
+
+    if (s->cxl_devices_state.is_enabled) {
+        hwaddr cxl_base = virt_high_pcie_memmap.base +
+                          virt_high_pcie_memmap.size;
+        cxl_base += memory_region_size(&s->cxl_devices_state.host_mr);
+        cxl_base = ROUND_UP(cxl_base, 256 * MiB);
+        cxl_fmws_set_memmap(cxl_base, UINT64_MAX);
+        cxl_fmws_update_mmio();
+    }
+
     /* register system main memory (actual RAM) */
     memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
                                 machine->ram);
@@ -1769,6 +1807,8 @@ static void virt_machine_instance_init(Object *obj)
     s->oem_table_id = g_strndup(ACPI_BUILD_APPNAME8, 8);
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
+
+    cxl_machine_init(obj, &s->cxl_devices_state);
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 18a2a323a3..7d559ac610 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -24,6 +24,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/cxl/cxl.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
@@ -64,6 +65,8 @@ struct RISCVVirtState {
     struct GPEXHost *gpex_host;
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
+    CXLState cxl_devices_state;
+    PCIBus *pci_bus;
 };
 
 enum {
-- 
2.50.1

