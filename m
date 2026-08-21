Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570C39DBDB
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 08:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787300411; cv=none; b=pqrWgFHLzUzHk2UL4sHyP37dIgWnlTp6IMi7LYhp45PqylLpYhFGUNxVYVVeHky6oB3NYKCvv/mMkWIpqlE0dseoJI7p6ffHZhOd50y6G+kuoSv8J2Rcn0bay/iyxGCLvZ4//FfNj75KbL4vik06SP824o38xwq2BFX+uWHekik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787300411; c=relaxed/simple;
	bh=BIFFmHNI78IPfWTVZ9DGmeGTjZfy4kHwD/vNySClkg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shogvl8QE2ZRAtbB5GQ9jFUncL21EJDu+SelxRl9HzwiOrOFto/vDBMCzcJb9zogxnYYndZ1ckCGCTYZw8vLMCOG5qh6P3tmvMi8s/XhZNzcReoDKhdOUWyhy/GuUW6H+guh4vxbrM9DD7lDnZrrXMO3CfPAen7Cwhvlyr20YKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=XPzCO/4g; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="XPzCO/4g"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787300406; h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	bh=/23PizEp50RcPDZT+s3J0RsUX/+EgorfQW0a0MUxPNo=;
	b=XPzCO/4gjDwmIZG1FuoQreTC1bKo6sneHwm9tEOoA4NeOry2ql8OpGRo24jNSVrByRx+d03asvf3+cKxGOWOsjq2dBvqymQTsNA/Pz2OQb3bKx2o4GBImkG4kzJUZ403jKNhq+pxFl/VrxHLoENMwkC/Msyjn2QHh91DGJWVnfU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=cp0613@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X9LmLu9_1787300404;
Received: from DESKTOP-S9E58SO.localdomain(mailfrom:cp0613@linux.alibaba.com fp:SMTPD_---0X9LmLu9_1787300404 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 16:20:04 +0800
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
Subject: [PATCH 3/4] hw/riscv/virt: Provide a 32-bit MMIO window for CXL host bridges
Date: Fri, 21 Aug 2026 16:19:53 +0800
Message-ID: <20260821081954.1171-4-cp0613@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821081954.1171-1-cp0613@linux.alibaba.com>
References: <20260821081954.1171-1-cp0613@linux.alibaba.com>
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

Reserve the top 256 MiB of the 32-bit MMIO window exclusively for CXL
host bridges, keeping all of the logic in the riscv code:

- Reduce the FDT 'ranges' for PCI0 by 256 MiB so that device-tree
  driven firmware does not hand that range to PCI0.
- The CXL host bridge _CRS is produced by the generic build_crs()
  path.  EDK2's PciBusDxe only recurses into PCI-to-PCI bridges, while
  the pxb-cxl expander bridge presents as a class 0x0600 host bridge
  with a type-0 header, so firmware never enumerates behind it and
  leaves the CXL root port's window and bus-number registers unset;
  build_crs() would therefore return an empty _CRS.  Simulate the
  firmware PCI initialization in virt_cxl_init_bridge_windows(): assign
  the reserved window to the root port's memory window, and allocate
  primary/secondary/subordinate bus numbers depth-first.  build_crs()
  then emits both the memory range and a correct bus-range resource
  (without a bus range Linux only claims the host-bridge bus and cannot
  enumerate the devices behind the root port), and the range is
  excluded from PCI0's _CRS.  A reset handler re-applies the state, as
  a PCI reset clears those registers.

This targets a single pxb-cxl (one CXL host bridge), which matches the
bios-tables test added later in the series.  With more than one
pxb-cxl the single reserved window would be claimed by every ACPI0016
bridge, so it would need to be partitioned per bridge; that is left as
future work (see the TODO in virt_cxl_init_bridge_windows()).

Verified by booting an RVA22 kernel: the CXL root port and Type3 device
are enumerated (0000:0c:00.0 / 0000:0d:00.0) and 'cxl list' reports the
memdev and the CFMWS root decoder.

Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
---
 hw/riscv/virt.c | 154 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 153 insertions(+), 1 deletion(-)

diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
index e08c76af4d..af83603293 100644
--- a/hw/riscv/virt.c
+++ b/hw/riscv/virt.c
@@ -48,11 +48,13 @@
 #include "chardev/char.h"
 #include "system/device_tree.h"
 #include "system/system.h"
+#include "system/reset.h"
 #include "system/tcg.h"
 #include "system/kvm.h"
 #include "system/tpm.h"
 #include "system/qtest.h"
 #include "hw/pci/pci.h"
+#include "hw/pci/pci_bridge.h"
 #include "hw/pci-host/gpex.h"
 #include "hw/display/ramfb.h"
 #include "hw/cxl/cxl.h"
@@ -115,6 +117,9 @@ static const MemMapEntry virt_memmap[] = {
 /* PCIe high mmio for RV64, size is fixed but base depends on top of RAM */
 #define VIRT64_HIGH_PCIE_MMIO_SIZE  (16 * GiB)
 
+/* 32-bit MMIO range carved out of VIRT_PCIE_MMIO for CXL host bridges */
+#define VIRT_CXL_MMIO32_SIZE        (256 * MiB)
+
 static MemMapEntry virt_high_pcie_memmap;
 
 #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
@@ -727,6 +732,18 @@ static void create_fdt_pcie(RISCVVirtState *s,
 {
     g_autofree char *name = NULL;
     MachineState *ms = MACHINE(s);
+    /*
+     * When CXL is enabled, reserve the last 256 MiB of the 32-bit MMIO
+     * window for CXL host bridges and exclude it from the main PCIe host
+     * bridge's FDT 'ranges' so UEFI's PciHostBridgeDxe does not allocate
+     * that range to PCI0.  The CXL host bridge _CRS declares this range
+     * independently.
+     */
+    hwaddr mmio32_size = s->memmap[VIRT_PCIE_MMIO].size;
+
+    if (s->cxl_devices_state.is_enabled) {
+        mmio32_size -= VIRT_CXL_MMIO32_SIZE;
+    }
 
     name = g_strdup_printf("/soc/pci@%"HWADDR_PRIx,
                            s->memmap[VIRT_PCIE_ECAM].base);
@@ -752,7 +769,7 @@ static void create_fdt_pcie(RISCVVirtState *s,
         2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
         1, FDT_PCI_RANGE_MMIO,
         2, s->memmap[VIRT_PCIE_MMIO].base,
-        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
+        2, s->memmap[VIRT_PCIE_MMIO].base, 2, mmio32_size,
         1, FDT_PCI_RANGE_MMIO_64BIT,
         2, virt_high_pcie_memmap.base,
         2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
@@ -1130,6 +1147,132 @@ static void cxl_host_state_init(RISCVVirtState *s)
     cxl_fmws_update_mmio();
 }
 
+/*
+ * Assign PCI bus numbers to the bridges under @bus in depth-first order,
+ * the way firmware does during enumeration.  QEMU leaves the secondary and
+ * subordinate bus registers at 0 until firmware programs them, so without
+ * this build_crs() would see an empty bus range for the CXL host bridge.
+ * @bus itself is numbered @bus_num.  Returns the highest bus number used.
+ */
+static int virt_cxl_assign_bus_numbers(PCIBus *bus, int bus_num)
+{
+    int max_bus = bus_num;
+    int next_bus = bus_num + 1;
+    int devfn;
+
+    for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+        PCIDevice *dev = bus->devices[devfn];
+        PCIBus *sec_bus;
+        int subordinate;
+
+        if (!dev) {
+            continue;
+        }
+        if ((dev->config[PCI_HEADER_TYPE] &
+             ~PCI_HEADER_TYPE_MULTI_FUNCTION) != PCI_HEADER_TYPE_BRIDGE) {
+            continue;
+        }
+
+        sec_bus = pci_bridge_get_sec_bus(PCI_BRIDGE(dev));
+        subordinate = virt_cxl_assign_bus_numbers(sec_bus, next_bus);
+
+        pci_set_byte(dev->config + PCI_PRIMARY_BUS, bus_num);
+        pci_set_byte(dev->config + PCI_SECONDARY_BUS, next_bus);
+        pci_set_byte(dev->config + PCI_SUBORDINATE_BUS, subordinate);
+
+        if (subordinate > max_bus) {
+            max_bus = subordinate;
+        }
+        next_bus = subordinate + 1;
+    }
+
+    return max_bus;
+}
+
+/*
+ * Simulate the PCI resource initialization that firmware (UEFI) would
+ * normally perform for the CXL host bridge.
+ *
+ * EDK2's PciBusDxe only recurses into devices that look like PCI-to-PCI
+ * bridges, while the pxb-cxl expander bridge presents as a class 0x0600
+ * host bridge with a standard (type 0) header, so the firmware neither
+ * enumerates behind it nor assigns it a memory window or bus numbers.  As a
+ * result the generic build_crs() path would produce an empty _CRS for the
+ * CXL host bridge (ACPI0016).
+ *
+ * Program each CXL root port the way firmware would:
+ *  - assign the reserved 32-bit MMIO range (see create_fdt_pcie()) to its
+ *    memory window, so build_crs() emits that range in the host bridge _CRS
+ *    and excludes it from PCI0's _CRS;
+ *  - set the primary/secondary/subordinate bus numbers, so build_crs()
+ *    emits a correct bus-range resource.  Without a bus range Linux only
+ *    claims the single host-bridge bus and cannot enumerate the devices
+ *    behind the root port.
+ *
+ * TODO: this handles a single pxb-cxl with a single root port, which is
+ * the supported topology for now.  With multiple CXL host bridges or root
+ * ports the reserved window would need to be partitioned per bridge.
+ */
+static void virt_cxl_init_bridge_windows(RISCVVirtState *s)
+{
+    hwaddr cxl_mmio_base, cxl_mmio_limit;
+    PCIBus *bus;
+
+    if (!s->cxl_devices_state.is_enabled) {
+        return;
+    }
+
+    cxl_mmio_base = s->memmap[VIRT_PCIE_MMIO].base +
+                    s->memmap[VIRT_PCIE_MMIO].size - VIRT_CXL_MMIO32_SIZE;
+    cxl_mmio_limit = cxl_mmio_base + VIRT_CXL_MMIO32_SIZE - 1;
+
+    QLIST_FOREACH(bus, &s->pci_bus->child, sibling) {
+        int devfn;
+
+        if (!pci_bus_is_root(bus) || !pci_bus_is_cxl(bus)) {
+            continue;
+        }
+
+        /* Assign bus numbers for the whole CXL subtree (firmware would). */
+        virt_cxl_assign_bus_numbers(bus, pci_bus_num(bus));
+
+        /* Assign the reserved MMIO window to the root-port bridge. */
+        for (devfn = 0; devfn < ARRAY_SIZE(bus->devices); devfn++) {
+            PCIDevice *dev = bus->devices[devfn];
+            PCIBridge *br;
+
+            if (!dev) {
+                continue;
+            }
+            if ((dev->config[PCI_HEADER_TYPE] &
+                 ~PCI_HEADER_TYPE_MULTI_FUNCTION) != PCI_HEADER_TYPE_BRIDGE) {
+                continue;
+            }
+
+            br = PCI_BRIDGE(dev);
+
+            pci_set_word(dev->config + PCI_MEMORY_BASE,
+                         (cxl_mmio_base >> 16) & PCI_MEMORY_RANGE_MASK);
+            pci_set_word(dev->config + PCI_MEMORY_LIMIT,
+                         (cxl_mmio_limit >> 16) & PCI_MEMORY_RANGE_MASK);
+            pci_word_test_and_set_mask(dev->config + PCI_COMMAND,
+                                       PCI_COMMAND_MEMORY);
+            pci_bridge_update_mappings(br);
+            break;
+        }
+    }
+}
+
+/*
+ * A PCI reset clears the bridge window and bus-number registers programmed
+ * above, so re-apply them after every reset, the way firmware would during
+ * its PCI enumeration.
+ */
+static void virt_cxl_reset_bridge_windows(void *opaque)
+{
+    virt_cxl_init_bridge_windows(RISCV_VIRT_MACHINE(opaque));
+}
+
 static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
 {
     FWCfgState *fw_cfg;
@@ -1238,6 +1381,15 @@ static void virt_machine_done(Notifier *notifier, void *data)
     if (s->cxl_devices_state.is_enabled) {
         cxl_fmws_link_targets(&error_fatal);
     }
+
+    /*
+     * Assign the CXL bridge memory window (simulating firmware) so the
+     * ACPI _CRS built for the CXL host bridge is populated.  Do it here for
+     * the initial build, and register a reset handler so the window is
+     * re-applied after any PCI reset (which clears the bridge registers).
+     */
+    virt_cxl_init_bridge_windows(s);
+    qemu_register_reset(virt_cxl_reset_bridge_windows, s);
     hwaddr firmware_end_addr;
     vaddr kernel_start_addr;
     const char *firmware_name = riscv_default_firmware_name(&s->soc[0]);
-- 
2.50.1

