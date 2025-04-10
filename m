Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA79E21324E;
	Thu, 10 Apr 2025 16:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744302387; cv=none; b=iUvbqTHOP8Lv/A9lCHT/7GllzjdoeqKZvHTd2n02/ku+X3AOWOM9wnRU5Srqv5Unjk0/vr9Sf/GISvBr8uQ92M5iMG5Ah6jxFceKaP6DLwdRRwEtnuRSwpBC2TJ4p9p8NFE7ihj1Xzl1zI1sVLCUOb2UvUeoN2w+laQlzHOmG0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744302387; c=relaxed/simple;
	bh=4PguwaFAXOUDYKLsldD8hprnRinLS29L76LJbAXk37o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=py/VqoPfX+nxFD9eVk196lOuAd3HYhPm67L13F2718ZRbegXiWEQjNLorur7UTD+uvNzODTYnHxnO6CuK/rEZIYTVQX4NZMCvZS7aQiMsh/KD7lQyD+mSeIl3s9Ann7M8vkErFMWszFO1sMZlbUXsJb3TGE9mrJsCqvO1jlFR2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Cli/O/J8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Cli/O/J8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744302386; x=1775838386;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=4PguwaFAXOUDYKLsldD8hprnRinLS29L76LJbAXk37o=;
  b=Cli/O/J8xRrtchxD9IVPc1VwxNKuEbcEV88QbhRYNeK8Ogtkc0IfgeTT
   tiuyOE5Hjs5UcWNCJ/WIQA4Xj+21mUObwZNq6tmyOherEaQaMNAOUK7XO
   /rQ8LBPTBsVIp9vFLVXgL9hvwwS27yim+NfCHs+7qZTCZHvrlKfsbN1Da
   qQTa7E48GASl6NPdhr1ZNE8GlWBUWqg72IyMabW4erq+XIQZrt37K7oDC
   WN+K/9tOQgCwRKQqN3ef2rs3fjLireRkgmsbPvqudeVlUZ01+RHwiN3KD
   IrpPIQ9j+NJgCvuaOaguRMImAi4AOnFicK+jPWO/yiB+/UwvnQWSHvb5O
   g==;
X-CSE-ConnectionGUID: 0ODhkfrPRDOtXK8QvM1toA==
X-CSE-MsgGUID: 7MI3zzoxQxmpCRXrGbV7SQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11400"; a="45726266"
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="45726266"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:26:26 -0700
X-CSE-ConnectionGUID: XcvdZQA0SMCR8Ax4YwbLFw==
X-CSE-MsgGUID: YRWvO29RT0K9EwoXfOlNIA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,202,1739865600"; 
   d="scan'208";a="166148824"
Received: from iherna2-mobl4.amr.corp.intel.com (HELO [10.125.108.92]) ([10.125.108.92])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2025 09:26:24 -0700
Message-ID: <4792da6c-f7f7-414b-9725-5cb74e81a6ea@intel.com>
Date: Thu, 10 Apr 2025 09:26:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl: core/region - ignore interleave granularity when
 ways=1
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com, ira.weiny@intel.com
References: <20250402232552.999634-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250402232552.999634-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/25 4:25 PM, Gregory Price wrote:
> When validating decoder IW/IG when setting up regions, the granularity
> is irrelevant when iw=1 - all accesses will always route to the only
> target anyway - so all ig values are "correct". Loosen the requirement
> that `ig = (parent_iw * parent_ig)` when iw=1.
> 
> On some Zen5 platforms, the platform BIOS specifies a 256-byte
> interleave granularity window for host bridges when there is only
> one target downstream.  This leads to Linux rejecting the configuration
> of a region with a x2 root with two x1 hostbridges.
> 
> Decoder Programming:
>    root - iw:2 ig:256
>    hb1  - iw:1 ig:256  (Linux expects 512)
>    hb2  - iw:1 ig:256  (Linux expects 512)
>    ep1  - iw:2 ig:256
>    ep2  - iw:2 ig:256
> 
> This change allows all decoders downstream of a passthrough decoder to
> also be configured as passthrough (iw:1 ig:X), but still disallows
> downstream decoders from applying subsequent interleaves.
> 
> e.g. in the above example if there was another decoder south of hb1
> attempting to interleave 2 endpoints - Linux would enforce hb1.ig=512
> because the southern decoder would have iw:2 and require ig=pig*piw.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Applied to cxl/next, with fixup against 6.15-rc1

> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 04bc6cad092c..dec262eadf9a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1553,7 +1553,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  
>  	if (test_bit(CXL_REGION_F_AUTO, &cxlr->flags)) {
>  		if (cxld->interleave_ways != iw ||
> -		    cxld->interleave_granularity != ig ||
> +		    (iw > 1 && cxld->interleave_granularity != ig) ||
>  		    cxled->spa_range.start != p->res->start ||
>  		    cxled->spa_range.end != p->res->end ||
>  		    ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)) {

