Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1AE3D25CC
	for <linux-cxl@vger.kernel.org>; Fri,  9 Oct 2026 22:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791584065; cv=none; b=PxjUUiPKD9bljnmMeI1NyTyGWMfVFpIfa2UC3en3byOS8r/NY0hWZA2iFzGOlZDHsLGzWWXrXgPG3lQlXXAiKvXvGf0h8Bzv7Bz4+kCvxhSqsLS3bd2doLDBIGjasbsJlkh31qdw427A0Qfkdp/mHlhNHSzuJHq5X/evRfL+pyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791584065; c=relaxed/simple;
	bh=tIq2fO7uRYeEUS7Tv/JgJaH9z/sydq9QSgQ77tlIlrQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OywsxnptuDdCLM2gLp6lbZM1x4vtIP6fK104d9PNUCjgLz+XYLZFrYylSe8/eJbf/NT0xvZsFME852epiYr4SS68XPvWF8tX36LkZYBug9guCd7QmnbPBJkV4fj1kTttq0mma2Zh0Q82p7NFkRYIqFFvSjlPDhBtEpg1XSd8kpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijcT/qe9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijcT/qe9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791584064; x=1823120064;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=tIq2fO7uRYeEUS7Tv/JgJaH9z/sydq9QSgQ77tlIlrQ=;
  b=ijcT/qe97GMh8hJhSxMfXHSGsQre8A885koUfM5nFE/LfosfziRr8APd
   En6rSqZ+2UtI02C7/XeRrJggdsy26hlo/zuGw1PXC11PpuYGSpeD0pRMV
   xo8FfWgN7NlXn/64c5wjrjzMMsFu3RnhV7GswCS3OIknj0uLYuTDtRxAI
   Qb6XdrAJp6pBtowW2llKZzSjtBUIjhsxh+S0GSWQ0mgQWhmZNyDs4aFNp
   BXjf3DVMi+pdTM3nTn/RrlFcHpEz0SK4lhrn7MGjtvs8Qa4k7E8y0tz84
   UBoKcbdt9Nw2MRegW4a8hH2Tzt+tIdn4BgODoP5zR/HIRJm1Mvgmi4XQ4
   A==;
X-CSE-ConnectionGUID: TiNEVtjMTu2dB0T0xDZIVw==
X-CSE-MsgGUID: fiin6SBDSAiOzgynJcQWJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11930"; a="288700"
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="288700"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:14:23 -0700
X-CSE-ConnectionGUID: cQ2jkzqfTaWZjOIhLaA/1w==
X-CSE-MsgGUID: r4iLEm9yTbeOTX7fi4oOJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,149,1787036400"; 
   d="scan'208";a="399908"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.109.123]) ([10.125.109.123])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 15:14:23 -0700
Message-ID: <42474778-af6f-4261-805d-a7dffe365e52@intel.com>
Date: Fri, 9 Oct 2026 15:14:21 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] cxl: Add interleave encoding validity helpers
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Li Ming <ming.li@zohomail.com>, Richard Cheng <icheng@nvidia.com>,
 Robert Richter <rrichter@amd.com>
Cc: linux-cxl@vger.kernel.org,
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
References: <cover.1791575481.git.alison.schofield@intel.com>
 <3c95aa7ab34dfa267ec5e37f28f890d1b2604713.1791575481.git.alison.schofield@intel.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <3c95aa7ab34dfa267ec5e37f28f890d1b2604713.1791575481.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 10/9/26 1:24 PM, Alison Schofield wrote:
> Some callers of ways_to_eiw(), granularity_to_eig(), and
> eig_to_granularity() only need to determine whether an input is valid,
> but must provide storage for a converted value that is then discarded.
> This obscures the purpose of the call and requires unnecessary temporary
> variables.
> 
> Define and use new helpers that provide a validation-only interface for
> those callers.
> 
> cxl_port_setup_targets() also encodes and then decodes its calculated
> granularity solely to validate it. Calculate the granularity directly
> and validate it instead, making the calculation explicit and removing
> the encode/decode round trip.
> 
> No functional change.
> 
> Suggested-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 49 +++++++++++++--------------------------
>  drivers/cxl/cxl.h         | 21 +++++++++++++++++
>  2 files changed, 37 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a048bd5c06cb..bc087ca63946 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -493,11 +493,9 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
>  	int save, rc;
> -	u8 iw;
>  
> -	rc = ways_to_eiw(val, &iw);
> -	if (rc)
> -		return rc;
> +	if (!ways_valid(val))
> +		return -EINVAL;
>  
>  	/*
>  	 * Even for x3, x6, and x12 interleaves the region interleave must be a
> @@ -566,12 +564,9 @@ static int set_interleave_granularity(struct cxl_region *cxlr, int val)
>  	struct cxl_root_decoder *cxlrd = cxlr->cxlrd;
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc;
> -	u16 ig;
>  
> -	rc = granularity_to_eig(val, &ig);
> -	if (rc)
> -		return rc;
> +	if (!granularity_valid(val))
> +		return -EINVAL;
>  
>  	/*
>  	 * When the host-bridge is interleaved, disallow region granularity !=
> @@ -1451,8 +1446,6 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  	struct cxl_switch_decoder *cxlsd;
>  	struct cxl_port *iter = port;
> -	u16 eig, peig;
> -	u8 eiw, peiw;
>  
>  	/*
>  	 * While root level decoders support x3, x6, x12, switch level
> @@ -1524,48 +1517,38 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	rc = granularity_to_eig(parent_ig, &peig);
> -	if (rc) {
> +	if (!granularity_valid(parent_ig)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
>  			dev_name(parent_port->uport_dev),
>  			dev_name(&parent_port->dev), parent_ig);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
> -	rc = ways_to_eiw(parent_iw, &peiw);
> -	if (rc) {
> +	if (!ways_valid(parent_iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
>  			dev_name(parent_port->uport_dev),
>  			dev_name(&parent_port->dev), parent_iw);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	iw = cxl_rr->nr_targets;
> -	rc = ways_to_eiw(iw, &eiw);
> -	if (rc) {
> +	if (!ways_valid(iw)) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid port interleave: %d\n",
>  			dev_name(port->uport_dev), dev_name(&port->dev), iw);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	/*
>  	 * Interleave granularity is a multiple of @parent_port granularity.
>  	 * Multiplier is the parent port interleave ways.
>  	 */
> -	rc = granularity_to_eig(parent_ig * parent_iw, &eig);
> -	if (rc) {
> +	ig = parent_ig * parent_iw;
> +
> +	if (!granularity_valid(ig)) {
>  		dev_dbg(&cxlr->dev,
>  			"%s: invalid granularity calculation (%d * %d)\n",
>  			dev_name(&parent_port->dev), parent_ig, parent_iw);
> -		return rc;
> -	}
> -
> -	rc = eig_to_granularity(eig, &ig);
> -	if (rc) {
> -		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
> -			dev_name(port->uport_dev), dev_name(&port->dev),
> -			256 << eig);
> -		return rc;
> +		return -EINVAL;
>  	}
>  
>  	if (iw > 8 || iw > cxlsd->nr_targets) {
> @@ -3131,13 +3114,13 @@ static bool cxl_is_hpa_in_chunk(u64 hpa, struct cxl_region *cxlr, int pos)
>   */
>  int cxl_validate_translation_params(u8 eiw, u16 eig, int pos)
>  {
> -	int ways, gran;
> +	int ways;
>  
>  	if (eiw_to_ways(eiw, &ways)) {
>  		pr_debug("%s: invalid eiw=%u\n", __func__, eiw);
>  		return -EINVAL;
>  	}
> -	if (eig_to_granularity(eig, &gran)) {
> +	if (!eig_valid(eig)) {
>  		pr_debug("%s: invalid eig=%u\n", __func__, eig);
>  		return -EINVAL;
>  	}
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f03ee0addc45..4c9173e07f1f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -146,6 +146,27 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
>  	return 0;
>  }
>  
> +static inline bool eig_valid(u16 eig)
> +{
> +	int granularity;
> +
> +	return eig_to_granularity(eig, &granularity) == 0;
> +}
> +
> +static inline bool granularity_valid(int granularity)
> +{
> +	u16 eig;
> +
> +	return granularity_to_eig(granularity, &eig) == 0;
> +}
> +
> +static inline bool ways_valid(unsigned int ways)
> +{
> +	u8 eiw;
> +
> +	return ways_to_eiw(ways, &eiw) == 0;
> +}
> +
>  /* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
>  #define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
>  #define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))

