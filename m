Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAD2381AF
	for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 09:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785143186; cv=none; b=JD+khS8rrkItakOz6pmjT74Tko6M0LCAukMMddo7JJUkn2OppT/PLaMuZl/wyCZ+PDCCLVjykguFtLsBMHtFABgJHW5ARQX7kRnjopNKVMtM/rY25840M15TwGJDiQ3ABT7Rn6yP7d+2k9Y/NfrhmMxuibV7AJ+vNUJ6E612Mkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785143186; c=relaxed/simple;
	bh=XRxPRqvh6xGZ1roOj30kRgPLcnZg87ruW1jsDuzR2F8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hpXx+ncVa6Zylx5L1VOrHAPj2N38+0pnZkyp8o2uRIIYQWgZUhzby1ty1StDzSeWzUA2Z913h7GFzNE1jB2yv5iaGAlx9egxJ6VoYK9xJ3pkVTvFgisYJQoarfymVckBvuhTpPmEK9sFBnxuwTTn35Kci3Ilc1SPcl27XilyN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YGqKe9Sp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YGqKe9Sp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785143183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6juDJB9SuJ8viw5hTV/fyWyN9im+TVrsr9lb3ZKqVHQ=;
	b=YGqKe9Sp6J2DjL9lGHcEL1XfZqTIeTNEkhRSdFHVUsmW034YPoc6jLc5hAhM/+6uVGdMfV
	EJWAwEkxS+qlUDEAocvn1k3tkC4tGaGr/57sagoFsjtYFNUZ3ejQqoCUmO9fAODVJ8W9kq
	lcnOYyAbofiDmsifQhtlzlS3zZfEIb8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-OR8hByQfO4im01D49d2FvQ-1; Mon, 27 Jul 2026 05:06:22 -0400
X-MC-Unique: OR8hByQfO4im01D49d2FvQ-1
X-Mimecast-MFC-AGG-ID: OR8hByQfO4im01D49d2FvQ_1785143181
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47f9ae25143so2093429f8f.2
        for <linux-cxl@vger.kernel.org>; Mon, 27 Jul 2026 02:06:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785143181; x=1785747981;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FYAQR87+IF7SU2JF8iWU2NworjIcqWl+5FKENXWQeZE=;
        b=FiMKrIKXk7ioMBqJ0UINDEkQwcU1C/tJkpRKk41P+S/Y8XEXPFELrNFaRONECBh7mB
         p0XgWAJt/P4F4MSccPZzF6uElMEbLf2Ohrh9tPsxRSrzmTyUpvk3Mt5Q9PKpZJuFb/G2
         scOQllT6dSNdqZx/GOQ1bL/iaSc3jnNfMJoiIh/iG/1YJ3zwI0Q+DXn+QYtRS8hiDCw+
         UxTEgAHiMbr4WSLU1Y/nEi7jq3KHRa0DsZilqav7lGxGwXEvQVhNg27r2eJMA6bLXuO4
         DJvK3IKsQskWcLGPa9LqgqfWBAGIhQa3GkNfIMEF3dbwX9jvNAQURlAvYbfxtaFXPOFR
         nogw==
X-Forwarded-Encrypted: i=1; AHgh+RoNXVNvDRb2/jhziBpvP20fXGlADu9r4OvSFUvzJNDUUjq9J3fYEK723iDl+E2WufL1BYdDwPkZfLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp3isJLQrRQ4iXufbhRigS/6BuNMx2tTdnXIO65D9Tpp9swwrX
	ZtPVprZHA8h1/3nyu96D2ZV4UTECPP56+Qj7jwcmPU9uj5yEF9AEqG1tNicKwcC0cQ6MpGy2OhS
	Za5xDTUIcvSGUsbgKZgN8OKM45/rQ9WzZ77TbwLRW8J/RN6cG5mRZGtpyuwut5Q==
X-Gm-Gg: AR+sD13YBpQAJ92kTiT3kvyQHtE3FdWkD7eR6SfEmj8m22DtbnvgrRQ4TOKcSDcrTxA
	5S4r7w15d76WKobpgEQp1IHG/7AOUMcVAPMqQSz9NhLpv93FDwA1ibEHglMS+Mhlaa7vitIqxpF
	oXHchcBMfMfOgRTo8ea/V2UIDIKq5o4In5kK3Kw5jVccQTFHK5K0ka3ULAWu7QgA2diXbvPuwz0
	w3aeJMNLCOoGEYb+XbwsGLEmXKFlzbh/iWWFNksUr2ArMdQttaGIaMUUJ4iYq3Mb8N6K/qexOCK
	SgZ00KfG8R2qOue0jA8v9tIh2XLnWDZBJddSVLgVVL4xIg50iTjV97RJmcon
X-Received: by 2002:a05:6000:2681:b0:47d:f01e:83cf with SMTP id ffacd0b85a97d-47f9febea2dmr8819722f8f.58.1785143180729;
        Mon, 27 Jul 2026 02:06:20 -0700 (PDT)
X-Received: by 2002:a05:6000:2681:b0:47d:f01e:83cf with SMTP id ffacd0b85a97d-47f9febea2dmr8819676f8f.58.1785143180237;
        Mon, 27 Jul 2026 02:06:20 -0700 (PDT)
Received: from imammedo ([213.175.37.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85c6dc25sm46202931f8f.33.2026.07.27.02.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 02:06:18 -0700 (PDT)
Date: Mon, 27 Jul 2026 11:06:15 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: jic23@kernel.org, pbonzini@redhat.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, sunilvl@ventanamicro.com, dave.jiang@intel.com,
 alison.schofield@intel.com, mst@redhat.com, guoren@kernel.org,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 3/4] hw/riscv/virt,gpex: Provide 32-bit MMIO window
 for CXL host bridges
Message-ID: <20260727110615.3e523125@imammedo>
In-Reply-To: <20260618093827.3507-4-cp0613@linux.alibaba.com>
References: <20260618093827.3507-1-cp0613@linux.alibaba.com>
	<20260618093827.3507-4-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 29D4DQm11-BKYvce7_GwcqUuM_Xetab3N-avxCNx3Os_1785143181
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 18 Jun 2026 17:38:25 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> CXL component register BAR (BAR0 on CXL Root Port and Type3 device)
> and the CXL device register BAR (BAR2 on Type3 device) are declared
> as 64-bit non-prefetchable memory.  Per the PCI-to-PCI Bridge
> Architecture Specification Rev 1.2 (PCI-SIG, 2003):
>=20
>   - =C2=A73.2.5.8 (Memory Base/Limit): the non-prefetchable window covers
>     only 32-bit addresses (AD[31:20]); the Type 1 header defines no
>     upper-32-bit extension for it.
>   - =C2=A73.2.5.9 (Prefetchable Memory Base/Limit): the bottom 4 bits
>     encode 64-bit support (01h), but this applies exclusively to the
>     *prefetchable* window.
>   - =C2=A73.2.5.10 (Prefetchable Base/Limit Upper 32 Bits): optional
>     registers for AD[63:32] of the prefetchable range only.
>=20
> The architecture therefore allows a 64-bit window only when it is also
> prefetchable; there is no 64-bit non-prefetchable form.  PCIe inherits
> this Type 1 header layout unchanged.  Linux thus places 64-bit
> non-prefetchable BARs in the 32-bit non-prefetchable bridge window,
> which requires the bridge to own enough address space below 4 GiB.
>=20
> On RISC-V virt the 32-bit PCIe MMIO range (1 GiB at 0x40000000) is
> currently consumed entirely by PCI0, so CXL host bridges (ACPI0016)
> have no non-prefetchable window and Linux fails to assign these BARs.
> Marking the BARs prefetchable would work around it, but the CXL
> component registers have read/write side effects and are not
> prefetchable per the PCIe specification.
>=20
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
>=20
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  hw/pci-host/gpex-acpi.c    | 36 +++++++++++++++++++++--
>  hw/riscv/virt.c            | 58 +++++++++++++++++++++++++++++++-------
>  include/hw/pci-host/gpex.h |  1 +
>  3 files changed, 83 insertions(+), 12 deletions(-)
>=20
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index d9820f9b41..d8b943b665 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -158,9 +158,41 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfi=
g *cfg)
>               * Resources defined for PXBs are composed of the following =
parts:
>               * 1. The resources the pci-bridge/pcie-root-port need.
>               * 2. The resources the devices behind pxb need.
> +             *
> +             * For CXL host bridges on platforms where UEFI (driven by
> +             * FDT 'ranges') does not assign PCI resources for the CXL
> +             * root bridge before ACPI table construction, build_crs()

I kind of dislike (basically riscv specific hack) in generic code.
well, correct way to tackle this is
 1: fix UEFI to perform required initialization.

> +             * would return an empty resource set.  When the platform
> +             * has reserved a dedicated MMIO window for CXL host bridges
> +             * (cfg->cxl_mmio32), emit that window as a static _CRS
> +             * instead.  The platform is responsible for shrinking PCI0'=
s
> +             * mmio32 window so the two do not overlap.

if you have to put a hack into QEMU, make it work with current build_crs()
and localize 'proper simulated initialization' in riscv codebase
(i.e. do not spread it to common codebase). But before doing it see (#1 not=
e).

>               */
> -            crs =3D build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_ra=
nge_set,
> -                            cfg->pio.base, 0, 0, 0);
> +            if (is_cxl && cfg->cxl_mmio32.size) {
> +                uint64_t cxl_base =3D cfg->cxl_mmio32.base;
> +                uint64_t cxl_size =3D cfg->cxl_mmio32.size;
> +
> +                crs =3D aml_resource_template();
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
> +                crs =3D build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent),
> +                                &crs_range_set, cfg->pio.base, 0, 0, 0);
> +            }
>              aml_append(dev, aml_name_decl("_CRS", crs));
> =20
>              if (is_cxl) {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 84b91b4322..9c1a001553 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -113,6 +113,9 @@ static const MemMapEntry virt_memmap[] =3D {
>  /* PCIe high mmio for RV64, size is fixed but base depends on top of RAM=
 */
>  #define VIRT64_HIGH_PCIE_MMIO_SIZE  (16 * GiB)
> =20
> +/* 32-bit MMIO range carved out of VIRT_PCIE_MMIO for CXL host bridges *=
/
> +#define VIRT_CXL_MMIO32_SIZE        (256 * MiB)
> +
>  static MemMapEntry virt_high_pcie_memmap;
> =20
>  #define VIRT_FLASH_SECTOR_SIZE (256 * KiB)
> @@ -890,15 +893,28 @@ static void create_fdt_pcie(RISCVVirtState *s,
>      }
>      qemu_fdt_setprop_sized_cells(ms->fdt, name, "reg", 2,
>          s->memmap[VIRT_PCIE_ECAM].base, 2, s->memmap[VIRT_PCIE_ECAM].siz=
e);
> -    qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> -        1, FDT_PCI_RANGE_IOPORT, 2, 0,
> -        2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO].si=
ze,
> -        1, FDT_PCI_RANGE_MMIO,
> -        2, s->memmap[VIRT_PCIE_MMIO].base,
> -        2, s->memmap[VIRT_PCIE_MMIO].base, 2, s->memmap[VIRT_PCIE_MMIO].=
size,
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
> +        hwaddr mmio32_size =3D s->memmap[VIRT_PCIE_MMIO].size;
> +        if (s->cxl_devices_state.is_enabled) {
> +            mmio32_size -=3D VIRT_CXL_MMIO32_SIZE;
> +        }
> +        qemu_fdt_setprop_sized_cells(ms->fdt, name, "ranges",
> +            1, FDT_PCI_RANGE_IOPORT, 2, 0,
> +            2, s->memmap[VIRT_PCIE_PIO].base, 2, s->memmap[VIRT_PCIE_PIO=
].size,
> +            1, FDT_PCI_RANGE_MMIO,
> +            2, s->memmap[VIRT_PCIE_MMIO].base,
> +            2, s->memmap[VIRT_PCIE_MMIO].base, 2, mmio32_size,
> +            1, FDT_PCI_RANGE_MMIO_64BIT,
> +            2, virt_high_pcie_memmap.base,
> +            2, virt_high_pcie_memmap.base, 2, virt_high_pcie_memmap.size=
);
> +    }
> =20
>      if (virt_is_iommu_sys_enabled(s)) {
>          qemu_fdt_setprop_cells(ms->fdt, name, "iommu-map",
> @@ -1728,7 +1744,29 @@ static void virt_machine_init(MachineState *machin=
e)
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
> =20
> -    gpex_pcie_init(system_memory, pcie_irqchip, s);
> +    DeviceState *pcie_dev =3D gpex_pcie_init(system_memory, pcie_irqchip=
, s);
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
> +        GPEXHost *gpex =3D GPEX_HOST(pcie_dev);
> +        gpex->gpex_cfg.cxl_mmio32.size =3D VIRT_CXL_MMIO32_SIZE;
> +        gpex->gpex_cfg.cxl_mmio32.base =3D
> +            s->memmap[VIRT_PCIE_MMIO].base +
> +            s->memmap[VIRT_PCIE_MMIO].size - VIRT_CXL_MMIO32_SIZE;
> +        /* Shrink PCI0's advertised 32-bit MMIO window to exclude CXL ra=
nge */
> +        gpex->gpex_cfg.mmio32.size -=3D VIRT_CXL_MMIO32_SIZE;
> +    }
> =20
>      create_platform_bus(s, mmio_irqchip);
> =20
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

