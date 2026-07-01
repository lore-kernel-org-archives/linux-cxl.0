Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1213A48D5
	for <linux-cxl@vger.kernel.org>; Wed,  1 Jul 2026 08:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782893900; cv=none; b=SinqqbikfuunbeqxT197SdowBNJ9rx2aIkRz6J8TJODmUTfrwgJJlzj/03cIZ0bQ/GYY9WtfObnA8qaQze7zwE8vFvhBz8IktoIf7bN84l0k6nzBAUnoM9ysoI0IOM+zF1EO0cWNBGvXKUph+6nGa3vsl7nlJUTaWrJYE+jIpRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782893900; c=relaxed/simple;
	bh=+4KHaDE8WyQsJBn+HCZedPT6aLi5fPXZfGOgH74DULY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sCpmavHYS7aXG+7YV8Z50eW+THj8DBIwOMHNd/ZWCRiK6NXMVY1CK3uhFxhk8eOCpD9jYoYCbUjGBbZdIdbss0vGI9QPSXl3UXpengBnpxXGSJLRhKa/SJ8hpK49nsD8qW5JjRaDP8nhb7rSVoYlyrFV21tKDZg9FN8mOi9i+5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rv+M82k2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rv+M82k2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782893897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LmfLTmWYgd/3XHF3IWN+KkX93s3f/MCewHSC/ez+FP8=;
	b=Rv+M82k2KUEAEzOHf+DZ+/Ku1vpr4Dp+G8ilzN/ekRunUPNI31QfJeDxg7rjXyL0yf3Tf1
	2X/h2TtnA5e4WeuPIawsH2crKQzc7I8KS2wuXVLFJtPCM+lwP5g7bJ6tK3LVUBJVOwXUN2
	eru0q9oO9x6TizBGLId+DVlJqCrPNNo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-422-ou37C-yPP5u-BSpQWd1hJg-1; Wed, 01 Jul 2026 04:18:16 -0400
X-MC-Unique: ou37C-yPP5u-BSpQWd1hJg-1
X-Mimecast-MFC-AGG-ID: ou37C-yPP5u-BSpQWd1hJg_1782893895
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47127ee7e07so207803f8f.2
        for <linux-cxl@vger.kernel.org>; Wed, 01 Jul 2026 01:18:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782893895; x=1783498695;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LmfLTmWYgd/3XHF3IWN+KkX93s3f/MCewHSC/ez+FP8=;
        b=dcvORQMkulOsEI1v8hbpj3LVX1nTcePPViouN+eDN/eeXWXe/w/qHhZ6Z/Rh99SV5N
         d9pkBh4WS3vMoJICl3jUGVLPWVc3HWRbzkYFtnnOXKsM1KMWAQ+HKKNdNw9u/Ob5Y3a+
         rs0O9zulYQwIB9frFHB66ihsWyM0c1RDjnDGaXCaRAd1DvmqDLYhXrqVCRv8pITAQCmo
         js21NZTJf59lxwj2DtpBb6ALoPIYOWt+SrPa6mOAVy0H/+UuW3z7WZng71yua4VdKxf0
         wHBMkkUdOHj4JwOw5TiSqnox8FDCy7qqCNZeWim98vVvMW88zCvpKDgX7ld4fHbyziFI
         91Tg==
X-Forwarded-Encrypted: i=1; AHgh+RrQQFUNf8mQ/+ufRNaLk5lealt8g29JIJZJhX2+3iNtrJZpf+nb9D3+dKPm4ehA20vA740DoX45WRA=@vger.kernel.org
X-Gm-Message-State: AOJu0YymSl9aQxb28b9P/W48tXgihcNwvTboQB9ncZlfQa7A+uLYjcJo
	Og3KFLs5wtaD5hEg3BFd/QMrNwwb0G9FfF0BTDidIdppd31NhIZUxcGVBbU71qJHuLI5dJEjn9Q
	r0q1ltAlkg30pMqetm+RdNeQmkoXVo9QhSWCoh6cXGQzHCZRciBk37s48ehvE8Q==
X-Gm-Gg: AfdE7cn4exQV7N7yOJfTLVFshJ8xUi7xGZEaUq7OHoAdtlxVZO9t3gXjyWH7ImgJELy
	weaBAtr9V0dp9iYgg6xAukKcPxVV2gTEMCBZI5ZSb7XyeXRtbSgEwPku9jWxksGhCW6v/WYiwgA
	W6QAxQXOVPWAmfDLVrZQj+1+6bsCvd0c7Q9LQAtLkVO+wVvpNS7HIF1GWp8EhXIgQISbVwgkzTu
	ax6Jsv76X63uarPGIx5KzOzk6WObFnF7iqsZidXhDErJnivFRKPM5zIMUzPLmom9Qo3ffMkBNmn
	YrjYquJp3a38x+6PgkI3zc1Pyq78H37tTC0mN/63CfQ/9uNrXZ3TIrKQAwA7Nx8mh89ZRuyVjpX
	Yjcj+H+3M0Mw3C/+4Bs8eZpqlmMMB0g6p
X-Received: by 2002:a5d:6e46:0:b0:472:6602:3347 with SMTP id ffacd0b85a97d-47759754d45mr731597f8f.43.1782893895113;
        Wed, 01 Jul 2026 01:18:15 -0700 (PDT)
X-Received: by 2002:a5d:6e46:0:b0:472:6602:3347 with SMTP id ffacd0b85a97d-47759754d45mr731560f8f.43.1782893894571;
        Wed, 01 Jul 2026 01:18:14 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47567a6f351sm14961756f8f.36.2026.07.01.01.18.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 01:18:13 -0700 (PDT)
Date: Wed, 1 Jul 2026 04:18:08 -0400
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
Message-ID: <20260701041112-mutt-send-email-mst@kernel.org>
References: <0b5f8b4b-d7dc-4b79-9555-a5b36265f3a9@kernel.org>
 <20260629030657-mutt-send-email-mst@kernel.org>
 <4f5ba5d6-246c-4430-9737-e8dd8e4c5142@kernel.org>
 <20260629092856-mutt-send-email-mst@kernel.org>
 <54c8cbee-9b26-458c-93ba-5aa594f5d1e8@kernel.org>
 <20260629174225-mutt-send-email-mst@kernel.org>
 <cbab829a-3e65-4b4f-a2e2-704e88a611a0@kernel.org>
 <f6d8354c-2f79-4a48-934c-cbeb335765e2@kernel.org>
 <20260630174852-mutt-send-email-mst@kernel.org>
 <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <2f884bfa-3cd5-4fba-8aa4-c2e68890ab64@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DRW_ijBEImO7O3RnHm313Otf3tNk601yMYlERGJ-6qg_1782893895
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jul 01, 2026 at 10:08:45AM +0200, David Hildenbrand (Arm) wrote:
> >> Cheers,
> >> 
> >> David
> > 
> > Yay. I did that + dropped the extra lock/unlock and now it's in the noise in
> > my testing. needs much more testing of course.
> 
> Cool. I'd expect that latency-sensitive workloads (PREEMPT_RT) would not want to
> have hwpoison handling either way, so using the no_resched variants at these
> places might be doable.
> 
> > 
> > If you want me to post (including addressing your other feedback) let me
> > know.
> > 
> 
> Let's first discuss the options. We essentially have the following one so far:
> 
> 1) Ignore the problem
> 
> It's been there forever ... but I am not quite happy about that.
> 
> 2) Use atomics everywhere
> 
> The easiest+cleanest, but as measured, the performance hit is real.
> 
> 3) Keep retrying for a couple of times
> 
> The big problem is "how long". A CPU in a hypervisor might be stalled for quite
> a while (20s? can be longer).

So on this idea. It might not matter. What I had in mind is:
1. run the current logic
2. add page to a list of pages to check, then invoke e.g. call_rcu_tasks
   (or call_rcu_tasks_rude) maybe
3. in the callback, recheck and if poison cleared, go back to 1
4. otherwise everyone will see the bit set, remove from list we are done

it seems to not regress anything, and for the rare race, we set
the bit eventually.


> 4) Disable preemption around non-atomic updates + synchronize_rcu() loop
> 
> I think it should work, but I don't like the possibly endless retry loop. (well,
> it would never be an endless loop in practice)
> 
> Is there a problem with synchronize_rcu() latency, given that it can take in bad
> scenarios a couple of seconds? (grace periods can be large ... but also very short)
> 
> 4) disable local interrupts around non-atomic updates + let all CPUs perform
>    atomic setting/clearing of the bit through smp_call_function_many().
> 
> Disabling local interrupts is way too expensive. :(
> 
> 5) disable preemption around non-atomic updates + let all CPUs perform
>    atomic setting/clearing of the bit through schedule_on_each_cpu()
> 
> Mixture of 3) + 4), but schedule_on_each_cpu() can also possibly take a long
> time (as long as we cannot schedule on a CPU ...).
> 
> We could likely build something that remembers all pages with bits-to-set /
> bits-to-clear, to then kick off a per-cpu work ... and once all CPUs processed a
> page it was fully processed ... needs much more thought.
> 
> 6) stop_machine()
> 
> Big hammer. I think we'd still need to disable preemption around non-atomic updates.
> 
> 7) Move hwpoison bit out of page->flags
> 
> Use a sparse bitmap. Quite invasive, and any hwpoison bit checking code would
> get more expensive.
> 
> 
> 
> Did I mess something up / forget something?
> 
> > Or look into call_rcu_tasks/call_rcu_tasks_rude which might work without 
> > changes in mm.
> 
> Looking into call_rcu_tasks() (the first time) the semantics are interesting
> ("involuntary preemption is not a Tasks RCU quiescent state").
> 
> I'm curious how this interacts with random page allocations (on the IRQ path?),
> and which design you envision given that we only get a single callback (who
> prevents code to re-enter).
> 
> > 
> > Or if someone else is gonnu work on this, absolutely fine too.
> 
> I can likely let someone work on that, but I think we should first figure out
> what can really be done. (and likely when we send it out, it should be an RFC)
> 
> -- 
> Cheers,
> 
> David

