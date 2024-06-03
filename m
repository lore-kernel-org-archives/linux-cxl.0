Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C1D12BEBE
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 12:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717417687; cv=none; b=vFjmhXPRLdTQEZ5PwlJSO43HdgxvJbas/PvDT1UwunboiujfLfN7w7dE80P8TJ/oQNnCPm1vItnALZtt8rrl9H2yL4r7q6SVxVYoXJZFswF4Yywx7Uz9euY/KV/ZjX05tZv3XrSWc/OCHqAMEhe5H20wgDt1VAR9P2QCVqsvQ3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717417687; c=relaxed/simple;
	bh=0L7sW7MJ6pmx+dXJA8Rayt7dtePWEGP2UJNCtJoVFqw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s7E2MjYpcxgOu7uSoKxNF7yc4dW56wVcYSXWdbc7+szhjw+4FXz+y6eKN9SE+9AfuCA7Bohh13LUurdYNHyyyXeti7tW9dHOeL2hhCIZvRAAqJaBVmojPYA1dVWKD5QcCTjwPW0gFbtPr/Z6wfVJgl/u+qWbJWUb+oJHS7UttDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VtCdn00Bnz6K9RV;
	Mon,  3 Jun 2024 20:26:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0A02A14011D;
	Mon,  3 Jun 2024 20:28:01 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Mon, 3 Jun
 2024 13:28:00 +0100
Date: Mon, 3 Jun 2024 13:27:59 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, <armbru@redhat.com>,
	<mst@redhat.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v8 08/14] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240603132759.00005fbf@Huawei.com>
In-Reply-To: <20240523174651.1089554-9-nifan.cxl@gmail.com>
References: <20240523174651.1089554-1-nifan.cxl@gmail.com>
	<20240523174651.1089554-9-nifan.cxl@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 23 May 2024 10:44:48 -0700
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend for DCD. All the dynamic capacity
> regions will share a single, large enough host backend. Set up address
> space for DC regions to support read/write operations to dynamic capacity
> for DCD.
> 
> With the change, the following support is added:
> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all DC regions share one
>    host backend;
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region.
> 
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

>      dvsec = (uint8_t *)&(CXLDVSECDevice){
> @@ -579,11 +622,28 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>  {
>      int i;
>      uint64_t region_base = 0;
> -    uint64_t region_len =  2 * GiB;
> -    uint64_t decode_len = 2 * GiB;
> +    uint64_t region_len;
> +    uint64_t decode_len;
>      uint64_t blk_size = 2 * MiB;
>      CXLDCRegion *region;
>      MemoryRegion *mr;
> +    uint64_t dc_size;
> +
> +    mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +    dc_size = memory_region_size(mr);
> +    region_len = DIV_ROUND_UP(dc_size, ct3d->dc.num_regions);
> +
> +    if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLIER) != 0) {
> +        error_setg(errp, "backend size is not multiple of region len: 0x%lx",

Just seen a build error for this in mst's gitlab.
Needs to be the messy PRIx64(not tested) e.g.

    error_setg(errp, "backend size is not multiple of region len: " PRIx64,
               region_len);

Michael, do you want a new version, or are you happy to fix this up?

Thanks,

Jonathan

> +                   region_len);
> +        return false;
> +    }
> +    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
> +        error_setg(errp, "DC region size is unaligned to 0x%lx",
> +                   CXL_CAPACITY_MULTIPLIER);
> +        return false;
> +    }
> +    decode_len = region_len;
>  
>      if (ct3d->hostvmem) {
>          mr = host_memory_backend_get_memory(ct3d->hostvmem);
> @@ -610,6 +670,7 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
>              /* dsmad_handle set when creating CDAT table entries */
>              .flags = 0,
>          };
> +        ct3d->dc.total_capacity += region->len;
>      }
>  
>      return true;
> @@ -619,7 +680,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
>  
> -    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
> +        && !ct3d->dc.num_regions) {
>          error_setg(errp, "at least one memdev property must be set");
>          return false;
>      } else if (ct3d->hostmem && ct3d->hostpmem) {
> @@ -683,7 +745,37 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          g_free(p_name);
>      }
>  
> +    ct3d->dc.total_capacity = 0;
>      if (ct3d->dc.num_regions > 0) {
> +        MemoryRegion *dc_mr;
> +        char *dc_name;
> +
> +        if (!ct3d->dc.host_dc) {
> +            error_setg(errp, "dynamic capacity must have a backing device");
> +            return false;
> +        }
> +
> +        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +        if (!dc_mr) {
> +            error_setg(errp, "dynamic capacity must have a backing device");
> +            return false;
> +        }
> +
> +        /*
> +         * Set DC regions as volatile for now, non-volatile support can
> +         * be added in the future if needed.
> +         */
> +        memory_region_set_nonvolatile(dc_mr, false);
> +        memory_region_set_enabled(dc_mr, true);
> +        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
> +        if (ds->id) {
> +            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
> +        } else {
> +            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
> +        }
> +        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
> +        g_free(dc_name);
> +
>          if (!cxl_create_dc_regions(ct3d, errp)) {
>              error_append_hint(errp, "setup DC regions failed");
>              return false;
> @@ -779,6 +871,9 @@ err_release_cdat:
>  err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
> +    if (ct3d->dc.host_dc) {
> +        address_space_destroy(&ct3d->dc.host_dc_as);
> +    }
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -797,6 +892,9 @@ static void ct3_exit(PCIDevice *pci_dev)
>      pcie_aer_exit(pci_dev);
>      cxl_doe_cdat_release(cxl_cstate);
>      g_free(regs->special_ops);
> +    if (ct3d->dc.host_dc) {
> +        address_space_destroy(&ct3d->dc.host_dc_as);
> +    }
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
> @@ -875,16 +973,23 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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
> +        dc_size = memory_region_size(dc_mr);
>      }
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return -ENODEV;
>      }
>  
> @@ -892,19 +997,18 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
>          return -EINVAL;
>      }
>  
> -    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
> +    if (*dpa_offset >= vmr_size + pmr_size + dc_size) {
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
> @@ -986,6 +1090,8 @@ static Property ct3_props[] = {
>      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> +    DEFINE_PROP_LINK("volatile-dc-memdev", CXLType3Dev, dc.host_dc,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> @@ -1052,33 +1158,39 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
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
> +        dc_size = memory_region_size(dc_mr);
> +     }
>  
> -    if (!vmr && !pmr) {
> +    if (!vmr && !pmr && !dc_mr) {
>          return false;
>      }
>  
> -    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
> +    if (dpa_offset + CXL_CACHE_LINE_SIZE > vmr_size + pmr_size + dc_size) {
>          return false;
>      }
>  
> -    if (vmr) {
> -        if (dpa_offset < memory_region_size(vmr)) {
> -            as = &ct3d->hostvmem_as;
> -        } else {
> -            as = &ct3d->hostpmem_as;
> -            dpa_offset -= memory_region_size(vmr);
> -        }
> -    } else {
> +    if (dpa_offset < vmr_size) {
> +        as = &ct3d->hostvmem_as;
> +    } else if (dpa_offset < vmr_size + pmr_size) {
>          as = &ct3d->hostpmem_as;
> +        dpa_offset -= vmr_size;
> +    } else {
> +        as = &ct3d->dc.host_dc_as;
> +        dpa_offset -= (vmr_size + pmr_size);
>      }
>  
>      address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index f7f56b44e3..c2c3df0d2a 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -467,6 +467,14 @@ struct CXLType3Dev {
>      uint64_t poison_list_overflow_ts;
>  
>      struct dynamic_capacity {
> +        HostMemoryBackend *host_dc;
> +        AddressSpace host_dc_as;
> +        /*
> +         * total_capacity is equivalent to the dynamic capability
> +         * memory region size.
> +         */
> +        uint64_t total_capacity; /* 256M aligned */
> +
>          uint8_t num_regions; /* 0-8 regions */
>          CXLDCRegion regions[DCD_MAX_NUM_REGION];
>      } dc;

