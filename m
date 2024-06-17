Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 354A813AD1E;
	Mon, 17 Jun 2024 17:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718643999; cv=none; b=OppIYRhNxrSUcI1EbK1pbaKfHktQvnsSuwbHHnNapFg3qzneEkQsEEVUQ42SmdFWPEYcIwR/rGGjvyqvu0gnrMfQaT5LbQMo3FRhe1xHs3pcBp0IWZJVNnuwHBqO7VyY1+uwqf2f9ady7/LXSnsjyGCS4umUX5SrhzaRU5Y+QgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718643999; c=relaxed/simple;
	bh=zFn2MRuAseKvMtT6I6TQPYdfMV0TCKVZ0GaoNKiDdL8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ilHBKBhEb/EXi+3cB75bu7Ufh/M07S/zn80ze/V3P7vlLQr3YWuk8yR6Hh4VzTVYJjUc+XuS5CM6vxvJW69YTQmnn60zA745e3Vp8qfqKKJ2Eyje1CbtQZQMhvjKzngZVf6vTuNC9zBw2zd2eVsMTJm23wDrKH88PaxklubAiDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V+8nfATM; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V+8nfATM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718643997; x=1750179997;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=zFn2MRuAseKvMtT6I6TQPYdfMV0TCKVZ0GaoNKiDdL8=;
  b=V+8nfATM3QcnNLdOuOLoMYjP+VxKBBBdyKL/BeeXBJ9seum06jhpXntx
   BuS0hyhLTxJLv9BFR/Iy0S9xbhofXzP9S9Hlvehh2hRQTzM4NjQM3k8nL
   c1VCtrlHwVKqzNiYc3BjAXj3sqyUac3EQK7OOTZ4dwcYFIRk3MyOWlWEQ
   OAv58Wcav6F3lkqjhSy21q5bkERJ7Q5XS2CzfRnisg23343fN1Ww5j6oV
   gvgQTqRcz4vIe0WARAYTR3BTj5TLJEUm6HLeu+h9D5X2qClJ5BFNk3k0J
   MAqC9OkgFakp5eq7733DuUdl8Sp5VdK2X2SyQp4HY9W9yjf7t/Wgwjyvh
   g==;
X-CSE-ConnectionGUID: wUl6cfr9RKmt8P+ggrDlCg==
X-CSE-MsgGUID: C3t1+wPqRr2Fo/phQKi1qA==
X-IronPort-AV: E=McAfee;i="6700,10204,11106"; a="12113847"
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="12113847"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:06:37 -0700
X-CSE-ConnectionGUID: h7hsdadQTMqN+vYe/6eZSA==
X-CSE-MsgGUID: MWYCxnXNRrOP95KkVufqJQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,245,1712646000"; 
   d="scan'208";a="41127541"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.111.175]) ([10.125.111.175])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2024 10:06:35 -0700
Message-ID: <b1652fc6-b3d7-46e6-8dc4-15e2841c68d8@intel.com>
Date: Mon, 17 Jun 2024 10:06:34 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -V2] cxl/region: Support to calculate memory tier abstract
 distance
To: "Huang, Ying" <ying.huang@intel.com>,
 Alison Schofield <alison.schofield@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Bharata B Rao <bharata@amd.com>, Alistair Popple <apopple@nvidia.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
References: <20240611055423.470574-1-ying.huang@intel.com>
 <ZmjBfcaosIlOODFR@aschofie-mobl2>
 <87v8285ngi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87v8285ngi.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/16/24 7:10 PM, Huang, Ying wrote:
> Alison Schofield <alison.schofield@intel.com> writes:
> 
>> On Tue, Jun 11, 2024 at 01:54:23PM +0800, Ying Huang wrote:
> 
> [snip]
> 
>>> ---
>>>  drivers/cxl/core/region.c | 40 +++++++++++++++++++++++++++++++++++----
>>>  drivers/cxl/cxl.h         |  2 ++
>>>  2 files changed, 38 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 3c2b6144be23..81d0910c0a02 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -9,6 +9,7 @@
>>>  #include <linux/uuid.h>
>>>  #include <linux/sort.h>
>>>  #include <linux/idr.h>
>>> +#include <linux/memory-tiers.h>
>>>  #include <cxlmem.h>
>>>  #include <cxl.h>
>>>  #include "core.h"
>>> @@ -2304,14 +2305,20 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>>  	return true;
>>>  }
>>>  
>>> +static int cxl_region_nid(struct cxl_region *cxlr)
>>> +{
>>> +	struct cxl_region_params *p = &cxlr->params;
>>> +	struct cxl_endpoint_decoder *cxled = p->targets[0];
>>> +	struct cxl_decoder *cxld = &cxled->cxld;
>>> +
>>> +	return phys_to_target_node(cxld->hpa_range.start);
>>> +}
>>> +
>>
>> I believe it's OK to send a resource_size_t to phys_to_target_node()
>> like this:
>>
>> --- a/drivers/cxl/core/region.c
>> +++ b/drivers/cxl/core/region.c
>> @@ -2308,10 +2308,8 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>  static int cxl_region_nid(struct cxl_region *cxlr)
>>  {
>>         struct cxl_region_params *p = &cxlr->params;
>> -       struct cxl_endpoint_decoder *cxled = p->targets[0];
>> -       struct cxl_decoder *cxld = &cxled->cxld;
>>
>> -       return phys_to_target_node(cxld->hpa_range.start);
>> +       return phys_to_target_node(p->res->start);
>>  }
>>
> 
> Read the related code again, it appears that there's a theoretical race
> condition here.  The register_memory_notifier() is called in
> devm_cxl_add_region(), where p->targets[] and p->res haven't been
> setupped yet.  And, IIUC, p->targets[] or p->res may be gone during the
> life cycle of regions too.  If so, we need to use
> guard(rwsem_read)(&cxl_region_rwsem) to protect p->targets[] and p->res
> references.  Because the memory notifier may be called for other nodes
> online/offline.

You mind sending a patch? :)

> 
> --
> Best Regards,
> Huang, Ying
