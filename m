Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0916D2F99A5;
	Thu, 13 Nov 2025 20:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066193; cv=none; b=aH8V3keFWVSNaX8Tvr/5tsjBQkGYu+heezdGAkkWLwevzHahjhFlvdxXeYhC0uUwthCEcwBFFKKX8MRSGkX4OqC/ajgAYd3nYXXfrXj/5EsBXi8OjffyZ4uN0qGS75DyAeir3EbQxzCP/rNQxczksTPk2dXA5pxbJnFMzzbJl9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066193; c=relaxed/simple;
	bh=r2od/2ACer4ZUP0BL+s+JsyPJ2XSXc3nRjQ/B11YoIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kcQynp7+zYxABd4lPFElUkDb8Y45W2SmMYyUO/3ipD5hK/a2kFM7w/0sB5zNNna1oQNaL4CKk53zFL0pCLgqvD5xWYcPJujDKmzTlTgspsZrN/hZEuXqfI3bUTaOAhM07bb28SWyGnqj3XqSERr4Gk6rbW/siTm9Y+1iIBP3Pmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XrSMP0Pr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XrSMP0Pr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763066191; x=1794602191;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=r2od/2ACer4ZUP0BL+s+JsyPJ2XSXc3nRjQ/B11YoIY=;
  b=XrSMP0PrBHbA+eW1JOCiNjjv8IALAZ0dcPARQ8Hvnvac/62mmQ+Ya11X
   CH/qu4qIfUrpMrEIcyiaIg7bVuufiBHh5+qZn2VWhGxQB9O0mGBnEaDVR
   dfhH03Qu5HzoEanyQl9yw9AZzkdLHoks0/6z3SWngqxDjzMayXVWres6S
   bJnSzJaiwOmUGeVogzki60d/beG9x03OeosD8nMzRTXX8WGA85iep1XCA
   XatmNDemXwYzO35biD9Eg+nNW0tiLdV6tsVcvTH9z1v+KLCZLarUlxAK9
   CZLH/moSc2l5kCFfY95tOTChWKwJ8hDQoYViztnos1kjPKrs0M9aG2H98
   A==;
X-CSE-ConnectionGUID: 3R4i5AQ0TAmc72FftIvQ5A==
X-CSE-MsgGUID: Clm4Y3MATb+AVKWNQe0BCg==
X-IronPort-AV: E=McAfee;i="6800,10657,11612"; a="64164337"
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="64164337"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 12:36:30 -0800
X-CSE-ConnectionGUID: HchIK+okSQ6Lkf1QGvhQkQ==
X-CSE-MsgGUID: t/o2q0NzSM+ju2phg+bgbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,302,1754982000"; 
   d="scan'208";a="194041193"
Received: from tslove-mobl4.amr.corp.intel.com (HELO [10.125.108.114]) ([10.125.108.114])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2025 12:36:29 -0800
Message-ID: <7eea091e-f241-4305-a233-ba56a4ed5df3@intel.com>
Date: Thu, 13 Nov 2025 13:36:26 -0700
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
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aRY6EaTALW4SvkaW@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/13/25 1:05 PM, Robert Richter wrote:
> On 12.11.25 09:34:34, Dave Jiang wrote:
>>
>>
>> On 11/11/25 5:54 AM, Robert Richter wrote:
>>> On 04.11.25 10:13:34, Dave Jiang wrote:
>>>>
>>>>
>>>> On 11/3/25 11:47 AM, Robert Richter wrote:
>>>>> There is only support to translate addresses from an endpoint to its
>>>>> CXL host bridge, but not in the opposite direction from the bridge to
>>>>> the endpoint. Thus, the endpoint address range cannot be determined
>>>>> and setup manually for a given SPA range of a region. If the endpoint
>>>>> has address translation enabled, lock it to prevent the kernel from
>>>>> reconfiguring it.
>>>>>
>>>>> Reviewed-by: Gregory Price <gourry@gourry.net>
>>>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>>>> ---
>>>>>  drivers/cxl/core/atl.c | 10 ++++++++++
>>>>>  1 file changed, 10 insertions(+)
>>>>>
>>>>> diff --git a/drivers/cxl/core/atl.c b/drivers/cxl/core/atl.c
>>>>> index d6aa7e6d0ac5..5c15e4d12193 100644
>>>>> --- a/drivers/cxl/core/atl.c
>>>>> +++ b/drivers/cxl/core/atl.c
>>>>> @@ -158,6 +158,16 @@ static int cxl_prm_translate_hpa_range(struct cxl_root *cxl_root, void *data)
>>>>>  		return -ENXIO;
>>>>>  	}
>>>>>  
>>>>> +	/*
>>>>> +	 * There is only support to translate from the endpoint to its
>>>>> +	 * parent port, but not in the opposite direction from the
>>>>> +	 * parent to the endpoint. Thus, the endpoint address range
>>>>> +	 * cannot be determined and setup manually. If the address range
>>>>> +	 * was translated and modified, forbid reprogramming of the
>>>>> +	 * decoders and lock them.
>>>>> +	 */
>>>>> +	cxld->flags |= CXL_DECODER_F_LOCK;
>>>>
>>>  
>>>> Feels like this should be something the BIOS should enforce if that
>>>> is the expectation? And the kernel checks and warns if that is not
>>>> the case.
>>>
>>> I think this is more a limitation of the kernel implementation rather
>>> than the BIOS. The BIOS provides enought information by CFMWS, PRM,
>>> HDM and PCI topology. In theory and if there is demand for it, support
>>> could be added for driver region setup.
>>
> 
>> But shouldn't the BIOS set the decoder lock rather than the kernel
>> setting a software lock flag based on assumption of the PRM based
>> setup?
> 
> If BIOS locks the decoders, it cannot be removed even for the case
> there the OS can actually handle it.

Oh so the current implementation is auto region by BIOS but in the future it may not be? But if you add a lock flag, you wouldn't be able to remove it later anyhow since it's presented as locked?


> 
> -Robert

