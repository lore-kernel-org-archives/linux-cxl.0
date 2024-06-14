Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8908A19D894
	for <linux-cxl@vger.kernel.org>; Fri, 14 Jun 2024 04:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718341059; cv=none; b=DWVOHUyK36HeG0SRkka0lcIyRWg6xWxap53ItYQsGq8XcdbOQ+MHzVuYjnGgQ0W+Mrp/WcW6gPxVF0vUQExlkRXyJ2vxoIRzXmIbKQANaEuZp6sy5SZPhjW7d6PkuxzhGgmpw31DGxdFJNorj/mAZIhXyJYS9SEin6YOcvKglPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718341059; c=relaxed/simple;
	bh=ldTMtVVtVtE19FvPUKkY0Mp++T2hjtQ1+Ry9tdDS4Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XPQEFxvW6Mjs8e6uMdCn+pUNclQ7UueIRJK7M/2X0KqUKuMmojNUg/d2fKtTl8MYDUnse54alLxBgqqQ3LxK1IqMfZ3UwyhYFGgIGoIv7ytfOuAPtTAR7ZmKZu9BmViolKRsFIUbL1jA2JYHvi9MUwBcWSaTNk+I6mL2+fWik5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZRmxgEw3; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZRmxgEw3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718341058; x=1749877058;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ldTMtVVtVtE19FvPUKkY0Mp++T2hjtQ1+Ry9tdDS4Gc=;
  b=ZRmxgEw35+keOWpvWjCTDqnlaiTcv9k7YZa77bUKgyLznbFUKF6Bfteq
   CIvH9jRn2KNdJTQ0PSu9TiPTJk9qOETzDnkRVrLpSfMdQtf1U4u8WrrCM
   MzyNsnZbct3emsgBX8Zw5RdVnI3iG4Ogkk4oqwizg5AjyUAN0tfmkGyB+
   KQMDVlQJFmoELR53uIPy56skbhQw/9849iL4PKNeoyOIRH/MPAkVtsgRC
   TT5EGHTA1kePWRSUZFfPNm1FKmnsHc3BfkhVkyyC8JoD2v03L8WH7sqIL
   ybM4eRrGlaZmgRZwkAkJ+J1sJ3zf//XG8WdKKQvLwf4Sf8Tz5R8GFT0N2
   Q==;
X-CSE-ConnectionGUID: 5DlysURYTqOAO0/kl7M7sA==
X-CSE-MsgGUID: 2DX9SQirQequsi/6k848TA==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="15084559"
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="15084559"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 21:57:37 -0700
X-CSE-ConnectionGUID: UxDVOokCTu+r5UM/oYPf9A==
X-CSE-MsgGUID: oBS79BEEQguN491efE5kyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,236,1712646000"; 
   d="scan'208";a="44909597"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.251.22.236])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2024 21:57:36 -0700
Date: Thu, 13 Jun 2024 21:57:34 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yao Xingtao <yaoxt.fnst@fujitsu.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, jim.harris@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v8 3/3] cxl_test: fix the 'create region failed' error
Message-ID: <ZmvNvqerpvI7IXPb@aschofie-mobl2>
References: <20240614032133.45365-1-yaoxt.fnst@fujitsu.com>
 <20240614032133.45365-4-yaoxt.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240614032133.45365-4-yaoxt.fnst@fujitsu.com>

On Thu, Jun 13, 2024 at 11:21:33PM -0400, Yao Xingtao wrote:
> Since the interleave capability check is supported, the cxl_test will
> fail.
> Support any and all possibilities for the mock cxl device (host bridge,
> switch, cxl_mem .etc).

This needs to be folded into Patch 1. 

FYI - sometimes when we add a new feature the cxl-test mock support is
added as a separate patch. In this case, we're just preserving existing
functionality of cxl-test. Prefer not to break it in Patch 1 and then
fix it in a subsequent patch. 

-- Alison

> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Alison Schofield <alison.schofield@intel.com>
> Signed-off-by: Yao Xingtao <yaoxt.fnst@fujitsu.com>
> ---
>  tools/testing/cxl/test/cxl.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 61c69297e797..fbebcda4364c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -630,11 +630,15 @@ static struct cxl_hdm *mock_cxl_setup_hdm(struct cxl_port *port,
>  					  struct cxl_endpoint_dvsec_info *info)
>  {
>  	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
> +	struct device *dev = &port->dev;
>  
>  	if (!cxlhdm)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> +	cxlhdm->interleave_mask = ~0U;
> +	cxlhdm->iw_cap_mask = ~0UL;
> +	dev_set_drvdata(dev, cxlhdm);
>  	return cxlhdm;
>  }
>  
> -- 
> 2.37.3
> 
> 
