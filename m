Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DBE3016EB;
	Thu, 26 Mar 2026 22:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774563594; cv=none; b=oE0D8PwK8vgXZfd1en4wRuJXaXL2vcrJjomir9EuUT1StmTvywqhqiAyjZIHHqHFrrdtxP8SrXlzaYsfBHU2fx5fRu/MPc1P9DPyLlOvCH3KKgohNu1dpD7tqeeqriq7GkLPk8MB9Mqz8zGZSTER+8vzqLxk+8gEQObKJ6vuI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774563594; c=relaxed/simple;
	bh=8B/tXMYm8hAUhCMR+YxCgI3aaCb+Or0dadbsaOVLgmI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Doh06co3wBQk0z1aeaJLbVrF5unn8JKZsFzRT2mspKi2FPtjvzkc/lKwrbA03xFC5BCXYLcS2k5yMOpp5UpqQHlRBdeR8fOYPsJXlk+dYy1tkq5Z6cmr7dRz0vCSSkUpf0oeg/srcprRawP3QT5DoHOl3kxltcxX3BDSRMpdGQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OoNziy5h; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OoNziy5h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774563593; x=1806099593;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=8B/tXMYm8hAUhCMR+YxCgI3aaCb+Or0dadbsaOVLgmI=;
  b=OoNziy5hyxvxPG0DEPMHJEh5j5eXL5K5P23IkABpy0nI9HyIgwFv8aFr
   NXMngjIATphCKbR9KInbQ3CZRwzwRFJJzb0gu3so+2td4fLrf/iJtRY9v
   piGaE0PNcfdM9lBFWxkGkW8sK5P/7xlrmN0iH1Aentnexph9WE+f8Mk7I
   EBFIkxHlj5pP+DKXHKq45JmAO6Xr7tDWM6UnUDVMnwO39vjR0NRFBIEXi
   bvLMbz/rEuPHGD58ydKj5b+mPUQIjh8CMHacgCHqDiKdQRVd/FiN/n3PT
   f5kPq/UuS8RMlbuRnlllS6bc03cB/jZ+Q73EXAg2x/qb08qLY0kupmfLQ
   Q==;
X-CSE-ConnectionGUID: XKW4/VQiRi6jrK9c3i0wTg==
X-CSE-MsgGUID: +wnajsD4Rb+kdCcvncZglQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="75351482"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="75351482"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 15:19:52 -0700
X-CSE-ConnectionGUID: Ko7MAvEgSz2TmyhlSJ4h6A==
X-CSE-MsgGUID: SNSI9yd0Rd6Gw+Hl/lkW9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="263048103"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.122]) ([10.125.110.122])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 15:19:50 -0700
Message-ID: <9d672ece-e67c-47ff-9978-db405c939f67@intel.com>
Date: Thu, 26 Mar 2026 15:19:49 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
From: Dave Jiang <dave.jiang@intel.com>
To: Rakie Kim <rakie.kim@sk.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: akpm@linux-foundation.org, gourry@gourry.net, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, ziy@nvidia.com,
 matthew.brost@intel.com, joshua.hahnjy@gmail.com, byungchul@sk.com,
 ying.huang@linux.alibaba.com, apopple@nvidia.com, david@kernel.org,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, dave@stgolabs.net,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, kernel_team@skhynix.com, honggyu.kim@sk.com,
 yunjeong.mun@sk.com, Keith Busch <kbusch@kernel.org>
References: <20260326085501.343-1-rakie.kim@sk.com>
 <67c5b4a4-fdee-425c-8383-5c9c2f32227c@intel.com>
Content-Language: en-US
In-Reply-To: <67c5b4a4-fdee-425c-8383-5c9c2f32227c@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/26 2:41 PM, Dave Jiang wrote:
> 
> 
> On 3/26/26 1:54 AM, Rakie Kim wrote:
>> On Wed, 25 Mar 2026 12:33:50 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>>> On Tue, 24 Mar 2026 14:35:45 +0900
>>> Rakie Kim <rakie.kim@sk.com> wrote:
>>>
>>>> On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
> 
> <--snip-->
> 
>  
>> Hello Jonathan,
>>
>> Thank you for the deep insight into the HMAT parser code. As you
>> mentioned, considering the current state where node 1 is still
>> registered as the initiator in sysfs despite the flag being 0, it
>> seems highly likely that the kernel parser logic is not handling
>> this specific situation gracefully.
>>
>>>
>>>> Because both HMAT and sysfs are exposing abnormal values, it was
>>>> impossible for me to determine the true socket connections for CXL
>>>> using this data.
>>>>
>>>>>>
>>>>>> Even though the distance map shows node2 is physically closer to
>>>>>> Socket 0 and node3 to Socket 1, the HMAT incorrectly defines the
>>>>>> routing path strictly through Socket 1. Because the HMAT alone made it
>>>>>> difficult to determine the exact physical socket connections on these
>>>>>> systems, I ended up using the current CXL driver-based approach.  
>>>>>
>>>>> Are the HMAT latencies and bandwidths all there?  Or are some missing
>>>>> and you have to use SLIT (which generally is garbage for historical
>>>>> reasons of tuning SLIT to particular OS behaviour).
>>>>>   
>>>>
>>>> The HMAT latencies and bandwidths are present, but the values seem
>>>> broken. Here is the latency table:
>>>>
>>>> Init->Target | node0 | node1 | node2 | node3
>>>> node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
>>>> node1        | 0x89F | 0x38B | 0x3AFC| 0x4268
>>>
>>> Yeah. That would do it...  Looks like that final value is garbage.
> 
> Hi Rakie,
> So I talked to the Intel BIOS folks and apparently for devices that are not hot-plugged (with memory ranges provided in SRAT), those HMAT values are the value for end to end and not just CPU to Gen Port. That's why they look so much bigger. So there are couple things we'll have to consider:
> 1. Make sure that Intel, AMD, and ARM HMATs are all created the same way and this is the agreed on way to do this. Hopefully someone from AMD and ARM vendors can comment. We all should get on the same page for the CXL kernel code to work properly.
> 
> 2. Add code in the CXL driver to detect whether the range is in SRAT and then skip the end to end perf calculation if that is the case. 

After further talking to Jonathan, I don't think at least this part is an issue. The devices that are attached at boot do not have Generic Ports in the SRAT.

> 
> DJ
> 
> 
> <--snip-->
> 
> 

