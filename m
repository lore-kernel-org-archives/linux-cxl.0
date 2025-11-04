Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE3183321DF;
	Tue,  4 Nov 2025 17:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762276423; cv=none; b=REm9JJgdQUBI6yrqtEFTrc6pDBFOo0QnQHOooWzF/Kkp+EdyWQoDJrSsr+hTv70a9TMeAg0jYBZMDvmr7ankrrI3Mqjx0Dp2mXQjy6LuaUB6FwZnlScn/8UxdfPzv9TzKP0ywTTc3rjeaOu1NbVSxAKxdpPAeVLyP22LGmDt3C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762276423; c=relaxed/simple;
	bh=kyJEGDVqlyC03PDfLG2BWsfWjvb/fgVAG7RwEUTRdh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YO6U1OK1MctEoqoeR26TE8JXhIwQUqE+pE9qeruS+kiu4jmMiVM2A4v353tG3q26i4zN0JUd1pW4TIKMeLdY8fA5Px+KlaF53HhC7FAWL/jzoa4C2Pfzriu90jo5aDH0ehjvy4EfcMuM64H6Btn6nsn3mgf+sYehe9UmCU96uX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=e/Wl3QPl; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="e/Wl3QPl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762276422; x=1793812422;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=kyJEGDVqlyC03PDfLG2BWsfWjvb/fgVAG7RwEUTRdh4=;
  b=e/Wl3QPlQ1IS7y6TMRy8SYocAWc9052cojPn4QfTtl0gY9+w5ouz8pYF
   l4RQAjsdZqiCZzQ5KiTk/gTqjPLyznfDg0uxcQlrX6z8de5qKiMKorbt/
   OxImXFVvJlQeeAJgPMnERqDx7f2FHbKbrUpS5Ki8zzLw+KCUyIxOW3YtS
   tAX/pmYhqc0kv9R88EXeC2MyzpJ6g0OBOUm1tNq+sw3ZTRq0uEvdcS4qs
   yfR7n2EAVqquZ8tOMeGX5A8pQ6K8VN3Phystl15wcgY/lroxDvzrtmg7P
   Ufdx4P0pLVPHIpbZoTEkPVaan9Ioo0TyGPw+TZ37SwcBG4/O32KFnjwip
   Q==;
X-CSE-ConnectionGUID: hQAaN64qQOKarLYnm+od1Q==
X-CSE-MsgGUID: nn2xedxhQhOinUT4UWhUxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="81784799"
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="81784799"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:13:36 -0800
X-CSE-ConnectionGUID: d5wse++8Sma4rYZOLgOe9g==
X-CSE-MsgGUID: 7haD6cuGTua8bLtkq1Wv7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,279,1754982000"; 
   d="scan'208";a="187159814"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 09:13:35 -0800
Message-ID: <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
Date: Tue, 4 Nov 2025 10:13:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
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
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-12-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-12-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> There is only support to translate addresses from an endpoint to its
> CXL host bridge, but not in the opposite direction from the bridge to
> the endpoint. Thus, the endpoint address range cannot be determined
> and setup manually for a given SPA range of a region. If the endpoint
> has address translation enabled, lock it to prevent the kernel from
> reconfiguring it.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/atl.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
> index d6aa7e6d0ac5..5c15e4d12193 100644
> --- a/drivers/cxl/core/atl.c
> +++ b/drivers/cxl/core/atl.c
> @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
>  		return -ENXIO;
>  	}
>  
> +	/*
> +	 * There is only support to translate from the endpoint to its
> +	 * parent port, but not in the opposite direction from the
> +	 * parent to the endpoint. Thus, the endpoint address range
> +	 * cannot be determined and setup manually. If the address range
> +	 * was translated and modified, forbid reprogramming of the
> +	 * decoders and lock them.
> +	 */
> +	cxld->flags |= CXL_DECODER_F_LOCK;

Feels like this should be something the BIOS should enforce if that is the expectation? And the kernel checks and warns if that is not the case.


> +
>  	ctx->hpa_range = hpa_range;
>  	ctx->interleave_ways = ways;
>  	ctx->interleave_granularity = gran;

