Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD004D9F0
	for <linux-cxl@vger.kernel.org>; Mon,  1 Apr 2024 16:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711990246; cv=none; b=g6AeZ2g6bWmM4dTecrDwquiuO5BHpxXrZCz9MrimBQvMCUhRhOEnYRydWNAT/3M5RO7P7UDaTn+DcwEMsNMW653udMjMlOJy5KehdkYQs/+KAKgnVsEVSYyXUmZGMcYIrGo4QP9/znJ1bKjgpD9RfiQ3xjmyz5i3KMKGEJZ5CBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711990246; c=relaxed/simple;
	bh=05uehgqWrgkLNgm4S2vfJZ6POWa5R9t3NBgSoWDZKI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V1johyFSBzT8sLUXD9pAGbiv1BqFZVKIFSigOzoHvPJ67b3XQ1IV5VxI60j7nZpICYfQbnKwZ9mRj5Lh1tELvBD4bxKGgsGqDHwIUvN/acDIGXcS6LyZOQPlmKfzZeGq3+uN0Md+hvqOCP+pYSLo67sQKV0waxNb45RhD4WxXrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=azcYgdxE; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="azcYgdxE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711990243; x=1743526243;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=05uehgqWrgkLNgm4S2vfJZ6POWa5R9t3NBgSoWDZKI4=;
  b=azcYgdxEcFrIMCVAF5CPtBAMVOuFC51tvNdroSBJ91vpT7La9vtMnmvS
   K/3H5MQREraE9DfQrvXaUC4c56+aV6zYxYmbuxcd2C+tq8C1SQIVBtazW
   FDOeHAlMUrVSyYr5np/KitJbSaRyAsd37df3au+xPrwtjdoGX3Ks7oyme
   UkzT8mn1q46rEIbTh53bhXJBUI4YnFlntnYMalFtprC16CEgbrR9fNu4U
   ZHB0GE5B37RolYnd8TwAsroc4kgx8OF5pB66GRAPzDP9doeFnRJSJn7xk
   6ozozye9eLPOqA8SZCgVXEPmt3fxSSwictXdOna98twgLJ5Fc3LqmhESG
   Q==;
X-CSE-ConnectionGUID: V14Xv8uxRhG0N9KBDCmO8A==
X-CSE-MsgGUID: fpLJ2K86RDK5N3qNgBYqSA==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="18485939"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18485939"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 09:50:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="18164128"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.66.56])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 09:50:43 -0700
Date: Mon, 1 Apr 2024 09:50:40 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, jim.harris@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl/core/region: check interleave way capability
Message-ID: <Zgrl4HTeOPCow/tu@aschofie-mobl2>
References: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240401075635.9333-1-yaoxt.fnst@fujitsu.com>

On Mon, Apr 01, 2024 at 03:56:35AM -0400, Yao Xingtao wrote:
> I used qemu to emulaute the cxl.mem and attmpted to create a 6-way
> region, the region was created successfully, but I could not access the
> memory properly:
> $ numactl -m 2 ls
> Segmentation fault (core dumped)
> 
> I found the root cause is that the logic of converting HPA to DPA for
> 3-way, 6-way and 12-way were not implimented on qemu side.
> 
> But qemu has already disable the capability, so we should not create
> region in such ways.
> 
> So I think we should check whether the interleave way is supported by
> the target while attaching it to region.

Nice find!

I'm wondering if this may be done where other hdm caps are parsed,
at parse_hdm_decoder_caps() and saved as a capability of the port,
as opposed to reading the register on region creation attempts.

--Alison



> 
> Link: https://lore.kernel.org/qemu-devel/20240327014653.26623-1-yaoxt.fnst@fujitsu.com/T/#r
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/region.c | 25 +++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |  2 ++
>  2 files changed, 27 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c186e0a39b9..dde66b7c9e3f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1786,6 +1786,24 @@ static int cxl_region_sort_targets(struct cxl_region *cxlr)
>  	return rc;
>  }
>  
> +static bool check_iw_capability(struct cxl_endpoint_decoder *cxled, u8 iw)
> +{
> +	struct cxl_port *port = to_cxl_port(cxled->cxld.dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	u32 cap;
> +
> +	cap = readl(hdm + CXL_HDM_DECODER_CAP_OFFSET);
> +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY, cap) &&
> +	    (iw == 3 || iw == 6 || iw == 12))
> +		return false;
> +
> +	if (!FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_16_WAY, cap) && iw == 16)
> +		return false;
> +
> +	return true;
> +}
> +
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> @@ -1796,6 +1814,13 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  	struct cxl_dport *dport;
>  	int rc = -ENXIO;
>  
> +	if (!check_iw_capability(cxled, p->interleave_ways)) {
> +		dev_dbg(&cxlr->dev,
> +			"%s with region interleave ways: %d is not supported\n",
> +			dev_name(&cxled->cxld.dev), p->interleave_ways);
> +		return -EOPNOTSUPP;
> +	}
> +
>  	if (cxled->mode != cxlr->mode) {
>  		dev_dbg(&cxlr->dev, "%s region mode: %d mismatch: %d\n",
>  			dev_name(&cxled->cxld.dev), cxlr->mode, cxled->mode);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 534e25e2f0a4..da8a487ededa 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -45,6 +45,8 @@
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
>  #define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define   CXL_HDM_DECODER_INTERLEAVE_3_6_12_WAY BIT(11)
> +#define   CXL_HDM_DECODER_INTERLEAVE_16_WAY BIT(12)
>  #define CXL_HDM_DECODER_CTRL_OFFSET 0x4
>  #define   CXL_HDM_DECODER_ENABLE BIT(1)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> -- 
> 2.37.3
> 
