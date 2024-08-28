Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86D6416CD07
	for <linux-cxl@vger.kernel.org>; Wed, 28 Aug 2024 15:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724859311; cv=none; b=cmD/9GAJ1rkze3R0IGroBfMmpwMiSJURKY+j2Dw4uh5YhReY1mlycG0LiBZcCP/gsY0JyQnIEtndQZM40JMi38tpQ1652fwmcmUvlBJNFF5wycjLn6YoqS9Q+Ojt3jIzK6Ws1o1m+88edrz5bsUTsZZfAMZq/8NeJeg+vDJwD2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724859311; c=relaxed/simple;
	bh=GMBSBnPHUgzK8P13/6MlnPEocUIO5VOHMAPdRJHMiD8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ikQaZhQRMezHtTHH1aqUXLjkI9SOM512bUX3ki/lfElxnueHko0GWCp3rrQfca2RhkRryiVq+qOyk3WHv6Xzjm1kLwVoU5tUxEqcA8M7QDCWlczO+9PTNrqCKdPDDfM+Ein14ZdVXQQbe7r4Y9FknKl1IST5DNuE0/Q6QN0WrjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dckdwjjr; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dckdwjjr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724859309; x=1756395309;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GMBSBnPHUgzK8P13/6MlnPEocUIO5VOHMAPdRJHMiD8=;
  b=dckdwjjrrMZqE8Ws5JTCIxx+m0tsqMvf2GXjSnCPDzqyYe5CupiIvU6a
   bvWhk2yRR6Z3wRcHj6rw7QFOIznUhJW5EW6v5nCWhTg+jhfe3Bgk1R1Co
   qA50EsprzfbXoqBKGQkiVOl8PU28o9lu40QWgZjp1qnMXXGHPBkV5X3US
   OLL+on18FFkja7v9x+UvHjpUYrO5AqRtZEMMNvUdNfR8cMJRFDKe5E/70
   ZNCreR65Qh4yQH5o7RQcV6l+mqHMVsdm5ZXxXH+dz9WeF5NO5YpUfGdmV
   B4m6aYui+2jMA3gQevJrat0PeiquBgj8rCNuRofg8bKyqYwqLA8Ls+fef
   g==;
X-CSE-ConnectionGUID: qYLyZHIpTA2cEVWa4Pfp6w==
X-CSE-MsgGUID: 9yQ+fDPQSTWkkwVmtNKkUg==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23282741"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23282741"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:35:09 -0700
X-CSE-ConnectionGUID: kE+vMceOSfW6pvBUhDtmEQ==
X-CSE-MsgGUID: 1ufj+cfbQyCwlix9EHNoEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="62905778"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.111.94]) ([10.125.111.94])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 08:35:08 -0700
Message-ID: <426842e1-ac1b-4741-8774-0d40dfbd8a33@intel.com>
Date: Wed, 28 Aug 2024 08:35:07 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 3/3] cxl: Add documentation to explain the shared link
 bandwidth calculation
To: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: linux-cxl@vger.kernel.org, dan.j.williams@intel.com, ira.weiny@intel.com,
 vishal.l.verma@intel.com, alison.schofield@intel.com, dave@stgolabs.net
References: <20240710222716.797267-1-dave.jiang@intel.com>
 <20240710222716.797267-4-dave.jiang@intel.com>
 <20240827170640.000007ab@Huawei.com>
 <3c325ad2-e483-417a-a952-1357df3382c4@intel.com>
 <20240828100015.000010a0@Huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20240828100015.000010a0@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/28/24 2:00 AM, Jonathan Cameron wrote:
> On Tue, 27 Aug 2024 15:38:27 -0700
> Dave Jiang <dave.jiang@intel.com> wrote:
> 
>> On 8/27/24 9:06 AM, Jonathan Cameron wrote:
>>> On Wed, 10 Jul 2024 15:24:02 -0700
>>> Dave Jiang <dave.jiang@intel.com> wrote:
>>>   
>>>> Create a kernel documentation to describe how the CXL shared upstream
>>>> link bandwidth is calculated.
>>>>
>>>> Suggested-by: Dan Williams <dan.j.williams@intel.com>
>>>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>  
>>> Oops. Missed this previously.  A few minor things inline.
>>>
>>> J  
>>>> ---
>>>>  .../driver-api/cxl/access-coordinates.rst     | 90 +++++++++++++++++++
>>>>  Documentation/driver-api/cxl/index.rst        |  1 +
>>>>  MAINTAINERS                                   |  1 +
>>>>  3 files changed, 92 insertions(+)
>>>>  create mode 100644 Documentation/driver-api/cxl/access-coordinates.rst
>>>>
>>>> diff --git a/Documentation/driver-api/cxl/access-coordinates.rst b/Documentation/driver-api/cxl/access-coordinates.rst
>>>> new file mode 100644
>>>> index 000000000000..973e63872f06
>>>> --- /dev/null
>>>> +++ b/Documentation/driver-api/cxl/access-coordinates.rst
>>>> @@ -0,0 +1,90 @@
>>>> +.. SPDX-License-Identifier: GPL-2.0
>>>> +.. include:: <isonum.txt>
>>>> +
>>>> +==================================
>>>> +CXL Access Coordinates Computation
>>>> +==================================
>>>> +
>>>> +Shared Upstream Link Calculation
>>>> +================================
>>>> +For certain CXL region construction with endpoints behind CXL switches (SW) or
>>>> +Root Ports (RP), there is the possibility of the total bandwdith for all  
>>> spell check. bandwidth  
>>>> +the endpoints behind a switch being more than the switch upstream link.  
>>>
>>> Could also be the Generic Port bit of the topology. Mind you I'm still failing
>>> to come up with text for the qemu GP Documentation that the reviewers can follow
>>> so maybe that's just too hard to describe here.  Could use weasel words.
>>>
>>> "A similar situation can occur within the host, upstream of the root ports."
>>>
>>>   
>>>> +The CXL driver performs an additional pass after all the targets have
>>>> +arrived for a region in order to recalculate the bandwidths with possible
>>>> +upstream link being a limiting factor in mind.
>>>> +
>>>> +The algorithm assumes the configuration is a symmetric topology as that
>>>> +maximizes performance. When asymmetric topology is detected, the calculation
>>>> +is aborted when such topology is detected. An asymmetric topology is detected  
>>>
>>> is detected is duplicated.  
>>
>> I don't follow here.
>>
>> + When asymmetric topology is detected, the calculation
>                              ^^^^^^^^^^^
>> +is aborted when such topology is detected.
>                                 ^^^^^^^^^^^^
> Delete the second one.

Thanks. The brain does funny tricks sometimes when reading the stuff you write yourself. 

> 
>>>   
>>>> +during topology walk where the number of RPs detected as a grandparent is not
>>>> +equal to the number of devices iterated in the same iteration loop.  
>>>
>>> Maybe make the point that asymmetric in terms of only properties of devices
>>> is not detected. It just uses the first one I think?  
>>
>> I also don't follow here.
>>
>> I also wonder if I should use "unbalanced" topology rather than "unsymmetric"?
> 
> Difference between detecting a topology with different number of links and one
> where say one type 3 device in an interleave set has lower bandwidth in it's CDAT.
> 
> IIRC this does the first, but not the second.

I think here we attempt to detect whether one root port has different level of switch(s) vs another. For example a topology configuration like RP0 is direct attached and RP1 has a switch underneath. 

> 
>>
>> DJ
> 
