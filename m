Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26939400E1F;
	Mon,  6 Jul 2026 18:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783361450; cv=none; b=EFTpHhBtLBRbFmbyQpWn8BXGp0x1phC87oijGsT68fwD3aRs4Nr/HLU2DRIGGgr+t77hYsArb0RmXS8YUWQF0qaKVRsS/O44OlrVos0W9ndU2wlpDsGhVWqFIBYs0F0swh9L+TQrJHcFoqIM7XEo3VlTROZv5yBHjD2PQRXE5Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783361450; c=relaxed/simple;
	bh=cZylIpFjPYXD5YWCgz0Te7s0cm7VrMziO7tGsH5esms=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IK7E/zmdfBOD9MugEA3lwX85aWdHJzcU55SOAlnO9AEw8bpfjoufnEtpTpIC89R42zamTVeQjU1PZuyTriYYWCPxg/o3x8HzMj3KpYvACE7A6ZJGCmxhEVeSDqV2qQPajNZ1mnS8a8wc1HWFyFBLjXx9QiiofM74gQ9Gb8HSIuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H902nuq7; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H902nuq7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1783361449; x=1814897449;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cZylIpFjPYXD5YWCgz0Te7s0cm7VrMziO7tGsH5esms=;
  b=H902nuq7/4N86J2oMVOO5I43RlCsnKIDXcokr1SvWwoBbpqLYeh+elFv
   Uq1DyrrNrrug9QiSVGPik4RvqDtZrulEM2hQRUXPyBmsKeB/iZl6LFyo1
   iaQB/xYjeFO9r6nB6s5aZOCQ8q2KVZdJE2lH6E9HMTAkyU7I0tDTMfApY
   AorHz6lGFfIgZ9oNoMcYQy2i2/KCppsoRlf7Ap43SDSRrJeeu5OoKGAol
   WwMMte02NmegiN7P0Hwm+WROOnYkI8swnDTqv/4/2jBi/MH8LDfFfS0Nu
   UFWgfCxz4u6v5JzukP6ivjS/wHPG5bxz1ayvmILshYl+FT7N4/Ms2djGK
   A==;
X-CSE-ConnectionGUID: uupzXXiDT8OyVQdMyQIIRQ==
X-CSE-MsgGUID: KYwxji61Ra+E8vtLCbdo7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="94649881"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="94649881"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 11:10:48 -0700
X-CSE-ConnectionGUID: n+ReRpJNThaavuyjaUux0w==
X-CSE-MsgGUID: TgkMcBRWTD6iAljQCa9GWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; 
   d="scan'208";a="250435443"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.202]) ([10.125.110.202])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2026 11:10:47 -0700
Message-ID: <b2170b62-66c3-4cdc-8f9d-514a9cb049dd@intel.com>
Date: Mon, 6 Jul 2026 11:10:46 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Fix spelling typo in asynchronous event string
To: Praveen Rajendran <praveenrajendran2009@gmail.com>, dave@stgolabs.net,
 jic23@kernel.org, alison.schofield@intel.com, vishal.l.verma@intel.com,
 djbw@kernel.org
Cc: iweiny@kernel.org, ming.li@zohomail.com, linux-cxl@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260703145250.3953-1-praveenrajendran2009@gmail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260703145250.3953-1-praveenrajendran2009@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/3/26 7:52 AM, Praveen Rajendran wrote:
> Correct a user-facing spelling mistake in the CXL memory error logging
> macro array where "occurred" was misspelled as "occured".
> 
> Signed-off-by: Praveen Rajendran <praveenrajendran2009@gmail.com>

Hi Praveen, this is a duplicate [1] that was already applied to cxl/next.

[1]: https://lore.kernel.org/linux-cxl/20260624122835.5656-1-alhouseenyousef@gmail.com/



> ---
>  drivers/cxl/cxlmem.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ed419d0c59f2..503ae2864591 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -183,7 +183,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>  	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
>  	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
>  	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
> -	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
> +	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
>  	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
>  	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
>  	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\

