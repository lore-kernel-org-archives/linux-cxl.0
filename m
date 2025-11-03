Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3739428C871;
	Mon,  3 Nov 2025 21:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762206726; cv=none; b=q/NngKScuMH07Uv3cHsXCsvTyOarRo7h6LDuPd8Qi+bRJmvmG9Ilag4LaSHUYsD5POEOCQH3Pu8feLdhLZKGVafOEIZehq5+ilA8cho8WZMdTdPo+VfaViRi9+GNR9ragjRm7yMhZOaUBRWgAfnqfjkURXSJdAVhgrylNj0/Qz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762206726; c=relaxed/simple;
	bh=G650CcctKviHrpBbtXZF9/tV8M+ZyEG/5CgFWIMxRSQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=C8lHpZdzBDs1VzWmkgC8M1D27DRjC3rMe/cCg7SgT6aEuR1cKnNLgIYkUYUhMCUYuhfWhz4OGsa4BlaaxiHOZmM+ue4I3hLk6PLvrsGKkUVnN8raXG3TRKXa+mOwbux/odXkBl/Do9KtIBuNYHh1CgQoo1q4CFkU0mAnJs1DJSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=av1Sa24X; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="av1Sa24X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762206724; x=1793742724;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=G650CcctKviHrpBbtXZF9/tV8M+ZyEG/5CgFWIMxRSQ=;
  b=av1Sa24XN23jCu+B0+CDQ1VPWI3Ld7S6cPlRgOBE316fkvq8AMU1B090
   43xRcmk4gjWIlmaGNJxAdto8snytS1F4MZ+QCea8RRaa7bG8XBzgCzg2J
   HgFHTBlJrNr80a2GQp2U0DX3yAO97y1QTs18szlq2IK9HKAVAhlERNRhk
   7ObxMNJvl/09iJsd9uj7UGKNvLCd8gQqPhUpN8d4qui5Z7kLajgzMdFs7
   Kgs/durfbeqStuXg5zRWmgcq4cnoNAUpXKIhgmBXEo+8QRYGpUCU9dCkm
   RfodsCAb/DkXPl6CT8K6Ii+UNcTyns+MLyUhn5PWEYVyBlhqf64oe38fy
   w==;
X-CSE-ConnectionGUID: X065Zu5uR/mXsgeT5dEEOg==
X-CSE-MsgGUID: xLsFedVWSV6jLbAuwEgeQQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="75645470"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="75645470"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:52:04 -0800
X-CSE-ConnectionGUID: zE+DtD8CRjmgagUg7pmUAQ==
X-CSE-MsgGUID: JyTJB3WKTkC+lN8UwpeX0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186658446"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:52:02 -0800
Message-ID: <df23145b-b088-4131-ba23-6f63a4c49de0@intel.com>
Date: Mon, 3 Nov 2025 14:52:01 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/14] cxl/region: Add @hpa_range argument to function
 cxl_calc_interleave_pos()
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>, Joshua Hahn <joshua.hahnjy@gmail.com>
References: <20251103184804.509762-1-rrichter@amd.com>
 <20251103184804.509762-5-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-5-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> cxl_calc_interleave_pos() uses the endpoint decoder's HPA range to
> determine its interleaving position. This requires the endpoint
> decoders to be an SPA, which is not the case for systems that need
> address translation.
> 
> Add a separate @hpa_range argument to function
> cxl_calc_interleave_pos() to specify the address range. Now it is
> possible to pass the SPA translated address range of an endpoint
> decoder to function cxl_calc_interleave_pos().
> 
> Refactor only, no functional changes.
> 
> Patch is a prerequisite to implement address translation.
> 
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Signed-off-by: Robert Richter <rrichter@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  drivers/cxl/core/region.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index bb889c891cf7..d3557d9d5b0f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1845,11 +1845,11 @@ static int find_pos_and_ways(struct cxl_port *port, struct range *range,
>   * Return: position >= 0 on success
>   *	   -ENXIO on failure
>   */
> -static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
> +static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled,
> +				   struct range *hpa_range)
>  {
>  	struct cxl_port *iter, *port = cxled_to_port(cxled);
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct range *range = &cxled->cxld.hpa_range;
>  	int parent_ways = 0, parent_pos = 0, pos = 0;
>  	int rc;
>  
> @@ -1887,7 +1887,8 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  		if (is_cxl_root(iter))
>  			break;
>  
> -		rc = find_pos_and_ways(iter, range, &parent_pos, &parent_ways);
> +		rc = find_pos_and_ways(iter, hpa_range, &parent_pos,
> +				       &parent_ways);
>  		if (rc)
>  			return rc;
>  
> @@ -1897,7 +1898,7 @@ static int cxl_calc_interleave_pos(struct cxl_endpoint_decoder *cxled)
>  	dev_dbg(&cxlmd->dev,
>  		"decoder:%s parent:%s port:%s range:%#llx-%#llx pos:%d\n",
>  		dev_name(&cxled->cxld.dev), dev_name(cxlmd->dev.parent),
> -		dev_name(&port->dev), range->start, range->end, pos);
> +		dev_name(&port->dev), hpa_range->start, hpa_range->end, pos);
>  
>  	return pos;
>  }
> @@ -1910,7 +1911,7 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  
> -		cxled->pos = cxl_calc_interleave_pos(cxled);
> +		cxled->pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		/*
>  		 * Record that sorting failed, but still continue to calc
>  		 * cxled->pos so that follow-on code paths can reliably
> @@ -2094,7 +2095,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled);
> +		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
>  		dev_dbg(&cxled->cxld.dev,
>  			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
>  			(test_pos == cxled->pos) ? "success" : "fail",

