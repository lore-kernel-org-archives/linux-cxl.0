Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8572F5331
	for <linux-cxl@vger.kernel.org>; Fri,  6 Feb 2026 19:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406416; cv=none; b=otjS9eDzR/gk1ume811Qmrje+ptumdjzf/qn7ApfrHxOwMIAsiHqvhWr3Jkp0eUWv8NpSATFq6QL6fcefvkjsRfgiiJjzDtnzQNhuoPYEElaPyMB8aWT7RlhNNCIyD6lGkvhjR10DWvnn4ewDhsLRElu8EBCDquQ1OewASJ8EF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406416; c=relaxed/simple;
	bh=bcS/pkV3VWpCM9KIsWqniVlOLZbIX7P+NAPZRPjRXKQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jx7VxRTWaJ6qBNsjzt3GIJBYDeFXI2tL6rIXqZI5IkbiA8Efnp4qWwCgEuWBcp2i4fPX5/5c2yyhvj6Qz2L2bfT6zXnH7vY2LAFgu0MqI8PHSqoAr3WO2qYJbr9foD/fYVQG8RCxcCfmdMCLYFPTqYLelNKvRkSjo+epjXQ0sIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j2w0yq+p; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j2w0yq+p"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770406417; x=1801942417;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=bcS/pkV3VWpCM9KIsWqniVlOLZbIX7P+NAPZRPjRXKQ=;
  b=j2w0yq+pQeMVuj4Wj5a0CapydPumMKj+krC84sj9RlrpCh/y5/guSZcP
   XycaOCirzDthV6zKa6JdtKTDwVmBQfxVrRAWwKra5mLxH2XjGNw1UDE8E
   fYBTHFUyozuZPW+BK7wN5OC1bZ6TqQ6cSHCRFMQbi6NTLB9jZ5oQIbWOS
   G1//jg66gAydVzWPupc18/t736wBjPRWMtg+4/l0zH8ICv+Y4J1msDfi+
   ZbSAIVgipjM253hpgqZBmvxNEFCATRmHP60IYq7BQm6UOt6rPyf1YEO+4
   bcf/WOL3DC/CuI+YHFGyrPioBELRNfxB7gHJt8W1t+h1s6S780jnCokH7
   g==;
X-CSE-ConnectionGUID: jLMSlFsSRVeWM8P6iHWPDA==
X-CSE-MsgGUID: dvHXxeH4Tn68HASXmfUVsQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11693"; a="70634362"
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="70634362"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 11:33:36 -0800
X-CSE-ConnectionGUID: uQ8eDC5eRBWIDOwsY8OM0Q==
X-CSE-MsgGUID: 1/y7rntKQtm6b47yx/xTPw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,277,1763452800"; 
   d="scan'208";a="210048667"
Received: from ssimmeri-mobl2.amr.corp.intel.com (HELO [10.125.111.145]) ([10.125.111.145])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2026 11:33:36 -0800
Message-ID: <af94b779-4feb-46d3-9ea4-e14a1308d0da@intel.com>
Date: Fri, 6 Feb 2026 12:33:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Test decoder flags as bitmasks
To: Alison Schofield <alison.schofield@intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org
References: <20260206181404.1025991-1-alison.schofield@intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260206181404.1025991-1-alison.schofield@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/6/26 11:14 AM, Alison Schofield wrote:
> The CXL decoder flags are defined as bitmasks, not bit indices.
> Using test_bit() to check them interprets the mask value as a bit
> index, which is the wrong test.
> 
> For CXL_DECODER_F_NORMALIZED_ADDRESSING the test reads beyond the
> flags word, making the flag sometimes appear set and blocking creation
> of CXL region debugfs attributes that support poison operations.
> 
> For CXL_DECODER_F_LOCK the test reads beyond the defined bits, causing
> the test to always return false and allowing resets that should have
> been blocked.
> 
> Replace test_bit() with a bitmask check.
> 
> Found with cxl-test.
> 
> Fixes: 208f432406b7 ("cxl: Disable HPA/SPA translation handlers for Normalized Addressing")
> Fixes: 2230c4bdc412 ("cxl: Add handling of locked CXL decoder")

Given it needs to back port and fix 2 different commits, maybe this needs to split?

> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> ---
> 
> Obsoletes prior patch that only fixed up one test:
> cxl/region: Test CXL_DECODER_F_NORMALIZED_ADDRESSING as a bitmask
> https://lore.kernel.org/linux-cxl/20260206013135.1012375-1-alison.schofield@intel.com/
> 
> 
>  drivers/cxl/core/hdm.c    | 2 +-
>  drivers/cxl/core/region.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index e3f0c39e6812..c222e98ae736 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -904,7 +904,7 @@ static void cxl_decoder_reset(struct cxl_decoder *cxld)
>  	if ((cxld->flags & CXL_DECODER_F_ENABLE) == 0)
>  		return;
>  
> -	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_LOCK)
>  		return;
>  
>  	if (port->commit_end == id)
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 08fa3deef70a..befa2a7b81c2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1100,12 +1100,12 @@ static int cxl_rr_assign_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  static void cxl_region_setup_flags(struct cxl_region *cxlr,
>  				   struct cxl_decoder *cxld)
>  {
> -	if (test_bit(CXL_DECODER_F_LOCK, &cxld->flags)) {
> +	if (cxld->flags & CXL_DECODER_F_LOCK) {
>  		set_bit(CXL_REGION_F_LOCK, &cxlr->flags);
>  		clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  	}
>  
> -	if (test_bit(CXL_DECODER_F_NORMALIZED_ADDRESSING, &cxld->flags))
> +	if (cxld->flags & CXL_DECODER_F_NORMALIZED_ADDRESSING)
>  		set_bit(CXL_REGION_F_NORMALIZED_ADDRESSING, &cxlr->flags);
>  }
>  
> 
> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921

