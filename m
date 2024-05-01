Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6884A60269
	for <linux-cxl@vger.kernel.org>; Wed,  1 May 2024 12:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564987; cv=none; b=gbasTL4aLEFTGsEoM350Ll5mpPtcQsXeWsNFMHZrOKErckC3W67xRuMRtv8tJKYWfyvxdmXqE0MW36hL3Iv2vKTOCYdzEu4WSw5JUmBIoLDqxVchxSr98LyOvsnu/jKlooz9ISHLd9cd6Pu09Bslge+G7wVooYWc775lWf8xew4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564987; c=relaxed/simple;
	bh=rQUJbT+Wdadi30I/9+k4XlMGkOxEkdIkQInQaLzStA4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k97eUsW/kJRk6RJRjoottzsXsZWHeJU36icnb4vxtqbCNGL9Tq0ht9oY3SloLjpqj/87DD9dqPiYMl8HL1P13Bd3f91VnsfULhlHm9cfgWKQ8eCEQXxr8b6u92SkeWBF/RQFZNfBujpFSsXaWVL3fTWm79QdyOuAoFcubaDxWUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VTwcD5l6cz67n5j;
	Wed,  1 May 2024 20:00:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 9DB52140B55;
	Wed,  1 May 2024 20:02:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 1 May
 2024 13:02:52 +0100
Date: Wed, 1 May 2024 13:02:51 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, Li Zhijian <lizhijian@fujitsu.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/region: Convert cxl_pmem_region_alloc to
 scope-based resource management
Message-ID: <20240501130251.0000265d@Huawei.com>
In-Reply-To: <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
References: <171451430965.1147997.15782562063090960666.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Tue, 30 Apr 2024 14:59:00 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> A recent bugfix to cxl_pmem_region_alloc() to fix an
> error-unwind-memleak [1], highlighted a use case for scope-based resource
> management.
> 
> Delete the goto for releasing @cxl_region_rwsem, and return error codes
> directly from error condition paths.
> 
> The caller, devm_cxl_add_pmem_region(), is no longer given @cxlr_pmem
> directly it must retrieve it from @cxlr->cxlr_pmem. This retrieval from
> @cxlr was already in place for @cxlr->cxl_nvb, and converting
> cxl_pmem_region_alloc() to return an int makes it less awkward to handle
> no_free_ptr().
> 
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20240430174540.000039ce@Huawei.com
> Link: http://lore.kernel.org/r/20240428030748.318985-1-lizhijian@fujitsu.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Trivial comments inline  Up to Dave or you on whether you want to act on them.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> Hey Dave, this applies on top of Li's fix.
> 
>  drivers/cxl/core/region.c |   43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 812b2948b6c6..e0577d99c4db 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2681,26 +2681,21 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  
>  static struct lock_class_key cxl_pmem_region_key;
>  
> -static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
> +static int cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
>  	struct cxl_nvdimm_bridge *cxl_nvb;
> -	struct cxl_pmem_region *cxlr_pmem;
>  	struct device *dev;
>  	int i;
>  
> -	down_read(&cxl_region_rwsem);
> -	if (p->state != CXL_CONFIG_COMMIT) {
> -		cxlr_pmem = ERR_PTR(-ENXIO);
> -		goto out;
> -	}
> +	guard(rwsem_read)(&cxl_region_rwsem);
> +	if (p->state != CXL_CONFIG_COMMIT)
> +		return -ENXIO;
>  
> -	cxlr_pmem = kzalloc(struct_size(cxlr_pmem, mapping, p->nr_targets),
> -			    GFP_KERNEL);
> -	if (!cxlr_pmem) {
> -		cxlr_pmem = ERR_PTR(-ENOMEM);
> -		goto out;
> -	}
> +	struct cxl_pmem_region *cxlr_pmem __free(kfree) = kzalloc(
> +		struct_size(cxlr_pmem, mapping, p->nr_targets), GFP_KERNEL);

That is rather ugly.  Maybe bring the kzalloc down onto the second line and
wrap the GFP_KERNEL (or just go over 80 chars)?

> +	if (!cxlr_pmem)
> +		return -ENOMEM;
>  
>  	cxlr_pmem->hpa_range.start = p->res->start;
>  	cxlr_pmem->hpa_range.end = p->res->end;
> @@ -2718,11 +2713,8 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  		 */
>  		if (i == 0) {
>  			cxl_nvb = cxl_find_nvdimm_bridge(cxlmd);
> -			if (!cxl_nvb) {
> -				kfree(cxlr_pmem);
> -				cxlr_pmem = ERR_PTR(-ENODEV);
> -				goto out;
> -			}
> +			if (!cxl_nvb)
> +				return -ENODEV;
>  			cxlr->cxl_nvb = cxl_nvb;
>  		}
>  		m->cxlmd = cxlmd;
> @@ -2733,18 +2725,16 @@ static struct cxl_pmem_region *cxl_pmem_region_alloc(struct cxl_region *cxlr)
>  	}
>  
>  	dev = &cxlr_pmem->dev;
> -	cxlr_pmem->cxlr = cxlr;
> -	cxlr->cxlr_pmem = cxlr_pmem;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_pmem_region_key);
>  	device_set_pm_not_required(dev);
>  	dev->parent = &cxlr->dev;
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_pmem_region_type;
> -out:
> -	up_read(&cxl_region_rwsem);
> +	cxlr_pmem->cxlr = cxlr;
> +	cxlr->cxlr_pmem = no_free_ptr(cxlr_pmem);
>  
> -	return cxlr_pmem;
> +	return 0;
>  }
>  
>  static void cxl_dax_region_release(struct device *dev)
> @@ -2861,9 +2851,10 @@ static int devm_cxl_add_pmem_region(struct cxl_region *cxlr)
>  	struct device *dev;
>  	int rc;
>  
> -	cxlr_pmem = cxl_pmem_region_alloc(cxlr);
> -	if (IS_ERR(cxlr_pmem))
> -		return PTR_ERR(cxlr_pmem);
> +	rc = cxl_pmem_region_alloc(cxlr);
> +	if (rc)
> +		return rc;
> +	cxlr_pmem = cxlr->cxlr_pmem;

Is the local variable worth retaining? It's only used twice.

The fact it's a clxr->cxlr* also seems rather like it could be named
in a more compact fashion inside the cxl_region.  Would pmemr
work for instance?

>  	cxl_nvb = cxlr->cxl_nvb;
>  
>  	dev = &cxlr_pmem->dev;
> 
> 

