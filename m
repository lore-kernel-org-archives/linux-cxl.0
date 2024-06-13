Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D164811;
	Thu, 13 Jun 2024 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718239320; cv=none; b=DgMf6Ws4e92QvuzaFSPqaYQtrpfGZUWusz4q9qDZl5AJiabavinlGDGe5xjkATmsogBYjVb55/x1Zd3hdfv3hxgOUTomWvD3oQgPLLb9pWTFMAmDDvPXmh1h+aipEC4YEwDx1zl7m7NgjP6Zh579lF69qNcAL2RvXHD98BBak1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718239320; c=relaxed/simple;
	bh=VuVVGamM9xYmkROyduLx/PBHwQBhtgnEoNQrgKFoeYY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=nQFOHlzHxCiP7n7sxerSaiSQgQjszKJ/snNQM1kgXX6E2kyATLtqkhK+S4VDcS0hFeBsIHpnt287vvOqtKEfregCy/CfRMdMaYXjespPfrBN/yVIkzweqX2lS8KAxgca0/McSBPwFZD2w+l0hhPF3pBqQXFAPrGGe/xDdZ20DDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G7PqMDXy; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G7PqMDXy"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718239319; x=1749775319;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=VuVVGamM9xYmkROyduLx/PBHwQBhtgnEoNQrgKFoeYY=;
  b=G7PqMDXyfvQqjwncNOTtxz7g9RMy/iq3Uq9ZYgHJIqYJ2MpOXkfpN4zs
   ntX8oQFIfXk4FMMH0RbCsNgB3nre8LMCZ8c10QYxAoIUPxtRm0WO/hmoc
   AclyUU7YM3WjyYATG2oylJ0Ek17cC0OZJVf8l+BSvjWKCxZh/a2R17O5f
   ruM55z9G5XiuJWzJ+S+9ySBKURJlHqiDIvutgj7TNQsgyKaXp8+iCeUHX
   Mm2Ge3vRynEvyoDyUFyNMtqY1mP7OFBDmT4c7r/5kVWgkq5ygZh31GRwH
   ZrKSe3W2hl2a3OEt62ILpKZ/c4xg1K5H4hN7XDlKc6A1CRMNATnpWsBLy
   w==;
X-CSE-ConnectionGUID: 0XP2AmY+RsCG3zVLfWfWVQ==
X-CSE-MsgGUID: FaY6gc8xQW+dXTDgy4RJBA==
X-IronPort-AV: E=McAfee;i="6700,10204,11101"; a="18889055"
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="18889055"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 17:41:58 -0700
X-CSE-ConnectionGUID: x9YBITAETDKsiL1EKQAmMA==
X-CSE-MsgGUID: WHQ7xxEqR/+mf9K2RSm1og==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,234,1712646000"; 
   d="scan'208";a="40060628"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2024 17:41:55 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Dave Jiang <dave.jiang@intel.com>,
  Bharata B Rao <bharata@amd.com>,  Alistair Popple <apopple@nvidia.com>,
  "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier
 abstract distance
In-Reply-To: <Zmnc/bIkAQp6dpxQ@aschofie-mobl2> (Alison Schofield's message of
	"Wed, 12 Jun 2024 10:38:05 -0700")
References: <20240611055423.470574-1-ying.huang@intel.com>
	<ZmjBfcaosIlOODFR@aschofie-mobl2>
	<87sexi7vzp.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<Zmnc/bIkAQp6dpxQ@aschofie-mobl2>
Date: Thu, 13 Jun 2024 08:40:04 +0800
Message-ID: <87ikyd7k0r.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alison Schofield <alison.schofield@intel.com> writes:

> On Wed, Jun 12, 2024 at 10:09:14AM +0800, Ying Huang wrote:
>
> snip
>
>> >> ---
>> >>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>> >>  drivers/cxl/cxl.h         |  2 ++
>> >>  2 files changed, 38 insertions(+), 4 deletions(-)
>> >> 
>> >> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> >> index 3c2b6144be23..81d0910c0a02 100644
>> >> --- a/drivers/cxl/core/region.c
>> >> +++ b/drivers/cxl/core/region.c
>> >> @@ -9,6 +9,7 @@
>> >>  #include <linux/uuid.h>
>> >>  #include <linux/sort.h>
>> >>  #include <linux/idr.h>
>> >> +#include <linux/memory-tiers.h>
>> >>  #include <cxlmem.h>
>> >>  #include <cxl.h>
>> >>  #include "core.h"
>> >> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>> >>  	return true;
>> >>  }
>> >>  
>> >> +static int cxl_region_nid(struct cxl_region *cxlr)
>> >> +{
>> >> +	struct cxl_region_params *p = &cxlr->params;
>> >> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>> >> +	struct cxl_decoder *cxld = &cxled->cxld;
>> >> +
>> >> +	return phys_to_target_node(cxld->hpa_range.start);
>> >> +}
>> >> +
>> >
>> > I believe it's OK to send a resource_size_t to phys_to_target_node()
>> > like this:
>> >
>> > --- a/drivers/cxl/core/region.c
>> > +++ b/drivers/cxl/core/region.c
>> > @@ -2308,10 +2308,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>> >  static int cxl_region_nid(struct cxl_region *cxlr)
>> >  {
>> >         struct cxl_region_params *p = &cxlr->params;
>> > -       struct cxl_endpoint_decoder *cxled = p->targets[0];
>> > -       struct cxl_decoder *cxld = &cxled->cxld;
>> >
>> > -       return phys_to_target_node(cxld->hpa_range.start);
>> > +       return phys_to_target_node(p->res->start);
>> >  }
>> >
>> 
>> I believe this works.  But the original implementation is just a
>> mechanical code movement from cxl_region_perf_attrs_callback().  So, I
>> prefer to keep it stupid. Then, further optimization can be done on top
>> of it.  Is it good for you?
>
> I prefer to do it now while we are thinking about it.
>
> How about a precursor patch:
> Patch 1/2: cxl/region: Add a region to node id helper
>
> --and then in that commit log you can say it's a simplified lookup 
> and is being done in preparation for adding another caller.

This works.  Will do it.

--
Best Regards,
Huang, Ying
