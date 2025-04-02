Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32BBA4964E;
	Wed,  2 Apr 2025 19:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743623172; cv=none; b=qAM68S+RdSlOVXl34H9AlVZrSYdZsHf3usb0rDS/3d2vDpeRQrwZZHYxrKO9VCKp4fvL77qNz5IEx/frNc4b3cA7yGXsIbilnyum/1WA65aN+TNRBj9gr+GUgal7YT4REjRGf9yhgbIvjSK1GIV38IxM/735FtSU3zKXqimP+hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743623172; c=relaxed/simple;
	bh=Sr0PO344Y64uD0RvkpWin7zwEczMXCW2INObpLIsPWY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YJFiVP8vrdCWSRWXZbBHCv+s4nwRatBnerGnbRdQIMOX5HqzGWlh9Amhnz88Sy1CQszr1CdP7JuizuAydM+l1zv3Kqy2EF4kZefDHTkchukiCzlA0pusySIN5R7Sd4ypauEAcA0onbgg7S4vonZm+RU+LFbbZJ0RRy9fTJ885ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ds9EyK2u; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ds9EyK2u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1743623170; x=1775159170;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=Sr0PO344Y64uD0RvkpWin7zwEczMXCW2INObpLIsPWY=;
  b=ds9EyK2u+HAtTCtCZDvOPw5JXYGHuiXZL/6F+BXcfhOKavgNwV6rRWcf
   MaTvgzjObFPo78Ci/x20EkqoDBeKBPEugSs+VQtTBhStLcL61c946+ugs
   ihydjHvqu1Y4iQkVeWRUiW6tWTyMgU6zYmV4rqNqqH63IPKsYUHLsOR0k
   qj3+S5FZzlUqMFRRbxLRhiDBNxFvjpWz2gyi1up8GKDNSLuMqY1AcOBAG
   wMAF9v9yDWTJ+MNyGtQDyGJFtBjwvOvsXfkHG/UGLWK2MrXqo7WcleFvg
   ZSHKWv3fJiiWdCwT87KgI+V+yEcHH8bxglktt+SceQhp8ceRER6Ydykof
   Q==;
X-CSE-ConnectionGUID: hfcUsQObTS2qQsatgLoN6w==
X-CSE-MsgGUID: fPo1X08ITueXzsDxjP3Csg==
X-IronPort-AV: E=McAfee;i="6700,10204,11392"; a="56374779"
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="56374779"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 12:46:09 -0700
X-CSE-ConnectionGUID: rTeoaGt9R4WgSyyzs2a4Dw==
X-CSE-MsgGUID: Do9Ngm9wRBKuW0AteZh+5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,183,1739865600"; 
   d="scan'208";a="127290654"
Received: from inaky-mobl1.amr.corp.intel.com (HELO [10.125.110.4]) ([10.125.110.4])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Apr 2025 12:46:08 -0700
Message-ID: <a383e6e5-9ae9-47a9-a4ae-55fa8166e224@intel.com>
Date: Wed, 2 Apr 2025 12:46:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: core/region - ignore interleave granularity when
 ways=1
To: Gregory Price <gourry@gourry.net>, linux-cxl@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@meta.com,
 dan.j.williams@intel.com, vishal.l.verma@intel.com, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com, ira.weiny@intel.com
References: <20250402193443.944654-1-gourry@gourry.net>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250402193443.944654-1-gourry@gourry.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/2/25 12:34 PM, Gregory Price wrote:
> When validating decoder IW/IG when setting up regions, the granularity
> is irrelevant when iw=1 - all accesses will always route to the only
> target anyway - so all ig values are "correct". Loosen the requirement
> that `ig = (parent_iw * parent_ig)` when iw=1.
> 
> Signed-off-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
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

