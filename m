Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BD881B9834
	for <linux-cxl@vger.kernel.org>; Thu, 12 Sep 2024 15:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726154231; cv=none; b=CgFej2y3945ZV1GiPN8turoqtGzFBX8tOV8Z59O9zGsTY/73eWYGe/qhMjFSwtK4u69X86CD4XobemdxrOJcyuwHsgjZlxoSG6/uHM9wcI0XQ4yRtiOnajr3UlVolwHaGpOJqSmqmBWeJSHKk8iiNqrBjcNSQPyBIXsSg5o/ZQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726154231; c=relaxed/simple;
	bh=ybYgjdOqu+dgUCD/msE0MGZvAiS8bjjdXPmisxDWXng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J42BKqW2LVfa/z5quVtABQaByd3GZ1Qh8NFXYrP1EzLAZh0gpW0jZ2FSLVGEOgjbYAN73JgPC6vC5gyYBFmsCHyXHwc7FlT5RBUNSKeGPeJGOPdnBj2p5wnRu1neyYREhwoOsmBntRUQKlO3Jn0vl0AajA0fiz8GJxTws3h2KAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=j829SQOs; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="j829SQOs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1726154230; x=1757690230;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ybYgjdOqu+dgUCD/msE0MGZvAiS8bjjdXPmisxDWXng=;
  b=j829SQOsPoMaiFzD/qF4+TcElJGLP511S4q+HELjVBJNXKNPLnikMMGF
   6SsesSmAkvjFQhd7rV8SAtcHPgcaDxz2J5ObUj7JXW3cQTprOjp6Y6Ibo
   /K6TmKZHxRxqgcyfEAlU+TW+BbSaZvWxj3ZZKhmun/BlGuAgfmmj+GPBl
   up1p7JlqD9iI8Y5vz88Uyd6yUgMQJef2seFMnJSNUGg1ehcL4FMasN6qB
   RbwibgBZVDFy7lC5g9r++81zqbytZtuPIwDAelx4kYPU9t+TXypQEqAuy
   BbBYMJIei/0/KrTml71C5eLcb3/POQZ67TGL+RaBZ0+kLbRC4Tlm2ErK6
   g==;
X-CSE-ConnectionGUID: 1NLKF02wRNWPaOraivqe3A==
X-CSE-MsgGUID: jixbii0zTmWrU+E63TEwUA==
X-IronPort-AV: E=McAfee;i="6700,10204,11193"; a="35685895"
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="35685895"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:17:08 -0700
X-CSE-ConnectionGUID: mAP9A0rSTNSMdQHqVve+wA==
X-CSE-MsgGUID: iVJhFa7BSMGyOxL1S7tssA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,223,1719903600"; 
   d="scan'208";a="67358665"
Received: from apaszkie-mobl2.apaszkie-mobl2 (HELO [10.125.108.93]) ([10.125.108.93])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2024 08:17:07 -0700
Message-ID: <6d9fc6b9-ddf5-4429-8d67-3a09f75960ac@intel.com>
Date: Thu, 12 Sep 2024 08:17:06 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] perf/cxlpmu: Support missing events in 3.1 spec
To: Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>
Cc: jonathan.cameron@huawei.com, fan.ni@samsung.com, linux-cxl@vger.kernel.org
References: <20240911215221.308483-1-dave@stgolabs.net>
 <ZuJBKHi-l3YSgDEW@aschofie-mobl2.lan>
 <b4qrc6xbwmmfidmyhaieu3kxlqewtupttp3pqatg2rj6ua2yxd@xwx4ybpysnil>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <b4qrc6xbwmmfidmyhaieu3kxlqewtupttp3pqatg2rj6ua2yxd@xwx4ybpysnil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 9/11/24 8:23 PM, Davidlohr Bueso wrote:
> On Wed, 11 Sep 2024, Alison Schofield wrote:\n
>> On Wed, Sep 11, 2024 at 02:52:21PM -0700, Davidlohr Bueso wrote:
>>> Update the CXL PMU driver to support the new events introduced
>>> in the latest revision. These are:
>>>
>>> - read/write accesses with TEE constraints.
>>> - S2M indicating Modified state.
>>>
>>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
>>> ---
>>>  drivers/perf/cxl_pmu.c | 31 ++++++++++++++++++-------------
>>>  1 file changed, 18 insertions(+), 13 deletions(-)
>>>
>>> diff --git a/drivers/perf/cxl_pmu.c b/drivers/perf/cxl_pmu.c
>>> index 1f93a66eff5b..13005f410ee0 100644
>>> --- a/drivers/perf/cxl_pmu.c
>>> +++ b/drivers/perf/cxl_pmu.c
>>> @@ -63,7 +63,7 @@
>>>
>>>  #define CXL_PMU_COUNTER_REG(n)        (0xc00 + 8 * (n))
>>>
>>> -/* CXL rev 3.0 Table 13-5 Events under CXL Vendor ID */
>>> +/* CXL rev 3.1 Table 13-5 Events under CXL Vendor ID */
>>
>> I hesitate to be picky here, but also I don't think we want to set
>> a precedent. In CXL-land at least, I don't think it is our intent
>> to keep spec revisions, sections, tables updated in general.
>>
>> That makes me think the only places where this patch should reference
>> 3.1 is for the new items you added. All the extra spec updates can be
>> omitted.
> 
> I have no strong preference really. I updated all the event references
> to 3.1 because it felt weird just updating the comments for the new ones.

I would say unless you are working in a specific part and updating that register block or adding a new definitions I would just leave it alone. Otherwise it's a lot of code churn. Will take that spelling correction though.

> 
> Thanks,
> Davidlohr
> 
