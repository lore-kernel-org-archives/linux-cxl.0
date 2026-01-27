Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708681FDE31
	for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 20:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769545482; cv=none; b=ZGWjkmPzPk2rylvAIzPEz2CWoWLK2+lcg21b2GhcxjDmfcUfvtz1X71v45TKmYItFqzAp2fT8tTQnFnCOWFl37/AobWdI+zcQ6DJplBKeNlLkXKa0tkczEwRmyS5JEaGteQmd/0DOZdGk7Iu13wV/mV1Y0vs71sqdd3hNybOWB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769545482; c=relaxed/simple;
	bh=bkUBlovj45Q2VasAOYSzsnX97gHpU2v2Ow2IKixM1Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qo/OvJA+n1xeTU5iSo3+ymSwNkgKG/q5Fku/hcAGLSBhNDWrRvxDOgTJVtOJzOEHRGK30Fn2VnMaqBLORLfT/V13sZV2ob8HgPUGFszDG+pXNJpROB4tgHKllcF0JGfUZg3fg/CHWBKmZBV8zlx6hbBaY899hRUVC5eATpaHmsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net; spf=pass smtp.mailfrom=gourry.net; dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b=HoyjArTk; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=gourry.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gourry.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gourry.net header.i=@gourry.net header.b="HoyjArTk"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-8c531473fdcso813919285a.3
        for <linux-cxl@vger.kernel.org>; Tue, 27 Jan 2026 12:24:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gourry.net; s=google; t=1769545479; x=1770150279; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=A5LxVPVBoG+UMcNxikNez0XKmCy+fMwCwEoTyhq3Vgg=;
        b=HoyjArTk+Rgihg4YR6jbLaJ08KX3dms1L1NonvyYO6aXm3MErDWnK5PHsObh3H44zM
         GmS/p2uOR0P2kz06lj0IIgyCQEFG643/izyf4LHGO+3CHY7HsFKMDIL8/nMp/K+kbCLV
         eHQC04vFD/qvh1obt1/W/YHStUROy5GgDGusmRr+BUUCkHAq08oeF/6SMWBM/tjEtDGS
         yHh2703AzosigXbJ91fyvuzd3ZelPm0ZSsheLlBaJx4TWNAoMkekim/RXLChfWzc2k/y
         /hbm4mGrgEYqr6Y8bllILmHPCJOp7mNDmXu9OqMnHEwHLbw5ZH3D0GnX4pXZOLyL1NUn
         lCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769545479; x=1770150279;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A5LxVPVBoG+UMcNxikNez0XKmCy+fMwCwEoTyhq3Vgg=;
        b=NsMwhpmY13isJcv2veCbqAhVHstDVqpI5lyC8nAvtIjP90rVrxkbZ6adKTFs7HRx2Y
         7KQUEZ4lCS79mDfPnomy31AkukAgpPJwq0YyEXOy3/mYggUpkbPgVCce91itjKA6nXnb
         s4LNCNQfGZeYSTHP1Sl2/FdY9dbixFCuBV4aIp21xBOvQW8trJmofyZlO1NpSQi7NQdK
         hZ6OyKPw2tYRgzjd7eYNpvN7HLBHVKcrhmYtlAbumOf7KjzxyPJ/4LMH/HY1hQEcRLRu
         eXiTBuylkjjX1V/EEdjXbHrlM5TUCKSH7sQfAQfwv5VQhGC9CjXq7XaARvN+YkLqAqPx
         tl0w==
X-Gm-Message-State: AOJu0YxP3eDDHLyol35cIQjXo+v6kqiNo92wMSE927DqEEN5ehTzR/Pd
	M7nbuYwSm+YH5z3sto7RaKIbLUPaqTkYHRUfgDLrq6FQSyJHfYAEgLJDyhEJ2gZIAe0=
X-Gm-Gg: AZuq6aK8azIQaN5DjDyz+Vu9QDN9u75wH7pZdmiNmlNk5+V6frfHiFtimPqe3Alkx/s
	mD8ui1KKfmuSlBENH7LvBKsNQ1DpGLqqJooBwKQt1CtoV97pe8mq20mLfxPpukCidC7dPMgZlEb
	UnctxkiuSQEZc5lrUv/aaDA9mk2eBmDsotKERRbPbBrhhGrx0iL/6+YIt2o61TCsPhUauOd4L8u
	q6VjfLa7AYBZCIElLQ+iPWZZF9reGa0MFfIYYs0gSX6rNla28iF6ymqdUxEIEVIik1psfhJqmy4
	UfLfirGtYrOqw5+Uo6cWlw+hD/7D6OQtjwQZ1kKumSmjg4WqKdeZnyiRSr7IYzkIq09u+1HMAhe
	dbMQVelQVBkE9i96hTMmT0YuFheKUtaJLCJorPavlEUpICw4k3zFzCLUxeRySOJ2pzwQ12xFg4J
	oxFLOLVDk7srl6wvfNd7wkkgLo7sCGKQpAnQztbyNc6IbjerGWLcFc92Cc168c0qSl9nPERKE/j
	OY9k4Fi
X-Received: by 2002:a05:620a:404f:b0:8b2:edc8:13d0 with SMTP id af79cd13be357-8c70b85bc20mr389358885a.17.1769545479306;
        Tue, 27 Jan 2026 12:24:39 -0800 (PST)
Received: from gourry-fedora-PF4VCD3F (pool-96-255-20-138.washdc.ftas.verizon.net. [96.255.20.138])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c711d29aa2sm41365985a.35.2026.01.27.12.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jan 2026 12:24:38 -0800 (PST)
Date: Tue, 27 Jan 2026 15:24:36 -0500
From: Gregory Price <gourry@gourry.net>
To: Akinobu Mita <akinobu.mita@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, akpm@linux-foundation.org,
	axelrasmussen@google.com, yuanchu@google.com, weixugc@google.com,
	hannes@cmpxchg.org, david@kernel.org, mhocko@kernel.org,
	zhengqi.arch@bytedance.com, shakeel.butt@linux.dev,
	lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
	rppt@kernel.org, surenb@google.com, bingjiao@google.com
Subject: Re: [PATCH v3 3/3] mm/vmscan: don't demote if there is not enough
 free memory in the lower memory tier
Message-ID: <aXkfBF5bdnTZ7t7e@gourry-fedora-PF4VCD3F>
References: <20260108101535.50696-1-akinobu.mita@gmail.com>
 <20260108101535.50696-4-akinobu.mita@gmail.com>
 <aWEn2ODG0gyej0Xr@gourry-fedora-PF4VCD3F>
 <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAC5umyhoMi_J_Ford2M_1fB-qCuPEDopAK1OF=AisZyDZ8duJQ@mail.gmail.com>

On Sat, Jan 10, 2026 at 10:55:02PM +0900, Akinobu Mita wrote:
> 2026年1月10日(土) 1:08 Gregory Price <gourry@gourry.net>:
> >
> > > +     for_each_node_mask(nid, allowed_mask) {
> > > +             int z;
> > > +             struct zone *zone;
> > > +             struct pglist_data *pgdat = NODE_DATA(nid);
> > > +
> > > +             for_each_managed_zone_pgdat(zone, pgdat, z, MAX_NR_ZONES - 1) {
> > > +                     if (zone_watermark_ok(zone, 0, min_wmark_pages(zone),
> > > +                                             ZONE_MOVABLE, 0))
> >
> > Why does this only check zone movable?
> 
> Here, zone_watermark_ok() checks the free memory for all zones from 0 to
> MAX_NR_ZONES - 1.
> There is no strong reason to pass ZONE_MOVABLE as the highest_zoneidx
> argument every time zone_watermark_ok() is called; I can change it if an
> appropriate value is found.
> In v1, highest_zoneidx was "sc ? sc->reclaim_idx : MAX_NR_ZONES - 1"
> 
> > Also, would this also limit pressure-signal to invoke reclaim when
> > there is still swap space available?  Should demotion not be a pressure
> > source for triggering harder reclaim?
> 
> Since can_reclaim_anon_pages() checks whether there is free space on the swap
> device before checking with can_demote(), I think the negative impact of this
> change will be small. However, since I have not been able to confirm the
> behavior when a swap device is available, I would like to correctly understand
> the impact.

Something else is going on here

See demote_folio_list and alloc_demote_folio

static unsigned int demote_folio_list(struct list_head *demote_folios,
                                      struct pglist_data *pgdat,
                                      struct mem_cgroup *memcg)
{
        struct migration_target_control mtc = {
                 */
                .gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
                        __GFP_NOMEMALLOC | GFP_NOWAIT,
        };
}

static struct folio *alloc_demote_folio(struct folio *src,
                unsigned long private)
{
	/* Only attempt to demote to the preferred node */
        mtc->nmask = NULL;
        mtc->gfp_mask |= __GFP_THISNODE;
        dst = alloc_migration_target(src, (unsigned long)mtc);
        if (dst)
                return dst;

	/* Now attempt to demote to any node in the lower tier */
        mtc->gfp_mask &= ~__GFP_THISNODE;
        mtc->nmask = allowed_mask;
        return alloc_migration_target(src, (unsigned long)mtc);
}


/*
* %__GFP_RECLAIM is shorthand to allow/forbid both direct and kswapd reclaim.
*/


You basically shouldn't be hitting any reclaim behavior at all, and if
the target nodes are actually under various watermarks, you should be
getting allocation failures and quick-outs from the demotion logic.

i.e. you should be seeing OOM happen

When I dug in far enough I found this:

static struct folio *alloc_demote_folio(struct folio *src,
                unsigned long private)
{
...
        dst = alloc_migration_target(src, (unsigned long)mtc);
}

struct folio *alloc_migration_target(struct folio *src, unsigned long private)
{
        
...
        if (folio_test_hugetlb(src)) {
                struct hstate *h = folio_hstate(src);

                gfp_mask = htlb_modify_alloc_mask(h, gfp_mask);
                return alloc_hugetlb_folio_nodemask(h, nid, ...)
	}
}

static inline gfp_t htlb_modify_alloc_mask(struct hstate *h, gfp_t gfp_mask)
{
        gfp_t modified_mask = htlb_alloc_mask(h);

        /* Some callers might want to enforce node */
        modified_mask |= (gfp_mask & __GFP_THISNODE);

        modified_mask |= (gfp_mask & __GFP_NOWARN);

        return modified_mask;
}

/* Movability of hugepages depends on migration support. */
static inline gfp_t htlb_alloc_mask(struct hstate *h)
{
        gfp_t gfp = __GFP_COMP | __GFP_NOWARN;

        gfp |= hugepage_movable_supported(h) ? GFP_HIGHUSER_MOVABLE : GFP_HIGHUSER;

        return gfp;
}

#define GFP_USER        (__GFP_RECLAIM | __GFP_IO | __GFP_FS | __GFP_HARDWALL)
#define GFP_HIGHUSER    (GFP_USER | __GFP_HIGHMEM)
#define GFP_HIGHUSER_MOVABLE    (GFP_HIGHUSER | __GFP_MOVABLE | __GFP_SKIP_KASAN)


If we try to move a hugepage, we start including __GFP_RECLAIM again -
regardless of whether HIGHUSER_MOVABLE or HIGHUSER is used.


Any chance you are using hugetlb on this system?  This looks like a
clear bug, but it may not be what you're experiencing.

~Gregory
