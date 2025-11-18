Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC15536C0B6
	for <linux-cxl@vger.kernel.org>; Tue, 18 Nov 2025 18:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763490258; cv=none; b=EXu1of/5XcG9ruquw8hBQwH8ptazA1XcQwSUp1qARTvYDfySyP2hRJ7Y0vlmS9osqeYiprD+YALcwCTj2JgnnswRAjDQoQx4Yc5T9m2ZS5oo/uIUcTSLZKM83x63cQhe23TWO764afaODYUgPM0tz4hcfwFnS2Dr/ChfKjfNwZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763490258; c=relaxed/simple;
	bh=oUuAWJBn08fKSeAZ8rXtYOS1hLtLNf7wIAZPfaDd4yQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HpBwTsjOgjJre4A4NgekBYRYR7oJvk4BjiBcN6bONRnw1R+qIYyDnHL2vQQjAIBkaVTH1ASFdk0ZVR2LAZLVK2yJs+8GrSeGuzTFcH3DheDRNP7gdsZvfIQ9dbcsab0W6hxV0VCGfpe3zj5T+QGBPNR+x7HpBd2928Gw6k4PN9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=F2r7Zzcl; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F2r7Zzcl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763490257; x=1795026257;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=oUuAWJBn08fKSeAZ8rXtYOS1hLtLNf7wIAZPfaDd4yQ=;
  b=F2r7Zzcl/gZR0lXXgIzb24cJ71yOxnKBiBxx/DuS73Pa9iL+hno21OGW
   dOFQ77NkjqpQrISctuxy2slXivfh2gD5tCqwa6VqFXjPrsSy+AgtAuZk3
   Rw3Z28PtVLq+O0N2ADUbohw/m4n2cfdim75HMBZmOq5TYklx2dWZsw+wF
   HvQahsa6wAeV7AcuaDg/dDeMpFkmAiJk26OC7rJZXAo8kUBbC91B6N2vO
   VuvHk7Md5q99kjSd8qhMPpDtrqwHWK4eg9OLiBuXDVg1DogM5RKFYhEKR
   g5j1LTyUYSvLS2y+JmtMDf1AZe0FFp+bxjEsjXKzaoS7D9Aq1B+lwEWDM
   A==;
X-CSE-ConnectionGUID: yJQ4ojHAQqaDEWd9MJB56w==
X-CSE-MsgGUID: 2HBdxkAgTdW3tNJ3qqy67A==
X-IronPort-AV: E=McAfee;i="6800,10657,11617"; a="76625761"
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="76625761"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:24:16 -0800
X-CSE-ConnectionGUID: Ga8F5AfnRNSxGLiNTY/dcw==
X-CSE-MsgGUID: wzjHVqmIT4mE8hloAzvktg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,314,1754982000"; 
   d="scan'208";a="228163630"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.109.115]) ([10.125.109.115])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2025 10:24:16 -0800
Message-ID: <1c460e7b-657e-4d45-acd1-5c4f372af929@intel.com>
Date: Tue, 18 Nov 2025 11:24:15 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: remove unused function
To: alejandro.lucero-palau@amd.com, linux-cxl@vger.kernel.org,
 dan.j.williams@intel.com
Cc: Alejandro Lucero <alucerop@amd.com>
References: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251118182202.2083244-1-alejandro.lucero-palau@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/18/25 11:22 AM, alejandro.lucero-palau@amd.com wrote:
> From: Alejandro Lucero <alucerop@amd.com>
> 
> Since commit 733b57f262b0 __wrap_cxl_rcd_component_reg_phys()
> is not necessary under mocking tests.
> 
> Signed-off-by: Alejandro Lucero <alucerop@amd.com>

Thanks Alejandro
Reviewed-by: Dave Jiang <dave.jiang@intel.com>> ---
>  tools/testing/cxl/Kbuild      |  1 -
>  tools/testing/cxl/test/mock.c | 17 -----------------
>  2 files changed, 18 deletions(-)
> 
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index d07f14cb7aa4..52736f611ea9 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -12,7 +12,6 @@ ldflags-y += --wrap=cxl_await_media_ready
>  ldflags-y += --wrap=cxl_hdm_decode_init
>  ldflags-y += --wrap=cxl_dvsec_rr_decode
>  ldflags-y += --wrap=devm_cxl_add_rch_dport
> -ldflags-y += --wrap=cxl_rcd_component_reg_phys
>  ldflags-y += --wrap=cxl_endpoint_parse_cdat
>  ldflags-y += --wrap=cxl_dport_init_ras_reporting
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 1989ae020df3..c471400116a1 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -268,23 +268,6 @@ struct cxl_dport *__wrap_devm_cxl_add_rch_dport(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_rch_dport, "CXL");
>  
> -resource_size_t __wrap_cxl_rcd_component_reg_phys(struct device *dev,
> -						  struct cxl_dport *dport)
> -{
> -	int index;
> -	resource_size_t component_reg_phys;
> -	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> -
> -	if (ops && ops->is_mock_port(dev))
> -		component_reg_phys = CXL_RESOURCE_NONE;
> -	else
> -		component_reg_phys = cxl_rcd_component_reg_phys(dev, dport);
> -	put_cxl_mock_ops(index);
> -
> -	return component_reg_phys;
> -}
> -EXPORT_SYMBOL_NS_GPL(__wrap_cxl_rcd_component_reg_phys, "CXL");
> -
>  void __wrap_cxl_endpoint_parse_cdat(struct cxl_port *port)
>  {
>  	int index;

