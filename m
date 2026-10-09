Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E4F13A258
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585930; cv=none; b=O4ipP0CLjzafA/RJvm6XdUNcBjV1YTntKAO0EgLntOdnI+hVHn0TZ9wusxQiDBqUGTh/8UyAsnZSDmNzr2oskniMDaTC0fLmJj9jJ4Wty/rBlzQ0cw7chxyBQbxtLJD46+bWFxSSYbbJrGsd3HdR0JGA/PQ6FLKckq3rfDcVJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585930; c=relaxed/simple;
	bh=j6+b83KRhHXtt2/zxvRHaOhKZCdAUp0c9tSnfRzX67Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J8QEuZRCpj6dbNqJ9IYlKlpF5V7ZVm3ZDcvp7SJEU6w0X0i6DS4acCwW4r+YGmcR1SsIxBo7XXPjjxBgj94pLuiHrY+vnNAzD6AYZrJ6+Nj5Ifs5FfexNtSjKh00Fi+ZOR30rJmxYr6x6K2eMvCt4z3QfaFz2si/PY5bhshdkC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SnmBE1Ig; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SnmBE1Ig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791585928; x=1823121928;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=j6+b83KRhHXtt2/zxvRHaOhKZCdAUp0c9tSnfRzX67Y=;
  b=SnmBE1IgYvA1XrtKXE68kTTQ7dm7WuHBD6JnTPD9HPB/iaVLKEjVDPW3
   Aeb4wkPxNNsLG0MzhwSEjfv8h2Yi7Ugo9NbBeH7GjZJm2E8+EAiH28bSq
   URMbgGXoXxeWGrKIP06vhhHnMaWLdD1rMOUS9XhQCHxFX7Vkl3+gk0CJA
   18Zpu14Rxk9+Nqq1LPFAsoo+m2MpUaDVtf9BtRtD6tRnIXNt9d10CVF9l
   QTnwNp2gkggSTiviJwyVQPvlXL8cuDyztDUw7x3cj+ulWgprxgFbds5VU
   Uwvk7vKDLrGFbG5/qXpayK/chMoA8koXHA984mUali04aiIruMA3P0fS3
   w==;
X-CSE-ConnectionGUID: +WdF/FH1T/qXu0o+3NVm/g==
X-CSE-MsgGUID: oblRBurcRlqQXkeaUE8Bfw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="416928"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="416928"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:45:28 -0700
X-CSE-ConnectionGUID: c0rpMYzBQBmeNz4udfsWyw==
X-CSE-MsgGUID: 5UZl7r4CQDWkpEXRcKxu3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="394468"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:45:27 -0700
Message-ID: <4cc83557-ae7b-459b-9b22-4d0cca318da2@intel.com>
Date: Fri, 9 Oct 2026 15:45:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] cxl/region: Factor out cxl_port_calc_interleave()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791575481.git.alison.schofield@intel.com>
 <107a6e3685ecfd9287bf8983b999281e6e2716d2.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <107a6e3685ecfd9287bf8983b999281e6e2716d2.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> cxl_port_setup_targets() calculates the interleave ways and granularity of
> a port's decoder from the parent interleave and the number of targets below
> the port, then validates the result. That calculation and its checks are
> open coded between the target search and the decoder setup.
> 
> Move the calculation and its checks to a new helper,
> cxl_port_calc_interleave(), so that the interleave for the port's decoder
> is calculated and validated in one place.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 81 ++++++++++++++++++++++++---------------
>  1 file changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c1866b7b089b..43f1ffbe64c0 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1513,11 +1513,58 @@ static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *
>  	return 0;
>  }
>  
> +static int cxl_port_calc_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> +				    struct cxl_region_ref *cxl_rr, int *iw, int *ig)
> +{
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	int parent_iw, parent_ig, child_iw, child_ig, rc;
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	if (rc)
> +		return rc;
> +
> +	child_iw = cxl_rr->nr_targets;
> +	if (!ways_valid(child_iw)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			child_iw);
> +		return -EINVAL;
> +	}
> +
> +	/*
> +	 * Interleave granularity is a multiple of @parent_port granularity.
> +	 * Multiplier is the parent port interleave ways.
> +	 */
> +	child_ig = parent_ig * parent_iw;
> +
> +	if (!granularity_valid(child_ig)) {
> +		dev_dbg(&cxlr->dev,
> +			"%s: invalid granularity calculation (%d * %d)\n",
> +			dev_name(&parent_port->dev), parent_ig, parent_iw);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s:%s: ways: %d overflows targets: %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
> +		return -ENXIO;
> +	}
> +
> +	*iw = child_iw;
> +	*ig = child_ig;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
> -	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
> -	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	int child_iw, child_ig, rc, pos = cxled->pos;
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> @@ -1551,38 +1598,10 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
>  		goto add_target;
>  	}
>  
> -	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
>  	if (rc)
>  		return rc;
>  
> -	child_iw = cxl_rr->nr_targets;
> -	if (!ways_valid(child_iw)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), child_iw);
> -		return -EINVAL;
> -	}
> -
> -	/*
> -	 * Interleave granularity is a multiple of @parent_port granularity.
> -	 * Multiplier is the parent port interleave ways.
> -	 */
> -	child_ig = parent_ig * parent_iw;
> -
> -	if (!granularity_valid(child_ig)) {
> -		dev_dbg(&cxlr->dev,
> -			"%s: invalid granularity calculation (%d * %d)\n",
> -			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return -EINVAL;
> -	}
> -
> -	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s:%s: ways: %d overflows targets: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
> -		return -ENXIO;
> -	}
> -
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != child_iw ||
>  		    (child_iw > 1 && cxld->interleave_granularity != child_ig) ||

