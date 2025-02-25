Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 059B0156960
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740498118; cv=none; b=h6XkS9BaUttvihOEIDMq+VpBeS6tfSVHDBnjXrM1ME2X+4mv80nmlvFy7SH6GAAPHzE0DElrjn2M5PP4z/pIMmljrC377OD2Invgv8BRpmHDUylu9RZ04gS1IvDpkSy/SuEJgGZ45x1voqwh2Io9VJcHE38yXpHMgtl7UuxNZg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740498118; c=relaxed/simple;
	bh=Oy5T1WomdJknb/G6FK/XgwG8gFLlpKt5VcZGwRq14VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LkdM2gsLNb4jbmyrwjT2XCB6PdN51Sii8fY7Zayga/3MyhWZuQXOfmuDp9lv6DSvgPpGLF6lO55zL6jUJ1VD33/5l8uI3Kw+nh7j97PdrKBYFl59XEqpWedtMO/4dM8y4H0bKS6JSFYx+FOwJlGqSjO9s/ZrfcLMSR0YlGUMi6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pkfj0KzW; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pkfj0KzW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740498117; x=1772034117;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Oy5T1WomdJknb/G6FK/XgwG8gFLlpKt5VcZGwRq14VE=;
  b=Pkfj0KzWIp4VMQaIbS/5RtM//K6S10NI6/Ftr4C0zeZsEEXaNpXF4NhQ
   SjjxDn4vFuuk8wH+KcpenAe8x0Nseufejc/GUeQFn2IkYnn1C120R3Zuk
   IKybjNAHLih+HyAg7EvjKAKU55TUqkfoWBvYTVKWCFL0r854Unh31b34T
   gIAve0Kiwy/L7qzefvpo4WbvQ6aWA7hGspp1bFqDijriWPUgE1dTkElt0
   A4KU2DCDj4B7A+VWUedefGuBm32zEbpD4oeVxbKQpQ3JaWD67R2gTpiWc
   rL4FnlOXUyFSbiIYzLMuD9VkSLdgK5fJYz6FGY2IRAgGTjdQkFKK8G/uZ
   g==;
X-CSE-ConnectionGUID: oy7NnhjDRL6fWwjS2REFHQ==
X-CSE-MsgGUID: gPq1xq57Tge47dURW4YQPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11356"; a="51523731"
X-IronPort-AV: E=Sophos;i="6.13,314,1732608000"; 
   d="scan'208";a="51523731"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:41:56 -0800
X-CSE-ConnectionGUID: O4gljl6mToeVOfF3dzkfQg==
X-CSE-MsgGUID: /rXfqrTNQ0CKDmlOvJyxUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="116270529"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.111.168]) ([10.125.111.168])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 07:41:56 -0800
Message-ID: <648bd488-a93f-4e6a-93cc-cc1841bebfc0@intel.com>
Date: Tue, 25 Feb 2025 08:41:54 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Allow 6 & 12 way regions on 3-way HB
 interleaves
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <20250224235817.2259508-1-alison.schofield@intel.com>
 <010e16c3-0f90-41b0-8939-4cc8cb26de7a@intel.com>
 <Z70qiCzzusQ6XXhd@aschofie-mobl2.lan>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z70qiCzzusQ6XXhd@aschofie-mobl2.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/25 7:27 PM, Alison Schofield wrote:
> On Mon, Feb 24, 2025 at 05:41:20PM -0700, Dave Jiang wrote:
>>
>>
>> On 2/24/25 4:58 PM, alison.schofield@intel.com wrote:
>>> From: Alison Schofield <alison.schofield@intel.com>
>>>
>>> The CXL driver requires the granularity of a region and it's root
>>
>> s/it's/its/
> 
> got it
> 
>>
>>> decoder to be the same. This is particularly restrictive for 3-way
>>> host bridge interleaves where the only spec defined interleave
>>> configurations for creating 6-way and 12-way regions on a 3-way HB
>> configuration?
>>> interleave require mixed granularities.
>> requries?
> 
> considering that 
> 
>>
>>>
>>> CXL 3.1 Specification 9.13.1.1:
>>
>> May as well go to 3.2
>>
> 
> got it
> 
> 
>>> Legal Interleaving Configurations: 12-way, 6-way, and 3-way
>>>
>>> Adding support for these new interleaves touches these areas:
>>>
>>> 1) User created regions employing "cxl create-region" fail when the
>>> ndctl tool gets a mixed granularity request. That is addressed in
>> s/ndctl/CXL CLI/
>>
> 
> got it
> 
> 
>>> a patch to the ndctl tool.
>>>
> 
> snip
> 
>>>  
>>> +static bool interleave_granularity_allow(struct cxl_decoder *cxld, u16 ig)
>>> +{
>>> +	/*
>>> +	 * When the host-bridge is interleaved, disallow region granularity
>>> +	 * != root granularity with the exception of 3-way HB interleaves.
>>> +	 * Allow the CXL Spec defined 3-way HB interleaves that can only be
>>> +	 * configured when host-bridge interleave is greater that the
>>> +	 * region interleave. (CXL 3.1 Specification 9.13.1.1)
>> spec 3.2
>>
>>> +	 * Allow 2+2+2 interleave where HB gran is 2 * region granularity
>>> +	 *	 4+4+4 interleave where HB gran is 4 * region granularity
>>> +	 *
>>> +	 * Regions with a granularity greater than the root interleave result
>>> +	 * in invalid DPA translations (invalid to support).
>>> +	 */
>>> +	if (cxld->interleave_ways > 1 && ig != cxld->interleave_granularity) {
>>> +		if (cxld->interleave_ways != 3)
>>> +			return false;
>>> +
>>> +		if (cxld->interleave_granularity % (2 * ig) &&
>>> +		    cxld->interleave_granularity % (4 * ig))
>>> +			return false;
>>
>> Can you please explain how the math works here? I'm not understanding the code here vs the comments above.
> 
> I'm guessing you are talking about the last chunk only. We get there
> after discovering a 3-way HB interleave. (HB interleave and root decoder
> interleave are the same thing.) Once we know it's a 3-way, there are
> only 2 possible values and those are defined in the spec as:
> 	2+2+2 interleave where HB gran is 2 * region granularity
> 	4+4+4 interleave where HB gran is 4 * region granularity
> 
> And now that I've gotten to this part of the explanation I think
> the code is allowing multiples of 2*ig and 4*ig, when it should
> be a stricter check for exactly 2*ig or 4*ig.
> 
> updating that to:
> 	if (cxld->interleave_granularity != 2 * ig &&
> 	    cxld->interleave_granularity != 4 * ig)
> 		return false;
> 

Ok the new code make sense to me now. :) 

> Thanks for that Dave!
>>
>> DJ
>>
> 
> snip

