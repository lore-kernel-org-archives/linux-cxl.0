Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794F842065;
	Mon, 13 Jan 2025 17:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736790532; cv=none; b=eUO1B7oZr1/dS4NUORc1I2SaSTtgjAPgjesKyCGNq0SWJblnTk6JNxK9B4zyDq1tbexfAdlTpzpeynujiD7Wi0S/6LWXU9G0rEw+42CGRZgqp0Z7USs7Y01zO61TiJsB7L30WKxpEmsO2GPG4B5J6koXLUzeB7NojOK5SkK6p5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736790532; c=relaxed/simple;
	bh=6gH+bK/GKZBdnBc/yhP8Eg8qMnBd7JSVZZJz8u25QqA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o5mu0uAwnQBbtY9PdgFtKlzxXlb+ISPFt0fp00oWXbHmoMgYbkkRFGb+sxr8zBlkJiKGdIT4Q+6OaebLWlURIL7tju3Zfx7Vb/sLvfEY51iS16LrWmHyg6Dd1QpclVr1Mi5w/zE6fk4LhFLiJA9MqLam9Vb1ZFxA0D9h9q837Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QeSi1mma; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QeSi1mma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736790531; x=1768326531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gH+bK/GKZBdnBc/yhP8Eg8qMnBd7JSVZZJz8u25QqA=;
  b=QeSi1mmaXxXpl3NyZIDTuTDEVd4RMOLVjtGeQVMG82KvBYqn9q831jt8
   itvhzaLNxTYwfGGwOFqaOyGShtYf0WukevH0whMLgA8wjszQro6nuqPQS
   Nt3L9wZA9VuLG0S0andKL1RzCIl27QCgzAhkJwEKwUcJ5txbhylZZtZbD
   ekhJDze9XFIgrspCkEcKvBkFjOK5Zac9BXY4pPk3P4nxuGYcb1pOQ9TYf
   kLTAV5JpEI55ND0H0PzjAxJrzZEykRgcaMEQJ5RQGjGW07ebGowp5mLud
   gBLSjsrtPStmKB+VsGtNA0mX2CSKkghmexuQdG8AkrDQECO54pVHATIeL
   A==;
X-CSE-ConnectionGUID: 8MePL9EoQJqo4O/n3x4ygQ==
X-CSE-MsgGUID: h2wdOHU8SoCv9cU2QSjPUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="47641303"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="47641303"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:48:50 -0800
X-CSE-ConnectionGUID: McA/JQf+RNKV0C0C+r1pNA==
X-CSE-MsgGUID: NO49GSj5R/mCr13Eq0E5UQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="109683146"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.108.60])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2025 09:48:49 -0800
Date: Mon, 13 Jan 2025 09:48:47 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Robert Richter <rrichter@amd.com>
Cc: Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, Gregory Price <gourry@gourry.net>,
	"Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
	Terry Bowman <terry.bowman@amd.com>
Subject: Re: [PATCH v1 23/29] cxl/region: Use root decoders interleaving
 parameters to create a region
Message-ID: <Z4VR_8Z1Qx4E8VSS@aschofie-mobl2.lan>
References: <20250107141015.3367194-1-rrichter@amd.com>
 <20250107141015.3367194-24-rrichter@amd.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250107141015.3367194-24-rrichter@amd.com>

On Tue, Jan 07, 2025 at 03:10:09PM +0100, Robert Richter wrote:
> Endpoints requiring address translation might not be aware of the
> system's interleaving configuration. Instead, interleaving can be
> configured on an upper memory domain (from an endpoint view) and thus
> is not visible to the endpoint. For region creation this might cause
> an invalid interleaving config that does not match the CFMWS entries.
> 
> Use the interleaving configuration of the root decoders to create a
> region which bases on CFMWS entries. This always matches the system's
> interleaving configuration and is independent of the underlying memory
> topology.

This sounds like a restriction, more restrictive than present.

Won't it block all region interleave ways greater than root decoder
interleave ways? ie. disallows 2, 2+2, 2+2+2, 4, etc.


> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> ---
>  drivers/cxl/core/region.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e218f0be2409..c3322bae05b9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3477,8 +3477,8 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	}
>  
>  	p->res = res;
> -	p->interleave_ways = cxled->cxld.interleave_ways;
> -	p->interleave_granularity = cxled->cxld.interleave_granularity;
> +	p->interleave_ways = cxlrd->cxlsd.cxld.interleave_ways;
> +	p->interleave_granularity = cxlrd->cxlsd.cxld.interleave_granularity;
>  	p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> -- 
> 2.39.5
> 
