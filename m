Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DBF1CCEE2
	for <linux-cxl@vger.kernel.org>; Tue,  8 Apr 2025 14:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744122387; cv=none; b=kByMfRhFXftA0BqSrvAXzNDWnuUBbTg4vZctyX3ljTOIUPgvWl9OXt6owNTCTI83jl9Z3aqD6Nh98GmhUHH6kQYZvjH6PmgwS/9LnuA7TXlIm9KcWr1AY1LnXs24uhc6LMf5rd7ifDy79dBWL3dwa9gTZTbmi1YFtKwOCnxuxKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744122387; c=relaxed/simple;
	bh=o9SbxjFmy56UpmIx0oi+ZQHqDhIiT+abssNTnn2ZEXM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aFLAG4m/NkGDX/eHyaaKsUfDtz/VlwldrZcQ+efCidd0JLIk1UkT4QVpfYQPrpVlqgh5KcrLGpYmylxBjPeJbtxJD3o5C0nKGoDJLA1T3ImzkVkUNaDVPRR1/85cgVbCv0XsgIoOk3CFnT/oY8kvEuXTgtztD8UEQR/pajXqdUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NSxOCiP6; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NSxOCiP6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744122383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=cdYzwQdmas4AvXbPEP9rA3v9GgJ/jWsMLp6HlDh9xY4=;
	b=NSxOCiP66tqQQpwii1saxGd3T0Vz3KPmhvH861GDOWDnSREPma1kb0QAYqLL57BdyHfXA7
	P53Z8+PcqHSl+h8gzAkjuIP4CEv1A3K4ROB5Q2Bn8PMg0GP0hUu2bDpwCkcdjXvnqntDU4
	6OEWIqovn/HjsPRVe2uOKEa9Nxmd5qU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-TyRU_Jj-NBqOjZhSQ-ywPQ-1; Tue, 08 Apr 2025 10:25:36 -0400
X-MC-Unique: TyRU_Jj-NBqOjZhSQ-ywPQ-1
X-Mimecast-MFC-AGG-ID: TyRU_Jj-NBqOjZhSQ-ywPQ_1744122335
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43ceeaf1524so32448115e9.1
        for <linux-cxl@vger.kernel.org>; Tue, 08 Apr 2025 07:25:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744122335; x=1744727135;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt
         :content-language:from:references:cc:to:subject:user-agent
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=cdYzwQdmas4AvXbPEP9rA3v9GgJ/jWsMLp6HlDh9xY4=;
        b=gqkxsyKBIVC+lYngZYqPAAt+tUuP2kJALhFvjqoQh25Wtv65tiovYcd6o3KBbeSs8d
         riSkXA+vGrA3eHLHWokn+xbaUUufo/L1CtOCQgGBmWHf2jhujL/sVThB3+YZ+O987S4d
         evc7n2nt1FO3cyoH+wCa93Hff9b1YhBDy02cpHY1UyrwNJhoFd3csCVkRxy3odVW1B5E
         m3gn3eFsWV1kvyOx81bw6dNe+aj898qgxAK3OZLmAwV9DK/MOKLZEbBVNbHL8+5oHlSr
         Z+dve+bBlSMiwQqhyMRmqXUn8SDycepB9vvYNWK+OHyZ+7QIILQyI4XOR0VzuDRNHJ6H
         jrZw==
X-Forwarded-Encrypted: i=1; AJvYcCXXP8+ZCeaMWfFvYVWwD6lmgJeymc+2bRJ+uZawocbrEJ9ActTsBI0iWXO/lwcPEZvIoRkDX4SmXVw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx896YOgzR+mnJFU8dnl+Ezotq0396yOufAbWzUp93i/UhV1c8N
	7z1MqAaCFOJFPlG7jgkUN4bk6miYK3elsljPC2gULxGap+PBpbNYiOtERbs1aeWSt+Ahb6DyOem
	rFS57lEoKipdaxGhuV+XQY/O3th+1tJ/siKalUqNBasZyJDaxDLD9ZfKsGg==
X-Gm-Gg: ASbGncvisDOz5VXWpkJdVShmINirxwiTkzci7POWJUUZXxIFNZ5Xvl3y22/uWY6gTSv
	6bnayIABDYQToni/kUzg/nNXLTyU8RyaoyxGZU86yiy2lvFDCfgheljyiH5Xt7IkHIHDxK8sN0i
	4j2M2QSeEp/tnmtvps4jP0zSR4f6c7g/mNIJkzLRRcy608EGhPjn/4Pf3T9k1NLRMIJ3F6WXizC
	5v03rNhe1uwh6/qId2U2xcQjRlwqif+sXeLVodEM47aEIwp34C/nPi/6endEQmDRLQlvRoYSaPu
	yrRvms7TN0aMDnvjJcMwPiAZ6tIGjwI6XLX9PxSGv04igA==
X-Received: by 2002:a05:600c:4fcf:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43f0e559b59mr25070685e9.2.1744122335145;
        Tue, 08 Apr 2025 07:25:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEmTbfxJIh666ObJTK1RRy0WNRsx3t3PI5C48zyEfbY1TrN6gfjIulvoD2QknSx2rkn+d8uDg==
X-Received: by 2002:a05:600c:4fcf:b0:439:8878:5029 with SMTP id 5b1f17b1804b1-43f0e559b59mr25070395e9.2.1744122334712;
        Tue, 08 Apr 2025 07:25:34 -0700 (PDT)
Received: from [192.168.3.141] (p4ff236e3.dip0.t-ipconnect.de. [79.242.54.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43f0e5e8dfasm28445335e9.27.2025.04.08.07.25.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Apr 2025 07:25:34 -0700 (PDT)
Message-ID: <b26b32c9-6b3a-4ab4-9ef4-c20b415d5483@redhat.com>
Date: Tue, 8 Apr 2025 16:25:33 +0200
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] mm,slub: Do not special case N_NORMAL nodes for
 slab_nodes
To: Harry Yoo <harry.yoo@oracle.com>
Cc: Oscar Salvador <osalvador@suse.de>,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Vlastimil Babka <vbabka@suse.cz>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, linux-cxl@vger.kernel.org
References: <20250408084153.255762-1-osalvador@suse.de>
 <20250408084153.255762-2-osalvador@suse.de>
 <92ff4f7f-90d2-48ab-8f7d-7fc3485276b5@redhat.com> <Z_UwPmyxyu8YNLG_@harry>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <Z_UwPmyxyu8YNLG_@harry>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Yla-D5H09ESohEuo4UhYbhqPhI092Iy-GHlQlMsZnAs_1744122335
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 08.04.25 16:18, Harry Yoo wrote:
> On Tue, Apr 08, 2025 at 12:17:52PM +0200, David Hildenbrand wrote:
>> On 08.04.25 10:41, Oscar Salvador wrote:
>>> Currently, slab_mem_going_going_callback() checks whether the node has
>>> N_NORMAL memory in order to be set in slab_nodes.
>>> While it is true that gettind rid of that enforcing would mean
>>> ending up with movables nodes in slab_nodes, the memory waste that comes
>>> with that is negligible.
>>>
>>> So stop checking for status_change_nid_normal and just use status_change_nid
>>> instead which works for both types of memory.
>>>
>>> Also, once we allocate the kmem_cache_node cache  for the node in
>>> slab_mem_online_callback(), we never deallocate it in
>>> slab_mem_off_callback() when the node goes memoryless, so we can just
>>> get rid of it.
>>>
>>> The only side effect is that we will stop clearing the node from slab_nodes.
>>>
>>
>> Feel free to add a Suggested-by: if you think it applies.
>>
>>
>> Do we have to take care of the N_NORMAL_MEMORY check in kmem_cache_init() ? Likely it
>> would have to be a N_MEMORY check.
>>
>>
>> But, I was wondering if we could get rid of the "slab_nodes" thingy as a first step?
> 
> The following commit says that SLUB has slab_nodes thingy for a reason...
> kmem_cache_node might not be ready yet even when N_NORMAL_MEMORY check
> says it now has normal memory.

node_states_set_node() is called from memory hotplug code after 
MEM_GOING_ONLINE and after online_pages_range().

Pages might be isolated at that point, but node_states_set_node() is set 
only after the memory notifier (MEM_GOING_ONLINE) was triggered.

So I don't immediately see the problem assuming that we never free the 
structures.

But yeah, this is what I raised below: "Not sure if there are any races 
to consider" :)

> 
> @Vlastimil maybe a dumb question but why not check s->node[nid]
> instead of having slab_nodes bitmask?
> 
> commit 7e1fa93deff44677a94dfc323ff629bbf5cf9360
> Author: Vlastimil Babka <vbabka@suse.cz>
> Date:   Wed Feb 24 12:01:12 2021 -0800
> 
>      mm, slab, slub: stop taking memory hotplug lock
>      
>      Since commit 03afc0e25f7f ("slab: get_online_mems for
>      kmem_cache_{create,destroy,shrink}") we are taking memory hotplug lock for
>      SLAB and SLUB when creating, destroying or shrinking a cache.  It is quite
>      a heavy lock and it's best to avoid it if possible, as we had several
>      issues with lockdep complaining about ordering in the past, see e.g.
>      e4f8e513c3d3 ("mm/slub: fix a deadlock in show_slab_objects()").
>      
>      The problem scenario in 03afc0e25f7f (solved by the memory hotplug lock)
>      can be summarized as follows: while there's slab_mutex synchronizing new
>      kmem cache creation and SLUB's MEM_GOING_ONLINE callback
>      slab_mem_going_online_callback(), we may miss creation of kmem_cache_node
>      for the hotplugged node in the new kmem cache, because the hotplug
>      callback doesn't yet see the new cache, and cache creation in
>      init_kmem_cache_nodes() only inits kmem_cache_node for nodes in the
>      N_NORMAL_MEMORY nodemask, which however may not yet include the new node,
>      as that happens only later after the MEM_GOING_ONLINE callback.
>      
>      Instead of using get/put_online_mems(), the problem can be solved by SLUB
>      maintaining its own nodemask of nodes for which it has allocated the
>      per-node kmem_cache_node structures.  This nodemask would generally mirror
>      the N_NORMAL_MEMORY nodemask, but would be updated only in under SLUB's
>      control in its memory hotplug callbacks under the slab_mutex.  This patch
>      adds such nodemask and its handling.
>      
>      Commit 03afc0e25f7f mentiones "issues like [the one above]", but there
>      don't appear to be further issues.  All the paths (shared for SLAB and
>      SLUB) taking the memory hotplug locks are also taking the slab_mutex,
>      except kmem_cache_shrink() where 03afc0e25f7f replaced slab_mutex with
>      get/put_online_mems().
>      
>      We however cannot simply restore slab_mutex in kmem_cache_shrink(), as
>      SLUB can enters the function from a write to sysfs 'shrink' file, thus
>      holding kernfs lock, and in kmem_cache_create() the kernfs lock is nested
>      within slab_mutex.  But on closer inspection we don't actually need to
>      protect kmem_cache_shrink() from hotplug callbacks: While SLUB's
>      __kmem_cache_shrink() does for_each_kmem_cache_node(), missing a new node
>      added in parallel hotplug is not fatal, and parallel hotremove does not
>      free kmem_cache_node's anymore after the previous patch, so use-after free
>      cannot happen.  The per-node shrinking itself is protected by
>      n->list_lock.  Same is true for SLAB, and SLOB is no-op.
>      
>      SLAB also doesn't need the memory hotplug locking, which it only gained by
>      03afc0e25f7f through the shared paths in slab_common.c.  Its memory
>      hotplug callbacks are also protected by slab_mutex against races with
>      these paths.  The problem of SLUB relying on N_NORMAL_MEMORY doesn't apply
>      to SLAB, as its setup_kmem_cache_nodes relies on N_ONLINE, and the new
>      node is already set there during the MEM_GOING_ONLINE callback, so no
>      special care is needed for SLAB.
>      
>      As such, this patch removes all get/put_online_mems() usage by the slab
>      subsystem.
>      
>      Link: https://lkml.kernel.org/r/20210113131634.3671-3-vbabka@suse.cz
>      Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
>      Cc: Christoph Lameter <cl@linux.com>
>      Cc: David Hildenbrand <david@redhat.com>
>      Cc: David Rientjes <rientjes@google.com>
>      Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
>      Cc: Michal Hocko <mhocko@kernel.org>
>      Cc: Pekka Enberg <penberg@kernel.org>
>      Cc: Qian Cai <cai@redhat.com>
>      Cc: Vladimir Davydov <vdavydov.dev@gmail.com>
>      Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
>      Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
> 
>>
>>  From 518a2b83a9c5bd85d74ddabbc36ce5d181a88ed6 Mon Sep 17 00:00:00 2001
>> From: David Hildenbrand <david@redhat.com>
>> Date: Tue, 8 Apr 2025 12:16:13 +0200
>> Subject: [PATCH] tmp
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>   mm/slub.c | 56 ++++---------------------------------------------------
>>   1 file changed, 4 insertions(+), 52 deletions(-)
>>
>> diff --git a/mm/slub.c b/mm/slub.c
>> index b46f87662e71d..afe31149e7f4e 100644
>> --- a/mm/slub.c
>> +++ b/mm/slub.c
>> @@ -445,14 +445,6 @@ static inline struct kmem_cache_node *get_node(struct kmem_cache *s, int node)
>>   	for (__node = 0; __node < nr_node_ids; __node++) \
>>   		 if ((__n = get_node(__s, __node)))
>> -/*
>> - * Tracks for which NUMA nodes we have kmem_cache_nodes allocated.
>> - * Corresponds to node_state[N_NORMAL_MEMORY], but can temporarily
>> - * differ during memory hotplug/hotremove operations.
>> - * Protected by slab_mutex.
>> - */
>> -static nodemask_t slab_nodes;
>> -
>>   #ifndef CONFIG_SLUB_TINY
>>   /*
>>    * Workqueue used for flush_cpu_slab().
>> @@ -3706,10 +3698,9 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   	if (!slab) {
>>   		/*
>>   		 * if the node is not online or has no normal memory, just
>> -		 * ignore the node constraint
>> +		 * ignore the node constraint.
>>   		 */
>> -		if (unlikely(node != NUMA_NO_NODE &&
>> -			     !node_isset(node, slab_nodes)))
>> +		if (unlikely(node != NUMA_NO_NODE && !node_state(node, N_NORMAL_MEMORY)))
>>   			node = NUMA_NO_NODE;
>>   		goto new_slab;
>>   	}
>> @@ -3719,7 +3710,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>>   		 * same as above but node_match() being false already
>>   		 * implies node != NUMA_NO_NODE
>>   		 */
>> -		if (!node_isset(node, slab_nodes)) {
>> +		if (!node_state(node, N_NORMAL_MEMORY)) {
>>   			node = NUMA_NO_NODE;
>>   		} else {
>>   			stat(s, ALLOC_NODE_MISMATCH);
>> @@ -5623,7 +5614,7 @@ static int init_kmem_cache_nodes(struct kmem_cache *s)
>>   {
>>   	int node;
>> -	for_each_node_mask(node, slab_nodes) {
>> +	for_each_node_state(node, N_NORMAL_MEMORY) {
>>   		struct kmem_cache_node *n;
>>   		if (slab_state == DOWN) {
>> @@ -6164,30 +6155,6 @@ static int slab_mem_going_offline_callback(void *arg)
>>   	return 0;
>>   }
>> -static void slab_mem_offline_callback(void *arg)
>> -{
>> -	struct memory_notify *marg = arg;
>> -	int offline_node;
>> -
>> -	offline_node = marg->status_change_nid_normal;
>> -
>> -	/*
>> -	 * If the node still has available memory. we need kmem_cache_node
>> -	 * for it yet.
>> -	 */
>> -	if (offline_node < 0)
>> -		return;
>> -
>> -	mutex_lock(&slab_mutex);
>> -	node_clear(offline_node, slab_nodes);
>> -	/*
>> -	 * We no longer free kmem_cache_node structures here, as it would be
>> -	 * racy with all get_node() users, and infeasible to protect them with
>> -	 * slab_mutex.
>> -	 */
>> -	mutex_unlock(&slab_mutex);
>> -}
>> -
>>   static int slab_mem_going_online_callback(void *arg)
>>   {
>>   	struct kmem_cache_node *n;
>> @@ -6229,11 +6196,6 @@ static int slab_mem_going_online_callback(void *arg)
>>   		init_kmem_cache_node(n);
>>   		s->node[nid] = n;
>>   	}
>> -	/*
>> -	 * Any cache created after this point will also have kmem_cache_node
>> -	 * initialized for the new node.
>> -	 */
>> -	node_set(nid, slab_nodes);
>>   out:
>>   	mutex_unlock(&slab_mutex);
>>   	return ret;
>> @@ -6253,8 +6215,6 @@ static int slab_memory_callback(struct notifier_block *self,
>>   		break;
>>   	case MEM_OFFLINE:
>>   	case MEM_CANCEL_ONLINE:
>> -		slab_mem_offline_callback(arg);
>> -		break;
>>   	case MEM_ONLINE:
>>   	case MEM_CANCEL_OFFLINE:
>>   		break;
>> @@ -6309,7 +6269,6 @@ void __init kmem_cache_init(void)
>>   {
>>   	static __initdata struct kmem_cache boot_kmem_cache,
>>   		boot_kmem_cache_node;
>> -	int node;
>>   	if (debug_guardpage_minorder())
>>   		slub_max_order = 0;
>> @@ -6321,13 +6280,6 @@ void __init kmem_cache_init(void)
>>   	kmem_cache_node = &boot_kmem_cache_node;
>>   	kmem_cache = &boot_kmem_cache;
>> -	/*
>> -	 * Initialize the nodemask for which we will allocate per node
>> -	 * structures. Here we don't need taking slab_mutex yet.
>> -	 */
>> -	for_each_node_state(node, N_NORMAL_MEMORY)
>> -		node_set(node, slab_nodes);
>> -
>>   	create_boot_cache(kmem_cache_node, "kmem_cache_node",
>>   			sizeof(struct kmem_cache_node),
>>   			SLAB_HWCACHE_ALIGN | SLAB_NO_OBJ_EXT, 0, 0);
>> -- 
>> 2.48.1
>>
>>
>> Not sure if there are any races to consider ... just an idea.
>>
>> -- 
>> Cheers,
>>
>> David / dhildenb
>>
> 


-- 
Cheers,

David / dhildenb

