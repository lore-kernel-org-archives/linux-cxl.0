Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84A09138C
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 09:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717493865; cv=none; b=WcSUPcu3X44yGaIDOAjQjNnvTGMYViPEXx3qqQTSOprP1P+z11jlhbx3+ZkfsVa+7vizSWK781oNsBpbMjDEDoQ5BayhmsjEXr5r8X+CVYrbCxIaIdURoKOs0jMq7gPWmaEZ6AQdlM1Mm65LvCzjman3bZu5ATcrLeT7nnBfuXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717493865; c=relaxed/simple;
	bh=GZWZkDa/GqVCvLUAbA3883f1mOynjynYFD8Gb/uzg9c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VjCuARBqiK7KSPlEBbgByZqBANB5VzaOjQrcuRNDO+s0Lt/sn4RntBUEUZdYOr/K1LX3kdijwI7CE12yv1qhEEU0lrx4D4h0obQmpNyAI3Y5Ejtwi/VHbqt9viMNz/mp9CJbju2731G8lEudZ4/WRsYagF0tg7d8Xiq0FQ2Ae54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T1yHPr2/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T1yHPr2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CFFC2BBFC;
	Tue,  4 Jun 2024 09:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717493864;
	bh=GZWZkDa/GqVCvLUAbA3883f1mOynjynYFD8Gb/uzg9c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T1yHPr2/NgB8WY5+bqkwHW+C5jm6kUuG089/KVTvx3aLRP491lusQCWZVhCp6vMEJ
	 rpINvL2Rliqb0jux5m9juz1jpCBdSMjxDxCxSp+kAszP692ozbY04Rko2TtCcwwBtI
	 mtOGIE9cCcpT1bpQrHDIeZnP1DTQKLgPfqRmmp193B0PExaloCokhP1mBiB3ViHI0U
	 eL3PcwOsib/JrcAVTi1IltlIoq1xBn3F1zo/dilv5+popN83USz4V63xvwpQolVWEu
	 3g65wJRHwTN9oitHGJYJ1TECqn3GEG98sRTbrTV7vePvFuA/bjRqN+qHQfUwsloiDg
	 ft1BTdH6gcfUg==
Date: Tue, 4 Jun 2024 12:35:50 +0300
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
Message-ID: <Zl7f9gpdg99keirF@kernel.org>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
 <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
 <Zl13aA2ihYsLPcL6@kernel.org>
 <92ea53c6-a93b-4ab8-8aec-7f88300576eb@redhat.com>
 <Zl2eNQF7S9zlUFne@kernel.org>
 <da88fa70-203e-49e6-bf4d-22cd161ef8d1@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <da88fa70-203e-49e6-bf4d-22cd161ef8d1@redhat.com>

On Mon, Jun 03, 2024 at 10:53:03PM +0200, David Hildenbrand wrote:
> On 03.06.24 12:43, Mike Rapoport wrote:
> > On Mon, Jun 03, 2024 at 11:14:00AM +0200, David Hildenbrand wrote:
> > > On 03.06.24 09:57, Mike Rapoport wrote:
> > > > On Fri, May 31, 2024 at 09:49:32AM +0200, David Hildenbrand wrote:
> > > > > On 29.05.24 19:12, Jonathan Cameron wrote:
> > > > > > I'm not sure what this is balancing, but it if is necessary then the reserved
> > > > > > memblock approach can't be used to stash NUMA node assignments as after the
> > > > > > first add / remove cycle the entry is dropped so not available if memory is
> > > > > > re-added at the same HPA.
> > > > > > 
> > > > > > This patch is here to hopefully spur comments on what this is there for!
> > > > > > 
> > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > > > > ---
> > > > > >     mm/memory_hotplug.c | 2 +-
> > > > > >     1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> > > > > > index 431b1f6753c0..3d8dd4749dfc 100644
> > > > > > --- a/mm/memory_hotplug.c
> > > > > > +++ b/mm/memory_hotplug.c
> > > > > > @@ -2284,7 +2284,7 @@ static int __ref try_remove_memory(u64 start, u64 size)
> > > > > >     	}
> > > > > >     	if (IS_ENABLED(CONFIG_ARCH_KEEP_MEMBLOCK)) {
> > > > > > -		memblock_phys_free(start, size);
> > > > > > +		//		memblock_phys_free(start, size);
> > > > > >     		memblock_remove(start, size);
> > > > > >     	}
> > > > > 
> > > > > memblock_phys_free() works on memblock.reserved, memblock_remove() works  on
> > > > > memblock.memory.
> > > > > 
> > > > > If you take a look at the doc at the top of memblock.c:
> > > > > 
> > > > > memblock.memory: physical memory available to the system
> > > > > memblock.reserved: regions that were allocated [during boot]
> > > > > 
> > > > > 
> > > > > memblock.memory is supposed to be a superset of memblock.reserved. Your
> > > > 
> > > > No it's not.
> > > > memblock.reserved is more of "if there is memory, don't touch it".
> > > 
> > > Then we should certainly clarify that in the comments! :P
> > 
> > You are welcome to send a patch :-P
> 
> I'll try once I understood what changed ever since you documented that in
> 2018 -- or if we missed that detail back then already.
 
> > > But for the memory hotunplug case, that's most likely why that code was
> > > added. And it only deals with ordinary system RAM, not weird reservations
> > > you describe below.
> > 
> > The commit that added memblock_free() at the first place (f9126ab9241f
> > ("memory-hotplug: fix wrong edge when hot add a new node")) does not really
> > describe why that was required :(
> > 
> > But at a quick glance it looks completely spurious.
> 
> There are more details [1] but I also did not figure out why the
> memblock_free() was really required to resolve that issue.
> 
> [1] https://marc.info/?l=linux-kernel&m=142961156129456&w=2
 
The tinkering with memblock there and in f9126ab9241f seem bogus in the
context of memory hotplug on x86.

I believe that dropping that memblock_phys_free() is right thing to do
regardless of this series. There's no corresponding memblock_alloc() and it
was added as part of a fix for hotunplug on x86 that anyway had memblock
discarded at that point.

> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
