Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522C1F7910;
	Mon, 15 Sep 2025 16:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757953456; cv=none; b=OPj5O/HRjyJN0Pt97MDRNBo6qUhuV5lLHaHH/QAhX+oEXkdnFc13OtBDvu2RandOLSlkfIlWWy4n341NxZCQVdl6ZqdOix0HPeNoFf/ypiNAaUiMNKuEnJ7Hx0MR6oNVuzGBk2OlIpUUcnksM3M4N8CpyKu9N3f5PZeWQsGaCx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757953456; c=relaxed/simple;
	bh=O5SwdmxxLNi13kb62q2OqCYx8wGzejzDqVMTzbO/oLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nByLGQIBzniHsU5uYLAGmmWlamKk8gZbRlj5b1w4PyZ66No2X0MOLUJO0TSF8jrLKjlrP4V0M4a31FT11YnfIv9BHzO2mfvUCRkcPSSIbVggy4z7sFKywcA/IvYVYhjEpqkmj3c2cmrpph4ySEdpS6vCXBOtJdMF3pqFXtnoRUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kmvAgdRD; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kmvAgdRD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757953455; x=1789489455;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=O5SwdmxxLNi13kb62q2OqCYx8wGzejzDqVMTzbO/oLM=;
  b=kmvAgdRD9Z86wa2auMf/NSqgPtnQtUGHnITPYhEbEMoZ6RdQf2duroXn
   9IWxzqsYYvVjGiYiIoJx7nSCGN1rBmWYXvE4D5H64gX/IZtk6k+iMCAZg
   vioxpKK2VUeH0HQ03P93q4gDhWh6NnKb3n/bs1TZ5Fgx5q1Ag5pKkLNtb
   9rCsdU22y1Bvon0rNH3tbdMD07BW4a981bfTRigVdDuhgEhF8AuZfOkKX
   PlChBqurG/SOM+xkwqr39gS51lwKxwU1nyGQCcr/yXb73AIMbxIdwakPP
   wBBDlleoSZG7gB/JpYg37fGxH+3yZtsqdVkTk88Kx+19nORJRUpdYXk0N
   Q==;
X-CSE-ConnectionGUID: WeQrXdrlSdO2PAAgccXhaw==
X-CSE-MsgGUID: uv/xGNjXTdaNyKlWQiPGKg==
X-IronPort-AV: E=McAfee;i="6800,10657,11554"; a="47782486"
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="47782486"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:24:14 -0700
X-CSE-ConnectionGUID: 5JB3YnFGS3i1pKU71CnCaw==
X-CSE-MsgGUID: e2KTI+UiQPe8ebRf8vvPPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,266,1751266800"; 
   d="scan'208";a="179053455"
Received: from cmdeoliv-mobl4.amr.corp.intel.com (HELO [10.125.111.129]) ([10.125.111.129])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2025 09:24:10 -0700
Message-ID: <090fd415-42e4-481f-8c77-0b3f2e9f3f63@intel.com>
Date: Mon, 15 Sep 2025 09:24:09 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/11] cxl/region: Store HPA range in struct cxl_region
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
 <20250912144514.526441-3-rrichter@amd.com>
 <fd4fc0f6-03a9-4134-9703-60705ec6898c@intel.com>
 <aMe96yaXueRvTARq@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aMe96yaXueRvTARq@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/15/25 12:19 AM, Robert Richter wrote:
> On 12.09.25 10:17:14, Dave Jiang wrote:
>>
>>
>> On 9/12/25 7:45 AM, Robert Richter wrote:
>>> Each region has a known host physical address (HPA) range it is
>>> assigned to. Endpoint decoders assigned to a region share the same HPA
>>> range. The region's address range is the system's physical address
>>> (SPA) range.
>>>
>>> Endpoint decoders in systems that need address translation use HPAs
>>> which are not SPAs. To make the SPA range accessible to the endpoint
>>> decoders, store and track the region's SPA range in struct cxl_region.
>>> Introduce the @hpa_range member to the struct. Now, the SPA range of
>>> an endpoint decoder can be determined based on its assigned region.
>>>
>>> Patch is a prerequisite to implement address translation which uses
>>> struct cxl_region to store all relevant region and interleaving
>>> parameters.
>>>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>
>> Just a nit below. Otherwise looks ok
>>
>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>
>>> ---
>>>  drivers/cxl/core/region.c | 17 +++++++++++++++++
>>>  drivers/cxl/cxl.h         |  2 ++
>>>  2 files changed, 19 insertions(+)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 2c37c060d983..777d04870180 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -664,6 +664,11 @@ static int alloc_hpa(struct cxl_region *cxlr, resource_size_t size)
>>>  		return PTR_ERR(res);
>>>  	}
>>>  
>>> +	cxlr->hpa_range = (struct range) {
>>> +		.start = res->start,
>>> +		.end = res->end,
>>> +	};
>>> +
>>>  	p->res = res;
>>>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>>>  
>>> @@ -700,8 +705,14 @@ static int free_hpa(struct cxl_region *cxlr)
>>>  	if (p->state >= CXL_CONFIG_ACTIVE)
>>>  		return -EBUSY;
>>>  
>>> +	cxlr->hpa_range = (struct range) {
>>> +		.start = 0,
>>> +		.end = -1,
>>> +	};
>>> +
>>>  	cxl_region_iomem_release(cxlr);
>>>  	p->state = CXL_CONFIG_IDLE;
>>> +
>>
>> stray blank line
>>>  	return 0;
>>>  }
> 
> This small cleanup was intended and separates the return from other
> statements to better group the code in (sort of) blocks. It is not
> worth separate patch and it is common practice to have small cleanups
> in the area of code that is changed. That allows small style fixes to
> the code while reworking it, but avoids separate code cleanups causing
> extra efforts, conflicts and the risk of changing stable code.
> 
> Anyway, let me know if you want me remove the change.

Yeah please just drop the change. While it's nice to have, it may potentially cause backport issues generally speaking. 

> 
> Thanks,
> 
> -Robert

