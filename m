Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B41DC77B7F
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 16:36:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbjEKQgl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 12:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238548AbjEKQgk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 12:36:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B308DF5
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 09:36:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QHHYX0H70z67fjq;
        Fri, 12 May 2023 00:34:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Thu, 11 May
 2023 17:36:36 +0100
Date:   Thu, 11 May 2023 17:36:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>
Subject: Re: [RESEND PATCH v2] cxl: Warn of flexible array in struct
 cxl_root_decoder
Message-ID: <20230511173635.00005a70@Huawei.com>
In-Reply-To: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
References: <168261044311.369593.10950998135160952191.stgit@djiang5-mobl3>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 27 Apr 2023 08:47:23 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> The 'cxl_switch_decoder' member in 'cxl_root_decoder' must be the last
> element due to 'cxl_switch_decoder' has a flexible array at the
> end of the struct. Any variables placed after will be corrupted.
> Add a warning comment to 'cxl_root_decoder'.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Ugly requirement, so comment good to have.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> v2:
> - Clarify subject (Alison)
> - Fit comment under 80 chars. (Alison)
> ---
>  drivers/cxl/cxl.h |    1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 044a92d9813e..7db7e217b6f3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -419,6 +419,7 @@ struct cxl_root_decoder {
>  	cxl_calc_hb_fn calc_hb;
>  	void *platform_data;
>  	struct mutex range_lock;
> +	/* Must be the last member. Struct contains a flexible array */
>  	struct cxl_switch_decoder cxlsd;
>  };
>  
> 
> 

