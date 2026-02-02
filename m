Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F543101C8;
	Mon,  2 Feb 2026 21:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770066294; cv=none; b=cTW3I0dBUi/KBzr2aBCtuRlYc/o6l8Hsaac4hVY+oKGMqlLY58OrapDP5OoKIdkU+oWpWwpoAENs8vQyV0kQKBQZuRRkQoI8Scl/6kmeo9GXx9FMkjXbr1eKrxoW95GkuPjQBZ3lh+mw1U+8RMJ4EfjvVq1udmaPPQhvKLj5YF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770066294; c=relaxed/simple;
	bh=NH7M5AJhrWHuXu1rMJ0asRpHua7M5f2QKVNLE7wx2Cc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HI/71zH7pcAOby/yi7IewYVsO54XB8zbedEIi6zh7lVfbfQtgrShH4LjFaL+GEUjet5fwUPMr+Gx50W1g1qRFXkCbS1C0aE78FLUKf034syxa6trwwdxIt8kAslz6xYcDndXWkwb+PPIEgMwD5wtipBWugJL625V6ayqAp8yPhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PLD1/yET; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PLD1/yET"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1770066287; x=1801602287;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=NH7M5AJhrWHuXu1rMJ0asRpHua7M5f2QKVNLE7wx2Cc=;
  b=PLD1/yETtnPYFtnmeuLrZd+LEtgslm6eUKAfm2pdwI2yEQ9uBwKdxMKq
   vzKEHHBbsyEbuUueOXkHS5XkmtEAcCNzpGBW4KFYYuWwQHuKDcS13X6z5
   ubOhlKyZXtPvv6M8UUT9/+R8eAoKnkCxrXuZiGg4iByVYUiu5sCZxnju1
   n9I5bK72JAy38cSj0g0nOKmHTw6Xfs2qjuTfzArY0A/U4Osb+QY53X7X0
   DyvzFYjmzoHjpHnvnWecNL8yleC7Pybt7FSaXOhANicAcuyZqN8CBnBQ6
   PZhUEsStdaMOizK/cb570dKsk+vVYAcYoBJjz2aOXWpnFKxKZtFll2NeI
   w==;
X-CSE-ConnectionGUID: Z4e3ERwgRb23nehhkjsApA==
X-CSE-MsgGUID: EAP8xEDNT+G/SR715ASZcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11690"; a="93886434"
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="93886434"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 13:04:46 -0800
X-CSE-ConnectionGUID: JGOpS9ECRP+cVaCoIE2FWQ==
X-CSE-MsgGUID: wbs5KFfsQ7S4w5cUTn3/9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,269,1763452800"; 
   d="scan'208";a="209857579"
Received: from sghuge-mobl2.amr.corp.intel.com (HELO [10.125.110.162]) ([10.125.110.162])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2026 13:04:45 -0800
Message-ID: <f7bae850-b9de-4d6c-bd8d-914cae90e7cc@intel.com>
Date: Mon, 2 Feb 2026 14:04:44 -0700
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] cxl/core: Set cxlmd->endpoint to NULL by default
To: Li Ming <ming.li@zohomail.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 vishal.l.verma@intel.com, ira.weiny@intel.com, dan.j.williams@intel.com
Cc: linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260201093002.1281858-1-ming.li@zohomail.com>
 <20260201093002.1281858-2-ming.li@zohomail.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260201093002.1281858-2-ming.li@zohomail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 2/1/26 2:30 AM, Li Ming wrote:
> CXL testing environment can trigger following trace
> 
>  Oops: general protection fault, probably for non-canonical address 0xdffffc0000000092: 0000 [#1] SMP KASAN NOPTI
>  KASAN: null-ptr-deref in range [0x0000000000000490-0x0000000000000497]
>  RIP: 0010:cxl_dpa_to_region+0x105/0x1f0 [cxl_core]
>  Call Trace:
>   <TASK>
>   cxl_event_trace_record+0xd1/0xa70 [cxl_core]
>   __cxl_event_trace_record+0x12f/0x1e0 [cxl_core]
>   cxl_mem_get_records_log+0x261/0x500 [cxl_core]
>   cxl_mem_get_event_records+0x7c/0xc0 [cxl_core]
>   cxl_mock_mem_probe+0xd38/0x1c60 [cxl_mock_mem]
>   platform_probe+0x9d/0x130
>   really_probe+0x1c8/0x960
>   __driver_probe_device+0x187/0x3e0
>   driver_probe_device+0x45/0x120
>   __device_attach_driver+0x15d/0x280

So I talked to Dan and the assigning of ERR_PTR(-ENXIO) is from a previous revision of implementation and isn't intended to be there. So removing the line entirely (which would mean endpoint == NULL from kzalloc) is probably the right change. However, I'm not able to reproduce the error. How is it triggered? Also, by setting it to NULL, are we covering up a different issue? Are you able to determine whether cxlmd->endpoint at that point is unexpected and perhaps triggered by a different bug?

DJ

> 
> commit 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> initializes cxlmd->endpoint to ERR_PTR(-ENXIO) in cxl_memdev_alloc().
> However, cxl_dpa_to_region() treats a non-NULL cxlmd->endpoint as a
> valid endpoint.
> 
> Across the CXL core, endpoint availability is generally determined by
> checking whether it is NULL. Align with this convention by initializing
> cxlmd->endpoint to NULL by default.
> 
> Fixes: 29317f8dc6ed ("cxl/mem: Introduce cxl_memdev_attach for CXL-dependent operation")
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index af3d0cc65138..41a507b5daa4 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -675,7 +675,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	cxlmd->id = rc;
>  	cxlmd->depth = -1;
>  	cxlmd->attach = attach;
> -	cxlmd->endpoint = ERR_PTR(-ENXIO);
> +	cxlmd->endpoint = NULL;
>  
>  	dev = &cxlmd->dev;
>  	device_initialize(dev);

