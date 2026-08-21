Received: from out30-100.freemail.mail.aliyun.com (out30-100.freemail.mail.aliyun.com [115.124.30.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C0239890A
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300411; cv=none; b=rP1yIbdHRiUb3tCl6B4gMS50OqxuGlGNjgVPDPtYKGdJe/4wFhxwvz3GntwVpNdDTTt2qEOTGgChqF1+yf0kcq26MW8MELlRuo2s+ApI22hUZbvCZqQry4vNdfy+7NRvn7f/YKCd02reUE00JoMtim9Kok8v1eqpFv/4Rp66PjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300411; c=relaxed/simple;
	bh=6jTgzTQ5uEknmPhe1xtK357um7OUBH1ApyZi8nQAEBw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J0ERZsfEXDO0jfFsoF/PBfc3w6nzhObqoY95hX/7ew4rZoJsmmqojAHk2EHDjIshchD3u9ZsxoMxUNGMAgcQT7nePFVWJzut7Q6XvYbyuXwGP63mb1s8rvkKjYpgAffO2GhF7guci6qtcG5Sw7t13irkf23hrW3oH0bx+z6NR7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=gg6ayPQN; arc=none smtp.client-ip=115.124.30.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="gg6ayPQN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787300404; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=7kYP1SmE4po1NHX60o1wn5jt4JN1ovNWLbqMRiHorT8=;
	b=gg6ayPQNxSQfVoQr2cNf926Rz8YfeW7Zq3Gctvqy9dKEPLeQ9V/+UqYe5a6681GiHPmmhQvOq6aRUFj1a+Ky86kASJNQwN19zFCQ0nh+maPB4qMHZMb1t5pqyWa71I9rcAZJ+VI6Amgy61Ae3w+AFAT5I6niR5mo1njf/pd6wQY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9LmLtZ_1787300402;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9LmLtZ_1787300402 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 16:20:02 +0800
From: Chen Pei <cp0613@linux.alibaba.com>
To: palmer@dabbelt.com,
	alistair.francis@wdc.com,
	mst@redhat.com,
	imammedo@redhat.com,
	sunilvl@ventanamicro.com,
	jic23@kernel.org
Cc: pbonzini@redhat.com,
	liwei1518@gmail.com,
	daniel.barboza@oss.qualcomm.com,
	zhiwei_liu@linux.alibaba.com,
	chao.liu@processmission.com,
	anisinha@redhat.com,
	dave.jiang@intel.com,
	alison.schofield@intel.com,
	junjie.cao@intel.com,
	guoren@kernel.org,
	qemu-riscv@nongnu.org,
	qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/4] hw/riscv/virt: Add CXL support to the RISC-V virt machine
Date: Fri, 21 Aug 2026 16:19:51 +0800
Message-ID: <20260821081954.1171-2-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
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
 hw/riscv/virt-acpi-build.c | 20 ++++++++++++++++++++
 hw/riscv/virt.c            | 37 +++++++++++++++++++++++++++++++++++++
 include/hw/riscv/virt.h    |  3 +++
 4 files changed, 62 insertions(+)

diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
index de37c08cae..0ba3cd9e15 100644
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
index 59c454f4f9..3188cdc5bf 100644
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
@@ -514,6 +518,17 @@ static void build_dsdt(GArray *table_data,
         acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
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
@@ -921,6 +936,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
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
index 51bac47a91..e08c76af4d 100644
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
@@ -1101,9 +1103,33 @@ static inline DeviceState *gpex_pcie_init(MemoryRegion *sys_mem,
     }
 
     GPEX_HOST(dev)->gpex_cfg.bus = PCI_HOST_BRIDGE(dev)->bus;
+    s->pci_bus = PCI_HOST_BRIDGE(dev)->bus;
     return dev;
 }
 
+static void cxl_host_state_init(RISCVVirtState *s)
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
+
+    /* Map the Fixed Memory Windows above the CXL host register region. */
+    base += memory_region_size(mr);
+    base = ROUND_UP(base, 256 * MiB);
+    cxl_fmws_set_memmap(base, UINT64_MAX);
+    cxl_fmws_update_mmio();
+}
+
 static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
@@ -1205,6 +1231,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
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
@@ -1451,6 +1484,8 @@ static void virt_machine_init(MachineState *machine)
             ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
     }
 
+    cxl_host_state_init(s);
+
     /* register system main memory (actual RAM) */
     memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
                                 machine->ram);
@@ -1558,6 +1593,8 @@ static void virt_machine_instance_init(Object *obj)
     s->acpi = ON_OFF_AUTO_AUTO;
     s->iommu_sys = ON_OFF_AUTO_AUTO;
     s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
+
+    cxl_machine_init(obj, &s->cxl_devices_state);
 }
 
 static char *virt_get_aia_guests(Object *obj, Error **errp)
diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
index 36a2def410..4cf930ab9f 100644
--- a/include/hw/riscv/virt.h
+++ b/include/hw/riscv/virt.h
@@ -24,6 +24,7 @@
 #include "hw/core/sysbus.h"
 #include "hw/block/flash.h"
 #include "hw/intc/riscv_imsic.h"
+#include "hw/cxl/cxl.h"
 
 #define VIRT_CPUS_MAX_BITS             9
 #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
@@ -65,6 +66,8 @@ struct RISCVVirtState {
     OnOffAuto iommu_sys;
     uint16_t pci_iommu_bdf;
     uint16_t num_sources;
+    CXLState cxl_devices_state;
+    PCIBus *pci_bus;
 };
 
 enum {
-- 
2.50.1

