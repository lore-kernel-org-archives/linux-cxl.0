Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA4E7312807
	for <linux-cxl@vger.kernel.org>; Fri, 12 Jun 2026 05:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781243895; cv=none; b=rx+NC3ow8S4+B69x0aWlSMAhmgW6lg21FJ5qkRSs4DCHQ1ammQ/fTjU8aBjIjpwPojSCSWqq04R/a/MR4Y5kOF37ua6+7+HlLyy6qNi6zsezFfhcBpNo9she3KpYGddGV/a4gCqLOTHP8uUP1FVDS0aD2XSY31zJopVuy+xKW/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781243895; c=relaxed/simple;
	bh=2fXynrJ0y2VtFuh+yhOsjBs9aaoCu4OUI3rXHh9kyvg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X30ZYYKCLUK0ryjbUJs0zlgPsaUsZ77jQNZzycXuiAGqzJQ5XfPFlEVk4GeXtMOOb+FgJoIZqFo0aONA8g8zdXmn6tIWiCZmpCLG+JWPvVmjr1GckQwZr2NQY9kGt37PRJGZ4KFBfLYBEFeKb39j7Lr9U+dyPKavsOvUSlxm5wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UQGQ9ZeE; arc=none smtp.client-ip=74.125.82.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UQGQ9ZeE"
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-13807d2f898so676033c88.0
        for <linux-cxl@vger.kernel.org>; Thu, 11 Jun 2026 22:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781243893; x=1781848693; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fwbrydugeAdaiQhvmDZSq+wpz/V9WJz4F5NXtcyhmdI=;
        b=UQGQ9ZeE9Iv85iBVbgLYAERNxsZf6yCFWSJejq0gfF0E+fz5NLZ6oHPCbo8Ffr7oDT
         OxJmtvUuIdPk1pAJF3Wnom1Zl+AoIc/aQWg9XA9OF48T5gpRrGhjkxzJGL084mqUS/Mw
         Ajh2fHj/83oazsjP9l3kZ90r3NqB1Bbp/akXY7eAZ5/Uz1B6/6cws1ylTRrIzmztKCqp
         2Cf0iYb1q5x6I0NB+Uhm0vjybqPSzBCzhFk8LhNFbxCGQ7XugkF3JNmD1q1BWU20HFbh
         701i9ielMKWMOZLeUr9I1AUuukagMqBCL8q2Nwwe+heIYZ0RqJx3fAbQRKA8BuC7EF6v
         JnaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781243893; x=1781848693;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fwbrydugeAdaiQhvmDZSq+wpz/V9WJz4F5NXtcyhmdI=;
        b=Jbyg/oFSv0pFPsQmJJxnPBoQlq0oJWXOe+qBPpXFcLaa2JsGEmivn/3f++lZv+BK5n
         ntGQnnwyH+fjuBknjrr8GNZzvIM9ll5HXuZW2/R0Zi8zBto8Q8SUs697mmjiPzB6EDnv
         aNemcpnnl+pO33LcLyRJ2JAEyyI+Q5WhEgmX3d6NAquMgsDNMAKP0EVAgR6/10J1Fz9A
         NRMPKYd7wYBA8RnJc5m3YW2s047e5ENuqgWJl8f4dZEvupMk2GUVb1WBBPOa8PFDTrcB
         erMPpg/H/hnKFFDRxUUhXzTq78yt++UnIxU3Jw5T7XhbyS1/4dqKK7EDQ+1Pvg5///Vv
         5GuA==
X-Forwarded-Encrypted: i=1; AFNElJ+HwShSW+4gFVKKu4ioMfvJSAR1mQM6jnAJ2cusFbVxIVDpc4E8XWpRpPNqop4hU1bXmKHUlzd1vFQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHpm8Dp9eLNaPWFWhhYwa57q4DmiWUPyhqh+NYRvSFJVPMy/dV
	ga+I8w07UzASch4Q55qwPf6ntTKc28B4OeIL5+7xaVgM9AbUrIYOdrPf
X-Gm-Gg: Acq92OEa70fEur9eNnNKFSFq1E1D5OdII/GUp4f//lONn9bP50S3kF+cBVCYYE3n09K
	9S583CR4l70CdwbfnO30VcBhxUhuPD94CoVGl/l+cIjRgR1FCfqp868STFYm11FpMdZ7ximUcM/
	9/4I7WMlnpGmI4QjeBG/sXaYUPNXnH5ZTjS3N15LeIdwpl21o22ejBnL/mnYB8k3R91J5iREe2I
	uEko2QkstAgEUKFBmPFR00ZoEsYBb37GnWcpEO5YBDfBN9n/mu8LQ3dtgSex3meQLQBvT/ERcNh
	ZPos+QiLSDRH0InBKV8XLU8xo+1kRjV2ufp5yXsKiWtKi5MVsA61DINx2739pOUJus2/gcNGFlU
	yotFnelS3CTrDBn1ARE6bPGXhqfss9bU70iczF5xt1V1jDckZ19jWRsHJDBLfgQ184TXG/UD3Mz
	9e83NTKXpySGx2I9nVZqPoTumspDKmy9xK5wfo7JjohU7kwTNU5btMq/DAdz0dZycLGCpdU5NK3
	P5MyDY=
X-Received: by 2002:a05:7022:607:b0:132:5d42:55ba with SMTP id a92af1059eb24-1384bb00787mr539158c88.16.1781243892677;
        Thu, 11 Jun 2026 22:58:12 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1384b916b2bsm1150858c88.6.2026.06.11.22.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 22:58:11 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Thu, 11 Jun 2026 22:58:09 -0700
To: Dave Jiang <dave.jiang@intel.com>
Cc: Anisa Su <anisa.su887@gmail.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org, nvdimm@lists.linux.dev,
	Dan Williams <djbw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v10 20/31] cxl/region/extent: Expose dc_extent
 information in sysfs
Message-ID: <aiuf8QDN_MvUf_WI@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <52f5a9ba175424c0f0a181e32ed6c04f26993d96.1779528761.git.anisa.su@samsung.com>
 <e29c7d64-4ea1-4fe6-b47b-2141a832f5a8@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e29c7d64-4ea1-4fe6-b47b-2141a832f5a8@intel.com>

On Thu, May 28, 2026 at 03:54:34PM -0700, Dave Jiang wrote:
> 
> 
> On 5/23/26 2:43 AM, Anisa Su wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Extent information can be helpful to the user to coordinate memory
> > usage with the external orchestrator and FM.
> > 
> > Expose the details of each dc_extent by creating the following sysfs
> > entries.
> > 
> > 	/sys/bus/cxl/devices/dax_regionX/extentX.Y
> > 	/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> > 	/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> > 	/sys/bus/cxl/devices/dax_regionX/extentX.Y/uuid
> > 
> > Each dc_extent surfaces as its own extentX.Y device under the parent
> > dax_region.  offset and length describe that dc_extent's HPA range,
> > not an aggregate bounding box across the containing tagged
> > allocation — so when a tagged allocation has multiple
> > DPA-discontiguous extents, each is reported with its own offset and
> > length.  uuid is the tag identifying the containing allocation; it
> > is shared across dc_extents that belong to the same tagged
> > allocation and is hidden for untagged extents.
> > 
> > Based on an original patch by Navneet Singh.
> > 
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > Tested-by: Fan Ni <fan.ni@samsung.com>
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> Missing Anisa sign off
> 
added
> > ---
> >  Documentation/ABI/testing/sysfs-bus-cxl | 36 +++++++++++++++
> >  drivers/cxl/core/extent.c               | 58 +++++++++++++++++++++++++
> >  2 files changed, 94 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> > index 3080aef9ad67..38cf0a2894b9 100644
> > --- a/Documentation/ABI/testing/sysfs-bus-cxl
> > +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> > @@ -661,3 +661,39 @@ Description:
> >  		The count is persistent across power loss and wraps back to 0
> >  		upon overflow. If this file is not present, the device does not
> >  		have the necessary support for dirty tracking.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/offset
> > +Date:		May, 2025
> > +KernelVersion:	v6.16
> 
> Update date and kernel version for all
> 
updated
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > +		extent information to create DAX devices on specific extents.
> > +		This is done by creating and destroying DAX devices in specific
> > +		sequences and looking at the mappings created.  Extent offset
> > +		within the region.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/length
> > +Date:		May, 2025
> > +KernelVersion:	v6.16
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > +		extent information to create DAX devices on specific extents.
> > +		This is done by creating and destroying DAX devices in specific
> > +		sequences and looking at the mappings created.  Extent length
> > +		within the region.
> > +
> > +
> > +What:		/sys/bus/cxl/devices/dax_regionX/extentX.Y/uuid
> > +Date:		May, 2025
> > +KernelVersion:	v6.16
> > +Contact:	linux-cxl@vger.kernel.org
> > +Description:
> > +		(RO) [For Dynamic Capacity regions only] Users can use the
> > +		extent information to create DAX devices on specific extents.
> > +		This is done by creating and destroying DAX devices in specific
> > +		sequences and looking at the mappings created.  UUID of this
> > +		extent.
> > diff --git a/drivers/cxl/core/extent.c b/drivers/cxl/core/extent.c
> > index f66fa8c600c5..34babfe032d1 100644
> > --- a/drivers/cxl/core/extent.c
> > +++ b/drivers/cxl/core/extent.c
> > @@ -6,6 +6,63 @@
> >  
> >  #include "core.h"
> >  
> > +static ssize_t offset_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct dc_extent *dc_extent = to_dc_extent(dev);
> > +
> > +	return sysfs_emit(buf, "%#llx\n", dc_extent->hpa_range.start);
> > +}
> > +static DEVICE_ATTR_RO(offset);
> > +
> > +static ssize_t length_show(struct device *dev, struct device_attribute *attr,
> > +			   char *buf)
> > +{
> > +	struct dc_extent *dc_extent = to_dc_extent(dev);
> > +	u64 length = range_len(&dc_extent->hpa_range);
> > +
> > +	return sysfs_emit(buf, "%#llx\n", length);
> > +}
> > +static DEVICE_ATTR_RO(length);
> > +
> > +static ssize_t uuid_show(struct device *dev, struct device_attribute *attr,
> > +			 char *buf)
> > +{
> > +	struct dc_extent *dc_extent = to_dc_extent(dev);
> > +
> > +	return sysfs_emit(buf, "%pUb\n", &dc_extent->group->uuid);
> > +}
> > +static DEVICE_ATTR_RO(uuid);
> > +
> > +static struct attribute *dc_extent_attrs[] = {
> > +	&dev_attr_offset.attr,
> > +	&dev_attr_length.attr,
> > +	&dev_attr_uuid.attr,
> > +	NULL
> > +};
> > +
> > +static uuid_t empty_uuid = { 0 };
> > +
> > +static umode_t dc_extent_visible(struct kobject *kobj,
> > +				 struct attribute *a, int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct dc_extent *dc_extent = to_dc_extent(dev);
> > +
> > +	if (a == &dev_attr_uuid.attr &&
> > +	    uuid_equal(&dc_extent->group->uuid, &empty_uuid))'
> 
> uuid_is_null() can be used?
> 
oh yeah oops... replaced w/uuid_is_null()

> DJ
> 
Thanks,
Anisa
> > +		return 0;
> > +
> > +	return a->mode;
> > +}
> > +
> > +static const struct attribute_group dc_extent_attribute_group = {
> > +	.attrs = dc_extent_attrs,
> > +	.is_visible = dc_extent_visible,
> > +};
> > +
> > +__ATTRIBUTE_GROUPS(dc_extent_attribute);
> > +
> >  
> >  static void cxled_release_extent(struct cxl_endpoint_decoder *cxled,
> >  				 struct dc_extent *dc_extent)
> > @@ -93,6 +150,7 @@ static void dc_extent_release(struct device *dev)
> >  static const struct device_type dc_extent_type = {
> >  	.name = "extent",
> >  	.release = dc_extent_release,
> > +	.groups = dc_extent_attribute_groups,
> >  };
> >  
> >  bool is_dc_extent(struct device *dev)
> 
