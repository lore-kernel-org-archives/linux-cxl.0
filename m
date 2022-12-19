Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B362C4332F
	for <linux-cxl@archiver.kernel.org>; Mon, 19 Dec 2022 12:42:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbiLSMmW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 19 Dec 2022 07:42:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbiLSMmV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 19 Dec 2022 07:42:21 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8BCFDFC6
        for <linux-cxl@vger.kernel.org>; Mon, 19 Dec 2022 04:42:17 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NbK7R5psxz6H6jT;
        Mon, 19 Dec 2022 20:40:51 +0800 (CST)
Received: from localhost (10.45.149.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 19 Dec
 2022 12:42:14 +0000
Date:   Mon, 19 Dec 2022 12:42:11 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20221219124211.000032b7@Huawei.com>
In-Reply-To: <20221128150157.97724-4-gregory.price@memverge.com>
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-4-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.149.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

As a process thing, when reworking a patch I picked up for the
CXL qemu gitlab tree, drop the SOB that I added as it's not relevant
to the new patch.

Some minor comments inline. I've fixed these up (and the int i from
the other review) whilst applying to my local tree.  That tree is a bit
of a mess at the moment, so probably won't push out to gitlab until
after the holidays.  Still no need to post a new version unless you particularly
want to or there are other changes to make.

My current plan for sending this upstream is to do it after a couple of
other series - the driver being what is needed for the current kernel code
testing:

1) Trivial cleanup (I'll probably pull patch 1 of this series into that)
2) The RAS error injection series - kernel code already upstream.
3) The event injection series (Ira is going to send an updated RFC)
   kernel code on list.

4) This series probably. My main concern here is that we don't really have
   any way of testing this yet. It's small enough that doesn't bother me
   to much though.


Hopefully some other series in parallel that aren't focused on the type 3 device
so can merge in other orders.


> ---
>  docs/system/devices/cxl.rst |  49 ++++--
>  hw/cxl/cxl-mailbox-utils.c  |  22 +--
>  hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++---------
>  include/hw/cxl/cxl_device.h |  11 +-
>  tests/qtest/cxl-test.c      |  78 ++++++++--
>  5 files changed, 347 insertions(+), 105 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index f25783a4ec..45639a676a 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -300,7 +300,7 @@ Example topology involving a switch::
>  
>  Example command lines
>  ---------------------
> -A very simple setup with just one directly attached CXL Type 3 device::
> +A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
>  
>    qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
>    ...
> @@ -308,7 +308,28 @@ A very simple setup with just one directly attached CXL Type 3 device::
>    -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> +
> +A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> +
> +The same volatile setup may optionally include an LSA region::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
> +  -object memory-backend-file,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \
> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,lsa=cxl-lsa0,id=cxl-vmem0 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
>  
>  A setup suitable for 4 way interleave. Only one fixed window provided, to enable 2 way
> @@ -328,13 +349,13 @@ the CXL Type3 device directly attached (no switches).::
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    -device pxb-cxl,bus_nr=222,bus=pcie.0,id=cxl.2 \
>    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
>    -device cxl-rp,port=1,bus=cxl.1,id=root_port14,chassis=0,slot=3 \
> -  -device cxl-type3,bus=root_port14,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
> +  -device cxl-type3,bus=root_port14,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem1 \
>    -device cxl-rp,port=0,bus=cxl.2,id=root_port15,chassis=0,slot=5 \
> -  -device cxl-type3,bus=root_port15,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
> +  -device cxl-type3,bus=root_port15,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem2 \
>    -device cxl-rp,port=1,bus=cxl.2,id=root_port16,chassis=0,slot=6 \
> -  -device cxl-type3,bus=root_port16,memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
> +  -device cxl-type3,bus=root_port16,persistent-memdev=cxl-mem4,lsa=cxl-lsa4,id=cxl-pmem3 \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.targets.1=cxl.2,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=8k
>  
>  An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
> @@ -354,15 +375,23 @@ An example of 4 devices below a switch suitable for 1, 2 or 4 way interleave::
>    -device cxl-rp,port=1,bus=cxl.1,id=root_port1,chassis=0,slot=1 \
>    -device cxl-upstream,bus=root_port0,id=us0 \
>    -device cxl-downstream,port=0,bus=us0,id=swport0,chassis=0,slot=4 \
> -  -device cxl-type3,bus=swport0,memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
> +  -device cxl-type3,bus=swport0,persistent-memdev=cxl-mem0,lsa=cxl-lsa0,id=cxl-pmem0,size=256M \
>    -device cxl-downstream,port=1,bus=us0,id=swport1,chassis=0,slot=5 \
> -  -device cxl-type3,bus=swport1,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
> +  -device cxl-type3,bus=swport1,persistent-memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem1,size=256M \
>    -device cxl-downstream,port=2,bus=us0,id=swport2,chassis=0,slot=6 \
> -  -device cxl-type3,bus=swport2,memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
> +  -device cxl-type3,bus=swport2,persistent-memdev=cxl-mem2,lsa=cxl-lsa2,id=cxl-pmem2,size=256M \
>    -device cxl-downstream,port=3,bus=us0,id=swport3,chassis=0,slot=7 \
> -  -device cxl-type3,bus=swport3,memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
> +  -device cxl-type3,bus=swport3,persistent-memdev=cxl-mem3,lsa=cxl-lsa3,id=cxl-pmem3,size=256M \
>    -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G,cxl-fmw.0.interleave-granularity=4k
>  
> +Deprecations
> +------------
> +
> +The Type 3 device [memdev] attribute has been deprecated in favor
> +of the [persistent-memdev] and [volatile-memdev] attributes. [memdev]

That's not quite correct as it sort of implies we could previously use
memdev for the volatile case.

Also curiously short line wrap here. I'll tweak this.  Whilst the rest of the file is also
wrapped oddly, lets not make it worse.

> +will default to a persistent memory device for backward compatibility
> +and is incapable of being used in combination with [persistent-memdev].
> +
>  Kernel Configuration Options
>  ----------------------------
>  


>  
> @@ -444,16 +445,15 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>          uint64_t next_pmem;
>      } QEMU_PACKED *part_info = (void *)cmd->payload;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> -    uint64_t size = cxl_dstate->pmem_size;
>  
> -    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
> +    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> -    /* PMEM only */
> -    part_info->active_vmem = 0;
> +    part_info->active_vmem = cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER;
>      part_info->next_vmem = 0;

Unrelated to this patch, but it might be a nice follow up to add a comment somewhere
near here to say that next_vmem == 0 && next_pmem == 0 corresponds to no partition
change.  I had to check the spec on that :)

> -    part_info->active_pmem = size / CXL_CAPACITY_MULTIPLIER;
> +    part_info->active_pmem = cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER;
>      part_info->next_pmem = 0;
>  
>      *len = sizeof(*part_info);
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0317bd96a6..81dc3def01 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c


>      dvsec = (uint8_t *)&(CXLDVSECDevice){
>          .cap = 0x1e,
>          .ctrl = 0x2,
>          .status2 = 0x2,
> -        .range1_size_hi = ct3d->hostmem->size >> 32,
> -        .range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> -        (ct3d->hostmem->size & 0xF0000000),
> -        .range1_base_hi = 0,
> -        .range1_base_lo = 0,
> +        .range1_size_hi = range1_size_hi,
> +        .range1_size_lo = range1_size_lo,
> +        .range1_base_hi = range1_base_hi,
> +        .range1_base_lo = range1_base_lo,
> +        .range2_size_hi = range2_size_hi,
> +        .range2_size_lo = range2_size_lo,
> +        .range2_base_hi = range2_base_hi,
> +        .range2_base_lo = range2_base_lo

Trivial but add a trailing comma.  The structure might well get bigger in future
so we may want to add stuff here and the lack of a comma will make that noisier
than it needs to be.

>      };
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
>                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
> @@ -475,33 +542,62 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>      MemoryRegion *mr;
>      char *name;
>  
> -    if (!ct3d->hostmem) {
> -        error_setg(errp, "memdev property must be set");
> +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> +        error_setg(errp, "at least one memdev property must be set");
>          return false;
> +    } else if (ct3d->hostmem && ct3d->hostpmem) {
> +        error_setg(errp, "[memdev] cannot be used with new "
> +                         "[persistent-memdev] property");
> +        return false;
> +    } else if (ct3d->hostmem) {
> +        /* Use of hostmem property implies pmem */
> +        ct3d->hostpmem = ct3d->hostmem;
> +        ct3d->hostmem = NULL;
>      }
>  
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        error_setg(errp, "memdev property must be set");
> +    if (ct3d->hostpmem && !ct3d->lsa) {
> +        error_setg(errp, "lsa property must be set for persistent devices");
>          return false;
>      }
> -    memory_region_set_nonvolatile(mr, true);
> -    memory_region_set_enabled(mr, true);
> -    host_memory_backend_set_mapped(ct3d->hostmem, true);
>  
> -    if (ds->id) {
> -        name = g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
> -    } else {
> -        name = g_strdup("cxl-type3-dpa-space");
> +    if (ct3d->hostvmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (!mr) {
> +            error_setg(errp, "volatile memdev must have backing device");
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(mr, false);
> +        memory_region_set_enabled(mr, true);
> +        host_memory_backend_set_mapped(ct3d->hostvmem, true);
> +        if (ds->id) {
> +            name = g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds->id);
> +        } else {
> +            name = g_strdup("cxl-type3-dpa-vmem-space");
> +        }
> +        address_space_init(&ct3d->hostvmem_as, mr, name);
> +        ct3d->cxl_dstate.vmem_size = mr->size;
> +        ct3d->cxl_dstate.mem_size += mr->size;
> +        g_free(name);
>      }
> -    address_space_init(&ct3d->hostmem_as, mr, name);
> -    g_free(name);
> -
> -    ct3d->cxl_dstate.pmem_size = ct3d->hostmem->size;
>  
> -    if (!ct3d->lsa) {
> -        error_setg(errp, "lsa property must be set");
> -        return false;
> +    if (ct3d->hostpmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (!mr) {
> +            error_setg(errp, "persistent memdev must have backing device");
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(mr, true);
> +        memory_region_set_enabled(mr, true);
> +        host_memory_backend_set_mapped(ct3d->hostpmem, true);
> +        if (ds->id) {
> +            name = g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds->id);
> +        } else {
> +            name = g_strdup("cxl-type3-dpa-pmem-space");
> +        }
> +        address_space_init(&ct3d->hostpmem_as, mr, name);
> +        ct3d->cxl_dstate.pmem_size = mr->size;
> +        ct3d->cxl_dstate.mem_size += mr->size;
> +        g_free(name);
>      }
>  
>      return true;
> @@ -609,7 +705,12 @@ err_free_spdm_socket:
>  err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
> -    address_space_destroy(&ct3d->hostmem_as);
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }

These two should be in opposite order (tear down in reverse of setup)

>      return;
>  }
>  
> @@ -623,7 +724,12 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_doe_cdat_release(cxl_cstate);
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
> -    address_space_destroy(&ct3d->hostmem_as);
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }

Same here.  Almost worth factoring this out but it's undoing setup_memory
and I can't immediately think of what the undo version of that should be called
so maybe we can avoid that for now by leaving these here.

>  }
>  
>  /* TODO: Support multiple HDM decoders and DPA skip */
> @@ -663,11 +769,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(d);
>      uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
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

As a follow up it might be worth exploring if we can combine the two address spaces.
I'm not keen to do it yet, because of no simple way to test it and it's less obviously
correct than just having separate address spaces.

Would involve mapping a the two hostmem regions into a container memory region which
would be the one we use to build the address space.  Advantage would be that we wouldn't
need special handling for which region it was in here or the write path as QEMUs
normal heirarchical memory regions would handle that for us.
I'm not 100% sure it would work though!

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
>  static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
> @@ -744,30 +891,35 @@ static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
>  static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
>                      uint64_t offset)
>  {
> -    MemoryRegion *mr;
> +    MemoryRegion *mr = NULL;

No reason to set this to NULL.

>      void *lsa;
>  
> -    mr = host_memory_backend_get_memory(ct3d->lsa);
> -    validate_lsa_access(mr, size, offset);
> +    if (ct3d->lsa) {

Flip logic to return early.  Nicer anyway plus reduces diff
making this slightly easier to review.


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

Hmm. Maybe this should return an error, but then we can't use the uint64_t as a return
value.  As this function would never be called with !ct3d->lsa let's leave it as it stands.

>  }
>  
>  static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset)
>  {
> -    MemoryRegion *mr;
> -    void *lsa;
> +    MemoryRegion *mr = NULL;
> +    void *lsa = NULL;
As above these NULL values aren't read.
>  
> -    mr = host_memory_backend_get_memory(ct3d->lsa);
> -    validate_lsa_access(mr, size, offset);
> +    if (ct3d->lsa) {

Flip logic here as well

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

> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index e59ba22387..6893f54e28 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -40,32 +40,46 @@
>    "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
>    "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
>  
> -#define QEMU_T3D \
> +#define QEMU_T3D_DEPRECATED \
>    "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> -  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \

This belongs in previous patch. 

> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
>    "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
>  

Rest looks good to me.

Jonathan

