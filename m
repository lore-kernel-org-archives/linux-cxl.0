Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEEDA13AC1
	for <linux-cxl@vger.kernel.org>; Wed,  5 Mar 2025 10:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741170172; cv=none; b=JsDEYwBfiWl1GJiWXSzhiMDpy9V18FiG7rAYWQPmVHFyuyo1/g2V9GrWV9wFLld6r+aaeh4/SkDfCnj2LiKLW717lUBS+6YNdj6r1gQgNSI9SVXhNFlgAAkPcs9C8Ya6kk3WHg3HC/StUBXKeyL337+UB3YtDGAyotH2XzAw4Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741170172; c=relaxed/simple;
	bh=sDY6BUPW+OGAAp3JJSt2SBitLHYwodsfGAV9PgLqpM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PefLVNEFcEM9Ryb4H6YBEOZA9L8+yJMNq33NtvX4eNmlZBdrHFcEPU+/7R9Fug/eyDTbNrEVNmpNDPNPo58h0EbLmYOqBQyZCoMbRi10a84iRhbYhNfchZQMuGZ0XOo15OUAHAjTmf01J07sYLEFpGhSUCyY16xBrRPYGFTDmrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lIfNZSKN; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lIfNZSKN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741170170; x=1772706170;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sDY6BUPW+OGAAp3JJSt2SBitLHYwodsfGAV9PgLqpM8=;
  b=lIfNZSKNobSuk2SeU5nXd1f1eQ98ipRlA6d9TywmNRxE1WzusCbHPCsF
   5DnAVXUcXTBCZxkcN+NUQWbB/dScq2S7FynUYIdvUWP3Y1VWOVBXiB3+r
   +pUv5/J4yuQpN6rUfHy6KvLDJ9nOb5KgrGI5o5VAi1LnEOEM7AJu2BOmz
   5pqwqGT/yUEHGxx2Y3dDESD716UtB1DRvmEJvdRbgOQ11lQlrGRq/qZBo
   rtjv0TRd6x3Tp+crnSUOB5QK6YTopukV6y8xz0itGT3Qqv3yWLB7sx0Lc
   sAcyqJQnVM0TG7yuc2WKguHr+8kH6snC2pyntWm7ydcLCcEuKkgZG7SLf
   w==;
X-CSE-ConnectionGUID: 56Sca74zQ4OT/1cFEjUC1Q==
X-CSE-MsgGUID: M/L57s3qRe+aehohtpb6aA==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="59670502"
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="59670502"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 02:22:49 -0800
X-CSE-ConnectionGUID: khh250UnTTS2a11OmY7E+g==
X-CSE-MsgGUID: upSnxmzGSJO6JbChk/jRQg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,222,1736841600"; 
   d="scan'208";a="118795556"
Received: from smile.fi.intel.com ([10.237.72.58])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2025 02:22:47 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpltk-0000000HNiq-32IL;
	Wed, 05 Mar 2025 12:22:44 +0200
Date: Wed, 5 Mar 2025 12:22:44 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: akpm@linux-foundation.org, Li Zhijian <lizhijian@fujitsu.com>,
	linux-cxl@vger.kernel.org, Jonathan.Cameron@huawei.com,
	mika.westerberg@linux.intel.com, ilpo.jarvinen@linux.intel.com,
	bhelgaas@google.com, huang.ying.caritas@gmail.com
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <Z8gl9JzsfGoF4xQ9@smile.fi.intel.com>
References: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <174114125011.1367354.2670882864492961789.stgit@dwillia2-xfh.jf.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

On Tue, Mar 04, 2025 at 06:22:53PM -0800, Dan Williams wrote:
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

The above lines are not important and may be removed from the commit message.

> It turns out it not only leaks memory, also fails to unwind changes to
> the resource tree (@base, usually iomem_resource).
> 
> Fix this by consolidating the devres and devm paths into just devres,
> and move those details to a wrapper function. So now
> __get_free_mem_region() only needs to worry about alloc_resource()
> unwinding, and the devres failure path is resolved before touching the
> resource tree.

...

>  static void devm_region_release(struct device *dev, void *res)
>  {
>  	struct region_devres *this = res;
>  
> -	__release_region(this->parent, this->start, this->n);
> +	if (!this->res) {
> +		__release_region(this->parent, this->start, this->n);
> +	} else {
> +		remove_resource(this->res);
> +		free_resource(this->res);
> +	}

Why not positive conditional?

	if (this->res) {
		remove_resource(this->res);
		free_resource(this->res);
	} else {
		__release_region(this->parent, this->start, this->n);
	}

>  }

...

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
> +	if (dev) {
> +		dr = devres_alloc(devm_region_release,
> +				  sizeof(struct region_devres), GFP_KERNEL);

sizeof(*dr)

> +		if (!dr)
> +			return ERR_PTR(-ENOMEM);
> +	}

> +	res = __get_free_mem_region(base, size, align, name, desc, flags);

> +	if (IS_ERR(res) || !dr)
> +		return res;


But wouldn't be easier to utilise devm_add_action_or_reset()?

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

-- 
With Best Regards,
Andy Shevchenko


