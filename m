Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DA53009CA;
	Mon,  3 Nov 2025 22:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762209015; cv=none; b=t0kHBohO0BxVh2Qf4vD3eAX+LwQjtpWgHvDPYZ7GS3hwHZ+MlCnpgbKEwAtkWsBPpi2iRAXoZyh/IXJWP+EcMYWsKvPNLTxyEuew3MHW1vedtCAzdh/s46m2WbyqWZ283dZBBK7QW0x4+Ji4DVhHnXO4oFxA7OnlGHdWe+VEWP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762209015; c=relaxed/simple;
	bh=mH+WZQSaYYRHt+QJ+o1Rlvj3iqKKz01T6IAuo5kGMSU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OcwgoxIue0pLLF4xaj6qodnukfqsr6TVkxKBodgYXKhrqYP9yylZ/IhgYeRYy//a6VeyM3wEV6r6a42tuDykitBVy0vPX/UoiuSfsIvDLPNpvCTkxbGzvkVywrslcCZzPjhws9R88Ycb5qMg7LTBnpn5ik4qjJFCmYAxO1r+P3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GfNfa9JK; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GfNfa9JK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762209015; x=1793745015;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=mH+WZQSaYYRHt+QJ+o1Rlvj3iqKKz01T6IAuo5kGMSU=;
  b=GfNfa9JK0wgi3WkfoVQtB9nWoTzvMcflbBMV/BYqOJmjzCdsdEwXnRRy
   3cpIMq2ALNS7n7WA8Ye9hlqaeibk3jecPm94lm4WmNBgWcGjbmo4o1KMp
   zt+LGOWsT0seERVmn8BgdD9+4VPwZy2UfMe+Yx39xeCpiK03F5QlzeMg6
   Bszd+Q9Lm8sNypdPA7a66FlmU/HcunyxMs3VxvinTmc1Ap9Loh6o8we2I
   /mGwa0s+4Zb4V6WeDVB2DdkQ1oUmCX4qYYOzvtt+ynQ5Wo7A9G77dHdYO
   dv8ptlDAsBupN1hATDFALcXvvkdjYimUpFRZEKsfeeXsnyv1gTrUQWbiZ
   w==;
X-CSE-ConnectionGUID: XHmjcqnARGG4cLc1UGHSsg==
X-CSE-MsgGUID: rljL6DvJRgaPh2R9Cx9r+Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="64199950"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="64199950"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:30:14 -0800
X-CSE-ConnectionGUID: p+KDwjF/Q+KgK205eYt3yg==
X-CSE-MsgGUID: 4ObPLpzKQumKNmfO//UGIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="186664765"
Received: from dwesterg-mobl1.amr.corp.intel.com (HELO [10.125.110.133]) ([10.125.110.133])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 14:30:12 -0800
Message-ID: <288d310a-af1f-47ce-ab03-ac57f3901793@intel.com>
Date: Mon, 3 Nov 2025 15:30:11 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/14] cxl/region: Use region data to get the root
 decoder
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
 <20251103184804.509762-8-rrichter@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251103184804.509762-8-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/3/25 11:47 AM, Robert Richter wrote:
> To find a region's root decoder, the endpoint's HPA range is used to
> search the matching decoder by its range. With address translation the
> endpoint decoder's range is in a different address space and thus
> cannot be used to determine the root decoder.
> 
> The region parameters are encapsulated within struc cxl_region_context
> and may include the translated Host Physical Address (HPA) range. Use
> this context to identify the root decoder rather than relying on the
> endpoint.
> 
> Modify cxl_find_root_decoder() and add the region context as
> parameter. Rename this function to get_cxl_root_decoder() as a
> counterpart to put_cxl_root_decoder(). Simplify the implementation by
> removing function cxl_port_find_switch_decode(). The function is
> unnecessary because it is not referenced or utilized elsewhere in the
> code.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>

Just a nit below. Otherwise
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 50 +++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 28 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 2cfc29a2b588..2dd9e9be4889 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3350,47 +3350,39 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_decoder_by_range(struct device *dev, const void *data)
> +static int match_root_decoder(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;
> -	struct cxl_decoder *cxld;
> +	struct cxl_root_decoder *cxlrd;
>  
> -	if (!is_switch_decoder(dev))
> +	if (!is_root_decoder(dev))
>  		return 0;
>  
> -	cxld = to_cxl_decoder(dev);
> -	r1 = &cxld->hpa_range;
> -	return range_contains(r1, r2);
> -}
> +	cxlrd = to_cxl_root_decoder(dev);
> +	r1 = &cxlrd->cxlsd.cxld.hpa_range;
>  
> -static struct cxl_decoder *
> -cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa_range)
> -{
> -	struct device *cxld_dev = device_find_child(&port->dev, hpa_range,
> -						    match_decoder_by_range);
> -
> -	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> +	return range_contains(r1, r2);
>  }
>  
>  static struct cxl_root_decoder *
> -cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
> +get_cxl_root_decoder(struct cxl_endpoint_decoder *cxled,
> +		     struct cxl_region_context *ctx)

Would like a comment that make note the caller should call put_device() when done with the root decoder.

DJ
 >  {
> -	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *port = cxled_to_port(cxled);
>  	struct cxl_root *cxl_root __free(put_cxl_root) = find_cxl_root(port);
> -	struct cxl_decoder *root, *cxld = &cxled->cxld;
> -	struct range *hpa_range = &cxld->hpa_range;
> +	struct device *cxlrd_dev;
>  
> -	root = cxl_port_find_switch_decoder(&cxl_root->port, hpa_range);
> -	if (!root) {
> -		dev_err(cxlmd->dev.parent,
> +	cxlrd_dev = device_find_child(&cxl_root->port.dev, &ctx->hpa_range,
> +				      match_root_decoder);
> +	if (!cxlrd_dev) {
> +		dev_err(port->uport_dev,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> -			hpa_range->start, hpa_range->end);
> -		return NULL;
> +			dev_name(&ctx->cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			ctx->hpa_range.start, ctx->hpa_range.end);
> +		return ERR_PTR(-ENXIO);
>  	}
>  
> -	return to_cxl_root_decoder(&root->dev);
> +	return to_cxl_root_decoder(cxlrd_dev);
>  }
>  
>  static int match_region_by_range(struct device *dev, const void *data)
> @@ -3584,9 +3576,11 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  	};
>  
>  	struct cxl_root_decoder *cxlrd __free(put_cxl_root_decoder) =
> -		cxl_find_root_decoder(cxled);
> -	if (!cxlrd)
> -		return -ENXIO;
> +		get_cxl_root_decoder(cxled, &ctx);
> +
> +	rc = PTR_ERR_OR_ZERO(cxlrd);
> +	if (rc)
> +		return rc;
>  
>  	/*
>  	 * Ensure that if multiple threads race to construct_region()

