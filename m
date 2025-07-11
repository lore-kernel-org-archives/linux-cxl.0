Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB3780B;
	Fri, 11 Jul 2025 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752253063; cv=none; b=M9Vm1RXzl0XWsG7M/EqBH7iO6Qy/aLQqBrWL2NWPs/S7l2Uxil9oGjahKw8Wk+Ki7b0DX4GEJpuPfHYwXIUUG5f21riXlFxooxrTi8prouAvbh0qVyARn1JVjtHH5HTTXuu7CbNkLsEsSGmIB5IpjYiF4nPjfp/fPL6fzaeVlbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752253063; c=relaxed/simple;
	bh=oo/M3QHRjzFLrs7NsW4bHVeUgwGKrq+xYEyNUQ+3qek=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KWkbUMgXOo7RcYxcyDX+VTKlSdMQ3dln7/3VxKcuor1CDnp4/YbcbSgvd8y+9YCmsAyzUJ2f6hf9Q9CHQbEVCKYaT3SCx0bsMs3OW9FSgvy8IYT3GZdS1ASCOh767auaTXzGt0v4rArd8kQvGela/Of55zdpZKOXfgBMHvyBNdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UOkvV9jk; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UOkvV9jk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752253062; x=1783789062;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oo/M3QHRjzFLrs7NsW4bHVeUgwGKrq+xYEyNUQ+3qek=;
  b=UOkvV9jkMdFgoVzCnkKV0Is0dxXTYRjb/XBX2YoOgoO+XZYl4R4elUKK
   dP0PcRT0MJz2n7HafwzeYSapfaWEr6lSzMP2Rq/buH/9DD8BO0dQ26VEq
   mL1MKU+Ztyw8E4qVNjTOnt1p/wY32/m6+RFDzeGQIuedbaAweiRDde9Fl
   14U9vwjq1JuQvHTwn/2S77ecGsUAHps93KNwA3HrB0Yf+67vZoWtrcUj1
   M+w7oRodTq5DZjiytFzWrxjOcXYMhd9ycUNoAR0PK/vS34OIFK+L+2hfz
   +Y1RVAS2TprTmsinq+Cc74g5wXBP8J5SKE/FpaBPhJ3QhHD4SCEosYf5G
   Q==;
X-CSE-ConnectionGUID: 96Bvk9bWQrqrnmtHnoJU2w==
X-CSE-MsgGUID: wLfZIzbcRAu76M5bVRVRug==
X-IronPort-AV: E=McAfee;i="6800,10657,11491"; a="65620273"
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="65620273"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:57:41 -0700
X-CSE-ConnectionGUID: bY6+wjn6RD+LsQF80L5fNQ==
X-CSE-MsgGUID: D7sA57oRRQm5OarrscJTRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,304,1744095600"; 
   d="scan'208";a="157131239"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.35]) ([10.125.111.35])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jul 2025 09:57:39 -0700
Message-ID: <221d5666-a860-40c0-8cab-9c8086c1a597@intel.com>
Date: Fri, 11 Jul 2025 09:57:38 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/3] Fix wrong dpa checking in PPR operation
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 shiju.jose@huawei.com
Cc: andriy.shevchenko@linux.intel.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250711032357.127355-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250711032357.127355-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/10/25 8:23 PM, Li Ming wrote:
> In cxl_do_ppr(), there is a checking to check if a DPA is valid, the
> implementation of the checking is check if the DPA is 0, if yes,
> consider that DPA is valid. the checking is not right, the correct
> implementation is checking if the DPA is in the CXL device DPA range, if
> yes, it is valid.
> 
> The patchset also includes another part implementing a general helper
> function cxl_resource_contains_addr() in cxl core so that cxl drivers
> can use it for all DPA/HPA/SPA availability checking.

applied to cxl/next
bdf2d9fd3a86 cxl/core: Using cxl_resource_contains_addr() to check address availability
03ff65c02559 cxl/edac: Fix wrong dpa checking for PPR operation
5b6031c832c2 cxl/core: Introduce a new helper cxl_resource_contains_addr()

> 
> v6:
> - Fix reviewed-by tag mistake.
> 
> v5:
> - Reverse checkings order in cxl_do_ppr(). (Alison)
> 
> v4:
> - Add cxl_ prefix to resource_contains_addr().	(Andy & Alison)
> - Add impact statement to the commit log of Patch #2. (Alison)
> - Add review tags.
> 
> v3:
> - Move resource_contains_addr() from include/linux/ioport.h to
> cxl/core/hdm.c. (Andy)
> 
> v2:
> - Implement a general helper resource_contains_addr() for DPA/HPA
> resource. (Alison)
> 
> base-commit: d0b3b7b22dfa1f4b515fd3a295b3fd958f9e81af cxl/fixes
> 
> Li Ming (3):
>   cxl/core: Introduce a new helper cxl_resource_contains_addr()
>   cxl/edac: Fix wrong dpa checking for PPR operation
>   cxl/core: Using cxl_resource_contains_addr() to check address
>     availability
> 
>  drivers/cxl/core/core.h   | 1 +
>  drivers/cxl/core/edac.c   | 9 ++++++---
>  drivers/cxl/core/hdm.c    | 7 +++++++
>  drivers/cxl/core/memdev.c | 2 +-
>  drivers/cxl/core/region.c | 6 +++---
>  5 files changed, 18 insertions(+), 7 deletions(-)
> 

