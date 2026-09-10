Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB33909BF
	for <linux-cxl@vger.kernel.org>; Thu, 10 Sep 2026 08:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789029183; cv=none; b=K9tW6csoD0BFuJKZCfrGizheriasuMAVQhVelyfv7jaVAUCC5S9zp9QcO4PtVq0H+l4VB7e46c45+qRcTH3jslAChnnhJ80rPbTqAdOklMti0Zc46TyazIVy5uUZiD6+Wv0qxbDPwQiYxhFLUEDMkbzhWT3lw2oWaKqULEd5nGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789029183; c=relaxed/simple;
	bh=h3B6sjM3AZP0jiIhc3HoebOv/ZrOxBtQU609xGJ46+w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Kr5bwGjLi0VkBxe+tC8NwgbpYERsf71d+lLD4168YuyB89QAk5AZgkoS4bXAn6ZsjJJ4uPjoMsf6gTcRA3YWiXeH4WT81jjE/2WwYC8S6kE3vdWEofmYcp06vNXvMBQNhdAqbawqTXWaQW38hsi4zGocQUWmsOuXnAazp5Yy2hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=l9A/PWLc; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="l9A/PWLc"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1789029178; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=dyVp4FLJ7AdL3qU2GgA7iAlwbmLMSb61uuy3Ygn6hck=;
	b=l9A/PWLcv6KPCPASTlNW1ICEuJ9cQ/jqAUzlSSQLF+kMe2WYk0ugcugEgMbDW9vXSaNHlAExM56i69uKHIPZL50uATrfZVQgRzXTIJwdcmY+/4KmRBXkQPKjwH5D+UNmyTGtsJk6FlrzEIW1TmM7N1vWNFZqC60A8dH51tV60Us=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037026112;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XAgyhSu_1789029176;
Received: from 30.178.66.249(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XAgyhSu_1789029176 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 10 Sep 2026 16:32:57 +0800
Message-ID: <96159fb0-80dd-43b4-ab71-db6c9a0fec9e@linux.alibaba.com>
Date: Thu, 10 Sep 2026 16:32:56 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260831110449.719086-1-kanie@linux.alibaba.com>
 <ec6c61c3-5c28-40c4-be86-4e6ee90bb2eb@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <ec6c61c3-5c28-40c4-be86-4e6ee90bb2eb@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/9/10 00:21, Dave Jiang 写道:
>
> On 8/31/26 4:04 AM, Guixin Liu wrote:
>> HDM decoders are emulated from the DVSEC range registers in two cases:
>> (a) the component registers expose no HDM decoder capability, or (b) the
>> capability is present but the DVSEC ranges were the ones in use at driver
>> load.
>>
>> After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() reads the HDM
>> decoder Committed bit for every decoder marked enabled, emulated ones
>> included. In case (a) regs.hdm_decoder is NULL and the read oopses. In case
>> (b) the Committed bit was never set, so a reset gets reported that never
>> happened.
>>
>> Use the absence of cxld->commit to elide the check for emulated decoders.
>>
>> Case (b) tested under QEMU: a reset on an endpoint driven down the DVSEC
>> emulation path no longer reports a reset or strips the decoder flags.
>>
>> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
>> ---
>> This was patch 4/8 of the "cxl: Assorted fixes" series [1], resent
>> individually per review feedback.
>>
>> The two synchronisation concerns the review bot raised on v2 - the missing
>> exclusion against a cxl_port unbind freeing the devm allocated cxl_hdm, and
>> the plain read-modify-write of cxld->flags in
>> cxl_endpoint_decoder_clear_reset_flags() while the region paths update the
>> same word under cxl_rwsem.region - are still untouched here. Both are
>> about the reset handler's locking rather than about which registers it
>> reads, and neither fix is local; happy to follow up with separate patches.
>>
>> Testing
>>
>> Reaching case (b) needs an endpoint whose DVSEC ranges are live while the
>> global HDM decoder enable is clear. Unbinding cxl_pci runs the
>> disable_hdm() and clear_mem_enable() devm actions, so both bits start
>> clean. setpci then programs DVSEC Range 1 Base to 0x890000000, which sits
>> inside a RAM capable CFMWS, and sets Mem_Enable. Rebinding takes the
>> emulation path:
>>
>>    cxl_port endpoint3: Fallback map 1 range register
>>    cxl_pci 0000:35:00.0: DVSEC Range0 allowed by platform
>>
>> The endpoint ends up with a single decoder, enabled and locked, with no
>> Committed bit behind it:
>>
>>    decoder3.0: locked=1 start=0x890000000 size=0x100000000 mode=ram
>>
>> The device's only available reset method is cxl_bus, which unmasks SBR
>> through the port DVSEC. Before this change:
>>
>>    cxl_pci 0000:35:00.0: resetting
>>    cxl_pci 0000:35:00.0: SBR happened without memory regions removal.
>>    cxl_pci 0000:35:00.0: System may be unstable if regions hosted system memory.
>>
>> /proc/sys/kernel/tainted picked up TAINT_USER (8192 -> 8256) and locked
>> dropped from 1 to 0. After this change the same reset logs only
>> "resetting", locked stays 1, and no taint is added. The decoder is
>> decoder6.0 in the second run because reloading cxl_core renumbered the
>> memdevs.
>>
>> QEMU does not clear the DVSEC range registers on SBR, so the emulated
>> decode is still fully programmed by the time the reset completes. The old
>> report was spurious here too.
>>
>> Not covered: case (a) needs an endpoint with no component register block,
>> which QEMU's type3 always provides, and the FLR variant needs FLR support
>> that QEMU's type3 does not advertise (FLReset-). I also did not run a
>> positive control confirming that a normally committed HDM decoder is still
>> detected after this change.
>>
>> v1->v2:
>> - rebase onto cxl/next
>> - rewrite the commit message to describe the behaviour rather than narrate
>>    the code change (Alison Schofield)
>>
>> v2->v3:
>> - test cxld->commit instead of cxlhdm->regs.hdm_decoder, so that decoders
>>    emulated from the DVSEC ranges are also skipped when the HDM decoder
>>    registers exist but are globally disabled (Richard Cheng)
>> - update the subject and the commit message for the widened scope
>>
>> v3->v4:
>> - shorten the commit message (Dave Jiang)
>>
>> v4->v5:
>> - condense the commit message further, wording taken from Jonathan
>>    Cameron's suggestion on v4
>> - note the case (b) test in the commit message
>>
>> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>>
>>   drivers/cxl/core/pci.c | 7 +++++++
>>   1 file changed, 7 insertions(+)
>>
>> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
>> index 9d807c1a002c..d8b07f86bab0 100644
>> --- a/drivers/cxl/core/pci.c
>> +++ b/drivers/cxl/core/pci.c
>> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
>>   	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>>   		return 0;
>>   
>> +	/*
>> +	 * Decoders emulated from the DVSEC range registers have no commit
>> +	 * callback and no HDM decoder registers to consult.
>> +	 */
>> +	if (!cxld->commit)
>> +		return 0;
> Do we want a warning here given that if SBR is issued and we end up skipping? I think this is the issue sashiko raised.
>
> DJ
Sure, Added in v6.

Best Regards,
Guixin Liu
>
>> +
>>   	cxlhdm = dev_get_drvdata(&port->dev);
>>   	hdm = cxlhdm->regs.hdm_decoder;
>>   	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>>
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

