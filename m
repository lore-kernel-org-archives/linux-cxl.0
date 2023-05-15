Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00AC3C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 09:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238273AbjEOJ43 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237368AbjEOJzr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 05:55:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DBF1BD7
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 02:55:15 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKZ1829PQz6J6tj;
        Mon, 15 May 2023 17:33:16 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 10:37:23 +0100
Date:   Mon, 15 May 2023 10:37:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <dave.jiang@intel.com>, <ira.weiny@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] tools/testing/cxl: Use DEFINE_STATIC_SRCU()
Message-ID: <20230515103722.00004a06@Huawei.com>
In-Reply-To: <168392709546.1135523.10424917245934547117.stgit@dwillia2-xfh.jf.intel.com>
References: <168392709546.1135523.10424917245934547117.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 12 May 2023 14:31:35 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Starting with commit:
> 
> 95433f726301 ("srcu: Begin offloading srcu_struct fields to srcu_update")
> 
> ...it is no longer possible to do:
> 
> static DEFINE_SRCU(x)
> 
> Switch to DEFINE_STATIC_SRCU(x) to fix:
> 
> tools/testing/cxl/test/mock.c:22:1: error: duplicate ‘static’
>    22 | static DEFINE_SRCU(cxl_mock_srcu);
>       | ^~~~~~
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I guess this got missed because of hiding kernel code in tools :)
(not that I want to restart that 'discussion / argument')

Jonathan


> ---
>  tools/testing/cxl/test/mock.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index c4e53f22e421..de3933a776fd 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -19,7 +19,7 @@ void register_cxl_mock_ops(struct cxl_mock_ops *ops)
>  }
>  EXPORT_SYMBOL_GPL(register_cxl_mock_ops);
>  
> -static DEFINE_SRCU(cxl_mock_srcu);
> +DEFINE_STATIC_SRCU(cxl_mock_srcu);
>  
>  void unregister_cxl_mock_ops(struct cxl_mock_ops *ops)
>  {
> 

