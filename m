Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CB8D1FF601;
	Tue,  4 Mar 2025 12:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741090165; cv=none; b=VsKYHJl8/LNaLrOWDYPK4C5W2PQStZV8yNGKAOtZpXTQeO5/8r3q/DDZnOHR3rkO44H7Kt9Gpyjol3zg11sHYqZYYxhWe20o3JU/53T7COvVjDaPnXA153hAnIU8ZriC5pd6unlEOASGMr28TcnoxfO0pnbLjCh2IFJWmCD9z84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741090165; c=relaxed/simple;
	bh=ogSYhzGCHiiIkuY69mtK2P9WMYKeISRCXFDfjwBJNHA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n6TqWlFUm0ZZFnBFkqR9FFYzyxg+dJmnyczorCJqbFWLIQTy7wCfGciAL2mX3E/QLnalwYOAxX6nI6HN4AXdfznO+IBKt8lyW+Co2Uk2M/iQ3VgQco0ebDMDANGC+TmUDphknN3wmODZ7ztqVon1SkBdvlvhoagz6oBneIgOetA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EcovBiOr; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EcovBiOr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741090163; x=1772626163;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ogSYhzGCHiiIkuY69mtK2P9WMYKeISRCXFDfjwBJNHA=;
  b=EcovBiOrvB+KZ608w1UsFOjqluuOQkO5dkzwOWBWArY/PfICO4SIVBMA
   1NdZ5iX2ErATgO9DpKGm/wyiMcGwiZaLnCEesEWxRuKUXqU+OAhrcKa1n
   GJBep1tndM/QdRWQ6PXKobpHnCLYhp9f8eFauKuuUtaqRW0gfLIg5x9nR
   6lrPDMMc30RpxWlSfPiHeyiZ66Qq0nl1lBLnb+HXIPQVSscadlrf6O1e3
   QAEGzqTcJu8alTY1WMqQR2C4kZ71Y0YPZxjxR6I8xSXvFzmHNyHn2BM5k
   uAfCYhOvd0cTlmHeBiWvTs+tODmwsCPNjYjrrBqovZKxm+KuGqrwJKbzO
   Q==;
X-CSE-ConnectionGUID: SFO+9DJpRlWZoo9d6BcJTQ==
X-CSE-MsgGUID: DYN0kg8HSJ29MFuDX3y9fQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11362"; a="41181574"
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="41181574"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:09:22 -0800
X-CSE-ConnectionGUID: 0p40bEkYTg+w90kV7SKWmQ==
X-CSE-MsgGUID: YurhHa8oRCaePj3Ivnp6tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,331,1732608000"; 
   d="scan'208";a="123363786"
Received: from smile.fi.intel.com ([10.237.72.58])
  by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2025 04:09:20 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.98)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1tpR5J-0000000H7J9-10sU;
	Tue, 04 Mar 2025 14:09:17 +0200
Date: Tue, 4 Mar 2025 14:09:17 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Li Zhijian <lizhijian@fujitsu.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	ilpo.jarvinen@linux.intel.com,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ying Huang <huang.ying.caritas@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH] resource: Fix resource leak in get_free_mem_region()
Message-ID: <Z8btbTohCVzq16Qb@smile.fi.intel.com>
References: <20250304043415.610286-1-lizhijian@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304043415.610286-1-lizhijian@fujitsu.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo

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

The below lines have no importance to be present in the commit message.
Please read Submitting Patches documentation that justifies my comment.

>     kernfs_fop_write_iter+0x13f/0x1e0
>     vfs_write+0x37c/0x540
>     ksys_write+0x68/0xe0
>     do_syscall_64+0x6e/0x190
>     entry_SYSCALL_64_after_hwframe+0x76/0x7e

-- 
With Best Regards,
Andy Shevchenko


