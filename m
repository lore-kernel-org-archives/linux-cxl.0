Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79F1B66E
	for <linux-cxl@vger.kernel.org>; Wed, 19 Feb 2025 01:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739927416; cv=none; b=AzmKr2c7Dp5MZrOOg7J2K5PynEAVJ7f9u4AgjelHDRdoA+VqhF/Vv30RmJhZxglN0vqRXyg6i5Zy4JbT+xFJxQx5ueEZkJCP7Go/nCJvL/AmI/5Hm6sSN53rL0BEOtXIHmVzKgkbcjHLCSJL/qGicIZczWpTW+hGPA6b7HicIzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739927416; c=relaxed/simple;
	bh=UGNs0ZW6hb7R/Hw/kagHqKOGU8gopsipQ9iM7x6k7x8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZV/ClnHX1b0ykzk89Me8EC/8EnWjuj9waXpXt+nrdWIL9Jhfx2uPySOLI90EzfKo/NjgiGjrUexoc624QMfXxh5BtqhAdm3SS2Q1yOvbJn0AsFF4xA1mmswgkEzfpDbuWOvVCUSo/xrA3w5P5RvjhLipMxNo94MtDEjjc38T5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=bVWws8qO; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="bVWws8qO"
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7c08fc20194so570915585a.2
        for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 17:10:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1739927413; x=1740532213; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=mUpwLBw+Z1T0MkCckOh5bFyJys42TZYUDiEdEk41zSc=;
        b=bVWws8qOVDmI9nXMB6pK5actNUiveL/W2/iHsy+Z/fc8eCAAWrqiiXsLkc/ZmS6Kx6
         oFvwHK6caNJaGRYbOmRb6ALSbMC2bo/KGU72R0FYoCkHdWZF5YfwV3hEEM0ts0YNg8+4
         bvGJjovT8DfUFq5Meexte6gWyx1AHIQs/GhHUTAj9ni16VDf9y+LF6R6JYk78LyKTr5/
         MCwO2+MEmHnEeUm4nrPYSI1Ha0z4GF+/9D9hqM2LqVxc9cHCRhrS9tVWVSAVwdX0u4zp
         DOlMYKASr682j172f6uDWqQOkC4F/AbfhkYiEx0lAVCepdw/2q3FvLf/1r2QHmq6cbhl
         8KKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739927413; x=1740532213;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUpwLBw+Z1T0MkCckOh5bFyJys42TZYUDiEdEk41zSc=;
        b=VeowLJUHBYqp6jmVixsi+GS7rYrbdtynG1lNfvs5nOLdbbIBeG+FNAL4oL16mcCVi5
         gm1MCYkxJN0200TEqid8CMr3zXo+MWtdZ/t0joS6cZNykQozFkG+3nLqXld+Luw/6DJZ
         edTBxEtNsfKsLpIARHQcaYbLdfvvDmjAOg4b5tctp7JSmWagvDdlDyHMGsCWnk8f2nab
         hp+YCTmpyUpZDG4kLr5UvvLNiZo2gg5DIUA2uDNM22qdS5R1iMPzMp7D4/1DGT8FbY1K
         eflja8ONH5p+ZftAZczTZyun0zBVnyKSJuan7UlLeg6rxmmKMiQHQGpZY+ia4dC+VyUj
         ys2A==
X-Forwarded-Encrypted: i=1; AJvYcCUuf0BY7IjnpXFxi9ASqaHLxgAV4KqZNm1dqo8vMN1a2MtA+4P1ZP0kPrMyzps70Wfog0PUSHlXl80=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUuPl37oPfR2W/Qlee4IOv1AqnzkMXqD+vpcTmZnSTsk7j1AB2
	zwyS6E4Rp7k4lVFp8YiZIf5JNHhZ5HlfGXqXjdU0+ol46dGMQBZWiJbRDkIQHeg=
X-Gm-Gg: ASbGncuUR1w9pg/ffN7ofNX5EbkP0ymnmkjxFoqlvKA78MRh7QAPp1Udvqvn6VkSi5b
	hrOok1wZJ1UVQH8UwzYYioSMECnIRJgy4wcm+k63Y4pJk2Y9BfCPwdECs/Dht9SDinIpm2bGeew
	PxUPtjqefrXmdLmwbc06CzDXY6c7tDOnp4jARxtVJ9KcdjZzAzyGaxu2uiytegzsvnu8VcXKAui
	PMTFv5a60nGWlfD4girCIU/wm1BB7IEioZUhyLduDiQ6R3hgVJp4NI0eqCCBCRWOshttk0X84Ya
	WM6OkIfn6yauVSlCrLALCaVcFOqCi2f0sPAVfqfuTvVBclpkNykdf4dC/97OFSS+KMadMLPTRg=
	=
X-Google-Smtp-Source: AGHT+IH/AUdFwBNx24uUtaBVfN+n1JoWvhbYt0qh38JBEugYo+ybiMsaT1gcAkaQqXvSHqzz/jLiKA==
X-Received: by 2002:a05:620a:4626:b0:7c0:a28e:4970 with SMTP id af79cd13be357-7c0a28e4ae2mr1109600285a.29.1739927413662;
        Tue, 18 Feb 2025 17:10:13 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e65dce9f9csm69069206d6.104.2025.02.18.17.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Feb 2025 17:10:12 -0800 (PST)
Date: Tue, 18 Feb 2025 20:10:10 -0500
From: Gregory Price <gourry@gourry.net>
To: David Hildenbrand <david@redhat.com>
Cc: Yang Shi <shy828301@gmail.com>, lsf-pc@lists.linux-foundation.org,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
Message-ID: <Z7UvchoiRUg_cnhh@gourry-fedora-PF4VCD3F>
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F>
 <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F>
 <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F>
 <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>

On Tue, Feb 18, 2025 at 09:57:06PM +0100, David Hildenbrand wrote:
> > 
> > 2) if memmap_on_memory is on, and hotplug capacity (node1) is
> >     zone_movable - then each memory block (256MB) should appear
> >     as 252MB (-4MB of 64-byte page structs).  For 256GB (my system)
> >     I should see a total of 252GB of onlined memory (-4GB of page struct)
> 
> In memory_block_online(), we have:
> 
> 	/*
> 	 * Account once onlining succeeded. If the zone was unpopulated, it is
> 	 * now already properly populated.
> 	 */
> 	if (nr_vmemmap_pages)
> 		adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
> 					  nr_vmemmap_pages);
> 

I've validated the behavior on my system, I just mis-read my results.
memmap_on_memory works as suggested.

What's mildly confusing is for pages used for altmap to be accounted for
as if it's an allocation in vmstat - but for that capacity to be chopped
out of the memory-block (it "makes sense" it's just subtly misleading).

I thought the system was saying i'd allocated memory (from the 'free'
capacity) instead of just reducing capacity.

Thank you for clearing this up.

> > 
> > stupid question - it sorta seems like you'd want this as the default
> > setting for driver-managed hotplug memory blocks, but I suppose for
> > very small blocks there's problems (as described in the docs).
> 
> The issue is that it is per-memblock. So you'll never have 1 GiB ranges
> of consecutive usable memory (e.g., 1 GiB hugetlb page).
>

That makes sense, i had not considered this.  Although it only applies
for small blocks - which is basically an indictment of this suggestion:

https://lore.kernel.org/linux-mm/20250127153405.3379117-1-gourry@gourry.net/

So I'll have to consider this and whether this should be a default.
It's probably this is enough to nak this entirely.


... that said ....

Interestingly, when I tried allocating 1GiB hugetlb pages on a dax device
in ZONE_MOVABLE (without memmap_on_memory) - the allocation fails silently
regardless of block size (tried both 2GB and 256MB).  I can't find a reason
why this would be the case in the existing documentation.

(note: hugepage migration is enabled in build config, so it's not that)

If I enable one block (256MB) into ZONE_NORMAL, and the remainder in
movable (with memmap_on_memory=n) the allocation still fails, and:

   nr_slab_unreclaimable 43

in node1/vmstat - where previously there was nothing.

Onlining the dax devices into ZONE_NORMAL successfully allowed 1GiB huge
pages to allocate.

This used the /sys/bus/node/devices/node1/hugepages/* interfaces to test

Using the /sys/kernel/mm/hugepages/hugepages-1048576kB/nr_hugepages with
interleave mempolicy - all hugepages end up on ZONE_NORMAL.

(v6.13 base kernel)

This behavior is *curious* to say the least.  Not sure if bug, or some
nuance missing from the documentation - but certainly glad I caught it.


> I thought we had that? See MHP_MEMMAP_ON_MEMORY set by dax/kmem.
> 
> IIRC, the global toggle must be enabled for the driver option to be considered.

Oh, well, that's an extra layer I missed.  So there's:

build:
  CONFIG_MHP_MEMMAP_ON_MEMORY=y
  CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=y
global:
  /sys/module/memory_hotplug/parameters/memmap_on_memory
device:
  /sys/bus/dax/devices/dax0.0/memmap_on_memory

And looking at it - this does seem to be the default for dax.

So I can drop the existing `nuance movable/memmap` section and just
replace it with the hugetlb subtleties x_x.

I appreciate the clarifications here, sorry for the incorrect info and
the increasing confusing.

~Gregory
