Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC792C17A0
	for <linux-cxl@vger.kernel.org>; Tue, 31 Mar 2026 04:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774930476; cv=none; b=du4BPsHUC5V8UueL1TEiBZM3o0eSXzw/yIFvSLHLM3BminarZ7whv3vQUuU3ENZTJB976MeqkJ1s/5U0mA5vMBMJ7w+p9H/xcu8Ovy+7UsLqLYZtGYQnRgYLAnvAOx1PmgtOqjmI4ATIpwISQNqvrxrkzim0xgUlUCP4tQWhimI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774930476; c=relaxed/simple;
	bh=mpRpgWJup5x2ZOxjfOaQCawA4BP1QokeWgH703DTax4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OAfCG8DCChp5PhVpnhymiJeaIi5X2vEH4VvY+zzoWGENW3kZuNTsD4pAOm06QR+ZO+YnvPhYZs0/yiFe+MADorUrz/Ch/Ypx+CNL99d8OkVbVC41KSm+dYy12nkPiYMHQ5F/o+Atgjr+vUncJOg73ItQtlywqMGVBvKJALR8Hyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FcX3e4P7; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FcX3e4P7"
Date: Tue, 31 Mar 2026 12:14:14 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774930462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OuvZGNCpc5ageytlY+oW5uy/i3LviqcbXfIayS0ZEo4=;
	b=FcX3e4P7G90Em1TGT4P7k+9itASOOUWQnxeESkUIj+27i1UH3ormvlgY7HCvuoiRRMBA6l
	lXYcZ3Gf/YkfxFK32SiHdYGDgERj3aVEiKC/C6XwGceTs5kHHDse2G3Z0KgbFVkCXrbgLZ
	DEyKHQH0PKcqCB/B5OkMnpJiJvCgveI=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Hao Li <hao.li@linux.dev>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: osalvador@suse.de, akpm@linux-foundation.org, vbabka@suse.cz, 
	harry.yoo@oracle.com, joshua.hahnjy@gmail.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2] mm/memory_hotplug: maintain N_NORMAL_MEMORY during
 hotplug
Message-ID: <lj2h4mig2za32bi5gnxmeh7gjshd2gwa45zl3xhot4cjsvtwsv@5jjtp2el3yn5>
References: <20260330035941.518186-1-hao.li@linux.dev>
 <5de08585-fd2b-4395-b421-99c7b887aa8f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5de08585-fd2b-4395-b421-99c7b887aa8f@kernel.org>
X-Migadu-Flow: FLOW_OUT

On Mon, Mar 30, 2026 at 04:20:23PM +0200, David Hildenbrand (Arm) wrote:
> On 3/30/26 05:57, Hao Li wrote:
> > N_NORMAL_MEMORY is initialized from zone population at boot, but memory
> > hotplug currently only updates N_MEMORY. As a result, a node that gains
> > normal memory via hotplug can remain invisible to users iterating over
> > N_NORMAL_MEMORY, while a node that loses its last normal memory can stay
> > incorrectly marked as such.
> > 
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
> > Fixes: 8d2882a8edb8 ("mm,memory_hotplug: remove status_change_nid_normal and update documentation")
> 
> Agreed on CCing stable.
> 
> > Signed-off-by: Hao Li <hao.li@linux.dev>
> > ---
> > Changes: simplify the code. (Thanks Joshua and David)
> > ---
> >  mm/memory_hotplug.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index bc805029da51..05a47953ef21 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -1209,6 +1209,13 @@ int online_pages(unsigned long pfn, unsigned long nr_pages,
> >  
> >  	if (node_arg.nid >= 0)
> >  		node_set_state(nid, N_MEMORY);
> > +	/*
> > +	 * Check whether we are adding normal memory to the node for the first
> > +	 * time.
> > +	 */
> > +	if (!node_state(nid, N_NORMAL_MEMORY) && zone_idx(zone) <= ZONE_NORMAL)
> > +		node_set_state(nid, N_NORMAL_MEMORY);
> > +
> >  	if (need_zonelists_rebuild)
> >  		build_all_zonelists(NULL);
> >  
> > @@ -1908,6 +1915,8 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >  	unsigned long flags;
> >  	char *reason;
> >  	int ret;
> > +	unsigned long normal_pages = 0;
> > +	enum zone_type zt;
> >  
> >  	/*
> >  	 * {on,off}lining is constrained to full memory sections (or more
> > @@ -2055,6 +2064,17 @@ int offline_pages(unsigned long start_pfn, unsigned long nr_pages,
> >  	/* reinitialise watermarks and update pcp limits */
> >  	init_per_zone_wmark_min();
> >  
> > +	/*
> > +	 * Check whether this operation removes the last normal memory from
> > +	 * the node. We do this before clearing N_MEMORY to avoid the possible
> > +	 * transient "!N_MEMORY && N_NORMAL_MEMORY" state.
> > +	 */
> > +	if (zone_idx(zone) <= ZONE_NORMAL) {
> > +		for (zt = 0; zt <= ZONE_NORMAL; zt++)
> > +			normal_pages += pgdat->node_zones[zt].present_pages;
> > +		if (!normal_pages)
> > +			node_clear_state(node, N_NORMAL_MEMORY);
> > +	}
> 
> Was wondering whether we could just do an early exit, like:
> 
> 
> for (zt = 0; zt <= ZONE_NORMAL; zt++) {
> 	if (pgdat->node_zones[zt].present_pages)
> 		break;
> }
> if (zt > ZONE_NORMAL)
> 	node_clear_state(node, N_NORMAL_MEMORY);
> 
> But ends up being harder to digest (incl. all variants I tried :) ), so

Thanks for exploring this.
Yeah, this looks like one of those cases where we have to make a bit of a
tradeoff for readability :)

> 
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for the Ack!

-- 
Thanks,
Hao
