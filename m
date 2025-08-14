Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 269EE2D6407;
	Thu, 14 Aug 2025 16:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755187633; cv=none; b=i0hLcLNFDuMHsAjlg6+23yATei+KNIf0yyaG8aE56VQGwPZsoU4AMjn9RqPA5qAcFZOvv82BSXCi6mh92TuoCfjLd6wUlXGhDPH1nSp46zdXcAig7CKIQOdidvlh6/pdMDrSJlelke4DGS4CNS1Tyr9n3Y8OUg020Y1eYRKtwHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755187633; c=relaxed/simple;
	bh=vG/qEKEpCZUZKsXkxVaanRomBpekziB+YRxHWgLrWI0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fZy+4jJTtegXtJLGFvp9NhaYc5LNmnhFTyNi2DORuk+tteCedQsi08YV8JZxyNAHZKjI0ybCgFXSb67DXilMwk59nELw/H5CDz3B6a7ICp+2mO+cH+ds3nlSylToJWBAvdniZuo+cUUNjODk59e81zRPIfQ9aJda6WGv1/DjNZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L3a4ERY5; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L3a4ERY5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755187632; x=1786723632;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=vG/qEKEpCZUZKsXkxVaanRomBpekziB+YRxHWgLrWI0=;
  b=L3a4ERY5x62n9oPfRUcL4jDXmr5vxWN+Wtym0eYSHNNxOLGn4H0hjmWP
   bRwFn0pec5UKhEUHHX3sAU2bMa86zMEbysxBVxuq9H4WlJTVc5WQD6Fa/
   suMnat5iMBR0oQaIKo+tU+M9moBz8LVH2O2Hg3on6tHTLddmIasno9GFq
   SQrHrGJaS2bT2r6VTbcL6Kx7+WZRVM0M01oyYqv80rdRbysD8eVKqtgd3
   KyC1SguLiIH6L9wlQXMpN+dv6YkxbU1fIRZeuAr+01NOHlFM51lkoVDvb
   20TBQ+HNSC374xY6XjCcmVEbG1SI8aRva1MxbScwSK3vaK/Y3gpWij9Au
   A==;
X-CSE-ConnectionGUID: +eRZjzjVRqKRCWWdradtKQ==
X-CSE-MsgGUID: eKI51XkrS4yG/q0aOzFDRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11522"; a="68208578"
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="68208578"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:07:11 -0700
X-CSE-ConnectionGUID: XKwl5ZwpR/eOvQm+LOwh9w==
X-CSE-MsgGUID: i2DLUQVrTfCuoOh9/S7xkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,287,1747724400"; 
   d="scan'208";a="166767403"
Received: from anmitta2-mobl4.gar.corp.intel.com (HELO [10.247.119.169]) ([10.247.119.169])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2025 09:07:04 -0700
Message-ID: <18b2a030-f607-4a6c-bd55-b704a06c6948@intel.com>
Date: Thu, 14 Aug 2025 09:06:58 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Documentation: Fix driver-api typos
To: Ranganath V N <vnranganath.20@gmail.com>, corbet@lwn.net,
 linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
 linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com,
 dave@stgolabs.net, rafael@kernel.org, linux-kernel-mentees@vger.kernel.org,
 skhan@linuxfoundation.org, vishal.l.verma@intel.com
References: <20250814114245.16399-1-vnranganath.20@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250814114245.16399-1-vnranganath.20@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 8/14/25 4:42 AM, Ranganath V N wrote:
> Corrected a few spelling mistakes
> 
> - functionalty ==> functionality
> in Documentation/driver-api/cxl/devices/device-types.rst
> 
> - adjascent ==> adjacent
> in Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> 
> - succeessful ==> successful
> in Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> 
> Signed-off-by: Ranganath V N <vnranganath.20@gmail.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  Documentation/driver-api/cxl/devices/device-types.rst           | 2 +-
>  .../cxl/platform/example-configurations/one-dev-per-hb.rst      | 2 +-
>  Documentation/driver-api/thermal/exynos_thermal_emulation.rst   | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/Documentation/driver-api/cxl/devices/device-types.rst b/Documentation/driver-api/cxl/devices/device-types.rst
> index 923f5d89bc04..7f69dfa4509b 100644
> --- a/Documentation/driver-api/cxl/devices/device-types.rst
> +++ b/Documentation/driver-api/cxl/devices/device-types.rst
> @@ -22,7 +22,7 @@ The basic interaction protocol, similar to PCIe configuration mechanisms.
>  Typically used for initialization, configuration, and I/O access for anything
>  other than memory (CXL.mem) or cache (CXL.cache) operations.
>  
> -The Linux CXL driver exposes access to .io functionalty via the various sysfs
> +The Linux CXL driver exposes access to .io functionality via the various sysfs
>  interfaces and /dev/cxl/ devices (which exposes direct access to device
>  mailboxes).
>  
> diff --git a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> index aebda0eb3e17..a4c3fb51ea7d 100644
> --- a/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> +++ b/Documentation/driver-api/cxl/platform/example-configurations/one-dev-per-hb.rst
> @@ -10,7 +10,7 @@ has a single CXL memory expander with a 4GB of memory.
>  Things to note:
>  
>  * Cross-Bridge interleave is not being used.
> -* The expanders are in two separate but adjascent memory regions.
> +* The expanders are in two separate but adjacent memory regions.
>  * This CEDT/SRAT describes one node per device
>  * The expanders have the same performance and will be in the same memory tier.
>  
> diff --git a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> index c21d10838bc5..f77d27c25ce2 100644
> --- a/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> +++ b/Documentation/driver-api/thermal/exynos_thermal_emulation.rst
> @@ -32,7 +32,7 @@ Exynos emulation mode requires synchronous of value changing and
>  enabling. It means when you want to update the any value of delay or
>  next temperature, then you have to enable emulation mode at the same
>  time. (Or you have to keep the mode enabling.) If you don't, it fails to
> -change the value to updated one and just use last succeessful value
> +change the value to updated one and just use last successful value
>  repeatedly. That's why this node gives users the right to change
>  termerpature only. Just one interface makes it more simply to use.
>  

