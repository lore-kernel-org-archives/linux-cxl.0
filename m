Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF1ACCE7A81
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 10:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjIYKMn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 06:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjIYKMk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 06:12:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71AC81A7;
        Mon, 25 Sep 2023 03:12:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvJYh5yW2z6K71Y;
        Mon, 25 Sep 2023 18:11:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 25 Sep
 2023 11:12:30 +0100
Date:   Mon, 25 Sep 2023 11:12:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Jeongtae Park <jtp.park@samsung.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>, <linux-cxl@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kyungsan Kim <ks0204.kim@samsung.com>,
        "Wonjae Lee" <wj28.lee@samsung.com>,
        Hojin Nam <hj96.nam@samsung.com>,
        Junhyeok Im <junhyeok.im@samsung.com>,
        Jehoon Park <jehoon.park@samsung.com>,
        "Jeongtae Park" <jeongtae.park@gmail.com>
Subject: Re: [PATCH v2 6/7] cxl/memdev: Fix a whitespace error
Message-ID: <20230925111229.000042c0@Huawei.com>
In-Reply-To: <20230922113636.3301482-1-jtp.park@samsung.com>
References: <CGME20230922113350epcas2p230c0ea8019d20f8ae8d246a5566d3a64@epcas2p2.samsung.com>
        <20230922113636.3301482-1-jtp.park@samsung.com>
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

On Fri, 22 Sep 2023 20:36:36 +0900
Jeongtae Park <jtp.park@samsung.com> wrote:

> ERROR: code indent should use tabs where possible
> 
> Signed-off-by: Jeongtae Park <jtp.park@samsung.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

These whitespace ones are simple enough RB feels over the top :)

Jonathan

> ---
>  drivers/cxl/core/memdev.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index f99e7ec3cc40..7e8fca4707c0 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -935,11 +935,11 @@ static void cxl_fw_cancel(struct fw_upload *fwl)
>  }
>  
>  static const struct fw_upload_ops cxl_memdev_fw_ops = {
> -        .prepare = cxl_fw_prepare,
> -        .write = cxl_fw_write,
> -        .poll_complete = cxl_fw_poll_complete,
> -        .cancel = cxl_fw_cancel,
> -        .cleanup = cxl_fw_cleanup,
> +	.prepare = cxl_fw_prepare,
> +	.write = cxl_fw_write,
> +	.poll_complete = cxl_fw_poll_complete,
> +	.cancel = cxl_fw_cancel,
> +	.cleanup = cxl_fw_cleanup,
>  };
>  
>  static void devm_cxl_remove_fw_upload(void *fwl)

