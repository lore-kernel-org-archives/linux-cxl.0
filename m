Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170D417F3;
	Tue, 18 Jun 2024 00:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718670648; cv=none; b=lwXiBixrphuGa78Jkwcmbqfg5X5vfPdv2jsVlJJe8GIeyyzPAKoL/ohaOZ3H7p2HGXWqE3uQo1+UhrwnkNbHYKc6jQIFwL526Fu2GehY/WMx/ymFR18VTljrelo2X40kHCwKp4I0aFdt36Q6Bq6WMp0x1LDycwbsg8n6J8FenMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718670648; c=relaxed/simple;
	bh=FdpTsig6BTVDhc8/bI5WIzYpdqvQKtYmhHMwuOn+XOA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=gbLGG2IrB7sGALasyDMvObe232WJY/pn68qFtIGlcfQI8Ay50yeBrB5YaL2QpJfi+Oojk0ZE83ObQjELg/PhuBvOVJN8BvJO6njTzEEf+aR9+o1Ilz7gDlYw6DDfyoWRQGpTUnRHMYSEhAaJ+emiz3PqMZNx5I7psyhkj7C6PYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j5YGDA52; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j5YGDA52"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718670646; x=1750206646;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=FdpTsig6BTVDhc8/bI5WIzYpdqvQKtYmhHMwuOn+XOA=;
  b=j5YGDA52OKkN/E57cSwrCxM5t+/nMJRaPk0OK5G3MJXbn7jH0Q4ettxX
   rOtZqmpP3+3r35NPeVmZatI2C5WrSarcp3+z5X8XE+GtgxtuI0UHjzk/G
   jmkTUVxmZQjDhcvX+YR2SLWNL4c7JnF1OtQcvi/GBXROeb2Mvt3ZMBwoF
   5JLK58vQBFiqmuMlXWJ+ffCt24GuJfZ+d96i8bmUOVMBtz/KXE0gBBRCK
   MuBaBvG2xfsa5k7zHx6TOxlKaQiHyFZfkcA5u8sjXZ8mKsUBTJg5h3JzL
   80B/3qgXBs2FsrF/pB8cB1phndlyPRQVAcalSFdibvGfDtgCkAoKeXDbp
   w==;
X-CSE-ConnectionGUID: Z+SN1S0IRAmX7/aE6o9TgQ==
X-CSE-MsgGUID: zmoRC7MPR+qSdWcP0vpOMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="15355287"
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="15355287"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 17:30:45 -0700
X-CSE-ConnectionGUID: UWPGeQu8R7K2xpNk9YR0ag==
X-CSE-MsgGUID: iuj5Zq6TS8CtOuobGcmJEw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,246,1712646000"; 
   d="scan'208";a="78826441"
Received: from unknown (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 17:30:43 -0700
From: "Huang, Ying" <ying.huang@intel.com>
To: Dave Jiang <dave.jiang@intel.com>
Cc: Alison Schofield <alison.schofield@intel.com>,  Dan Williams
 <dan.j.williams@intel.com>,  <linux-cxl@vger.kernel.org>,
  <linux-kernel@vger.kernel.org>,  Andrew Morton
 <akpm@linux-foundation.org>,  Jonathan Cameron
 <Jonathan.Cameron@huawei.com>,  Bharata B Rao <bharata@amd.com>,  Alistair
 Popple <apopple@nvidia.com>,  "Aneesh Kumar K . V"
 <aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier
 abstract distance
In-Reply-To: <b1652fc6-b3d7-46e6-8dc4-15e2841c68d8@intel.com> (Dave Jiang's
	message of "Mon, 17 Jun 2024 10:06:34 -0700")
References: <20240611055423.470574-1-ying.huang@intel.com>
	<ZmjBfcaosIlOODFR@aschofie-mobl2>
	<87v8285ngi.fsf@yhuang6-desk2.ccr.corp.intel.com>
	<b1652fc6-b3d7-46e6-8dc4-15e2841c68d8@intel.com>
Date: Tue, 18 Jun 2024 08:28:51 +0800
Message-ID: <877cen5c1o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii

Dave Jiang <dave.jiang@intel.com> writes:

> On 6/16/24 7:10 PM, Huang, Ying wrote:
>> Alison Schofield <alison.schofield@intel.com> writes:
>> 
>>> On Tue, Jun 11, 2024 at 01:54:23PM +0800, Ying Huang wrote:
>> 
>> [snip]
>> 
>>>> ---
>>>>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>>>>  drivers/cxl/cxl.h         |  2 ++
>>>>  2 files changed, 38 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>>> index 3c2b6144be23..81d0910c0a02 100644
>>>> --- a/drivers/cxl/core/region.c
>>>> +++ b/drivers/cxl/core/region.c
>>>> @@ -9,6 +9,7 @@
>>>>  #include <linux/uuid.h>
>>>>  #include <linux/sort.h>
>>>>  #include <linux/idr.h>
>>>> +#include <linux/memory-tiers.h>
>>>>  #include <cxlmem.h>
>>>>  #include <cxl.h>
>>>>  #include "core.h"
>>>> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>>>  	return true;
>>>>  }
>>>>  
>>>> +static int cxl_region_nid(struct cxl_region *cxlr)
>>>> +{
>>>> +	struct cxl_region_params *p = &cxlr->params;
>>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>>>> +	struct cxl_decoder *cxld = &cxled->cxld;
>>>> +
>>>> +	return phys_to_target_node(cxld->hpa_range.start);
>>>> +}
>>>> +
>>>
>>> I believe it's OK to send a resource_size_t to phys_to_target_node()
>>> like this:
>>>
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2308,10 +2308,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>>  static int cxl_region_nid(struct cxl_region *cxlr)
>>>  {
>>>         struct cxl_region_params *p = &cxlr->params;
>>> -       struct cxl_endpoint_decoder *cxled = p->targets[0];
>>> -       struct cxl_decoder *cxld = &cxled->cxld;
>>>
>>> -       return phys_to_target_node(cxld->hpa_range.start);
>>> +       return phys_to_target_node(p->res->start);
>>>  }
>>>
>> 
>> Read the related code again, it appears that there's a theoretical race
>> condition here.  The register_memory_notifier() is called in
>> devm_cxl_add_region(), where p->targets[] and p->res haven't been
>> setupped yet.  And, IIUC, p->targets[] or p->res may be gone during the
>> life cycle of regions too.  If so, we need to use
>> guard(rwsem_read)(&cxl_region_rwsem) to protect p->targets[] and p->res
>> references.  Because the memory notifier may be called for other nodes
>> online/offline.
>
> You mind sending a patch? :)

Sure.  Will do it.

--
Best Regards,
Huang, Ying
