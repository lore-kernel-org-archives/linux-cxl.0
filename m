Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F073438BC
	for <linux-cxl@vger.kernel.org>; Mon, 31 Aug 2026 11:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.112
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788174188; cv=none; b=XcQmhHhXS9IJFNS1T9bf0/SQpe872c2pV64EvEXmUyhZOpD49q157HKBEkMfMGVXcMMjeV9vZI1DL7hm4swma6vEOWncsDonW67n/ViBkozROsTqQ6RDacsgW0DgPpPixHb0+jeyxwA0CYyrNxsYUF9Xz7WTwFB57U4tT0nP1Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788174188; c=relaxed/simple;
	bh=e9/nvxXM/AGQn9zl4OIVnaZfHIZF1hIPDDrqNnJXlkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E7Ax5sNuB/gvbwgmFGeoGuJIhZPC/m+JZzeuYALeyX3FETfMA5QXYDb6FfvSwcUTIFjQoFQPhyt1mPNJlv5lsXLCcrZ0hGVFzNklIDWCTdfOLmp1PIaVm5kSYsVNtnpD0halp02ulrtV/VzKpJ4G7nPc0xQT3DimWbB4uitS4ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Y+/SipHE; arc=none smtp.client-ip=115.124.30.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Y+/SipHE"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1788174182; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=xQQoRzmwV8MXvI517q5x41UPB6U0BKWkUH49jmiVgV4=;
	b=Y+/SipHEaycOqRU8vZhLGErF2u2ajlq2/q1p9DwY5dbRXcUV1+J3mcCfqUtxC9M4NGjKE6oinRqKmv9hvpN/Lp+q8N3t+LpY8hTWZXVftuTZ2kuxlUFoxjNmwP0Pk6OTRti2EzXbY0DV2iLF3sWQX2ybMBxsp1lKy+B2whtJO8w=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X9x9frm_1788174180;
Received: from 30.178.67.152(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9x9frm_1788174180 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 31 Aug 2026 19:03:01 +0800
Message-ID: <0e756618-242e-4449-b001-7aa937c9cb66@linux.alibaba.com>
Date: Mon, 31 Aug 2026 19:02:59 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
To: Dave Jiang <dave.jiang@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
References: <20260821021029.2550584-1-kanie@linux.alibaba.com>
 <20260821233305.32d77d60@jic23-huawei> <20260821233714.54f67d0a@jic23-huawei>
 <195c022c-e794-4476-8ce5-84fc55cca76e@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <195c022c-e794-4476-8ce5-84fc55cca76e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/25 23:45, Dave Jiang 写道:
>
> On 8/21/26 3:37 PM, Jonathan Cameron wrote:
>> On Fri, 21 Aug 2026 23:33:05 +0100
>> Jonathan Cameron <jic23@kernel.org> wrote:
>>
>>> On Fri, 21 Aug 2026 10:10:29 +0800
>>> Guixin Liu <kanie@linux.alibaba.com> wrote:
>>>
>>>> After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() samples the
>>>> Committed bit at cxlhdm->regs.hdm_decoder for every decoder that has
>>>> CXL_DECODER_F_ENABLE set. Decoders emulated from the CXL DVSEC range
>>>> registers carry that flag too, but their state does not live in the HDM
>>>> decoder registers. When the component registers expose no HDM decoder
>>>> capability, regs.hdm_decoder is NULL and the readl() oopses in the reset
>>>> completion path. When the capability is present but firmware left
>>>> Mem_Enable set with the global HDM decoder enable clear, the Committed bit
>>>> reads zero and cxl_reset_done() reports a reset that never happened: it
>>>> taints the kernel and strips CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK
>>>> from every endpoint decoder, even though the driver still cannot reprogram
>>>> the DVSEC ranges.
>>>>
>>>> Skip the check when cxld->commit is NULL. Only
>>>> cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, so that one
>>>> test covers both emulation paths, and a DVSEC-described range has no
>>>> Committed bit for a reset to clear.
>>>>    
>>> This is still a lot of text to read - I'll have stab an what I think would be sufficient.
>>> Take this perhaps as inspiration, not a precise suggestion!
>> Ah I see this was the cut down text Dave suggested.
>> That's fine (though I think he could have gone further!)
> I have no issues if you are able to condense it further. :)
>
> DJ
Hi Jonathan, Hi Dave, I condense the commit body in v5, thanks. Best 
Regards, Guixin Liu
>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>>
>> I think it is still worth thinking about the question on what it means
>> to try and recover below.  Though looking at how this is used, it
>> is just to complain that something crazy happened - so maybe none of this
>> matters!
>>
>> Jonathan
>>
>>
>>> When HDM decoders are emulated from DVSEC range registers either (a) there are
>>> no HDM decoder registers present or (b) the DVSEC registers were in use at driver
>>> load.
>>>
>>> After FLR or SBR, __cxl_endpoint_decoder_reset_detected() checks the HDM
>>> decoder committed bit for any previously committed decoders. This includes
>>> emulated decoders: (a) results in a NULL pointer dereference, (b) in a false
>>> detection of reset when they are present and not in use as the committed bit
>>> was never set.
>>>
>>> Use absence of cxld->commit to elide the reset check for emulated decoders.
>>>
>>>> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
>>>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>>> This does make me wonder if we should be doing something similar to check
>>> the dvsec based decoding reset.  The memory_base_high should reset to 0
>>> for example.
>>>
>>> Can we actually do anything with such devices?  Not sure we can today.
>>> That is not a reason to crash however so this fix still makes sense.
>>>
>>> Jonathan
>>>
>>>> ---
>>>> This was patch 4/8 of the "cxl: Assorted fixes" series [1], resent
>>>> individually per review feedback.
>>>>    
>>>> The two synchronisation concerns the review bot raised on v2 - the missing
>>>> exclusion against a cxl_port unbind freeing the devm allocated cxl_hdm, and
>>>> the plain read-modify-write of cxld->flags in
>>>> cxl_endpoint_decoder_clear_reset_flags() while the region paths update the
>>>> same word under cxl_rwsem.region - are still untouched here. Both are
>>>> about the reset handler's locking rather than about which registers it
>>>> reads, and neither fix is local; happy to follow up with separate patches.
>>>>
>>>> v1->v2:
>>>> - rebase onto cxl/next
>>>> - rewrite the commit message to describe the behaviour rather than narrate
>>>>    the code change (Alison Schofield)
>>>>
>>>> v2->v3:
>>>> - test cxld->commit instead of cxlhdm->regs.hdm_decoder, so that decoders
>>>>    emulated from the DVSEC ranges are also skipped when the HDM decoder
>>>>    registers exist but are globally disabled (Richard Cheng)
>>>> - update the subject and the commit message for the widened scope
>>>>
>>>> v3->v4:
>>>> - shorten the commit message (Dave Jiang)
>>>>
>>>> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>>>>
>>>>   drivers/cxl/core/pci.c | 7 +++++++
>>>>   1 file changed, 7 insertions(+)
>>>>
>>>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>>>> index 9d807c1a002c..d8b07f86bab0 100644
>>>> --- a/drivers/cxl/core/pci.c
>>>> +++ b/drivers/cxl/core/pci.c
>>>> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
>>>>   	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>>>>   		return 0;
>>>>   
>>>> +	/*
>>>> +	 * Decoders emulated from the DVSEC range registers have no commit
>>>> +	 * callback and no HDM decoder registers to consult.
>>>> +	 */
>>>> +	if (!cxld->commit)
>>>> +		return 0;
>>>> +
>>>>   	cxlhdm = dev_get_drvdata(&port->dev);
>>>>   	hdm = cxlhdm->regs.hdm_decoder;
>>>>   	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>>>>
>>>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07
>>>

