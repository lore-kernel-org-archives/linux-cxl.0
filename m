Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EDA3CF688;
	Thu, 21 May 2026 17:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779384032; cv=none; b=Pojcgy6ZcXyzSoJhftmOtk4pv1maYloc2TwIIp8HvOk7hMLT3zVWGk4yOFFcrHkQfbvgfCcHXTvyxT/G7Qvg6JUKrj+64rEizGcAaNHgmuGGPYAuaIN5d29zsD6gXLDQrxl1TgQfsw/lnhC1fbeQ1H9dKLeN1w3RbQ6SAiIal/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779384032; c=relaxed/simple;
	bh=9/EoeqZiGjFlC3PtUtBcRacJu6Q4xuS49QjAnec6OUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fSznLzmGB98K0YF0EnUMvzsx7MZ/vdBB+3It52a1pTtkWvIIpFLlFcsctuRDVE2yZJOmLT/18wxquOfIB0Q6agvJ82zCg8Hm6N/aDqjXZtVV5FnTWxHEEJdTfKjYe+KNRI2P2ZRpnIA5yvmryQjut0adPUyUSupE27ZE6POF+fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iIGuOutW; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iIGuOutW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779384031; x=1810920031;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9/EoeqZiGjFlC3PtUtBcRacJu6Q4xuS49QjAnec6OUY=;
  b=iIGuOutWTYur3GE3hFEMYSWcDIw29zu1HLY/koRzXR+SOo9R3bmuF7Pg
   u+p5NaNo49LqPju9kiPHq34qpMXvm1B4KF5bvIgHh0omNqTrvthXI3qV0
   B4T0r+DxVhd24PdZcAgg7J28A1CZKdKJWLvwBf0oxQIWYQbMt/qu52uQu
   0TJ09Tsu0mXLFZP+jxWv+AJ/vUxagB7xYnPZxUUVE9rUWmrUXAXEJeMWn
   /PYtiQ2h9+9njsu2IqHavEl47XIaCgGfSnDPhWV+Qwfy2qSq4UMv+qWYF
   d+k6L25B1zRR21SOIwpaKkUFQxKTr59Vd9EkDrkb5QtHCONtFEQKjMLgA
   g==;
X-CSE-ConnectionGUID: eb2wIMtUSc+c4ZSchBCqGQ==
X-CSE-MsgGUID: j9P1M8U6RmyF1ot49+4jEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11793"; a="84192822"
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="84192822"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:20:29 -0700
X-CSE-ConnectionGUID: sLTOUXNHTLmzLesl7yInEw==
X-CSE-MsgGUID: 02sDLEK8Rm6sMyteOOh4WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,160,1774335600"; 
   d="scan'208";a="242386181"
Received: from cjhill-mobl.amr.corp.intel.com (HELO [10.125.110.16]) ([10.125.110.16])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2026 10:20:28 -0700
Message-ID: <f98724ee-249e-46a9-9a07-3be0e436adbb@intel.com>
Date: Thu, 21 May 2026 10:20:26 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] cxl/test: Enforce PMD alignment for volatile mock
 regions
To: Richard Cheng <icheng@nvidia.com>, Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
 ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260521083257.27753-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260521083257.27753-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/21/26 1:32 AM, Richard Cheng wrote:
> cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> from a volatile window inherits a non-PMD-aligned start, and
> cxl_dax_region_probe() -> alloca_dax_region() fails:
> 
> """
>     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
>                                 with error -12
> """
> 
> Enfore that every volatile mock CFMWS is PMD-aligned in both start and
> size.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Hi Richard,
I can't seem to apply this patch against v7.1-rc4. What base did you use?

DJ



> ---
> Changelog:
> 
> v1 -> v2:
>     - Reframe from "fix start alignment" to "enforce PMD invariant for
>       volatile CFMWS"
>     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
>     - Gate populate_cedt() alignment on
>       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
>     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
>       in cxl_test_init()
> 
> v1 link: https://lore.kernel.org/r/20260519233523.5991-1-icheng@nvidia.com/
> 
> Best regards,
> Richard Cheng.
> ---
>  tools/testing/cxl/test/cxl.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..09c309af5fd1 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -318,7 +318,7 @@ static struct {
>  			.restrictions = ACPI_CEDT_CFMWS_RESTRICT_HOSTONLYMEM |
>  					ACPI_CEDT_CFMWS_RESTRICT_VOLATILE,
>  			.qtg_id = FAKE_QTG_ID,
> -			.window_size = SZ_256M,
> +			.window_size = SZ_256M > PMD_SIZE ? SZ_256M : PMD_SIZE,
>  		},
>  		.target = { 3 },
>  	},
> @@ -495,9 +495,17 @@ static int populate_cedt(void)
>  
>  	for (i = cfmws_start; i <= cfmws_end; i++) {
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
> +		int align = SZ_256M;
>  
>  		cfmws_elc_update(window, i);
> -		res = alloc_mock_res(window->window_size, SZ_256M);
> +		if (window->restrictions & ACPI_CEDT_CFMWS_RESTRICT_VOLATILE)
> +			align = max_t(int, SZ_256M, PMD_SIZE);
> +		res = alloc_mock_res(window->window_size, align);
>  		if (!res)
>  			return -ENOMEM;
>  		window->base_hpa = res->range.start;
> @@ -1826,6 +1834,8 @@ static __init int cxl_test_init(void)
>  	int rc, i;
>  	struct range mappable;
>  
> +	BUILD_BUG_ON(!IS_ALIGNED(MOCK_AUTO_REGION_SIZE_DEFAULT, PMD_SIZE));
> +
>  	cxl_acpi_test();
>  	cxl_core_test();
>  	cxl_mem_test();

