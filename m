Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4972317C67
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jan 2024 15:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706109805; cv=none; b=TH/jHPuGe3kEx/T/Xi6GjvHKx/lKkrVnuTP//cWXdjNMLsG0HnDtRXYhQVnjWWonE5RaZ9YBPTZ9IGMULnGoCnYE7pPK/SxBsHTnfwhQoG93SxhQWKu+1uAE9R6ZlCHUSTLaxy+1nIhWzr3oordk5ZZepodo6rMytKYO4MBCe8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706109805; c=relaxed/simple;
	bh=uek02zkQikW6DC1JIzADspqurWDiGy9kjI+r4irAuVk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s22NjuIkfgIHhc0Iqc/43X9lWf0FcbkYos94cqgSRneyk+JhUgFvNdEl0Uz+EbyxzXmTSx2C+7zB9RZ4S2pbLWPIWy10IIGM+nvvahFK3Kzednjgisnf7wcGdmySCczS0WbUD3+UUE2vpCo+Lc/7vXbAzRWzbX/MQBqbv4u3g9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TKnhL0xfFz6J9jy;
	Wed, 24 Jan 2024 23:20:18 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 59A84140D1A;
	Wed, 24 Jan 2024 23:23:18 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 15:23:17 +0000
Date: Wed, 24 Jan 2024 15:23:16 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <nifan.cxl@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<ira.weiny@intel.com>, <dan.j.williams@intel.com>,
	<a.manzanares@samsung.com>, <dave@stgolabs.net>, <nmtadam.samsung@gmail.com>,
	<nifan@outlook.com>, <jim.harris@samsung.com>, "Fan Ni" <fan.ni@samsung.com>
Subject: Re: [PATCH v3 4/9] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <20240124152316.0000281c@Huawei.com>
In-Reply-To: <20231107180907.553451-5-nifan.cxl@gmail.com>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
	<20231107180907.553451-5-nifan.cxl@gmail.com>
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
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  7 Nov 2023 10:07:08 -0800
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
> support as below:
> 
> region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
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
Hi Fan, a few comments inline.

Jonathan

> ---
>  hw/mem/cxl_type3.c | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
> 
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 754c885cd1..2d67d2015c 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -721,6 +721,36 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
>      }
>  }
>  
> +static int cxl_create_dc_regions(CXLType3Dev *ct3d)
> +{
> +    int i;
> +    uint64_t region_base = 0;
> +    uint64_t region_len =  2 * GiB;
> +    uint64_t decode_len = 8; /* 8*256MB */

If decode len is going to be div 256MiB then we need
a name for that field that makes it clear that it is.

decode_len_256mbytes or something like that and maybe
region_len_bytes to keep things consistent.

Why the spec didn't make our life easier and define decode length
in bytes with some bits that must be zero is beyond me... 


I think we need to make this at least optionally configurable or based
in some fashion on the provided memory backend (divide that up
by number of regions with appropriate rounding perhaps?)

> +    uint64_t blk_size = 2 * MiB;
> +    CXLDCDRegion *region;
> +
> +    if (ct3d->hostvmem) {
> +        region_base += ct3d->hostvmem->size;
> +    }
> +    if (ct3d->hostpmem) {
> +        region_base += ct3d->hostpmem->size;
> +    }
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
> +    }
> +
> +    return 0;

Given it doesn't fail (even after the rest of this series is applied),
why return anything?  Make it void and we can drop the checks below..

> +}
> +
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds = DEVICE(ct3d);
> @@ -789,6 +819,10 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>          g_free(p_name);
>      }
>  
> +    if (cxl_create_dc_regions(ct3d)) {
> +        return false;
> +    }
> +
>      return true;
>  }
>  
> @@ -1108,6 +1142,7 @@ static Property ct3_props[] = {
>      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
>      DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
>      DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
> +    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  

