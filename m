Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D0C343881
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jun 2026 09:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781775527; cv=none; b=Q+Je+C3HXsq2KvkfG/+JgMaja9jIOBOJ2sn0uTVU2PwUY8nzq0VLfHUmQG65yT5YVQ+TY309YGYgDf32VcheGZxymLkjeAvbSxvmEonU1r9bWT1I1JGdreaLunEXwU7CROQYFEcLrWtDCSvwfR4WsJhHy6IxaI0TIwfZquIGJEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781775527; c=relaxed/simple;
	bh=EVzJRY9ucbx+/cnsKLI9MjazyYaAtVRXYcBwi2a+rqQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N+KZ0haR71ZmnmBi0zj0yYB5fd6c9hfKMx6BYfSjD9e/fSdlZATnYXIkzf99u1XExZamEJg2w7/kHPdht6id3dj8gxzg9d51yfFXWkkuGZ8ZTz2WbSThpe1EL2KEcl0V1vaicMr1CBFiWDXfJsUMmtoR/UyGZZI/qtYEt5C853U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WeJTiTaL; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WeJTiTaL"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1781775517; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=3XQdS48sPXuJmO8K+dNMGNXxL97FmWYc63jMl0VUAiE=;
	b=WeJTiTaLfT0uyPYt638xJUmfk1Y6ryuKkiMhh9Dd+y+X80xsiU/lxLnM6sHzoHjzhaSkjp4ZE0HmcRfgUa9MYsJIdarT+AqZOWWrelc+6KJBoua/kEihyFqO3Z0Lk3w0C76VW5WlF4mwFxv+MD9RJJ3K3D5+CFx0NJjORWJo01Q=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0X56RwN-_1781775516;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X56RwN-_1781775516 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 18 Jun 2026 17:38:37 +0800
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
Subject: [PATCH v2 3/4] hw/riscv/virt,gpex: Provide 32-bit MMIO window for CXL host bridges
Date: Thu, 18 Jun 2026 17:38:25 +0800
Message-ID: <20260618093827.3507-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260618093827.3507-1-cp0613@linux.alibaba.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

CXL component register BAR (BAR0 on CXL Root Port and Type3 device)
and the CXL device register BAR (BAR2 on Type3 device) are declared
as 64-bit non-prefetchable memory.  Per the PCI-to-PCI Bridge
Architecture Specification Rev 1.2 (PCI-SIG, 2003):

  - §3.2.5.8 (Memory Base/Limit): the non-prefetchable window covers
    only 32-bit addresses (AD[31:20]); the Type 1 header defines no
    upper-32-bit extension for it.
  - §3.2.5.9 (Prefetchable Memory Base/Limit): the bottom 4 bits
    encode 64-bit support (01h), but this applies exclusively to the
    *prefetchable* window.
  - §3.2.5.10 (Prefetchable Base/Limit Upper 32 Bits): optional
    registers for AD[63:32] of the prefetchable range only.

The architecture therefore allows a 64-bit window only when it is also
prefetchable; there is no 64-bit non-prefetchable form.  PCIe inherits
this Type 1 header layout unchanged.  Linux thus places 64-bit
non-prefetchable BARs in the 32-bit non-prefetchable bridge window,
which requires the bridge to own enough address space below 4 GiB.

On RISC-V virt the 32-bit PCIe MMIO range (1 GiB at 0x40000000) is
currently consumed entirely by PCI0, so CXL host bridges (ACPI0016)
have no non-prefetchable window and Linux fails to assign these BARs.
Marking the BARs prefetchable would work around it, but the CXL
component registers have read/write side effects and are not
prefetchable per the PCIe specification.

Reserve the top 256 MiB of the 32-bit MMIO window exclusively for
CXL host bridges:
- Shrink PCI0's mmio32 window by 256 MiB in virt.c so that UEFI's
  PciHostBridgeDxe and the ACPI _CRS for PCI0 never claim that range
- Store the reserved range in a new gpex_cfg.cxl_mmio32 field
- In gpex-acpi.c, emit the cxl_mmio32 range as the Memory resource
  in the CXL host bridge _CRS instead of re-using build_crs() (which
  returns an empty set when UEFI has not assigned resources yet)
- Reduce the FDT 'ranges' for PCI0 by the same 256 MiB so that UEFI
  firmware driven by device-tree also respects the reservation

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/pci-host/gpex-acpi.c    | 36 +++++++++++++++++++++--
 hw/riscv/virt.c            | 58 +++++++++++++++++++++++++++++++-------
 include/hw/pci-host/gpex.h |  1 +
 3 files changed, 83 insertions(+), 12 deletions(-)

diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
index d9820f9b41..d8b943b665 100644
--- a/hw/pci-host/gpex-acpi.c
+++ b/hw/pci-host/gpex-acpi.c
@@ -158,9 +158,41 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
              * Resources defined for PXBs are composed of the following parts:
              * 1. The resources the pci-bridge/pcie-root-port need.
              * 2. The resources the devices behind pxb need.
+             *
+             * For CXL host bridges on platforms where UEFI (driven by
+             * FDT 'ranges') does not assign PCI resources for the CXL
+             * root bridge before ACPI table construction, build_crs()
+             * would return an empty resource set.  When the platform
+             * has reserved a dedicated MMIO window for CXL host bridges
+             * (cfg->cxl_mmio32), emit that window as a static _CRS
+             * instead.  The platform is responsible for shrinking PCI0's
+             * mmio32 window so the two do not overlap.
              */
-            crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set,
-                            cfg->pio.base, 0, 0, 0);
+            if (is_cxl && cfg->cxl_mmio32.size) {
+                uint64_t cxl_base = cfg->cxl_mmio32.base;
+                uint64_t cxl_size = cfg->cxl_mmio32.size;
+
+                crs = aml_resource_template();
+
+                /* 32-bit MMIO range for CXL devices */
+                aml_append(crs,
+                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
+                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
+                                     AML_READ_WRITE, 0,
+                                     cxl_base,
+                                     cxl_base + cxl_size - 1,
+                                     0, cxl_size));
+
+                /* Bus number range */
+                aml_append(crs,
+                    aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
+                                       AML_POS_DECODE, 0,
+                                       bus_num, bus_num + 15,
+                                       0, 16));
+            } else {
+                crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent),
+                                &crs_range_set, cfg->pio.base, 0, 0, 0);
+            }
             aml_append(dev, aml_name_decl("_CRS", crs));
 
             if (is_cxl) {
diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index 84b91b4322..9c1a001553 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -113,6 +113,9 @@ static const MemMapEntry virt_memmap[] = {
 /* PCIe high mmio for RV64, size is fixed but base depends on top of RAM */
 #define VIRT64_HIGH_PCIE_MMIO_SIZE  (16 * GiB)
 
+/* 32-bit MMIO range carved out of VIRT_PCIE_MMIO for CXL host bridges */
+#define VIRT_CXL_MMIO32_SIZE        (256 * MiB)
+
 static MemMapEntry virt_high_pcie_memmap;
 
 #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
@@ -890,15 +893,28 @@ static void create_fdt_pcie(RISCVVirtState *s,
     }
     qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
         s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
-    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
-        1, FDT_PCI_RANGE_IOPORT, 2, 0,
-        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
-        1, FDT_PCI_RANGE_MMIO,
-        2, s->memmap[VIRT_PCIE_MMIO].base,
-        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
-        1, FDT_PCI_RANGE_MMIO_64BIT,
-        2, virt_high_pcie_memmap.base,
-        2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
+    {
+        /*
+         * When CXL is enabled, reserve the last 256 MiB of the 32-bit
+         * MMIO window for CXL host bridges and exclude it from the main
+         * PCIe host bridge's FDT 'ranges' so UEFI's PciHostBridgeDxe
+         * does not allocate that range to PCI0.  The CXL host bridge
+         * _CRS declares this range independently.
+         */
+        hwaddr mmio32_size = s->memmap[VIRT_PCIE_MMIO].size;
+        if (s->cxl_devices_state.is_enabled) {
+            mmio32_size -= VIRT_CXL_MMIO32_SIZE;
+        }
+        qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
+            1, FDT_PCI_RANGE_IOPORT, 2, 0,
+            2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
+            1, FDT_PCI_RANGE_MMIO,
+            2, s->memmap[VIRT_PCIE_MMIO].base,
+            2, s->memmap[VIRT_PCIE_MMIO].base, 2, mmio32_size,
+            1, FDT_PCI_RANGE_MMIO_64BIT,
+            2, virt_high_pcie_memmap.base,
+            2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
+    }
 
     if (virt_is_iommu_sys_enabled(s)) {
         qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
@@ -1728,7 +1744,29 @@ static void virt_machine_init(MachineState *machine)
             qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
     }
 
-    gpex_pcie_init(system_memory, pcie_irqchip, s);
+    DeviceState *pcie_dev = gpex_pcie_init(system_memory, pcie_irqchip, s);
+
+    /*
+     * If CXL is enabled, reserve the last 256 MiB of the 32-bit MMIO
+     * window for CXL host bridges so the bridge non-prefetchable window
+     * can hold CXL device BARs (component registers and similar 64-bit
+     * non-prefetchable BARs that need a < 4 GiB address).
+     *
+     * - Shrink PCI0's mmio32 advertised in the ACPI _CRS by the same
+     *   256 MiB so the two ranges do not overlap (the FDT 'ranges'
+     *   shrink happens in create_fdt_pcie()).
+     * - Store the reserved range in cxl_mmio32 so gpex-acpi.c can emit
+     *   a correct _CRS for the CXL host bridge (ACPI0016).
+     */
+    if (s->cxl_devices_state.is_enabled) {
+        GPEXHost *gpex = GPEX_HOST(pcie_dev);
+        gpex->gpex_cfg.cxl_mmio32.size = VIRT_CXL_MMIO32_SIZE;
+        gpex->gpex_cfg.cxl_mmio32.base =
+            s->memmap[VIRT_PCIE_MMIO].base +
+            s->memmap[VIRT_PCIE_MMIO].size - VIRT_CXL_MMIO32_SIZE;
+        /* Shrink PCI0's advertised 32-bit MMIO window to exclude CXL range */
+        gpex->gpex_cfg.mmio32.size -= VIRT_CXL_MMIO32_SIZE;
+    }
 
     create_platform_bus(s, mmio_irqchip);
 
diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
index 1da9c85bce..d38fbbacd6 100644
--- a/include/hw/pci-host/gpex.h
+++ b/include/hw/pci-host/gpex.h
@@ -43,6 +43,7 @@ struct GPEXConfig {
     MemMapEntry mmio32;
     MemMapEntry mmio64;
     MemMapEntry pio;
+    MemMapEntry cxl_mmio32;
     int         irq;
     PCIBus      *bus;
     bool        pci_native_hotplug;
-- 
2.50.1

