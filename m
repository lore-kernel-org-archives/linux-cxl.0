Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80EE1B21B8;
	Mon, 17 Mar 2025 17:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742234369; cv=none; b=bajxZMXofnik+klinGa4EWLm5ENvi2a4/OPzZT/A5oMxmegyQePlXgfE+YALDjoVYdTnSNnlhU+ZZCQ6d64wy129c4m3Ow782zeseMnhybuXx/+9m2ZGNRwtRWaNVVrjOlw6TjfEHfHY2NTcfhiUaxDE0MxI1XcynFt1IChQtGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742234369; c=relaxed/simple;
	bh=kzN3DDqc8hAjqb/rDQcWukQAiIn4lKxU/b/iu1LB/Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m73vjNkaRYsa1vd6eLh7GssrbYyFijcaKllHiuW7Agz43dlDV2/h1qxMa3VWfIxSE5vB2YMJwpguR66f+9UOSe5N3xt4G756tKwPsXC3T6KDC3iWXPtG2/v45MsZi9IRM8VTaOWcPYMUylVnORX3ngU2ibkIeOeXqRKzvNUjIr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PXUqe1Er; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PXUqe1Er"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742234368; x=1773770368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kzN3DDqc8hAjqb/rDQcWukQAiIn4lKxU/b/iu1LB/Xw=;
  b=PXUqe1ErVH6i9Bxu/K4B7k97hWyH3IFkgL/5X8CFFPhgmpR+TQ4XwCxn
   zstCC87NBPgBYsIQcTGeQmyYj/QT1b+QegdHyeYnbZPTdpYTMU2v30DKL
   ohUjfMSuR8RVImHjldCDMwODes/egDvNrGjqdnwV6YgkfzaTMvtoztE6c
   fAOSWWNnEUR6hFGpLA1Sc+rpW9A7/k7o/jrjjcC097mBqFknR8SpXOAGb
   2efL9XUYTT64TQHpJvmTEp6w8RimCpnihRMwkjsBCvi8I/01vkRJO2Ln6
   SpnyJ5bc6FccTGve0f86Sir1g0PMM3bBlmI197/v63ZajJMjTDqwjUzat
   w==;
X-CSE-ConnectionGUID: fFI0nDcbQv6G1w/rItEcRg==
X-CSE-MsgGUID: e0fZicAbSo6oqdShtyO55g==
X-IronPort-AV: E=McAfee;i="6700,10204,11376"; a="53969539"
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="53969539"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 10:59:27 -0700
X-CSE-ConnectionGUID: V2iqJnXATROcths5wXtyqQ==
X-CSE-MsgGUID: c7H+1jwFRse9NFLq+0u/eA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,254,1736841600"; 
   d="scan'208";a="127031858"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.109.118])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2025 10:59:26 -0700
Date: Mon, 17 Mar 2025 10:59:24 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] cxl/region: Fix the first aliased address
 miscalculation
Message-ID: <Z9hi_OBA4P_111oc@aschofie-mobl2.lan>
References: <20250317070124.815028-1-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250317070124.815028-1-ming.li@zohomail.com>

On Mon, Mar 17, 2025 at 03:01:24PM +0800, Li Ming wrote:
> In extended linear cache(ELC) case, cxl_port_get_spa_cache_alias() helps
> to get the aliased address of a SPA, it considers the first address in
> CXL memory range is "region start + region cache size + 1", but it
> should be "region start + region cache size".
> 
> So if a SPA is equal to "region start + region cache size", its aliased
> address should be "SPA - region cache size".

Nice catch Ming!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 6d8bdb53f258..c3f4dc244df7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3460,7 +3460,7 @@ u64 cxl_port_get_spa_cache_alias(struct cxl_port *endpoint, u64 spa)
>  			if (!p->cache_size)
>  				return ~0ULL;
>  
> -			if (spa > p->res->start + p->cache_size)
> +			if (spa >= p->res->start + p->cache_size)
>  				return spa - p->cache_size;
>  
>  			return spa + p->cache_size;
> -- 
> 2.34.1
> 
