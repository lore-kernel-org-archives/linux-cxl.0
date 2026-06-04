Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B11023812E4;
	Thu,  4 Jun 2026 15:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780587945; cv=none; b=jRFWT5sBShXUNo7w4Ysn3A7KU+apZA0da4zUXJ06Au82apfOn1KujUcepWXQOXZ3VZZUOgQssMkyDolRjVWnJ0J6c85Ag6kYrC/6YWVGndothf8WA8dU98wUsJ9WvZ+krRxuFQXH8XpQR0AP5jKpVwZR/aucIFVB3CFD8enZnX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780587945; c=relaxed/simple;
	bh=5fTfTeDePnUCU8NeGBX71SY280ubMI052UIveZM2QEM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uwp3cBsBG6HtuRFqq8kMcRInl9Qz4FlVU8GB+yhhf0UYq9r/n1T/0IyTG1O4UY9c2B/b2jhXuT2IplBoAnkxQ36/J5xWD6skg5+VLhg98CGiWz3Ck1IuJQ9yBcILtfB//7JsGYz5iJrdLLf0lBvR+7tZyesG/ygWBPnP4dqQ46o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iRLvAx/0; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iRLvAx/0"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780587944; x=1812123944;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=5fTfTeDePnUCU8NeGBX71SY280ubMI052UIveZM2QEM=;
  b=iRLvAx/0n9ATzN00AJHPb/k7RU+WH5TRKbKY9iK540e+QsgHvzZ4HgPH
   vvfwBU6vvcldAYY27Rn7SFytjUgM8LK4Dsqi2jrLtI6sv1cf9yq2QJNAM
   WM1IlylLJbrMhGuW4VLCvmaEexgMYOqG1KmLWFSG9cYNiPMCQ9BjRFvuo
   MqJ/+3JmYAhL8oSUOmRvb2qk75Je+78PMB4oBzIhkyZZ7gUymrovTR2Ll
   gph25tYS0Rv3tLTvUZoRcXsSq5WE/Q5o98NfHqZ7DHsxCncKWjqEpnHKv
   bTaVAbv4TBUPf0zCu1ivBIiefhy7fH36dZ8ANmZJo98IJCfcwppgvFSdr
   w==;
X-CSE-ConnectionGUID: qj/a4vi6QeCexg7fC+sXBA==
X-CSE-MsgGUID: oBtVD/4wRWOC0WRdwbQYuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="92901189"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="92901189"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:45:43 -0700
X-CSE-ConnectionGUID: Fp9d8JheTney8gWxTn9qdQ==
X-CSE-MsgGUID: +Kl4Ba+zTWCZwitII1EcPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; 
   d="scan'208";a="238230776"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.108.206]) ([10.125.108.206])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2026 08:45:42 -0700
Message-ID: <e5c36677-c4e1-4622-9a9c-d056d2a266ba@intel.com>
Date: Thu, 4 Jun 2026 08:45:41 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Fix NULL pointer within p->targets[]
To: Li Ming <ming.li@zohomail.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <djbw@kernel.org>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260530-fix_null_in_targets_array-v1-1-312c3bf1fe0f@zohomail.com>
 <aiCtet61qSddQ-Pr@aschofie-mobl2.lan>
 <09a534c2-3dc2-4fd9-a69b-c26771af45f1@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <09a534c2-3dc2-4fd9-a69b-c26771af45f1@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/4/26 6:28 AM, Li Ming wrote:
> 
> 在 2026/6/4 06:40, Alison Schofield 写道:
>> On Sat, May 30, 2026 at 12:24:40PM +0800, Li Ming wrote:
>>> cxl_region_remove_target() leaves a NULL pointer in the slot of the
>>> removable endpoint decoder in p->targets array. However, p->targets
>>> array replies on p->nr_targets to determine validity, which means when
>>> p->nr_targets == p->interleave_ways, driver assumes all elements from
>>> index 0 to (p->nr_targets - 1) are valid. The stale NULL pointer
>>> violates this assumption and causes the driver to treat a NULL pointer
>>> as a valid endpoint decoder.
>>>
>>> To fix this issue, when a endpoint decoder is removed by
>>> cxl_region_remove_target(), always swap the last valid endpoint decoder
>>> pointer into the slot of removal endpoint decoder to ensure all pointers
>>> before p->targets[p->nr_targets] are valid.
>>>
>>> Fixes: 809ccef5385f ("cxl/region: Fix out-of-bounds access in cxl_cancel_auto_attach()")
>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>> Signed-off-by: Li Ming <ming.li@zohomail.com>
>>> ---
>>>   drivers/cxl/core/region.c | 10 +++++++++-
>>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index e90c024c8036..54018db87a4c 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2220,7 +2220,15 @@ static int cxl_region_remove_target(struct device *dev, void *data)
>>>               p->nr_targets--;
>>>               cxled->state = CXL_DECODER_STATE_AUTO;
>>>               cxled->pos = -1;
>>> -            p->targets[i] = NULL;
>>> +
>>> +            /*
>>> +             * Swap the last valid target into the slot to
>>> +             * ensure no invalid target in p->nr_targets range.
>>> +             * The targets array will be re-sorted during the
>>> +             * last endpoint decoder attaching again.
>>> +             */
>>> +            p->targets[i] = p->targets[p->nr_targets];
>>> +            p->targets[p->nr_targets] = NULL;
>>>                 return 1;
>>>           }
>> Hi Ming,
>>
>> I'm replying to top post here, but I have read the Sashiko response
>> and your response to that.
>>
>> I'm offering review on the target list holes, but deferring on the
>> issue with cxl_rr_free_decoder because I think it's a narrow window
>> and it would not belong in *this* patch. (and maybe I'm running
>> out of steam too ;))
>>
>> For the target list holes. I think there may be a single change
>> that can fix both the site you've fixed in this patch, and the
>> decoder detach site that Sashiko calls out.
>>
>> Rather than add compaction at each removal site, make the AUTO
>> 'appender' insert the decoder in the first free slot instead of
>> blindly at p->targets[p->nr_targets].
>>
>>      /* Use first free slot. Do not assume nr_targets is dense */
>>      for (pos = 0; pos < p->interleave_ways; pos++)
>>              if (!p->targets[pos])
>>                      break;
>>      ...
>>      p->targets[pos] = cxled;
>>      cxled->pos = pos;
> Yes, I think it can solve the problem, I will take a try.
>>
>>
>> My reasoning, that you'll need to prove -
>>
>> - Removal only leaves a hole. The damage happens later in the appender
>> Fix the appender and the hole becomes harmless no matter who created it.
>>
>> - It covers the cancel-auto site because a hole left by the staging
>> cancel is skipped by the next append, so the swap-compaction in this
>> patch is no longer needed.
> 
> Yes, if we use finding the first free slot for a decoder attachment, we will not need swap-compaction. But we should reuse p->interleave_ways instead of p->nr_targets for walking p->targets array in cxl_region_remove_target(), consecutive detach will have problem without that. Like this:
> 
> p->nr_targets = 4
> 
> [-1, 1, 2, 3]    # __cxl_decoder_detach() called for pos 1, remove it.
> 
> 
> p->nr_targets = 3
> 
> [-1, NULL, 2, 3] # __cxl_decoder_detach() called for pos 3, but it have no chance to be accessed by cxl_region_remove_target().
> 
> 
> Maybe Dave could drop the OOB fix, I will send out a patchset that includes both the "insert decoder in the first free slot" and the OOB fix.
> 

OOB fix dropped from cxl/next

DJ

> 
>>
>> - It covers the decoder detach site similarly (per Sashiko). The NULL
>> left by __cxl_decoder_detach() is filled on re-attach instead of being
>> appended past. Your reproduce seems like it would verify that.
>>
>> - It needs no manual-vs-auto special case. An AUTO region has exactly
>> interleave_ways slots and interleave_ways members, so first-free-slot
>> keeps the array dense whenever it is full. The manual path is
>> untouched.
>>
>> I'd probably rename to something like:
>> cxl/region: Fill first free targets[] slot during auto-discovery
> Will do
>>
>> BTW the fixes tag is not the OOB fix but is the original commit,
>> the same one you used in the OOB fix. 87805c32e6ad
> 
> Sure, Will fix it, thanks.
> 
> 
> Ming
> 
>>
>> -- Alison
>>
>>
>>> ---
>>> base-commit: 809ccef5385fa1779c7db3de43272f3fc6a87a45
>>> change-id: 20260530-fix_null_in_targets_array-124303a8ba0f
>>>
>>> Best regards,
>>> -- 
>>> Li Ming <ming.li@zohomail.com>
>>>
>>>

