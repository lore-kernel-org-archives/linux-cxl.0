Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F5F19A
	for <linux-cxl@vger.kernel.org>; Tue, 10 Jun 2025 00:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749514044; cv=none; b=qippCjgaduDKsBUs2ZlvFEsote5qxLfh/IyqMrXCvUVopp9gkePRJoyxcklfY1043bP3xaixYhMDDApuM8IpIAemweBacqtTW8AruYWWaLH8RlFPC6otNdxH9gowmpe5tRFxXAIyfpZpuodUxa5u4+1bQxx7+kkeqxcyT2vRBaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749514044; c=relaxed/simple;
	bh=JRdNWbBcQjiiqBpGehVUQoohDrBHYPcVimh2WujVFBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lJTGtiyzw1vd51yW68It/VLckdUSGe/NTzaao2tXn8hLddCS82jhvdlKtkassZIW/OOMmMOhlz5hynBvFxwYJZq51e+cb7gDUzItaEgHevXb2Oz95sUZlImY1ULMVBX94+0xOW4+mUgJ+512fplmARv+sucqduqs8xKX1ALwM8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BhY1StmW; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BhY1StmW"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749514042; x=1781050042;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JRdNWbBcQjiiqBpGehVUQoohDrBHYPcVimh2WujVFBw=;
  b=BhY1StmWpurNih/EaJ5y1JE1yMEjm8rgV21zRs/cvM7O4+DpzLSrxV67
   Tz5RbF/yOuAxqCQE3QLF2CDlICzcUdf/i2sw9s4p6YjP2+hV5jlL4BiGC
   EylITd8byLKnwJbWFIb+jKlu7bdorFsbT83NI0cYu3HCGnhKrwzZ930YM
   yO2YaXlh9LlYB397/45ZDUXzB1uafAF1nKs/Dn3DBoCH97nIF68xb9gDD
   C8cLoqFxFz3nDYVNXkCV9CN/zP9dy7cjp3KCcZauxm20UTHUBc2JU9wIT
   6bSCH1kgHBj2nmK78G5VUy9YkujmXTnuXjEr8LtJBCSiPCERwRsHgrDxK
   Q==;
X-CSE-ConnectionGUID: iIpyb6zQRg2LkAH9HjkaWQ==
X-CSE-MsgGUID: uDhR05I8Sf26SEVV+8Edvg==
X-IronPort-AV: E=McAfee;i="6800,10657,11459"; a="51517820"
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="51517820"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 17:07:22 -0700
X-CSE-ConnectionGUID: fHbhqcoqR+aElErDkbLx+w==
X-CSE-MsgGUID: QW6Cz3/ZTuCGUPp4OEgo+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,223,1744095600"; 
   d="scan'208";a="147019966"
Received: from msatwood-mobl.amr.corp.intel.com (HELO [10.125.111.99]) ([10.125.111.99])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2025 17:07:20 -0700
Message-ID: <45e82050-837a-48b6-b505-506a20372bbc@intel.com>
Date: Mon, 9 Jun 2025 17:07:19 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl_test: Limit location for fake CFMWS to mappable range
To: Itaru Kitayama <itaru.kitayama@linux.dev>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 Marc Herbert <Marc.Herbert@linux.intel.com>,
 Alison Schofield <alison.schofield@intel.com>, linuxarm@huawei.com
References: <BCD3DCBE-C008-4315-BF6E-B5B75EE70A7E@linux.dev>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <BCD3DCBE-C008-4315-BF6E-B5B75EE70A7E@linux.dev>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/9/25 5:02 PM, Itaru Kitayama wrote:
> 
> 
>> On Jun 10, 2025, at 2:25, Dave Jiang <dave.jiang@intel.com> wrote:
>>
>> ﻿
>>
>>> On 5/27/25 8:34 AM, Jonathan Cameron wrote:
>>> Some architectures (e.g. arm64) only support memory hotplug operations on
>>> a restricted set of physical addresses. This applies even when we are
>>> faking some CXL fixed memory windows for the purposes of cxl_test.
>>> That range can be queried with mhp_get_pluggable_range(true). Use the
>>> minimum of that the top of that range and iomem_resource.end to establish
>>> the 64GiB region used by cxl_test.
>>>
>>> From thread #2 which was related to the issue in #1.
>>>
>>> Link: https://lore.kernel.org/linux-cxl/20250522145622.00002633@huawei.com/ #2
>>> Reported-by: Itaru Kitayama <itaru.kitayama@linux.dev>
>>> Closes: https://github.com/pmem/ndctl/issues/278 #1
>>> Reviewed-by: Dan Williams <dan.j.williams@intel.com>
>>> Tested-by: Itaru Kitayama <itaru.kitayama@fujitsu.com <mailto:itaru.kitayama@fujitsu.com>
>>> Tested-by: Marc Herbert <marc.herbert@linux.intel.com>
>>> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>>
>> Applied to cxl/next
>>
>> Added the config check from Alison
> 
> Can this go into the 6.16 release cycle -rc2 or -rc3?

Given that it doesn't break the actual kernel, it's going in 6.17.

> 
> Itaru.
> 
>>
>>>
>>> ---
>>> I haven't given this a fixes tag because it never worked on arm64.
>>> So it isn't a regression fix, and I'm not sure we want to back port this
>>> which a fixes tag might well trigger.  If people want one shout and I'll
>>> try and figure out what is appropriate.
>>> ---
>>> tools/testing/cxl/test/cxl.c | 7 ++++++-
>>> 1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>>> index 8a5815ca870d..6a25cca5636f 100644
>>> --- a/tools/testing/cxl/test/cxl.c
>>> +++ b/tools/testing/cxl/test/cxl.c
>>> @@ -2,6 +2,7 @@
>>> // Copyright(c) 2021 Intel Corporation. All rights reserved.
>>>
>>> #include <linux/platform_device.h>
>>> +#include <linux/memory_hotplug.h>
>>> #include <linux/genalloc.h>
>>> #include <linux/module.h>
>>> #include <linux/mutex.h>
>>> @@ -1328,6 +1329,7 @@ static int cxl_mem_init(void)
>>> static __init int cxl_test_init(void)
>>> {
>>>    int rc, i;
>>> +    struct range mappable;
>>>
>>>    cxl_acpi_test();
>>>    cxl_core_test();
>>> @@ -1342,8 +1344,11 @@ static __init int cxl_test_init(void)
>>>        rc = -ENOMEM;
>>>        goto err_gen_pool_create;
>>>    }
>>> +    mappable = mhp_get_pluggable_range(true);
>>>
>>> -    rc = gen_pool_add(cxl_mock_pool, iomem_resource.end + 1 - SZ_64G,
>>> +    rc = gen_pool_add(cxl_mock_pool,
>>> +              min(iomem_resource.end + 1 - SZ_64G,
>>> +                  mappable.end + 1 - SZ_64G),
>>>              SZ_64G, NUMA_NO_NODE);
>>>    if (rc)
>>>        goto err_gen_pool_add;
>>
> 

