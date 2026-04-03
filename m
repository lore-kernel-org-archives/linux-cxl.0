Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF82272E61
	for <linux-cxl@vger.kernel.org>; Fri,  3 Apr 2026 14:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775226883; cv=none; b=aHBqs8Qc7EeGpwnkB2b0fWd0rOy6yF3c+IZqzuI7lpOAD7nEwK31Pp8Y9cO/dhRH3C4SXWzfWjctWzXCR8a5HLdeRDd6TIWdCyj4IeXr+OK4MDnuQGapEO6d0Oe6RTbPXRG0eVv+hAJP1nyjNffgs+Cob82mYBpSZgFDMyiuLns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775226883; c=relaxed/simple;
	bh=Xr2C4lS2VB87h4Vzy2Dp2Chx7DEsE6AgqBKnpzPniYU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o13hLTfK/oAd8xp3NaUW3pzPr33nlnRB9PlyhHnejchA8TS1pvM1pqnR90KBe/2Vd+Jy5xf+RQqUPlVOImCjiVINMWdeYdmSI0etW1PGm3D+X/BnVtw9irf6Rcfy5PiCqf59xNwSNt/QwPrSM9rwuWBM/PbxbQ5CYAtLLKI3Xhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AA4Mv+nF; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AA4Mv+nF"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775226881; x=1806762881;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Xr2C4lS2VB87h4Vzy2Dp2Chx7DEsE6AgqBKnpzPniYU=;
  b=AA4Mv+nFCmKJl4ZD9xzxMjfQOIx+VFKPWCIJMEw7uRIGB7LLa81d+dEb
   8Egr4ebCYbI7y8ML9pxoG4SUFkQN/bhDIzKdKSguvkVDMQ9Z/XacCzXNO
   aSHGAYeYzLQ6ZjLYgmANy5clf0GWvCfYaWTxZBP9F3G++tkvjr0BbmBl3
   VjxFlBmapbhbFHzq3vsKTBrQr7wOmMY04xtYcj2hrC/szbvv4TZuMA0Qi
   3T8Go7iHlqk7RE7eAk3O3cnR2uqPj6vaVMdnb01TIBaPvsASL0+yvcA7h
   62DD4+iQOyWFnmmybb948AOIMPHhasjyEU2eKUQTvo4MXLGK08eK7GZZn
   Q==;
X-CSE-ConnectionGUID: UpMOt6XhTOeZeqAYfmNeyg==
X-CSE-MsgGUID: anJgAd1YTme+od3n84lnUw==
X-IronPort-AV: E=McAfee;i="6800,10657,11748"; a="86908478"
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="86908478"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 07:34:40 -0700
X-CSE-ConnectionGUID: RCT3IhasRo2sDK1Nv7afKg==
X-CSE-MsgGUID: 3R0kU9cxQ4CcAH53ELsBwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,157,1770624000"; 
   d="scan'208";a="232072975"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.111.241]) ([10.125.111.241])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2026 07:34:39 -0700
Message-ID: <c70de147-f84d-48a6-9ae6-bcb4d7232731@intel.com>
Date: Fri, 3 Apr 2026 07:34:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [ndctl PATCH v3 1/1] ndctl/cxl: Show region locked status to user
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20260403050459.2236-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260403050459.2236-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/26 10:04 PM, Li Ming wrote:
> A region is not allowed to be destroyed if it is in locked status.
> cxl destroy-region command will fail and ask user to try it again as
> root, but it is not the real reason and it will confuse user if user is
> already a root user. This patch will show the region locked status in
> region information and output an explicit log to user that operation is
> not permitted like below.
> 
> Before the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> libcxl: write_attr: failed to write 0
>  to /sys/bus/cxl/devices/root0/decoder0.0/region0/commit: Operation not permitted hint: try running as root or using sudo
> cxl region: destroy_region: region0: failed to reset decode: Operation not permitted
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions
> 
> After the patch:
> cxl list -ir region0
> [
>   {
>     "region":"region0",
>     "resource":53955526656,
>     "size":536870912,
>     "type":"ram",
>     "interleave_ways":2,
>     "interleave_granularity":256,
>     "decode_state":"commit",
>     "state":"disabled",
>     "locked":true,
>     "qos_class_mismatch":true
>   }
> ]
> 
> cxl destroy-region region0
> cxl region: destroy_region: region0: Cannot destroy a locked region.
> cxl region: decoder_region_action: region0: failed: Operation not permitted
> cxl region: region_action: one or more failures, last failure: Operation not permitted
> cxl region: cmd_destroy_region: destroyed 0 regions
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> v3:
> * Set locked state to unknown if no sysfs locked attribute exposed.
>   (Alison)
> 
> v2:
> * Move lock status checking to the beginning of destroy_region().
>   (Alison)
> ---
>  cxl/json.c         |  6 ++++++
>  cxl/lib/libcxl.c   | 11 +++++++++++
>  cxl/lib/libcxl.sym |  5 +++++
>  cxl/lib/private.h  |  1 +
>  cxl/libcxl.h       |  8 ++++++++
>  cxl/region.c       |  6 ++++++
>  6 files changed, 37 insertions(+)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index a0dc343..eee7781 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -1077,6 +1077,12 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
>  			json_object_object_add(jregion, "state", jobj);
>  	}
>  
> +	if (cxl_region_locked_state(region) != CXL_REGION_LOCKED_UNKNOWN) {
> +		jobj = json_object_new_boolean(cxl_region_locked_state(region));
> +		if (jobj)
> +			json_object_object_add(jregion, "locked", jobj);
> +	}
> +
>  	if (flags & UTIL_JSON_MEDIA_ERRORS) {
>  		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
>  		if (jobj)
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 5e8deb6..2945d21 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
>  	return is_enabled(path);
>  }
>  
> +CXL_EXPORT int cxl_region_locked_state(struct cxl_region *region)
> +{
> +	return region->locked;
> +}
> +
>  CXL_EXPORT bool cxl_region_qos_class_mismatch(struct cxl_region *region)
>  {
>  	struct cxl_decoder *root_decoder = cxl_region_get_decoder(region);
> @@ -689,6 +694,12 @@ static void *add_cxl_region(void *parent, int id, const char *cxlregion_base)
>  	if (sysfs_read_attr(ctx, path, buf) == 0)
>  		region->module = util_modalias_to_module(ctx, buf);
>  
> +	sprintf(path, "%s/locked", cxlregion_base);
> +	if (sysfs_read_attr(ctx, path, buf) < 0)
> +		region->locked = CXL_REGION_LOCKED_UNKNOWN;
> +	else
> +		region->locked = strtoul(buf, NULL, 0);
> +
>  	cxl_region_foreach_safe(decoder, region_dup, _r)
>  		if (region_dup->id == region->id) {
>  			list_del_from(&decoder->regions, &region_dup->list);
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 797e398..ed4429f 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -315,3 +315,8 @@ global:
>  	cxl_memdev_clear_poison;
>  	cxl_debugfs_exists;
>  } LIBCXL_10;
> +
> +LIBCXL_12 {
> +global:
> +	cxl_region_locked_state;
> +} LIBCXL_11;
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index 582eebf..d2d71fc 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -189,6 +189,7 @@ struct cxl_region {
>  	u64 start;
>  	u64 size;
>  	u64 cache_size;
> +	enum cxl_region_locked_state locked;
>  	unsigned int interleave_ways;
>  	unsigned int interleave_granularity;
>  	enum cxl_decode_state decode_state;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index a853ab6..e6eec8e 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -354,6 +354,14 @@ int cxl_region_decode_commit(struct cxl_region *region);
>  int cxl_region_decode_reset(struct cxl_region *region);
>  bool cxl_region_qos_class_mismatch(struct cxl_region *region);
>  
> +enum cxl_region_locked_state {
> +	CXL_REGION_LOCKED_UNKNOWN = -1,
> +	CXL_REGION_UNLOCKED,
> +	CXL_REGION_LOCKED,
> +};
> +
> +int cxl_region_locked_state(struct cxl_region *region);
> +
>  #define cxl_region_foreach(decoder, region)                                    \
>  	for (region = cxl_region_get_first(decoder); region != NULL;           \
>  	     region = cxl_region_get_next(region))
> diff --git a/cxl/region.c b/cxl/region.c
> index 207cf2d..853cd08 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -837,6 +837,12 @@ static int destroy_region(struct cxl_region *region)
>  	unsigned int ways, i;
>  	int rc;
>  
> +	if (cxl_region_locked_state(region) == CXL_REGION_LOCKED) {
> +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
> +			devname);
> +		return -EPERM;
> +	}
> +
>  	/* First, unbind/disable the region if needed */
>  	if (cxl_region_is_enabled(region)) {
>  		if (param.force) {

