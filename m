Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBAFF19F11B;
	Thu, 28 May 2026 15:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779982546; cv=none; b=tyqI8YOslr4eICdKT15dUUXwnR0p9d3DMt/V404PS00h93qL0A2jUK6uBYxF0IezB0ETFz6DimaB4L57Uk/Q8xSpOnbSwzNWdS90YtrLVEowvq+yLX6ez9+BAm+ckFnmnt34KqPw4ASHdDKONGWbDfpLY+HKpOMVYoDezYy0pO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779982546; c=relaxed/simple;
	bh=IgK1y52ooMLoMSRqWF+bmH+DLIqi0OwpQ60lSfJb51A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IPAM8fCzUik9pfeRwF0du/3D9hT1x4Qve5u2uZM72vZhkER0VdCe75X7gNfhgVreLdTHoYdyfIyW2KtumkIsoIzFyHzxg/IwK/wM0gqRF6+yUtkVzNfsvnPq8pJr49YmyIKqzPG2GtKy0SHwIXHEIr9zCgAJLWkHJoXqVXldMkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hZv+B4Jg; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hZv+B4Jg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779982546; x=1811518546;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IgK1y52ooMLoMSRqWF+bmH+DLIqi0OwpQ60lSfJb51A=;
  b=hZv+B4JgL/9SF+Ay6kqrZEXowYXEJKbMp/phQIzkU0YcRXsZyK/wFtZX
   yFm+Ohy15kgL7EXw9b6eewj07pi7rlXObtenmDt6ObNorush2118PT/WO
   RmP4G48fJ3zN9aKOMqR2jK8gOGavKX6Sh8KtPQhBiYrOllpYKINIw4N5F
   Qbh9fbGvQp7eTo63yQ0ZVFwue5lFF5e5CODLoSiQCmbERxT1oSPhfP1FI
   fmVHfAVlFLgPHDLJab0lVb3XJ4CJJFXKp00ObWGfPGBBzd+rX5eX1niVH
   dCgCTZlzbZESS2VCNXefqG1karOHnumtUYn1x+VHST9QvCQp36lSS/J/A
   g==;
X-CSE-ConnectionGUID: z69dfcxMSveaLnfAXjw4Bg==
X-CSE-MsgGUID: pfqhbMuQQMejPbPITmghAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11800"; a="80819253"
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="80819253"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:35:45 -0700
X-CSE-ConnectionGUID: iaOxe5c/TJ+QZlYnY79EvQ==
X-CSE-MsgGUID: 7v9auB8NQruRTImx5h1EqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,173,1774335600"; 
   d="scan'208";a="272914858"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.111.91]) ([10.125.111.91])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2026 08:35:45 -0700
Message-ID: <45d678e0-b482-4302-abee-db8b66d24900@intel.com>
Date: Thu, 28 May 2026 08:35:43 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] cxl/test: Enforce PMD alignment for volatile mock
 regions
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: fabio.m.de.francesco@linux.intel.com, rrichter@amd.com,
 ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, newtonl@nvidia.com, kristinc@nvidia.com,
 kaihengf@nvidia.com, kobak@nvidia.com
References: <20260527090332.30002-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260527090332.30002-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/27/26 2:03 AM, Richard Cheng wrote:
> cxl_test allocates synthetic CFMWS HPA windows from a gen_pool with
> SZ_256M alignment. On arm64 with CONFIG_ARM64_64K_PAGES=y and
> CONFIG_PGTABLE_LEVELS=3, PMD_SIZE is 512M, so every CXL region carved
> from a volatile window inherits a non-PMD-aligned start, and
> cxl_dax_region_probe() -> alloc_dax_region() fails:
> 
> """
>     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
>                                 with error -12
> """
> 
> Enforce that every volatile mock CFMWS is PMD-aligned in both start and
> size
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> Signed-off-by: Richard Cheng <icheng@nvidia.com>

Applied to cxl/next
8850852b25f7884d9804f8de5591edb3881bd674

> ---
> Changelog:
> 
> v3->v4:
>     - Replace compile-time BUILD_BUG_ON() with runtime
>       IS_ALIGNED(mock_auto_region_size, PMD_SIZE) check in
> cxl_test_init().
> 
> v2->v3:
>     - Correct hunk headers
>     - Add base commit SHA
> 
> v1->v2:
>     - Reframe from "fix start alignment" to "enforce PMD invariant for
>       volatile CFMWS"
>     - Bump cfmws5.window_size to max(SZ_256M, PMD_SIZE)
>     - Gate populate_cedt() alignment on
>       ACPI_CEDT_CFMWS_RESTRICT_VOLATILE so PMEM windows stay at SZ_256M
>     - Add BUILD_BUG_ON for MOCK_AUTO_REGION_SIZE_DEFAULT v.s. PMD_SIZE
>       in cxl_test_init()
> 
> Best regards,
> Richard Cheng.
> ---
>  tools/testing/cxl/test/cxl.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..6f8fa7504cad 100644
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
> @@ -495,9 +495,12 @@ static int populate_cedt(void)
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
> @@ -1826,6 +1829,12 @@ static __init int cxl_test_init(void)
>  	int rc, i;
>  	struct range mappable;
>  
> +	if (!IS_ALIGNED(mock_auto_region_size, PMD_SIZE)) {
> +		pr_err_once("mock_auto_region_size %d must be PMD-aligned\n",
> +			    mock_auto_region_size);
> +		return -EINVAL;
> +	}
> +
>  	cxl_acpi_test();
>  	cxl_core_test();
>  	cxl_mem_test();
> 
> base-commit: 507bd4b66c85d5b65696150cc16d31ac0b2ab151

