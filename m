Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AD423E5A32
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584639; cv=none; b=Bn11lkR4DK5qAjnw1Q+NSN158NvMNNlpLvOT9pc3N6BkrfFbsDR3joQJfh0j+XLKdTyJUDBPXq8Hyv/fP3qZzPMuN6+NP69UAMV6DdSaM9kdw2QCwB2YftHiIeTbV1cbjeM/fF34QQScjoAty8He1LiafdlkFxON9rPYEivaDao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584639; c=relaxed/simple;
	bh=Y0tlRfBryXtOgSGnPWjAMeQ7QOwjf5wNMaz/SNK/LOo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HBlMgvQEtzaziFHuW/iMLcrN7SyKoyzkOEiW2na2xEpu4XnQdT5GX5+I6083X8Izp477qD7Zd3whMDlZ6isqyRDmnlW/J/YTPosqwf9S9/WqDLZVS4rQILwLAaELu2V00XpxiBsYNUCFCVe4B8vAzcM2VTl+m/TbCwMuI3ho+bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mu6vyPDf; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mu6vyPDf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791584638; x=1823120638;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Y0tlRfBryXtOgSGnPWjAMeQ7QOwjf5wNMaz/SNK/LOo=;
  b=mu6vyPDfEZl2sV2TCzicboHbzfTaAnxCHd3L7Mn9cP+iL6lPo73Nonw8
   06r/CAxg46mDlGn6IrXvIJQfqWzx7tdzn7d9DluaMooiUnXXgN4zR8jjx
   aICyCN2TQDYC/52DmvvoioRMG0AIzxEHBG3PRC+sq5hu39rebfsO59+NS
   A2hZqPC7P4GuK0la5NpMqCm5vUhXgGOX2iKTQqHNfW0ve9CRPNE52UPgP
   HcFw1kwOKdsTtsZ3Nvtk1hjvPs8cQci4puuZ4p8IFSWZSbgrun9wA8Y0a
   1WLMI82mZAzyfpqh7Bd25XTyeqz6BZmsDW/+Wedk8SjDXRXwKfMhbSLFv
   w==;
X-CSE-ConnectionGUID: NMEywk3OTcGttLVa8AXrqA==
X-CSE-MsgGUID: CPjsQ9/hTei1nInX46kXbQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="277156"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="277156"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:23:58 -0700
X-CSE-ConnectionGUID: 49B6vJaKRGSg7twwwYGyrA==
X-CSE-MsgGUID: jBgUJjkGQTGc/ixDimdcpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="401225"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:23:57 -0700
Message-ID: <467f3347-d8d7-4170-aded-c1a39fab2807@intel.com>
Date: Fri, 9 Oct 2026 15:23:55 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] cxl/region: Name the interleave locals in
 cxl_port_setup_targets()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1791575481.git.alison.schofield@intel.com>
 <c3ed0302abf8206225d2482caa63bbb1dd0b9a07.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <c3ed0302abf8206225d2482caa63bbb1dd0b9a07.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> cxl_port_setup_targets() derives the interleave granularity of one decoder
> from the granularity and ways of the decoder above it, and takes that
> decoder's own ways from the topology below it. The values from the level
> above are named parent_iw and parent_ig, but the values being derived are
> the bare iw and ig, so the reader has to work out which level each one
> describes.
> 
> Rename iw and ig to child_iw and child_ig to match the parent_ prefix used
> for the level above.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 32 ++++++++++++++++----------------
>  1 file changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bc087ca63946..1a42753fda48 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1437,7 +1437,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, ig, iw, rc, pos = cxled->pos;
> +	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -1531,10 +1531,10 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return -EINVAL;
>  	}
>  
> -	iw = cxl_rr->nr_targets;
> -	if (!ways_valid(iw)) {
> +	child_iw = cxl_rr->nr_targets;
> +	if (!ways_valid(child_iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +			dev_name(port->uport_dev), dev_name(&port->dev), child_iw);
>  		return -EINVAL;
>  	}
>  
> @@ -1542,32 +1542,32 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	ig = parent_ig * parent_iw;
> +	child_ig = parent_ig * parent_iw;
>  
> -	if (!granularity_valid(ig)) {
> +	if (!granularity_valid(child_ig)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s: invalid granularity calculation (%d * %d)\n",
>  			dev_name(&parent_port->dev), parent_ig, parent_iw);
>  		return -EINVAL;
>  	}
>  
> -	if (iw > 8 || iw > cxlsd->nr_targets) {
> +	if (child_iw > 8 || child_iw > cxlsd->nr_targets) {
>  		dev_dbg(&cxlr->dev,
>  			"%s:%s:%s: ways: %d overflows targets: %d\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxld->dev), iw, cxlsd->nr_targets);
> +			dev_name(&cxld->dev), child_iw, cxlsd->nr_targets);
>  		return -ENXIO;
>  	}
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		if (cxld->interleave_ways != iw ||
> -		    (iw > 1 && cxld->interleave_granularity != ig) ||
> +		if (cxld->interleave_ways != child_iw ||
> +		    (child_iw > 1 && cxld->interleave_granularity != child_ig) ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s expected iw: %d ig: %d %pr\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
> -				__func__, iw, ig, p->res);
> +				__func__, child_iw, child_ig, p->res);
>  			dev_err(&cxlr->dev,
>  				"%s:%s %s got iw: %d ig: %d state: %s %#llx:%#llx\n",
>  				dev_name(port->uport_dev), dev_name(&port->dev),
> @@ -1578,24 +1578,24 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  			return -ENXIO;
>  		}
>  	} else {
> -		rc = check_interleave_cap(cxld, iw, ig);
> +		rc = check_interleave_cap(cxld, child_iw, child_ig);
>  		if (rc) {
>  			dev_dbg(&cxlr->dev,
>  				"%s:%s iw: %d ig: %d is not supported\n",
>  				dev_name(port->uport_dev),
> -				dev_name(&port->dev), iw, ig);
> +				dev_name(&port->dev), child_iw, child_ig);
>  			return rc;
>  		}
>  
> -		cxld->interleave_ways = iw;
> -		cxld->interleave_granularity = ig;
> +		cxld->interleave_ways = child_iw;
> +		cxld->interleave_granularity = child_ig;
>  		cxld->hpa_range = (struct range) {
>  			.start = p->res->start,
>  			.end = p->res->end,
>  		};
>  	}
>  	dev_dbg(&cxlr->dev, "%s:%s iw: %d ig: %d\n", dev_name(port->uport_dev),
> -		dev_name(&port->dev), iw, ig);
> +		dev_name(&port->dev), child_iw, child_ig);
>  add_target:
>  	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
>  		dev_dbg(&cxlr->dev,

