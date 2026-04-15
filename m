Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC22B2DECBA;
	Wed, 15 Apr 2026 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776266322; cv=none; b=J6I6nuBQpANN2P0xsIYOdW9CXZQ5L6AjtBt3C12mDIIidV1jBYnNCY944AVDDenVjIHnQ3dKhFdx8sT4N5GPisTl+rLNqML0VDc5SXDlhc4O7nfHCtVWqvpQo3cUVi36gBHoBpn2s3rQpTSKqdrROU3V3jQrmHMubxknQhZZbaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776266322; c=relaxed/simple;
	bh=e3REa60twSDju4GhxpK9P4fAHki7XSVkaT2px3NoSNY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n0kxnicXZyx8X6F0KCwEAGYITg3r55Wrf0goIS6/i7Dtp86mUZ/uA1WyKb+UMSCzsiz3hPTOR9fBaMgjfUMh1rViw/K9w9tAE/1B2RON0aqxKm0Nh9v3FYtBfB2RqqNKXxElDEkiF2lX/YN3NCRWQN2pg+7rJi7eNy1pBwOGfJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gzyEsEdd; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gzyEsEdd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1776266321; x=1807802321;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=e3REa60twSDju4GhxpK9P4fAHki7XSVkaT2px3NoSNY=;
  b=gzyEsEdd8vF6U+aPgklsba1on7X8SIBAECQg5K41CXaXHoIkhZ5tgnn2
   23UpzPx484s+1usVnPtvKeeuWnBRraNlUwAg79rlnENsq+v2NLct6nZPw
   sEw/NVRXxIRRdUPFFo2ZI087fAYzmzkg0GlKPjlCplflT5O50swwiqsIa
   M/mBTV492j21i2p82FEzMYbM0+xC2N0FUkTbBDXpLyumFE99sq0sZOX3+
   NbUPMR0jXnBw1+wWqVNq4rx7VXSyUkf7KG/V5SuKQn4VOmMqhOIq5q/o4
   68P/rRXrbjtXjuUC+fd2Qqs5b6MFGlPnW4C5jMZEwwuiRxcnSzo8coGgJ
   A==;
X-CSE-ConnectionGUID: /ez7yT1uSEmps5qQIpeD1A==
X-CSE-MsgGUID: MTylbzSzQ+m21qVpinEO7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11760"; a="94649519"
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="94649519"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 08:18:41 -0700
X-CSE-ConnectionGUID: NMyh1FouQ5O7tJDJ8buXwQ==
X-CSE-MsgGUID: 3K+4ivnNSduieQd3Q5wQAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,179,1770624000"; 
   d="scan'208";a="226132168"
Received: from aduenasd-mobl5.amr.corp.intel.com (HELO [10.125.110.66]) ([10.125.110.66])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2026 08:18:38 -0700
Message-ID: <77a6193b-62bc-416d-8bdd-a56266df9c73@intel.com>
Date: Wed, 15 Apr 2026 08:18:37 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update Jonathan Cameron's email address
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 linux-kernel@vger.kernel.org, jic23@kernel.org,
 Davidlohr Bueso <dave@stgolabs.net>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 djbw@kernel.org, linux-cxl@vger.kernel.org, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Conor Dooley <conor@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>
Cc: linuxarm@huawei.com
References: <20260415124357.12539-1-Jonathan.Cameron@huawei.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260415124357.12539-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 4/15/26 5:43 AM, Jonathan Cameron wrote:
> Update my email address for CXL, FWCTL and Cache subsystems to use my
> kernel.org account. Also update .mailmap.
> 
> Separate patches will replace maintainers for HiSilicon specific hardware.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Applied to cxl/next
dc989bb79380

> ---
> 
> Any merge route works for this, but given there are two CXL entries,
> perhaps that one is most obvious.
> 
>  .mailmap    | 1 +
>  MAINTAINERS | 8 ++++----
>  2 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/.mailmap b/.mailmap
> index 22c5ab1c5d55..55be3163f8ea 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -419,6 +419,7 @@ John Stultz <johnstul@us.ibm.com>
>  <jon.toppins+linux@gmail.com> <jtoppins@cumulusnetworks.com>
>  <jon.toppins+linux@gmail.com> <jtoppins@redhat.com>
>  Jonas Gorski <jonas.gorski@gmail.com> <jogo@openwrt.org>
> +Jonathan Cameron <jic23@kernel.org> <jonathan.cameron@huawei.com>
>  Jordan Crouse <jordan@cosmicpenguin.net> <jcrouse@codeaurora.org>
>  <josh@joshtriplett.org> <josh@freedesktop.org>
>  <josh@joshtriplett.org> <josh@kernel.org>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index d1cc0e12fe1f..558b92f5fbc5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -6426,7 +6426,7 @@ F:	include/linux/compiler_attributes.h
>  
>  COMPUTE EXPRESS LINK (CXL)
>  M:	Davidlohr Bueso <dave@stgolabs.net>
> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Jonathan Cameron <jic23@kernel.org>
>  M:	Dave Jiang <dave.jiang@intel.com>
>  M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
> @@ -6442,7 +6442,7 @@ F:	include/uapi/linux/cxl_mem.h
>  F:	tools/testing/cxl/
>  
>  COMPUTE EXPRESS LINK PMU (CPMU)
> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Jonathan Cameron <jic23@kernel.org>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/admin-guide/perf/cxl.rst
> @@ -10539,7 +10539,7 @@ FWCTL SUBSYSTEM
>  M:	Dave Jiang <dave.jiang@intel.com>
>  M:	Jason Gunthorpe <jgg@nvidia.com>
>  M:	Saeed Mahameed <saeedm@nvidia.com>
> -R:	Jonathan Cameron <Jonathan.Cameron@huawei.com>
> +R:	Jonathan Cameron <jic23@kernel.org>
>  S:	Maintained
>  F:	Documentation/userspace-api/fwctl/
>  F:	drivers/fwctl/
> @@ -25148,7 +25148,7 @@ F:	drivers/staging/
>  
>  STANDALONE CACHE CONTROLLER DRIVERS
>  M:	Conor Dooley <conor@kernel.org>
> -M:	Jonathan Cameron <jonathan.cameron@huawei.com>
> +M:	Jonathan Cameron <jic23@kernel.org>
>  S:	Maintained
>  T:	git https://git.kernel.org/pub/scm/linux/kernel/git/conor/linux.git/
>  F:	Documentation/devicetree/bindings/cache/

