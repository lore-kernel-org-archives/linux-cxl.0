Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71801D540;
	Fri, 14 Mar 2025 12:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956593; cv=none; b=kUSq03/6JF1hMEQ96SGSZqgAq+wJqe7LPU+KSURAQYv1wwZVxJSSlJiiSOzkH07hH3A3bostnJQzwWOH+DnUUOyv87zEBBezdY+BrgvDl2dmMdcwYeXBUedW64j4midZc5gjcVM348y693J2SN531XqAfF1M/I170819VQRnpe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956593; c=relaxed/simple;
	bh=ykkSyokurIZOkGVyHZ6RGiCF1TX/5YvFq1AdmVuGnFU=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+eyaQrwDi21Phy0nY8a5fHTJjiGi7MdQaJGpVjm9hLb+LpG8MI85+T9cQrSjyqkASZzhNn8wZsQyUuozqj4c8/ZDvai+SZTjyuQKbLyvE9qXcdezYqWmaLSodIsN8U6uUEYh0a1PyPrxJgdo+laEcQn1qO55emup58KrOqTr0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDkdV32Shz6K8hM;
	Fri, 14 Mar 2025 20:46:38 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AB4F140D1D;
	Fri, 14 Mar 2025 20:49:49 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:49:48 +0100
Date: Fri, 14 Mar 2025 12:49:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v2 10/15] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <20250314124947.00001d93@huawei.com>
In-Reply-To: <20250218132356.1809075-11-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
	<20250218132356.1809075-11-rrichter@amd.com>
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

On Tue, 18 Feb 2025 14:23:51 +0100
Robert Richter <rrichter@amd.com> wrote:

> Endpoints requiring address translation might not be aware of the
> system's interleaving configuration. Instead, interleaving can be
> configured on an upper memory domain (from an endpoint view) and thus
> is not visible to the endpoint. For region creation this might cause
> an invalid interleaving config that does not match the CFMWS entries.
> 
> Use the interleaving configuration of the root decoders to create a
> region which bases on CFMWS entries. This always matches the system's
> interleaving configuration and is independent of the underlying memory
> topology.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 39 ++++++++++++++++++++++++++++++++++-----
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6e0434eee6df..3afcc9ca06ae 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1749,6 +1749,15 @@ static int cxl_region_validate_position(struct cxl_region *cxlr,
>  		}
>  	}
>  
> +	if (p->interleave_ways != cxled->interleave_ways ||
> +	    p->interleave_granularity != cxled->interleave_granularity ) {
> +		dev_dbg(&cxlr->dev, "interleaving config mismatch with %s: ways: %d:%d granularity: %d:%d\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways,
> +			cxled->interleave_ways, p->interleave_granularity,
> +			cxled->interleave_granularity);
> +		return -ENXIO;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -1852,7 +1861,7 @@ static int match_switch_decoder_by_range(struct device *dev,
>  }
>  
>  static int find_pos_and_ways(struct cxl_port *port, struct range *range,
> -			     int *pos, int *ways)
> +			     int *pos, int *ways, int *granularity)
>  {
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *parent;
> @@ -1873,6 +1882,7 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  	}
>  	cxlsd = to_cxl_switch_decoder(dev);
>  	*ways = cxlsd->cxld.interleave_ways;
> +	*granularity = cxlsd->cxld.interleave_granularity;
>  
>  	for (int i = 0; i < *ways; i++) {
>  		if (cxlsd->target[i] == port->parent_dport) {
> @@ -1896,6 +1906,8 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>  struct cxl_interleave_context {
>  	struct range *hpa_range;
>  	int pos;
> +	int interleave_ways;
> +	int interleave_granularity;

Ah. And here is our context expansion

>  };
>  
>  /**
> @@ -1914,13 +1926,17 @@ struct cxl_interleave_context {
>   * the topology from the endpoint to the root decoder and iteratively
>   * applying the function for each port.
>   *
> + * Calculation of interleaving ways:
> + *
> + *    interleave_ways = interleave_ways * parent_ways;
> + *
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
>  static int cxl_port_calc_interleave(struct cxl_port *port,
>  				    struct cxl_interleave_context *ctx)
>  {
> -	int parent_ways = 0, parent_pos = 0;
> +	int parent_ways = 0, parent_pos = 0, parent_granularity = 0;
>  	int rc;
>  
>  	/*
> @@ -1955,12 +1971,23 @@ static int cxl_port_calc_interleave(struct cxl_port *port,
>  	if (is_cxl_root(port))
>  		return 0;
>  
> -	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways);
> +	rc = find_pos_and_ways(port, ctx->hpa_range, &parent_pos, &parent_ways,
> +			&parent_granularity);
>  	if (rc)
>  		return rc;
>  
>  	ctx->pos = ctx->pos * parent_ways + parent_pos;
>  
> +	if (ctx->interleave_ways)
> +		ctx->interleave_ways *= parent_ways;
> +	else
> +		ctx->interleave_ways = parent_ways;
> +
> +	if (ctx->interleave_granularity)
> +		ctx->interleave_granularity *= ctx->interleave_ways;
> +	else
> +		ctx->interleave_granularity = parent_granularity;
> +
>  	return ctx->pos;

I think Gregory called this out in earlier patch.  Mixing and matching
between returning pos and use of ctx makes things hard to read.  If
we need to have it in context, then make this return 0 or -ERR instead.

>  }


