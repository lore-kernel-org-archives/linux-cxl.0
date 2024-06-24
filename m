Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFD51DFEA;
	Mon, 24 Jun 2024 15:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719242691; cv=none; b=Pqv0itpvwO5KY+qTSTNS6gc23UxBlz1Oa6P/3bfrsw+IZBT4vHBNlkzFOmfcvT/WmTaICy4n5Xm8P+ekN3OY0MujM9O4DIvqgCyBBhiZJAZW343tTPeBsklMCOPpVifmDMXmZ5y9CLoKZ9jDXnOQuyWeJU1j6vMpUJIv2IZG5nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719242691; c=relaxed/simple;
	bh=+FI3POEgqlvVKntt6wy2SUb7y0AW3rS7GUdFiz0F8Sc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jNr36SQpt4SsMKgYZMFWWdjs+kTovcGWiseSlJhh8DDGcvo6xY7S9Oe8OYzUu0WWdSCz6gRiJOtejpg+apjiuOms/iLNehDminTrKeaGH/f0jUXvO9JvvfepqI4JEn2vMSalq0c2eYPCvitZamI04s/0PWGfABZAZlc/2AHp51Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtJgk3hN; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtJgk3hN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719242689; x=1750778689;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=+FI3POEgqlvVKntt6wy2SUb7y0AW3rS7GUdFiz0F8Sc=;
  b=RtJgk3hNttu6ncUV//m7FwUVUJK7W+DHRWgDVMWS6O5+KuaYDjOB/bmc
   hj0RLZHCoogLDedGQk3x+9sGEpv9MeJGt7zp2KFSt36mC/eJFyytheimR
   ReAloI6HhG6bLSiJQofqesprli7yKzaAdB1rmW/LUcK5X+BHAHpAKlRRl
   +AL/IugTNJLxPGmYUNKzEtzo0ef2U7Nx613tIuxaMreYU8sWa3MGl3g2d
   kw8JhCKb5W9DTC4hLufjwEfPQa0WM+NLsuDKL1N93HyUjJEGBclKXKlTX
   QFdXuN9SnazdkJCZidx219qS5V9MXlfvZ4mW0NWxsmGR/MQNUYsqAjkWm
   g==;
X-CSE-ConnectionGUID: k8Kf2c1JTc+PSOAecPu4yQ==
X-CSE-MsgGUID: 6di3NlE6ShmyMtNH3ftzfA==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16364342"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16364342"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:24:48 -0700
X-CSE-ConnectionGUID: 9SyTmW8dRAe7P8MloXCNtQ==
X-CSE-MsgGUID: yGUAHZJOSVeuWIt38vKPNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="43777282"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.125.108.207]) ([10.125.108.207])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 08:24:48 -0700
Message-ID: <ab5c6540-373e-418b-8d04-27518842ea51@intel.com>
Date: Mon, 24 Jun 2024 08:24:47 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] cxl/region: Simplify cxl_region_nid()
To: "Huang, Ying" <ying.huang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org, Alison Schofield <alison.schofield@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Bharata B Rao <bharata@amd.com>,
 Alistair Popple <apopple@nvidia.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Vishal Verma
 <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>
References: <20240618084639.1419629-1-ying.huang@intel.com>
 <20240618084639.1419629-4-ying.huang@intel.com>
 <20240620121517.00006e3e@Huawei.com>
 <87wmmj117v.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <87wmmj117v.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 6/20/24 7:25 PM, Huang, Ying wrote:
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> writes:
> 
>> On Tue, 18 Jun 2024 16:46:39 +0800
>> Huang Ying <ying.huang@intel.com> wrote:
>>
>>> The node ID of the region can be gotten via resource start address
>>> directly.  This simplifies the implementation of cxl_region_nid().
>>>
>>> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
>>> Suggested-by: Alison Schofield <alison.schofield@intel.com>
>>> Cc: Dan Williams <dan.j.williams@intel.com>
>>> Cc: Andrew Morton <akpm@linux-foundation.org>
>>> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>> Cc: Dave Jiang <dave.jiang@intel.com>
>>> Cc: Bharata B Rao <bharata@amd.com>
>>> Cc: Alistair Popple <apopple@nvidia.com>
>>> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>>> Cc: Davidlohr Bueso <dave@stgolabs.net>
>>> Cc: Vishal Verma <vishal.l.verma@intel.com>
>>> Cc: Ira Weiny <ira.weiny@intel.com>
>>> ---
>>>  drivers/cxl/core/region.c | 10 ++++------
>>>  1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
>>> index dc15ceba7ab7..605efe3562c6 100644
>>> --- a/drivers/cxl/core/region.c
>>> +++ b/drivers/cxl/core/region.c
>>> @@ -2309,15 +2309,13 @@ static bool cxl_region_update_coordinates(struct cxl_region *cxlr, int nid)
>>>  static int cxl_region_nid(struct cxl_region *cxlr)
>>>  {
>>>  	struct cxl_region_params *p = &cxlr->params;
>>> -	struct cxl_endpoint_decoder *cxled;
>>> -	struct cxl_decoder *cxld;
>>> +	struct resource *res;
>>>  
>>>  	guard(rwsem_read)(&cxl_region_rwsem);
>>> -	cxled = p->targets[0];
>>> -	if (!cxled)
>>> +        res = p->res;
>>
>> Odd indent - I think spaces rather than tab.  Otherwise seems
>> reasonable.
> 
> Good catch!  I used spaces accidently.
> 
> Hi, Dave,
> 
> Do you need me to send a new version?  Or you can change it?

The series LGTM. I can fix it up unless there are other comments from someone else that require changes. Also thanks for the fix in 1/3. 

> 
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Thank you very much for your review!
> 
> --
> Best Regards,
> Huang, Ying
> 
>>
>>> +	if (!res)
>>>  		return NUMA_NO_NODE;
>>> -	cxld = &cxled->cxld;
>>> -	return phys_to_target_node(cxld->hpa_range.start);
>>> +	return phys_to_target_node(res->start);
>>>  }
>>>  
>>>  static int cxl_region_perf_attrs_callback(struct notifier_block *nb,
