Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83F25334C33
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 22:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769551207; cv=none; b=TXe5ZrM6yyN4aQy9IJNOKveB/Rx1nZcKU3OkxW4jKJFgxYoCzNVrSqqg9ZWC2aReX0jL7XsXxld8Czn9gGj+CrO/s4Sk/R8kYmqXutjioMhB5Ptj9EKCoIxwKIJxJTtSZx5V/s/EJX7xWErCLEYzqXH/Bu/MXECtGDQjcbCCwcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769551207; c=relaxed/simple;
	bh=Y88iVvSNkV74nN1mJKvTtB14ao7wckVJ0F+cwVhyggE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3A7Z30JqK3tdGs97/aorS+c43CUxJqvi4tb/uWd1Fr0dhOM4O1zDzd+1Ti+Q6zlpVeWbXDthPlo3At2oB+pA2Phz3fArWfsVXVCeIKVwqoZEZoIQg6CKQtafDk2UJVkM5yGZBxsdxykHjhpvKnjCpKknjRO31dDW1q9upzb4a4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=caTegEuD; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="caTegEuD"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-7942b9663f8so55766777b3.2
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 14:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769551205; x=1770156005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IjM130EplqqQ/xeoUk9+p55WLFrsTBothNzba4XDkwI=;
        b=caTegEuDoulqGXdzlUaTBhlAJfesqi1cnRvN7TDROD0eEiueqXnpGByHdh6hvY+Ree
         b4pN3/XZdF7EJ81kvz21FVWLo4lUgTbvjSa6VHVyavN03AkgIW7sywCN6fbcAFtOO4kb
         1tUBiHa7p9VbsLLS9rekPpAAl+Mr7nnFwbbAYtsU5iNB4BmZmika60fLnS8ObCousF+6
         gmPSgZKk6ale6dHImcbCiQpYkXff+nVTsAtAdZqUXhi5tT59LdTZVSHDcoVp2OB4UD/a
         gJm0QHBMIc1V5t1dkhzkrPKiY5CGz6KYbjHBbWEO2He7pxe1kEg1HOdHdfgO1l2fzWZK
         RTlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769551205; x=1770156005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IjM130EplqqQ/xeoUk9+p55WLFrsTBothNzba4XDkwI=;
        b=KRfcs5qaUyzzTbI+E96s6IiZbs20Z3R3R+3YbDipLhQHWDht8tUKvSu7p3BVjKDfNQ
         lF+LyZlm1O5DoWy14v7AeVC1i11Smyw25FIcR/znrYcf9ZdfyJlIXT3L1geDZmN1hpe8
         pY9iMLs4P58SHiASBn4My8w/JPohOOT1TMYFyI0MARJtDnCpRJlVgrWkEsdz4X+GHBeh
         MOiGcflDFBh+wxYOUnjHxQgDnTeqbPnIRtZJeGgNRmioYoMhrCMdaNpHrWz6RkapsM0y
         Hsafk2sSo1NCkRqLDh/snYwxUKrbyRChKIKnYi2eqmEV4yiwrx0VUNrRIbOPjdbVEjBq
         1ipg==
X-Forwarded-Encrypted: i=1; AJvYcCXCshgfz0imtpehHKmGx1b7qE8//ln7eoo5F41M2dGqyILPnbuxasa7zOYUwaHyWKP+sjY59MRrv/8=@vger.kernel.org
X-Gm-Message-State: AOJu0YygRslnaT2A3TCUHnfw5yuEPHhe9Kd13G6F/eKk3FuRgfgJ67Ua
	eWW+PZpFhk85/qTTzJH0a1qzLb6V9quTfglmjOuZQspwJrskyCSga8r8
X-Gm-Gg: AZuq6aImv57mgJcQ4RyDkPu3VQ+g9FWUvxQUj7wu+gTMXlOHUQhosIEqphqXf1oUp0g
	GP4xR5kt6k8fgCIe3P9NdImhSdv3YG6HUJ5WquyVmFV0ln1wHqZB8nEgEgG0VYyGmBEi6yG3cid
	TKtxwFP14QQnB2obJe11hVIZymx57d6H0r1RKL+W3yTdfsuoKkWfMKEg51FBZscKrz8g+neOS50
	DRQ/pFgBgYjo6hkLT/MZOorYn5OPL/SA1ZnjrApO0rRUU08ifIYTqyiFJN+VgHKKY88pxDFrD1H
	CeKs2+7HDkKfH6KYv+Acme7IRfRy9IS8N633TWd2KiurOiujvgg/qSMwD4OgPUbabtuswAVdLdL
	rlQ28nrDQSoQRQT9H4NFWnUWd3rPm+9JwEidnuq1Axg5hIvSg3z2SNJaLKsN3uHGTWk87kGaLEZ
	CDUC8Ljj7qwGCLcB+UIGtY
X-Received: by 2002:a05:690c:6982:b0:793:a94d:4fd2 with SMTP id 00721157ae682-7947ab1d0b8mr25216387b3.6.1769551205384;
        Tue, 27 Jan 2026 14:00:05 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:11::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-794828ab4c6sm3043037b3.34.2026.01.27.14.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 14:00:04 -0800 (PST)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Michal Hocko <mhocko@suse.com>,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	akpm@linux-foundation.org,
	axelrasmussen@google.com,
	yuanchu@google.com,
	weixugc@google.com,
	hannes@cmpxchg.org,
	david@kernel.org,
	zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com,
	vbabka@suse.cz,
	rppt@kernel.org,
	surenb@google.com,
	ziy@nvidia.com,
	matthew.brost@intel.com,
	rakie.kim@sk.com,
	byungchul@sk.com,
	gourry@gourry.net,
	ying.huang@linux.alibaba.com,
	apopple@nvidia.com,
	bingjiao@google.com,
	jonathan.cameron@huawei.com,
	pratyush.brahma@oss.qualcomm.com
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough free memory in the lower memory tier
Date: Tue, 27 Jan 2026 17:00:02 -0500
Message-ID: <20260127220003.3993576-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
References: 
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > > Therefore, it appears that the behavior of get_swappiness() is important
> > > in this issue.
> >
> > This is quite mysterious.
> >
> > Especially because get_swappiness() is an MGLRU exclusive function, I find
> > it quite strange that the issue you mention above occurs regardless of whether
> > MGLRU is enabled or disabled. With MGLRU disabled, did you see the same hangs
> > as before? Were these hangs similarly fixed by modifying the callsite in
> > get_swappiness?
> 
> Good point.
> When MGLRU is disabled, changing only the behavior of can_demote()
> called by get_swappiness() did not solve the problem.
> 
> Instead, the problem was avoided by changing only the behavior of
> can_demote() called by can_reclaim_anon_page(), without changing the
> behavior of can_demote() called from other places.
> 
> > On a separate note, I feel a bit uncomfortable for making this the default
> > setting, regardless of whether there is swap space or not. Just as it is
> > easy to create a degenerate scenario where all memory is unreclaimable
> > and the system starts going into (wasteful) reclaim on the lower tiers,
> > it is equally easy to create a scenario where all memory is very easily
> > reclaimable (say, clean pagecache) and we OOM without making any attempt to
> > free up memory on the lower tiers.
> >
> > Reality is likely somewhere in between. And from my perspective, as long as
> > we have some amount of easily reclaimable memory, I don't think immediately
> > OOMing will be helpful for the system (and even if none of the memory is
> > easily reclaimable, we should still try doing something before killing).
> >
> > > > > The reason for this issue is that memory allocations do not directly
> > > > > trigger the oom-killer, assuming that if the target node has an underlying
> > > > > memory tier, it can always be reclaimed by demotion.
> >
> > This patch enforces that the opposite of this assumption is true; that even
> > if a target node has an underlying memory tier, it can never be reclaimed by
> > demotion.
> >
> > Certainly for systems with swap and some compression methods (z{ram, swap}),
> > this new enforcement could be harmful to the system. What do you think?
> 
> Thank you for the detailed explanation.
> 
> I understand the concern regarding the current patch, which only
> checks the free memory of the demotion target node.
> I will explore a solution.

Hello Akinobu, I hope you had a great weekend!

I noticed something that I thought was worth flagging. It seems like the
primary addition of this patch, which is to check for zone_watermark_ok
across the zones, is already a part of should_reclaim_retry():

    /*
     * Keep reclaiming pages while there is a chance this will lead
     * somewhere.  If none of the target zones can satisfy our allocation
     * request even if all reclaimable pages are considered then we are
     * screwed and have to go OOM.
     */
    for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
                ac->highest_zoneidx, ac->nodemask) {

	[...snip...]

        /*
         * Would the allocation succeed if we reclaimed all
         * reclaimable pages?
         */
        wmark = __zone_watermark_ok(zone, order, min_wmark,
                ac->highest_zoneidx, alloc_flags, available);

        if (wmark) {
            ret = true;
            break;
        }
    }

... which is called in __alloc_pages_slowpath. I wonder why we don't already
hit this. It seems to do the same thing your patch is doing?

What do you think? I hope you have a great day!
Joshua
