Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4719F23EA86
	for <linux-cxl@vger.kernel.org>; Wed,  4 Feb 2026 02:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170837; cv=pass; b=JWvj71UlqVrQx0xHjeB3Gw+IKQmuD75QceVN2oYlaZKCVWvHu+vSb1F1bLzWp+zLPgB+tAYWmE8j8X92NJoutlj/wsjY+Ka9Lz2vInnWKnrG04WpebdVmtGDnqXyTGvs9oKy85AaRPhBmiyelDo4CE6UXFhfoBDKc6RytXUnEx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170837; c=relaxed/simple;
	bh=HYruztICbS4zvZSUChbtPdfl2rYAOzNmlKIqTXPI8S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uzgB2LIoX3hcmd4EtoP9BA9yUDPpi14fs/6ufkAypj9vR3lN/WI4AHeks/bFmwX7CqExCKJXxb5JvLa68+wQCDxH8tdtQBpfJlUFdnzIoRaosYSeaXhp616Qm+v/1xHwcs5zqakl8bC4nT4FDuKzf4830LrcxIJrR+K9+yyzEV4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7z3Puj/; arc=pass smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7z3Puj/"
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-8c70ab3b5fcso853581785a.2
        for <linux-cxl@vger.kernel.org>; Tue, 03 Feb 2026 18:07:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770170835; cv=none;
        d=google.com; s=arc-20240605;
        b=AY4c37dmCQrHgvW/a3brU0B7XTlWzks2+XReqINWMNoCOSxC61P6Cq2GUYH3Bs00Vp
         yALIRRep9gObxQzJIoRAd2kV4kya4iRjbVgT1VX2lJnNUsOmGsfN5hlEau/Y+atqSP3I
         5ZDrgrlyct1bzYWtErbwei7zYjidzDxjtq7zzrkpWSrFo7DYOHTEMqKkTQunAVdO8U/I
         tLqwZUHyGnJvvr7F1D4bI5UCs9WS9US2pdLttFivmIO3zsnw877D2pZbM1CUBpJsZ6SH
         ib7FSJQWBX4gKYVrs6ar3h+xZXm2iH6zq/Uw++I2PoLdJeK35i5iQA7V9kAYcGuyjZpF
         HvRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=P3XKctSvXGgVpW/lX1QkUiLVHuzybB4KcosEl9SXxcg=;
        fh=3rY+2XeuHun/BCRCDaMX91zdOaMq2ZzhLI8/eMu/BQg=;
        b=Lw1JG049DCWQnpE8IFj+5ly0WYf2m2uyM0S2cs8Qi6B0Kcw4n27uFzDHXoF5frb22C
         ljYB4w0nejgic9XmrotBMjt8AzSvzr193KOnc2+X2G98tge5bmvIBrfGy3HHVzOJB6tN
         8K16xm6FYQA56GUY3X6wtF19QDfJ59/g2a2ycR3BZo106ODhohMEPTy/0vxOVYRPvMwf
         oKj91mC6MbIScjtb8pDYL3sSIxxv1D7TdBXwm736hcWqjcG2DB/eKyg2uuylmfP97oCU
         2eXeAuUV9nxxGjzX05qWnQV+r/IQ1LByfBCR0mKWCOTUrZMk9UKroBPGFo6I0ptd/qH/
         MhQQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770170835; x=1770775635; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=P3XKctSvXGgVpW/lX1QkUiLVHuzybB4KcosEl9SXxcg=;
        b=B7z3Puj/QTRJShTq8txNXcY6incH2hnyNs+uWKVKB4tJFFcn2NVTkaMA37ONqmNdRo
         OvrkAs+UWDj8OhF8rXEhXacVJif8NTWz78htuU/j8oOWY8bCsLNsy2sIz1/Q7/zum2P9
         oX7Z8cHtiSmL7GcCSp2dAVmZ59cGV9k+zYUhHQQfRABuR3ubFYBGbZEHhKZ+IuoRn0qP
         PhnuH58rp+B5VjGqJvpIer/pN1yerjbt1Vq2Ek2Y/uleFhIXofxvWytcPiEGfjSsjeqm
         ZwuGhfPLcHomAH8zhDZFAQZsnkf49VGhlKDeN/2hSxIz85vC6hpKPqPZGec90L267GP8
         +zyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770170835; x=1770775635;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=P3XKctSvXGgVpW/lX1QkUiLVHuzybB4KcosEl9SXxcg=;
        b=MUVmob7NnG0gVX3+rFnmRBQnEnc3w4uyx9qRHWrp2cz3LWSBfRn8lCLeUaKoH8ql52
         p4HD9TpOHRtTkoHIk0W44VSFf69ZDKxcycwBdApuA2lbjXQgSJ5ZwxXpHKOn1ioR8S8J
         zSgpur78U8oGPkIx/e2wl+znsjVryj+vq0L+yWD6RnwK7S5IgvZE0M0k8SiwURecz6dR
         OVi5yJM3Xc/McLJcLsW+yxH6N4508+7z3W8MAspoWGBwKKg/reTrYBq/5bBj4Sotkt++
         zZoaza4BtA+gk1zTaz2DMEhOnK3y+tM/+YGBUiuDy3P+Ld7Rxxs00cSGe2wjG8riRTKt
         RiCg==
X-Forwarded-Encrypted: i=1; AJvYcCXDtOogGuoTpK2fbCrAi5iX/mkRswzamuhA57Fh23RNCHhyAzzwUC+jHOsMjJ/PQ3CzJSopQVhyK1M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx81YBtC1Bugo07wSNkoxLYdtQnqZLZyPJUzIwcHOs49JEZoCiS
	49TbkOu66Qo5M+UD3gNVDh7tncyMWO1Qzh635mwIf+h07OoTyCPprOUw1me6Ksd82USrCJk/MOH
	pKPQieek1cV1qPChAVr4Yp/peVFDPLpE=
X-Gm-Gg: AZuq6aI8+6ZDaxzBFGa1OI4RUS2gIVTkGN0vXbFGTWSLbJo7QRlv3L/zJ7JMlalJFDW
	yZblkExE2WdZZ5fE1kfqwo0sotmPEp+1aZh1gUI4yWxsLhSJiCAb6ai/qjHdGQhCyjmN1cIP+62
	twYZA5K6vVko49M8QMaXw7jDwxITK0vzeobxrgSxr1vzayj6/P7j5yjZNtcpgVZMNG0sZswL6mt
	hUupFz6XOebZ3ST0W2HI4C55opaeEHN7Sq6RpzGTQXRWGdI6/tbjGTC8M7RXsy6tF8sk0uQ61cj
	plR2whWMBAeVHgb2ufgyEXA=
X-Received: by 2002:a05:620a:288e:b0:8ca:2cfa:822e with SMTP id
 af79cd13be357-8ca2f9f5b94mr235535285a.70.1770170835165; Tue, 03 Feb 2026
 18:07:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAC5umygEq6xvpDFnVnDLYLyqJV7qChEsJ_+W-KCBJ+EXj1948g@mail.gmail.com>
 <20260127220003.3993576-1-joshua.hahnjy@gmail.com> <CAC5umyhqbW_qXaApO8OGg1wo706GfVPuak5JwdBfBgS751Ka5Q@mail.gmail.com>
 <aYCiboGiXO2lQC0W@tiehlicka>
In-Reply-To: <aYCiboGiXO2lQC0W@tiehlicka>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Wed, 4 Feb 2026 11:07:03 +0900
X-Gm-Features: AZwV_Qh72QJTI4M2CEIA0M9FqVyxcZFhJhrBbyaUc7tMrpfUO9BLxMEmywo9FJo
Message-ID: <CAC5umygW8PXnS5tix-DfujhPjrRjBaEKe8ojW=y5FmqhqBfurg@mail.gmail.com>
Subject: Re: [PATCH v4 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Michal Hocko <mhocko@suse.com>
Cc: Joshua Hahn <joshua.hahnjy@gmail.com>, linux-cxl@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, akpm@linux-foundation.org, 
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com, 
	hannes@cmpxchg.org, david@kernel.org, zhengqi.arch@bytedance.com, 
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, 
	vbabka@suse.cz, rppt@kernel.org, surenb@google.com, ziy@nvidia.com, 
	matthew.brost@intel.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	bingjiao@google.com, jonathan.cameron@huawei.com, 
	pratyush.brahma@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B42=E6=9C=882=E6=97=A5(=E6=9C=88) 22:11 Michal Hocko <mhocko@sus=
e.com>:
>
> On Thu 29-01-26 09:40:17, Akinobu Mita wrote:
> > 2026=E5=B9=B41=E6=9C=8828=E6=97=A5(=E6=B0=B4) 7:00 Joshua Hahn <joshua.=
hahnjy@gmail.com>:
> > >
> > > > > > Therefore, it appears that the behavior of get_swappiness() is =
important
> > > > > > in this issue.
> > > > >
> > > > > This is quite mysterious.
> > > > >
> > > > > Especially because get_swappiness() is an MGLRU exclusive functio=
n, I find
> > > > > it quite strange that the issue you mention above occurs regardle=
ss of whether
> > > > > MGLRU is enabled or disabled. With MGLRU disabled, did you see th=
e same hangs
> > > > > as before? Were these hangs similarly fixed by modifying the call=
site in
> > > > > get_swappiness?
> > > >
> > > > Good point.
> > > > When MGLRU is disabled, changing only the behavior of can_demote()
> > > > called by get_swappiness() did not solve the problem.
> > > >
> > > > Instead, the problem was avoided by changing only the behavior of
> > > > can_demote() called by can_reclaim_anon_page(), without changing th=
e
> > > > behavior of can_demote() called from other places.
> > > >
> > > > > On a separate note, I feel a bit uncomfortable for making this th=
e default
> > > > > setting, regardless of whether there is swap space or not. Just a=
s it is
> > > > > easy to create a degenerate scenario where all memory is unreclai=
mable
> > > > > and the system starts going into (wasteful) reclaim on the lower =
tiers,
> > > > > it is equally easy to create a scenario where all memory is very =
easily
> > > > > reclaimable (say, clean pagecache) and we OOM without making any =
attempt to
> > > > > free up memory on the lower tiers.
> > > > >
> > > > > Reality is likely somewhere in between. And from my perspective, =
as long as
> > > > > we have some amount of easily reclaimable memory, I don't think i=
mmediately
> > > > > OOMing will be helpful for the system (and even if none of the me=
mory is
> > > > > easily reclaimable, we should still try doing something before ki=
lling).
> > > > >
> > > > > > > > The reason for this issue is that memory allocations do not=
 directly
> > > > > > > > trigger the oom-killer, assuming that if the target node ha=
s an underlying
> > > > > > > > memory tier, it can always be reclaimed by demotion.
> > > > >
> > > > > This patch enforces that the opposite of this assumption is true;=
 that even
> > > > > if a target node has an underlying memory tier, it can never be r=
eclaimed by
> > > > > demotion.
> > > > >
> > > > > Certainly for systems with swap and some compression methods (z{r=
am, swap}),
> > > > > this new enforcement could be harmful to the system. What do you =
think?
> > > >
> > > > Thank you for the detailed explanation.
> > > >
> > > > I understand the concern regarding the current patch, which only
> > > > checks the free memory of the demotion target node.
> > > > I will explore a solution.
> > >
> > > Hello Akinobu, I hope you had a great weekend!
> > >
> > > I noticed something that I thought was worth flagging. It seems like =
the
> > > primary addition of this patch, which is to check for zone_watermark_=
ok
> > > across the zones, is already a part of should_reclaim_retry():
> > >
> > >     /*
> > >      * Keep reclaiming pages while there is a chance this will lead
> > >      * somewhere.  If none of the target zones can satisfy our alloca=
tion
> > >      * request even if all reclaimable pages are considered then we a=
re
> > >      * screwed and have to go OOM.
> > >      */
> > >     for_each_zone_zonelist_nodemask(zone, z, ac->zonelist,
> > >                 ac->highest_zoneidx, ac->nodemask) {
> > >
> > >         [...snip...]
> > >
> > >         /*
> > >          * Would the allocation succeed if we reclaimed all
> > >          * reclaimable pages?
> > >          */
> > >         wmark =3D __zone_watermark_ok(zone, order, min_wmark,
> > >                 ac->highest_zoneidx, alloc_flags, available);
> > >
> > >         if (wmark) {
> > >             ret =3D true;
> > >             break;
> > >         }
> > >     }
> > >
> > > ... which is called in __alloc_pages_slowpath. I wonder why we don't =
already
> > > hit this. It seems to do the same thing your patch is doing?
> >
> > I checked the number of calls and the time spent for several functions
> > called by __alloc_pages_slowpath(), and found that time is spent in
> > __alloc_pages_direct_reclaim() before reaching the first should_reclaim=
_retry().
> >
> > After a few minutes have passed and the debug code that automatically
> > resets numa_demotion_enabled to false is executed, it appears that
> > __alloc_pages_direct_reclaim() immediately exits.
>
> First of all is this MGLRU or traditional reclaim? Or both?

The behavior is almost the same whether MGLRU is enabled or not.
However, one difference is that __alloc_pages_direct_reclaim() may be
called multiple times when __alloc_pages_slowpath() is called, and
should_reclaim_retry() also returns true several times.

This is probably because the watermark check in should_reclaim_retry()
considers not only NR_FREE_PAGES but also NR_ZONE_INACTIVE_ANON and
NR_ZONE_ACTIVE_ANON as potential free memory. (zone_reclaimable_pages())

The following is the increment of stats in /proc/vmstat from the start
of the reproduction test until the problem occurred and
numa_demotion_enabled was automatically reset by the debug code and
OOM occurred a few minutes later:

workingset_nodes 578
workingset_refault_anon 5054381
workingset_refault_file 41502
workingset_activate_anon 3003283
workingset_activate_file 33232
workingset_restore_anon 2556549
workingset_restore_file 27139
workingset_nodereclaim 3472
pgdemote_kswapd 121684
pgdemote_direct 23977
pgdemote_khugepaged 0
pgdemote_proactive 0
pgsteal_kswapd 3480404
pgsteal_direct 2602011
pgsteal_khugepaged 74
pgsteal_proactive 0
pgscan_kswapd 93334262
pgscan_direct 227649302
pgscan_khugepaged 1232161
pgscan_proactive 0
pgscan_direct_throttle 18
pgscan_anon 320480379
pgscan_file 1735346
pgsteal_anon 5828270
pgsteal_file 254219

> Then another thing I've noticed only now. There seems to be a layering
> discrepancy (for traditional LRU reclaim) when get_scan_count which
> controls the to-be-reclaimed lrus always relies on can_reclaim_anon_pages
> while down the reclaim path shrink_folio_list tries to be more clever
> and avoid demotion if it turns out to be inefficient.
>
> I wouldn't be surprised if get_scan_count predominantly (or even
> exclusively) scanned anon LRUs only while increasing the reclaim
> priority  (so essentially just checked all anon pages on the LRU list)
> before concluding that it makes no sense. This can take quite some time
> and in the worst case you could be recycling couple of page cache pages
> remaining on the list to make small but sufficient progress to loop
> around.
>
> So I think the first step is to make the demotion behavior consistent.
> If demotion fails then it would probably makes sense to set sc->no_demoti=
on
> so that get_scan_count can learn from the reclaim feedback that
> anonymous pages are not a good reclaim target in this situation. But the
> whole reclaim path needs a careful review I am afraid.

If migrate_pages() in demote_folio_list() detects that it cannot
migrate any folios and all calls to alloc_demote_folio() also fail
(this is made possible by adding a few fields to migration_target_control),
it sets sc->no_demotion to true, which also resolves the issue.

        migrate_pages(demote_folios, alloc_demote_folio, NULL,
                      (unsigned long)&mtc, MIGRATE_ASYNC, MR_DEMOTION,
                      &nr_succeeded);
        if (!nr_succeeded && mtc.nr_alloc_tried > 0 &&
                        (mtc.nr_alloc_tried =3D=3D mtc.nr_alloc_failed)) {
                sc->no_demotion =3D 1;
        }
