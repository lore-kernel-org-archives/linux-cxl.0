Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF8C2C0261
	for <linux-cxl@vger.kernel.org>; Mon,  7 Sep 2026 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788821980; cv=none; b=DZUhm8j8LlMElocEowDap6G3ElhaMrMG2LIMbL4BgBmGYzs06YHAemtQLRVMxzvYoK0VuphSI8sIKTOU2KW/izMYvE36gX4fYChW9lrLzaEhztUQoRTV0/iVyNhtbASZqhtb/TFJETh8E3b3lKnuOoCGa/8Pv8kgm9MjT0J4dIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788821980; c=relaxed/simple;
	bh=p+fcqUigCYUWjnKugdbAdJUJRT0lX9YjTMjJVK5JCME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MWpm7mcEhf2JIh3tEZwLMShB6D/ntMPSCpUIZnaUy4AsESwM3a/YmV95XYJSO/gA7QA8uM9g+6tUD86evNqCCqLDcMTj9h1JO8DlNzmizGg2gwsFYWuFfAcUPiAYrfB2YlO6YjWozHVUJ58KH43fXOf+eLq2HWoH7LEVbcx8pfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cdYVd98F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cdYVd98F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E9D51F00A3A;
	Mon,  7 Sep 2026 22:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788821979;
	bh=JFeo0qnItbvp9QXz7j8hFWmfaq9ILPG1ZXD8h8V+j2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cdYVd98FaN0/ryvbR9Zlm64yqGbXit8tq3ThqyfUPdLWKc3taDTeTrlHaFQ2X433H
	 f+6lNc0Hf/a96o6E/m2GySPNhes1G1IW23vBUKixF6eOW9lwDLrWEjvyHgCDIl796s
	 sivCuEm6I2Gk8u70PUHGSSL6r8REMyuhYmQYhfNUeI0DiaUb8NHqVFmUCL5r3J1Zbs
	 o0c1UtLkdRvPqnMPr/Foeo3refddGQKOCorSs2qX0IjdU1OuC6l73gxS7NG2C3RwTE
	 P+LKv1m10AOaGvCXSxI8dRdlYbBLefvR3V6ZMfTD6+7bHaClDRZYx4uccueoSDhb5E
	 FOAc2qRmVuFyg==
Date: Mon, 7 Sep 2026 23:59:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, linux-cxl@vger.kernel.org, Sashiko AI Review
 <sashiko-bot@kernel.org>, Richard Cheng <icheng@nvidia.com>
Subject: Re: [PATCH v4 1/2] cxl/region: Allow regions with an unencodable
 passthrough granularity
Message-ID: <20260907235934.47a8c703@jic23-huawei>
In-Reply-To: <35566fc6397183a8be89055d1de9979eab9a24a5.1788487020.git.alison.schofield@intel.com>
References: <cover.1788487020.git.alison.schofield@intel.com>
	<35566fc6397183a8be89055d1de9979eab9a24a5.1788487020.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 20:21:32 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Region creation fails when the interleave granularity accumulated below the
> root decoder exceeds 16K, the maximum encodable in the HDM Decoder Control
> IG field, even when the decoder that computes it does not interleave.
Hi Alison

I'm rather late to the game, but a few questions and suggestions inline.

> 
> For example, a 2-way root decoder at 16K granularity with a single endpoint
> below each host bridge. Neither host bridge decoder interleaves, yet the
> 32K granularity computed for them is rejected and the region fails to
> attach an endpoint:
> 
>   cxl region3: root0: invalid granularity calculation (16384 * 2)
>   cxl_port endpoint16: failed to attach decoder16.0 to region3: -22
> 
> A non-interleaving decoder does not consume the IG field, so region setup
> is rejecting a value hardware never reads.
> 
> Only require the granularity to be encodable for interleaving decoders,
> both where it is inherited from the parent and where it is computed for the
> current decoder. Keep the computed value for passthrough decoders so it can
> seed descendant decoder setup.

Which computed value?  If it's passthrough it should be as if it wasn't
there at all. So I assume you mean if we get to a downstream decoder we need
to use the accumulation from the layer about the pass through decoder?

I think this is just me getting confused by the explanation rather than
a real problem with what you are doing here.

> 
> Accumulating the granularity below a passthrough decoder is not being
> undone: a descendant that does interleave must see the accumulated value or
> it would interleave on an address bit an ancestor already used. That
> descendant inherits a granularity above 16K, so it is still rejected on its
> own turn and a real overflow cannot be masked.
> 
> When committing a non-interleaving decoder, still program the granularity
> if it is encodable; use a don't-care IG encoding only when it is not. This
> preserves an encodable passthrough granularity across re-enumeration, so
> descendants do not inherit a stale value.

I don't understand what is preserved vs using a don't-care IG value in all
cases.

> 
> As a consequence, the interleave_granularity attribute of a decoder whose
> interleave_ways is 1 may report a value above 16K. Document that the
> reported granularity for non-interleaving decoders is a don't-care value
> that may exceed the maximum encodable in hardware.

An alternative that seems valid to me would be to report the upstream
decoder value.  So in the example you have just report the pass through
as 16K same as the host bridge. Anything downstream would then accumulated
as normal.  That might also remove the need for any special notes in the
documentation.

Mind you we'd then need to also carry the parent interleave ways forward
in the calcs (but hide it as that obviously doesn't make sense for
a pass through decoder). So maybe this is the cleanest route.

A few other comments inline.

> 
> Fixes: 18f35dc9314d ("cxl/region: Refactor granularity select in cxl_port_setup_targets()")
> Reported-by: Sashiko AI Review <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260530002613.682E71F00893@smtp.kernel.org/
> Assisted-by: Claude:Opus-4-8
> Reviewed-by: Richard Cheng <icheng@nvidia.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  5 +++-
>  drivers/cxl/core/hdm.c                  |  8 +++++-
>  drivers/cxl/core/region.c               | 34 ++++++++++++++-----------
>  3 files changed, 30 insertions(+), 17 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 7352dbd70bc7..6abfd792f07e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -412,7 +412,10 @@ Description:
>  		space this decoder claims at address N before the decode rotates
>  		to the next target in the interleave at address N +
>  		interleave_granularity (assuming N is aligned to
> -		interleave_granularity).
> +		interleave_granularity). When 'interleave_ways' is 1, the
> +		decoder does not interleave and the reported granularity is
> +		a don't-care value that may exceed the maximum encodable in
> +		hardware.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/create_pmem_region
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0c80b76a5f9b..5ff1a75124cc 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -691,7 +691,13 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	if (WARN_ONCE(ways_to_eiw(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
> +
> +	/*
> +	 * A non-interleaving decoder ignores the IG field, so an unencodable
> +	 * granularity is a don't-care rather than a failure.
> +	 */
> +	if (granularity_to_eig(cxld->interleave_granularity, &eig) &&
> +	    WARN_ONCE(cxld->interleave_ways > 1,
>  		      "invalid interleave_granularity: %d\n",
>  		      cxld->interleave_granularity))
>  		return;

This is a little confusing and relies on the clearing of eig to 0 inside
granularity to ig.  I'd be tempted to do that explicitly and flag
what that placeholder value is with a define or similar.  Something like

	if (granularity_to_eig(cxld->interleave_granularity, &eig)) {
		if (WARN_ONCE(cxld->interleave_ways >1,
			      "stuff ...)
			return;
		eig = EIG_PLACE_HOLDER;
	} 

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 27e63e6dab7c..89693f0181dd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1435,6 +1435,20 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  

>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1449,7 +1463,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *iter = port;
> -	u16 eig, peig;
>  	u8 eiw, peiw;
>  
>  	/*
> @@ -1522,12 +1535,11 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> +	if (!granularity_is_valid(parent_iw, parent_ig)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
>  			dev_name(parent_port->uport_dev),
>  			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	rc = ways_to_eiw(parent_iw, &peiw);
> @@ -1550,20 +1562,12 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> +	ig = parent_ig * parent_iw;

If you did set the ig to that of the parent for pass through, this is
where you'd need to have gotten the cached upstream_iw (name can be improved)
so the maths still works.

> +	if (!granularity_is_valid(iw, ig)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s: invalid granularity calculation (%d * %d)\n",
>  			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> -
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	if (iw > 8 || iw > cxlsd->nr_targets) {

