Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EA5C2580D7
	for <linux-cxl@vger.kernel.org>; Thu, 29 Jan 2026 00:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769647480; cv=pass; b=b+SbrQZdT4rRjsnn4LJAEcN4R7Sj9D41TfbFmY1hPpC3HOPMXZunrZ/jKsJmZWpijC7Dn34rfUnNl4lOt6lMytAOS26aDHlX7ezmT8gVm2Ynu6HcXivyAtoMmTPPjCO2lpDZSeSrVsN2cL5s+9Y54Zm+YkNZaf5pdmym1dFGlRg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769647480; c=relaxed/simple;
	bh=EAsIf0B7RnvS9exHl9xP6Rho8qjOZRMDuTv/cnx/7mg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aNcsNeT4xKNwYdIzWiu2C4UcbDiKFazxeFo/aPMPpokGf/SkSvZWVWA0VIX0QNeCzTpkIiHOdTWJi7L9zAvwfTlNIz4pBZZn8aDypYtsjzHzHEKeUbkzyd6rdRVeMd3SGVl/PUPHxuwca2u0ZsEeS8La7TmWJw7iPsEsp6WZZSU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVzXLpN7; arc=pass smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVzXLpN7"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-89461ccc46eso7573816d6.2
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 16:44:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769647478; cv=none;
        d=google.com; s=arc-20240605;
        b=GxpP7hqHQHVxFAphekHIjOg4sbMfFgvbYi+Dd7bOeWlmQXY/OAqGjQDjdAe/Sigtxc
         DHnhXhMGIRDQT4qbMJqlHVnYKZqit0OPDJAHlGd59QEht5pDyml6BPtHdtByug8sRmjo
         M7m1MODKBL9UNnCR6IQvzk/OXCXP6YKvOFtOthMMbnfteYbxDxsYZQUGOVuOaoKE1KuT
         Z+Yj/M7OKzNrcvvKavMsoWVYGzNuBue41323OgD06SFQ3YqvrcTsz3CeaszgtThhNQV9
         8uH6yMdsC5YRJfC5HWQ9EY49y9PFj+4wZTdIuiYPwQydoMWZ22eK3jiJSoRIbKvRQ8MV
         yidA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XwM3zfTFqHE5kmjZguuH0nYrlQY8HFwC7+d1W+Ezm88=;
        fh=VJ56IdzFdJ2jwD+LVZxJq+rINfhF2BwJam9vTyBwDyU=;
        b=JyJT5JpO1cJIlFQ3+TjuS01+UZ8aZh/aV9sYzP9MAjR5o+ftRLhLiwSZ4qvFe/EDY2
         AgHhtNCMoElevl+aaps1/2/TK1tWo4YY/mInvW7ENFQXKdH42paRihT5zDwMdPsBUPID
         jfEJSGb0PFAc7K+tlfaMUukJvrZa0KNKReV4fbotd7NcHMKbUlJhlnwvywzPlGVKRU6Z
         Daf18cq1+AhT265qcmN4eoxjN8gurMpxJUxDjv3L3y/3b96XaylOZpvhnnan3/deUCMi
         q2KN/hs5IgccQnHg9701z6SkFXYeWVH9rzhlVlbdQt6fbx6y5D10O8+yLhARdVZIF7QZ
         sCOQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769647478; x=1770252278; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XwM3zfTFqHE5kmjZguuH0nYrlQY8HFwC7+d1W+Ezm88=;
        b=UVzXLpN7h0HXjdyFAkkJfckPvwbN/Jdv1qiu2J6ASeKnXj0i8+Xy6IxYGGXV1qgqjQ
         alG5E90lnq/II+ZGh5mou0XOtM3VgIKy76Ei7eTWnklYJXzFNMCPqxTHF8PIQWqETXxL
         wqLtWkHh+dEhMUBuNTTh6GnALYsABa76llC7mvAf4/jr5DITNqdLQ3f+Sp2znfTZFJfi
         uUCGB+ZHkGCLU868fCu97rzxbpXKm3DsqdFA7XAeoK2pcH4nxMqJV3JAl0oFCVBHNbOK
         ghtBii+lj/xb5YzuiMuyL34szcGl0MPXuqQ6MSDKyt4vGk+KsSrEt8gWzLIQhVCUm9Yl
         HCkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769647478; x=1770252278;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XwM3zfTFqHE5kmjZguuH0nYrlQY8HFwC7+d1W+Ezm88=;
        b=vWoE6BUv2ukEst4KLUIxx5ua7rsUvRpyw+ERGvqA/0Kkb/QuXI2ilU9o8tg7MrsYhw
         67tel9CFVGkx3iF7Pmps83d/BqnSk2Gv8LB2AvOOBaJkAtEHsT90dYTqOeDLusmEbukE
         HSaugozAUNooWCMZjoFN62RRNxS4cnn5FHvVTtcJY6tQEcvH1fPakCGmVrb5OfoRNkc2
         v0qArMXbshdotHYCS/om+ZjmJyWKaR/FKhc72ooAaYUtPQJslf7hnFfZ9ROlbsWSd+Cm
         DwRiHZESUVfXfIDrTMmIAmVAdG6/6QT/w0ygGOkwh0pIEJNQgUTz1Jxs4g6Y54g305/3
         UjgQ==
X-Gm-Message-State: AOJu0Yx2ICEdwh1eum8EEDlgG5U/BhMcXW8N8ReeuEs9zjJEGM9KG8hM
	Y58iIBg4/6DlFZg7gTmlsE7vtO0dx03IGFi94vmvW3v1ASteFd56d3Qyb9tlytprHVrtEk6DoWW
	GG2hlTFRjFjCtnGf21KVcwFWNyUFVexs=
X-Gm-Gg: AZuq6aKFUv0KaMLvCLxoqDPZhcUUn5HmKerdTFwcUY0AbKmwUyz3gVfMMACQkqIX+0n
	cJuZ5kRAnZRCGF8moucyZYEC1qdREDSiyeSCfrAMdol6c0YlOaFlI+yXT/cpnQpiCx7C+R7Kpmo
	FobHS+f5GiPMUy6HEllP5lQQ/hyxzzGp50ijQNVKvzGqQqLMoHvM5rfXQ3cLTAx6j9L2HsYFXgt
	UIkHzomRVKcOhRilE21dHbjcFXz6HW9+ZiNVCltoHdtnC3LgLfcvALeM5kV/AxgR7OTEBZaAt9l
	6W20IzY3BNELKJTezzRg+2M=
X-Received: by 2002:a05:6214:d85:b0:894:7fd1:923a with SMTP id
 6a1803df08f44-894cc835eacmr95525106d6.24.1769647477989; Wed, 28 Jan 2026
 16:44:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com> <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com> <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
In-Reply-To: <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
From: Akinobu Mita <akinobu.mita@gmail.com>
Date: Thu, 29 Jan 2026 09:44:27 +0900
X-Gm-Features: AZwV_QgUyHkG-WUI7iNcz5xWCWhbTMOceR-EUzNXVnt7j2TJLEh0eaXRurf4hjo
Message-ID: <CAC5umyieqMyasC=nZNtpP0jrO-YEYEZ1KyGeX=E=ZtWrYyDpMg@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
To: Gregory Price <gourry@gourry.net>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, akpm@linux-foundation.org, axelrasmussen@google.com, 
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org, david@kernel.org, 
	mhocko@kernel.org, zhengqi.arch@bytedance.com, shakeel.butt@linux.dev, 
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz, 
	rppt@kernel.org, surenb@google.com, bingjiao@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2026=E5=B9=B41=E6=9C=8828=E6=97=A5(=E6=B0=B4) 5:24 Gregory Price <gourry@go=
urry.net>:
>
> On Sat, Jan 10, 2026 at 10:55:02PM +0900, Akinobu Mita wrote:
> > 2026=E5=B9=B41=E6=9C=8810=E6=97=A5(=E5=9C=9F) 1:08 Gregory Price <gourr=
y@gourry.net>:
> > >
> > > > +     for_each_node_mask(nid, allowed_mask) {
> > > > +             int z;
> > > > +             struct zone *zone;
> > > > +             struct pglist_data *pgdat =3D NODE_DATA(nid);
> > > > +
> > > > +             for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZO=
NES - 1) {
> > > > +                     if (zone_watermark_ok(zone, 0, min_wmark_page=
s(zone),
> > > > +                                             ZONE_MOVABLE, 0))
> > >
> > > Why does this only check zone movable?
> >
> > Here, zone_watermark_ok() checks the free memory for all zones from 0 t=
o
> > MAX_NR_ZONES - 1.
> > There is no strong reason to pass ZONE_MOVABLE as the highest_zoneidx
> > argument every time zone_watermark_ok() is called; I can change it if a=
n
> > appropriate value is found.
> > In v1, highest_zoneidx was "sc ? sc->reclaim_idx : MAX_NR_ZONES - 1"
> >
> > > Also, would this also limit pressure-signal to invoke reclaim when
> > > there is still swap space available?  Should demotion not be a pressu=
re
> > > source for triggering harder reclaim?
> >
> > Since can_reclaim_anon_pages() checks whether there is free space on th=
e swap
> > device before checking with can_demote(), I think the negative impact o=
f this
> > change will be small. However, since I have not been able to confirm th=
e
> > behavior when a swap device is available, I would like to correctly und=
erstand
> > the impact.
>
> Something else is going on here
>
> See demote_folio_list and alloc_demote_folio
>
> static unsigned int demote_folio_list(struct list_head *demote_folios,
>                                       struct pglist_data *pgdat,
>                                       struct mem_cgroup *memcg)
> {
>         struct migration_target_control mtc =3D {
>                  */
>                 .gfp_mask =3D (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                         __GFP_NOMEMALLOC | GFP_NOWAIT,
>         };
> }
>
> static struct folio *alloc_demote_folio(struct folio *src,
>                 unsigned long private)
> {
>         /* Only attempt to demote to the preferred node */
>         mtc->nmask =3D NULL;
>         mtc->gfp_mask |=3D __GFP_THISNODE;
>         dst =3D alloc_migration_target(src, (unsigned long)mtc);
>         if (dst)
>                 return dst;
>
>         /* Now attempt to demote to any node in the lower tier */
>         mtc->gfp_mask &=3D ~__GFP_THISNODE;
>         mtc->nmask =3D allowed_mask;
>         return alloc_migration_target(src, (unsigned long)mtc);
> }
>
>
> /*
> * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd recl=
aim.
> */
>
>
> You basically shouldn't be hitting any reclaim behavior at all, and if
> the target nodes are actually under various watermarks, you should be
> getting allocation failures and quick-outs from the demotion logic.
>
> i.e. you should be seeing OOM happen
>
> When I dug in far enough I found this:
>
> static struct folio *alloc_demote_folio(struct folio *src,
>                 unsigned long private)
> {
> ...
>         dst =3D alloc_migration_target(src, (unsigned long)mtc);
> }
>
> struct folio *alloc_migration_target(struct folio *src, unsigned long pri=
vate)
> {
>
> ...
>         if (folio_test_hugetlb(src)) {
>                 struct hstate *h =3D folio_hstate(src);
>
>                 gfp_mask =3D htlb_modify_alloc_mask(h, gfp_mask);
>                 return alloc_hugetlb_folio_nodemask(h, nid, ...)
>         }
> }
>
> static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_ma=
sk)
> {
>         gfp_t modified_mask =3D htlb_alloc_mask(h);
>
>         /* Some callers might want to enforce node */
>         modified_mask |=3D (gfp_mask & __GFP_THISNODE);
>
>         modified_mask |=3D (gfp_mask & __GFP_NOWARN);
>
>         return modified_mask;
> }
>
> /* Movability of hugepages depends on migration support. */
> static inline gfp_t htlb_alloc_mask(struct hstate *h)
> {
>         gfp_t gfp =3D __GFP_COMP | __GFP_NOWARN;
>
>         gfp |=3D hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : G=
FP_HIGHUSER;
>
>         return gfp;
> }
>
> #define GFP_USER        (__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARD=
WALL)
> #define GFP_HIGHUSER    (GFP_USER | __GFP_HIGHMEM)
> #define GFP_HIGHUSER_MOVABLE    (GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKI=
P_KASAN)
>
>
> If we try to move a hugepage, we start including __GFP_RECLAIM again -
> regardless of whether HIGHUSER_MOVABLE or HIGHUSER is used.
>
>
> Any chance you are using hugetlb on this system?  This looks like a
> clear bug, but it may not be what you're experiencing.

In my case where the issue was reproduced, alloc_demote_folio() failed almo=
st
every time, but the folio passed to alloc_migration_target() was always fal=
se
for both folio_test_hugetlb() and folio_test_large().
