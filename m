Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 713931FECBB;
	Fri, 14 Mar 2025 12:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956310; cv=none; b=KWDPmx8DpPrfBpE78FOdr6GCS1D/DL4zOLMuvCFwRup7Xu7gKvJUPKA2okAqerOp2FRGDDHCl+ClN8b8KwvK4Liz/81PMPS64mP1S2J+8xZ/O9AcHxOR1e91zGR1wg6qnl3B/Cl1A/sr+0673OMFaHmzGsfi3w3tCF2Mji3M0h8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956310; c=relaxed/simple;
	bh=H6/smu2eq1za5tJ/ycHo8F4oEFo0l6V+wEVVj4bRAy8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=onEcxXwqsvI+FRgy2Ov1S+L+tGxDYwln986rMBzcasMB2R9GeWAZOowLxdLQYdSkzFR4v10Y1Q7iOgxMZ2lZg+q7aDzfiv7E7BPmp9aGQs/NSVv5RymkqiOVSljt470zQqECMec8yjbFBIzu/VEhPE5Ggf6bxpX4f5A+JhfSXhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDkX20dT1z6K8hM;
	Fri, 14 Mar 2025 20:41:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B78F140680;
	Fri, 14 Mar 2025 20:45:05 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:45:04 +0100
Date: Fri, 14 Mar 2025 12:45:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v2 03/15] cxl/region: Factor out code for interleaving
 calculations
Message-ID: <20250314124503.000034d3@huawei.com>
In-Reply-To: <20250218132356.1809075-4-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
	<20250218132356.1809075-4-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 18 Feb 2025 14:23:44 +0100
Robert Richter <rrichter@amd.com> wrote:

> Function cxl_calc_interleave_pos() contains code to calculate the
> interleaving parameters of a port. Factor out that code for later
> reuse. Add function cxl_port_calc_interleave() for this and introduce
> struct cxl_interleave_context to collect all interleaving data.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 63 ++++++++++++++++++++++++++-------------
>  1 file changed, 43 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c118bda93e86..ad4a6ce37216 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1800,27 +1800,34 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	return rc;
>  }
>  
> +struct cxl_interleave_context {
> +	struct range *hpa_range;
> +	int pos;

If this isn't going to get bigger later in the series I'd be inclined to just pass
the two separately.  Update the pos based on return value if non negative.

Maybe I'm missing a reason that doesn't work.



> +};
> +
>  /**
> - * cxl_calc_interleave_pos() - calculate an endpoint position in a region
> - * @cxled: endpoint decoder member of given region
> + * cxl_port_calc_interleave() - calculate interleave config of an endpoint for @port
> + * @port: Port the new position is calculated for.
> + * @ctx: Interleave context

>   *
> - * The endpoint position is calculated by traversing the topology from
> - * the endpoint to the root decoder and iteratively applying this
> - * calculation:
> + * The endpoint position for the next port is calculated by applying
> + * this calculation:
>   *
>   *    position = position * parent_ways + parent_pos;
>   *
>   * ...where @position is inferred from switch and root decoder target lists.
>   *
> + * The endpoint's position in a region can be calculated by traversing
> + * the topology from the endpoint to the root decoder and iteratively
> + * applying the function for each port.
> + *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
> -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_calc_interleave(struct cxl_port *port,
> +				    struct cxl_interleave_context *ctx)
>  {
> -	struct cxl_port *iter, *port = cxled_to_port(cxled);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *range = &cxled->cxld.hpa_range;
> -	int parent_ways = 0, parent_pos = 0, pos = 0;
> +	int parent_ways = 0, parent_pos = 0;
>  	int rc;
>  
>  	/*
> @@ -1852,22 +1859,38 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  	 * complex topologies, including those with switches.
>  	 */
>  
> -	/* Iterate from endpoint to root_port refining the position */
> -	for (iter = port; iter; iter = parent_port_of(iter)) {
> -		if (is_cxl_root(iter))
> -			break;
> +	if (is_cxl_root(port))
> +		return 0;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> -		if (rc)
> -			return rc;
> +	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways);
> +	if (rc)
> +		return rc;
>  
> -		pos = pos * parent_ways + parent_pos;
> -	}
> +	ctx->pos = ctx->pos * parent_ways + parent_pos;
> +
> +	return ctx->pos;
> +}
> +
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_port *iter, *port = cxled_to_port(cxled);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_interleave_context ctx;
> +	int pos = 0;
> +
> +	ctx = (struct cxl_interleave_context) {
> +		.hpa_range = &cxled->cxld.hpa_range,
> +	};
> +
> +	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
> +	     iter = parent_port_of(iter))
> +		pos = cxl_port_calc_interleave(iter, &ctx);
>  
>  	dev_dbg(&cxlmd->dev,
>  		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
>  		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> -		dev_name(&port->dev), range->start, range->end, pos);
> +		dev_name(&port->dev), ctx.hpa_range->start, ctx.hpa_range->end,
> +		ctx.pos);
>  
>  	return pos;
>  }

