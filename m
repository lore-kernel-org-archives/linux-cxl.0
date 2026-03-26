Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1613AF66A;
	Thu, 26 Mar 2026 21:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774561298; cv=none; b=ZJPgXaXaoAReQrAL+somOutAI+SjyesyTmvGR0gnp8yMo9faJ1iqRYktv+GSUV6qTD58xKr/of/kyzefxRyMG4/JTXDu5f2aJz0NEF4WeypBLirljLv8Inq0BibaJComlseqUZ4Thlvkl+AjD2e1NvRNRorEnP9X1HRprY4H5SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774561298; c=relaxed/simple;
	bh=T0dtBj3s8LT0i/Bza0Vy9gcessZjN5wbfSYVN87qrFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tQRvPeIgoaB9D38df4lNo3Ac6qmv1bP6j9UEuMzPPQtaObf5ZdPFYKT+jIdoHv48YoA8OexDWdR+JBjj4fK67I++/LIxiyKzoCYkyk/dU2qqGu0BJcLsu06F5voNhi9Th/1f33F049QD3faxi//9eK4ZOXMYuazVT3kgtq2q0hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AoehRjoo; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AoehRjoo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774561296; x=1806097296;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=T0dtBj3s8LT0i/Bza0Vy9gcessZjN5wbfSYVN87qrFo=;
  b=AoehRjoo9NW02w1FS0SuOV2sk/8Q5ItWATzWYcilXcQ3tYoeMRBI1tXF
   JsNbGpUZ/Rt3NUIs8hToFtqnpj5sL3/XWCXbZpEab/p1cUyHmwVaPCct0
   Yb47t6FIkmgBjYBa3zgOVOIw6PFYM8ECNHTGNsMIzPDCBsZD95ir+f5aD
   iHOIYDwJO1vffZwRYra9fnyOzp3c/aFHr7x4bJYceHOb/2D3dR506kTJY
   L3DED+3QJr++iyrPnkyDG039dVmsjUAuALmbfSFjouxOJ+BX+vGRvjrbs
   iPkNkn5ElNoxrSgHiMX19ms+7RaRpg10BhhQ4EdFO2Ixh7cexOz4GySHK
   w==;
X-CSE-ConnectionGUID: 36gykua/Tl2s5dvTCWjPEQ==
X-CSE-MsgGUID: z6iR9nq6R9STcXxbGiRYjw==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="78229762"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="78229762"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:41:35 -0700
X-CSE-ConnectionGUID: VnuhCQUDSWeA2r5M7vYhQA==
X-CSE-MsgGUID: kB3d1EHlSQiPEqxLWFmaRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; 
   d="scan'208";a="255619182"
Received: from rchatre-mobl4.amr.corp.intel.com (HELO [10.125.110.122]) ([10.125.110.122])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2026 14:41:32 -0700
Message-ID: <67c5b4a4-fdee-425c-8383-5c9c2f32227c@intel.com>
Date: Thu, 26 Mar 2026 14:41:32 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] [RFC PATCH 0/4] mm/mempolicy: introduce
 socket-aware weighted interleave
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
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260326085501.343-1-rakie.kim@sk.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 3/26/26 1:54 AM, Rakie Kim wrote:
> On Wed, 25 Mar 2026 12:33:50 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:
>> On Tue, 24 Mar 2026 14:35:45 +0900
>> Rakie Kim <rakie.kim@sk.com> wrote:
>>
>>> On Fri, 20 Mar 2026 16:56:05 +0000 Jonathan Cameron <jonathan.cameron@huawei.com> wrote:

<--snip-->

 
> Hello Jonathan,
> 
> Thank you for the deep insight into the HMAT parser code. As you
> mentioned, considering the current state where node 1 is still
> registered as the initiator in sysfs despite the flag being 0, it
> seems highly likely that the kernel parser logic is not handling
> this specific situation gracefully.
> 
>>
>>> Because both HMAT and sysfs are exposing abnormal values, it was
>>> impossible for me to determine the true socket connections for CXL
>>> using this data.
>>>
>>>>>
>>>>> Even though the distance map shows node2 is physically closer to
>>>>> Socket 0 and node3 to Socket 1, the HMAT incorrectly defines the
>>>>> routing path strictly through Socket 1. Because the HMAT alone made it
>>>>> difficult to determine the exact physical socket connections on these
>>>>> systems, I ended up using the current CXL driver-based approach.  
>>>>
>>>> Are the HMAT latencies and bandwidths all there?  Or are some missing
>>>> and you have to use SLIT (which generally is garbage for historical
>>>> reasons of tuning SLIT to particular OS behaviour).
>>>>   
>>>
>>> The HMAT latencies and bandwidths are present, but the values seem
>>> broken. Here is the latency table:
>>>
>>> Init->Target | node0 | node1 | node2 | node3
>>> node0        | 0x38B | 0x89F | 0x9C4 | 0x3AFC
>>> node1        | 0x89F | 0x38B | 0x3AFC| 0x4268
>>
>> Yeah. That would do it...  Looks like that final value is garbage.

Hi Rakie,
So I talked to the Intel BIOS folks and apparently for devices that are not hot-plugged (with memory ranges provided in SRAT), those HMAT values are the value for end to end and not just CPU to Gen Port. That's why they look so much bigger. So there are couple things we'll have to consider:
1. Make sure that Intel, AMD, and ARM HMATs are all created the same way and this is the agreed on way to do this. Hopefully someone from AMD and ARM vendors can comment. We all should get on the same page for the CXL kernel code to work properly.

2. Add code in the CXL driver to detect whether the range is in SRAT and then skip the end to end perf calculation if that is the case. 

DJ


<--snip-->

