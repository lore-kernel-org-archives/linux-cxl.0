Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6486C7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 15:00:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237116AbjFFPAU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 11:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbjFFPAS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 11:00:18 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC191985
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 07:59:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QbDBQ3VHmz6J7Hl;
        Tue,  6 Jun 2023 22:58:38 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 15:58:55 +0100
Date:   Tue, 6 Jun 2023 15:58:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 16/19] cxl/hdm: Define a driver interface for DPA
 allocation
Message-ID: <20230606155854.00000f4d@Huawei.com>
In-Reply-To: <168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592158743.1948938.7622563891193802610.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:33:07 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Region creation involves finding available DPA (device-physical-address)
> capacity to map into HPA (host-physical-address) space. Given the HPA
> capacity constraint, define an API, cxl_request_dpa(), that has the
> flexibility to map the minimum amount of memory the driver needs to
> operate vs the total possible that can be mapped given HPA availability.

Maybe give an example of when a device might want to do this? I guess
it's the equivalent of resize-able BARs?
> 
> Factor out the core of cxl_dpa_alloc(), that does free space scanning,
> into a cxl_dpa_freespace() helper, and use that to balance the capacity
> available to map vs the @min and @max arguments to cxl_request_dpa().
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/hdm.c |  140 +++++++++++++++++++++++++++++++++++++++++-------
>  drivers/cxl/cxl.h      |    6 ++
>  drivers/cxl/cxlmem.h   |    4 +
>  3 files changed, 131 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 91ab3033c781..514d30131d92 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -464,30 +464,17 @@ int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
>  	return rc;
>  }
>  
...

> +static int find_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct cxl_port *port;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	port = cxled_to_port(cxled);
> +
> +	if (cxled->cxld.id != port->hdm_end + 1)
> +		return 0;
> +	return 1;
> +}
> +
> +/**
> + * cxl_request_dpa - search and reserve DPA given input constraints
> + * @endpoint: an endpoint port with available decoders

Can call it on ones with out given you check.  Whilst not useful
to do so, I'm not sure you want to say they are available here as that
feels like a constraint that isn't true.
"endpoint with decoders" or "endpoint with potentially available decoders"


> + * @mode: DPA operation mode (ram vs pmem)
> + * @min: the minimum amount of capacity the call needs
> + * @max: extra capacity to allocate after min is satisfied

This sounds like another chunk on top. So allocate min + max?
That's an odd thing for 'max'.  
"max: allocate up to this capacity if available - @min must be allocated"

> + *
> + * Given that a region needs to allocate from limited HPA capacity it
> + * may be the case that a device has more mappable DPA capacity than
> + * available HPA. So, the expectation is that @min is a driver known
> + * value for how much capacity is needed, and @max is based the limit of
> + * how much HPA space is available for a new region.
> + *
> + * Returns a pinned cxl_decoder with at least @min bytes of capacity
> + * reserved, or an error pointer. The caller is also expected to own the
> + * lifetime of the memdev registration associated with the endpoint to
> + * pin the decoder registered as well.
> + */
> +struct cxl_endpoint_decoder *cxl_request_dpa(struct cxl_port *endpoint,
> +					     enum cxl_decoder_mode mode,
> +					     resource_size_t min,
> +					     resource_size_t max)
> +{
> +	struct cxl_endpoint_decoder *cxled;
> +	struct device *cxled_dev;
> +	resource_size_t alloc;
> +	int rc;
> +
> +	if (!IS_ALIGNED(min | max, SZ_256M))
> +		return ERR_PTR(-EINVAL);
> +
> +	down_read(&cxl_dpa_rwsem);
> +	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
> +	if (!cxled_dev)
> +		cxled = ERR_PTR(-ENXIO);
> +	else
> +		cxled = to_cxl_endpoint_decoder(cxled_dev);

Can in theory (based on what's in the function at least) return NULL. 

> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (IS_ERR(cxled))
> +		return cxled;

Perhaps cleaner as following. I'm not spotting lifetime concerns from narrower locking
but I might be missing something.

	down_read(&cxl_dpa_rwsem);
	cxled_dev = device_find_child(&endpoint->dev, NULL, find_free_decoder);
	up_read(&cxl_dpa_rwsem);

	if (!cxled_dev) {
		return ERR_PTR(-ENXIO);
	} else {
		cxled = to_cxl_endpoint_decoder(cxled_dev);
		if (!cxl_ed)
			return ERR_PTR(-ENXIO);
	} 

> +
> +	rc = cxl_dpa_set_mode(cxled, mode);
> +	if (rc)
> +		goto err;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	alloc = cxl_dpa_freespace(cxled, NULL, NULL);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	if (max)
> +		alloc = min(max, alloc);

Why allow optional max? Just have it same as min if
no difference is allowed.  Docs don't mention special
values - though they are bit confusing as noted above.

> +	if (alloc < min) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	rc = cxl_dpa_alloc(cxled, alloc);
> +	if (rc)
> +		goto err;
> +
> +	return cxled;
> +err:
> +	put_device(cxled_dev);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_request_dpa, CXL);
> +
>  static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  {
>  	u16 eig;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 258c90727dd2..55808697773f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -680,6 +680,12 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  struct cxl_root_decoder *to_cxl_root_decoder(struct device *dev);
>  struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev);
>  struct cxl_endpoint_decoder *to_cxl_endpoint_decoder(struct device *dev);
> +
> +static inline struct device *cxled_dev(struct cxl_endpoint_decoder *cxled)
> +{
> +	return &cxled->cxld.dev;
> +}
> +
For one current user, I'd not bother.  If there are others in tree (there are ;)
then do this as a precursor cleanup patch.


