Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCF2345CB2
	for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 08:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782290190; cv=none; b=cjmxBdMSUPFNPi0iZf4JFZsNBOrprtY6I4GWHl6xh30pvtk7rolt1ec7raTj65CS468lNEieVkRXPAtiNFiwZ4ZfW8RndP8I0Arcjha43lu3VUcfTIqPaWYuOdHgJxBE4A+KswHkV4cNWi+KF6W3q9clWPGVkCNCDlRap7lB5ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782290190; c=relaxed/simple;
	bh=IC96SJpon10vJpky3Egz7KbIXsoKr7uotQi+Mi3bWy4=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OKmzWEIOpCUOylpDM20ntIEffpaIbYKKzmAj3dU+8PKDSKDD1GGJ67nwRNJDBr+8ey7xy9foVysP0voaXfom7SEVn9R51JiNJq4nmyVbX690b8L0fSGr0ZJimrvEmdDDC2iR4IgVykC1TtXvi05dxBTDUjNwsQvogF6oWEjwBQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tMogCuSj; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tMogCuSj"
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-30c6c8d7503so1227671eec.0
        for <linux-cxl@vger.kernel.org>; Wed, 24 Jun 2026 01:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782290189; x=1782894989; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=i6loG2kbuu3buyD+OMfDQDJAMGaTd6c5fL/hshLRcTg=;
        b=tMogCuSjDvveW3L5eqfsApWiu/ogl36KpFw2EBTGe3DFaFd7nMxNF6VrlC6kh2ipBj
         68bkT7l+ZFNboTrHq2b8WYGeoFnTd08+VhyyJOnbnYav0C7DPSj6z3Z4F0wkB2x4db3f
         2Uv7JPlE7GmlgfvHZVz4erQMnPcfrR418v1eNtW7D1lNb9gMZDTA0pog4pY0upwvC8t5
         1ikuUnnh4EMDqq4StjYPipPZmcSDhUek8rV4u/ny9F9lGFs6MBk9cjZD6ZZTEpnTF3R5
         DbIQCAuxpJF3Yqk5XcUmsWeT/x3HWnxSeqJTM7hsPaAMiH6AjYsHsZk+w8FykmvXe1uk
         9b7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782290189; x=1782894989;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=i6loG2kbuu3buyD+OMfDQDJAMGaTd6c5fL/hshLRcTg=;
        b=Uwjr1iu9grAe9QsbuxIEtQYSP1FXL/ng6TEwng0XEiCHOwe6Uk/yJ8Cuu9YZjmQx6w
         VnamjgGfSaJ8yLYIvVe/Y1R+3IdNZlagpzbXnM47LHDUppUHM2rFzDBhY9AHUxho/asg
         bwmUlmwnW5ShRg1VGyrKtDanbBs8cm62hKCjHp59Q6BukTpYImqMEgJTnpcAyg+25cD/
         +Nngjcp2v+aEyOUUZZKTAVcdBS/0lbHHyXRSe4kNxeZ+7YHWILDTe8Lf55wE2g2SHnfx
         m9zt3UajdLjgyAHbwLuV9NIyUSC849LALslB8zybdb76G3twj8Kw5Oe4PWRcE8iCWPQo
         AXcA==
X-Gm-Message-State: AOJu0YybQgGJVXHrnyeFiRXOSxm6NADT956s2vecJHgQ2sTQozovlX8g
	2h3msbQWyOjfu0f/+1Q1L0O1N7T70fysUUE7qS96Zcv4If8GyfVT/A+9
X-Gm-Gg: AfdE7cnWsiH2Js011zuwoWR2KgVH0gONBR5JgnhVP3I+bFHadVTDaZGeBO5kKWEjDbo
	canoLIDAASSHyw27TsJF1U4zuk4wOy+WZpbtcHyVEsrNLD907ti/XV4Uan9jl7GEujxz7pY5R4a
	arkMd/cCauhjUpJbMk0pv6WoujZ6NHDWYRA/m+Phr0W4lNGE2T2uZDDSS3RmdFV004KDDCb0Al7
	dlJ2/fw1M4Hm5fs9a7RSEF0CTMxSLUXcWVa0xW0n9ofAbO9c36lXhym39dssRGD0sEj7OMolzml
	+NdNvY+jJRzD0tSufIxQ4La+DSj+U9T4EpePiONKS7goa2wqt6IDo2025TuwYAww7wzGkn94/Id
	cceNVgJ/KS7XQtnJrfsaQYwQQBxUzsL0o8cG1dK0oUTHp05RQ6ewAnSLXtf04n7R9/U8qaHFhmG
	9243cWQAqFF/EhOLBf4BZgwQ+yYYE/JJO/vaQ6yGqF+SUHfeVMaJ0ED6ouqnbS3IrCioL9+GYJ5
	LeolNQ=
X-Received: by 2002:a05:7300:506:b0:30b:c502:23e8 with SMTP id 5a478bee46e88-30c692f8c53mr2440312eec.21.1782290188564;
        Wed, 24 Jun 2026 01:36:28 -0700 (PDT)
Received: from AnisaLaptop.localdomain (c-73-170-217-179.hsd1.ca.comcast.net. [73.170.217.179])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30c6d5717a2sm2764659eec.0.2026.06.24.01.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 01:36:27 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 24 Jun 2026 01:36:26 -0700
To: Anisa Su <anisa.su887@gmail.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
	nvdimm@lists.linux.dev, Dan Williams <djbw@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <iweiny@kernel.org>,
	Alison Schofield <alison.schofield@intel.com>,
	John Groves <John@groves.net>, Gregory Price <gourry@gourry.net>,
	Ira Weiny <ira.weiny@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v10 23/31] dax/bus: Factor out dev dax resize logic
Message-ID: <ajuXCluBoji23s8N@AnisaLaptop.localdomain>
References: <cover.1779528761.git.anisa.su@samsung.com>
 <29393afa419cdffdd5d299cdc323262f5c20c036.1779528761.git.anisa.su@samsung.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <29393afa419cdffdd5d299cdc323262f5c20c036.1779528761.git.anisa.su@samsung.com>

On Sat, May 23, 2026 at 02:43:17AM -0700, Anisa Su wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Dynamic Capacity (DC) DAX regions back their dax devices with per-extent
> resource children of the region, rather than carving from a single
> contiguous dax_region->res.  Allocating space for a DC dax device — on
> initial uuid claim of its backing extents and on shrink-to-0 during
> destroy — needs the same allocator the static case uses, but pointed at
> a different parent resource.
> 
> Factor the body of dev_dax_resize() into __dev_dax_resize(parent, ...)
> and add a dev_dax_resize_static() wrapper that passes dax_region->res
> for static (non-DC) regions.  alloc_dev_dax_range() gains the same
> parent parameter so it can operate under either kind of parent.
> 
Stale commit message :( __dev_dax_resize is introduced in a subsequent
commit. Updated commit message to reflect actual state.

> No functional change.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
[snip]
> +
> +static ssize_t dev_dax_resize(struct dax_region *dax_region,
> +		struct dev_dax *dev_dax, resource_size_t size)
> +{
> +	resource_size_t avail = dax_region_avail_size(dax_region);
> +	resource_size_t dev_size = dev_dax_size(dev_dax);
> +	struct device *dev = &dev_dax->dev;
> +	resource_size_t to_alloc;
> +	resource_size_t alloc;
> +
> +	if (dev->driver)
> +		return -EBUSY;
> +	if (size == dev_size)
> +		return 0;
> +	if (size > dev_size && size - dev_size > avail)
> +		return -ENOSPC;
> +	if (size < dev_size)
> +		return dev_dax_shrink(dev_dax, size);
> +
> +	to_alloc = size - dev_size;
> +	if (dev_WARN_ONCE(dev, !alloc_is_aligned(dev_dax, to_alloc),
> +			"resize of %pa misaligned\n", &to_alloc))
> +		return -ENXIO;
> +
> +retry:
> +	alloc = dev_dax_resize_static(&dax_region->res, dev_dax, to_alloc);
From Sashiko: https://sashiko.dev/#/patchset/cover.1779528761.git.anisa.su%40samsung.com?part=23

alloc is declared as unsigned resource_size_t. A negative errno isn't
returned correctly. Instead, the below line to_alloc -= alloc underflows
and the goto retry loops forever.

Fix: declare ssize_t alloc.

> +	if (alloc <= 0)
> +		return alloc;
>  	to_alloc -= alloc;
>  	if (to_alloc)
>  		goto retry;
> @@ -1367,7 +1396,8 @@ static ssize_t mapping_store(struct device *dev, struct device_attribute *attr,
>  
>  	to_alloc = range_len(&r);
>  	if (alloc_is_aligned(dev_dax, to_alloc))
> -		rc = alloc_dev_dax_range(dev_dax, r.start, to_alloc, NULL);
> +		rc = alloc_dev_dax_range(&dax_region->res, dev_dax, r.start,
> +					 to_alloc, NULL);
>  	up_write(&dax_dev_rwsem);
>  	up_write(&dax_region_rwsem);
>  
> @@ -1659,7 +1689,8 @@ static struct dev_dax *__devm_create_dev_dax(struct dev_dax_data *data)
>  	device_initialize(dev);
>  	dev_set_name(dev, "dax%d.%d", dax_region->id, dev_dax->id);
>  
> -	rc = alloc_dev_dax_range(dev_dax, dax_region->res.start, data->size, NULL);
> +	rc = alloc_dev_dax_range(&dax_region->res, dev_dax, dax_region->res.start,
> +				 data->size, NULL);
>  	if (rc)
>  		goto err_range;
>  
> -- 
> 2.43.0
> 
