Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DFB1B3F0A
	for <linux-cxl@vger.kernel.org>; Wed,  5 Jun 2024 12:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717589922; cv=none; b=M96LHpgX/CLaACmVuHgpA3mnwPsFpWCy0IaxQhT7K1kSQsDmDJhQhAgF3wuKjryiX4c3gUEv5hgkD5sheu4HfKRDvrzxM8OaSVFI89t9VUOzUcB+UBP5IecK18Qnkj6NUWcw6LsY1fMw55jrxzZvMzejQ1o3rVoZjQ1f3Mo7vRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717589922; c=relaxed/simple;
	bh=p9pv9o4jFvIqa7yDDK0CN7ZOAi8yJlR+sVFZ5mfCyGo=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7y85cmugk5UVG+jMOE2GvdtSjGMyQRBpt+IjcwngU+LIV5Ieq0DOILBTpy9LIpAUhrFSbpjC1h+CuYI2ppMrZl93kS1NtpuOC6oOcCoNq2u7rAV/IjtJnTYxQSvtXO+HAzq0+vc3AP1Z1QooQnWLdrzpEyMmRPlDECpPmPx8wU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VvRKx4qyzz6K9bs;
	Wed,  5 Jun 2024 20:17:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9E6DB140B55;
	Wed,  5 Jun 2024 20:18:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 5 Jun
 2024 13:18:36 +0100
Date: Wed, 5 Jun 2024 13:18:35 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Fix null pointer dereference in region
 lookup
Message-ID: <20240605131835.00000048@Huawei.com>
In-Reply-To: <20240605021928.223287-1-alison.schofield@intel.com>
References: <20240605021928.223287-1-alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue,  4 Jun 2024 19:19:28 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_dpa_to_region() looks up a region based on a memdev and DPA.
> It wrongly assumes an endpoint found mapping the DPA is also of
> a fully assembled region. When not true it leads to a null pointer
> dereference looking up the region name.
> 
> BUG: kernel NULL pointer dereference, address: 0000000000000050
> RIP: 0010:__cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
> Call Trace:
>  <TASK>
>  ? show_regs+0x5f/0x70
>  ? __die+0x1f/0x70
>  ? page_fault_oops+0x14b/0x430
>  ? __cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
>  ? search_exception_tables+0x5b/0x60
>  ? fixup_exception+0x22/0x300
>  ? kernelmode_fixup_or_oops.constprop.0+0x5a/0x70
>  ? __bad_area_nosemaphore+0x166/0x230
>  ? up_read+0x43/0x90
>  ? bad_area_nosemaphore+0x11/0x20
>  ? do_user_addr_fault+0x2cb/0x6b0
>  ? find_held_lock+0x31/0x90
>  ? exc_page_fault+0x6e/0x220
>  ? asm_exc_page_fault+0x27/0x30
>  ? __cxl_dpa_to_region+0x8c/0xc0 [cxl_core]
>  ? __cxl_dpa_to_region+0x35/0xc0 [cxl_core]
>  ? __pfx___cxl_dpa_to_region+0x10/0x10 [cxl_core]
>  device_for_each_child+0x4a/0x70
>  cxl_dpa_to_region+0x61/0x70 [cxl_core]
>  cxl_inject_poison+0xde/0x1e0 [cxl_core]
>  cxl_debugfs_poison_inject+0x9/0x10 [cxl_mem]
> 
> This appears during testing of region lookup after a failure to
> assemble a BIOS defined region or if the lookup raced with the
> assembly of the BIOS defined region.
> 
> Failure to clean up BIOS defined regions that fail assembly is an
> issue in itself and a fix to that problem will alleviate some of
> the impact. It will not alleviate the race condition so let's harden
> this path.
> 
> The behavior change is that the kernel oops due to a null pointer
> dereference is replaced with a dev_dbg() message noting that an
> endpoint was mapped.
> 
> Additional comments are added so that future users of this function
> can more clearly understand what it provides.
> 
> Fixes: 0a105ab28a4d ("cxl/memdev: Warn of poison inject or clear to a mapped region")
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

This simplified version works for me so keep the tag... However given the spirit of
the patch changed rather a lot would have been reasonable to drop the RB.

> ---
> 
> Changes in v2:
> - emit endpoint dev_dbg() message only, rm cxlr-ness (Dan)
> - rm redundant null cxled check (Dan)
> - add stack trace to commit log (Dan)
> - s/Avoid/Fix in commit msg (Dan)
> - add Reviewed-by Tag (Jonathan)
> 
>  drivers/cxl/core/region.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..d9819650c529 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2700,9 +2700,13 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
>  		return 0;
>  
> -	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> -		dev_name(&cxled->cxld.region->dev));
> -
> +	/*
> +	 * Stop the region search (return 1) when an endpoint mapping is
> +	 * found. The region may not be fully constructed so offering
> +	 * the cxlr in the context structure is not guaranteed.
> +	 */
> +	dev_dbg(dev, "dpa:0x%llx mapped in endpoint:%s\n", dpa,
> +		dev_name(dev));
>  	ctx->cxlr = cxled->cxld.region;
>  
>  	return 1;
> 
> base-commit: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1

