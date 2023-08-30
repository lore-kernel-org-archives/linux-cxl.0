Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 993C7C83F1D
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Aug 2023 18:54:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbjH3Sww (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:52:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243464AbjH3LGK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Aug 2023 07:06:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 227891BF;
        Wed, 30 Aug 2023 04:06:06 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbLvG3V1Mz6K60k;
        Wed, 30 Aug 2023 19:01:14 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 12:06:01 +0100
Date:   Wed, 30 Aug 2023 12:06:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: Re: [PATCH] cxl/region: Clarify pointers in unregister_region()
Message-ID: <20230830120601.000043a6@Huawei.com>
In-Reply-To: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
References: <20230829-cxl-clarify-ptrs-v1-1-40e0705c6188@intel.com>
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

On Tue, 29 Aug 2023 14:47:46 -0700
Ira Weiny <ira.weiny@intel.com> wrote:

> devm_add_action_or_reset() passes a void * data parameter to the
> callback.  In the case of CXL regions, unregister_region() is passed a
> struct cxl_region *.
> 
> unregister_region() incorrectly interprets this as a struct device
> pointer.  Fortunately the device structure was the first member of
> cxl_region.  Therefore the code still works.  However, should struct
> cxl_region change the bug could be subtle.
> 
> Use the proper types in unregister_region() and extract the device
> pointer correctly.
> 
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index e115ba382e04..471d305ef675 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2018,10 +2018,11 @@ static struct cxl_region *to_cxl_region(struct device *dev)
>  	return container_of(dev, struct cxl_region, dev);
>  }
>  
> -static void unregister_region(void *dev)
> +static void unregister_region(void *_cxlr)
>  {
> -	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region *cxlr = _cxlr;
>  	struct cxl_region_params *p = &cxlr->params;
> +	struct device *dev = &cxlr->dev;
>  	int i;
>  
>  	device_del(dev);
> 
> ---
> base-commit: 1c59d383390f970b891b503b7f79b63a02db2ec5
> change-id: 20230829-cxl-clarify-ptrs-f38255b7e52b
> 
> Best regards,

