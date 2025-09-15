Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456524DCE9;
	Mon, 15 Sep 2025 16:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953621; cv=none; b=chMdG8Yc6tvvWTf3r1rp5727C1STHNjD/BerJ8qGHPiO2xOl4+l5IlzlMD0JkncfIR+WlldF7OId7GyphyxmzKcrB7XGwxO1M4MiHxnv+nXstneHyOMjuowJvCvsxRE9pfkGtlVTbdfLIAfz6ouQxDHFTEWtiQosrapc6qGdmac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953621; c=relaxed/simple;
	bh=JJjoz8iiqJhmNZfKOSMi6Un11Z5v49/PkAlyrOo9J5o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u79GdbuOqqnTc3yNSe2zmFPPH0kRMOEnN9tOItA9ao1qxuIHaTr4lzFhbzXx+gtdnMvlN9X5EHEq0jJW9/4IP6Mh56yJ+9oMmVzBrRWrAVEYcJX5YySTis1pFUlNpJSigCfbWAXpTP4PPh4nEWHap6f0FMWpLuq5Ebok+tRgo1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CSkOOOHi; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CSkOOOHi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757953620; x=1789489620;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JJjoz8iiqJhmNZfKOSMi6Un11Z5v49/PkAlyrOo9J5o=;
  b=CSkOOOHizgr/RW7nX/uAsBERIP2COB4DThvjs5RGKHRVesrjImw3D4zE
   1cKIBteliB4yF4iSYQcUaxwHWMknjXZKG4mMPCq8R305opiR9po4B2rH3
   IycTE92XxfGeGrZzyxmweISP1TKsgtR07ZS9mdYCWz3UupUgZpuEEFinu
   esgFXS1q6/3sYeANQK1WGk/JTroQED4O7xgfZhRJbxcSWOiJmhVSVog9f
   FOovVjpLgWtmqxSuhiS497iHlPXC91rrRf5//mjC+CAyuDdNwBp0fksNB
   2ozI8fQrhBr9bBiIl5bdzk3QReZnYezRMSW0aP7UK7QZwCSbyOfExkHXF
   A==;
X-CSE-ConnectionGUID: kM5X7HfBQHSR2IjxI1+3ZA==
X-CSE-MsgGUID: cJYqNygLTcqGsHKP5VocAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="60288376"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="60288376"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:26:56 -0700
X-CSE-ConnectionGUID: EhG1VS+xTLGNAkC8/sm9lA==
X-CSE-MsgGUID: pPBgcjI3SeWtt6gNtT3wiA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="205646801"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.129]) ([10.125.111.129])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:26:54 -0700
Message-ID: <45b9e636-d611-4e81-9f3d-ce23df2fac0d@intel.com>
Date: Mon, 15 Sep 2025 09:26:52 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 06/11] cxl/region: Separate region parameter setup and
 region construction
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20250912144514.526441-1-rrichter@amd.com>
 <20250912144514.526441-7-rrichter@amd.com>
 <3d44af04-f7d6-4625-b07d-40173bc95c35@intel.com>
 <aMfA1hlZWfNdnEy5@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aMfA1hlZWfNdnEy5@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/25 12:31 AM, Robert Richter wrote:
> On 12.09.25 14:10:06, Dave Jiang wrote:
>>
>>
>> On 9/12/25 7:45 AM, Robert Richter wrote:
>>> To construct a region, the region parameters such as address range and
>>> interleaving config need to be determined. This is done while
>>> constructing the region by inspecting the endpoint decoder
>>> configuration. The endpoint decoder is passed as a function argument.
>>>
>>> With address translation the endpoint decoder data is no longer
>>> sufficient to extract the region parameters as some of the information
>>> is obtained using other methods such as using firmware calls.
>>>
>>> In a first step, separate code to determine and setup the region
>>> parameters from the region construction. Temporarily store all the
>>> data to create the region in the new struct cxl_region_context. Add a
>>> new function setup_region_parameters() to fill that struct and later
>>> use it to construct the region. This simplifies the extension of the
>>> function to support other methods needed, esp. to support address
>>> translation.
>>>
>>> Patch is a prerequisite to implement address translation.
>>>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>> ---
>>>  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++++++++----------
>>>  1 file changed, 38 insertions(+), 12 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 106692f1e310..57697504410b 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -3414,6 +3414,26 @@ static int match_region_by_range(struct device *dev, const void *data)
>>>  	return 0;
>>>  }
>>>  
>>> +struct cxl_region_context {
>>> +	struct cxl_endpoint_decoder *cxled;
>>> +	struct cxl_memdev *cxlmd;
>>> +	struct range hpa_range;
>>> +	int interleave_ways;
>>> +	int interleave_granularity;
>>> +};
>>> +
>>> +static int setup_region_params(struct cxl_endpoint_decoder *cxled,
>>> +			       struct cxl_region_context *ctx)
>>> +{
>>> +	ctx->cxled = cxled;
>>> +	ctx->cxlmd = cxled_to_memdev(cxled);
>>> +	ctx->hpa_range = cxled->cxld.hpa_range;
>>> +	ctx->interleave_ways = cxled->cxld.interleave_ways;
>>> +	ctx->interleave_granularity = cxled->cxld.interleave_granularity;
>>
>> You can init like this:
>>
>> 	*ctx = (struct cxl_region_context) {
>> 		.cxled = cxled,
>> 		.cxlmd = cxled_to_memdev(cxled),
>> 		.hpa_range = cxled->cxld.hpa_range,
>> 		.interleave_ways = cxled->cxld.interleave_ways,
>> 		.interleave_granularity = cxled->cxld.interleave_granularity,
>> 	};
> 
> Will change that for readability and to zero-init possibly missing
> members.
> 
>>
>>
>>> +
>>> +	return 0;
>>
>> Can probably make this function void if no expected errors and only assignments.
> 
> A later extension to the code may return an error code, so I prepared
> the function interface already for this.

I realized that when I saw it in the later patch. So please ignore the comment.

> 
> -Robert
> 
>>
>> DJ

