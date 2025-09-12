Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D0A247281;
	Fri, 12 Sep 2025 15:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757692330; cv=none; b=j9Ka8RFhVrKIY5ufLyG00ar7aA7ByA1QUojLvcXPqcUmuSRVCb7hub/zR/gRTK1FN9wVegSAlXkcbA6aqbzF/wYTQyxIbcTxq13/M+HPZWTdLpCgHhEGViM9MWnOFvr1ixAfXd7LGK4y3/b6Q2iDDFJ7l7YKfqoD5+gv2lK2t9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757692330; c=relaxed/simple;
	bh=1Z0OLrcaMnOXzu977c6oJrXuoBg1b/4f4ARZB/2ReFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n8bBfiwXSGUsLMf694cl7quWM3wOKqACkVcWzEZemNDoq1fqPCB+7ct5ZQWO29Vv+t7h92B3xAkxHuRO4/NbXupl4zqYIvyL8KjwOrlyHWI3Olj9TatK5rUJz5DnSTbIaEl5jfMEkPZD+7fJdcDcs/vfhferaNn0neBAnr00SNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKkkj8NY; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKkkj8NY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757692329; x=1789228329;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1Z0OLrcaMnOXzu977c6oJrXuoBg1b/4f4ARZB/2ReFY=;
  b=bKkkj8NY0Bj/w1Z0ODk8wCSqF+y0y/dKrov5yfrobV+cRAwn2VR9tcbr
   S9X4Bfn9WZPCoajtj3uTkaExXgr9ZHA7ScsDD9rzpYl2B6IvwV4y9bS7L
   ySMfz1LvakygI67P8Av0S1m1bezg5Cqsk3p0zVwkRD6J0cronKLLo4Zcs
   fr2Cfhz5UwX6q2u+dOdt/xlanqpYgkPnHfB+70zy/s2TNpY/euZhoZvnx
   4sj2sOFQHX+mxgtDLY/NwHhkBZc/tyBHwgH8lCY98nJDYv4aH33320oGT
   V0eAvhNBVMd4upaT5Q3EG86tYad/CscV/e2TAreDF7nb2XgDegahOumM8
   g==;
X-CSE-ConnectionGUID: Tvnlq+3aSzavRw+dcbnB2g==
X-CSE-MsgGUID: U/Y4xoP5Q+u6DbvMCqs6Ng==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="59982808"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="59982808"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:52:08 -0700
X-CSE-ConnectionGUID: CHco2DdbSNeej1Uv78Qh0A==
X-CSE-MsgGUID: j20oiV2/QWOyByJ1LaDPVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,259,1751266800"; 
   d="scan'208";a="178032095"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO [10.125.111.66]) ([10.125.111.66])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2025 08:52:08 -0700
Message-ID: <a25bbb46-9f79-458e-9d4f-2de70c9ef22d@intel.com>
Date: Fri, 12 Sep 2025 08:52:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/11] cxl/region: Store root decoder in struct
 cxl_region
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-2-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250912144514.526441-2-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/12/25 7:45 AM, Robert Richter wrote:
> A region is always bound to a root decoder. The region's associated
> root decoder is often needed. Add it to struct cxl_region.
> 
> This simplifies code by removing dynamic lookups and removing the root
> decoder argument from the function argument list where possible.
> 
> Patch is a prerequisite to implement address translation which uses
> struct cxl_region to store all relevant region and interleaving
> parameters.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 37 +++++++++++++++++++------------------
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 21 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 29d3809ab2bb..2c37c060d983 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -489,9 +489,9 @@ static ssize_t interleave_ways_store(struct device *dev,
>  				     struct device_attribute *attr,
>  				     const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	unsigned int val, save;
>  	int rc;
> @@ -552,9 +552,9 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  					    struct device_attribute *attr,
>  					    const char *buf, size_t len)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int rc, val;
>  	u16 ig;
> @@ -628,7 +628,7 @@ static DEVICE_ATTR_RO(mode);
>  
>  static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct resource *res;
>  	u64 remainder = 0;
> @@ -1321,7 +1321,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int parent_iw, parent_ig, ig, iw, rc, inc = 0, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> @@ -1678,10 +1678,10 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  }
>  
>  static int cxl_region_attach_position(struct cxl_region *cxlr,
> -				      struct cxl_root_decoder *cxlrd,
>  				      struct cxl_endpoint_decoder *cxled,
>  				      const struct cxl_dport *dport, int pos)
>  {
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_switch_decoder *cxlsd = &cxlrd->cxlsd;
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
> @@ -1918,7 +1918,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_region_params *p = &cxlr->params;
> @@ -2023,8 +2023,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  			ep_port = cxled_to_port(cxled);
>  			dport = cxl_find_dport_by_dev(root_port,
>  						      ep_port->host_bridge);
> -			rc = cxl_region_attach_position(cxlr, cxlrd, cxled,
> -							dport, i);
> +			rc = cxl_region_attach_position(cxlr, cxled, dport, i);
>  			if (rc)
>  				return rc;
>  		}
> @@ -2047,7 +2046,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	if (rc)
>  		return rc;
>  
> -	rc = cxl_region_attach_position(cxlr, cxlrd, cxled, dport, pos);
> +	rc = cxl_region_attach_position(cxlr, cxled, dport, pos);
>  	if (rc)
>  		return rc;
>  
> @@ -2343,8 +2342,8 @@ static const struct attribute_group *region_groups[] = {
>  
>  static void cxl_region_release(struct device *dev)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
>  	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	int id = atomic_read(&cxlrd->region_id);
>  
>  	/*
> @@ -2427,10 +2426,12 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>  	 * region id allocations
>  	 */
>  	get_device(dev->parent);
> +	cxlr->cxlrd = cxlrd;
> +	cxlr->id = id;
> +
>  	device_set_pm_not_required(dev);
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_region_type;
> -	cxlr->id = id;
>  
>  	return cxlr;
>  }
> @@ -2931,7 +2932,7 @@ static bool has_spa_to_hpa(struct cxl_root_decoder *cxlrd)
>  u64 cxl_dpa_to_hpa(struct cxl_region *cxlr, const struct cxl_memdev *cxlmd,
>  		   u64 dpa)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	u64 dpa_offset, hpa_offset, bits_upper, mask_upper, hpa;
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_endpoint_decoder *cxled = NULL;
> @@ -3007,7 +3008,7 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  				       struct dpa_result *result)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_endpoint_decoder *cxled;
>  	u64 hpa, hpa_offset, dpa_offset;
>  	u64 bits_upper, bits_lower;
> @@ -3401,7 +3402,7 @@ static int match_region_by_range(struct device *dev, const void *data)
>  static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  					    struct resource *res)
>  {
> -	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
>  	resource_size_t size = resource_size(res);
>  	resource_size_t cache_size, start;
> @@ -3437,9 +3438,9 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>  }
>  
>  static int __construct_region(struct cxl_region *cxlr,
> -			      struct cxl_root_decoder *cxlrd,
>  			      struct cxl_endpoint_decoder *cxled)
>  {
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> @@ -3531,7 +3532,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		return cxlr;
>  	}
>  
> -	rc = __construct_region(cxlr, cxlrd, cxled);
> +	rc = __construct_region(cxlr, cxled);
>  	if (rc) {
>  		devm_release_action(port->uport_dev, unregister_region, cxlr);
>  		return ERR_PTR(rc);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4fe3df06f57a..350ccd6949b3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -517,6 +517,7 @@ enum cxl_partition_mode {
>   * struct cxl_region - CXL region
>   * @dev: This region's device
>   * @id: This region's id. Id is globally unique across all regions
> + * @cxlrd: Region's root decoder
>   * @mode: Operational mode of the mapped capacity
>   * @type: Endpoint decoder target type
>   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> @@ -530,6 +531,7 @@ enum cxl_partition_mode {
>  struct cxl_region {
>  	struct device dev;
>  	int id;
> +	struct cxl_root_decoder *cxlrd;
>  	enum cxl_partition_mode mode;
>  	enum cxl_decoder_type type;
>  	struct cxl_nvdimm_bridge *cxl_nvb;

