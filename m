Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0822B9AA;
	Thu, 20 Feb 2025 17:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740073823; cv=none; b=FR8HktQbCz4Z+6oKj3f4HQKCelZFG7iTnE63ltijFTI/Pdo+8MMOjqVays/i2oPrPUkvy35RlzUmGsYNvz6IETEakdug/Og3l/Y3kXexjhBgZNg66x05Y8EfIWNnuNQUQdzGe+vTCQh70PXhuOYsB06sY7vyTZ2juZfBIFDYmRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740073823; c=relaxed/simple;
	bh=IJ7M86wMSdxXMV52jPqJQwN18In/Fq4MAFTJcpgW8sI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t9p6UMcK4mY0hgXvq7V1Hf4UwtO1Zyu5xFMfbXW6KoC9vnOw+jhK3EaCoWWtg8x7QPvGgf956y9QAjhwz45+myY82w1NrPaUtZekT8YJuOqzeelQBkKQGV5kbRZYlliHJvccJo0RhklfWAjXHCBk4in2K3K6TzpdGAVcXWuKsGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LUoloyaR; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LUoloyaR"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5e05780509dso1729841a12.2;
        Thu, 20 Feb 2025 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740073820; x=1740678620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ACbXZSJEeD7MSU+0ygnOG3CFUz1SHUqmj4uHUBUExvo=;
        b=LUoloyaRwf4WbEzVHt2I7vgQHXLMv4P+EY5Z6KTiNkf6jabEDyVAGWc0IrNDIwCYYX
         kddKaQr20gZ1t0jPtvbdo1wvgxptUtvvRmRBtnxQ3Jtid3mcCOk2I4vQmLz7q7Erov44
         FzTbdn0Su3KnydPxhinoU34Ku7HzGXgQ/bCqJVnMk2fZiTkqMhna/KtFox3Kb8hymcuN
         IhNZ/40gsuM8aTjxx9/Vf4EbKmC3GKF4/qlwUaVxR2YKA0xoDFZTrZLX6fjCNvrCBSiD
         nA/aWKQ+JCJ7UCuEmQVsDA/p5cL7+Vd5VBdqfwTxJUK5NW6/nSBdBty6sWl2TWiaBVr5
         0PAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740073820; x=1740678620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ACbXZSJEeD7MSU+0ygnOG3CFUz1SHUqmj4uHUBUExvo=;
        b=r5AeKplolqo28hFlwrmMLQg5Iaanv/pQ2V6jC/SNJ+iBgo3t6xqEIH5vaqNUahE12e
         hM6oHmlS3KUKhLLVqlUPSkB8H+VALHCSeIRNbOe+wVUor84TyEAulXrO8BQJ4P9snYzS
         PUBq3eMhZJn3Wv3OVvVBNGISOJf5t8gf/pjZ5eTb2zbWHf8IgU/jMnXXtGVPQ04HGYjt
         OQvcKr3a3po5VUTHPTrCYd9s/Zm+01fyPc/YAmm4s/MNLJsbQL8mzlb5eyf3p6VnRGRJ
         0JCOe7d/D6o0K/0bPIQFt0AzB/aOSN8XQw4hNj63FLTGegvaoN3oTBXoxpvwan3KQ2+o
         xvBw==
X-Forwarded-Encrypted: i=1; AJvYcCUQSPY1CJEFC2SWIqxSfZ09ZddxzYT9cBZlI7M72bpTrJsjs6p5Z4jnVu8gkwyyIQPYGaNpSEG8p54=@vger.kernel.org, AJvYcCWWov7Wm7gPMRZMSRwlGaGHgYkZwwTKvwgFBndsIFtCzdGbHGbkr2svLjz7WbDFg3hoQ4ANiwRwbIBuBbil@vger.kernel.org
X-Gm-Message-State: AOJu0YwqqAKj/HYXQPxawUS7YvW4IK5ZBQJK98pE/S2N6acuIqPQimrk
	VdkLdi9mZYwo9hmhL90jWWp2eHnu8hH/KdP6IErczYmqPtgl+7AwXBWkUz1iGZn5IOv3ZsWlNoh
	rAzVqS4sDjEkdm/FLL4rkzxcVdu4=
X-Gm-Gg: ASbGncu1APAETMnKYY0D0uvNYnazH02p8Np82lwu8r9Gtyr/kpytkviLma1/IESuoB5
	SbZ66No3zgUUlDCTbZGzAj+3CO7WmIbNTVbK9ukgyyTRryqkX2/F545PhufdrDCfGCPDZVkHe7J
	c=
X-Google-Smtp-Source: AGHT+IEoWXbWwTVuK2Nwv99J648YCts8QbcZyhvyRX5LPXJIREs0N43ohOkCkOhIjhQm5MU2a34de0JWy5oegIyzsg0=
X-Received: by 2002:a05:6402:268a:b0:5d9:a62:32b with SMTP id
 4fb4d7f45d1cf-5e0360440a0mr26146606a12.7.1740073819559; Thu, 20 Feb 2025
 09:50:19 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <Z226PG9t-Ih7fJDL@gourry-fedora-PF4VCD3F> <Z7OWmDXEYhT0BB0X@gourry-fedora-PF4VCD3F>
 <CAHbLzkq6Me6nRaL6b09YxJ_nFkxb+n+M3-q_aJwOs2ZO4q8VCg@mail.gmail.com>
 <Z7TLwtQY3vGUw2bO@gourry-fedora-PF4VCD3F> <1b4c6442-a2b0-4290-8b89-c7b82a66d358@redhat.com>
 <Z7TswQbpPV590ADr@gourry-fedora-PF4VCD3F> <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
In-Reply-To: <bda4cf52-d81a-4935-b45a-09e9439e33b6@redhat.com>
From: Yang Shi <shy828301@gmail.com>
Date: Thu, 20 Feb 2025 09:50:07 -0800
X-Gm-Features: AWEUYZkw36f3OEiXrlZX_cyPCOYpVkyNjb2lSz_Gn-SXQJshZlbv5FIQbCvDvP0
Message-ID: <CAHbLzkqDQcrHLPzk8n0SMgkidH2ByCqdwfYXX=uBPQfOArWf8A@mail.gmail.com>
Subject: Re: CXL Boot to Bash - Section 3: Memory (block) Hotplug
To: David Hildenbrand <david@redhat.com>
Cc: Gregory Price <gourry@gourry.net>, lsf-pc@lists.linux-foundation.org, 
	linux-mm@kvack.org, linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> >
> > 2) if memmap_on_memory is on, and hotplug capacity (node1) is
> >     zone_movable - then each memory block (256MB) should appear
> >     as 252MB (-4MB of 64-byte page structs).  For 256GB (my system)
> >     I should see a total of 252GB of onlined memory (-4GB of page struct)
>
> In memory_block_online(), we have:
>
>         /*
>          * Account once onlining succeeded. If the zone was unpopulated, it is
>          * now already properly populated.
>          */
>         if (nr_vmemmap_pages)
>                 adjust_present_page_count(pfn_to_page(start_pfn), mem->group,
>                                           nr_vmemmap_pages);
>
> So we'd add the vmemmap pages to
> * zone->present_pages
> * zone->zone_pgdat->node_present_pages
>
> (mhp_init_memmap_on_memory() moved the vmemmap pages to ZONE_MOVABLE)
>
> However, we don't add them to
> * zone->managed_pages
> * totalram pages
>
> /proc/zoneinfo would show them as present but not managed.
> /proc/meminfo would not include them in MemTotal
>
> We could adjust the latter two, if there is a problem.
> (just needs some adjust_managed_page_count() calls)
>
> So yes, staring at MemTotal, you should see an increase by 252 MiB right now.
>
> >
> >     2a) when dropping these memory blocks, I should see node0 memory use
> >         stay the same - since it was vmemmap usage.
>
> Yes.
>
> >
> > I will double check that this isn't working as expected, and i'll double
> > check for a build option as well.
> >
> > stupid question - it sorta seems like you'd want this as the default
> > setting for driver-managed hotplug memory blocks, but I suppose for
> > very small blocks there's problems (as described in the docs).
>
> The issue is that it is per-memblock. So you'll never have 1 GiB ranges
> of consecutive usable memory (e.g., 1 GiB hugetlb page).

Regardless of ZONE_MOVABLE or ZONE_NORMAL, right?

Thanks,
Yang

>
> >
> > :thinking: - is it silly to suggest maybe a per-driver memmap_on_memory
> > setting rather than just a global setting?  For CXL capacity, this seems
> > like a no-brainer since blocks can't be smaller than 256MB (per spec).
>
> I thought we had that? See MHP_MEMMAP_ON_MEMORY set by dax/kmem.
>
> IIRC, the global toggle must be enabled for the driver option to be considered.
>
> --
> Cheers,
>
> David / dhildenb
>
