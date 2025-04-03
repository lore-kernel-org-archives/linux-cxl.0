Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FFFF35942;
	Thu,  3 Apr 2025 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743684259; cv=none; b=DpxutWhnxtqeJx4UN7lOffPXjZ2T9GhJ0Ib187vMAFOz1KgCbOLV5P8Qt6hokXIZbJ4m2S1M6aBxTWfxfsLpZqmEMYgTWAJkyfu6xzyE/YbHFvaUdWg8s70/el+rWKMXZaY6EsLi8UQHk7g8/2KTWa37+xGwi6VirGAufm6K1D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743684259; c=relaxed/simple;
	bh=dr+SFjooIEDN+L1BBO81AAg0EZwIrLQpIuSx3JNdTQI=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TQ9YvfozUzBYBlWGNdFkoQO8tzyJIvULGb8LNADqHM53UigJphlI/LoSp7Q1Z3gkcTDP1q3A6L3Plfi22Dy+sVyD6zfLC8C1ig9Mb9LAG/Zmd7LqgCw+L2lGI5ZErCi0zwRS1GhNAl7yP5LLRiYG0Yt4ogvI93iLp7Yk/I5FwBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZT1YD30wTz6L75h;
	Thu,  3 Apr 2025 20:40:32 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id B4266140557;
	Thu,  3 Apr 2025 20:44:12 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 3 Apr
 2025 14:44:12 +0200
Date: Thu, 3 Apr 2025 13:44:10 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Oscar Salvador <osalvador@suse.de>
CC: Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand
	<david@redhat.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	<mkoutny@suse.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm,memory_hotplug: Implement numa node notifier
Message-ID: <20250403134410.000006c7@huawei.com>
In-Reply-To: <20250401092716.537512-2-osalvador@suse.de>
References: <20250401092716.537512-1-osalvador@suse.de>
	<20250401092716.537512-2-osalvador@suse.de>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue,  1 Apr 2025 11:27:15 +0200
Oscar Salvador <osalvador@suse.de> wrote:

> There are at least four consumers of hotplug_memory_notifier that what they
> really are interested in is whether any numa node changed its state, e.g: going
> from being memory aware to becoming memoryless.

Cover letter says 5.  Whilst that's at least 4, maybe update this if you do
a v2 to say at least 5 :)

> 
> Implement a specific notifier for numa nodes when their state gets changed,
> and have those consumers that only care about numa node state changes use it.
> 
> Signed-off-by: Oscar Salvador <osalvador@suse.de>

A couple of trivial things below.  To me this looks fine otherwise.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> +#define hotplug_node_notifier(fn, pri) ({		\
> +	static __meminitdata struct notifier_block fn##_node_nb =\
> +		{ .notifier_call = fn, .priority = pri };\
> +	register_node_notifier(&fn##_node_nb);			\
> +})

Trivial but spacing before \ seems rather random. Maybe I'm missing
how it is consistent.

> +
>  #ifdef CONFIG_NUMA
>  void memory_block_add_nid(struct memory_block *mem, int nid,
>  			  enum meminit_context context);

> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 75401866fb76..4bb9ff282ec9 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c


> @@ -2106,27 +2143,32 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
>  	 * Make sure to mark the node as memory-less before rebuilding the zone
>  	 * list. Otherwise this node would still appear in the fallback lists.
>  	 */
> -	node_states_clear_node(node, &arg);
> +	node_states_clear_node(node, &node_arg);
>  	if (!populated_zone(zone)) {
>  		zone_pcp_reset(zone);
>  		build_all_zonelists(NULL);
>  	}
>  
> -	if (arg.status_change_nid >= 0) {
> +	if (node_arg.status_change_nid >= 0) {
>  		kcompactd_stop(node);
>  		kswapd_stop(node);
> +		/*Node went memoryless. Notifiy interested consumers */

Trivial: missing space after *

> +		node_notify(NODE_BECAME_MEMORYLESS, &node_arg);
>  	}
>  
>  	writeback_set_ratelimit();
>  
> -	memory_notify(MEM_OFFLINE, &arg);
> +	memory_notify(MEM_OFFLINE, &mem_arg);
>  	remove_pfn_range_from_zone(zone, start_pfn, nr_pages);
>  	return 0;
>  
>  failed_removal_isolated:
>  	/* pushback to free area */
>  	undo_isolate_page_range(start_pfn, end_pfn, MIGRATE_MOVABLE);
> -	memory_notify(MEM_CANCEL_OFFLINE, &arg);
> +	if (cancel_node_notifier_on_err)
> +		node_notify(NODE_CANCEL_MEMORYLESS, &node_arg);
> +	if (cancel_mem_notifier_on_err)
> +		memory_notify(MEM_CANCEL_OFFLINE, &mem_arg);
>  failed_removal_pcplists_disabled:
>  	lru_cache_enable();
>  	zone_pcp_enable(zone);


