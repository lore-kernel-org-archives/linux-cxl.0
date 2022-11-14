Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978D5C43217
	for <linux-cxl@archiver.kernel.org>; Mon, 14 Nov 2022 17:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236962AbiKNRyO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 14 Nov 2022 12:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237825AbiKNRxv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 14 Nov 2022 12:53:51 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8E41B792
        for <linux-cxl@vger.kernel.org>; Mon, 14 Nov 2022 09:53:45 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N9xgr6DZGz6864S;
        Tue, 15 Nov 2022 01:51:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 14 Nov 2022 18:53:43 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 14 Nov
 2022 17:53:42 +0000
Date:   Mon, 14 Nov 2022 17:53:41 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <mst@redhat.com>, <marcel.apfelbaum@gmail.com>,
        <imammedo@redhat.com>, <ani@anisinha.ca>,
        <alison.schofield@intel.com>, <dave@stgolabs.net>,
        <a.manzanares@samsung.com>, <bwidawsk@kernel.org>,
        <gregory.price@memverge.com>, <hchkuo@avery-design.com.tw>,
        <cbrowy@avery-design.com>, <ira.weiny@intel.com>
Subject: Re: [PATCH 3/4] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Message-ID: <20221114175341.000036c4@Huawei.com>
In-Reply-To: <20221026004737.3646-4-gregory.price@memverge.com>
References: <20221026004737.3646-1-gregory.price@memverge.com>
        <20221026004737.3646-4-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 25 Oct 2022 20:47:36 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

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

Hi Gregory,

I've not been rushing on this purely because we are after the feature
freeze for this QEMU cycle so no great rush to line up new features
(and there was some fun with the pull request the previous set of QEMU
CXL features were in - unrelated to those patches).

A few comments inline.

Once I've chased down a segfault on power down of my qemu setup (that
seems to have nothing to do with the CXL support. *sigh*) I'll push out
an updated tree with this on it for testing purposes.

Thanks,

Jonathan

> ---
>  docs/system/devices/cxl.rst |  53 +++++--
>  hw/cxl/cxl-mailbox-utils.c  |  21 ++-
>  hw/mem/cxl_type3.c          | 274 +++++++++++++++++++++++++++---------
>  include/hw/cxl/cxl_device.h |  11 +-
>  tests/qtest/cxl-test.c      | 111 +++++++++++----
>  5 files changed, 348 insertions(+), 122 deletions(-)
> 
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index f25783a4ec..9e165064c8 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -300,15 +300,36 @@ Example topology involving a switch::
>  
>  Example command lines
>  ---------------------
> -A very simple setup with just one directly attached CXL Type 3 device::
> +A very simple setup with just one directly attached CXL Type 3 Persistent Memory device::
>  
>    qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
>    ...
> -  -object memory-backend-file,id=cxl-mem1,share=on,mem-path=/tmp/cxltest.raw,size=256M \
> -  -object memory-backend-file,id=cxl-lsa1,share=on,mem-path=/tmp/lsa.raw,size=256M \
> +  -object memory-backend-file,pmem=true,id=pmem0,share=on,mem-path=/tmp/cxltest.raw,size=256M \
> +  -object memory-backend-file,pmem=true,id=cxl-lsa0,share=on,mem-path=/tmp/lsa.raw,size=256M \

Why make the pmem=true change in here? If we want to do that I think it should be in a
separate patch with explanation.

> +  -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
> +  -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> +  -device cxl-type3,bus=root_port13,persistent-memdev=pmem0,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G
> +
> +A very simple setup with just one directly attached CXL Type 3 Volatile Memory device::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3,cxl=on -m 4g,maxmem=8G,slots=8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=vmem0,share=on,size=256M \
>    -device pxb-cxl,bus_nr=12,bus=pcie.0,id=cxl.1 \
>    -device cxl-rp,port=0,bus=cxl.1,id=root_port13,chassis=0,slot=2 \
> -  -device cxl-type3,bus=root_port13,memdev=cxl-mem1,lsa=cxl-lsa1,id=cxl-pmem0 \
> +  -device cxl-type3,bus=root_port13,volatile-memdev=vmem0,id=cxl-vmem0 \
> +  -M cxl-fmw.0.targets.0=cxl.1,cxl-fmw.0.size=4G

...


> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d7543fd5b4..c1183614b9 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -269,7 +269,7 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
>  
> -    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
> +    if (cxl_dstate->mem_size < CXL_CAPACITY_MULTIPLIER) {

I think this is also true of the individual types. Should we check each of them instead
much like we do below for cmd_identify_memoyr_Device.

>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -412,20 +412,20 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
>  
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> -    uint64_t size = cxl_dstate->pmem_size;
>  
> -    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
> +    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
...


> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0317bd96a6..21e866dcaf 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -32,7 +32,8 @@ enum {
>  };
>  

...

>  
> @@ -151,33 +152,67 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  {
>      g_autofree CDATSubHeader **table = NULL;
> -    MemoryRegion *nonvolatile_mr;
>      CXLType3Dev *ct3d = priv;
> +    MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
>      int dsmad_handle = 0;
> +    int cur_ent = 0;
> +    int len = 0;
>      int rc;
>  
> -    if (!ct3d->hostmem) {
> +    if (!ct3d->hostpmem && !ct3d->hostvmem) {
>          return 0;
>      }
>  
> -    nonvolatile_mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!nonvolatile_mr) {
> -        return -EINVAL;
> +    if (ct3d->hostvmem) {
> +        volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (!volatile_mr) {
> +            return -EINVAL;
> +        }
> +        len += CT3_CDAT_NUM_ENTRIES;
> +    }
> +
> +    if (ct3d->hostpmem) {
> +        nonvolatile_mr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (!nonvolatile_mr) {
> +            return -EINVAL;
> +        }
> +        len += CT3_CDAT_NUM_ENTRIES;
>      }
>  
> -    table = g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
> +    table = g_malloc0(len * sizeof(*table));
>      if (!table) {
>          return -ENOMEM;
>      }
>  
> -    rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, nonvolatile_mr);
> -    if (rc < 0) {
> -        return rc;
> +    /* Now fill them in */
> +    if (volatile_mr) {
> +        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> +                true, 0);

Align second line of parameters with ( would look nicer.

> +        if (rc < 0) {
> +            return rc;
> +        }
> +        cur_ent = CT3_CDAT_NUM_ENTRIES;
> +    }
> +
> +    if (nonvolatile_mr) {
> +        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> +                nonvolatile_mr, true, (volatile_mr ? volatile_mr->size : 0));
> +        if (rc < 0) {
> +            goto error_cleanup;
> +        }
> +        cur_ent += CT3_CDAT_NUM_ENTRIES;
>      }
> +    assert(len == cur_ent);
>  
>      *cdat_table = g_steal_pointer(&table);
>  
> -    return CT3_CDAT_NUM_ENTRIES;
> +    return len;
> +error_cleanup:
> +    int i;
> +    for (i = 0; i < cur_ent; i++) {
> +        g_free(*cdat_table[i]);

Until the steal pointer above, *cdata_table not set to anything.
Possibly gfree(table[i])?


> +    }
> +    return rc;
>  }
>  
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, void *priv)
> @@ -378,16 +413,48 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>      CXLDVSECRegisterLocator *regloc_dvsec;
>      uint8_t *dvsec;
>      int i;
> +    uint32_t range1_size_hi = 0, range1_size_lo = 0,
> +             range1_base_hi = 0, range1_base_lo = 0,

range1 values always set, so no need to initialize. Hopefully the compiler can
see that.

> +             range2_size_hi = 0, range2_size_lo = 0,
> +             range2_base_hi = 0, range2_base_lo = 0;
> +
> +    /*
> +     * Volatile memory is mapped as (0x0)
> +     * Persistent memory is mapped at (volatile->size)
> +     */
> +    if (ct3d->hostvmem && ct3d->hostpmem) {
> +        range1_size_hi = ct3d->hostvmem->size >> 32;
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                         (ct3d->hostvmem->size & 0xF0000000);
> +        range1_base_hi = 0;
> +        range1_base_lo = 0;
> +        range2_size_hi = ct3d->hostpmem->size >> 32;
> +        range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                         (ct3d->hostpmem->size & 0xF0000000);
> +        range2_base_hi = ct3d->hostvmem->size >> 32;
> +        range2_base_lo = ct3d->hostvmem->size & 0xF0000000;
> +    } else {
> +        HostMemoryBackend *hmbe = ct3d->hostvmem ?
> +                                  ct3d->hostvmem : ct3d->hostpmem;
> +        range1_size_hi = hmbe->size >> 32;
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                         (hmbe->size & 0xF0000000);
> +        range1_base_hi = 0;
> +        range1_base_lo = 0;
> +    }

Hmm. I wonder if this is simpler done as below. Both look fine
to me though so up to you for next version.  Trade off between
slightly ugly nested logic, and the readability always lost when
a ternary operator puts in an appearance.

    if (ct3d->hostvmem) {
        range1_size_hi = ct3d->hostvmem->size >> 32;
        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                         (ct3d->hostvmem->size & 0xF0000000);
        range1_base_hi = 0;
        range1_base_lo = 0;
	if (ct3d->hostpmem) {
            range2_size_hi = ct3d->hostpmem->size >> 32;
            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                             (ct3d->hostpmem->size & 0xF0000000);
            range2_base_hi = ct3d->hostvmem->size >> 32;
            range2_base_lo = ct3d->hostvmem->size & 0xF0000000;
       }
   } else {
       range1_size_hi = hostpmem->size >> 32;
       range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                        (hostpmem->size & 0xF0000000);
       range1_base_hi = 0;
       range1_base_lo = 0;
   }


>  
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
>      };
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
>                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
> @@ -475,33 +542,62 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>      MemoryRegion *mr;
>      char *name;


>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
> @@ -687,10 +801,17 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(d);
>      uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    AddressSpace *as;
> +
> +    if (ct3d->hostvmem) {
> +        vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
>  
> -    mr = host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    if (!vmr && !pmr) {
>          return MEMTX_OK;
>      }
>  
> @@ -698,11 +819,13 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
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
> +    as = (vmr && (dpa_offset <= int128_get64(vmr->size))) ?
> +         &ct3d->hostvmem_as : &ct3d->hostpmem_as;
> +    return address_space_write(as, dpa_offset, attrs, &data, size);

If we have both volatile and persistent and yet still only have our one HDM
decoder, then I think a write into the persistent range will have the wrong offset.

dpa_offset == address space offset when we only had one region. Not so much any more.
For persistent i think we'll need to subtract the size of the volatile region
(possibly taking care with alignment - I need to check that).

...

> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index 6baed747fa..a05ddc0c7b 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -34,29 +34,46 @@
>                   "-device cxl-rp,id=rp2,bus=cxl.1,chassis=0,slot=2 " \
>                   "-device cxl-rp,id=rp3,bus=cxl.1,chassis=0,slot=3 "
>  
> -#define QEMU_T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> -                 "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> -                 "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
> -
> -#define QEMU_2T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> -                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 "
> -
> -#define QEMU_4T3D "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> -                  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 " \
> -                  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp1,memdev=cxl-mem1,lsa=lsa1,id=cxl-pmem1 " \
> -                  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp2,memdev=cxl-mem2,lsa=lsa2,id=cxl-pmem2 " \
> -                  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
> -                  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
> -                  "-device cxl-type3,bus=rp3,memdev=cxl-mem3,lsa=lsa3,id=cxl-pmem3 "

If re-indenting makes sense (I'm really convinced it is worth the noise) then do it
in a precusor no-op patch so we can more easily see what is new here.)

 
> +#define QEMU_T3D_DEPRECATED \
> +  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp0,memdev=cxl-mem0,lsa=lsa0,id=cxl-pmem0 "
> +
> +#define QEMU_T3D_PMEM \
> +  "-object memory-backend-file,id=m0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-m0,lsa=lsa0,id=pmem0 "
> +
> +#define QEMU_T3D_VMEM \
> +  "-object memory-backend-ram,id=mem0,size=256M " \
> +  "-device cxl-type3,bus=rp0,volatile-memdev=mem0,id=mem0 "
> +
> +#define QEMU_T3D_VMEM_LSA \
> +  "-object memory-backend-ram,id=mem0,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M " \
> +  "-device cxl-type3,bus=rp0,volatile-memdev=mem0,lsa=lsa0,id=mem0 "
> +
> +#define QEMU_2T3D \
> +  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M "    \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 " \
> +  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> +  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=pmem1 "
> +
> +#define QEMU_4T3D \
> +  "-object memory-backend-file,id=cxl-mem0,mem-path=%s,size=256M " \
> +  "-object memory-backend-file,id=lsa0,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp0,persistent-memdev=cxl-mem0,lsa=lsa0,id=pmem0 " \
> +  "-object memory-backend-file,id=cxl-mem1,mem-path=%s,size=256M "    \
> +  "-object memory-backend-file,id=lsa1,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp1,persistent-memdev=cxl-mem1,lsa=lsa1,id=pmem1 " \
> +  "-object memory-backend-file,id=cxl-mem2,mem-path=%s,size=256M "    \
> +  "-object memory-backend-file,id=lsa2,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp2,persistent-memdev=cxl-mem2,lsa=lsa2,id=pmem2 " \
> +  "-object memory-backend-file,id=cxl-mem3,mem-path=%s,size=256M "    \
> +  "-object memory-backend-file,id=lsa3,mem-path=%s,size=256M "    \
> +  "-device cxl-type3,bus=rp3,persistent-memdev=cxl-mem3,lsa=lsa3,id=pmem3 "
>  
>  static void cxl_basic_hb(void)
>  {
> @@ -95,14 +112,53 @@ static void cxl_2root_port(void)
>  }
>  


