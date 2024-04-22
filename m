Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E46B153578
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 15:59:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801554; cv=none; b=EaeVKmgBNRJDRpxfOeAnKGfMguIBGUt9xElguDhisjGmhV2tKrozI+bRnHx+LaSc3a/VAld0sNl698EC83A2n7Qmg3JwMB6kSZvhwwdSdt2+sN1oqArxzaXoQY+v81GL2jqYqpL45GLJOf5x1H/xPaJueh2TL1myhv2Cerd0Bz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801554; c=relaxed/simple;
	bh=XUbRvyOoTNOEvsOaUGoN16Q4Yy9fPP2sv1Snn3XOmPE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L5xYKU1C8BLKLg/Hzz6GblujWdwryaEJAyk3dSkOrHlaxNNEMNAGzEUX+oWjIiVjPuDySrTma1mV3BQ9/7er+8uxkZ6cTc80c9zvROqgqoi0NGRoVgYsLCUhwHdZtzOIyLDXHfcd7llD2tiHs0pULl2g+ec0Cv5FEO3d3SvL84g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNVHT4dmRz688d6;
	Mon, 22 Apr 2024 23:56:53 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id CD381140B63;
	Mon, 22 Apr 2024 23:59:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 16:59:07 +0100
Date: Mon, 22 Apr 2024 16:59:06 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Dan Williams <dan.j.williams@intel.com>
CC: <dave.jiang@intel.com>, Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3] cxl/acpi: Cleanup __cxl_parse_cfmws()
Message-ID: <20240422165906.00007005@Huawei.com>
In-Reply-To: <171235474028.2718248.14109646123143505522.stgit@dwillia2-xfh.jf.intel.com>
References: <170915213220.2419769.6117155173006983208.stgit@dwillia2-xfh.jf.intel.com>
	<171235474028.2718248.14109646123143505522.stgit@dwillia2-xfh.jf.intel.com>
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
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 05 Apr 2024 15:05:50 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> As a follow on to the recent rework of __cxl_parse_cfmws() to always
> return errors [1], use cleanup.h helpers to remove goto and other cleanups
> now that logging is moved to the cxl_parse_cfmws() wrapper.
> 
> This ends up adding more code than it deletes, but __cxl_parse_cfmws()
> itself does get smaller. The takeaway from the cond_no_free_ptr()
> discussion [2] was to not add new macros to handle the cases where
> no_free_ptr() is awkward, instead rework the code to have helpers and
> clearer delineation of responsibility.
> 
> Now one might say that  __free(del_cxl_resource) is excessive given it
> is immediately registered with add_or_reset_cxl_resource(). The
> rationale for keeping it is that it forces use of "no_free_ptr()" on the
> argument passed to add_or_reset_cxl_resource(). That in turn makes it
> clear that @res is NULL for the rest of the function which is part of
> the point of the cleanup helpers, to turn subtle use after free errors
> [3] into loud NULL pointer de-references.
> 
> Link: http://lore.kernel.org/r/170820177238.631006.1012639681618409284.stgit@dwillia2-xfh.jf.intel.com [1]
> Link: http://lore.kernel.org/r/CAHk-=whBVhnh=KSeBBRet=E7qJAwnPR_aj5em187Q3FiD+LXnA@mail.gmail.com [2]
> Link: http://lore.kernel.org/r/20230714093146.2253438-1-leitao@debian.org [3]
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20240219124041.00002bda@Huawei.com
> Reviewed-by: Alison Schofield <alison.schofield@intel.com>
> Reviewed-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I guess I may have missed the boat on reviewing this one, but if not
a few late comments inline.  

Jonathan


> ---
> Changes since v2:
> - Drop kvasprintf() usage in alloc_cxl_resource (Alison)
> 
>  drivers/cxl/acpi.c |   93 +++++++++++++++++++++++++++++-----------------------
>  drivers/cxl/cxl.h  |    5 +++
>  2 files changed, 56 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index af5cb818f84d..32091379a97b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c

> +
> +static struct resource *alloc_cxl_resource(resource_size_t base,
> +					   resource_size_t n, int id)
> +{
> +	struct resource *res __free(kfree) = kzalloc(sizeof(*res), GFP_KERNEL);
> +
> +	if (!res)
> +		return NULL;
> +
> +	res->start = base;
> +	res->end = base + n - 1;
> +	res->flags = IORESOURCE_MEM;
> +	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", id);

If you are going to call a function something as generic
as 'alloc_cxl_resource' I wouldn't expect to see such a specific string.

alloc_cxl_fmw_resource() would be fine with this.

> +	if (!res->name)
> +		return NULL;
> +
> +	return no_free_ptr(res);
> +}

> +
> +DEFINE_FREE(put_cxlrd, struct cxl_root_decoder *,
> +	    if (!IS_ERR_OR_NULL(_T)) put_device(&_T->cxlsd.cxld.dev))
> +DEFINE_FREE(del_cxl_resource, struct resource *, if (_T) del_cxl_resource(_T))
>  static int __cxl_parse_cfmws(struct acpi_cedt_cfmws *cfmws,
>  			     struct cxl_cfmws_context *ctx)
>  {
>  	int target_map[CXL_DECODER_MAX_INTERLEAVE];
>  	struct cxl_port *root_port = ctx->root_port;
> -	struct resource *cxl_res = ctx->cxl_res;
>  	struct cxl_cxims_context cxims_ctx;
> -	struct cxl_root_decoder *cxlrd;
>  	struct device *dev = ctx->dev;
>  	cxl_calc_hb_fn cxl_calc_hb;
>  	struct cxl_decoder *cxld;
>  	unsigned int ways, i, ig;
> -	struct resource *res;
>  	int rc;
>  
>  	rc = cxl_acpi_cfmws_verify(dev, cfmws);
> -	if (rc) {
> -		dev_err(dev, "CFMWS range %#llx-%#llx not registered\n",
> -			cfmws->base_hpa,
> -			cfmws->base_hpa + cfmws->window_size - 1);

Not sure how this is related to rest of the change.

> +	if (rc)
>  		return rc;
> -	}
>  
>  	rc = eiw_to_ways(cfmws->interleave_ways, &ways);
>  	if (rc)

...

