Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472FA20F967;
	Tue, 14 Jan 2025 10:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736852375; cv=none; b=Q8ZL8HQd4smAQ4LT67f2keX3Nrn93YxPQaJdjVjRR/ZvlT2LXlT5ojcaN8d6BUjFM38Rq1Mjn4rCP38QZ66Sf6siqgbkQdDGg/MW+ty86XFA6OYmpYt5I0TzlgaElhEkQ3kmrSGdAE5ZxtiLwQsjBK5XLtTn0QM5Sct3AwcYhxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736852375; c=relaxed/simple;
	bh=jdE+TeNcRyBTLOkcVuAfbMo72WeO9wDiXISLbc0hF0s=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tNJKawyoketAcdQ1GAq1Sq+0m/GiYvhJHbNvMD+hHN9sEGHsWwMZOO3NrPqnHlprKfbqN44B82IejcJyXY2yQ4Af5l5WjZeUellmGlja9pIX+OXfA+65HLcvPtHUYgAyUSh4PiFRvVKU5HMOyYapRbqEAjfHH5iiVTD++nj5WFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YXQxT4L5wz6K9HV;
	Tue, 14 Jan 2025 18:54:37 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B592414039F;
	Tue, 14 Jan 2025 18:59:29 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 14 Jan
 2025 11:59:29 +0100
Date: Tue, 14 Jan 2025 10:59:27 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v1 15/29] cxl/region: Use an endpoint's SPA range to
 find a region
Message-ID: <20250114105927.00000a96@huawei.com>
In-Reply-To: <20250107141015.3367194-16-rrichter@amd.com>
References: <20250107141015.3367194-1-rrichter@amd.com>
	<20250107141015.3367194-16-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 7 Jan 2025 15:10:01 +0100
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
> endpoint's SPA range and use it to find the endpoint's region.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 85 ++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h         |  1 +
>  2 files changed, 71 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 09a68e266a79..007a2016760d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -824,6 +824,41 @@ static int match_free_decoder(struct device *dev, void *data)
>  	return 1;
>  }
>  
> +static int cxl_port_calc_hpa(struct cxl_port *port, struct cxl_decoder *cxld,
> +			     struct range *hpa_range)
> +{
> +	struct range hpa = *hpa_range;
> +	u64 len = range_len(&hpa);
> +
> +	if (!port->to_hpa)
> +		return 0;
> +
> +	/* Translate HPA to the next upper domain. */
> +	hpa.start = port->to_hpa(cxld, hpa.start);
> +	hpa.end = port->to_hpa(cxld, hpa.end);
> +
> +	if (!hpa.start || !hpa.end ||

On general basis, why can't hpa.start be 0?
It is an unusual physical memory map, but technically possible on some
architectures.

> +	    hpa.start == ULLONG_MAX || hpa.end == ULLONG_MAX) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range invalid: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa.start, hpa.end, hpa_range->start,
> +			hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	if (range_len(&hpa) != len * cxld->interleave_ways) {
> +		dev_warn(&port->dev,
> +			"CXL address translation: HPA range not contiguous: %#llx-%#llx:%#llx-%#llx(%s)\n",
> +			hpa.start, hpa.end, hpa_range->start,
> +			hpa_range->end, dev_name(&cxld->dev));
> +		return -ENXIO;
> +	}
> +
> +	*hpa_range = hpa;
> +
> +	return 0;
> +}
> +
>  static int match_auto_decoder(struct device *dev, void *data)
>  {
>  	struct cxl_region_params *p = data;
> @@ -3214,26 +3249,47 @@ cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
>  static int cxl_endpoint_initialize(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *iter = cxled_to_port(cxled);
> -	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_port *parent, *iter = cxled_to_port(cxled);

I'd prefer that spit into two lines. Mixing cases that allocate and ones
that don't isn't great for readability.  Would also reduce the diff a little
which is always nice!

> +	struct range hpa = cxled->cxld.hpa_range;
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  

...


