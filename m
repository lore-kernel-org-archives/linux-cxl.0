Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72926371899
	for <linux-cxl@vger.kernel.org>; Wed, 19 Aug 2026 21:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173970; cv=none; b=CVKY+TmMol9oQxzsC7QIW61U7h8h3DMDuX0oT+cTK1PAmRcqSwuLj3rbZcgmP/US/aZ5SnI7FKieNT/fma0Bl3GXOsv6mQUgJjM4mY3oXaQGfbxCxcTHWS7H3znuJeP6Kvj8N/kkms0rrdMihwphsQYU/z/TdMWOgrk5OjtScrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173970; c=relaxed/simple;
	bh=NNpv17CSKmkPMnsatm6o5QnNqAB0lwB/lxEaHqTqjHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tszrU5NmtjFz2bPkL6lypoyDXOcRcUQ6/R82BmxeohLVxGV2Q3zVWPZYUzBCbZp7hFCytWe/tC3fLXlsxPZwhE/cbNunz/cfuF70P5Wom0eyOGMx6iUhWESk4v486sWyttbDOqA2g7Oa/hjU3NL6iAVvJRAWFGr4gYa2n8pRQ9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hzAm8gw6; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hzAm8gw6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1787173968; x=1818709968;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NNpv17CSKmkPMnsatm6o5QnNqAB0lwB/lxEaHqTqjHE=;
  b=hzAm8gw68bioHLmV9neh4T5T/GKfAfae2X8kofRA988xwiw/M2ppuqyX
   dLi8arfkf+sn95AT1IWGQv4MGN5gVx58Y52F3mo6Klk+J3Mphk1pEVCC6
   i3uIeEs39ZKxf63u05TXlAzQBKl0gk2jfNgozMxHqJ6a0qY0gWh6rMpXr
   yMc5TFkHRpRbCYuu857dp6IMO436303LC9SVc6mbOjjeppA8m2PJdEUfi
   +JTqmAcjz1AAf3NfSiteyOwqDAkHilBeKVzB2007Xo+r7NxPqqcX7PZ5u
   Fh6WOINtRzT8wMKMef9tS8IiSZ91RX6oW5vJAXeF15tTLUll1bvuJjraq
   Q==;
X-CSE-ConnectionGUID: 8EGrbCBIT8y4+DyZU4QNyQ==
X-CSE-MsgGUID: i7rZ+szzROmSOGBT6/MSxw==
X-IronPort-AV: E=McAfee;i="6800,10657,11880"; a="99060497"
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="99060497"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 14:12:47 -0700
X-CSE-ConnectionGUID: QZgs5SAPRieluqej+j8Ulg==
X-CSE-MsgGUID: 3ZJph5eFTdeLjLEAxzQuLQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,232,1779174000"; 
   d="scan'208";a="269178456"
Received: from aschende-mobl.amr.corp.intel.com (HELO [10.125.108.13]) ([10.125.108.13])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2026 14:12:47 -0700
Message-ID: <9c01c22c-370f-4336-b371-d3fc367aeb35@intel.com>
Date: Wed, 19 Aug 2026 14:12:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/test: Map mock device nodes to an online node
To: Gregory Price <gourry@gourry.net>, Davidlohr Bueso <dave@stgolabs.net>
Cc: jic23@kernel.org, alison.schofield@intel.com, linux-cxl@vger.kernel.org
References: <20260723180630.1302871-1-dave@stgolabs.net>
 <aoXXgaUoIOQDDqjd@gourry-fedora-PF4VCD3F>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <aoXXgaUoIOQDDqjd@gourry-fedora-PF4VCD3F>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/19/26 9:19 AM, Gregory Price wrote:
> On Thu, Jul 23, 2026 at 11:06:30AM -0700, Davidlohr Bueso wrote:
>> cxl_mem_init() assigns alternating NUMA nodes to the mock memdevs
>> to model multi-node topologies. On a single-node host node 1 has
>> no pgdat, and the first node-aware allocation in an odd device's
>> probe faults on a NULL zonelist:
>>
>>   Oops: general protection fault, probably for non-canonical address 0xdffffc00000006e3
>>   KASAN: probably user-memory-access in range [0x0000000000003718-0x000000000000371f]
>>   Workqueue: async async_run_entry_fn
>>   RIP: __alloc_frozen_pages_noprof+0x288
>>    new_slab
>>    ___slab_alloc
>>    __kmalloc_node_track_caller_noprof
>>    devm_kmalloc
>>    cxl_mock_mem_probe
>>
>> Map the requested node to an online one, as dax_hmem already does
>> for its target node.
>>
>> Fixes: cf1f6877b088 ("cxl/memdev: Add numa_node attribute")
>> Fixes: e41c8452b9b2 ("tools/testing/cxl: Add a single-port host-bridge regression config")
>> Fixes: c9435dbee119 ("tools/testing/cxl: Add an RCH topology")
> 
> I think should only have a single fixes tag? Otherwise seems it seems
> unclear where/how to backport?

Issues started with this commit:
Fixes: 17c38c88294d ("slab: remove cpu (partial) slabs usage from allocation paths")

But we probably should just use this:
Fixes: cf1f6877b088 ("cxl/memdev: Add numa_node attribute")

Also, this patch needs to be rebased for v7.3-rc1 due type2 changes for 7.3.

DJ



> 
>> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> 
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> 
>> ---
>> Found while regression testing unrelated work.
>>
>>  tools/testing/cxl/test/cxl.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
>> index ef92dd35e030..5156516a82d2 100644
>> --- a/tools/testing/cxl/test/cxl.c
>> +++ b/tools/testing/cxl/test/cxl.c
>> @@ -1748,7 +1748,7 @@ static int cxl_mem_init(void)
>>  		if (!pdev)
>>  			goto err_mem;
>>  		pdev->dev.parent = &dport->dev;
>> -		set_dev_node(&pdev->dev, i % 2);
>> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>>  
>>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem[i]);
>>  		if (rc)
>> @@ -1763,7 +1763,7 @@ static int cxl_mem_init(void)
>>  		if (!pdev)
>>  			goto err_single;
>>  		pdev->dev.parent = &dport->dev;
>> -		set_dev_node(&pdev->dev, i % 2);
>> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>>  
>>  		rc = cxl_mock_platform_device_add(pdev, &cxl_mem_single[i]);
>>  		if (rc)
>> @@ -1779,7 +1779,7 @@ static int cxl_mem_init(void)
>>  		if (!pdev)
>>  			goto err_rcd;
>>  		pdev->dev.parent = &rch->dev;
>> -		set_dev_node(&pdev->dev, i % 2);
>> +		set_dev_node(&pdev->dev, numa_map_to_online_node(i % 2));
>>  
>>  		rc = cxl_mock_platform_device_add(pdev, &cxl_rcd[i]);
>>  		if (rc)
>> -- 
>> 2.39.5
>>
>>

