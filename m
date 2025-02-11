Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F12D261562;
	Tue, 11 Feb 2025 17:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739295372; cv=none; b=MDiLrckPkvyovm+8RvyqAardXuk/2rWUnRt34bm/0By4y7adc4zUPjLqjukG41G51O31wXZg76XicDOr/pUH0w661bDAkFFliKrmva1c4qUm+CTdiinmfVXROY1t/2AWGerzQIO2dTltyBOz9VyBcKjK8zYoQKvS+9aZDKVf1I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739295372; c=relaxed/simple;
	bh=pA2c/4v4jIsjXDTHK2U3nVkLaip9cFt3LkM0qkCtz5U=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SAJMW+8JgclemYdLs52XuQTaA1k6pepke9NOPef9EPxqrqJ/PRXgrjDUrWrxKkBkMzIkh0JE3L6nPQatiP4VArHkthaWsWy5bK3vOMRUwJAGGRDvEs975w9F/l/Ld7RBFCf2zB5CUl6p+a6MMIUw7iYagynGWQG5h3Sb88HJubg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YspVQ5Xkdz6K5p3;
	Wed, 12 Feb 2025 01:34:54 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2A5A61402A4;
	Wed, 12 Feb 2025 01:36:08 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 11 Feb
 2025 18:36:07 +0100
Date: Tue, 11 Feb 2025 17:36:06 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Li Ming <ming.li@zohomail.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1 7/7] cxl/region: Drop goto pattern of
 construct_region()
Message-ID: <20250211173606.00004d33@huawei.com>
In-Reply-To: <20250211075727.351895-8-ming.li@zohomail.com>
References: <20250211075727.351895-1-ming.li@zohomail.com>
	<20250211075727.351895-8-ming.li@zohomail.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500009.china.huawei.com (7.191.174.84) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 15:57:27 +0800
Li Ming <ming.li@zohomail.com> wrote:

> Some operations need to be procted by the cxl_region_rwsem in construct
> region(). Currently, construct_region() uses down_write() and up_write()
> for the cxl_region_rwsem, so there is a goto pattern after down_write()
> invoked to release cxl_region_rwsem.
> 
> construct region() can be optimized to remove the goto pattern. The
> changes are creating a new function called __construct_region() which
> will include all checking and operations protected by the
> cxl_region_rwsem, and using guard(rwsem_write) to replace down_write()
> and up_write() in __construct_region().
> 
> Signed-off-by: Li Ming <ming.li@zohomail.com>
> ---
>  drivers/cxl/core/region.c | 71 +++++++++++++++++++++------------------
>  1 file changed, 39 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 36f3771818d3..170278bdcedc 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3217,49 +3217,31 @@ static int match_region_by_range(struct device *dev, const void *data)
>  	return rc;
>  }
>  
> -/* Establish an empty region covering the given HPA range */
> -static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> -					   struct cxl_endpoint_decoder *cxled)
> +static int __construct_region(struct cxl_region *cxlr,

This is only factoring out part, so I'm not sure the naming makes sense.
I don't have a better name however as this is doing various different things...
setup_region() doesn't feel right either...


> +			      struct cxl_root_decoder *cxlrd,
> +			      struct cxl_endpoint_decoder *cxled)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> -	struct cxl_port *port = cxlrd_to_port(cxlrd);
>  	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
>  	struct resource *res;
>  	int rc;
>  
> -	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> -				       atomic_read(&cxlrd->region_id));
> -	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> -
> -	if (IS_ERR(cxlr)) {
> -		dev_err(cxlmd->dev.parent,
> -			"%s:%s: %s failed assign region: %ld\n",
> -			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> -			__func__, PTR_ERR(cxlr));
> -		return cxlr;
> -	}
> -
> -	down_write(&cxl_region_rwsem);
> +	guard(rwsem_write)(&cxl_region_rwsem);
>  	p = &cxlr->params;
>  	if (p->state >= CXL_CONFIG_INTERLEAVE_ACTIVE) {
>  		dev_err(cxlmd->dev.parent,
>  			"%s:%s: %s autodiscovery interrupted\n",
>  			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
>  			__func__);
> -		rc = -EBUSY;
> -		goto err;
> +		return -EBUSY;
>  	}
>  
>  	set_bit(CXL_REGION_F_AUTO, &cxlr->flags);
>  
>  	res = kmalloc(sizeof(*res), GFP_KERNEL);
> -	if (!res) {
> -		rc = -ENOMEM;
> -		goto err;
> -	}
> +	if (!res)
> +		return -ENOMEM;
>  
>  	*res = DEFINE_RES_MEM_NAMED(hpa->start, range_len(hpa),
>  				    dev_name(&cxlr->dev));
> @@ -3282,7 +3264,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
>  	if (rc)
> -		goto err;
> +		return rc;
>  
>  	dev_dbg(cxlmd->dev.parent, "%s:%s: %s %s res: %pr iw: %d ig: %d\n",
>  		dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev), __func__,
> @@ -3291,14 +3273,39 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  
>  	/* ...to match put_device() in cxl_add_to_region() */
>  	get_device(&cxlr->dev);
> -	up_write(&cxl_region_rwsem);
>  
> -	return cxlr;
> +	return 0;
> +}
>  
> -err:
> -	up_write(&cxl_region_rwsem);
> -	devm_release_action(port->uport_dev, unregister_region, cxlr);
> -	return ERR_PTR(rc);
> +/* Establish an empty region covering the given HPA range */
> +static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
> +					   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_region *cxlr;
> +	int rc;
> +
> +	do {
> +		cxlr = __create_region(cxlrd, cxled->mode,
> +				       atomic_read(&cxlrd->region_id));
> +	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
> +
> +	if (IS_ERR(cxlr)) {
> +		dev_err(cxlmd->dev.parent,
> +			"%s:%s: %s failed assign region: %ld\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			__func__, PTR_ERR(cxlr));
> +		return cxlr;
> +	}
> +
> +	rc = __construct_region(cxlr, cxlrd, cxled);
> +	if (rc) {
> +		devm_release_action(port->uport_dev, unregister_region, cxlr);
> +		return ERR_PTR(rc);
> +	}
> +
> +	return cxlr;
>  }
>  
>  int cxl_add_to_region(struct cxl_port *root, struct cxl_endpoint_decoder *cxled)

