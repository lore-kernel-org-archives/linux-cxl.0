Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0B783ED5D3;
	Fri, 27 Mar 2026 14:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622662; cv=none; b=BpjHPVA0mE68d75ZseNHiH10qaqCHTTYZ6nupfb+ks41jaiwePl5hnZd/ZgfViqjU0jhEjKk5WXbBoEpnME2lTsuTz4qtinDSXq8seu6hagfHHQwC0Qmoqy9ue2E1l+g+hYR4Otn8+5NRo7EA12Ua1JXa9OTGqG+B3HKh5F0tTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622662; c=relaxed/simple;
	bh=VzHqT1HLWRjCt76mqRElErCGJJ63FvELKETApdvgTtc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2ZzdKD72rlfxPnyG979ReGp6GrIaO7bCYceUp+B9mYHuOwxEUmAMwdihDqSg6wfaVNiULVCO9GcwVzW5IMS1PDNOHX9VO9klCjTuy2KGGVVOqyWhWDgy9xHE3L/ucvMca6/WWT1w+zZdgZqgVfB0ZJR8HhZ6Zc1w5NNFUaV6Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8E2wyNd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8E2wyNd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9445CC19423;
	Fri, 27 Mar 2026 14:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622662;
	bh=VzHqT1HLWRjCt76mqRElErCGJJ63FvELKETApdvgTtc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=a8E2wyNdJdSDZm0OE8JfiS0ZOuXavyS8W+f3sH3lFuwsiRPNFKHKQuJ37M5mjZ7gP
	 vk/NEMG//USy10sqpVztsM6u/7B5EcEerEDDx/SvI6+nSnMCyWxFCvPddhJNJJ3SNC
	 wJfUkzB0oy27IjdARRblG64Ei4E8V40vR2iDoCrZwXVq0MVnCKyYRrDNPkei+YHZAy
	 dV5obcBpIRU5PUZ+4Et8Ob37LyIf5R6YwF//O8oBlXJHN5TtEZqcrPCii0sRI5a5fx
	 5NnHYhh1ehALiW8ZME4bu9f3vV1L/kQUmpg2mXDKGKH9D8BZO/ZyWpkQd+phdl0AuR
	 9riX2874GFefw==
Message-ID: <2356614e-d9b8-4639-8e2a-96c5e4eaef61@kernel.org>
Date: Fri, 27 Mar 2026 15:44:18 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Content-Language: en-US
To: Joshua Hahn <joshua.hahnjy@gmail.com>, Hao Li <hao.li@linux.dev>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org,
 vbabka@suse.cz, harry.yoo@oracle.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
References: <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/27/26 15:38, Joshua Hahn wrote:
> On Fri, 27 Mar 2026 20:42:47 +0800 Hao Li <hao.li@linux.dev> wrote:
> 
> Hello Hao,
> 
> I hope you are doing well, thank you for the patch!
> 
>> N_NORMAL_MEMORY is initialized from zone population at boot, but memory
>> hotplug currently only updates N_MEMORY. As a result, a node that gains
>> normal memory via hotplug can remain invisible to users iterating over
>> N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
>> incorrectly marked as such.
> 
> The second part feels more important than the second part, doing a quick
> glance through the code I can see a few N_NORMAL_MEMORY iterators that

Note in practice it's unlikely that a node would hotplug normal memory,
start using it, and then manage to successfully hotremove it, due to
unmovable allocations. Most likely only ZONE_MOVABLE memory can get hotremoved.

> are in some hot paths like shrink_memcg. Iterating over nodes that don't
> contain any NORMAL memory seems like an inefficiency rather than a bug
> though. 

Ignoring nodes that have normal memory, just because it was hotplugged, will
result also just in some form of inefficiency, or can the consequences be worse?

>> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
>> offline_pages(). Set the bit when a node that currently lacks normal
>> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
>> offlining removes the last present pages from zones <= ZONE_NORMAL.
>> 
>> This restores the intended semantics without bringing back the old
>> status_change_nid_normal notifier plumbing which was removed in
>> 8d2882a8edb8.

But commit 8d2882a8edb8 didn't introduce the current state, or did it?

>> Current users that benefit include list_lru, zswap, nfsd filecache,
>> hugetlb_cgroup, and has_normal_memory sysfs reporting.
>> 
>> Signed-off-by: Hao Li <hao.li@linux.dev>
>> ---
>> 
>> This patch also prepares for a subsequent SLUB change that makes
>> can_free_to_pcs() rely on N_NORMAL_MEMORY to decide whether an object can be
>> freed to the sheaf.
>> 
>> ---
>>  mm/memory_hotplug.c | 22 ++++++++++++++++++++++
>>  1 file changed, 22 insertions(+)
>> 
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index bc805029da51..5498744aa1f1 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -1155,6 +1155,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>>  	int need_zonelists_rebuild = 0;
>>  	unsigned long flags;
>>  	int ret;
>> +	bool need_set_normal_memory = false;
>>  
>>  	/*
>>  	 * {on,off}lining is constrained to full memory sections (or more
>> @@ -1180,6 +1181,9 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>>  		if (ret)
>>  			goto failed_addition;
>>  	}
>> +	/* Adding normal memory to the node for the first time */
>> +	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
>> +		need_set_normal_memory = true;
>>  
>>  	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
>>  	ret = notifier_to_errno(ret);
>> @@ -1209,6 +1213,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
>>  
>>  	if (node_arg.nid >= 0)
>>  		node_set_state(nid, N_MEMORY);
>> +	if (need_set_normal_memory)
>> +		node_set_state(nid, N_NORMAL_MEMORY);
>>  	if (need_zonelists_rebuild)
>>  		build_all_zonelists(NULL);
> 
> Do we need the flag here? As far as I can tell, we can just skip this and just
> directly check whether this is the first normal memory we are adding to the
> node here and set the bit. Then we can remove the flag and the extraneous
> check. We won't do any notifier work so I think it should be OK.
> 
>> @@ -1908,6 +1914,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>  	unsigned long flags;
>>  	char *reason;
>>  	int ret;
>> +	bool need_clear_normal_memory = false;
>> +	unsigned long node_normal_pages = 0;
>> +	enum zone_type zt;
>>  
>>  	/*
>>  	 * {on,off}lining is constrained to full memory sections (or more
>> @@ -1977,6 +1986,13 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>  			goto failed_removal_isolated;
>>  		}
>>  	}
>> +	/*
>> +	 * Check whether this operation removes the node's last normal memory.
>> +	 */
>> +	for (zt = 0; zt <= ZONE_NORMAL; zt++)
>> +		node_normal_pages += pgdat->node_zones[zt].present_pages;
>> +	if (nr_pages >= node_normal_pages && zone_idx(zone) <= ZONE_NORMAL)
>> +		need_clear_normal_memory = true;
>>  
>>  	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
>>  	ret = notifier_to_errno(ret);
>> @@ -2055,6 +2071,12 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>>  	/* reinitialise watermarks and update pcp limits */
>>  	init_per_zone_wmark_min();
> 
> Same here, couldn't we just iterate through the paegs here and accumulate
> node_normal_pages and clear the memory here? We can get rid of the bool and
> also keep node_normal_pages defined inside an if (zone_idx(zone) <= ZONE_NORMAL)
> check as well. 
> 
>> +	/*
>> +	 * Clear N_NORMAL_MEMORY first to avoid the transient state
>> +	 * "!N_MEMORY && N_NORMAL_MEMORY".
>> +	 */
>> +	if (need_clear_normal_memory)
>> +		node_clear_state(node, N_NORMAL_MEMORY);
>>  	/*
>>  	 * Make sure to mark the node as memory-less before rebuilding the zone
>>  	 * list. Otherwise this node would still appear in the fallback lists.
>> -- 
>> 2.50.1
>> 
>> 
> 
> Thank you for the patch. The rest looks good to me! Have a great day : -)
> Joshua

