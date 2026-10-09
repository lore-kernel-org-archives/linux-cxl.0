Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1714037F73A
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791585587; cv=none; b=kBe/CVNqOzaAc1ncUI2sjvyOeiWnjXyiDFYKDXkUu5Z6zgdINpverS+KJlWTrM2kpr9yafeXOPJYZ9q/djydFzmLiwrjE4oUUHUqsYN0i2gXursjUHhJdziq1cqY0qURvfe9n4uV3pByzgZS0vKPv2Kl2uNdobgPHZnmaCpuZVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791585587; c=relaxed/simple;
	bh=dd7i09R28mWZn+x2M5VlXY2vxQcZ6YuUb2bHjAyzZl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OzT9Tp9RmBHqZ3G1/vF4CIC18krJD3tCIrw2I+PTR0pDrz1gB7xvq8YwzfswFXzudRKh+q2Z4MifeDctiefk9xELyH5iMM55A/VKH7rNyRv28aOBTG2Vf+zWvkSqNpZRAAAP7vt1u+GRLfS4E/MIOjGt7Od142uauML+4HWmgZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DUNWlnD2; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DUNWlnD2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791585585; x=1823121585;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=dd7i09R28mWZn+x2M5VlXY2vxQcZ6YuUb2bHjAyzZl8=;
  b=DUNWlnD2UP2nLgY+SajjteSayR46WtheUgl4NU0XokyNpdxWZiqY2X72
   umGnI6Fg5G36qSI1uL3KGXLwRzX3sONzdXAEvi52W0QWQhqRm/rIkklPg
   8CMKGRXhCHRA9oLlH8EhrovxRp2jD/Bz+cpb4YIOoVErGAwC9viL1BhQS
   VVxeMVs/hJRhPNdENz+wOOtPRcntMZgv2BMDwWAypyu62NPYA6EIg3SZu
   1OiAvY8f4HCcYMHm6BW9qlv4DdHe3xqV2dx9z2A7iG/K/PugtTxDaBd9s
   olr+Fl5uZJ3YsRMo3B21JMBFM4wzpoLhSz6bxLvrcWd7Yx7z8dNbevPUC
   g==;
X-CSE-ConnectionGUID: 29YZRLRURkyA4n6qWpxoxA==
X-CSE-MsgGUID: DXDwgxJ0S5qPtduGCskT8g==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="278119"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="278119"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:39:44 -0700
X-CSE-ConnectionGUID: tmKDvnbhRfW2v64qLh355g==
X-CSE-MsgGUID: +jyqWQWFQte4c7YUvvYm1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="393450"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:39:44 -0700
Message-ID: <e54ca303-18b7-46d0-b02d-832cf900651a@intel.com>
Date: Fri, 9 Oct 2026 15:39:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] cxl/region: Factor out cxl_port_parent_interleave()
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1791575481.git.alison.schofield@intel.com>
 <e0d73b783d15ef9bc39481934c86bd915be9c98f.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <e0d73b783d15ef9bc39481934c86bd915be9c98f.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> cxl_port_setup_targets() derives a decoder's interleave from the interleave
> of the decoder above it. That parent interleave comes from either the root
> decoder or a switch decoder, and each case is open coded along with the
> parent validity checks.
> 
> Move the parent interleave lookup and validation to a new helper,
> cxl_port_parent_interleave().
> 
> No functional change.
> 
> Assisted-by: LLM
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
>  drivers/cxl/core/region.c | 88 +++++++++++++++++++++++----------------
>  1 file changed, 52 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 80c40716c368..c1866b7b089b 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1459,45 +1459,13 @@ static int cxl_port_peer_distance(struct cxl_port *port, struct cxl_region *cxlr
>  	return distance;
>  }
>  
> -static int cxl_port_setup_targets(struct cxl_port *port,
> -				  struct cxl_region *cxlr,
> -				  struct cxl_endpoint_decoder *cxled)
> +static int cxl_port_parent_interleave(struct cxl_port *port, struct cxl_region *cxlr,
> +				      int *iw, int *ig)
>  {
> -	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
> -	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
>  	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> -	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_region_params *p = &cxlr->params;
> -	struct cxl_decoder *cxld = cxl_rr->decoder;
> -	struct cxl_switch_decoder *cxlsd;
> -
> -	/*
> -	 * While root level decoders support x3, x6, x12, switch level
> -	 * decoders only support powers of 2 up to x16.
> -	 */
> -	if (!is_power_of_2(cxl_rr->nr_targets)) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			cxl_rr->nr_targets);
> -		return -EINVAL;
> -	}
> -
> -	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> -	if (cxl_rr->nr_targets_set) {
> -		int distance = cxl_port_peer_distance(port, cxlr);
> -
> -		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> -			if (ep->dport == cxlsd->target[i]) {
> -				rc = check_last_peer(cxled, ep, cxl_rr,
> -						     distance);
> -				if (rc)
> -					return rc;
> -				goto out_target_set;
> -			}
> -		goto add_target;
> -	}
> +	int parent_iw, parent_ig;
>  
>  	if (is_cxl_root(parent_port)) {
>  		/*
> @@ -1539,6 +1507,54 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return -EINVAL;
>  	}
>  
> +	*iw = parent_iw;
> +	*ig = parent_ig;
> +
> +	return 0;
> +}
> +
> +static int cxl_port_setup_targets(struct cxl_port *port, struct cxl_region *cxlr,

Do we want to just rename it to cxl_switch_port_setup_targets() since the function basically is handling switch only?

DJ

> +				  struct cxl_endpoint_decoder *cxled)
> +{
> +	int parent_iw, parent_ig, child_iw, child_ig, rc, pos = cxled->pos;
> +	struct cxl_port *parent_port = to_cxl_port(port->dev.parent);
> +	struct cxl_region_ref *cxl_rr = cxl_rr_load(port, cxlr);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_switch_decoder *cxlsd;
> +
> +	/*
> +	 * While root level decoders support x3, x6, x12, switch level
> +	 * decoders only support powers of 2 up to x16.
> +	 */
> +	if (!is_power_of_2(cxl_rr->nr_targets)) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid target count %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			cxl_rr->nr_targets);
> +		return -EINVAL;
> +	}
> +
> +	cxlsd = to_cxl_switch_decoder(&cxld->dev);
> +	if (cxl_rr->nr_targets_set) {
> +		int distance = cxl_port_peer_distance(port, cxlr);
> +
> +		for (int i = 0; i < cxl_rr->nr_targets_set; i++)
> +			if (ep->dport == cxlsd->target[i]) {
> +				rc = check_last_peer(cxled, ep, cxl_rr,
> +						     distance);
> +				if (rc)
> +					return rc;
> +				goto out_target_set;
> +			}
> +		goto add_target;
> +	}
> +
> +	rc = cxl_port_parent_interleave(port, cxlr, &parent_iw, &parent_ig);
> +	if (rc)
> +		return rc;
> +
>  	child_iw = cxl_rr->nr_targets;
>  	if (!ways_valid(child_iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",

