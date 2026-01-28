Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96ED329A9E9
	for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 09:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769594209; cv=none; b=BJCunJUjuPpN8MOFizxkTcux4a3gyiz28teiUNWyTZ+ivGJucQuyl4yRnTORZSFso8vKqWp8OywlYRDIUgK6Dl6rgnOVuQDGpQdNW5ebFFIk1mLuGaxs3cprfyukoqMVSJM8cKuKQ/cXvEtilCzYaH1Zf/lHi9hlrYNiVElMHiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769594209; c=relaxed/simple;
	bh=B35P+VFD288c6IomJGtjlDvW2ZFwLeHxQS6eBwvBvGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSr60L5Ikug/hCafxTbbi0dXd7kkEHi7a6jmZwoVQVGs83dXIK+CsgdaZ7YU652dbcl8uzMVk44APtbFh151oz8z8URjUZWt7doaoj4ctIQWh4OO9oW89ILxb4+aCNcahtETRGr5A/Dh85Wni4uf9OkkRkOOpFmJ0+6b5AK/CQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IlcYVyFW; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IlcYVyFW"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-47ee0291921so57465375e9.3
        for <linux-cxl@vger.kernel.org>; Wed, 28 Jan 2026 01:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1769594206; x=1770199006; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kxRg4wzZcesj+93lNqvgnZRj7Qw2sb28l6iopF01T5s=;
        b=IlcYVyFWs/n1sTVZ3cTXp8v7t4u8RPxIiODIyoGa3sTtx7SsJAIS8HLAHoIcFbkvTB
         0VOobNW3eirYEXjchNXUrtkQOt7d/mXXHvzILL2VRMciCn9Xl5mMf3Lxhd1DIVJrIRGx
         pT+epmXMsIsOypnSxwRAiPmqTz6Q8uJqmH9fSTeic98EJ3iOehh6euONkg2nqi4oArXJ
         KE9Twp+DTJEVz2pHt3IRZTkvfolidPL2ucfx3/C2xkq4gabpo4BUE/e9nqUQ7sl3cFV9
         t9W4PdVN+HWWOqVDvHrUJcl0K2umxaw8cq1VvTB0jCKwowGlFiY9HDZNe0n6MvaIkVNB
         4nXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769594206; x=1770199006;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kxRg4wzZcesj+93lNqvgnZRj7Qw2sb28l6iopF01T5s=;
        b=Sn7hU1cTuPGu2gWfmnr5y6aTk0ezB2ex/yFm9ATbcgPDDech+kxjPtW5Npgs6gy68u
         9tS+2ffIcIe9xDs1pKlDJm5WndJWYd2+xX7b4vypkGblrUgH8h775wFlVU2gEdEBhZQM
         WsI5ijmOPZ+vGSWXfS3i9KEhcyUw+6vjc+akgxDTuQeziebZqXf63m1rJksh+r0FLsLV
         RHe12ySb/oJVCCh1c52eXIpvULHE7hDO0HSodYNLC5fBBCzpVIjmtOhdA1cfQQGV93px
         PXroqIC9zSrY9WWicZvwwGIs5fseGVcovfCuKVsEliCg29Ww8wqmOQSigcpa/kERetJk
         nZNA==
X-Forwarded-Encrypted: i=1; AJvYcCWZj0aZiiLcFJPOhnRYrQOmMNE7BaQgJicpS5H8iFhiQMEpteR6GLgQOoOQLuZIG7RUEFKTMdjJNRs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6mT+RYCIX6IRX5xg4yaZKGNmWpSMv7jL9l/nD8Jzf+1QNISyE
	MmNwpa/lJkbIuDPgrE3fEK3+GmmpAgilaB8o5it/t3j2u8qt/F+TWK/9J4zOemrr/WY=
X-Gm-Gg: AZuq6aJvuewuZy+BH59bobI/arcc/G4AEYvGrUYPXcWo1PtYA7+IQVVZ2cfgvx5206B
	st6sjIvQdMAKa/oKU78+ziSMJGYMBg3Jdd1UAaOviYX+JSiMSwUx4DswdQy74lKQGKhuB2qtw2J
	fyykdVjiA3m0RGt5JL2nl5dXurK3km+svccQ/IO6cYHVxvMYnHe2LjuESlPT1NGWV1b5POSWs/+
	pCXN72eGr1kIOwq99bGSog43MP4pE3ly8UAhb3LPSjoGINUudGdpYnAG1hKAnMZYenvjqgvmKmo
	uIkOOxnPYBbJHhlPTcsJRWBLzM1Vd7zlIkUjXUWbqkcoQQltZHr16SufS3/qWrK5m+7O8FN/GRT
	8k9Bum1AW6iVp2glXN6FRB7Wo9CrJVjqn0dfS25r85R2SI+gsYfc7OwO8ErKMXDXzc6SllFxqd2
	ERLHKjlH5J84sRGYiv1kYpz6WQrtcTgUVXEuE=
X-Received: by 2002:a05:600c:5489:b0:47e:de23:dd6f with SMTP id 5b1f17b1804b1-48069c4a7fbmr55983155e9.12.1769594206010;
        Wed, 28 Jan 2026 01:56:46 -0800 (PST)
Received: from localhost (109-81-26-156.rct.o2.cz. [109.81.26.156])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10e48a6sm5741401f8f.8.2026.01.28.01.56.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jan 2026 01:56:45 -0800 (PST)
Date: Wed, 28 Jan 2026 10:56:44 +0100
From: Michal Hocko <mhocko@suse.com>
To: Gregory Price <gourry@gourry.net>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	akpm@linux-foundation.org, axelrasmussen@google.com,
	yuanchu@google.com, weixugc@google.com, hannes@cmpxchg.org,
	david@kernel.org, zhengqi.arch@bytedance.com,
	shakeel.butt@linux.dev, lorenzo.stoakes@oracle.com,
	Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
	surenb@google.com, bingjiao@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXndXPMFK2fhLA4p@tiehlicka>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
 <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
 <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>

On Tue 27-01-26 15:24:36, Gregory Price wrote:
> On Sat, Jan 10, 2026 at 10:55:02PM +0900, Akinobu Mita wrote:
> > 2026年1月10日(土) 1:08 Gregory Price <gourry@gourry.net>:
> > >
> > > > +     for_each_node_mask(nid, allowed_mask) {
> > > > +             int z;
> > > > +             struct zone *zone;
> > > > +             struct pglist_data *pgdat = NODE_DATA(nid);
> > > > +
> > > > +             for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZONES - 1) {
> > > > +                     if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
> > > > +                                             ZONE_MOVABLE, 0))
> > >
> > > Why does this only check zone movable?
> > 
> > Here, zone_watermark_ok() checks the free memory for all zones from 0 to
> > MAX_NR_ZONES - 1.
> > There is no strong reason to pass ZONE_MOVABLE as the highest_zoneidx
> > argument every time zone_watermark_ok() is called; I can change it if an
> > appropriate value is found.
> > In v1, highest_zoneidx was "sc ? sc->reclaim_idx : MAX_NR_ZONES - 1"
> > 
> > > Also, would this also limit pressure-signal to invoke reclaim when
> > > there is still swap space available?  Should demotion not be a pressure
> > > source for triggering harder reclaim?
> > 
> > Since can_reclaim_anon_pages() checks whether there is free space on the swap
> > device before checking with can_demote(), I think the negative impact of this
> > change will be small. However, since I have not been able to confirm the
> > behavior when a swap device is available, I would like to correctly understand
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
>         struct migration_target_control mtc = {
>                  */
>                 .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
>                         __GFP_NOMEMALLOC | GFP_NOWAIT,
>         };
> }
> 
> static struct folio *alloc_demote_folio(struct folio *src,
>                 unsigned long private)
> {
> 	/* Only attempt to demote to the preferred node */
>         mtc->nmask = NULL;
>         mtc->gfp_mask |= __GFP_THISNODE;
>         dst = alloc_migration_target(src, (unsigned long)mtc);
>         if (dst)
>                 return dst;
> 
> 	/* Now attempt to demote to any node in the lower tier */
>         mtc->gfp_mask &= ~__GFP_THISNODE;
>         mtc->nmask = allowed_mask;
>         return alloc_migration_target(src, (unsigned long)mtc);
> }
> 
> 
> /*
> * %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
> */
> 
> 
> You basically shouldn't be hitting any reclaim behavior at all, and if

This will trigger kswapd so there will be background reclaim demoting
from those lower tiers.

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
>         dst = alloc_migration_target(src, (unsigned long)mtc);
> }
> 
> struct folio *alloc_migration_target(struct folio *src, unsigned long private)
> {
>         
> ...
>         if (folio_test_hugetlb(src)) {
>                 struct hstate *h = folio_hstate(src);
> 
>                 gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
>                 return alloc_hugetlb_folio_nodemask(h, nid, ...)
> 	}
> }
> 
> static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
> {
>         gfp_t modified_mask = htlb_alloc_mask(h);
> 
>         /* Some callers might want to enforce node */
>         modified_mask |= (gfp_mask & __GFP_THISNODE);
> 
>         modified_mask |= (gfp_mask & __GFP_NOWARN);
> 
>         return modified_mask;
> }
> 
> /* Movability of hugepages depends on migration support. */
> static inline gfp_t htlb_alloc_mask(struct hstate *h)
> {
>         gfp_t gfp = __GFP_COMP | __GFP_NOWARN;
> 
>         gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;
> 
>         return gfp;
> }
> 
> #define GFP_USER        (__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
> #define GFP_HIGHUSER    (GFP_USER | __GFP_HIGHMEM)
> #define GFP_HIGHUSER_MOVABLE    (GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)
> 
> 
> If we try to move a hugepage, we start including __GFP_RECLAIM again -
> regardless of whether HIGHUSER_MOVABLE or HIGHUSER is used.
> 
> 
> Any chance you are using hugetlb on this system?  This looks like a
> clear bug, but it may not be what you're experiencing.

Hugetlb pages are not sitting on LRU lists so they are not participating
in the demotion.

Or maybe I missed your point.
-- 
Michal Hocko
SUSE Labs
