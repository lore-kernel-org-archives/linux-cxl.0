Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7207731E845
	for <linux-cxl@vger.kernel.org>; Fri, 24 Jul 2026 14:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905106; cv=none; b=e8ZaunCxD92y3LRTJlIKqGD4i3ES1h0D62vFpi+aBSzAtej1q7CO35ZMHH793EbgUYpB1Sz+qi1csKE4OE4opVG4siRGlOjuZoFmSpSe2oXuIK/F3ypNTwkySrr4El2IkUHm7xvOV0w0PSK2GLdA1rr0/E1oi6XdloKPepniG3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905106; c=relaxed/simple;
	bh=YtNwPpLBpzxItCNix5XKiyB+aKzbV0Eq1W74WOpiZAQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FcX8MBpBuOmwLoGcGbeHV+ypRix3wQNHMtAWjoxtxur/iik6FWIe+/jEgmLAquOFLd9yfI0E39P+Dq6ket2S3wUH0K33YZO76S8d4CjJcr1b6GuPbJJPSSj/r97tpQdHFNVU8WgobMRARGib4fRRfRXnrZ9GW3Bszko7QCh6bIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iOmaTTzp; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iOmaTTzp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1784905105; x=1816441105;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=YtNwPpLBpzxItCNix5XKiyB+aKzbV0Eq1W74WOpiZAQ=;
  b=iOmaTTzpjtbowHRLRhtK3CbNhlP/FsLtiSYbCBMIi4cistrud7JxaNof
   lTr4u/UGgrafPuqiVG4qOUCIxiaDJwQFHd0vOvgoNh1FSts5WB47UVHyq
   Y6/LRy+bx3UFOl+ZSaeXg7ve5l1iOBPwiwf13FtbZ1CgcXS128CaBNgMQ
   Kyh0KVceK7rh08gfnucWWpX9EzZEFvydI+1xAJtwYQfdyAQwJOnyqCXZB
   /HcpyIFrsytK2xHsqM2Cd3JHT+NyCJIWYS+BDWndnQwxCyP7Ilhs2cnaU
   1YYy7qiUdYKSD5/oJ1PrjfCksqJTkjvW3wUYtWCMVgaSZlAfYffrdbn/P
   Q==;
X-CSE-ConnectionGUID: xHcDoYlETZK84uDKsdEBpA==
X-CSE-MsgGUID: SnDq7WCrRnO/6kNg6N19cg==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="96721613"
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="96721613"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:58:24 -0700
X-CSE-ConnectionGUID: t0iMy75NR16gRU/t7iNx6w==
X-CSE-MsgGUID: Op+a+PPaTbOrQwBrcrXO4Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,182,1779174000"; 
   d="scan'208";a="296950242"
Received: from smithj1-mobl2.amr.corp.intel.com (HELO [10.125.110.193]) ([10.125.110.193])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2026 07:58:23 -0700
Message-ID: <61395775-5603-4582-a540-0d2aa60dec94@intel.com>
Date: Fri, 24 Jul 2026 07:58:22 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] cxl: Misc sashiko fixes
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: djbw@kernel.org, dave@stgolabs.net, jic23@kernel.org,
 alison.schofield@intel.com, vishal.l.verma@intel.com
References: <20260722205303.3184787-1-dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20260722205303.3184787-1-dave.jiang@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/22/26 1:52 PM, Dave Jiang wrote:
> Several shashiko reported issues
> 1. cxl/memdev: Don't mask an earlier partition's poison query error
> 2. cxl/ras: Clear software-only TLP log fields after RCH AER copy
> 3. cxl/region: Guard against unset partition in poison_by_decoder()
> 
> 
> Dave Jiang (3):
>   cxl/region: Guard against unset partition in poison_by_decoder()
>   cxl/ras: Clear software-only TLP log fields after RCH AER copy
>   cxl/memdev: Don't mask an earlier partition's poison query error
> 
>  drivers/cxl/core/memdev.c  | 2 ++
>  drivers/cxl/core/ras_rch.c | 7 +++++++
>  drivers/cxl/core/region.c  | 3 +++
>  3 files changed, 12 insertions(+)
> 
> 
> base-commit: 1590cf0329716306e948a8fc29f1d3ee87d3989f


Ok ignore this series for now. I'm working it out with Alison and Terry to get them more organized into specific area series.
