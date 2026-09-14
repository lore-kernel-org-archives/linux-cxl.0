Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB47B2E7379
	for <linux-cxl@vger.kernel.org>; Mon, 14 Sep 2026 21:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789419848; cv=none; b=Y6uaFIJ8L/4Xog3BE0mGbRZghZSMVqgRR/8k6uie9lVFU7cghUn6+z58PPa9PYc0xOmOIZEN766eyBRHVMGWxY0crlc1/Qh13FmQfUxo2iFmCO/DIS4wFY/3Tnl53oiaxnqTDe7VfaYoNm2ZHcB/CYB8zt8osCST7NMWmWo/PzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789419848; c=relaxed/simple;
	bh=xnv86VhThlrQcvxWPqg8Y+P40gXUXoLy2AdYcF0ijwk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DiS5pM5z3RlHbcRj2CX4wpIKuHlb+a8UrS3ZC20sxZCbCMHJvqbqod2eZOodzmo0aVv1J9ss+yBG5gILzOJQxMq5H2oYa6JKwVpa/tmuYmrviOKWZDpt/aZ/lgwtrcepL3Mimzw4c4g0BFl9B7FrHa8jW3FqZNHykNFN9aDhV84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaVyukPg; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaVyukPg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789419847; x=1820955847;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xnv86VhThlrQcvxWPqg8Y+P40gXUXoLy2AdYcF0ijwk=;
  b=SaVyukPgHK+rAIgI+Eag5yAhNKuq4zKEJmxMh1fadnyMjhAPR3+fCVbY
   aQFxlwBiYWydP3JsecPK6tdsxCDpHg0prmDtOnJQfGGShkWRfeRr8hk9x
   x/mclPE7xRguW1rT18/qymJtbfY5lr591JvrbZbGg8O1IfTFTTwJtZlmH
   QzAibLENU6pw8tch0RRiMxW1cJWRADqRsju7HmpzKyomkOXgDbwAFoeBH
   I9Q3IUOtZoG2iAN3eWAHvDEKBeU+vwFxvBLx/gQLyLBeJAc2dj+mB9gb1
   Ztj53ZtXornYeMcdlcLTkUlSTQBBO6BY8lEZjIvW2CwYH1m1qBtKHultB
   g==;
X-CSE-ConnectionGUID: LHB6w9H1QV2ixiPgAcb9rQ==
X-CSE-MsgGUID: TrFWnjDHSeqTnIB/COv3Lw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88718053"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88718053"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:04:06 -0700
X-CSE-ConnectionGUID: NI+E2ctUTjOPPnPi8t2w1g==
X-CSE-MsgGUID: +3QfQ3tCSpeM9VmQA5sPww==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="273268290"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.108.142]) ([10.125.108.142])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Sep 2026 14:04:05 -0700
Message-ID: <70e19ff3-37bc-4068-b7d2-9aeae3b9a754@intel.com>
Date: Mon, 14 Sep 2026 14:04:04 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
To: Guixin Liu <kanie@linux.alibaba.com>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>,
 Ira Weiny <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260910082141.3908416-1-kanie@linux.alibaba.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260910082141.3908416-1-kanie@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 9/10/26 1:21 AM, Guixin Liu wrote:
> HDM decoders are emulated from the DVSEC range registers in two cases:
> (a) the component registers expose no HDM decoder capability, or (b) the
> capability is present but the DVSEC ranges were the ones in use at driver
> load.
> 
> After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() reads the HDM
> decoder Committed bit for every decoder marked enabled, emulated ones
> included. In case (a) regs.hdm_decoder is NULL and the read oopses. In case
> (b) the Committed bit was never set, so a reset gets reported that never
> happened.
> 
> Use the absence of cxld->commit to elide the check for emulated decoders.
> Warn when doing so: the DVSEC range registers are non-sticky, so a reset
> may have cleared the decode and, with no Committed bit to read, the loss
> cannot be detected here.
> 
> Case (b) tested under QEMU: a reset on an endpoint driven down the DVSEC
> emulation path no longer reports a reset or strips the decoder flags.
> 
> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
> ---

I reapplied the change with the printk to cxl/next.
ddcce1734d11

> This was patch 4/8 of the "cxl: Assorted fixes" series [1], resent
> individually per review feedback.
> 
> The two synchronisation concerns the review bot raised on v2 - the missing
> exclusion against a cxl_port unbind freeing the devm allocated cxl_hdm, and
> the plain read-modify-write of cxld->flags in
> cxl_endpoint_decoder_clear_reset_flags() while the region paths update the
> same word under cxl_rwsem.region - are still untouched here. Both are
> about the reset handler's locking rather than about which registers it
> reads, and neither fix is local; happy to follow up with separate patches.
> 
> Testing
> 
> Reaching case (b) needs an endpoint whose DVSEC ranges are live while the
> global HDM decoder enable is clear. Unbinding cxl_pci runs the
> disable_hdm() and clear_mem_enable() devm actions, so both bits start
> clean. setpci then programs DVSEC Range 1 Base to 0x890000000, which sits
> inside a RAM capable CFMWS, and sets Mem_Enable. Rebinding takes the
> emulation path:
> 
>   cxl_port endpoint3: Fallback map 1 range register
>   cxl_pci 0000:35:00.0: DVSEC Range0 allowed by platform
> 
> The endpoint ends up with a single decoder, enabled and locked, with no
> Committed bit behind it:
> 
>   decoder3.0: locked=1 start=0x890000000 size=0x100000000 mode=ram
> 
> The device's only available reset method is cxl_bus, which unmasks SBR
> through the port DVSEC. Before this change:
> 
>   cxl_pci 0000:35:00.0: resetting
>   cxl_pci 0000:35:00.0: SBR happened without memory regions removal.
>   cxl_pci 0000:35:00.0: System may be unstable if regions hosted system memory.
> 
> /proc/sys/kernel/tainted picked up TAINT_USER (8192 -> 8256) and locked
> dropped from 1 to 0. After this change the same reset logs only
> "resetting", locked stays 1, and no taint is added. The decoder is
> decoder6.0 in the second run because reloading cxl_core renumbered the
> memdevs.
> 
> QEMU does not clear the DVSEC range registers on SBR, so the emulated
> decode is still fully programmed by the time the reset completes. The old
> report was spurious here too.
> 
> Not covered: case (a) needs an endpoint with no component register block,
> which QEMU's type3 always provides, and the FLR variant needs FLR support
> that QEMU's type3 does not advertise (FLReset-). I also did not run a
> positive control confirming that a normally committed HDM decoder is still
> detected after this change. The QEMU run above predates the v6 warning:
> the warning fires on the skip path that run exercises, but it has not been
> observed directly.
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
> v3->v4:
> - shorten the commit message (Dave Jiang)
> 
> v4->v5:
> - condense the commit message further, wording taken from Jonathan
>   Cameron's suggestion on v4
> - note the case (b) test in the commit message
> 
> v5->v6:
> - rebase onto master, per Dave's request to send patches against master
>   rather than cxl/next
> - warn when the check is skipped, as the DVSEC range registers are
>   non-sticky and a reset may have cleared the emulated decode (Dave Jiang)
> 
> [1] https://lore.kernel.org/linux-cxl/20260811113608.2815625-1-kanie@linux.alibaba.com/
> 
>  drivers/cxl/core/pci.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 9d807c1a002c..03dae6b701a4 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -683,6 +683,16 @@ static int __cxl_endpoint_decoder_reset_detected(struct device *dev, void *data)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return 0;
>  
> +	/*
> +	 * Decoders emulated from the DVSEC range registers have no commit
> +	 * callback and no HDM decoder registers to consult, so a reset
> +	 * that cleared the non-sticky range registers cannot be detected.
> +	 */
> +	if (!cxld->commit) {
> +		dev_warn(dev, "DVSEC emulated decode may have been cleared by reset\n");
> +		return 0;
> +	}
> +
>  	cxlhdm = dev_get_drvdata(&port->dev);
>  	hdm = cxlhdm->regs.hdm_decoder;
>  	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> 
> base-commit: 50d05c7c76c96b90462f24debacca971d2e86713

