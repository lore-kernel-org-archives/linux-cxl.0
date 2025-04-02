Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE8F10F9;
	Wed,  2 Apr 2025 15:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743607871; cv=none; b=tJvDTVO1/kuxrf5vr7/IXpwWm33pqKBOwAvHZwnUQDAwLSFhfvzAT/iUsRXuY3bRFEjKLPBHcEjQOBl3WDAIqbuLRkWtGjS5+bnGd8VJjEGAfpvyctlPSDqoq2XjYeGBzPCpuwg/UtxQZEonMbbAWeidtGi9lKCrImucVt9WxRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743607871; c=relaxed/simple;
	bh=DCRq2ZvCLh3oAN9gAb4UKag+DXIJpyJq8KIvPQhUQrM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mai7tdOR5jI5V3v+2YPSxb91KNOlhJVh3Wn9yn6He7KxO7U3X4dAk5Q4D9XALLemHBCgueP0PPJxj+LVagyfqW3F3/K+MO9MhRb3NWDgMxo5BjpWaz2o3N7/E6HXXk9QIUZjV/tyaYwaMBXDmHPQnLYau+CzW8ssJ6Uobdu4prc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fdCjRJrJ; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fdCjRJrJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743607869; x=1775143869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=DCRq2ZvCLh3oAN9gAb4UKag+DXIJpyJq8KIvPQhUQrM=;
  b=fdCjRJrJRN4jkPqezZRA3V+ubLn9fqN08jZk0q4QAiL/HGFIYf7ivGRn
   el5HRB3VDkiKZ11eC2AVNkfqVodhbKJ+fmBZGcTmi14JSBPUGqVI14vVI
   7reASz4P0o6QwgH+zXNPxOB983+kxcxg0kaWeZ+A4bIfbvb3BmQ0l8cDh
   y+VSY/Av7uDiMj94rOmG5J+Z7YCgCiNLcuj/CzFzo/nA/hua48+IHW5O+
   w1Gt/p1bYDRXOIJkqoFZnE4ys78Smum5rBvyMqQJ0g+4PemmYmfIDmesI
   0SlqvsVTCKFV4JdsqYrqBCdwfhnJl4XwB40UXyKdMzNNNlk3AC7ULAVFf
   A==;
X-CSE-ConnectionGUID: Khp304z5Q9KUNoPd01l3uQ==
X-CSE-MsgGUID: kYlo37VcR4GEPF+VZHpq1w==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="44886652"
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="44886652"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:31:09 -0700
X-CSE-ConnectionGUID: oNBDcvriQd+psnJhCqhhLQ==
X-CSE-MsgGUID: DNoPf2d4Q2upkSzn2xrY6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,182,1739865600"; 
   d="scan'208";a="131719856"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.4]) ([10.125.110.4])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 08:31:08 -0700
Message-ID: <c333ba8b-f01f-4413-81d8-af7efbf5454b@intel.com>
Date: Wed, 2 Apr 2025 08:31:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4 v3] cxl/core: Enable Region creation on x86 with Low
 Mem Hole
To: Robert Richter <rrichter@amd.com>
Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, ming.li@zohomail.com,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20250314113708.759808-1-fabio.m.de.francesco@linux.intel.com>
 <Z91Au5en7r6D7IsW@rric.localdomain> <3301434.hkbZ0PkbqX@fdefranc-mobl3>
 <Z-Zlrm8emmOtQjhu@rric.localdomain>
 <ae1e1b6f-3435-44f6-890b-7c7bd013113a@intel.com>
 <Z-0kzvPAS2JrNiIb@rric.localdomain>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <Z-0kzvPAS2JrNiIb@rric.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/25 4:51 AM, Robert Richter wrote:
> Dave,
> 
> thank you for your answer.
> 
> On 28.03.25 14:10:00, Dave Jiang wrote:
>>
>>
>> On 3/28/25 2:02 AM, Robert Richter wrote:
>>> On 25.03.25 17:13:50, Fabio M. De Francesco wrote:
> 
>>>> Interference? Do you mean that this series would make the driver fail on 
>>>> other platforms? 
>>>
>>> No, other platforms must deal with that specific code and constrains.
>>>
>>>>
>>>> Of course I don't want anything like that. I'm not clear about it...
>>>> Would you please describe how would this series interfere and what
>>>> would happen on other platforms?
>>>
>>> Other platforms should not care about platform-specifics of others. So
>>> again, use a platform check and only enable that code there necessary.
>>> And this requires a well defined interface to common code.
>>
>> Hi Robert,
> 
>> Can you please share more on the background information and/or your
>> specific concerns on the possible memory holes in the other
>> platforms that need to be considered and not covered by Fabio's
>> code? Let's all get on the same page of what specifics we need to
>> consider to make this work. Preferably I want to avoid arch and
>> platform specific code in CXL if possible. Of course that may not
>> always be possible. Would like see if we can avoid a bunch of #ifdef
>> X86/ARM/INTEL/AMD and do it more cleanly. But fully understand the
>> situation first would be helpful to determine that. Thank you!
> 
> We implement a "special" case in the main path. This adds unnecessary
> complexity to the code, makes it hard to maintain, change or even to
> understand in the future. It becomes more error-prone. Though it is
> limited to x86 arch, the code runs for all platforms. A reuse for
> other archs will enable it for all platforms of that archs too.
> 
> This general approach to add "special" cases does not scale. We see
> this already with the "extended linear cache" and now the "low mem
> hole". While I am fine with all those special cases (AMD address
> translation is another), we need a proper way to enable and implement
> those by reducing complexity and with a good isolation. This makes
> future changes easier and reduces conflicts with other
> implementations.

I'm more of thinking that if those special cases are detectable rather than a set of ambiguous rules then we might address those quirks in a way better than #ifdefs. For "extended linear cache", it is detected via HMAT spec change. So while only Intel implements this right now on a platform, other vendors can and may in the future. The LMH is more difficult as there are no are no standard ways to enumerate it. Hopefully a set of clear rules will define this. It does look like Dan is trying to get the CXL spec to clearly define this and discussion in the WG is coming in the next couple weeks. The AMD translation can be detected by seeing if certain ACPI callback methods exist right? Is there more required to detect the special translation needs to be applied? But I do agree with the reducing complexity for maintenance and future implementations.  

> 
> The change of this series does not much, just find a CFMWS region that
> is unaligned to the EP decoder's range and then just shrink the used
> SPA range of the EP to match that region. That can be implemented in a
> very simple way if we introduce a spa_range paramater plus a custom
> port setup. The generalized part of my address translation part alrady
> implements this, it can be reused here. To implement LMH support only
> the following is needed then:
> 
>  * add a setup function with a platform check to add a custom
>    callback,
> 
>  * the callback checks for the LMH range and adjusts the spa_range.
> 
> The modified spa_range matches then with the region range (no changes
> needed here). That's it.
> 
> I can help making this work.

Code is always welcome :)
> 
> I hope that makes sense?

Yes. Appreciate you explaining. thank you!
> 
> Thanks,
> 
> -Robert
> 

