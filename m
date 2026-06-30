Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5219315D49
	for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 21:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782856727; cv=none; b=ZaBluFH8gh1kT67Ici7N8etVN++ywq1UZSLjA/WSO/+RjcbkllxcKm4emDsorob3lL9v/SMzktlkzuT7D9but3iebBzpUq/TzH5tCIImfYqxT3pYdaIyXkyQj9o8B0CGlQl5ZHzIEb6NQBocJrALc/RL+S6/HorXGWn0d5+7fsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782856727; c=relaxed/simple;
	bh=pIA06d6RWeJhKSc3E7zOkhvNaqyUsTuEFjFFoLPce94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fckRibXjf5a8ekIZkH69xF/d7s5HUBUJoq8fPodBktGYNrHa86vuim3mLH6hM4hi3WKDq05vvzOFHS12CiLOoXFHMR7NHpuYJGlEAKuw6HvNjAkwSrCgCsFi6IIpOSTsrRz1jjAXWStCRdUhAp3QV8j81CBuNd+mS4gMjm32e7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=M5yFH4iv; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M5yFH4iv"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782856725;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=z3TpDHKeSg3hCaDbNSxrROf4Ku8OcMO3gdNHwndIgX4=;
	b=M5yFH4ivkKI3Nag4MChCsIw1x584D4ll9lQwvaoidrfI77KlHG2so2RiEREjmZzbKJmk+P
	5JA/NYueUrGNiTEHI4GzJ9N+6gNRTfSXnbK2BkHmp0LETSk06Oq9QcFJwOocrD8cjxzpqb
	Omkn8lK9e+91P5FqeJa4j9/UwA4sfDA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-O-WztCC1N8-1V5S1xzR4eA-1; Tue, 30 Jun 2026 17:58:43 -0400
X-MC-Unique: O-WztCC1N8-1V5S1xzR4eA-1
X-Mimecast-MFC-AGG-ID: O-WztCC1N8-1V5S1xzR4eA_1782856722
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4767036f8faso292538f8f.3
        for <linux-cxl@vger.kernel.org>; Tue, 30 Jun 2026 14:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782856722; x=1783461522;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z3TpDHKeSg3hCaDbNSxrROf4Ku8OcMO3gdNHwndIgX4=;
        b=EKEPrzLdaq/PBXOWi82EhQkxfO0/yC/tTxAk5VlsWwZ4nvuK6EgMPFj+hZnJ7wNNt8
         6oaBlHDRqnMOfux0YAGCPVFWL60BxzuNChhLuF/MuZR8v+cwR6gQ2QunwxDDG7QcN7N7
         swCBCF1RJTfRCIsu8XYhv0tbcTqmAALJKzX+CDV/JfI5h2Aq7Cg7kP5453AumHQnruEP
         EBx6ZJrLNYovOL+PUu3h8dG5TkMjQniMyAMAbomCqH0LAL3sVTiJtlXxQBI4902KPxM6
         Gpd7S1mM/ogQG/GzI3IYHvjiqw834n8dxBXV8BeglX8nCSrZStuzMvBZiWpGE6sG2n9I
         szww==
X-Forwarded-Encrypted: i=1; AFNElJ8qb36UINFbUb/gJBUHF4YtUrVxZ+AVmL3qQFNfhlH+/HyvvsdHR9QQ8Tdkv9jVx6blbhwUhRNlFtQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJ1m1abz7rlNTfMiEpMINbj8j1J4yxpZ+408c3UoDS3ywUKm3/
	Rs3TyH4s29M4qrwTHda9kUwg/CStQFe5p7JP5bJZoA00P2l2r41FDvo3G8+87EcIz/tE5+aa88F
	D4VIVlaSqOZ4eZfJw0l21EZ462EvrIK3GRZx4nySCMzYDL7XCoSGZ6haBfRhHqQ==
X-Gm-Gg: AfdE7cmXRcLLMB2287O8OIwZRb1/9EBT/oHyflmOlJ/zCBQghmLXNLm4lfs4cL2vd/w
	WACGkksxADgo3obFtZvOUcjIiDpxZeD6h0VUFLClY/9xldymJR9RRJQ3P79F12d86i/R9TzQ8qu
	YJya+8thoQ3pxu638RUMNOpE38cVWk85kYk5naXz2QX+BnSIfbkv95GttvITlIiZTB8qdDqqPLD
	vpoZ7rBHE0L7YiupI2xzsOmOHCqiXU2iGjBxuWnvyphLRK9TQ98fkLXBAlj0HMIpqm+Mo8EzW/+
	cQEQkvwMbQYaGEF1U5bTaEIy3ezLX1nRrpfayqCH+5dK2H6wOBMSEZzWuM6W0ugHhh8qkfLKVL2
	WsdK/clsj04OOf43Ez8Rz28PBFlvMcwVZ
X-Received: by 2002:a05:600c:83cd:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-493bda7e355mr34314775e9.34.1782856721670;
        Tue, 30 Jun 2026 14:58:41 -0700 (PDT)
X-Received: by 2002:a05:600c:83cd:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-493bda7e355mr34314205e9.34.1782856721167;
        Tue, 30 Jun 2026 14:58:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4bfdb4sm27279365e9.3.2026.06.30.14.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 14:58:40 -0700 (PDT)
Date: Tue, 30 Jun 2026 17:58:36 -0400
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
Message-ID: <20260630174852-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <20260629174225-mutt-send-email-mst@kernel.org>
 <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4-kzDXmAGgzK6SH0lFrZFpRs1XRdU9KbXDLMwFXxk68_1782856722
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 30, 2026 at 08:41:08AM +0200, David Hildenbrand (Arm) wrote:
> On 6/30/26 08:30, David Hildenbrand (Arm) wrote:
> > On 6/29/26 23:50, Michael S. Tsirkin wrote:
> >> On Mon, Jun 29, 2026 at 11:22:11PM +0200, David Hildenbrand (Arm) wrote:
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
> >>> loop on the alloc path.
> >>
> >> Is this different from what this patch is doing?
> > 
> > Ah, I missed that we batch this already. We could make it include the
> > 
> > page_cpupid_reset_last(page);
> > page->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
> > 
> > As well, to reduce from 3 to 1 locks.
> > 
> > So I guess there is potential for optimization.
> > 
> > [...]
> > 
> >>
> >>> I concluded, similar to Andi, that stop_machine() is too big of a hammer.
> >>>
> >>> I wonder if something could be built out of preempt_disable() and sync SMP
> >>> calls. hmm :(
> >>
> >> rcu_lock is basically same as preempt_disable if rcu is non preemptible,
> >> no?
> > 
> > Yes. See my other mail, I learned that preempt_disable() should likely just do
> > for our use case. So the preemptible RCU case would not matter.
> > 
> > I assume that's as good as it gets.
> > 
> > 1) Use preempt_disable/preempt_enable to protect
> > 2) Batch as good as possible in the page allocator
> > 
> > If the overhead is then still noticeable, there is not a lot we can do to handle
> > this cleanly I'm afraid.
> 
> FWIW, there seems to be preempt_enable_no_resched() that is a bit more
> lightweight. I'm sure there is some downside, but it might be worth a try.
> 
> -- 
> Cheers,
> 
> David

Yay. I did that + dropped the extra lock/unlock and now it's in the noise
in my testing. needs much more testing of course.

If you want me to post (including addressing your other feedback) let me know.

Or look into call_rcu_tasks/call_rcu_tasks_rude which might work without
changes in mm.

Or if someone else is gonnu work on this, absolutely fine too.

-- 
MST

