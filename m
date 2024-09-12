Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014ED22301
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 01:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726103853; cv=none; b=udcthq7I939ruQJthFbUwVFm8DQ/V2wQP/vNOKUSHB9B022IY3l+tgmHLNzB4OL17WaBHhBaInUI18v2vRBGCSPCGybRKviGFBaRXzqWnAxlfocjdDcMI/L2mIzhSS05DM38U1ia/22khTvNXNg4UEA1fs30JfvkWkEAm65oB2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726103853; c=relaxed/simple;
	bh=q7W3Lklb8xq3jkLcAl6nJjhTZv8wuDrAZEyuiOCMDQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jWJMYzw4AB0dkEB94w+BGLh3L/cuBH47jF5muftSBwL6EcbhFQmhAzOP6OM87LFk0wQFxWDr4F3FGio50MSp0ahB4j8if0oVxGEGA/HoemOgYbB4A2TQ1qJHp+TjxRfnvLAhgrUlc/W2Gw3gykdAdimykIOpuBn58/Kcnb945EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G6I3IUwG; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G6I3IUwG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726103852; x=1757639852;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=q7W3Lklb8xq3jkLcAl6nJjhTZv8wuDrAZEyuiOCMDQc=;
  b=G6I3IUwGuQkzruYf0nRi2WGtkxlBZZ4nqPMWcDdFx/JGtuEKEz1N+TuV
   ih5K9NEGAkLnlT9xxRabVxhQylMb/UfOt47hDvf2Dkud6SL8LxHEh9nkz
   rnpsO0X1yZ9MTX8BRVxfaMFa/j7mymt0tIy1vRkppUCPnrVlQMc0f6agh
   QotS34yGfV6h9C5WV2335aJnU+IcpeKR7Cjt9IOYl/Jhs3yB/VGJ3HMpu
   VTLpHN7VqVs90ZcTS1o8cwo4CTL3vnmQct6WUv5uDFJN7g6bEU7RFy74V
   2TKW4s2mg86mKe9vhuFfoki8WiO7LzaHqL0GSZC4Lh+SeluljdeCJIa64
   w==;
X-CSE-ConnectionGUID: yUiEc0PmSVOYfVzYkTtX1Q==
X-CSE-MsgGUID: bd6JrbsdRzm/fLEQbrQNwQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11192"; a="47448183"
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="47448183"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:17:32 -0700
X-CSE-ConnectionGUID: nYPPflpvQ8WHh76bvfFgpg==
X-CSE-MsgGUID: 45KZYb61QqqlgrhgPY7FPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,221,1719903600"; 
   d="scan'208";a="67167152"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.5])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2024 18:17:31 -0700
Date: Wed, 11 Sep 2024 18:17:28 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] perf/cxlpmu: Support missing events in 3.1 spec
Message-ID: <ZuJBKHi-l3YSgDEW@aschofie-mobl2.lan>
References: <20240911215221.308483-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911215221.308483-1-dave@stgolabs.net>

On Wed, Sep 11, 2024 at 02:52:21PM -0700, Davidlohr Bueso wrote:
> Update the CXL PMU driver to support the new events introduced
> in the latest revision. These are:
> 
> - read/write accesses with TEE constraints.
> - S2M indicating Modified state.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/perf/cxl_pmu.c | 31 ++++++++++++++++++-------------
>  1 file changed, 18 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
> index 1f93a66eff5b..13005f410ee0 100644
> --- a/drivers/perf/cxl_pmu.c
> +++ b/drivers/perf/cxl_pmu.c
> @@ -63,7 +63,7 @@
>  
>  #define CXL_PMU_COUNTER_REG(n)		(0xc00 + 8 * (n))
>  
> -/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
> +/* CXL rev 3.1 Table 13-5 Events under CXL Vendor ID */

I hesitate to be picky here, but also I don't think we want to set
a precedent. In CXL-land at least, I don't think it is our intent
to keep spec revisions, sections, tables updated in general.

That makes me think the only places where this patch should reference
3.1 is for the new items you added. All the extra spec updates can be
omitted.

Maybe perf folks are different about this?

It's a nit. Ignore if you disagree ;)




>  #define CXL_PMU_GID_CLOCK_TICKS		0x00
>  #define CXL_PMU_GID_D2H_REQ		0x0010
>  #define CXL_PMU_GID_D2H_RSP		0x0011
> @@ -338,7 +338,7 @@ static ssize_t cxl_pmu_event_sysfs_show(struct device *dev,
>  
>  static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(clock_ticks,			CXL_PMU_GID_CLOCK_TICKS, BIT(0)),
> -	/* CXL rev 3.0 Table 3-17 - Device to Host Requests */
> +	/* CXL rev 3.1 Table 3-22 - Device to Host Requests */
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_req_rdcurr,			CXL_PMU_GID_D2H_REQ, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_req_rdown,			CXL_PMU_GID_D2H_REQ, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_req_rdshared,		CXL_PMU_GID_D2H_REQ, BIT(3)),
> @@ -354,7 +354,7 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_req_wowrinvf,		CXL_PMU_GID_D2H_REQ, BIT(13)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_req_wrinv,			CXL_PMU_GID_D2H_REQ, BIT(14)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_req_cacheflushed,		CXL_PMU_GID_D2H_REQ, BIT(16)),
> -	/* CXL rev 3.0 Table 3-20 - D2H Repsonse Encodings */
> +	/* CXL rev 3.1 Table 3-25 - D2H Response Encodings */

I'd let that one get it just to sneak in the spelling correction.


>  	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihiti,		CXL_PMU_GID_D2H_RSP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvhitv,		CXL_PMU_GID_D2H_RSP, BIT(6)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspihitse,		CXL_PMU_GID_D2H_RSP, BIT(5)),
> @@ -362,11 +362,11 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspsfwdm,		CXL_PMU_GID_D2H_RSP, BIT(7)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspifwdm,		CXL_PMU_GID_D2H_RSP, BIT(15)),
>  	CXL_PMU_EVENT_CXL_ATTR(d2h_rsp_rspvfwdv,		CXL_PMU_GID_D2H_RSP, BIT(22)),
> -	/* CXL rev 3.0 Table 3-21 - CXL.cache - Mapping of H2D Requests to D2H Responses */
> +	/* CXL rev 3.1 Table 3-26 - CXL.cache - Mapping of H2D Requests to D2H Responses */
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_req_snpdata,			CXL_PMU_GID_H2D_REQ, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_req_snpinv,			CXL_PMU_GID_H2D_REQ, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_req_snpcur,			CXL_PMU_GID_H2D_REQ, BIT(3)),
> -	/* CXL rev 3.0 Table 3-22 - H2D Response Opcode Encodings */
> +	/* CXL rev 3.1 Table 3-27 - H2D Response Opcode Encodings */
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_writepull,		CXL_PMU_GID_H2D_RSP, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_go,			CXL_PMU_GID_H2D_RSP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_gowritepull,		CXL_PMU_GID_H2D_RSP, BIT(5)),
> @@ -374,45 +374,50 @@ static struct attribute *cxl_pmu_event_attrs[] = {
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_gowritepulldrop,		CXL_PMU_GID_H2D_RSP, BIT(8)),
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_fastgowritepull,		CXL_PMU_GID_H2D_RSP, BIT(13)),
>  	CXL_PMU_EVENT_CXL_ATTR(h2d_rsp_goerrwritepull,		CXL_PMU_GID_H2D_RSP, BIT(15)),
> -	/* CXL rev 3.0 Table 13-5 directly lists these */
> +	/* CXL rev 3.1 Table 13-5 directly lists these */
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
> -	/* CXL rev 3.0 Table 3-35 M2S RwD Memory Opcodes */
> +	/* CXL rev 3.1 Table 3-41 M2S RwD Memory Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwr,			CXL_PMU_GID_M2S_RWD, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_memwrptl,		CXL_PMU_GID_M2S_RWD, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_rwd_biconflict,		CXL_PMU_GID_M2S_RWD, BIT(4)),
> -	/* CXL rev 3.0 Table 3-38 M2S BIRsp Memory Opcodes */
> +	/* CXL rev 3.1 Table 3-45 M2S BIRsp Memory Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_i,			CXL_PMU_GID_M2S_BIRSP, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_s,			CXL_PMU_GID_M2S_BIRSP, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_e,			CXL_PMU_GID_M2S_BIRSP, BIT(2)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_iblk,			CXL_PMU_GID_M2S_BIRSP, BIT(4)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_sblk,			CXL_PMU_GID_M2S_BIRSP, BIT(5)),
>  	CXL_PMU_EVENT_CXL_ATTR(m2s_birsp_eblk,			CXL_PMU_GID_M2S_BIRSP, BIT(6)),
> -	/* CXL rev 3.0 Table 3-40 S2M BISnp Opcodes */
> +	/* CXL rev 3.1 Table 3-47 S2M BISnp Opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_cur,			CXL_PMU_GID_S2M_BISNP, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_data,			CXL_PMU_GID_S2M_BISNP, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_bisnp_inv,			CXL_PMU_GID_S2M_BISNP, BIT(2)),
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
> -	/* CXL rev 3.0 Table 3-46 S2M DRS opcodes */
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_ndr_cmptee,			CXL_PMU_GID_S2M_NDR, BIT(5)),
> +	/* CXL rev 3.1 Table 3-53 S2M DRS opcodes */
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdata,			CXL_PMU_GID_S2M_DRS, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatanxm,		CXL_PMU_GID_S2M_DRS, BIT(1)),
> -	/* CXL rev 3.0 Table 13-5 directly lists these */
> +	CXL_PMU_EVENT_CXL_ATTR(s2m_drs_memdatatee,		CXL_PMU_GID_S2M_DRS, BIT(2)),
> +	/* CXL rev 3.1 Table 13-5 directly lists these */
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_act,				CXL_PMU_GID_DDR, BIT(0)),
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_pre,				CXL_PMU_GID_DDR, BIT(1)),
>  	CXL_PMU_EVENT_CXL_ATTR(ddr_casrd,			CXL_PMU_GID_DDR, BIT(2)),
> -- 
> 2.46.0
> 
> 
