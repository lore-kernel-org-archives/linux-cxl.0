Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E341A3E7BC8
	for <linux-cxl@vger.kernel.org>; Mon,  6 Jul 2026 16:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783355563; cv=none; b=FTiUaLl1boNUSDqk849JY4ROI+UOkuXiNBjbOEdymSGn4PFTZ8gA+eM3txAleDjpsYxlthkCfGwekY5Dr5hrrnlK1XxOWdjmlx8u/GLWNRqCJOL0kbryG/K1ABL0xHwzuFEc/Ahud0Xpg8RH3y4npKBo0bakkAeiZIrYzqprU5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783355563; c=relaxed/simple;
	bh=ChT0Cy7t5UleR4cMAh98klooOZKR2NojT6Ljhw1EM/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pfMDcGr5jomjASiGKx0KeRScT+yycKtLgZaiN8wGHRE7MQGdxTBRzqWeUWLgLP+S4v+zaojrFzIqPe7CxtycS0XUSzXtZcBnan/bburcG56ovgeTfZn5Z88lnGV3lqID4T/vzuMFvUgtnFnO4K13fBacy/B2QDhV851L6cJ81KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I3ZqVljW; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I3ZqVljW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783355562; x=1814891562;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ChT0Cy7t5UleR4cMAh98klooOZKR2NojT6Ljhw1EM/A=;
  b=I3ZqVljWRVZ0LY8pZRoo0VyNr3hbhquvyf85WMQOFbEqdWHjQPJ6rMOy
   0GMdMBq1SCzI0aDdDISQQXfzdCF6doqCG+5GQs0EGfgV1+5OJvCDnIIt6
   nYqjJHmf/BCtSlo0ge+pE7AqEzVZo/pqG34/A7Kp9ecL5QkGJwtNnTn2X
   q1TZ+lMf9kO5il7w6fkLCQ2os7K5M5eHWfFTTvzV4S5j9kGhNcPX58a7/
   MesHPoi8pl5wP+qxG6TJSdb6wzhVRSknvtRAGh1tTxC0goB5ksAAHtOtG
   ykEKgSWF/TUKkosTqTPy1qb6u+xlethPwgUbM98FxPewtuGFElRzYcxP0
   A==;
X-CSE-ConnectionGUID: VRU9ESi3R3+aieOEksk4iw==
X-CSE-MsgGUID: hUvrZisFS0K0fmfMEVnc7A==
X-IronPort-AV: E=McAfee;i="6800,10657,11838"; a="95149360"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="95149360"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:32:41 -0700
X-CSE-ConnectionGUID: YdAtQfd0RAeZypVi9ybSLA==
X-CSE-MsgGUID: eBx7Fhz/RkC1Ul7CmGNmaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="291920458"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 09:32:42 -0700
Message-ID: <7b8cb4b0-f532-4711-9b37-a930ea1ed7a1@intel.com>
Date: Mon, 6 Jul 2026 09:32:40 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] cxl/hdm: Allow zero sized HDM decoders
To: Richard Cheng <icheng@nvidia.com>, sashiko-reviews@lists.linux.dev
Cc: linux-cxl@vger.kernel.org
References: <20260625092857.41139-1-icheng@nvidia.com>
 <20260625092857.41139-2-icheng@nvidia.com>
 <20260625094718.8D3FD1F000E9@smtp.kernel.org> <akYSpn_EyYTys6Fh@MWDK4CY14F>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <akYSpn_EyYTys6Fh@MWDK4CY14F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/2/26 12:28 AM, Richard Cheng wrote:
> On Thu, Jun 25, 2026 at 09:47:18AM +0800, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>> - [High] cxl_dpa_free() returns early for zero-sized decoders, permanently stranding their DPA reservation and breaking LIFO decoder teardown.
>> --
>>
>> commit 0afce63a5399c17fcedf2e4f736d16ed9b2f7179
>> Author: Richard Cheng <icheng@nvidia.com>
>>
>> cxl/hdm: Allow zero sized HDM decoders
>>
>> This commit allows empty (zero-sized) HDM decoders to be treated as first
>> class instead of being rejected. It backs them with a kmalloc'd resource
>> since the resource tree cannot represent an empty range, while keeping the
>> skip and hdm_end accounting intact.
>>
>>> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
>>> index 0c80b76a5f9b4..ccbab2e21f060 100644
>>> --- a/drivers/cxl/core/hdm.c
>>> +++ b/drivers/cxl/core/hdm.c
>> [ ... ]
>>> @@ -545,7 +569,7 @@ int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
>>>  	struct device *dev = &cxled->cxld.dev;
>>>  
>>>  	guard(rwsem_write)(&cxl_rwsem.dpa);
>>> -	if (!cxled->dpa_res)
>>> +	if (cxled_empty(cxled))
>>>  		return 0;
>>
>> [Severity: High]
>> Does this early return permanently strand the DPA reservation and break LIFO
>> decoder teardown for zero-sized decoders?
>>
>> By returning early for zero-sized decoders here, the cleanup logic inside
>> devm_cxl_dpa_release() is bypassed. This means the kmalloc'd 0-size
>> resource and any associated skip range aren't freed, and port->hdm_end is
>> not decremented.
>>
>> Consequently, any attempt to resize a zero-sized decoder would fail with
>> -EBUSY because the reservation isn't actually freed. Attempting to free any
>> lower-indexed decoder would also fail with -EBUSY due to the port->hdm_end
>> ID mismatch.
>>
>>>  	if (cxled->cxld.region) {
>>>  		dev_dbg(dev, "decoder assigned to: %s\n",
>>>  			dev_name(&cxled->cxld.region->dev));
>>
>> -- 
>> Sashiko AI review · https://sashiko.dev/#/patchset/20260625092857.41139-1-icheng@nvidia.com?part=1
> 
> I don't think this stands,
> devm teardown still runs __cxl_dpa_release(), which kfrees the zero-size resource, releases the skip,
> and decrements hdm_end. The early return only skips the sysfs free patch, and a committed empty decoder
> is not userspace-manageable, resize already fails on the F_ENABLE check, and F_ENABLE is never cleared
> since an empty decoder joins no region. Dan cover this on v5, I think it's ok for now.
> 
> Anyone has thoughts on this ?

sashiko looks to be wrong in this scenario. I think we can ignore. 

> 
> --Richard
> 

