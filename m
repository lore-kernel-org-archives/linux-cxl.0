Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB41E3CBE89
	for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782769847; cv=none; b=KmOiH76rJQQ+wox+Spiargiir4WwA6WOnnr/tjTbki/IN1el8RvaQwh+fSkJLBiKiwpftmC/fw3mUzm9x4UVqI+VB3ArLWf8o3mQ1ZvbDVKmXyPG7OoQvHPi8XajII/Bazw4kprScTYixyMvHoBPCCxdaW2gdURthngYIonwFfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782769847; c=relaxed/simple;
	bh=eMS4e+Gb+yNoZwxOY/zCsJx6umB9gFs6bTWZ5VqPw9g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kJuu9uBX4SzZoPcnC3gjioRTzpmqjtxjlyHqeY3l1z74CQEGaP4gxkv1I/jKDjUlbQ7MHdPP/GJT/JB6F6+0qutfitc8LU0jqgZ/3pfV+s1nod4x+dILwSni5i/+ud9+UaLcjACs5sA2yo20pgIzYmy3Ak5cg2mhCDH0/KboJD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PcQNpJ8w; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PcQNpJ8w"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782769845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=j1BSh5W1gPjYMhKd19XJgXfbVBqQZUI73y0mmOWCqSI=;
	b=PcQNpJ8wWjuyzmkNXutE+SGi3ydkkp3er7SSzoUYujqUTgsvCSDqWHfLWcWi7mbC/u0G7z
	XvqEUC9iDtlbzjZ+fabLr4GWGRe/Eov19B/B76+j2v5x2csL+HITZ+JFx6Lp2EIC0g7rBc
	VnI3EOSkPabRBlUJTI9v2a75hBzALdc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-176-MLCXb_UBNfWY1wQFPdLUsg-1; Mon, 29 Jun 2026 17:50:43 -0400
X-MC-Unique: MLCXb_UBNfWY1wQFPdLUsg-1
X-Mimecast-MFC-AGG-ID: MLCXb_UBNfWY1wQFPdLUsg_1782769842
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47416fc1674so876749f8f.3
        for <linux-cxl@vger.kernel.org>; Mon, 29 Jun 2026 14:50:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782769842; x=1783374642;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j1BSh5W1gPjYMhKd19XJgXfbVBqQZUI73y0mmOWCqSI=;
        b=DCd4llSeFj3WInYMqDLKJXyDkweAh4CLzmbZTt1z6uNmwAX/CCVKbFFnxU461vmZJD
         WsZ0+lWGwuYl8MphwNTOe0LjtU7itIcRY4xjXnH0my6tQem1zKFCJWlaSQhwUyjtgS/Z
         vs8qmc10OoMPfkMW1upL4lneT7uouhx6W6myvtARM/mB/HPvSf+KsY0wDB5m5qargdz6
         TeCSw8AKyTSLUNqQm7mgUVyjhSM0KNsf/DslUpniSMzzH77x/0oVw4GA5NIwiRWCYakX
         kfe+kWhDTrEE8m9C0NtnUGA+HJApmzUlk+/5ELdBDmNslCiRRSq/HuoFtW3dygEY5eYu
         QGQA==
X-Forwarded-Encrypted: i=1; AHgh+RrinCR7O1RwMiKwPuOUXHUnG4W7O64ZatXbPkTJnzaAaPrl0tnl5UnN1J3b+4ZgkVeic4uQBI+WfOY=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjkRJSMewpoLyISTcumJTN+UV5tmQWAvo0GU7keLS4Ilip+bOq
	Lrtii9cNGOhRVeV8IZygns3IuBsHXxNYReld0icw6qU0hUFpUjNCPwUS3SNBuymxRFVgpXSP25q
	qHqGPgi2+E0hJ3RVjpE1DELl0TUPqPx3B6GLT01Ggl/Zo0RQkdjYbJT2Xe9jRXw==
X-Gm-Gg: AfdE7cljeArDEFmcL1o0vlgFG6RSG35Weat3nkABw+cfHQK4NbLCo9qVHJj8bXFFw7P
	q2MrH9aMtAzWdcya6ZKPEp9hzCc5TSOW/lu9XMVrGJdpRF6er6dbdC/JPp/twReIjD5FMoqaRVT
	a0zf3vHw6FkNMdx0EPaoUvLmlt57FH5XM7NCZn7h9gQtwlAkcIN4eM2HXX2uUKWDMTk68s+kRi1
	+h9VQn9X2bZ8I/YH6c2WJE/gS0i4QWRAkrFmHinErKyxESIXuJVyjjAz4KD//4JEYePZZNtD8Ub
	0UtNPuF++ZQr/jMSbt1EL2iV8Agc9NdUmXNdLOzhSoI0/TWqKxkJrsUu91E/n+6iTxPpNcuHWfO
	OILT286o/iYriz/yyciMHLcPlCWTnlW7O
X-Received: by 2002:a5d:5d8a:0:b0:474:9991:60d0 with SMTP id ffacd0b85a97d-47550cabbbdmr1238860f8f.12.1782769841916;
        Mon, 29 Jun 2026 14:50:41 -0700 (PDT)
X-Received: by 2002:a5d:5d8a:0:b0:474:9991:60d0 with SMTP id ffacd0b85a97d-47550cabbbdmr1238829f8f.12.1782769841353;
        Mon, 29 Jun 2026 14:50:41 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475674af239sm1206001f8f.30.2026.06.29.14.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 14:50:40 -0700 (PDT)
Date: Mon, 29 Jun 2026 17:50:35 -0400
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
Message-ID: <20260629174225-mutt-send-email-mst@kernel.org>
References: <cover.1782676497.git.mst@redhat.com>
 <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 4WrJ6gP6wg5tanhwAXu_Hu0A7LtGy1C-chYh8gvenVc_1782769842
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 29, 2026 at 11:22:11PM +0200, David Hildenbrand (Arm) wrote:
> [...]
> 
> > 
> > And again, I'm really not sure fixing a theoretical race when memory
> > is failing is worth slowing the world by 0.1-1% for.
> > 
> 
> Fully agreed. I was hoping RCU was cheaper (I mean, we were once told that RCU
> read side locking is essentially for free ... well in some configs :) )
> 
> The question if we could optimize it reasonably enough ...
> 
> > 
> > From what I saw in my testing, if we allocate 4k pages
> > it's hidden by the overhead. With hp and thp it's measureably
> > worse than rcu on !preempt config.
> 
> ... for example, by doing the rcu read lock + unlock around the
> 
> 	for (i = 1; i < (1 << order); i++) {
> 
> loop on the alloc path.

Is this different from what this patch is doing?

        if (unlikely(order)) {
                int i;

                hwpoison_rcu_lock();
                if (compound) {
                        page[1].flags.f &= ~PAGE_FLAGS_SECOND;
  #ifdef NR_PAGES_IN_LARGE_FOLIO
                        folio->_nr_pages = 0;
  #endif
                }
                for (i = 1; i < (1 << order); i++) {
                        if (compound)
                                bad += free_tail_page_prepare(page, page + i);
                        if (is_check_pages_enabled()) {
                                if (free_page_is_bad(page + i)) {
                                        bad++;
                                        continue;
                                }
                        }
                        (page + i)->flags.f &= ~PAGE_FLAGS_CHECK_AT_PREP;
                }
                hwpoison_rcu_unlock();
        }
  


> But I suspect it's not going to make that much of a
> difference.

It makes a difference! Just not enough to make it completely unmeasureable.


> I concluded, similar to Andi, that stop_machine() is too big of a hammer.
> 
> I wonder if something could be built out of preempt_disable() and sync SMP
> calls. hmm :(

rcu_lock is basically same as preempt_disable if rcu is non preemptible,
no?


> -- 
> Cheers,
> 
> David

