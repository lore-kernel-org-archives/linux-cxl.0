Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 514243B585D
	for <linux-cxl@vger.kernel.org>; Wed,  3 Jun 2026 23:51:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530710; cv=none; b=iNJwpTp44ag8oEgbKCheWMrn6jjGuuq2jCwUA17W8h/NY3ay1yH6uaaPshS7uMCYdXXf1r89JgiSnlWvqBRhQ1F1MT0K/GevyKYlU3d/bN3IDr0Y03WJ5Q0nRmqAjF4SKOFlXrp9DzEV4aL+8Bf8oo5qpC1f0cnJ8O18cBikEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530710; c=relaxed/simple;
	bh=a55Sp0bEwy2iXBVC537GUD9qVZfHCqmaA3j0BjTCCE8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fqrpJlxEIO60Fp6f8Uk0PvM4oYJIlwm5/a6Vlz46IEh7GJfbwledkSVbXz2AUe2zh8vauZ+94ZPZg/pFO1IzInbyrzYkrnsMb2p9eGkJOsFYvA2tp571v6Lo97snwemgWxZ1bhR8B4w8Lvv9IO7m6/RtaC4i7m9bF1gpBux4qgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=m59gtTdq; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="m59gtTdq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780530709; x=1812066709;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=a55Sp0bEwy2iXBVC537GUD9qVZfHCqmaA3j0BjTCCE8=;
  b=m59gtTdqD8fsmOUDV0C9kZ/f76SGJw+buj3GeWIyBo2qye9oGSLLZTiD
   gWRhXWX74inxK9ECHrNrLz8AY6Dhh1u5EUlc36YHEvtNcFpdV8g4xtYhN
   hnOyXRX07zL47oFR/8CAm8tENMyTuLGPIN15yfUcwEBhrz59rgW/o9lvn
   NZ+/I2sBexBrNMi0Pt2Y9YMzwcQnpT0dpHinDMpTqxxkiAeGYKxMwtT2Y
   efYWFFDS1x7/wu1fZB1VvZL3lhXB1Qg6nI557/2xXb+8CGnbPg2g+62Sc
   mtGvDDAisn6XOYHJ+ifTi8+wrXCABrH9W0UfIW0esjYxZ1TmVS/Hb9EDV
   Q==;
X-CSE-ConnectionGUID: aAVPNLDbR2KBVT4E/O8bOw==
X-CSE-MsgGUID: LhaWmXYETWSENCiwMWZARg==
X-IronPort-AV: E=McAfee;i="6800,10657,11806"; a="81330067"
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="81330067"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:51:48 -0700
X-CSE-ConnectionGUID: OENa2ydwSIK1xjpL3VY6QQ==
X-CSE-MsgGUID: uFY+S4ZTR0uR2Ws/USY8pA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,186,1774335600"; 
   d="scan'208";a="244499457"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.108.116]) ([10.125.108.116])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2026 16:51:47 -0700
Message-ID: <d9601c6e-b2a5-43fd-9cbd-641bda575dad@intel.com>
Date: Wed, 3 Jun 2026 16:51:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] cxl/region: Derive port granularity from selector
 bits
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1780095671.git.alison.schofield@intel.com>
 <4feca2a522e1e380495f22742551dec230ff0618.1780095671.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <4feca2a522e1e380495f22742551dec230ff0618.1780095671.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/29/26 5:00 PM, Alison Schofield wrote:
> Selector-bit validation uses a single same-granularity formula
> for user-created regions. Mixed-granularity layouts need the
> programmed granularity to depend on the type of decoder being
> configured.
> 
> Derive port granularity from the selector state:
> 
>   AUTO:    keep the firmware-programmed value; the walk validated it.
>   iw == 1: passthrough; consume no selector bits and span the parent
>            stride.
>   iw > 1:  claim the lowest selector bit still available to this
>            level.
> 
> This lets an interleaving switch beneath a mixed-granularity root
> claim an inner selector bit instead of colliding with the outer bit
> already owned by the root.
> 
> Add a final check that the derived selector fits within the
> remaining selector bits.
> 
> Originally-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 87fb1a9f2683..9d310287d48d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1548,7 +1548,23 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		goto add_target;
>  	}
>  
> -	ig = p->interleave_granularity * parent_distance;
> +	/*
> +	 * Auto regions keep the firmware value, passthrough decoders consume
> +	 * no selector bits, interleaving decoders claim the lowest available
> +	 * selector bit.
> +	 */
> +	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
> +		ig = cxld->interleave_granularity;
> +	} else if (iw == 1) {
> +		ig = p->interleave_granularity * parent_distance;
> +	} else if (selector) {
> +		ig = 1ULL << __ffs64(selector);
> +	} else {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: no selector bits available for iw %d\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> +		return -ENXIO;
> +	}
>  
>  	rc = ways_to_eiw(iw, &eiw);
>  	if (!rc)
> @@ -1560,6 +1576,14 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		return rc;
>  	}
>  
> +	if (iw > 1 && (~selector & get_selector(iw, ig))) {
> +		dev_dbg(&cxlr->dev,
> +			"%s:%s: derived selector %#llx exceeds remaining %#llx (iw %d ig %d)\n",
> +			dev_name(port->uport_dev), dev_name(&port->dev),
> +			get_selector(iw, ig), selector, iw, ig);
> +		return -ENXIO;
> +	}
> +
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
>  		    !spa_maps_hpa(p, &cxld->hpa_range) ||

