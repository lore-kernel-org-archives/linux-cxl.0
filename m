Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B1341168C
	for <linux-cxl@vger.kernel.org>; Tue, 15 Sep 2026 17:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789494525; cv=none; b=h1yjHSgtH9M8+9YhnttlmcIN56t+0KBP6EmOjdL3NEWB7Z37FIs7nOyEaofssaLIsxaNXxSvHeTmLXKp3vCugWQ1Nn0gO3xNJou0pxFKp6r9gpNXr/s7/zxE5etVE7A/EbJ0dOCW63vut8A9XPMqXkdOU30f6hXkKa6KSdrsjeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789494525; c=relaxed/simple;
	bh=Ue8xiBaU4aUmeFbQyzzdIim4dna+2QVQyJ5QTT9w2iA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q/TZ75WZssRObJIk6JQjXmPzCBWvzDW59570h8Le9Tax5VkgcX2Tz83ZJWYErdTiJptCyuNAKbFVpFW3yfYnPjt67afjvr2doU4hK2v6lz11Nw7WGUcJI4kIp3tHCNNEfNua+ZMWudZsLCxNIwfZYuGFOAaPjJlGuh1tErXXA5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTuZdhMW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTuZdhMW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3F8E1F000FF;
	Tue, 15 Sep 2026 17:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789494523;
	bh=iCjZ2yNGguw/kFBX7DMQal9LkVgh2UHx++IDVyxVlYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LTuZdhMW4kbH/UQVWptd4WnzbZB+r6Qk3d+rZv1HOLmBGZbX+taAjk9G7ePOT0pWi
	 19zlJ59+PRvljVf4MuxK1DdgwPK0V6wM0lFZzbqDcq83I+7oXL4twv0dm5DFUyoWLX
	 1nsrdV274L5+f98lRjtZTxapvNrNV8r4SfLlDToM0h3TC9YtzzbnMs67MX99CNjPHe
	 JY7FNN4jnEiV9TXcAzAtQIumPCUvYAttEvwrQ7zpuVg/BbknhjJlvzsQyIR4ZZLgGn
	 01sno4bFPtwYfjpF+4wx9T5AHV+EIl5rQ6Kisd7lZ7Md9QkShQzB+eVrK1coSt2uoG
	 JV08HhdJD3ZBQ==
Date: Tue, 15 Sep 2026 18:48:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, mst@redhat.com,
 imammedo@redhat.com, sunilvl@ventanamicro.com, pbonzini@redhat.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu@processmission.com,
 anisinha@redhat.com, dave.jiang@intel.com, alison.schofield@intel.com,
 junjie.cao@intel.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v6 1/6] hw/riscv/virt: Add CXL support to the RISC-V
 virt machine
Message-ID: <20260915184838.6011cf41@jic23-hlaptop>
In-Reply-To: <20260907093735.2753-2-cp0613@linux.alibaba.com>
References: <20260907093735.2753-1-cp0613@linux.alibaba.com>
	<20260907093735.2753-2-cp0613@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  7 Sep 2026 17:37:28 +0800
Chen Pei <cp0613@linux.alibaba.com> wrote:

> Enable CXL support on the RISC-V virt machine following the same
> approach used by the ARM virt machine:
> - Add PXB and ACPI_CXL Kconfig selections
> - Add CXLState and PCIBus pointer to RISCVVirtState
> - Register CXL machine properties via cxl_machine_init()
> - Create CXL host register region above the PCIe high MMIO region
> - Call cxl_hook_up_pxb_registers() and cxl_fmws_link_targets() at
>   machine_done time
> - Map Fixed Memory Windows above the CXL host register region
> - Add ACPI0017 device in DSDT and build CEDT table in virt-acpi-build.c
> 
> Reviewed-by: Junjie Cao <junjie.cao@intel.com>
> Tested-by: Junjie Cao <junjie.cao@intel.com>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>

Sorry for delay. LGTM
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  hw/riscv/Kconfig           |  2 ++
>  hw/riscv/virt-acpi-build.c | 20 ++++++++++++++++
>  hw/riscv/virt.c            | 47 ++++++++++++++++++++++++++++++++++----
>  include/hw/riscv/virt.h    |  3 +++
>  4 files changed, 68 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/riscv/Kconfig b/hw/riscv/Kconfig
> index d06ac26648..c2f8c5d2da 100644
> --- a/hw/riscv/Kconfig
> +++ b/hw/riscv/Kconfig
> @@ -66,8 +66,10 @@ config RISCV_VIRT
>      select VIRTIO_MMIO
>      select FW_CFG_DMA
>      select PLATFORM_BUS
> +    select PXB
>      select ACPI
>      select ACPI_PCI
> +    select ACPI_CXL
>  
>  config SHAKTI_C
>      bool
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 8e516ec114..2be8c6d572 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -29,12 +29,16 @@
>  #include "hw/acpi/aml-build.h"
>  #include "hw/acpi/pci.h"
>  #include "hw/acpi/utils.h"
> +#include "hw/acpi/cxl.h"
>  #include "hw/intc/riscv_aclint.h"
>  #include "hw/nvram/fw_cfg_acpi.h"
>  #include "hw/pci-host/gpex.h"
> +#include "hw/pci/pci_bus.h"
>  #include "hw/riscv/virt.h"
>  #include "hw/riscv/numa.h"
>  #include "hw/virtio/virtio-acpi.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>  #include "kvm/kvm_riscv.h"
>  #include "migration/vmstate.h"
>  #include "qapi/error.h"
> @@ -518,6 +522,17 @@ static void build_dsdt(GArray *table_data,
>          acpi_dsdt_add_gpex_host(scope, PCIE_IRQ + s->num_sources * 2);
>      }
>  
> +    if (s->cxl_devices_state.is_enabled) {
> +        Aml *cxl_dev = aml_device("CXLM");
> +        aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")));
> +        Aml *method = aml_method("_STA", 0, AML_NOTSERIALIZED);
> +        aml_append(method, aml_return(aml_int(0x0B)));
> +        aml_append(cxl_dev, method);
> +        build_cxl_dsm_method(cxl_dev);
> +
> +        aml_append(scope, cxl_dev);
> +    }
> +
>      aml_append(dsdt, scope);
>  
>      /* copy AML table into ACPI tables blob and patch header there */
> @@ -925,6 +940,11 @@ static void virt_acpi_build(RISCVVirtState *s, AcpiBuildTables *tables)
>                     s->oem_table_id);
>      }
>  
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_build_cedt(table_offsets, tables_blob, tables->linker,
> +                       s->oem_id, s->oem_table_id, &s->cxl_devices_state);
> +    }
> +
>      if (ms->numa_state->num_nodes > 0) {
>          acpi_add_table(table_offsets, tables_blob);
>          build_srat(tables_blob, tables->linker, s);
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index f3a1cc5ba3..70090ca70a 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -56,6 +56,8 @@
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
>  #include "hw/display/ramfb.h"
> +#include "hw/cxl/cxl.h"
> +#include "hw/cxl/cxl_host.h"
>  #include "hw/acpi/aml-build.h"
>  #include "qapi/qapi-visit-common.h"
>  #include "hw/virtio/virtio-iommu.h"
> @@ -540,6 +542,29 @@ static void create_fdt(RISCVVirtState *s)
>      create_fdt_pmu(s);
>  }
>  
> +static void cxl_host_state_init(RISCVVirtState *s)
> +{
> +    MemoryRegion *sysmem = get_system_memory();
> +    MemoryRegion *mr = &s->cxl_devices_state.host_mr;
> +    hwaddr base;
> +
> +    if (!s->cxl_devices_state.is_enabled) {
> +        return;
> +    }
> +
> +    base = virt_high_pcie_memmap.base + virt_high_pcie_memmap.size;
> +    base = ROUND_UP(base, 64 * KiB);
> +
> +    memory_region_init(mr, OBJECT(s), "cxl_host_reg", 64 * KiB * 16);
> +    memory_region_add_subregion(sysmem, base, mr);
> +
> +    /* Map the Fixed Memory Windows above the CXL host register region. */
> +    base += memory_region_size(mr);
> +    base = ROUND_UP(base, 256 * MiB);
> +    cxl_fmws_set_memmap(base, UINT64_MAX);
> +    cxl_fmws_update_mmio();
> +}
> +
>  static FWCfgState *create_fw_cfg(const MachineState *ms, hwaddr base)
>  {
>      FWCfgState *fw_cfg;
> @@ -625,6 +650,13 @@ static void virt_machine_done(Notifier *notifier, void *data)
>      BlockBackend *pflash_blk0;
>      RISCVBootInfo boot_info;
>  
> +    cxl_hook_up_pxb_registers(s->pci_bus, &s->cxl_devices_state,
> +                              &error_fatal);
> +
> +    if (s->cxl_devices_state.is_enabled) {
> +        cxl_fmws_link_targets(&error_fatal);
> +    }
> +
>      /*
>       * An user provided dtb must include everything, including
>       * dynamic sysbus devices. Our FDT needs to be finalized.
> @@ -716,6 +748,7 @@ static void virt_machine_init(MachineState *machine)
>      MemoryRegion *system_memory = get_system_memory();
>      MemoryRegion *mask_rom = g_new(MemoryRegion, 1);
>      DeviceState *mmio_irqchip, *virtio_irqchip, *pcie_irqchip;
> +    DeviceState *gpex_dev;
>      int i, base_hartid, hart_count;
>      int socket_count = riscv_socket_count(machine);
>  
> @@ -871,6 +904,8 @@ static void virt_machine_init(MachineState *machine)
>              ROUND_UP(virt_high_pcie_memmap.base, virt_high_pcie_memmap.size);
>      }
>  
> +    cxl_host_state_init(s);
> +
>      /* register system main memory (actual RAM) */
>      memory_region_add_subregion(system_memory, s->memmap[VIRT_DRAM].base,
>                                  machine->ram);
> @@ -898,10 +933,12 @@ static void virt_machine_init(MachineState *machine)
>              qdev_get_gpio_in(virtio_irqchip, VIRTIO_IRQ + i));
>      }
>  
> -    riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> -                   &s->memmap[VIRT_PCIE_ECAM], &s->memmap[VIRT_PCIE_MMIO],
> -                   &virt_high_pcie_memmap, &s->memmap[VIRT_PCIE_PIO],
> -                   PCIE_IRQ);
> +    gpex_dev = riscv_gpex_pcie_init(system_memory, pcie_irqchip,
> +                                    &s->memmap[VIRT_PCIE_ECAM],
> +                                    &s->memmap[VIRT_PCIE_MMIO],
> +                                    &virt_high_pcie_memmap,
> +                                    &s->memmap[VIRT_PCIE_PIO], PCIE_IRQ);
> +    s->pci_bus = PCI_HOST_BRIDGE(gpex_dev)->bus;
>  
>      s->platform_bus_dev = riscv_create_platform_bus(mmio_irqchip,
>          &s->memmap[VIRT_PLATFORM_BUS], VIRT_PLATFORM_BUS_IRQ,
> @@ -972,6 +1009,8 @@ static void virt_machine_instance_init(Object *obj)
>      s->acpi = ON_OFF_AUTO_AUTO;
>      s->iommu_sys = ON_OFF_AUTO_AUTO;
>      s->num_sources = VIRT_IRQCHIP_NUM_SOURCES;
> +
> +    cxl_machine_init(obj, &s->cxl_devices_state);
>  }
>  
>  static char *virt_get_aia_guests(Object *obj, Error **errp)
> diff --git a/include/hw/riscv/virt.h b/include/hw/riscv/virt.h
> index e516898f9a..a7b74d10c6 100644
> --- a/include/hw/riscv/virt.h
> +++ b/include/hw/riscv/virt.h
> @@ -24,6 +24,7 @@
>  #include "hw/core/sysbus.h"
>  #include "hw/block/flash.h"
>  #include "hw/intc/riscv_imsic.h"
> +#include "hw/cxl/cxl.h"
>  
>  #define VIRT_CPUS_MAX_BITS             9
>  #define VIRT_CPUS_MAX                  (1 << VIRT_CPUS_MAX_BITS)
> @@ -66,6 +67,8 @@ struct RISCVVirtState {
>      OnOffAuto iommu_sys;
>      uint16_t pci_iommu_bdf;
>      uint16_t num_sources;
> +    CXLState cxl_devices_state;
> +    PCIBus *pci_bus;
>  };
>  
>  enum {

