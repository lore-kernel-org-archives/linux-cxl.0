Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289432FE58A
	for <linux-cxl@vger.kernel.org>; Tue, 14 Oct 2025 14:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760453176; cv=none; b=PbSiuPmAn5xQXSuUkyy6RK/LJgKI6UiI44BP+TjnT+JbpjRQSGWzLTbHb2igK97dg9yQ25JSQcnRnkDg0w/v+oM6MMORaGEtqze9XFYmkMTpknCaGC62ef8Ljw9SqlHCS22vtK3DOgqwPMWJ4qKqGCgfaOJ9kLrZsZhUldWYPBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760453176; c=relaxed/simple;
	bh=iRAx05/eHuPA/scCTbiUVnfeIZZ3aYbXrgkmMFwlpqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JoqqqbK9Z0ei5jErIEPcaR3KSONFqxBe8W9KgVlbUKiGQG7Rqt07RY9s+6o1F5wtyKWz04U7Kh2jnR+zZshUuYDmMgq33iDadaH0RLXrL28grVZK0XwdnBwl+9DIhw2bre6LNcieSU5y+xT4VOQpecY/jVh7AbTuridVN2b8CFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XEFtfhOo; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XEFtfhOo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760453175; x=1791989175;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=iRAx05/eHuPA/scCTbiUVnfeIZZ3aYbXrgkmMFwlpqk=;
  b=XEFtfhOolv/k8Uv3oyw2zZyEQVWtUUvXEYrXCI6cO/V1l/uvRUwtKU0W
   k9Zen0dyz5pO0S7x2Sbfi6rtmbiYpeWYgeqT8epv39kAvDW+Ml/C3Sx+x
   O7XVcKCVY9dFBGewQ5q+dovhRsxtLlpHjRg+m4PpN4YKpIDQb/MVTkntI
   jHMna4MOGinZuwsCHyTs4NWTv1okLJeX9pvXTdro70hD0cB5W73knNK43
   /TTNeahfZYV/OAgFymltoafUVfSQME+WbdUdaI47cqITTWu+FHLJiQK+1
   Y+lmJBY/oKk03QGqqq5CcP6uI5qejcVqfezaeJzbfsSmNkQ91ahzP4+Qz
   g==;
X-CSE-ConnectionGUID: kslSLSxkTay2xctcnqHNIQ==
X-CSE-MsgGUID: 1x4ZbYZuQsaZOthwz//cSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11582"; a="73214387"
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="73214387"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:46:15 -0700
X-CSE-ConnectionGUID: elOmSL/fQaK8+ROddAyQ9Q==
X-CSE-MsgGUID: Ytwg2Q/kRpWH8DUqOayZdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,228,1754982000"; 
   d="scan'208";a="186995361"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.111.176]) ([10.125.111.176])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2025 07:46:14 -0700
Message-ID: <e04e41c6-5636-4b83-9191-1bcc6f14418d@intel.com>
Date: Tue, 14 Oct 2025 07:46:13 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Use %pa printk format to emit resource_size_t
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20251014073106.730952-1-alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251014073106.730952-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/14/25 12:31 AM, Alison Schofield wrote:
> KASAN reports a stack-out-of-bounds access in validate_region_offset()
> while running the cxl-poison.sh unit test because the printk format
> specifier, %pr format, is not a match for the resource_size_t type of
> the variables. %pr expects struct resource pointers and attempts to
> dereference the structure fields, reading beyond the bounds of the
> stack variables.
> 
> Since these messages emit  an 'A exceeds B' type of message, keep
> the resource_size_t's and use the %pa specifier to be architecture
> safe.
> 
> BUG: KASAN: stack-out-of-bounds in resource_string.isra.0+0xe9a/0x1690
> [] Read of size 8 at addr ffff88800a7afb40 by task bash/1397
> ...
> [] The buggy address belongs to stack of task bash/1397
> []  and is located at offset 56 in frame:
> []  validate_region_offset+0x0/0x1c0 [cxl_core]
> 
> Fixes: c3dd67681c70 ("cxl/region: Add inject and clear poison by region offset")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Applied to cxl/fixes

> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e14c1d305b22..4e567f7e06bc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3666,14 +3666,14 @@ static int validate_region_offset(struct cxl_region *cxlr, u64 offset)
>  
>  	if (offset < p->cache_size) {
>  		dev_err(&cxlr->dev,
> -			"Offset %#llx is within extended linear cache %pr\n",
> +			"Offset %#llx is within extended linear cache %pa\n",
>  			offset, &p->cache_size);
>  		return -EINVAL;
>  	}
>  
>  	region_size = resource_size(p->res);
>  	if (offset >= region_size) {
> -		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pr\n",
> +		dev_err(&cxlr->dev, "Offset %#llx exceeds region size %pa\n",
>  			offset, &region_size);
>  		return -EINVAL;
>  	}
> 
> base-commit: 3a8660878839faadb4f1a6dd72c3179c1df56787

