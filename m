Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33F5196C7B
	for <linux-cxl@vger.kernel.org>; Thu,  6 Jun 2024 15:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717688798; cv=none; b=coU3bT0cz80wmAiwmgw94qObafwRlhn6Oi81i0zZxn1Yqi2yho0wwql+fupTPYMHajyHZXtBztvjskyqmqJ7E7GBAFjI5NW3VAYWVq58mjqNb4P1v7/jlh067uGSWF2j/nHC1Pk+D8EPyQby+COafQqfoXvM2AkgnpVDnsfzY9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717688798; c=relaxed/simple;
	bh=tdUd+sQ+AtIbL6VgvDooNlTuDamPXaS/f7IM4yBS8cs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/U3jW/92ibV/NXFyQvdVWeex/gwAZ6nVA2tV97QdltUtgGsMVqWdx+969VAYcWBaX6bKc4DiBrNYE58FdAyKOwy2scoiK2Zct2xsCPVA1cEFg8X86igAI+lEN5AO0FkCc1Ggkj6aQFILQJLOhY36lDmTJ95i4RXOCRnred5ZWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rz9rd/m3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rz9rd/m3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B04C32782;
	Thu,  6 Jun 2024 15:46:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717688798;
	bh=tdUd+sQ+AtIbL6VgvDooNlTuDamPXaS/f7IM4yBS8cs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rz9rd/m3A83EsyFNY4S7Uz5IqVPDGC/S90AhVZWkdDgQjz7N4ZWrE17BWcYerPQZe
	 oXrrRIOk0m8KTrOjil4uKjiwnnJ0SJxpysNpZ+UYPxiebkiVYOo4z3yq4YMPTQ9Asi
	 4Hl4nC+nJUJKL+6GffOKm4PYn877cyf4dcv9Y1gbFFbgROffo0f5pTMIaziPQoWDZc
	 zVWI+IbWV317z4FOIprj3r7BWzK7GBxo1nXtLhq5wV+GoPT8RcyhDHfzKRQDeZOOUe
	 bxf/+Z/ySSygIKBLyU2QJ5slYh9ntF3t6nUVga2duJjn+IWDvWVP5rPAD+7UWNeNct
	 74a3zVqbtLA8A==
Date: Thu, 6 Jun 2024 18:44:34 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Sudeep Holla <sudeep.holla@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Will Deacon <will@kernel.org>, Jia He <justin.he@arm.com>,
	Mike Rapoport <rppt@linux.ibm.com>, linuxarm@huawei.com,
	catalin.marinas@arm.com, Anshuman.Khandual@arm.com,
	Yuquan Wang <wangyuquan1236@phytium.com.cn>,
	Oscar Salvador <osalvador@suse.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	James Morse <james.morse@arm.com>
Subject: Re: [RFC PATCH 8/8] HACK: mm: memory_hotplug: Drop
 memblock_phys_free() call in try_remove_memory()
Message-ID: <ZmHZYkzvyg_h2TRV@kernel.org>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
 <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
 <20240531104848.00006a95@Huawei.com>
 <4f734ec7-6277-4f5e-b291-6186f1eb5ecd@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f734ec7-6277-4f5e-b291-6186f1eb5ecd@redhat.com>

On Fri, May 31, 2024 at 11:55:08AM +0200, David Hildenbrand wrote:
> On 31.05.24 11:48, Jonathan Cameron wrote:
> > On Fri, 31 May 2024 09:49:32 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> > 
> > > On 29.05.24 19:12, Jonathan Cameron wrote:
> > > > I'm not sure what this is balancing, but it if is necessary then the reserved
> > > > memblock approach can't be used to stash NUMA node assignments as after the
> > > > first add / remove cycle the entry is dropped so not available if memory is
> > > > re-added at the same HPA.
> > > > 
> > > > This patch is here to hopefully spur comments on what this is there for!
> > > > 
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > ---
> > > >    mm/memory_hotplug.c | 2 +-
> > > >    1 file changed, 1 insertion(+), 1 deletion(-)
> > > > 
> > > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > > index 431b1f6753c0..3d8dd4749dfc 100644
> > > > --- a/mm/memory_hotplug.c
> > > > +++ b/mm/memory_hotplug.c
> > > > @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
> > > >    	}
> > > >    	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> > > > -		memblock_phys_free(start, size);
> > > > +		//		memblock_phys_free(start, size);
> > > >    		memblock_remove(start, size);
> > > >    	}
> > > 
> > > memblock_phys_free() works on memblock.reserved, memblock_remove() works
> > >    on memblock.memory.
> > > 
> > > If you take a look at the doc at the top of memblock.c:
> > > 
> > > memblock.memory: physical memory available to the system
> > > memblock.reserved: regions that were allocated [during boot]
> > > 
> > > 
> > > memblock.memory is supposed to be a superset of memblock.reserved. Your
> > > "hack" here indicates that you somehow would be relying on the opposite
> > > being true, which indicates that you are doing the wrong thing.
> > > 
> > > 
> > > memblock_remove() indeed balances against memblock_add_node() for
> > > hotplugged memory [add_memory_resource()]. There seem to a case where we
> > > would succeed in hotunplugging memory that was part of "memblock.reserved".
> > > 
> > > But how could that happen? I think the following way:
> > > 
> > > Once the buddy is up and running, memory allocated during early boot is
> > > not freed back to memblock, but usually we simply go via something like
> > > free_reserved_page(), not memblock_free() [because the buddy took over].
> > > So one could end up unplugging memory that still resides in
> > > memblock.reserved set.
> > > 
> > > So with memblock_phys_free(), we are enforcing the invariant that
> > > memblock.memory is a superset of memblock.reserved.
> > > 
> > > Likely, arm64 should store that node assignment elsewhere from where it
> > > can be queried. Or it should be using something like
> > > CONFIG_HAVE_MEMBLOCK_PHYS_MAP for these static windows.
> > > 
> > 
> > Hi David,
> > 
> > Thanks for the explanation and pointers.  I'd rather avoid inventing a parallel
> > infrastructure for this (like x86 has for other reasons, but which is also used
> > for this purpose).
> 
> Yes, although memblock feels a bit wrong, because it is targeted at managing
> actual present memory, not properties about memory that could become present
> later.

Right now memblock.reserved can have ranges that are not actually present,
but I still have doubts about using it to contain memory ranges that could
be hotplugged and I'm more leaning against it.

In general memblock as an infrastructure for dealing with memory ranges and
their properties seems to be a good fit, so either memblock.reserved or a
new memblock_type can be used to implement phys_to_target_node().

memblock.reserved maybe less suitable than a new data structure because
unlike x86::numa_reserved_meminfo it does manage already present memory for
the most part while x86::numa_reserved_meminfo contains regions that do not
overlap with RAM.
 
Now before we continue to bikeshed about the name for the new data
structure, how about this crazy idea to merge parts of arch/x86/numa.c
dealing with 'struct numa_meminfo' to arch_numa.c and then remove some of
the redundancy, e.g by implementing memory_add_physaddr_to_nid() with
memblock.memory instead of numa_meminfo.

It's an involved project indeed, but it has advantage of shared
infrastructure for NUMA initialization of ACPI systems.
AFAIU, x86 has a parallel infrastructure because they were first, but I
don't see a fundamental reason why it has to remain that way.

There also were several attempts to implement fakenuma on arm64 or riscv
(sorry, can't find lore links right now), and with numa_meminfo in
arch_numa.c we get it almost for free.

> >  From a quick look CONFIG_HAVE_MEMBLOCK_PHYS_MAP is documented in a fashion that
> > makes me think it's not directly appropriate (this isn't actual physical memory
> > available during boot) but the general approach of just adding another memblock
> > collection seems like it will work.
> 
> Yes. As an alternative, modify the description of
> CONFIG_HAVE_MEMBLOCK_PHYS_MAP.
 
I wouldn't want to touch physmem, except maybe moving it entirely to
arch/s390 and leaving it there.
 
> > Hardest problem might be naming it.  physmem_possible perhaps?
> > Fill that with anything found in SRAT or CEDT should work for ACPI, but I'm not
> > sure on whether we can fill it when neither of those is present.  Maybe we just
> > don't bother as for today's usecase CEDT needs to be present.
> 
> You likely only want something for these special windows, with these special
> semantics. That makes it hard.
> 
> "physmem_possible" is a bit too generic for my taste, promising semantics
> that might not hold true (we don't want all hotpluggable areas to show up
> there).
> 
> > 
> > Maybe physmem_known_possible is the way to go. I'll give this approach a spin
> > and see how it goes.
> 
> Goes into a better direction, or really "physmem_fixed_windows". Because
> also "physmem_known_possible" as a wrong smell to it.

physmem_potential? ;-)
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
