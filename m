Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C160AEB64DC
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 16:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjFVQfO (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 12:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231189AbjFVQex (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 12:34:53 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC371BFE
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 09:34:50 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qn5Vq15K5z6GDD8;
        Fri, 23 Jun 2023 00:32:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 17:34:47 +0100
Date:   Thu, 22 Jun 2023 17:34:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/5] cxl/region: Add dynamic capacity cxl region
 support.
Message-ID: <20230622173446.00002f95@Huawei.com>
In-Reply-To: <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
References: <20230604-dcd-type2-upstream-v1-0-71b6341bae54@intel.com>
        <20230604-dcd-type2-upstream-v1-2-71b6341bae54@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 14 Jun 2023 12:16:29 -0700
ira.weiny@intel.com wrote:

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
> 

I'd like some additional info here on why the skip stuff needs to be
so complicated.  I think it's juts a way of tracking the skip value
needed in the HDM decoders and that's just one value. So why can't
we just have one resource reservation for the skip?  Is it related to them needing
to be nested in some way?

Jonathan



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
>  
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
>  	/* save @skip_start, before @res is released */
> -	skip_start = res->start - cxled->skip;
> +	skip_start = res->start - skipped;
>  	__release_region(&cxlds->dpa_res, res->start, resource_size(res));
> -	if (cxled->skip)
> -		__release_region(&cxlds->dpa_res, skip_start, cxled->skip);
> +	if (cxled->skip != 0) {
> +		while (skipped != 0) {
> +			res = xa_load(&cxled->skip_res, skip_start);
> +			__release_region(&cxlds->dpa_res, skip_start,
> +							resource_size(res));
> +			xa_erase(&cxled->skip_res, skip_start);
> +			skip_start += resource_size(res);
> +			skipped -= resource_size(res);
> +			}
} indented too far..

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

Might as well increment index in the loop as well.
i++, index++;  Though given you are looping over a bunch of enum
entries and relying on them being in a row...

	if (mode < CXL_DECODER_DC0 || i > CXL_DECODER_DC7)
		return -EINVAL;
	return mode - CXL_DECODER0;


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
>  	lockdep_assert_held_write(&cxl_dpa_rwsem);
>  
> @@ -304,28 +330,119 @@ static int __cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	}
>  
>  	if (skipped) {
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
> +			if (resource_size(&cxlds->ram_res) &&
> +					skip_base <= cxlds->ram_res.end) {

Fix alignment to after (

> +				skip_len = cxlds->ram_res.end - skip_base + 1;
> +				res = __request_region(dpa_res, skip_base,
> +						skip_len, dev_name(ed_dev), 0);


Does it make sense to have all these potential skip regions in a row?
Why not just add one potentially including ram, pmem, and some of the
dc regions and remove one below?

I may be missing some subtlety here though.

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
> +		} else	{
> +			res = __request_region(dpa_res, base - skipped, skipped,
> +							dev_name(ed_dev), 0);
> +			if (!res)
> +				goto error;
> +
> +			rc = xa_insert(&cxled->skip_res, skip_base, res,
> +								GFP_KERNEL);
Can we have a precursor patch introducing the xarray for skip res?
Might make that bit easy to understand even if it start with few entries.

Also, is rc checked?


>  		}
>  	}
> -	res = __request_region(&cxlds->dpa_res, base, len,
> -			       dev_name(&cxled->cxld.dev), 0);
> +
> +	res = __request_region(dpa_res, base, len, dev_name(ed_dev), 0);
>  	if (!res) {
>  		dev_dbg(dev, "decoder%d.%d: failed to reserve allocation\n",
> -			port->id, cxled->cxld.id);
> -		if (skipped)
> -			__release_region(&cxlds->dpa_res, base - skipped,
> -					 skipped);
> +				port->id, cxled->cxld.id);

Odd indent of line above that is making this noisier than it needs to be.

> +		if (skipped) {

I'd invert at cost of two places you exit.
		if (!skipped)
			return -EBUSY;

		skip_base = base - skipped;
		...

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
>  	return 0;
> +
> +error:

Unless other stuff is coming here, drag the debug print up to callers, make
it more specific and return directly.  Makes for an easier flow to read.


> +	dev_dbg(dev, "decoder%d.%d: failed to reserve skipped space\n",
> +			port->id, cxled->cxld.id);
> +	return -EBUSY;
> +
>  }


> @@ -469,10 +611,12 @@ static resource_size_t cxl_dpa_freespace(struct cxl_endpoint_decoder *cxled,
>  					 resource_size_t *skip_out)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	resource_size_t free_ram_start, free_pmem_start;
> +	resource_size_t free_ram_start, free_pmem_start, free_dc_start;
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxled->cxld.dev;

Pull this out as a precursor.  Also note Dan used cxled_dev() in the patch adding cxl_dpa_freespace.
Probably best bet is just push this change into Dan's patch on basis it'll make the history neater.


>  	resource_size_t start, avail, skip;
>  	struct resource *p, *last;
> +	int index;
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

Push all the dc stuff into one place?  Perhaps that becomes impossible
in later patches...

> +	index = dc_mode_to_region_index(cxled->mode);
> +	if (index >= 0) {
> +		if (cxlds->dc_res[index].child) {
> +			dev_err(dev, "Cannot allocated DPA from DC Region: %d\n",
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

Hmm. 8 is on the boundary for being better to just do this programaticaly.
I guess it's fine though and is nice and easy to follow.

> +		};
>  		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> -			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> -			&avail);
> +			names[cxled->mode], &avail);
>  		rc = -ENOSPC;
>  		goto out;
>  	}


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

> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index ccdf8de85bd5..eb5eb81bfbd7 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -23,11 +23,15 @@ static int cxl_dax_region_probe(struct device *dev)
>  	if (!dax_region)
>  		return -ENOMEM;
>  
> +	if (decoder_mode_is_dc(cxlr->mode))
Comment for this would be good to let people know why (even if
it goes away in the future).

> +		return 0;
> +
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
>  		.size = range_len(&cxlr_dax->hpa_range),
>  	};
> +

*grumble*

>  	dev_dax = devm_create_dev_dax(&data);
>  	if (IS_ERR(dev_dax))
>  		return PTR_ERR(dev_dax);
> 

