Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0A8F1CD3F;
	Fri, 14 Mar 2025 12:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741956105; cv=none; b=R5FQb3TwZvkrgmu1FVuZyCqBCXcxdbKeCh+u4QpdmRAPEfWw6X0mJxT5HoM1WiVG6C26gqwTj/0OzNJdVtwiLcND4ag4N8j/mZcAPdbHJwohLYKHIYWu2jhtM9meWjEybzTJ9qsmq4Z7MI2TfeLb66Fy4BCo4bBMRwWYTrONvx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741956105; c=relaxed/simple;
	bh=1HoHoRNVZwzgg9OyuVUuQ9S6UujbGi8KzsQha8/ree8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AYWW6SL9FF2RWXgv1u9aCiDoaFjmdn2PVIDt8kX+6xHWKygWmA1li3hFzlrq4IIele9En/XH1mm+9UDN4ztN1JAQs139x/qB2v2k/0U5vVpXb//IhEwfbYQG5WFcQyTIQxDL2n5SIZEdYwWtaxPnF1ZWTWFIF6D/C32tAAGb2WA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDkSf31T4z6J9fm;
	Fri, 14 Mar 2025 20:38:58 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AD92140155;
	Fri, 14 Mar 2025 20:41:39 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 13:41:38 +0100
Date: Fri, 14 Mar 2025 12:41:37 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v2 05/15] cxl/region: Calculate and store the SPA range
 of an endpoint
Message-ID: <20250314124137.00004320@huawei.com>
In-Reply-To: <20250218132356.1809075-6-rrichter@amd.com>
References: <20250218132356.1809075-1-rrichter@amd.com>
	<20250218132356.1809075-6-rrichter@amd.com>
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

On Tue, 18 Feb 2025 14:23:46 +0100
Robert Richter <rrichter@amd.com> wrote:

> To find the correct region and root port of an endpoint of a system
> needing address translation, the endpoint's HPA range must be
> translated to each of the parent port address ranges up to the root
> decoder.
> 
> Calculate the SPA range using the newly introduced callback function
> port->to_hpa() that translates the decoder's HPA range to its parent
> port's HPA range of the next outer memory domain. Introduce the helper
> function cxl_port_calc_hpa() for this to calculate address ranges
> using the low-level port->to_hpa() callbacks. Determine the root port
> SPA range by iterating all the ports up to the root. Store the
> endpoint's SPA range for later use.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 68 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6f106bfa115f..d898c9f51113 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

> +
>  static int match_auto_decoder(struct device *dev, const void *data)
>  {
>  	const struct cxl_region_params *p = data;
> @@ -1882,6 +1920,11 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		.hpa_range = &cxled->cxld.hpa_range,
>  	};
>  
> +	/*
> +	 * Address translation is only supported for auto-discovery of
> +	 * decoders. There is no need to support address translation
> +	 * here. That is, do not recalculate ctx.hpa_range here.
> +	 */
>  	for (iter = cxled_to_port(cxled); pos >= 0 && iter;
>  	     iter = parent_port_of(iter))
>  		pos = cxl_port_calc_interleave(iter, &ctx);
> @@ -3262,7 +3305,8 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
> -	struct cxl_decoder *root, *cxld = &cxled->cxld;
> +	struct cxl_port *parent = parent_port_of(iter);
> +	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct range hpa = cxld->hpa_range;
>  	struct cxl_interleave_context ctx;
>  	int rc;
> @@ -3271,25 +3315,33 @@ static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
>  		.hpa_range = &hpa,
>  	};
>  
> -	while (iter && !is_cxl_root(iter)) {
> +	if (!iter || !parent)
> +		return -ENXIO;
> +
> +	while (iter && parent) {
> +		/* Translate HPA to the next upper memory domain. */
> +		rc = cxl_port_calc_hpa(parent, cxld, &hpa);
> +		if (rc < 0)
> +			return rc;
> +
>  		/* Convert interleave settings to next port upstream. */
>  		rc = cxl_port_calc_interleave(iter, &ctx);
>  		if (rc < 0)
>  			return rc;
>  
> -		iter = parent_port_of(iter);
> -	}
> +		iter = parent;
> +		parent = parent_port_of(iter);
>  
> -	if (!iter)
> -		return -ENXIO;
> +		if (!parent || parent->to_hpa)
> +			cxld = cxl_port_find_switch_decoder(iter, &hpa);
>  
> -	root = cxl_port_find_switch_decoder(iter, hpa);
> -	if (!root) {

I'm not immediately spotting why root needs a rename.  Is it used
for other things now that it wasn't before?

> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> -		return -ENXIO;
> +		if (!cxld) {
> +			dev_err(cxlmd->dev.parent,
> +				"%s:%s no CXL window for range %#llx:%#llx\n",
> +				dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +				hpa.start, hpa.end);
> +			return -ENXIO;
> +		}
>  	}


