Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408D019F
	for <linux-cxl@vger.kernel.org>; Mon,  3 Jun 2024 10:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717411499; cv=none; b=CHK0cjVP2rI9JsAi8/YTh/Ekm0EfnjqSyqfgCezWGDLTqfaMNwL6SCrR+gyKrasj2mSszqbQNILWADhCTRUancItTyxxGJqpHMb+6UqLDJMvluFEu4R5TslR/f4No7M8pmdFX730k3+0YWMJTu4uhaiVip3Z4YCDkNrg5spYg84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717411499; c=relaxed/simple;
	bh=EHLo1UVVyz3p/w37rlTPUbrjybRxQnqVItAP1nJHDZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVNXWVUGBNy+IA0gK9Xo1aklGzcdY0Dv6IOG+usbm7503QD3Cde7F0KwNG1HGvuA8r7HcxC6zXISzKsdQ1tmzO/Vgk3b6wZ5yvAnqY+O4y/zs5YJ5Evt4f7pfaWTofmlDrjKmJfqC2+WmuLPJpDhnRb6DoulOzC2UTUIO9UGJ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qZ4Qu3My; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qZ4Qu3My"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B009C2BD10;
	Mon,  3 Jun 2024 10:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717411498;
	bh=EHLo1UVVyz3p/w37rlTPUbrjybRxQnqVItAP1nJHDZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qZ4Qu3My9+JrHqEu2/3N3C5OZTg4+btjgXxNkEF8QhqXpso/FTlgnfy0QR+egq+7g
	 2ZH7U5zPe5gMJ3J4r0i18F8ZpMcFvhNq3udMkJUDPgLrFxSk8NtW8BVwBEedQ7ndj/
	 8vn3vBywwa6caiqzJag6hutf9frN/AL+P0cENIbb6fnoH4OipBo8k+qCFYREjxoaf5
	 /gQFPHrkAQUob3BrZ0tm59j3mpK0GOmQDXTnQAQHtoYFxCmPv1aoWErcKfrWmDTtBB
	 53svt+j2uLGaz99En/F4EqIeDFkDe6BvDiepqCMvvR+ntamp8V2W1JhyWRhrqCUyYw
	 yxeWhWq8mQsSg==
Date: Mon, 3 Jun 2024 13:43:01 +0300
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
Message-ID: <Zl2eNQF7S9zlUFne@kernel.org>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
 <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
 <Zl13aA2ihYsLPcL6@kernel.org>
 <92ea53c6-a93b-4ab8-8aec-7f88300576eb@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92ea53c6-a93b-4ab8-8aec-7f88300576eb@redhat.com>

On Mon, Jun 03, 2024 at 11:14:00AM +0200, David Hildenbrand wrote:
> On 03.06.24 09:57, Mike Rapoport wrote:
> > On Fri, May 31, 2024 at 09:49:32AM +0200, David Hildenbrand wrote:
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
> > > memblock_phys_free() works on memblock.reserved, memblock_remove() works  on
> > > memblock.memory.
> > > 
> > > If you take a look at the doc at the top of memblock.c:
> > > 
> > > memblock.memory: physical memory available to the system
> > > memblock.reserved: regions that were allocated [during boot]
> > > 
> > > 
> > > memblock.memory is supposed to be a superset of memblock.reserved. Your
> > 
> > No it's not.
> > memblock.reserved is more of "if there is memory, don't touch it".
> 
> Then we should certainly clarify that in the comments! :P

You are welcome to send a patch :-P
 
> But for the memory hotunplug case, that's most likely why that code was
> added. And it only deals with ordinary system RAM, not weird reservations
> you describe below.

The commit that added memblock_free() at the first place (f9126ab9241f
("memory-hotplug: fix wrong edge when hot add a new node")) does not really
describe why that was required :(

But at a quick glance it looks completely spurious.
 
> > Some regions in memblock.reserved are boot time allocations and they are indeed a
> > subset of memblock.memory, but some are reservations done by firmware (e.g.
> > reserved memory in DT) that just might not have a corresponding regions in
> > memblock.memory. It can happen for example, when the same firmware runs on
> > devices with different memory configuration, but still wants to preserve
> > some physical addresses.
> 
> Could this happen with a good old BIOS as well? Just curious.
 
Yes. E.g. for E820_TYPE_SOFT_RESERVED.
 
> > > "hack" here indicates that you somehow would be relying on the opposite
> > > being true, which indicates that you are doing the wrong thing.
> > I'm not sure about that, I still have to digest the patches :)
> 
> In any case, using "reserved" to store persistent data across plug/unplug
> sounds wrong; but maybe I'm wrong :)
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
