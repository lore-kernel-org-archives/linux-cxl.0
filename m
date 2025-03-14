Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBBD166F32
	for <linux-cxl@vger.kernel.org>; Fri, 14 Mar 2025 11:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741952948; cv=none; b=Pr9ULs2SQzc3Ivi7YwJsobBHRUF7hHrOanxvI1wuYsyDDfk7UedFKo/F2ACc22ti4F2UStI0Gt4NEIQUjvzaKiQzVRjxDZ4EWJ51LJcf8URjbozmzECvKJ/WuzFzS6PQfZfDJAUbFvTuUAT2TI6Y0V9UPhqTEc04fIWoqI9idMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741952948; c=relaxed/simple;
	bh=rshHOHTD1bxdLP+oopn+oEtDhvYxrjZd7AaQNgVhK5M=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+KyclrSQ/9nC2hsxulGBKuVupY2x6vd1Lu02fvm7kx2SSmjAxSCOkBZREVhpSV83JQc+ISNvtkJFhapODztM4g/TWuI6UoK3cjjInrlUXtSvtnlaXI5pH70c8gDa36xgOtc/b0wXxmUZHjvvgFRGZo2ZFnqwhEgls9fJ3fWDC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4ZDjHy6fk8z6K5l2;
	Fri, 14 Mar 2025 19:46:22 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BCCC7140155;
	Fri, 14 Mar 2025 19:49:03 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Mar
 2025 12:49:03 +0100
Date: Fri, 14 Mar 2025 11:49:01 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <akpm@linux-foundation.org>, Li Zhijian <lizhijian@fujitsu.com>,
	<linux-cxl@vger.kernel.org>, <andriy.shevchenko@linux.intel.com>,
	<mika.westerberg@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<bhelgaas@google.com>, <huang.ying.caritas@gmail.com>
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <20250314114901.00000b99@huawei.com>
In-Reply-To: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
References: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100011.china.huawei.com (7.191.174.247) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 04 Mar 2025 18:22:53 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Li reports a kmemleak detection in get_free_mem_region() error unwind
> path:
> 
>   cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
>   kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
>      __kmalloc_cache_noprof+0x28c/0x350
>      get_free_mem_region+0x45/0x380
>      alloc_free_mem_region+0x1d/0x30
>      size_store+0x180/0x290 [cxl_core]
>      kernfs_fop_write_iter+0x13f/0x1e0
>      vfs_write+0x37c/0x540
>      ksys_write+0x68/0xe0
>      do_syscall_64+0x6e/0x190
>      entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> It turns out it not only leaks memory, also fails to unwind changes to
> the resource tree (@base, usually iomem_resource).
> 
> Fix this by consolidating the devres and devm paths into just devres,
> and move those details to a wrapper function. So now
> __get_free_mem_region() only needs to worry about alloc_resource()
> unwinding, and the devres failure path is resolved before touching the
> resource tree.
> 
> Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> Reported-by: Li Zhijian <lizhijian@fujitsu.com>
> Closes: http://lore.kernel.org/20250304043415.610286-1-lizhijian@fujitsu.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
> 
> Andrew, here is a replacement patch for
> resource-fix-resource-leak-in-get_free_mem_region.patch in your tree. It
> addresses missing calls to remove_resource() in addition to
> free_resource() in the error path.

Fiddly code.  So feel free to ignore comments below as even
if these help, it's still code that requires more coffee than I have
had today to follow easily.

Jonathan

>  
> +static struct resource *
> +get_free_mem_region(struct device *dev, struct resource *base,
> +		    resource_size_t size, const unsigned long align,
> +		    const char *name, const unsigned long desc,
> +		    const unsigned long flags)
> +{
> +
> +	struct region_devres *dr __free(kfree) = NULL;
> +	struct resource *res;
> +
	Avoid split of the constructor / destructor with a ternary though
	error check is worse... Hmm.

	struct region_devres *dr __free(kfree) =
		dev ? devres_alloc(devm_region_release, sizeof(*dr), GFP_KERNEL) : NULL;
	if (dev && !dr)
		return ERR_PTR(-ENOMEM);

So on balance up to you, but at very least put that __free(kfree) direclty
above the set.

> +	if (dev) {
> +		dr = devres_alloc(devm_region_release,
> +				  sizeof(struct region_devres), GFP_KERNEL);
> +		if (!dr)
> +			return ERR_PTR(-ENOMEM);
> +	}
> +
> +	res = __get_free_mem_region(base, size, align, name, desc, flags);
> +
Probably no blank line here would be nicer.

> +	if (IS_ERR(res) || !dr)

This conflates error and don't care if error cases and briefly
made me scratch my head.

Maybe though it increase indent don't do early
return on the !dr case.

	if (IS_ERR(res))
		return res;

	if (dr) {
		dr->parent = base;

		...

	}

	return res;

> +		return res;
> +
> +	dr->parent = base;
> +	dr->start = res->start;
> +	dr->n = resource_size(res);
> +
> +	/* See 'struct region_devres' definition for details */
> +	if ((flags & GFR_REQUEST_REGION) == 0)
> +		dr->res = res;
> +
> +	devres_add(dev, no_free_ptr(dr));
> +
> +	return res;
> +}
> +
>  /**
>   * devm_request_free_mem_region - find free region for device private memory
>   *
> 
> 

