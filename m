Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 476DDC001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 16:36:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjHDQgb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 12:36:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjHDQga (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 12:36:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABFCCB2
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 09:36:27 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHWTk6pC3z688hZ;
        Sat,  5 Aug 2023 00:32:42 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 17:36:24 +0100
Date:   Fri, 4 Aug 2023 17:36:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and
 address space handling for DC regions
Message-ID: <20230804173623.00007707@Huawei.com>
In-Reply-To: <20230725183939.2741025-6-fan.ni@samsung.com>
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b@uscas1p1.samsung.com>
        <20230725183939.2741025-6-fan.ni@samsung.com>
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

On Tue, 25 Jul 2023 18:39:56 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
> 
> With the change, following supports are added:
> 1. add a new property to type3 device "nonvolatile-dc-memdev" to point to host
>    memory backend for dynamic capacity;
> 2. add namespace for dynamic capacity for read/write support;
> 3. create cdat entries for each dynamic capacity region;
> 4. fix dvsec range registers to include DC regions.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan,

I'm not sure if we want to do all regions backed by one memory backend
or one backend each.  It will become complex when some are shared
(e.g. what Gregory is working on).

A few questions inline.  In particular there are subtle changes to
existing handling that are either bug fixes (in which case they need
to be sent first) or bugs / have no effect and shouldn't be in here.


> ---
>  hw/cxl/cxl-mailbox-utils.c  |  19 +++-
>  hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
>  include/hw/cxl/cxl_device.h |   4 +
>  3 files changed, 185 insertions(+), 41 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index dd5ea95af8..0511b8e6f7 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -388,9 +388,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>          char fw_rev4[0x10];
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>  
>      if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> -        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
> +        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -531,7 +533,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -566,9 +569,11 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>          uint64_t next_pmem;
>      } QEMU_PACKED *part_info = (void *)cmd->payload;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> +    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -880,7 +885,13 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      struct clear_poison_pl *in = (void *)cmd->payload;
>  
>      dpa = ldq_le_p(&in->dpa);
> -    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
> +    if (dpa + CXL_CACHE_LINE_SIZE >= cxl_dstate->static_mem_size

If there is already a bug here we should pull it out. If not I can't
see why the >= change is here.  

> +            && ct3d->dc.num_regions == 0) {
> +        return CXL_MBOX_INVALID_PA;
> +    }
> +
> +    if (ct3d->dc.num_regions && dpa + CXL_CACHE_LINE_SIZE >=
> +            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
>          return CXL_MBOX_INVALID_PA;
>      }
>  
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index b29bb2309a..76bbd9f785 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -20,6 +20,7 @@
>  #include "hw/pci/spdm.h"
>  
>  #define DWORD_BYTE 4
> +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  
>  /* Default CDAT entries for a memory region */
>  enum {
> @@ -33,8 +34,8 @@ enum {
>  };
>  
>  static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> -                                         int dsmad_handle, MemoryRegion *mr,
> -                                         bool is_pmem, uint64_t dpa_base)
> +        int dsmad_handle, uint8_t flags,
> +        uint64_t dpa_base, uint64_t size)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;
> @@ -53,9 +54,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>              .length = sizeof(*dsmas),
>          },
>          .DSMADhandle = dsmad_handle,
> -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +        .flags = flags,
>          .DPA_base = dpa_base,
> -        .DPA_length = memory_region_size(mr),
> +        .DPA_length = size,
>      };
>  
>      /* For now, no memory side cache, plausiblish numbers */
> @@ -137,9 +138,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>           * NV: Reserved - the non volatile from DSMAS matters
>           * V: EFI_MEMORY_SP
>           */
> -        .EFI_memory_type_attr = is_pmem ? 2 : 1,
> +        .EFI_memory_type_attr = flags ? 2 : 1,

This doesn't look good.  Previously we used a boolean to control
this now you are using flags which contains other things?

I don't see the flags expanding that much more, so instead of
this I'd just change the function to take two booleans.
is_pmem, is_dynamic

>          .DPA_offset = 0,
> -        .DPA_length = memory_region_size(mr),
> +        .DPA_length = size,
>      };
>  
>      /* Header always at start of structure */
> @@ -158,21 +159,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      g_autofree CDATSubHeader **table = NULL;
>      CXLType3Dev *ct3d = priv;
>      MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
> +    MemoryRegion *dc_mr = NULL;
>      int dsmad_handle = 0;
>      int cur_ent = 0;
>      int len = 0;
>      int rc, i;
> +    uint64_t vmr_size = 0, pmr_size = 0;
>  
> -    if (!ct3d->hostpmem && !ct3d->hostvmem) {
> +    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
>          return 0;
>      }
>  
> +    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
> +        warn_report("The device has static ram and pmem and dynamic capacity");
> +    }
> +
>      if (ct3d->hostvmem) {
>          volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
>          if (!volatile_mr) {
>              return -EINVAL;
>          }
>          len += CT3_CDAT_NUM_ENTRIES;
> +        vmr_size = volatile_mr->size;
>      }
>  
>      if (ct3d->hostpmem) {
> @@ -181,6 +189,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>              return -EINVAL;
>          }
>          len += CT3_CDAT_NUM_ENTRIES;
> +        pmr_size = nonvolatile_mr->size;
> +    }
> +
> +    if (ct3d->dc.num_regions) {
> +        if (ct3d->dc.host_dc) {
> +            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +            if (!dc_mr) {
> +                return -EINVAL;
> +            }
> +            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> +        } else {
> +            return -EINVAL;
> +        }
>      }
>  
>      table = g_malloc0(len * sizeof(*table));
> @@ -190,8 +211,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  
>      /* Now fill them in */
>      if (volatile_mr) {
> -        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> -                                           false, 0);
> +        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
> +                0, 0, vmr_size);
>          if (rc < 0) {
>              return rc;
>          }
> @@ -200,14 +221,37 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  
>      if (nonvolatile_mr) {
>          rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                                           nonvolatile_mr, true,
> -                                           (volatile_mr ?
> -                                            memory_region_size(volatile_mr) : 0));
> +                CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);

These lines don't end up that long, so I'd prefer to keep aligned 
with the brackets where we can do so and stay under 80 chars.

>          if (rc < 0) {
>              goto error_cleanup;
>          }
>          cur_ent += CT3_CDAT_NUM_ENTRIES;
>      }
> +
> +    if (dc_mr) {
> +        uint64_t region_base = vmr_size + pmr_size;
> +
> +        /*
> +         * Currently we create cdat entries for each region, should we only
> +         * create dsmas table instead??
> +         * We assume all dc regions are non-volatile for now.
> +         *
> +         */
> +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent])
> +                    , dsmad_handle++
> +                    , CDAT_DSMAS_FLAG_NV | CDAT_DSMAS_FLAG_DYNAMIC_CAP
> +                    , region_base, ct3d->dc.regions[i].len);

Formatting should have those , on the end of lines, not start of next ones.

> +            if (rc < 0) {
> +                goto error_cleanup;
> +            }
> +            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
> +
> +            cur_ent += CT3_CDAT_NUM_ENTRIES;
> +            region_base += ct3d->dc.regions[i].len;
> +        }
> +    }
> +
>      assert(len == cur_ent);
>  
>      *cdat_table = g_steal_pointer(&table);
> @@ -435,11 +479,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>              range2_size_hi = ct3d->hostpmem->size >> 32;
>              range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                               (ct3d->hostpmem->size & 0xF0000000);
> +        } else if (ct3d->dc.host_dc) {
> +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->dc.host_dc->size & 0xF0000000);
>          }
> -    } else {
> +    } else if (ct3d->hostpmem) {
>          range1_size_hi = ct3d->hostpmem->size >> 32;
>          range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
>                           (ct3d->hostpmem->size & 0xF0000000);
> +        if (ct3d->dc.host_dc) {
> +            range2_size_hi = ct3d->dc.host_dc->size >> 32;
> +            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->dc.host_dc->size & 0xF0000000);
> +        }
> +    } else {
> +        range1_size_hi = ct3d->dc.host_dc->size >> 32;
> +        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
> +            (ct3d->dc.host_dc->size & 0xF0000000);
>      }
I think we concluded in that other thread that DCD doesn't belong in here
at all?  I'll leave it for now though.

>  
>      dvsec = (uint8_t *)&(CXLDVSECDevice){
> @@ -708,7 +765,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>  }
>  
>  /*
> - * Create a dc region to test "Get Dynamic Capacity Configuration" command.
> + * Create dc regions.
> + * TODO: region parameters are hard coded, may need to change in the future.
>   */
>  static int cxl_create_dc_regions(CXLType3Dev *ct3d)
>  {
> @@ -739,7 +797,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
>  
> -    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
> +            && !ct3d->dc.num_regions) {
>          error_setg(errp, "at least one memdev property must be set");
>          return false;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
> @@ -807,6 +866,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          return false;
>      }
>  
> +    ct3d->dc.total_capacity = 0;
> +    if (ct3d->dc.host_dc) {
> +        MemoryRegion *dc_mr;
> +        char *dc_name;
> +        uint64_t total_region_size = 0;
> +        int i;
> +
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        if (!dc_mr) {
> +            error_setg(errp, "dynamic capacity must have backing device");
> +            return false;
> +        }
> +        /* FIXME: set dc as nonvolatile for now */

Yup. This is where we need to think about interface, or decide
that no one cares about PMEM DCD on basis it's a pain to deal with
and I think some stuff is still not well defined in the spec.

> +        memory_region_set_nonvolatile(dc_mr, true);
> +        memory_region_set_enabled(dc_mr, true);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> +        if (ds->id) {
> +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> +        } else {
> +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> +        }
> +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> +
> +        for (i = 0; i < ct3d->dc.num_regions; i++) {
> +            total_region_size += ct3d->dc.regions[i].len;
> +        }
> +        /* Make sure the host backend is large enough to cover all dc range */
> +        if (total_region_size > memory_region_size(dc_mr)) {
> +            error_setg(errp,
> +                "too small host backend size, increase to %lu MiB or more",
> +                total_region_size / 1024 / 1024);

/ MiB

> +            return false;
> +        }
> +
> +        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
> +            error_setg(errp, "DC region size is unaligned to %lx",
> +                    CXL_CAPACITY_MULTIPLIER);
> +            return false;
> +        }
> +
> +        ct3d->dc.total_capacity = total_region_size;
> +        g_free(dc_name);
> +    }
> +
>      return true;
>  }
>  
> @@ -916,6 +1019,9 @@ err_release_cdat:
>  err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
> +    if (ct3d->dc.host_dc) {
> +        address_space_destroy(&ct3d->dc.host_dc_as);
> +    }
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -935,6 +1041,9 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_doe_cdat_release(cxl_cstate);
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
> +    if (ct3d->dc.host_dc) {
> +        address_space_destroy(&ct3d->dc.host_dc_as);
> +    }
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -999,16 +1108,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>                                         AddressSpace **as,
>                                         uint64_t *dpa_offset)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size = memory_region_size(vmr);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size = memory_region_size(pmr);
> +    }
> +    if (ct3d->dc.host_dc) {
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        /* Do we want dc_size to be dc_mr->size or not?? */

yes, I think we do. No need for qemu to care about remapping and complex
allocation strategies.  The host can't tell if we are doing that or not
anyway.

> +        dc_size = ct3d->dc.total_capacity;
>      }
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return -ENODEV;
>      }
>  
> @@ -1016,19 +1133,19 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>          return -EINVAL;
>      }
>  
> -    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
> +    if ((*dpa_offset >= vmr_size + pmr_size + dc_size) ||
> +       (*dpa_offset >= vmr_size + pmr_size && ct3d->dc.num_regions == 0)) {
>          return -EINVAL;
>      }
>  
> -    if (vmr) {
> -        if (*dpa_offset < memory_region_size(vmr)) {
> -            *as = &ct3d->hostvmem_as;
> -        } else {
> -            *as = &ct3d->hostpmem_as;
> -            *dpa_offset -= memory_region_size(vmr);
> -        }
> -    } else {
> +    if (*dpa_offset < vmr_size) {
> +        *as = &ct3d->hostvmem_as;
> +    } else if (*dpa_offset < vmr_size + pmr_size) {
>          *as = &ct3d->hostpmem_as;
> +        *dpa_offset -= vmr_size;
> +    } else {
> +        *as = &ct3d->dc.host_dc_as;
> +        *dpa_offset -= (vmr_size + pmr_size);
>      }
>  
>      return 0;
> @@ -1101,6 +1218,8 @@ static Property ct3_props[] = {
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> +    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
> +                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),

I think we will want a more adaptable interface for this, but I'll apply with this for now
so we have something to iterate on.

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -1167,33 +1286,43 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>  
>  static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
>      AddressSpace *as;
> +    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        vmr_size = memory_region_size(vmr);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        pmr_size = memory_region_size(pmr);
>      }
> +    if (ct3d->dc.host_dc) {
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        dc_size = ct3d->dc.total_capacity;
> +     }
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return false;
>      }
>  
> -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
> +    if (dpa_offset >= vmr_size + pmr_size + dc_size) {

What is reasoning behind not having offset + cacheline size here?
DC blocks are multiples of CXL_CACHE_LINE_SIZE anyway.


> +        return false;
> +    }
> +    if (dpa_offset + CXL_CACHE_LINE_SIZE >= vmr_size + pmr_size
> +            && ct3d->dc.num_regions == 0) {

This is getting messy - we have the dc_size set above on basis
of one condition and this checked on num_regions.

Need to only allow backed regions to keep this simpler.

>          return false;
>      }

