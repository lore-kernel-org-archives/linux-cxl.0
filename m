Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A642EEA7
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jul 2026 22:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784759393; cv=none; b=I3hSFn+ElaXI0WCXTOCvDyn/OXenhDbVBL2r31YL8kGaJhqiWQKylijBN48haNPfkujzs9KiEJ3CGAVTrQsR08GHIHNyQqLUd1A3ixtnlMkwa2Rct3W1GVml3+h2qGPC4eUFZsvILINSJX1VMPEjFMb4wqLOuE0ivC8CmWoV3tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784759393; c=relaxed/simple;
	bh=eIEiHfsMC7DCrFKT8SAAzbol7fM9mtZtPPn4M/6NHog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iQhG576gAv0V65XHBFS5mq5i2HU54JfI+rS7LOp9DfE66HY9eWnlPxe8U6wqyQO6b4XpyaNOVr0UqOOHU4cCAN5DkXzvatgPUNYBSeXes1Y6IY7MdBZNdDfXA2obQwVkTlGDUPbU41/ZM452lJ7QmPAZLc0YSOx0qmRd+2KrAOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YJndtC0F; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YJndtC0F"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784759391; x=1816295391;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=eIEiHfsMC7DCrFKT8SAAzbol7fM9mtZtPPn4M/6NHog=;
  b=YJndtC0FKJ6jNwV+UZ0/5KQ1QtB6az1hl7d2kaxyKw4IUdP61ozKkkef
   ecW0dbe9awqtzZTvTzsRT6PL5sivR38HainGba7vA9fnlNDbfSOrUTWEy
   IDtfbEaqOvsLrnHW8fd1R/XB5egyGFtq0CCKLvJfon5yRkAgwmXWSq84L
   s1GU6wGuhqMNEddHNev39scN4vm2SpCEEcsvMIu2OehCP3Q77OzrcuGU2
   4CNxuewvHSMd0LYafB0Zs98l2LZ7bY8n4q1s74MkRUe+ONki7Gl0bceat
   oK1yZRVGU2GI1JEbBWs8zmO+vMwxCAZfbMdW5FrWVgc8ejv5RV0r8/He4
   g==;
X-CSE-ConnectionGUID: UO22xG5rQTm7yoDWrsM9pg==
X-CSE-MsgGUID: JqWNPh6BQyqiV1Y+P4syiA==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="89227922"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="89227922"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 15:29:51 -0700
X-CSE-ConnectionGUID: 8cz/rnxeSviGOxxl+f26oA==
X-CSE-MsgGUID: 5ZfvyUARTrik7K5a8y4/pg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; 
   d="scan'208";a="282737096"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.61]) ([10.125.110.61])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2026 15:29:50 -0700
Message-ID: <8af783cc-a012-4244-840f-269fd8b09984@intel.com>
Date: Wed, 22 Jul 2026 15:29:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] cxl/region: Guard against unset partition in
 poison_by_decoder()
To: sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260722205303.3184787-1-dave.jiang@intel.com>
 <20260722205303.3184787-2-dave.jiang@intel.com>
 <20260722211025.E33CE1F000E9@smtp.kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260722211025.E33CE1F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/26 2:10 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] The early return for decoders with `part < 0` skips the loop termination condition, causing iteration to silently continue past the last committed decoder.
> --
> 
> --- Patch [1]: [PATCH 1/3] cxl/region: Guard against unset partition in poison_by_decoder() ---
> commit 8424c8c335042ef0b39d03b8e79434f7d0ee9eba
> Author: Dave Jiang <dave.jiang@intel.com>
> 
> cxl/region: Guard against unset partition in poison_by_decoder()
> 
> This commit skips decoders with an unset partition (part < 0) in
> poison_by_decoder() to prevent an out-of-bounds access when querying
> partition modes.
> 
> Closes: https://sashiko.dev/#/patchset/20260708074228.43654-1-icheng@nvidia.com?part=4
> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 1e211542b6b64..ec0dc4284c3c5 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2959,6 +2959,9 @@ static int poison_by_decoder(struct device *dev, void *arg)
>>  	if (!cxled->dpa_res)
>>  		return rc;
>>  
>> +	if (cxled->part < 0)
>> +		return rc;
> 
> [Severity: Medium]
> Does this early return bypass the iteration termination logic if the
> commit_end decoder itself has an unset partition?
> 
> Looking at poison_by_decoder(), returning early here skips the termination
> check at the bottom of the function:
> 
> 	/* Iterate until commit_end is reached */
> 	if (cxled->cxld.id == ctx->port->commit_end) {
> 		ctx->offset = cxled->dpa_res->end + 1;
> 		ctx->part = cxled->part;
> 		return 1;
> 	}
> 
> This would cause device_for_each_child() to continue iterating into 
> uncommitted decoders instead of returning 1 and stopping. Because the 
> iteration would ultimately return 0 instead of 1, cxl_get_poison_by_endpoint() 
> would then fail to trigger the subsequent cxl_get_poison_unmapped() call.

False positive. The intent is to iterate through all the child devices to find the commit end. Having cxled->part < 0 does not mean it is the commit_end. Iterating through uncommitted decoders just return 0 and is harmless. And if there's none found, then it doesn't matter if cxl_get_poison_by_endpoint() needs to be triggered.

DJ
> 
>> +
>>  	cxlmd = cxled_to_memdev(cxled);
>>  	cxlds = cxlmd->cxlds;
>>  	mode = cxlds->part[cxled->part].mode;
> 

