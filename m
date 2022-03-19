Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AC2DC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 19 Mar 2022 08:36:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241360AbiCSIha (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 19 Mar 2022 04:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiCSIha (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 19 Mar 2022 04:37:30 -0400
Received: from mail.default.ilande.bv.iomart.io (mail.ilande.co.uk [IPv6:2001:41c9:1:41f::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63912424B4
        for <linux-cxl@vger.kernel.org>; Sat, 19 Mar 2022 01:36:09 -0700 (PDT)
Received: from [2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c]
        by mail.default.ilande.bv.iomart.io with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <mark.cave-ayland@ilande.co.uk>)
        id 1nVUYN-0003gn-Ds; Sat, 19 Mar 2022 08:35:19 +0000
Message-ID: <10cae45f-9f3a-c7a5-c834-ae14a5fcbecf@ilande.co.uk>
Date:   Sat, 19 Mar 2022 08:35:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linuxarm@huawei.com, qemu-devel@nongnu.org,
        =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>
References: <20220318150635.24600-1-Jonathan.Cameron@huawei.com>
 <20220318150635.24600-24-Jonathan.Cameron@huawei.com>
From:   Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20220318150635.24600-24-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v8 23/46] hw/cxl/component: Implement host bridge MMIO
 (8.2.5, table 142)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.bv.iomart.io)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 18/03/2022 15:06, Jonathan Cameron wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> CXL host bridges themselves may have MMIO. Since host bridges don't have
> a BAR they are treated as special for MMIO.  This patch includes
> i386/pc support.
> Also hook up the device reset now that we have have the MMIO
> space in which the results are visible.
> 
> Note that we duplicate the PCI express case for the aml_build but
> the implementations will diverge when the CXL specific _OSC is
> introduced.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Co-developed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   hw/i386/acpi-build.c                | 25 +++++++++++-
>   hw/i386/pc.c                        | 27 ++++++++++++-
>   hw/pci-bridge/pci_expander_bridge.c | 62 ++++++++++++++++++++++++++++-
>   include/hw/cxl/cxl.h                |  4 ++
>   4 files changed, 114 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 4ad4d7286c..0b7d06e107 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -28,6 +28,7 @@
>   #include "qemu/bitmap.h"
>   #include "qemu/error-report.h"
>   #include "hw/pci/pci.h"
> +#include "hw/cxl/cxl.h"
>   #include "hw/core/cpu.h"
>   #include "target/i386/cpu.h"
>   #include "hw/misc/pvpanic.h"
> @@ -1572,10 +1573,21 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               }
>   
>               scope = aml_scope("\\_SB");
> -            dev = aml_device("PC%.02X", bus_num);
> +
> +            if (pci_bus_is_cxl(bus)) {
> +                dev = aml_device("CL%.02X", bus_num);
> +            } else {
> +                dev = aml_device("PC%.02X", bus_num);
> +            }
>               aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)));
>               aml_append(dev, aml_name_decl("_BBN", aml_int(bus_num)));
> -            if (pci_bus_is_express(bus)) {
> +            if (pci_bus_is_cxl(bus)) {
> +                aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
> +                aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
> +
> +                /* Expander bridges do not have ACPI PCI Hot-plug enabled */
> +                aml_append(dev, build_q35_osc_method(true));
> +            } else if (pci_bus_is_express(bus)) {
>                   aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A08")));
>                   aml_append(dev, aml_name_decl("_CID", aml_eisaid("PNP0A03")));
>   
> @@ -1595,6 +1607,15 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>               aml_append(dev, aml_name_decl("_CRS", crs));
>               aml_append(scope, dev);
>               aml_append(dsdt, scope);
> +
> +            /* Handle the ranges for the PXB expanders */
> +            if (pci_bus_is_cxl(bus)) {
> +                MemoryRegion *mr = &machine->cxl_devices_state->host_mr;
> +                uint64_t base = mr->addr;
> +
> +                crs_range_insert(crs_range_set.mem_ranges, base,
> +                                 base + memory_region_size(mr) - 1);
> +            }
>           }
>       }
>   
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index e2849fc741..da74f08f9e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -75,6 +75,7 @@
>   #include "acpi-build.h"
>   #include "hw/mem/pc-dimm.h"
>   #include "hw/mem/nvdimm.h"
> +#include "hw/cxl/cxl.h"
>   #include "qapi/error.h"
>   #include "qapi/qapi-visit-common.h"
>   #include "qapi/qapi-visit-machine.h"
> @@ -813,6 +814,7 @@ void pc_memory_init(PCMachineState *pcms,
>       MachineClass *mc = MACHINE_GET_CLASS(machine);
>       PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
>       X86MachineState *x86ms = X86_MACHINE(pcms);
> +    hwaddr cxl_base;
>   
>       assert(machine->ram_size == x86ms->below_4g_mem_size +
>                                   x86ms->above_4g_mem_size);
> @@ -902,6 +904,26 @@ void pc_memory_init(PCMachineState *pcms,
>                                       &machine->device_memory->mr);
>       }
>   
> +    if (machine->cxl_devices_state->is_enabled) {
> +        MemoryRegion *mr = &machine->cxl_devices_state->host_mr;
> +        hwaddr cxl_size = MiB;
> +
> +        if (pcmc->has_reserved_memory && machine->device_memory->base) {
> +            cxl_base = machine->device_memory->base;
> +            if (!pcmc->broken_reserved_end) {
> +                cxl_base += memory_region_size(&machine->device_memory->mr);
> +            }
> +        } else if (pcms->sgx_epc.size != 0) {
> +            cxl_base = sgx_epc_above_4g_end(&pcms->sgx_epc);
> +        } else {
> +            cxl_base = 0x100000000ULL + x86ms->above_4g_mem_size;
> +        }
> +
> +        e820_add_entry(cxl_base, cxl_size, E820_RESERVED);
> +        memory_region_init(mr, OBJECT(machine), "cxl_host_reg", cxl_size);
> +        memory_region_add_subregion(system_memory, cxl_base, mr);
> +    }
> +
>       /* Initialize PC system firmware */
>       pc_system_firmware_init(pcms, rom_memory);
>   
> @@ -962,7 +984,10 @@ uint64_t pc_pci_hole64_start(void)
>       X86MachineState *x86ms = X86_MACHINE(pcms);
>       uint64_t hole64_start = 0;
>   
> -    if (pcmc->has_reserved_memory && ms->device_memory->base) {
> +    if (ms->cxl_devices_state->host_mr.addr) {
> +        hole64_start = ms->cxl_devices_state->host_mr.addr +
> +            memory_region_size(&ms->cxl_devices_state->host_mr);
> +    } else if (pcmc->has_reserved_memory && ms->device_memory->base) {
>           hole64_start = ms->device_memory->base;
>           if (!pcmc->broken_reserved_end) {
>               hole64_start += memory_region_size(&ms->device_memory->mr);
> diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> index f762eb4a6e..b3b5f93650 100644
> --- a/hw/pci-bridge/pci_expander_bridge.c
> +++ b/hw/pci-bridge/pci_expander_bridge.c
> @@ -75,6 +75,9 @@ struct PXBDev {
>       uint8_t bus_nr;
>       uint16_t numa_node;
>       bool bypass_iommu;
> +    struct cxl_dev {
> +        CXLHost *cxl_host_bridge;
> +    } cxl;
>   };
>   
>   static PXBDev *convert_to_pxb(PCIDevice *dev)
> @@ -92,6 +95,9 @@ static GList *pxb_dev_list;
>   
>   #define TYPE_PXB_HOST "pxb-host"
>   
> +#define TYPE_PXB_CXL_HOST "pxb-cxl-host"
> +#define PXB_CXL_HOST(obj) OBJECT_CHECK(CXLHost, (obj), TYPE_PXB_CXL_HOST)

Again this is a legacy QOM type declaration and should be replaced with 
OBJECT_DECLARE_SIMPLE_TYPE(). It should also be located in the associated header file 
if it exists (include/hw/cxl/cxl.h in this case).

>   static int pxb_bus_num(PCIBus *bus)
>   {
>       PXBDev *pxb = convert_to_pxb(bus->parent_dev);
> @@ -197,6 +203,52 @@ static const TypeInfo pxb_host_info = {
>       .class_init    = pxb_host_class_init,
>   };
>   
> +static void pxb_cxl_realize(DeviceState *dev, Error **errp)
> +{
> +    MachineState *ms = MACHINE(qdev_get_machine());
> +    SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> +    CXLHost *cxl = PXB_CXL_HOST(dev);
> +    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
> +    struct MemoryRegion *mr = &cxl_cstate->crb.component_registers;
> +    hwaddr offset;
> +
> +    cxl_component_register_block_init(OBJECT(dev), cxl_cstate,
> +                                      TYPE_PXB_CXL_HOST);
> +    sysbus_init_mmio(sbd, mr);
> +
> +    offset = memory_region_size(mr) * ms->cxl_devices_state->next_mr_idx;
> +    if (offset > memory_region_size(&ms->cxl_devices_state->host_mr)) {
> +        error_setg(errp, "Insufficient space for pxb cxl host register space");
> +        return;
> +    }
> +
> +    memory_region_add_subregion(&ms->cxl_devices_state->host_mr, offset, mr);
> +    ms->cxl_devices_state->next_mr_idx++;
> +}
> +
> +static void pxb_cxl_host_class_init(ObjectClass *class, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(class);
> +    PCIHostBridgeClass *hc = PCI_HOST_BRIDGE_CLASS(class);
> +
> +    hc->root_bus_path = pxb_host_root_bus_path;
> +    dc->fw_name = "cxl";
> +    dc->realize = pxb_cxl_realize;
> +    /* Reason: Internal part of the pxb/pxb-pcie device, not usable by itself */
> +    dc->user_creatable = false;
> +}
> +
> +/*
> + * This is a device to handle the MMIO for a CXL host bridge. It does nothing
> + * else.
> + */
> +static const TypeInfo cxl_host_info = {
> +    .name          = TYPE_PXB_CXL_HOST,
> +    .parent        = TYPE_PCI_HOST_BRIDGE,
> +    .instance_size = sizeof(CXLHost),
> +    .class_init    = pxb_cxl_host_class_init,
> +};
> +
>   /*
>    * Registers the PXB bus as a child of pci host root bus.
>    */
> @@ -245,6 +297,12 @@ static int pxb_map_irq_fn(PCIDevice *pci_dev, int pin)
>   
>   static void pxb_dev_reset(DeviceState *dev)
>   {
> +    CXLHost *cxl = PXB_CXL_DEV(dev)->cxl.cxl_host_bridge;
> +    CXLComponentState *cxl_cstate = &cxl->cxl_cstate;
> +    uint32_t *reg_state = cxl_cstate->crb.cache_mem_registers;
> +
> +    cxl_component_register_init_common(reg_state, CXL2_ROOT_PORT);
> +    ARRAY_FIELD_DP32(reg_state, CXL_HDM_DECODER_CAPABILITY, TARGET_COUNT, 8);
>   }
>   
>   static gint pxb_compare(gconstpointer a, gconstpointer b)
> @@ -281,12 +339,13 @@ static void pxb_dev_realize_common(PCIDevice *dev, enum BusType type,
>           dev_name = dev->qdev.id;
>       }
>   
> -    ds = qdev_new(TYPE_PXB_HOST);
> +    ds = qdev_new(type == CXL ? TYPE_PXB_CXL_HOST : TYPE_PXB_HOST);
>       if (type == PCIE) {
>           bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_PCIE_BUS);
>       } else if (type == CXL) {
>           bus = pci_root_bus_new(ds, dev_name, NULL, NULL, 0, TYPE_PXB_CXL_BUS);
>           bus->flags |= PCI_BUS_CXL;
> +        PXB_CXL_DEV(dev)->cxl.cxl_host_bridge = PXB_CXL_HOST(ds);
>       } else {
>           bus = pci_root_bus_new(ds, "pxb-internal", NULL, NULL, 0, TYPE_PXB_BUS);
>           bds = qdev_new("pci-bridge");
> @@ -475,6 +534,7 @@ static void pxb_register_types(void)
>       type_register_static(&pxb_pcie_bus_info);
>       type_register_static(&pxb_cxl_bus_info);
>       type_register_static(&pxb_host_info);
> +    type_register_static(&cxl_host_info);
>       type_register_static(&pxb_dev_info);
>       type_register_static(&pxb_pcie_dev_info);
>       type_register_static(&pxb_cxl_dev_info);
> diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
> index 31af92fd5e..75e5bf71e1 100644
> --- a/include/hw/cxl/cxl.h
> +++ b/include/hw/cxl/cxl.h
> @@ -17,8 +17,12 @@
>   #define CXL_COMPONENT_REG_BAR_IDX 0
>   #define CXL_DEVICE_REG_BAR_IDX 2
>   
> +#define CXL_WINDOW_MAX 10
> +
>   typedef struct CXLState {
>       bool is_enabled;
> +    MemoryRegion host_mr;
> +    unsigned int next_mr_idx;
>   } CXLState;

... so simply drop the typedef and place OBJECT_DECLARE_SIMPLE_TYPE here instead.

>   #endif


ATB,

Mark.
