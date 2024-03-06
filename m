Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC75D1353EC
	for <linux-cxl@vger.kernel.org>; Wed,  6 Mar 2024 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740174; cv=none; b=h+rSH4vWuAPkZg2Vs9wLJ+k8SoeK1uAXcF/4u84hiNwXY04XcEohBRJ0DahFBoNpaYpJtS57lo/fUCm/366eetZrxsLNL/UFWGgeDkhnzoeoBXh6eCzDS7MhdLMGpnqJv0UJzH9+yFpBXhJB8ogrlmKqe3tfSIeLO12aXe9VTBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740174; c=relaxed/simple;
	bh=A+oIgPsLp9gLQhwfYD9hujnTn6hy5yOD26/NXTvcWgI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GpNrsoOT7R3FLo+Af0h81RPrUvTBkU+otip0e7TKV4EeQ4jl0AaUh4i39q7V3es434XjbKxXBrm158o5W7+PrAUuRPXxghglGTCBx8FV6FsJgXt6rkihy9SbP1ou+7iFI+yPiu1VDtqeiAjLJxFn4UWjr+/5cEOBBUB7Z0+MAJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TqcG30SqFz6K7MC;
	Wed,  6 Mar 2024 23:45:31 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 0D6C7140CB9;
	Wed,  6 Mar 2024 23:49:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 6 Mar
 2024 15:48:54 +0000
Date: Wed, 6 Mar 2024 15:48:53 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<gregory.price@memverge.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <a.manzanares@samsung.com>, <dave@stgolabs.net>,
	<nmtadam.samsung@gmail.com>, <jim.harris@samsung.com>,
	<Jorgen.Hansen@wdc.com>, <wj28.lee@gmail.com>, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v5 04/13] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <20240306154853.00004c11@Huawei.com>
In-Reply-To: <20240304194331.1586191-5-nifan.cxl@gmail.com>
References: <20240304194331.1586191-1-nifan.cxl@gmail.com>
	<20240304194331.1586191-5-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  4 Mar 2024 11:33:59 -0800
nifan.cxl@gmail.com wrote:

> From: Fan Ni <fan.ni@samsung.com>
> 
> With the change, when setting up memory for type3 memory device, we can
> create DC regions.
> A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> number of DC regions to create. To make it easier, other region parameters
> like region base, length, and block size are hard coded. If needed,
> these parameters can be added easily.
> 
> With the change, we can create DC regions with proper kernel side
> support like below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
> echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
> echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> 
> echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> echo 1 > /sys/bus/cxl/devices/$region/commit
> echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>
Suggested changes are trivial formatting things
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  hw/mem/cxl_type3.c | 46 ++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 244d2b5fd5..a191211009 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -30,6 +30,7 @@
>  #include "hw/pci/msix.h"
>  
>  #define DWORD_BYTE 4
> +#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
>  
>  /* Default CDAT entries for a memory region */
>  enum {
> @@ -567,6 +568,45 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>      }
>  }
>  
> +/*
> + * TODO: dc region configuration will be updated once host backend and address
> + * space support is added for DCD.
> + */
> +static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> +{
> +    int i;
> +    uint64_t region_base = 0;
> +    uint64_t region_len =  2 * GiB;
> +    uint64_t decode_len = 2 * GiB;
> +    uint64_t blk_size = 2 * MiB;
> +    CXLDCRegion *region;
> +    MemoryRegion *mr;
> +
> +    if (ct3d->hostvmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostvmem);
> +        region_base += memory_region_size(mr);
> +    }
> +    if (ct3d->hostpmem) {
> +        mr = host_memory_backend_get_memory(ct3d->hostpmem);
> +        region_base += memory_region_size(mr);
> +    }
> +    assert(region_base % CXL_CAPACITY_MULTIPLIER == 0);
> +
> +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> +        region = &ct3d->dc.regions[i];
> +        region->base = region_base;
> +        region->decode_len = decode_len;
> +        region->len = region_len;
> +        region->block_size = blk_size;
> +        /* dsmad_handle is set when creating cdat table entries */
> +        region->flags = 0;
> +
> +        region_base += region->len;

Maybe make the loop update to do some or all of the variable updating
(perhaps all of them is a bit too complex!)

    for (i = 0, region = &ct3d->dc_regions[0];
         i < ct3d->dc.num_regions;
         i++, region++, region_base += region_len) {
Also, using this style of assignment will avoid lots of repetition of region.
        *region = (CXLDCRegion) {
            .base = region_base,
            .decode_len = decode_len,
            .len = region_len,
            .block_size = blk_size,
            /* dsmad_handle set when creating CDAT table entries */
            .flags = 0,
        };
    }

> +    }
> +
> +    return true;
> +}


