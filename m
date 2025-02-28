Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2820923F386
	for <linux-cxl@vger.kernel.org>; Fri, 28 Feb 2025 20:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740774811; cv=none; b=W6LyAgjyECXFAexC6Vmo4jK5PKKELXjVB4nBuB4H5qxzQ2SHp//AYxs8gKLm9WMizKOEW8skOz+JneeDjn2VmGS8sZWJK86EMc4kWpurzRK5xYt1987IqKa3UC1aY6H8miagvJSJhtrJvL3P1S8B54/yX0dvyM6wtr9j6+uJcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740774811; c=relaxed/simple;
	bh=Ay1IkLvH3rmiLFS0oKgNmKfnCvJjypOF3asP/umtttM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ekh33smdOs0ut0ygXZxxLRDR1JDcPbzSzNMqvJkXTtu2R/3AQ3fwhFvLAzUpIlQ85HALwkrrVBiomNU9/SlJVQSqqkKBy7trEftTfddjHW3Vt8b27ysr3ZorLB/gT3b/2vk9XjIASwZDjDWgx2I+1Znew6G+DSS6Syf3+DYRbq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WTWXuTt6; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WTWXuTt6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740774810; x=1772310810;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ay1IkLvH3rmiLFS0oKgNmKfnCvJjypOF3asP/umtttM=;
  b=WTWXuTt6AvCg5XbkNqtW0l3pvhyYpSVGHA75QwBzCtR8rhTy7/JZD0sG
   tYvO+ykMVQyfq3FYZYeC3fUhES5/63JGnSegqA5MnNAR70Jbb/eSPiUdV
   sNMGn0otg6YKIe1+J5ff/gX5MQ7NHboJSQLUZ/XnP4Qqk1HxK7iGt8+uB
   UBjLiD87HmkBxhkyPYrGcQvPgob3ToSv1UQ/7ji8afcI4xVT1QKZHIH/c
   Y+muTxMv5HoqmKGdoXGcOcNddp48cOEzOoaH8gzOIWQGjJ19QVT6NrBP7
   DoqcRlAqJiE95tOO9yEOvXWdVukqkNF5K5f0It3YueHcTMBlejGZT4z+f
   A==;
X-CSE-ConnectionGUID: MbAuFz7ES1e8EK/+MSuSpQ==
X-CSE-MsgGUID: wRoLBUJNRu+EIWQaiHb+tg==
X-IronPort-AV: E=McAfee;i="6700,10204,11359"; a="45500485"
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="45500485"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:33:29 -0800
X-CSE-ConnectionGUID: m8ZgjBmrS1ass8JLaaIlBQ==
X-CSE-MsgGUID: CdYC8zDhS86DQuHuazirzA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,323,1732608000"; 
   d="scan'208";a="117423967"
Received: from ldmartin-desk2.corp.intel.com (HELO [10.125.108.153]) ([10.125.108.153])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2025 12:33:28 -0800
Message-ID: <24aedde1-a21d-4581-98c9-2ac53fdb9384@intel.com>
Date: Fri, 28 Feb 2025 13:33:27 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix warning from emitting resoruce_size_t as long
 long int on 32bit systems
To: Alison Schofield <alison.schofield@intel.com>
Cc: linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>
References: <20250228194402.3745766-1-dave.jiang@intel.com>
 <Z8IdC2dbdWcqlg4O@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z8IdC2dbdWcqlg4O@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/28/25 1:31 PM, Alison Schofield wrote:
> On Fri, Feb 28, 2025 at 12:44:02PM -0700, Dave Jiang wrote:
>> Reported by kernel test bot from an ARM build:
>> drivers/cxl/core/region.c:3263:26: warning: format '%lld' expects argument of type 'long long int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
>>
>> On a 32bit system, resoruce_size_t is defined as 32bit long vs on a 64bit
> 
> 'resource' here and in commit msg.
> 
>> system it is defined as 64bit long. Define the variables as u64 instead to
>> make the size same across all archs.
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Closes: https://lore.kernel.org/oe-kbuild-all/202503010252.mIDhZ5kY-lkp@intel.com/
>> Fixes: 0ec9849b6333 ("acpi/hmat / cxl: Add extended linear cache support for CXL")
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> ---
>>  drivers/cxl/core/region.c | 5 +++--
>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index a83301f24fa2..958c15842b1e 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -3235,14 +3235,15 @@ static int cxl_extended_linear_cache_resize(struct cxl_region *cxlr,
>>  	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
>>  	struct cxl_region_params *p = &cxlr->params;
>>  	int nid = phys_to_target_node(res->start);
>> -	resource_size_t size, cache_size, start;
>> +	u64 size, cache_size, start;
>>  	int rc;
>>  
>>  	size = resource_size(res);
>>  	if (!size)
>>  		return -EINVAL;
>>  
>> -	rc = cxl_acpi_get_extended_linear_cache_size(res, nid, &cache_size);
>> +	rc = cxl_acpi_get_extended_linear_cache_size(res, nid,
>> +						     (resource_size_t *)&cache_size);
>>  	if (rc)
>>  		return rc;
> 
> Ah...I was thinking this fixup would be either a %pa format or (u64)cast on
> cache_size in the dev_warns, but this works too.
> 
> Do we also need to do this to avoid a complaint assigning to cxl_region_params:
> -       p->cache_size = cache_size;
> +       p->cache_size = (resource_size_t)cache_size;

Sure I can add that.

> 
> 
>>  
>> -- 
>> 2.48.1
>>
>>

