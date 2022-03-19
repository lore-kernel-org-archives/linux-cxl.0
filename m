Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA960C433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 19 Mar 2022 08:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238651AbiCSIeK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 19 Mar 2022 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiCSIeK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 19 Mar 2022 04:34:10 -0400
Received: from mail.default.ilande.bv.iomart.io (mail.ilande.co.uk [IPv6:2001:41c9:1:41f::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF172986DB
        for <linux-cxl@vger.kernel.org>; Sat, 19 Mar 2022 01:32:48 -0700 (PDT)
Received: from [2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c]
        by mail.default.ilande.bv.iomart.io with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <mark.cave-ayland@ilande.co.uk>)
        id 1nVUV6-0003ek-IH; Sat, 19 Mar 2022 08:31:56 +0000
Message-ID: <b61e4534-988c-14b6-b21b-4040ee72475b@ilande.co.uk>
Date:   Sat, 19 Mar 2022 08:32:29 +0000
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
 <20220318150635.24600-18-Jonathan.Cameron@huawei.com>
From:   Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20220318150635.24600-18-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v8 17/46] hw/cxl/device: Add a memory device (8.2.8.5)
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.bv.iomart.io)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 18/03/2022 15:06, Jonathan Cameron via wrote:

> From: Ben Widawsky <ben.widawsky@intel.com>
> 
> A CXL memory device (AKA Type 3) is a CXL component that contains some
> combination of volatile and persistent memory. It also implements the
> previously defined mailbox interface as well as the memory device
> firmware interface.
> 
> Although the memory device is configured like a normal PCIe device, the
> memory traffic is on an entirely separate bus conceptually (using the
> same physical wires as PCIe, but different protocol).
> 
> Once the CXL topology is fully configure and address decoders committed,
> the guest physical address for the memory device is part of a larger
> window which is owned by the platform.  The creation of these windows
> is later in this series.
> 
> The following example will create a 256M device in a 512M window:
> -object "memory-backend-file,id=cxl-mem1,share,mem-path=cxl-type3,size=512M"
> -device "cxl-type3,bus=rp0,memdev=cxl-mem1,id=cxl-pmem0"
> 
> Note: Dropped PCDIMM info interfaces for now.  They can be added if
> appropriate at a later date.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c  |  46 +++++++++++
>   hw/mem/Kconfig              |   5 ++
>   hw/mem/cxl_type3.c          | 153 ++++++++++++++++++++++++++++++++++++
>   hw/mem/meson.build          |   1 +
>   include/hw/cxl/cxl_device.h |  17 ++++
>   include/hw/cxl/cxl_pci.h    |  21 +++++
>   include/hw/pci/pci_ids.h    |   1 +
>   7 files changed, 244 insertions(+)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4e9cb2bccd..7ed9606c6b 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -50,6 +50,8 @@ enum {
>       LOGS        = 0x04,
>           #define GET_SUPPORTED 0x0
>           #define GET_LOG       0x1
> +    IDENTIFY    = 0x40,
> +        #define MEMORY_DEVICE 0x0
>   };
>   
>   /* 8.2.8.4.5.1 Command Return Codes */
> @@ -214,6 +216,48 @@ static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
>       return CXL_MBOX_SUCCESS;
>   }
>   
> +/* 8.2.9.5.1.1 */
> +static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> +                                           CXLDeviceState *cxl_dstate,
> +                                           uint16_t *len)
> +{
> +    struct {
> +        char fw_revision[0x10];
> +        uint64_t total_capacity;
> +        uint64_t volatile_capacity;
> +        uint64_t persistent_capacity;
> +        uint64_t partition_align;
> +        uint16_t info_event_log_size;
> +        uint16_t warning_event_log_size;
> +        uint16_t failure_event_log_size;
> +        uint16_t fatal_event_log_size;
> +        uint32_t lsa_size;
> +        uint8_t poison_list_max_mer[3];
> +        uint16_t inject_poison_limit;
> +        uint8_t poison_caps;
> +        uint8_t qos_telemetry_caps;
> +    } QEMU_PACKED *id;
> +    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
> +
> +    uint64_t size = cxl_dstate->pmem_size;
> +
> +    if (!QEMU_IS_ALIGNED(size, 256 << 20)) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    id = (void *)cmd->payload;
> +    memset(id, 0, sizeof(*id));
> +
> +    /* PMEM only */
> +    snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> +
> +    id->total_capacity = size / (256 << 20);
> +    id->persistent_capacity = size / (256 << 20);
> +
> +    *len = sizeof(*id);
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>   #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
>   #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>   #define IMMEDIATE_LOG_CHANGE (1 << 4)
> @@ -231,6 +275,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
>       [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8, IMMEDIATE_POLICY_CHANGE },
>       [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
>       [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> +    [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
> +        cmd_identify_memory_device, 0, 0 },
>   };
>   
>   void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
> diff --git a/hw/mem/Kconfig b/hw/mem/Kconfig
> index 03dbb3c7df..73c5ae8ad9 100644
> --- a/hw/mem/Kconfig
> +++ b/hw/mem/Kconfig
> @@ -11,3 +11,8 @@ config NVDIMM
>   
>   config SPARSE_MEM
>       bool
> +
> +config CXL_MEM_DEVICE
> +    bool
> +    default y if CXL
> +    select MEM_DEVICE
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> new file mode 100644
> index 0000000000..a8d7cfcc81
> --- /dev/null
> +++ b/hw/mem/cxl_type3.c
> @@ -0,0 +1,153 @@
> +#include "qemu/osdep.h"
> +#include "qemu/units.h"
> +#include "qemu/error-report.h"
> +#include "hw/mem/memory-device.h"
> +#include "hw/mem/pc-dimm.h"
> +#include "hw/pci/pci.h"
> +#include "hw/qdev-properties.h"
> +#include "qapi/error.h"
> +#include "qemu/log.h"
> +#include "qemu/module.h"
> +#include "qemu/range.h"
> +#include "qemu/rcu.h"
> +#include "sysemu/hostmem.h"
> +#include "hw/cxl/cxl.h"
> +
> +static void build_dvsecs(CXLType3Dev *ct3d)
> +{
> +    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> +    uint8_t *dvsec;
> +
> +    dvsec = (uint8_t *)&(struct cxl_dvsec_device){
> +        .cap = 0x1e,
> +        .ctrl = 0x6,
> +        .status2 = 0x2,
> +        .range1_size_hi = 0,
> +#ifdef SET_PMEM_PADDR
> +        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 | ct3d->size,
> +#else
> +        .range1_size_lo = 0x3,
> +#endif

Generally you don't want #ifdefs like this to control functionality: it should either 
be removed if it is for unimplemented features, or controlled via a qdev property in 
ct3_props below.

> +        .range1_base_hi = 0,
> +        .range1_base_lo = 0,
> +    };
> +    cxl_component_create_dvsec(cxl_cstate, PCIE_CXL_DEVICE_DVSEC_LENGTH,
> +                               PCIE_CXL_DEVICE_DVSEC,
> +                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
> +
> +    dvsec = (uint8_t *)&(struct cxl_dvsec_register_locator){
> +        .rsvd         = 0,
> +        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
> +        .reg0_base_hi = 0,
> +        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
> +        .reg1_base_hi = 0,
> +    };
> +    cxl_component_create_dvsec(cxl_cstate, REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
> +                               REG_LOC_DVSEC_REVID, dvsec);
> +}
> +
> +static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> +{
> +    MemoryRegion *mr;
> +
> +    if (!ct3d->hostmem) {
> +        error_setg(errp, "memdev property must be set");
> +        return;
> +    }
> +
> +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> +    if (!mr) {
> +        error_setg(errp, "memdev property must be set");
> +        return;
> +    }
> +    memory_region_set_nonvolatile(mr, true);
> +    memory_region_set_enabled(mr, true);
> +    host_memory_backend_set_mapped(ct3d->hostmem, true);
> +    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
> +}
> +
> +
> +static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    CXLType3Dev *ct3d = CT3(pci_dev);
> +    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> +    ComponentRegisters *regs = &cxl_cstate->crb;
> +    MemoryRegion *mr = &regs->component_registers;
> +    uint8_t *pci_conf = pci_dev->config;
> +
> +    cxl_setup_memory(ct3d, errp);
> +
> +    pci_config_set_prog_interface(pci_conf, 0x10);
> +    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
> +
> +    pcie_endpoint_cap_init(pci_dev, 0x80);
> +    cxl_cstate->dvsec_offset = 0x100;
> +
> +    ct3d->cxl_cstate.pdev = pci_dev;
> +    build_dvsecs(ct3d);
> +
> +    cxl_component_register_block_init(OBJECT(pci_dev), cxl_cstate,
> +                                      TYPE_CXL_TYPE3_DEV);
> +
> +    pci_register_bar(
> +        pci_dev, CXL_COMPONENT_REG_BAR_IDX,
> +        PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
> +
> +    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
> +    pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
> +                     PCI_BASE_ADDRESS_SPACE_MEMORY |
> +                         PCI_BASE_ADDRESS_MEM_TYPE_64,
> +                     &ct3d->cxl_dstate.device_registers);
> +}
> +
> +static void ct3d_reset(DeviceState *dev)
> +{
> +    CXLType3Dev *ct3d = CT3(dev);
> +    uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
> +
> +    cxl_component_register_init_common(reg_state, CXL2_TYPE3_DEVICE);
> +    cxl_device_register_init_common(&ct3d->cxl_dstate);
> +}
> +
> +static Property ct3_props[] = {
> +    DEFINE_PROP_SIZE("size", CXLType3Dev, size, -1),
> +    DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
> +                     HostMemoryBackend *),
> +    DEFINE_PROP_END_OF_LIST(),
> +};
> +
> +static void ct3_class_init(ObjectClass *oc, void *data)
> +{
> +    DeviceClass *dc = DEVICE_CLASS(oc);
> +    PCIDeviceClass *pc = PCI_DEVICE_CLASS(oc);
> +
> +    pc->realize = ct3_realize;
> +    pc->class_id = PCI_CLASS_STORAGE_EXPRESS;
> +    pc->vendor_id = PCI_VENDOR_ID_INTEL;
> +    pc->device_id = 0xd93; /* LVF for now */
> +    pc->revision = 1;
> +
> +    set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> +    dc->desc = "CXL PMEM Device (Type 3)";
> +    dc->reset = ct3d_reset;
> +    device_class_set_props(dc, ct3_props);
> +}
> +
> +static const TypeInfo ct3d_info = {
> +    .name = TYPE_CXL_TYPE3_DEV,
> +    .parent = TYPE_PCI_DEVICE,
> +    .class_init = ct3_class_init,
> +    .instance_size = sizeof(CXLType3Dev),
> +    .interfaces = (InterfaceInfo[]) {
> +        { INTERFACE_CXL_DEVICE },
> +        { INTERFACE_PCIE_DEVICE },
> +        {}
> +    },
> +};
> +
> +static void ct3d_registers(void)
> +{
> +    type_register_static(&ct3d_info);
> +}
> +
> +type_init(ct3d_registers);
> diff --git a/hw/mem/meson.build b/hw/mem/meson.build
> index 82f86d117e..609b2b36fc 100644
> --- a/hw/mem/meson.build
> +++ b/hw/mem/meson.build
> @@ -3,6 +3,7 @@ mem_ss.add(files('memory-device.c'))
>   mem_ss.add(when: 'CONFIG_DIMM', if_true: files('pc-dimm.c'))
>   mem_ss.add(when: 'CONFIG_NPCM7XX', if_true: files('npcm7xx_mc.c'))
>   mem_ss.add(when: 'CONFIG_NVDIMM', if_true: files('nvdimm.c'))
> +mem_ss.add(when: 'CONFIG_CXL_MEM_DEVICE', if_true: files('cxl_type3.c'))
>   
>   softmmu_ss.add_all(when: 'CONFIG_MEM_DEVICE', if_true: mem_ss)
>   
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 8102d2a813..72da811c52 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -230,4 +230,21 @@ REG64(CXL_MEM_DEV_STS, 0)
>       FIELD(CXL_MEM_DEV_STS, MBOX_READY, 4, 1)
>       FIELD(CXL_MEM_DEV_STS, RESET_NEEDED, 5, 3)
>   
> +typedef struct cxl_type3_dev {
> +    /* Private */
> +    PCIDevice parent_obj;
> +
> +    /* Properties */
> +    uint64_t size;
> +    HostMemoryBackend *hostmem;
> +
> +    /* State */
> +    CXLComponentState cxl_cstate;
> +    CXLDeviceState cxl_dstate;
> +} CXLType3Dev;
> +
> +#define TYPE_CXL_TYPE3_DEV "cxl-type3"
> +
> +#define CT3(obj) OBJECT_CHECK(CXLType3Dev, (obj), TYPE_CXL_TYPE3_DEV)
> +

Ah okay this is an old style initialiser, and new code shouldn't be using them 
anymore (I believe there should be no remaining instances in git master). Drop the 
typedef from struct cxl_type3_dev and replace with:

#define TYPE_CXL_TYPE3_DEV "cxl-type3"
OBJECT_DECLARE_SIMPLE_TYPE(CXLType3Dev, CXL_TYPE3_DEV))

Note this will alter the generated QOM CAST from CT3() to CXL_TYPE3_DEV(): I would 
argue that the _DEV suffix is QOM legacy naming and recommend removing it from both 
of the above to give you TYPE_CXL_TYPE3 and CXL_TYPE3 respectively.

>   #endif
> diff --git a/include/hw/cxl/cxl_pci.h b/include/hw/cxl/cxl_pci.h
> index 810a244fab..cf53fe5425 100644
> --- a/include/hw/cxl/cxl_pci.h
> +++ b/include/hw/cxl/cxl_pci.h
> @@ -64,6 +64,27 @@ QEMU_BUILD_BUG_ON(sizeof(struct dvsec_header) != 10);
>    * CXL 2.0 Downstream Port: 3, 4, 7, 8
>    */
>   
> +/* CXL 2.0 - 8.1.3 (ID 0001) */
> +struct cxl_dvsec_device {
> +    struct dvsec_header hdr;
> +    uint16_t cap;
> +    uint16_t ctrl;
> +    uint16_t status;
> +    uint16_t ctrl2;
> +    uint16_t status2;
> +    uint16_t lock;
> +    uint16_t cap2;
> +    uint32_t range1_size_hi;
> +    uint32_t range1_size_lo;
> +    uint32_t range1_base_hi;
> +    uint32_t range1_base_lo;
> +    uint32_t range2_size_hi;
> +    uint32_t range2_size_lo;
> +    uint32_t range2_base_hi;
> +    uint32_t range2_base_lo;
> +};
> +QEMU_BUILD_BUG_ON(sizeof(struct cxl_dvsec_device) != 0x38);
> +
>   /* CXL 2.0 - 8.1.5 (ID 0003) */
>   struct cxl_dvsec_port_extensions {
>       struct dvsec_header hdr;
> diff --git a/include/hw/pci/pci_ids.h b/include/hw/pci/pci_ids.h
> index 11abe22d46..898083b86f 100644
> --- a/include/hw/pci/pci_ids.h
> +++ b/include/hw/pci/pci_ids.h
> @@ -53,6 +53,7 @@
>   #define PCI_BASE_CLASS_MEMORY            0x05
>   #define PCI_CLASS_MEMORY_RAM             0x0500
>   #define PCI_CLASS_MEMORY_FLASH           0x0501
> +#define PCI_CLASS_MEMORY_CXL             0x0502
>   #define PCI_CLASS_MEMORY_OTHER           0x0580
>   
>   #define PCI_BASE_CLASS_BRIDGE            0x06


ATB,

Mark.
