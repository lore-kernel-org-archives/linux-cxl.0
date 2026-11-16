Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794865886;
	b=yo6dld21KVPdvLD2fvI/CLBXpWoh+6rPPRI32sf122ph5lxZ6BpOMFTB1jtHqkJb/zQs
	 MqTV5zeP3WasS/091w2hYBginPBF0yf6MRHf8bQMYjW9kMBpd+mYdf4DMuNdFtiig+qqB
	 OlWg1Jd9Z0rZg2nb9BasztDo/7DEX1lNFfcc5VKYf08bQiIk1m7qSbH3V/SiR4Qjty1Yi
	 lww1ssKs08mkVK5KF7/DFSeMQbnwmAYdxz2sejQvVLL6n95MEgqR2qHPbXqXjmR6GXYGa
	 cZ6lAVfoYRohOer9duQzGDVSaiLQPO4yIBTrxZCjB9WWMJYpNaU1fex6lrWvGfnQBWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794865886;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:Date:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7lJe8kmJzwkxCohIpMmOFr2cyMS4kAHxtVA3UYeyvFI=;
	b=bAqooBKEPOpFR8fHPH/VVnKMkhBE9QctpcqgWIJfMzK80XqRjZR+n0jw9Eoq0CcAI9E6
	 FXOjAH36GxPvNyaQDe70U2iNiaQOGj7GHdtPltmEV0o1pfa/udSi6caFB/G/h24cB8za7
	 7gzB3zTsBBQV6i8hvDmPRjnQlErKq3mHh0G+COldt6HFFfbdi60rQvnIZ7b3jp+GUXokG
	 wVReDTsyojUEuyyNYqHB9R6XavozbAb8tror2IvzFPHRAGfkxSjHoVAkIAXap8tJ1xYqi
	 2cazeYwPeamnz/6veVmFaAOOFvC/W/nhXgw8gXUF/3U8sbJW60+hIhFgJ/6mm2kZgyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIlS45dx;
	arc=none smtp.remote-ip=74.125.82.174
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2EDD606A322
	for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 21:51:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2EDD606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GIlS45dx
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-37071c0f42aso5879091eec.0
        for <linux-cxl@vger.kernel.org>; Mon, 16 Nov 2026 13:51:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794865885; x=1795470685; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7lJe8kmJzwkxCohIpMmOFr2cyMS4kAHxtVA3UYeyvFI=;
        b=GIlS45dxM46zCqCVsKj3fogvCEax8ZdzJSu2aKWOEI5WtCXsl0Ol5GbL0HkL/zi3Jl
         FB+AeW1u0BPPuoEJBsBcwvUYJ9isOLJM8MbLHds9JajvMLMxTMrAfSSQnda46QlS92zc
         kdpS+6drU/to3s9Z6FX3uD+kidIcnss4DXs9oqlAhuM6s2ZmxPYAFPy+NP5IBtORg5pj
         wwc8XUjUJk/lriakHIIxJcUhS1ohPDq30AwRG8w+4fmn+cT3WaQH88LgXOKt9XjvYday
         3aXlnooMhWE2tdL5SKKH/n3VeiDjYjdr3iOk7prd88bc6NRZnopgA2HZRRGMrlAq5drd
         BTfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794865885; x=1795470685;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7lJe8kmJzwkxCohIpMmOFr2cyMS4kAHxtVA3UYeyvFI=;
        b=w5UfLRrHBmTk4OEZEnyL+Se+NFh6o5SaXLOrC+wFx1cCQGnGsxsb2el0bN7ez5p4IZ
         Rg03lnh5l2Efzh+iI+uB8JmJVpIQKagYEVlA0x00oq56PdC7F6PslCOOspsUBOxLnso1
         aXv4E4DsMz/ylMf5vYpW9KqIMIVfjEPD0na9BLOpqZ2p9+ll40ZzfNgP2y3ykHDgynaW
         b2K8mx4eCFSFYagLAfETMrqZ7zo4rDhVR5OKYvKqjVs82XWmr4c/8c3/liRufwzSD+0N
         h47cLON0S6ibbQbXAxamCoCCBKlxk/PTphA8aRmSpyimvsXeOJgg4BPuPgZO9bT99rJb
         OO/g==
X-Forwarded-Encrypted: i=1; AL+hErEErEvlgJWf62tzpgZu8jBYGGZYChSvJy1H/sddAHetBhw7wk3JDzxOv2663QXdw17gLObJt3vcdZI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LF9KVJQLqbRqp4AQnoZe590zk9LYnv+lwsuj0BGxSo+QhYJbM
	dTUdD2taRdkHup9HZPIGNBAwGeLRpLpBUc5gms0mrOOcruILCZfCa+rt
X-Gm-Gg: AZFdTZfQLbQpyB9m+hGZZolRNQhcFIaMwRUzz7g0tlcCXOAjWrpyegX5V+vMPUAMpqt
	YRzNVxN6XVEqrYF87itEd3Fa56LHN96C0f6SvieqIcNuIwKdhesPkj2pfqgT3zOZnh5a4E1kkcs
	M59gqqSv5rp9jvFAECnDcszjufGQVz8JY/Y0EVk21FjsJX/CaP0Btawyvexw3R7UJpwYI0dFvAV
	/woihenvLY5AeyUCHXeDYOX6YWIxJ1ycVUM5vk2GOm7KUCwSGneAaXwY/CGZCHWVUGivmKm3eoi
	EpTu+IQoRzAOSF320PeicpkvcvWoUbFPeqDuFYakNWKzXslIxLv2fnT3kEb4nolFktiIZaJNsLE
	2GiXWFDXlhT2x9FV947KdrSi4I8bk7/0ph7s4Ubw3qWIH+sCEd65BKlfxXID7/rth993xvl/aj2
	WIsOhZpJx7p6btrfe1BRoxkFgKlUb1swqVeDx7rmE68RWMILBP4lNMd8sKHiqO9VFpPwknc573r
	K6THs3tGI9SUBzFnJUM5M6H6SXoxFzf3Sg6hcxoPNxMJJUvIZlzzYBi5fcwydS6kncG+Z4ZZ5lJ
	QDuNO746+LsADVhPeBhg1yN66WE=
X-Received: by 2002:a05:7301:db83:b0:375:dc5b:43fa with SMTP id 5a478bee46e88-37966b522f1mr10637100eec.8.1794865884452;
        Mon, 16 Nov 2026 13:51:24 -0800 (PST)
Received: from cxlqual ([220.120.90.131])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379565d07b3sm35601313eec.22.2026.11.16.13.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 13:51:24 -0800 (PST)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 17 Nov 2026 06:53:41 +0900
To: Richard Cheng <icheng@nvidia.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <iweiny@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Fan Ni <nifan.cxl@gmail.com>, Li Ming <ming.li@zohomail.com>,
	Benjamin Cheatham <benjamin.cheatham@amd.com>,
	Gregory Price <gourry@gourry.net>
Subject: Re: [PATCH v1 06/14] cxl/extent: Handle DC Add Capacity events
Message-ID: <avt7ZWXUvp9JrO80@cxlqual>
References: <20261104230445.66625-1-anisa.su@samsung.com>
 <20261104230445.66625-7-anisa.su@samsung.com>
 <avUsyj-2n-qB-ZIu@MWDK4CY14F>
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Post: <mailto:linux-cxl@vger.kernel.org>
List-Help: <mailto:linux-cxl+help@vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-cxl+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <avUsyj-2n-qB-ZIu@MWDK4CY14F>

On Thu, Nov 12, 2026 at 11:34:45AM +0800, Richard Cheng wrote:
> On Thu, Nov 05, 2026 at 08:02:30AM +0800, Anisa Su wrote:
> > From: Ira Weiny <iweiny@kernel.org>
> > 
> > Replace the refuse-all stub for Add Capacity chains in
> > handle_dcd_chain_event() with the real add pipeline.
> > 
> > DC Event Records can be grouped together with the 'More' flag. The
> > previous commit completed the set up for holding onto extents in
> > the pending list until receiving the last event record of the group,
> > marked by 'More'=0.
> > 
> > This commit fills in the logic for processing the pending list and
> > adds basic validation for extents before they are added to the
> > device model as a child of the cxlr_dax region. More complete
> > checks for tags/sequence numbers/alignment are added in subsequent
> > commits.
> > 
> > For each tag that appears in the pending list:
> > 1. Extract all extents in the pending list with that tag to a
> > local list.
> > 
> > 2. The spec requires that shareable extents are ordered by
> > shared extent sequence number, which "instructs each host
> > on the relative order these extents must be placed in adjacent
> > virtual address space" (r4.0 Section 9.13.3 Figure 9-23
> > Shared Extent List Example). Otherwise, retain arrival order.
> > 
> > Thus the tag group is stable-sorted by shared_extn_seq; for non-sharable
> > extents every key is 0 and the stable sort preserves arrival
> > order.
> > 
> > Individual extents are checked for the following:
> > 1. The extent's DPA range fully resolves to an endpoint decoder.
> > 
> > 2. Doesn't overlap or repeat a previously accepted extent; the device
> > rejects a DPA range reported twice in an Add response (r4.0 Section
> > 8.2.10.9.9.3, Invalid Physical Address).
> > 
> > A tag group is one allocation, and for sharable capacity the host
> > must accept all of it or none (r4.0 Section 8.2.10.9.9.3, otherwise
> > the device returns Invalid Extent List). So an extent failing any of
> > these checks drops its whole group.
> > 
> > Upon passing these checks, extents are "onlined" together as a
> > tag group:
> > 
> > online_tag_group() registers a tagged group as a tag_groupX.Y device
> > under cxlr_dax->dev and a struct device per dc_extent under it.
> > 
> > A single "untagged" device is registered under cxlr_dax when
> > accepting the first untagged extent. All future untagged extents
> > will be registered under it.
> > 
> > A group that fails to online is dropped from the Add response.
> > 
> > Once the pending list has been fully processed, send the
> > DC_ADD_RESPONSE.
> > 
> > Region teardown invalidates the region's cached lines and releases all
> > extents under it.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <iweiny@kernel.org>
> > Co-developed-by: John Groves <John@Groves.net>
> > Signed-off-by: John Groves <John@Groves.net>
> > Co-developed-by: Anisa Su <anisa.su@samsung.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > Tested-by: Wonjae Lee <wj28.lee@samsung.com>
> > Tested-by: Junhee Park <jh9934.park@samsung.com>
> > Tested-by: Heesoo Kim <habil.kim@samsung.com>
> > ---
> >  drivers/cxl/core/Makefile     |   2 +-
> >  drivers/cxl/core/core.h       |  33 +++
> >  drivers/cxl/core/extent.c     | 513 ++++++++++++++++++++++++++++++++++
> >  drivers/cxl/core/mbox.c       | 248 +++++++++++++++-
> >  drivers/cxl/core/region.c     |   2 +-
> >  drivers/cxl/core/region_dax.c |  78 +++++-
> >  drivers/cxl/cxl.h             |  87 ++++++
> >  drivers/cxl/cxlmem.h          |   2 +
> >  drivers/dax/bus.c             |  13 +
> >  tools/testing/cxl/Kbuild      |   5 +-
> >  10 files changed, 974 insertions(+), 9 deletions(-)
> >  create mode 100644 drivers/cxl/core/extent.c
> > 
[snip]

> Hi Anisa, Ira,
> 
> I'm thinking CXL/DAX should have a clearer boundary split.
> 
> - CXL owns the device protocol, capacity acceptance, and recovery
>   when the mailbox outcome is uncertain
> - DAX owns local resource management, all-or-none group insertion,
>   and userspace claims.
> 
> 
> The interface should distinguish preparing resources from making them available.
> CXL can ask DAX to prepare a group before sending the Add Capacity Response,
> but those resources must remain unclaimable until CXL confirms acceptance
> with the device.
> 
> CXL then tells DAX to make the group available. On a definite refusal,
> CXl requests cleanup. On an uncertain result, CXL keeps the group unavailable
> and reconciles the device state.
> 
> The current ordering adds DAX resources before the Add Capacity Response
> completes. A successful dax_region_add_resources() only means that local
> insertion succeeded, it doesn't establish that the device accepted the
> allocation.
> 
> That coordiation belongs in CXL. DAX should provide the resource
> operations and enforce availability according to CXL's decision.
> 
> Best regards,
> Richard Cheng.
> 
Hi Richard,

Thanks for the review. I agree with your point, but it seems simpler to
re-order the steps in cxl_add_pending() than to add a new "prepare" step.
So in cxl_add_pending(): validate and build tag groups, then send the
Add Response. If rc == 0, online the groups to DAX.

If onlining to DAX fails, then send a Release DC Response. If Release DC
response fails, maybe we can retry X number of times.

Does that keep the boundary between CXL/DAX you have in mind?

Also is it harder to review the series separately? While I was
splitting the series, I thought it may be difficult to make a very clean
split. Since you mentioned about onlining to DAX, which is not in this series,
I assume you looked at the DAX half.

Thanks,
Anisa
> 
> >  static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
> >  				  struct cxl_event_dcd *event)
> >  {
> > @@ -1359,11 +1601,9 @@ static int handle_dcd_chain_event(struct cxl_memdev_state *mds,
> >  	chain->armed = false;
> >  	cancel_delayed_work(&chain->timeout_work);
> >  
> > -	/* Nothing is tracked yet: refuse every add, acknowledge every release */
> >  	if (event->event_type == DCD_ADD_CAPACITY)
> > -		rc = cxl_send_dc_response(mds, CXL_MBOX_OP_ADD_DC_RESPONSE,
> > -					  &chain->pending_extents, 0);
> > -	else
> > +		rc = cxl_add_pending(mds, &chain->pending_extents);
> > +	else	/* Nothing is tracked yet: acknowledge every release */
> >  		rc = cxl_send_dc_response(mds, CXL_MBOX_OP_RELEASE_DC,
> >  					  &chain->pending_extents,
> >  					  list_count_nodes(&chain->pending_extents));
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index fc9139ce358f..1b7031b2f159 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -224,7 +224,7 @@ static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
> >  	return xa_load(&port->regions, (unsigned long)cxlr);
> >  }
> >  
> > -static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> > +int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
> >  {
> >  	if (!cpu_cache_has_invalidate_memregion()) {
> >  		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> > diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> > index 47c9c52a3902..790176a8aadd 100644
> > --- a/drivers/cxl/core/region_dax.c
> > +++ b/drivers/cxl/core/region_dax.c
> > @@ -13,6 +13,8 @@ static void cxl_dax_region_release(struct device *dev)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = to_cxl_dax_region(dev);
> >  
> > +	xa_destroy(&cxlr_dax->dc_extents);
> > +	ida_destroy(&cxlr_dax->tag_group_ida);
> >  	kfree(cxlr_dax);
> >  }
> >  
> > @@ -27,6 +29,20 @@ const struct device_type cxl_dax_region_type = {
> >  	.groups = cxl_dax_region_attribute_groups,
> >  };
> >  
> > +static void cxl_dax_untagged_release(struct device *dev)
> > +{
> > +	struct cxl_dax_region *cxlr_dax =
> > +		container_of(dev, struct cxl_dax_region, untagged);
> > +
> > +	/* Drop the pin taken in cxl_dax_region_alloc(). */
> > +	put_device(&cxlr_dax->dev);
> > +}
> > +
> > +static const struct device_type cxl_dax_untagged_type = {
> > +	.name = "untagged",
> > +	.release = cxl_dax_untagged_release,
> > +};
> > +
> >  static bool is_cxl_dax_region(struct device *dev)
> >  {
> >  	return dev->type == &cxl_dax_region_type;
> > @@ -49,7 +65,8 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  	struct cxl_dax_region *cxlr_dax;
> >  	struct device *dev;
> >  
> > -	guard(rwsem_read)(&cxl_rwsem.region);
> > +	/* Publishes cxlr->cxlr_dax, which the event paths read under the read lock */
> > +	guard(rwsem_write)(&cxl_rwsem.region);
> >  	if (p->state != CXL_CONFIG_COMMIT)
> >  		return ERR_PTR(-ENXIO);
> >  
> > @@ -57,11 +74,14 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  	if (!cxlr_dax)
> >  		return ERR_PTR(-ENOMEM);
> >  
> > +	xa_init_flags(&cxlr_dax->dc_extents, XA_FLAGS_ALLOC1);
> > +	ida_init(&cxlr_dax->tag_group_ida);
> >  	cxlr_dax->hpa_range.start = p->res->start;
> >  	cxlr_dax->hpa_range.end = p->res->end;
> >  
> >  	dev = &cxlr_dax->dev;
> >  	cxlr_dax->cxlr = cxlr;
> > +	cxlr->cxlr_dax = cxlr_dax;
> >  	device_initialize(dev);
> >  	lockdep_set_class(&dev->mutex, &cxl_dax_region_key);
> >  	device_set_pm_not_required(dev);
> > @@ -69,16 +89,70 @@ static struct cxl_dax_region *cxl_dax_region_alloc(struct cxl_region *cxlr)
> >  	dev->bus = &cxl_bus_type;
> >  	dev->type = &cxl_dax_region_type;
> >  
> > +	/* Parent of the untagged extents, see cxl_dax_untagged_add() */
> > +	dev = &cxlr_dax->untagged;
> > +	device_initialize(dev);
> > +	device_set_pm_not_required(dev);
> > +	dev->parent = &cxlr_dax->dev;
> > +	dev->type = &cxl_dax_untagged_type;
> > +	get_device(&cxlr_dax->dev);
> > +
> >  	return cxlr_dax;
> >  }
> >  
> > +/*
> > + * Clearing cxlr->cxlr_dax here cannot race an Add or Release event.
> > + * Event paths find cxlr_dax through cxl_dpa_to_region() and use it with
> > + * cxl_rwsem.region held for read, from resolving an extent through
> > + * onlining its group.  Taking the write lock waits those paths out, and
> > + * later lookups find NULL, so the teardown that follows sees no events.
> > + */
> > +static void cxlr_dax_unpublish(struct cxl_dax_region *cxlr_dax)
> > +{
> > +	guard(rwsem_write)(&cxl_rwsem.region);
> > +	cxlr_dax->cxlr->cxlr_dax = NULL;
> > +}
> > +
> >  static void cxlr_dax_unregister(void *_cxlr_dax)
> >  {
> >  	struct cxl_dax_region *cxlr_dax = _cxlr_dax;
> >  
> > +	cxlr_dax_unpublish(cxlr_dax);
> > +	/* Unbind first: the driver's teardown empties untagged and the groups */
> > +	device_release_driver(&cxlr_dax->dev);
> > +	if (device_is_registered(&cxlr_dax->untagged))
> > +		device_del(&cxlr_dax->untagged);
> > +	put_device(&cxlr_dax->untagged);
> >  	device_unregister(&cxlr_dax->dev);
> >  }
> >  
> > +/*
> > + * The dax_region's driver may probe, and its extent scan run, before
> > + * devm_cxl_add_dax_region() returns, so the untagged device is registered
> > + * on first use instead.  Callers are serialized by the memdev's
> > + * dc_chain.lock; a DC region has a single memdev behind it.
> > + */
> > +int cxl_dax_untagged_add(struct cxl_dax_region *cxlr_dax)
> > +{
> > +	struct device *dev = &cxlr_dax->untagged;
> > +	int rc;
> > +
> > +	if (device_is_registered(dev))
> > +		return 0;
> > +
> > +	rc = dev_set_name(dev, "untagged");
> > +	if (rc)
> > +		return rc;
> > +	return device_add(dev);
> > +}
> > +
> > +DEFINE_FREE(unpublish_cxl_dax_region, struct cxl_dax_region *,
> > +	if (!IS_ERR_OR_NULL(_T)) {
> > +		cxlr_dax_unpublish(_T);
> > +		put_device(&_T->untagged);
> > +		put_device(&_T->dev);
> > +	})
> > +
> >  int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  {
> >  	struct device *dev;
> > @@ -90,7 +164,7 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  		return -EINVAL;
> >  	}
> >  
> > -	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) =
> > +	struct cxl_dax_region *cxlr_dax __free(unpublish_cxl_dax_region) =
> >  		cxl_dax_region_alloc(cxlr);
> >  	if (IS_ERR(cxlr_dax))
> >  		return PTR_ERR(cxlr_dax);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 64138e1768a1..f7d7749d704c 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -325,6 +325,42 @@ enum cxl_decoder_state {
> >  	CXL_DECODER_STATE_AUTO_STAGED,
> >  };
> >  
> > +struct cxl_dc_tag_group;
> > +
> > +/**
> > + * struct dc_extent - A single dynamic-capacity extent surfaced to the host.
> > + *
> > + * One per device-stamped extent.  Multiple dc_extents that share a tag
> > + * (see &struct cxl_dc_tag_group) form a single logical allocation, but
> > + * each dc_extent has its own HPA range.
> > + *
> > + * @dev: device representing this extent; child of its tag_groupX.Y
> > + *	device, or of the dax_region's untagged device for a null tag.
> > + * @group: tag group that this extent belongs to; shared across siblings.
> > + * @cxled: endpoint decoder backing the DPA range.
> > + * @dpa_range: DPA range this extent covers within @cxled.
> > + * @hpa_range: HPA range that @dpa_range decodes to, relative to
> > + *	       cxlr_dax->hpa_range.start.
> > + * @uuid: tag uuid (matches @group->uuid).
> > + * @seq_num: 0..n-1 assembly-order index within the tag group.  For a
> > + *	     sharable partition the order follows the shared_extn_seq given
> > + *	     by the device; for a non-sharable partition, where
> > + *	     shared_extn_seq is reserved, the order is the order in which
> > + *	     extents arrive.  Either way @seq_num forms a dense range 0..n-1.
> > + * @rcu: rcu_head for the kfree_rcu() deferred free in dc_extent_release(),
> > + *	 so RCU readers walking the tag group's extents finish safely.
> > + */
> > +struct dc_extent {
> > +	struct device dev;
> > +	struct cxl_dc_tag_group *group;
> > +	struct cxl_endpoint_decoder *cxled;
> > +	struct range dpa_range;
> > +	struct range hpa_range;
> > +	uuid_t uuid;
> > +	u16 seq_num;
> > +	struct rcu_head rcu;
> > +};
> > +
> >  /**
> >   * struct cxl_endpoint_decoder - Endpoint  / SPA to DPA decoder
> >   * @cxld: base cxl_decoder_object
> > @@ -490,6 +526,7 @@ struct cxl_region_params {
> >   * @type: Endpoint decoder target type
> >   * @cxl_nvb: nvdimm bridge for coordinating @cxlr_pmem setup / shutdown
> >   * @cxlr_pmem: (for pmem regions) cached copy of the nvdimm bridge
> > + * @cxlr_dax: the region's cxl_dax_region while it is registered, else NULL
> >   * @flags: Region state flags
> >   * @shareable: (for DC regions) backing partitions must be shareable
> >   * @read_only: (for DC regions) backing partitions must be read-only
> > @@ -508,6 +545,7 @@ struct cxl_region {
> >  	enum cxl_decoder_type type;
> >  	struct cxl_nvdimm_bridge *cxl_nvb;
> >  	struct cxl_pmem_region *cxlr_pmem;
> > +	struct cxl_dax_region *cxlr_dax;
> >  	unsigned long flags;
> >  	bool shareable;
> >  	bool read_only;
> > @@ -570,8 +608,57 @@ struct cxl_dax_region {
> >  	struct device dev;
> >  	struct cxl_region *cxlr;
> >  	struct range hpa_range;
> > +	/*
> > +	 * dc_extents is keyed by an allocator-assigned u32 (see
> > +	 * online_tag_group()).  Tag groups have no first-class identity in
> > +	 * this xarray; siblings within a tag find each other via
> > +	 * dc_extent->group.
> > +	 */
> > +	struct xarray dc_extents;
> > +	/* ids for the tag_groupX.Y devices registered under this region */
> > +	struct ida tag_group_ida;
> > +	/* parent of the extentX.Y devices of untagged allocations */
> > +	struct device untagged;
> >  };
> >  
> > +/**
> > + * struct cxl_dc_tag_group - A tagged dynamic-capacity allocation.
> > + *
> > + * Container for the &struct dc_extent siblings that share a tag.  A
> > + * tagged group is a tag_groupX.Y device under the dax_region and the
> > + * parent of its extentX.Y devices; untagged extents, each a group of
> > + * one, sit under the region's untagged device instead.  The group
> > + * exists to keep tag-scoped invariants (atomic add, atomic release,
> > + * ordered carve by seq_num) in one place.
> > + *
> > + * @dev: device representing a tagged group; child of cxlr_dax->dev.
> > + *	Holds the group's memory: the last dc_extent release drops the
> > + *	final reference.  Never registered for an untagged group.
> > + * @cxlr_dax: back reference to parent region device.
> > + * @uuid: tag identifying this allocation; same across all member dc_extents.
> > + * @dc_extents: xarray of &struct dc_extent in this group, indexed by the
> > + *		dc_extent's @seq_num (0..n-1, dense).  See &struct dc_extent
> > + *		for how seq_num is sourced for sharable vs non-sharable
> > + *		allocations.
> > + * @nr_extents: live count of dc_extents in the group; the group is freed
> > + *		when the last dc_extent device is released.
> > + */
> > +struct cxl_dc_tag_group {
> > +	struct device dev;
> > +	struct cxl_dax_region *cxlr_dax;
> > +	uuid_t uuid;
> > +	struct xarray dc_extents;
> > +	unsigned int nr_extents;
> > +};
> > +
> > +bool is_dc_extent(struct device *dev);
> > +static inline struct dc_extent *to_dc_extent(struct device *dev)
> > +{
> > +	if (!is_dc_extent(dev))
> > +		return NULL;
> > +	return container_of(dev, struct dc_extent, dev);
> > +}
> > +
> >  /**
> >   * struct cxl_port - logical collection of upstream port devices and
> >   *		     downstream port devices to construct a CXL memory
> > diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> > index 52c936ec15a9..73f01efc0172 100644
> > --- a/drivers/cxl/cxlmem.h
> > +++ b/drivers/cxl/cxlmem.h
> > @@ -433,6 +433,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> >   * struct cxl_dc_event_chain - staged Dynamic Capacity event chain
> >   * @pending_extents: extents received so far; flushed when the chain
> >   *		     closes (More=0)
> > + * @group: tag group being assembled from an Add Capacity chain
> >   * @timeout_work: watchdog that fires if a chain is opened with
> >   *		  CXL_DCD_EVENT_MORE but the closing record never arrives
> >   * @lock: serialises updates to the chain state against the watchdog
> > @@ -454,6 +455,7 @@ static inline struct cxl_dev_state *mbox_to_cxlds(struct cxl_mailbox *cxl_mbox)
> >   */
> >  struct cxl_dc_event_chain {
> >  	struct list_head pending_extents;
> > +	struct cxl_dc_tag_group *group;
> >  	struct delayed_work timeout_work;
> >  	struct mutex lock;	/* chain state, against the watchdog */
> >  	bool armed;
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index d8cc1c012f46..7d28aedfd2f7 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -539,6 +539,8 @@ static int alloc_dev_dax_id(struct dev_dax *dev_dax)
> >  	return id;
> >  }
> >  
> > +static bool is_dev_dax(struct device *dev);
> > +
> >  static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
> >  		const char *buf, size_t len)
> >  {
> > @@ -555,6 +557,12 @@ static ssize_t delete_store(struct device *dev, struct device_attribute *attr,
> >  	if (!victim)
> >  		return -ENXIO;
> >  
> > +	/* Tag groups and the untagged device are children of the region too */
> > +	if (!is_dev_dax(victim)) {
> > +		put_device(victim);
> > +		return -EINVAL;
> > +	}
> > +
> >  	device_lock(dev);
> >  	device_lock(victim);
> >  	dev_dax = to_dev_dax(victim);
> > @@ -1443,6 +1451,11 @@ static const struct device_type dev_dax_type = {
> >  	.groups = dax_attribute_groups,
> >  };
> >  
> > +static bool is_dev_dax(struct device *dev)
> > +{
> > +	return dev->type == &dev_dax_type;
> > +}
> > +
> >  /* see "strong" declaration in tools/testing/nvdimm/dax-dev.c */
> >  __weak phys_addr_t dax_pgoff_to_phys(struct dev_dax *dev_dax, pgoff_t pgoff,
> >  			      unsigned long size)
> > diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> > index e49ce644b4b1..f1ab25872e76 100644
> > --- a/tools/testing/cxl/Kbuild
> > +++ b/tools/testing/cxl/Kbuild
> > @@ -67,7 +67,10 @@ cxl_core-y += $(CXL_CORE_SRC)/hdm.o
> >  cxl_core-y += $(CXL_CORE_SRC)/pmu.o
> >  cxl_core-y += $(CXL_CORE_SRC)/cdat.o
> >  cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
> > -cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o $(CXL_CORE_SRC)/region_pmem.o $(CXL_CORE_SRC)/region_dax.o
> > +cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o \
> > +				 $(CXL_CORE_SRC)/region_pmem.o \
> > +				 $(CXL_CORE_SRC)/region_dax.o \
> > +				 $(CXL_CORE_SRC)/extent.o
> >  cxl_core-$(CONFIG_CXL_MCE) += $(CXL_CORE_SRC)/mce.o
> >  cxl_core-$(CONFIG_CXL_FEATURES) += $(CXL_CORE_SRC)/features.o
> >  cxl_core-$(CONFIG_CXL_EDAC_MEM_FEATURES) += $(CXL_CORE_SRC)/edac.o
> > -- 
> > 2.43.0
> > 
