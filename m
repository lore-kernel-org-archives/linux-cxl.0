Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250D443DA31
	for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 08:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785314092; cv=none; b=drPcEUmWLpwuOCFIdE+eO05R/3SVIRKWiTd/SaeuhtN8oaTM3VacI3VUsnVEDZ3UjG1V59EoMBFe4BS/0dxP+/nTnRK+txycZ8NnvNLm6pfLU7yuBLctbpqWBehwfgt3c1Kgk1AGAnwdegxCYMo6mTCbTFYycoq1dYvdVq+JvjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785314092; c=relaxed/simple;
	bh=VBWe4z6lpdhgWWhgi9ZL4hf+LSw7oDXHex0pW15bWNM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UTdpANrxSFvnhGgbzRWmQi0AWcig4YfBY0ltL/nyPsbuCyhHV5HSK1jGxv6AgA8itLf+gA5+65/ikTXQwcEmcATWi0kmzZvnkOiMzYl5OOjZWN6lqthe2nMx5DxOln8ACrPMw1YfUM0KDyPN1mH45gVNbXTDHsaOrqpAuv0rUQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b8LN3Q+M; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8LN3Q+M"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2cc61541f8cso26639195ad.0
        for <linux-cxl@vger.kernel.org>; Wed, 29 Jul 2026 01:34:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785314082; x=1785918882; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=y8VVG7c5rynDfSnOxDa5w1W+bUds2tSk8XMQSsCkTs4=;
        b=b8LN3Q+MMRoVwdoybUjAaHwme5b1Io8UiuPa6R35FaeVUQoy9amYOGmTs3wr0W1nlp
         lfLXlJPHlXojKJG6X+tw5sR+kY/ikbUmk2AeiFQMXPnTlhumGIGcEU1A10QQr4gKiKJD
         as5uQN/S3YSmlrXNd5PdM2BZHes3rVriYudx62UNF2FfU875Jodkk8iTB5e+3UHq00xU
         +lrtpK1EWmJtQOC5QEZVFEll+CoYbIETPf9UrPrQpnp8ii5326mzToGA7bDsrp2TvhHE
         yy53CCBRU9LIoEou3xkjMo4DjWmGb+wsedwjPq5A6EBU4Xh2yRT8jtS8YJ/oVGXXg0yY
         OvzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785314082; x=1785918882;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=y8VVG7c5rynDfSnOxDa5w1W+bUds2tSk8XMQSsCkTs4=;
        b=fMn1FaBt+ovx2kVFUUY37gDv5iPQO44SbEy1gCJOugy7hs9IVXdtOh2FBgX3SGxen1
         SUHaPrJ5CYQ83yQ8+LzZNCgLbLT8ZS+mfbCZ5IIouCZctkS0NnfDwUJzAF61UdG0a5II
         H5mpE4n5wtFL4354wz7xLaFBfnj3AEu/YwK/kdMXad3SieBKEpXC57ODa9UX8k/tDC0z
         p9Rkpk2K4ahhQl0/wAdW8YO9WgoTgM6rTCzLZ9+6uWsKt6uRcIqP+uFliG7vV2RfPcXr
         /OoZofeSmoHSH1cqLBz5bLHk4fObQNA/mZwMfSVZw9PAJ5KUmmcz6yb7Ui32k84YBxH9
         G0Aw==
X-Forwarded-Encrypted: i=1; AHgh+Roq0d3HtcNM4TTEDjIAmjg/kxvPODkkIWS0NaJ9ZVUuOq7R1D74e5KhZfoi+q1euA+buhTHAkAqLTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywgh3a0wwPsB/jFY/jw3LH/lUTIiPAxGO2SF/8FXVs80dMmdwUu
	qUXiC9Rl4wnrqFQzgRPoDckXziOayAo0eSMmqK+am/zEHlIkDJk60Ee8
X-Gm-Gg: AR+sD112LCywRdUAK1udTxfDcvOIA9d6n79plkCUpT+83u6JIWHZDJeuZg2Eq97RW5k
	1rEKwIPFSdGLVvTMB68FeN8cpSo57Eh+PpzHohvBndIi73dAneMfCD32OMCE7MljBSqFF2hii3s
	kk7JzXWB3gXG9k3BYaujxTSi7Ux61IE170V7g8V+PJnRNnISnUmm2lsMJrTDQOYGt7YYmVjGZzD
	rLmFFB/bRCmjepEQ2HVqQMN1hDjlF8WKrlSBADC2ur6YvZ+TK3hpnEt6AbXXnzDDbMK3AToKGal
	of8S+LcfQ9VEHwXjssVeuwSzHRYrHpjhf8YV61ReUprlq/nsvyMOrqlFJRdHjVU316PFPT0gFQB
	o8mZ5h276OeWvFbW1xjbLXnijXsqfaLzWM2j7/7xcLo655NjzdVT6p3asfpN/SgS1Hn8Q6a1NKP
	zU6SS3fFPWg/LRReYT3NSVz5kn0I1o2LyJxyuyckm3JZ6O9eto1bASLnT9DBf6AO9qlHAK0YYUq
	GSbWTV2sSoBh462Ab3lcKHBCk9tFyFP6aFEIMm9YXNN
X-Received: by 2002:a17:903:2c04:b0:2ca:12aa:a390 with SMTP id d9443c01a7336-2d02625525dmr14066595ad.0.1785314081788;
        Wed, 29 Jul 2026 01:34:41 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022bf888csm7779935ad.64.2026.07.29.01.34.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 01:34:41 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 29 Jul 2026 01:34:40 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 16/31] cxl/extent: Validate DC extent partition
Message-ID: <amm7IJgMdlMpb7dd@AnisaLaptop.localdomain>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-17-anisa.su@samsung.com>
 <20260625182052.07E301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625182052.07E301F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 06:20:51PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Entirely duplicate tag groups are rejected and dropped instead of replying success to the device.
True but benign. And also unlikely. Even if an entirely duplicate tag
group is ommitted from the DC add response, since the capacity was
previously added, it's still provisioned to the host until a release
event.

> - [High] Concurrent access to `group->nr_extents` without locks causes a memory leak and pins the DAX region device indefinitely.
False Positive.

> --
> 
> commit b3bfb6df5d2f0f0f9e2b022064279f74742afa2e
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/extent: Validate DC extent partition
>     
> Extend cxl_validate_extent() — the per-extent check of the add pipeline
> to check partition membership. Resolves an extent's DPA to its containing
> DC partition. Sharability is a property of the partition (part->shareable),
> taken from its CDAT DSMAS entry.
> 
> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index 6e67e787d14de..2e770c5279c23 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> 
> [ ... ]
> 
> > @@ -101,6 +159,27 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
> >  		.end = start_dpa + le64_to_cpu(extent->length) - 1,
> >  	};
> >  	struct range ed_range;
> > +	uuid_t uuid;
> > +
> > +	import_uuid(&uuid, extent->uuid);
> > +
> > +	part = cxl_extent_dc_partition(mds, extent, &ext_range);
> > +	if (!part)
> > +		return -ENXIO;
> > +
> > +	if (part->shareable) {
> > +		if (uuid_is_null(&uuid)) {
> > +			dev_err_ratelimited(dev,
> > +				"DC extent DPA %pra: sharable-partition extent has null tag (firmware bug)\n",
> > +				&ext_range);
> > +			return -ENXIO;
> > +		}
> > +	} else if (le16_to_cpu(extent->shared_extn_seq)) {
> > +		dev_err_ratelimited(dev,
> > +			"DC extent DPA %pra (%pU): non-sharable partition but shared_extn_seq=%u (firmware bug)\n",
> > +			&ext_range, &uuid, le16_to_cpu(extent->shared_extn_seq));
> > +		return -ENXIO;
> > +	}
> >  
> >  	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> >  	if (!cxlr || !cxlr->cxlr_dax)
> 
> [Severity: High]
> This is a pre-existing issue, but I noticed a potential race condition in
> drivers/cxl/core/extent.c:dc_extent_release() that might lead to a leak:
> 
> 	group->nr_extents--;
> 	if (!group->nr_extents)
> 		free_tag_group(group);
> 
> Could concurrent access to group->nr_extents without locks cause a lost
> decrement?
> 
A tag group's extents are never concurrently torn down.

> When userspace closes sysfs files for multiple extents of the same tag group
> concurrently, their kobject refcounts can drop to 0 simultaneously, causing
> dc_extent_release() to run on multiple CPUs in parallel.
>
??? An open sysfs fd does not pin the device's kobject, and closing it
does not trigger the device's release. sysfs files are backed by kernfs,
and kernfs uses active references that are taken only for the duration
of an individual read/write, then dropped — not held across an idle open
fd. The device's own kref comes from device_add() and is dropped by
device_del()/put_device() in the driver-core teardown path, not by
userspace opening or closing sysfs files.


> If group->nr_extents never reaches 0, does this permanently pin the DAX
> region device (since the reference isn't dropped) and leak the
> cxl_dc_tag_group structure?
> 

Well that never happens because there is no lost decrement race.

> [Severity: High]
> This isn't a bug introduced by this patch, but I have a question about how
> duplicate tag groups are handled between drivers/cxl/core/extent.c and
> drivers/cxl/core/mbox.c.
> 
> In drivers/cxl/core/extent.c:cxl_add_extent(), duplicate extents return 0
> without allocating or assigning mds->add_ctx.group:
> 
> 	case CXL_EXT_DUPLICATE:
> 		/*
> 		 * Idempotent accept simplifies the dax-side scan for existing
> 		 * extents on region creation; reply success without duplicating.
> 		 */
> 		dev_warn_ratelimited(&cxled->cxld.dev,
> 				     "Extent %pra exists; accept again\n",
> 				     &ext_range);
> 		return 0;
> 
> If all extents in a group are duplicates, cxl_realize_group() in
> drivers/cxl/core/mbox.c finishes its loop with group_cnt > 0 but
> mds->add_ctx.group remains NULL. It then returns -ENXIO:
> 
> 	tag_group = mds->add_ctx.group;
> 	mds->add_ctx.group = NULL;
> 	if (!tag_group)
> 		return -ENXIO;
> 
> Since this causes the caller cxl_add_pending() to treat the group as an error
> and drop the extents instead of adding them to the accepted list, does this
> leave the device hanging without an ADD_DC_RESPONSE if it resends an
> unacknowledged extent group?
> 
No. cxl_add_pending() always sends a response, even if it's empty. We
simply omit fully duplicate extents from the response.

> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625112638.550691-1-anisa.su@samsung.com?part=16
