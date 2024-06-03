Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF615025E
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 07:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717401567; cv=none; b=e+sjg2ZeASGvl9EtEqgteyVmI2ZV2Y4uGbHHHdfrSUpwFIjvVt3/WgyJYZZJrE23dPzfBM5KwKE5boBV1aW4+vUFqt2RBrkJEBmEa+0v9iMfxtXAhWz+T6XDFTaif3OichJNXQwMInShGva5BSgj3j1DfMWW7k4lLAra37grTAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717401567; c=relaxed/simple;
	bh=0VegF9XMtUv3jnXb7b8g6QP9TKzjqBXKAtuGcGkfzSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MGkQNZVgoNlJ33cgJkROSShKSpwjdMOvkMjubaNyPSnylfYHuSfXl4xg8BjtZRmrrZ0czQcAZ6yuzoBtYx6RrdUb+5B+4UjDQOOMzYYYq9hLr1sPsPh4HvVKrU9t3pUI1N1Ahb2fpMMMURs/4KT/o9UzqPG85m43xR7GjWBj3z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P417+Zpo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P417+Zpo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6200AC2BD10;
	Mon,  3 Jun 2024 07:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717401565;
	bh=0VegF9XMtUv3jnXb7b8g6QP9TKzjqBXKAtuGcGkfzSw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=P417+ZpojmienU72GF2y2X1GT/j9dsT9IwUmXNWyPmAhYHJ+DUO5beFRRa+cw9t0M
	 xkm6RWvLHW3WqRYpS6YKFL0w/lPt2+9zpzpa6O19cWbB1GG3tjMZsXHXEVPE5IU69e
	 Ee20ljgRsmEK0lUS1B4lT/nf6z5P0YHlViluk7furLOEY6veclDnjNwfHoNEID8S74
	 sNGuDahB7hQjY2qzrkqa+dWhkE1r3vwDRPOG6HIpPqzSOyc1vVgjPp0o9B1hanlFJp
	 9p/IHg4ONG0DSpezYLDx930uXVrXe+Rlw5kHOAj1MApnomBt9rJPfXb7SbSKCq8VbP
	 7GeakgRT+ZZbQ==
Date: Mon, 3 Jun 2024 10:57:28 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
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
Message-ID: <Zl13aA2ihYsLPcL6@kernel.org>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
 <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>

On Fri, May 31, 2024 at 09:49:32AM +0200, David Hildenbrand wrote:
> On 29.05.24 19:12, Jonathan Cameron wrote:
> > I'm not sure what this is balancing, but it if is necessary then the reserved
> > memblock approach can't be used to stash NUMA node assignments as after the
> > first add / remove cycle the entry is dropped so not available if memory is
> > re-added at the same HPA.
> > 
> > This patch is here to hopefully spur comments on what this is there for!
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> >   mm/memory_hotplug.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > index 431b1f6753c0..3d8dd4749dfc 100644
> > --- a/mm/memory_hotplug.c
> > +++ b/mm/memory_hotplug.c
> > @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
> >   	}
> >   	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> > -		memblock_phys_free(start, size);
> > +		//		memblock_phys_free(start, size);
> >   		memblock_remove(start, size);
> >   	}
> 
> memblock_phys_free() works on memblock.reserved, memblock_remove() works  on
> memblock.memory.
> 
> If you take a look at the doc at the top of memblock.c:
> 
> memblock.memory: physical memory available to the system
> memblock.reserved: regions that were allocated [during boot]
> 
> 
> memblock.memory is supposed to be a superset of memblock.reserved. Your

No it's not.
memblock.reserved is more of "if there is memory, don't touch it".
Some regions in memblock.reserved are boot time allocations and they are indeed a
subset of memblock.memory, but some are reservations done by firmware (e.g.
reserved memory in DT) that just might not have a corresponding regions in
memblock.memory. It can happen for example, when the same firmware runs on
devices with different memory configuration, but still wants to preserve
some physical addresses.

> "hack" here indicates that you somehow would be relying on the opposite
> being true, which indicates that you are doing the wrong thing.
 
I'm not sure about that, I still have to digest the patches :)
 
> memblock_remove() indeed balances against memblock_add_node() for hotplugged
> memory [add_memory_resource()]. There seem to a case where we would succeed
> in hotunplugging memory that was part of "memblock.reserved".
> 
> But how could that happen? I think the following way:
> 
> Once the buddy is up and running, memory allocated during early boot is not
> freed back to memblock, but usually we simply go via something like
> free_reserved_page(), not memblock_free() [because the buddy took over]. So
> one could end up unplugging memory that still resides in memblock.reserved
> set.
> 
> So with memblock_phys_free(), we are enforcing the invariant that
> memblock.memory is a superset of memblock.reserved.
> 
> Likely, arm64 should store that node assignment elsewhere from where it can
> be queried. Or it should be using something like
> CONFIG_HAVE_MEMBLOCK_PHYS_MAP for these static windows.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
