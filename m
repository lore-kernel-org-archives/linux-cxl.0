Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8BDB18B47E
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 21:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968702; cv=none; b=VZ6sIu4l7NUmkFXVF2u8WrooSTboSK07FLtlMRzNDPjZFNEOGRno413JO1XKn6ay+0ppOimUKf8nVb7ZfSknorm5si7qbnu/1EK9sj+6L7oHWsh4vGMWWtfYgieVoC1irAGXJUgglYEBmif6gvNaRYH4H7zzgMfrE639snEiS8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968702; c=relaxed/simple;
	bh=cTOYhJm/3/7C0kAOVdiv9/C3h0bY4V4dBiw4UrsmMbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mQvITtEKGAqxknGSgbDZIoVwNIz0gyFQbt4CSVsTvaVKpUUOQaLnAoUArGnBXmy471SyJeYVkWI6VYzr1wADdEKXmJFxqKI3zwRHuL76u2P9OUJ8tt2WbWscBt1XewQ2L/Vp2j5cKPdzXEGxMtoPDqfph3M/Y42NHvhrVfw8Gr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dsCehHv8; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dsCehHv8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724968701; x=1756504701;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cTOYhJm/3/7C0kAOVdiv9/C3h0bY4V4dBiw4UrsmMbk=;
  b=dsCehHv8GT3ttuonUPko+vNrWA+JhDt7hgt55ItRsiOJZJ2h8z738Ump
   rMDIfs1JJ4gc2ZhL0KU98Gpengb4DEpIln2nZys+jKn3kzk7rBcR3RyNO
   GYNx2uFpUmpoAYbqNShSrvhr2SQ/TIdfoK1HmJBSqMvDlreviGp6HJ6kt
   uYZi+B2QOem0xF43RWh6EjMv8/X1cm78A4WCAvwoflHdR1dPmKMeRxvCM
   wiDcvQmzKsNCTMwRw/1q93cbBnq+fkLwMc4KasJhmtiyhyrs+qVCoDnyR
   rPhulgVInOzVImqWsjnGkwC97L8/n1tqUTDlSyhxlVAEeOc8jZqvZxm2H
   g==;
X-CSE-ConnectionGUID: 8RZG8tfGR7KZJO0rGhCnNQ==
X-CSE-MsgGUID: v6q5RuK9SjSq3zwT1Dt6nA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="23457622"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="23457622"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:58:20 -0700
X-CSE-ConnectionGUID: 3OvPl6AeQJamN3kX4GEqYw==
X-CSE-MsgGUID: s7GohTA4Tk+ZxrrUVRJMag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="94451642"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:58:21 -0700
Date: Thu, 29 Aug 2024 14:58:18 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, ming4.li@intel.com
Subject: Re: [v4 3/4] cxl/pci: Check Mem_info_valid bit for each applicable
 DVSEC
Message-ID: <ZtDu-kTRwSph5QAG@aschofie-mobl2.lan>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
 <20240828084231.1378789-4-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828084231.1378789-4-yanfei.xu@intel.com>

On Wed, Aug 28, 2024 at 04:42:30PM +0800, Yanfei Xu wrote:
> In theory a device might set the mem_info_valid bit for a first range
> after it is ready but before as second range has reached that state.
> Therefore, the correct approach is to check the Mem_info_valid bit for
> each applicable DVSEC range against HDM_COUNT, rather than only for the
> DVSEC range 1. Consequently, let's move the check into the "for loop"
> that handles each DVSEC range.

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  drivers/cxl/core/pci.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f29af0b788d9..cda22feadbd3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -324,10 +324,6 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  	if (!hdm_count || hdm_count > 2)
>  		return -EINVAL;
>  
> -	rc = cxl_dvsec_mem_range_valid(cxlds, 0);
> -	if (rc)
> -		return rc;
> -
>  	/*
>  	 * The current DVSEC values are moot if the memory capability is
>  	 * disabled, and they will remain moot after the HDM Decoder
> @@ -345,6 +341,10 @@ int cxl_dvsec_rr_decode(struct device *dev, struct cxl_port *port,
>  		u64 base, size;
>  		u32 temp;
>  
> +		rc = cxl_dvsec_mem_range_valid(cxlds, i);
> +		if (rc)
> +			return rc;
> +
>  		rc = pci_read_config_dword(
>  			pdev, d + CXL_DVSEC_RANGE_SIZE_HIGH(i), &temp);
>  		if (rc)
> -- 
> 2.39.2
> 
