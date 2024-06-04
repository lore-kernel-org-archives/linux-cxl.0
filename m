Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBDB148FF5
	for <linux-cxl@vger.kernel.org>; Tue,  4 Jun 2024 16:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717519076; cv=none; b=B34WgS2pdAJAY9ZtI1irbOiWQrqK/38itoiGaTSluM2JFO88xZSRMkM50Nnp/EdV72nIVkCAnsjdgHIwDnkRDHB32SBygK5qlKzam7SI6lSaETsXB+t/sJkF87QQBPR7ITi1tO/gsrDglfez3kfo0qpSW2q818EbWtRUMKeXhGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717519076; c=relaxed/simple;
	bh=hXbDUe+YgGhcGu4vpJ70ZgqHlDChCBaM5sojwMnNLpc=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PCVPPStEP0qQ/AX/0TjWx6YxHbogFyCPE6a4yp4UJkhQQp21Vfakn/g23z3bSYmtMWhrT2eP05EdLnLChpN1Br0G1Zb4+B4kpVA7fZsn/UKEThf7AwFgNv5h9pftQwdsAWB8gZwpMCgYcp9TEM6Tk6btnf6I7r28yHDjPfBzm6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Vtx3y6ryQz6JBWn;
	Wed,  5 Jun 2024 00:33:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id EE55F1400D4;
	Wed,  5 Jun 2024 00:37:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 4 Jun
 2024 17:37:50 +0100
Date: Tue, 4 Jun 2024 17:37:49 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: <alison.schofield@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Dave Jiang <dave.jiang@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan
 Williams <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Avoid null pointer dereference in region
 lookup
Message-ID: <20240604173749.00002451@Huawei.com>
In-Reply-To: <20240604003609.202682-1-alison.schofield@intel.com>
References: <20240604003609.202682-1-alison.schofield@intel.com>
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
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  3 Jun 2024 17:36:09 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> cxl_dpa_to_region() looks up a region based on a memdev and DPA.
> It wrongly assumes an endpoint found mapping the DPA is also of
> a fully assembled region. When not true it leads to a null pointer
> dereference looking up the region name.
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
Nasty corner case. Fix looks correct to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 3c2b6144be23..88051bb673bf 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2688,22 +2688,33 @@ static int __cxl_dpa_to_region(struct device *dev, void *arg)
>  {
>  	struct cxl_dpa_to_region_context *ctx = arg;
>  	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_region *cxlr;
>  	u64 dpa = ctx->dpa;
>  
>  	if (!is_endpoint_decoder(dev))
>  		return 0;
>  
>  	cxled = to_cxl_endpoint_decoder(dev);
> -	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +	if (!cxled || !cxled->dpa_res || !resource_size(cxled->dpa_res))
>  		return 0;
>  
>  	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
>  		return 0;
>  
> -	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> -		dev_name(&cxled->cxld.region->dev));
> +	/*
> +	 * Stop the region search (return 1) when an endpoint mapping is
> +	 * found. The region may not be fully constructed so offering
> +	 * the cxlr in the context structure is not guaranteed.
> +	 */
> +	cxlr = cxled->cxld.region;
> +	if (cxlr)
> +		dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> +			dev_name(&cxlr->dev));
> +	else
> +		dev_dbg(dev, "dpa:0x%llx mapped in endpoint:%s\n", dpa,
> +			dev_name(dev));
>  
> -	ctx->cxlr = cxled->cxld.region;
> +	ctx->cxlr = cxlr;
>  
>  	return 1;
>  }
> 
> base-commit: 49ba7b515c4c0719b866d16f068e62d16a8a3dd1

