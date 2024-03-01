Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70346848D
	for <linux-cxl@vger.kernel.org>; Fri,  1 Mar 2024 18:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709317788; cv=none; b=NgPCTQoCw6vDBLe3/VBz4NFrXMyYQKmvAgrBj5Rd6a9zUDAABLzA/T2uGICk5q2zXDGxcusTKZPFaaM4UaJ8mtEgGwLD9fYxzl2LKqj1dlC8qjj84ExiSB3lz3c23vz3eISCSen9kIwa64VsUAgtRC3CIfal3cZXKcLlgbRftLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709317788; c=relaxed/simple;
	bh=AmBMXsibMJMY74/f4lkWFY2hP8nkj+DbT+waYvwXWFQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iS8EgbC1omVeJoR9SMYStk5sKOUjIa9b2rgFN+1OJZkbQp1ODlScl6iK1BT7hE9UJu0DCNMh2UT16MpoIYWDD70LCDr+zWVCNczvD03CKDvOiSLis4nG3sONCT0mDoW3euPUxsfD8cCw1DqlxlIBj+ngdAdoFsc6RhBTBab+UaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/EWLd3x; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/EWLd3x"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709317786; x=1740853786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AmBMXsibMJMY74/f4lkWFY2hP8nkj+DbT+waYvwXWFQ=;
  b=N/EWLd3xIduYI29Jf2Eu56UMFsul9XzmA+uJQJneWvjhcwOisvSIakSJ
   +zEmrzdQrt0HXisUx6Zw0prYJ4XBzMY9CXAguhu3HGEJmXQ+Udoz9o8EE
   zSnBPCJZK/2cdEPW/bZvdteC3kF4DczS2JZilBENVs7YgKeJf44u64yBv
   rACz5mpYYlv30B89YCD4B7xm82zP6HXwAUZStratFnAH7B8UvPVnzlq+T
   ut0iEQ72/D2yCmTiasMwMFnVmbnuEa2V8TjpuN8xcsSXBkfeKWIdqtpeI
   XRgifEiW6i63FAK1qnlF7qyBaHtZT6bLkjgzeUckMOCaHuw3io4n+kA5U
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11000"; a="6820061"
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="6820061"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:29:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,196,1705392000"; 
   d="scan'208";a="8659254"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.20.131])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2024 10:29:38 -0800
Date: Fri, 1 Mar 2024 10:29:36 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: linux-cxl@vger.kernel.org,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH v2] cxl/acpi: Cleanup __cxl_parse_cfmws()
Message-ID: <ZeIekICjXpqVUrUG@aschofie-mobl2>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>

On Wed, Feb 28, 2024 at 12:30:56PM -0800, Dan Williams wrote:
> As a follow on to the recent rework of __cxl_parse_cfmws() to always
> return errors [1], use cleanup.h helpers to remove goto and other cleanups
> now that logging is moved to the cxl_parse_cfmws() wrapper.

one question about helper below...


>
snip

> +static struct resource *alloc_cxl_resource(resource_size_t base,
> +					   resource_size_t n, const char *fmt,
> +					   ...)
> +{
> +	va_list ap;
> +
> +	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return NULL;
> +
> +	res->start = base;
> +	res->end = base + n - 1;
> +	res->flags = IORESOURCE_MEM;
> +
> +	va_start(ap, fmt);
> +	res->name = kvasprintf(GFP_KERNEL, fmt, ap);
> +	va_end(ap);

Why is alloc_cxl_resource() defined w variable params and using
kvasprintf(), rather than tailored to the one caller and used
kasprintf()?

Perhaps you have bigger plans for this helper?

Other than that,

Reviewed-by: Alison Schofield <alison.schofield@gmail.com>

> +

snip

