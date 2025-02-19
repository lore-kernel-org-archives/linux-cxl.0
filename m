Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0E081E00BE;
	Wed, 19 Feb 2025 18:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739989360; cv=none; b=Yqnx9x3zFF5hCPDJ0oN+apDI1dd4xyJ8bp8+TQB+VlarxNJkaz8MuIzTzOXX2i4kKLtyJezNuJR0CY9cLb1/CRHmbRzdGgl7JHX7XkG/gZjgFnmoplpNgcQ8/2xIXR9cm2d8c+pIE44501PcDGxh/ykjkuYMHTWD/YxiJRtVjXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739989360; c=relaxed/simple;
	bh=OtN+nCWP028c9YxfywswpvvIGJdMDwAWAFWstnJzWSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P7pe+bsryBlGCxekmRc5QSjZ7hRhsZ9IkB3G8V7ILdSXGZWlqECI462DGt1cmntQ5jLmK/rEOvVKjfQxN3UEYBnHdGGdRh2pdlwexuxc3CzhpdBJBdsPdTeq+0OeMEqCgrQecJBcuFqOR6cNFeF7TlTWJ0hqLKT4GdKWWkrws1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nuZn63/z; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nuZn63/z"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739989359; x=1771525359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OtN+nCWP028c9YxfywswpvvIGJdMDwAWAFWstnJzWSo=;
  b=nuZn63/zD+WxUxKpagQhx71wG8CwbSh7larvziaT1Yp/WpTjkAgjH4oj
   uVwO9Ks1m9bhanQUavvHMnWhrOlgPPUiijn57f3Qedbk31cMZUO9oPfQ3
   X9V0PZp7IEJ3FXE4klLyxxs71yglW/sLP0eOm0/OzAMpYW9sY5lPLEUzp
   lzN6EFVYES5POiq8sxGWhuk2UNIkZS7Kf1045FFFIuejbI2KiOoOPjFET
   A0oDu5qDeQiZbziolcXDbY8X+injbduBdE5i2W4MheyIYDpNxnkHH6/cZ
   D5MTHY24pzB3hw2IK4fim1Z3952K8eq1I4Qvyt6qBzQIV9MsPSoOCMsP9
   g==;
X-CSE-ConnectionGUID: Ye12EBKHQy2HKY+Rk54SDg==
X-CSE-MsgGUID: qgR3+6TzQwmkMfes3dCVhw==
X-IronPort-AV: E=McAfee;i="6700,10204,11350"; a="51724999"
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="51724999"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 10:22:35 -0800
X-CSE-ConnectionGUID: XeMIevMRSUGZ1op/Ozhpow==
X-CSE-MsgGUID: r4wdCU9qSFqeQ35RoVYvuQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,299,1732608000"; 
   d="scan'208";a="119907804"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2.lan) ([10.125.110.15])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Feb 2025 09:34:14 -0800
Date: Wed, 19 Feb 2025 09:34:05 -0800
From: Alison Schofield <alison.schofield@intel.com>
To: Li Ming <ming.li@zohomail.com>
Cc: dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
	vishal.l.verma@intel.com, ira.weiny@intel.com,
	dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] cxl/core: cxl_mem_sanitize() cleanup
Message-ID: <Z7YWDfB5iOSeVd1C@aschofie-mobl2.lan>
References: <20250217144828.30651-1-ming.li@zohomail.com>
 <20250217144828.30651-3-ming.li@zohomail.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217144828.30651-3-ming.li@zohomail.com>

On Mon, Feb 17, 2025 at 10:48:23PM +0800, Li Ming wrote:
> In cxl_mem_sanitize(), the down_read() and up_read() for
> cxl_region_rwsem can be simply replaced by a guard(rwsem_read), and the
> local variable 'rc' can be removed.
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/mbox.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

snip

