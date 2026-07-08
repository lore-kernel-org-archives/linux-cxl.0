Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBE121F4181
	for <linux-cxl@vger.kernel.org>; Wed,  8 Jul 2026 13:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515619; cv=none; b=lxyuXUdQnIvKU1GEYmFHzDuvBx2YWpcElC5HPXHU/KPxhswTJTclsZwCq4a2aB6fVL6Rs4FNIFokHIdHGir4OZ1s1zdi1DAsPq48U/7G/GYerqfERoC6LaOe++PZDsGE4jMa6FXWsiwusHx9bpVm9ZyryW5Mrda8A+E26/5ljfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515619; c=relaxed/simple;
	bh=8TnT3cGzhgFtS9Xuu2VMgPRHUgC5kqQMxAr2Q9rBdoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=oXirgucvDX5MXWPb4L6srAcyqU/QTikXaw8zK0u03lkvcjzVPd7+V3YDEhOwiBOvQQcmFhJy63DDenHqSEXnFVmvSy3JjavS0axOHTRlQns9FH8gyRd14DRrGSNRxhA6F7eDMFfz5myGIFclimYXred4ueqmZo/NLqnC12FvKUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DSZyg+Py; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DSZyg+Py"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783515617;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l1nxHUHuYBD2sRGWeQWBd/Pf2pEVUcm+cL6w6ahUDa0=;
	b=DSZyg+Py6Xno846+1QVp68JnpT30SBr+C2eWDAK5gSZOeUjU2WIhSwvgvB6BV/p69nVm+D
	hrG5Whu5grnjBXRzRNFCSAWxYuPfsW4fRtfUpRn09Yv20fjLl4D1ZuvwVEqhf3/6ZJhF6y
	eGCn2k6vKwORbT1r5iAOs8SqVUhf9Mw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-PBIFXvI5MPeqE-WwcPz9Ew-1; Wed, 08 Jul 2026 09:00:15 -0400
X-MC-Unique: PBIFXvI5MPeqE-WwcPz9Ew-1
X-Mimecast-MFC-AGG-ID: PBIFXvI5MPeqE-WwcPz9Ew_1783515615
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15d4bd2afeso42541066b.3
        for <linux-cxl@vger.kernel.org>; Wed, 08 Jul 2026 06:00:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783515614; x=1784120414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1nxHUHuYBD2sRGWeQWBd/Pf2pEVUcm+cL6w6ahUDa0=;
        b=eaJ3RFu8VVuvqupzPf5fk+19Yg9liM5ZHWzl6hn8gC4ZF8GLe+NmmSRK3WtmX6EV4v
         AQL11BpDFF4ciCTe67UMOPa3d8UZvdKgIIQJmOgic6K9qlYohASwljrneYLDcnFwM8uA
         AowxfnDMRFv7DI6U3M95/TThRyVThLM39lo9gl/zwdM2IT+dbDhrejgLK90bgvHvQESA
         AunGF/Pd84iGf+lk/Qsucj23rbFOxbhvOLRtOa7N4L7j45xvPSV4+BGbaLXRPW4Od6I6
         ac8+vDVXHDZOL64PNlIN+gCYruilVrDqCpoJrlJz1427wwuya7F4qiHAPhHCvlGLPW8x
         2ARg==
X-Forwarded-Encrypted: i=1; AHgh+RpzKaG+IGyi0kr+lxAL9fSeVQxiN9D7wiXci4u8shlmTyseCdDuyrFSJFX/L9wIKMnEHBVAAeQp1RI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvxgGiCujFtkLsEwcy6izpduTT4psGs1KdJ3G6rlvhFbdAYSoF
	OPRsZyW1d59Gsg//Xk4sdn6hN4o8bD5CTnq5E2nta5DAWs004Uct2DLGfjxjN94bC8ju1eFkBtD
	D/WlGfk2AZ7mOcfNMcRxiQRE4xAfQVptnk89dp8keFPDkfY1q2nMnfC6GwZS25A==
X-Gm-Gg: AfdE7clQzXrW/Soeygyzy3S8kij/K57QZHvtQo8aDooLV8GuRaKSwNPhD3AAUoX+WHA
	1OKZlCxHszw5iOFNRH0TnP+Vj3JkVLP8MSyhmpU23Rex67/DqMMcMs6+/VFgkyPw6BbCUcr9/Em
	R8NTTG9AHSsBBWf1h/w6KxQ525BGjA1/fFw+J35ne0JjkAaViAcw1zd+QfjKY/mDsYT+ipO9YZ3
	2gxZzziG+ozF7mh7BH1FaqRksUvcJNVxSekG2SXzbYjyUDtS6+1m/qInEexePRWfDsFITm/xrsS
	DAYvNDjV4tKq1tHNBKdf0dWA1VbxmhP29b9zrF1KhsfFI2b9bCSlCN3AcddSbTHnB9yG/fyXIkP
	51imjlgfDJKZucH+UvhcexZ7RfEGnfTeD
X-Received: by 2002:a17:907:26c1:b0:c12:7e24:a76f with SMTP id a640c23a62f3a-c15ce025ae4mr111217966b.20.1783515612908;
        Wed, 08 Jul 2026 06:00:12 -0700 (PDT)
X-Received: by 2002:a17:907:26c1:b0:c12:7e24:a76f with SMTP id a640c23a62f3a-c15ce025ae4mr111210366b.20.1783515611401;
        Wed, 08 Jul 2026 06:00:11 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c15ddb9e1d2sm6630866b.52.2026.07.08.06.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 06:00:10 -0700 (PDT)
Date: Wed, 8 Jul 2026 09:00:05 -0400
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
Message-ID: <20260708085745-mutt-send-email-mst@kernel.org>
References: <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
 <20260701043024-mutt-send-email-mst@kernel.org>
 <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
 <20260701112946-mutt-send-email-mst@kernel.org>
 <a353c28c-a864-456d-9b00-7f6a932cda73@kernel.org>
 <20260701180511-mutt-send-email-mst@kernel.org>
 <6b0f028c-574b-4b80-b803-2bff15a5a148@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <6b0f028c-574b-4b80-b803-2bff15a5a148@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ivGyNXnip7oBASLL9i7XZO90G3UlqBwU_8TddXBick4_1783515615
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 08, 2026 at 02:13:27PM +0200, David Hildenbrand (Arm) wrote:
> On 7/2/26 00:18, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 06:17:23PM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 17:54, Michael S. Tsirkin wrote:
> >>>
> >>> Not "generated" surely. But assisted, yes.
> >>
> >> What I thought.
> >>
> >>> Still hacking on it, but the difficulty
> >>> with memory-failure is that fundamentally, it's not 100% robust.
> >>
> >> It's all a bit slapped on top of everything, yes.
> >>
> >> What I was wondering is, assuming the call_task_rcu() and it takes forever,
> >> there might be quite a while where a hwpoisoned page that lost its bit is not
> >> marked as hwpoisoned.
> >>
> >> So you'd actually want the one doing the test_and_set_bit() caller to wait until
> >> the bit is stable.
> > 
> > not sure I get it.
> 
> Essentially, I think that after you set the bit you'd want everybody else in the
> system to see that state before you continue.
> 
> Such that other code that tests for poisoned pages would just immediately act on
> it. Like the buddy not handing out such a page anymore, immediately.
> 
> At least that way it's easier to reason about. Losing these bits is really just
> nasty :(
> 
> > 
> >> But that should be rather hairy as well. :(
> >>
> >>>
> >>> For example, we have a fifo fed by hardware and consumed by a workqueue:
> >>>
> >>>         struct memory_failure_cpu *mf_cpu;
> >>>         unsigned long proc_flags;
> >>>         bool buffer_overflow;
> >>>         struct memory_failure_entry entry = {
> >>>                 .pfn =          pfn,
> >>>                 .flags =        flags,
> >>>         };
> >>>
> >>>         mf_cpu = &get_cpu_var(memory_failure_cpu);
> >>>         raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
> >>>         buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
> >>>         if (!buffer_overflow)
> >>>                 schedule_work_on(smp_processor_id(), &mf_cpu->work);
> >>>         raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
> >>>         put_cpu_var(memory_failure_cpu);
> >>>         if (buffer_overflow)
> >>>                 pr_err("buffer overflow when queuing memory failure at %#lx\n",
> >>>                        pfn);
> >>>
> >>>
> >>> if there are lots of these and the scheduler is slow and it overflows,
> >>> it's sayonara you have lost the flag, right?
> >>
> >> I guess so. I assume on relevant hw you wouldn't expect a storm. But who knows :)
> >>
> >>>
> >>>
> >>> Oh and by the way, I just noticed that when buddy merges pages it does
> >>> not check the poison bit. So it looks like there's a simple way to lose
> >>> the poison bit - have it merge with a non poisoned page.
> >>
> >> When we poison, we try to take the free page off the buddy. At least that's what
> >> I remember.
> > 
> > 
> > Yes but not immediately - we set hwpoison then we try to take it off.
> > 
> > 
> >> So I think we would just then go ahead and split the free higher-order buddy
> >> page to remove the single page.
> > 
> > Later we split, yes. But I don't see where it sets HWPoison after
> > split - it calls
> > SetPageHWPoisonTakenOff but it seems to assume HWPoison is already set.
> > 
> > Am I missing something? It's late here...
> So, we set hwpoison on a page and that is sticky, even when the buddy merges
> them, right?

right. bar races but that is separate.

> When handing out pages, the buddy will check all pages through
> check_new_pages(). If the poisoned page is part of a higher-order page, that
> would still find it.
> 
> So I would assume that the hwpoison page->flags stays there, and
> PageHWPoisonTakenOff() only tells us if we succeeded in removing the page from
> the buddy ourselves.

Right, I see.  Btw in a bunch of paths even if
we unpoison we lose the page, right?
And it seems we can also lose a hugepage just because 4k in
it got poisoned?
Is that expected?

> 
> -- 
> Cheers,
> 
> David

