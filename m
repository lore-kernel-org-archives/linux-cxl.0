Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F6020C028;
	Thu, 20 Feb 2025 16:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740070259; cv=none; b=X4aBBg8dJGg43Woso24SmHH0ks2sSB1Kl5igqQGZcWk74NR/VZOQRMnl905dXCK5n9WuD+Pe7cy1h6jHqe2nMsZc0XNaoAKf/9Q9ap0bTQh8Lfr479KeLv4HsKHXXWYE9lu70NoMf0T+uXEWDJ+BoaGTc43+U+p4hvewQcl6+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740070259; c=relaxed/simple;
	bh=jD+lCe3cZutxOSVIG8kKgxCMwONIx0YVxNvTOAV5gw4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=opBZ5i5FlLSLrE9KjdlkbXIr3Bu47dHAMyfSWgleMlLN70bWI+9tToFCh21VPRQv8/JfZFpk8owuAJrjKa6hcBKbgQYh7zlXOijBYeVss7W1rWteNJkZKTK1GQGs4/TJkXIRWGP+u6jis87WEwWz797MlE1nnTPFts1Vq/bSjKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dTgiPtlD; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dTgiPtlD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740070258; x=1771606258;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=jD+lCe3cZutxOSVIG8kKgxCMwONIx0YVxNvTOAV5gw4=;
  b=dTgiPtlDFe5yYHAoxKlyUjNFnwEozVJEHv52ynzjeajP2MiOuVDb1V1e
   9QJYK5F4Mg9QzEtCh8uIf7DeyjCUdAoYGkrOS3f1Oyi+xrKB6EgB2ukIs
   1H1EQzinYGdswzsLWWMsQyA93Yo1yQWWV5mJsbUvU4Rky9KmgmBymtYTH
   EPk7HemAMJ4erneiPOVCrCA+W3MkCAjS0v2ahw/m2MIulNozFIzSjuHeh
   65diE7xW8kaWkVrcs35JayE7kEEy21htmgVoUwFHhbYsjFkfES0OIQBK3
   SGqAR9BQcRc1uOc0vqEnQQyNSt4EWa97ccLQHHC+h7KYKuG/Nrm+V9RqJ
   Q==;
X-CSE-ConnectionGUID: QhfIxrpiTVOC4gO8gIGaiQ==
X-CSE-MsgGUID: t9RcOQKeT6y8hdVhJy1p/Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11351"; a="58269534"
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="58269534"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:50:26 -0800
X-CSE-ConnectionGUID: AaPzoKkNQu2JfQ9HXhx8Dw==
X-CSE-MsgGUID: gW02EKFHScGF1sthoGyUeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,302,1732608000"; 
   d="scan'208";a="119708576"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 08:50:24 -0800
Message-ID: <288d1d01-5e63-4bbc-872e-5f49e1500329@intel.com>
Date: Thu, 20 Feb 2025 09:50:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/18] cxl/region: Factor out code to find a root
 decoder's region
To: Robert Richter <rrichter@amd.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gregory Price <gourry@gourry.net>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Terry Bowman <terry.bowman@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
 <20250211095349.981096-11-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-11-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> In function cxl_add_to_region() there is code to determine a root
> decoder's region. Factor that code out. This is in preparation to
> further rework and simplify function cxl_add_to_region().
> 
> No functional changes.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/region.c | 24 ++++++++++++++++--------
>  1 file changed, 16 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c641c8922455..9ce0282c0042 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3256,6 +3256,19 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	return rc;
>  }
>  
> +static struct cxl_region *
> +cxl_find_region_by_range(struct cxl_root_decoder *cxlrd, struct range *hpa)
> +{
> +	struct device *region_dev;
> +
> +	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> +				       match_region_by_range);
> +	if (!region_dev)
> +		return NULL;
> +
> +	return to_cxl_region(region_dev);
> +}
> +
>  /* Establish an empty region covering the given HPA range */
>  static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  					   struct cxl_endpoint_decoder *cxled)
> @@ -3347,7 +3360,6 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct range *hpa = &cxled->cxld.hpa_range;
> -	struct device *region_dev;
>  	struct cxl_root_decoder *cxlrd;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
> @@ -3363,13 +3375,9 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	 * one does the construction and the others add to that.
>  	 */
>  	mutex_lock(&cxlrd->range_lock);
> -	region_dev = device_find_child(&cxlrd->cxlsd.cxld.dev, hpa,
> -				       match_region_by_range);
> -	if (!region_dev) {
> +	cxlr = cxl_find_region_by_range(cxlrd, hpa);
> +	if (!cxlr)
>  		cxlr = construct_region(cxlrd, cxled);
> -		region_dev = &cxlr->dev;
> -	} else
> -		cxlr = to_cxl_region(region_dev);
>  	mutex_unlock(&cxlrd->range_lock);
>  
>  	rc = PTR_ERR_OR_ZERO(cxlr);
> @@ -3394,7 +3402,7 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  				p->res);
>  	}
>  
> -	put_device(region_dev);
> +	put_device(&cxlr->dev);			/* cxl_find_region_by_range() */
>  
>  	return rc;
>  }

