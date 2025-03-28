Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E341EDA10;
	Fri, 28 Mar 2025 21:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743196208; cv=none; b=iZtQyai6Im/O9PHOq+GHOP2sGU4TcErRsTqtizW9VFNaNzxd4bIHuMihZmSGfAy4Bg+rY9mdYGN4hTvx3gkdbKlycpRNv4szRIKEG4LajyTsCUKr0P5skej9mogmk4mSzQ61zvkn69RBIvq1ylNoXWBLOaUhxTG4rpDueJ8alKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743196208; c=relaxed/simple;
	bh=++2rvVuivnu/sxuWqJDDn9O3RKew/CIMlKMDDwQyZa4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p4EgAHFaZOkvfeo8GHnZs6IAMNHWgzL7AXMUHgwAI0tujlyDgHyZANTpLlj+GmCfRs+90OcFTYi2sYW41BGXP6Yzy7zkHtuBVtudj6l0TQqKIatO1VxScU4qktoX+chBbA5bDaPuRN83d0KLdYwry75xLzh9hSy53tlvQMnKL+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HIAVP/Hh; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HIAVP/Hh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743196206; x=1774732206;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=++2rvVuivnu/sxuWqJDDn9O3RKew/CIMlKMDDwQyZa4=;
  b=HIAVP/HhYKYEiBWoGuMdtMhTwOYg2u7xkJV+lzJaY3dhdnQ1mEwST5WW
   afAbivCg5XfJyTX92y02VlNQSQtx9iSK++Er+dL5JyKGYfbo8AT5/1DyH
   iz6X6ZZywgzqCrR3Y63k4DpZbqehVO3B260mvi5vvavsw7Qw8Y8fBBZTb
   Cs+f/8h00WrvYvjCRrwbZaWz2/h50ts4zRQ/o3HzWK/dRS9iWdOSqfqlX
   sPZTCpPaS8eFrGUJj2T26+/11UbqaLa1c4bL0+YOlxq4TtZDEa39ePtn7
   3V6oDYYj2qXd40olNpI5p0c4feOUward4qH0XRiHkfKVP8Fuk8uh4HCSI
   w==;
X-CSE-ConnectionGUID: lZIrBFv1T7eLOMxTlSER5g==
X-CSE-MsgGUID: 98HA7bTxRzKYiiZ/tV3+PA==
X-IronPort-AV: E=McAfee;i="6700,10204,11387"; a="44464333"
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="44464333"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 14:10:04 -0700
X-CSE-ConnectionGUID: tK1MpVj5QC+ydFDFL5eukg==
X-CSE-MsgGUID: iedfHOjgSOSJ6yaOWcznDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,284,1736841600"; 
   d="scan'208";a="125781524"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.185]) ([10.125.108.185])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2025 14:10:02 -0700
Message-ID: <ae1e1b6f-3435-44f6-890b-7c7bd013113a@intel.com>
Date: Fri, 28 Mar 2025 14:10:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
To: Robert Richter <rrichter@amd.com>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z91Au5en7r6D7IsW@rric.localdomain> <3301434.hkbZ0PkbqX@fdefranc-mobl3>
 <Z-Zlrm8emmOtQjhu@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z-Zlrm8emmOtQjhu@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 3/28/25 2:02 AM, Robert Richter wrote:
> On 25.03.25 17:13:50, Fabio M. De Francesco wrote:
>> On Friday, March 21, 2025 11:34:35 AM Central European Standard Time Robert Richter wrote:
>>> Fabio,
>>>
>>> On 14.03.25 12:36:29, Fabio M. De Francesco wrote:
>>>> The CXL Fixed Memory Window Structure (CFMWS) describes zero or more Host
>>>> Physical Address (HPA) windows that are associated with each CXL Host
>>>> Bridge. Each window represents a contiguous HPA that may be interleaved
>>>> with one or more targets (CXL v3.1 - 9.18.1.3).
>>>>
>>>> The Low Memory Hole (LMH) of x86 is a range of addresses of physical low
>>>> memory to which systems cannot send transactions. On those systems, BIOS
>>>> publishes CFMWS which communicate the active System Physical Address (SPA)
>>>> ranges that map to a subset of the Host Physical Address (HPA) ranges. The
>>>> SPA range trims out the hole, and capacity in the endpoint is lost with no
>>>> SPA to map to CXL HPA in that hole.
>>>>
>>>> In the early stages of CXL Regions construction and attach on platforms
>>>> with Low Memory Holes, the driver fails and returns an error because it
>>>> expects that the CXL Endpoint Decoder range is a subset of the Root
>>>> Decoder's (SPA >= HPA). On x86 with LMH's, it happens that SPA < HPA.
>>>>
>>>> Therefore, detect x86 Low Memory Holes, match CXL Root and Endpoint
>>>> Decoders or already made CXL Regions and Decoders to allow the
>>>> construction of new CXL Regions and the attachment of Endpoint Decoders,
>>>> even if SPA < HPA. If needed because of LMH's, adjust the Endpoint Decoder
>>>> range end to match Root Decoder's.
>>>>
>>>> - Patch 1/4 changes the calling conventions of three match_*_by_range()
>>>>   helpers in preparation of 3/4.
>>>> - Patch 2/4 Introduces helpers to detect LMH's and also one to adjust
>>>>   the HPA range end for CXL Regions construction.
>>>> - Patch 3/4 enables CXL Regions construction and Endpoint Decoders
>>>>   attachment by matching Root Decoders or Regions with Endpoint
>>>>   Decoders, adjusting Endpoint Decoders HPA range end, and relaxing
>>>>   constraints while Endpoints decoders' attachment.
>>>> - Patch 4/4 simulates a LMH for the CXL tests on patched CXL driver.
>>>>
>>>> Many thanks to Alison, Dan, and Ira for their help and for their reviews
>>>> of my RFC on Intel's internal ML.
>>>>
>>>> Commenting on v1, Alison wrote a couple of observations on what users
>>>> will see. I suggest anyone interested to see how this series affect
>>>> users to take a look at her observations.[0] Thank you!
>>>>
>>>> Changes for v3:
>>>>
>>>>   Re-base the series on cxl/next.
>>>>
>>>>   1/4 - 2/4:
>>>> 	Constify local variables.
>>>>   3/4:
>>>> 	Call arch_match_region() from region_res_match_cxl_range().
>>>>   4/4:
>>>> 	arch_match_region() - Check that region end is under start + 4G;
>>>> 	arch_match_spa() - Check that SPA range start is cfmws_range_start.
>>>
>>> I have sent comments for version 1 and suggested a simpler approach
>>> for this to implement.
>>>
>> I replied to your comments for version 1. Please find my message at 
>> https://lore.kernel.org/linux-cxl/9930375.eNJFYEL58v@fdefranc-mobl3/.
> 
> The outcome was "I'll think about it.".
> 
>>>
>>> My comments haven't been addressed yet,
>>>
>> I think it's not possible to detect an LMH while still in cxl_port_add().
> 
> Why is that not possible? I have outlined a solution before: Implement
> a function to run platform specific port setup. Run a platform check.
> Enable a platform dependend callback. Setup the port using platform
> specifics.
> 
>> Therefore, I think that this is the best way to go. It works to prevent
>> the driver to fail to create Regions and attach Endpoint Decoders on x86
>> with Low Memory Holes, provided that the lower SPA range starts at 0x0.
> 
> An alternative works as well, that is not an argument.
> 
>>
>> On platforms with other kind of holes, the driver will continue to fail
>> as it currently does. 
> 
> And those platform will then add more specific code and more
> complexity in the main path other need to run? See, the code needs to
> be encapsulated.
> 
>>>
>>> but we
>>> need better isolation to reduce interference with other platforms and
>>> archs. Please take a look again.
>>>
>> Interference? Do you mean that this series would make the driver fail on 
>> other platforms? 
> 
> No, other platforms must deal with that specific code and constrains.
> 
>>
>> Of course I don't want anything like that. I'm not clear about it...
>> Would you please describe how would this series interfere and what
>> would happen on other platforms?
> 
> Other platforms should not care about platform-specifics of others. So
> again, use a platform check and only enable that code there necessary.
> And this requires a well defined interface to common code.

Hi Robert,
Can you please share more on the background information and/or your specific concerns on the possible memory holes in the other platforms that need to be considered and not covered by Fabio's code? Let's all get on the same page of what specifics we need to consider to make this work. Preferably I want to avoid arch and platform specific code in CXL if possible. Of course that may not always be possible. Would like see if we can avoid a bunch of #ifdef X86/ARM/INTEL/AMD and do it more cleanly. But fully understand the situation first would be helpful to determine that. Thank you!

DJ

> 
> Thanks,
> 
> -Robert
> 
>>
>> Thanks,
>>
>> Fabio
>>>
>>> Many thanks,
>>>
>>> -Robert
>>>
>>
>>
>>
>>

