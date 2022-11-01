Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7556C433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 18:17:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229923AbiKASRB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Nov 2022 14:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiKASQy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Nov 2022 14:16:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC36413E17
        for <linux-cxl@vger.kernel.org>; Tue,  1 Nov 2022 11:16:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667326611; x=1698862611;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=6N4qPlJP4pJBAWH8DCVgT/ArFoYzaxAEiLOB7KWkVmg=;
  b=gF7+7T/9Gnt5H9S0JRk9/UOteUCscaBHXINrJTROHTQe+MbnwVFKrPZI
   7uxsvjce+/fwS5RzYEYqJzgSTtvBw51A2DMGw9OjY3d53E2ZzNJgOArAw
   bhuuAuXqXscupou0akfoKv954OGD65LZtT0FyXCBohxcf6SDuv3ZlnF7L
   F/Mn06kqObm6PF0mExQSN0LjBA9XbvWL+RGwaMMV1bcw8BgHNRjQlKO/k
   GVw3k3T5doRMSV2ReH8IM+y9kOinOGvvXOOMFCOKjWwpVB6yoPydVdxGd
   jvkwYjYW5Xi3KPiNWX9CyhRZzRhGelatxE1Zlw0EeFkKCxkb2ZSObf+RR
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="335880000"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="335880000"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:16:51 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10518"; a="739429249"
X-IronPort-AV: E=Sophos;i="5.95,231,1661842800"; 
   d="scan'208";a="739429249"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.110.73]) ([10.212.110.73])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2022 11:16:50 -0700
Message-ID: <e1136861-bfcb-38ec-4c99-6fab6fbe1d97@intel.com>
Date:   Tue, 1 Nov 2022 11:16:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH v2] cxl/region: refactor decoder allocation for region
 refs
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>
References: <20221101074100.1732003-1-vishal.l.verma@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221101074100.1732003-1-vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/1/2022 12:41 AM, Vishal Verma wrote:
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

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c | 67 ++++++++++++++++++++++++---------------
>   1 file changed, 41 insertions(+), 26 deletions(-)
> 
> Changes since v1[1]:
> - Limit the new decoder alloc helper to only the decoder allocation for
>    new cxl_region_ref objects, not retrieval for existing refs (Dan).
> 
> [1]: https://lore.kernel.org/linux-cxl/89acba4011d03582a1f81feb376915b826020cee.camel@intel.com
> 
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..986855e93e71 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -686,18 +686,27 @@ static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
>   	return cxl_rr;
>   }
>   
> -static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +static void cxl_rr_free_decoder(struct cxl_region_ref *cxl_rr)
>   {
> -	struct cxl_port *port = cxl_rr->port;
>   	struct cxl_region *cxlr = cxl_rr->region;
>   	struct cxl_decoder *cxld = cxl_rr->decoder;
>   
> +	if (!cxld)
> +		return;
> +
>   	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
>   	if (cxld->region == cxlr) {
>   		cxld->region = NULL;
>   		put_device(&cxlr->dev);
>   	}
> +}
>   
> +static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +{
> +	struct cxl_port *port = cxl_rr->port;
> +	struct cxl_region *cxlr = cxl_rr->region;
> +
> +	cxl_rr_free_decoder(cxl_rr);
>   	xa_erase(&port->regions, (unsigned long)cxlr);
>   	xa_destroy(&cxl_rr->endpoints);
>   	kfree(cxl_rr);
> @@ -728,6 +737,33 @@ static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
>   	return 0;
>   }
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
>   /**
>    * cxl_port_attach_region() - track a region's interest in a port by endpoint
>    * @port: port to add a new region reference 'struct cxl_region_ref'
> @@ -794,12 +830,6 @@ static int cxl_port_attach_region(struct cxl_port *port,
>   			cxl_rr->nr_targets++;
>   			nr_targets_inc = true;
>   		}
> -
> -		/*
> -		 * The decoder for @cxlr was allocated when the region was first
> -		 * attached to @port.
> -		 */
> -		cxld = cxl_rr->decoder;
>   	} else {
>   		cxl_rr = alloc_region_ref(port, cxlr);
>   		if (IS_ERR(cxl_rr)) {
> @@ -810,26 +840,11 @@ static int cxl_port_attach_region(struct cxl_port *port,
>   		}
>   		nr_targets_inc = true;
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
>   			goto out_erase;
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
>   	}
> +	cxld = cxl_rr->decoder;
>   
>   	rc = cxl_rr_ep_add(cxl_rr, cxled);
>   	if (rc) {
