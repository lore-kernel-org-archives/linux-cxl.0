Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BADD3EE1EE;
	Wed, 20 May 2026 14:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779289001; cv=none; b=MQbNZujH13iZk8qyRCfnVgDsQSmwYeR+NbS2IpLJRP7P+exNeZ49R3Y6W4UMj8WReQxtp5lLhkXx81RHF88gbugZQ1Qw91ucfSoXAMeuNXIgi21eD2tggoZNNj31w4tPFZ+Uk1ug12lUS/rHEG4QxFU+H1jM3ZZOwfNajpusVv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779289001; c=relaxed/simple;
	bh=xuNi0xiASqqfEloY3Pmvynl8rKpwTvcAtKkliqBdZuM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YMBgGUecY1YzFSvCA4pCp1zB6DO7V6ksxeHrya+zSATrJv9sSKFlCXmI7LcTfwZATQHHqk64ME8N34Op7vuiztkx0o0M424KfmEz2tWsrHkEOea/7mz8m6m3Zo59Zn3ncrScna+m02RYSZ8k+MnK+4iLCv3Iu8ESzmCsifpGkdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Qg6mHF3R; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Qg6mHF3R"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1779288999; x=1810824999;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xuNi0xiASqqfEloY3Pmvynl8rKpwTvcAtKkliqBdZuM=;
  b=Qg6mHF3RdS1jtOgHD2QJbAsTjydgU+dRKuzt0DT+hNaGvCyE9U2eD4y+
   PP8shp1ON2A5aXUP45IMCGkfHD7jLqTvjfxv16gej6SOgazDZsEyxjAT9
   wDJEU/8l7ggJjEHir6li4Bmq0uoQSHiKUyisizzJpvkN2NCa6yOX9Mtl5
   8iXBerZlecF33CR114qna9qArNogi9sthGzHBBWggE/UmhbIGsmQWp+9+
   EX68ktqxHaIfaKGahNStDHShskY4jVr4yOz0zXDUZl8GSXDLCq4qn92Jq
   Bs9//7V812wr5gMZYBXdg5CmWQbcTqDwkMIughPRGsB5Uc+/Voe+qzdaF
   g==;
X-CSE-ConnectionGUID: Jo47flIkRmm3pXzyI18/vg==
X-CSE-MsgGUID: CuHmHDIGT8i+fMdi9XrwEg==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="90487358"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="90487358"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 07:56:38 -0700
X-CSE-ConnectionGUID: XlSQa1WqQyifenaTUyFIag==
X-CSE-MsgGUID: VFSbqdYOSXu03svpfwFclQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; 
   d="scan'208";a="240071354"
Received: from bradocaj-mobl.ger.corp.intel.com (HELO [10.125.109.205]) ([10.125.109.205])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2026 07:56:37 -0700
Message-ID: <ee59d270-5cb1-4eb5-ad4e-f5ae2fb27449@intel.com>
Date: Wed, 20 May 2026 07:56:35 -0700
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
> 
> Signed-off-by: Richard Cheng <icheng@nvidia.com>
> Acked-by: Kai-Heng Feng <kaihengf@nvidia.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Does this need a fixes tag?

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

