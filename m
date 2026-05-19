Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18B4DC540;
	Tue, 19 May 2026 12:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779194429; cv=none; b=Mheu0eoWSPk/wtYmM4Kn1lPwf6gvzcM/R89RttMOHclR77qW2K4J8a6PLRCkP145+fAejOODAGjaCecp1oQMzlukIsid29DM4iPj/M60tyoJT85J6FHEdf3XtAbK12QwmTyTxzAnlHr6xQZq3IgG8bK5TsBYjgKb0dSicIhW2kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779194429; c=relaxed/simple;
	bh=C9LJspxe9GlzuGA89k1Z0lPBgQt209jCJ7X50Q61Rbc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SIdpHIHBPLBawCaDcMethnZUqePiOQ9CkwIMhD6W2A4xvxK/iPryNb6NkbV/ZlyELMNtWOO2M6U7N6BwVCgPbOnnTUQXwl+q6C4NyFTb0M0saY+eFBLwQ5dLLUJs3od0be4TeWp28WX3/ru6/Yqfz7j7VmC3DZ3Umm8R9V1P3To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BxvXTuw/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BxvXTuw/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAA02C2BCB8;
	Tue, 19 May 2026 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779194429;
	bh=C9LJspxe9GlzuGA89k1Z0lPBgQt209jCJ7X50Q61Rbc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BxvXTuw/1KacfEuUcxA2ShzLusAlC1/fZN4LJ1syCuxeVT0wCRJBbz1vfN2Oyv8Qm
	 laupkzT3Szae7dDCk2WyAfR1JO6EWUtFWMeCu6GUrtojLGRciixMgNUgEbSGfwKxV5
	 kWo+Ds/+lcbJkp0uff0/b8XlvXvOHzVyKvZY59zvDmFewnPbw2syELpEn9rJbiO6az
	 9NyfExj1eN5h8NyjNtrhIyhPj7SkS+oKDidCjGzwfYzjVarRSqMQteA19hqSZYAntn
	 ihCYDQjsc4vt82dLdQrSWcI1AlRa0A0NQ1dqijbRAs9ZIwuxe+azXu6L1e+ORAFgru
	 5qwgcQBIjyV0w==
Date: Tue, 19 May 2026 13:40:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: <mhonap@nvidia.com>
Cc: <alwilliamson@nvidia.com>, <skolothumtho@nvidia.com>,
 <ankita@nvidia.com>, <mst@redhat.com>, <imammedo@redhat.com>,
 <anisinha@redhat.com>, <eric.auger@redhat.com>, <peter.maydell@linaro.org>,
 <shannon.zhaosl@gmail.com>, <jonathan.cameron@huawei.com>,
 <fan.ni@samsung.com>, <pbonzini@redhat.com>,
 <richard.henderson@linaro.org>, <marcel.apfelbaum@gmail.com>,
 <clg@redhat.com>, <cohuck@redhat.com>, <dan.j.williams@intel.com>,
 <dave.jiang@intel.com>, <alejandro.lucero-palau@amd.com>,
 <vsethi@nvidia.com>, <cjia@nvidia.com>, <targupta@nvidia.com>,
 <zhiw@nvidia.com>, <kjaju@nvidia.com>, <linux-cxl@vger.kernel.org>,
 <kvm@vger.kernel.org>, <qemu-devel@nongnu.org>, <qemu-arm@nongnu.org>
Subject: Re: [RFC 1/9] hw/arm/virt: Add CXL FMWS PA window for device memory
Message-ID: <20260519134014.474a8289@jic23-huawei>
In-Reply-To: <20260427181235.3003865-2-mhonap@nvidia.com>
References: <20260427181235.3003865-1-mhonap@nvidia.com>
	<20260427181235.3003865-2-mhonap@nvidia.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Apr 2026 23:42:27 +0530
<mhonap@nvidia.com> wrote:

> From: Manish Honap <mhonap@nvidia.com>
> 
> CXL VFIO passthrough needs a stable guest physical address range for
> device memory (DPA) that falls inside a CFMWS entry the guest discovers
> from ACPI CEDT. Without a dedicated range in the address map, the HDM
> decoder has nowhere to point.
> 
> Add VIRT_HIGH_CXL_MMIO immediately after the second PCIe MMIO window.
> It gets its own highmem_cxl_mmio flag in VirtMachineState rather than
> sharing highmem_cxl, so the two slots are independently controllable
> even though both are currently tied to CXL bridge presence.

Can we clearly state here what they are.  highmem_cxl is the root
bridge registers. I'm not entirely sure I yet understand what highmem_cxl_mmio

> 
> The base and size flow through GPEXConfig.cxl_mmio to
> acpi_dsdt_add_gpex(), which carves out a QWord memory descriptor in the
> first CXL root bridge's _CRS. The CFMWS window is system-wide, so only
> the first CXL bridge gets the descriptor - subsequent ones would
> produce duplicate resource claims for the same range.

I don't follow. CFMWS are not system wide. They refer to one or more of the
root bridges. I suppose you could argue that the 'or more' bit makes
them kind of system wide. Right now I'm not even sure why they are in
CRS at all as opposed to being obtained from CEDT.

Maybe a spec reference for why a bridge should be claiming these regions?

I'm not understanding yet why we can't use the existing CFMWS support
so please add information on that tot his commit message.


> 
> build_crs() already emits the bridge's own 64-bit ranges into crs.
> The CFMWS window is a separate system-wide range, so only that window
> is appended as a new QWord descriptor; the bridge ranges are not
> re-emitted. A warn_report() fires if the CFMWS window overlaps any
> existing bridge 64-bit range, since that would indicate an address
> layout conflict.
> 
> Signed-off-by: Zhi Wang <zhiw@nvidia.com>
> Signed-off-by: Manish Honap <mhonap@nvidia.com>
> ---
>  hw/arm/virt-acpi-build.c   |  5 +++++
>  hw/arm/virt.c              |  9 +++++++++
>  hw/pci-host/gpex-acpi.c    | 40 ++++++++++++++++++++++++++++++++++++++
>  include/hw/arm/virt.h      |  2 ++
>  include/hw/pci-host/gpex.h |  1 +
>  5 files changed, 57 insertions(+)
> 
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index 591cfc993c..863e0680fb 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -176,6 +176,11 @@ static void acpi_dsdt_add_pci(Aml *scope, const MemMapEntry *memmap,
>          cfg.mmio64 = memmap[VIRT_HIGH_PCIE_MMIO];
>      }
>  
> +    if (vms->highmem_cxl) {
> +        cfg.cxl_mmio.base = memmap[VIRT_HIGH_CXL_MMIO].base;
> +        cfg.cxl_mmio.size = memmap[VIRT_HIGH_CXL_MMIO].size;
> +    }
> +
>      acpi_dsdt_add_gpex(scope, &cfg);
>      QLIST_FOREACH(bus, &vms->bus->child, sibling) {
>          if (pci_bus_is_cxl(bus)) {
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index ec0d8475ca..fa07819401 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -211,6 +211,8 @@ static const MemMapEntry base_memmap[] = {
>  #define DEFAULT_HIGH_PCIE_MMIO_SIZE_GB 512
>  #define DEFAULT_HIGH_PCIE_MMIO_SIZE (DEFAULT_HIGH_PCIE_MMIO_SIZE_GB * GiB)
>  
> +#define DEFAULT_HIGH_CXL_MMIO_SIZE  DEFAULT_HIGH_PCIE_MMIO_SIZE
> +
>  /*
>   * Highmem IO Regions: This memory map is floating, located after the RAM.
>   * Each MemMapEntry base (GPA) will be dynamically computed, depending on the
> @@ -237,6 +239,11 @@ static MemMapEntry extended_memmap[] = {
>      [VIRT_HIGH_PCIE_ECAM] =     { 0x0, 256 * MiB },
>      /* Second PCIe window */
>      [VIRT_HIGH_PCIE_MMIO] =     { 0x0, DEFAULT_HIGH_PCIE_MMIO_SIZE },
> +    /*
> +     * CXL FMWS guest PA window - separate from PCIe MMIO so the two are
> +     * independently sizeable. Same default size for now.
> +     */
> +    [VIRT_HIGH_CXL_MMIO] =      { 0x0, DEFAULT_HIGH_CXL_MMIO_SIZE },
>      /* Any CXL Fixed memory windows come here */

Why not use the infra this comment is talking about?

>  };
>  
> @@ -1724,6 +1731,7 @@ static void create_cxl_host_reg_region(VirtMachineState *vms)
>                         vms->memmap[VIRT_CXL_HOST].size);
>      memory_region_add_subregion(sysmem, vms->memmap[VIRT_CXL_HOST].base, mr);
>      vms->highmem_cxl = true;
> +    vms->highmem_cxl_mmio = true;
>  }
>  
>  static void create_platform_bus(VirtMachineState *vms)
> @@ -1897,6 +1905,7 @@ static inline bool *virt_get_high_memmap_enabled(VirtMachineState *vms,
>          &vms->highmem_cxl,
>          &vms->highmem_ecam,
>          &vms->highmem_mmio,
> +        &vms->highmem_cxl_mmio,
>      };
>  
>      assert(ARRAY_SIZE(extended_memmap) - VIRT_LOWMEMMAP_LAST ==
> diff --git a/hw/pci-host/gpex-acpi.c b/hw/pci-host/gpex-acpi.c
> index d9820f9b41..7de57bbc46 100644
> --- a/hw/pci-host/gpex-acpi.c
> +++ b/hw/pci-host/gpex-acpi.c
> @@ -7,6 +7,7 @@
>  #include "hw/pci/pci_bridge.h"
>  #include "hw/pci/pcie_host.h"
>  #include "hw/acpi/cxl.h"
> +#include "qemu/error-report.h"
>  
>  static void acpi_dsdt_add_pci_route_table(Aml *dev, uint32_t irq,
>                                            Aml *scope, uint8_t bus_num)
> @@ -108,6 +109,7 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>      CrsRangeSet crs_range_set;
>      CrsRangeEntry *entry;
>      int i;
> +    bool first_cxl = true;
>  
>      /* start to construct the tables for pxb */
>      crs_range_set_init(&crs_range_set);
> @@ -161,6 +163,44 @@ void acpi_dsdt_add_gpex(Aml *scope, struct GPEXConfig *cfg)
>               */
>              crs = build_crs(PCI_HOST_BRIDGE(BUS(bus)->parent), &crs_range_set,
>                              cfg->pio.base, 0, 0, 0);
> +            if (is_cxl && first_cxl && cfg->cxl_mmio.size) {
> +                uint64_t cfmws_end = cfg->cxl_mmio.base +
> +                                     cfg->cxl_mmio.size - 1;
> +
> +                /*
> +                 * The CXL Fixed Memory Window (CFMWS) is a system-wide GPA
> +                 * range.  Only the first CXL root bridge emits the QWord
> +                 * descriptor; adding it to every bridge would give the OS
> +                 * duplicate resource claims for the same range.
> +                 *
> +                 * build_crs() has already appended the bridge's own 64-bit
> +                 * ranges into crs.  Do not copy them again here; only append
> +                 * the CFMWS window itself as a new QWord descriptor.
> +                 *
> +                 * Warn if the CFMWS window overlaps any range already claimed
> +                 * by the bridge; in the current address layout they should be
> +                 * disjoint, but catch it early if the layout ever changes.
> +                 */
> +                for (i = 0; i < crs_range_set.mem_64bit_ranges->len; i++) {
> +                    entry = g_ptr_array_index(crs_range_set.mem_64bit_ranges,
> +                                              i);
> +                    if (entry->base <= cfmws_end &&
> +                        entry->limit >= cfg->cxl_mmio.base) {
> +                        warn_report("CXL CFMWS [0x%"PRIx64"-0x%"PRIx64"] "
> +                                    "overlaps CXL root bridge 64-bit range "
> +                                    "[0x%"PRIx64"-0x%"PRIx64"]",
> +                                    cfg->cxl_mmio.base, cfmws_end,
> +                                    entry->base, entry->limit);
> +                    }
> +                }
> +                aml_append(crs,
> +                    aml_qword_memory(AML_POS_DECODE, AML_MIN_FIXED,
> +                        AML_MAX_FIXED, AML_NON_CACHEABLE, AML_READ_WRITE,
> +                        0x0000, cfg->cxl_mmio.base, cfmws_end, 0x0000,
> +                        cfg->cxl_mmio.size));
> +                first_cxl = false;
> +            }
> +
>              aml_append(dev, aml_name_decl("_CRS", crs));
>  
>              if (is_cxl) {
> diff --git a/include/hw/arm/virt.h b/include/hw/arm/virt.h
> index 5fcbd1c76f..88bb3c0bdf 100644
> --- a/include/hw/arm/virt.h
> +++ b/include/hw/arm/virt.h
> @@ -91,6 +91,7 @@ enum {
>      VIRT_CXL_HOST,
>      VIRT_HIGH_PCIE_ECAM,
>      VIRT_HIGH_PCIE_MMIO,
> +    VIRT_HIGH_CXL_MMIO,
>  };
>  
>  typedef enum VirtIOMMUType {
> @@ -147,6 +148,7 @@ struct VirtMachineState {
>      bool highmem;
>      bool highmem_compact;
>      bool highmem_cxl;
> +    bool highmem_cxl_mmio;  /* VIRT_HIGH_CXL_MMIO window; follows highmem_cxl */
>      bool highmem_ecam;
>      bool highmem_mmio;
>      bool highmem_redists;
> diff --git a/include/hw/pci-host/gpex.h b/include/hw/pci-host/gpex.h
> index 1da9c85bce..a7c2e2edf3 100644
> --- a/include/hw/pci-host/gpex.h
> +++ b/include/hw/pci-host/gpex.h
> @@ -43,6 +43,7 @@ struct GPEXConfig {
>      MemMapEntry mmio32;
>      MemMapEntry mmio64;
>      MemMapEntry pio;
> +    MemMapEntry cxl_mmio;
>      int         irq;
>      PCIBus      *bus;
>      bool        pci_native_hotplug;

