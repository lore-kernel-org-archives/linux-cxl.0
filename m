Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D199A13A258
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791586115; cv=none; b=fcIXIKrv8aOhCCBlG40jVnQABEYF3H2WDXNCkXzvKkQtZ+1m/swk78wp9fvwuVYkaw99o6ndp5hhjo7C6YM/InweTnOyTIbwRru1OsQG/MSuDRLg8EsDHIAjcLlMNw99YKe13x/mBC62GAPMhIHTQcv1HlWEWV3M8lZij0LHISs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791586115; c=relaxed/simple;
	bh=jF5IxG/BsYy3tBvMWKElUKd/2ZEgH0UIx0PNl/4Un5I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JsXjoNoZWmDPZgrcIh/yX5sJ9x/spOt2g0+ubammVCzG7LML9ojlv1EfxBlyOkwuzr5Ysfv34tLKHVH+WeW/xGXuppE05CGveOlVboN+5ViqR6JazvPD7n1SvTrBJvFucrJLnVMgJQMHLJ1ClNDTu82a5lHxPBBgNO5uYiF24Qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DgytQHqB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DgytQHqB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791586114; x=1823122114;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jF5IxG/BsYy3tBvMWKElUKd/2ZEgH0UIx0PNl/4Un5I=;
  b=DgytQHqBGtOASs6+LFgyEbziweirVML7W8rV4ty31dUzE1XkerlbQFpb
   XSq80FI+qk8oaIx9oDX40ufMEirnixiFMkwTUQNicM3dipDETLvyHRbI0
   O5IwbMrrgAz/mKuiYjldap8SHRMLxeHmiCEjDQfcAYzioeXBcQ0QdQ9S/
   fms9GHsNIJny8f+mHhomfJukVT67PKbuvJt2Df+HZloe7g1ak9xTWHr0P
   UcgfljoyL2NbwezeN2rbOC+9cw4sN4HkrcqdH3m3T/dHcQIybWXRjv2fl
   37duDFsw7DgcD8Z7Xhv667B6DPoc1bOZy3dKRcHA/dUJsnI0hkk7UHpe+
   Q==;
X-CSE-ConnectionGUID: N6fIF7T1Rsm0Ai78etGNmA==
X-CSE-MsgGUID: OVfakFs0SzeBUZe58mLLWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="417105"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="417105"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:48:33 -0700
X-CSE-ConnectionGUID: oT9w31gWTT+qlXbVzt7lEg==
X-CSE-MsgGUID: 4eYw17GvRB+OYyUPzoDk2w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="395057"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:48:33 -0700
Message-ID: <9030cf98-ac5d-484e-b124-4278963af304@intel.com>
Date: Fri, 9 Oct 2026 15:48:31 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] cxl/region: Factor out cxl_port_add_target()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791575481.git.alison.schofield@intel.com>
 <a9855ed2663c8f93ac4b1c881eefe3c301dfc39c.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <a9855ed2663c8f93ac4b1c881eefe3c301dfc39c.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> cxl_port_setup_targets() adds an endpoint's downstream port to a port's
> decoder target list. For an auto region it checks that the decoder already
> targets that downstream port at the next position. For a user created
> region it programs the downstream port at that position. That step is open
> coded behind an add_target label that the target search jumps to.
> 
> Move that step to a new helper, cxl_port_add_target(). With the decoder
> setup and the target add now in helpers, the path for the first endpoint to
> reach a port becomes an else branch of the target search, so the add_target
> label is no longer needed.
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 82 ++++++++++++++++++++++++---------------
>  1 file changed, 51 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4e9b0880663d..abe5fcc62e9d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1608,15 +1608,50 @@ static int cxl_port_setup_decoder(struct cxl_port *port, struct cxl_region *cxlr
>  	return 0;
>  }
>  
> +static int cxl_port_add_target(struct cxl_port *port, struct cxl_region *cxlr,

This is only switch port right? Maybe just pass in cxlsd instead of port and name it cxl_switch_port_add_target()?

DJ

> +			       struct cxl_region_ref *cxl_rr,
> +			       struct cxl_endpoint_decoder *cxled, struct cxl_ep *ep)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_switch_decoder *cxlsd;
> +	int pos = cxled->pos;
> +
> +	cxlsd = to_cxl_switch_decoder(&cxl_rr->decoder->dev);
> +	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: targets full trying to add %s:%s at %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> +		return -ENXIO;
> +	}
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> +			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> +				dev_name(port->uport_dev), dev_name(&port->dev),
> +				dev_name(&cxlsd->cxld.dev),
> +				dev_name(ep->dport->dport_dev),
> +				cxl_rr->nr_targets_set);
> +			return -ENXIO;
> +		}
> +	} else {
> +		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> +		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] =
> +			ep->dport->port_id;
> +	}
> +	cxl_rr->nr_targets_set++;
> +
> +	return 0;
> +}
> +
>  static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,
>  				  struct cxl_endpoint_decoder *cxled)
>  {
> -	int child_iw, child_ig, rc, pos = cxled->pos;
>  	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
> +	int rc, pos = cxled->pos;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1641,38 +1676,23 @@ static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr
>  					return rc;
>  				goto out_target_set;
>  			}
> -		goto add_target;
> -	}
> -
> -	rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw, &child_ig);
> -	if (rc)
> -		return rc;
> -
> -	rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw, child_ig);
> -	if (rc)
> -		return rc;
> -add_target:
> -	if (cxl_rr->nr_targets_set == cxl_rr->nr_targets) {
> -		dev_dbg(&cxlr->dev,
> -			"%s:%s: targets full trying to add %s:%s at %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), pos);
> -		return -ENXIO;
> -	}
> -	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> -		if (cxlsd->target[cxl_rr->nr_targets_set] != ep->dport) {
> -			dev_dbg(&cxlr->dev, "%s:%s: %s expected %s at %d\n",
> -				dev_name(port->uport_dev), dev_name(&port->dev),
> -				dev_name(&cxlsd->cxld.dev),
> -				dev_name(ep->dport->dport_dev),
> -				cxl_rr->nr_targets_set);
> -			return -ENXIO;
> -		}
>  	} else {
> -		cxlsd->target[cxl_rr->nr_targets_set] = ep->dport;
> -		cxlsd->cxld.target_map[cxl_rr->nr_targets_set] = ep->dport->port_id;
> +		int child_iw, child_ig;
> +
> +		rc = cxl_port_calc_interleave(port, cxlr, cxl_rr, &child_iw,
> +					      &child_ig);
> +		if (rc)
> +			return rc;
> +
> +		rc = cxl_port_setup_decoder(port, cxlr, cxld, child_iw,
> +					    child_ig);
> +		if (rc)
> +			return rc;
>  	}
> -	cxl_rr->nr_targets_set++;
> +
> +	rc = cxl_port_add_target(port, cxlr, cxl_rr, cxled, ep);
> +	if (rc)
> +		return rc;
>  out_target_set:
>  	dev_dbg(&cxlr->dev, "%s:%s target[%d] = %s for %s:%s @ %d\n",
>  		dev_name(port->uport_dev), dev_name(&port->dev),

