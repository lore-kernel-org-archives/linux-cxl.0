Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA7F2FF17A
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jun 2026 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780673910; cv=none; b=cUdiQ6ZIHJM6IY0JZQjsAKN1JNHmQe+ub+7U3Io7bmbq7A214D/rfRmbm3qhnRmJYY+HVwguz2tfYogQs0doKGhl7lDGjEf1bOtd132NzzZ8RpsQ2rCkjF5EpmubkUStYXrhkYijiAtQwlAPzc84tsVMcL6t9yh7S50M+eSNWr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780673910; c=relaxed/simple;
	bh=OPFmwMKQhA5mQbqdM5lwCEJ2YTNH+9bT9leD1saW2w4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a9nTQej3KVwst5NZWd8ACZSBvTNGI1u5x2GemQSWFPFS4gKONW/87kMINovU3xS62EBfaq7zoCbB9fYJG26HX6Q+eP51+Ex6hz7mPLODVuuQcylMbWZHG6lsqvxLGA2fJ5vwx1Xuz92GN7i4uZAgwWOcz0ddedDj6cuv37vl3c8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mOLMzGMw; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mOLMzGMw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780673909; x=1812209909;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=OPFmwMKQhA5mQbqdM5lwCEJ2YTNH+9bT9leD1saW2w4=;
  b=mOLMzGMwIX4jU1J6VS8szveIug7tNWgeTb9RSEVxD2q67KqHYkoblxEq
   2t1fsgV4uX76QQVWK0XFJVYYTGZrxZMXoIUFNw5T4aPKmghB6GEopmKyy
   V8+H3IuGPF2PnmXnHouuq52hBuyGBIlc+4bwg8XEXeHrAST63tU8r3usD
   aHs40GXcUGS5jbfR87TBHqNjtvDZdv0/rwPmC8+AplkPxOBlj01UerK22
   RuIBdrEfcoZXpY8pchW3/eaOwcZgAyLE6A0O5DF+bkGGUE6O3DiDVZPyw
   6b1CA8KBXDU9P8BkYXZm7nhUrqWMjpoMcKtAesnFJdlYVW8XPhHx7psei
   A==;
X-CSE-ConnectionGUID: CQYxZmV0RgCXtXCDj4HbgQ==
X-CSE-MsgGUID: JEwgmno5R+GbtPxUH4XJBA==
X-IronPort-AV: E=McAfee;i="6800,10657,11808"; a="92996040"
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="92996040"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:38:28 -0700
X-CSE-ConnectionGUID: O9g1cyH7SayhA1jjQrLEKg==
X-CSE-MsgGUID: BhxluuvSRtyn7WGj8244/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,189,1774335600"; 
   d="scan'208";a="242400746"
Received: from jmaxwel1-mobl.amr.corp.intel.com (HELO [10.125.109.36]) ([10.125.109.36])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2026 08:38:26 -0700
Message-ID: <df9919ec-a776-4986-b1c9-a78bd4134bea@intel.com>
Date: Fri, 5 Jun 2026 08:38:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/region: Avoid variable shadowing in region attach
 paths
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron <jic23@kernel.org>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <iweiny@kernel.org>,
 Dan Williams <djbw@kernel.org>, Li Ming <ming.li@zohomail.com>
Cc: linux-cxl@vger.kernel.org
References: <20260605040504.865728-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260605040504.865728-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/4/26 9:05 PM, Alison Schofield wrote:
> A couple of symbol declarations shadow earlier variables in the region
> attach paths. Shadowing makes it harder to tell which object is being
> referenced and can obscure future bugs.
> 
> Reuse the existing 'cxld' variable in cxl_port_attach_region() and
> rename the endpoint decoder iterator in cxl_region_attach() to avoid
> shadowing the function parameter.
> 
> No functional change.
> 
> Found with sparse.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e50dc716d4e8..819392c8f753 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1224,8 +1224,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  			nr_targets_inc = true;
>  		}
>  	} else {
> -		struct cxl_decoder *cxld;
> -
>  		cxld = cxl_port_pick_region_decoder(port, cxled, cxlr);
>  		if (!cxld) {
>  			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> @@ -2189,14 +2187,14 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	 * will fail when presented as CXL_REGION_F_AUTO.
>  	 */
>  	for (int i = 0; i < p->nr_targets; i++) {
> -		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_endpoint_decoder *target = p->targets[i];
>  		int test_pos;
>  
> -		test_pos = cxl_calc_interleave_pos(cxled, &cxlr->hpa_range);
> -		dev_dbg(&cxled->cxld.dev,
> -			"Test cxl_calc_interleave_pos(): %s test_pos:%d cxled->pos:%d\n",
> -			(test_pos == cxled->pos) ? "success" : "fail",
> -			test_pos, cxled->pos);
> +		test_pos = cxl_calc_interleave_pos(target, &cxlr->hpa_range);
> +		dev_dbg(&target->cxld.dev,
> +			"Test cxl_calc_interleave_pos(): %s test_pos:%d target->pos:%d\n",
> +			(test_pos == target->pos) ? "success" : "fail",
> +			test_pos, target->pos);
>  	}
>  
>  	return 0;
> 
> base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731

