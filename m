Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3457F3655D9
	for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 09:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781600472; cv=none; b=VZqxB6eAqqoqBBiSmyC3oWTLavfujBe5g+4qW66b1OYxcs2cFfdQ1hH7WqtqMD/bDuGqlc9vBapzweAN0UPNp2hPDhjAUu3fI5uMFIcd+nBvY+RAqy++Qgw9dHZR0wJi5PNhyxOB6B9d1NdZAQY9lmgRsVVxlSv7VO6sObfWE/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781600472; c=relaxed/simple;
	bh=FRA1KwIFISMQKwypiH6P5YXZCV0SChYLUCjyR5PBoBc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iFFlqAfgE4im/ipJKmQOq9xKmNEU+z8fP4BCCNqw2D40YttDG5f35UMqBcm3tyxAirWWiRe9Bu3MHwlVX/mL/1M3S90sg66EinXr/XUHz76d/fdEYPqS1VhLT2bi/Zbl1NNHYk1scyKZMl1OQfrm/YauKaJJqdRFhq9SviLoraI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EBhRAc/D; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EBhRAc/D"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-30b932e4bf1so2584409eec.0
        for <linux-cxl@vger.kernel.org>; Tue, 16 Jun 2026 02:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781600470; x=1782205270; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gTHSWqIDphiu7OnXpJ8UEDiN1fONaHd50Es3Nexm0+E=;
        b=EBhRAc/DVW6VibjjWNmfMk1mMa23DB4iHgaLInYuW+OGzSmdjk8fMn6meSOFiUG7bD
         Y+A50aYEiTuyxxm6KJI/mfOqN5rtnMWQwYoX5mipYeYJ0B+HP3LwQllQdS6Udr4H5Jv3
         DzKgbNwOeLzwbrc/43mwYTFDZVmnE5jegVh+26MfcFAxc15CSiaDsY/J0HWqo+8ydH3r
         h1P8nHMGK9m6T2FLOdn/AHtDQcV+jQYxjLINZifNW+JUuRNPc/RCfdqgPYRfmZgdB4K+
         vCsmPRkpD5bHCZpScdUydjFEhQTVOzQI6dB0LGLv970Uhay13QtI1gzgUR90ig6zyjj0
         uD+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781600470; x=1782205270;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gTHSWqIDphiu7OnXpJ8UEDiN1fONaHd50Es3Nexm0+E=;
        b=M9xAaVGWfTvXZkQeOrvWl8Bm+l+irwYk7Dy6/R7u+JKh34eB7mX8VXryEKLJ1SxvLq
         JYyQXSWaDmImW6Ld4quDXIBP3ZwBu6b9IGTZfF1ARI4RAMU4r7dhywjZ+9EEtizlwYYv
         oH7y9zp/7YgJs2Zs5tSN4ALdyqoOkqixhR1GfyeAf/pyWMaAX9gJoataqjTB74YDlt25
         KVGhwemHbrSiCu6P3pxt4M2bsrhnFF7rNXMtvCrfy5Jq+wL+/F7oyV+gt6z0UwBejFa2
         RJs2g7dyUubnMVXbA6rO0enuewzNIR0f+V6Bdbt4vluwHAhlR+SY230WpO/tWTlgbowX
         vwfg==
X-Forwarded-Encrypted: i=1; AFNElJ/ckYejKUb+fKh6qEBSNDtFm8zKGliCNXeTeLq1kQ8losG7T3uoSBsASbztstUmHYWkfWMH7EBg7gY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgiFSmsMmGueGQbwfxeLEKGElVGcy7eEqMqzV5yuwV8NLkpco
	zOg578tvp78LJL/HOvzPlT/9PHkjC8acADNF0DoM1IJAjAlD5URogETj
X-Gm-Gg: Acq92OF3N0bYq9w/UmhpCVCxWAIbB+z8tmZFCDOIY9ecPJERoMajV+94IXaxJBhnNl8
	+ReNBHtcyvps+JYRDKo7/lnGQ5V8EP36dG7Qa7Ilx2MKI5pfMbLsSqlGbKKPstFCj2Nr4w0UoUp
	+kQu82ZNoMj0qE6ZzOeColfcDy87yIq5R8PuDLz44WxcyAw5ezoqZmdZG/C2QjnYGH1t4MWb9u0
	P+VlFIf6ST4IjilAxwuCHy7c/c2ybkU3cVCjHYO3ifLq2Fxe5f7E+pHuf3fXY1OrTInnVFcuApt
	3AZVoAqY/oDmryQysruc7S4bCQXn7qXADgg6Fe8xAFOWMcOXhoa/QpMv3dp4ujHgszmFKKFYi/P
	K9sMcnPqbyyQRocW6W1miVNLVfKYQ//KREkU+TKFn1pZRQBMApjcLWmyok5fD4DFPTl3liNUPuI
	8g13Pfd3MSF7C2DKQsgefC15K/P5zYcLSxZnPd/GIwRBNfGj6BjP9R6zy+NcrodQdvAFEL+PfXu
	RB+rPo=
X-Received: by 2002:a05:7300:640a:b0:2f1:496c:94bf with SMTP id 5a478bee46e88-3093ec3deb0mr7396433eec.16.1781600469774;
        Tue, 16 Jun 2026 02:01:09 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3081eb8d3c9sm18149333eec.26.2026.06.16.02.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 02:01:09 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Tue, 16 Jun 2026 02:01:08 -0700
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
Subject: Re: [PATCH v10 26/31] dax/bus: Tag-aware uuid claim and show on DC
 dax devices
Message-ID: <ajEQ1HiL0rZ0jrCP@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <89784b600e4284772c4136b462e948e016129cdf.1779528761.git.anisa.su@samsung.com>
 <7731c0e2-83e7-4502-a722-8d009532d1a9@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7731c0e2-83e7-4502-a722-8d009532d1a9@intel.com>

On Fri, May 29, 2026 at 10:53:23AM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > DC DAX regions are populated with dax_resource children that each carry a
> > backing tag uuid and a per-allocation sequence number (seq_num).  Add the
> > userspace claim semantics that resolve those tagged groups into DAX
> > devices.
> > 
> > A DC region's seed dax device is created at 0-size on probe; userspace
> > populates it by writing to its 'uuid' attribute:
> > 
> >   * A non-null UUID claims every dax_resource on this region whose tag
> >     matches, in seq_num order via uuid_claim_tagged().  The match set
> >     must form a dense 1..n sequence (no gap, no duplicate); the CXL
> >     side maintains this invariant for both sharable allocations (where
> >     the device stamps shared_extn_seq) and non-sharable allocations
> >     (where cxl_add_pending assigns arrival-order seq).  The resulting
> >     DAX device's size equals the sum of every member extent's size.
> > 
> >   * "0" claims a single untagged dax_resource via
> >     uuid_claim_untagged().  Untagged extents are independent
> >     allocations; collapsing several would aggregate unrelated capacity,
> >     so each uuid="0" write consumes exactly one untagged resource.
> > 
> >   * A write that matches no dax_resource returns -ENOENT; the device
> >     stays at size 0.
> > 
> > uuid_show() reads back the backing tag uuid (or the null UUID for an
> > untagged claim).  The attribute is read-only (0444) on non-DC dax
> > devices; writes to it on non-DC regions return -EOPNOTSUPP.
> > 
> > dev_dax_visible() exposes the uuid attribute only on DC dax devices.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > 
> > ---
> > Changes:
> > [anisa: split out from the original "Surface dc_extents" commit;
> >  userspace tag-claim semantics only.]
> > ---
> >  drivers/dax/bus.c | 260 +++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 256 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index c030eb103ad0..1dccb3e5cd0f 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -5,6 +5,7 @@
> >  #include <linux/mutex.h>
> >  #include <linux/list.h>
> >  #include <linux/slab.h>
> > +#include <linux/sort.h>
> >  #include <linux/dax.h>
> >  #include <linux/io.h>
> >  #include "dax-private.h"
> > @@ -1316,6 +1317,89 @@ static ssize_t dev_dax_resize(struct dax_region *dax_region,
> >  	return 0;
> >  }
> >  
> > +/* DC extents are all-or-nothing: an extent is either free or fully claimed. */
> > +static bool dax_resource_in_use(const struct dax_resource *dax_resource)
> > +{
> > +	return dax_resource->use_cnt > 0;
> > +}
> > +
> > +struct dax_uuid_match {
> > +	const struct dax_region *dax_region;
> > +	const uuid_t *uuid;
> > +};
> > +
> > +static int find_uuid_extent(struct device *dev, const void *data)
> > +{
> > +	const struct dax_uuid_match *match = data;
> > +	struct dax_resource *dax_resource;
> > +
> > +	if (!match->dax_region->dc_ops->is_extent(dev))
> > +		return 0;
> > +
> > +	dax_resource = dev_get_drvdata(dev);
> > +	if (!dax_resource || dax_resource_in_use(dax_resource))
> > +		return 0;
> > +	return uuid_equal(&dax_resource->uuid, match->uuid);
> > +}
> > +
> > +struct dax_tag_collect {
> > +	const struct dax_region *dax_region;
> > +	const uuid_t *uuid;
> > +	struct dax_resource **arr;
> > +	unsigned int count;
> > +	unsigned int cap;
> > +};
> > +
> > +static int collect_uuid_extent(struct device *dev, void *data)
> > +{
> > +	struct dax_tag_collect *c = data;
> > +	struct dax_resource *dax_resource;
> > +
> > +	if (!c->dax_region->dc_ops->is_extent(dev))
> > +		return 0;
> > +
> > +	dax_resource = dev_get_drvdata(dev);
> > +	if (!dax_resource || dax_resource_in_use(dax_resource))
> > +		return 0;
> > +	if (!uuid_equal(&dax_resource->uuid, c->uuid))
> > +		return 0;
> > +
> > +	if (c->count == c->cap)
> > +		return -ENOSPC;
> > +	c->arr[c->count++] = dax_resource;
> > +	return 0;
> > +}
> > +
> > +static int count_uuid_extent(struct device *dev, void *data)
> > +{
> > +	struct dax_tag_collect *c = data;
> > +	struct dax_resource *dax_resource;
> > +
> > +	if (!c->dax_region->dc_ops->is_extent(dev))
> > +		return 0;
> > +
> > +	dax_resource = dev_get_drvdata(dev);
> > +	if (!dax_resource || dax_resource_in_use(dax_resource))
> > +		return 0;
> > +	if (!uuid_equal(&dax_resource->uuid, c->uuid))
> > +		return 0;
> > +
> > +	c->count++;
> > +	return 0;
> > +}
> > +
> > +static int dax_resource_seq_cmp(const void *a, const void *b)
> > +{
> > +	const struct dax_resource * const *pa = a;
> > +	const struct dax_resource * const *pb = b;
> > +
> > +	if ((*pa)->seq_num < (*pb)->seq_num)
> > +		return -1;
> > +	if ((*pa)->seq_num > (*pb)->seq_num)
> > +		return 1;
> > +	return 0;
> > +}
> > +
> >  static ssize_t size_store(struct device *dev, struct device_attribute *attr,
> >  		const char *buf, size_t len)
> >  {
> > @@ -1548,13 +1632,177 @@ static DEVICE_ATTR_RO(numa_node);
> >  static ssize_t uuid_show(struct device *dev,
> >  		struct device_attribute *attr, char *buf)
> >  {
> > -	return sysfs_emit(buf, "%d\n", 0);
> > +	struct dev_dax *dev_dax = to_dev_dax(dev);
> > +	int rc;
> > +
> > +	rc = down_read_interruptible(&dax_dev_rwsem);
> 
> Since we are here, may as well convert these to ACQUIRE() and be rid of the gotos
> 
> ACQUIRE(rwsem_read_intr, rwsem)(&dax_dev_rwsem);
> if ((rc = ACQUIRE_ERR(rwsem_read_intr, &rwsem)))
> 	...
> 
Fixed!

> 
> > +	if (rc)
> > +		return rc;
> > +
> > +	for (int i = 0; i < dev_dax->nr_range; i++) {
> > +		struct dax_resource *r = dev_dax->ranges[i].dax_resource;
> > +
> > +		if (r && !uuid_is_null(&r->uuid)) {
> > +			rc = sysfs_emit(buf, "%pUb\n", &r->uuid);
> > +			goto out;
> > +		}
> > +	}
> > +	rc = sysfs_emit(buf, "0\n");
> 
> As pointed out earlyer, should display null_uuid to be consistent.
> 
Yep, fix from prev commit propagated to current.

> > +out:
> > +	up_read(&dax_dev_rwsem);
> > +	return rc;
> > +}
> > +
> > +static ssize_t uuid_claim_untagged(struct dax_region *dax_region,
> > +				   struct dev_dax *dev_dax)
> > +{
> > +	struct dax_uuid_match match = {
> > +		.dax_region = dax_region,
> > +		.uuid = &uuid_null,
> > +	};
> > +	struct dax_resource *dax_resource;
> > +	resource_size_t to_alloc;
> > +	struct device *extent_dev;
> > +	ssize_t alloc;
> > +
> > +	extent_dev = device_find_child(dax_region->dev, &match,
> > +				       find_uuid_extent);
> > +	if (!extent_dev)
> > +		return -ENOENT;
> > +
> > +	dax_resource = dev_get_drvdata(extent_dev);
> > +	to_alloc = resource_size(dax_resource->res);
> > +	alloc = __dev_dax_resize(dax_resource->res, dev_dax, to_alloc,
> > +				 dax_resource);
> > +	put_device(extent_dev);
> > +	if (alloc < 0)
> > +		return alloc;
> > +	if (alloc == 0)
> > +		return -ENOENT;
> > +	dax_resource->use_cnt++;
> > +	return 0;
> > +}
> > +
> > +static ssize_t uuid_claim_tagged(struct dax_region *dax_region,
> > +				 struct dev_dax *dev_dax, const uuid_t *uuid)
> > +{
> > +	struct dax_tag_collect c = {
> > +		.dax_region = dax_region,
> > +		.uuid = uuid,
> > +	};
> > +	unsigned int i;
> > +	ssize_t rc;
> > +
> > +	/* Two-pass: count, then collect into a sized array. */
> > +	device_for_each_child(dax_region->dev, &c, count_uuid_extent);
> > +	if (!c.count)
> > +		return -ENOENT;
> > +
> > +	c.arr = kmalloc_array(c.count, sizeof(*c.arr), GFP_KERNEL);
> > +	if (!c.arr)
> > +		return -ENOMEM;
> > +	c.cap = c.count;
> > +	c.count = 0;
> > +
> > +	rc = device_for_each_child(dax_region->dev, &c, collect_uuid_extent);
> > +	if (rc)
> > +		goto out;
> > +
> > +	sort(c.arr, c.count, sizeof(*c.arr), dax_resource_seq_cmp, NULL);
> > +
> > +	/*
> > +	 * Tagged groups carry a dense 1..n @seq_num regardless of source
> > +	 * (sharable: device-stamped; non-sharable: host-assigned in
> > +	 * arrival order — see &struct dax_resource).  A gap or
> > +	 * out-of-range value here means an extent went missing on the
> > +	 * cxl side (e.g. a per-extent failure in cxl_add_pending) or a
> > +	 * cxl-side validation gap; in either case refuse the whole
> > +	 * group rather than carve a partial allocation.
> > +	 */
> > +	for (i = 0; i < c.count; i++) {
> > +		if (c.arr[i]->seq_num != i + 1) {
> > +			dev_WARN_ONCE(dax_region->dev, 1,
> > +				"tag %pUb seq invariant violated at slot %u (got %u)\n",
> > +				uuid, i, c.arr[i]->seq_num);
> > +			rc = -EINVAL;
> > +			goto out;
> > +		}
> > +	}
> > +
> > +	for (i = 0; i < c.count; i++) {
> > +		resource_size_t to_alloc = resource_size(c.arr[i]->res);
> > +		ssize_t alloc;
> > +
> > +		alloc = __dev_dax_resize(c.arr[i]->res, dev_dax, to_alloc,
> > +					 c.arr[i]);
> > +		if (alloc < 0) {
> > +			rc = alloc;
> > +			goto rollback;
> > +		}
> > +		if (alloc == 0) {
> > +			rc = -ENOSPC;
> > +			goto rollback;
> > +		}
> > +		c.arr[i]->use_cnt++;
> > +	}
> > +	rc = 0;
> > +	goto out;
> > +
> > +rollback:
> > +	/*
> > +	 * Partial failure: trim every range we added in this attempt.
> > +	 * trim_dev_dax_range pops the most-recently-appended range from
> > +	 * dev_dax->ranges[] and decrements its dax_resource->use_cnt, so
> > +	 * looping until we have undone @i additions restores both
> > +	 * dev_dax->ranges[] and the matched dax_resources' use_cnt.
> > +	 */
> > +	while (i-- > 0)
> > +		trim_dev_dax_range(dev_dax);
> > +out:
> > +	kfree(c.arr);
> > +	return rc;
> >  }
> >  
> >  static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
> >  			  const char *buf, size_t len)
> >  {
> > -	return -EOPNOTSUPP;
> > +	struct dev_dax *dev_dax = to_dev_dax(dev);
> > +	struct dax_region *dax_region = dev_dax->region;
> > +	uuid_t uuid;
> > +	ssize_t rc;
> > +
> > +	if (!is_dynamic(dax_region))
> > +		return -EOPNOTSUPP;
> > +
> > +	if (sysfs_streq(buf, "0"))
> > +		uuid_copy(&uuid, &uuid_null);
> > +	else {
> > +		rc = uuid_parse(buf, &uuid);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> > +	rc = down_write_killable(&dax_region_rwsem);
> > +	if (rc)
> > +		return rc;
> > +	if (!dax_region->dev->driver) {
> > +		rc = -ENXIO;
> > +		goto err_region;
> > +	}
> > +	rc = down_write_killable(&dax_dev_rwsem);
> 
> same comments about ACQUIRE()
> 
Same applied here

> > +	if (rc)
> > +		goto err_region;
> > +
> 
> Does it need to check if the device is already claimed before proceeding to claiming? What happens if the uuid is written twice to this sysfs file?
> 
yes; new check added:

/* A claimed device already has capacity; do not overwrite its uuid. */
if (dev_dax_size(dev_dax))
	return -EBUSY;

> DJ

Thanks,
Anisa
> > +	if (uuid_is_null(&uuid))
> > +		rc = uuid_claim_untagged(dax_region, dev_dax);
> > +	else
> > +		rc = uuid_claim_tagged(dax_region, dev_dax, &uuid);
> > +
> > +	up_write(&dax_dev_rwsem);
> > +err_region:
> > +	up_write(&dax_region_rwsem);
> > +
> > +	return rc < 0 ? rc : len;
> >  }
> >  static DEVICE_ATTR_RW(uuid);
> >  
> > @@ -1614,8 +1862,12 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
> >  		return 0;
> >  	if (a == &dev_attr_mapping.attr && is_dynamic(dax_region))
> >  		return 0;
> > -	if ((a == &dev_attr_align.attr ||
> > -	     a == &dev_attr_size.attr) && is_static(dax_region))
> > +	if (a == &dev_attr_uuid.attr && !is_dynamic(dax_region))
> > +		return 0444;
> > +	if (a == &dev_attr_align.attr &&
> > +	    (is_static(dax_region) || is_dynamic(dax_region)))
> > +		return 0444;
> > +	if (a == &dev_attr_size.attr && is_static(dax_region))
> >  		return 0444;
> >  	return a->mode;
> >  }
> 
