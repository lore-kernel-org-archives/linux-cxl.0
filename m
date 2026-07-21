Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF78471257
	for <linux-cxl@vger.kernel.org>; Tue, 21 Jul 2026 18:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784657064; cv=none; b=nhBrycET2NmigPTqjF/lYTxRCwgxH4hccyqwAsGKoGYW7Y21mp8tuuwzZgC2UQP2CreqDV5dli8siF7Mhrw608Bpey+cHp0xzlbfHGC30El5J1b4kv53rmVU0M581rr6c9SEjtx1WogiXEysN+N37fg+HoN89aoFx2JP7JyJ6yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784657064; c=relaxed/simple;
	bh=siTHOkEhSCyUYCM5lVN/0fllfYiLQMn2Gvdzs5sBD7c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUl+PdkXTsN+FNj+1o9Gq/ygZ9ChmFTqzZTA2eCTtfMZqvmY+jQOi9q25zp/+WfQt8QmgUItQCEjbuuNtP7Sujfh2Ux9SrXvDcBxIy09uAixjTfp87g6m+9rKrzjY65LOklX8SKfK6DQVCny8jSSUwBICLVA+ylawHPFzX+oc8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kdaE3vil; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kdaE3vil"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC591F00A3A;
	Tue, 21 Jul 2026 18:04:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784657062;
	bh=03sdSpPOjmKX3OzS7svij6IL1jc3WOas+OtdlMhdPBY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kdaE3vilnDyqmubQdgIwN3Y9RporqaRuXKhq230/1KyQuGdbYaG2IFhKeXqHLl4S+
	 dND2DMFhBLn7PyZTiPKv/sZAUVJ731J1MOdQqi1JzVrq33ISDgEGgsiGMOigKr+rW3
	 H0jFNyS/aB1VEDbiQJoyervpzjxaIBPbeij1xnwf4Mo1SIcspYHJMIyep8CBAwBLzQ
	 3tQh+7hmY8Bo6fG8rQIxOv7kf4BZ1HwvYE/sBU8618VRtvqJfeUqeWnfSH/o6qQijq
	 he13fLa3ECMW7eG9e2+4GLRUGjH/wt630QfXMBiDy8MvR9mAdDalzT0uHzDVmPeSvi
	 Bw5sC708fADPA==
Date: Tue, 21 Jul 2026 19:04:16 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Dan
 Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 linux-cxl@vger.kernel.org, Srirangan Madhavan <smadhavan@nvidia.com>
Subject: Re: [PATCH v3 1/3] cxl/hdm: Reject switch decoder interleave ways
 that overflow targets
Message-ID: <20260721190416.096286a9@jic23-huawei>
In-Reply-To: <de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
References: <cover.1784322343.git.alison.schofield@intel.com>
	<de61a8143c7de391f8463003d87a3845496f4af3.1784322343.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 17 Jul 2026 14:42:46 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Switch decoder enumeration validates that the interleave ways encoding
> is legal, but not that the resulting number of ways fits the available
> targets. This can overrun the target arrays during enumeration.
> 
> Reject committed decoders whose interleave ways exceed either the
> hardware target list capacity or the reported target count. Reject
> switch decoders that report zero targets.
> 
> For uncommitted decoders, ignore the stale interleave ways value and
> reset it to one until the decoder is committed.

Note on this below.  Why 1?  If it is invalid can we use a nonsense
value like 0 so that any use of it will cause an obvious bug and
make it easy to spot? (hopefully)

> 
> Add a clarifying comment that target_count is a direct count, not
> 0-based like decoder_count.
> 
> Link: https://sashiko.dev/#/patchset/20260711180755.1779002-1-alison.schofield@intel.com?part=1
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/hdm.c | 33 +++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 ++
>  2 files changed, 35 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..d81df45d8005 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -76,6 +76,8 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  
>  	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
>  	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +
> +	/* target_count is a direct count (1h..8h), not 0-based like decoder_count */
>  	cxlhdm->target_count =
>  		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
>  	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> @@ -1084,6 +1086,37 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  		cxld->interleave_ways, cxld->interleave_granularity);
>  
>  	if (!cxled) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);

Trivial but I'd go long and have that on one line. It's only just over 80 chars!


> +
> +		if (cxlsd->nr_targets < 1) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: reports zero targets\n",
> +				port->id, cxld->id);
> +			return -ENXIO;
> +		}
> +
> +		if (!committed) {
> +			/* Ignore interleave ways until commit */

Dumb question but why is = 1 equivalent to ignore? Can we make it explicit
either by gating at all use of interleave_ways, or using an invalid value
to mean we don't care yet.  I like 0 as that's clearly nonsense for interleave
ways.

> +			cxld->interleave_ways = 1;
> +			return 0;
> +		}
> +
> +		if (cxld->interleave_ways > CXL_HDM_DECODER0_TL_TARGETS) {

This feels a bit belt and braces.  Should we be verifying that nr_targets meets
this constraint before setting it instead and only having the below test here?

> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds target list capacity: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				CXL_HDM_DECODER0_TL_TARGETS);
> +			return -ENXIO;
> +		}
> +		if (cxld->interleave_ways > cxlsd->nr_targets) {
> +			dev_err(&port->dev,
> +				"decoder%d.%d: interleave ways: %d exceeds targets: %d\n",
> +				port->id, cxld->id, cxld->interleave_ways,
> +				cxlsd->nr_targets);
> +			return -ENXIO;
> +		}
> +
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
>  		target_list.value = (hi << 32) + lo;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index c0e5308e4d1b..291ada46b646 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -67,6 +67,8 @@ extern const struct nvdimm_security_ops *cxl_security_ops;
>  #define   CXL_HDM_DECODER0_CTRL_HOSTONLY BIT(12)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> +/* Two registers with one target ID per byte */
> +#define CXL_HDM_DECODER0_TL_TARGETS 8

Whilst the comment is true, perhaps better to refer to IW definition
and 8 being max allowed for anything that isn't a end point.

Maybe the spec would provide 2 registers and then only allow 6 decoders :)
Also comment doesn't say how big registers are.  Anyhow, to me the IW
reference is crisper.

>  #define CXL_HDM_DECODER0_SKIP_LOW(i) CXL_HDM_DECODER0_TL_LOW(i)
>  #define CXL_HDM_DECODER0_SKIP_HIGH(i) CXL_HDM_DECODER0_TL_HIGH(i)
>  

