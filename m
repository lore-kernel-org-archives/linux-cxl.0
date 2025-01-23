Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574C313EFF3
	for <linux-cxl@vger.kernel.org>; Thu, 23 Jan 2025 16:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737651069; cv=none; b=bN8e/fjaATG9xwEW674JUSbFLXuYE1L89Vkdsa7PPrqKxDiYh4l62b+5RFxqhaIimee69221WEU1zoIIGHnJ6BDGWF+FV0lEyQh3GpyD++IWG1GMBjAsFSKaS9q/dZ88gbl/isvQ4uNfVrhxlyMvZ37G8fld5RCJ0vl23Xu61gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737651069; c=relaxed/simple;
	bh=9MLxOYMAliSZu9O3R0izuVFyoVoDuh/4sZKNWShS4r8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EwvLGvj/F0Tk3JiR1Fyp3orutwpsF9cTvY7YP5+t0bDSGwR+I6+7ZWXuMEEEG1SrMm3qiqVg3oH/iVRZc1O/0Y0Hufh7LwJbJqRle8rL0b4HjHUO6hRYBhtez86VqdXQDE4Ztzs+mPmQF+G//8Ia/TSu4NOQeabnX9+6X+5V5f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Yf6NN3Vtwz6L4yc;
	Fri, 24 Jan 2025 00:49:08 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id D4D151404C4;
	Fri, 24 Jan 2025 00:51:04 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 23 Jan
 2025 17:51:04 +0100
Date: Thu, 23 Jan 2025 16:51:03 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, Dave Jiang <dave.jiang@intel.com>, "Alejandro
 Lucero" <alucerop@amd.com>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH v2 5/5] cxl: Kill enum cxl_decoder_mode
Message-ID: <20250123165103.00004379@huawei.com>
In-Reply-To: <173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
References: <173753635014.3849855.17902348420186052714.stgit@dwillia2-xfh.jf.intel.com>
	<173753637863.3849855.16067432468334597297.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 22 Jan 2025 00:59:38 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Now that the operational mode of DPA capacity (ram vs pmem... etc) is
> tracked in the partition, and no code paths have dependencies on the
> mode implying the partition index, the ambiguous 'enum cxl_decoder_mode'
> can be cleaned up, specifically this ambiguity on whether the operation
> mode implied anything about the partition order.
> 
> Endpoint decoders simply reference their assigned partition where the
> operational mode can be retrieved as partition mode.
> 
> With this in place PMEM can now be partition0 which happens today when
> the RAM capacity size is zero. Dynamic RAM can appear above PMEM when
> DCD arrives, etc. Code sequences that hard coded the "PMEM after RAM"
> assumption can now just iterate partitions and consult the partition
> mode after the fact.
> 
> Cc: Dave Jiang <dave.jiang@intel.com>
> Cc: Alejandro Lucero <alucerop@amd.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A few things inline.

Jonathan

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 591aeb26c9e1..bb478e7b12f6 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
>
> -int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> -		     enum cxl_decoder_mode mode)
> +int cxl_dpa_set_part(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_partition_mode mode)
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct device *dev = &cxled->cxld.dev;
> -
> -	switch (mode) {
> -	case CXL_DECODER_RAM:
> -	case CXL_DECODER_PMEM:
> -		break;
> -	default:
> -		dev_dbg(dev, "unsupported mode: %d\n", mode);
> -		return -EINVAL;
> -	}
> +	int part;
>  
>  	guard(rwsem_write)(&cxl_dpa_rwsem);
>  	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
>  		return -EBUSY;
>  
> -	/*
> -	 * Only allow modes that are supported by the current partition
> -	 * configuration
> -	 */
> -	if (mode == CXL_DECODER_PMEM && !cxl_pmem_size(cxlds)) {
> -		dev_dbg(dev, "no available pmem capacity\n");
> -		return -ENXIO;
> +	part = -1;
> +	for (int i = 0; i < cxlds->nr_partitions; i++)

Similar to previous comment can use early loop exit and
part as the loop iteration variable short code and no magic i
appears.

> +		if (cxlds->part[i].mode == mode) {
> +			part = i;
> +			break;
> +		}
> +
> +	if (part < 0) {
> +		dev_dbg(dev, "unsupported mode: %d\n", mode);
> +		return -EINVAL;
>  	}
> -	if (mode == CXL_DECODER_RAM && !cxl_ram_size(cxlds)) {
> -		dev_dbg(dev, "no available ram capacity\n");
> +
> +	if (!resource_size(&cxlds->part[part].res)) {
> +		dev_dbg(dev, "no available capacity for mode: %d\n", mode);
>  		return -ENXIO;
>  	}
>  
> -	cxled->mode = mode;
> +	cxled->part = part;
>  	return 0;
>  }
>  

> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9f0f6fdbc841..83b985d2ba76 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c

>  
>  static int poison_by_decoder(struct device *dev, void *arg)
>  {
>  	struct cxl_poison_context *ctx = arg;
>  	struct cxl_endpoint_decoder *cxled;
> +	enum cxl_partition_mode mode;
> +	struct cxl_dev_state *cxlds;
>  	struct cxl_memdev *cxlmd;
>  	u64 offset, length;
>  	int rc = 0;
> @@ -2728,11 +2733,17 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  		return rc;
>  
>  	cxlmd = cxled_to_memdev(cxled);
> +	cxlds = cxlmd->cxlds;
> +	if (cxled->part < 0)
> +		mode = CXL_PARTMODE_NONE;
Ah.  Here is our mysterious none.  Maybe add a comment on what
this means in practice.  Race condition, actual hole, crazy decoder
someone (e.g bios) setup?

> +	else
> +		mode = cxlds->part[cxled->part].mode;
> +
>  	if (cxled->skip) {
>  		offset = cxled->dpa_res->start - cxled->skip;
>  		length = cxled->skip;
>  		rc = cxl_mem_get_poison(cxlmd, offset, length, NULL);
> -		if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +		if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>  			rc = 0;
>  		if (rc)
>  			return rc;
> @@ -2741,7 +2752,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	offset = cxled->dpa_res->start;
>  	length = cxled->dpa_res->end - offset + 1;
>  	rc = cxl_mem_get_poison(cxlmd, offset, length, cxled->cxld.region);
> -	if (rc == -EFAULT && cxled->mode == CXL_DECODER_RAM)
> +	if (rc == -EFAULT && mode == CXL_PARTMODE_RAM)
>  		rc = 0;
>  	if (rc)
>  		return rc;
> @@ -2749,7 +2760,7 @@ static int poison_by_decoder(struct device *dev, void *arg)
>  	/* Iterate until commit_end is reached */
>  	if (cxled->cxld.id == ctx->port->commit_end) {
>  		ctx->offset = cxled->dpa_res->end + 1;
> -		ctx->mode = cxled->mode;
> +		ctx->part = cxled->part;
>  		return 1;
>  	}
>  
> @@ -2762,7 +2773,8 @@ int cxl_get_poison_by_endpoint(struct cxl_port *port)
>  	int rc = 0;
>  
>  	ctx = (struct cxl_poison_context) {
> -		.port = port
> +		.port = port,
> +		.part = -1,
>  	};
>  
>  	rc = device_for_each_child(&port->dev, &ctx, poison_by_decoder);
> @@ -3206,14 +3218,18 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  {
>  	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
>  	struct cxl_port *port = cxlrd_to_port(cxlrd);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct range *hpa = &cxled->cxld.hpa_range;
> +	int rc, part = READ_ONCE(cxled->part);
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	struct resource *res;
> -	int rc;
> +
> +	if (part < 0)
> +		return ERR_PTR(-EBUSY);
>  
>  	do {
> -		cxlr = __create_region(cxlrd, cxled->mode,
> +		cxlr = __create_region(cxlrd, cxlds->part[part].mode,
>  				       atomic_read(&cxlrd->region_id));
>  	} while (IS_ERR(cxlr) && PTR_ERR(cxlr) == -EBUSY);
>  
> @@ -3416,9 +3432,9 @@ static int cxl_region_probe(struct device *dev)
>  		return rc;
>  
>  	switch (cxlr->mode) {
> -	case CXL_DECODER_PMEM:
> +	case CXL_PARTMODE_PMEM:
>  		return devm_cxl_add_pmem_region(cxlr);
> -	case CXL_DECODER_RAM:
> +	case CXL_PARTMODE_RAM:
>  		/*
>  		 * The region can not be manged by CXL if any portion of
>  		 * it is already online as 'System RAM'


