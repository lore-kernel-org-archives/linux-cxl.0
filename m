Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DE76C4332F
	for <linux-cxl@archiver.kernel.org>; Fri, 16 Dec 2022 11:16:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiLPLQe (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 16 Dec 2022 06:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiLPLQL (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 16 Dec 2022 06:16:11 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0B15566CE
        for <linux-cxl@vger.kernel.org>; Fri, 16 Dec 2022 03:16:05 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NYRKL5Bmwz6H74X;
        Fri, 16 Dec 2022 19:12:54 +0800 (CST)
Received: from localhost (10.45.152.125) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 16 Dec
 2022 11:16:02 +0000
Date:   Fri, 16 Dec 2022 11:15:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <mcgrof@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2] cxl/region: Only warn about
 cpu_cache_invalidate_memregion() once
Message-ID: <20221216111558.000003c3@Huawei.com>
In-Reply-To: <20221215183836.24136-1-dave@stgolabs.net>
References: <20221215183836.24136-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.152.125]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 15 Dec 2022 10:38:36 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> No need for more than once per region.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 02f28da519e3..c11a6ab5e48d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1967,7 +1967,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>  
>  	if (!cpu_cache_has_invalidate_memregion()) {
>  		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> -			dev_warn(
> +			dev_warn_once(
>  				&cxlr->dev,
>  				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>  			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);

Seems sensible.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
