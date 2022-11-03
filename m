Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0B84C4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  3 Nov 2022 16:45:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232300AbiKCQph (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 3 Nov 2022 12:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232172AbiKCQpU (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 3 Nov 2022 12:45:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB894205E4
        for <linux-cxl@vger.kernel.org>; Thu,  3 Nov 2022 09:41:29 -0700 (PDT)
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4N38Yh0JtRz67gNl;
        Fri,  4 Nov 2022 00:37:28 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 3 Nov 2022 17:41:27 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 3 Nov
 2022 16:41:26 +0000
Date:   Thu, 3 Nov 2022 16:41:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
Subject: Re: [PATCH v2] cxl/region: refactor decoder allocation for region
 refs
Message-ID: <20221103164118.000031bf@Huawei.com>
In-Reply-To: <20221101074100.1732003-1-vishal.l.verma@intel.com>
References: <20221101074100.1732003-1-vishal.l.verma@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue,  1 Nov 2022 01:41:00 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> When an intermediate port's decoders have been exhausted by existing
> regions, and creating a new region with the port in question in it's
> hierarchical path is attempted, cxl_port_attach_region() fails to find a
> port decoder (as would be expected), and drops into the failure / cleanup
> path.
> 
> However, during cleanup of the region reference, a sanity check attempts
> to dereference the decoder, which in the above case didn't exist. This
> causes a NULL pointer dereference BUG.
> 
> To fix this, refactor the decoder allocation and de-allocation into
> helper routines, and in this 'free' routine, check that the decoder,
> @cxld, is valid before attempting any operations on it.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

FWIW.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c | 67 ++++++++++++++++++++++++---------------
>  1 file changed, 41 insertions(+), 26 deletions(-)
> 
> Changes since v1[1]:
> - Limit the new decoder alloc helper to only the decoder allocation for
>   new cxl_region_ref objects, not retrieval for existing refs (Dan).
> 
> [1]: https://lore.kernel.org/linux-cxl/89acba4011d03582a1f81feb376915b826020cee.camel@intel.com
> 
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..986855e93e71 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -686,18 +686,27 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>  	return cxl_rr;
>  }
>  
> -static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
>  {
> -	struct cxl_port *port = cxl_rr->port;
>  	struct cxl_region *cxlr = cxl_rr->region;
>  	struct cxl_decoder *cxld = cxl_rr->decoder;
>  
> +	if (!cxld)
> +		return;
> +
>  	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
>  	if (cxld->region == cxlr) {
>  		cxld->region = NULL;
>  		put_device(&cxlr->dev);
>  	}
> +}
>  
> +static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +{
> +	struct cxl_port *port = cxl_rr->port;
> +	struct cxl_region *cxlr = cxl_rr->region;
> +
> +	cxl_rr_free_decoder(cxl_rr);
>  	xa_erase(&port->regions, (unsigned long)cxlr);
>  	xa_destroy(&cxl_rr->endpoints);
>  	kfree(cxl_rr);
> @@ -728,6 +737,33 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>  	return 0;
>  }
>  
> +static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
> +				struct cxl_endpoint_decoder *cxled,
> +				struct cxl_region_ref *cxl_rr)
> +{
> +	struct cxl_decoder *cxld;
> +
> +	if (port == cxled_to_port(cxled))
> +		cxld = &cxled->cxld;
> +	else
> +		cxld = cxl_region_find_decoder(port, cxlr);
> +	if (!cxld) {
> +		dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +			dev_name(&port->dev));
> +		return -EBUSY;
> +	}
> +
> +	if (cxld->region) {
> +		dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
> +			dev_name(&port->dev), dev_name(&cxld->dev),
> +			dev_name(&cxld->region->dev));
> +		return -EBUSY;
> +	}
> +
> +	cxl_rr->decoder = cxld;
> +	return 0;
> +}
> +
>  /**
>   * cxl_port_attach_region() - track a region's interest in a port by endpoint
>   * @port: port to add a new region reference 'struct cxl_region_ref'
> @@ -794,12 +830,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  			cxl_rr->nr_targets++;
>  			nr_targets_inc = true;
>  		}
> -
> -		/*
> -		 * The decoder for @cxlr was allocated when the region was first
> -		 * attached to @port.
> -		 */
> -		cxld = cxl_rr->decoder;
>  	} else {
>  		cxl_rr = alloc_region_ref(port, cxlr);
>  		if (IS_ERR(cxl_rr)) {
> @@ -810,26 +840,11 @@ static int cxl_port_attach_region(struct cxl_port *port,
>  		}
>  		nr_targets_inc = true;
>  
> -		if (port == cxled_to_port(cxled))
> -			cxld = &cxled->cxld;
> -		else
> -			cxld = cxl_region_find_decoder(port, cxlr);
> -		if (!cxld) {
> -			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> -				dev_name(&port->dev));
> +		rc = cxl_rr_alloc_decoder(port, cxlr, cxled, cxl_rr);
> +		if (rc)
>  			goto out_erase;
> -		}
> -
> -		if (cxld->region) {
> -			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
> -				dev_name(&port->dev), dev_name(&cxld->dev),
> -				dev_name(&cxld->region->dev));
> -			rc = -EBUSY;
> -			goto out_erase;
> -		}
> -
> -		cxl_rr->decoder = cxld;
>  	}
> +	cxld = cxl_rr->decoder;
>  
>  	rc = cxl_rr_ep_add(cxl_rr, cxled);
>  	if (rc) {

