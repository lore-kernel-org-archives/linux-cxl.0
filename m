Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40E2478868
	for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 13:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787059843; cv=none; b=RMKQu7VA5BAJ6foWtzwC25ZADsgmAm0DcUW8BrM/ev1FwWKUdF+6azBoB7pWDTDyQzb/8acOyf1+dvmVsUPzW9Zc6mYpWMHGB+qVYX9datSBM1TAf78AlQBE6HfcIC8JlhQtR/ZEZ7VVkANP7ZBL6a+B/9LYZPIr6O37uwagDL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787059843; c=relaxed/simple;
	bh=9EtrV7OjP64RmR5TwTSWprliKDtLV5/e6pRMrGJB82k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVUA5ldXuT10fCwilVG7WeWoDKFm7TEAWTTGSmGY5HI3m8A6d/Nl9uEmpkMHQmpCYgQh6up0q2HzkkkA20qiaKr1di5xsk1ZwMbW2sPFsSBoz3TCGbVHBC8CL58w9mioS1yxotGmVzEWfWtrUnLNNyG23GtsGtNZ4zOmBvGsr0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=GynkVWkj; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="GynkVWkj"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-8f256eaedf8so46091486d6.2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Aug 2026 06:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1787059839; x=1787664639; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ax6pSQ+/xfd4HZ06hVopmXYjHWPwUVuXeBPTbOtm2CI=;
        b=GynkVWkjCLAbEJM1rQzLwg0o00h0x5fGGFeLcoDzJR9wG3akSbv2KUuhmjFmAeAG7F
         KoCiQh6u0GeLBYqQjqks7eM5OT5FO4kIAxJxBLH8qLZucJt3E+fA6EsLCNjBGt+OJ+wB
         4nuhtFJUyUiNx11BSQcxbZM0c9mZnZ6aYvJ24B6vNyJ8JEaQ+/TDjuIZTqWouIH480rh
         Ard0z85prpSfrlATkGVbC/qq0AK92+ob3AOh/tJb0tB2HSh0LOm0zOw1c5i0OSx5rRoq
         Lw78Mhdmeg9MFsdz7LqY6QXhPqk06smk3IK87VLqIjhzluFBDmCPu46HKVbx/N9ZiWSg
         TmeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787059839; x=1787664639;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ax6pSQ+/xfd4HZ06hVopmXYjHWPwUVuXeBPTbOtm2CI=;
        b=G2WPKYxsTfyKUTNk40Q9c6Zn0UZMnxYlpb1xFHch0eCllf3pyEmgoIofgbbFzjsPSR
         Uv/tS6CAv2uZJZF6phQ/53GrDJdu2f0f9i2e0Q4UDzqfXCt0ufM8F/Z7u195VK/0SMJq
         3amjPkunek+/p1AP05VyatqLADG+psL5jMAptykMxrBX872AN25uRKfJNA/hRFqyAGt/
         bbbfks9j2F+QOT9wWAVCMSvbosBowxw0/l1zZ87unL24F9PUk/zyglgPYC1tFYdjmwSI
         qvinI4yatuxe+zTOW32RG7zFGOzqkmIZY1jRXuFbVgd91C7TikUzzCVpv1S1A/0xsnpE
         sMKg==
X-Forwarded-Encrypted: i=1; AHgh+RqfPyXOsr22rErCXJKTYltvJ/ZKaTsNaVHzBraB81wdRNtVuaI6TD+7RlSYl4ZJf73q/K9g+EyxeAY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNx3R0Vgn8GN4CMbj2P1q4HfoKs/ZIbLfyWCmKO/oxnnqYk4B+
	CgNx9ts9CAjQidIkK889r1KL1n5tSyak8Sp5iB8XDhkXjKFfpk38JwAD+jTEZw1jsNI=
X-Gm-Gg: AR+sD10m2ovf6G0n1BRn36COsVcLJg/6Qsgb/71O8ta2wZ+tsYKv0tyUHayIfB8JEvZ
	cZ1oueA0+yPup4HQLnlXPCFnSIIDDcso/ng+o9WsPCDG0tR9B8LhDEvoeLzrNhWctlCFZB4GbJn
	U17oEj4h82niS9o+TBOWYoRwzJSpP4gFT5ENaXu5JLauVzkhaFI++x6f2AJ43zj8uFNJ8LPwdVz
	U/rXMav12/d/WOXIZYddMD2hxxfvpNaNWxpbY33ksourEHefPdDmDz0UHIRM7Go5Vj1/EN01H04
	W009bc4NJ5cBf5NTTZCAhEjLl4wmIukh0C8pl+fc/GXgySKtCAbfcNV6STpLGe4d+nAYDoOnexg
	3t2skrEOs4BxiZMhu2sARjO7b8VfUXX5MmrNZKJRkZ6SEnhG1kBoOxhI0oiKIzSX4+Icq0cdOtk
	ouHtvRzUqpF6Xws4PIhTrfViMyG8xkR1pZkYSBAK7oUaTkc1fA8e2uSIihE4DwZZZucgLEpacmt
	9OCuh1YELEn6B5m5e3DCmvAvzCh4UoYIEZeDUtxuC7I
X-Received: by 2002:a05:6214:498a:b0:908:a54a:5b29 with SMTP id 6a1803df08f44-90a91deefccmr394858816d6.24.1787059838767;
        Tue, 18 Aug 2026 06:30:38 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90c4580fcc4sm32688846d6.4.2026.08.18.06.30.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 06:30:38 -0700 (PDT)
Date: Tue, 18 Aug 2026 09:30:36 -0400
From: Gregory Price <gourry@gourry.net>
To: Rakie Kim <rakie.kim@sk.com>
Cc: akpm@linux-foundation.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	byungchul@sk.com, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	david@kernel.org, ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, 
	rppt@kernel.org, surenb@google.com, mhocko@suse.com, dave@stgolabs.net, 
	jic23@kernel.org, dave.jiang@intel.com, alison.schofield@intel.com, 
	vishal.l.verma@intel.com, ira.weiny@intel.com, harry@kernel.org, kernel_team@skhynix.com, 
	honggyu.kim@sk.com, yunjeong.mun@sk.com
Subject: Re: [PATCH 0/4] mm/mempolicy: introduce package-aware weighted
 interleave
Message-ID: <aoRbDEn1sQ7b22dy@gourry-fedora-PF4VCD3F>
References: <aoMv3OhqkBTzSfek@gourry-fedora-PF4VCD3F>
 <20260818060201.1907-1-rakie.kim@sk.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818060201.1907-1-rakie.kim@sk.com>

On Tue, Aug 18, 2026 at 03:01:58PM +0900, Rakie Kim wrote:
> On Mon, 17 Aug 2026 12:19:51 -0400 Gregory Price <gourry@gourry.net> wrote:
> 
> > I have some concerns with the now additional filtering mechanism
> > introdced into the allocation stack, but fundamentally I think this is
> > a *better* solution than a straight weight-matrix.
> 
> About the cost of the filter: when the toggle is off, the filter does
> not run. When it is on, node selection needs a nodemask filtering
> step, but in my tests the overhead was negligible. I will look at
> this part further and check whether there is more room to optimize.
> 

Not concerned about the performance, concerned about how complicated the
mempolicy - cgroup - zonelist - page_alloc interaction already is, and
then adding another filtering mechanism on top.

Today we have:

1) cpuset constrains mempolicy (nodemask remaps)
2) cpuset constrains zonelist walks
3) mempolicy nodemask constrains zonelist walks
4) memory-tiers.c nodemask constrains zonelist walks for demotion
5) zonelist membership constrains allocation access
6) a bunch of corner conditions that violate 1-3 for the sake of forward
   progress

now we're adding:

7) memory-tiers.c nodemask constrains mempolicy nodemask
   except when it doesn't, because fallbacks occurred hard enough

It's already un-intuitive how and when memory lands on certain nodes.

To be clear, I'm not saying this idea is bad - either as-is or in some
other form - just that adding another nodemask filtering path is making
it harder and harder to understand what lands where.

Mostly starting to wonder if we're reaching the point where the page
allocator needs to take something a little more descriptive than a
nodemask to dictate placement.

~Gregory
