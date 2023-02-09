Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC14C636D6
	for <linux-cxl@archiver.kernel.org>; Thu,  9 Feb 2023 16:02:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjBIQCz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 9 Feb 2023 11:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbjBIQCy (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 9 Feb 2023 11:02:54 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CCA860B91
        for <linux-cxl@vger.kernel.org>; Thu,  9 Feb 2023 08:02:52 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCLg760Qxz67W0D;
        Thu,  9 Feb 2023 23:40:51 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 15:45:19 +0000
Date:   Thu, 9 Feb 2023 15:45:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl/mem: Correct full ID range allocation
Message-ID: <20230209154518.000011a7@Huawei.com>
In-Reply-To: <20230208181944.240261-1-dave@stgolabs.net>
References: <20230208181944.240261-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed,  8 Feb 2023 10:19:44 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> For ID allocations we want 0-(max-1), ie: smatch complains:
> 
> 	 error: Calling ida_alloc_range() with a 'max' argument which is a power of 2. -1 missing?
> 
> Correct this and also replace the call to use the max() flavor instead.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I'm not sure I follow the smatch error always applying, but definitely suspicious here

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/memdev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..12bd9ddaba22 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -242,7 +242,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>  	if (!cxlmd)
>  		return ERR_PTR(-ENOMEM);
>  
> -	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>  	if (rc < 0)
>  		goto err;
>  	cxlmd->id = rc;

