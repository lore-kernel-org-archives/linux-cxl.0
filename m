Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23DD5C77B75
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 15:22:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242411AbjEOPWb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 11:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242405AbjEOPWY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 11:22:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5B22137
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 08:22:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKjkh4JzHz67lp8;
        Mon, 15 May 2023 23:21:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 16:22:13 +0100
Date:   Mon, 15 May 2023 16:22:12 +0100
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
Subject: Re: [RFC 7/7] hw/mem/cxl_type3: add read/write support to dynamic
 capacity
Message-ID: <20230515162212.0000275c@Huawei.com>
In-Reply-To: <20230511175609.2091136-8-fan.ni@samsung.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d@uscas1p2.samsung.com>
        <20230511175609.2091136-8-fan.ni@samsung.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Before the change, read from or write to dynamic capacity of the memory
> device is not support as 1) no host backed file/memory is provided for
> it; 2) no address space is created for the dynamic capacity.

Ah nice. I should have read ahead.  Probably makes sense to reorder things
so that when we present DCD region it will work.

> 
> With the change, add code to support following:
> 1. add a new property to type3 device "dc-memdev" to point to host
>    memory backend for dynamic capacity;
> 2. add a bitmap for each region to track whether a block is host backed,
> which will be used for address check when read/write dynamic capacity;
> 3. add namespace for dynamic capacity for read/write support;
> 4. create cdat entries for each dynamic capacity region;
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
> ---
>  hw/cxl/cxl-mailbox-utils.c  |  21 ++-
>  hw/mem/cxl_type3.c          | 336 +++++++++++++++++++++++++++++-------
>  include/hw/cxl/cxl_device.h |   8 +-
>  3 files changed, 298 insertions(+), 67 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7212934627..efe61e67fb 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -391,9 +391,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
>          char fw_rev4[0x10];
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
> +	CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>  
>      if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> -        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
> +			(cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||

Keep old alignment

> +		(ct3d->dc.total_dynamic_capicity < CXL_CAPACITY_MULTIPLIER)) {

We should think about the separation between what goes in cxl_dstate and directly
in ct3d. That boundary has been blurring for a while and getting some review
comments.

>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -534,7 +536,9 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> +		(!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +		(!QEMU_IS_ALIGNED(ct3d->dc.total_dynamic_capicity,
> +						CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -543,7 +547,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>  
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
>  
> -    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIER);
> +	stq_le_p(&id->total_capacity,
> +			cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);

Pull the rename out as a precursor patch.

>      stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_MULTIPLIER);
>      stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
> @@ -568,9 +573,12 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
>          uint64_t next_pmem;
>      } QEMU_PACKED *part_info = (void *)cmd->payload;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
> +	CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>  
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> -        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
> +		(!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
> +		(!QEMU_IS_ALIGNED(ct3d->dc.total_dynamic_capicity,
> +						CXL_CAPACITY_MULTIPLIER))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
>  
> @@ -881,9 +889,8 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>      struct clear_poison_pl *in = (void *)cmd->payload;
>  
>      dpa = ldq_le_p(&in->dpa);
> -    if (dpa + 64 > cxl_dstate->mem_size) {
> -        return CXL_MBOX_INVALID_PA;
> -    }
> +	if (dpa + 64 > cxl_dstate->static_mem_size && ct3d->dc.num_regions == 0)

This test will need expanding to include DPAs in DC regions.

> +		return CXL_MBOX_INVALID_PA;
>  
>      QLIST_FOREACH(ent, poison_list, node) {
>          /*
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 70d47d43b9..334660bd0f 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -33,8 +33,8 @@ enum {
>  };
>  
>  static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> -                                         int dsmad_handle, MemoryRegion *mr,
> -                                         bool is_pmem, uint64_t dpa_base)
> +		int dsmad_handle, uint8_t flags,
> +		uint64_t dpa_base, uint64_t size)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;
> @@ -53,9 +53,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>              .length = sizeof(*dsmas),
>          },
>          .DSMADhandle = dsmad_handle,
> -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +		.flags = flags,
>          .DPA_base = dpa_base,
> -        .DPA_length = int128_get64(mr->size),
> +		.DPA_length = size,
>      };
>  
>      /* For now, no memory side cache, plausiblish numbers */
> @@ -137,9 +137,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>           * NV: Reserved - the non volatile from DSMAS matters
>           * V: EFI_MEMORY_SP
>           */
> -        .EFI_memory_type_attr = is_pmem ? 2 : 1,
> +		.EFI_memory_type_attr = flags ? 2 : 1,

Fix all these alignment changes (spaces vs tabs)

>          .DPA_offset = 0,
> -        .DPA_length = int128_get64(mr->size),
> +		.DPA_length = size,
>      };
>  
>      /* Header always at start of structure */
> @@ -158,14 +158,15 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      g_autofree CDATSubHeader **table = NULL;
>      CXLType3Dev *ct3d = priv;
>      MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
> +	MemoryRegion *dc_mr = NULL;
>      int dsmad_handle = 0;
>      int cur_ent = 0;
>      int len = 0;
>      int rc, i;
> +	uint64_t vmr_size = 0, pmr_size = 0;
>  
> -    if (!ct3d->hostpmem && !ct3d->hostvmem) {
> -        return 0;
> -    }
> +	if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions)
> +		return 0;
>  
>      if (ct3d->hostvmem) {
>          volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
> @@ -173,6 +174,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>              return -EINVAL;
>          }
>          len += CT3_CDAT_NUM_ENTRIES;
> +		vmr_size = volatile_mr->size;
>      }
>  
>      if (ct3d->hostpmem) {
> @@ -181,7 +183,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>              return -EINVAL;
>          }
>          len += CT3_CDAT_NUM_ENTRIES;
> -    }
> +		pmr_size = nonvolatile_mr->size;
> +	}
> +
> +	if (ct3d->dc.num_regions) {
> +		if (ct3d->dc.host_dc) {
> +			dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +			if (!dc_mr)
> +				return -EINVAL;
> +			len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> +		} else {
> +			return -EINVAL;
> +		}
> +	}
>  
>      table = g_malloc0(len * sizeof(*table));
>      if (!table) {
> @@ -189,23 +203,45 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      }
>  
>      /* Now fill them in */
> -    if (volatile_mr) {
> -        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
> -                                           false, 0);
> -        if (rc < 0) {
> -            return rc;
> -        }
> -        cur_ent = CT3_CDAT_NUM_ENTRIES;
> -    }
> +	if (volatile_mr) {
> +		rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
> +				0, 0, vmr_size);
> +		if (rc < 0)
> +			return rc;
Without the tabs / spaces accidental conversion this diff should look a lot
clearer..
> +		cur_ent = CT3_CDAT_NUM_ENTRIES;
> +	}
> +
> +	if (nonvolatile_mr) {
> +		rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> +				CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);
> +		if (rc < 0)
> +			goto error_cleanup;
> +		cur_ent += CT3_CDAT_NUM_ENTRIES;
> +	}
> +
> +	if (dc_mr) {
> +		uint64_t region_base = vmr_size + pmr_size;
> +
> +		/*
> +		 * Currently we create cdat entries for each region, should we only
> +		 * create dsmas table instead??

I don't think it does any harm to have a lot of similar entries. We may want to reconsider
this in the longer term to make sure that more complex code paths are handled where
things are shared.  What combinations does the spec allow?
One entry for all regions with them all sharing a single dsmad handle?


> +		 * We assume all dc regions are non-volatile for now.
> +		 *
> +		 */
> +		for (i = 0; i < ct3d->dc.num_regions; i++) {
> +			rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent])
> +					, dsmad_handle++
> +					, CDAT_DSMAS_FLAG_NV|CDAT_DSMAS_FLAG_DYNAMIC_CAP
> +					, region_base, ct3d->dc.regions[i].len);
> +			if (rc < 0)
> +				goto error_cleanup;
> +			ct3d->dc.regions[i].dsmadhandle = dsmad_handle-1;
> +
> +			cur_ent += CT3_CDAT_NUM_ENTRIES;
> +			region_base += ct3d->dc.regions[i].len;
> +		}
> +	}
>  
> -    if (nonvolatile_mr) {
> -        rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
> -                nonvolatile_mr, true, (volatile_mr ? volatile_mr->size : 0));
> -        if (rc < 0) {
> -            goto error_cleanup;
> -        }
> -        cur_ent += CT3_CDAT_NUM_ENTRIES;
> -    }
>      assert(len == cur_ent);
>  
>      *cdat_table = g_steal_pointer(&table);
> @@ -706,6 +742,11 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
>  		/* dsmad_handle is set when creating cdat table entries */
>  		region->flags = 0;
>  
> +		region->blk_bitmap = bitmap_new(region->len / region->block_size);
> +		if (!region->blk_bitmap)
> +			return -1;
> +		bitmap_zero(region->blk_bitmap, region->len / region->block_size);
> +
>  		region_base += region->len;
>  	}
>  	QTAILQ_INIT(&ct3d->dc.extents);
> @@ -713,11 +754,24 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
>  	return 0;
>  }
>  
> +static void cxl_destroy_toy_regions(CXLType3Dev *ct3d)

Why toy?  They work after this so no longer toys ;)

> +{
> +	int i;
> +	struct CXLDCD_Region *region;
> +
> +	for (i = 0; i < ct3d->dc.num_regions; i++) {
> +		region = &ct3d->dc.regions[i];
> +		if (region->blk_bitmap)
> +			g_free(region->blk_bitmap);
Why is check needed? Is there a path where we call this function
without the bitmap having been allocated successfully?

> +	}
> +}
> +
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
>  
> -    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> +	if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
> +			&& !ct3d->dc.num_regions) {
>          error_setg(errp, "at least one memdev property must be set");
>          return false;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
> @@ -754,7 +808,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          }
>          address_space_init(&ct3d->hostvmem_as, vmr, v_name);
>          ct3d->cxl_dstate.vmem_size = vmr->size;
> -        ct3d->cxl_dstate.mem_size += vmr->size;
> +		ct3d->cxl_dstate.static_mem_size += vmr->size;
>          g_free(v_name);
>      }
>  
> @@ -777,12 +831,47 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          }
>          address_space_init(&ct3d->hostpmem_as, pmr, p_name);
>          ct3d->cxl_dstate.pmem_size = pmr->size;
> -        ct3d->cxl_dstate.mem_size += pmr->size;
> +		ct3d->cxl_dstate.static_mem_size += pmr->size;
>          g_free(p_name);
>      }
>  
> -	if (cxl_create_toy_regions(ct3d))
> -		return false;
> +	ct3d->dc.total_dynamic_capicity = 0;
> +	if (ct3d->dc.host_dc) {
> +		MemoryRegion *dc_mr;
> +		char *dc_name;
> +		uint64_t total_region_size = 0;
> +		int i;
> +
> +		dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +		if (!dc_mr) {
> +			error_setg(errp, "dynamic capacity must have backing device");
> +			return false;

> +		}
> +		/* FIXME: set dc as nonvolatile for now */
That's fine. I think to do anything else we'll want multiple backends anyway.
Perhaps rename the parameter to reflect that it's volatile for now though otherwise
we'll end up deprecating another memory region command line parameter and people will
begin to get grumpy ;)

> +		memory_region_set_nonvolatile(dc_mr, true);
> +		memory_region_set_enabled(dc_mr, true);
> +		host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> +		if (ds->id) {
> +			dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> +		} else {
> +			dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> +		}
> +		address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> +
> +		if (cxl_create_toy_regions(ct3d)) {
> +			return false;
> +		}
> +
> +		for (i = 0; i < ct3d->dc.num_regions; i++) {
> +			total_region_size += ct3d->dc.regions[i].len;
> +		}
> +		/* Make sure the host backend is large enough to cover all dc range */
> +		assert(total_region_size <= dc_mr->size);
> +		assert(dc_mr->size % (256*1024*1024) == 0);
> +
> +		ct3d->dc.total_dynamic_capicity = total_region_size;
> +		g_free(dc_name);
> +	}
>  
>      return true;
>  }
> @@ -890,6 +979,10 @@ err_release_cdat:
>  err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
> +	if (ct3d->dc.host_dc) {
> +		cxl_destroy_toy_regions(ct3d);
> +		address_space_destroy(&ct3d->dc.host_dc_as);
> +	}
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -909,6 +1002,10 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_doe_cdat_release(cxl_cstate);
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
> +	if (ct3d->dc.host_dc) {
> +		cxl_destroy_toy_regions(ct3d);
> +		address_space_destroy(&ct3d->dc.host_dc_as);
> +	}
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -917,6 +1014,100 @@ static void ct3_exit(PCIDevice *pci_dev)
>      }
>  }
>  
> +static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +		uint64_t len)
> +{
> +	int i;
> +	CXLDCD_Region *region = NULL;
> +
> +	if (dpa < ct3d->dc.regions[0].base
> +		|| dpa >= ct3d->dc.regions[0].base + ct3d->dc.total_dynamic_capicity)
> +		return;
> +
> +	/*
> +	 * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> +	 * Region 0 being used for the lowest DPA of Dynamic Capacity and
> +	 * Region 7 for the highest DPA.
> +	 * So we check from the last region to find where the dpa belongs.
> +	 * access across multiple regions is not allowed.
> +	 **/
> +	for (i = ct3d->dc.num_regions-1; i >= 0; i--) {
> +		region = &ct3d->dc.regions[i];
> +		if (dpa >= region->base)
> +			break;
> +	}
> +
> +	bitmap_set(region->blk_bitmap, (dpa-region->base)/region->block_size,
> +			len/region->block_size);
> +}
> +
> +static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +		uint64_t len)
> +{
> +	int i;
> +	CXLDCD_Region *region = NULL;
> +	uint64_t nbits;
> +	long nr;
> +
> +	if (dpa < ct3d->dc.regions[0].base
> +		   || dpa >= ct3d->dc.regions[0].base + ct3d->dc.total_dynamic_capicity)
> +		return false;
> +
> +	/*
> +	 * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> +	 * Region 0 being used for the lowest DPA of Dynamic Capacity and
> +	 * Region 7 for the highest DPA.
> +	 * So we check from the last region to find where the dpa belongs.
> +	 * access across multiple regions is not allowed.
> +	 **/
> +	for (i = ct3d->dc.num_regions-1; i >= 0; i--) {
> +		region = &ct3d->dc.regions[i];
> +		if (dpa >= region->base)
> +			break;
> +	}
> +
> +	nr = (dpa-region->base)/region->block_size;
> +	nbits = (len + region->block_size-1)/region->block_size;
> +	if (find_next_zero_bit(region->blk_bitmap, nr+nbits, nr)
> +			>= nr+nbits)
> +		return true;
> +
> +	return false;

return find_next_zero_bit(...) >= nr + nbits;

> +}
> +
> +static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> +		uint64_t len)
> +{
> +	int i;
> +	CXLDCD_Region *region = NULL;
> +	uint64_t nbits;
> +	long nr;
> +
> +	if (dpa < ct3d->dc.regions[0].base
> +		|| dpa >= ct3d->dc.regions[0].base + ct3d->dc.total_dynamic_capicity)
> +		return;
> +
> +	/*
> +	 * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
> +	 * Region 0 being used for the lowest DPA of Dynamic Capacity and
> +	 * Region 7 for the highest DPA.
> +	 * So we check from the last region to find where the dpa belongs.
> +	 * access across multiple regions is not allowed.
> +	 **/
> +	for (i = ct3d->dc.num_regions-1; i >= 0; i--) {
> +		region = &ct3d->dc.regions[i];
> +		if (dpa >= region->base)
> +			break;
> +	}
> +
> +	nr = (dpa-region->base) / region->block_size;
> +	nbits = (len + region->block_size-1) / region->block_size;

Why handle non precise multiple?  

> +	for (i = 0; i < nbits; i++) {
> +		clear_bit(nr, region->blk_bitmap);
> +		nr++;
> +	}

bitmap_clear()?



> +
>  static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
>  {
>      uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
> @@ -973,16 +1164,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>                                         AddressSpace **as,
>                                         uint64_t *dpa_offset)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +	MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
> +	uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +		vmr_size = int128_get64(vmr->size);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +		pmr_size = int128_get64(pmr->size);
>      }
> +	if (ct3d->dc.host_dc) {
> +		dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +		/* Do we want dc_size to be dc_mr->size or not?? */
> +		dc_size = ct3d->dc.total_dynamic_capicity;
> +	}
>  
> -    if (!vmr && !pmr) {
> +	if (!vmr && !pmr && !dc_mr) {
>          return -ENODEV;
>      }
>  
> @@ -990,20 +1189,22 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>          return -EINVAL;
>      }
>  
> -    if (*dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +    if (*dpa_offset >= vmr_size + pmr_size + dc_size ||
> +       (*dpa_offset >= vmr_size + pmr_size && ct3d->dc.num_regions == 0)) {
>          return -EINVAL;
>      }
>  
> -    if (vmr) {
> -        if (*dpa_offset < int128_get64(vmr->size)) {
> -            *as = &ct3d->hostvmem_as;
> -        } else {
> -            *as = &ct3d->hostpmem_as;
> -            *dpa_offset -= vmr->size;
> -        }
> -    } else {
> -        *as = &ct3d->hostpmem_as;
> -    }
> +	if (*dpa_offset < vmr_size)
> +		*as = &ct3d->hostvmem_as;
> +	else if (*dpa_offset < vmr_size + pmr_size) {
> +		*as = &ct3d->hostpmem_as;
> +		*dpa_offset -= vmr_size;
> +	} else {
> +		if (!test_region_block_backed(ct3d, *dpa_offset, size))
> +			return -ENODEV;
> +		*as = &ct3d->dc.host_dc_as;
> +		*dpa_offset -= (vmr_size + pmr_size);
> +	}
>  
>      return 0;
>  }
> @@ -1069,6 +1270,8 @@ static Property ct3_props[] = {
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
>  	DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> +	DEFINE_PROP_LINK("dc-memdev", CXLType3Dev, dc.host_dc,
> +					TYPE_MEMORY_BACKEND, HostMemoryBackend *),

Perhaps volatile-dc-memdev?  leaves us space for a persistent one in future.
If anyone every cares that is ;)

>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -1135,34 +1338,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>  
>  static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
>  {
> -    MemoryRegion *vmr = NULL, *pmr = NULL;
> +	MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
>      AddressSpace *as;
> +	uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
>  
>      if (ct3d->hostvmem) {
>          vmr = host_memory_backend_get_memory(ct3d->hostvmem);
> +		vmr_size = int128_get64(vmr->size);
>      }
>      if (ct3d->hostpmem) {
>          pmr = host_memory_backend_get_memory(ct3d->hostpmem);
> +		pmr_size = int128_get64(pmr->size);
>      }
> +	if (ct3d->dc.host_dc) {
> +		dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +		dc_size = ct3d->dc.total_dynamic_capicity;
> +	}
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return false;
>      }
>  
> -    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
> -        return false;
> -    }
> +	if (dpa_offset >= vmr_size + pmr_size + dc_size)
> +		return false;
> +	if (dpa_offset + 64 >= vmr_size + pmr_size && ct3d->dc.num_regions == 0)
> +		return false;
>  
> -    if (vmr) {
> -        if (dpa_offset <= int128_get64(vmr->size)) {
> -            as = &ct3d->hostvmem_as;
> -        } else {
> -            as = &ct3d->hostpmem_as;
> -            dpa_offset -= vmr->size;
> -        }
> -    } else {
> -        as = &ct3d->hostpmem_as;
> -    }
> +	if (dpa_offset < vmr_size) {
> +		as = &ct3d->hostvmem_as;
> +	} else if (dpa_offset < vmr_size + pmr_size) {
> +		as = &ct3d->hostpmem_as;
> +		dpa_offset -= vmr->size;
> +	} else {
> +		as = &ct3d->dc.host_dc_as;
> +		dpa_offset -= (vmr_size + pmr_size);
> +	}
>  
>      address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64);
>      return true;
> @@ -1711,6 +1921,14 @@ static void qmp_cxl_process_dynamic_capacity_event(const char *path, CxlEventLog
>  		memcpy(&dCap.dynamic_capacity_extent, &extents[i]
>  				, sizeof(CXLDCExtent_raw));
>  
> +		if (dCap.type == 0x0)

Enum values as suggested in earlier patch.

> +			set_region_block_backed(dcd, extents[i].start_dpa, extents[i].len);
> +		else if (dCap.type == 0x1)
> +			clear_region_block_backed(dcd, extents[i].start_dpa,
> +					extents[i].len);
> +		else
> +			error_setg(errp, "DC event not support yet, no bitmap op");
> +
>  		if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
>  					(CXLEventRecordRaw *)&dCap)) {
>  			;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index c0c8fcc24b..d9b6776e2c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -211,7 +211,7 @@ typedef struct cxl_device_state {
>      } timestamp;
>  
>      /* memory region size, HDM */
> -    uint64_t mem_size;
> +	uint64_t static_mem_size;
>      uint64_t pmem_size;
>      uint64_t vmem_size;
>  
> @@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
>  	uint64_t block_size;
>  	uint32_t dsmadhandle;
>  	uint8_t flags;
> +	unsigned long *blk_bitmap;
>  } CXLDCD_Region;
>  
>  struct CXLType3Dev {
> @@ -447,12 +448,17 @@ struct CXLType3Dev {
>      uint64_t poison_list_overflow_ts;
>  
>  	struct dynamic_capacity {
> +		HostMemoryBackend *host_dc;
> +		AddressSpace host_dc_as;
> +
> +		uint8_t num_hosts; //Table 7-55

Not visible here as far as I can see. So leave it for now.

>  		uint8_t num_regions; // 1-8
>  		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
>  		CXLDCDExtentList extents;
>  
>  		uint32_t total_extent_count;
>  		uint32_t ext_list_gen_seq;
> +		uint64_t total_dynamic_capicity; // 256M aligned
capacity

>  	} dc;
>  };
>  

