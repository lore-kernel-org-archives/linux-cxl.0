Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2281E3795
	for <linux-cxl@vger.kernel.org>; Fri,  4 Oct 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728060227; cv=none; b=Ls8m2nTNkzE1DGcnxKxQykryT4bhw/KlSU8yuQeEYdaKUMtyq3HktGhXLePniHg493/+ieYS6bk5FpjMRKpYSBlvWdkZGAGTHiv6V1Jy0F4jQVbUcaTmw2B/B+u0CO+XYPDKzayt8ccX05ouBKXfdcuxcu6TA+YEKndumHb3eE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728060227; c=relaxed/simple;
	bh=caWUEqBo9JBzKr5pYbO48z5AX97RvRUEdO9pFaTQp2A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=htHBWkzYjgMUJxnC1X7pOU9Cj63kpl36MPxnACuJQwXbKwI12SIzKl+hAG8vcbFM1UfGXdVvKcS9gUGyhF2n1rY6O0U2EBPVg9jGPVXZWlJRfjgao+WvRzn1MjgYlTeoZxDmOJcDo/sKVQ+9pTfu82FE+GcO776u7FABzXGSYtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MFqkjsD8; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MFqkjsD8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728060225; x=1759596225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=caWUEqBo9JBzKr5pYbO48z5AX97RvRUEdO9pFaTQp2A=;
  b=MFqkjsD8ma+o0R0XEg4sMww5Kak/GFJhNtl6tkR8vjljfPgwc9Zn8B3V
   bj+xxkJZHa5/n3iDsRZejU8tbyzFktyjl28W08IpP39NbjZAKC7l2f/4A
   7mHCJR7N3DbJTKykr9NMOHDanudgpVTkmTYxLbBVivzLhfBFqWwa13zmK
   Ym26LaJHAd3H3i/22NGw6ZzSNKyWEuej22NRnp+2ODOY870/SzutLabrd
   mWVeDBQaC19yRzHLxFUwJEESVKrCWsHB9DepTAQ5bZI32vfs56yHlB778
   TM3qdrY4qQGdPrQl5GeOgqgylEdb1iEYezpAADqM4Lv+LMrEltFStt/dg
   A==;
X-CSE-ConnectionGUID: RslXPTDjTEGinRdclVH36Q==
X-CSE-MsgGUID: ZFY1pd+ZR1adUzJvJ1NGpg==
X-IronPort-AV: E=McAfee;i="6700,10204,11215"; a="49819574"
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="49819574"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 09:43:44 -0700
X-CSE-ConnectionGUID: 2VDto1VuR9CEQpmZjbXNAQ==
X-CSE-MsgGUID: 8CmPP9bVTLSLS36Z2gLxCw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,178,1725346800"; 
   d="scan'208";a="98081677"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.218])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2024 09:43:43 -0700
Date: Fri, 4 Oct 2024 09:43:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, dave.jiang@intel.com,
	dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <ZwAbPFS7XqxCrI7U@aschofie-mobl2.lan>
References: <20240930203445.149954-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240930203445.149954-1-dave@stgolabs.net>

On Mon, Sep 30, 2024 at 01:34:45PM -0700, Davidlohr Bueso wrote:
> Update the CXL PMU driver to support the new events introduced
> in the latest revision. These are:
> 
> - read/write accesses with TEE constraints.
> - S2M indicating Modified state.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Changes from v1:
>  - only update spec references of groups that are affected (Alison, Dave).
> 

Typo in a comment s/Opcopdes/Opcodes may be fixed-up upon applying.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

>  drivers/perf/cxl_pmu.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 43d68b69e630..644caf039718 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -377,12 +377,14 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	/* CXL rev 3.0 Table 13-5 directly lists these */
>  	CXL_PMU_EVENT_CXL_ATTR(cachedata_d2h_data,		CXL_PMU_GID_CACHE_DATA, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(cachedata_h2d_data,		CXL_PMU_GID_CACHE_DATA, BIT(1)),
> -	/* CXL rev 3.0 Table 3-29 M2S Req Memory Opcodes */
> +	/* CXL rev 3.1 Table 3-35 M2S Req Memory Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminv,			CXL_PMU_GID_M2S_REQ, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrd,			CXL_PMU_GID_M2S_REQ, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddata,		CXL_PMU_GID_M2S_REQ, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdfwd,		CXL_PMU_GID_M2S_REQ, BIT(3)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memwrfwd,		CXL_PMU_GID_M2S_REQ, BIT(4)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrdtee,		CXL_PMU_GID_M2S_REQ, BIT(5)),
> +	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memrddatatee,		CXL_PMU_GID_M2S_REQ, BIT(6)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memspecrd,		CXL_PMU_GID_M2S_REQ, BIT(8)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_meminvnt,		CXL_PMU_GID_M2S_REQ, BIT(9)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_req_memcleanevict,		CXL_PMU_GID_M2S_REQ, BIT(10)),
> @@ -404,10 +406,11 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_curblk,		CXL_PMU_GID_S2M_BISNP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_datblk,		CXL_PMU_GID_S2M_BISNP, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_invblk,		CXL_PMU_GID_S2M_BISNP, BIT(6)),
> -	/* CXL rev 3.0 Table 3-43 S2M NDR Opcopdes */
> +	/* CXL rev 3.1 Table 3-50 S2M NDR Opcopdes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmp,			CXL_PMU_GID_S2M_NDR, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmps,			CXL_PMU_GID_S2M_NDR, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpe,			CXL_PMU_GID_S2M_NDR, BIT(2)),
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmpm,			CXL_PMU_GID_S2M_NDR, BIT(3)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_biconflictack,		CXL_PMU_GID_S2M_NDR, BIT(4)),
>  	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),
> -- 
> 2.46.1
> 
