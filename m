Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A361C3306;
	Thu,  8 May 2025 18:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746728243; cv=none; b=HimLFAZltEZ2XGj/KFdmvYEPTk6Bf46QovcqkrOo+6klOLjwCyNqke5QbQUw8sHLEe4wpp1oKfAd0XnQowbsUmFzAS8YvQ8yRchtm7JPP79Uun5DUCqWbnUmOA6mSp80di5RQFJm5S787kcOUwaAQ0ocT2vzTTmgsSYbV8dyK7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746728243; c=relaxed/simple;
	bh=GLzTbzdc2UfmgqMZWDuFySy0KC/JndcIGPlAXHN9ses=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qtc3ZDjaE8ce+fWkiWSXTdcZLs76Rh7a6O8BzVU5/9nZylzAxd3dM+RGjfxb3KchrhabtCJzRlAjAOn37g4ALJJodKJoFZq/2FaI0hk8My2zGegfwG6HRbTpn2wqWhVGLw8KMW5RWPr5Xg8fnAi0oUWxw0JY45oR/zhXajUKrQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jvlzvq1V; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jvlzvq1V"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74019695377so1083003b3a.3;
        Thu, 08 May 2025 11:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746728240; x=1747333040; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pyik47GwrvFZBA/CYoKvkO68NE1obimave8JFxJydPQ=;
        b=jvlzvq1VzHQmghuPppzNqGBvLV70tEJOsYUHmMYtgNPELtawDE3Xt/ZZdR2zyzTQTS
         frIrQRcPTGUX6h7DUwewIKHBhxNVoRCMO61UCNXFvUyaFeMWLaxYHaVxWUWmg9DrNi+8
         zaqcwHZIn05HFpm3f16GjSulC5g4evO3ZPTd5JVB38tZ99+3ad8DtOD3Li4muVuCfOD3
         n+qq4KbUz+fYo+YW5aNcPHzVySgADcCq9QlMvtdjBtEWaTusP+Lo7RmbaI4vtxrB0zYa
         F+M99X85BcJ7tpvGHB5QTP2J4mQfpO9eaUVG6mj6HcLkfuPfqgwhLekNQc4J5Sds3Utu
         Hj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746728240; x=1747333040;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pyik47GwrvFZBA/CYoKvkO68NE1obimave8JFxJydPQ=;
        b=wQRDgz8vu2z+5qOFYKJebuXBO/8R9UjTK8r+GYj28EWJezTCqWeWHJrc6AHLO4JxT0
         dDtFAHkDUK7CZ0kvXsa6+oC2i3geF4STbxtqy5tFY7cAshwxXmeT4glnAeGj2UlB1oDQ
         hU1WCjviA6NMy3Yf5i5oUaz9LzVf+FY39bRoUi3sK+cqAlPzRAE9c0W45wf05xiT//at
         /S+wVblnffJ4m0h2WvxGuzmeGCKqTiM3l/i51MEAVlRAUZ9nFcIDEHvNsRIzHH1H+Yy6
         zsiZ+wVLF4aWsENdz4kqRjdDOXjG/0+K8CR6+JBM+Pyku8t6lmADeqR7RXK0cA6zVOC1
         Dvgw==
X-Forwarded-Encrypted: i=1; AJvYcCWmZtimWKeqqdFHFvcv9vehpW9/MHd1x8Tf271GpeQ0BXc+CSjlyJGAYzDcPN+bDb01VluYWLvRtJyWl52C@vger.kernel.org, AJvYcCXcQtWQ35TfiHJTR1XqexPKV6Tj4JYHQWhBZlqqTgKdyn0GYB1gDrdjnDclNYIaYzwokdbP7+efNC8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxueIDzo934/Jr5y5FlsYU+0LYoVxBZL8uPLr9pnwRBwWd1GYgV
	aBMK0Rjoo3+r5wgXiXQ6YSqAR2YL9TKi+09p5kjxcZUw7+VHbCrS
X-Gm-Gg: ASbGncuRMLX3h+QOe0g/w+xKUJkBcIJlJJOTZwMLFHBtTP2OqxYHNogH+dG+TKxCumH
	dRxijAz9Klz+FH4CkWvhOLBGXYkfS59t9iJtTB6VY6jqoJF6Qj3pPJGi3LslMidZbl3ixSm5cyw
	VzXlATu2hVi5AIci5JZMX4qLJL9fePNTbUPUD2Zr5jEt6f8k5WM4uOLShOBtz4l+BtieUNrbLJ2
	9DHVdZGTHOznjCXPQlX+cAej7LGo4Rd247PlC9kI9kA+B124GZSw0532sC4HhyamFBuWZwXqBXY
	pbhEBI8/cg6rQsxAveHStIu/Tj1gu30jXYgRTa6uKxn3
X-Google-Smtp-Source: AGHT+IFeCkyzWhnzRhnd0TPO6+N5Yx6Ke5gkFFIcNYroKPoSS1G9aIULOsEI5UTl9XBJqx4UwIs9ng==
X-Received: by 2002:a05:6a00:85a2:b0:742:3cc1:9485 with SMTP id d2e1a72fcca58-7423cc196c9mr61866b3a.12.1746728239656;
        Thu, 08 May 2025 11:17:19 -0700 (PDT)
Received: from smc-140338-bm01 ([149.97.161.244])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74237a8a3adsm302832b3a.158.2025.05.08.11.17.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 11:17:19 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Thu, 8 May 2025 18:17:16 +0000
To: Ira Weiny <ira.weiny@intel.com>
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 07/19] cxl/region: Add sparse DAX region support
Message-ID: <aBz1LFrrEGpo4Wdv@smc-140338-bm01>
References: <20250413-dcd-type2-upstream-v9-0-1d4911a0b365@intel.com>
 <20250413-dcd-type2-upstream-v9-7-1d4911a0b365@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413-dcd-type2-upstream-v9-7-1d4911a0b365@intel.com>

On Sun, Apr 13, 2025 at 05:52:15PM -0500, Ira Weiny wrote:
> Dynamic Capacity CXL regions must allow memory to be added or removed
> dynamically.  In addition to the quantity of memory available the
> location of the memory within a DC partition is dynamic based on the
> extents offered by a device.  CXL DAX regions must accommodate the
> sparseness of this memory in the management of DAX regions and devices.
> 
> Introduce the concept of a sparse DAX region.  Introduce
> create_dynamic_ram_a_region() sysfs entry to create such regions.
> Special case dynamic capable regions to create a 0 sized seed DAX device
> to maintain compatibility which requires a default DAX device to hold a
> region reference.
> 
> Indicate 0 byte available capacity until such time that capacity is
> added.
> 
> Sparse regions complicate the range mapping of dax devices.  There is no
> known use case for range mapping on sparse regions.  Avoid the
> complication by preventing range mapping of dax devices on sparse
> regions.
> 
> Interleaving is deferred for now.  Add checks.
> 
> Based on an original patch by Navneet Singh.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
LGTM, although I am not very familiar with dax. 

Reviewed-by: Fan Ni <fan.ni@samsung.com>
> 
> ---
> Changes:
> [iweiny: adjust to new partition mode and new singular dynamic ram
>          partition]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl | 22 +++++++++----------
>  drivers/cxl/core/core.h                 | 11 ++++++++++
>  drivers/cxl/core/port.c                 |  1 +
>  drivers/cxl/core/region.c               | 38 +++++++++++++++++++++++++++++++--
>  drivers/dax/bus.c                       | 10 +++++++++
>  drivers/dax/bus.h                       |  1 +
>  drivers/dax/cxl.c                       | 16 ++++++++++++--
>  7 files changed, 84 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index b2754e6047ca..2e26d95ac66f 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -434,20 +434,20 @@ Description:
>  		interleave_granularity).
>  
>  
> -What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram}_region
> -Date:		May, 2022, January, 2023
> -KernelVersion:	v6.0 (pmem), v6.3 (ram)
> +What:		/sys/bus/cxl/devices/decoderX.Y/create_{pmem,ram,dynamic_ram_a}_region
> +Date:		May, 2022, January, 2023, May 2025
> +KernelVersion:	v6.0 (pmem), v6.3 (ram), v6.16 (dynamic_ram_a)
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
>  		(RW) Write a string in the form 'regionZ' to start the process
> -		of defining a new persistent, or volatile memory region
> -		(interleave-set) within the decode range bounded by root decoder
> -		'decoderX.Y'. The value written must match the current value
> -		returned from reading this attribute. An atomic compare exchange
> -		operation is done on write to assign the requested id to a
> -		region and allocate the region-id for the next creation attempt.
> -		EBUSY is returned if the region name written does not match the
> -		current cached value.
> +		of defining a new persistent, volatile, or dynamic RAM memory
> +		region (interleave-set) within the decode range bounded by root
> +		decoder 'decoderX.Y'. The value written must match the current
> +		value returned from reading this attribute.  An atomic compare
> +		exchange operation is done on write to assign the requested id
> +		to a region and allocate the region-id for the next creation
> +		attempt.  EBUSY is returned if the region name written does not
> +		match the current cached value.
>  
>  
>  What:		/sys/bus/cxl/devices/decoderX.Y/delete_region
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 15699299dc11..08facbc2d270 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -5,6 +5,7 @@
>  #define __CXL_CORE_H__
>  
>  #include <cxl/mailbox.h>
> +#include <cxlmem.h>
>  
>  extern const struct device_type cxl_nvdimm_bridge_type;
>  extern const struct device_type cxl_nvdimm_type;
> @@ -12,9 +13,19 @@ extern const struct device_type cxl_pmu_type;
>  
>  extern struct attribute_group cxl_base_attribute_group;
>  
> +static inline struct cxl_memdev_state *
> +cxled_to_mds(struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +
> +	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> +}
> +
>  #ifdef CONFIG_CXL_REGION
>  extern struct device_attribute dev_attr_create_pmem_region;
>  extern struct device_attribute dev_attr_create_ram_region;
> +extern struct device_attribute dev_attr_create_dynamic_ram_a_region;
>  extern struct device_attribute dev_attr_delete_region;
>  extern struct device_attribute dev_attr_region;
>  extern const struct device_type cxl_pmem_region_type;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index e98605bd39b4..b2bd24437484 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -334,6 +334,7 @@ static struct attribute *cxl_decoder_root_attrs[] = {
>  	&dev_attr_qos_class.attr,
>  	SET_CXL_REGION_ATTR(create_pmem_region)
>  	SET_CXL_REGION_ATTR(create_ram_region)
> +	SET_CXL_REGION_ATTR(create_dynamic_ram_a_region)
>  	SET_CXL_REGION_ATTR(delete_region)
>  	NULL,
>  };
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c3f4dc244df7..716d33140ee8 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -480,6 +480,11 @@ static ssize_t interleave_ways_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A && val != 1) {
> +		dev_err(dev, "Interleaving and DCD not supported\n");
> +		return -EINVAL;
> +	}
> +
>  	rc = ways_to_eiw(val, &iw);
>  	if (rc)
>  		return rc;
> @@ -2198,6 +2203,7 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  	if (sysfs_streq(buf, "\n"))
>  		rc = detach_target(cxlr, pos);
>  	else {
> +		struct cxl_endpoint_decoder *cxled;
>  		struct device *dev;
>  
>  		dev = bus_find_device_by_name(&cxl_bus_type, NULL, buf);
> @@ -2209,8 +2215,13 @@ static size_t store_targetN(struct cxl_region *cxlr, const char *buf, int pos,
>  			goto out;
>  		}
>  
> -		rc = attach_target(cxlr, to_cxl_endpoint_decoder(dev), pos,
> -				   TASK_INTERRUPTIBLE);
> +		cxled = to_cxl_endpoint_decoder(dev);
> +		if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
> +		    !cxl_dcd_supported(cxled_to_mds(cxled))) {
> +			dev_dbg(dev, "DCD unsupported\n");
> +			return -EINVAL;
> +		}
> +		rc = attach_target(cxlr, cxled, pos, TASK_INTERRUPTIBLE);
>  out:
>  		put_device(dev);
>  	}
> @@ -2555,6 +2566,7 @@ static struct cxl_region *__create_region(struct cxl_root_decoder *cxlrd,
>  	switch (mode) {
>  	case CXL_PARTMODE_RAM:
>  	case CXL_PARTMODE_PMEM:
> +	case CXL_PARTMODE_DYNAMIC_RAM_A:
>  		break;
>  	default:
>  		dev_err(&cxlrd->cxlsd.cxld.dev, "unsupported mode %d\n", mode);
> @@ -2607,6 +2619,21 @@ static ssize_t create_ram_region_store(struct device *dev,
>  }
>  DEVICE_ATTR_RW(create_ram_region);
>  
> +static ssize_t create_dynamic_ram_a_region_show(struct device *dev,
> +						struct device_attribute *attr,
> +						char *buf)
> +{
> +	return __create_region_show(to_cxl_root_decoder(dev), buf);
> +}
> +
> +static ssize_t create_dynamic_ram_a_region_store(struct device *dev,
> +						 struct device_attribute *attr,
> +						 const char *buf, size_t len)
> +{
> +	return create_region_store(dev, buf, len, CXL_PARTMODE_DYNAMIC_RAM_A);
> +}
> +DEVICE_ATTR_RW(create_dynamic_ram_a_region);
> +
>  static ssize_t region_show(struct device *dev, struct device_attribute *attr,
>  			   char *buf)
>  {
> @@ -3173,6 +3200,12 @@ static int devm_cxl_add_dax_region(struct cxl_region *cxlr)
>  	struct device *dev;
>  	int rc;
>  
> +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A &&
> +	    cxlr->params.interleave_ways != 1) {
> +		dev_err(&cxlr->dev, "Interleaving DC not supported\n");
> +		return -EINVAL;
> +	}
> +
>  	cxlr_dax = cxl_dax_region_alloc(cxlr);
>  	if (IS_ERR(cxlr_dax))
>  		return PTR_ERR(cxlr_dax);
> @@ -3539,6 +3572,7 @@ static int cxl_region_probe(struct device *dev)
>  	case CXL_PARTMODE_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
>  	case CXL_PARTMODE_RAM:
> +	case CXL_PARTMODE_DYNAMIC_RAM_A:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'
> diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> index fde29e0ad68b..d8cb5195a227 100644
> --- a/drivers/dax/bus.c
> +++ b/drivers/dax/bus.c
> @@ -178,6 +178,11 @@ static bool is_static(struct dax_region *dax_region)
>  	return (dax_region->res.flags & IORESOURCE_DAX_STATIC) != 0;
>  }
>  
> +static bool is_sparse(struct dax_region *dax_region)
> +{
> +	return (dax_region->res.flags & IORESOURCE_DAX_SPARSE_CAP) != 0;
> +}
> +
>  bool static_dev_dax(struct dev_dax *dev_dax)
>  {
>  	return is_static(dev_dax->region);
> @@ -301,6 +306,9 @@ static unsigned long long dax_region_avail_size(struct dax_region *dax_region)
>  
>  	lockdep_assert_held(&dax_region_rwsem);
>  
> +	if (is_sparse(dax_region))
> +		return 0;
> +
>  	for_each_dax_region_resource(dax_region, res)
>  		size -= resource_size(res);
>  	return size;
> @@ -1373,6 +1381,8 @@ static umode_t dev_dax_visible(struct kobject *kobj, struct attribute *a, int n)
>  		return 0;
>  	if (a == &dev_attr_mapping.attr && is_static(dax_region))
>  		return 0;
> +	if (a == &dev_attr_mapping.attr && is_sparse(dax_region))
> +		return 0;
>  	if ((a == &dev_attr_align.attr ||
>  	     a == &dev_attr_size.attr) && is_static(dax_region))
>  		return 0444;
> diff --git a/drivers/dax/bus.h b/drivers/dax/bus.h
> index cbbf64443098..783bfeef42cc 100644
> --- a/drivers/dax/bus.h
> +++ b/drivers/dax/bus.h
> @@ -13,6 +13,7 @@ struct dax_region;
>  /* dax bus specific ioresource flags */
>  #define IORESOURCE_DAX_STATIC BIT(0)
>  #define IORESOURCE_DAX_KMEM BIT(1)
> +#define IORESOURCE_DAX_SPARSE_CAP BIT(2)
>  
>  struct dax_region *alloc_dax_region(struct device *parent, int region_id,
>  		struct range *range, int target_node, unsigned int align,
> diff --git a/drivers/dax/cxl.c b/drivers/dax/cxl.c
> index 13cd94d32ff7..88b051cea755 100644
> --- a/drivers/dax/cxl.c
> +++ b/drivers/dax/cxl.c
> @@ -13,19 +13,31 @@ static int cxl_dax_region_probe(struct device *dev)
>  	struct cxl_region *cxlr = cxlr_dax->cxlr;
>  	struct dax_region *dax_region;
>  	struct dev_dax_data data;
> +	resource_size_t dev_size;
> +	unsigned long flags;
>  
>  	if (nid == NUMA_NO_NODE)
>  		nid = memory_add_physaddr_to_nid(cxlr_dax->hpa_range.start);
>  
> +	flags = IORESOURCE_DAX_KMEM;
> +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
> +		flags |= IORESOURCE_DAX_SPARSE_CAP;
> +
>  	dax_region = alloc_dax_region(dev, cxlr->id, &cxlr_dax->hpa_range, nid,
> -				      PMD_SIZE, IORESOURCE_DAX_KMEM);
> +				      PMD_SIZE, flags);
>  	if (!dax_region)
>  		return -ENOMEM;
>  
> +	if (cxlr->mode == CXL_PARTMODE_DYNAMIC_RAM_A)
> +		/* Add empty seed dax device */
> +		dev_size = 0;
> +	else
> +		dev_size = range_len(&cxlr_dax->hpa_range);
> +
>  	data = (struct dev_dax_data) {
>  		.dax_region = dax_region,
>  		.id = -1,
> -		.size = range_len(&cxlr_dax->hpa_range),
> +		.size = dev_size,
>  		.memmap_on_memory = true,
>  	};
>  
> 
> -- 
> 2.49.0
> 

-- 
Fan Ni (From gmail)
