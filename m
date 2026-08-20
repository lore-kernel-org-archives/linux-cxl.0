Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B20B47A879
	for <linux-cxl@vger.kernel.org>; Thu, 20 Aug 2026 16:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787241634; cv=none; b=NEapG7LkJhnav7ZYWRueP6ar4tbToS6Ax8NlLRSYI5uotHpcYcdv3JCIC9HT6FW0zCbY3nN5eTwn0aGahVpTQ5HH+CAo/x4SB1vNfUGZIYhw4LuaE9Sq+DqOiqiPOkeX5qsFY0gdiApWtOjH43kEhT3V34bc4bJcOiWvkriXo5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787241634; c=relaxed/simple;
	bh=Ac0FdjTLeNfGyBdc0qc+TaXGUj1zpCZ4axlhPNzdKmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PVMi+5tBBvYYP7Gh/0C1j8/agfjL5yP3PR5uutQcdbTKncEBH8Ljbgtp4PRMAsOBclY1NSP6/wdnk+XfghusnyZX7bb8cYcAHVrpOy200zyRoa0Vkm6L/tFkqZ+JMG88k0gf108YwpOmaUXrD/e/LNz0zslurQXD6RZ7dnB9Duc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XCB+TrRw; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XCB+TrRw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787241634; x=1818777634;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Ac0FdjTLeNfGyBdc0qc+TaXGUj1zpCZ4axlhPNzdKmU=;
  b=XCB+TrRwar32vmqZAfuQJDO8Qt/AbxSDLweZ8U54O/TF7E4sa5yR2VgS
   Rl0fVcJRqfcq8932KntM0EYdwMBGnKTwxNlRpAdA3kFW7V1H1hF5b1USS
   GumJ0iEWKthkKTrGK4iVoLlu2I0O1p2P8c3I5POOAkuZswqGli1iTvmF3
   DujieUrEFy+0ZVFYjD1OHz+P0u3Yg4hYJMyc3Fto5Q8IzbjUW+o4E0Njv
   74acbibcR5l2GQiYMO0wVO1uhe7xCfOo7C87LgVzDLusbw2nDt/+Jr4Wr
   6SWBqxOZJsR0Qx1MRrMkTnYJrbC507ydBajL/yuGmmNclyQooPUEoyCJW
   Q==;
X-CSE-ConnectionGUID: BYCf9KizQPiPozV9o2j38w==
X-CSE-MsgGUID: IIjnlpVHSTSCYfcqHurhtQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="110569625"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="110569625"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:00:33 -0700
X-CSE-ConnectionGUID: STznI3N2QWifbXpKQB0ZcQ==
X-CSE-MsgGUID: mOYnd5O7TCuxB70yq5y5Xg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; 
   d="scan'208";a="266697668"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.108.63]) ([10.125.108.63])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2026 09:00:32 -0700
Message-ID: <7d1c81ba-b8ed-48d6-bc3b-4ebe7c8d88cf@intel.com>
Date: Thu, 20 Aug 2026 09:00:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260812082347.354371-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260812082347.354371-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/12/26 1:23 AM, Guixin Liu wrote:
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

This is a really long commit log for the code change. Does this look better to you?

    After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() samples the
    committed bit at cxlhdm->regs.hdm_decoder for every decoder that has
    CXL_DECODER_F_ENABLE set. Decoders emulated from the CXL DVSEC range
    registers carry that flag too, but their state does not live in the HDM
    decoder registers. When the component registers expose no HDM decoder
    capability, regs.hdm_decoder is NULL and the readl() oopses in the reset
    completion path. When the capability exists but is unused, the committed
    bit reads zero and cxl_reset_done() reports a reset that never happened:
    it taints the kernel and strips CXL_DECODER_F_ENABLE and
    CXL_DECODER_F_LOCK from every endpoint decoder, even though the driver
    still cannot reprogram the DVSEC ranges.

    Skip the check when cxld->commit is NULL. Only
    cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, so the one
    test covers both emulation paths, and a DVSEC-described range has no
    committed bit for a reset to clear.

DJ

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
>   an unbind of the cxl_port driver from the endpoint port, which frees the
>   devm allocated cxl_hdm while dev_get_drvdata(&port->dev) keeps returning
>   it. An unbind that has completed is harmless: devres frees the decoders
>   before the cxl_hdm allocation that predates them, so the child walk finds
>   nothing to look at. What is left is the interleaving where the walk has
>   already taken its reference on a decoder, which keeps that device alive
>   past device_del(), and the unbind reaches the cxl_hdm free first. Narrow,
>   and the fix is not local: it means deciding how the PCI error handlers
>   should exclude the port driver's binding.
> 
> - cxld->flags is updated with a plain read-modify-write in
>   cxl_endpoint_decoder_clear_reset_flags(), while cxl_decoder_commit() and
>   cxl_decoder_reset() update the same word under cxl_rwsem.region, which
>   __commit() and the region reset paths hold across those calls. Having the
>   reset handler take that rwsem too looks like the natural fix, but it
>   already holds the memdev device lock at that point, so the lock ordering
>   wants review first.
> 
> Both look worth doing on their own; happy to follow up with separate
> patches if that is the preference.
> 
> v1->v2:
> - rebase onto cxl/next
> - rewrite the commit message to describe the behaviour rather than narrate
>   the code change (Alison Schofield)
> 
> v2->v3:
> - test cxld->commit instead of cxlhdm->regs.hdm_decoder, so that decoders
>   emulated from the DVSEC ranges are also skipped when the HDM decoder
>   registers exist but are globally disabled (Richard Cheng)
> - update the subject and the commit message for the widened scope
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/pci.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..d8b07f86bab0 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -683,6 +683,13 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return 0;
>  
> +	/*
> +	 * Decoders emulated from the DVSEC range registers have no commit
> +	 * callback and no HDM decoder registers to consult.
> +	 */
> +	if (!cxld->commit)
> +		return 0;
> +
>  	cxlhdm = dev_get_drvdata(&port->dev);
>  	hdm = cxlhdm->regs.hdm_decoder;
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> 
> base-commit: 7098e9cd98a05c0c5de2fae0c2465f9d966fdd07

