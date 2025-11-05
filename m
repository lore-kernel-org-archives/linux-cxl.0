Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025933375B9;
	Wed,  5 Nov 2025 18:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762368718; cv=none; b=kRFyEIyxRRz7rfIbWrr9bFW6PW0hcXpfNJ///nDM1VuPrL5HqwAEdJTEqd4s34ZsGkf8vwic2/Akc5AVQ1jGG57jsKj6PLTBEhHyQ5f3UPD1XByFAe80fPq4511+7KJw/zZkQVKbL1AxVtPhxinDSoHuLjppBbFdXnvlb4eb0PI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762368718; c=relaxed/simple;
	bh=hD0/McD68PyBa+dj++HMH8vhSjmG0wLiAUBAv1ByDuY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jQ6ZDmihq+YnLEwfHVMfV59f35SPo3hX2brD/ch6gP+rjADsspXZ63FP9myBAs1El8rcC1VSnV7vbxY2ybodhaib+ZnIPL4lAltJ3mq9ZaC15irYYQKJ0E9SM7ZWnvKBr+O/Yt73rfnxEK0JnyqGKEWBzcXHE1BTOIFBfVyEQXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDgjTE3Q; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDgjTE3Q"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762368718; x=1793904718;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=hD0/McD68PyBa+dj++HMH8vhSjmG0wLiAUBAv1ByDuY=;
  b=JDgjTE3Q4dQSQAKKVsoyq3g8Q6FUM7eETKWNGdWIVHLbSIf6h+1QMEgw
   ytTdIsnKp1WVlXxmvIekxOPVKTJ5dO+eF4CsIuAOMCs/GNjATwvnicE6F
   FuizEWgbjnr904886mtWAQ54/KYwkkR7hoGeX5YBNBGP1K9kFG/lWC5LM
   Q8d/XL7iZi03qJW0LBRJj8PE55f6/qYv1H2YIc68LKI4ye96cQgXxGjWq
   4qD9AXDeZtdvsbT/WqS3G1yYjCxwymvVSge+8/5HcPLCDA9wPpe47v2qF
   otjBhuKNc+EoiJQibaW7a+W1xPkzuKAo5e4VzkGdOPN7pGaxGl1uI0Q4y
   g==;
X-CSE-ConnectionGUID: sD7z+Ni1SV6H9nvqo8zFFw==
X-CSE-MsgGUID: DINOTT3uSGy/gnz6SJgQAA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="64644581"
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="64644581"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:51:57 -0800
X-CSE-ConnectionGUID: XZFX++rnQSOGeCixIC6nmQ==
X-CSE-MsgGUID: PsVuI6AGTL6kp+L0JIj+DQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,282,1754982000"; 
   d="scan'208";a="187200398"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.242]) ([10.125.110.242])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 10:51:55 -0800
Message-ID: <d3d1757a-20b1-49e4-90fe-8a1751c40c59@intel.com>
Date: Wed, 5 Nov 2025 11:51:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes
 on x86
To: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>
Cc: llvm@lists.linux.dev, oe-kbuild-all@lists.linux.dev,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>, Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
References: <20251006155836.791418-3-fabio.m.de.francesco@linux.intel.com>
 <202510102229.iFcGqbMH-lkp@intel.com> <2093111.UnXabflUDm@fdefranc-mobl3>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <2093111.UnXabflUDm@fdefranc-mobl3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/5/25 11:20 AM, Fabio M. De Francesco wrote:
> On Friday, October 10, 2025 4:49:01 PM Central European Standard Time kernel test robot wrote:
>> Hi Fabio,
>>
>> kernel test robot noticed the following build warnings:
>>
>> [auto build test WARNING on 46037455cbb748c5e85071c95f2244e81986eb58]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Fabio-M-De-Francesco/cxl-core-Change-match_-_by_range-signatures/20251010-111627
>> base:   46037455cbb748c5e85071c95f2244e81986eb58
>> patch link:    https://lore.kernel.org/r/20251006155836.791418-3-fabio.m.de.francesco%40linux.intel.com
>> patch subject: [PATCH 2/4 v5] cxl/core: Add helpers to detect Low Memory Holes on x86
>> config: i386-randconfig-011-20251010 (https://download.01.org/0day-ci/archive/20251010/202510102229.iFcGqbMH-lkp@intel.com/config)
>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 87f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20251010/202510102229.iFcGqbMH-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new version of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202510102229.iFcGqbMH-lkp@intel.com/
>>
>> All warnings (new ones prefixed by >>):
>>
>>>> drivers/cxl/core/platform_quirks.c:70:36: warning: result of comparison of constant 4294967296 with expression of type 'const resource_size_t' (aka 'const unsigned int') is always true [-Wtautological-constant-out-of-range-compare]
>>       70 |             res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
>>          |                                  ~~~~~~~~ ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>    1 warning generated.
>>
> Unavoidable warning wherever res->end is an u32 variable:
> 
> /* include/linux/types.h */
> 
> #ifdef CONFIG_PHYS_ADDR_T_64BIT
> typedef u64 phys_addr_t;
> #else
> typedef u32 phys_addr_t;
> #endif
> 
> typedef phys_addr_t resource_size_t;
> 
> /* include/linux/ioport.h */
> 
> struct resource {
> 	resource_size_t start;
> 	resource_size_t end;
> };
> 
> I think we should ignore this report.

Maybe try casting res->end to (u64) and see if it shuts the warning up?

DJ

> 
> Fabio
>>
>> vim +70 drivers/cxl/core/platform_quirks.c
>>
>>     50	
>>     51	/**
>>     52	 * platform_region_matches_cxld() - Platform quirk to match a CXL Region and a
>>     53	 * Switch or Endpoint Decoder. It allows matching on platforms with LMH's.
>>     54	 * @p: Region Params against which @cxled is matched.
>>     55	 * @cxld: Switch or Endpoint Decoder to be tested for matching @p.
>>     56	 *
>>     57	 * Similar to platform_cxlrd_matches_cxled(), it matches regions and
>>     58	 * decoders on platforms with LMH's.
>>     59	 *
>>     60	 * Return: true if a Decoder matches a Region, else false.
>>     61	 */
>>     62	bool platform_region_matches_cxld(const struct cxl_region_params *p,
>>     63					  const struct cxl_decoder *cxld)
>>     64	{
>>     65		const struct range *r = &cxld->hpa_range;
>>     66		const struct resource *res = p->res;
>>     67		int align = cxld->interleave_ways * SZ_256M;
>>     68	
>>     69		if (res->start == LMH_CFMWS_RANGE_START && res->start == r->start &&
>>   > 70		    res->end < r->end && res->end < (LMH_CFMWS_RANGE_START + SZ_4G) &&
>>     71		    IS_ALIGNED(range_len(r), align))
>>     72			return true;
>>     73	
>>     74		return false;
>>     75	}
>>     76	
>>
>> -- 
>> 0-DAY CI Kernel Test Service
>> https://github.com/intel/lkp-tests/wiki
>>
>>
> 
> 
> 
> 

