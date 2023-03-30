Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DABB0C77B60
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 18:55:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229895AbjC3Szw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 14:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjC3Szv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 14:55:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74D6DE
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 11:55:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnXb55jg6z6J9Zd;
        Fri, 31 Mar 2023 02:52:01 +0800 (CST)
Received: from localhost (10.195.247.161) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 19:55:46 +0100
Date:   Thu, 30 Mar 2023 19:55:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v5 03/12] cxl/memdev: Warn of poison inject or clear to
 a mapped region
Message-ID: <20230330195546.00004774@Huawei.com>
In-Reply-To: <fc7db7de4778803a3221d7fd5a203bf971fdac61.1679892337.git.alison.schofield@intel.com>
References: <cover.1679892337.git.alison.schofield@intel.com>
        <fc7db7de4778803a3221d7fd5a203bf971fdac61.1679892337.git.alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.247.161]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 26 Mar 2023 22:03:09 -0700
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
> ---
>  drivers/cxl/core/memdev.c | 59 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 59 insertions(+)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 0e39c3c3fb09..a83619c31f61 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -213,6 +213,50 @@ ssize_t cxl_trigger_poison_list(struct device *dev,
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
If we have a match, little point in letting walk continue.

return 1;

Also, I "think" we just know that the association has been built.
Injecting poison is probably still fine if the region / decoder hasn't yet
been committed.

Jonathan


> +	return 0;
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
> @@ -242,6 +286,7 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_mbox_inject_poison inject;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_region *cxlr;
>  	int rc;
>  
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> @@ -261,6 +306,13 @@ int cxl_inject_poison(struct device *dev, u64 dpa)
>  		.payload_in = &inject,
>  	};
>  	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> +	if (rc)
> +		goto out;
> +
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	if (cxlr)
> +		dev_warn_once(dev, "poison inject dpa:0x%llx region: %s\n",
> +			      dpa, dev_name(&cxlr->dev));
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  
> @@ -273,6 +325,7 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_mbox_clear_poison clear;
>  	struct cxl_mbox_cmd mbox_cmd;
> +	struct cxl_region *cxlr;
>  	int rc;
>  
>  	if (!IS_ENABLED(CONFIG_DEBUG_FS))
> @@ -303,7 +356,13 @@ int cxl_clear_poison(struct device *dev, u64 dpa)
>  	};
>  
>  	rc = cxl_internal_send_cmd(cxlmd->cxlds, &mbox_cmd);
> +	if (rc)
> +		goto out;
>  
> +	cxlr = cxl_dpa_to_region(cxlmd, dpa);
> +	if (cxlr)
> +		dev_warn_once(dev, "poison clear dpa:0x%llx region: %s\n",
> +			      dpa, dev_name(&cxlr->dev));
>  out:
>  	up_read(&cxl_dpa_rwsem);
>  

