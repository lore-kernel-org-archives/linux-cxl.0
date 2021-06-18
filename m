Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E69DC48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11F3561261
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 13:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhFRNhc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 09:37:32 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3279 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232253AbhFRNha (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 09:37:30 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G609Q4bW1z6H6j1;
        Fri, 18 Jun 2021 21:28:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Fri, 18 Jun 2021 15:35:18 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 14:35:18 +0100
Date:   Fri, 18 Jun 2021 14:35:08 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 6/6] cxl/region: Handle region's address space
 allocation
Message-ID: <20210618143508.000036f0@Huawei.com>
In-Reply-To: <20210617173655.430424-7-ben.widawsky@intel.com>
References: <20210617173655.430424-1-ben.widawsky@intel.com>
        <20210617173655.430424-7-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 10:36:55 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Regions are carved out of an addresses space which is claimed by top
> level decoders, and subsequently their children decoders. Regions are
> created with a size and therefore must fit, with proper alignment, in
> that address space. The support for doing this fitting is handled by the
> driver automatically.
> 
> As an example, a platform might configure a top level decoder to claim
> 1TB of address space @ 0x800000000 -> 0x10800000000; it would be
> possible to create M regions with appropriate alignment to occupy that
> address space. Each of those regions would have a host physical address
> somewhere in the range between 32G and 1.3TB, and the location will be
> determined by the logic added here.
> 
> The request_region() usage is not strictly mandatory at this point as
> the actual handling of the address space is done with genpools. It is
> highly likely however that the resource/region APIs will become useful
> in the not too distant future.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

This feels like something that will be much more obvious once the rest
of the missing bits you mention in the cover letter are in place.

Until then it looks fine to me, but I'm not sure I understand how it is
going to get used.  Guess I'll wait and see ;)

Jonathan

> ---
>  drivers/cxl/core.c   | 13 +++++++++++++
>  drivers/cxl/cxl.h    |  2 ++
>  drivers/cxl/region.c | 31 +++++++++++++++++++++++++++++--
>  3 files changed, 44 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 0e598a18e95f..b57ee627bc6a 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/pci.h>
> @@ -607,6 +608,18 @@ devm_cxl_add_decoder(struct device *host, struct cxl_port *port, int nr_targets,
>  	rc = devm_add_action_or_reset(host, unregister_dev, dev);
>  	if (rc)
>  		return ERR_PTR(rc);
> +
> +	cxld->address_space =
> +		devm_gen_pool_create(dev, ilog2(SZ_256M * cxld->interleave_ways),
> +				     NUMA_NO_NODE, dev_name(dev));
> +	if (IS_ERR(cxld->address_space))
> +		return ERR_CAST(cxld->address_space);
> +
> +	rc = gen_pool_add(cxld->address_space, cxld->res.start,
> +			  resource_size(&cxld->res), NUMA_NO_NODE);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
>  	return cxld;
>  
>  err:
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index b08f0969abeb..b5b728155d86 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -193,6 +193,7 @@ enum cxl_decoder_type {
>   * @region_ida: allocator for region ids.
>   * @regions: List of regions mapped (may be disabled) by this decoder.
>   * @youngest: Last region created for this decoder.
> + * @address_space: Used/free address space for regions.
>   * @target: active ordered target list in current decoder configuration
>   */
>  struct cxl_decoder {
> @@ -206,6 +207,7 @@ struct cxl_decoder {
>  	struct ida region_ida;
>  	struct list_head regions;
>  	struct cxl_region *youngest;
> +	struct gen_pool *address_space;
>  	struct cxl_dport *target[];
>  };
>  
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 62bca8b30349..0554f3fff7ac 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2021 Intel Corporation. All rights reserved. */
>  #include <linux/io-64-nonatomic-lo-hi.h>
> +#include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
>  #include <linux/sizes.h>
> @@ -388,9 +389,33 @@ int cxl_delete_region(struct cxl_decoder *cxld, const char *region_name)
>  	return 0;
>  }
>  
> +static int allocate_region_addr(struct cxl_region *region)
> +{
> +	struct cxl_decoder *cxld = to_cxl_decoder(region->dev.parent);
> +	unsigned long start;
> +
> +	start = gen_pool_alloc(cxld->address_space, region->requested_size);
> +	if (!start) {
> +		trace_cxl_region_bind(region, "Couldn't allocate address space");
> +		return -ENOMEM;
> +	}
> +
> +	region->res =
> +		__request_region(&cxld->res, start, region->requested_size,
> +				 dev_name(&region->dev), IORESOURCE_EXCLUSIVE);
> +	if (IS_ERR(region->res)) {
> +		trace_cxl_region_bind(region, "Couldn't obtain region");
> +		gen_pool_free(cxld->address_space, start,
> +			      region->requested_size);
> +		return PTR_ERR(region->res);
> +	}
> +
> +	return 0;
> +}
> +
>  static int bind_region(struct cxl_region *region)
>  {
> -	int i;
> +	int i, rc;
>  
>  	if (dev_WARN_ONCE(&region->dev, !cxl_is_region_configured(region),
>  			  "unconfigured regions can't be probed (race?)\n")) {
> @@ -408,7 +433,9 @@ static int bind_region(struct cxl_region *region)
>  			return -ENXIO;
>  		}
>  
> -	/* TODO: Allocate from decoder's address space */
> +	rc = allocate_region_addr(region);
> +	if (rc)
> +		return rc;
>  
>  	/* TODO: program HDM decoders */
>  

