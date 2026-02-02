Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F191533D6
	for <linux-cxl@vger.kernel.org>; Mon,  2 Feb 2026 13:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770037880; cv=none; b=tYpSJoJ1xhFEJaSNz6R1B4SaKSKJ7EXA4eW0IxYpJmhyFFkDLgUr9KAo18uZWLkX05wbvW0ttju0dLLXv1QbvmPR6RtxwXsuyPdAnAG7qz/CFWUyZfJvGtU5bSYk7QdNALtrI1rIm5KDjECIxZrJwkkrhfoFrdEHRxE2hkrXrSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770037880; c=relaxed/simple;
	bh=yGAddF5F1ZVUsQarPLGXeHT8UezjvX78Qu7gyZ68JlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kIjP8At3WzZaC8uidMp4OvYK4pb9clXJBuB4x1lbEFW6R6YvGK7R38Xo8gp9EKDNz2Ezr9HLbume26CKWNv2630sxWHgCyENXpFbjmrLKB7Lau6oWihr0xs9Ljwn/ebti02SrnmkZHg1hZo/isFN9i3bw+RioQjxx+wpAIKBWw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=fO/7JNPK; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="fO/7JNPK"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4327555464cso3104694f8f.1
        for <linux-cxl@vger.kernel.org>; Mon, 02 Feb 2026 05:11:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770037878; x=1770642678; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=8JsWhYD8Ccn9O07ciy26zVsalLPwSPT50YwVsz4kOkY=;
        b=fO/7JNPKg1BejFyjkrVLJg91zi2lFZlZWM7PfY7RpACgoCODlYA6lVLkmUoMnO81wV
         xjxRavMF5jShO3myTD8bGHuUJJjH2guXP+/4Ln8YkRcXjN+mNC/bcCi2DiR8khywg0pV
         Kp07jqAvm93WVRynFNtGi2nABMCyI5sqP8mDlC5msns7K3nNLxcPGtiiHyDL1RqfoCKQ
         pzkHq+TuZlc5VVw8DoWE1FAZ2kSWYdpKc5nLPtyFFk3LxgtvCxfHIo0hiFn30jyBK3oq
         K6FjAfAQ+PvEWyE5hy+ELglWxNx4kUsskdkxKO3imo2+QtnL8Cg+u6ktQIolrZ/Nwd4r
         n0gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770037878; x=1770642678;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8JsWhYD8Ccn9O07ciy26zVsalLPwSPT50YwVsz4kOkY=;
        b=p3xQXjtYeA9Q4MlgqGfS/xJ8X8gyNKOXpu+rlvY45WwSL5PT35gm+wRr5b4QE4wosm
         Uw9+t4+kMlHju2PQlZiI5lzrec+VpuE3Zl4rdPVUwpTnb6B9TY00hzKVPhIvaK4dbfCL
         JDmo+IJao0PwHW5mS+tv44yfwk4VIcIR4MUDpzuAironHggl9HnilNPnWxbvIhAKAxBb
         +lOinyAXNRgsUAOPjt0zOHD/yIRhp6HqGEZXPMBo8egD1EZyrxkhO7x8yU2jUNqkU55A
         swtL851fudPXrZv7TkCaejd+BP7PglNtH25P5pxkWNrRKgep4pP4nqzUiNUDdlxbO+Kr
         ZGCA==
X-Forwarded-Encrypted: i=1; AJvYcCV4s6g34AwpRnR/fkU2KrLAbbjBtjOLC5MZc+PLLc/J76FGQQfcLLJ6eQVV6jIihC+nFrJCogTvpuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxclzIQoXoNA27ADMKpVBDCDggBavYFX9R93pFNQHjjmo1bagzr
	rHEZxpolc58z8fFCjDs5ilsPiFE7/yIYuPApyu2dvwg5zWDo3jBs/FeFWuPi3q1hAGk=
X-Gm-Gg: AZuq6aJ9mf7V2BeHOkia3fey9NCUlt/63hreIcIya/hY+tUjXhQ9ASBbHR5s6TrX99k
	knTYSjuFArfRPS0FdXEOIvz6Le9J4zI8ORyUsT4g3phGInWuPVbRv7kebdUZ3bsCfZAX98WMQv2
	DMCWJ2FasECNyjuPj4qSFLz9iAp5TS67O0kDCD3848I+NPLNVjALK0fOflRsAo6EkLT20Onlm8Y
	UG3FOA+bv7Qqp/Y84G8qK18bLT/izyvV6CbWJ5Dl09SZFaiGsNKCeqyoOzvogrUVnKXo8qf+QcZ
	YaxyEDAOwmyhvVtTmn0GjqwlRdPDVSonvotzB4O7N8Jwl+or/BJ+VPMxzxzSbQ0YaW/fZqkHHiM
	l+oBA6lTGgC/Ka7WaIT/uIaQlERkLXsfWRGW1VJhhSFGCAt7ofhyMdq5YG93k7SgT9TG7nB16Sg
	C8n4U5Y+zZ/0Wq2Y/ZCGYlnFsG/0HKOCdBCAo=
X-Received: by 2002:a5d:64c7:0:b0:432:5c34:fb22 with SMTP id ffacd0b85a97d-435f3a7bee5mr16538747f8f.22.1770037877469;
        Mon, 02 Feb 2026 05:11:17 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e4762sm41985148f8f.6.2026.02.02.05.11.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 05:11:16 -0800 (PST)
Date: Mon, 2 Feb 2026 14:11:10 +0100
From: Michal Hocko <mhocko@suse.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, ziy@nvidia.com, matthew.brost@intel.com,
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net,
	ying.huang@linux.alibaba.com, apopple@nvidia.com,
	bingjiao@google.com, jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aYCiboGiXO2lQC0W@tiehlicka>
References: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
 <20260127220003.3993576-1-joshua.hahnjy@gmail.com>
 <CAC5umyhqbW_qXaApO8OGg1wo706GfVPuak5JwdBfBgS751Ka5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyhqbW_qXaApO8OGg1wo706GfVPuak5JwdBfBgS751Ka5Q@mail.gmail.com>

On Thu 29-01-26 09:40:17, Akinobu Mita wrote:
> 2026年1月28日(水) 7:00 Joshua Hahn <joshua.hahnjy@gmail.com>:
> >
> > > > > Therefore, it appears that the behavior of get_swappiness() is important
> > > > > in this issue.
> > > >
> > > > This is quite mysterious.
> > > >
> > > > Especially because get_swappiness() is an MGLRU exclusive function, I find
> > > > it quite strange that the issue you mention above occurs regardless of whether
> > > > MGLRU is enabled or disabled. With MGLRU disabled, did you see the same hangs
> > > > as before? Were these hangs similarly fixed by modifying the callsite in
> > > > get_swappiness?
> > >
> > > Good point.
> > > When MGLRU is disabled, changing only the behavior of can_demote()
> > > called by get_swappiness() did not solve the problem.
> > >
> > > Instead, the problem was avoided by changing only the behavior of
> > > can_demote() called by can_reclaim_anon_page(), without changing the
> > > behavior of can_demote() called from other places.
> > >
> > > > On a separate note, I feel a bit uncomfortable for making this the default
> > > > setting, regardless of whether there is swap space or not. Just as it is
> > > > easy to create a degenerate scenario where all memory is unreclaimable
> > > > and the system starts going into (wasteful) reclaim on the lower tiers,
> > > > it is equally easy to create a scenario where all memory is very easily
> > > > reclaimable (say, clean pagecache) and we OOM without making any attempt to
> > > > free up memory on the lower tiers.
> > > >
> > > > Reality is likely somewhere in between. And from my perspective, as long as
> > > > we have some amount of easily reclaimable memory, I don't think immediately
> > > > OOMing will be helpful for the system (and even if none of the memory is
> > > > easily reclaimable, we should still try doing something before killing).
> > > >
> > > > > > > The reason for this issue is that memory allocations do not directly
> > > > > > > trigger the oom-killer, assuming that if the target node has an underlying
> > > > > > > memory tier, it can always be reclaimed by demotion.
> > > >
> > > > This patch enforces that the opposite of this assumption is true; that even
> > > > if a target node has an underlying memory tier, it can never be reclaimed by
> > > > demotion.
> > > >
> > > > Certainly for systems with swap and some compression methods (z{ram, swap}),
> > > > this new enforcement could be harmful to the system. What do you think?
> > >
> > > Thank you for the detailed explanation.
> > >
> > > I understand the concern regarding the current patch, which only
> > > checks the free memory of the demotion target node.
> > > I will explore a solution.
> >
> > Hello Akinobu, I hope you had a great weekend!
> >
> > I noticed something that I thought was worth flagging. It seems like the
> > primary addition of this patch, which is to check for zone_watermark_ok
> > across the zones, is already a part of should_reclaim_retry():
> >
> >     /*
> >      * Keep reclaiming pages while there is a chance this will lead
> >      * somewhere.  If none of the target zones can satisfy our allocation
> >      * request even if all reclaimable pages are considered then we are
> >      * screwed and have to go OOM.
> >      */
> >     for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
> >                 ac->highest_zoneidx, ac->nodemask) {
> >
> >         [...snip...]
> >
> >         /*
> >          * Would the allocation succeed if we reclaimed all
> >          * reclaimable pages?
> >          */
> >         wmark = __zone_watermark_ok(zone, order, min_wmark,
> >                 ac->highest_zoneidx, alloc_flags, available);
> >
> >         if (wmark) {
> >             ret = true;
> >             break;
> >         }
> >     }
> >
> > ... which is called in __alloc_pages_slowpath. I wonder why we don't already
> > hit this. It seems to do the same thing your patch is doing?
> 
> I checked the number of calls and the time spent for several functions
> called by __alloc_pages_slowpath(), and found that time is spent in
> __alloc_pages_direct_reclaim() before reaching the first should_reclaim_retry().
> 
> After a few minutes have passed and the debug code that automatically
> resets numa_demotion_enabled to false is executed, it appears that
> __alloc_pages_direct_reclaim() immediately exits.

First of all is this MGLRU or traditional reclaim? Or both?

Then another thing I've noticed only now. There seems to be a layering
discrepancy (for traditional LRU reclaim) when get_scan_count which
controls the to-be-reclaimed lrus always relies on can_reclaim_anon_pages
while down the reclaim path shrink_folio_list tries to be more clever
and avoid demotion if it turns out to be inefficient.

I wouldn't be surprised if get_scan_count predominantly (or even
exclusively) scanned anon LRUs only while increasing the reclaim
priority  (so essentially just checked all anon pages on the LRU list)
before concluding that it makes no sense. This can take quite some time
and in the worst case you could be recycling couple of page cache pages
remaining on the list to make small but sufficient progress to loop
around.

So I think the first step is to make the demotion behavior consistent.
If demotion fails then it would probably makes sense to set sc->no_demotion
so that get_scan_count can learn from the reclaim feedback that
anonymous pages are not a good reclaim target in this situation. But the
whole reclaim path needs a careful review I am afraid.
-- 
Michal Hocko
SUSE Labs
