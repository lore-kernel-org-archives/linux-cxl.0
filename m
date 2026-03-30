Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFADF3A6F17
	for <linux-cxl@vger.kernel.org>; Mon, 30 Mar 2026 21:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774907804; cv=none; b=jELv7zTrsxbELTr6Zghyr8DALilnptIXfbCB54TAbVn/n4qwWxrExqOGgpWujt5uflLR5L8UINRZhS4ruzJJWkB2O2Guo59kgmg5h5Ss/oso+whbdGw6/+r5/e4a2P98HuIf8pAsDhP8sgdJigY8vkk4aNqieLOvalu5gQH3zSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774907804; c=relaxed/simple;
	bh=xwjwsz8bkfpLtPa854hixUTWybNG3yPRvL5Lus5rl1A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XYzfwfrU467njZchUmaA4VjrNYvoHCpCEpvbbba9sKlRM7gYhfp+oFZ9dJS1vsu6vJO/QS0vFiE82a2V0yEP5R9/WZylRrZu7kWtAWJ1fge7pB9rKoZy/aL7IZAsP8FwDHwVnqM/ItFtWaXU3xxApW4dJ41CT8ldX6dvHWd7OgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q3TJOb4O; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q3TJOb4O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774907803; x=1806443803;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xwjwsz8bkfpLtPa854hixUTWybNG3yPRvL5Lus5rl1A=;
  b=Q3TJOb4OAeYRQ3nwadUXghvDkUO3Y6Ajyn/m0UNSmp7bHNc3ObuBEAmq
   nqYTNZCltt60YpIR8TOR+UIf2FDU11nSLIkcR24lwg0MJkebZoOPnk5qS
   qx481Nat3KpSTIiCXQO00/8LHRE9O4mQ2DWVyPdwQBYomYECRexpMLQbL
   Z/Z7/y2cgbxyapWj0G90l3QkshWf+mpcD075nq526WgdvXkTEyptMfIp6
   SC+gpUZYo1rZsWl3Acxo6Frdig4nSF+602/vBxxkJnvppED6I0TZVheji
   eT2q9AtvJ5uqwp8/dtmwTjrHBO9rBlBQhid4g+yidDp23mxuGl/u1rBXM
   g==;
X-CSE-ConnectionGUID: v3A7W1wmT0SeLvaBOfnb4g==
X-CSE-MsgGUID: /tLDrDWISMKO24daLxgYaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11744"; a="76021512"
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="76021512"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:56:42 -0700
X-CSE-ConnectionGUID: ToN1NCsBQ+ehorzN9qhn3A==
X-CSE-MsgGUID: sl26qLVpToK/Q8DrpyblpA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,150,1770624000"; 
   d="scan'208";a="225342233"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.111.4]) ([10.125.111.4])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2026 14:56:41 -0700
Message-ID: <c52d8c3e-2a3c-432b-b207-a0d061a660f5@intel.com>
Date: Mon, 30 Mar 2026 14:56:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ndctl: Show region locked status to user
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org
References: <20260329144714.888155-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260329144714.888155-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/29/26 7:47 AM, Li Ming wrote:
> A region is not allowed to be destroyed if it is in locked status.
> cxl destroy-region command will fail and ask user to try it again as
> root, but it is not the real reason and it will confuse user if user is
> already a root user. This patch will shows the region locked status in
> region information and outputs an explicit log to user that operation is
> not allowed like below.
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
> root@jammy-cloud:~/ndctl# cxl list -ir region0
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
>  cxl/json.c         |  4 ++++
>  cxl/lib/libcxl.c   | 11 +++++++++++
>  cxl/lib/libcxl.sym |  5 +++++
>  cxl/lib/private.h  |  1 +
>  cxl/libcxl.h       |  1 +
>  cxl/region.c       |  6 ++++++
>  6 files changed, 28 insertions(+)
> 
> diff --git a/cxl/json.c b/cxl/json.c
> index a0dc343..3bbe07a 100644
> --- a/cxl/json.c
> +++ b/cxl/json.c
> @@ -1077,6 +1077,10 @@ struct json_object *util_cxl_region_to_json(struct cxl_region *region,
>  			json_object_object_add(jregion, "state", jobj);
>  	}
>  
> +	jobj = json_object_new_boolean(cxl_region_is_locked(region));
> +	if (jobj)
> +		json_object_object_add(jregion, "locked", jobj);
> +
>  	if (flags & UTIL_JSON_MEDIA_ERRORS) {
>  		jobj = util_cxl_poison_list_to_json(region, NULL, flags);
>  		if (jobj)
> diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> index 5e8deb6..ce2b364 100644
> --- a/cxl/lib/libcxl.c
> +++ b/cxl/lib/libcxl.c
> @@ -472,6 +472,11 @@ CXL_EXPORT int cxl_region_is_enabled(struct cxl_region *region)
>  	return is_enabled(path);
>  }
>  
> +CXL_EXPORT bool cxl_region_is_locked(struct cxl_region *region)
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
> +		region->locked = false;
> +	else
> +		region->locked = strtoul(buf, NULL, 0);
> +
>  	cxl_region_foreach_safe(decoder, region_dup, _r)
>  		if (region_dup->id == region->id) {
>  			list_del_from(&decoder->regions, &region_dup->list);
> diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> index 797e398..7c586f4 100644
> --- a/cxl/lib/libcxl.sym
> +++ b/cxl/lib/libcxl.sym
> @@ -315,3 +315,8 @@ global:
>  	cxl_memdev_clear_poison;
>  	cxl_debugfs_exists;
>  } LIBCXL_10;
> +
> +LIBCXL_12 {
> +global:
> +	cxl_region_is_locked;
> +} LIBCXL_11;
> diff --git a/cxl/lib/private.h b/cxl/lib/private.h
> index 582eebf..d074122 100644
> --- a/cxl/lib/private.h
> +++ b/cxl/lib/private.h
> @@ -189,6 +189,7 @@ struct cxl_region {
>  	u64 start;
>  	u64 size;
>  	u64 cache_size;
> +	bool locked;
>  	unsigned int interleave_ways;
>  	unsigned int interleave_granularity;
>  	enum cxl_decode_state decode_state;
> diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> index a853ab6..6ff58de 100644
> --- a/cxl/libcxl.h
> +++ b/cxl/libcxl.h
> @@ -353,6 +353,7 @@ int cxl_region_clear_all_targets(struct cxl_region *region);
>  int cxl_region_decode_commit(struct cxl_region *region);
>  int cxl_region_decode_reset(struct cxl_region *region);
>  bool cxl_region_qos_class_mismatch(struct cxl_region *region);
> +bool cxl_region_is_locked(struct cxl_region *region);
>  
>  #define cxl_region_foreach(decoder, region)                                    \
>  	for (region = cxl_region_get_first(decoder); region != NULL;           \
> diff --git a/cxl/region.c b/cxl/region.c
> index 207cf2d..a3b511e 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -853,6 +853,12 @@ static int destroy_region(struct cxl_region *region)
>  		}
>  	}
>  
> +	if (cxl_region_is_locked(region)) {
> +		log_err(&rl, "%s: Cannot destroy a locked region.\n",
> +			devname);
> +		return -EPERM;
> +	}
> +
>  	/* Reset the region decode in preparation for removal */
>  	rc = cxl_region_decode_reset(region);
>  	if (rc) {

