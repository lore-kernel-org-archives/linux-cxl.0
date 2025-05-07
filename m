Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EB828980B
	for <linux-cxl@vger.kernel.org>; Wed,  7 May 2025 16:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746635903; cv=none; b=m8Ep2jIj2OVXtpFWxlJJYgQD+HYt/1KI4Xo5g9BeS0bXVCRBfSMwwrhVqE64actq+MfQFRZSGfABJGjUf2UmsSrBNuAb/RIWFLXdcCMMhF7mAo+ti3KxmlmlWW0OtmveEGURycevQvfI52wp9vWFv5IhXKLEZn1GMn2VTzEZ8Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746635903; c=relaxed/simple;
	bh=Pjs80y8eHu5bjBIh65bwbOhNCtjNmJR7kP6EndofUzA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns/V56GauuFVtvns71tT8J3bz1qslXF//HasJkvRu3u7ZBBT2X+z6y+ntrAYgdpionEgQbUPm4UGXc5VdYHMGciU9qDvHHfjfEXzaoZdaDjW2sz+5bSgU23pBR2kGWBfg1kKgCeBTAVyL4m5H9QTOJmtS2RWEIJD596LtY3OjVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=r472r2HD; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="r472r2HD"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-7c559b3eb0bso3775685a.1
        for <linux-cxl@vger.kernel.org>; Wed, 07 May 2025 09:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1746635900; x=1747240700; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FNwnXaMBa9hDs8yRXt3IkZX2NwxNzCzlBs/R2yeu/pc=;
        b=r472r2HD65eU6nLDKvjt91BVBS6m70ietVlInvxW7CFYzxZmqW3MbwmyfxKjaLQjUL
         ENvgBvxf3CXzs2/o/cdCUpOLT5I7Zjwb4GQG7gB5UHCu2r4hmlQiNOl93plvbbw7hzKG
         SffNcyxGRJp1caMHyI6fHGkgmgEIJHq+yNdcteHBaJoCpBq/K8oklFCxZOvJ3Aprp7F5
         PeETepPMKm7zPDzsowx7jrBdAdFxAMEkLlRZiIxjXUOi6ayGEy1+A71FM2fY1BjdUhQn
         4D7TuvIpbHziqXlaDqxUGKadnsdtHWNwyT0alEyGmm+DU5piVIBS9a6QTbQvuhgNyIrx
         NhCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746635900; x=1747240700;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FNwnXaMBa9hDs8yRXt3IkZX2NwxNzCzlBs/R2yeu/pc=;
        b=lQZujJ0pxZwnOb0HuvOx4NGWB8ajg51ReY8EEt5/OHooEWrT8GnndMD+TLuWrgbpHw
         ficD9dYWBjh79s/wmxJX0feJmF2UFoimt4l4HZYI4Qwl/YAex5T8GQOnwOLss0oU7u1o
         DUYRoqFs2PcisSUl6N7jRa4e2yZKBfDJIFvoYhCLItCt8DYYlvckOP4oqrKM32LGl5zx
         tGet3pynAfU8wyrsX084v64xboVW/IsCmW7UwankVs0uoTTNe2GNjiZ3muqyAQ+FSHiT
         XK79cM2jKwKAYIHWMxQEaJFGs8SAiB7OztgZsGnqZmUena41YKVomv6RE3CyznKsNXsX
         nqkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW9LMoy9whHU4XTZdM1SR97WVQR3m+bJWxBuiIOr41cgteFqrXnMxSjQWcCoUFkwYKZqlaPbYfhaMU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM3jsVCJLzPe49V03pRddrDZ3/Tkwxdv+9Ljefo9oTiSId6M1A
	zGZUFkK7eOSoE/N2xm8twc2XvBYbz4UKJPSqEyWaRwh/AsWc9pNLCvC8gnFNmoQ=
X-Gm-Gg: ASbGncvn/mckkKgz/QPw8Vx3pN3juXbjNoXcXlE3kp+cAA6WlUyzgFk0srp4OgLrF1Y
	9xZ1caGhbY7wYU3CPjay54Fzv/0YfByKTBdKPkcAjc8rRuWlIqlrztvtQj99hJTN1SpmptJpVyw
	N9zb+y+/CY/c06Qv1J+4tr7Wb/gATVDrGtv0tVPWeEOv1BIEKt9X5eZcbvd26zwPg99vzDwZCV4
	6P5xTPB4u9jyNFAhCSVPntQ7KGpGLVoytAfo879WhkDFk79FTgEf+xKstS5Tfu2Qp3j41w//+h0
	E6wXeKb/4gZ5H3VHJ1ImHK54HzOuY2LhU0TosMRg8OcD2bQKDM5aft8TIxlEHzMVt4wp6SIdx5c
	YJJx1UHTCU+OqCPrL5EKS
X-Google-Smtp-Source: AGHT+IF0xHUJtr97towfcTvdfSOQ4JyJPdVT4WVEd27PBR1E81nlMSzfNE409MAkSdrttE1G0v49TQ==
X-Received: by 2002:a05:620a:4621:b0:7c7:a5c9:d109 with SMTP id af79cd13be357-7caf74188e8mr542999885a.50.1746635900579;
        Wed, 07 May 2025 09:38:20 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-42.washdc.ftas.verizon.net. [96.255.20.42])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7caf75b8841sm171484285a.69.2025.05.07.09.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 May 2025 09:38:20 -0700 (PDT)
Date: Wed, 7 May 2025 12:38:18 -0400
From: Gregory Price <gourry@gourry.net>
To: rakie.kim@sk.com
Cc: joshua.hahnjy@gmail.com, akpm@linux-foundation.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
	dan.j.williams@intel.com, ying.huang@linux.alibaba.com,
	kernel_team@skhynix.com, honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [RFC] Add per-socket weight support for multi-socket systems in
 weighted interleave
Message-ID: <aBuMet_S1ONS1pOT@gourry-fedora-PF4VCD3F>
References: <20250507093517.184-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250507093517.184-1-rakie.kim@sk.com>

On Wed, May 07, 2025 at 06:35:16PM +0900, rakie.kim@sk.com wrote:
> Hi Gregory, Joshua,
> 
> I hope this message finds you well. I'm writing to discuss a feature I
> believe would enhance the flexibility of the weighted interleave policy:
> support for per-socket weighting in multi-socket systems.
> 
> ---
> 
> <Background and prior design context>
> 
> While reviewing the early versions of the weighted interleave patches,
> I noticed that a source-aware weighting structure was included in v1:
> 
>   https://lore.kernel.org/all/20231207002759.51418-1-gregory.price@memverge.com/
> 
> However, this structure was removed in a later version:
> 
>   https://lore.kernel.org/all/20231209065931.3458-1-gregory.price@memverge.com/
> 
> Unfortunately, I was unable to participate in the discussion at that
> time, and I sincerely apologize for missing it.
> 
> From what I understand, there may have been valid reasons for removing
> the source-relative design, including:
> 
> 1. Increased complexity in mempolicy internals. Adding source awareness
>    introduces challenges around dynamic nodemask changes, task policy
>    sharing during fork(), mbind(), rebind(), etc.
> 
> 2. A lack of concrete, motivating use cases. At that stage, it might
>    have been more pragmatic to focus on a 1D flat weight array.
> 
> If there were additional reasons, I would be grateful to learn them.
>

x. task local weights would have required additional syscalls, and there
   was insufficient active users to warrant the extra complexity.

y. numa interfaces don't capture cross-socket interconnect information,
   and as a result actually hides "True" bandwidth values from the
   perspective of a given socket.

As a result, mempolicy just isn't well positioned to deal with this
as-designed, and introducing the per-task weights w/ the additional
extensions just was a bridge too far.  Global weights are sufficient
if you combine cpusets/core-pinning and a nodemask that excludes
cross-socket nodes (i.e.: Don't use cross-socket memory).

For workloads that do scale up to use both sockets and both devices,
you either want to spread it out according to global weights or use
region-specific (mbind) weighted interleave anyway.

> ---
> 
> Scenario 1: Adapt weighting based on the task's execution node
> 
> Many applications can achieve reasonable performance just by using the
> CXL memory on their local socket. However, most workloads do not pin
> tasks to a specific CPU node, and the current implementation does not
> adjust weights based on where the task is running.
> 

"Most workloads don't..." - but they can, and fairly cleanly via
cgroups/cpusets.

> If per-source-node weighting were available, the following matrix could
> be used:
> 
>          0     1     2     3
>      0   3     0     1     0
>      1   0     3     0     1
>
> This flexibility is currently not possible with a single flat weight
> array.

This can be done with a mempolicy that omits undesired nodes from the
nodemask - without requiring any changes.

> 
> Scenario 2: Reflect relative memory access performance
> 
> Remote memory access (e.g., from node0 to node3) incurs a real bandwidth
> penalty. Ideally, weights should reflect this. For example:
> 
> Bandwidth-based matrix:
> 
>          0     1     2     3
>      0   6     3     2     1
>      1   3     6     1     2
> 
> Or DRAM + local CXL only:
> 
>          0     1     2     3
>      0   6     0     2     1
>      1   0     6     1     2
> 
> While scenario 1 is probably more common in practice, both can be
> expressed within the same design if per-socket weights are supported.
> 

The core issue here is actually that NUMA doesn't have a good way to
represent the cross-socket interconnect bandwidth - and the fact that it
abstracts all devices behind it (both DRAM and CXL).

So reasoning about this problem in terms of NUMA is trying to fit a
square peg in a round hole.  I think it's the wrong tool - maybe we need
a new one.  I don't know what this looks like.

> ---
> 
> <Proposed approach>
> 
> Instead of removing the current sysfs interface or flat weight logic, I
> propose introducing an optional "multi" mode for per-socket weights.
> This would allow users to opt into source-aware behavior.
> (The name 'multi' is just an example and should be changed to a more
> appropriate name in the future.)
> 
> Draft sysfs layout:
> 
>   /sys/kernel/mm/mempolicy/weighted_interleave/
>     +-- multi         (bool: enable per-socket mode)
>     +-- node0         (flat weight for legacy/default mode)
>     +-- node_groups/
>         +-- node0_group/
>         |   +-- node0  (weight of node0 when running on node0)
>         |   +-- node1
>         +-- node1_group/
>             +-- node0
>             +-- node1
> 

This is starting to look like memory-tiers.c, which is largely useless
at the moment.  Maybe we implement such logic in memory-tiers, and then 
extend mempolicy to have a MPOL_MEMORY_TIER or MPOL_F_MEMORY_TIER?

That would give us better flexibility to design the mempolicy interface
without having to be bound by the NUMA infrastructure it presently
depends on.  We can figure out how to collect cross-socket interconnect
information in memory-tiers, and see what issues we'll have with
engaging that information from the mempolicy/page allocator path.

You'll see in very very early versions of weighted interleave I
originally implemented it via memory-tiers.  You might look there for
inspiration.

> <Additional implementation considerations>
> 
> 1. Compatibility: The proposal avoids breaking the current interface or
>    behavior and remains backward-compatible.
> 
> 2. Auto-tuning: Scenario 1 (local CXL + DRAM) likely works with minimal
>    change. Scenario 2 (bandwidth-aware tuning) would require more
>    development, and I would welcome Joshua's input on this.
> 
> 3. Zero weights: Currently the minimum weight is 1. We may want to allow
>    zero to fully support asymmetric exclusion.
>

I think we need to explore different changes here - it's become fairly
clear when discussing tiering at LSFMM that NUMA is a dated abstraction
that is showing its limits here.  Lets ask what information we want and
how to structure/interact with it first, before designing the sysfs
interface for it.

~Gregory
