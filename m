Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B583330D5D;
	Fri, 14 Nov 2025 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763133708; cv=none; b=pxtwIqO31ubagV3xoWu1BoD9NrfcSOU/91WJ1WUY+wOoLp+McPQL7er9xPoieMRWYH7nIw/0A+sLJfXe3iTj3/6wfJw5oEqiqPSXfvpfKyYu0fup4mVxolPvxR0pTKqYfsd1sPyEONQtoSliQ1RFVe4AqrX5QuMWJ+wkLLRQCZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763133708; c=relaxed/simple;
	bh=Tr9BxVjgFEJZ83aXHYKUo2kJADqcemsuI7gnR9GKR1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OwRl4uAqgFt7RRYSoiwkkgPY8j1U/vSGl/uI4QkruihLzqHpvqEL/H+A5czyom2Qg5+nOIgLpkhyEhC1ZKpgve0/RSRqjfD2QFgUUoIY9tiOrqscfbkMXIWQNaXYFftKIcEJiBPpAtAfbQBjjjbZ48kbLXvUYEX1oVAjEyFPor0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MY9eO7Y7; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MY9eO7Y7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763133708; x=1794669708;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Tr9BxVjgFEJZ83aXHYKUo2kJADqcemsuI7gnR9GKR1g=;
  b=MY9eO7Y7JjYqcoj0JslKGLmysZngso5i38WlT30EMzoNK/DYyc4XpD/B
   u8f/v50rSvtBSVJ0u/phdUNo/pnEp0bw+odjpjKzs19lgGGqUN7M6surb
   zZWIToXRZKyuOUWZUYpihrxIQylqZLxmLlmPu2detW9lqnSfr+K3HGsWQ
   erIj/XdIwpYM+G+pOcNd4GEaeZtkKMpGW31DwQfKItGqgN1l/6frhGW9E
   pZ1JDNuAZA0dbcwuSBSOU8u/oE4Andlm88HG5RyBID7FZAaJJtPv3AMSD
   WhE07h6XGHPrWWz+rHs+G8uoIcSEUQgvTMUM7sMNG14gC5wza1AXq6dd7
   Q==;
X-CSE-ConnectionGUID: HGEKlDbhS4aV/ACtZBhz/w==
X-CSE-MsgGUID: jg+FEPsNSP6ExONMOYWczg==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="65160824"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="65160824"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:21:47 -0800
X-CSE-ConnectionGUID: CA/oUoEgS7W+RgyIlrfJ9Q==
X-CSE-MsgGUID: 9dDhs43hTZi2KwGH9WMR6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,305,1754982000"; 
   d="scan'208";a="190051571"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.108.188]) ([10.125.108.188])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Nov 2025 07:21:45 -0800
Message-ID: <ac8dae0d-251e-405a-be24-c553fcedf05f@intel.com>
Date: Fri, 14 Nov 2025 08:21:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 11/14] cxl/atl: Lock decoders that need address
 translation
To: Robert Richter <rrichter@amd.com>
Cc: Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-12-rrichter@amd.com>
 <ae28560c-ed16-400b-bf3d-86e2cc8617cf@intel.com>
 <aRMx-YYhaouP4LvR@rric.localdomain>
 <6f1eaf10-071c-41ad-bda3-62eb6b1119e9@intel.com>
 <aRY6EaTALW4SvkaW@rric.localdomain>
 <7eea091e-f241-4305-a233-ba56a4ed5df3@intel.com>
 <aRbboCjBhCujhh67@rric.localdomain>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRbboCjBhCujhh67@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/14/25 12:34 AM, Robert Richter wrote:
> On Thu, Nov 13, 2025 at 01:36:26PM -0700, Dave Jiang wrote:
>>
>>
>> On 11/13/25 1:05 PM, Robert Richter wrote:
>>> On 12.11.25 09:34:34, Dave Jiang wrote:
>>>>
>>>>
>>>> On 11/11/25 5:54 AM, Robert Richter wrote:
>>>>> On 04.11.25 10:13:34, Dave Jiang wrote:
>>>>>>
>>>>>>
>>>>>> On 11/3/25 11:47 AM, Robert Richter wrote:
>>>>>>> There is only support to translate addresses from an endpoint to its
>>>>>>> CXL host bridge, but not in the opposite direction from the bridge to
>>>>>>> the endpoint. Thus, the endpoint address range cannot be determined
>>>>>>> and setup manually for a given SPA range of a region. If the endpoint
>>>>>>> has address translation enabled, lock it to prevent the kernel from
>>>>>>> reconfiguring it.
>>>>>>>
>>>>>>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>>>>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>>>>>> ---
>>>>>>>  drivers/cxl/core/atl.c | 10 ++++++++++
>>>>>>>  1 file changed, 10 insertions(+)
>>>>>>>
>>>>>>> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
>>>>>>> index d6aa7e6d0ac5..5c15e4d12193 100644
>>>>>>> --- a/drivers/cxl/core/atl.c
>>>>>>> +++ b/drivers/cxl/core/atl.c
>>>>>>> @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
>>>>>>>  		return -ENXIO;
>>>>>>>  	}
>>>>>>>  
>>>>>>> +	/*
>>>>>>> +	 * There is only support to translate from the endpoint to its
>>>>>>> +	 * parent port, but not in the opposite direction from the
>>>>>>> +	 * parent to the endpoint. Thus, the endpoint address range
>>>>>>> +	 * cannot be determined and setup manually. If the address range
>>>>>>> +	 * was translated and modified, forbid reprogramming of the
>>>>>>> +	 * decoders and lock them.
>>>>>>> +	 */
>>>>>>> +	cxld->flags |= CXL_DECODER_F_LOCK;
>>>>>>
>>>>>  
>>>>>> Feels like this should be something the BIOS should enforce if that
>>>>>> is the expectation? And the kernel checks and warns if that is not
>>>>>> the case.
>>>>>
>>>>> I think this is more a limitation of the kernel implementation rather
>>>>> than the BIOS. The BIOS provides enought information by CFMWS, PRM,
>>>>> HDM and PCI topology. In theory and if there is demand for it, support
>>>>> could be added for driver region setup.
>>>>
>>>
>>>> But shouldn't the BIOS set the decoder lock rather than the kernel
>>>> setting a software lock flag based on assumption of the PRM based
>>>> setup?
>>>
>>> If BIOS locks the decoders, it cannot be removed even for the case
>>> there the OS can actually handle it.
>>
> 
>> Oh so the current implementation is auto region by BIOS but in the
>> future it may not be? But if you add a lock flag, you wouldn't be
>> able to remove it later anyhow since it's presented as locked?
> 
> The BIOS provides all necessary data for address translation, so that
> decoders can be reconfigured (including normalized endpoint
> addresses). There is no reason to lock the decoders by the BIOS, as
> otherwise, with a capable kernel (or other OS), it would not be
> possible to shutdown auto-generated regions.
> 
> However, current kernel implementation does not support this and is
> unable to create the region. That is why the kernel and not the BIOS
> should lock the decoders.

Ok I see what you are saying. Fair enough. As long as we have a comment that makes note of this detail.

> 
> -Robert

