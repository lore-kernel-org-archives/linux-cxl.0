Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7402F852;
	Thu, 20 Feb 2025 17:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740071871; cv=none; b=RjsneJL6aDvtT4rHYssiwr3B/O2tStOPtSPtfjQZ/1KcClrs2cyKe4d9Z/WOSlX5saRCTggEh4BcbNfdEGHGr/7HbHqXBjlYRtAZalUco+dyg4aUXYwDH4AvIqjii+JB1MJyi1I0IUgs8Plo64jOtmspZWcNjb23FXVgWQm1mCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740071871; c=relaxed/simple;
	bh=YT5Fa455xzJIgAAesy8Hd+w/8vUYTo87Psi7+utV9xc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i7obDbURKBlEdcrpBt/AOyRYYLucQUazZyDhXtFiVeqJJPcz0zHQaPZrmdwYwgyaGcjN2hJFRhoI7Gd1yvXsGjG//xdOzNfROgV9fyMymEsABvxkebhFKhk0YjNxfJo2aQjADqmofePy2ZmkSoh9uKhyFFCv8RGXYK76Km8+erU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WGINU7vc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WGINU7vc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740071869; x=1771607869;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=YT5Fa455xzJIgAAesy8Hd+w/8vUYTo87Psi7+utV9xc=;
  b=WGINU7vcfuB3tijhk2Kt8ufjV7Krt1j5sciwr3TjZgEROfyk9adVqxJu
   4nDMsuU2fjw8hUL2h/Alvk2evvLX7pJRIr0cFpFM6JrXcalXpPHOALD+c
   1rsJhDWMw+J0T9bONNKHJaOW+V+mtYksqHRxjV5SebwrzCOR2U+OUW2e0
   lmW3KiBi98cfHA2hjogfaFOftiYLTKR1WVPY0hl3BPTgNs9Cuzxng6DEE
   TZ3gPmp8KUw8nGPHyzGk/2IGOzH1zmJPelviGI3plY3jgUGMv2qsyLd8k
   mQGHogqppj2Lxk2myuVKtgDXoAGanO3TZkRi9C1UcctJXDFSggcsfSJPT
   A==;
X-CSE-ConnectionGUID: uWSZ/GRZRge7+E4AGXIucA==
X-CSE-MsgGUID: 2h3FLJwzQh6t1eTkzDW+cA==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41075198"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41075198"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:17:49 -0800
X-CSE-ConnectionGUID: o/DP0KRZROySbXhGQ31eSQ==
X-CSE-MsgGUID: pZ2aYE6aR/ehYEYSyak37A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114966004"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:17:48 -0800
Message-ID: <7b65a200-cddf-4503-9fe8-4004d67f856b@intel.com>
Date: Thu, 20 Feb 2025 10:17:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 12/18] cxl/region: Use iterator to find the root port
 in cxl_find_root_decoder()
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
 <20250211095349.981096-13-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-13-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> cxl_find_root_decoder() uses find_cxl_root() to find the root port.
> In order to support address translation, an iterator must traverse all
> ports from endpoint to root port and filter based on system physical
> address. Replace the call to find_cxl_root() with the required logic.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Tested-by: Gregory Price <gourry@gourry.net>

Hi Robert,

While some cleanup patches are good to send ahead, some like these would be good to go right before they get used to allow the reviewer to see how the new code is utilized. Otherwise the changes doesn't make a lot of sense stand alone.

If it's not too much of a pain, I'd like to this series only have cleanups/refactorings that would make sense without the address translation needs. And move the other changes near the address translation changes for a smoother review.

Thanks!   

Reviewed-by: Dave Jiang <dave.jiang@intel.com>


> ---
>  drivers/cxl/core/region.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index fb43e154c7b9..cfcd235f311e 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3207,13 +3207,18 @@ static struct cxl_root_decoder *
>  cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxled_to_port(cxled);
> -	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> +	struct cxl_port *iter = cxled_to_port(cxled);
>  	struct cxl_decoder *cxld = &cxled->cxld;
>  	struct range *hpa = &cxld->hpa_range;
>  	struct device *cxlrd_dev;
>  
> -	cxlrd_dev = device_find_child(&cxl_root->port.dev, hpa,
> +	while (iter && !is_cxl_root(iter))
> +		iter = to_cxl_port(iter->dev.parent);
> +
> +	if (!iter)
> +		return NULL;
> +
> +	cxlrd_dev = device_find_child(&iter->dev, hpa,
>  				      match_root_decoder_by_range);
>  	if (!cxlrd_dev) {
>  		dev_err(cxlmd->dev.parent,

