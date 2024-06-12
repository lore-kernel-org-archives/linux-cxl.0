Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07043770D;
	Wed, 12 Jun 2024 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718213890; cv=none; b=ua5ukLHG7qWla1CX0LP53dF0CAHpw0kGZgeBzn2BljAjdkWmldD+Rm0+E51AZKmg4xbnxu17Q3yfeqy06ZynVJNEVvrxpt0Zi6KChe8+pGvESPcfAQOQPLUu5HME3k5ndc00T5uHDm4LjeMym0dnXFZ7tFnBtlR6U3mYHnh4nbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718213890; c=relaxed/simple;
	bh=w+ngwamm0ApqPGga3qi/YIQkOfcw86BRXlkHoeHqNZg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hdvpoHnMPFnfJZ2OxrBSaPcbgHvMafzUw8Ghd2cQXgY3WuxVi67mq208xdQwvCU8DrpR/DFnT31g30vlEDWKYCc2BE2cXNcXd46Xfh04XkEUyi9HbuWLCK69vX5bEt31CnvcsQQ3HO5TbCizcAul8gyPqH+3fMtnTQI1pb1fDfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OEb+0hmM; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OEb+0hmM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718213889; x=1749749889;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=w+ngwamm0ApqPGga3qi/YIQkOfcw86BRXlkHoeHqNZg=;
  b=OEb+0hmMdsWqvDkrE68PyupusIT/txz1uR8ayzEuSFsMFGuOc3tXwEC4
   DtqeKoTPaMdg7c0yu1NESKemNg4ZnrxckhU2Zi7mmynAplO96vqMX9vpO
   Udm8CUHOgoBNzWihQK+uUD4i68UMyd67z48Q/77m+t5IqMFu3omR7kRE+
   ltw2ZtyEEwARmphzDt7KGgyxKPsWEPSqxNqQ/UE+wD3TD1joHW246Exp5
   Gz+5JRDqv+jf5ltSzO//7ACZ00DRZBOU6raQBXdXjKoGSGOx5b9IBSUOQ
   fsiw8ZytAI4tIZ5Pn4Rpg/Jzq8tnxDS4J2eUSxqHy82rYRgRW7ZNbwvFe
   g==;
X-CSE-ConnectionGUID: Arw4yAG2R7iCtt0qugcOsA==
X-CSE-MsgGUID: TLYkkSQ3QPye6L7EmTNtug==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="15119684"
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="15119684"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:38:08 -0700
X-CSE-ConnectionGUID: Fzt9ZDUDRbuHE4/p+0mYzA==
X-CSE-MsgGUID: U/zYKYu1QQ6imkplDYnjyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,233,1712646000"; 
   d="scan'208";a="63052523"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.178])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 10:38:07 -0700
Date: Wed, 12 Jun 2024 10:38:05 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>, Bharata B Rao <bharata@amd.com>,
	Alistair Popple <apopple@nvidia.com>,
	"Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier
 abstract distance
Message-ID: <Zmnc/bIkAQp6dpxQ@aschofie-mobl2>
References: <20240611055423.470574-1-ying.huang@intel.com>
 <ZmjBfcaosIlOODFR@aschofie-mobl2>
 <87sexi7vzp.fsf@yhuang6-desk2.ccr.corp.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sexi7vzp.fsf@yhuang6-desk2.ccr.corp.intel.com>

On Wed, Jun 12, 2024 at 10:09:14AM +0800, Ying Huang wrote:

snip

> >> ---
> >>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
> >>  drivers/cxl/cxl.h         |  2 ++
> >>  2 files changed, 38 insertions(+), 4 deletions(-)
> >> 
> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> >> index 3c2b6144be23..81d0910c0a02 100644
> >> --- a/drivers/cxl/core/region.c
> >> +++ b/drivers/cxl/core/region.c
> >> @@ -9,6 +9,7 @@
> >>  #include <linux/uuid.h>
> >>  #include <linux/sort.h>
> >>  #include <linux/idr.h>
> >> +#include <linux/memory-tiers.h>
> >>  #include <cxlmem.h>
> >>  #include <cxl.h>
> >>  #include "core.h"
> >> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
> >>  	return true;
> >>  }
> >>  
> >> +static int cxl_region_nid(struct cxl_region *cxlr)
> >> +{
> >> +	struct cxl_region_params *p = &cxlr->params;
> >> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
> >> +	struct cxl_decoder *cxld = &cxled->cxld;
> >> +
> >> +	return phys_to_target_node(cxld->hpa_range.start);
> >> +}
> >> +
> >
> > I believe it's OK to send a resource_size_t to phys_to_target_node()
> > like this:
> >
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -2308,10 +2308,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
> >  static int cxl_region_nid(struct cxl_region *cxlr)
> >  {
> >         struct cxl_region_params *p = &cxlr->params;
> > -       struct cxl_endpoint_decoder *cxled = p->targets[0];
> > -       struct cxl_decoder *cxld = &cxled->cxld;
> >
> > -       return phys_to_target_node(cxld->hpa_range.start);
> > +       return phys_to_target_node(p->res->start);
> >  }
> >
> 
> I believe this works.  But the original implementation is just a
> mechanical code movement from cxl_region_perf_attrs_callback().  So, I
> prefer to keep it stupid. Then, further optimization can be done on top
> of it.  Is it good for you?

I prefer to do it now while we are thinking about it.

How about a precursor patch:
Patch 1/2: cxl/region: Add a region to node id helper

--and then in that commit log you can say it's a simplified lookup 
and is being done in preparation for adding another caller.

-- Alison

> 
snip
> >
