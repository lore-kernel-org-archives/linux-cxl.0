Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881924A1A
	for <linux-cxl@vger.kernel.org>; Tue, 25 Feb 2025 00:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740443241; cv=none; b=cLaKz/JC6qqFrClEaBvIKgpt6xNbiFDvmfjldFOZn0Sz8ay7IpK5HC5bzp/YtqSVE7g+5lOKcl50JTY6s6p2LH4wDFhmV5rpUFHM4VqvOSrDhNRXMXCpafLmuzV9x7cMma9JIddSTPdSWsBfQOgNStm9++RQkhQm3JS8b4jFC7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740443241; c=relaxed/simple;
	bh=9wAbUe+QxJXcMgZSsEy5GxdzkG9mdFq0V8tLDz27+sg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZMXNW44M5QPJgA5fU9JJSZQo1DB+NuxEyEy+WY76iB2LJcWx2O3tAtIySSFpJdZck71UxNreYdvFezzQVJSgVMxLq8fXqk0vdqEnFt+8qh3IXIe8pcXXg8pOb2yCg9TGJlwwC0rchlc8X0Yfl/aCvCGshK5ajm2wMnb68xLLiCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cPbeOm6v; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cPbeOm6v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740443239; x=1771979239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9wAbUe+QxJXcMgZSsEy5GxdzkG9mdFq0V8tLDz27+sg=;
  b=cPbeOm6vGtGNIM+KmPMJcuMgYWDR/NLyRpKUm4ZOas4Q9OUIp9fu3ctl
   /9okM4n1Kztuz3D9lS/6jW4QaYf1uL84No1xweKk6nlua/oJ9GSC8UAe6
   XWQujBAc+AD5yyK3dg/w4IkaWhX+PCP4pq7hn6+mXzWEi6x+ocmTBvCJN
   kARNPGMydAg5e0bDSp6IyBK3NRb5gERLyQAikqrLCZeslCtwS8xfGqkuu
   LmdOotthZ/j073rqORzYfJrIdoiNmRYTokPIpnLkH31MVwe9Eg4f3tQC8
   pwWua5+Zl6DOdGNHCZJX4plS9dwOyW2Vq/T58zctJWPs6Jx8J5ozmgoyb
   A==;
X-CSE-ConnectionGUID: TafwTh4uQ6ei2MJK3mihbA==
X-CSE-MsgGUID: yY/UPjooSM+c9Xf6HT72jw==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="41364437"
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="41364437"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 16:27:17 -0800
X-CSE-ConnectionGUID: y4q3hXsqSiq0k5LMGtW0qw==
X-CSE-MsgGUID: 9zZNE8gAQJ2sUP67JhZxfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,312,1732608000"; 
   d="scan'208";a="116199026"
Received: from lstrano-mobl6.amr.corp.intel.com (HELO [10.125.111.114]) ([10.125.111.114])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2025 16:27:17 -0800
Message-ID: <df3230ab-ecda-4957-a25a-f711ece30dc2@intel.com>
Date: Mon, 24 Feb 2025 17:27:16 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Define a CFMWS capable of a 3 way HB interleave
To: alison.schofield@intel.com, Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20250224235032.2259058-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250224235032.2259058-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/24/25 4:50 PM, alison.schofield@intel.com wrote:
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
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>  tools/testing/cxl/test/cxl.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 083a66a52731..e5cd874614d2 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
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

