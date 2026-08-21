Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65970282F1E
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 02:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787277906; cv=none; b=Gw8mMZXXsa5E0LEWm4+FgndKEyjMe10jGXG8g2O1Hw4f59BAc5K7F9CpfsFqHxQVRX23OzoMyicu2Nt98i6n9hJih+sSxeguMS7JpKXZYDFQlmNjSLj8RNNKxYg9Lvz8EO4HdoSPIxfVq6z9p7cv+Ja6S2lxzUMnyMGo9KgO3KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787277906; c=relaxed/simple;
	bh=0jDaNaeXl7nkjE+CqSs/0EO3A29KJqZd3biaTDoMkag=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nOIt56TkLCVrddN5yC+Psmhxckj885q9VfwaTiPfHW4C83ORRdVkZ6OnBjQ+NYjw0qypnghlJnbxQoEnbdP2IGJBR/RZt3QdFng1PaBfz75IEzR26OqPj/0UN7nbAo+7bRs/bl+CHzQciFXKuEpAkLROM7/e8rkrmJGEh16vfmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=oeWsKvgO; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="oeWsKvgO"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787277899; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=YkmNDBdwdVM4+eU5DjF0skMaktrgLPif0tB6W3qLnVs=;
	b=oeWsKvgOaniELQDK8omSJ0s19Hy5Go5Bzh9+qK68SwC4uVlpM+VeeJ2BwHkNlkhDDI5V257qHFN1unHwhBGxpfxCPwJlJczKbQqqSK6oTa9QOkDEaodey+cXsBmFSUg4Utcy0VMFpbUJBqEdB6i8m44MMLCg4eWR2SCeJm2Qsxc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R311e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0X9Kk8Al_1787277897;
Received: from 30.178.84.62(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X9Kk8Al_1787277897 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 21 Aug 2026 10:04:59 +0800
Message-ID: <cb97eff1-3c2c-434d-97b9-cdf813f69f7c@linux.alibaba.com>
Date: Fri, 21 Aug 2026 10:04:57 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
To: Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260812082347.354371-1-kanie@linux.alibaba.com>
 <7d1c81ba-b8ed-48d6-bc3b-4ebe7c8d88cf@intel.com>
From: Guixin Liu <kanie@linux.alibaba.com>
In-Reply-To: <7d1c81ba-b8ed-48d6-bc3b-4ebe7c8d88cf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



在 2026/8/21 00:00, Dave Jiang 写道:
>
> On 8/12/26 1:23 AM, Guixin Liu wrote:
>> After an FLR or an SBR, cxl_reset_done() walks the endpoint's decoders and
>> asks __cxl_endpoint_decoder_reset_detected() whether any of them lost its
>> committed state. That helper filters on CXL_DECODER_F_ENABLE and then
>> samples the Committed bit in the HDM decoder control register at
>> cxlhdm->regs.hdm_decoder.
>>
>> The HDM decoder registers are not always where an enabled decoder's state
>> lives. A memory device may describe its ranges through the CXL DVSEC range
>> registers instead, and should_emulate_decoders() picks that path in two
>> situations: when the component registers expose no HDM decoder capability
>> at all, and when the capability exists but firmware left Mem_Enable set
>> with the global HDM decoder enable bit clear.
>> cxl_setup_hdm_decoder_from_dvsec() publishes the emulated decoders with
>> CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK set, so they pass the filter,
>> and it leaves cxld->commit NULL because there is no register to commit to.
>>
>> In the first situation regs.hdm_decoder is NULL and the readl() oopses in
>> the PCI reset completion path. In the second the pointer is valid but the
>> registers are unused, so the Committed bit reads zero and the helper
>> reports a reset that did not happen: cxl_reset_done() prints two dev_crit
>> lines about an SBR wiping active decoders, taints the kernel, and strips
>> CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK from every endpoint decoder.
>> Losing the lock flag is the more consequential half of that, because it is
>> what keeps the emulated ranges from being treated as reprogrammable while
>> the driver still cannot change the range registers at run time.
>>
>> Skip the check when cxld->commit is NULL. Only
>> cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, and
>> init_hdm_decoder() installs cxl_decoder_commit() on every decoder that
>> does come from the registers, so one test covers both emulation paths and
>> no separate test for the NULL register pointer is needed. A range
>> described by the DVSEC registers has no Committed bit for a reset to
>> clear, so there is nothing here for the post-reset warning to observe.
> This is a really long commit log for the code change. Does this look better to you?
>
>      After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() samples the
>      committed bit at cxlhdm->regs.hdm_decoder for every decoder that has
>      CXL_DECODER_F_ENABLE set. Decoders emulated from the CXL DVSEC range
>      registers carry that flag too, but their state does not live in the HDM
>      decoder registers. When the component registers expose no HDM decoder
>      capability, regs.hdm_decoder is NULL and the readl() oopses in the reset
>      completion path. When the capability exists but is unused, the committed
"When the capability exists but is unused ",  I think this keep
"firmware left Mem_Enable set with the global HDM decoder enable bit clear"
would be better.

Others looks good to me, thanks, I will send a v4 patch.

Best Regards,
Guixin Liu
>      bit reads zero and cxl_reset_done() reports a reset that never happened:
>      it taints the kernel and strips CXL_DECODER_F_ENABLE and
>      CXL_DECODER_F_LOCK from every endpoint decoder, even though the driver
>      still cannot reprogram the DVSEC ranges.
>
>      Skip the check when cxld->commit is NULL. Only
>      cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, so the one
>      test covers both emulation paths, and a DVSEC-described range has no
>      committed bit for a reset to clear.
>
> DJ
>
>> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
>> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
>> ---
>> This was patch 4/8 of the "cxl: Assorted fixes" series [1]. Per review
>> feedback that series is not being reworked as a whole; the fixes are resent
>> individually instead.
>>
>> v2 tested cxlhdm->regs.hdm_decoder for NULL. That test turns out to be
>> subsumed by the commit callback test rather than complementary to it: on
>> the endpoint path info is never NULL, since
>> devm_cxl_endpoint_decoders_setup() passes the address of an on-stack struct
>> to both devm_cxl_setup_hdm() and devm_cxl_enumerate_decoders(). A NULL
>> regs.hdm_decoder can therefore only come from the "no component registers"
>> early return in devm_cxl_setup_hdm(), which requires info->mem_enabled,
>> and should_emulate_decoders() then emulates every decoder on the port.
>> Keeping both tests would leave one that cannot be reached today, so only
>> the commit test is here - say the word if you would rather have the NULL
>> test back as a guard on that invariant.
>>
>> The Sashiko review bot raised two further pre-existing concerns on v2 that
>> this patch does not address, since both are about the reset handler's
>> synchronisation rather than about which registers it reads:
>>
>> - cxl_reset_done() holds only the memdev device lock, so nothing excludes
>>    an unbind of the cxl_port driver from the endpoint port, which frees the
>>    devm allocated cxl_hdm while dev_get_drvdata(&port->dev) keeps returning
>>    it. An unbind that has completed is harmless: devres frees the decoders
>>    before the cxl_hdm allocation that predates them, so the child walk finds
>>    nothing to look at. What is left is the interleaving where the walk has
>>    already taken its reference on a decoder, which keeps that device alive
>>    past device_del(), and the unbind reaches the cxl_hdm free first. Narrow,
>>    and the fix is not local: it means deciding how the PCI error handlers
>>    should exclude the port driver's binding.
>>
>> - cxld->flags is updated with a plain read-modify-write in
>>    cxl_endpoint_decoder_clear_reset_flags(), while cxl_decoder_commit() and
>>    cxl_decoder_reset() update the same word under cxl_rwsem.region, which
>>    __commit() and the region reset paths hold across those calls. Having the
>>    reset handler take that rwsem too looks like the natural fix, but it
>>    already holds the memdev device lock at that point, so the lock ordering
>>    wants review first.
>>
>> Both look worth doing on their own; happy to follow up with separate
>> patches if that is the preference.
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
>> +
>>   	cxlhdm = dev_get_drvdata(&port->dev);
>>   	hdm = cxlhdm->regs.hdm_decoder;
>>   	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>>
>> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

