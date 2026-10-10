Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7449630BF70
	for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 22:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791672330; cv=none; b=qGa3+YRRwpzaiY7j753Cn6ZGf6dYr7FkUPoUs1+2VuGKvqqSTQCAIf96MJOHx4QIaDZYLQLMx8Hngq5HH3PA7crcdI03OR6UKykAF/3sKWTI0gc7b/JSq/qkZ9Rtjhov75SflgA/FNKgQa1ZhqBwvSW/JApJLkhbq3O7w/H8LPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791672330; c=relaxed/simple;
	bh=wTgGw8DHW6xFD4B4hl4ywDHhFyN1oJ4qHHPGEJTEyaE=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IqST6zg/ZjbbkBVURwH1nTWXDVZeXX9IXgBNgEhfpDosuNT8W+Q0TlT2bg0VGA/gmKfZN2ZVQiBmsPtEh+ASOF12dRrSZWjhFT8gUAmeMYbQuhdg2xPHAdML7Q7cKKfBJF6zweHZ16oLRZ5rIS51sDzoRcl0IjPsLC8OxeD+ReU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1sKKcTl; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1sKKcTl"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab60ff4273so705776a91.0
        for <linux-cxl@vger.kernel.org>; Sat, 10 Oct 2026 15:45:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791672329; x=1792277129; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xivJcQZ1ooou86Bqdwfy9/e7A6VmVxGxUj1fMYYNf5s=;
        b=k1sKKcTlkoqX3B4eSJovq1PNLziXovSK1Jpm5z4fHRUi79bSGfuy+bJEIjdDMZCP0l
         ZGKJHlzqujVNHkR5HffjrSUc7tmHniL15I3muz5EjTSGWKiE+QT68bBQjnzZewla8K2L
         xwXg6v6lcocBMWfce8I7j9MDQ2h/VE0gAAf/9ojJz6ul4/95ehGlhdNvAEOpLffvV3S6
         KQ4mw1uFMQ4Y+n++07wEz4ZveZ0Wdi5Zg2VmU3iyez+43Rh7kBYXY+sja+1zo4e6/3Z5
         HxT2DYXEUufOMje+w4fnwXAXTtoELa0wAtL2inFiCluyxNre4iI/lgOO/wOHYHu7Xrqd
         bLdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791672329; x=1792277129;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xivJcQZ1ooou86Bqdwfy9/e7A6VmVxGxUj1fMYYNf5s=;
        b=Z+n2Nyru0mn2W3x9Yof1YAlfRJ+JQpMTya27J14nUep0szujrPLJkgJlgy1Wr/vY+L
         RNxLdZXWMPGPIlzKPKhVpZLmCciviOw3qqGSgVZLpcFkdVGzSYBBH6gWRpym1A3+B3A5
         rmKtrOcBpmLKt345L/iH2SNHr5yLJjbbvMvhK1imnRYgq2abmbdIHnfcYa2Pg8jxttsj
         9fmAiqZQDCs8zRLiohNdK2Lf4QHr9AIns+Tb8s9tPGtk+DAJEefvEZtTl8yhQn479vTC
         U9hxpSmzxiziI3lLYa8BZNFzxieZQ7yKv4e9PqaS62hatZCNRS1NAl2MNETvs+YYje9I
         XTHg==
X-Forwarded-Encrypted: i=1; AKwUvBwdZbTe+Xfuhjbda7wnsMNrKglp6BRzmbmLe9GX9BrC6J24Z2wGgRyQ5F26XoWZSI8DRs3ZDUDXQ7E=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEvpdce77qUmYN7lkXXoGN1hE8o9xf+19j5PcMhEGW0GWRJj9e
	KgM2hRdjwxLAtPsy8neZNWE2TteV5xm/GtaDP7X1fQ+O3B2+z3rnaoXh
X-Gm-Gg: AYBFou35wgnDe4JZIjHOF0Px6gpCkIW4KXmAdHokEGfxjIQKLyET53PGz0k9/xzA2Qf
	c0c5HI3ROImwCQ8oWPA6q/iNI7xEm7KJrNctAB92kYXQHn8Z3v6wOUnvEXDV0UcCmWyCEsHfc6D
	zgo5oR8NFrdstptRLaCnPCCLh94GT6qfqZsFkgYv2J6h5Nmxxu1ktOlOcr0z1NgtdjD2+ysLWYi
	2ToQtc2aZsxAiJKnUbqf0eSmWZi+P/W+/fhuo//UleatgWMy0v7b7SI53hG8zoA72wpPxs8b5Na
	9SCFXMBnnxn6BxwBBTh33kJGba8Ob1Jf0jm/ZIDBJZ7fHMylOS1x5TmdZThlL1ZDv2+J4TwpzNm
	F2SN5ipicJ17D6qCOMSlDe8bamyf+L5npcR/izj4VVk888uNMbq2PMrKrhit2ZbImGFvQh3tLfm
	DCjh14SEWMXI7Kdv/PuJFyQZjxYvgOBjxd39Fyjt0Ugxo7LQxVUPYG1LNtrmWX2UhRsc/aPVxO/
	qERyQW+x8XfsBhxYI+z49pmYg==
X-Received: by 2002:a17:90b:5486:b0:39e:6a7f:1dcd with SMTP id 98e67ed59e1d1-3ab3ab1d56cmr5351273a91.41.1791672328538;
        Sat, 10 Oct 2026 15:45:28 -0700 (PDT)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab39822051sm4431351a91.4.2026.10.10.15.45.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Oct 2026 15:45:28 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Sun, 11 Oct 2026 07:47:21 +0900
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev
Subject: Re: [PATCH v15 3/8] cxl/cdat: Gather DSMAS data for DCD partitions
Message-ID: <asrAecwfhRU7kMLm@cxlqual>
References: <20261007201828.952-1-anisa.su@samsung.com>
 <20261007201828.952-4-anisa.su@samsung.com>
 <sashiko-outbox-163342@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <sashiko-outbox-163342@kernel.org>

On Wed, Oct 07, 2026 at 08:33:12PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential issue(s) to consider:
> - [High] cxl: Ineffective DCD disablement leaves partially configured partitions exposed
> - [Medium] cxl: QoS class 0 incorrectly overwrites CXL_QOS_CLASS_INVALID
> - [Low] cxl: Lockless modification of DPA partition attributes exposes torn reads
> --
> 
> commit 6722908eab4fa5c8dd9820d34f1ec3beb729c8f0
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/cdat: Gather DSMAS data for DCD partitions
> 
> Additional DCD partition (AKA region) information is contained in the
> DSMAS CDAT tables, including performance, shareable and read-only
> attributes. Match DCD partitions with DSMAS tables and store the meta
> data.
> 
> > diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> > index 5c9f072625135..07aedff657d9e 100644
> > --- a/drivers/cxl/core/cdat.c
> > +++ b/drivers/cxl/core/cdat.c
> [ ... ]
> > @@ -219,6 +226,13 @@ static int cxl_port_perf_data_calculate(struct cxl_port *port,
> >  	xa_for_each(dsmas_xa, index, dent) {
> >  		int qos_class;
> >  
> > +		/* No DSLBIS for this DSMAS; nothing to hand the QTG _DSM */
> > +		if (!dent->cdat_coord[ACCESS_COORDINATE_CPU].read_bandwidth &&
> > +		    !dent->cdat_coord[ACCESS_COORDINATE_CPU].write_bandwidth &&
> > +		    !dent->cdat_coord[ACCESS_COORDINATE_CPU].read_latency &&
> > +		    !dent->cdat_coord[ACCESS_COORDINATE_CPU].write_latency)
> > +			continue;
> 
> [Severity: Medium]
> When this continue statement is taken, dent->qos_class remains 0 (from
> kzalloc_obj zero-initialization).
> 
> If at least one other entry succeeds, cxl_memdev_apply_dsmas() will be called
> with CXL_DSMAS_APPLY_FLAGS_PERF, which unconditionally calls update_perf_entry()
> and overwrites part->perf.qos_class (previously CXL_QOS_CLASS_INVALID) with 0.
> 
> Since 0 is a valid QoS class in CXL, does this falsely advertise a QoS class of
> 0 to userspace for partitions lacking DSLBIS performance coordinates?
> 
Fixed. dsams_entry.qos_class is initialized to CXL_QOS_CLASS_INVALID in
cdat_dsmas_handler().

> > +
> >  		cxl_coordinates_combine(dent->coord, dent->cdat_coord, ep_c);
> >  		dent->entries = 1;
> >  		rc = cxl_root->ops.qos_class(cxl_root,
> [ ... ]
> > @@ -255,35 +269,90 @@ static void update_perf_entry(struct device *dev, struct dsmas_entry *dent,
> >  		dent->coord[ACCESS_COORDINATE_CPU].write_latency);
> >  }
> >  
> > -static void cxl_memdev_set_qos_class(struct cxl_dev_state *cxlds,
> > -				     struct xarray *dsmas_xa)
> > +/*
> > + * A DCD shall describe its DC partition in a DSMAS entry (CXL r4.0 9.13.3).
> > + * Without one the partition's attributes are unknown, so disable DCD.
> > + */
> > +static void cxl_dcd_dsmas_missing(struct cxl_dev_state *cxlds, const char *why)
> > +{
> > +	struct cxl_memdev_state *mds;
> > +
> > +	if (cxlds->type != CXL_DEVTYPE_CLASSMEM)
> > +		return;
> > +
> > +	mds = to_cxl_memdev_state(cxlds);
> > +	if (!cxl_dcd_supported(mds) ||
> > +	    !cxl_part_size(cxlds, CXL_PARTMODE_DYNAMIC_RAM))
> > +		return;
> > +
> > +	dev_warn(cxlds->dev, "DC partition has no valid DSMAS entry (%s), disabling DCD\n",
> > +		 why);
> > +	cxl_disable_dcd(mds);
> 
> [Severity: High]
> Does clearing the mds->dcd_supported flag effectively disable the partition?
> 
> Since cxl_configure_dcd() and cxl_dpa_setup() have already executed during
> cxl_pci_probe(), the DCD partition is permanently added to cxlds->part and its
> DPA resource is registered.
> 
> Because mds->dcd_supported is never evaluated again during region creation or
> sysfs access, does the partition remain fully exposed and usable by userspace
> without valid DSMAS attributes?
> 
Nothing is exposed in sysfs by this series. The rest of the series that does
adds those capabilities will hide the memdev dynamic_ram group and refuse the
decoder mode if dcd is not supported.
> > +}
> > +
> > +enum cxl_dsmas_apply {
> > +	CXL_DSMAS_APPLY_FLAGS,		/* shareable etc.; no QTG data */
> > +	CXL_DSMAS_APPLY_FLAGS_PERF,	/* perf coordinates and qos_class */
> > +};
> > +
> > +/*
> > + * DSMAS flags such as shareable are properties of the CDAT entry and are
> > + * applied regardless; perf data is applied only if the QTG lookup produced
> > + * recommendations.
> > + */
> > +static void cxl_memdev_apply_dsmas(struct cxl_dev_state *cxlds,
> > +				   struct xarray *dsmas_xa,
> > +				   enum cxl_dsmas_apply attrs)
> >  {
> >  	struct device *dev = cxlds->dev;
> >  	struct dsmas_entry *dent;
> > +	bool dc_matched = false;
> >  	unsigned long index;
> >  
> >  	xa_for_each(dsmas_xa, index, dent) {
> >  		bool found = false;
> >  
> >  		for (int i = 0; i < cxlds->nr_partitions; i++) {
> > -			struct resource *res = &cxlds->part[i].res;
> > +			struct cxl_dpa_partition *part = &cxlds->part[i];
> [ ... ]
> > +			if (attrs == CXL_DSMAS_APPLY_FLAGS_PERF)
> > +				update_perf_entry(dev, dent, &part->perf);
> > +			if (part->mode == CXL_PARTMODE_DYNAMIC_RAM) {
> > +				part->shareable = dent->shareable;
> > +				part->read_only = dent->read_only;
> > +				dc_matched = true;
> > +			}
> 
> [Severity: Low]
> Are these partition attributes being modified locklessly?
> 
> The CXL memdev and its sysfs attributes are registered and visible during
> cxl_pci_probe(), while this CDAT parsing happens later in
> cxl_endpoint_port_probe().
> 
> If part->perf, part->shareable, and part->read_only are updated without holding
> the cxl_rwsem.dpa lock, can concurrent userspace sysfs readers observe
> intermediate, torn, or partially updated performance states?
> 
update_perf_entry() is the function that writes to part->perf and not
touched by this series.

shareable and read-only are bools, so stores are atomic.

> > +			break;
> >  		}
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20261007201828.952-1-anisa.su@samsung.com?part=3
