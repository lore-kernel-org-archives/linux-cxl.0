Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E7A204877;
	Thu, 20 Feb 2025 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740072235; cv=none; b=NlbORB5tfwI3+PwLqOOexey6KUr0N3Wm0wRSA/lqHitrAIfyIMhORxZSbCUlSlQC3+GvLap69q/zNVQlmw7HHV50A2j3JE+icVN7W9QpZH/QC4H3K+U+giEvULx+2blFAVI+V6aLFkT4+G9WBntMNMJf531nayOPcarpVczAQ38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740072235; c=relaxed/simple;
	bh=CoU9Upr5IfW1UbCU/qk6AaXo8dcsi5zMO7uYXliXrGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J0/Nrs4LDzxk9R0mH4OJblF1oq4al3ibepO1wSknhcgMxUlWUOFkDY/u474uVA+aoAWm4eMY18PFCJRhh4haJ65gwAbBm0XgPBJVX3edg9hoHT6aRIRMPPJBa5ooEl9QNxAGFhGmUvcYv+poUBRxAbL8fz4ihTHudPM8FVNMP2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hppNGksD; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hppNGksD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740072234; x=1771608234;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CoU9Upr5IfW1UbCU/qk6AaXo8dcsi5zMO7uYXliXrGY=;
  b=hppNGksDvtLVAT/bygcQKKQ/2ic4Wx8PfBCpBfqG7YBh9cYMUdjL9BDd
   FrdsVXobnxIwmv37WNOg9ocUQeShWU1dRFLMfweenOmrCGJPtfYYQwzWo
   Z7fm2fdU9+F6AsEGpzYx+me+Icg9jyMVRQzXPsDEoNYT5i5eCX8toXATC
   RsfUWC+aqakWDru9ajnhQCA9Ta5GSpHF6XvzFNKgIfE+YAbIRfUvn3KvB
   LBDYowRa7mpkoKHWlz1XDvEk8dujnB4S84AgX8z/0lrq3Z5yjGgqtAEeO
   ysoB0qncdKFXQ5U06A9/OQDH8rXyn/enKJlvA8Ps+13HS350KcYdRpop8
   A==;
X-CSE-ConnectionGUID: vtIcjIuIR7+T3Pe1coJPwA==
X-CSE-MsgGUID: Z39tp2oGRCqlOZXIAJcQTQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="41076275"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="41076275"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:23:53 -0800
X-CSE-ConnectionGUID: xTOc1FKNS0OFg8TAmcXuHQ==
X-CSE-MsgGUID: jASiOlg7Rz2nvCfhNsk+0Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="114966710"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.110.112]) ([10.125.110.112])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2025 09:23:53 -0800
Message-ID: <e5cdb4b2-9be4-4af5-9579-01451d221c74@intel.com>
Date: Thu, 20 Feb 2025 10:23:51 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 13/18] cxl/region: Add function to find a port's switch
 decoder by range
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
 <20250211095349.981096-14-rrichter@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250211095349.981096-14-rrichter@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/11/25 2:53 AM, Robert Richter wrote:
> Factor out code to find the switch decoder of a port for a specific
> address range. Reuse the code to search a root decoder, create the
> function cxl_port_find_switch_decoder() and rework
> match_root_decoder_by_range() to be usable for switch decoders too.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  drivers/cxl/core/region.c | 48 +++++++++++++++++++++++----------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cfcd235f311e..72e991e7d9ab 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3189,28 +3189,44 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> -static int match_root_decoder_by_range(struct device *dev,
> -				       const void *data)
> +static int match_decoder_by_range(struct device *dev, const void *data)
>  {
>  	const struct range *r1, *r2 = data;
> -	struct cxl_root_decoder *cxlrd;
> +	struct cxl_decoder *cxld;
>  
> -	if (!is_root_decoder(dev))
> +	if (!is_switch_decoder(dev))
>  		return 0;
>  
> -	cxlrd = to_cxl_root_decoder(dev);
> -	r1 = &cxlrd->cxlsd.cxld.hpa_range;
> +	cxld = to_cxl_decoder(dev);
> +	r1 = &cxld->hpa_range;
>  	return range_contains(r1, r2);
>  }
>  
> +static struct cxl_decoder *
> +cxl_port_find_switch_decoder(struct cxl_port *port, struct range *hpa)
> +{
> +	/*
> +	 * device_find_child() increments the reference count of the
> +	 * the switch decoder's parent port to protect the reference
> +	 * to its child. The port is already a parent of the endpoint
> +	 * decoder's port, at least indirectly in the port hierarchy.
> +	 * Thus, the endpoint already holds a reference for the parent
> +	 * port of the switch decoder. Free the unnecessary reference
> +	 * here.
> +	 */
> +	struct device *cxld_dev __free(put_device) =
> +		device_find_child(&port->dev, hpa, match_decoder_by_range);
> +
> +	return cxld_dev ? to_cxl_decoder(cxld_dev) : NULL;
> +}
> +
>  static struct cxl_root_decoder *
>  cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *iter = cxled_to_port(cxled);
> -	struct cxl_decoder *cxld = &cxled->cxld;
> +	struct cxl_decoder *root, *cxld = &cxled->cxld;
>  	struct range *hpa = &cxld->hpa_range;
> -	struct device *cxlrd_dev;
>  
>  	while (iter && !is_cxl_root(iter))
>  		iter = to_cxl_port(iter->dev.parent);
> @@ -3218,9 +3234,8 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  	if (!iter)
>  		return NULL;
>  
> -	cxlrd_dev = device_find_child(&iter->dev, hpa,
> -				      match_root_decoder_by_range);
> -	if (!cxlrd_dev) {
> +	root = cxl_port_find_switch_decoder(iter, hpa);
> +	if (!root) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s no CXL window for range %#llx:%#llx\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxld->dev),
> @@ -3228,16 +3243,9 @@ cxl_find_root_decoder(struct cxl_endpoint_decoder *cxled)
>  		return NULL;
>  	}
>  
> -	/*
> -	 * device_find_child() created a reference to the root
> -	 * decoder. Since the root decoder exists as long as the root
> -	 * port exists and the endpoint already holds a reference to
> -	 * the root port, this additional reference is not needed.
> -	 * Free it here.
> -	 */
> -	put_device(cxlrd_dev);
>  
> -	return to_cxl_root_decoder(cxlrd_dev);
> +
> +	return to_cxl_root_decoder(&root->dev);
>  }
>  
>  static int match_region_by_range(struct device *dev, const void *data)

