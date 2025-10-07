Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D77B19EEC2;
	Tue,  7 Oct 2025 20:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759868715; cv=none; b=kKXGngWxGS2dH+yymSkDi6CUK5fq8sYnRneoIgVYmOBlp6hoAgUqFLybO26wzCmvtgM9gRFyDiqLSfh+1fnIjEqbUuWI246BAcr22TsMtkTo4uDFEaFIrXOSfnP/Paa3GZAoHhz0LT0m1y6i67rfhGvLVMA2Y1twdxOoOVkKx0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759868715; c=relaxed/simple;
	bh=esu6vwwSfDhTx89e5Xav97zZd7CnHA4/fBhMBiXUEHc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjWdhxvyS+LU6BV3ldP7UCBk42IaG+FiKAEmf50bnV8nQcrh3XEdLLg+EbYOIgZQxHyVzZLiNEq4AdVNAMAncpcybK5yfru1mPrKmVrIb8ky2P66DhRoWmYdPXxzp1iKcVRk9YboeGhDv6KgREFlGArd4U3ars+wguVUCdo6cX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N+oKMJ2k; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N+oKMJ2k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1759868714; x=1791404714;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=esu6vwwSfDhTx89e5Xav97zZd7CnHA4/fBhMBiXUEHc=;
  b=N+oKMJ2konUVIPkRueayvYSKdsUsyE8VLA7seV87oXv7dzRRrO9jfBw9
   g+khFw1sGFRztv3z6W8f25hImXJe2C1EqkfWbOY+NDCIhoWXK0JcI9JgM
   nS/jc/VGu6LRELS9xzddsy7ZCcZDSyJhbF0Mo+7C6m01S9LTBUEPIKumU
   2gyqOt4bGHfEQPIuqF4lHZLNdTOIJArSyQNgFSYri+krS5JHnNZJ7Cl8m
   lsJx/aWOy6lAir4rMOvl2Das6uOvme6hZL6ygJb+944czuu4zf5AzhG27
   rHIc4HZvlPgNPB5kdNhgqva+rb4H6OG46W0TqnXWPO77ZbbKdldDgaSIo
   g==;
X-CSE-ConnectionGUID: Zbr3wNseRSSXMWwSWTnzWA==
X-CSE-MsgGUID: Nc6qfiFBRZeI14ZH8u9OAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11575"; a="62158457"
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="62158457"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:25:13 -0700
X-CSE-ConnectionGUID: 0VLIA3cXS2yjlF7McAzNEw==
X-CSE-MsgGUID: bI5JO7moRxSnSQbK2C65+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,321,1751266800"; 
   d="scan'208";a="217342372"
Received: from gabaabhi-mobl2.amr.corp.intel.com (HELO [10.125.110.156]) ([10.125.110.156])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Oct 2025 13:25:13 -0700
Message-ID: <ed390a72-2470-4e09-8fbe-56915d619dfa@intel.com>
Date: Tue, 7 Oct 2025 13:25:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4 v5] cxl/core: Enable Region creation on x86 with LMH
To: Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Robert Richter <rrichter@amd.com>,
 Cheatham Benjamin <benjamin.cheatham@amd.com>
References: <20251006155836.791418-1-fabio.m.de.francesco@linux.intel.com>
 <20251006155836.791418-4-fabio.m.de.francesco@linux.intel.com>
 <aOQAb9H-wIxc6j31@gourry-fedora-PF4VCD3F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aOQAb9H-wIxc6j31@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/6/25 10:46 AM, Gregory Price wrote:
> On Mon, Oct 06, 2025 at 05:58:06PM +0200, Fabio M. De Francesco wrote:
>> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more
>> Host Physical Address (HPA) windows that are associated with each CXL
>> Host Bridge. Each window represents a contiguous HPA that may be
>> interleaved with one or more targets (CXL v3.2 - 9.18.1.3).
>>
> ...
>>
>> Cc: Alison Schofield <alison.schofield@intel.com>
>> Cc: Dan Williams <dan.j.williams@intel.com>
>> Cc: Dave Jiang <dave.jiang@intel.com>
>> Cc: Ira Weiny <ira.weiny@intel.com>
>> Signed-off-by: Fabio M. De Francesco <fabio.m.de.francesco@linux.intel.com>
> 
> Couple inlines but just nits
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> 
>> @@ -1770,6 +1778,7 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>>  {
>>  	const struct cxl_endpoint_decoder *cxled = data;
>>  	struct cxl_switch_decoder *cxlsd;
>> +	struct cxl_root_decoder *cxlrd;
>>  	const struct range *r1, *r2;
>>  
>>  	if (!is_switch_decoder(dev))
>> @@ -1779,8 +1788,13 @@ static int match_cxlsd_to_cxled_by_range(struct device *dev, const void *data)
>>  	r1 = &cxlsd->cxld.hpa_range;
>>  	r2 = &cxled->cxld.hpa_range;
>>  
>> -	if (is_root_decoder(dev))
>> -		return range_contains(r1, r2);
>> +	if (is_root_decoder(dev)) {
>> +		if (range_contains(r1, r2))
>> +			return 1;
>> +		cxlrd = to_cxl_root_decoder(dev);
>> +		if (platform_cxlrd_matches_cxled(cxlrd, cxled))
>> +			return 1;
>> +	}
> 
> Is there any concern for longer term maintainability if addition
> match_*() functions are added?  Or is this upkeep just the unfortunate
> maintenance cost of supportering the quirk?

Suggestions welcome. Would be nice if we have cleaner ways of dealing with this.

> 
>>  
>>  static struct cxl_decoder *
>> @@ -3406,8 +3421,12 @@ static int match_region_to_cxled_by_range(struct device *dev, const void *data)
>>  	p = &cxlr->params;
>>  
>>  	guard(rwsem_read)(&cxl_rwsem.region);
>> -	if (p->res && p->res->start == r->start && p->res->end == r->end)
>> -		return 1;
>> +	if (p->res) {
>> +		if (p->res->start == r->start && p->res->end == r->end)
>> +			return 1;
>> +		if (platform_region_matches_cxld(p, &cxled->cxld))
>> +			return 1;
>> +	}
> 
> 
> if (!p->res)
> 	return 0;
> if (p->res->start == r->start && p->res->end == r->end)
> 	return 1;
> if (platform_region_matches_cxld(p, &cxled->cxld))
> 	return 1;
> return 0;
> 
> ?
> 
> I like flat, but I also dislike not-logic.  Style choice here, unless
> others have a strong feeling this is fine.

More flat is definitely the preferred way. With the changes, the last one we can actually do:

return platform_region_matches_cxld(p, &cxled->cxld));


> 
> ~Gregory

