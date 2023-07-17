Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A2AEB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 10:50:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGQKuM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 06:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGQKuK (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 06:50:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9AAE72;
        Mon, 17 Jul 2023 03:50:07 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4Jgs5Yn7z6J6qr;
        Mon, 17 Jul 2023 18:47:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 17 Jul
 2023 11:50:04 +0100
Date:   Mon, 17 Jul 2023 11:50:03 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Chenyuan Mi <michenyuan@huawei.com>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <rrichter@amd.com>, <alison.schofield@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Fix memory leak bug in alloc_mock_res()
Message-ID: <20230717115003.00007f73@Huawei.com>
In-Reply-To: <20230717041609.1162445-1-michenyuan@huawei.com>
References: <20230717041609.1162445-1-michenyuan@huawei.com>
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

On Mon, 17 Jul 2023 04:16:09 +0000
Chenyuan Mi <michenyuan@huawei.com> wrote:

> When gen_pool_alloc_algo() fails, the error handling path
> forgets to free 'res'. It would cause a memory leak bug.
> 
> Fix it by add kfree() in error handling path.
> 
> Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>

+CC linux-cxl list

Please make sure to include that for any future CXL patches.

> ---
>  tools/testing/cxl/test/cxl.c |   4 +++-
>  1 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 0e78d8e19895..250ffd147067 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -405,8 +405,10 @@ static struct cxl_mock_res *alloc_mock_res(resource_size_t size, int align)
>  	INIT_LIST_HEAD(&res->list);
>  	phys = gen_pool_alloc_algo(cxl_mock_pool, size,
>  				   gen_pool_first_fit_align, &data);
> -	if (!phys)
> +	if (!phys) {
> +		kfree(res);
>  		return NULL;
> +	}
>  
>  	res->range = (struct range) {
>  		.start = phys,

