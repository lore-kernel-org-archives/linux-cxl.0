Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 169C5C05027
	for <linux-cxl@archiver.kernel.org>; Fri, 17 Feb 2023 16:38:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjBQQiN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 17 Feb 2023 11:38:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjBQQiM (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 17 Feb 2023 11:38:12 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8410D2
        for <linux-cxl@vger.kernel.org>; Fri, 17 Feb 2023 08:38:04 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PJGyz6g9fz6J7R6;
        Sat, 18 Feb 2023 00:11:39 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Fri, 17 Feb
 2023 16:16:18 +0000
Date:   Fri, 17 Feb 2023 16:16:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Jonathan Cameron via <qemu-devel@nongnu.org>
CC:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20230217161617.000064d1@huawei.com>
In-Reply-To: <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
        <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 31 Jan 2023 16:38:47 +0000
Jonathan Cameron via <qemu-devel@nongnu.org> wrote:

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
> 
Hi Gregory,

I've added support for multiple HDM decoders and hence can now
test both volatile and non volatile on same device.
It very nearly all works. With one exception which is I couldn't
poke the first byte of the non volatile region.

I think we have an off by one in a single check.

Interestingly it makes no difference when creating an FS on top
(which was my standard test) so I only noticed when poking memory
addresses directly to sanity check the HDM decoder setup.

I'll roll a v2 if no one shouts out that I'm wrong.

Note that adding multiple HDM decoders massively increases
the number of test cases over what we had before to poke all the
corners so I may well be missing stuff.  Hopefully can send an RFC
of that support out next week.

Jonathan

> -MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
> -                           unsigned size, MemTxAttrs attrs)
> +static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> +                                       hwaddr host_addr,
> +                                       unsigned int size,
> +                                       AddressSpace **as,
> +                                       uint64_t *dpa_offset)
>  {
> -    CXLType3Dev *ct3d = CXL_TYPE3(d);
> -    uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
>  
> -    /* TODO support volatile region */
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        return MEMTX_ERROR;
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
>      }
>  
> -    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> -        return MEMTX_ERROR;
> +    if (!vmr && !pmr) {
> +        return -ENODEV;
> +    }
> +
> +    if (!cxl_type3_dpa(ct3d, host_addr, dpa_offset)) {
> +        return -EINVAL;
> +    }
> +
> +    if (*dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return -EINVAL;
> +    }
> +
> +    if (vmr) {
> +        if (*dpa_offset <= int128_get64(vmr->size)) {

Off by one I think.  < 

> +            *as = &ct3d->hostvmem_as;
> +        } else {
> +            *as = &ct3d->hostpmem_as;
> +            *dpa_offset -= vmr->size;
> +        }
> +    } else {
> +        *as = &ct3d->hostpmem_as;
>      }
>  
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    return 0;
> +}
