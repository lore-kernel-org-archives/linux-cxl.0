Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386C425D911
	for <linux-cxl@vger.kernel.org>; Thu, 27 Feb 2025 19:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740684289; cv=none; b=cm2YAZIsdctRiq6CYlKGR4jdjwSO7yuCfHjkLEkb4Egd9GdUjl5MDIaaxYJOdcT1WwJYsylOezTKp6q0BXZi+h2U2jRborU/XavVhoYO7zk/uj+8RqhnVMaFdqN+oS1bn0pONjamcwpS1S0nPHuU2E9D72dZHjKXfLrb3p1hS98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740684289; c=relaxed/simple;
	bh=+mSdTOZVS3QbwoBx5zBczSmSUBia+jWbOP87F2iJPfg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K8OdK5BsgnCLDekKs78JaHzEd/dpr44867o4kIWOIvYJiu9dwn5Fc932Y7VXyikNXsVgKFKQWRAZwyQNitlKSD8N/XIDTMpN4XzwLvq6jlkcBF5Um1nkj2A66JrHiDHo1q3VUD3XY7DT5VteSC90kJG+DTz3nYlgoFwN7YP0Wek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fNkiZNe2; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fNkiZNe2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740684288; x=1772220288;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+mSdTOZVS3QbwoBx5zBczSmSUBia+jWbOP87F2iJPfg=;
  b=fNkiZNe2nfKAVB/HNDcgIL2hP40FzzfDi53N6qo4MrzUXHq2CZhx7CBP
   rIO//o53N5+6TjJJYwWW68jgvdgO8ZWBGgEQUc2ItH7/DioVMUTHP7fU1
   349+LwLSaVYLD/JMS7RuWjGKP/vYaC5mY5134XOuZNx4Ae0e5RkvbpBuE
   Ic7oG8Wtmflvq9yhJve6Q+XoTBQRw4NsgipVF3g6SWCGb7A/pJ7C5tQzd
   aUsEW8xJaBxgSGpizWM7gyTumCupUn6xQv3oyI44WXNo6TF3Ses1x3bPX
   dJqKYODOpVpYKokeV/kfl0+ZUuobBcLn1kRDOaCaV66oIffEnUkZe/mHP
   g==;
X-CSE-ConnectionGUID: himYsqvFQVGwtCq+z4WbYA==
X-CSE-MsgGUID: NldQqq40QvGhx/myMscFCA==
X-IronPort-AV: E=McAfee;i="6700,10204,11358"; a="45510822"
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="45510822"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:24:47 -0800
X-CSE-ConnectionGUID: gKs4bkFUTK+v2SQp0QyyNg==
X-CSE-MsgGUID: +gjaTpg0QS+Rt3JKp8J0ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,320,1732608000"; 
   d="scan'208";a="117613714"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.108.89]) ([10.125.108.89])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2025 11:24:46 -0800
Message-ID: <2c4ccd08-1e8c-46f3-9f3b-eb13648f02cf@intel.com>
Date: Thu, 27 Feb 2025 12:24:45 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/test: Define a CFMWS capable of a 3 way HB
 interleave
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, Li Zhijian <lizhijian@fujitsu.com>
References: <20250226221931.2352061-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250226221931.2352061-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/26/25 3:19 PM, alison.schofield@intel.com wrote:
> From: Alison Schofield <alison.schofield@intel.com>
> 
> The CXL unit test cxl-xor-region.sh is skipping a 1+1+1 region
> interleave test case because the window is not defined.
> 
> Additionally, upcoming expansion of 3 way HB interleave test cases
> (like 2+2+2) require the same window.
> 
> Replace an unused CFMWS with a 3-way capable CFMWS in the set of
> CFMWS's loaded when interleave_arithmetic=1.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Tested-by: Li Zhijian <lizhijian@fujitsu.com>

Applied to cxl/next

> ---
> 
> v2: Adjust target list length (Ira)
> 
>  tools/testing/cxl/test/cxl.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 083a66a52731..1c3336095923 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -155,7 +155,7 @@ static struct {
>  	} cfmws7;
>  	struct {
>  		struct acpi_cedt_cfmws cfmws;
> -		u32 target[4];
> +		u32 target[3];
>  	} cfmws8;
>  	struct {
>  		struct acpi_cedt_cxims cxims;
> @@ -331,14 +331,14 @@ static struct {
>  				.length = sizeof(mock_cedt.cfmws8),
>  			},
>  			.interleave_arithmetic = ACPI_CEDT_CFMWS_ARITHMETIC_XOR,
> -			.interleave_ways = 2,
> -			.granularity = 0,
> +			.interleave_ways = 8,
> +			.granularity = 1,
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_TYPE3 |
>  					ACPI_CEDT_CFMWS_RESTRICT_PMEM,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M * 16UL,
> +			.window_size = SZ_512M * 6UL,
>  		},
> -		.target = { 0, 1, 0, 1, },
> +		.target = { 0, 1, 2, },
>  	},
>  	.cxims0 = {
>  		.cxims = {
> 
> base-commit: 2bb67004903cfd35710750654669a77e7223fcd1

