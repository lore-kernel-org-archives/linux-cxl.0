Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7231079CF;
	Thu,  8 May 2025 06:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746685857; cv=none; b=WqwmCUvbGOxAoP7W1Zq8rJnTdB7cp01/KVVCQsRaoDNFBM4xvlKqTMm2NTzad+FWrP0JNYNgicYOxavi/pHYSD3FnUWQ9X4Huhfxqu0KR62ZLy34sB6Ax55Y+E5G0HKpp/MdT5BC0YybnfR3ARnk/xN5WB9DM3maREiqFxPtVTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746685857; c=relaxed/simple;
	bh=5IZCu6O0HHtnUdydLq5+oA+8YbknHDZjzkPzJFgT66I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qck24vc+WFoG6JEb+atP7C7+ha35dVBG8kU88v7VKrAu86jO9B3ZAhkoOugKYpyv3CmCT6ESJcM3fig6QrGsqrjM5pLLh+p8zPb2WQYfAvoyULwJFDwTFt3LFVlyeVgjg4VetO3OfB9/k9U+kGYml4mE4CuvrUVA8DDLLOLbUKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-681ff7000002311f-2b-681c4f979076
From: Rakie Kim <rakie.kim@sk.com>
To: Gregory Price <gourry@gourry.net>
Cc: joshua.hahnjy@gmail.com,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com,
	ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com,
	honggyu.kim@sk.com,
	yunjeong.mun@sk.com,
	rakie.kim@sk.com
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in weighted interleave
Date: Thu,  8 May 2025 15:30:36 +0900
Message-ID: <20250508063042.210-1-rakie.kim@sk.com>
X-Mailer: git-send-email 2.48.1.windows.1
In-Reply-To: <aBuMet_S1ONS1pOT@gourry-fedora-PF4VCD3F>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDLMWRmVeSWpSXmKPExsXC9ZZnke50f5kMgyvH9CzmrF/DZjF96gVG
	i593j7NbHN86j93i/KxTLBaXd81hs7i35j+rxeo1GQ4cHjtn3WX36G67zO6xeM9LJo9Nnyax
	e5yY8ZvFY+dDS4/Pm+QC2KO4bFJSczLLUov07RK4Mm7sn81S8D+oYsOcTsYGxnMOXYycHBIC
	JhLHmk4wwtidz54xdzFycLAJKEkc2xsDYooIqEq0XXHvYuTiYBZYzCRxcP9fJpByYYEEiVPz
	LjGD2CxANQ1rfrKD2LwCxhIXny9ghhipKdFw6R5YPaeAmcSh1pNsILaQAI/Eqw37GSHqBSVO
	znzCAmIzC8hLNG+dzQyyTELgBJvE+xnvWSEGSUocXHGDZQIj/ywkPbOQ9CxgZFrFKJSZV5ab
	mJljopdRmZdZoZecn7uJERjGy2r/RO9g/HQh+BCjAAejEg+vg7d0hhBrYllxZe4hRgkOZiUR
	3qJGoBBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeo2/lKUIC6YklqdmpqQWpRTBZJg5OqQbGhC9G
	7NYOnB41L1de0tpf83Ttyu4tOdEd83evj3813Vv4nxeD44pnp65POdzYFVurpDDjqud2fbGJ
	+irGDM+Tl3f2BvGe5Kl8Jz8t79TXJRkzVgkyLTol9Znz9vpLNwRb/7st3RPVvITh0OP5O4XO
	Llu8NnVJ4Jy1nHPmHlac733XbEOO+guLE0osxRmJhlrMRcWJABf+swpfAgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGLMWRmVeSWpSXmKPExsXCNUNNS3e6v0yGwYE9yhZz1q9hs5g+9QKj
	xc+7x9ktPj97zWxxfOs8dovDc0+yWpyfdYrF4vKuOWwW99b8Z7U4dO05q8XqNRkWv7etYHPg
	8dg56y67R3fbZXaPxXteMnls+jSJ3ePEjN8sHjsfWnp8u+3hsfjFByaPz5vkAjijuGxSUnMy
	y1KL9O0SuDJu7J/NUvA/qGLDnE7GBsZzDl2MnBwSAiYSnc+eMXcxcnCwCShJHNsbA2KKCKhK
	tF1x72Lk4mAWWMwkcXD/XyaQcmGBBIlT8y4xg9gsQDUNa36yg9i8AsYSF58vYIYYqSnRcOke
	WD2ngJnEodaTbCC2kACPxKsN+xkh6gUlTs58wgJiMwvISzRvnc08gZFnFpLULCSpBYxMqxhF
	MvPKchMzc0z1irMzKvMyK/SS83M3MQJDd1ntn4k7GL9cdj/EKMDBqMTD6+AtnSHEmlhWXJl7
	iFGCg1lJhLeoESjEm5JYWZValB9fVJqTWnyIUZqDRUmc1ys8NUFIID2xJDU7NbUgtQgmy8TB
	KdXAaDBxmTFHO3vw8aKeFjFWLzaLxsjGWVfnB/2uvbxMiVvjYcONBTkvhFaZruFRv772dB/f
	Jc+COzw+rlKKO3eJ8ll5xn61fzajYcNSZ3mzog9/LeXV/zhWsfElzPqffVQ0LD6pQlM2v8j3
	EufUe8d/X2JZrdB1cz/T0zItBdbH64SF7hYv3/tDiaU4I9FQi7moOBEAt26VGlkCAAA=
X-CFilter-Loop: Reflected

On Wed, 7 May 2025 12:38:18 -0400 Gregory Price <gourry@gourry.net> wrote:

Thank you very much for your detailed response. I fully agree with your points
regarding the limitations of the NUMA abstraction and the potential direction
with memory-tiers. These are indeed important and forward-looking suggestions.

That said, I would still like to emphasize the importance of supporting a
source-aware weight mechanism within the current weighted interleave policy,
even as an optional extension.

The proposed design is completely optional and isolated: it retains the
existing flat weight model as-is and activates the source-aware behavior only
when 'multi' mode is enabled. The complexity is scoped entirely to users who
opt into this mode.

> On Wed, May 07, 2025 at 06:35:16PM +0900, rakie.kim@sk.com wrote:
> > Hi Gregory, Joshua,
> > 
> > I hope this message finds you well. I'm writing to discuss a feature I
> > believe would enhance the flexibility of the weighted interleave policy:
> > support for per-socket weighting in multi-socket systems.
> > 
> > ---
> > 
> > <Background and prior design context>
> > 
> > While reviewing the early versions of the weighted interleave patches,
> > I noticed that a source-aware weighting structure was included in v1:
> > 
> >   https://lore.kernel.org/all/20231207002759.51418-1-gregory.price@memverge.com/
> > 
> > However, this structure was removed in a later version:
> > 
> >   https://lore.kernel.org/all/20231209065931.3458-1-gregory.price@memverge.com/
> > 
> > Unfortunately, I was unable to participate in the discussion at that
> > time, and I sincerely apologize for missing it.
> > 
> > From what I understand, there may have been valid reasons for removing
> > the source-relative design, including:
> > 
> > 1. Increased complexity in mempolicy internals. Adding source awareness
> >    introduces challenges around dynamic nodemask changes, task policy
> >    sharing during fork(), mbind(), rebind(), etc.
> > 
> > 2. A lack of concrete, motivating use cases. At that stage, it might
> >    have been more pragmatic to focus on a 1D flat weight array.
> > 
> > If there were additional reasons, I would be grateful to learn them.
> >
> 
> x. task local weights would have required additional syscalls, and there
>    was insufficient active users to warrant the extra complexity.

I also think that additional syscalls are not necessary.
Moreover, this proposal does not require any additional syscalls.

> 
> y. numa interfaces don't capture cross-socket interconnect information,
>    and as a result actually hides "True" bandwidth values from the
>    perspective of a given socket.
> 
> As a result, mempolicy just isn't well positioned to deal with this
> as-designed, and introducing the per-task weights w/ the additional
> extensions just was a bridge too far.  Global weights are sufficient
> if you combine cpusets/core-pinning and a nodemask that excludes
> cross-socket nodes (i.e.: Don't use cross-socket memory).
> 
> For workloads that do scale up to use both sockets and both devices,
> you either want to spread it out according to global weights or use
> region-specific (mbind) weighted interleave anyway.
> 

Cpuset and cgroups can control task placement, but they cannot dynamically
alter memory node preferences based on the current execution node. For
multi-threaded tasks running across multiple sockets, cpusets alone cannot
represent per-socket locality preferences.

Source-aware weights, on the other hand, enable automatic memory node
selection based on where a task is running, which greatly improves flexibility
in hybrid bandwidth environments.

> > ---
> > 
> > Scenario 1: Adapt weighting based on the task's execution node
> > 
> > Many applications can achieve reasonable performance just by using the
> > CXL memory on their local socket. However, most workloads do not pin
> > tasks to a specific CPU node, and the current implementation does not
> > adjust weights based on where the task is running.
> > 
> 
> "Most workloads don't..." - but they can, and fairly cleanly via
> cgroups/cpusets.
> 
> > If per-source-node weighting were available, the following matrix could
> > be used:
> > 
> >          0     1     2     3
> >      0   3     0     1     0
> >      1   0     3     0     1
> >
> > This flexibility is currently not possible with a single flat weight
> > array.
> 
> This can be done with a mempolicy that omits undesired nodes from the
> nodemask - without requiring any changes.

Nodemask can restrict accessible memory nodes, but cannot implement conditional
preferences based on task execution locality. For example, if a task runs on
node0, it may want to prefer {0,2}; if on node1, prefer {1,3}.

In the current model, implementing this would require runtime updates to the
nodemask per task, which is neither scalable nor practical. Source-aware
weights aim to encode this logic directly into policy behavior.

> 
> > 
> > Scenario 2: Reflect relative memory access performance
> > 
> > Remote memory access (e.g., from node0 to node3) incurs a real bandwidth
> > penalty. Ideally, weights should reflect this. For example:
> > 
> > Bandwidth-based matrix:
> > 
> >          0     1     2     3
> >      0   6     3     2     1
> >      1   3     6     1     2
> > 
> > Or DRAM + local CXL only:
> > 
> >          0     1     2     3
> >      0   6     0     2     1
> >      1   0     6     1     2
> > 
> > While scenario 1 is probably more common in practice, both can be
> > expressed within the same design if per-socket weights are supported.
> > 
> 
> The core issue here is actually that NUMA doesn't have a good way to
> represent the cross-socket interconnect bandwidth - and the fact that it
> abstracts all devices behind it (both DRAM and CXL).
> 
> So reasoning about this problem in terms of NUMA is trying to fit a
> square peg in a round hole.  I think it's the wrong tool - maybe we need
> a new one.  I don't know what this looks like.

I agree. NUMA does abstract away cross-socket topology and bandwidth details,
especially for DRAM vs CXL. But I believe weighted interleave was itself an
attempt to make NUMA more topology-aware via per-node weights.

The source-aware extension is a logical next step in that direction
introducing per-socket decision logic without replacing the NUMA model.

While it's clear that the NUMA abstraction has reached its limits in some
areas, the memory policy, sysfs interface, and page allocator are still built
on NUMA. Rather than discarding NUMA outright, I believe we should iterate on
it by introducing well-scoped enhancements, such as this one, to better
understand our future needs.

> 
> > ---
> > 
> > <Proposed approach>
> > 
> > Instead of removing the current sysfs interface or flat weight logic, I
> > propose introducing an optional "multi" mode for per-socket weights.
> > This would allow users to opt into source-aware behavior.
> > (The name 'multi' is just an example and should be changed to a more
> > appropriate name in the future.)
> > 
> > Draft sysfs layout:
> > 
> >   /sys/kernel/mm/mempolicy/weighted_interleave/
> >     +-- multi         (bool: enable per-socket mode)
> >     +-- node0         (flat weight for legacy/default mode)
> >     +-- node_groups/
> >         +-- node0_group/
> >         |   +-- node0  (weight of node0 when running on node0)
> >         |   +-- node1
> >         +-- node1_group/
> >             +-- node0
> >             +-- node1
> > 
> 
> This is starting to look like memory-tiers.c, which is largely useless
> at the moment.  Maybe we implement such logic in memory-tiers, and then 
> extend mempolicy to have a MPOL_MEMORY_TIER or MPOL_F_MEMORY_TIER?
> 
> That would give us better flexibility to design the mempolicy interface
> without having to be bound by the NUMA infrastructure it presently
> depends on.  We can figure out how to collect cross-socket interconnect
> information in memory-tiers, and see what issues we'll have with
> engaging that information from the mempolicy/page allocator path.
> 
> You'll see in very very early versions of weighted interleave I
> originally implemented it via memory-tiers.  You might look there for
> inspiration.

This is an excellent idea. I fully agree that memory-tiers has strong potential
as a future foundation for flexible memory classification and topology-aware
policy enforcement.

However, in its current form, memory-tiers lacks integration with mempolicy and
does not yet expose weight-based policy control over allocation decisions.

Weighted interleave, by contrast, already connects to allocator logic and
enables immediate policy experimentation. I view this proposal as a practical
starting point for validating ideas that could later inform a memory-tiers
based design.

As you mentioned, early versions of weighted interleave used memory-tiers.
I will revisit that implementation and analyze how the concepts could align or
transition toward the model you're proposing.

> 
> > <Additional implementation considerations>
> > 
> > 1. Compatibility: The proposal avoids breaking the current interface or
> >    behavior and remains backward-compatible.
> > 
> > 2. Auto-tuning: Scenario 1 (local CXL + DRAM) likely works with minimal
> >    change. Scenario 2 (bandwidth-aware tuning) would require more
> >    development, and I would welcome Joshua's input on this.
> > 
> > 3. Zero weights: Currently the minimum weight is 1. We may want to allow
> >    zero to fully support asymmetric exclusion.
> >
> 
> I think we need to explore different changes here - it's become fairly
> clear when discussing tiering at LSFMM that NUMA is a dated abstraction
> that is showing its limits here.  Lets ask what information we want and
> how to structure/interact with it first, before designing the sysfs
> interface for it.
> 
> ~Gregory

In conclusion, while I acknowledge the NUMA model's aging limitations,
I believe source-aware weights offer a focused and minimal expansion of the
existing framework. This enables:

- policy control based on execution locality,
- compatibility with current NUMA-based infrastructure, and
- a conceptual bridge toward future tier-aware models.

Thank you again for your valuable feedback and thoughtful suggestions.
I will review your memory-tiers guidance in more detail and follow up with
further analysis.

Rakie

