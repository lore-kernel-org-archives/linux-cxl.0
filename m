Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452C129D19;
	Mon, 17 Jun 2024 02:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718590322; cv=none; b=X/awC+Y2IDBW9TpMwx2ICqS/eywVPKAsr10cUCuJktzUBAPn36JKzC3F83vZNvvd1QrycDU2YchozjEix8MhPaU7woqXo7eaeh+6/QQGQvmShu54PzrYcwfsQFHu6TMBZNSF1J2oF3hcgYEK/Uapj07edtKpy4SDL+bz8qSRWLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718590322; c=relaxed/simple;
	bh=itwsVa10Pb4Iql/zli9eOmB+/Xbz4VCqkvBFU09kQo8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MMrTwlhSHn2pCgq6NnHEQLlKCiwWQoHZn3FSP0V6mvtBULdtPjmHneF1NoeJwGKbRAnsF1R5r7yzzpKqUI7Xdfkbnqsl3uokxxMmYH5H/nWcuWAMjQe2Z+wAcesrqpmwKzi5rP9RB8QmycefAZyvSrHR/82R5gS+DAyGQz8L7wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hqc1uP7r; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hqc1uP7r"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718590320; x=1750126320;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=itwsVa10Pb4Iql/zli9eOmB+/Xbz4VCqkvBFU09kQo8=;
  b=hqc1uP7r2qzD0rySLPNZzikTqZzk7elksR411udrfhqPRv/9nVrfKol8
   4Px62JLVCxFgyaN+IyJqSgXY3s55/0kh7+huNCixtSv2hAN3WRIX2RNPd
   TbHot0gff9qDLyb4768b/X/B0xo1z3cK09F8kD2i+UpX0iq47NnR7WyZT
   vz35xx64iNUuCUmVUxuinAbJBqYiDAC5AwhfyZ/sLK82VGFfBIFZcEbXL
   2OhWnNk/YFT7Fxg7snoibvdEyR9xrdpBgCzJZjpLmYOotcyY1wWSATNgp
   cPOk/yM3zlAn6jAGUgdUwuTBWUIj5V3NmgVPEkuAA5tsSAGOm7MvWTkmF
   w==;
X-CSE-ConnectionGUID: AxMJ1nybSS6ZRe92CoN0pw==
X-CSE-MsgGUID: 1cE1bNYZRmu/9WnZBB3iLw==
X-IronPort-AV: E=McAfee;i="6700,10204,11105"; a="26038109"
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="26038109"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 19:11:59 -0700
X-CSE-ConnectionGUID: 999u2h2dQjiv9bTlFQfcKg==
X-CSE-MsgGUID: y1E7LXt1SeKrOE9Ku0BjnA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,244,1712646000"; 
   d="scan'208";a="45499818"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2024 19:11:56 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Alison Schofield <alison.schofield@intel.com>,  Dave Jiang
 <dave.jiang@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Bharata B Rao <bharata@amd.com>,  Alistair
 Popple <apopple@nvidia.com>,  "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier
 abstract distance
In-Reply-To: <ZmjBfcaosIlOODFR@aschofie-mobl2> (Alison Schofield's message of
	"Tue, 11 Jun 2024 14:28:29 -0700")
References: <20240611055423.470574-1-ying.huang@intel.com>
	<ZmjBfcaosIlOODFR@aschofie-mobl2>
Date: Mon, 17 Jun 2024 10:10:05 +0800
Message-ID: <87v8285ngi.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Alison Schofield <alison.schofield@intel.com> writes:

> On Tue, Jun 11, 2024 at 01:54:23PM +0800, Ying Huang wrote:

[snip]

>> ---
>>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>>  drivers/cxl/cxl.h         |  2 ++
>>  2 files changed, 38 insertions(+), 4 deletions(-)
>> 
>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>> index 3c2b6144be23..81d0910c0a02 100644
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -9,6 +9,7 @@
>>  #include <linux/uuid.h>
>>  #include <linux/sort.h>
>>  #include <linux/idr.h>
>> +#include <linux/memory-tiers.h>
>>  #include <cxlmem.h>
>>  #include <cxl.h>
>>  #include "core.h"
>> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>  	return true;
>>  }
>>  
>> +static int cxl_region_nid(struct cxl_region *cxlr)
>> +{
>> +	struct cxl_region_params *p = &cxlr->params;
>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>> +	struct cxl_decoder *cxld = &cxled->cxld;
>> +
>> +	return phys_to_target_node(cxld->hpa_range.start);
>> +}
>> +
>
> I believe it's OK to send a resource_size_t to phys_to_target_node()
> like this:
>
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2308,10 +2308,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>  static int cxl_region_nid(struct cxl_region *cxlr)
>  {
>         struct cxl_region_params *p = &cxlr->params;
> -       struct cxl_endpoint_decoder *cxled = p->targets[0];
> -       struct cxl_decoder *cxld = &cxled->cxld;
>
> -       return phys_to_target_node(cxld->hpa_range.start);
> +       return phys_to_target_node(p->res->start);
>  }
>

Read the related code again, it appears that there's a theoretical race
condition here.  The register_memory_notifier() is called in
devm_cxl_add_region(), where p->targets[] and p->res haven't been
setupped yet.  And, IIUC, p->targets[] or p->res may be gone during the
life cycle of regions too.  If so, we need to use
guard(rwsem_read)(&cxl_region_rwsem) to protect p->targets[] and p->res
references.  Because the memory notifier may be called for other nodes
online/offline.

--
Best Regards,
Huang, Ying
