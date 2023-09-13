Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C177EDEC4A
	for <linux-cxl@archiver.kernel.org>; Wed, 13 Sep 2023 12:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240343AbjIMMUK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 13 Sep 2023 08:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240320AbjIMMUJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 13 Sep 2023 08:20:09 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D519AC
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 05:20:05 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401f68602a8so73187765e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 13 Sep 2023 05:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694607604; x=1695212404; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cw/GU2hpkfIr/4amrzLmC4xtCt8GrYzMMKVVf+xAAJc=;
        b=e2vZVb/mTcpfaMJKp98Y4O7vKxZgtFNAu3of210Uf6bCixYaPMtHqRVSbANdSmryj6
         VUZx44uHFgUQwb+YPoeVeGYTnbyRYYRY9ISRv808t38sbmp9psRqQEcmqc1tdOLXGaZs
         h47GI3Vzhcnx0csuhdGJGHbE0qfZ70Hcw6QaT02mlQcZm82HtiH9tXZba9KBwVSndJPx
         ZhXU6iX83+KXogfbEKT7jZZIJv0VrWTUT8acf9D22ZmiTR/XU+5FGl2X5AyrRbTUb9n8
         lPu2MrE8nAlq4gQAqpeGR2xkpOmbNjHo/QXlY3nv0B8zSkFQFfYa0RGTVdXQYfMPYqe9
         WBLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694607604; x=1695212404;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cw/GU2hpkfIr/4amrzLmC4xtCt8GrYzMMKVVf+xAAJc=;
        b=aFEcwhikcu43p24jf0glisZW9oegXzvWi9ZtGI1GD93ALbOlGkZMvRYKK/EYZ3HkgK
         SyZ0D7j1yHvXkaHCwLwfKHaRSFfDARTSgowQvtQ1Jnu9RdxdNAvIpcMHMU6uxg4lEyYt
         ssCGbBSIWnR58UO7iZphr8WuI+BhXcPppMR+MaMYdwAnq8v4feQeMcdlWDmDNumwXl/g
         5mF0ncTNojMJ5a0x/BUopQU532TQmUb4TIQu8opEyUCdPRn4SnRqgBMa7slmxrtoHi5f
         aW+/R9u7HMndlhlasZ0Zk19iXimLtgobTJmFs5R6ZS5gVhA9IEavA2C1JEN6MaVB6z+H
         C0HA==
X-Gm-Message-State: AOJu0Yymf7yDByBZ333Mn3onAksxmjLvsQgfrcEpEPoQ5XWfVxjUd3Zj
        RRAzDXMScJgZkDvfUPZy6evAVw==
X-Google-Smtp-Source: AGHT+IGNFuDPHGRBGc6156rZGRaGHciVdYu8mbA56Iadsbp4KcddKfFOSxwyp21ik/zNQ3sH2wk3pg==
X-Received: by 2002:a5d:538f:0:b0:317:51da:83b9 with SMTP id d15-20020a5d538f000000b0031751da83b9mr1971357wrv.49.1694607603805;
        Wed, 13 Sep 2023 05:20:03 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr. [176.131.211.241])
        by smtp.gmail.com with ESMTPSA id r16-20020adff110000000b00317b0155502sm15521167wro.8.2023.09.13.05.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 05:20:03 -0700 (PDT)
Message-ID: <c524da2a-f6e6-135b-bf22-b633b684961e@linaro.org>
Date:   Wed, 13 Sep 2023 14:20:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v10 17/45] hw/cxl/device: Add a memory device (8.2.8.5)
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linuxarm@huawei.com, qemu-devel@nongnu.org, alex.bennee@linaro.org,
        Marcel Apfelbaum <marcel@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>
Cc:     linux-cxl@vger.kernel.org, Ben Widawsky <ben.widawsky@intel.com>,
        Peter Maydell <peter.maydell@linaro.org>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Saransh Gupta1 <saransh@ibm.com>,
        Shreyas Shah <shreyas.shah@elastics.cloud>,
        Chris Browy <cbrowy@avery-design.com>,
        Samarth Saxena <samarths@cadence.com>,
        Dan Williams <dan.j.williams@intel.com>, k.jensen@samsung.com,
        dave@stgolabs.net, Alison Schofield <alison.schofield@intel.com>,
        Thomas Huth <thuth@redhat.com>
References: <20220429144110.25167-1-Jonathan.Cameron@huawei.com>
 <20220429144110.25167-18-Jonathan.Cameron@huawei.com>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20220429144110.25167-18-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Hi Ben, Jonathan,

On 29/4/22 16:40, Jonathan Cameron via wrote:
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
>   hw/cxl/cxl-component-utils.c |  18 ++++
>   hw/cxl/cxl-mailbox-utils.c   |  46 ++++++++++
>   hw/mem/Kconfig               |   5 ++
>   hw/mem/cxl_type3.c           | 162 +++++++++++++++++++++++++++++++++++
>   hw/mem/meson.build           |   1 +
>   include/hw/cxl/cxl_device.h  |  15 ++++
>   include/hw/cxl/cxl_pci.h     |  21 +++++
>   include/hw/pci/pci_ids.h     |   1 +
>   8 files changed, 269 insertions(+)


> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> new file mode 100644
> index 0000000000..290c088dd6
> --- /dev/null
> +++ b/hw/mem/cxl_type3.c
> @@ -0,0 +1,162 @@

This file lacks a license, do you mind adding one?

Thanks!

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
> +    dvsec = (uint8_t *)&(CXLDVSECDevice){
> +        .cap = 0x1e,
> +        .ctrl = 0x2,
> +        .status2 = 0x2,
> +        .range1_size_hi = ct3d->hostmem->size >> 32,
> +        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +        (ct3d->hostmem->size & 0xF0000000),
> +        .range1_base_hi = 0,
> +        .range1_base_lo = 0,
> +    };
> +    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +                               PCIE_CXL_DEVICE_DVSEC_LENGTH,
> +                               PCIE_CXL_DEVICE_DVSEC,
> +                               PCIE_CXL2_DEVICE_DVSEC_REVID, dvsec);
> +
> +    dvsec = (uint8_t *)&(CXLDVSECRegisterLocator){
> +        .rsvd         = 0,
> +        .reg0_base_lo = RBI_COMPONENT_REG | CXL_COMPONENT_REG_BAR_IDX,
> +        .reg0_base_hi = 0,
> +        .reg1_base_lo = RBI_CXL_DEVICE_REG | CXL_DEVICE_REG_BAR_IDX,
> +        .reg1_base_hi = 0,
> +    };
> +    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +                               REG_LOC_DVSEC_LENGTH, REG_LOC_DVSEC,
> +                               REG_LOC_DVSEC_REVID, dvsec);
> +    dvsec = (uint8_t *)&(CXLDVSECDeviceGPF){
> +        .phase2_duration = 0x603, /* 3 seconds */
> +        .phase2_power = 0x33, /* 0x33 miliwatts */
> +    };
> +    cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
> +                               GPF_DEVICE_DVSEC_LENGTH, GPF_PORT_DVSEC,
> +                               GPF_DEVICE_DVSEC_REVID, dvsec);
> +}
> +
> +static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> +{
> +    MemoryRegion *mr;
> +
> +    if (!ct3d->hostmem) {
> +        error_setg(errp, "memdev property must be set");
> +        return false;
> +    }
> +
> +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> +    if (!mr) {
> +        error_setg(errp, "memdev property must be set");
> +        return false;
> +    }
> +    memory_region_set_nonvolatile(mr, true);
> +    memory_region_set_enabled(mr, true);
> +    host_memory_backend_set_mapped(ct3d->hostmem, true);
> +    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
> +
> +    return true;
> +}
> +
> +static void ct3_realize(PCIDevice *pci_dev, Error **errp)
> +{
> +    CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
> +    CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> +    ComponentRegisters *regs = &cxl_cstate->crb;
> +    MemoryRegion *mr = &regs->component_registers;
> +    uint8_t *pci_conf = pci_dev->config;
> +
> +    if (!cxl_setup_memory(ct3d, errp)) {
> +        return;
> +    }
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
> +                                      TYPE_CXL_TYPE3);
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
> +    CXLType3Dev *ct3d = CXL_TYPE3(dev);
> +    uint32_t *reg_state = ct3d->cxl_cstate.crb.cache_mem_registers;
> +    uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
> +
> +    cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
> +    cxl_device_register_init_common(&ct3d->cxl_dstate);
> +}
> +
> +static Property ct3_props[] = {
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
> +    .name = TYPE_CXL_TYPE3,
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

