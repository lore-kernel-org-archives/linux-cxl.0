Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19CB33A9DE;
	Fri, 27 Mar 2026 15:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625338; cv=none; b=EdlCIgWhUiEon+pcby4HrNiamIamU9IOWTRxZ92JH2Ki2jnofq//OZRr+iwMoyG5FOybdc5BOUYfMaDKdmLtiziP1jpvmh6fLlPUOSumSvdNCuWmUiZ911Jny1Xnyr0Te4YZD7XRt1JwEWh2FtBZgAhLY66GDPkEtYiUHEPrbK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625338; c=relaxed/simple;
	bh=J2u6Jqx+FbvWSOw3ohUKrvyOEMc9S5FKrfLPN/czIfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t7bbLK7YT1ioaEoureQKLipYRp9DjXTRYNMYy6EU/kGDpGRaQtZ4BjADL3GCeQQxBdtDcKV8HBnVRTg/J3Z5wNLflWazxooySeOIfiMOf/bOWmcLVjXDcZECH4mBcxUA+TbkEJEsKQDO1bdv8X28nC+2WWeWNUExWEHskYqlVGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oja3Aqjs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oja3Aqjs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDB11C19423;
	Fri, 27 Mar 2026 15:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774625337;
	bh=J2u6Jqx+FbvWSOw3ohUKrvyOEMc9S5FKrfLPN/czIfs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Oja3AqjsW5GP/6tkHzvlIoS8mBTOp9Du3zT1sP+oFAXBoPJgYZiZlPy6BKP1fIzG7
	 ZrbiiwArmjzPeGpRKKO+KX0PXwNzcbPI1lPt9g29p/qJs5I+gGw1wP8d6BE2g+2+TY
	 aRxl2P6GwL+f9MqYsqf6NmYZa7rro1x+uomRN9XcjvK0uce8+Pa7j3xjQNvV9W5lbH
	 R61z94B+48hGYhgEfqDoW0M01M1NHw9xJ1glcQAGo2buzoSBWJAAgdoMrylMFP42Qt
	 X5uE8II/tBHfCBwVaExiVDj65+4NI8EKHXQFGhQjPQgdiQWimBYxGxnNc1sRTTV/8N
	 8GY3xC5kpoImA==
Message-ID: <c8d9fba0-a001-42b0-b0e3-323235cb652b@kernel.org>
Date: Fri, 27 Mar 2026 16:28:53 +0100
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
To: Joshua Hahn <joshua.hahnjy@gmail.com>, Hao Li <hao.li@linux.dev>
Cc: osalvador@suse.de, akpm@linux-foundation.org, vbabka@suse.cz,
 harry.yoo@oracle.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-cxl@vger.kernel.org
References: <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
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
> are in some hot paths like shrink_memcg. Iterating over nodes that don't
> contain any NORMAL memory seems like an inefficiency rather than a bug
> though. 
> 
>> Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
>> offline_pages(). Set the bit when a node that currently lacks normal
>> memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
>> offlining removes the last present pages from zones <= ZONE_NORMAL.
>>
>> This restores the intended semantics without bringing back the old
>> status_change_nid_normal notifier plumbing which was removed in
>> 8d2882a8edb8.
>>
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

I assume you simply mean:


if (zone_idx(zone) <= ZONE_NORMAL && !node_state(nid, N_NORMAL_MEMORY))
	node_set_state(nid, N_NORMAL_MEMORY);

That looks m uch better!

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

Right, all we have to do is check for remaining present_pages in one of
the nodes IIUC.

-- 
Cheers,

David
