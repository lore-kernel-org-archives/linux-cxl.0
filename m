Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C971C41513
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Aug 2023 13:34:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234000AbjHGNeR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Aug 2023 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234171AbjHGNeK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Aug 2023 09:34:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DDA19B6
        for <linux-cxl@vger.kernel.org>; Mon,  7 Aug 2023 06:33:56 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RKHFz5J3Nz6HJcL;
        Mon,  7 Aug 2023 21:28:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 7 Aug
 2023 14:33:35 +0100
Date:   Mon, 7 Aug 2023 14:33:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <alison.schofield@intel.com>
CC:     Davidlohr Bueso <dave@stgolabs.net>,
        Dave Jiang <dave.jiang@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-cxl@vger.kernel.org>,
        "Andy Shevchenko" <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH] cxl/mbox: Remove useless cast in
 cxl_mem_create_range_info()
Message-ID: <20230807143334.00005448@Huawei.com>
In-Reply-To: <20230804190309.1665132-1-alison.schofield@intel.com>
References: <20230804190309.1665132-1-alison.schofield@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri,  4 Aug 2023 12:03:09 -0700
alison.schofield@intel.com wrote:

> From: Alison Schofield <alison.schofield@intel.com>
> 
> DEFINE_RES_MEM() returns a struct resource so the cast is not needed.
> Remove it.
> 
> Found using sparse:
> drivers/cxl/core/mbox.c:1184:18: warning: cast to non-scalar
> drivers/cxl/core/mbox.c:1184:18: warning: cast from non-scalar
> 
> Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Good to call out this is a result of Andy's cleanup

42c4211f1 ("resource: Convert DEFINE_RES_NAMED() to be a compound literal")

I thought we'd long caught all of these (IIRC there were a few at the time).
Ah well.

Jonathan

> ---
>  drivers/cxl/core/mbox.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..01de4b438b2a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1180,8 +1180,7 @@ int cxl_mem_create_range_info(struct cxl_memdev_state *mds)
>  		return 0;
>  	}
>  
> -	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, mds->total_bytes);
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, mds->total_bytes);
>  
>  	if (mds->partition_align_bytes == 0) {
>  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> 
> base-commit: fe77cc2e5a6a7c85f5c6ef8a39d7694ffc7f41c9

