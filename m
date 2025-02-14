Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4552753FD;
	Fri, 14 Feb 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739550255; cv=none; b=tgy0Dmdw8EY05lve7WuKUfxA7Xp4f0TNC5fum1BalR/N7Ji5YKfaW8wWBnWVpd/ZEx17kFwvIXz72nOWt76FzVC5/pdiOEyyZrrEnpCNUmhWufyCUvcBpI8l6HcTIFB3iWW1jz1Pb00Z+7E9R79Vqjn4PPygNaxFuZKhbKKm0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739550255; c=relaxed/simple;
	bh=cto20RyuLyDQiiltYRvN29tUDL44aemys6qjqds3B3Y=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aA5hDnJ4LA+/0Jls7RLiidr6Avx/+TC6vmRMXQJ09YmBR2MGFa3dFqUlDfEwHO4cvqcHVIHNOpRpeWdrW64PcVuEtguVhWhnxEFTdzLiBQk/XHOzRm1EfgnQi7Rf/67s61MKh5fpOg5Dw6EEfoq7jCseSfRwlN16uoOj/lcSLHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YvckX55M3z6H7Kd;
	Sat, 15 Feb 2025 00:21:40 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 2961A140A77;
	Sat, 15 Feb 2025 00:24:09 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 14 Feb
 2025 17:24:08 +0100
Date: Fri, 14 Feb 2025 16:24:07 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Robert Richter <rrichter@amd.com>
CC: Alison Schofield <alison.schofield@intel.com>, Vishal Verma
	<vishal.l.verma@intel.com>, Ira Weiny <ira.weiny@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, Dave Jiang <dave.jiang@intel.com>, "Davidlohr
 Bueso" <dave@stgolabs.net>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gregory Price <gourry@gourry.net>, "Fabio M.
 De Francesco" <fabio.m.de.francesco@linux.intel.com>, Terry Bowman
	<terry.bowman@amd.com>
Subject: Re: [PATCH v3 11/18] cxl/region: Split region registration into an
 initialization and adding part
Message-ID: <20250214162407.00002efc@huawei.com>
In-Reply-To: <20250211095349.981096-12-rrichter@amd.com>
References: <20250211095349.981096-1-rrichter@amd.com>
	<20250211095349.981096-12-rrichter@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500010.china.huawei.com (7.191.174.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 11 Feb 2025 10:53:41 +0100
Robert Richter <rrichter@amd.com> wrote:

> Before adding an endpoint to a region, the endpoint is initialized
> first. Move that part to a new function
> cxl_endpoint_decoder_initialize(). The function is in preparation of
> adding more parameters that need to be determined in a setup.
> 
> The split also helps better separating the code. After initialization
> the addition of an endpoint may fail with an error code and all the
> data would need to be reverted to not leave the endpoint in an
> undefined state. With separate functions the init part can succeed
> even if the endpoint cannot be added.
> 
> Function naming follows the style of device_register() etc. Thus,
> rename function cxl_add_to_region() to
> cxl_endpoint_decoder_register().
Hi Robert,

Superficially I'd expect a call of that name to be registering
the device for the decoder.  i.e. being the thing that makes
/sys/bus/cxl/devices/decoder3.2 appear.

This register naming is based on the other two being initalize
and add, but they aren't initializing and adding the
endpoint decode device. Hence I don't think those names work either.

> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Reviewed-by: Gregory Price <gourry@gourry.net>
> Tested-by: Gregory Price <gourry@gourry.net>
> ---
>  drivers/cxl/core/region.c | 36 ++++++++++++++++++++++++++++--------
>  drivers/cxl/cxl.h         |  6 ++++--
>  drivers/cxl/port.c        |  9 +++++----
>  3 files changed, 37 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 9ce0282c0042..fb43e154c7b9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -3345,7 +3345,7 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  		dev_name(&cxlr->dev), p->res, p->interleave_ways,
>  		p->interleave_granularity);
>  
> -	/* ...to match put_device() in cxl_add_to_region() */
> +	/* ...to match put_device() in cxl_endpoint_decoder_add() */
>  	get_device(&cxlr->dev);
>  	up_write(&cxl_region_rwsem);
>  
> @@ -3357,19 +3357,28 @@ static struct cxl_region *construct_region(struct cxl_root_decoder *cxlrd,
>  	return ERR_PTR(rc);
>  }
>  
> -int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
> +static int cxl_endpoint_decoder_initialize(struct cxl_endpoint_decoder *cxled)
So far this looks like it should be called something like

cxl_endpoint_decoder_init_region_decoder()
or something like that. The cxled is already intialized more generally
and the cxled->cxld.dev is registered.

>  {
> -	struct range *hpa = &cxled->cxld.hpa_range;
>  	struct cxl_root_decoder *cxlrd;
> -	struct cxl_region_params *p;
> -	struct cxl_region *cxlr;
> -	bool attach = false;
> -	int rc;
>  
>  	cxlrd = cxl_find_root_decoder(cxled);
>  	if (!cxlrd)
>  		return -ENXIO;
>  
> +	cxled->cxlrd = cxlrd;
> +
> +	return 0;
> +}
> +
> +static int cxl_endpoint_decoder_add(struct cxl_endpoint_decoder *cxled)
It's not adding what I'd expect such a function to add.
Rather it is performing an association with a region.

> +{
> +	struct range *hpa = &cxled->cxld.hpa_range;
> +	struct cxl_root_decoder *cxlrd = cxled->cxlrd;
> +	struct cxl_region_params *p;
> +	struct cxl_region *cxlr;
> +	bool attach = false;
> +	int rc;
> +
>  	/*
>  	 * Ensure that if multiple threads race to construct_region() for @hpa
>  	 * one does the construction and the others add to that.
> @@ -3406,7 +3415,18 @@ int cxl_add_to_region(struct cxl_endpoint_decoder *cxled)
>  
>  	return rc;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_add_to_region, "CXL");
> +
> +int cxl_endpoint_decoder_register(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +
> +	rc = cxl_endpoint_decoder_initialize(cxled);
> +	if (rc)
> +		return rc;
> +
> +	return cxl_endpoint_decoder_add(cxled);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_endpoint_decoder_register, "CXL");



