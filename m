Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABC436494C
	for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 07:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781163317; cv=none; b=T4I/wPif1J+WLEqYFth5J2/H6x+jk394PDEDqTZKQbkjTXQvh972aY6x4umnXHEwfI471rjDUOirQDuu2+Yuq3HOrB35BLU5t10qtDF0LrwheIvhsjEFZfd5KwIkZi4zpJfXZFMI8zwhm7rtG5YZHxHUqgxq2xQxp+ZkdeqbqxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781163317; c=relaxed/simple;
	bh=ILpNiLCWDwhEg+xrOtsVZTMCa8TTJKYnqIb1fsBn/to=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd2bkSFP30YvTKbGzpKN5f5xSQhUzc+gatN8yFGF06ue3Is/vvgiT0NP7gTkiVymzNW0o+TALHdCtXCSBAePikJ+sGeSzSeAKOS6fl23THhiH4DCi0wDwYbO3HJDpE/fuYrFov5oarJpr3faSBBEcHGaKgk5C/IT1zF+kjNXeOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uh5oJY10; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uh5oJY10"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3075ce9c05aso2874181eec.1
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 00:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781163315; x=1781768115; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=o532ZBa92Bn1kV6y/svVQfZGV2JIbpTmE8EZMxhPVcU=;
        b=Uh5oJY10KC7pTCLmWDuICaAsB0mxbvuH95PHvcYyhfagY18IKotkE+Du0qHmPJ27lN
         dnYgkLXsn6J2DeN5uuelYE0HAm8j5lk/GcSEdr4fPbE5R8QGoQr/TiIOqmc6lVI7gaQw
         +SAABboBqIn16kN1e8DrNLbwyi4I/FloRUa5r9jhNVLHbIiz5P2N1Vk/crZGZ8grzKPT
         tn18lV5h0inRO+Uwa+PoHozic9Ls3aoiQkBjC/8XGtnvjmFJb8n/PG8TPclLPXegv6US
         jP9oK6aLUiXUeY2fWf621PTAQj6cYJjUGa79yz1fKDI6LN3s2tIX+2ybxzlhOsGUlDtK
         3wEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781163315; x=1781768115;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o532ZBa92Bn1kV6y/svVQfZGV2JIbpTmE8EZMxhPVcU=;
        b=n6z/eMx3vQK3iO8WFHmGM/alOA31UQ7QF3L1QzVXOstmIIKjJvoKTzSj302YYm9rVs
         ZdImRXCnvcer+WBptXep+8kd/hh5DIdf9dWxOlUprE6e9uduG0V+iSFKQIO5bodHOLvc
         mmNM7BH7UKBBSXW4F3cYdVzhw51yTrUZ1UHH7/AfOjxvaF79UPNnJdwJaVqZGFe/iH5R
         ZtKSBgD2ub16eK7W2ygTw6W8vyfa/DAzkxRAZYuxVbkuTP1XUjT3Y5w0g7aTIyDjiAwS
         PPeuNLjfEswKZZARitmxXhYF0Jxk4DjYqONVCSq9eMsyTeYFrpM8YvvIm2obZCwi3kjB
         6f+Q==
X-Forwarded-Encrypted: i=1; AFNElJ88lis4Oms6Va8C/ru+VaN6+wk8qlfvfipU3xT4o2ADpjJ56VimWiibp6R4alUbsRdn9UR+SAFjda4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWnnAZo4ESFr1CRVFNYGCcUhpdNfISZtayohkzf/ivoSWIaB5
	LX0H2xR0d/iqNoNiXYejjE6qCfeam5GKbPw3HoqRRgpR3ZSqZy+StxtD
X-Gm-Gg: Acq92OFcq22HqpGnCL+Ycss6kCRXkqGMx1hjUNhovH40l1EhD3f0tMabtUHtN91pSqi
	JfhhxeIT7710a5oNnaTTq/zRQ8yd5R/q+rs/jkHUrgAiztukps9oW0JlI/jZrC3CbldTsiRszNx
	LyH8IDevLCCYmiE+m+ZVtS8VfSNjUidi173bATb59nZ3HIIhtuHcmvU3F5S12CpE456bxV4ahNG
	zPLeE9qAO6jwyKy0zDAlIN2NINB8lBBOPjrC2QWWVc/RIugkNfNpp7EqeMy4/PuATinvWphM6Zk
	0uITQSx2DZPDyBRMb6Fa5GpUQ390XEw1E0EG+IweN7eqDEY7M6PwfFMmgvduOCFgzLSGLMaKayN
	Y+Zsmr8bAf2mafI0yiZKyNxjqMxV3hFlqGtyGfe0a5z8JIZsCCyKOid8N9G1GYMoOQyFoMT7sho
	OuS+mqS8acpk2xSr+1zM6dgMAKXR829CjmaDIT9F1PguHN2aOtt/XSvMwSigja0zo0gWTf4egOd
	kfEzgVFL3NUDUsXnw==
X-Received: by 2002:a05:7300:4307:b0:2e6:e504:5431 with SMTP id 5a478bee46e88-30804a0f00dmr1450108eec.22.1781163312992;
        Thu, 11 Jun 2026 00:35:12 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30806ebb105sm989695eec.23.2026.06.11.00.35.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 00:35:12 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 11 Jun 2026 00:35:11 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v10 16/31] cxl/extent: Validate DC extent partition
Message-ID: <aiplL-1v0Puf2xut@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <def526ee51b647e9256c7e777c6b7bd5cd647f89.1779528761.git.anisa.su@samsung.com>
 <dbcfcbe8-5a4a-4b5d-b1f1-188e33eb2a4b@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbcfcbe8-5a4a-4b5d-b1f1-188e33eb2a4b@intel.com>

On Thu, May 28, 2026 at 02:34:49PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > Extend cxl_validate_extent() — the per-extent check of the add pipeline
> > to check partition membership.
> > 
> > Resolves an extent's DPA to its containing DC partition. Then based on
> > if the partition is shareable:
> > 
> >   - Shareable: tag must be non-null and shared_extn_seq must be non-zero
> >     — multiple hosts reading the same allocation rely on the device-
> >     stamped 1..n sequence to assemble extents in agreed order.
> >   - Non-sharable: shared_extn_seq must be zero — sequencing is
> >     meaningless when only one host consumes the allocation; tag is
> >     optional (null UUID permitted).
> > 
> > Any cross-mix is a device firmware bug; reject the extent.
> > 
> > Based on patches by John Groves.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: John Groves <John@Groves.net>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > ---
> > Changes:
> > [anisa: split out as a separate validation step]
> > ---
> >  drivers/cxl/core/core.h   |  4 ++
> >  drivers/cxl/core/extent.c | 78 +++++++++++++++++++++++++++++++++++++--
> >  2 files changed, 79 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 1bae80dbf991..30b6b05b155b 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -179,6 +179,10 @@ int cxl_pci_get_bandwidth(struct pci_dev *pdev, struct access_coordinate *c);
> >  int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
> >  					struct access_coordinate *c);
> >  void memdev_release_extent(struct cxl_memdev_state *mds, struct range *range);
> > +const struct cxl_dpa_partition *
> > +cxl_extent_dc_partition(struct cxl_memdev_state *mds,
> > +			struct cxl_extent *extent,
> > +			struct range *ext_range);
> >  
> >  static inline struct device *port_to_host(struct cxl_port *port)
> >  {
> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index 94128d06f4ed..b01507022cff 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> > @@ -63,11 +63,55 @@ alloc_tag_group(struct cxl_dax_region *cxlr_dax, uuid_t *uuid)
> >  	return no_free_ptr(group);
> >  }
> >  
> > +/*
> > + * Find the DC (Dynamic Capacity) partition that fully contains @ext_range,
> > + * or NULL if the extent falls outside every DC partition on this memdev.
> > + * The returned pointer is owned by mds->cxlds.part[] and lives for the
> > + * lifetime of the memdev.
> > + */
> > +const struct cxl_dpa_partition *
> > +cxl_extent_dc_partition(struct cxl_memdev_state *mds,
> > +			struct cxl_extent *extent,
> > +			struct range *ext_range)
> 
> This can be static, given it's only called in extent.c
> 
Fixed. Later called in mbox.c so declared non-static in that commit.

> > +{
> > +	struct cxl_dev_state *cxlds = &mds->cxlds;
> > +	struct device *dev = mds->cxlds.dev;
> > +
> > +	for (int i = 0; i < cxlds->nr_partitions; i++) {
> > +		struct cxl_dpa_partition *part = &cxlds->part[i];
> > +		struct range partition_range = {
> > +			.start = part->res.start,
> > +			.end = part->res.end,
> > +		};
> > +
> > +		if (part->mode != CXL_PARTMODE_DYNAMIC_RAM_A)
> > +			continue;
> > +
> > +		if (range_contains(&partition_range, ext_range)) {
> > +			dev_dbg(dev, "DC extent DPA %pra (DCR:%pra)(%pU)\n",
> > +				ext_range, &partition_range, extent->uuid);
> > +			return part;
> > +		}
> > +	}
> > +
> > +	dev_err_ratelimited(dev,
> > +			    "DC extent DPA %pra (%pU) is not in a valid DC partition\n",
> > +			    ext_range, extent->uuid);
> > +	return NULL;
> > +}
> > +
> >  /*
> >   * Stage 1 of the add pipeline: pure, no allocation.  Resolve the extent
> > - * to its region/endpoint decoder and ext_range, and verify the range
> > - * fits in the resolved endpoint decoder's DPA resource.  Further
> > - * per-extent invariants layer into this function in subsequent commits.
> > + * to its region/endpoint decoder and ext_range, and enforce every
> > + * per-extent invariant the device must satisfy:
> > + *
> > + *   - DPA falls inside a Dynamic Capacity partition (cxl_extent_dc_partition).
> > + *   - CDAT-sharability rules:
> > + *       sharable:     tag must be non-null AND shared_extn_seq != 0
> > + *       non-sharable: shared_extn_seq must be 0  (tag is optional)
> > + *     Any cross-mixing is a device firmware bug.
> > + *   - DPA resolves to an endpoint decoder attached to a region.
> > + *   - The extent's range is fully contained in that ED's DPA resource.
> >   *
> >   * Caller must hold cxl_rwsem.region for read (cxl_dpa_to_region()).
> >   * On success, @out_cxled / @out_cxlr_dax / @out_ext_range carry the
> > @@ -81,6 +125,10 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
> >  {
> >  	u64 start_dpa = le64_to_cpu(extent->start_dpa);
> >  	struct cxl_memdev *cxlmd = mds->cxlds.cxlmd;
> > +	struct device *dev = mds->cxlds.dev;
> > +	uuid_t *uuid = (uuid_t *)extent->uuid;
> 
> Consider using import_uuid() instead of direct cast.
> 
Fixed
> > +	u16 seq = le16_to_cpu(extent->shared_extn_seq);
> > +	const struct cxl_dpa_partition *part;
> >  	struct cxl_endpoint_decoder *cxled;
> >  	struct cxl_region *cxlr;
> >  	struct range ext_range = (struct range) {
> > @@ -89,6 +137,30 @@ static int cxl_validate_extent(struct cxl_memdev_state *mds,
> >  	};
> >  	struct range ed_range;
> >  
> > +	part = cxl_extent_dc_partition(mds, extent, &ext_range);
> > +	if (!part)
> > +		return -ENXIO;
> > +
> > +	if (part->perf.shareable) {
> > +		if (uuid_is_null(uuid)) {
> > +			dev_err_ratelimited(dev,
> > +				"DC extent DPA %pra: sharable-partition extent has null tag (firmware bug)\n",
> > +				&ext_range);
> > +			return -ENXIO;
> > +		}
> > +		if (seq == 0) {
> 
> I don't think this complies with the spec language. In r4.0 Table 8-230: "For extents describing shareable regions this field shall be within the range of 0 to n-1 where n is the number of extents, with each value appearing only once." So seq == 0 is an acceptable value.
> 
> Also, looking at cxl_add_pending() @ line ~1396, does shared seq number '0' holds special meanings? Maybe that needs to change? Also suggest adding comments to point out what's happening there if '0' is special. 
> 

Fixed to enforce 0...n-1 for shared seq num instead of 1...n.
0 no longer used as sentinel val for unshared extents. 

'Enforce tag-group semantics', which checks seq num have no
duplicates/gaps, is also fixed

> DJ
> 
Thanks,
Anisa
> 
> > +			dev_err_ratelimited(dev,
> > +				"DC extent DPA %pra (%pU): sharable-partition extent missing shared_extn_seq (firmware bug)\n",
> > +				&ext_range, uuid);
> > +			return -ENXIO;
> > +		}
> > +	} else if (seq != 0) {
> > +		dev_err_ratelimited(dev,
> > +			"DC extent DPA %pra (%pU): non-sharable partition but shared_extn_seq=%u (firmware bug)\n",
> > +			&ext_range, uuid, seq);
> > +		return -ENXIO;
> > +	}
> > +
> >  	cxlr = cxl_dpa_to_region(cxlmd, start_dpa, &cxled);
> >  	if (!cxlr)
> >  		return -ENXIO;
> 
