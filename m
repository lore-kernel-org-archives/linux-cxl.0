Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9676415E5DC;
	Fri, 24 Apr 2026 00:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776991910; cv=none; b=vDCfai7uxNdYc5LcdmyVW4wNMMgf5zqWAm+LiJ3sT5cUQiFn6RewyObwiJXN73wFb/odmKcBrIxso5nVSwceJYGZKSP265kO069eZxJ9i7Su6T7daEv6qf3tcPfSTArCDUfkt7GN1ezuDYQXG/TodluGFEox99wYBUlMB8mzN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776991910; c=relaxed/simple;
	bh=eY7UKBOhyM8QG9Njq0CqoqM8Bouwx34XtrBabBeDYiA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbkM2vOxfDrKDWMIMdVYIeT17/LQdGnaXbUclyg/+BPvqIaKUT/g+H6dfitZxfk/3tG1gyvsCb2Zfb5nJBezo0qnDCIdkcOoN0d5bzjXEM7WqWfNJtrS5MSmXSkryVTVC5yxTcNNUiAy+v4tV3CR7OOo1t45WUzoAXjC1LRyQwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=joHFetqo; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="joHFetqo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776991909; x=1808527909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eY7UKBOhyM8QG9Njq0CqoqM8Bouwx34XtrBabBeDYiA=;
  b=joHFetqoNx3oUtQdirHkXOAN1+a93USGLn46/8Xj4besyszIWIW6DFXb
   jIJOJVepWsWFF9XKhFFAcI3+gTuiH1XjMj+wXj7wfPIFYwmtBor30ju2s
   0RDtJej7Uvagd5D0QWbF+MkiPWwTRLNalhH52XXlNyuvaS1PQYAW/YPbh
   7monSgPoBgn4Pl3mVe2c+LScaU96NLpPBD7KwLwd+GG/Hcy2AQ+uiFCjE
   twGjmhnnCqXJSuF7mVOz2vn259zwsWYMyrCrQcBRKDJVAWB18KyDBSUCV
   XfKxe9dNyYefqM8ZgDK+ZgQ3II8oP0aUxhPvyOlD3Awrqa79sUbxmHEiN
   Q==;
X-CSE-ConnectionGUID: w7pcHuTDSm2bN6MV+lwnVA==
X-CSE-MsgGUID: ThtXSmt/RjCJnxbI7vNYkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11765"; a="81577016"
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="81577016"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 17:51:48 -0700
X-CSE-ConnectionGUID: Sl1KXaJQRIqzugt2goG/kw==
X-CSE-MsgGUID: 56RJct4sRfe62FDllvFB9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,195,1770624000"; 
   d="scan'208";a="237165862"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.37]) ([10.125.108.37])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Apr 2026 17:51:46 -0700
Message-ID: <0dc6521e-e431-416c-a132-680dc0360095@intel.com>
Date: Thu, 23 Apr 2026 17:51:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to an
 xarray
To: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, John Groves <John@Groves.net>,
 Fan Ni <fan.ni@samsung.com>, Anisa Su <anisa.su@samsung.com>,
 Shiju Jose <shiju.jose@huawei.com>, Robert Richter <rrichter@amd.com>
Cc: "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
 "arramesh@micron.com" <arramesh@micron.com>,
 "ajayjoshi@micron.com" <ajayjoshi@micron.com>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
 <20260423235158.3732476-1-john@jagalactic.com>
 <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/23/26 4:52 PM, John Groves wrote:
> From: John Groves <John@Groves.net>
> 
> Terminology note: "CXL region" (struct cxl_region) is the
> mode-agnostic HDM-decoded HPA window; "DAX region"
> (struct cxl_dax_region, nicknamed cxlr_dax) is the DCD-specific
> CXL->device-dax shim that hangs off a cxl_region.  This commit
> touches only the DAX-region shim; nothing about cxl_region, its
> HDM decoding, or its lifecycle changes.
> 
> Prior to this commit, struct cxl_dax_region holds a single
> region_extent pointer, so at most one tagged allocation can ever
> surface under a DAX region.  A subsequent commit rewrites DCD
> add-capacity handling to assemble extents per-tag and permits multiple
> allocations per More-chain; that work is latent until cxlr_dax can
> actually hold more than one region_extent.  Do the infrastructural
> swap here, on its own, so the behavior change lands in a dedicated
> commit and the per-tag assembly work isn't tangled with storage-layout
> changes.
> 
> Replace the single-slot pointer with an xarray.  Note: the xarray is
> *not* keyed by UUID.  xarray is a radix tree over unsigned-long keys;
> a 128-bit pseudo-random UUID is neither the right width nor the right
> distribution for a radix index.  The key is an allocator-assigned u32
> obtained via xa_alloc() when online_region_extent() registers the
> device; that same u32 is stored in region_extent->dev.id so device
> names become "extent<rid>.<id>" with unique suffixes per allocation
> (replacing the hardcoded .0).  UUID remains a stored attribute on
> struct region_extent; tag-based lookup is a linear xa_for_each walk,
> which is adequate at the bounded per-region tag counts DCD delivers.
> 
> User-visible naming: device names remain "extent<rid>.<N>".  Before
> this commit, N is always 0; after, N is the xa_alloc()-assigned id.
> The first region_extent under a cxlr_dax still lands at id 0, so a
> single-allocation region is observably unchanged.  Only a 2nd+
> region_extent (which cannot be produced at all today) gets a
> non-zero suffix.
> 
> Call-site translations:
> 
>   - cxl_dax_region_alloc() / _release(): xa_init / xa_destroy.
>   - alloc_region_extent(): drop the hardcoded dev.id = 0; the ID is
>     assigned when online_region_extent() registers the device.
>   - online_region_extent(): device_initialize() first so the release
>     function is wired, then xa_alloc(), assign the returned id into
>     dev->id, then dev_set_name() and device_add().  On any failure
>     from xa_alloc() onward, put_device(dev) -> release ->
>     free_region_extent() -> xa_erase() handles cleanup; no explicit
>     xa_erase() is needed in the error path of online_region_extent().
>   - free_region_extent(): xa_erase() replaces NULLing the slot.
>   - extents_contain() / extents_overlap(): nested xa_for_each, outer
>     over region_extents, inner over decoder_extents.
>   - cxl_rm_extent(): walk region_extents and match by UUID to find
>     the target region_extent (linear, bounded).
>   - cxl_add_extent()'s "already onlined" gate: translated from
>     single-slot NULL check to !xa_empty().  This preserves the
>     existing single-region_extent-per-cxlr_dax invariant; lifting
>     that gate to actually support multiple allocations is a separate
>     semantic change that belongs with the per-tag assembly rework.
> 
> The dax-side (drivers/dax/cxl.c) is unchanged.  cxl_dax_region_probe()
> still iterates region_extent children via device_for_each_child() on
> cxlr_dax->dev, and cxl_dax_region_notify() still takes a
> struct region_extent * through cxl_notify_data; neither the CXL<->DAX
> boundary nor the DAX resource model is affected.
> 
> No functional change: all paths still observe at most one
> region_extent per cxlr_dax; this commit only prepares the storage.
> 
> Signed-off-by: John Groves <John@Groves.net>
> Signed-off-by: John Groves <john@groves.net>

Double sign offs

> ---
>  drivers/cxl/core/extent.c | 89 ++++++++++++++++++++++-----------------
>  drivers/cxl/core/region.c |  2 +
>  drivers/cxl/cxl.h         |  9 +++-
>  3 files changed, 61 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> index c4ad81814fb4d..44b58cd477655 100644
> --- a/drivers/cxl/core/extent.c
> +++ b/drivers/cxl/core/extent.c
> @@ -87,7 +87,8 @@ static void free_region_extent(struct region_extent *region_extent)
>  	xa_for_each(&region_extent->decoder_extents, index, ed_extent)
>  		cxled_release_extent(ed_extent->cxled, ed_extent);
>  	xa_destroy(&region_extent->decoder_extents);
> -	region_extent->cxlr_dax->region_extent = NULL;
> +	xa_erase(&region_extent->cxlr_dax->region_extents,
> +		 region_extent->dev.id);
>  	kfree(region_extent);
>  }
>  
> @@ -144,7 +145,6 @@ alloc_region_extent(struct cxl_dax_region *cxlr_dax, struct range *hpa_range,
>  	region_extent->hpa_range = *hpa_range;
>  	region_extent->cxlr_dax = cxlr_dax;
>  	uuid_copy(&region_extent->uuid, uuid);
> -	region_extent->dev.id = 0;
>  	xa_init(&region_extent->decoder_extents);
>  	return no_free_ptr(region_extent);
>  }
> @@ -153,12 +153,26 @@ int online_region_extent(struct region_extent *region_extent)
>  {
>  	struct cxl_dax_region *cxlr_dax = region_extent->cxlr_dax;
>  	struct device *dev = &region_extent->dev;
> +	u32 id;
>  	int rc;
>  
>  	device_initialize(dev);
>  	device_set_pm_not_required(dev);
>  	dev->parent = &cxlr_dax->dev;
>  	dev->type = &region_extent_type;
> +
> +	/*
> +	 * Insert into cxlr_dax->region_extents before dev_set_name so
> +	 * the allocated id is available as the .<N> suffix.  On any
> +	 * failure from here on, put_device(dev) -> release ->
> +	 * free_region_extent() -> xa_erase() handles the cleanup.
> +	 */
> +	rc = xa_alloc(&cxlr_dax->region_extents, &id, region_extent,
> +		      xa_limit_32b, GFP_KERNEL);
> +	if (rc < 0)
> +		goto err;
> +	dev->id = id;
> +
>  	rc = dev_set_name(dev, "extent%d.%d", cxlr_dax->cxlr->id, dev->id);
>  	if (rc)
>  		goto err;
> @@ -167,7 +181,6 @@ int online_region_extent(struct region_extent *region_extent)
>  	if (rc)
>  		goto err;
>  
> -	cxlr_dax->region_extent = region_extent;
>  	dev_dbg(dev, "region extent HPA %pra\n", &region_extent->hpa_range);
>  	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,
>  					region_extent);
> @@ -184,17 +197,16 @@ static bool extents_contain(struct cxl_dax_region *cxlr_dax,
>  			    struct cxl_endpoint_decoder *cxled,
>  			    struct range *new_range)
>  {
> -	struct region_extent *re = cxlr_dax->region_extent;
> +	struct region_extent *re;
>  	struct cxled_extent *entry;
> -	unsigned long index;
> -
> -	if (!re)
> -		return false;
> -
> -	xa_for_each(&re->decoder_extents, index, entry) {
> -		if (cxled == entry->cxled &&
> -		    range_contains(&entry->dpa_range, new_range))
> -			return true;
> +	unsigned long i, j;
> +
> +	xa_for_each(&cxlr_dax->region_extents, i, re) {
> +		xa_for_each(&re->decoder_extents, j, entry) {
> +			if (cxled == entry->cxled &&
> +			    range_contains(&entry->dpa_range, new_range))
> +				return true;
> +		}
>  	}
>  	return false;
>  }
> @@ -203,17 +215,16 @@ static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
>  			    struct cxl_endpoint_decoder *cxled,
>  			    struct range *new_range)
>  {
> -	struct region_extent *re = cxlr_dax->region_extent;
> +	struct region_extent *re;
>  	struct cxled_extent *entry;
> -	unsigned long index;
> -
> -	if (!re)
> -		return false;
> -
> -	xa_for_each(&re->decoder_extents, index, entry) {
> -		if (cxled == entry->cxled &&
> -		    range_overlaps(&entry->dpa_range, new_range))
> -			return true;
> +	unsigned long i, j;
> +
> +	xa_for_each(&cxlr_dax->region_extents, i, re) {
> +		xa_for_each(&re->decoder_extents, j, entry) {
> +			if (cxled == entry->cxled &&
> +			    range_overlaps(&entry->dpa_range, new_range))
> +				return true;
> +		}
>  	}

Second time seeing this pattern. Maybe just create a helper function?


>  	return false;
>  }
> @@ -306,21 +317,25 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
>  	}
>  
>  	cxlr_dax = cxlr->cxlr_dax;
> -	reg_ext = cxlr_dax->region_extent;
> +	import_uuid(&tag, extent->uuid);
> +	{
> +		struct region_extent *r;
> +		unsigned long idx;
> +
> +		reg_ext = NULL;
> +		xa_for_each(&cxlr_dax->region_extents, idx, r) {
> +			if (uuid_equal(&r->uuid, &tag)) {
> +				reg_ext = r;
> +				break;
> +			}
> +		}
> +	}

Would prefer not have the extra scope.

DJ

>  	if (!reg_ext) {
> -		dev_err(&cxlr->cxlr_dax->dev,
> -			"no capacity has been added to the region\n");
> +		dev_err(&cxlr_dax->dev,
> +			"no region_extent matches tag %pU\n", &tag);
>  		return -ENXIO;
>  	}
>  
> -	import_uuid(&tag, extent->uuid);
> -	if (!uuid_equal(&tag, &reg_ext->uuid)) {
> -		dev_err(&cxlr->cxlr_dax->dev,
> -			"extent tag %pU doesn't match region tag %pU\n",
> -			&tag, &reg_ext->uuid);
> -		return -EINVAL;
> -	}
> -
>  	calc_hpa_range(cxled, cxlr_dax, &dpa_range, &hpa_range);
>  	if (!range_contains(&reg_ext->hpa_range, &hpa_range)) {
>  		dev_err(&cxlr_dax->dev,
> @@ -329,9 +344,7 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
>  		return -EINVAL;
>  	}
>  
> -	rc = cxlr_notify_extent(cxlr,
> -				DCD_RELEASE_CAPACITY,
> -				cxlr_dax->region_extent);
> +	rc = cxlr_notify_extent(cxlr, DCD_RELEASE_CAPACITY, reg_ext);
>  	if (rc == -EBUSY)
>  		return 0;
>  
> @@ -416,7 +429,7 @@ int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
>  
>  	cxlr_dax = cxlr->cxlr_dax;
>  	/* Cannot add to a region_extent once it's been onlined */
> -	if (cxlr_dax->region_extent) {
> +	if (!xa_empty(&cxlr_dax->region_extents)) {
>  		dev_err(&cxlr_dax->dev, "Can no longer add to region %d\n",
>  			cxlr->id);
>  		return -EINVAL;
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 15065d9a1cbf2..42b3a3bbd502f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3546,6 +3546,7 @@ static void cxl_dax_region_release(struct device *dev)
>  {
>  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
>  
> +	xa_destroy(&cxlr_dax->region_extents);
>  	kfree(cxlr_dax);
>  }
>  
> @@ -3590,6 +3591,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
>  	if (!cxlr_dax)
>  		return ERR_PTR(-ENOMEM);
>  
> +	xa_init(&cxlr_dax->region_extents);
>  	cxlr_dax->hpa_range.start = p->res->start;
>  	cxlr_dax->hpa_range.end = p->res->end;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 53d8a2f0d1272..715fa9e580cb0 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -637,7 +637,14 @@ struct cxl_dax_region {
>  	struct device dev;
>  	struct cxl_region *cxlr;
>  	struct range hpa_range;
> -	struct region_extent *region_extent;
> +	/*
> +	 * region_extents is keyed by an allocator-assigned u32 (see
> +	 * online_region_extent()), not by extent UUID.  The UUID is a
> +	 * 128-bit pseudo-random identity carried on each region_extent;
> +	 * tag lookup is a linear xa_for_each walk, which is adequate at
> +	 * the bounded per-region tag counts this driver handles.
> +	 */
> +	struct xarray region_extents;
>  };
>  
>  /**

