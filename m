Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 827CD20EA26
	for <linux-cxl@vger.kernel.org>; Thu,  7 Nov 2024 12:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730981109; cv=none; b=dhhsKXIADjz7bL8tkA1iTVcVKO2VY5hNShPoqvrboRLutjMw7dIqOkYHPFwNWwE0SXLd+ZTTCqxehAik4H+xwLFFBDOGsq1ngWKKAxstCCBI6Cw2EZfnruE2LLAonB4W87M9DZHMl8h/UHI3U28rlzgf4YDqC+sXzpH4S7yUESk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730981109; c=relaxed/simple;
	bh=Udt7FqX7F8tRjSMk9WkZq5z8nSFQUBplSCxJBjVdqPM=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bBoSMbAHNNSiN25Y2MiRvB9A1XfSA4X9mC+v11FOxxfWVcnHMVJreWELqCcmylKwdZjHRxjX/2lOezWua+cIUjfZZrVDaDalOQHqSNTG+ndEiobH98SblOsl1HDsiP/mGsvS/+laIjjl0JIFRcUFINXFHcfnuEaiZNRgAhFZ/fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Xkgk43q4hz6LD90;
	Thu,  7 Nov 2024 20:05:00 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 6FC4B140CB9;
	Thu,  7 Nov 2024 20:05:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 7 Nov
 2024 13:04:58 +0100
Date: Thu, 7 Nov 2024 12:04:57 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>
CC: <devel@edk2.groups.io>, <marcin.juszkiewicz@linaro.org>,
	<ardb+tianocore@kernel.org>, <quic_llindhol@quicinc.com>,
	<peter.maydell@linaro.org>, <chenbaozi@phytium.com.cn>,
	<linux-cxl@vger.kernel.org>, <asa-dev@op-lists.linaro.org>,
	<qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [edk2-devel] [RFC PATCH v2 1/1] hw/arm/sbsa-ref: Support CXL
 Host Bridge & CFMW
Message-ID: <20241107120457.00006024@Huawei.com>
In-Reply-To: <20241105104346.417102-2-wangyuquan1236@phytium.com.cn>
References: <20241105104346.417102-1-wangyuquan1236@phytium.com.cn>
	<20241105104346.417102-2-wangyuquan1236@phytium.com.cn>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  5 Nov 2024 18:43:46 +0800
"Yuquan Wang" <wangyuquan1236@phytium.com.cn> wrote:

> This creates a default pxb-cxl (bus_nr=0xc0) bridge with two
> cxl root ports on sbsa-ref. And the memory layout places 64K
> space for the cxl host bridge register regions(CHBCR) in the
> sbsa-ref memmap.
> 
> In addition, this support indepentent mmio32(32M) & mmio64(1M)
> space for cxl components.

Those are too small.  Might work today but not sustainable.

I'm a bit surprised it was this simple to move the MMIO Space away
from what is normally done for PXBs.
I think it might work because the GPEX memory windows are effectively
unlimited in size but I'd like some more eyes on this from people
familiar with how all that works and whether there might be some
corner cases that you haven't seen yet.

Otherwise this looks ok to me.

> 
> To provide CFMWs on sbsa-ref, this extends 1TB space from the
> hole above RAM Memory [SBSA_MEM] for CXL Fixed Memory Window.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  docs/system/arm/sbsa.rst  |   4 ++
>  hw/arm/sbsa-ref.c         | 122 +++++++++++++++++++++++++++++++++++++-
>  hw/cxl/cxl-host-stubs.c   |   2 +
>  hw/cxl/cxl-host.c         |   2 +-
>  include/hw/cxl/cxl_host.h |   2 +
>  5 files changed, 130 insertions(+), 2 deletions(-)
> 
> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
> index 2bf3fc8d59..21b88e88e7 100644
> --- a/docs/system/arm/sbsa.rst
> +++ b/docs/system/arm/sbsa.rst
> @@ -28,6 +28,7 @@ The ``sbsa-ref`` board supports:
>    - E1000E ethernet card on PCIe bus
>    - Bochs display adapter on PCIe bus
>    - A generic SBSA watchdog device
> +  - CXL host bridge and CXL fixed memory window
>  
>  
>  Board to firmware interface
> @@ -92,3 +93,6 @@ Platform version changes:
>  
>  0.4
>    CPU topology information is present in devicetree.
> +
> +0.5
> +  CXL host bridge and CXL fixed memory window are supported.
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index e3195d5449..655dc82863 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -36,12 +36,18 @@
>  #include "hw/arm/smmuv3.h"
>  #include "hw/block/flash.h"
>  #include "hw/boards.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>  #include "hw/ide/ide-bus.h"
>  #include "hw/ide/ahci-sysbus.h"
>  #include "hw/intc/arm_gicv3_common.h"
>  #include "hw/intc/arm_gicv3_its_common.h"
>  #include "hw/loader.h"
> +#include "hw/pci/pci_bridge.h"
> +#include "hw/pci/pci_bus.h"
> +#include "hw/pci/pcie_port.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/pci-bridge/pci_expander_bridge.h"
>  #include "hw/qdev-properties.h"
>  #include "hw/usb.h"
>  #include "hw/usb/xhci.h"
> @@ -94,6 +100,10 @@ enum {
>      SBSA_SECURE_MEM,
>      SBSA_AHCI,
>      SBSA_XHCI,
> +    SBSA_CXL_HOST,
> +    SBSA_CXL_MMIO,
> +    SBSA_CXL_MMIO_HIGH,
> +    SBSA_CXL_FIXED_WINDOW,
>  };
>  
>  struct SBSAMachineState {
> @@ -105,6 +115,8 @@ struct SBSAMachineState {
>      int psci_conduit;
>      DeviceState *gic;
>      PFlashCFI01 *flash[2];
> +    CXLState cxl_devices_state;
> +    PCIBus *cxlbus;
>  };
>  
>  #define TYPE_SBSA_MACHINE   MACHINE_TYPE_NAME("sbsa-ref")
> @@ -132,6 +144,10 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      /* Space here reserved for more SMMUs */
>      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
>      [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
> +    /* 64KiB CXL Host Bridge Registers space */
> +    [SBSA_CXL_HOST] =           { 0x60120000, 0x00010000 },

> +    /* 32M CXL 32-bit MMIO space */
> +    [SBSA_CXL_MMIO] =           { 0x60130000, 0x02000000 },
>      /* Space here reserved for other devices */
>      [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
>      /* 32-bit address PCIE MMIO space */
> @@ -141,6 +157,10 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      /* ~1TB PCIE MMIO space (4GB to 1024GB boundary) */
>      [SBSA_PCIE_MMIO_HIGH] =     { 0x100000000ULL, 0xFF00000000ULL },
>      [SBSA_MEM] =                { 0x10000000000ULL, RAMLIMIT_BYTES },
> +    /* 1M CXL 64-bit MMIO space */
> +    [SBSA_CXL_MMIO_HIGH] =           { 0x90000000000ULL, 0x00100000 },

As above, make this bigger.  CXL devices can have substantial BARs.

> +    /* 1TB CXL FIXED WINDOW space */
> +    [SBSA_CXL_FIXED_WINDOW] =   { 0xA0000000000ULL, 0x10000000000ULL },
>  };
>  
>  static const int sbsa_ref_irqmap[] = {
> @@ -216,7 +236,7 @@ static void create_fdt(SBSAMachineState *sms)
>       *                        fw compatibility.
>       */
>      qemu_fdt_setprop_cell(fdt, "/", "machine-version-major", 0);
> -    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 4);
> +    qemu_fdt_setprop_cell(fdt, "/", "machine-version-minor", 5);
>  
>      if (ms->numa_state->have_numa_distance) {
>          int size = nb_numa_nodes * nb_numa_nodes * 3 * sizeof(uint32_t);
> @@ -629,6 +649,35 @@ static void create_smmu(const SBSAMachineState *sms, PCIBus *bus)
>      }
>  }
>  
> +static void create_pxb_cxl(SBSAMachineState *sms, PCIBus *bus)
> +{
> +    DeviceState *qdev = qdev_new(TYPE_PXB_CXL_DEV);
> +    PCIDevice *dev = PCI_DEVICE(qdev);
> +    CXLHost *host;
> +    PCIHostState *cxl;
> +    PCIDevice *cxlrp;
> +    PCIEPort *p;
> +    PCIESlot *s;
> +    int i;
> +
> +    sms->cxl_devices_state.is_enabled = true;
> +    qdev_prop_set_uint32(qdev, "bus_nr", 0xc0);
> +    pci_realize_and_unref(dev, bus, &error_fatal);
> +
> +    host = PXB_CXL_DEV(dev)->cxl_host_bridge;
> +    cxl = PCI_HOST_BRIDGE(host);
> +    sms->cxlbus = cxl->bus;
> +
> +    for (i = 0; i < 2; i++) {
> +        cxlrp = pci_new(-1, "cxl-rp");
> +        p = PCIE_PORT(cxlrp);
> +        s = PCIE_SLOT(cxlrp);
> +        p->port = i;
> +        s->slot = i;
> +        pci_realize_and_unref(cxlrp, sms->cxlbus, &error_fatal);
> +    }
> +}
> +
>  static void create_pcie(SBSAMachineState *sms)
>  {
>      hwaddr base_ecam = sbsa_ref_memmap[SBSA_PCIE_ECAM].base;
> @@ -638,6 +687,10 @@ static void create_pcie(SBSAMachineState *sms)
>      hwaddr base_mmio_high = sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].base;
>      hwaddr size_mmio_high = sbsa_ref_memmap[SBSA_PCIE_MMIO_HIGH].size;
>      hwaddr base_pio = sbsa_ref_memmap[SBSA_PCIE_PIO].base;
> +    hwaddr cxl_base_mmio = sbsa_ref_memmap[SBSA_CXL_MMIO].base;
> +    hwaddr cxl_size_mmio = sbsa_ref_memmap[SBSA_CXL_MMIO].size;
> +    hwaddr cxl_base_mmio_high = sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].base;
> +    hwaddr cxl_size_mmio_high = sbsa_ref_memmap[SBSA_CXL_MMIO_HIGH].size;
>      int irq = sbsa_ref_irqmap[SBSA_PCIE];
>      MachineClass *mc = MACHINE_GET_CLASS(sms);
>      MemoryRegion *mmio_alias, *mmio_alias_high, *mmio_reg;
> @@ -686,6 +739,67 @@ static void create_pcie(SBSAMachineState *sms)
>      pci_create_simple(pci->bus, -1, "bochs-display");
>  
>      create_smmu(sms, pci->bus);
> +
> +    /* Map CXL MMIO space */
> +    mmio_alias = g_new0(MemoryRegion, 1);
> +    mmio_reg = sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 1);
> +    memory_region_init_alias(mmio_alias, OBJECT(dev), "cxl-mmio",
> +                             mmio_reg, cxl_base_mmio, cxl_size_mmio);
> +    memory_region_add_subregion(get_system_memory(), cxl_base_mmio, mmio_alias);
> +
> +    /* Map CXL MMIO_HIGH space */
> +    mmio_alias_high = g_new0(MemoryRegion, 1);
> +    memory_region_init_alias(mmio_alias_high, OBJECT(dev), "cxl-mmio-high",
> +                             mmio_reg, cxl_base_mmio_high, cxl_size_mmio_high);
> +    memory_region_add_subregion(get_system_memory(), cxl_base_mmio_high,
> +                                mmio_alias_high);
> +
> +    create_pxb_cxl(sms, pci->bus);
> +}

>  
>  static void *sbsa_ref_dtb(const struct arm_boot_info *binfo, int *fdt_size)
> @@ -821,6 +935,12 @@ static void sbsa_ref_init(MachineState *machine)
>  
>      create_pcie(sms);
>  
> +    create_cxl_host_reg_region(sms);
> +    create_cxl_fixed_window_region(sms, sysmem);
> +    pxb_cxl_hook_up_registers(&sms->cxl_devices_state, sms->cxlbus,
> +                              &error_fatal);
> +    sbsa_cxl_fmws_link_targets(sms, &error_fatal);
> +
>      create_secure_ec(secure_sysmem);
>  
>      sms->bootinfo.ram_size = machine->ram_size;
> diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
> index cae4afcdde..aea94933ba 100644
> --- a/hw/cxl/cxl-host-stubs.c
> +++ b/hw/cxl/cxl-host-stubs.c
> @@ -11,5 +11,7 @@
>  void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
>  void cxl_machine_init(Object *obj, CXLState *state) {};
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +                        CXLFixedMemoryWindowOptions *object, Error **errp) {};
>  
>  const MemoryRegionOps cfmws_ops;
> diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
> index e9f2543c43..d408c7db15 100644
> --- a/hw/cxl/cxl-host.c
> +++ b/hw/cxl/cxl-host.c
> @@ -22,7 +22,7 @@
>  #include "hw/pci/pcie_port.h"
>  #include "hw/pci-bridge/pci_expander_bridge.h"
>  
> -static void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
>                                             CXLFixedMemoryWindowOptions *object,
>                                             Error **errp)
>  {
> diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
> index c9bc9c7c50..f3184733aa 100644
> --- a/include/hw/cxl/cxl_host.h
> +++ b/include/hw/cxl/cxl_host.h
> @@ -16,6 +16,8 @@
>  void cxl_machine_init(Object *obj, CXLState *state);
>  void cxl_fmws_link_targets(CXLState *stat, Error **errp);
>  void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp);
> +void cxl_fixed_memory_window_config(CXLState *cxl_state,
> +                        CXLFixedMemoryWindowOptions *object, Error **errp);
>  
>  extern const MemoryRegionOps cfmws_ops;
>  

