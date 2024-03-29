Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 821F71C0DF8
	for <linux-cxl@vger.kernel.org>; Fri, 29 Mar 2024 18:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711736043; cv=none; b=EVeGAPDgVOggO8qxlYtWsdxCmG20GqTtIrHnhTLWWXhaHgG5RUfv2aLv5lIzTsdiGTYCTImeXgNUKzzfXbzF4g9pJdUAXd604IpjyIIp2K1415qLEwhgmTPmTQsK7eHv5Kbd6GXkZFWrbfqRsv2GKlExSaWnfR9CJCrlTEkePIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711736043; c=relaxed/simple;
	bh=spDdkp5at93t5uLpTXXyW7vLLkVTjvAI4OLZ+91XLjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FH+9xKi3y5RYW0sFtWqZWxJRBEAi8Hnn8+FUKNTqqGPcLFppd5yLxJyFonundUSA42FxqtI4DsHBdwUUz/j4yibphGeBDFNNoEag3LBshyNVDFi9M13dYZAC/zn12LXInlUuZNcA0NHMd2eXQW6v/8NA8h7avqHkBMVHLjNHvI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Gf0M0pUB; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Gf0M0pUB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711736040; x=1743272040;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=spDdkp5at93t5uLpTXXyW7vLLkVTjvAI4OLZ+91XLjg=;
  b=Gf0M0pUBAGq4kCHXfTcofUdjxp5v4X2s8Tat5xKvk2Ye6jrPV3j1xPcx
   qXvQVGMYGZVy7CRXEXKhBiaI9cM9nf4mMp44v0kqTBI/6qJFQ7AaDWT3M
   n5y9mBGlzDzcsmj1uoZsGKWvhgKfheKZvHUIDYfOYv8kdwqI/2c8Hya4S
   Kd4xKuxesRBlEvtWPi+eF0ABV3Hxjg43NHaUFT9fQb1Sos0uMxr7XkFT1
   XsiKwq8EOqdj62w4qH8s22//W6vP3l5xxj7flHG9Ar9TL7QkMEtYFQ+Ai
   jWLFpwIxNGdU6J/9VC0pjZoMutHtczzAxUtck3cXtT6uj01GLT5Oq+/S9
   w==;
X-CSE-ConnectionGUID: lWA4Xg8tQUCgvPPSjBhkIg==
X-CSE-MsgGUID: 0UbyiL0FRV+qX3/nFt95CQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="7151660"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="7151660"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:13:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="48245285"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.86.126])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 11:13:17 -0700
Date: Fri, 29 Mar 2024 11:13:15 -0700
From: Alison Schofield <alison.schofield@intel.com>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
	Jonathan.Cameron@huawei.com, dan.j.williams@intel.com,
	dave@stgolabs.net, ira.weiny@intel.com
Subject: Re: [RFC PATCH v2 4/6] cxl/core: report poison when injecting from
 debugfs
Message-ID: <ZgcEu9q/k+jjojOj@aschofie-mobl2>
References: <20240329063614.362763-1-ruansy.fnst@fujitsu.com>
 <20240329063614.362763-5-ruansy.fnst@fujitsu.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240329063614.362763-5-ruansy.fnst@fujitsu.com>

On Fri, Mar 29, 2024 at 02:36:12PM +0800, Shiyang Ruan wrote:
> Poison injection from debugfs is silent too.  Add calling
> cxl_mem_report_poison() to make it able to do memory_failure().

Curious as to why it is silent? Will a GMER poison event occur
and trigger the path to report it via memory_failure?

> 
> Signed-off-by: Shiyang Ruan <ruansy.fnst@fujitsu.com>
> ---
>  drivers/cxl/core/memdev.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index e976141ca4a9..b0dcbe6f1004 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -366,6 +366,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.length = cpu_to_le32(1),
>  	};
>  	trace_cxl_poison(cxlmd, cxlr, &record, 0, 0, CXL_POISON_TRACE_INJECT);
> +	cxl_mem_report_poison(cxlmd, cxlr, &record);
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  	up_read(&cxl_region_rwsem);
> -- 
> 2.34.1
> 
> 
