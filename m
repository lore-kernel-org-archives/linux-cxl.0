Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 216C9C38142
	for <linux-cxl@archiver.kernel.org>; Tue, 31 Jan 2023 11:53:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjAaLxZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 31 Jan 2023 06:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjAaLxV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 31 Jan 2023 06:53:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F682DBC3
        for <linux-cxl@vger.kernel.org>; Tue, 31 Jan 2023 03:53:18 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P5jyV4x0Lz6J6CH;
        Tue, 31 Jan 2023 19:49:38 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 31 Jan
 2023 11:53:15 +0000
Date:   Tue, 31 Jan 2023 11:53:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20230131115314.00004f7e@huawei.com>
In-Reply-To: <20221128150157.97724-4-gregory.price@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-4-gregory.price@memverge.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 28 Nov 2022 10:01:57 -0500
Gregory Price <gourry.memverge@gmail.com> wrote:

> From: Gregory Price <gourry.memverge@gmail.com>
> 
> This commit enables each CXL Type-3 device to contain one volatile
> memory region and one persistent region.
> 
> Two new properties have been added to cxl-type3 device initialization:
>     [volatile-memdev] and [persistent-memdev]
> 
> The existing [memdev] property has been deprecated and will default the
> memory region to a persistent memory region (although a user may assign
> the region to a ram or file backed region). It cannot be used in
> combination with the new [persistent-memdev] property.
> 
> Partitioning volatile memory from persistent memory is not yet supported.
> 
> Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
> at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm taking another look at these and tweaking what I'm carrying as I go
with a plan to post them for merging shortly.

Anyhow, a few more changes I wanted to call out here so they don't come
as a surprise / are things to focus on in reviewing that version 
(hopefully post it later today or maybe tomorrow).

Most of this is reducing the diff / duplication of code to make review a
tiny bit easier (hopefully)

...
  
>  /* TODO: Support multiple HDM decoders and DPA skip */
> @@ -663,11 +769,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(d);
>      uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;

We end up with a lot of duplication between cxl_type3_read and cxl_type3_write()
so I've factored out a _get_as_and_dpa() function that deals with establish
where the memory we then read or write is. 

>  
> -    /* TODO support volatile region */
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
>          return MEMTX_ERROR;
>      }
>  
> @@ -675,11 +787,22 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>          return MEMTX_ERROR;
>      }
>  
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
>          return MEMTX_ERROR;
>      }
>  
> -    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data, size);
> +    if (vmr) {
> +        if (dpa_offset <= int128_get64(vmr->size)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= vmr->size;
> +        }
> +    }
> +    else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +    return address_space_read(as, dpa_offset, attrs, data, size);
>  }
>  
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> @@ -687,10 +810,17 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(d);
>      uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
>  
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
>          return MEMTX_OK;
>      }
>  
> @@ -698,11 +828,22 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>          return MEMTX_OK;
>      }
>  
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
>          return MEMTX_OK;
>      }
> -    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
> -                               &data, size);
> +
> +    if (vmr) {
> +        if (dpa_offset <= int128_get64(vmr->size)) {
> +            as = &ct3d->hostvmem_as;
> +        } else {
> +            as = &ct3d->hostpmem_as;
> +            dpa_offset -= vmr->size;
> +        }
> +    }
> +    else {
> +        as = &ct3d->hostpmem_as;
> +    }
> +    return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
>  
>  static void ct3d_reset(DeviceState *dev)
> @@ -717,7 +858,11 @@ static void ct3d_reset(DeviceState *dev)
>  
>  static Property ct3_props[] = {
>      DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND,
> -                     HostMemoryBackend *),
> +                     HostMemoryBackend *), /* for backward compatibility */
> +    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> +    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, hostvmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
>      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> @@ -728,10 +873,12 @@ static Property ct3_props[] = {
>  
>  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
>  {
> -    MemoryRegion *mr;
> -
> -    mr = host_memory_backend_get_memory(ct3d->lsa);
> -    return memory_region_size(mr);
> +    MemoryRegion *mr = NULL;
> +    if (ct3d->lsa) {

I flipped this logic as reduces the resulting diff and makes patch a little
easier to read.

> +        mr = host_memory_backend_get_memory(ct3d->lsa);
> +        return memory_region_size(mr);
> +    }
> +    return 0;
>  }
>  
>  static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
> @@ -744,30 +891,35 @@ static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
>  static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
>                      uint64_t offset)
>  {
> -    MemoryRegion *mr;
> +    MemoryRegion *mr = NULL;
>      void *lsa;
>  
> -    mr = host_memory_backend_get_memory(ct3d->lsa);
> -    validate_lsa_access(mr, size, offset);
> +    if (ct3d->lsa) {

Flipped this one as well.

> +        mr = host_memory_backend_get_memory(ct3d->lsa);
> +        validate_lsa_access(mr, size, offset);
>  
> -    lsa = memory_region_get_ram_ptr(mr) + offset;
> -    memcpy(buf, lsa, size);
> +        lsa = memory_region_get_ram_ptr(mr) + offset;
> +        memcpy(buf, lsa, size);
> +        return size;
> +    }
>  
> -    return size;
> +    return 0;
>  }
>  
>  static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset)
>  {
> -    MemoryRegion *mr;
> -    void *lsa;
> +    MemoryRegion *mr = NULL;
> +    void *lsa = NULL;
>  
> -    mr = host_memory_backend_get_memory(ct3d->lsa);
> -    validate_lsa_access(mr, size, offset);
> +    if (ct3d->lsa) {
> +        mr = host_memory_backend_get_memory(ct3d->lsa);
> +        validate_lsa_access(mr, size, offset);
>  
> -    lsa = memory_region_get_ram_ptr(mr) + offset;
> -    memcpy(lsa, buf, size);
> -    memory_region_set_dirty(mr, offset, size);
> +        lsa = memory_region_get_ram_ptr(mr) + offset;
> +        memcpy(lsa, buf, size);
> +        memory_region_set_dirty(mr, offset, size);
> +    }
>  
>      /*
>       * Just like the PMEM, if the guest is not allowed to exit gracefully, label
> @@ -978,7 +1130,7 @@ static void ct3_class_init(ObjectClass *oc, void *data)
>      pc->config_read = ct3d_config_read;
>  
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    dc->desc = "CXL PMEM Device (Type 3)";
> +    dc->desc = "CXL Memory Device (Type 3)";
>      dc->reset = ct3d_reset;
>      device_class_set_props(dc, ct3_props);
>  
>
