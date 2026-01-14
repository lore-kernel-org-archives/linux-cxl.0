Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03D81E47CC
	for <linux-cxl@vger.kernel.org>; Wed, 14 Jan 2026 00:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350270; cv=none; b=P9PeOd74sPna4bjXQUUGzRcdgC+r1tnuOj61sjiSfaJhfc8ZJNWc+33+FKc8nuqmMKIN83rrK4S+fpD+Vq7py407luLRyyLi+aUDWMMlPdT91D9B3NHCHfasL7QXi09WWtLb8nzk1kLZAWQv4tvUP7buQLhFkvVPXovNt2PuzGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350270; c=relaxed/simple;
	bh=WqCsSyi76k4r56NtzdxY43LLmTK/iyv8s8ejjbX031A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Hiw/dZqOs9EoO8Z7Z0SZgS7ZhEI7fLybsNkKCqRK0ntUkFZmAhyiKYMoRomS4259/TaHC0ZXn4RnI2kck8bcIIk2Y5u1TJhC3hZax6DqRV9F1Mikv4oxn+0YkF8s1gMRDRRA3VWf6Eig+bcqB51NXYdGtpHMSQXkryNwQunSGTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ou0GQvle; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ou0GQvle"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768350269; x=1799886269;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WqCsSyi76k4r56NtzdxY43LLmTK/iyv8s8ejjbX031A=;
  b=Ou0GQvlePWyGSmj/RhriTabk5sMuVKQr9Xclhl4ePOVxpvj9XRtq1tLp
   vLtSNGQKmiDpyIsqMAxTvrm9z5WsSGA8SQzD0K11CSWmfCtEmCxknNKMj
   pOS5So1YWa2u/ADN801xFEd5qpg7ADP597o9JSFm8ddcF2Hn8z98sFKt1
   jOZdGqOa+TrlbpNwNyaMrbbWF0VhmkyPSmPn0U0hAKWkQcURt+iyDeiJp
   xadPIFBAGSHJERkxYTnF8pCV0ipFmEF5/JrnGr/cUN35NodlFnlJcHlT9
   MA8o8AC+Sbx6IyC3X2wIGfTKlGGYB+Tor7f04skeelxN1ik/jwwqnhJYC
   A==;
X-CSE-ConnectionGUID: 6MwvovAcSE+jf6JfI3qJAQ==
X-CSE-MsgGUID: POmxoCy/QICYhDzxOHYSJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="69698777"
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="69698777"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:24:28 -0800
X-CSE-ConnectionGUID: aOL48Z+KS92claLUcP6gwQ==
X-CSE-MsgGUID: ZLJBOL7TT4u2x1tVeAPbRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,224,1763452800"; 
   d="scan'208";a="204942083"
Received: from dnelso2-mobl.amr.corp.intel.com (HELO [10.125.110.189]) ([10.125.110.189])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2026 16:24:27 -0800
Message-ID: <720020ac-b35c-4331-8434-457d170e4c68@intel.com>
Date: Tue, 13 Jan 2026 17:24:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/2] cxl/region: Translate HPA to DPA and memdev in
 unaligned regions
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <cover.1768008522.git.alison.schofield@intel.com>
 <0d7d47672e81d0c4d9a4e5e335ca536dbecb9dee.1768008522.git.alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <0d7d47672e81d0c4d9a4e5e335ca536dbecb9dee.1768008522.git.alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/9/26 6:54 PM, Alison Schofield wrote:
> The CXL driver supports an expert user debugfs interface to inject and
> clear poison by a region offset. That feature requires translating a
> HPA (the region address) to a DPA and a memdev to perform the poison
> operation.
> 
> Unaligned regions do not have an algebraically invertible mapping
> from HPA to DPA due to the region offset skew. The region base is not
> aligned to a full interleave. Add a helper to perform the unaligned
> translations that first calculates the DPA offset and then tests it
> against each candidate endpoint decoder.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 46 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 46 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 146ae9e42496..f63fc15ba0c1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3307,6 +3307,48 @@ struct dpa_result {
>  	u64 dpa;
>  };
>  
> +static int unaligned_region_offset_to_dpa_result(struct cxl_region *cxlr,
> +						 u64 offset,
> +						 struct dpa_result *result)
> +{
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> +	struct cxl_region_params *p = &cxlr->params;
> +	u64 interleave_width, interleave_index;
> +	u64 gran, gran_offset, dpa_offset;
> +	u64 hpa = p->res->start + offset;
> +
> +	/*
> +	 * Unaligned addresses are not algebraically invertible. Calculate
> +	 * a dpa_offset independent of the target device and then enumerate
> +	 * and test that dpa_offset against each candidate endpoint decoder.
> +	 */
> +	gran = cxld->interleave_granularity;
> +	interleave_width = gran * cxld->interleave_ways;
> +	interleave_index = offset / interleave_width;
> +	gran_offset = offset % gran;
> +
> +	dpa_offset = interleave_index * gran + gran_offset;
> +
> +	for (int i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		int pos = cxled->pos;
> +		u64 test_hpa;
> +
> +		test_hpa = unaligned_dpa_to_hpa(cxld, p, pos, dpa_offset);
> +		if (test_hpa == hpa) {
> +			result->cxlmd = cxled_to_memdev(cxled);
> +			result->dpa =
> +				cxl_dpa_resource_start(cxled) + dpa_offset;
> +			return 0;
> +		}
> +	}
> +	dev_err(&cxlr->dev,
> +		"failed to resolve HPA %#llx in unaligned MOD3 region\n", hpa);
> +
> +	return -ENXIO;
> +}
> +
>  static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  				       struct dpa_result *result)
>  {
> @@ -3336,6 +3378,10 @@ static int region_offset_to_dpa_result(struct cxl_region *cxlr, u64 offset,
>  		hpa_offset = offset;
>  	}
>  
> +	if (region_is_unaligned_mod3(cxlr))
> +		return unaligned_region_offset_to_dpa_result(cxlr, offset,
> +							     result);
> +
>  	pos = cxl_calculate_position(hpa_offset, eiw, eig);
>  	if (pos < 0 || pos >= p->nr_targets) {
>  		dev_dbg(&cxlr->dev, "Invalid position %d for %d targets\n",

