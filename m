Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 316923B42EF
	for <linux-cxl@vger.kernel.org>; Fri, 21 Aug 2026 20:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345702; cv=none; b=LTkwk4Z4nEgVHFa9P3Fla5QDTBydpQ7wGA8TafMFGC9D2ciLForCASByhDoGZspwqp+cfuNjaq9xwWPz9TSwe6I2o6fycokkQ1PW/8EkfY67qXqT9/KKio+fWdOAxC8y8VXnPLnslI8fQFE8/wjR2P12FjSKTZ+EkGxZbNlO90E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345702; c=relaxed/simple;
	bh=Aqkp/8dM3BqBF5KNqRDtgAqScVZidk2Gdts7whRJ3v4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fu+JItkbMdQG09JpSxHyiTXKL8oUfTSDf3wCr9WIeHA2GSfWpZM02EBFaaaYbE7E8pzXVXEtZrhVnBdxytPkLtiY4bNp5a1jjpM4T5cBHXGB/xkBypH0HyNdvOzUrYmalK4FZ9zLDh76HvizFoUphpi0KQnMvqWpDEwA9wOYTqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G15DudDg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G15DudDg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC101F000E9;
	Fri, 21 Aug 2026 20:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787345697;
	bh=UYpkM7WZjqVgHxck4SEt/uUHkcBPsnzZ5UcYRxy7vM0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G15DudDgAdmVJstmM0FGqxMb5XRidyjoTH0CiC0w3Jve93tLIvK3X8vSVT4SMDjsX
	 oz1lSnR0pGB9bwGjTdnv/FmB4W3U8Axok0V2ePeJm3OO2C7Q3DDf4iHNHTW9WoWGrI
	 Gj5awD3oWhyWQJ0T/i1fCJQYP4svI9jhJezS9PU1AmU8ecbbuFymc5gAByJg61iM0w
	 dwNZlnmM1/BvsYBf/Adxo37nL047hNHLtiOtXw/qMHERZjQAftAq9sdJyDpjvU89QA
	 yJlmIjdcMLIh21fiQWOggHyOhqxOBxdmvcmjWCp9uZ1HIfmgMxgZMj55YVcFwKy99O
	 1YSZfKIvJmoUA==
Date: Fri, 21 Aug 2026 21:54:50 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>, Li
 Ming <ming.li@zohomail.com>, Robert Richter <rrichter@amd.com>,
 linux-cxl@vger.kernel.org
Subject: Re: [PATCH v4 2/6] cxl/region: Generalize endpoint position mapping
Message-ID: <20260821215450.3cc4d69f@jic23-huawei>
In-Reply-To: <1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
References: <cover.1787255388.git.alison.schofield@intel.com>
	<1c9218cf46a96937964e217c9172648a322d86c7.1787255388.git.alison.schofield@intel.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Aug 2026 16:31:20 -0700
Alison Schofield <alison.schofield@intel.com> wrote:

> Endpoint position calculation currently relies on the requirement that
> an interleaving root have the same granularity as the region. Auto
> region creation builds the position by multiplying by each parent
> decoder's ways, while user region creation selects the root target

decoders' (more than one and belongs to I think)

> with 'pos % ways'. Those calculations are sufficient under the current
> granularity restriction.
> 

So far no definition of mixed-granularity - hence suggestion to drag
the docs patch ahead of this one.

> In order to support mixed-granularity regions, that granularity
> restriction will need to be removed so decoder granularity can change
> between levels of the interleave hierarchy. The position calculation
> needs to account for those changes to produce the correct endpoint
> ordering.
> 
> Change the position calculation so each decoder's contribution is
> weighted by its granularity relative to the region granularity:
> 
>     position += target_pos *
>                 (decoder_granularity / region_granularity)
> 
> Use the same relationship to select the root target during user region
> creation.
> 
> For currently supported regions, the new weighted calculation reduces
> to the existing position calculation and produces identical endpoint
> positions.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 60 ++++++++++++++++++++++-----------------
>  1 file changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3b640c9ba5a0..4f367feaf6c8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1805,9 +1805,14 @@ static int cxl_region_attach_position(struct cxl_region *cxlr,
>  	struct cxl_decoder *cxld = &cxlsd->cxld;
>  	int iw = cxld->interleave_ways;
>  	struct cxl_port *iter;
> -	int rc;
> +	int root_pos = pos, rc;
>  
> -	if (dport != cxlrd->cxlsd.target[pos % iw]) {
> +	/* Root target selection advances at root-granularity intervals */
> +	if (iw > 1)
> +		root_pos = pos * cxlr->params.interleave_granularity /
> +			   cxld->interleave_granularity;
> +
> +	if (dport != cxlrd->cxlsd.target[root_pos % iw]) {
>  		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			dev_name(&cxlrd->cxlsd.cxld.dev));
> @@ -1908,13 +1913,13 @@ static int match_switch_decoder_by_range(struct device *dev,
>  	return (r1->start == r2->start && r1->end == r2->end);
>  }
>  
> -static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +static int find_pos_and_gran(struct cxl_port *port, struct range *range,
> +			     int *pos, int *gran)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
>  	struct device *dev;
> -	int rc = -ENXIO;
> +	int ways, rc = -ENXIO;

Trivial and perhaps just me, but I really don't like combining declarations with
and without assignments on one line.

>  
>  	parent = parent_port_of(port);
>  	if (!parent)
> @@ -1929,9 +1934,10 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  		return rc;
>  	}
>  	cxlsd = to_cxl_switch_decoder(dev);
> -	*ways = cxlsd->cxld.interleave_ways;
> +	ways = cxlsd->cxld.interleave_ways;
> +	*gran = cxlsd->cxld.interleave_granularity;
>  
> -	for (int i = 0; i < *ways; i++) {
> +	for (int i = 0; i < ways; i++) {
>  		if (cxlsd->target[i] == port->parent_dport) {
>  			*pos = i;
>  			rc = 0;
> @@ -1955,13 +1961,16 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * @cxled: endpoint decoder member of given region
>   * @hpa_range: translated HPA range of the endpoint
>   *
> - * The endpoint position is calculated by traversing the topology from
> - * the endpoint to the root decoder and iteratively applying this
> - * calculation:
> + * The endpoint position is calculated by traversing the topology from the
> + * endpoint to the root decoder and accumulating the contribution of each
> + * decoder level:
>   *
> - *    position = position * parent_ways + parent_pos;
> + *    position += parent_pos * (parent_granularity / region_granularity);
>   *
> - * ...where @position is inferred from switch and root decoder target lists.
> + * ...where @parent_pos is inferred from switch and root decoder target
> + * lists, and the multiplier is the number of region positions that the
> + * level's granularity spans. A level that selects a single target
> + * contributes nothing.

Wrap is a bit short.  I don't care much but you made one line above longer
and one line here shorter.  So if going to do that, target 80 chars max
for any line you have to touch.

>   *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
> @@ -1971,7 +1980,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	int parent_ways = 0, parent_pos = 0, pos = 0;
> +	int gran = cxled->cxld.interleave_granularity;
> +	int parent_gran = 0, parent_pos = 0, pos = 0;
>  	int rc;
>  
>  	/*
> @@ -1984,20 +1994,18 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  	 *        |    |           |    |
>  	 *       mem0 mem1        mem2 mem3
>  	 *
> -	 * In the example the calculator will iterate twice. The first iteration
> -	 * uses the mem position in the host-bridge and the ways of the host-
> -	 * bridge to generate the first, or local, position. The second
> -	 * iteration uses the host-bridge position in the root_port and the ways
> -	 * of the root_port to refine the position.
> +	 * The region and the root decoder interleave at granularity g, so
> +	 * each host-bridge decoder interleaves at 2g and spans two region
> +	 * positions while the root decoder spans one.

I've read this a few times and don't follow it. What are region positions?
I was assuming positions in the region. In which case the root decoder
spans 4, the host bridges 2.  So I guess not that?

>  	 *
>  	 * A trace of the calculation per endpoint looks like this:
> -	 * mem0: pos = 0 * 2 + 0    mem2: pos = 0 * 2 + 0
> -	 *       pos = 0 * 2 + 0          pos = 0 * 2 + 1
> +	 * mem0: pos += 0 * 2       mem2: pos += 0 * 2
> +	 *       pos += 0 * 1             pos += 1 * 1
>  	 *       pos: 0                   pos: 1
>  	 *
> -	 * mem1: pos = 0 * 2 + 1    mem3: pos = 0 * 2 + 1
> -	 *       pos = 1 * 2 + 0          pos = 1 * 2 + 1
> -	 *       pos: 2                   pos = 3
> +	 * mem1: pos += 1 * 2       mem3: pos += 1 * 2
> +	 *       pos += 0 * 1             pos += 1 * 1
> +	 *       pos: 2                   pos: 3
>  	 *
>  	 * Note that while this example is simple, the method applies to more
>  	 * complex topologies, including those with switches.
> @@ -2008,12 +2016,12 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
> -				       &parent_ways);
> +		rc = find_pos_and_gran(iter, hpa_range, &parent_pos,
> +				       &parent_gran);
>  		if (rc)
>  			return rc;
>  
> -		pos = pos * parent_ways + parent_pos;
> +		pos += parent_pos * (parent_gran / gran);
>  	}
>  
>  	dev_dbg(&cxlmd->dev,

