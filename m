Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091672857CA;
	Tue, 15 Jul 2025 17:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752601086; cv=none; b=su3+LvIFh+y+jMHThrjjKLwK1SJfnLZ2tIX7X0K3UwJgmQYopKY99AOfFsHaPCn6t13wH5UJk72fquF/3ufqNrv0NtR/tCHsMNExDGWpmKnDqJM+zsaeWRBhU6yDzal+pPsopF0OzU9UNLkczWvKYta2HBSSICoHP5hUN59qeJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752601086; c=relaxed/simple;
	bh=EbGMQEpU+rnzDU+21fE19WNpsPpsSs+V6wNFBXF4UW8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FqY8071tK1WxTLwX06PBfQ7ZJ32zWyZhw0nnAa0/CdW88G5Y9WCwkKYSmKH9cuOlKEsF7TN8XxrIT9QNTkVKR2DGF+SRE5sogB9xqh7ODnMss0VhYaDRHlePI5bir1yLISj9IAN7D0MoZIUtYOAf0ckzIVwakJIPI8gIvn2ZqqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CYVXbZWu; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CYVXbZWu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752601085; x=1784137085;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EbGMQEpU+rnzDU+21fE19WNpsPpsSs+V6wNFBXF4UW8=;
  b=CYVXbZWufpG4Pn7vysfSqeVgeqO87tXS/+QXt6wuABDyjf92QzDVWDUk
   wtWfGf2+BrxiJug67xPBhmYxjOhTX9hCLnetFpmco7G/N7q8PNydz1dM3
   zRTZmXFLSiK4EasC8vfUh/1Luu2YXxXD2ArhE/QYrLD9SB707UXj756ls
   qiJ0FIFu2dRht+GjwAba0XAu7m5nDx76mC2djfSCrx4PnMEZs93/nvuEO
   4cskz6uc6ySWjc1o1y57VKX55jDhurst7wP/KRk2Wo5nL8yb7+4rEcpIS
   LUlHbuilbmEb2G2QtveAXdRbcMTFVWpTCVufXfYPVHWO7UTQ8e/OwVO8d
   w==;
X-CSE-ConnectionGUID: fyfV3tbgSbK95rMlRWxOeQ==
X-CSE-MsgGUID: KySdnt3LRKyvD3Bj7/z8kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11493"; a="54769996"
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="54769996"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:38:04 -0700
X-CSE-ConnectionGUID: mPzsWfjtSkGu7iiyTl7bZw==
X-CSE-MsgGUID: MBtT5LmQQIOLvuBPxXAiWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,313,1744095600"; 
   d="scan'208";a="157392353"
Received: from tcingleb-desk1.amr.corp.intel.com (HELO [10.125.111.148]) ([10.125.111.148])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 10:38:03 -0700
Message-ID: <691f8616-f39f-449c-bb6e-541c0dcfa974@intel.com>
Date: Tue, 15 Jul 2025 10:38:00 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] cxl: Convert to ACQUIRE() for conditional rwsem
 locking
To: dan.j.williams@intel.com, Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 David Lechner <dlechner@baylibre.com>, Peter Zijlstra
 <peterz@infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>,
 Ingo Molnar <mingo@kernel.org>,
 "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Shiju Jose <shiju.jose@huawei.com>
References: <20250711234932.671292-1-dan.j.williams@intel.com>
 <20250711234932.671292-9-dan.j.williams@intel.com>
 <20250715172035.00007f96@huawei.com>
 <68768c20640c7_2ead10081@dwillia2-xfh.jf.intel.com.notmuch>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <68768c20640c7_2ead10081@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/15/25 10:13 AM, dan.j.williams@intel.com wrote:
> Jonathan Cameron wrote:
>> On Fri, 11 Jul 2025 16:49:32 -0700
>> Dan Williams <dan.j.williams@intel.com> wrote:
>>
>>> Use ACQUIRE() to cleanup conditional locking paths in the CXL driver
>>> The ACQUIRE() macro and its associated ACQUIRE_ERR() helpers, like
>>> scoped_cond_guard(), arrange for scoped-based conditional locking. Unlike
>>> scoped_cond_guard(), these macros arrange for an ERR_PTR() to be retrieved
>>> representing the state of the conditional lock.
>>>
>>> The goal of this conversion is to complete the removal of all explicit
>>> unlock calls in the subsystem. I.e. the methods to acquire a lock are
>>> solely via guard(), scoped_guard() (for limited cases), or ACQUIRE(). All
>>> unlock is implicit / scope-based. In order to make sure all lock sites are
>>> converted, the existing rwsem's are consolidated and renamed in 'struct
>>> cxl_rwsem'. While that makes the patch noisier it gives a clean cut-off
>>> between old-world (explicit unlock allowed), and new world (explicit unlock
>>> deleted).
>>>
>>> Cc: David Lechner <dlechner@baylibre.com>
>>> Cc: Peter Zijlstra <peterz@infradead.org>
>>> Cc: Linus Torvalds <torvalds@linux-foundation.org>
>>> Cc: Ingo Molnar <mingo@kernel.org>
>>> Cc: "Fabio M. De Francesco" <fabio.m.de.francesco@linux.intel.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> Cc: Shiju Jose <shiju.jose@huawei.com>
>>> Acked-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
>>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>>
>> Two trivial comments inline. 
>>
>> Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index 4314aaed8ad8..ad60c93be803 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>
>>>  static int attach_target(struct cxl_region *cxlr,
>>>  			 struct cxl_endpoint_decoder *cxled, int pos,
>>>  			 unsigned int state)
>>>  {
>>> -	int rc = 0;
>>> -
>>> -	if (state == TASK_INTERRUPTIBLE)
>>> -		rc = down_write_killable(&cxl_region_rwsem);
>>> -	else
>>> -		down_write(&cxl_region_rwsem);
>>> -	if (rc)
>>> -		return rc;
>>> -
>>> -	down_read(&cxl_dpa_rwsem);
>>> -	rc = cxl_region_attach(cxlr, cxled, pos);
>>> -	up_read(&cxl_dpa_rwsem);
>>> -	up_write(&cxl_region_rwsem);
>>> +	int rc = __attach_target(cxlr, cxled, pos, state);
>>>  
>>
>> ... (start of block for next comment)
>>
>>> -	if (rc)
>>> -		dev_warn(cxled->cxld.dev.parent,
>>> -			"failed to attach %s to %s: %d\n",
>>> -			dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
>>> +	if (rc == 0)
>>> +		return 0;
>>>  
>>> +	dev_warn(cxled->cxld.dev.parent, "failed to attach %s to %s: %d\n",
>>> +		 dev_name(&cxled->cxld.dev), dev_name(&cxlr->dev), rc);
>>
>> I'm not seeing a reason for this change.  I prefer the original
>> with the error path as the out of line case.
> 
> I prefer the out-dent of the message. I'll let Dave tie-break.

I'm leaning towards leaving it alone if there's no functional change. If there's a v4 then revert the changes, otherwise I guess just let it be.

DJ

> 
>>>  	return rc;
>>>  }
>>
>>
>>> @@ -3592,30 +3552,23 @@ static int cxl_region_can_probe(struct cxl_region *cxlr)
>> ...
>>   
>>>  	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
>>>  		dev_err(&cxlr->dev,
>>>  			"failed to activate, re-commit region and retry\n");
>>> -		rc = -ENXIO;
>>> -		goto out;
>>> +		return -ENXIO;
>>
>> 		return dev_err_probe(&cxlr->dev, -ENXIO,
>> 				     "failed to activate, re-commit region and retry\n");
>>
>> perhaps. I always like the cleanup.h stuff enabling this as it improves the patch
>> line count no end ;)
> 
> I think that looks good, but perhaps as a follow-on cleanup?

