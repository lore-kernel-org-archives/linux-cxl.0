Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5072DE6E3
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 22:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782944298; cv=none; b=fT4tA7jG0K6A11ZtyYeeno9cvUwkky5ZegnHLlrye23MPseTuaBWrJTNKMUWU2tqS+++ls1ztdI44z+B1rXuafvMKyXpHM7XN3GuPk/+FTgTSDz5LIKTgnHGR+DRBPPHmPkOUiJg02ch68ZiGppSFk6qHguVwWMTmh1dogi1Flo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782944298; c=relaxed/simple;
	bh=YFODPyiBTJ3qFQRmKDjGlGykbaq+xRFKBxJyqfTImiw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=lETqp2pLnAURlJ9HJkxDHIuBPSXhcUv0L3wohxZi/N0aGURXWzz4lpc7mLtvfwCIuzjhKNQlLatr1IdS7Uda/6/rTL7V8RYAh8iWXacZnquDlWX6SppJQbvO0JffCZdAOLuchc+YKK6YqKTKOmxkTimQFGVZ7/F6kwcyyWAAKw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NKU7Pjza; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NKU7Pjza"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782944296;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki85T1yuIZ08q4/WMbISj88TpnfFulA/YFotMHfXQJE=;
	b=NKU7PjzaAT2BVowMUpmK3xwP1tG/jG7SpNnil2lWKsk1qGTckFZlMIHYxQn8d8Jfq9D5hA
	J88jLclVzxVYhTXaD8/GRDZNxF3I4KA4CTVJQYtuPGVx8FCDqYtxPRPc7iYew+N4fYsqRS
	OYPU9o/B5eCSrLN9pGKILMQVNBbauuY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-fvoGi04pNBegvvwi7Kd32A-1; Wed, 01 Jul 2026 18:18:13 -0400
X-MC-Unique: fvoGi04pNBegvvwi7Kd32A-1
X-Mimecast-MFC-AGG-ID: fvoGi04pNBegvvwi7Kd32A_1782944292
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-493bb6a4336so10819225e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 15:18:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782944292; x=1783549092;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ki85T1yuIZ08q4/WMbISj88TpnfFulA/YFotMHfXQJE=;
        b=O0KUJmmU3obgs8KuQYjyOoi7CLuiOp+7uE6B4YHvysIADLidbtxCKhJvdsRyZZGlO/
         1Skkt+DJACI+1Yj1aYf9sQmulfMhqA6OxPwedGt6azc5rWsmpfVY9pjvZMe/miPkZubu
         68SrXQjs3KKj4FrE1MzgHg6AQXTKib0GPmRBquKNwa2yOpNmbAFF18gSPC5jFtuhPPvD
         iMEMA1HcqoKmPjYpN6Ufwc1zbGNYme+kiAKJdnfNftFOjbPgs2T2DL9tUUkpjE55G+ZQ
         YRbY69XK+PredJxDrSJzZt2eGKU+0X6TkGhyt8BGC/HI0XU9qrqAYxluFIXo9zmqsk91
         3ACQ==
X-Forwarded-Encrypted: i=1; AFNElJ/eGiJrL92WkxbERnKw1kc/DAoCsbCYyIi4GettkNcdQ09G76ZqoqYCAFbLdAEMbiGC89lVvvexhwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyvDxNGHHeBbvVzyVZ7pzM9wHJKnro42mOuJqfwU4fbCNFgxgs
	rG16f5fVueKoYHdj1XwuaaYN2GN+z3+m3EXuQOBcQr1NyvHhr0im/7zd5ka8K5bIpN5RjBbH2py
	dxUVa4VTIP0ZM90EC4b2lXYPp21lB1b93m5bETfvjSZW2zG4wQZ3pFfWp07KdeQ==
X-Gm-Gg: AfdE7cmJc9L0DJe1mLvKmsG2MJliusYobtjOmPa/Mo/oe/0/etDwzEFPiOe6ZMwMvoX
	67mR4GDudPlD2IV6wSS8zMVm3OVvyZ3X348d1lEcdeVS8c4ptXYtPT8ll76lh3z9izYh18f6nq0
	0MA8l1MwV4U1LPtLmL7brkyE9NQ77GcYScUSHkdYFZdVWhdLOsbM0rwLLJ0DWPDtSDLVp03DMY9
	uR5ZAh4CNQ/RkFFBig3A7BdcEnwTYQfAKRiBFV8UfhALZwazWvnmtGspFdM+xr/7Sz3LyQxbpLA
	Z1XHIea6Ouu5t0Hz/QS8upLFGb8Tr80nz8b5ydnm3XSBCAp3lpWwO01DMroFYqW0M/1sCvV+k2r
	Yp1pwkiXchPkZl0RuCMfb5kRuD0bIy9jP
X-Received: by 2002:a05:600c:37cf:b0:493:bc97:916b with SMTP id 5b1f17b1804b1-493c2b986cemr52220305e9.26.1782944291740;
        Wed, 01 Jul 2026 15:18:11 -0700 (PDT)
X-Received: by 2002:a05:600c:37cf:b0:493:bc97:916b with SMTP id 5b1f17b1804b1-493c2b986cemr52219795e9.26.1782944291279;
        Wed, 01 Jul 2026 15:18:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4da247sm104154245e9.7.2026.07.01.15.18.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 15:18:10 -0700 (PDT)
Date: Wed, 1 Jul 2026 18:18:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: linux-kernel@vger.kernel.org, Miaohe Lin <linmiaohe@huawei.com>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Oscar Salvador <osalvador@suse.de>,
	Andi Kleen <andi@firstfloor.org>,
	Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
	Rik van Riel <riel@redhat.com>, Vlastimil Babka <vbabka@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Brendan Jackman <jackmanb@google.com>,
	Johannes Weiner <hannes@cmpxchg.org>, Zi Yan <ziy@nvidia.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
	Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
	Lance Yang <lance.yang@linux.dev>,
	Christoph Lameter <cl@gentwo.org>,
	David Rientjes <rientjes@google.com>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Harry Yoo <harry@kernel.org>, Hao Li <hao.li@linux.dev>,
	Kiryl Shutsemau <kas@kernel.org>, Byungchul Park <byungchul@sk.com>,
	linux-mm@kvack.org, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 0/2] mm: memory-failure: fix HWPoison flag race with
 non-atomic page flag ops
Message-ID: <20260701180511-mutt-send-email-mst@kernel.org>
References: <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
 <20260701043024-mutt-send-email-mst@kernel.org>
 <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
 <20260701112946-mutt-send-email-mst@kernel.org>
 <a353c28c-a864-456d-9b00-7f6a932cda73@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a353c28c-a864-456d-9b00-7f6a932cda73@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7hNEXmLAdo6NwGd7CAabrH2KgP5CTr3NT3L4fv3oAGU_1782944292
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 06:17:23PM +0200, David Hildenbrand (Arm) wrote:
> On 7/1/26 17:54, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 10:36:31AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 10:33, Michael S. Tsirkin wrote:
> >>>
> >>> what do you think ;) post it?
> >>
> >> As RFC please :) [and if it's AI generated, obviously properly reviewed and
> >> reworked by you]
> >> -- 
> >> Cheers,
> >>
> >> David
> > 
> > Not "generated" surely. But assisted, yes.
> 
> What I thought.
> 
> > Still hacking on it, but the difficulty
> > with memory-failure is that fundamentally, it's not 100% robust.
> 
> It's all a bit slapped on top of everything, yes.
> 
> What I was wondering is, assuming the call_task_rcu() and it takes forever,
> there might be quite a while where a hwpoisoned page that lost its bit is not
> marked as hwpoisoned.
> 
> So you'd actually want the one doing the test_and_set_bit() caller to wait until
> the bit is stable.

not sure I get it.

> But that should be rather hairy as well. :(
> 
> > 
> > For example, we have a fifo fed by hardware and consumed by a workqueue:
> > 
> >         struct memory_failure_cpu *mf_cpu;
> >         unsigned long proc_flags;
> >         bool buffer_overflow;
> >         struct memory_failure_entry entry = {
> >                 .pfn =          pfn,
> >                 .flags =        flags,
> >         };
> > 
> >         mf_cpu = &get_cpu_var(memory_failure_cpu);
> >         raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> >         buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
> >         if (!buffer_overflow)
> >                 schedule_work_on(smp_processor_id(), &mf_cpu->work);
> >         raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
> >         put_cpu_var(memory_failure_cpu);
> >         if (buffer_overflow)
> >                 pr_err("buffer overflow when queuing memory failure at %#lx\n",
> >                        pfn);
> > 
> > 
> > if there are lots of these and the scheduler is slow and it overflows,
> > it's sayonara you have lost the flag, right?
> 
> I guess so. I assume on relevant hw you wouldn't expect a storm. But who knows :)
> 
> > 
> > 
> > Oh and by the way, I just noticed that when buddy merges pages it does
> > not check the poison bit. So it looks like there's a simple way to lose
> > the poison bit - have it merge with a non poisoned page.
> 
> When we poison, we try to take the free page off the buddy. At least that's what
> I remember.


Yes but not immediately - we set hwpoison then we try to take it off.


> So I think we would just then go ahead and split the free higher-order buddy
> page to remove the single page.

Later we split, yes. But I don't see where it sets HWPoison after
split - it calls
SetPageHWPoisonTakenOff but it seems to assume HWPoison is already set.

Am I missing something? It's late here...


> 
> -- 
> Cheers,
> 
> David

