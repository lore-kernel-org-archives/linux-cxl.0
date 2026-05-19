Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2A6233943
	for <linux-cxl@vger.kernel.org>; Tue, 19 May 2026 23:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779232420; cv=none; b=EsUrOEK+ZSO8APnYjJOT2LL2Ol6H6ts2vBuL+MCRp1KY7ku3lUmOk1co3H2TC5qSMtYAGz9TrLSWJotTe+AUZdC0YhHrBVO8m99FrrMuczfBaO5it0U9NmlCsK3wN9jjLhb92a336B/w55ae8tMLzlkppH9RW3/bQPm+zxNvJHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779232420; c=relaxed/simple;
	bh=0GCtwIMIq7XXu1o4fMN0wkLYUkamWN1eWYsyXmYsGh0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzG4DS/kdXPX/6Tc5M7Qpn0ndSyIK9mg1nx4LYjAmI5SUyKrD1VRrxKgtLQIeATefLSeXwItkNbI/rsaPxFBfxgp4HIFYe/Krlm+/3wEXN/3TXSWpyYcRSbuOPHHAHj6E8j6AemONB2sLGHq9pj/n87nwwYt3UbQovq+a6C9kWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aJDRPH93; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aJDRPH93"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779232420; x=1810768420;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=0GCtwIMIq7XXu1o4fMN0wkLYUkamWN1eWYsyXmYsGh0=;
  b=aJDRPH93tpNQP0Ylt2f90Ruqs4P9O7bsVPiyj5Sp1wQ26w4dIwBPC7nU
   tstzEWKTNkJPhARx7bQ9kXKy0fbGmIFcrNGXKbpDyEbo9CA3+nS41OaRn
   L0y6oNJHnbmwBAWomf2tNz8/pQuklMteK/oWq+HGPFuNio1xBI45yuDbo
   cAIRyafzvW0fWB3W2LnmgsymhApL5nw61G6rfODkWAmHMyjCfMQ8hx2/b
   d0marZd6PEHARgHrqk4omT8RHUAty8S9Jm7D7Z/mJmxxKhLuNhulNcPkl
   1oud7gOVJ2KO7JI+P1x9R5MgcUGPIZUa+Y0vqGs7/QY9YTq2fTGTdqqTY
   w==;
X-CSE-ConnectionGUID: wP+sjpeDRnClAIwTTXsK7w==
X-CSE-MsgGUID: G7iOb+j4Svyuns+GYAdHEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="79273007"
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="79273007"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 16:13:39 -0700
X-CSE-ConnectionGUID: c1p+y1qBSDWVbJMIHPcpJA==
X-CSE-MsgGUID: RjrVVO0QRRiWcvito3fZbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,243,1770624000"; 
   d="scan'208";a="235502016"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.109.143]) ([10.125.109.143])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2026 16:13:38 -0700
Message-ID: <2b86f67c-065b-49f3-ba58-74568481a059@intel.com>
Date: Tue, 19 May 2026 16:13:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] cxl/test: Fix __fortify_panic
To: Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org
Cc: alison.schofield@intel.com
References: <20260519221204.1517773-1-djbw@kernel.org>
 <20260519221204.1517773-3-djbw@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519221204.1517773-3-djbw@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 3:12 PM, Dan Williams wrote:
> Fix a runtime assertion in setup_xor_mapping(). Fortify complains that it
> is potentially overflowing the xormaps array per __counted_by(nr_maps).
> Quiet the false positive by initializing @nr_entries earlier.

@nr_maps?


> 
>  memcpy: detected buffer overflow: 32 byte write of buffer size 0
>  WARNING: lib/string_helpers.c:1036 at __fortify_report+0x4d/0xa0, CPU#8: modprobe/2728
>  Call Trace:
>   __fortify_panic+0xd/0xf
>   setup_xor_mapping+0x6c/0xa0 [cxl_translate]
> 
> Fixes: 06377c54a133 ("cxl/test: Add cxl_translate module for address translation testing")
> Signed-off-by: Dan Williams <djbw@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  tools/testing/cxl/test/cxl_translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl_translate.c b/tools/testing/cxl/test/cxl_translate.c
> index 16328b2112b2..25a27e01ac21 100644
> --- a/tools/testing/cxl/test/cxl_translate.c
> +++ b/tools/testing/cxl/test/cxl_translate.c
> @@ -236,8 +236,8 @@ static int setup_xor_mapping(void)
>  	if (!cximsd)
>  		return -ENOMEM;
>  
> -	memcpy(cximsd->xormaps, xormaps, nr_maps * sizeof(*cximsd->xormaps));
>  	cximsd->nr_maps = nr_maps;
> +	memcpy(cximsd->xormaps, xormaps, nr_maps * sizeof(*cximsd->xormaps));
>  
>  	return 0;
>  }

