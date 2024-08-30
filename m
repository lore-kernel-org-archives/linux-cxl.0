Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C4613D60E
	for <linux-cxl@vger.kernel.org>; Fri, 30 Aug 2024 04:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724991394; cv=none; b=e6br8dgE1wd4EfzYM1gqjUIcxrwgH5cR0l7AVgHdZADNf+QTENcAiM+x5CRkBnDwtxv8jGnCU73c5xcrg8VEzJEtLbeQN7uFy80bdCUKkVkypG7CjOBb/3SjW9oNKsVk8fMTs7rheOFm2v2Higgjrj3xZ6X9GsTx3ZAIW+BqkA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724991394; c=relaxed/simple;
	bh=mRT4Bo4OwlPLuexu9oqtuiVpLuSMbh5UXKSycw6ayL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uyeQNZGg9FODgYL6lDqpuDpBMSGyq8jdTgPxLLRbQuLuaam1sJl8a7xcae8iZJxPudoSpTuYyw1CHKEu4f06kLc+SnkfYpS9rip7ZpIDq6pqlw0qBu9RKO3uqfjYgg/1eo8lUfSDUsjg8imQ1+hb8USck0EF7+VFxJ9EtY1pF0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn; spf=pass smtp.mailfrom=phytium.com.cn; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytium.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytium.com.cn
Received: from prodtpl.icoremail.net (unknown [10.12.1.20])
	by hzbj-icmmx-6 (Coremail) with SMTP id AQAAfwCnqSGXR9Fmob+CAg--.18550S2;
	Fri, 30 Aug 2024 12:16:23 +0800 (CST)
Received: from phytium.com.cn (unknown [218.76.62.144])
	by mail (Coremail) with SMTP id AQAAfwC34bGOR9FmmakpAA--.16568S4;
	Fri, 30 Aug 2024 12:16:21 +0800 (CST)
From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
To: Jonathan.Cameron@Huawei.com,
	quic_llindhol@quicinc.com,
	peter.maydell@linaro.org,
	marcin.juszkiewicz@linaro.org
Cc: qemu-devel@nongnu.org,
	linux-cxl@vger.kernel.org,
	qemu-arm@nongnu.org,
	chenbaozi@phytium.com.cn,
	wangyinfeng@phytium.com.cn,
	shuyiqi@phytium.com.cn,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>
Subject: [RFC PATCH 1/2] hw/arm/sbsa-ref: Enable CXL Host Bridge by pxb-cxl
Date: Fri, 30 Aug 2024 12:15:56 +0800
Message-Id: <20240830041557.600607-2-wangyuquan1236@phytium.com.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
References: <20240830041557.600607-1-wangyuquan1236@phytium.com.cn>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAfwC34bGOR9FmmakpAA--.16568S4
X-CM-SenderInfo: 5zdqw5pxtxt0arstlqxsk13x1xpou0fpof0/1tbiAQANAWbQ2MkCWwAAsz
Authentication-Results: hzbj-icmmx-6; spf=neutral smtp.mail=wangyuquan
	1236@phytium.com.cn;
X-Coremail-Antispam: 1Uk129KBjvJXoWxXr48Jr1UGFy5KFWrJFyrZwb_yoWrXFyUpF
	45ur95CrW8GF17ArZ3Z347GF45Wayvkayjyry7Cr9YyF17Gr1Fq3ykK3WUKa47JFWDt34j
	9FZxZr1fWr17AaUanT9S1TB71UUUUUJqnTZGkaVYY2UrUUUUj1kv1TuYvTs0mT0YCTnIWj
	DUYxn0WfASr-VFAU7a7-sFnT9fnUUIcSsGvfJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUU
	UUUUU

The memory layout places 1M space for 16 host bridge register regions
in the sbsa-ref memmap. In addition, this creates a default pxb-cxl
(bus_nr=0xfe) bridge with one cxl-rp on sbsa-ref.

Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
---
 hw/arm/sbsa-ref.c | 54 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 51 insertions(+), 3 deletions(-)

diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index ae37a92301..dc924d181e 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -41,7 +41,10 @@
 #include "hw/intc/arm_gicv3_common.h"
 #include "hw/intc/arm_gicv3_its_common.h"
 #include "hw/loader.h"
+#include "hw/pci/pci_bridge.h"
+#include "hw/pci/pci_bus.h"
 #include "hw/pci-host/gpex.h"
+#include "hw/pci-bridge/pci_expander_bridge.h"
 #include "hw/qdev-properties.h"
 #include "hw/usb.h"
 #include "hw/usb/xhci.h"
@@ -52,6 +55,8 @@
 #include "qom/object.h"
 #include "target/arm/cpu-qom.h"
 #include "target/arm/gtimer.h"
+#include "hw/cxl/cxl.h"
+#include "hw/cxl/cxl_host.h"
 
 #define RAMLIMIT_GB 8192
 #define RAMLIMIT_BYTES (RAMLIMIT_GB * GiB)
@@ -94,6 +99,7 @@ enum {
     SBSA_SECURE_MEM,
     SBSA_AHCI,
     SBSA_XHCI,
+    SBSA_CXL_HOST,
 };
 
 struct SBSAMachineState {
@@ -105,6 +111,9 @@ struct SBSAMachineState {
     int psci_conduit;
     DeviceState *gic;
     PFlashCFI01 *flash[2];
+    CXLState cxl_devices_state;
+    PCIBus *bus;
+    PCIBus *cxlbus;
 };
 
 #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
@@ -132,6 +141,8 @@ static const MemMapEntry sbsa_ref_memmap[] = {
     /* Space here reserved for more SMMUs */
     [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
     [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
+    /* 1M CXL Host Bridge Registers space (64KiB * 16) */
+    [SBSA_CXL_HOST] =           { 0x60120000, 0x00100000 },
     /* Space here reserved for other devices */
     [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
     /* 32-bit address PCIE MMIO space */
@@ -631,6 +642,26 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
     }
 }
 
+static void create_pxb_cxl(SBSAMachineState *sms)
+{
+    CXLHost *host;
+    PCIHostState *cxl;
+
+    sms->cxl_devices_state.is_enabled = true;
+
+    DeviceState *qdev;
+    qdev = qdev_new(TYPE_PXB_CXL_DEV);
+    qdev_prop_set_uint32(qdev, "bus_nr", 0xfe);
+
+    PCIDevice *dev = PCI_DEVICE(qdev);
+    pci_realize_and_unref(dev, sms->bus, &error_fatal);
+
+    host = PXB_CXL_DEV(dev)->cxl_host_bridge;
+    cxl = PCI_HOST_BRIDGE(host);
+    sms->cxlbus = cxl->bus;
+    pci_create_simple(sms->cxlbus, -1, "cxl-rp");
+}
+
 static void create_pcie(SBSAMachineState *sms)
 {
     hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
@@ -682,12 +713,25 @@ static void create_pcie(SBSAMachineState *sms)
     }
 
     pci = PCI_HOST_BRIDGE(dev);
+    sms->bus = pci->bus;
+
+    pci_init_nic_devices(sms->bus, mc->default_nic);
 
-    pci_init_nic_devices(pci->bus, mc->default_nic);
+    pci_create_simple(sms->bus, -1, "bochs-display");
 
-    pci_create_simple(pci->bus, -1, "bochs-display");
+    create_smmu(sms, sms->bus);
 
-    create_smmu(sms, pci->bus);
+    create_pxb_cxl(sms);
+}
+
+static void create_cxl_host_reg_region(SBSAMachineState *sms)
+{
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *mr = &sms->cxl_devices_state.host_mr;
+
+    memory_region_init(mr, OBJECT(sms), "cxl_host_reg",
+                       sbsa_ref_memmap[SBSA_CXL_HOST].size);
+    memory_region_add_subregion(sysmem, sbsa_ref_memmap[SBSA_CXL_HOST].base, mr);
 }
 
 static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
@@ -823,6 +867,10 @@ static void sbsa_ref_init(MachineState *machine)
 
     create_pcie(sms);
 
+    create_cxl_host_reg_region(sms);
+
+    cxl_hook_up_pxb_registers(sms->bus, &sms->cxl_devices_state, &error_fatal);
+
     create_secure_ec(secure_sysmem);
 
     sms->bootinfo.ram_size = machine->ram_size;
-- 
2.34.1

