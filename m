Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA1E01922FC
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 08:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717574523; cv=none; b=nruUtaKtUxNMXnyNGpVnW29JoKy+Fulk+mTHA9khIpYy5bu/wAWoP6LXovzL4dlb10dL3to7VON91jIk/KrNN/8azcUzd0AsQxd3/JtZuFyTv6yVBakWhxRZCR+KxFP55BQsIx/d09xefUO40QepLagqlQ+1rnHtfNc5SqIX92A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717574523; c=relaxed/simple;
	bh=+tsIBWkMgCF8yjXjlHBxfYtu83pa8wEdvkTA6fDFLpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1AVbGFZLAFUTr3qgaonohRf2Wwnnrn6qiBenNCLbjpoUfMjUb9jDbilT3iddpk9DKFkgA0JkxRFLBXAk7jOwYS9CQEw19UbfMGo8dFvqGiiy1pEP1y1XxpgHbQQRzNgLUMcLC63+57XslCufYIrrWwDeLJYiiMkpjdbkg76muI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5S+1lpc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5S+1lpc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F021C4AF07;
	Wed,  5 Jun 2024 08:01:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717574523;
	bh=+tsIBWkMgCF8yjXjlHBxfYtu83pa8wEdvkTA6fDFLpo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=m5S+1lpcOONYokYZiWVbFO/wpXqXqVTh1KR9MGtlR7VARKjGaul+R66izeyV7nCMh
	 YBuFj0Vszv2OUGP2sBhxHxe+QPzR2C83OrzFDnGBpA81D3wGlAXFTp1u7zoLlw0HWM
	 4ytkGbr+TmxqsTtiVCWFzcV7E8E3mkOUERE6W5Nv31qdIdayCpDECP2BXxv+8oDq5l
	 nlVUDBK88Q04yodNso79PYXIN7mDn6amqfXM8xSrhxcM3SCYKQVPuQMrqFsRr8tKIQ
	 KmMWoGEvkN2oGDVvd8UXKXgT5IbqPqJj8OMpixKmbe1AYhkQBTeqABlnt9JdmQx8bK
	 +WIqYZMxfMmyA==
Date: Wed, 5 Jun 2024 11:00:03 +0300
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
Message-ID: <ZmAbA-kXEfKBKj4-@kernel.org>
References: <20240529171236.32002-1-Jonathan.Cameron@huawei.com>
 <20240529171236.32002-9-Jonathan.Cameron@huawei.com>
 <b8654dcd-68e1-4823-9588-cfa401104741@redhat.com>
 <Zl13aA2ihYsLPcL6@kernel.org>
 <92ea53c6-a93b-4ab8-8aec-7f88300576eb@redhat.com>
 <Zl2eNQF7S9zlUFne@kernel.org>
 <da88fa70-203e-49e6-bf4d-22cd161ef8d1@redhat.com>
 <Zl7f9gpdg99keirF@kernel.org>
 <900bd9b6-a788-4c71-9b43-aff4855ba234@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <900bd9b6-a788-4c71-9b43-aff4855ba234@redhat.com>

On Tue, Jun 04, 2024 at 11:39:27AM +0200, David Hildenbrand wrote:
> On 04.06.24 11:35, Mike Rapoport wrote:
> > On Mon, Jun 03, 2024 at 10:53:03PM +0200, David Hildenbrand wrote:
> > > On 03.06.24 12:43, Mike Rapoport wrote:
> > > > On Mon, Jun 03, 2024 at 11:14:00AM +0200, David Hildenbrand wrote:
> > > 
> > > > The commit that added memblock_free() at the first place (f9126ab9241f
> > > > ("memory-hotplug: fix wrong edge when hot add a new node")) does not really
> > > > describe why that was required :(
> > > > 
> > > > But at a quick glance it looks completely spurious.
> > > 
> > > There are more details [1] but I also did not figure out why the
> > > memblock_free() was really required to resolve that issue.
> > > 
> > > [1] https://marc.info/?l=linux-kernel&m=142961156129456&w=2
> > The tinkering with memblock there and in f9126ab9241f seem bogus in the
> > context of memory hotplug on x86.
> > 
> > I believe that dropping that memblock_phys_free() is right thing to do
> > regardless of this series. There's no corresponding memblock_alloc() and it
> > was added as part of a fix for hotunplug on x86 that anyway had memblock
> > discarded at that point.
> 
> So when we re-add that memory, we might have still ranges as "reserved".

I don't see how anything can become reserved on the hotplug path unless
hotplug is possible before mm_core_init().
There are no memblock_reserve() calls in memory_hotplug.c, no memblock
allocations possible after mm is inited, and even if memblock_add() will
need to allocate memory that will be done via slab.

> It does sound weird, but you're the boss :)

Nah, it's mm/memory_hotplug.c, so you are :)

But I can send a patch anyway :)
 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
