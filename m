Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7371923535E;
	Thu, 27 Feb 2025 15:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740669721; cv=none; b=gmRwnopYRjMMV/H311ZuUJFNZBwCJ30NkIc0YWOlKOI3F7EMB+gx/rSM1Kdvzvo/cKEzGhv68f+SnwQyOaIcvEm/Phdv2aLg4BvtRUDasTuoQOkEoeTHCbzPOFOzjxAke8AtZ1WZXXRYrbbfaIZCYqlFaqT7gnDKIb0JPDSqTnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740669721; c=relaxed/simple;
	bh=ZbFHvEVs/StgTBF2XpBIeDqG6mLo1uxwQtkaK+V1oa0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hr3ntN9OY+fpF8ZwIoJRllHBlBlTns7Q+Tc8CNvd3+CyOyuYeEA2acWe3Iyib05Jv7VK3NXscUxc3+a/os1lUqcLhfo8O+eIMYORuuPLeQo7lciq5u69Eq5J38fsiycqWX0Ge/hVIT7B5vTJ2JBCgaQURBZ1Z26p0xSEW34MInM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bcrJDwMZ; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bcrJDwMZ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740669719; x=1772205719;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZbFHvEVs/StgTBF2XpBIeDqG6mLo1uxwQtkaK+V1oa0=;
  b=bcrJDwMZQOzrTx4484503dZDYj11aEx69Cq0usdEqlIjKpAsKRiGKA6z
   BMFTvhKYnyHo2gNsj4jaIsO7YwyexJVcKZ9Law2tmZtHMgQly/82DZLWS
   jqX7QQS6WZH1/7hTjoEkbdede4eUzChffk60Agm2PCATrAptForgQ5s9E
   Pu3HHWO4h+NSoavWO7E9wDAuGfPEbRuygtp1IdacztMyuefroPiP00trU
   ebv/FpVqemvrX7Z0xec+ZjLHt6+8SnJ1b1OU2IaHrmsLs8prqz9l28FZD
   dRLH+ROS5QqLloS9l0Glriq9NtpyWhgg+RHekuEaoT8htEgb2fFVBw73W
   Q==;
X-CSE-ConnectionGUID: lyEAPzfZRF+95xDBYTIWgQ==
X-CSE-MsgGUID: 5XNhtjXHQIqxL+ebf5TqSA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="52206183"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="52206183"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:21:58 -0800
X-CSE-ConnectionGUID: sc33+yjhRC+aHNm171099g==
X-CSE-MsgGUID: zm9t+1H0SnmLMUEOxChHDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="122000348"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.89]) ([10.125.108.89])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 07:21:58 -0800
Message-ID: <34a30d8d-f4e2-4c3b-8386-d07f7b8cfaa1@intel.com>
Date: Thu, 27 Feb 2025 08:21:57 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] cxl/hdm: Verify HDM decoder capabilities after
 parsing
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250227103251.390147-1-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250227103251.390147-1-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/27/25 3:32 AM, Li Ming wrote:
> devm_cxl_setup_hdm() only checks if decoder_count is 0 after parsing HDM
> decoder capability, But according to the implementation of
> cxl_hdm_decoder_count(), cxlhdm->decoder_count will never be 0.
> 
> Per CXL specification, the values ranges of decoder_count and
> target_count are limited. Adding a checking for the values of them
> in case hardware initialized them with wrong values.
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

#define the limit please

> +		return -EINVAL;
> +	else if (cxlhdm->decoder_count > 32)

same here

DJ
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
>  		return ERR_PTR(-ENXIO);
>  	}

