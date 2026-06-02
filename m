Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 043B237CD42
	for <linux-cxl@vger.kernel.org>; Tue,  2 Jun 2026 09:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780392167; cv=none; b=V9S5xhXlX65tQA09P5GjvvD7VU92Qozv2wLY6p8OzjdJqObipAgk2Ri6RMlC+2JJfU9MAdxHgIZiGU9ZgF3GzkvSdts7TPlq6nAh4e5z6P7tQJ7ZFHvQLlUvSBojyIVg4OfXSuZ5M0VA8VRTmkh3+txIV3zRdVvdrAx+uvGRKME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780392167; c=relaxed/simple;
	bh=zhkn0KSZEVWeWhvHbj/4Et1cOQSlVH/x3rznqmgLZY4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hT6vTyxrsK8jm+vz1H6hXG3fQF/n3TwBhRLjSrmaKb6aq215FUVqJdiMmqW1kfTphWiy/ge9o93zqqnLNq4cV4LtgOfC/lyT+OwD+WsPzjAZeh6TyNQEe6x4iSaqrcZdriuJ8fdw8Gmoy3JrXrAp8yRQsFkHKrkt6OeBDHgaGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zo9ZdkQ9; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zo9ZdkQ9"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-304545f5206so15227445eec.0
        for <linux-cxl@vger.kernel.org>; Tue, 02 Jun 2026 02:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780392165; x=1780996965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rFYPuiHRo/YZ7CenRDvSmVN7fBDTmqFFowjgjCkcIhc=;
        b=Zo9ZdkQ9PyZumbPtznnX0VZwwJruiUAU5xuWLL2uZMgYl7bb3J9jDrymyBTws8sgGo
         iPFmrghznvTHkHwls9GbD3lxfhvDc86wvyr3209rhRsivNL7Z8lNTEt4dYgIjWJrlA+3
         g8h5waMmpL7PQ47yF9rVz7rRwEiHEfEFVCk/t+750Fq8pedaOT5Bs7ECW3rPoI5Osldo
         fgeISvudIWI85+gIAg6gi9LAZKfvtiFd4Vsh2ElSbd5dHJZ0oSq674ro2aZXsQ5Tmxz0
         Ty/EbFV91OU0WIXCmm8TIoYjZsau40Zfum1NU2iRGzQUfLdhBftHqUL1JQ6n7O0gfd7+
         lryg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780392165; x=1780996965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rFYPuiHRo/YZ7CenRDvSmVN7fBDTmqFFowjgjCkcIhc=;
        b=GSvOLDF0Mvh6m8e/0it1JMpvEJdFlg/hbFsvg2TreiJTQB9vX2ee12XyIieQmJ3ekD
         uIJvlLSB4kFLnH7pNDkvGQQwhDfrAxsI+D2G9kwQ0+3Hz+BmgWxtfJekVP3loltu99U7
         AYkHSNbNZ3IVK1B9X/Ktkkw55Nxu9pNqsgg1p7jN0qcr+S7WzFXGKox8Kitv2CANnweg
         PaQmVbpmY617pZFcPkBi33hXdotMbQsJkk8h2bT+ByDCRRmy22LiuSIzTS5RJ2tZW5Ld
         u5OcUN2U0TOy8CW4DngeZx/iZGWgTOXNhFgTwLyZcKROVAokqt1jxvEwBEAP63eayzue
         zwIA==
X-Forwarded-Encrypted: i=1; AFNElJ9+tA1F6TMnW6m3B8IAm6txKlaudlFSSZo664v7TS6oNlc6SCq4Aav77xpl6C6s5bxLucyRNs2E7w0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92kds8l5qRcxzSoyJHk1ZXkx94Uue/yfUR/ZroZurV7bESd+N
	sIvh3PjfHntVbvbd90c8ZaqdNAZtYAZxkPFIyqvusYdnuDwyzuJhXCsm
X-Gm-Gg: Acq92OG1xX3Jk+Z3phT02OURrP8KdCVrYXN3gOkBtjDkkrCI/NOWAuB387yvpk+cbxq
	PBqSa+LdguEkEf2CZlicdTGXQPnLlxYIR8evIKIlNoXCW1lp1rlAhEtfw/XGCIBl+treU6mhQDS
	mISwtpUbzrcHqdXkkorV05PcdtESiiCOzRWfRqlKtLQ/jxhDeGaS1yxV9XplL95SbBTKKzFh+mh
	W8QtqbeHw/HzYICwjyDDX3ef9EqEpXSdZgVRml1F6Fa1gsfDVJdckf2w/n3LAgES3qNaCXYRMxI
	/GLMb52mUVDBu86qlX19bHmTdSIicea5ySogPYou5691wbibJLSiIG7qooEZknQeEveXupvkEA2
	x1Iqs600Ff5hVPlrUz7yyGQakCpR91B42GxgSrrjCny+Bd4JZ76Ei6WdTqL+/1C6AnHby2/pG0I
	g/Zu0o2zOMjpE74ndB2rrnxdwermjQWnU0sf5epwXETMebyJVJJNl1HVWFL7Y5Bf+E1f3dHQpZQ
	P0xcebEbAj4CFS4Rw==
X-Received: by 2002:a05:7300:7fa4:b0:304:8114:8d8f with SMTP id 5a478bee46e88-304fa67e79fmr7205323eec.31.1780392164908;
        Tue, 02 Jun 2026 02:22:44 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-304ed2eb24fsm10859599eec.7.2026.06.02.02.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 02:22:44 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 2 Jun 2026 02:22:42 -0700
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
Subject: Re: [PATCH v10 07/31] cxl/region: Add DC DAX region support
Message-ID: <ah6g4il0GtXKoclr@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <9f0e0b3deeb1825ad113d7aebe7056dcf2bbc5f9.1779528761.git.anisa.su@samsung.com>
 <f55e49bb-5032-448f-9550-69282b38b1c0@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f55e49bb-5032-448f-9550-69282b38b1c0@intel.com>

On Wed, May 27, 2026 at 05:16:44PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > DC DAX regions must allow memory to be added or removed dynamically.
> > In addition to the quantity of memory available the,
> > location of the memory within a DC partition is dynamic, based on the
> > extents offered by a device.  CXL DAX regions must accommodate the
> > dynamic movement of this memory in the management of DAX regions and devices.
> > 
> > Introduce the concept of a dynamic DAX region. Introduce
> > create_dynamic_ram_a_region() sysfs entry to create such regions.
> > Special case DC-capable regions to create a 0 sized seed DAX device
> > to maintain compatibility which requires a default DAX device to hold a
> > region reference.
> > 
> > Indicate 0 byte available capacity until such time that capacity is
> > added.
> > 
> > Dynamic regions complicate the range mapping of dax devices.  There is no
> > known use case for range mapping on dynamic regions.  Avoid the
> > complication by preventing range mapping of dax devices on dynamic
> > regions.
> > 
> > Interleaving is deferred for now.  Add checks.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Missing Anisa sign off
> 
Added!
> 
> > 
> > ---
> > Changes:
> > [anisa: rebase]
> > [anisa: change "sparse" naming conventions and to "dynamic"]
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 22 ++++++++---------
> >  drivers/cxl/core/core.h                 | 11 +++++++++
> >  drivers/cxl/core/port.c                 |  1 +
> >  drivers/cxl/core/region.c               | 33 +++++++++++++++++++++++--
> >  drivers/cxl/core/region_dax.c           |  6 +++++
> >  drivers/dax/bus.c                       | 10 ++++++++
> >  drivers/dax/bus.h                       |  1 +
> >  drivers/dax/cxl.c                       | 17 +++++++++++--
> >  8 files changed, 86 insertions(+), 15 deletions(-)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index c604c7ca6432..3080aef9ad67 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -434,20 +434,20 @@ Description:
> >  		interleave_granularity).
> >  
> >  
> > -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> > -Date:		May, 2022, January, 2023
> > -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> > +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dynamic_ram_a}_region
> > +Date:		May, 2022, January, 2023, May 2025
> > +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.16 (dynamic_ram_a)
> 
> update
> 
updated
> >  Contact:	linux-cxl@vger.kernel.org
> >  Description:
> >  		(RW) Write a string in the form 'regionZ' to start the process
> > -		of defining a new persistent, or volatile memory region
> > -		(interleave-set) within the decode range bounded by root decoder
> > -		'decoderX.Y'. The value written must match the current value
> > -		returned from reading this attribute. An atomic compare exchange
> > -		operation is done on write to assign the requested id to a
> > -		region and allocate the region-id for the next creation attempt.
> > -		EBUSY is returned if the region name written does not match the
> > -		current cached value.
> > +		of defining a new persistent, volatile, or dynamic RAM memory
> > +		region (interleave-set) within the decode range bounded by root
> > +		decoder 'decoderX.Y'. The value written must match the current
> > +		value returned from reading this attribute.  An atomic compare
> > +		exchange operation is done on write to assign the requested id
> > +		to a region and allocate the region-id for the next creation
> > +		attempt.  EBUSY is returned if the region name written does not
> > +		match the current cached value.
> >  
> >  
> >  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> > diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> > index 82ca3a476708..8881cc9323e0 100644
> > --- a/drivers/cxl/core/core.h
> > +++ b/drivers/cxl/core/core.h
> > @@ -6,6 +6,7 @@
> >  
> >  #include <cxl/mailbox.h>
> >  #include <linux/rwsem.h>
> > +#include <cxlmem.h>
> >  
> >  extern const struct device_type cxl_nvdimm_bridge_type;
> >  extern const struct device_type cxl_nvdimm_type;
> > @@ -18,6 +19,15 @@ enum cxl_detach_mode {
> >  	DETACH_INVALIDATE,
> >  };
> >  
> > +static inline struct cxl_memdev_state *
> > +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> > +{
> > +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> > +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> > +
> > +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> 
> return to_cxl_memdev_state(cxlmd->cxlds);
> 
done
> > +}
> > +
> >  #ifdef CONFIG_CXL_REGION
> >  
> >  struct cxl_region_context {
> > @@ -29,6 +39,7 @@ struct cxl_region_context {
> >  
> >  extern struct device_attribute dev_attr_create_pmem_region;
> >  extern struct device_attribute dev_attr_create_ram_region;
> > +extern struct device_attribute dev_attr_create_dynamic_ram_a_region;
> >  extern struct device_attribute dev_attr_delete_region;
> >  extern struct device_attribute dev_attr_region;
> >  extern const struct device_type cxl_pmem_region_type;
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index a7f71f36531f..2d33001dac26 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -337,6 +337,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
> >  	&dev_attr_qos_class.attr,
> >  	SET_CXL_REGION_ATTR(create_pmem_region)
> >  	SET_CXL_REGION_ATTR(create_ram_region)
> > +	SET_CXL_REGION_ATTR(create_dynamic_ram_a_region)
> 
> With this add, may need to add checks in cxl_root_decoder_visible() for dynamic_ram for create and also delete. 
> 
So for this check, since there's no CXL_DECODER_F_ bit defined for DCD, I considered
traversing through all endpoints and seeing if they have a DYNAMIC_RAM_A
partition, but that traversal already happens in the store_targetN() path,
which also includes the mode mismatch check.

Specifically, in cxl_region_attach:

if (cxlds->part[cxled->part].mode != cxlr->mode) {
	dev_dbg(&cxlr->dev, "%s region mode: %d mismatch\n",
		dev_name(&cxled->cxld.dev), cxlr->mode);
	return -EINVAL;
}

Is it sufficient here to prohibit creating a dynamic ram region if the root
decoder does not support ram?

if (a == CXL_REGION_ATTR(create_dynamic_ram_a_region) && !can_create_ram(cxlrd))
	return 0;

> >  	SET_CXL_REGION_ATTR(delete_region)
> >  	NULL,
> >  };
> > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > index edc267c6cf77..7561bf3d8af8 100644
> > --- a/drivers/cxl/core/region.c
> > +++ b/drivers/cxl/core/region.c
> > @@ -493,6 +493,11 @@ static int set_interleave_ways(struct cxl_region *cxlr, int val)
> >  	int save, rc;
> >  	u8 iw;
> >  
> > +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A && val != 1) {
> > +		dev_err(&cxlr->dev, "Interleaving and DCD not supported\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	rc = ways_to_eiw(val, &iw);
> >  	if (rc)
> >  		return rc;
> > @@ -2389,6 +2394,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> >  	if (sysfs_streq(buf, "\n"))
> >  		rc = detach_target(cxlr, pos);
> >  	else {
> > +		struct cxl_endpoint_decoder *cxled;
> >  		struct device *dev;
> >  
> >  		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> > @@ -2400,8 +2406,14 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
> >  			goto out;
> >  		}
> >  
> > -		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
> > -				   TASK_INTERRUPTIBLE);
> > +		cxled = to_cxl_endpoint_decoder(dev);
> > +		if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
> > +		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
> 
> cxled_to_mds() can return NULL with the earlier change suggested. Need to handle that
> 
Fixed
> DJ
> 
Thanks,
Anisa

Also, for potential future support for multiple DC partitions not to be awkward, I
think it would make sense to rename dynamic_ram_a to dynamic_ram_1. Any
objections?
> 
> > +			dev_dbg(dev, "DCD unsupported\n");
> > +			rc = -EINVAL;
> > +			goto out;
> > +		}
> > +		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
> >  out:
> >  		put_device(dev);
> >  	}
> > @@ -2750,6 +2762,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
> >  	switch (mode) {
> >  	case CXL_PARTMODE_RAM:
> >  	case CXL_PARTMODE_PMEM:
> > +	case CXL_PARTMODE_DYNAMIC_RAM_A:
> >  		break;
> >  	default:
> >  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> > @@ -2802,6 +2815,21 @@ static ssize_t create_ram_region_store(struct device *dev,
> >  }
> >  DEVICE_ATTR_RW(create_ram_region);
> >  
> > +static ssize_t create_dynamic_ram_a_region_show(struct device *dev,
> > +						struct device_attribute *attr,
> > +						char *buf)
> > +{
> > +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> > +}
> > +
> > +static ssize_t create_dynamic_ram_a_region_store(struct device *dev,
> > +						 struct device_attribute *attr,
> > +						 const char *buf, size_t len)
> > +{
> > +	return create_region_store(dev, buf, len, CXL_PARTMODE_DYNAMIC_RAM_A);
> > +}
> > +DEVICE_ATTR_RW(create_dynamic_ram_a_region);
> > +
> >  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
> >  			   char *buf)
> >  {
> > @@ -4081,6 +4109,7 @@ static int cxl_region_probe(struct device *dev)
> >  
> >  		return devm_cxl_add_pmem_region(cxlr);
> >  	case CXL_PARTMODE_RAM:
> > +	case CXL_PARTMODE_DYNAMIC_RAM_A:
> >  		rc = devm_cxl_region_edac_register(cxlr);
> >  		if (rc)
> >  			dev_dbg(&cxlr->dev, "CXL EDAC registration for region_id=%d failed\n",
> > diff --git a/drivers/cxl/core/region_dax.c b/drivers/cxl/core/region_dax.c
> > index de04f78f6ad8..d6bf69155827 100644
> > --- a/drivers/cxl/core/region_dax.c
> > +++ b/drivers/cxl/core/region_dax.c
> > @@ -84,6 +84,12 @@ int devm_cxl_add_dax_region(struct cxl_region *cxlr)
> >  	struct device *dev;
> >  	int rc;
> >  
> > +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
> > +	    cxlr->params.interleave_ways != 1) {
> > +		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
> > +		return -EINVAL;
> > +	}
> > +
> >  	struct cxl_dax_region *cxlr_dax __free(put_cxl_dax_region) =
> >  		cxl_dax_region_alloc(cxlr);
> >  	if (IS_ERR(cxlr_dax))
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 95aee2a037fb..b0c2162b5e37 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -181,6 +181,11 @@ static bool is_static(struct dax_region *dax_region)
> >  	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
> >  }
> >  
> > +static bool is_dynamic(struct dax_region *dax_region)
> > +{
> > +	return (dax_region->res.flags & IORESOURCE_DAX_DCD) != 0;
> > +}
> > +
> >  bool static_dev_dax(struct dev_dax *dev_dax)
> >  {
> >  	return is_static(dev_dax->region);
> > @@ -304,6 +309,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
> >  
> >  	lockdep_assert_held(&dax_region_rwsem);
> >  
> > +	if (is_dynamic(dax_region))
> > +		return 0;
> > +
> >  	for_each_dax_region_resource(dax_region, res)
> >  		size -= resource_size(res);
> >  	return size;
> > @@ -1389,6 +1397,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
> >  		return 0;
> >  	if (a == &dev_attr_mapping.attr && is_static(dax_region))
> >  		return 0;
> > +	if (a == &dev_attr_mapping.attr && is_dynamic(dax_region))
> > +		return 0;
> >  	if ((a == &dev_attr_align.attr ||
> >  	     a == &dev_attr_size.attr) && is_static(dax_region))
> >  		return 0444;
> > diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> > index 5909171a4428..6e739bfab932 100644
> > --- a/drivers/dax/bus.h
> > +++ b/drivers/dax/bus.h
> > @@ -15,6 +15,7 @@ struct dax_region;
> >  /* dax bus specific ioresource flags */
> >  #define IORESOURCE_DAX_STATIC BIT(0)
> >  #define IORESOURCE_DAX_KMEM BIT(1)
> > +#define IORESOURCE_DAX_DCD BIT(2)
> >  
> >  struct dax_region *alloc_dax_region(struct device *parent, int region_id,
> >  		struct range *range, int target_node, unsigned int align,
> > diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> > index 3ab39b77843d..f58fe992aa8d 100644
> > --- a/drivers/dax/cxl.c
> > +++ b/drivers/dax/cxl.c
> > @@ -13,19 +13,32 @@ static int cxl_dax_region_probe(struct device *dev)
> >  	struct cxl_region *cxlr = cxlr_dax->cxlr;
> >  	struct dax_region *dax_region;
> >  	struct dev_dax_data data;
> > +	resource_size_t dev_size;
> > +	unsigned long flags;
> >  
> >  	if (nid == NUMA_NO_NODE)
> >  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
> >  
> > +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
> > +		flags = IORESOURCE_DAX_DCD;
> > +	else
> > +		flags = IORESOURCE_DAX_KMEM;
> > +
> >  	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> > -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> > +				      PMD_SIZE, flags);
> >  	if (!dax_region)
> >  		return -ENOMEM;
> >  
> > +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
> > +		/* Add empty seed dax device */
> > +		dev_size = 0;
> > +	else
> > +		dev_size = range_len(&cxlr_dax->hpa_range);
> > +
> >  	data = (struct dev_dax_data) {
> >  		.dax_region = dax_region,
> >  		.id = -1,
> > -		.size = range_len(&cxlr_dax->hpa_range),
> > +		.size = dev_size,
> >  		.memmap_on_memory = true,
> >  	};
> >  
> 
