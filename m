Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E21EEC433EF
	for <linux-cxl@archiver.kernel.org>; Sat, 19 Mar 2022 08:53:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233497AbiCSIzQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 19 Mar 2022 04:55:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbiCSIzQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 19 Mar 2022 04:55:16 -0400
Received: from mail.default.ilande.bv.iomart.io (mail.ilande.co.uk [IPv6:2001:41c9:1:41f::167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 639691C7F0F
        for <linux-cxl@vger.kernel.org>; Sat, 19 Mar 2022 01:53:54 -0700 (PDT)
Received: from [2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c]
        by mail.default.ilande.bv.iomart.io with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.92)
        (envelope-from <mark.cave-ayland@ilande.co.uk>)
        id 1nVUpZ-0003pZ-Jk; Sat, 19 Mar 2022 08:53:05 +0000
Message-ID: <5e0dc4e5-d002-9fab-2b69-d849aee68acc@ilande.co.uk>
Date:   Sat, 19 Mar 2022 08:53:40 +0000
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
 <20220318150635.24600-33-Jonathan.Cameron@huawei.com>
From:   Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
In-Reply-To: <20220318150635.24600-33-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a00:23c4:8ba2:c800:3cf5:fb4b:b388:106c
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: Re: [PATCH v8 32/46] mem/cxl_type3: Add read and write functions for
 associated hostmem.
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.default.ilande.bv.iomart.io)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 18/03/2022 15:06, Jonathan Cameron wrote:

> From: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Once a read or write reaches a CXL type 3 device, the HDM decoders
> on the device are used to establish the Device Physical Address
> which should be accessed.  These functions peform the required maths
> and then use a device specific address space to access the
> hostmem->mr to fullfil the actual operation.  Note that failed writes
> are silent, but failed reads return poison.  Note this is based
> loosely on:
> 
> https://lore.kernel.org/qemu-devel/20200817161853.593247-6-f4bug@amsat.org/
> [RFC PATCH 0/9] hw/misc: Add support for interleaved memory accesses
> 
> Only lightly tested so far.  More complex test cases yet to be written.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   hw/mem/cxl_type3.c          | 88 +++++++++++++++++++++++++++++++++++++
>   include/hw/cxl/cxl_device.h |  6 +++
>   2 files changed, 94 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 244eb5dc91..225155dac5 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -100,7 +100,9 @@ static void ct3_finalize(Object *obj)
>   
>   static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>   {
> +    DeviceState *ds = DEVICE(ct3d);
>       MemoryRegion *mr;
> +    g_autofree char *name = NULL;
>   
>       if (!ct3d->hostmem) {
>           error_setg(errp, "memdev property must be set");
> @@ -115,6 +117,13 @@ static void cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>       memory_region_set_nonvolatile(mr, true);
>       memory_region_set_enabled(mr, true);
>       host_memory_backend_set_mapped(ct3d->hostmem, true);

There is an existing example for generating names for PCI devices in SPAPR which you 
can borrow which looks something like this (not compile tested!):

static char *cxl_type3_get_id(CXLType3Dev *ct3d)
{
     uint32_t busnr = pci_bus_num(PCI_BUS(qdev_get_parent_bus(DEVICE(ct3d))));
     PCIDevice *pd = PCI_DEVICE(ct3d);
     DeviceState *ds = DEVICE(ct3d);

     if (ds->id) {
         return g_strdup_printf("%s:%02x:%02x.%x", ds->id, busnr,
                                PCI_SLOT(pd->devfn), PCI_FUNC(pd->devfn));
     } else {
         return g_strdup_printf("%02x:%02x.%x", busnr,
                                PCI_SLOT(pd->devfn), PCI_FUNC(pd->devfn));
     }
}

> +
> +    if (ds->id) {
> +        name = g_strdup_printf("cxl-type3-dpa-space-%s", ds->id);
> +    } else {
> +        name = g_strdup("cxl-type3-dpa-space");
> +    }

This then becomes:

     char *id, *name;
     ...

     id = cxl_type3_get_id(ct3d);
     name = g_strdup_printf("cxl-type3-dpa-space:%s", id);
     address_space_init(&ct3d->hostmem_as, mr, name);
     g_free(id);
     g_free(name);

> +    address_space_init(&ct3d->hostmem_as, mr, name);

There is an address_space_init() here but no associated address_space_destroy() - 
you'll need to add a ct3_finalize() function to remove the address space, otherwise 
there will be a memory leak when the device is removed because of the dangling reference.

>       ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
>   
>       if (!ct3d->lsa) {
> @@ -160,6 +169,85 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
>                        &ct3d->cxl_dstate.device_registers);
>   }
>   
> +/* TODO: Support multiple HDM decoders and DPA skip */
> +static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
> +{
> +    uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> +    uint64_t decoder_base, decoder_size, hpa_offset;
> +    uint32_t hdm0_ctrl;
> +    int ig, iw;
> +
> +    decoder_base = (((uint64_t)cache_mem[R_CXL_HDM_DECODER0_BASE_HI] << 32) |
> +                    cache_mem[R_CXL_HDM_DECODER0_BASE_LO]);
> +    if ((uint64_t)host_addr < decoder_base) {
> +        return false;
> +    }
> +
> +    hpa_offset = (uint64_t)host_addr - decoder_base;
> +
> +    decoder_size = ((uint64_t)cache_mem[R_CXL_HDM_DECODER0_SIZE_HI] << 32) |
> +        cache_mem[R_CXL_HDM_DECODER0_SIZE_LO];
> +    if (hpa_offset >= decoder_size) {
> +        return false;
> +    }
> +
> +    hdm0_ctrl = cache_mem[R_CXL_HDM_DECODER0_CTRL];
> +    iw = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IW);
> +    ig = FIELD_EX32(hdm0_ctrl, CXL_HDM_DECODER0_CTRL, IG);
> +
> +    *dpa = (MAKE_64BIT_MASK(0, 8 + ig) & hpa_offset) |
> +        ((MAKE_64BIT_MASK(8 + ig + iw, 64 - 8 - ig - iw) & hpa_offset) >> iw);
> +
> +    return true;
> +}
> +
> +MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> +                           unsigned size, MemTxAttrs attrs)
> +{
> +    CXLType3Dev *ct3d = CT3(d);
> +    uint64_t dpa_offset;
> +    MemoryRegion *mr;
> +
> +    /* TODO support volatile region */
> +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> +    if (!mr) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    if (dpa_offset > int128_get64(mr->size)) {
> +        return MEMTX_ERROR;
> +    }
> +
> +    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
> +}
> +
> +MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> +                            unsigned size, MemTxAttrs attrs)
> +{
> +    CXLType3Dev *ct3d = CT3(d);
> +    uint64_t dpa_offset;
> +    MemoryRegion *mr;
> +
> +    mr = host_memory_backend_get_memory(ct3d->hostmem);
> +    if (!mr) {
> +        return MEMTX_OK;
> +    }
> +
> +    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> +        return MEMTX_OK;
> +    }
> +
> +    if (dpa_offset > int128_get64(mr->size)) {
> +        return MEMTX_OK;
> +    }
> +    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
> +                               &data, size);
> +}
> +
>   static void ct3d_reset(DeviceState *dev)
>   {
>       CXLType3Dev *ct3d = CT3(dev);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 288cc11772..eb998791d7 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -235,6 +235,7 @@ typedef struct cxl_type3_dev {
>       PCIDevice parent_obj;
>   
>       /* Properties */
> +    AddressSpace hostmem_as;
>       uint64_t size;
>       HostMemoryBackend *hostmem;
>       HostMemoryBackend *lsa;
> @@ -262,4 +263,9 @@ struct CXLType3Class {
>                       uint64_t offset);
>   };
>   
> +MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> +                           unsigned size, MemTxAttrs attrs);
> +MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> +                            unsigned size, MemTxAttrs attrs);
> +
>   #endif


ATB,

Mark.
