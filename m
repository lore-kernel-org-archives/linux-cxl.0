Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40BE324DD17
	for <linux-cxl@vger.kernel.org>; Fri, 14 Aug 2026 03:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786676644; cv=none; b=MZX3fV2y4nhWWWJKmQXIsGx/5uvmDuwsfZcW7q2yf7onzCVO53EbF0YZ6UMgM5Ghxizdp5uWxXF9igflPPoFQytN3l9tlTgqAfFvymsNAjqna8OQharGoFl+5F+AzIO+xj+psuxNBHhK/SU8/EAIMdMiOH9hDTcAjHhFPXkhgho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786676644; c=relaxed/simple;
	bh=hzKf0SadYdcZ4Mpt6BKWkGVYJ8d4It5Yhy1T9EHjUvI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kAfWATQ+m5RLsV09JqSA0eDHrrrlDp+MOInXcngwybbqYP7IhrpUJqsTvCRLA6UafWGEVQnkCmPU8dR/9fK/HWYEEsGt/Y9J1DyO6lFVFOF18fOXbXrRkELBtvbVef0CVkU7i8Kkt2rT0vL9X3ydUx9of6+nBJ/GRYUwcbCHazM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=myzBXODz; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="myzBXODz"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1786676633; h=Message-ID:Date:MIME-Version:Subject:From:To:Content-Type;
	bh=jDz9LEtGW3q8TP4trcW+pyFnntTzVvPtTA8IPSRhK44=;
	b=myzBXODze8rYzUbv32GmrmZnjG3aqNAPZ8I7dZ+sPeVr9nI1GICwXUJoh/2DBoVR7Mc7yLyZXkMJKV7kn7mSBtLhkt0cTzwUNOLrqOz5wKbeLWbXFiHq3Bj81/rdSz93tQX8ms6LXO77+NmrJ36XkynARCV++Tq6lPr10pIzxE0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam011083073210;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0X8vurCC_1786676631;
Received: from 30.178.84.14(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X8vurCC_1786676631 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 14 Aug 2026 11:03:52 +0800
Message-ID: <eceddb86-7f51-4257-a258-b9ecf1711458@linux.alibaba.com>
Date: Fri, 14 Aug 2026 11:03:50 +0800
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
From: Guixin Liu <kanie@linux.alibaba.com>
To: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260812082347.354371-1-kanie@linux.alibaba.com>
In-Reply-To: <20260812082347.354371-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Looks like this patch is omitted.

Best Regards,
Guixin Liu


在 2026/8/12 16:23, Guixin Liu 写道:
> After an FLR or an SBR, cxl_reset_done() walks the endpoint's decoders and
> asks __cxl_endpoint_decoder_reset_detected() whether any of them lost its
> committed state. That helper filters on CXL_DECODER_F_ENABLE and then
> samples the Committed bit in the HDM decoder control register at
> cxlhdm->regs.hdm_decoder.
>
> The HDM decoder registers are not always where an enabled decoder's state
> lives. A memory device may describe its ranges through the CXL DVSEC range
> registers instead, and should_emulate_decoders() picks that path in two
> situations: when the component registers expose no HDM decoder capability
> at all, and when the capability exists but firmware left Mem_Enable set
> with the global HDM decoder enable bit clear.
> cxl_setup_hdm_decoder_from_dvsec() publishes the emulated decoders with
> CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK set, so they pass the filter,
> and it leaves cxld->commit NULL because there is no register to commit to.
>
> In the first situation regs.hdm_decoder is NULL and the readl() oopses in
> the PCI reset completion path. In the second the pointer is valid but the
> registers are unused, so the Committed bit reads zero and the helper
> reports a reset that did not happen: cxl_reset_done() prints two dev_crit
> lines about an SBR wiping active decoders, taints the kernel, and strips
> CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK from every endpoint decoder.
> Losing the lock flag is the more consequential half of that, because it is
> what keeps the emulated ranges from being treated as reprogrammable while
> the driver still cannot change the range registers at run time.
>
> Skip the check when cxld->commit is NULL. Only
> cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, and
> init_hdm_decoder() installs cxl_decoder_commit() on every decoder that
> does come from the registers, so one test covers both emulation paths and
> no separate test for the NULL register pointer is needed. A range
> described by the DVSEC registers has no Committed bit for a reset to
> clear, so there is nothing here for the post-reset warning to observe.
>
> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---
> This was patch 4/8 of the "cxl: Assorted fixes" series [1]. Per review
> feedback that series is not being reworked as a whole; the fixes are resent
> individually instead.
>
> v2 tested cxlhdm->regs.hdm_decoder for NULL. That test turns out to be
> subsumed by the commit callback test rather than complementary to it: on
> the endpoint path info is never NULL, since
> devm_cxl_endpoint_decoders_setup() passes the address of an on-stack struct
> to both devm_cxl_setup_hdm() and devm_cxl_enumerate_decoders(). A NULL
> regs.hdm_decoder can therefore only come from the "no component registers"
> early return in devm_cxl_setup_hdm(), which requires info->mem_enabled,
> and should_emulate_decoders() then emulates every decoder on the port.
> Keeping both tests would leave one that cannot be reached today, so only
> the commit test is here - say the word if you would rather have the NULL
> test back as a guard on that invariant.
>
> The Sashiko review bot raised two further pre-existing concerns on v2 that
> this patch does not address, since both are about the reset handler's
> synchronisation rather than about which registers it reads:
>
> - cxl_reset_done() holds only the memdev device lock, so nothing excludes
>    an unbind of the cxl_port driver from the endpoint port, which frees the
>    devm allocated cxl_hdm while dev_get_drvdata(&port->dev) keeps returning
>    it. An unbind that has completed is harmless: devres frees the decoders
>    before the cxl_hdm allocation that predates them, so the child walk finds
>    nothing to look at. What is left is the interleaving where the walk has
>    already taken its reference on a decoder, which keeps that device alive
>    past device_del(), and the unbind reaches the cxl_hdm free first. Narrow,
>    and the fix is not local: it means deciding how the PCI error handlers
>    should exclude the port driver's binding.
>
> - cxld->flags is updated with a plain read-modify-write in
>    cxl_endpoint_decoder_clear_reset_flags(), while cxl_decoder_commit() and
>    cxl_decoder_reset() update the same word under cxl_rwsem.region, which
>    __commit() and the region reset paths hold across those calls. Having the
>    reset handler take that rwsem too looks like the natural fix, but it
>    already holds the memdev device lock at that point, so the lock ordering
>    wants review first.
>
> Both look worth doing on their own; happy to follow up with separate
> patches if that is the preference.
>
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>    the code change (Alison Schofield)
>
> v2->v3:
> - test cxld->commit instead of cxlhdm->regs.hdm_decoder, so that decoders
>    emulated from the DVSEC ranges are also skipped when the HDM decoder
>    registers exist but are globally disabled (Richard Cheng)
> - update the subject and the commit message for the widened scope
>
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
>
>   drivers/cxl/core/pci.c | 7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..d8b07f86bab0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
>   	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>   		return 0;
>   
> +	/*
> +	 * Decoders emulated from the DVSEC range registers have no commit
> +	 * callback and no HDM decoder registers to consult.
> +	 */
> +	if (!cxld->commit)
> +		return 0;
> +
>   	cxlhdm = dev_get_drvdata(&port->dev);
>   	hdm = cxlhdm->regs.hdm_decoder;
>   	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
>
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

