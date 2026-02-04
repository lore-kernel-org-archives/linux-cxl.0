Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB6C3A4F3F
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 09:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197107; cv=none; b=ZE0y8/E5ga5g/cva3DaYIzp9fYZQMEB6Y9XZKsNSwzPGTY1bNwbiRiXmhyeOVTa27Nwsnpd/A0uR57/seUaHxLctiWTOOqRId7+S05+TlbvdQ95IpSP1FaXMLbk0pPqKOcN5Xdsh7aYRvsJcITMhKnaBUi6AdEyiyfhpXJTfiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197107; c=relaxed/simple;
	bh=+9818JSt9C3kokZYpk+ZlyehQz3c1kWbUkWKL2tOaxw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LorFI61Jc/e0LzCUC9SofEv4AYvnmMYeueVU/+5l0iR+1BM5DdeTvQ7/Abnlya19cRSNE+xcQoTL8+SE/WkTPGpjt3+vPzqAFlAzrM86XqCrW+P3ayQwSHP7iPtkd4wnQLfH3LH6rOtCwgDiGOklbaf3Q+jRXr+j9er4Ve14QSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=d6EaRsvZ; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="d6EaRsvZ"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-47edd9024b1so53043265e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 04 Feb 2026 01:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1770197105; x=1770801905; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=5vRCdO0bXpcykxF+oz49o7od5GWLyt8pzJaSR709p2I=;
        b=d6EaRsvZakGpIyn9AvmMwiyV+TE0rVzjnczCyQot7Aq6JstraKmEoPsOQrTfYmUwxL
         S1Jz70QzdL7jdE3GKxqK5E4ipfDD1kdpqy2lXJUgC1ztdAhfKJv3E3J+T0Sljk3woXLg
         AZkChBXyAcuLwkii4draf6lsl/zMez2BeZcKezjhG25Rvv0njpg9gxQbis+Ppo9jA+iO
         ODLKy9jXN3qJ/pJ1uKL77uuGoom4zJDUkpsU32BWB7ts6stwhoe9RUDj2N9EB/2yQVYY
         KQLNa99lSlr7A3Tw6Rtf77o8lgBbmW/tvuNJ4M8XMPAGMKh/LPfWivBAA+h87lIXeDA0
         KY3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770197105; x=1770801905;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5vRCdO0bXpcykxF+oz49o7od5GWLyt8pzJaSR709p2I=;
        b=Ld2uqmpZnPJq1YSyha5RYwxgIbJIgxzAR1CycFmQB0lRNfVmSZc4eqaN3DntSLotFn
         KXB559NCaLHkIgRwUOJ5XKA6IL4ZQQ29Ll9aC5ba+fmNCQGeTYGJbl/j7IRn7vJj5bzd
         o/DlFYmL+OueBFNPhCHGUYMaoLIgmDB/gCkX4mJ7EPlwtoNkPR6zqsLy2P44eEbNiYMH
         LIqW8ynmKWhXxqu1TM/OfRroQasNyah3wElIvLZVV5vHh9DznI+7ULp0Y8YMcfpgeyN+
         4D0QDmrpg4DOISjFXWENEm4RA7XPmYAX/U1eGUXAL30qC7zqnhGgId5WvOEq+Rxe/fXy
         xByw==
X-Forwarded-Encrypted: i=1; AJvYcCVghQDNukgIoCdEMeiHWeY3C8gobd1ylGAuiYFUhiokSgu519I4zjgS7Bc0o5qurYbj9JEJPTNaX6U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6YVrChpAtDVvPi+cMt6FGm20BZjOI3Zw0cahmE5IfCPsAG4tB
	29G3Q7PUODl2A2nkZgLNPF2/QXeOz07ZA9m6gYzdPcFYMZSpnXxASiG+xpx1eWT9E04=
X-Gm-Gg: AZuq6aKqEiK5FiJnfM/hHD+dixOKeqtzRWXs+SsAAaj9yXi8ZuyWGtrraN4VYuNc3ir
	OxI/TuKdZXpHFQXYEZPYg0xIpKtTm1EAjiVOVo/EyML6LTAMKBlhWSp/LN3CHZ/NJKhZJaIxnLq
	JtLHUHxyp2SIXn9CbFsDh5hGoOog/7fykgyivgRPNF9/YStCFi7bchfRGMr867DuFMkagFlm7ZV
	oZRPfAn3iZs3lqxCK+8p8sJ5X7OIIrOVIcVIOvZfxBFJeLhD6VlvNsVlbmzrbAVL9U3Ze2oD5t2
	2NC0H1467+YawU8SNQjKxC/3WwUoLUiLcc7gdIgW8dXEi42Ywe0OekKmgb3fL05/WuRSBGa4+8b
	U5MpPicckJOA+fsO+aPhlecBvesA52x1GvTCWAeOIG3zjFm6lHcI6JHt8jw4Lfvd6kccnYOj0iq
	yySuIp+bsuGJ/WyaBrv6vQzGzH
X-Received: by 2002:a05:600c:c48f:b0:477:214f:bd95 with SMTP id 5b1f17b1804b1-4830e987c1dmr26960685e9.23.1770197104984;
        Wed, 04 Feb 2026 01:25:04 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4831088d318sm51779665e9.10.2026.02.04.01.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 01:25:04 -0800 (PST)
Date: Wed, 4 Feb 2026 10:25:03 +0100
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
Message-ID: <aYMQb9JTPXTutgvH@tiehlicka>
References: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
 <20260127220003.3993576-1-joshua.hahnjy@gmail.com>
 <CAC5umyhqbW_qXaApO8OGg1wo706GfVPuak5JwdBfBgS751Ka5Q@mail.gmail.com>
 <aYCiboGiXO2lQC0W@tiehlicka>
 <CAC5umygW8PXnS5tix-DfujhPjrRjBaEKe8ojW=y5FmqhqBfurg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umygW8PXnS5tix-DfujhPjrRjBaEKe8ojW=y5FmqhqBfurg@mail.gmail.com>

On Wed 04-02-26 11:07:03, Akinobu Mita wrote:
> 2026年2月2日(月) 22:11 Michal Hocko <mhocko@suse.com>:
> >
> > On Thu 29-01-26 09:40:17, Akinobu Mita wrote:
> > > 2026年1月28日(水) 7:00 Joshua Hahn <joshua.hahnjy@gmail.com>:
> > > >
> > > > > > > Therefore, it appears that the behavior of get_swappiness() is important
> > > > > > > in this issue.
> > > > > >
> > > > > > This is quite mysterious.
> > > > > >
> > > > > > Especially because get_swappiness() is an MGLRU exclusive function, I find
> > > > > > it quite strange that the issue you mention above occurs regardless of whether
> > > > > > MGLRU is enabled or disabled. With MGLRU disabled, did you see the same hangs
> > > > > > as before? Were these hangs similarly fixed by modifying the callsite in
> > > > > > get_swappiness?
> > > > >
> > > > > Good point.
> > > > > When MGLRU is disabled, changing only the behavior of can_demote()
> > > > > called by get_swappiness() did not solve the problem.
> > > > >
> > > > > Instead, the problem was avoided by changing only the behavior of
> > > > > can_demote() called by can_reclaim_anon_page(), without changing the
> > > > > behavior of can_demote() called from other places.
> > > > >
> > > > > > On a separate note, I feel a bit uncomfortable for making this the default
> > > > > > setting, regardless of whether there is swap space or not. Just as it is
> > > > > > easy to create a degenerate scenario where all memory is unreclaimable
> > > > > > and the system starts going into (wasteful) reclaim on the lower tiers,
> > > > > > it is equally easy to create a scenario where all memory is very easily
> > > > > > reclaimable (say, clean pagecache) and we OOM without making any attempt to
> > > > > > free up memory on the lower tiers.
> > > > > >
> > > > > > Reality is likely somewhere in between. And from my perspective, as long as
> > > > > > we have some amount of easily reclaimable memory, I don't think immediately
> > > > > > OOMing will be helpful for the system (and even if none of the memory is
> > > > > > easily reclaimable, we should still try doing something before killing).
> > > > > >
> > > > > > > > > The reason for this issue is that memory allocations do not directly
> > > > > > > > > trigger the oom-killer, assuming that if the target node has an underlying
> > > > > > > > > memory tier, it can always be reclaimed by demotion.
> > > > > >
> > > > > > This patch enforces that the opposite of this assumption is true; that even
> > > > > > if a target node has an underlying memory tier, it can never be reclaimed by
> > > > > > demotion.
> > > > > >
> > > > > > Certainly for systems with swap and some compression methods (z{ram, swap}),
> > > > > > this new enforcement could be harmful to the system. What do you think?
> > > > >
> > > > > Thank you for the detailed explanation.
> > > > >
> > > > > I understand the concern regarding the current patch, which only
> > > > > checks the free memory of the demotion target node.
> > > > > I will explore a solution.
> > > >
> > > > Hello Akinobu, I hope you had a great weekend!
> > > >
> > > > I noticed something that I thought was worth flagging. It seems like the
> > > > primary addition of this patch, which is to check for zone_watermark_ok
> > > > across the zones, is already a part of should_reclaim_retry():
> > > >
> > > >     /*
> > > >      * Keep reclaiming pages while there is a chance this will lead
> > > >      * somewhere.  If none of the target zones can satisfy our allocation
> > > >      * request even if all reclaimable pages are considered then we are
> > > >      * screwed and have to go OOM.
> > > >      */
> > > >     for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
> > > >                 ac->highest_zoneidx, ac->nodemask) {
> > > >
> > > >         [...snip...]
> > > >
> > > >         /*
> > > >          * Would the allocation succeed if we reclaimed all
> > > >          * reclaimable pages?
> > > >          */
> > > >         wmark = __zone_watermark_ok(zone, order, min_wmark,
> > > >                 ac->highest_zoneidx, alloc_flags, available);
> > > >
> > > >         if (wmark) {
> > > >             ret = true;
> > > >             break;
> > > >         }
> > > >     }
> > > >
> > > > ... which is called in __alloc_pages_slowpath. I wonder why we don't already
> > > > hit this. It seems to do the same thing your patch is doing?
> > >
> > > I checked the number of calls and the time spent for several functions
> > > called by __alloc_pages_slowpath(), and found that time is spent in
> > > __alloc_pages_direct_reclaim() before reaching the first should_reclaim_retry().
> > >
> > > After a few minutes have passed and the debug code that automatically
> > > resets numa_demotion_enabled to false is executed, it appears that
> > > __alloc_pages_direct_reclaim() immediately exits.
> >
> > First of all is this MGLRU or traditional reclaim? Or both?
> 
> The behavior is almost the same whether MGLRU is enabled or not.
> However, one difference is that __alloc_pages_direct_reclaim() may be
> called multiple times when __alloc_pages_slowpath() is called, and
> should_reclaim_retry() also returns true several times.
> 
> This is probably because the watermark check in should_reclaim_retry()
> considers not only NR_FREE_PAGES but also NR_ZONE_INACTIVE_ANON and
> NR_ZONE_ACTIVE_ANON as potential free memory. (zone_reclaimable_pages())

Yes, seems like the same problem as with get_scan_count.

> The following is the increment of stats in /proc/vmstat from the start
> of the reproduction test until the problem occurred and
> numa_demotion_enabled was automatically reset by the debug code and
> OOM occurred a few minutes later:
> 
> workingset_nodes 578
> workingset_refault_anon 5054381
> workingset_refault_file 41502
> workingset_activate_anon 3003283
> workingset_activate_file 33232
> workingset_restore_anon 2556549
> workingset_restore_file 27139
> workingset_nodereclaim 3472
> pgdemote_kswapd 121684
> pgdemote_direct 23977
> pgdemote_khugepaged 0
> pgdemote_proactive 0
> pgsteal_kswapd 3480404
> pgsteal_direct 2602011
> pgsteal_khugepaged 74
> pgsteal_proactive 0
> pgscan_kswapd 93334262
> pgscan_direct 227649302
> pgscan_khugepaged 1232161
> pgscan_proactive 0
> pgscan_direct_throttle 18
> pgscan_anon 320480379
> pgscan_file 1735346
> pgsteal_anon 5828270
> pgsteal_file 254219

You can clearly see that the order of magnitute of pages scanned is
completely disproportional to pages actually reclaimed. So there is a
lot of scanning without any progress at all.

> > Then another thing I've noticed only now. There seems to be a layering
> > discrepancy (for traditional LRU reclaim) when get_scan_count which
> > controls the to-be-reclaimed lrus always relies on can_reclaim_anon_pages
> > while down the reclaim path shrink_folio_list tries to be more clever
> > and avoid demotion if it turns out to be inefficient.
> >
> > I wouldn't be surprised if get_scan_count predominantly (or even
> > exclusively) scanned anon LRUs only while increasing the reclaim
> > priority  (so essentially just checked all anon pages on the LRU list)
> > before concluding that it makes no sense. This can take quite some time
> > and in the worst case you could be recycling couple of page cache pages
> > remaining on the list to make small but sufficient progress to loop
> > around.
> >
> > So I think the first step is to make the demotion behavior consistent.
> > If demotion fails then it would probably makes sense to set sc->no_demotion
> > so that get_scan_count can learn from the reclaim feedback that
> > anonymous pages are not a good reclaim target in this situation. But the
> > whole reclaim path needs a careful review I am afraid.
> 
> If migrate_pages() in demote_folio_list() detects that it cannot
> migrate any folios and all calls to alloc_demote_folio() also fail
> (this is made possible by adding a few fields to migration_target_control),
> it sets sc->no_demotion to true, which also resolves the issue.
> 
>         migrate_pages(demote_folios, alloc_demote_folio, NULL,
>                       (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
>                       &nr_succeeded);
>         if (!nr_succeeded && mtc.nr_alloc_tried > 0 &&
>                         (mtc.nr_alloc_tried == mtc.nr_alloc_failed)) {
>                 sc->no_demotion = 1;
>         }

This seems to low level place to make such a decision. Keep in mind that
shrink_list operates on SWAP_CLUSTER_MAX batches so the backoff could be
pre-mature. shrink_lruvec seems like a better place to make such a
decision but this really requires a deeper evaluation.

Anyway, it is good that we have a better understanding what is going on.
Thanks for confirming the theory.
-- 
Michal Hocko
SUSE Labs
