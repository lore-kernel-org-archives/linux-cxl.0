Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com [74.125.224.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9442CB15
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 21:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785361249; cv=none; b=WSS43qP1NPeOgDHmVRrDPVKwt4NmXrpUKhaXf8sg9Wfke1Jw0E1SgKkJ9P/TdZK2lKRFwAHXT+tl4wXCimCkwisXAXDX7YEuyV3FYlQ5/93aOs51Ff6lF/uaOweCgbkxiYh0ZCDEH3uN2OdNV6A+IxxwwLX2MNodq9E1tLF3lhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785361249; c=relaxed/simple;
	bh=JNEQ7rR1WM8PzoXdoNbQgKMHlFDVjglI0tzJrq2Jnp8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHtHFRyYiVoDm5ztW4a+Khr60s7rpQcnkJ69Z99g8a+As7SlP+yr0dBu0E5trQ++/WaEgdvfKCIxifUGmiAhLnPxD/xw4Of7f/vj+V3kkfMUX9SX7J5Df1C++p6H6kiat+NQeY6AuYoftPJewNsaKw6JT20mBTLWKrT5iFA9n0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L+WFhD3U; arc=none smtp.client-ip=74.125.224.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L+WFhD3U"
Received: by mail-yx1-f42.google.com with SMTP id 956f58d0204a3-667923d86a7so201075d50.0
        for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 14:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785361247; x=1785966047; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z+DgA4zG6AwsPezIGSHy64caLYuuPCqGKZCNKn+wt8Q=;
        b=L+WFhD3U2KSYY3xUjJri+4zuEhRURxbfP12+iHtGA+bG8aRz5a7LYDOiPYDj5/wnBu
         rWFjIoSgftD3NpMGWFGE6xmWrOwNVUERGp43T0yj9qbfu8Z8p+ntURo0HfYt2lXXRYZ/
         zaFKrvxsknupvmVbeJrqvXcKrVVfXhjHTW4apTFiiUdg6MoruW51UqB74otUdwv9Ls5Z
         ckSR1A0/JNhfsByKK3cwD5swxU7K5uDR+Eoc4jrnn3AHyktN5CFUecePwnzhaDeEztF0
         k1SW71La8Vz7k7M9vQhpqytmxugm6mmpCW0piwQOeUnE/v6GFPYG78FM34ONJ7r/ZPUX
         78RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785361247; x=1785966047;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Z+DgA4zG6AwsPezIGSHy64caLYuuPCqGKZCNKn+wt8Q=;
        b=irIZVY5qCRTWlouULkKgYKQa2YKGzPHRRVBhfMe1aLiyM3aaYVVSOytMOpUWkVHowW
         FT8rR9hroCi83iMKOiUsHZg+t6xZMYx93GN59/VhxtRpR/MGUaU8qKZmqeghslnt05FE
         +/H5ubXrlgmdrw5fahN0QXkc2RwNXXm7RMXHolYgosazjyL8TFowL11N8IKRqt+kVmZG
         rqgeuIvFW+dVaua3jXfaBmvc8vfMB9ADoXwT+56H11iMZN88uX8ClksFJMvq1KV7V/Eg
         1n5naEU+lWW1BmmOGUKdOJXDilR0pMAJ2OJ9EFAUVeL2G1tHxR3dTuPvRjSpd0VUoLgq
         NhNg==
X-Forwarded-Encrypted: i=1; AHgh+RpqO0RjjnSU65FHd+gSoA23r6gH7hMu2Ka2YqBr3TZmOVf1Xg11oLRaupsIDH3DibpjyPrjSdg/kD4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Q/Y/OVKCq/JySvzUPgie4ba5ofkx39ToYPUZfZj9qUi8Gs3m
	DW82yjiynNpOSxQZSK9SZR7/gRO/83Pf/BHBfLBuzcVpKH8ZPRE78KigPhZ/Rw==
X-Gm-Gg: AR+sD12/zlXTZxUShcCXCdveaSHl/z74Z6AZ7XGGfMcFqSmP0bCN3V+r+OBb+0ppxVe
	eegXjHjxeJTviIiWcTzv0IVNEh/emLxv/no0YnwKcrItNIh+VoHwWvAuBsBLwBpWSqhzXylcoWj
	uFrJItp2H+01hDnKxNu5Cpsj1brLKfgfHr+25vq+/37ODkKDMrW+KSnI3XKZpMHUg5vlrnr5hom
	GdqiAGJK3C6OpRxAdSWZQXWowdJy3bZEs09L9VXqmR5OyYVSeZIJnv9qINwzfxwzXIWvCX0jRHJ
	yILgmmU7g2+Tdoy1JqhvMTs2qzNgkbF2ppmo183NpsqsBARr1STbHZW0UROhTaEXgTCqm+HebTA
	i5uhuBNptAxmQDEeIXwfhekJI9HQcVYHaMnQbP4CmqWLN070Z2LZwaZPypidgk5gj8t3rH2ISQv
	8kHp0fMF+YjGOHsvMQxqkVMU5FRvQlktVTI70VsYNZcG8up8HhJuaEw7t3SlPbhRMp+OdXeSSV7
	iMlDr1Ddtr7Gjx93g==
X-Received: by 2002:a05:690e:4147:b0:668:14a7:d00d with SMTP id 956f58d0204a3-6692cc954cbmr44749d50.2.1785361246686;
        Wed, 29 Jul 2026 14:40:46 -0700 (PDT)
Received: from 4470NRD-ASU.ssi.samsung.com ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6692c7479c9sm66816d50.7.2026.07.29.14.40.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 14:40:46 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 29 Jul 2026 14:40:44 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 18/31] cxl/extent: Handle DC Release Capacity events
Message-ID: <ampzXMtmkiQAHVzU@4470NRD-ASU.ssi.samsung.com>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-19-anisa.su@samsung.com>
 <20260625182339.95A1F1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625182339.95A1F1F00A3A@smtp.kernel.org>

On Thu, Jun 25, 2026 at 06:23:38PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] Lockless iteration over the shared `cxlr_dax->dc_extents` xarray leads to Use-After-Free.

Fixed -- same bug reported in patch 14. The fix is split across both patches by
making the free rcu deferred and calling guard(rcu) appropriately.

> - [High] Unsynchronized non-atomic modifications to `group->nr_extents` lead to lost decrements and tag group leak.

Duplicate false positive reported in patch 14 and 16.
A single tag group/s extents are never released concurrently.

> - [High] Multi-extent tag group releases incorrectly tear down the entire group on the first chunk, causing spurious errors and WARN_ON stack traces on subsequent chunks.

Partial False Positive -- The WARN_ON case is not reachable (see below)

RFC for the spurious error case:

Currently extents are eagerly released. If a release event record
contains a full tag group of 3 extents, upon processing the first extent, if
no extents in the group are in use, the entire group is released.

This way, partial release requests from a faulty or naive FM are handled
by releasing the entire group anyway and we don't hold onto unused capacity.
It's also less code.

It does cause the kernel to emit the following dev_err logs for the next extent
if it belonged to the same tag group.
Specifically in cxl_rm_extent: 
dev_err(&cxlr_dax->dev,                                         
	"release DPA %pra (%pU) matches no dc_extent\n", &dpa_range, &tag);    

Then cxl_rm_extent returns -ENXIO to the caller cxl_handle_dcd_event_records(), 
which will print:

if (rc)
	dev_err_ratelimited(dev, "dcd event failed: %d\n", rc);

This is misleading, but the current greedy release policy can't distinguish between this
spurious case and an actually bogus extent that was never provisioned to us or
accepted in the first place.

If we want to distinguish between the 2 scenarios, then release needs
to follow a similar path as add:
- hold extents in a pending_release context
- 20 second timeout for end of "More" chain
- when chain closes (More=0):
	- loop over pending release list
	- extract tag groups
	- check if the tag matches any currently tracked tag groups
	- check that each extent 100% matches extents in the tracked group
		- same number of extents in the group
		- each extent has the same start_dpa and length as its tracked
		  counterpart
		- tracked extent is unused
	- if there is a mismatch:
		- err and hold onto the tag group?
			- IMO doesn't make sense to hold onto unused capacity
		- err and release the tag group anyway?
			- this is the same as the current behavior and the
			  only gain is that err msgs are not printed in
			  the success case
	- else (no mismatch):
		- release the group (no err msg)

Estimated + ~150 LOC to implement.

Proposed change:
downgrade dev_err to dev_dbg.
ack the release to tell the device we're not using the capacity (similar to the
other 2 cases in which !cxlr or !cxlr_dax) and return 0 from cxl_rm_extent

(see below)

> --
> 
> commit 277b0b7ee1e3ee9199ddbac19db51d5566770cbb
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/extent: Handle DC Release Capacity events
>     
> This commit replaces the no-op ack stub for cxl_rm_extent() with the real
> teardown logic. It resolves the released DPA range to its region and endpoint
> decoder, locates the matching dc_extent, and tears down the entire containing
> tag group atomically.
> 
> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index 0ebb581ca8335..a590a89f35802 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> [ ... ]
> > +static void rm_tag_group(struct cxl_dc_tag_group *group)
> > +{
> > +	struct device *region_dev = &group->cxlr_dax->dev;
> > +	struct dc_extent *dc_extent;
> > +	unsigned long index;
> > +
> > +	/*
> > +	 * Pin @group across the walk: each devm_release_action runs the
> > +	 * dc_extent_unregister action synchronously, which drops the last
> > +	 * reference on the dc_extent device and fires dc_extent_release.
> > +	 * The release decrements group->nr_extents and, on the final
> > +	 * decrement, frees @group.  Without the pin the next iteration's
> > +	 * xa_find_after() dereferences a freed xarray.
> > +	 */
> > +	group->nr_extents++;
> > +	xa_for_each(&group->dc_extents, index, dc_extent)
> > +		devm_release_action(region_dev, dc_extent_unregister, dc_extent);
> 
> [Severity: High]
> What happens if a device releases a multi-extent tag group by sending multiple
> DCD release events (one per chunk)?
> 
> When the host processes the first event, cxl_rm_extent() resolves the group
> and calls rm_tag_group(), which atomically unregisters all extents. If the
> sysfs reference is > 0 (e.g. userspace has a file open), the extents remain
> in the xarray.
> 
> When subsequent release events for the remaining chunks are processed,
> cxl_rm_extent() finds the same group and calls rm_tag_group() again. Will
> invoking devm_release_action() on already-removed actions trigger a
> WARN_ON(!devres) stack trace?
> 
Not reachable. While extents are in use, cxlr_notify_extent() returns -EBUSY
and cxl_rm_extent() returns 0 without calling rm_tag_group() at all; and once
a group is torn down its extents are erased from dc_extents, so a later event
can't re-select them to double-release. There is no double devm_release_action,
so no WARN.

> > +	group->nr_extents--;
> > +	if (!group->nr_extents)
> > +		free_tag_group(group);
> 
> [Severity: High]
> Can this result in lost decrements and a tag group leak?
> 
> Since group->nr_extents is a plain unsigned int, a lockless decrement here
> in rm_tag_group() could race with dc_extent_release(). If userspace holds
> references to multiple extents in the same tag group via sysfs and closes
> them concurrently, dc_extent_release() will run on multiple CPUs
> simultaneously.
> 
> This would race with the decrement here, preventing the counter from reaching
> zero and permanently leaking the cxl_dc_tag_group and its UUID.
> 
> > +}
> > +
> > +int cxl_rm_extent(struct cxl_memdev_state *mds, struct cxl_extent *extent)
> > +{
> [ ... ]
> > +	/*
> > +	 * Find the dc_extent whose DPA range covers the released range and
> > +	 * whose tag matches.  The release targets the entire containing
> > +	 * tag group atomically; partial release is not supported.
> > +	 */
> > +	group = NULL;
> > +	xa_for_each(&cxlr_dax->dc_extents, idx, dc_extent) {
> > +		if (dc_extent->cxled != cxled)
> 
> [Severity: High]
> Is it safe to iterate the shared cxlr_dax->dc_extents xarray without RCU
> protection or a write lock here?
> 
> cxl_rm_extent() and cxlr_dax_classify_extent() iterate over the shared
> xarray using xa_for_each() while holding cxl_rwsem.region only for read. If
> concurrent DCD events from different memdevs in the same interleaved region
> trigger rm_tag_group() or a failed cxl_add_extent(), dc_extent objects can be
> removed and synchronously freed via kfree() in dc_extent_release() by another
> thread.
> 
> Since xa_for_each() drops the internal RCU lock during the loop body, could
> the iterating thread dereference a freed dc_extent pointer here?
> 
The xa_for_each is put inside scoped__guard(rcu){} block, since
cxlr_notify_extent() is called afterwards, which takes dax_region_rwsem via
down_write() and can sleep.

> > +			continue;
> > +		if (!range_contains(&dc_extent->dpa_range, &dpa_range))
> > +			continue;
> > +		if (!uuid_equal(&dc_extent->group->uuid, &tag))
> > +			continue;
> > +		group = dc_extent->group;
> > +		break;
> > +	}
> > +	if (!group) {
> > +		dev_err(&cxlr_dax->dev,
> > +			"release DPA %pra (%pU) matches no dc_extent\n",
> > +			&dpa_range, &tag);
> 
> [Severity: High]
> Could this error path be triggered spuriously on multi-chunk releases?
> 
> If a device sends multiple DCD release events for a multi-extent tag group,
> the first chunk will cause rm_tag_group() to unregister all extents. If sysfs
> references are zero, the extents are freed immediately.
> 
> When subsequent release events for the remaining chunks are processed, they
> will fail to find the group here and print this spurious "matches no dc_extent"
> error.
Proposed change:

Re-ack the release here with memdev_release_extent() to let the device know
we're not using the capacity. This is consistent with how null cxlr and
cxlr_dax are handled (earlier in the function, snipped in sashiko's response):

guard(rwsem_read)(&cxl_rwsem.region);
	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
	if (!cxlr) {
		/*
		 * No region can happen here for a few reasons:
		 *
		 * 1) Extents were accepted and the host crashed/rebooted
		 *    leaving them in an accepted state.  On reboot the host
		 *    has not yet created a region to own them.
		 *
		 * 2) Region destruction won the race with the device releasing
		 *    all the extents.  Here the release will be a duplicate of
		 *    the one sent via region destruction.
		 *
		 * 3) The device is confused and releasing extents for which no
		 *    region ever existed.
		 *
		 * In all these cases make sure the device knows we are not
		 * using this extent.
		 */
		memdev_release_extent(mds, &dpa_range);
		return -ENXIO;
	}
cxlr_dax = cxlr->cxlr_dax;
	if (!cxlr_dax) {
		/*
		 * The region exists but its dax region is not set up, so the
		 * host is not tracking this extent.  Tell the device it is not
		 * in use, as in the no-region case above.
		 */
		memdev_release_extent(mds, &dpa_range);
		return -ENXIO;
	}

Downgrade the above dev_err to dev_dbg.

And instead of returning -ENXIO, return 0. The caller
cxl_handle_dcd_event_records() only uses rc to determine if it should print:

if (rc)
		dev_err_ratelimited(dev, "dcd event failed: %d\n", rc);

cxl_handle_dcd_event_records() is a void function and does not propagate rc.
The drawback is that this line is ommitted for a genuinely bogus
release extent.

Or return -ENXIO, consistent with the null cxlr and cxlr_dax case and print
the dcd event failed line, even for the spurious case.

- Anisa
> 
> > +		return -EINVAL;
> > +	}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625112638.550691-1-anisa.su@samsung.com?part=18
