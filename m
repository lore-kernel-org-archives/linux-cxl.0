Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA6C277003;
	Tue,  1 Jul 2025 15:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751382628; cv=none; b=h7gBvLtzF2HV9fo/GUcnVpHf4nEDUTWXdravC1rvl5mAfvYr2dYx3bUB+/loDZl2iI9Eh8fzFNJDFqTly/rKB2vY4P5SsAbsnoXV4SZa+YVDITUwaIkzACopa4AtMm7zIYq0pcj+2DzKHk05Nvg3FjbaRRl2dfgMQNv5vsLjKN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751382628; c=relaxed/simple;
	bh=UEFXMJt/nGdIIFadpnH+P1LGInf/zQ7wlDBDfdGZ4fA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ghUyVkANc1RAxcABydBGz8e7ufEHWvjFWU4JvOdEYqRvsAXbuIPg6XqAJkr8xF6WxK6MXtyX5tfNE3LzpIxW6WwCNHBozvv1Elt4UkKQhUgDBe491mOZHrw7PB11Zk1Xhq0yjmoZKlAVU34Ev9NgyG+x+/AJzD1+dqumfRE9JFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NHtz7CME; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NHtz7CME"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751382627; x=1782918627;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=UEFXMJt/nGdIIFadpnH+P1LGInf/zQ7wlDBDfdGZ4fA=;
  b=NHtz7CMEuTudibWzM6smL/5BhL3k6SjRHgmVNMk+ZE60Hs/Vh2HNroNW
   r8X2tuI112pG+EiawMtYI9p6m4/JOtYq+wNDmtirOw0jfK9CfIppLotW7
   APCqJwUlGNi0875hVvmOQz2B5IiRpr2hHox1aJhsnZEc0ziHq86XZVmJG
   NSyRTPNk+qDuuK6Up8OPQzURyN39VsO7JObjNZLqvj7ayZKN55itUXXIg
   x2kHtyoSQqwJdqFA5QD/mDLW3kCGcxTKx4ANiyWX5DUd5YElVoZUoAfKC
   kWt9qQ72n1ZYbqiICEta7uB4XPNyG9nDx6owK7sIaiyFR1xSYB/UaQ81A
   g==;
X-CSE-ConnectionGUID: DoS5FjjvRtKvZzSFbkW5/g==
X-CSE-MsgGUID: hY41UDhVSUuz4FQTCSB8pA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="52886331"
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="52886331"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:10:26 -0700
X-CSE-ConnectionGUID: hCY58xRZRTqCwnGYWmtzCA==
X-CSE-MsgGUID: hPVjltUNQ1SC1pH6+IwLNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,279,1744095600"; 
   d="scan'208";a="154114506"
Received: from puneetse-mobl.amr.corp.intel.com (HELO [10.125.109.179]) ([10.125.109.179])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2025 08:10:25 -0700
Message-ID: <420c5e4a-2d33-4751-a685-ecc94c1463c3@intel.com>
Date: Tue, 1 Jul 2025 08:10:24 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cxl: Include range.h in cxl.h
To: Nathan Chancellor <nathan@kernel.org>, Davidlohr Bueso
 <dave@stgolabs.net>, Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alison Schofield <alison.schofield@intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>,
 Dan Williams <dan.j.williams@intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20250701-cxl-fix-struct-range-error-v1-1-1f199bddc7c9@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 7/1/25 7:33 AM, Nathan Chancellor wrote:
> After commit aefeb286b960 ("libnvdimm: Don't use "proxy" headers"),
> range.h may not be implicitly included, resulting in a build error:
> 
>   In file included from drivers/cxl/core/features.c:8:
>   drivers/cxl/cxl.h:365:22: error: field 'hpa_range' has incomplete type
>     365 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:562:22: error: field 'hpa_range' has incomplete type
>     562 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:570:22: error: field 'hpa_range' has incomplete type
>     570 |         struct range hpa_range;
>         |                      ^~~~~~~~~
>   drivers/cxl/cxl.h:803:22: error: array type has incomplete element type 'struct range'
>     803 |         struct range dvsec_range[2];
>         |                      ^~~~~~~~~~~
> 
> Include range.h in cxl.h explicitly to clear up the errors.
> 
> Fixes: aefeb286b960 ("libnvdimm: Don't use "proxy" headers")
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/cxl.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3f1695c96abc..b941ff94fe0a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -11,6 +11,7 @@
>  #include <linux/log2.h>
>  #include <linux/node.h>
>  #include <linux/io.h>
> +#include <linux/range.h>
>  
>  extern const struct nvdimm_security_ops *cxl_security_ops;
>  
> 
> ---
> base-commit: aefeb286b960a0629273d1dc809ea36754f42d98
> change-id: 20250701-cxl-fix-struct-range-error-8475cbbf3358
> 
> Best regards,
> --  
> Nathan Chancellor <nathan@kernel.org>
> 
> 

