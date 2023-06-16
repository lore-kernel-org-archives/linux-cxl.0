Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB058EB64D7
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Jun 2023 16:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345815AbjFPQxn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Jun 2023 12:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbjFPQxJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Jun 2023 12:53:09 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAA8D44A4
        for <linux-cxl@vger.kernel.org>; Fri, 16 Jun 2023 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686934300; x=1718470300;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dIR95RQOe64MbonmpeoZeUB7BklYKk9U6d/00SqKQgo=;
  b=Rw3IQeOVj2mHg7RYXKx0sEqMXG+1u1J+al6q2J+n8HSVPHv26s7atxTY
   fpsWxKXfVRuE6AX0A1is+R02IL5tJDzbz5PCyugUn3zyaiXVPMFAyru5t
   H5XvGsOIBvI5jde9pKB+X7lkhrC7J3dcTkVnEYizU46koNVEAmlv9stqi
   1+Kt/UjW9raoiRTYHlfkK1gERnXpr3ktTzIxqzfEpw/bbHH/vork+0cq5
   Jrb4kEFd3glqsMHVSa7f3rNhLzb/SJRQCn4aFwkt+SGmrQAjVY8rLcUIp
   fr9yBfs9G8jeLmi9HXs+7XT6Ytjf66nhKKRT+PT/ujI0Nj51150lpbp7G
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="422913128"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="422913128"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10743"; a="707154278"
X-IronPort-AV: E=Sophos;i="6.00,248,1681196400"; 
   d="scan'208";a="707154278"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.55.57])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2023 09:51:36 -0700
Date:   Fri, 16 Jun 2023 09:51:34 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     ira.weiny@intel.com
Cc:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region support.
Message-ID: <ZIyTFpniGlEv2QEo@aschofie-mobl2>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
 <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jun 14, 2023 at 12:16:29PM -0700, Ira Weiny wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> CXL devices optionally support dynamic capacity. CXL Regions must be
> created to access this capacity.
> 
> Add sysfs entries to create dynamic capacity cxl regions. Provide a new
> Dynamic Capacity decoder mode which targets dynamic capacity on devices
> which are added to that region.
> 
> Below are the steps to create and delete dynamic capacity region0
> (example).
> 
>     region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
>     echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
>     echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
>     echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> 
>     echo "dc0" >/sys/bus/cxl/devices/decoder1.0/mode
>     echo 0x400000000 >/sys/bus/cxl/devices/decoder1.0/dpa_size
> 
>     echo 0x400000000 > /sys/bus/cxl/devices/$region/size
>     echo  "decoder1.0" > /sys/bus/cxl/devices/$region/target0
>     echo 1 > /sys/bus/cxl/devices/$region/commit
>     echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> 
>     echo $region> /sys/bus/cxl/devices/decoder0.0/delete_region
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>

Hi,
I took another pass at this and offered more feedback.
I do think that if the big part - the cxl_dpa_reserve()
was more 'chunkified' it would be easier to review for
actual functionality.

I'd also like to see the commit log be a bit more specific
in enumerated the things this patch intends to do.

Many of my comments are about style. Some checkpatch --strict
would call out and some are addressed in the kernel coding
style - Documentation/process/coding-style.rst

But really, my goal is that when this code merges, that as
I scroll through a file, say region.c, I see a consistent
coding style. I shouldn't be able to notice that oh, Dan
wrote that, and Ira that, and Navneet wrote that piece.

I think it's important because differences in style distract
from focusing on the functionality of the code.

(off my soap box now ;)

Alison


> 
> ---
> [iweiny: fixups]
> [iweiny: remove unused CXL_DC_REGION_MODE macro]
> [iweiny: Make dc_mode_to_region_index static]
> [iweiny: simplify <sysfs>/create_dc_region]
> [iweiny: introduce decoder_mode_is_dc]
> [djbw: fixups, no sign-off: preview only]
> ---
>  drivers/cxl/Kconfig       |  11 +++
>  drivers/cxl/core/core.h   |   7 ++
>  drivers/cxl/core/hdm.c    | 234 ++++++++++++++++++++++++++++++++++++++++++----
>  drivers/cxl/core/port.c   |  18 ++++
>  drivers/cxl/core/region.c | 135 ++++++++++++++++++++++++--
>  drivers/cxl/cxl.h         |  28 ++++++
>  drivers/dax/cxl.c         |   4 +
>  7 files changed, 409 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index ff4e78117b31..df034889d053 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -121,6 +121,17 @@ config CXL_REGION
>  
>  	  If unsure say 'y'
>  
> +config CXL_DCD
> +	bool "CXL: DCD Support"

"CXL DCD: Dynamic Capacity Device Support"
is more in line with others in this file, and expands the acronym onetime.

> +	default CXL_BUS
> +	depends on CXL_REGION
> +	help
> +	  Enable the CXL core to provision CXL DCD regions.
> +	  CXL devices optionally support dynamic capacity and DCD region
> +	  maps the dynamic capacity regions DPA's into Host HPA ranges.
> +
> +	  If unsure say 'y'
> +
>  config CXL_REGION_INVALIDATION_TEST
>  	bool "CXL: Region Cache Management Bypass (TEST)"
>  	depends on CXL_REGION
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 27f0968449de..725700ab5973 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -9,6 +9,13 @@ extern const struct device_type cxl_nvdimm_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> +#ifdef CONFIG_CXL_DCD
> +extern struct device_attribute dev_attr_create_dc_region;
> +#define SET_CXL_DC_REGION_ATTR(x) (&dev_attr_##x.attr),
> +#else
> +#define SET_CXL_DC_REGION_ATTR(x)
> +#endif
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 514d30131d92..29649b47d177 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -233,14 +233,23 @@ static void __cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct resource *res = cxled->dpa_res;
>  	resource_size_t skip_start;
> +	resource_size_t skipped = cxled->skip;

Reverse x-tree.

>  
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
>  	/* save @skip_start, before @res is released */
> -	skip_start = res->start - cxled->skip;
> +	skip_start = res->start - skipped;

Why did the assignment of skip_start need to change here?

>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> -	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +	if (cxled->skip != 0) {
> +		while (skipped != 0) {
> +			res = xa_load(&cxled->skip_res, skip_start);
> +			__release_region(&cxlds->dpa_res, skip_start,
> +							resource_size(res));

The above appears poorlty aligned.

> +			xa_erase(&cxled->skip_res, skip_start);
> +			skip_start += resource_size(res);
> +			skipped -= resource_size(res);
> +			}

This bracket appears poorly aligned.

> +	}
>  	cxled->skip = 0;
>  	cxled->dpa_res = NULL;
>  	put_device(&cxled->cxld.dev);
> @@ -267,6 +276,19 @@ static void devm_cxl_dpa_release(struct cxl_endpoint_decoder *cxled)
>  	__cxl_dpa_release(cxled);
>  }
>  
> +static int dc_mode_to_region_index(enum cxl_decoder_mode mode)
> +{
> +	int index = 0;
> +
> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> +		if (mode == i)
> +			return index;
> +		index++;
> +	}
> +
> +	return -EINVAL;
> +}
> +
>  static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  			     resource_size_t base, resource_size_t len,
>  			     resource_size_t skipped)
> @@ -275,7 +297,11 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &port->dev;
> +	struct device *ed_dev = &cxled->cxld.dev;
> +	struct resource *dpa_res = &cxlds->dpa_res;
> +	resource_size_t skip_len = 0;
>  	struct resource *res;
> +	int rc, index;
>  

Above poorly aligned.

>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
> @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	}
>  
>  	if (skipped) {

This has excessive indentation, so started out with a monster
if skipped is begging for a refactoring.

I find it odd that the DCD case got inserted before the 'default'
or non-DCD case here.


> -		res = __request_region(&cxlds->dpa_res, base - skipped, skipped,
> -				       dev_name(&cxled->cxld.dev), 0);
> -		if (!res) {
> -			dev_dbg(dev,
> -				"decoder%d.%d: failed to reserve skipped space\n",
> -				port->id, cxled->cxld.id);
> -			return -EBUSY;
> +		resource_size_t skip_base = base - skipped;
> +
> +		if (decoder_mode_is_dc(cxled->mode)) {

This may be cleaner to introduce as a separate function for
handling _mode_id_dc.

> +			if (resource_size(&cxlds->ram_res) &&
> +					skip_base <= cxlds->ram_res.end) {
> +				skip_len = cxlds->ram_res.end - skip_base + 1;
> +				res = __request_region(dpa_res, skip_base,
> +						skip_len, dev_name(ed_dev), 0);
> +				if (!res)
> +					goto error;
> +
> +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
> +				skip_base += skip_len;
> +			}
> +
> +			if (resource_size(&cxlds->ram_res) &&
> +					skip_base <= cxlds->pmem_res.end) {
> +				skip_len = cxlds->pmem_res.end - skip_base + 1;
> +				res = __request_region(dpa_res, skip_base,
> +						skip_len, dev_name(ed_dev), 0);
> +				if (!res)
> +					goto error;
> +
> +				rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
> +				skip_base += skip_len;
> +			}

The above 2 if (resource_size() cases have redundant code. 
Pull it out, refactor.

> +
> +			index = dc_mode_to_region_index(cxled->mode);
> +			for (int i = 0; i <= index; i++) {
> +				struct resource *dcr = &cxlds->dc_res[i];
> +
> +				if (skip_base < dcr->start) {
> +					skip_len = dcr->start - skip_base;
> +					res = __request_region(dpa_res,
> +							skip_base, skip_len,
> +							dev_name(ed_dev), 0);
> +					if (!res)
> +						goto error;
> +
> +					rc = xa_insert(&cxled->skip_res, skip_base,
> +							res, GFP_KERNEL);
> +					skip_base += skip_len;
> +				}
> +
> +				if (skip_base == base) {
> +					dev_dbg(dev, "skip done!\n");
> +					break;
> +				}
> +
> +				if (resource_size(dcr) &&
> +						skip_base <= dcr->end) {
> +					if (skip_base > base)
> +						dev_err(dev, "Skip error\n");
> +
> +					skip_len = dcr->end - skip_base + 1;
> +					res = __request_region(dpa_res, skip_base,
> +							skip_len,
> +							dev_name(ed_dev), 0);
> +					if (!res)
> +						goto error;
> +
> +					rc = xa_insert(&cxled->skip_res, skip_base,
> +							res, GFP_KERNEL);
> +					skip_base += skip_len;
> +				}
> +			}


And, below,we are back to the original code.
This would be more readable, reviewable if the DCD support was
added in separate function that are then called from here.

> +		} else	{
> +			res = __request_region(dpa_res, base - skipped, skipped,
> +							dev_name(ed_dev), 0);
> +			if (!res)
> +				goto error;
> +
> +			rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
>  		}
>  	}
> -	res = __request_region(&cxlds->dpa_res, base, len,
> -			       dev_name(&cxled->cxld.dev), 0);
> +
> +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
>  	if (!res) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> -			port->id, cxled->cxld.id);

General comment - look over the dev_dbg() messages and consider placing
them after the code. I recall, others that were needlessly between lines
of code.


> -		if (skipped)
> -			__release_region(&cxlds->dpa_res, base - skipped,
> -					 skipped);
> +				port->id, cxled->cxld.id);
> +		if (skipped) {
> +			resource_size_t skip_base = base - skipped;
> +
> +			while (skipped != 0) {
> +				if (skip_base > base)
> +					dev_err(dev, "Skip error\n");
> +
> +				res = xa_load(&cxled->skip_res, skip_base);
> +				__release_region(dpa_res, skip_base,
> +							resource_size(res));
> +				xa_erase(&cxled->skip_res, skip_base);
> +				skip_base += resource_size(res);
> +				skipped -= resource_size(res);
> +			}
> +		}

		Can that debug message go here ?

>  		return -EBUSY;
>  	}
>  	cxled->dpa_res = res;
>  	cxled->skip = skipped;
>  
> +	for (int mode = CXL_DECODER_DC0; mode <= CXL_DECODER_DC7; mode++) {
> +		int index = dc_mode_to_region_index(mode);
> +
> +		if (resource_contains(&cxlds->dc_res[index], res)) {
> +			cxled->mode = mode;
> +			dev_dbg(dev, "decoder%d.%d: %pr mode: %d\n", port->id,
> +				cxled->cxld.id, cxled->dpa_res, cxled->mode);

Can this move to ....


> +			goto success;
> +		}
> +	}
>  	if (resource_contains(&cxlds->pmem_res, res))
>  		cxled->mode = CXL_DECODER_PMEM;
>  	else if (resource_contains(&cxlds->ram_res, res))
> @@ -336,9 +453,16 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  		cxled->mode = CXL_DECODER_MIXED;
>  	}
>  
> +success:
>  	port->hdm_end++;
>  	get_device(&cxled->cxld.dev);

here...dev_dbg() success message. That pairs it nicely with the
error message below.

>  	return 0;
> +
> +error:
> +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> +			port->id, cxled->cxld.id);
> +	return -EBUSY;
> +
>  }
>  
>  int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
> @@ -429,6 +553,14 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0:
> +	case CXL_DECODER_DC1:
> +	case CXL_DECODER_DC2:
> +	case CXL_DECODER_DC3:
> +	case CXL_DECODER_DC4:
> +	case CXL_DECODER_DC5:
> +	case CXL_DECODER_DC6:
> +	case CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_dbg(dev, "unsupported mode: %d\n", mode);
> @@ -456,6 +588,16 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  		goto out;
>  	}
>  
> +	for (int i = CXL_DECODER_DC0; i <= CXL_DECODER_DC7; i++) {
> +		int index = dc_mode_to_region_index(i);
> +
> +		if (mode == i && !resource_size(&cxlds->dc_res[index])) {
> +			dev_dbg(dev, "no available dynamic capacity\n");

I see this one is following the pattern in the function :)


> +			rc = -ENXIO;
> +			goto out;
> +		}
> +	}
> +
>  	cxled->mode = mode;
>  	rc = 0;
>  out:
> @@ -469,10 +611,12 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,

Hmmm...I don't have cxl_dpa_freespace() in my cxl/next? Where's that?


>  					 resource_size_t *skip_out)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
> +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxled->cxld.dev;
>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> +	int index;

Why break the alignment above?

>  
>  	lockdep_assert_held(&cxl_dpa_rwsem);
>  
> @@ -490,6 +634,20 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  	else
>  		free_pmem_start = cxlds->pmem_res.start;
>  
> +	/*
> +	 * One HDM Decoder per DC region to map memory with different
> +	 * DSMAS entry.
> +	 */

It seems this comment is missing a verb. Why not align?

> +	index = dc_mode_to_region_index(cxled->mode);
> +	if (index >= 0) {
> +		if (cxlds->dc_res[index].child) {
> +			dev_err(dev, "Cannot allocated DPA from DC Region: %d\n"

s/allocated/allocate

,
> +					index);
> +			return -EINVAL;
> +		}
> +		free_dc_start = cxlds->dc_res[index].start;
> +	}
> +
>  	if (cxled->mode == CXL_DECODER_RAM) {
>  		start = free_ram_start;
>  		avail = cxlds->ram_res.end - start + 1;
> @@ -511,6 +669,29 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  		else
>  			skip_end = start - 1;
>  		skip = skip_end - skip_start + 1;
> +	} else if (decoder_mode_is_dc(cxled->mode)) {
> +		resource_size_t skip_start, skip_end;
> +
> +		start = free_dc_start;
> +		avail = cxlds->dc_res[index].end - start + 1;
> +		if ((resource_size(&cxlds->pmem_res) == 0) || !cxlds->pmem_res.child)
> +			skip_start = free_ram_start;
> +		else
> +			skip_start = free_pmem_start;
> +		/*
> +		 * If some dc region is already mapped, then that allocation

maybe s/some/any ?

> +		 * already handled the RAM and PMEM skip.Check for DC region
> +		 * skip.
> +		 */
> +		for (int i = index - 1; i >= 0 ; i--) {
> +			if (cxlds->dc_res[i].child) {
> +				skip_start = cxlds->dc_res[i].child->end + 1;
> +				break;
> +			}
> +		}
> +
> +		skip_end = start - 1;
> +		skip = skip_end - skip_start + 1;
>  	} else {
>  		dev_dbg(cxled_dev(cxled), "mode not set\n");
>  		avail = 0;
> @@ -548,10 +729,25 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  
>  	avail = cxl_dpa_freespace(cxled, &start, &skip);
>  
> +	dev_dbg(dev, "DPA Allocation start: %llx len: %llx Skip: %llx\n",
> +						start, size, skip);
>  	if (size > avail) {
> +		static const char * const names[] = {
> +			[CXL_DECODER_NONE] = "none",
> +			[CXL_DECODER_RAM] = "ram",
> +			[CXL_DECODER_PMEM] = "pmem",
> +			[CXL_DECODER_MIXED] = "mixed",
> +			[CXL_DECODER_DC0] = "dc0",
> +			[CXL_DECODER_DC1] = "dc1",
> +			[CXL_DECODER_DC2] = "dc2",
> +			[CXL_DECODER_DC3] = "dc3",
> +			[CXL_DECODER_DC4] = "dc4",
> +			[CXL_DECODER_DC5] = "dc5",
> +			[CXL_DECODER_DC6] = "dc6",
> +			[CXL_DECODER_DC7] = "dc7",
> +		};
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			names[cxled->mode], &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 5e21b53362e6..a1a98aba24ed 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -195,6 +195,22 @@ static ssize_t mode_store(struct device *dev, struct device_attribute *attr,
>  		mode = CXL_DECODER_PMEM;
>  	else if (sysfs_streq(buf, "ram"))
>  		mode = CXL_DECODER_RAM;
> +	else if (sysfs_streq(buf, "dc0"))
> +		mode = CXL_DECODER_DC0;
> +	else if (sysfs_streq(buf, "dc1"))
> +		mode = CXL_DECODER_DC1;
> +	else if (sysfs_streq(buf, "dc2"))
> +		mode = CXL_DECODER_DC2;
> +	else if (sysfs_streq(buf, "dc3"))
> +		mode = CXL_DECODER_DC3;
> +	else if (sysfs_streq(buf, "dc4"))
> +		mode = CXL_DECODER_DC4;
> +	else if (sysfs_streq(buf, "dc5"))
> +		mode = CXL_DECODER_DC5;
> +	else if (sysfs_streq(buf, "dc6"))
> +		mode = CXL_DECODER_DC6;
> +	else if (sysfs_streq(buf, "dc7"))
> +		mode = CXL_DECODER_DC7;
>  	else
>  		return -EINVAL;
>  
> @@ -296,6 +312,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_target_list.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_DC_REGION_ATTR(create_dc_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> @@ -1691,6 +1708,7 @@ struct cxl_endpoint_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxled->pos = -1;
> +	xa_init(&cxled->skip_res);
>  	cxld = &cxled->cxld;
>  	rc = cxl_decoder_init(port, cxld);
>  	if (rc)	 {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 543c4499379e..144232c8305e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1733,7 +1733,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	lockdep_assert_held_write(&cxl_region_rwsem);
>  	lockdep_assert_held_read(&cxl_dpa_rwsem);
>  
> -	if (cxled->mode != cxlr->mode) {
> +	if (decoder_mode_is_dc(cxlr->mode) && !decoder_mode_is_dc(cxled->mode)) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
>  		return -EINVAL;
> @@ -2211,6 +2211,14 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_DECODER_RAM:
>  	case CXL_DECODER_PMEM:
> +	case CXL_DECODER_DC0:
> +	case CXL_DECODER_DC1:
> +	case CXL_DECODER_DC2:
> +	case CXL_DECODER_DC3:
> +	case CXL_DECODER_DC4:
> +	case CXL_DECODER_DC5:
> +	case CXL_DECODER_DC6:
> +	case CXL_DECODER_DC7:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> @@ -2321,6 +2329,43 @@ static ssize_t create_ram_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> +static ssize_t store_dcN_region(struct cxl_root_decoder *cxlrd,
> +				const char *buf, enum cxl_decoder_mode mode,
> +				size_t len)
> +{
> +	struct cxl_region *cxlr;
> +	int rc, id;
> +
> +	rc = sscanf(buf, "region%d\n", &id);
> +	if (rc != 1)
> +		return -EINVAL;
> +
> +	cxlr = __create_region(cxlrd, id, mode, CXL_DECODER_HOSTMEM);
> +	if (IS_ERR(cxlr))
> +		return PTR_ERR(cxlr);
> +
> +	return len;
> +}
> +
> +static ssize_t create_dc_region_show(struct device *dev,
> +				     struct device_attribute *attr, char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dc_region_store(struct device *dev,
> +				      struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	/*
> +	 * All DC regions use decoder mode DC0 as the region does not need the
> +	 * index information
> +	 */
> +	return store_dcN_region(to_cxl_root_decoder(dev), buf,
> +				CXL_DECODER_DC0, len);
> +}
> +DEVICE_ATTR_RW(create_dc_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -2799,6 +2844,61 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static void cxl_dc_region_release(void *data)
> +{
> +	struct cxl_region *cxlr = data;
> +	struct cxl_dc_region *cxlr_dc = cxlr->cxlr_dc;
> +
> +	xa_destroy(&cxlr_dc->dax_dev_list);
> +	kfree(cxlr_dc);
> +}
> +
> +static int devm_cxl_add_dc_region(struct cxl_region *cxlr)
> +{
> +	struct cxl_dc_region *cxlr_dc;
> +	struct cxl_dax_region *cxlr_dax;
> +	struct device *dev;
> +	int rc = 0;
> +
> +	cxlr_dax = cxl_dax_region_alloc(cxlr);
> +	if (IS_ERR(cxlr_dax))
> +		return PTR_ERR(cxlr_dax);
> +
> +	cxlr_dc = kzalloc(sizeof(*cxlr_dc), GFP_KERNEL);
> +	if (!cxlr_dc) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	dev = &cxlr_dax->dev;
> +	rc = dev_set_name(dev, "dax_region%d", cxlr->id);
> +	if (rc)
> +		goto err;
> +
> +	rc = device_add(dev);
> +	if (rc)
> +		goto err;
> +
> +	dev_dbg(&cxlr->dev, "%s: register %s\n", dev_name(dev->parent),
> +		dev_name(dev));
> +
> +	rc = devm_add_action_or_reset(&cxlr->dev, cxlr_dax_unregister,
> +					cxlr_dax);
> +	if (rc)
> +		goto err;
> +
> +	cxlr_dc->cxlr_dax = cxlr_dax;
> +	xa_init(&cxlr_dc->dax_dev_list);
> +	cxlr->cxlr_dc = cxlr_dc;
> +	rc = devm_add_action_or_reset(&cxlr->dev, cxl_dc_region_release, cxlr);
> +	if (!rc)
> +		return 0;
> +err:
> +	put_device(dev);
> +	kfree(cxlr_dc);
> +	return rc;
> +}
> +
>  static int match_decoder_by_range(struct device *dev, void *data)
>  {
>  	struct range *r1, *r2 = data;
> @@ -3140,6 +3240,19 @@ static int is_system_ram(struct resource *res, void *arg)
>  	return 1;
>  }
>  
> +/*
> + * The region can not be manged by CXL if any portion of
> + * it is already online as 'System RAM'
> + */
> +static bool region_is_system_ram(struct cxl_region *cxlr,
> +				 struct cxl_region_params *p)
> +{
> +	return (walk_iomem_res_desc(IORES_DESC_NONE,
> +				    IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> +				    p->res->start, p->res->end, cxlr,
> +				    is_system_ram) > 0);
> +}
> +
>  static int cxl_region_probe(struct device *dev)
>  {
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> @@ -3174,14 +3287,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_DECODER_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_DECODER_RAM:
> -		/*
> -		 * The region can not be manged by CXL if any portion of
> -		 * it is already online as 'System RAM'
> -		 */
> -		if (walk_iomem_res_desc(IORES_DESC_NONE,
> -					IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY,
> -					p->res->start, p->res->end, cxlr,
> -					is_system_ram) > 0)
> +		if (region_is_system_ram(cxlr, p))
>  			return 0;
>  
>  		/*
> @@ -3193,6 +3299,17 @@ static int cxl_region_probe(struct device *dev)
>  
>  		/* HDM-H routes to device-dax */
>  		return devm_cxl_add_dax_region(cxlr);
> +	case CXL_DECODER_DC0:
> +	case CXL_DECODER_DC1:
> +	case CXL_DECODER_DC2:
> +	case CXL_DECODER_DC3:
> +	case CXL_DECODER_DC4:
> +	case CXL_DECODER_DC5:
> +	case CXL_DECODER_DC6:
> +	case CXL_DECODER_DC7:
> +		if (region_is_system_ram(cxlr, p))
> +			return 0;
> +		return devm_cxl_add_dc_region(cxlr);
>  	default:
>  		dev_dbg(&cxlr->dev, "unsupported region mode: %d\n",
>  			cxlr->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8400af85d99f..7ac1237938b7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -335,6 +335,14 @@ enum cxl_decoder_mode {
>  	CXL_DECODER_NONE,
>  	CXL_DECODER_RAM,
>  	CXL_DECODER_PMEM,
> +	CXL_DECODER_DC0,
> +	CXL_DECODER_DC1,
> +	CXL_DECODER_DC2,
> +	CXL_DECODER_DC3,
> +	CXL_DECODER_DC4,
> +	CXL_DECODER_DC5,
> +	CXL_DECODER_DC6,
> +	CXL_DECODER_DC7,
>  	CXL_DECODER_MIXED,
>  	CXL_DECODER_DEAD,
>  };
> @@ -345,6 +353,14 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  		[CXL_DECODER_NONE] = "none",
>  		[CXL_DECODER_RAM] = "ram",
>  		[CXL_DECODER_PMEM] = "pmem",
> +		[CXL_DECODER_DC0] = "dc0",
> +		[CXL_DECODER_DC1] = "dc1",
> +		[CXL_DECODER_DC2] = "dc2",
> +		[CXL_DECODER_DC3] = "dc3",
> +		[CXL_DECODER_DC4] = "dc4",
> +		[CXL_DECODER_DC5] = "dc5",
> +		[CXL_DECODER_DC6] = "dc6",
> +		[CXL_DECODER_DC7] = "dc7",
>  		[CXL_DECODER_MIXED] = "mixed",
>  	};
>  
> @@ -353,6 +369,11 @@ static inline const char *cxl_decoder_mode_name(enum cxl_decoder_mode mode)
>  	return "mixed";
>  }
>  
> +static inline bool decoder_mode_is_dc(enum cxl_decoder_mode mode)
> +{
> +	return (mode >= CXL_DECODER_DC0 && mode <= CXL_DECODER_DC7);
> +}
> +
>  /*
>   * Track whether this decoder is reserved for region autodiscovery, or
>   * free for userspace provisioning.
> @@ -375,6 +396,7 @@ struct cxl_endpoint_decoder {
>  	struct cxl_decoder cxld;
>  	struct resource *dpa_res;
>  	resource_size_t skip;
> +	struct xarray skip_res;
>  	enum cxl_decoder_mode mode;
>  	enum cxl_decoder_state state;
>  	int pos;
> @@ -475,6 +497,11 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_AUTO 1
>  
> +struct cxl_dc_region {
> +	struct xarray dax_dev_list;
> +	struct cxl_dax_region *cxlr_dax;
> +};
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> @@ -493,6 +520,7 @@ struct cxl_region {
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct cxl_pmem_region *cxlr_pmem;
> +	struct cxl_dc_region *cxlr_dc;
>  	unsigned long flags;
>  	struct cxl_region_params params;
>  };
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index ccdf8de85bd5..eb5eb81bfbd7 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	if (!dax_region)
>  		return -ENOMEM;
>  
> +	if (decoder_mode_is_dc(cxlr->mode))
> +		return 0;
> +
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
>  		.size = range_len(&cxlr_dax->hpa_range),
>  	};
> +
>  	dev_dax = devm_create_dev_dax(&data);
>  	if (IS_ERR(dev_dax))
>  		return PTR_ERR(dev_dax);
> 
> -- 
> 2.40.0
> 
