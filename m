Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F46271A94
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 06:27:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800851; cv=none; b=AIbWErBBQsRxyHQskHfEgga+4tLSIZHLfPdeIutUchWhWgMysUNuPTxfYtZxBK4Z105awNtCLKssdHYBwBFR0t4zzutBXbAZogxZE3YIkYLIuXPo12UXoUzx7J6bmCyAj7QcaxE558s/Eu1fvDVBWZCXXQlUS9mCN1O7mvxs4cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800851; c=relaxed/simple;
	bh=k7Y3i6gcUQFWQIhUxHIA18uLOLsRwKJaGLkiwpaIM+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=qnJSr7BtKJC8F4BWjT0vG1v3r+s0xpcgSQcbw3Z9EA2slTXA4cQRFC4guKHq9OMdAB8BnjFrjmLj+gLfTiHutr/XRtUUmzk0KO8KEMwMXpU46jLBpkl/bD3ZNn1g/3T3/kfEUVECqAVjgexCN5VPsoHB9ToTo+HM/VIFoyuL8Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O2ab3cAT; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O2ab3cAT"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782800849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=g85B6h0E6wmvIawCj3aK3oknIgQ+/nlCgtdjk9sHnt4=;
	b=O2ab3cAT8rPVgYh6trCvQBG1PdHB/GORqABT8unyUkt3+0OGHqRn7pX8FVVtMbDFaryuqc
	G2o1KvdsmVALnlCugR+3gmU8MFC+mQFApqP3JU1pgz8lPuZrlphRceruxVjt9iQEMwYNFU
	sROKWaVO2FAZNOJqO5QlaoLjmp8GIRc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-175--AW8gmE0OqmsgtRD-IkoRg-1; Tue, 30 Jun 2026 02:27:27 -0400
X-MC-Unique: -AW8gmE0OqmsgtRD-IkoRg-1
X-Mimecast-MFC-AGG-ID: -AW8gmE0OqmsgtRD-IkoRg_1782800846
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767c7dcso32861445e9.2
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 23:27:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782800846; x=1783405646;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g85B6h0E6wmvIawCj3aK3oknIgQ+/nlCgtdjk9sHnt4=;
        b=Mmo7C99hkjfWqDX3h8tQ8zxq7GzazOhfl+q6O2eetO0LRIngKZ4GeRHe5GMyH7n/DY
         K9hV7EzFqKCd1Vj05/yV/AXSx9w9JaJ2n5YyX9mmfWzOY/8+2uaC2i7C/tHdSPQ7s6sH
         OIEkaqIufCXovgbWkyseCOf4JOa57XDjkolnb7+Ki7QD99c0PF5i99VwkFvqF9Atpii1
         DPdUwCmV8u8LdKZHSfgiBVgJRkmhaI/KGksci+1DQueTfhWNbl4+Mc2olu1ZXB888Tkj
         lBmyNYkAgiqdxU4gNJWUBLD5tXvqioYbXBjEL6+WGTnOwgj4Xp6GyWa82iPZpik+wd1P
         mWfw==
X-Forwarded-Encrypted: i=1; AFNElJ+16RAH1EnPEHu+Dw9baxglkssF1fsz+L/aHvRL2EAwm4zU5iN0ZThDoQmgGR2auPuHuTeCR/c+uAk=@vger.kernel.org
X-Gm-Message-State: AOJu0YydDAhnXyd4hbI0xPho88/BnP5qRyFpd/scaWtTQKPNaPVjf/Sd
	WXOv78dWxvC3wMp9Rsw/vYFrKZm2FiFtMccNmfD6xQoVxhD+/Ii9tBJcDz4UNDBluhbizIEgVHQ
	Fxc1JyilO8qZudFquNmgUp5tLaiupnEUoIb9G4Bv93rwuAkJc7YScXbwbpg80ZA==
X-Gm-Gg: AfdE7clzzsH2aHzCVYxRMnNqjhBfFWj2EW9GkHHZFoifzeZnDH0Nngl4iIEMdxucn/0
	8ZCL56ng29pfIefbvNDZRL34ikoe9dxqZk+GCYFD379poYtH5Pl01hGI5D6ZtOL/n6VE41uiPfN
	4oeyn30KnSaWLZPS+OhQKWRisTrsDIpjy/fxoub7bCdzilLyBJyWdaFWW91LAtKJQR811BbDDJK
	+OM8czYOGFxBGZIXj1YtESu8rdTHsbKDxANJIVXbYG8fyGVxdT5aFwDUcK0W2juXczumgahvaUy
	EpzHk9tRusUtc7Mgevpnav30QaryiqSvo+w6CDzK5ulbJovCXtTd3ZgTs3q5n51m9bd0hBPXQqF
	amg==
X-Received: by 2002:a05:600c:a408:b0:492:5bc8:5e77 with SMTP id 5b1f17b1804b1-493b82b8b49mr23585455e9.29.1782800846079;
        Mon, 29 Jun 2026 23:27:26 -0700 (PDT)
X-Received: by 2002:a05:600c:a408:b0:492:5bc8:5e77 with SMTP id 5b1f17b1804b1-493b82b8b49mr23585075e9.29.1782800845541;
        Mon, 29 Jun 2026 23:27:25 -0700 (PDT)
Received: from redhat.com ([31.187.78.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bb4f174esm13896245e9.2.2026.06.29.23.27.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 23:27:24 -0700 (PDT)
Date: Tue, 30 Jun 2026 02:27:20 -0400
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
Message-ID: <20260630022129-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <0a309ed3-378e-4d88-95a0-65bf47c5496d@kernel.org>
 <20260629193347-mutt-send-email-mst@kernel.org>
 <5c8ca96b-381a-4fd3-a218-6aaa87a9a3b7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <5c8ca96b-381a-4fd3-a218-6aaa87a9a3b7@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 0IFizvNT-pVvqbQaRxwdYLR-baLExKSvsFG_gNaZnqg_1782800846
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 08:17:42AM +0200, David Hildenbrand (Arm) wrote:
> On 6/30/26 01:34, Michael S. Tsirkin wrote:
> > On Mon, Jun 29, 2026 at 11:43:32PM +0200, David Hildenbrand (Arm) wrote:
> >> On 6/29/26 23:22, David Hildenbrand (Arm) wrote:
> >>> [...]
> >>>
> >>>
> >>> Fully agreed. I was hoping RCU was cheaper (I mean, we were once told that RCU
> >>> read side locking is essentially for free ... well in some configs :) )
> >>>
> >>> The question if we could optimize it reasonably enough ...
> >>>
> >>>
> >>> ... for example, by doing the rcu read lock + unlock around the
> >>>
> >>> 	for (i = 1; i < (1 << order); i++) {
> >>>
> >>> loop on the alloc path. But I suspect it's not going to make that much of a
> >>> difference.
> >>>
> >>> I concluded, similar to Andi, that stop_machine() is too big of a hammer.
> >>>
> >>> I wonder if something could be built out of preempt_disable() and sync SMP
> >>> calls. hmm :(
> >>
> >> Scrap that, shouldn't work I think ...
> >>
> > 
> > Wait a sec, what about call_rcu_tasks? Use that and re-check the bit is
> > still set?
> 
> So, in essence the idea I had yestarday when it was late was the following:
> 
> Assume we
> 
> 1) Can have a way to guarantee that a function on a CPU cannot execute within
> our critical section (while updating the flags)
> 
> 2) We can request to execute a function on each CPU and wait for completion
> 
> I think we could just let each CPU execute our desired action (e.g., try setting
> the bit).
> 
> E.g.,
> 
> 	local_irq_save(flags);
> 	page->flags &= whatever;
> 	local_irq_restore(flags);
> 
> And assume we want to set the bit, do a
> 
> 	SetPageHWPoison(page);
> 	smp_call_function(set_hwpoison_smp_sync, page, 1);
> 
> whereby
> 
> 	static void set_hwpoison_smp_sync(void *info)
> 	{
> 		SetPageHWPoison(page);
> 	}
> 
> 
> The idea is (that needs double checking) that a CPU will execute the
> SetPageHWPoison() either before the local_irq_save() or after the
> local_irq_restore(). So it's own non-atomic update cannot get interrupted.
> 
> Now, IIUC when it comes to "how expensive is this" I think we have (cheap to
> expensive):
> 
> 1) preempt_disable()
> 2) rcu_read_lock()
> 3) local_irq_save()
> 
> 
> So the above wouldn't be better than an rcu-based approach we have right now.
> We'd need something that relies on disabled preemption only.
> 
> Huh, but I read that "anything that disables preemption also marks an RCU-sched
> read-side critical section including preempt_disable() and preempt_enable()".
> 
> So for our use case we should be able to use preempt_disable() instead of
> local_irq_save(). That should already work for your existing implementation.
> 
> -- 
> Cheers,
> 
> David

We have:

#else /* #ifdef CONFIG_PREEMPT_RCU */


static inline void __rcu_read_lock(void)
{
        preempt_disable();
}

...


static __always_inline void rcu_read_lock(void)
        __acquires_shared(RCU)
{
        __rcu_read_lock();
        __acquire_shared(RCU);
        rcu_lock_acquire(&rcu_lock_map);
        RCU_LOCKDEP_WARN(!rcu_is_watching(),
                         "rcu_read_lock() used illegally while idle");
}



So on non-debug build witout CONFIG_PREEMPT_RCU (what I tested), rcu_lock
is exactly same as preempt_disable.  It's relatively cheap but not free.


preempt_disable is not going to be cheaper.

I can test if you want but it seems clear.


But IIUC task rcu might be cheaper - IIUC it does not need rcu
lock/unlock at all, it relies on readers to invoke the scheduler
instead.
No?

-- 
MST

