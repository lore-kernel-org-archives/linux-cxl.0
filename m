Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49F71F4176;
	Wed, 12 Nov 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762964638; cv=none; b=OCtiRrykHUyTRia/9pexyzddkRDYd1J/rGkNCNLv9u3evZAPHZfocb7H+OLvTjI3zdoy8vTgLo1ciz7gTiykU+qe4KWFUGTDQo10Vh7hlL/W3xsNrypAFOjciwDntbDuS8Vm4aQSrk538O5T1XMx8TKWyED11WwgI3mB7ZXC1C0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762964638; c=relaxed/simple;
	bh=85iOPPCnPTcylTWGYbyHyZLBg6P3sq4n5iKzl/1KuRY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rtVtzvKp5g5sGyXxAxo0lCmUpzMl2EjM2jQrJv9CKiHbVc/IwDBrmGGu5GvE5tYEESJqkMz6p6tlTeohw1pgeiwNjWxyXvOAOOIrck+VbniqHFpnTm8cqdvpiRn2FKOww4zoWb4QeSPBCugwS34CiD0aLt/QFOREy/AYmsilRQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z5urpiHk; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z5urpiHk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762964637; x=1794500637;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=85iOPPCnPTcylTWGYbyHyZLBg6P3sq4n5iKzl/1KuRY=;
  b=Z5urpiHkztlHyPHs8Z7b3bDObhBrV7Y7xaarsKaoZ8kTMa4gUCVL/jTV
   yZ3BnNLXIFuy3C0C8Oc28rk0Zf45qKDhZJZILvcG53TlCjiX7xHGFKDE5
   EmHJGQczS2OSV7+38Cj5BBmMSLwwOhegkGx6dIKqbsNW4q6x460X5lmRs
   XjmqwvTeozJ+J8rjrhWnTmrIRsrPaNG5qqexrPkITOsb4dasOoloXOKLN
   L2Nz3yB5sFE/I6XP+2jXUu+uj6xEV518jiwmQamivjrGgBwJLQ2CS57rr
   30UYdgEuiSaECDwiLlx8rD4X6nO97+KzmpM4OupOF1oGB/cfpy7Iqf7bR
   Q==;
X-CSE-ConnectionGUID: 6vVWxrioSva/GRCkdb3BgA==
X-CSE-MsgGUID: wpYJIXDQSPS8u6uQ0kdqXw==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="75713345"
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="75713345"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:23:56 -0800
X-CSE-ConnectionGUID: 4LRDhCj/TKSWDdJePcx9ow==
X-CSE-MsgGUID: t8SFj0J3SgmXb8XzxAYDZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,299,1754982000"; 
   d="scan'208";a="189248987"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.30]) ([10.125.108.30])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 08:23:56 -0800
Message-ID: <4270add5-8ef1-4400-b884-c47b8af98b19@intel.com>
Date: Wed, 12 Nov 2025 09:23:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/14] cxl/region: Rename misleading variable name @hpa
 to @hpa_range
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, Davidlohr Bueso
 <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-4-rrichter@amd.com>
 <20251111144149.00007c63@huawei.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251111144149.00007c63@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/11/25 7:41 AM, Jonathan Cameron wrote:
> On Mon, 3 Nov 2025 19:47:44 +0100
> Robert Richter <rrichter@amd.com> wrote:
> 
>> @hpa is actually a @hpa_range, rename variables accordingly.
>>
>> Reviewed-by: Gregory Price <gourry@gourry.net>
>> Signed-off-by: Robert Richter <rrichter@amd.com>
> Passing comment below on readability (unrelated to the change you made)
> 
> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> 
> Dave, I wonder if it is reasonable to queue at least some of Robert's series
> like this one so that people can start basing on top of those and the
> merge conflicts will be less painful in the long run.

We can certainly do that, if the patches can be split out to a different series. Next week is the last week I'll take patches for this cycle.

DJ

> 
>> ---
>>  drivers/cxl/core/region.c | 30 ++++++++++++++++--------------
>>  1 file changed, 16 insertions(+), 14 deletions(-)
>>
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index a780e65532a7..bb889c891cf7 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
> 
>> @@ -3577,12 +3578,13 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>>  		return -ENXIO;
>>  
>>  	/*
>> -	 * Ensure that if multiple threads race to construct_region() for @hpa
>> -	 * one does the construction and the others add to that.
>> +	 * Ensure that if multiple threads race to construct_region()
>> +	 * for the HPA range one does the construction and the others
>> +	 * add to that.
> 
> Unrelated but a few commas would make this easier to read. Something like:
> 
> 	 * Ensure that, if multiple threads race to construct_region()
> 	 * for the HPA range, one does the construction and the others
> 	 * add to that.
> 
>>  	 */
>>  	mutex_lock(&cxlrd->range_lock);
>>  	struct cxl_region *cxlr __free(put_cxl_region) =
>> -		cxl_find_region_by_range(cxlrd, hpa);
>> +		cxl_find_region_by_range(cxlrd, hpa_range);
>>  	if (!cxlr)
>>  		cxlr = construct_region(cxlrd, cxled);
>>  	mutex_unlock(&cxlrd->range_lock);
> 

