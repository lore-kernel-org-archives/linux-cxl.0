Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 978163ECBDD
	for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 18:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777314787; cv=none; b=UwQLvaTQ7u5LCtw3nYq7wgbliYFb7fadg3ylKDmYq/rJ2qnoSBjCbF+d0I6IPNae1i+8LnNlsK5WBBFlssFHMgpUXXyUsawYGyPiEZtbaTd23rqbek5ny0lEh0/BiOZlZ5iIyPBjiqFJ/geXT/iLvi0ybnRDbVfRa8yFvgxFbyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777314787; c=relaxed/simple;
	bh=oigWqB6eMyE6NxAOk7tMpxoL8cPZz4Yr5Kc96bdLfjA=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e0lrzCLw3p93+Eq9pVMyjsLcu081uFlopmq6nF1Pj5A0tf5WLIBiz81D0JRpYWTwIxYjdP+Oo3Mst17kUe3kH8l5rXWy5SVr7meEpigWj9L/BhbkFYwVd56WD/5eOsgOwVulWocMl/LTKTqXE/rdjih4tRUz44uvKXQHrUU8i8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s9HDmxjx; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s9HDmxjx"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7b186dfc1d0so149152277b3.1
        for <linux-cxl@vger.kernel.org>; Mon, 27 Apr 2026 11:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777314783; x=1777919583; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YyXdQGyiE6NEMpQNgnYuSAkpxpV/2d5kNLWXcRP4YmI=;
        b=s9HDmxjx6TQtxpgHGre3Gdf1eqf138ZhLLKwV3Np8gwN5tzNeohx3XPyiCn9fE0xLo
         O8FfmLUbU6067VYQh4K8n/FTL/ZT9G5JsxMxPhaAFEkceZtK6+guWMLf4BWn5MeRr6vn
         H3KUsydyhqCH8Q5DzayIF2ISVWRw/wI0dhdpE6So7X2OH9hd+9NxHhKbMG1i+2Dcbx+s
         U5BKZe3CEeVM2Yv8dI3Op5kqID5tu9KLRU15XxQh7r1xAoqnip6Cwbbln2W27RROJE6j
         CRXc3FrN25KGssWzPYDkqUrI3dHzHfYKUmLNVTyTFRAb57s/SPRO5nz1DjfJ5iisKg/2
         AhRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777314783; x=1777919583;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YyXdQGyiE6NEMpQNgnYuSAkpxpV/2d5kNLWXcRP4YmI=;
        b=E3b9xFzBHh0U6kwEI+nnSRYVGRf9NW/7eb7fNUBIppCToUUuCMhdEZ99nl8oJ4ao/c
         HMhtVeNw1KZOxPkpFMSvjQvJqV1Ad6SjVYVb45JJlYl+1/nM4utPU8Wfs4DbUKOarsKD
         XLkLp+3dZxvq9IYngXnCVjbAGnByGYTCUZIdChib/mDRtWY3JHoNgOjAllRlIBj9bZhJ
         sXI/9RZEW8XqJDT2zzxsMXJPft+9DGwKCaKvPeB4NufK5Bbx2mC5YdUUSIFDMbMuSllj
         sbNPgOBW8dqpViBE00qieF5HwN4RXJr56Fmuo0GTujydm0k/WNRyPz/2PFyaXAzhLcO3
         PNJw==
X-Forwarded-Encrypted: i=1; AFNElJ8kB3KzWWD4JhMQ/ctqZWkQdydXyr57QgID6w7TGnZpBM8O72EPZ3an6foDhSPgRmQ17XsrIEfa0A8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXCtkDJrIedBixil62RGrpT7Uo0Jl+3CWBNp5hxLMX5d86YTW+
	pRolmlw5duErCiQ0+Go1Cmos14bo0KcGowHOtAtkZ8Mun6RGMO4UHdsc
X-Gm-Gg: AeBDietQoznfNHVSyyiPteDAGYIVxm/jXZSrAL6w4ZvlLPgZvM9PsECAyIB/bgyCiH0
	CAO9OmH9NQYw90Wrlh9zgEfgh91UseY8oV2zyZM6CIgajos0z6XWad/kX2DICpC1MO8iOFDjXAS
	d3nkF9aUbVbvc8SuWR3JJCYkmJyGwBeHqrYZEd3BYG6UlxzxFqXNVDJjtD58Bj34XYXh8WwpclU
	4AK7d+6lmhhKaFMU5wcjUMEeoQBZO6MQi+3ybDSAebC1lW8Dd2zkqQBjI053XVTh6qQUPBfV4tV
	gX24t0YZOtDRLRUkcfpB66yqLn4CofpIeSnGMuc+Pcav926K2UcTrFBcFjM8cv+krPF8o3g7Gjq
	XcpgLLMjPZ8MUxKZcTGbVUgHxbWp8ftxgKAXaoEEreodpGqXCl/DMgUzGhU0bTjKlud+AymTkR6
	h25oQwAkgqAdLMawccrIvF18lFmHgBG91v1JJOr+iDqcc48MbOwkY1
X-Received: by 2002:a05:690c:4d87:b0:79a:da8f:d26b with SMTP id 00721157ae682-7bceed3ad07mr2763407b3.18.1777314783247;
        Mon, 27 Apr 2026 11:33:03 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bcf04bd93fsm702667b3.7.2026.04.27.11.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 11:33:02 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 27 Apr 2026 11:32:59 -0700
To: Ira Weiny <ira.weiny@intel.com>
Cc: John Groves <john@jagalactic.com>, Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>,
	John Groves <John@groves.net>, Fan Ni <fan.ni@samsung.com>,
	Shiju Jose <shiju.jose@huawei.com>,
	Robert Richter <rrichter@amd.com>,
	"linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"dev.srinivasulu@gmail.com" <dev.srinivasulu@gmail.com>,
	"arramesh@micron.com" <arramesh@micron.com>,
	"ajayjoshi@micron.com" <ajayjoshi@micron.com>
Subject: Re: [RFC PATCH 1/4] cxl/extent: Promote cxlr_dax->region_extent to
 an xarray
Message-ID: <ae-r25BFwxKDmhTS@4470NRD-ASU.ssi.samsung.com>
References: <0100019dbcc13648-596853f3-0083-46e0-b654-396eedd657cb-000000@email.amazonses.com>
 <20260423235158.3732476-1-john@jagalactic.com>
 <0100019dbcc1f7da-e3c5b4b3-6505-4dc6-9952-70a4676cbdb6-000000@email.amazonses.com>
 <69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69ebe836a8ea_bde13100d@iweiny-mobl.notmuch>

On Fri, Apr 24, 2026 at 05:01:26PM -0500, Ira Weiny wrote:
> John Groves wrote:
> > From: John Groves <John@Groves.net>
> > 
> 
> There is a misunderstanding of what a region_extent was intended to do.
> 
> >From my original commit message:
> 
> <quote>
>     Regions are made up of one or more devices which may be surfacing memory
>     to the host.  Once all devices in a region have surfaced an extent the
>     region can expose a corresponding extent for the user to consume.
>     Without interleaving a device extent forms a 1:1 relationship with the
>     region extent.  Immediately surface a region extent upon getting a
>     device extent.
> </quote>
> 
> Without interleave support the relationship should remain 1:1.
> 
> I don't see any comments here which indicate interleaving is being added.
> 
> I think the misunderstanding started with the modifications that Anisa
> did trying to make device extents contiguous.  Her version of the commit
> message:
> 
> <quote>
>     Regions are made up of one or more devices which may be surfacing memory
>     to the host. Once all devices in a region have surfaced an extent the
>     region can expose a corresponding extent for the user to consume.
>     A region extent is comprised of 1 or more contiguous device extents with
>     the same tag. It is surfaced after all extents from the DC event ar
>      processed (events grouped together with the "More" flag).
>     Interleaving is unsupported.
> </quote>
> 
> >From what I can tell Anisa confused 'region_extent' with dax device.
> struct dax_dev is the container to group together extents.
> 
> Look at the diagrams in this presentation:
> 
> https://lpc.events/event/18/contributions/1826/attachments/1435/3335/LPC2024_CXL_DCD-v2.pdf
> 
> 'DAX dev 1' covers memory from Extent A and Extent B.  What yall will want
> to do is ensure that the region extents which get surfaced are ordered
> based on the sequence number _when_ _the_ _dax_ _device_ is created.  The
> order they come into the host does not really matter.  Although yea the
> spec has a bunch of rules...  so whatever, follow those.  But it is the
> dax device which groups the extents into a contiguous HPA range and maps
> those ranges through struct dev_dax->ranges.
> 
> Patch 2/4 tries to undo the contiguous DPA requirement.  This is going
> down a bad path.  We should go back and fix Anisa's patch rather than add
> on top of all this misunderstanding.
> 
I think what John meant was that we can squash this patchset rather than apply
on top.

All 4 of these patches should be able to be squashed into "cxl/extent: Process
dynamic partition events and realize region extents", which is the commit that
added the extent add/remove logic.

I can squash them by EOD and we can iterate from that? Would that work?

Anyway seems like I've made a huge mess from my confusion... sorry all :(

Thanks,
Anisa

> It may also be advantageous to remove the region_extent if interleave is
> way far out on the support list...  But it was added by me because folks
> in our meetings insisted it was something we should consider in the
> initial implementation.  Sounds like that is just confusing things.  So I
> have to say if I were Dan I would probably be boiling right now with the
> added complexity Ira added to the series...  :-/  Sorry...
> 
> Regardless, this series is a bad way to try and get the base series fixed
> up.
> 
> Allow Anisa to go back and remove the contiguous restriction and fix up
> the base series.
> 
> Ira
> 
> > Terminology note: "CXL region" (struct cxl_region) is the
> > mode-agnostic HDM-decoded HPA window; "DAX region"
> > (struct cxl_dax_region, nicknamed cxlr_dax) is the DCD-specific
> > CXL->device-dax shim that hangs off a cxl_region.  This commit
> > touches only the DAX-region shim; nothing about cxl_region, its
> > HDM decoding, or its lifecycle changes.
> > 
> > Prior to this commit, struct cxl_dax_region holds a single
> > region_extent pointer, so at most one tagged allocation can ever
> > surface under a DAX region.  A subsequent commit rewrites DCD
> > add-capacity handling to assemble extents per-tag and permits multiple
> > allocations per More-chain; that work is latent until cxlr_dax can
> > actually hold more than one region_extent.  Do the infrastructural
> > swap here, on its own, so the behavior change lands in a dedicated
> > commit and the per-tag assembly work isn't tangled with storage-layout
> > changes.
> > 
> > Replace the single-slot pointer with an xarray.  Note: the xarray is
> > *not* keyed by UUID.  xarray is a radix tree over unsigned-long keys;
> > a 128-bit pseudo-random UUID is neither the right width nor the right
> > distribution for a radix index.  The key is an allocator-assigned u32
> > obtained via xa_alloc() when online_region_extent() registers the
> > device; that same u32 is stored in region_extent->dev.id so device
> > names become "extent<rid>.<id>" with unique suffixes per allocation
> > (replacing the hardcoded .0).  UUID remains a stored attribute on
> > struct region_extent; tag-based lookup is a linear xa_for_each walk,
> > which is adequate at the bounded per-region tag counts DCD delivers.
> > 
> > User-visible naming: device names remain "extent<rid>.<N>".  Before
> > this commit, N is always 0; after, N is the xa_alloc()-assigned id.
> > The first region_extent under a cxlr_dax still lands at id 0, so a
> > single-allocation region is observably unchanged.  Only a 2nd+
> > region_extent (which cannot be produced at all today) gets a
> > non-zero suffix.
> > 
> > Call-site translations:
> > 
> >   - cxl_dax_region_alloc() / _release(): xa_init / xa_destroy.
> >   - alloc_region_extent(): drop the hardcoded dev.id = 0; the ID is
> >     assigned when online_region_extent() registers the device.
> >   - online_region_extent(): device_initialize() first so the release
> >     function is wired, then xa_alloc(), assign the returned id into
> >     dev->id, then dev_set_name() and device_add().  On any failure
> >     from xa_alloc() onward, put_device(dev) -> release ->
> >     free_region_extent() -> xa_erase() handles cleanup; no explicit
> >     xa_erase() is needed in the error path of online_region_extent().
> >   - free_region_extent(): xa_erase() replaces NULLing the slot.
> >   - extents_contain() / extents_overlap(): nested xa_for_each, outer
> >     over region_extents, inner over decoder_extents.
> >   - cxl_rm_extent(): walk region_extents and match by UUID to find
> >     the target region_extent (linear, bounded).
> >   - cxl_add_extent()'s "already onlined" gate: translated from
> >     single-slot NULL check to !xa_empty().  This preserves the
> >     existing single-region_extent-per-cxlr_dax invariant; lifting
> >     that gate to actually support multiple allocations is a separate
> >     semantic change that belongs with the per-tag assembly rework.
> > 
> > The dax-side (drivers/dax/cxl.c) is unchanged.  cxl_dax_region_probe()
> > still iterates region_extent children via device_for_each_child() on
> > cxlr_dax->dev, and cxl_dax_region_notify() still takes a
> > struct region_extent * through cxl_notify_data; neither the CXL<->DAX
> > boundary nor the DAX resource model is affected.
> > 
> > No functional change: all paths still observe at most one
> > region_extent per cxlr_dax; this commit only prepares the storage.
> > 
> > Signed-off-by: John Groves <John@Groves.net>
> > Signed-off-by: John Groves <john@groves.net>
> > ---
> >  drivers/cxl/core/extent.c | 89 ++++++++++++++++++++++-----------------
> >  drivers/cxl/core/region.c |  2 +
> >  drivers/cxl/cxl.h         |  9 +++-
> >  3 files changed, 61 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index c4ad81814fb4d..44b58cd477655 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> > @@ -87,7 +87,8 @@ static void free_region_extent(struct region_extent *region_extent)
> >  	xa_for_each(&region_extent->decoder_extents, index, ed_extent)
> >  		cxled_release_extent(ed_extent->cxled, ed_extent);
> >  	xa_destroy(&region_extent->decoder_extents);
> > -	region_extent->cxlr_dax->region_extent = NULL;
> > +	xa_erase(&region_extent->cxlr_dax->region_extents,
> > +		 region_extent->dev.id);
> >  	kfree(region_extent);
> >  }
> >  
> > @@ -144,7 +145,6 @@ alloc_region_extent(struct cxl_dax_region *cxlr_dax, struct range *hpa_range,
> >  	region_extent->hpa_range = *hpa_range;
> >  	region_extent->cxlr_dax = cxlr_dax;
> >  	uuid_copy(&region_extent->uuid, uuid);
> > -	region_extent->dev.id = 0;
> >  	xa_init(&region_extent->decoder_extents);
> >  	return no_free_ptr(region_extent);
> >  }
> > @@ -153,12 +153,26 @@ int online_region_extent(struct region_extent *region_extent)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = region_extent->cxlr_dax;
> >  	struct device *dev = &region_extent->dev;
> > +	u32 id;
> >  	int rc;
> >  
> >  	device_initialize(dev);
> >  	device_set_pm_not_required(dev);
> >  	dev->parent = &cxlr_dax->dev;
> >  	dev->type = &region_extent_type;
> > +
> > +	/*
> > +	 * Insert into cxlr_dax->region_extents before dev_set_name so
> > +	 * the allocated id is available as the .<N> suffix.  On any
> > +	 * failure from here on, put_device(dev) -> release ->
> > +	 * free_region_extent() -> xa_erase() handles the cleanup.
> > +	 */
> > +	rc = xa_alloc(&cxlr_dax->region_extents, &id, region_extent,
> > +		      xa_limit_32b, GFP_KERNEL);
> > +	if (rc < 0)
> > +		goto err;
> > +	dev->id = id;
> > +
> >  	rc = dev_set_name(dev, "extent%d.%d", cxlr_dax->cxlr->id, dev->id);
> >  	if (rc)
> >  		goto err;
> > @@ -167,7 +181,6 @@ int online_region_extent(struct region_extent *region_extent)
> >  	if (rc)
> >  		goto err;
> >  
> > -	cxlr_dax->region_extent = region_extent;
> >  	dev_dbg(dev, "region extent HPA %pra\n", &region_extent->hpa_range);
> >  	return devm_add_action_or_reset(&cxlr_dax->dev, region_extent_unregister,
> >  					region_extent);
> > @@ -184,17 +197,16 @@ static bool extents_contain(struct cxl_dax_region *cxlr_dax,
> >  			    struct cxl_endpoint_decoder *cxled,
> >  			    struct range *new_range)
> >  {
> > -	struct region_extent *re = cxlr_dax->region_extent;
> > +	struct region_extent *re;
> >  	struct cxled_extent *entry;
> > -	unsigned long index;
> > -
> > -	if (!re)
> > -		return false;
> > -
> > -	xa_for_each(&re->decoder_extents, index, entry) {
> > -		if (cxled == entry->cxled &&
> > -		    range_contains(&entry->dpa_range, new_range))
> > -			return true;
> > +	unsigned long i, j;
> > +
> > +	xa_for_each(&cxlr_dax->region_extents, i, re) {
> > +		xa_for_each(&re->decoder_extents, j, entry) {
> > +			if (cxled == entry->cxled &&
> > +			    range_contains(&entry->dpa_range, new_range))
> > +				return true;
> > +		}
> >  	}
> >  	return false;
> >  }
> > @@ -203,17 +215,16 @@ static bool extents_overlap(struct cxl_dax_region *cxlr_dax,
> >  			    struct cxl_endpoint_decoder *cxled,
> >  			    struct range *new_range)
> >  {
> > -	struct region_extent *re = cxlr_dax->region_extent;
> > +	struct region_extent *re;
> >  	struct cxled_extent *entry;
> > -	unsigned long index;
> > -
> > -	if (!re)
> > -		return false;
> > -
> > -	xa_for_each(&re->decoder_extents, index, entry) {
> > -		if (cxled == entry->cxled &&
> > -		    range_overlaps(&entry->dpa_range, new_range))
> > -			return true;
> > +	unsigned long i, j;
> > +
> > +	xa_for_each(&cxlr_dax->region_extents, i, re) {
> > +		xa_for_each(&re->decoder_extents, j, entry) {
> > +			if (cxled == entry->cxled &&
> > +			    range_overlaps(&entry->dpa_range, new_range))
> > +				return true;
> > +		}
> >  	}
> >  	return false;
> >  }
> > @@ -306,21 +317,25 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> >  	}
> >  
> >  	cxlr_dax = cxlr->cxlr_dax;
> > -	reg_ext = cxlr_dax->region_extent;
> > +	import_uuid(&tag, extent->uuid);
> > +	{
> > +		struct region_extent *r;
> > +		unsigned long idx;
> > +
> > +		reg_ext = NULL;
> > +		xa_for_each(&cxlr_dax->region_extents, idx, r) {
> > +			if (uuid_equal(&r->uuid, &tag)) {
> > +				reg_ext = r;
> > +				break;
> > +			}
> > +		}
> > +	}
> >  	if (!reg_ext) {
> > -		dev_err(&cxlr->cxlr_dax->dev,
> > -			"no capacity has been added to the region\n");
> > +		dev_err(&cxlr_dax->dev,
> > +			"no region_extent matches tag %pU\n", &tag);
> >  		return -ENXIO;
> >  	}
> >  
> > -	import_uuid(&tag, extent->uuid);
> > -	if (!uuid_equal(&tag, &reg_ext->uuid)) {
> > -		dev_err(&cxlr->cxlr_dax->dev,
> > -			"extent tag %pU doesn't match region tag %pU\n",
> > -			&tag, &reg_ext->uuid);
> > -		return -EINVAL;
> > -	}
> > -
> >  	calc_hpa_range(cxled, cxlr_dax, &dpa_range, &hpa_range);
> >  	if (!range_contains(&reg_ext->hpa_range, &hpa_range)) {
> >  		dev_err(&cxlr_dax->dev,
> > @@ -329,9 +344,7 @@ int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> >  		return -EINVAL;
> >  	}
> >  
> > -	rc = cxlr_notify_extent(cxlr,
> > -				DCD_RELEASE_CAPACITY,
> > -				cxlr_dax->region_extent);
> > +	rc = cxlr_notify_extent(cxlr, DCD_RELEASE_CAPACITY, reg_ext);
> >  	if (rc == -EBUSY)
> >  		return 0;
> >  
> > @@ -416,7 +429,7 @@ int cxl_add_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> >  
> >  	cxlr_dax = cxlr->cxlr_dax;
> >  	/* Cannot add to a region_extent once it's been onlined */
> > -	if (cxlr_dax->region_extent) {
> > +	if (!xa_empty(&cxlr_dax->region_extents)) {
> >  		dev_err(&cxlr_dax->dev, "Can no longer add to region %d\n",
> >  			cxlr->id);
> >  		return -EINVAL;
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index 15065d9a1cbf2..42b3a3bbd502f 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -3546,6 +3546,7 @@ static void cxl_dax_region_release(struct device *dev)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> >  
> > +	xa_destroy(&cxlr_dax->region_extents);
> >  	kfree(cxlr_dax);
> >  }
> >  
> > @@ -3590,6 +3591,7 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  	if (!cxlr_dax)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > +	xa_init(&cxlr_dax->region_extents);
> >  	cxlr_dax->hpa_range.start = p->res->start;
> >  	cxlr_dax->hpa_range.end = p->res->end;
> >  
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 53d8a2f0d1272..715fa9e580cb0 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -637,7 +637,14 @@ struct cxl_dax_region {
> >  	struct device dev;
> >  	struct cxl_region *cxlr;
> >  	struct range hpa_range;
> > -	struct region_extent *region_extent;
> > +	/*
> > +	 * region_extents is keyed by an allocator-assigned u32 (see
> > +	 * online_region_extent()), not by extent UUID.  The UUID is a
> > +	 * 128-bit pseudo-random identity carried on each region_extent;
> > +	 * tag lookup is a linear xa_for_each walk, which is adequate at
> > +	 * the bounded per-region tag counts this driver handles.
> > +	 */
> > +	struct xarray region_extents;
> >  };
> >  
> >  /**
> > -- 
> > 2.53.0
> > 
> > 
> 
> 
