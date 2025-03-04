Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26841E7C20;
	Tue,  4 Mar 2025 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741080146; cv=none; b=D41s8X1mdIwTkIpsX6qjVxWnswSvSBMLjNYyZLccSLD4iW6MY+kn5x8eJLkQFOeg4RZ9sUu/SGlqPHj4VLITHvGtU7ty3F22TcUEr1aNLwuA/+I8bzu4bEbD40DvyLbd6JKyye2SKJ4e4uyp42mqPpZXVXrgKBAc3U1Ptr2/POA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741080146; c=relaxed/simple;
	bh=SzzsRRoVJ9on6nCvD3rxckgTKyuW2QMhoe9u+u7oqQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A8k6QqyesxJGuHoRSc3hgStHV3eBhw0SDbURRoITF7rSLsEEu61jhEqULN9Dc4RbGmmN7TBnYAOI78v4P4VMxhBjJvrYpyBBwQkHjYK10akjgZ5XlMYPgLZEzusH2tDphzEgBehBFFsasNA5jhD6rNVFnoZtyX/5+y/jpiL5LmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R4c+7N+b; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R4c+7N+b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741080145; x=1772616145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SzzsRRoVJ9on6nCvD3rxckgTKyuW2QMhoe9u+u7oqQY=;
  b=R4c+7N+bZJDAgGcJ8a03bszDb7NWJeoplgDSAYtQdZx9Dfaz6ER6bsBs
   3woRUEMK1uq+Fz+7RXzUViA+GGY+DEYfP74JTprw9+p9HDZyupcxt1+s/
   Ibszzqh1gWaVIhf08Nko2ANgT83Z8I6NGVgJSCs6P1qp/rnAI0UrZ7QUC
   bVsSsOLv2bEL9IDIeLCR77i1LlDaY7jS+EsXqoh+cEjEqRtmeD2lk8Jqt
   AO9TA0ZyK0SaBee9Lpt4lrFmxvuvGdXT+FPVMm8T9VvTRDK35lr9vxVky
   Az8pXzY4GGWxAS8jYPOvtOC0cHsp/cWTVvurAhH6GSlTC3z0GVOEvqhOj
   w==;
X-CSE-ConnectionGUID: dj7rggjBT4Gq0tKAsvsdgw==
X-CSE-MsgGUID: BAPSUnnOQsmddXd7SJenMw==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="42015201"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="42015201"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 01:22:24 -0800
X-CSE-ConnectionGUID: C6Z0m4zgSryEZhTwrMg74w==
X-CSE-MsgGUID: P/Z78RriRpeF2xKcmkXNmQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="155509074"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa001.jf.intel.com with ESMTP; 04 Mar 2025 01:22:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
	id 433A218F; Tue, 04 Mar 2025 11:22:19 +0200 (EET)
Date: Tue, 4 Mar 2025 11:22:19 +0200
From: Mika Westerberg <mika.westerberg@linux.intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	ilpo.jarvinen@linux.intel.com, Bjorn Helgaas <bhelgaas@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <20250304092219.GH3713119@black.fi.intel.com>
References: <20250304043415.610286-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250304043415.610286-1-lizhijian@fujitsu.com>

On Tue, Mar 04, 2025 at 12:34:15PM +0800, Li Zhijian wrote:
> The leak is detected by the kernel memory leak detector (`kmemleak`)
> following a `cxl create-region` failure:
> 
>  cxl_acpi ACPI0017:00: decoder0.0: created region2
>  cxl region2: HPA allocation error (-34) for size:0x0000000100000000 in CXL Window 0 [mem 0xa90000000-0x1a8fffffff flags 0x200]
>  kmemleak: 1 new suspected memory leaks (see /sys/kernel/debug/kmemleak)
> 
>     __kmalloc_cache_noprof+0x28c/0x350
>     get_free_mem_region+0x45/0x380
>     alloc_free_mem_region+0x1d/0x30
>     size_store+0x180/0x290 [cxl_core]
>     kernfs_fop_write_iter+0x13f/0x1e0
>     vfs_write+0x37c/0x540
>     ksys_write+0x68/0xe0
>     do_syscall_64+0x6e/0x190
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e
> 
> Fixes: 14b80582c43e ("resource: Introduce alloc_free_mem_region()")
> Signed-off-by: Li Zhijian <lizhijian@fujitsu.com>
> ---
>  kernel/resource.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/kernel/resource.c b/kernel/resource.c
> index 12004452d999..aa0b1da143eb 100644
> --- a/kernel/resource.c
> +++ b/kernel/resource.c
> @@ -2000,6 +2000,8 @@ get_free_mem_region(struct device *dev, struct resource *base,
>  		devres_free(dr);
>  	} else if (dev)
>  		devm_release_action(dev, remove_free_mem_region, res);
> +	else
> +		free_resource(res);

It should use {} as per coding style:

	} else {
		free_resource(res);
	}

(probably should add that to the previous branch too).
