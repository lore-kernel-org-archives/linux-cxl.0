Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AA4C3C1F2B
	for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784101942; cv=none; b=dDrRnWvN+PwviIymcq5kdxpLrI/dnsh0s1/R36t/zLbpYwA0Yrczy9yylXH7sg4n7KnnNei5UK9VKrcQB4FyyiORcm167WXYvg+3RjORbYVi17UUOo5CcE27HX6EXBS74UKNm0l5CzPiZfgDp5NIl6FAMqScimTiuwZRFWp4wlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784101942; c=relaxed/simple;
	bh=SFfaixy5mSLcBLwBntye6Z3BtPZ39eJulCWZ9W5HDL0=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tpsGEHyWrJ37oBLJZzHdKmgEsLdWPGXgqH1xKU8gm48F55gUQiaiPF6ADosgNVWNv501gRiJ5gnerfP1yD7Hrna82nhJ3v2DVZrR0avWO7uSDmZ4X9Gihq6MyxoEhVB4Wewqn5dZfpm0yysTKN1n0SS0hP4CIEAU6Dd4h5OBcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=liJsJDLY; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="liJsJDLY"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-384930ca5e2so5327688a91.3
        for <linux-cxl@vger.kernel.org>; Wed, 15 Jul 2026 00:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784101940; x=1784706740; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LkoZxLu3mKiKId6IT2QmHjKJhmmkO8Ne64sGip4OZac=;
        b=liJsJDLYkkoZ6t9qepnMA5/KIvWIkUcAjmfl5C36qUfzlrowjVB2bdnyGuY2qgxFTa
         VYLACuYnG+X2YGMTypoYKltAcuZ/GOGhWqyqaNix4CaFRKUyL5gvNj+qH/xMFBD2sCHB
         xSbQQzoH3PTD4P+yLvjoHUTvlimrI6NIMmg7C7CokDgqwIRCA1iS9eQVL8rdfwq6d3v2
         zyicMUjqN9Yb5Czv3K7hldETFCPa3FVzn/M5mU1jW+HlNFuqWLALYBxi/OGc0vDxm9DV
         K1W3VgR6dZOjkgP/i2jSYSu9VKdCwF647ueHztODZgVg6qeIabv6TraH2QjVN4Rpt7Eu
         7gyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784101940; x=1784706740;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:date
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=LkoZxLu3mKiKId6IT2QmHjKJhmmkO8Ne64sGip4OZac=;
        b=OMqg5A00KqJd15yKvjpzY0cHRh1J5BZbuJjXzbduMzkd2Z1YM6EhafrcspuTPMlINP
         Yz/+zol3YIWFdsB7i1KU0UiOsRoPlrx5aVdPrPRctWc9ci42KTIsBXZwR1Ext6PtfR2G
         Ovzf/3iUfmX3Ndwu2g/5E/ukQZZsHNnnY36ItVQFTBiMvMTYdW0bNvLazZTCjPYMd0Kq
         vn4PzrH61N62ikVuWaEAcYG3ZJJqtknjdGbOYKmFOx6woFW0ywVrJ4f0sf5080bABP+f
         lWOGAfkI1dbxBkZWqeDvrRT/6BG5Fx7wEtsxUwuhprWfc2kfXwAUBvgnoCF6WSMMej0V
         4HNg==
X-Forwarded-Encrypted: i=1; AHgh+RrwvWUxPZW0n32MZpENCVK9AVkJVcUZLD5ZzXzFVM6+k2bY1S9kCQTjbz2xdgNdsB44Tsf7BOB9D0U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0/lgJ1uBkkslyfuFA5rvRCkMeiszZ1FzTCXnC/hMz/J1Vox3o
	XOJovgndHwZjH670YL+Isq0Ujkb7vmfDdOw+L2vZ/1j9qPzoWsZ2TPAQGG7yDw==
X-Gm-Gg: AfdE7cl5y+3cuRzzvj5918KPwBoBUHEpC433/9KsO/KRByXvL0PcUmeqOwfk/PZhbGi
	eu4E6dKM9lrE/V4j2UeJrzjs9yF9NkiHujtmrDZ86+ETUhR7DC/Q1lGfmsJQZOyvjspuZJ0XJCX
	JPxSpD0Mt4qxfrY8yisG6UWQQtEnOV00pIJKxXHwHTgx1hWA5Pgz3vd51SNPodl14/o0vulxu30
	2JyOYjx3HIyWMSRJjlNrgJL3NPxLQdzL3QiEAyr1f5MmskG54TBiIjJN7xQsjybHO2yrtnKt3QV
	UtHykao1f8jqV29BI8OU/R2jg9XwA6m0j5Gzi0gWyGM74cGIY6Cg16wrm/86e5ZkPh+ZF9i+u7o
	edyo8L0s5g73xka0j/UNpSUyR+8lNAdx23kcb/8d89pdqqtO/kZoWaeiqsUaDhJBuWbXUEfHbvh
	M+c3ObCmjEQI9o9PmoZNmjTxSyP+3nhAxUs5RRR+AM5pc9kAudg6tCMyv3gC7Abm6GBfCZ07uWl
	YPhZ1s=
X-Received: by 2002:a17:90b:3142:b0:387:e0db:3d8e with SMTP id 98e67ed59e1d1-38e2a0a87cfmr1777436a91.41.1784101940512;
        Wed, 15 Jul 2026 00:52:20 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31174ac14f2sm94910291eec.27.2026.07.15.00.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 00:52:20 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 15 Jul 2026 00:52:17 -0700
To: sashiko-reviews@lists.linux.dev
Cc: Anisa Su <anisa.su887@gmail.com>, nvdimm@lists.linux.dev,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v11 05/31] cxl/mem: Expose dynamic ram 1 partition in
 sysfs
Message-ID: <alc8MagZWKAAcNA_@AnisaLaptop.localdomain>
References: <20260625112638.550691-1-anisa.su@samsung.com>
 <20260625112638.550691-6-anisa.su@samsung.com>
 <20260625181243.77F581F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260625181243.77F581F000E9@smtp.kernel.org>

On Thu, Jun 25, 2026 at 06:12:42PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Empty sysfs directory created for absent dynamic RAM partitions.

Fixed.

> --
> 
> commit 839299dd9514d54314e661cd789de765da08d4f4
> Author: Ira Weiny <iweiny@kernel.org>
> 
> cxl/mem: Expose dynamic ram 1 partition in sysfs
> 
> This commit exposes the details of the first dynamic ram partition via
> sysfs so user space can properly configure CXL regions.
> 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> 
> [ ... ]
> 
> > @@ -519,6 +551,29 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
> >  	.is_visible = cxl_pmem_visible,
> >  };
> >  
> > +static umode_t cxl_dynamic_ram_1_visible(struct kobject *kobj, struct attribute *a, int n)
> > +{
> > +	struct device *dev = kobj_to_dev(kobj);
> > +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> > +	struct cxl_dpa_perf *perf = part_perf(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_1);
> > +
> > +	if (a == &dev_attr_dynamic_ram_1_qos_class.attr &&
> > +	    (!perf || perf->qos_class == CXL_QOS_CLASS_INVALID))
> > +		return 0;
> > +
> > +	if (a == &dev_attr_dynamic_ram_1_size.attr &&
> > +	    (!cxl_part_size(cxlmd->cxlds, CXL_PARTMODE_DYNAMIC_RAM_1)))
> > +		return 0;
> 
> [Severity: Low]
> Should cxl_dynamic_ram_1_visible() return SYSFS_GROUP_INVISIBLE here when the
> dynamic RAM partition is absent?
> 
> Since cxl_memdev_dynamic_ram_1_attribute_group is a named group
> (.name = "dynamic_ram_1"), returning 0 hides the individual attributes but
> still creates the group directory.
> 
> Won't this result in a permanently empty "dynamic_ram_1" directory in sysfs if
> the size is 0, rather than suppressing the directory entirely?
> 
Fixed.

If a DC partition's size is 0, better not the expose the directory at
all, instead of hide both attributes.

Ram and pmem always expose the size attribute, even if the
size of the ram/pmem partition is 0, but that makes less sense for a DC
partition, especially if support for multiple partitions is added later.

> > +
> > +	return a->mode;
> > +}
> > +
> > +static struct attribute_group cxl_memdev_dynamic_ram_1_attribute_group = {
> > +	.name = "dynamic_ram_1",
> > +	.attrs = cxl_memdev_dynamic_ram_1_attributes,
> > +	.is_visible = cxl_dynamic_ram_1_visible,
> > +};
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260625112638.550691-1-anisa.su@samsung.com?part=5
