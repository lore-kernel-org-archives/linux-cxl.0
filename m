Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03376184;
	Wed, 14 Jan 2026 16:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768406908; cv=none; b=IGGn4G4CuSghJnFZRpAomky751QqRLykLDzuvMDn4IZWmR4VQEtbgVVzWpJajF2rWb+nMCGwpnAKheZsk4j0F+ll3gAOEThvz6DDLmTHEaZAobimaVVoUztlZ7LKlh6o5Uq9WDMMUVCrMXElKKQf4P5mkghotT0zuPuyxrhJ3Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768406908; c=relaxed/simple;
	bh=ZH8ShbU7tU/JCfmsB/urIuO0l5PW2RETPf1nVR1ugJc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YiBM2rXxK2eB+sTL6cnT6fDvpbP8M7hWCwpMeYUcjoOIyneiyWmaOJkT6HU9s+zQqUsRRp04afvzQsPnaONexrjfdCaWsRHhLBl591SOC3ELlpf/yL2/K2eBUSuJ8XWIugXqBrP8ni482IyN8OpoWNQWUaKlNpYhJwgPLr0/iQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BofwBOOJ; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BofwBOOJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768406906; x=1799942906;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZH8ShbU7tU/JCfmsB/urIuO0l5PW2RETPf1nVR1ugJc=;
  b=BofwBOOJqGDr7y7gGsftXqzjwcT0pZAP9woqGmlRRZkK7mPJ1sU6Dfl8
   hbB91Wohq7wLbuZstlHcXl0b92zQ6c178Od2lbi5Tz/iZ06fSRdgGvWbu
   GJ3vIUht4yiWW0njQoFpY1OJ+FM+okQ6+IJ5w2eV5KX9k5raDiqM8nEzq
   O+UWh4apcARypFKF4V2rzpJvGnAbZZhvp2kZcycumdBTmPeTPdlXOrFpO
   xRDq+rtscT/+IdKde0031OnV6Rm9ppZu/j5+z3r0UsySIWi+5LjbvFB7x
   JwcVQtBvlvUoTMkWxUDFKujJVyXUHJ2D5fTu1fHeqhyjvYVsogFnm8LDd
   g==;
X-CSE-ConnectionGUID: MdZZm/ArTJWQogL9MnS+Bw==
X-CSE-MsgGUID: rw1uHC81QGeA7Hzcqipb0w==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="80005414"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="80005414"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:08:25 -0800
X-CSE-ConnectionGUID: wVLF+D1NS26h0KdeaO8XbQ==
X-CSE-MsgGUID: boAZEdObSG+2IMJ6GPNS1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; 
   d="scan'208";a="235441009"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 08:08:19 -0800
Message-ID: <6411cf5f-0a92-452c-b974-be14dcc4bd32@intel.com>
Date: Wed, 14 Jan 2026 09:08:17 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl: Check for invalid addresses returned from
 translation functions on errors
To: Robert Richter <rrichter@amd.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260107120544.410993-1-rrichter@amd.com>
 <3dbe036d-608d-486a-bc5a-b55b690d8347@intel.com>
 <aWaEqW1vP3EEOvYK@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <aWaEqW1vP3EEOvYK@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/13/26 10:45 AM, Robert Richter wrote:
> On 13.01.26 08:51:15, Dave Jiang wrote:
>>
>>
>> On 1/7/26 5:05 AM, Robert Richter wrote:
>>> Translation functions may return an invalid address in case of errors.
>>> If the address is not checked the further use of the invalid value
>>> will cause an address corruption.
>>>
>>> Consistently check for a valid address returned by translation
>>> functions. Use RESOURCE_SIZE_MAX to indicate an invalid address for
>>> type resource_size_t. Depending on the type either RESOURCE_SIZE_MAX
>>> or ULLONG_MAX is used to indicate an address error.
>>>
>>> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>> ---
>>> v3:
>>>  * updated sob-chain,
>>>  * changed error handling flow in test/cxl_translate.c (Alison),
>>>
>>> v2:
>>>  * separated from this patch series (Alison):
>>>    [PATCH v8 00/13] cxl: ACPI PRM Address Translation Support and AMD Zen5 enablement
>>>  * improved error handling logic and early return on error in
>>>    region_offset_to_dpa_result() (Dave),
>>>  * use RESOURCE_SIZE_MAX to indicate an invalid address for
>>>    resource_size_t types (Alison, kernel test robot),
>>>  * improved patch description (Alison),
>>>  * added line wrap for code >80 chars.
>>> ---
>>>
>>> Signed-off-by: Robert Richter <rrichter@amd.com>
>>
>> Applied to cxl/fixes
>> 8441c7d3bd6c5a52ab2ecf77e43a5bf262004f5c
> 
> Thanks Alison and Dave.
> 
>> Added user impact statement and fixed up tab formatting reported by checkpatch.
> 
>>> +		pr_err("test random iter %d FAIL hpa=%llu, dpa=%llu reverse_dpa=%llu, pos=%d reverse_pos=%d eiw=%u eig=%u\n",
>>> +			i, hpa, dpa, reverse_dpa, pos, reverse_pos, eiw, eig);
> 
> Note that my checkpatch does not trigger a tab issue here. How did you
> test that?

Maybe --strict?

> 
> Thanks,
> 
> -Robert

