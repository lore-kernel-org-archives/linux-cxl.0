Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C5A1CEAA3;
	Thu, 27 Feb 2025 21:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740692846; cv=none; b=IxlC6rYE0EOgNsl2v976HMTBh3V3f+9KMr/kBINYTF8f8RO6/zOVYEc9r00dYyDAR2ErZc8SLO5q3VeczL6rqaLi4lhk9k6NbKMD6A4ovfsfNUfUbqwEBE1kEMGjzCxX1J43woAVihlfZnCFIEHKEnotlPJxGgJseAc9zUTf+gQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740692846; c=relaxed/simple;
	bh=mzX5XybLuSNvnhruhydyeIUW1bh3JlK4zTTBNy9zFd4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MNpWCICZRjfeuCKZXAZHZ7c0aCRpr/AMDwxc7c2j2ZUbdCOdnIeCcyQpJpUSk0Yg3+ti1GWkgHTzHxa7/4os7mefFJC7vO5hKW1MgSgww5JMwD/tng0MLS/yf1B8Bym67peN7KJVDrTHw1Odn7gb5+I3+9dAjU4LDDWLgGfm3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZC34UkN2; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZC34UkN2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740692844; x=1772228844;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mzX5XybLuSNvnhruhydyeIUW1bh3JlK4zTTBNy9zFd4=;
  b=ZC34UkN2WptDqMmjN3sbg1YWqGj/o6uzkH/h6tZJpCtRaZPEm8xTrsky
   B6DQvwVlz7BFLpxJm+OFLyJmCx3vQ5HqKg0kdMY9vemBMUnfrrJqXpPYU
   IB/aGLXQIay4GiVJyVgDTpnK8ZgnzsDMXJQXF5wbTgAHho7NTGKvSFxfT
   KfD/VZiRNDh/N6CRKikaX7TpqhQkuOc7aRFnZNB5xM+iTCMPe5FCgWVfU
   90ReHfEe5nQFqGwH1e7yU6XsBok//gO2IkQgHYqR5GL+DcQomcgfTPKeY
   /rsG8PT7ZJpmeKxzME7oX/fmAts92Pu3Qdks4Fh7WDvnRH+OrUOhVjwpT
   g==;
X-CSE-ConnectionGUID: 34uGhsMGToGaQNwk1e48xg==
X-CSE-MsgGUID: saPEbmZpT+ShVmMKj30Lkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="41309602"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="41309602"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 13:47:24 -0800
X-CSE-ConnectionGUID: qacc7SupTEKz/6lA3UjX2Q==
X-CSE-MsgGUID: YsubvpYwSkajhPy5QT79zA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="140372458"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.94])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 13:47:23 -0800
Date: Thu, 27 Feb 2025 13:47:21 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
Message-ID: <Z8DdafbX6_tbM4DW@aschofie-mobl2.lan>
References: <20250227103251.390147-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250227103251.390147-1-ming.li@zohomail.com>

On Thu, Feb 27, 2025 at 06:32:51PM +0800, Li Ming wrote:
> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
> decoder capability, But according to the implementation of
> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.

How does a check against the spec maximums benefit this driver? Is there
a bad path we avoid by checking and quitting at this point.

Might this catch silly decoder counts that the driver previously
ignored?

> 
> Per CXL specification, the values ranges of decoder_count and
> target_count are limited. Adding a checking for the values of them
> in case hardware initialized them with wrong values.

Similar question - is this catching something sooner, rather than
later?

> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
> base-commit: 22eea823f69ae39dc060c4027e8d1470803d2e49 cxl/next
> ---
>  drivers/cxl/core/hdm.c | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 70cae4ebf8a4..a98191867c22 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -138,6 +138,34 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	return true;
>  }
>  
> +static int cxlhdm_decoder_caps_verify(struct cxl_hdm *cxlhdm)
> +{
> +	/*
> +	 * CXL r3.2 section 8.2.4.20.1
> +	 * CXL devices shall not advertise more than 10 decoders,
> +	 * CXL switches and HBs may advertise up to 32 decoders.
> +	 */
> +	if (is_cxl_endpoint(cxlhdm->port) && cxlhdm->decoder_count > 10)
> +		return -EINVAL;
> +	else if (cxlhdm->decoder_count > 32)
> +		return -EINVAL;
> +
> +	/*
> +	 * CXL r3.2 section 8.2.4.20.1
> +	 * target count is applicable only to CXL upstream port and HB.
> +	 * The number of target ports each decoder supports should be
> +	 * one of the numbers 1, 2, 4 or 8.
> +	 */
> +	if (!is_cxl_endpoint(cxlhdm->port) &&
> +	    cxlhdm->target_count != 1 &&
> +	    cxlhdm->target_count != 2 &&
> +	    cxlhdm->target_count != 4 &&
> +	    cxlhdm->target_count != 8)
> +		return -EINVAL;

Maybe instead of manual bitwise checks try
	(!is_power_of_2(cxlhdm->target_count) || cxlhdm->target_count > 8))


> +
> +	return 0;
> +}
> +
>  /**
>   * devm_cxl_setup_hdm - map HDM decoder component registers
>   * @port: cxl_port to map
> @@ -182,7 +210,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>  	}
>  
>  	parse_hdm_decoder_caps(cxlhdm);
> -	if (cxlhdm->decoder_count == 0) {
> +	rc = cxlhdm_decoder_caps_verify(cxlhdm);
> +	if (rc) {
>  		dev_err(dev, "Spec violation. Caps invalid\n");

Can you move the dev_err to the verify function and include the
specific invalid capability.


--Alison

>  		return ERR_PTR(-ENXIO);
>  	}
> -- 
> 2.34.1
> 
