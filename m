Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05D13C908
	for <linux-cxl@vger.kernel.org>; Tue,  8 Sep 2026 00:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788825725; cv=none; b=IJpBHI6BghBMGijWwVQln9n2viKqi3FXQ3Pjn/qbyS/SYBidAeUNUzlcMc6J3LbHxgd74Oa2fVq8gxBQMvJSqU/9Vxe1uKsVzvv+J3zIp91bKRAB2anJbWlWVtt9yhxVCHKIB+7JzaMwAjv39u8U822v0nzkdEAoTIk2+84MgCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788825725; c=relaxed/simple;
	bh=FNiVKursBAahX9i0tNY5bT9dX+m/RQLYA1642VZlwvk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WGZHeze5zDbpwwlhfnZvQ8gmvqVdN/07IkslWiSkXeKdX9zMdJiFjEZoK3ESBU2Bv7nLGOhoPcpPESNanWZ0wVpxbdKcFjzlQ+Vb8zaueo/SrL7DD5E+tYoGpBIMG27KMQ1DPgxfGy5zXOVFPGXLVvb4ZB5/FNAXLIOqMq6YWxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac/603Tc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac/603Tc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE7A1F00A3A;
	Tue,  8 Sep 2026 00:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788825723;
	bh=SrtGmjUv1LXkd9VGBBoe9i22vl5G03eN1u1RiK9Upic=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ac/603TciIUKRDC/amK6Ie2WMiea2NOqAHXYJMQbazFQ8gB1N5FI5rxdlLV5FpyL6
	 FABi+778FeuVRxlw7Y3MHSSLkDx870L6szXm6tYaWZwgNa8K2GFpoR3qkkjgJRNqvn
	 FH1d408+LNCTE9bWkDXHLRo8bqSCTz/kFDXZKUyYJUQ93insIjFWFNjfGlVM+eDGCw
	 LwntmYi/cKOQgTAAhdW/Bf4FbMfS12zgv8zR3ErWHZb5O1LYMmN9jrm4jyER3jTWGU
	 5+oGpCWtQh5Lkr8dCUn+oMbFlkX6llUClrx3Y9ZzpaMZIdMMN8lpLhnGB4Pf25tHNE
	 sqpyu2x8H23jw==
Date: Tue, 8 Sep 2026 01:02:00 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v5 5/7] cxl/region: Support mixed-granularity auto
 regions
Message-ID: <20260908010200.4435bb5b@jic23-huawei>
In-Reply-To: <4ff59676f6db40e86749ebc810ead8ddfd3d3366.1788475206.git.alison.schofield@intel.com>
References: <cover.1788475206.git.alison.schofield@intel.com>
	<4ff59676f6db40e86749ebc810ead8ddfd3d3366.1788475206.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  3 Sep 2026 16:23:47 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> The CXL Specification permits a region's interleave granularity to differ
> between levels of the decoder hierarchy. For an auto region, the CXL driver
> reconstructs that hierarchy from the decoder configuration programmed by
> platform firmware.
> 
> The CXL driver currently requires the interleaving root to have the same
> granularity as the region, with each successive interleaving level becoming
> coarser toward the endpoints. A mixed-granularity region lifts that
> requirement: its interleave granularity is finer than the granularity of
> its interleaving root decoder. The driver cannot assemble such a region
> today.
> 
> Support mixed-granularity auto regions in the CXL driver, restricted to
> coarse-to-fine layouts. Derive each interleaving decoder's granularity from
> its parent:
> 
>         child_ig = parent_ig / child_iw
> 
> A same-granularity region keeps the existing derivation, which coarsens
> toward the endpoints:
> 
>         child_ig = parent_ig * parent_iw
> 
> The topology determines each decoder's interleave ways, so the parent
> granularity and child ways determine the child granularity. Use that
> relationship to validate the decoder geometry while assembling an auto
> region. Only the interleaving levels are compared; a passthrough level,
> child_iw == 1, keeps its granularity exemption.
> 
> Refuse a derived granularity finer than the region granularity. Dividing at
> every level lands the deepest interleaving level exactly on the region
> granularity, so a finer value means the topology below one port is deeper
> than the region interleave has positions for, which happens only when
> another branch is too shallow to cover its share. That is what rejects an
> unbalanced tree below the interleaving root.
> 
> Require the root and region to interleave over the same span, the address
> range in which the interleave pattern completes one full pass:
> 
>         root_iw * root_ig == region_iw * region_ig
> 
> The same span relationship covers the CXL Specification's Mod3
> configurations. For example, a 6-way region at IGB across three host
> bridges uses a 3-way root interleave at 2 * IGB and a 2-way interleave at
> IGB below it, as described in CXL 4.0 Section 9.13.1.1.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

A couple of comments inline, but I'm fine with it as you have it here
if you prefer to not take those suggestions up.
Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

> ---
>  drivers/cxl/core/region.c | 128 ++++++++++++++++++++++++++------------
>  1 file changed, 89 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 116f84bb0745..5b7104a55fdd 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c


>  static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
> @@ -1448,7 +1457,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> -	struct cxl_port *iter = port;
>  	u16 eig, peig;
>  	u8 eiw, peiw;
>  
> @@ -1464,26 +1472,26 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	}
>  
>  	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	child_iw = cxl_rr->nr_targets;
> +
>  	if (cxl_rr->nr_targets_set) {
>  		int i, distance = 1;
> -		struct cxl_region_ref *cxl_rr_iter;
>  
>  		/*
> -		 * The "distance" between peer downstream ports represents which
> -		 * endpoint positions in the region interleave a given port can
> -		 * host.
> -		 *
> -		 * For example, at the root of a hierarchy the distance is
> -		 * always 1 as every index targets a different host-bridge. At
> -		 * each subsequent switch level those ports map every Nth region
> -		 * position where N is the width of the switch == distance.
> +		 * @distance is the spacing between region positions sharing this
> +		 * dport. Mixed-granularity regions place them contiguously.

Maybe throw in "Supported" given there are things that match your def
of mixed-granularity that we don't support!

>  		 */

...

...

> @@ -2061,6 +2070,43 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static int cxl_region_validate_interleave(struct cxl_region *cxlr)
> +{
> +	struct cxl_decoder *cxld = &cxlr->cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p = &cxlr->params;

I know this is consistent with elsewhere, but to me would be nice
if this were region_p or something like that so we'd immediately know
at point of use that this was region stuff.

> +	int root_iw = cxld->interleave_ways;
> +	int root_ig = cxld->interleave_granularity;
> +
> +	if (root_iw == 1)
> +		return 0;
> +
> +	if (p->interleave_granularity > root_ig) {
> +		dev_dbg(&cxlr->dev,
> +			"granularity %d exceeds root decoder granularity %d\n",
> +			p->interleave_granularity, root_ig);

In the patch description I think you describe this the other way around and
to me that makes more sense.  No where in the topology can the granularity be
less than that of the region.
	if (root_ig < p->interleave_granularity) {
		dev_dbg(&cxlr->dev,
			"Granularity %d, of root decoder is less than granularity %d of region\n"),

Obviously this is just my mental model being reverse of what is here and
they are mathematically the same, so feel free to ignore this one if you
think of it the other way around.

> +		return -ENXIO;

> +	}
