Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766BD48C8CE
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 15:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782921265; cv=none; b=q1Dg0T1AOJ4okrlI6LZCWXpL8UPc6LzTNS9uH1065mu9RYkD2AhgsMAQAfXY1vPWXypeBR8GHuY72iOE4RNA+s9qMwBeOwd33ur6kE8vxpIGJjHvqpv5KoObslUQkBUUumDFnIbYG7GSOy3kQzmLgHvNoj98UVtz1JcScHSNqj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782921265; c=relaxed/simple;
	bh=Xiv8a+MHhH8J6rT1nMbNrm50OA23p3Gi0rYDhopodjQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=mt4wBWrGG4PpY5cgcg3+AYyX+fVyGgBvNDKLDwgkqVBca2nBE9v/dVJzDeO+EnzlBypiNcBIF7C6f/Y28MV6nJZ2AefkKGarJT9hgyz+SYnPE6sTmK7FPhWTXqYVRMqigqkXg3cTSZU1hlkR5jRRs47JIlHNsSIJ1sElGax6uH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=A7iWcg2s; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="A7iWcg2s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782921263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQqt/bByGpZMVaTV47GrHV/MzFjAQYvcctbsvrjGHwc=;
	b=A7iWcg2s15SWrCLcvcL5iL1gvKcnPUTcPu81VdD+E641LEKd059mPI9Sd3CKaEN/VOI1Md
	Bq1/22pBQMlFb+LjwWshCSa6zvs6osx2wvl+a8KfS1/fkjdRbbF4BFIsIo18L56PB0/TMT
	1XWyau9FvnN2vOPeYXGebjiEtcdfMvs=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-320-AOw7T7YmMhysISjrpO5v1Q-1; Wed, 01 Jul 2026 11:54:22 -0400
X-MC-Unique: AOw7T7YmMhysISjrpO5v1Q-1
X-Mimecast-MFC-AGG-ID: AOw7T7YmMhysISjrpO5v1Q_1782921261
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493c1bc7a70so8092855e9.1
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 08:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782921261; x=1783526061;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQqt/bByGpZMVaTV47GrHV/MzFjAQYvcctbsvrjGHwc=;
        b=Z0ZlK32P8sli+wt2I8s4pxASQ4/MZac5U9z5iiVUELFXRs+0k/Kj0u35nAQlQchAec
         mdiwk4vP9kMRSVk3+6QTE8uq++0S0HfkaNqZxW8bij4UD0mO5loVg126Q9KBOIT7n84L
         o+uCQcRlVS3mth16WSbTxsM2EAx01qHYp9gd79KC4kEORs2SHg5WpD57moNB0YvDPNAw
         AIJzsKNh50TpS6r0cflSsMsS3fji7XY+HUCd2Z6g0YI/uxGg7Hg2hxaDldJPTP/RovgX
         Oh6p1Dm5pIi3odOFP0ftnWw5uu5fa6JJZl332SIJw9Qrs6ZtZPocYr/LIjthN9QGz5Ii
         z6fQ==
X-Forwarded-Encrypted: i=1; AFNElJ9uD29nmId7GGjquvlZhB9O0mhZ6WcuChtUa2vH8qUAL2IeTxk/PYXVaUb2b8gtyXGf63S6jWYHb84=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCKGiIv8GbAvdAv9rCHYVoxaVJzhak7+vlqbPh3ec1goAKoAfz
	W5kBD+aeCk1xlQ4a5xlEYokvm3giBemhDZXPn4xCwrinYY6pM289Z4CJ3Gv5TjLTHXii7h9G3F4
	1UyO+jxcmhbtMivubxe6z/EGmKOkoOyJoAm2+CUjluiySnxgcvdcLBnw0UFcQkQ==
X-Gm-Gg: AfdE7ckUl9W+3PKQos4AWiV4Pm570kg+Alw1t6RxS26UR3jloHz8wx1XRAecMEoelZI
	HXmYTOz2HizOYmOqNRbvcXUly2LIa8IEDWdVUS6wf3MmIzr6fYJXNJ85mp5AvChFAUyZ5bbmApn
	pkfHAsYU1F3YbiRlMM2IXU1YU1+UgwXqfzxERRl6k6OTdTiP9KDXLDSpLIwDsI3L95LrBCbLjoN
	qyHSHtfZBprLAD+9twg74c+AQBT7rLmUr8eOSMnVFi8/hqL03TSDwz37VPjgs3Q7ZqEH6i2FbSD
	hrQSk7H/e/yAT6q809nf3Im/lbz0nC4gX8cSVtoWfUgOAm7KZhBXIhlOH9JBS+a6P4SLckRM4Gz
	Pve0jr2cF/iEqbLoJtWFDjVTih7htJQ29
X-Received: by 2002:a05:600c:3588:b0:492:59fe:4a15 with SMTP id 5b1f17b1804b1-493c2b84695mr28231765e9.24.1782921260962;
        Wed, 01 Jul 2026 08:54:20 -0700 (PDT)
X-Received: by 2002:a05:600c:3588:b0:492:59fe:4a15 with SMTP id 5b1f17b1804b1-493c2b84695mr28231295e9.24.1782921260379;
        Wed, 01 Jul 2026 08:54:20 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4c89ccsm95218855e9.4.2026.07.01.08.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 08:54:19 -0700 (PDT)
Date: Wed, 1 Jul 2026 11:54:15 -0400
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
Message-ID: <20260701112946-mutt-send-email-mst@kernel.org>
References: <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <20260629174225-mutt-send-email-mst@kernel.org>
 <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
 <20260701041112-mutt-send-email-mst@kernel.org>
 <d2ce93d9-c3d8-4915-a511-d08eb2c1b374@kernel.org>
 <20260701043024-mutt-send-email-mst@kernel.org>
 <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <c03ec696-d635-4c7f-8c77-89a439d9135b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TQF0xiqoG0ZqCtOUvqKfcLntBtWwqk8kYmhhLrqwxO0_1782921261
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 10:36:31AM +0200, David Hildenbrand (Arm) wrote:
> On 7/1/26 10:33, Michael S. Tsirkin wrote:
> > On Wed, Jul 01, 2026 at 10:26:26AM +0200, David Hildenbrand (Arm) wrote:
> >> On 7/1/26 10:18, Michael S. Tsirkin wrote:
> >>>
> >>> So on this idea. It might not matter. What I had in mind is:
> >>> 1. run the current logic
> >>> 2. add page to a list of pages to check, then invoke e.g. call_rcu_tasks
> >>>    (or call_rcu_tasks_rude) maybe
> >>> 3. in the callback, recheck and if poison cleared, go back to 1
> >>> 4. otherwise everyone will see the bit set, remove from list we are done
> >>>
> >>> it seems to not regress anything, and for the rare race, we set
> >>> the bit eventually.
> >>>
> >>
> >> So test-and-set (and friends) would also have to check the data structure that
> >> remembers bit to set/clear (and possibly update the data structure).
> >>
> >> That does seem doable. Do you have a prototype?
> > 
> > what do you think ;) post it?
> 
> As RFC please :) [and if it's AI generated, obviously properly reviewed and
> reworked by you]
> -- 
> Cheers,
> 
> David

Not "generated" surely. But assisted, yes. Still hacking on it, but the difficulty
with memory-failure is that fundamentally, it's not 100% robust.

For example, we have a fifo fed by hardware and consumed by a workqueue:

        struct memory_failure_cpu *mf_cpu;
        unsigned long proc_flags;
        bool buffer_overflow;
        struct memory_failure_entry entry = {
                .pfn =          pfn,
                .flags =        flags,
        };

        mf_cpu = &get_cpu_var(memory_failure_cpu);
        raw_spin_lock_irqsave(&mf_cpu->lock, proc_flags);
        buffer_overflow = !kfifo_put(&mf_cpu->fifo, entry);
        if (!buffer_overflow)
                schedule_work_on(smp_processor_id(), &mf_cpu->work);
        raw_spin_unlock_irqrestore(&mf_cpu->lock, proc_flags);
        put_cpu_var(memory_failure_cpu);
        if (buffer_overflow)
                pr_err("buffer overflow when queuing memory failure at %#lx\n",
                       pfn);


if there are lots of these and the scheduler is slow and it overflows,
it's sayonara you have lost the flag, right?


Oh and by the way, I just noticed that when buddy merges pages it does
not check the poison bit. So it looks like there's a simple way to lose
the poison bit - have it merge with a non poisoned page.

I guess maybe we should fix this last one.

-- 
MST

