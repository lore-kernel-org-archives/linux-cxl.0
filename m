Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5643C3F4DD6;
	Wed, 20 May 2026 18:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301108; cv=none; b=ajLAlKlRaCigy29rcWxr44XDMAfoz8qDyRWNROOOJzMFHY8cGGhqcbed+n1EzqVilohl6Vo0MpnB8+m1G+ZzMB+miMPMHU3D4vlH5kWkWEKxL41O8z1AWmvg1kYmU4ASqkUR2Ru899+QyfVqlDI6aDKbrQMuYZPx+JcatSPUAB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301108; c=relaxed/simple;
	bh=gy/m35HK5R8C7OR4BcbU0s0pFCv8bAQqfqz4IIZi8A4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=epChi5Vwx/dmTTFCSE9w2yKCOlhTmXwTawhyAO7wcqClTs6FkDkPZDYyTivTcbomnwZjnIFKl0hcjpE1QP5siLd5pTqcgQGzvcsmqf5a/Ov9DLCNB+9j8Oqun15BWfLJbD2STc0VfrXpgJaWIjNMfspy5T2VRvuk4qwWKon/Rys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fWZwpr+W; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fWZwpr+W"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779301108; x=1810837108;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=gy/m35HK5R8C7OR4BcbU0s0pFCv8bAQqfqz4IIZi8A4=;
  b=fWZwpr+WYVpKyfVbbGLP3Xqxusvs+b/NELp+fuh+10gakAtsT9ou4jBS
   IP+NKD4uxc41K1mK3lKd+vaGIQl13JEVcBlfDdLDDaZ8Qgpf1dvujXPIi
   gp5zBuUolB5O3bPjOwxhNfGiIRVLNsc9TrwIXpVSoK+n9wmzjmUWYq1xW
   TEIJOB90pbrnen/+xumWETLI3ixh16zJwVLlktHK1MDcH4hZ1dzgqTV8n
   ITkHHrLAwoICl4Ydc2w7T1yWC8UYp+TZC1sauS3cxaGFZcPCmVlsAJBY2
   0bckshNSDJzRmGsjBuzHXQSsh1c8Tn/MJNO05N7IC/ZILQAqJsbWnQboO
   g==;
X-CSE-ConnectionGUID: hXlSkvIPS+22BVXTZt6j6Q==
X-CSE-MsgGUID: CqT2MmhtThah17Mot/3tIQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="79236318"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="79236318"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:18:27 -0700
X-CSE-ConnectionGUID: Y+HAddT+Qp6qQu2M+r0nww==
X-CSE-MsgGUID: Noowu3A7QjeMsoprFlNSXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="235850596"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 11:18:25 -0700
Message-ID: <144e80e3-1813-4c77-8c43-1f350f74230c@intel.com>
Date: Wed, 20 May 2026 11:18:23 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tools/testing/cxl: Align mock CFMWS to PMD_SIZE for ARM64
 64K pages
To: Richard Cheng <icheng@nvidia.com>, dave@stgolabs.net
Cc: jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com,
 fabio.m.de.francesco@linux.intel.com, ming.li@zohomail.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, newtonl@nvidia.com,
 kristinc@nvidia.com, kaihengf@nvidia.com, kobak@nvidia.com
References: <20260519233523.5991-1-icheng@nvidia.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260519233523.5991-1-icheng@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/19/26 4:35 PM, Richard Cheng wrote:
> cxl_test allocate synthetic CFMWS HPA windows out of a gen_pool and asks
> the allocator for SZ_256M alignment. It has been sufficient on x86 with
> 4k pages, arm64 with 4k pages since their PMD_SIZE are 2MB.
> 
> But for 64k-page arm64 kernel with CONFIG_ARM64_64K_PAGES=y and
> CONFIG_PGTABLE_LEVELS=3 , the PMD_SIZE is 512 MB, which is much larger
> than the alignment cxl_test guarantees. That results in every CXL region
> carved from that window inherits a mis-aligned start.
> 
> The DAX driver's cxl_dax_region_probe() then calls "alloc_dax_region()
> and the probe fails with -ENOMEM, with error message
> 
> """
>     cxl_dax_region dax_region1: probe with driver cxl_dax_region failed
>                                 with error -12
> """
> 
> It was hit while bringing up cxl_test on an ARM64 server with
> ARM64_64K_PAGES config.
> 
> Raise the alignment passed to "alloc"mock_res()" to the larger of
> SZ_256M and PMD_SIZE so that the mock CFMWS window is always at least as
> well-aligned as "alloc_dax_region()" require.

https://sashiko.dev/#/patchset/20260519233523.5991-1-icheng%40nvidia.com

Do you need to adjust length as well as alloc_dax_region() also checks length alignment?

DJ

> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>
> ---
>  tools/testing/cxl/test/cxl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 418669927fb0..b40e4bbcc958 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -497,7 +497,8 @@ static int populate_cedt(void)
>  		struct acpi_cedt_cfmws *window = mock_cfmws[i];
>  
>  		cfmws_elc_update(window, i);
> -		res = alloc_mock_res(window->window_size, SZ_256M);
> +		res = alloc_mock_res(window->window_size,
> +				     max_t(int, SZ_256M, PMD_SIZE));
>  		if (!res)
>  			return -ENOMEM;
>  		window->base_hpa = res->range.start;

