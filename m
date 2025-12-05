Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBB63B8D7F;
	Fri,  5 Dec 2025 21:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764969029; cv=none; b=Dzh987iKs1+5ywkvI/XS2gzv/mSfKjVZoyOiMEIHcOY9G6gt+eDudDVTocPHzon0M+zSjViZ4E9zQIhRzUWxWQzfCVczbaAk8YRaYDR8q9QrhGUp7uxUB4/qVBdlPwIxzUY6OZRqKm/rjbj2V/SQBnUqw6md1JHRrLA96HVUnIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764969029; c=relaxed/simple;
	bh=/Lzw/0WHPxYIZMgTbKlHGEtgM+U9Q+2Jv2Io/5Wtd8M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KiCzx3fvDew1iNDY3CFXn0ne1+jqis6OldoINXS9MMuUycsTeqCKKqKGuRqLqFh4PyT/Y/UZRUmmDttjwBxtphJew4pbqNR8/RoXK0n0SGHKLkSq1p3Tx2SXTxpFbuodVUfRQyKzo7NRhCirDwLSMjrISgrOm9U4aX2XgKerzGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=grMT/jXm; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="grMT/jXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764969028; x=1796505028;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=/Lzw/0WHPxYIZMgTbKlHGEtgM+U9Q+2Jv2Io/5Wtd8M=;
  b=grMT/jXmK1oglCYIr1GXkxlPE3RA20uCskPsedw7ssbLjwhwoJQj1hjF
   Dccdyy9delUC8GH5gGWuB65ZOvYHplezBT+8osbKuWUZOJMwmuYawHdFY
   Kla1JG2K0khGz6EqIaoECDlqyGFy5i4f4OESQKFtmaKByNZ0e052ioqIh
   hF6kwQYpb0pEQXkjN63aGqNMx5G0mh+Z34k48tyCULnppg6+hgCUKy08W
   bBrkuBFzOso/mGsGSFkN5b+zvTD8vJHnqA8KxyLvzGsPmaTP+d9934Vez
   CirhBfgpk/xexhAbxNE4jonA4zcB2CNgURXAbREO3NPyE0oy09k+wvThP
   w==;
X-CSE-ConnectionGUID: K+UhZxq0Qt6kXm+zkGBdkw==
X-CSE-MsgGUID: M++Ser/oR7GJBoZ6wSZVCQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11633"; a="84612625"
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="84612625"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:10:27 -0800
X-CSE-ConnectionGUID: qaFoeqybS626Yh/nDE8X4A==
X-CSE-MsgGUID: agts4j3bRFizicWbkxFQmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,252,1758610800"; 
   d="scan'208";a="195833170"
Received: from tjmaciei-mobl5.ger.corp.intel.com (HELO [10.125.108.160]) ([10.125.108.160])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2025 13:10:27 -0800
Message-ID: <1a745d27-6ad4-4778-bb4f-0fcdbd1af17e@intel.com>
Date: Fri, 5 Dec 2025 14:10:25 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl/pci: Fixed typo in Kconfig help text
To: Swarag V S <swaragvs09@gmail.com>, dan.j.williams@intel.com
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20251205195524.2454-1-swaragvs09@gmail.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251205195524.2454-1-swaragvs09@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/5/25 12:55 PM, Swarag V S wrote:
> The help text for CXL_PCI incorrectly uses 'Device's' (possessive)
> 
> instead of 'Devices' (plural). Fixed the grammar.
> 
> Signed-off-by: Swarag V S <swaragvs09@gmail.com>

Thanks Swarag!
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Hi Dan and CXL team,
> This is a small grammar fix for the CXL Kconfig and my first open source contribution.
> Found this small grammar typo while reading the documentation for my seminar>
> Hope it helps!
> 
>  drivers/cxl/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 48b7314af..78b39b3c5 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -24,7 +24,7 @@ config CXL_PCI
>  	default CXL_BUS
>  	help
>  	  The CXL specification defines a "CXL memory device" sub-class in the
> -	  PCI "memory controller" base class of devices. Device's identified by
> +	  PCI "memory controller" base class of devices. Devices identified by
>  	  this class code provide support for volatile and / or persistent
>  	  memory to be mapped into the system address map (Host-managed Device
>  	  Memory (HDM)).

