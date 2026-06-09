Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95372407CDC
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jun 2026 12:56:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781009783; cv=none; b=QH83TDQQsT2bkUs/5cZBPcdkGAskHjhj+IRl+ZmA8/BynCaYnwIr89rSOOc0i50pxsyQLJD12csfCJLrfu2CL60w2nT0zXTY232TA973Q/V8qNzNqwVoFRvkxlaMU6uyIRRMzNmYQg5U0HxEXLC1icZUKw/mrnm+s/daR+9BJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781009783; c=relaxed/simple;
	bh=a0fYeHPHFszioDC8aBCpCkCuhyDpGoy4BeuEzMuawCk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LLTg4Gq+aYvaa95xxPDq0ruFrCvs6VmUjhAQ/38LMb1VuX6WzldwfKIPUi6SjPjCzQq7ilQ/XH9V1tCWvCYeEUr+QVwUpJ9zTrIwyWWHty5ZrYBUhVK3fGSOUpAvnTFMTvZeCEbgDgaa4vFJ/oZuqn6gl6Df8raEtteNAL0mhTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csa70ec6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csa70ec6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 828AE1F00893;
	Tue,  9 Jun 2026 12:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781009782;
	bh=eebyKTXI7M7ZomeyrwHDB0fKiasWrvtdjHN2irhwtOg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=csa70ec6lrv9FgNKutBC9O9UUWyj5zaWcH1hxDbgbN7PzJg3Y2joJr9TVJnY26cbL
	 6o1+OHTrEmLLMRQNCPpwS7Q5OkgfjVUgiqiVzzZbxPQfW33EhiGC/P2VizX74hJEtk
	 8bkMoUKX/m9q8pVqSdsT45iUjyXpA/J0nJLO/17/9vzAKRRs07rMeTcLkAF35yx7MO
	 I/CFmTQjrCM4Ivfz59kxjDho3kFj2aXsgeKDnlNMVgzoVbiInEp26qze9sy30PiWCt
	 wwJ8+3AkYBeaHdQYTNum4vW2H55iL5oI0/0xiXKBpx+GkYcTYV2vM6xqFf8HGzx8Wj
	 z9UI7WN+rE4WQ==
Date: Tue, 9 Jun 2026 13:56:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com, fan.ni@samsung.com,
 guoren@kernel.org, qemu-riscv@nongnu.org, qemu-devel@nongnu.org,
 linux-cxl@vger.kernel.org, Dave Jiang <dave.jiang@intel.com>, "Michael S.
 Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH 3/4] hw/riscv/virt, gpex: Provide 32-bit MMIO window for
 CXL host bridges
Message-ID: <20260609135611.307122c8@jic23-huawei>
In-Reply-To: <20260602074127.63819-4-cp0613@linux.alibaba.com>
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
	<20260602074127.63819-4-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  2 Jun 2026 15:41:26 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> CXL component register BAR (BAR0 on CXL Root Port and Type3 device)
> and the CXL device register BAR (BAR2 on Type3 device) are declared
> as 64-bit non-prefetchable memory.  A standard PCIe-to-PCI bridge
> exposes a 32-bit non-prefetchable memory window plus an (optional)
> 64-bit prefetchable memory window, but no 64-bit non-prefetchable
> window.

When you say 'standard' do you mean that is all the PCI spec allows
for? (Right now I'm not working for a SIG member so don't have a copy
to check)

>  Linux therefore places 64-bit non-prefetchable BARs in the
> 32-bit non-prefetchable bridge window, which requires the bridge to
> own enough address space below 4 GiB.
> 

This sounds a bit like the issue that Dave Jiang reported with recent
EDK2 on x86 (fedora upgraded).  We don't see it with the older EDK2
that ships with QEMU. I haven't yet figured out exactly why.
Arguably whatever they changed is a regression but we don't have good
enough testing in place to have detected it early enough.

I'd like some input from PCI / ACPI experts on this. +CC Michael and
Igor.

Like the previous patch we'd definitely want some testing around this
to make sure it doesn't accidentally get broken in future.


> On RISC-V virt the 32-bit PCIe MMIO range (1 GiB at 0x40000000) is
> currently consumed entirely by PCI0, so CXL host bridges (ACPI0016)
> have no non-prefetchable window and Linux fails to assign these BARs.
> Marking the BARs prefetchable would work around it, but the CXL
> component registers have read/write side effects and are not
> prefetchable per the PCIe specification.
> 
> Reserve the top 256 MiB of the 32-bit MMIO window exclusively for
> CXL host bridges:
> - Shrink PCI0's mmio32 window by 256 MiB in virt.c so that UEFI's
>   PciHostBridgeDxe and the ACPI _CRS for PCI0 never claim that range
> - Store the reserved range in a new gpex_cfg.cxl_mmio32 field
> - In gpex-acpi.c, emit the cxl_mmio32 range as the Memory resource
>   in the CXL host bridge _CRS instead of re-using build_crs() (which
>   returns an empty set when UEFI has not assigned resources yet)
> - Reduce the FDT 'ranges' for PCI0 by the same 256 MiB so that UEFI
>   firmware driven by device-tree also respects the reservation
> 
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  hw/pci-host/gpex-acpi.c    | 36 +++++++++++++++++++++--
>  hw/riscv/virt.c            | 58 +++++++++++++++++++++++++++++++-------
>  include/hw/pci-host/gpex.h |  1 +
>  3 files changed, 83 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index d9820f9b41..d8b943b665 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -158,9 +158,41 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>               * Resources defined for PXBs are composed of the following parts:
>               * 1. The resources the pci-bridge/pcie-root-port need.
>               * 2. The resources the devices behind pxb need.
> +             *
> +             * For CXL host bridges on platforms where UEFI (driven by
> +             * FDT 'ranges') does not assign PCI resources for the CXL
> +             * root bridge before ACPI table construction, build_crs()
> +             * would return an empty resource set.  When the platform
> +             * has reserved a dedicated MMIO window for CXL host bridges
> +             * (cfg->cxl_mmio32), emit that window as a static _CRS
> +             * instead.  The platform is responsible for shrinking PCI0's
> +             * mmio32 window so the two do not overlap.
>               */
> -            crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set,
> -                            cfg->pio.base, 0, 0, 0);
> +            if (is_cxl && cfg->cxl_mmio32.size) {
> +                uint64_t cxl_base = cfg->cxl_mmio32.base;
> +                uint64_t cxl_size = cfg->cxl_mmio32.size;
> +
> +                crs = aml_resource_template();
> +
> +                /* 32-bit MMIO range for CXL devices */
> +                aml_append(crs,
> +                    aml_dword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                                     AML_MAX_FIXED, AML_NON_CACHEABLE,
> +                                     AML_READ_WRITE, 0,
> +                                     cxl_base,
> +                                     cxl_base + cxl_size - 1,
> +                                     0, cxl_size));
> +
> +                /* Bus number range */
> +                aml_append(crs,
> +                    aml_word_bus_number(AML_MIN_FIXED, AML_MAX_FIXED,
> +                                       AML_POS_DECODE, 0,
> +                                       bus_num, bus_num + 15,
> +                                       0, 16));
> +            } else {
> +                crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent),
> +                                &crs_range_set, cfg->pio.base, 0, 0, 0);
> +            }
>              aml_append(dev, aml_name_decl("_CRS", crs));
>  
>              if (is_cxl) {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 899f632de7..929c01fb26 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -113,6 +113,9 @@ static const MemMapEntry virt_memmap[] = {
>  /* PCIe high mmio for RV64, size is fixed but base depends on top of RAM */
>  #define VIRT64_HIGH_PCIE_MMIO_SIZE  (16 * GiB)
>  
> +/* 32-bit MMIO range carved out of VIRT_PCIE_MMIO for CXL host bridges */
> +#define VIRT_CXL_MMIO32_SIZE        (256 * MiB)
> +
>  static MemMapEntry virt_high_pcie_memmap;
>  
>  #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> @@ -890,15 +893,28 @@ static void create_fdt_pcie(RISCVVirtState *s,
>      }
>      qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
>          s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].size);
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> -        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> -        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
> -        1, FDT_PCI_RANGE_MMIO,
> -        2, s->memmap[VIRT_PCIE_MMIO].base,
> -        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].size,
> -        1, FDT_PCI_RANGE_MMIO_64BIT,
> -        2, virt_high_pcie_memmap.base,
> -        2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
> +    {
> +        /*
> +         * When CXL is enabled, reserve the last 256 MiB of the 32-bit
> +         * MMIO window for CXL host bridges and exclude it from the main
> +         * PCIe host bridge's FDT 'ranges' so UEFI's PciHostBridgeDxe
> +         * does not allocate that range to PCI0.  The CXL host bridge
> +         * _CRS declares this range independently.
> +         */
> +        hwaddr mmio32_size = s->memmap[VIRT_PCIE_MMIO].size;
> +        if (s->cxl_devices_state.is_enabled) {
> +            mmio32_size -= VIRT_CXL_MMIO32_SIZE;
> +        }
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> +            1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +            2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].size,
> +            1, FDT_PCI_RANGE_MMIO,
> +            2, s->memmap[VIRT_PCIE_MMIO].base,
> +            2, s->memmap[VIRT_PCIE_MMIO].base, 2, mmio32_size,
> +            1, FDT_PCI_RANGE_MMIO_64BIT,
> +            2, virt_high_pcie_memmap.base,
> +            2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size);
> +    }
>  
>      if (virt_is_iommu_sys_enabled(s)) {
>          qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> @@ -1730,7 +1746,29 @@ static void virt_machine_init(MachineState *machine)
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
>  
> -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +    DeviceState *pcie_dev = gpex_pcie_init(system_memory, pcie_irqchip, s);
> +
> +    /*
> +     * If CXL is enabled, reserve the last 256 MiB of the 32-bit MMIO
> +     * window for CXL host bridges so the bridge non-prefetchable window
> +     * can hold CXL device BARs (component registers and similar 64-bit
> +     * non-prefetchable BARs that need a < 4 GiB address).
> +     *
> +     * - Shrink PCI0's mmio32 advertised in the ACPI _CRS by the same
> +     *   256 MiB so the two ranges do not overlap (the FDT 'ranges'
> +     *   shrink happens in create_fdt_pcie()).
> +     * - Store the reserved range in cxl_mmio32 so gpex-acpi.c can emit
> +     *   a correct _CRS for the CXL host bridge (ACPI0016).
> +     */
> +    if (s->cxl_devices_state.is_enabled) {
> +        GPEXHost *gpex = GPEX_HOST(pcie_dev);
> +        gpex->gpex_cfg.cxl_mmio32.size = VIRT_CXL_MMIO32_SIZE;
> +        gpex->gpex_cfg.cxl_mmio32.base =
> +            s->memmap[VIRT_PCIE_MMIO].base +
> +            s->memmap[VIRT_PCIE_MMIO].size - VIRT_CXL_MMIO32_SIZE;
> +        /* Shrink PCI0's advertised 32-bit MMIO window to exclude CXL range */
> +        gpex->gpex_cfg.mmio32.size -= VIRT_CXL_MMIO32_SIZE;
> +    }
>  
>      create_platform_bus(s, mmio_irqchip);
>  
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 1da9c85bce..d38fbbacd6 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -43,6 +43,7 @@ struct GPEXConfig {
>      MemMapEntry mmio32;
>      MemMapEntry mmio64;
>      MemMapEntry pio;
> +    MemMapEntry cxl_mmio32;
>      int         irq;
>      PCIBus      *bus;
>      bool        pci_native_hotplug;

