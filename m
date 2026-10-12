Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E82AB449988
	for <linux-cxl@vger.kernel.org>; Mon, 12 Oct 2026 15:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791818216; cv=none; b=leUJK9wJuKdwtlj1XQl4EZwcuYhP8K+96fAFOdrZBxSg+dWug+dildiiGYGnoo4Cvhe+SJnIbdNV6qupLJjDhadlTrkfNe6UDXZJ1jLGaTwcl8jhXHFa7CZQ3/RGlPuEvUIPEZgqAVoALJhJmBhXD58RifDTLQKfSQYVsXFY7/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791818216; c=relaxed/simple;
	bh=aca3ti2jOkRyP5tnKAiu+yLYXRFyJQT/lCrVd+6UqNc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W8T1fo/8ko4LpXGvLfxGvCBzsadh2EP7Zb57tPmHZ3MJxu0cYOc8+kRbf4kQh4RPFGn2r+4fqpZjuo7gDfcHFujZ6TSoZcKRj3qQuL1cI28vLJtCDZvVrpuOkWkMW7RJhy7dp8ShNFWwjUkdUwG3N3QXiU8APM7C0tJgtKmKuGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kScBnBXk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kScBnBXk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7381F0089B;
	Mon, 12 Oct 2026 15:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791818214;
	bh=p9pfgVBHo0tQD0rDShowcg1/xXZjhsav3H9AsaHBqOY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kScBnBXkOLAUl8+/yTgMPyamh4caPysusJhk8iv0WluRMvzvZbIu43cHMciCnz6za
	 Tp24cEO8GUFCX0ciOafUQIRre1wFz01R2LFdQxi77SVQ2H5WEUP1FCgU7N4Blgz79B
	 BtQYtdFhVJqcSW0ZtI4Z69MSAC96MmigMCNXCiBLRkkWxalrpHMoFlJuEh88sOzcZB
	 L3VZiJkR9AL9Y8uZ3VFqswVjwre+cTnmOPXMkhkiLrTOMEO7jkBT/gNm8G47o+fmrq
	 PWiKbBpVd+4dYopMt2FSzNCllXGqdP/3SzgArldPoj0aq6HxRovmyzxQCwUKUpa2Od
	 JhLDJvGOET4Aw==
Date: Mon, 12 Oct 2026 16:16:47 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>, Robert
 Richter <rrichter@amd.com>, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 4/8] cxl/region: Factor out cxl_port_peer_distance()
Message-ID: <20261012161647.4fe1575d@jic23-hlaptop>
In-Reply-To: <dcbd67bd2059beccba1aaa92ea099ac35dec9026.1791676454.git.alison.schofield@intel.com>
References: <cover.1791676454.git.alison.schofield@intel.com>
	<dcbd67bd2059beccba1aaa92ea099ac35dec9026.1791676454.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 10 Oct 2026 17:20:19 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> cxl_switch_port_setup_targets() is nearly 200 lines long and open codes
> each step of adding an endpoint to a port's decoder. One of those steps
> calculates the distance between region positions that share a downstream
> port.
> 
> Move that calculation to a new helper, cxl_port_peer_distance().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

I wonder if the docs make more sense made function documentation rather
than inline.  Either way lgtm
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/region.c | 50 +++++++++++++++++++++++----------------
>  1 file changed, 29 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d564443a1d39..b288421203a9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1432,6 +1432,33 @@ static int check_interleave_cap(struct cxl_decoder *cxld, int iw, int ig)
>  	return 0;
>  }
>  
> +static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr)
> +{
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> +	struct cxl_region_ref *cxl_rr_iter;
> +	struct cxl_port *iter = port;
> +	int distance = 1;
> +
> +	/*
> +	 * The "distance" between peer downstream ports represents which
> +	 * endpoint positions in the region interleave a given port can
> +	 * host.
> +	 *
> +	 * For example, at the root of a hierarchy the distance is
> +	 * always 1 as every index targets a different host-bridge. At
> +	 * each subsequent switch level those ports map every Nth region
> +	 * position where N is the width of the switch == distance.

Maybe promote this to be function documentation now this function is only
concerned with finding that distance!

> +	 */
> +	do {
> +		cxl_rr_iter = cxl_rr_load(iter, cxlr);
> +		distance *= cxl_rr_iter->nr_targets;
> +		iter = to_cxl_port(iter->dev.parent);
> +	} while (!is_cxl_root(iter));
> +	distance *= cxlrd->cxlsd.cxld.interleave_ways;
> +
> +	return distance;
> +}
> +
>  static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  					 struct cxl_region *cxlr,
>  					 struct cxl_endpoint_decoder *cxled)
> @@ -1445,7 +1472,6 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1460,27 +1486,9 @@ static int cxl_switch_port_setup_targets(struct cxl_port *port,
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
>  	if (cxl_rr->nr_targets_set) {
> -		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
> +		int distance = cxl_port_peer_distance(port, cxlr);
>  
> -		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> -		 */
> -		do {
> -			cxl_rr_iter = cxl_rr_load(iter, cxlr);
> -			distance *= cxl_rr_iter->nr_targets;
> -			iter = to_cxl_port(iter->dev.parent);
> -		} while (!is_cxl_root(iter));
> -		distance *= cxlrd->cxlsd.cxld.interleave_ways;
> -
> -		for (i = 0; i < cxl_rr->nr_targets_set; i++)
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
>  			if (ep->dport == cxlsd->target[i]) {
>  				rc = check_last_peer(cxled, ep, cxl_rr,
>  						     distance);

