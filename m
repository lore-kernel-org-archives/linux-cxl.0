Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D1E5F853
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 16:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709742504; cv=none; b=JnqwWGeSHFoZx60Ps6+rXFktkUJOLNv0TR7MVIGDYEtVBvEzy0MCF9QF9OifJGQqkw3J6snXYNj3BukeZvbm+eEAPANBj+D/KyAi86FSJ5qBNDqYdtxkDTioo7256mURtYesV9IdEQztaR/WIaIsTxX1cu+f1thkunn5pRQJw+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709742504; c=relaxed/simple;
	bh=b87Y190fkMnMNK+7lqyaEd/NHNlp2X2mDcbmZNPpH+Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ymv591Evo2m7VJ+OFpLvN5kKouHZlopF4/2LaLXYnYYqU4z3EZWh7LCMadQIIw1QlvVEwlpgwB2fKn4JyL5r6R6FhgEaUjeUJERx6uHZdRZ0o7PeW/Sxehv+aIa3NbYaYB6q4PTl5GBKXnkS1Cx6vDpA19r4mXVOpAKY2DVpN00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tqd6r69FZz6K8tX;
	Thu,  7 Mar 2024 00:24:20 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E8F351400D7;
	Thu,  7 Mar 2024 00:28:17 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 16:28:17 +0000
Date: Wed, 6 Mar 2024 16:28:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 06/13] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Message-ID: <20240306162816.00002e0e@Huawei.com>
In-Reply-To: <20240304194331.1586191-7-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-7-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:34:01 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> Add (file/memory backed) host backend, all the dynamic capacity regions
> will share a single, large enough host backend. Set up address space for
> DC regions to support read/write operations to dynamic capacity for DCD.
> 
> With the change, following supports are added:
> 1. Add a new property to type3 device "volatile-dc-memdev" to point to host
>    memory backend for dynamic capacity. Currently, all dc regions share one
>    host backend.
> 2. Add namespace for dynamic capacity for read/write support;
> 3. Create cdat entries for each dynamic capacity region;
> 4. Fix dvsec range registers to include DC regions.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Hi Fan, 

This one has a few more significant comments inline.

thanks,

Jonathan

> ---

> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index c045fee32d..2b380a260b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -45,7 +45,8 @@ enum {
>  
>  static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>                                            int dsmad_handle, uint64_t size,
> -                                          bool is_pmem, uint64_t dpa_base)
> +                                          bool is_pmem, bool is_dynamic,
> +                                          uint64_t dpa_base)
>  {
>      g_autofree CDATDsmas *dsmas = NULL;
>      g_autofree CDATDslbis *dslbis0 = NULL;

There is a fixlet going through for these as the autofree doesn't do anything.
Will require a rebase.  I'll do it on my tree, but might not push that out for a
few days so this is just a heads up for anyone using these.

https://lore.kernel.org/qemu-devel/20240304104406.59855-1-thuth@redhat.com/

It went in clean for me, so may not even be something anyone notices!

> @@ -61,7 +62,8 @@ static void ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
>              .length = sizeof(*dsmas),
>          },
>          .DSMADhandle = dsmad_handle,
> -        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +        .flags = (is_pmem ? CDAT_DSMAS_FLAG_NV : 0) |
> +                 (is_dynamic ? CDAT_DSMAS_FLAG_DYNAMIC_CAP : 0),
>          .DPA_base = dpa_base,
>          .DPA_length = size,
>      };
> @@ -149,12 +151,13 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>      g_autofree CDATSubHeader **table = NULL;
>  
>  
> @@ -176,21 +179,55 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>          pmr_size = memory_region_size(nonvolatile_mr);
>      }
>  
> +    if (ct3d->dc.num_regions) {
> +        if (ct3d->dc.host_dc) {
> +            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
> +            if (!dc_mr) {
> +                return -EINVAL;
> +            }
> +            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
> +        } else {
> +            return -EINVAL;

Flip logic to get the error out the way first and reduce indent.

     if (ct3d->dc.num_regions) {
        if (!ct3d->dc.host_dc) {
            return -EINVAL;
        }
        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
        if (!dc_mr) {
            return -EINVAL;
        }
        len += CT3...
     }

> +        }
> +    }
> +

>  
>      *cdat_table = g_steal_pointer(&table);
> @@ -300,11 +337,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
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
> +                         (ct3d->dc.host_dc->size & 0xF0000000);

I've forgotten if we ever closed out on the right thing to do
with the legacy range registers.   Maybe, just ignoring DC is the
right option for now?  So I'd drop this block of changes.
Maybe Linux will do the wrong thing if we do, but then we should
make Linux more flexible on this.

If we did get a clarification that this is the right way to go
then add a note here.


>      }
>  
>      dvsec = (uint8_t *)&(CXLDVSECDevice){
> @@ -579,11 +629,27 @@ static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
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
> +    if (region_len * ct3d->dc.num_regions > dc_size) {
This check had me scratching my head for a minute.
Why not just check

	if (dc_size % (ct3d->dc.num_regions * CXL_CAPACITY_MULTIPLER) != 0) {
		error_setg(errp, "host backend must by a multiple of 256MiB and region len);
		return false;
	}
> +        error_setg(errp, "host backend size must be multiples of region len");
> +        return false;
> +    }
> +    if (region_len % CXL_CAPACITY_MULTIPLIER != 0) {
> +        error_setg(errp, "DC region size is unaligned to %lx",
> +                   CXL_CAPACITY_MULTIPLIER);
> +        return false;
> +    }
> +    decode_len = region_len;




> @@ -868,16 +974,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
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

Maybe - definitely don't want to leave this comment here
unanswered and I think you enforce it above anyway.

So if we get here ct3d->dc.total_capacity == memory_region_size(ct3d->dc.host_dc);
As such we could just not stash total_capacity at all?


> +        dc_size = ct3d->dc.total_capacity;
>      }

