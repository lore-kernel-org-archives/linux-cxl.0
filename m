Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612551BA860
	for <linux-cxl@vger.kernel.org>; Thu, 29 Aug 2024 21:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724968177; cv=none; b=B0GwZ34+c+rCA2mC3N/uIdPdmFW9g87BI1QCwvm9XA2BR2EK2fLvcgIkv5KMah97+rzx5hKXRsDRJXYrhgwsOlu2ECFmpM1Du5ddioC/lZ0G9C9JQaK5TT6iixYVaBvB9kNYMJ49wUeCsFahq535qzAJhBw9b9PugtUDgt1DzRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724968177; c=relaxed/simple;
	bh=hAZ5ClpNZ7lm2n6q8HDACc6D5d+dQIL0T4oSsqCT0M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WX3e8DTpasAIH0ZDwC//yGdBYhKCeqUp7/eQgPh9kVdMechZpguLWJMW9A6HyFZEG8jati5HToDtbN0YASbc5k3B6HSVNAsRzazLKFByWXaopOizQ3JfyxiRlawzf9nDM38jbcNs1LN2MlJGj7Ou50jPkRPcC9HoHUwx1WcUZRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KshwMJP2; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KshwMJP2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724968175; x=1756504175;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hAZ5ClpNZ7lm2n6q8HDACc6D5d+dQIL0T4oSsqCT0M4=;
  b=KshwMJP22AH2SsHvrGvt/ABUyk63/uBAjXfCC+gzYoZdCTxlFk1JYFAQ
   15CTb/b9y6W4EKMYN1J3oFmfCmdG285pbc36oGRVvKwnMO6Ztv1UHIbiy
   9E51iTEb5+hxY/7zKQw83VPV5q8MPQcZmrbpu35j++1ddQIbJhbAPazd2
   2ZSCbQyhCzCItVlwkEM0KH2jRGEQ8bYfdTRn9lx1gnB3esq88wn/OYhz6
   EUL4NpftO+h2D+ZcpBLkKbyet2zELD75D9CPidh1gmA9FOBx6GWAruwc/
   YEa7WtePGxBPqo7xocxY3w5RXghyx9L7kUGdglpqPHd2bqc8lGf9kbOo6
   g==;
X-CSE-ConnectionGUID: hBKegny+S5WI+Nncby91HA==
X-CSE-MsgGUID: gybf5+a9S3mteX/cDB3NUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11179"; a="34757254"
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="34757254"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:49:34 -0700
X-CSE-ConnectionGUID: paGzJcJkRi2z7ybJ40bDoA==
X-CSE-MsgGUID: gnUR9YadSeGt/4PffGfOEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,186,1719903600"; 
   d="scan'208";a="64447746"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.111.219])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2024 14:49:35 -0700
Date: Thu, 29 Aug 2024 14:49:32 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Yanfei Xu <yanfei.xu@intel.com>
Cc: linux-cxl@vger.kernel.org, dave@stgolabs.net,
	jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, ming4.li@intel.com
Subject: Re: [v4 1/4] cxl/pci: Fix to record only non-zero ranges
Message-ID: <ZtDs7NYujciohX-_@aschofie-mobl2.lan>
References: <20240828084231.1378789-1-yanfei.xu@intel.com>
 <20240828084231.1378789-2-yanfei.xu@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240828084231.1378789-2-yanfei.xu@intel.com>

On Wed, Aug 28, 2024 at 04:42:28PM +0800, Yanfei Xu wrote:
> The function cxl_dvsec_rr_decode() retrieves and records DVSEC ranges
> into info->dvsec_range[], regardless of whether it is non-zero range,
> and the variable info->ranges indicates the number of non-zero ranges.
> However, in cxl_hdm_decode_init(), the validation for
> info->dvsec_range[] occurs in a for loop that iterates based on
> info->ranges. It may result in zero range to be validated but non-zero
> range not be validated, in turn, the number of allowed ranges is to be
> 0. Address it by only record non-zero ranges.
> 
> This fix is not urgent as it requires a configuration that zeroes out
> the first dvsec range while populating the second. This has not been
> observed, but it is theoretically possible. If this gets picked up for
> -stable, no harm done, but there is no urgency to backport.
> 

I'd prefer the commit msg be:
	cxl/pci: Record only non-zero DVSEC ranges

but either way -
Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> Fixes: 560f78559006 ("cxl/pci: Retrieve CXL DVSEC memory info")
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Yanfei Xu <yanfei.xu@intel.com>
> ---
>  drivers/cxl/core/pci.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)

snip

