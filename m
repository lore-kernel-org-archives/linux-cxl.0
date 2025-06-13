Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D167B3594F;
	Fri, 13 Jun 2025 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749830201; cv=none; b=G0hprV+0SxBX3SwZe/+Emahywq5ll5KgqezUT1OJqKYoTrcYZUuePXUlBWiibLLttRynUnBYaR7OPwap8q3unZs53zHO99MPyGxZ76MZl7v4Ec6SBdiASiOg7QKwFMnH59wctAgBMF+p165C8hgIAqPuj9Wy5YNCOKgS8jO6grA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749830201; c=relaxed/simple;
	bh=T32rF5Ppsy5mjl762Ap1LKWpRnK50PIiK7HeE2yoxkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RWSdf6PgvKtbZJvp2qKB/toXVzygFZpO5z4QQezrvcODNuZDtWf8SI5ohzBh5GWfntu49+fm9hzjgCKaEcZjm7H0FPlRo5r/OmzVbJwBnG/4WQVg8HDhDg70zkFyi7Fzp9JGs8z4pzkfUi+rAbTm20rb3G2dpyTdT2lhdkrZvKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LebIydd3; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LebIydd3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749830199; x=1781366199;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T32rF5Ppsy5mjl762Ap1LKWpRnK50PIiK7HeE2yoxkk=;
  b=LebIydd3yb4lCSnWtHpuWawqXGb0KuB5W7SB8uhXhtpTosdpxLneYNEN
   nnIWqdQXNesKjPWhiJfshNmGakSUvz0ON/TcHzE8rL1rsHqBJkzkxN04z
   IFX4unHSd/oZAAu2TGbuyJQJCSkQzBcPADYpH2M5iTi0v7U2Y93MBRSvk
   xmA3kOL5M+WFXq5MEM1X61Hr0+fF06z4Cn2wYTK/0uJz8H+CuCC43lbn9
   4Tri7dPBpNoJZvndxxNrJWOZA1I76cHN2suu2I+hW0zVzZ4oLv3G44K4l
   27ALOyNohZJCqgzkd8aIAip5Jnq8+gotPa0VIrIaHurpvAggOC0FT986Z
   A==;
X-CSE-ConnectionGUID: 3oo6Laf3T8KQbcJRe410hw==
X-CSE-MsgGUID: fGCwrwDpSAG+pB9w+rbvtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11463"; a="39660878"
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="39660878"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:56:38 -0700
X-CSE-ConnectionGUID: 6y7GbN6TTkO5xEqqlI6GqQ==
X-CSE-MsgGUID: pwLhQMyvQ+il9thN61lIOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,234,1744095600"; 
   d="scan'208";a="178842443"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.111.232]) ([10.125.111.232])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2025 08:56:36 -0700
Message-ID: <ada06e3d-598f-4d6d-a468-f007be3f29ca@intel.com>
Date: Fri, 13 Jun 2025 08:56:33 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/1] cxl/edac: Fix potential memory leak issues
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250613011648.102840-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250613011648.102840-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/12/25 6:16 PM, Li Ming wrote:
> In cxl_store_rec_gen_media() and cxl_store_rec_dram(), use kmemdup() to
> duplicate a cxl gen_media/dram event to store the event in a xarray by
> xa_store(). The cxl gen_media/dram event allocated by kmemdup() should
> be freed in the case that the xa_store() fails.
> 
> Fixes: 0b5ccb0de1e2 ("cxl/edac: Support for finding memory operation attributes from the current boot")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> Tested-by: Shiju Jose <shiju.jose@huawei.com>
> Reviewed-by: Shiju Jose <shiju.jose@huawei.com>
> ---
> v2:
> * Use kfree() instead of __free(kfree). (Jonathan)
> 
> base-commit: 87b42c114cdda76c8ad3002f2096699ad5146cb3 cxl/next

Applied to cxl/fixes

In the future, probably best to base against Linus's latest rc rather than cxl/next. Thanks.

> ---
>  drivers/cxl/core/edac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/edac.c b/drivers/cxl/core/edac.c
> index 2cbc664e5d62..628786def464 100644
> --- a/drivers/cxl/core/edac.c
> +++ b/drivers/cxl/core/edac.c
> @@ -1099,8 +1099,10 @@ int cxl_store_rec_gen_media(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  	old_rec = xa_store(&array_rec->rec_gen_media,
>  			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
>  			   GFP_KERNEL);
> -	if (xa_is_err(old_rec))
> +	if (xa_is_err(old_rec)) {
> +		kfree(rec);
>  		return xa_err(old_rec);
> +	}
>  
>  	kfree(old_rec);
>  
> @@ -1127,8 +1129,10 @@ int cxl_store_rec_dram(struct cxl_memdev *cxlmd, union cxl_event *evt)
>  	old_rec = xa_store(&array_rec->rec_dram,
>  			   le64_to_cpu(rec->media_hdr.phys_addr), rec,
>  			   GFP_KERNEL);
> -	if (xa_is_err(old_rec))
> +	if (xa_is_err(old_rec)) {
> +		kfree(rec);
>  		return xa_err(old_rec);
> +	}
>  
>  	kfree(old_rec);
>  

