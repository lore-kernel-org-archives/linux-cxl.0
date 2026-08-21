Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC47199FB0
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 22:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787351593; cv=none; b=VonvJIZBgOxTsSfZ7XRe2wa8d/9txkWGDeLo+MqheDr5GOZqsTycZwlupS+4ofuRXf8wswry0Fu0ZBHEq6R7fKWbFyOUYiWmrtUaqymj4sI/aLZsBQiU7XAkHkxMfQyQK4Zma/RbYsXTK4DFsbkb1V8pgqLe/mVn9LAQ8F3CRB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787351593; c=relaxed/simple;
	bh=z52v7mcApiyybcrXRoRzZfyVcd+b3yNo9eVk03mBHWc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nyZKxYmUk1gVlGs9ENkw3hruND5ls83TH4Etx9NlZoXbTpXy7grH+dt7c8TVD3Kb/ryw0Tpo5fumC4lQWRZr7IbdulU6zv6I3JX68JX57Ka4szhZMqCizOGFU3KbhDTJhPlwDCcSDU1fHeX+zR4rHVA9wi7DUVvWrWVaNceFhK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zrebur1Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zrebur1Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26EAB1F000E9;
	Fri, 21 Aug 2026 22:33:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787351591;
	bh=RAkGoRL+C49/Pvylfhhz6/vglk/CBae1lCRt++fcDik=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Zrebur1YUw87kKuO/o3Bfmm6RIW1yBVDOyaXi+oY9hOHctg6G7+WSe63Q7dqoWjXk
	 Q1/WrLAPdiCaf3c7PQjGpUhMv6n8pvutqpVkRQh3pf1lJB26Auwkyx5+KFxjPt8Gv0
	 RAOxJE/1UhvmKDuBcuc5Pp/u5LY72btXLnemUKpjcjd/ulSGMCM3OTKtcikf/UBveU
	 KAZEYj8KzBnRhsXBw1nqHFTtYImXqVSyCkO+I04DX1S9P630ciiWY4NUNa5nmCreaz
	 6cdDolVz1ss0T+kCsBoXZQKGwMYfPtf6AOoVPalnjxiIDi7esjhTLhOZVr0hCNONlp
	 xvWKuOx9zsyJg==
Date: Fri, 21 Aug 2026 23:33:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Guixin Liu <kanie@linux.alibaba.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>, Vishal Verma
 <vishal.l.verma@intel.com>, Dan Williams <djbw@kernel.org>, Ira Weiny
 <iweiny@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4] cxl/pci: Skip reset detection for DVSEC emulated
 decoders
Message-ID: <20260821233305.32d77d60@jic23-huawei>
In-Reply-To: <20260821021029.2550584-1-kanie@linux.alibaba.com>
References: <20260821021029.2550584-1-kanie@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 10:10:29 +0800
Guixin Liu <kanie@linux.alibaba.com> wrote:

> After an FLR or SBR, __cxl_endpoint_decoder_reset_detected() samples the
> Committed bit at cxlhdm->regs.hdm_decoder for every decoder that has
> CXL_DECODER_F_ENABLE set. Decoders emulated from the CXL DVSEC range
> registers carry that flag too, but their state does not live in the HDM
> decoder registers. When the component registers expose no HDM decoder
> capability, regs.hdm_decoder is NULL and the readl() oopses in the reset
> completion path. When the capability is present but firmware left
> Mem_Enable set with the global HDM decoder enable clear, the Committed bit
> reads zero and cxl_reset_done() reports a reset that never happened: it
> taints the kernel and strips CXL_DECODER_F_ENABLE and CXL_DECODER_F_LOCK
> from every endpoint decoder, even though the driver still cannot reprogram
> the DVSEC ranges.
> 
> Skip the check when cxld->commit is NULL. Only
> cxl_setup_hdm_decoder_from_dvsec() leaves that callback unset, so that one
> test covers both emulation paths, and a DVSEC-described range has no
> Committed bit for a reset to clear.
> 
This is still a lot of text to read - I'll have stab an what I think would be sufficient.
Take this perhaps as inspiration, not a precise suggestion!

When HDM decoders are emulated from DVSEC range registers either (a) there are
no HDM decoder registers present or (b) the DVSEC registers were in use at driver
load.

After FLR or SBR, __cxl_endpoint_decoder_reset_detected() checks the HDM
decoder committed bit for any previously committed decoders. This includes
emulated decoders: (a) results in a NULL pointer dereference, (b) in a false
detection of reset when they are present and not in use as the committed bit
was never set.

Use absence of cxld->commit to elide the reset check for emulated decoders.

> Fixes: 934edcd436dc ("cxl: Add post-reset warning if reset results in loss of previously committed HDM decoders")
> Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>

This does make me wonder if we should be doing something similar to check
the dvsec based decoding reset.  The memory_base_high should reset to 0
for example.

Can we actually do anything with such devices?  Not sure we can today.
That is not a reason to crash however so this fix still makes sense.

Jonathan

> ---
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

