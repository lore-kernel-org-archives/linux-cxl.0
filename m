Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26561BD9DD;
	Wed, 30 Oct 2024 17:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730310671; cv=none; b=ThQTgjq31dJnyHdGg3C2hq/ctHBGMxchraKkiepuWvHb+PCtwz33lZL7EoOoq+haRHzQO/fmErhTFbfDtwuWq7kSGypGddv87cgaOcOf5ni11zmuYo7GxkWAjqicWoBwQdtHaysrVE5nQHAoepE5kfucud4y0U03Auhl38v/ciY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730310671; c=relaxed/simple;
	bh=POS7B+2UmGCT58tmhcQ34TAhYGQICIh64jfrggu4bCw=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SBqZvLksdEPaCQ04D4CGRt0P2rHTegiSfW0eApCwA2DQr0BCb4ixhLanbM4qsUDVNIITofXmirWfDR6KWPMrfKOjZOL4L4qfvfEtqYoliEQ7RlAiCETnYRXbngRTrpl01kp940FEe6F4rwHVqEeFLtsjFpsqSsGMZEkb3L/h7z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aSfeG0Rq; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aSfeG0Rq"
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e30e5b1dbdaso45642276.3;
        Wed, 30 Oct 2024 10:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730310668; x=1730915468; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vjd1UA4VGq0MmOBEsoo5W+9ryin2yV9rE8tVjf4h6xE=;
        b=aSfeG0RquL79OCc76sNFUmr4dGFqB3SDSPKgVxWUzy9grjqHA+W2NyvxQk/NWraj+M
         g2582tHyzf0jHSjV5240JFTDid3zVcqqTk1MElvar94PpzphYhNqHRs8Q1M1HAnnflmA
         f6woPuX/z62LccRZXaDU4sWrTc/wqGW+Z36yPwQmkRBn0q+BczsjXk8BUJdN2S0Giitu
         2yYeb5Ft/lWaIEOl7ORiOZt9GOC+vUC9lLKN8c2YjQjrf4QF52tZ61INsGDXkl/15VDk
         RJ5o4EJLbkpBz/9nnnQZGS/i2q0T2eQA54h8oKd0h9a2ITzh4SpC6J9Q/M7FKYci0ESI
         VMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730310668; x=1730915468;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjd1UA4VGq0MmOBEsoo5W+9ryin2yV9rE8tVjf4h6xE=;
        b=k2MaaaaF9UjmyAiyxjG2hnvWXXrRgNBmcCcf2+M1UAaFFxzTBlqsg8xiWHDrSKE0EY
         c7azYmrVdGOSmzd/bM7p1dv7T5sBTIFljwd4R99gXpL4lS48aretchfixka2bdfaKHcA
         gnvdWyFffvA9AtKLknId/OP29sDzaN2xrDS8a+w4wLQGceDEQ9bFrkDEJkiQEB54By0I
         GnO38Nitphv2E5xa4kTK8bLETXw6FUDfgsC8ugx+gOI5PbIeeCjTiULEkxxA5BdefOoo
         C7gsqK6X8BjYptn4hx3YPmNF9OWCHYjqehF3kXtHCB4J1McXz2RGPTt/nHaSCwXViaE3
         uxIw==
X-Forwarded-Encrypted: i=1; AJvYcCXZt9OYorTHAQeJvhRZt29PKmP/BHmO+3a2fgTbg0mZBJtCZht1i/qGI0BBB4nmCLpiG97l6pXYGwLV@vger.kernel.org, AJvYcCXdzYv/C5V95VgBa4GPy1Zf64fnn7urpPBgAX12ElIHEggzLpgfq0nQZJZI1kz9HcLa7hlTA5/ZQQk83ZDT@vger.kernel.org, AJvYcCXfjGf4U+dwPlcYsEoDh7/qzTjHHRcEISUSjYSQd9A+3OFKw45SmWZlrRmt1NP/Dj77TCcs+ERBgI8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwjKMNb2eKb3hdCbWD2sYshut1kse0I2OjAvC/CKSzdPxhj17oY
	KoPjy4p6pQru6Ho7/rcJuK/UoRb5QvX1Mw8aAqblDqXVQA1Bhp8g
X-Google-Smtp-Source: AGHT+IF49viZLlNmCGZYukwrxpU5CVcPPngvvPYQ6NEcV7cP0EzmVdHDeL6AvsXCVVF7yCJOZDBNgQ==
X-Received: by 2002:a05:6902:c13:b0:e28:6b10:51b4 with SMTP id 3f1490d57ef6-e3087bfd66fmr16472157276.46.1730310667694;
        Wed, 30 Oct 2024 10:51:07 -0700 (PDT)
Received: from fan ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e307a01fae9sm2427251276.42.2024.10.30.10.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 10:51:07 -0700 (PDT)
From: Fan Ni <nifan.cxl@gmail.com>
X-Google-Original-From: Fan Ni <fan.ni@samsung.com>
Date: Wed, 30 Oct 2024 10:50:40 -0700
To: ira.weiny@intel.com
Cc: Dave Jiang <dave.jiang@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Navneet Singh <navneet.singh@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org, nvdimm@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 13/27] cxl/mem: Expose DCD partition capabilities in
 sysfs
Message-ID: <ZyJx8FNXpy5SWaP2@fan>
References: <20241029-dcd-type2-upstream-v5-0-8739cb67c374@intel.com>
 <20241029-dcd-type2-upstream-v5-13-8739cb67c374@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029-dcd-type2-upstream-v5-13-8739cb67c374@intel.com>

On Tue, Oct 29, 2024 at 03:34:48PM -0500, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> user space will need to know the details of the DC partitions available.
> 
> Expose dynamic capacity capabilities through sysfs.
> 
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Co-developed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes:
> [Fan: Use proper str_false_true() call]

Reviewed-by: Fan Ni <fan.ni@samsung.com>

Fan
> [Jonathan: minor cleanups]
> [Bagas: Clean up documentation language]
> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  45 ++++++++++++
>  drivers/cxl/core/memdev.c               | 124 ++++++++++++++++++++++++++++++++
>  2 files changed, 169 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 3f5627a1210a16aca7c18d17131a56491048a0c2..ff3ae83477f0876c0ee2d3955d27a11fa9d16d83 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -54,6 +54,51 @@ Description:
>  		identically named field in the Identify Memory Device Output
>  		Payload in the CXL-2.0 specification.
>  
> +What:		/sys/bus/cxl/devices/memX/dcY/size
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.
> +		dcY/size is the size of each of those partitions.
> +
> +What:		/sys/bus/cxl/devices/memX/dcY/read_only
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.
> +		dcY/read_only indicates true if the region is exported
> +		read_only from the device.
> +
> +What:		/sys/bus/cxl/devices/memX/dcY/shareable
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.
> +		dcY/shareable indicates true if the region is exported
> +		shareable from the device.
> +
> +What:		/sys/bus/cxl/devices/memX/dcY/qos_class
> +Date:		December, 2024
> +KernelVersion:	v6.13
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Dynamic Capacity (DC) region information.  Devices only
> +		export dcY if DCD partition Y is supported.  For CXL host
> +		platforms that support "QoS Telemmetry" this attribute conveys
> +		a comma delimited list of platform specific cookies that
> +		identifies a QoS performance class for the persistent partition
> +		of the CXL mem device. These class-ids can be compared against
> +		a similar "qos_class" published for a root decoder. While it is
> +		not required that the endpoints map their local memory-class to
> +		a matching platform class, mismatches are not recommended as
> +		there are platform specific performance related side-effects
> +		that may result. First class-id is displayed.
>  
>  What:		/sys/bus/cxl/devices/memX/pmem/qos_class
>  Date:		May, 2023
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 84fefb76dafabc22e6e1a12397381b3f18eea7c5..857a9dd88b20291116d20b9c0bbe9e7961f4491f 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. */
>  
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/string_choices.h>
>  #include <linux/firmware.h>
>  #include <linux/device.h>
>  #include <linux/slab.h>
> @@ -449,6 +450,121 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>  	NULL,
>  };
>  
> +static ssize_t show_size_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
> +}
> +
> +static ssize_t show_read_only_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  str_true_false(mds->dc_region[pos].read_only));
> +}
> +
> +static ssize_t show_shareable_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%s\n",
> +			  str_true_false(mds->dc_region[pos].shareable));
> +}
> +
> +static ssize_t show_qos_class_dcN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%d\n", mds->dc_perf[pos].qos_class);
> +}
> +
> +#define CXL_MEMDEV_DC_ATTR_GROUP(n)						\
> +static ssize_t dc##n##_size_show(struct device *dev,				\
> +				 struct device_attribute *attr,			\
> +				 char *buf)					\
> +{										\
> +	return show_size_dcN(to_cxl_memdev(dev), buf, (n));			\
> +}										\
> +struct device_attribute dc##n##_size = {					\
> +	.attr	= { .name = "size", .mode = 0444 },				\
> +	.show	= dc##n##_size_show,						\
> +};										\
> +static ssize_t dc##n##_read_only_show(struct device *dev,			\
> +				      struct device_attribute *attr,		\
> +				      char *buf)				\
> +{										\
> +	return show_read_only_dcN(to_cxl_memdev(dev), buf, (n));		\
> +}										\
> +struct device_attribute dc##n##_read_only = {					\
> +	.attr	= { .name = "read_only", .mode = 0444 },			\
> +	.show	= dc##n##_read_only_show,					\
> +};										\
> +static ssize_t dc##n##_shareable_show(struct device *dev,			\
> +				     struct device_attribute *attr,		\
> +				     char *buf)					\
> +{										\
> +	return show_shareable_dcN(to_cxl_memdev(dev), buf, (n));		\
> +}										\
> +struct device_attribute dc##n##_shareable = {					\
> +	.attr	= { .name = "shareable", .mode = 0444 },			\
> +	.show	= dc##n##_shareable_show,					\
> +};										\
> +static ssize_t dc##n##_qos_class_show(struct device *dev,			\
> +				      struct device_attribute *attr,		\
> +				      char *buf)				\
> +{										\
> +	return show_qos_class_dcN(to_cxl_memdev(dev), buf, (n));		\
> +}										\
> +struct device_attribute dc##n##_qos_class = {					\
> +	.attr	= { .name = "qos_class", .mode = 0444 },			\
> +	.show	= dc##n##_qos_class_show,					\
> +};										\
> +static struct attribute *cxl_memdev_dc##n##_attributes[] = {			\
> +	&dc##n##_size.attr,							\
> +	&dc##n##_read_only.attr,						\
> +	&dc##n##_shareable.attr,						\
> +	&dc##n##_qos_class.attr,						\
> +	NULL									\
> +};										\
> +static umode_t cxl_memdev_dc##n##_attr_visible(struct kobject *kobj,		\
> +					       struct attribute *a,		\
> +					       int pos)				\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);					\
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
> +										\
> +	/* Not a memory device */						\
> +	if (!mds)								\
> +		return 0;							\
> +	return a->mode;								\
> +}										\
> +static umode_t cxl_memdev_dc##n##_group_visible(struct kobject *kobj)		\
> +{										\
> +	struct device *dev = kobj_to_dev(kobj);					\
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);				\
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);	\
> +										\
> +	/* Not a memory device or partition not supported */			\
> +	return mds && n < mds->nr_dc_region;					\
> +}										\
> +DEFINE_SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n);					\
> +static struct attribute_group cxl_memdev_dc##n##_group = {			\
> +	.name = "dc"#n,								\
> +	.attrs = cxl_memdev_dc##n##_attributes,					\
> +	.is_visible = SYSFS_GROUP_VISIBLE(cxl_memdev_dc##n),			\
> +}
> +CXL_MEMDEV_DC_ATTR_GROUP(0);
> +CXL_MEMDEV_DC_ATTR_GROUP(1);
> +CXL_MEMDEV_DC_ATTR_GROUP(2);
> +CXL_MEMDEV_DC_ATTR_GROUP(3);
> +CXL_MEMDEV_DC_ATTR_GROUP(4);
> +CXL_MEMDEV_DC_ATTR_GROUP(5);
> +CXL_MEMDEV_DC_ATTR_GROUP(6);
> +CXL_MEMDEV_DC_ATTR_GROUP(7);
> +
>  static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>  				  int n)
>  {
> @@ -525,6 +641,14 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
>  };
>  
>  static const struct attribute_group *cxl_memdev_attribute_groups[] = {
> +	&cxl_memdev_dc0_group,
> +	&cxl_memdev_dc1_group,
> +	&cxl_memdev_dc2_group,
> +	&cxl_memdev_dc3_group,
> +	&cxl_memdev_dc4_group,
> +	&cxl_memdev_dc5_group,
> +	&cxl_memdev_dc6_group,
> +	&cxl_memdev_dc7_group,
>  	&cxl_memdev_attribute_group,
>  	&cxl_memdev_ram_attribute_group,
>  	&cxl_memdev_pmem_attribute_group,
> 
> -- 
> 2.47.0
> 

-- 
Fan Ni
