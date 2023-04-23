Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D3B0C77B60
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 15:35:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbjDWPfg (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 11:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjDWPff (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 11:35:35 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0B31702
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 08:35:32 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4Bzc0dSyz6D8Wf;
        Sun, 23 Apr 2023 23:30:36 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Sun, 23 Apr
 2023 16:35:29 +0100
Date:   Sun, 23 Apr 2023 16:35:28 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v6 03/10] cxl/memdev: Warn of poison inject or clear to
 a mapped region
Message-ID: <20230423163528.00004c17@huawei.com>
In-Reply-To: <f911ca5277c9d0f9757b72d7e6842871bfff4fa2.1681874357.git.alison.schofield@intel.com>
References: <cover.1681874357.git.alison.schofield@intel.com>
        <f911ca5277c9d0f9757b72d7e6842871bfff4fa2.1681874357.git.alison.schofield@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 20:26:27 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> Inject and clear poison capabilities and intended for debug usage only.
> In order to be useful in debug environments, the driver needs to allow
> inject and clear operations on DPAs mapped in regions.
> 
> dev_warn_once() when either operation occurs.
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>

The warn for the clear says it's injecting poison.  Other than that.
(I wondered why I got two copies of a dev_warn_once() message in my
test kernel log).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/memdev.c | 58 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 3b48b6eec007..23ac8d322b37 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -160,6 +160,50 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_trigger_poison_list, CXL);
>  
> +struct cxl_dpa_to_region_context {
> +	struct cxl_region *cxlr;
> +	u64 dpa;
> +};
> +
> +static int __cxl_dpa_to_region(struct device *dev, void *arg)
> +{
> +	struct cxl_dpa_to_region_context *ctx = arg;
> +	struct cxl_endpoint_decoder *cxled;
> +	u64 dpa = ctx->dpa;
> +
> +	if (!is_endpoint_decoder(dev))
> +		return 0;
> +
> +	cxled = to_cxl_endpoint_decoder(dev);
> +	if (!cxled->dpa_res || !resource_size(cxled->dpa_res))
> +		return 0;
> +
> +	if (dpa > cxled->dpa_res->end || dpa < cxled->dpa_res->start)
> +		return 0;
> +
> +	dev_dbg(dev, "dpa:0x%llx mapped in region:%s\n", dpa,
> +		dev_name(&cxled->cxld.region->dev));
> +
> +	ctx->cxlr = cxled->cxld.region;
> +
> +	return 1;
> +}
> +
> +static struct cxl_region *cxl_dpa_to_region(struct cxl_memdev *cxlmd, u64 dpa)
> +{
> +	struct cxl_dpa_to_region_context ctx;
> +	struct cxl_port *port;
> +
> +	ctx = (struct cxl_dpa_to_region_context) {
> +		.dpa = dpa,
> +	};
> +	port = dev_get_drvdata(&cxlmd->dev);
> +	if (port && is_cxl_endpoint(port) && port->commit_end != -1)
> +		device_for_each_child(&port->dev, &ctx, __cxl_dpa_to_region);
> +
> +	return ctx.cxlr;
> +}
> +
>  static int cxl_validate_poison_dpa(struct cxl_memdev *cxlmd, u64 dpa)
>  {
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> @@ -189,6 +233,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_mbox_inject_poison inject;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_region *cxlr;
>  	int rc;
>  
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> @@ -209,6 +254,13 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  		.payload_in = &inject,
>  	};
>  	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
> +	if (rc)
> +		goto out;
> +
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	if (cxlr)
> +		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",
> +			      dpa, dev_name(&cxlr->dev));
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  
> @@ -221,6 +273,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>  	struct cxl_mbox_clear_poison clear;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_region *cxlr;
>  	int rc;
>  
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> @@ -252,6 +305,11 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
>  	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
>  	if (rc)
>  		goto out;
> +
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	if (cxlr)
> +		dev_warn_once(cxlds->dev, "poison inject dpa:0x%llx region: %s\n",

Ah. This had me confused. I got two warnings from a dev_warn_once.

Should be mentioning clearing for this one not injecting ;)

> +			      dpa, dev_name(&cxlr->dev));
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  

