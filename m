Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC66242D93;
	Tue,  1 Jul 2025 19:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751397254; cv=none; b=r3NahVOAt6s/DO4sXsxgTFIt6YfyLgI041y/UT/vyuB42BvY+/vqZ5LvdPxrZA8yMsPiNeHFzvITH5Ly7dkoiEtmm5Bv3YV/QFM2nPSuytNM5PryvRbhga3J3+/6MrOulGbtdWEZQQzz+XTcMgQDqsOZ3ziFNywHja1DKiEBPg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751397254; c=relaxed/simple;
	bh=XYN3mzgdO/2luMn1U6HxRQ5T0E1xv80oyWqd6OuQ5Ek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jeBRJKGmdcRhc7o15Ir0dNUMJQhb6IIL8ucgL1xUfYFOJVkKQ38StICaNaPdUO1LIbwQ1kYLb9Ok7T16Qu3z6iLe0jUqinCY+2qLawbXq68PnM0mT3Bu2ZQ8suw+CieksYVi2OCxx9pGKCtwRV75KyRX0mARCNXOXeCpunGkuXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sd7m0wAM; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sd7m0wAM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751397253; x=1782933253;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XYN3mzgdO/2luMn1U6HxRQ5T0E1xv80oyWqd6OuQ5Ek=;
  b=Sd7m0wAMGl8XCGE+ReVTZ6NVdqtn19obgX4s0vUSdxYDz69U5Tqyjw4I
   zmhHi2niG0VY7QcTx384WaRSBnaBj5CqDC/FK67LoQHAL3WQhaUq2xi/c
   BpaR4pzYvQLu3tHPK5OuTw6acjGPkjVs3iy9iwnuexVmfHmembd7ypsa/
   BYnW5nWBTU2s1l7n1/lCoUOtnODJRApLHQedsUgajTQZT9Jm311KN9VWZ
   Yr/krTE7taaTXHMWsRCCkl+7Wzg9MYbWKzy906JU7SfUDeMYexgKdS3YX
   2r4GlcfV5alXqaGJLs+2IjgAgX1XeU+Zdr7h0sqfMkyCnRJEjv49dNBFU
   A==;
X-CSE-ConnectionGUID: zV1tJXXiQQC/1geGC2yrMw==
X-CSE-MsgGUID: +SwTfH2yRuyo0B+c0byktw==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="53613005"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="53613005"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 12:14:12 -0700
X-CSE-ConnectionGUID: PkObRcHOTyWoGiQUDQ9+rA==
X-CSE-MsgGUID: YodDBZ8cRDunpR6tiykgIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154392091"
Received: from smile.fi.intel.com ([10.237.72.52])
  by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 12:14:10 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.98.2)
	(envelope-from <andriy.shevchenko@linux.intel.com>)
	id 1uWgQh-0000000Bfu8-0qFJ;
	Tue, 01 Jul 2025 22:14:07 +0300
Date: Tue, 1 Jul 2025 22:14:06 +0300
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ira Weiny <ira.weiny@intel.com>
Cc: Nathan Chancellor <nathan@kernel.org>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
Message-ID: <aGQzfh-36CnS_Jxg@smile.fi.intel.com>
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
 <6863fcb649c0d_2ff1fe29428@iweiny-mobl.notmuch>
 <20250701153820.GA3922159@ax162>
 <6864095bc5ecd_30815d2948c@iweiny-mobl.notmuch>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6864095bc5ecd_30815d2948c@iweiny-mobl.notmuch>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Tue, Jul 01, 2025 at 11:14:19AM -0500, Ira Weiny wrote:
> Nathan Chancellor wrote:
> > On Tue, Jul 01, 2025 at 10:20:22AM -0500, Ira Weiny wrote:
> > > Nathan Chancellor wrote:
> > > > After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> > > > range.h may not be implicitly included, resulting in a build error:
> > > 
> > > That said, I'm not seeing this issue.  What config caught this?
> > 
> > Fedora's aarch64 configuration [1] is where I initially noticed this.
> > Fedora's rpm site seems to be under the weather for me but I have it
> > mirrored [2] for my own test setup.
> 
> Ah, I suspected it was a non-x86 build.
> 
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> 
> Dave, I'll pull this in right now.

Thanks, I haven't seen issues and 0-day haven't given any (bad) report so far.

> > [1]: https://src.fedoraproject.org/rpms/kernel/raw/rawhide/f/kernel-aarch64-fedora.config
> > [2]: https://github.com/nathanchance/llvm-kernel-testing/raw/refs/heads/main/configs/fedora/aarch64.config

-- 
With Best Regards,
Andy Shevchenko


