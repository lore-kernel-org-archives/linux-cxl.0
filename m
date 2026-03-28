Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131141B87C0
	for <linux-cxl@vger.kernel.org>; Sat, 28 Mar 2026 03:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774669682; cv=none; b=U1HxGklXq18Ql0TrThD0KvHiOHISsPTztN7pCDGbP7/kp2QfQW8Xmgokq7ZLnPj5zqtx2v0s2UNYcMfu7ERUdS/YVWJX3ijs1wJBm9VVEPj3BlV4Kz7igDoIwOWRR7zCpJKiZUezrPMIbqa9hqeWbNZWFIyPF9c7GfYVkjuQxGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774669682; c=relaxed/simple;
	bh=2fuP/HMjmYlPMKl4Ye+ByjXav18w5RwbInQZPFygDI4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/m9uakoWdTOOazfAtRdo1gzOyitrBjtS2QQIJ42XXVX/nD27FzQQR9CrPBlGuCW5LhZeikqg7EnZQr1ILVUxAtdn8wU5zwEJEouuxGnWfqe0Xqf51azcCx8uL0VepsHrEy+hQuwBnFF9mYCwtAwTgha4ZD2Lvxqd9Yqk7I7z3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YJ+i6hrx; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YJ+i6hrx"
Date: Sat, 28 Mar 2026 11:47:40 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774669668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=zZvGpnGl9Qm/IlUyc9WaFTWtqjjf9i8+RUwv6uPlfyM=;
	b=YJ+i6hrxxPgwFZtF1N8rPjKOMrodTYZ4n5Wye4H+upasIGdThsQdgCCHsHD3OU24eDZLOZ
	PWphnvlDVvdeW3ad/lKvkO3BJB7tuSnw3KPP14G4MyWHtVpVLwmThfP2O6QrNv70Fm0X3L
	qxj/y89ZXhpcQLqJlusF6EVEWClWhaA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: david@kernel.org, osalvador@suse.de, akpm@linux-foundation.org, 
	vbabka@suse.cz, harry.yoo@oracle.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <ayiordz2mnetih63hjtnbmnx4dllekhpo527wgl7ausk3suwkc@erjqaeuydcny>
References: <20260327124412.469833-1-hao.li@linux.dev>
 <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260327143823.3063541-1-joshua.hahnjy@gmail.com>
X-Migadu-Flow: FLOW_OUT

On Fri, Mar 27, 2026 at 07:38:23AM -0700, Joshua Hahn wrote:
> On Fri, 27 Mar 2026 20:42:47 +0800 Hao Li <hao.li@linux.dev> wrote:
> 
> Hello Hao,
> 
> I hope you are doing well, thank you for the patch!

Hi Joshua,

Thanks! Hope you are too.

> 
> > N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> > hotplug currently only updates N_MEMORY. As a result, a node that gains
> > normal memory via hotplug can remain invisible to users iterating over
> > N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> > incorrectly marked as such.
> 
> The second part feels more important

I'm guessing you mean the first part.

> than the second part, doing a quick
> glance through the code I can see a few N_NORMAL_MEMORY iterators that
> are in some hot paths like shrink_memcg. Iterating over nodes that don't
> contain any NORMAL memory seems like an inefficiency rather than a bug
> though. 

Yes, I agree.

> 
> > Restore N_NORMAL_MEMORY maintenance directly in online_pages() and
> > offline_pages(). Set the bit when a node that currently lacks normal
> > memory onlines pages into a zone <= ZONE_NORMAL, and clear it when
> > offlining removes the last present pages from zones <= ZONE_NORMAL.
> > 
> > This restores the intended semantics without bringing back the old
> > status_change_nid_normal notifier plumbing which was removed in
> > 8d2882a8edb8.
> > 
> > Current users that benefit include list_lru, zswap, nfsd filecache,
> > hugetlb_cgroup, and has_normal_memory sysfs reporting.
> > 
> > Signed-off-by: Hao Li <hao.li@linux.dev>
> > ---
> > 
> > This patch also prepares for a subsequent SLUB change that makes
> > can_free_to_pcs() rely on N_NORMAL_MEMORY to decide whether an object can be
> > freed to the sheaf.
> > 
> > ---
> >  mm/memory_hotplug.c | 22 ++++++++++++++++++++++
> >  1 file changed, 22 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index bc805029da51..5498744aa1f1 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1155,6 +1155,7 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
> >  	int need_zonelists_rebuild = 0;
> >  	unsigned long flags;
> >  	int ret;
> > +	bool need_set_normal_memory = false;
> >  
> >  	/*
> >  	 * {on,off}lining is constrained to full memory sections (or more
> > @@ -1180,6 +1181,9 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
> >  		if (ret)
> >  			goto failed_addition;
> >  	}
> > +	/* Adding normal memory to the node for the first time */
> > +	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> > +		need_set_normal_memory = true;
> >  
> >  	ret = memory_notify(MEM_GOING_ONLINE, &mem_arg);
> >  	ret = notifier_to_errno(ret);
> > @@ -1209,6 +1213,8 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
> >  
> >  	if (node_arg.nid >= 0)
> >  		node_set_state(nid, N_MEMORY);
> > +	if (need_set_normal_memory)
> > +		node_set_state(nid, N_NORMAL_MEMORY);
> >  	if (need_zonelists_rebuild)
> >  		build_all_zonelists(NULL);
> 
> Do we need the flag here? As far as I can tell, we can just skip this and just
> directly check whether this is the first normal memory we are adding to the
> node here and set the bit. Then we can remove the flag and the extraneous
> check. We won't do any notifier work so I think it should be OK.

Exactly, this is a good point!

> 
> > @@ -1908,6 +1914,9 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >  	unsigned long flags;
> >  	char *reason;
> >  	int ret;
> > +	bool need_clear_normal_memory = false;
> > +	unsigned long node_normal_pages = 0;
> > +	enum zone_type zt;
> >  
> >  	/*
> >  	 * {on,off}lining is constrained to full memory sections (or more
> > @@ -1977,6 +1986,13 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >  			goto failed_removal_isolated;
> >  		}
> >  	}
> > +	/*
> > +	 * Check whether this operation removes the node's last normal memory.
> > +	 */
> > +	for (zt = 0; zt <= ZONE_NORMAL; zt++)
> > +		node_normal_pages += pgdat->node_zones[zt].present_pages;
> > +	if (nr_pages >= node_normal_pages && zone_idx(zone) <= ZONE_NORMAL)
> > +		need_clear_normal_memory = true;
> >  
> >  	ret = memory_notify(MEM_GOING_OFFLINE, &mem_arg);
> >  	ret = notifier_to_errno(ret);
> > @@ -2055,6 +2071,12 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >  	/* reinitialise watermarks and update pcp limits */
> >  	init_per_zone_wmark_min();
> 
> Same here, couldn't we just iterate through the paegs here and accumulate
> node_normal_pages and clear the memory here? We can get rid of the bool and
> also keep node_normal_pages defined inside an if (zone_idx(zone) <= ZONE_NORMAL)
> check as well. 

Yes, the same to online_pages(), thanks for this idea.

> 
> > +	/*
> > +	 * Clear N_NORMAL_MEMORY first to avoid the transient state
> > +	 * "!N_MEMORY && N_NORMAL_MEMORY".
> > +	 */
> > +	if (need_clear_normal_memory)
> > +		node_clear_state(node, N_NORMAL_MEMORY);
> >  	/*
> >  	 * Make sure to mark the node as memory-less before rebuilding the zone
> >  	 * list. Otherwise this node would still appear in the fallback lists.
> > -- 
> > 2.50.1
> > 
> > 
> 
> Thank you for the patch. The rest looks good to me! Have a great day : -)
> Joshua

Thanks for the review!

-- 
Thanks,
Hao
