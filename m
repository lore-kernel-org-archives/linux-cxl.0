Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D3FDC64EC4
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Mar 2023 12:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbjCCMPd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Mar 2023 07:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCCMPb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Mar 2023 07:15:31 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F209A24C85
        for <linux-cxl@vger.kernel.org>; Fri,  3 Mar 2023 04:15:27 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PSn150VRRz6J9Vc;
        Fri,  3 Mar 2023 20:12:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 3 Mar
 2023 12:15:24 +0000
Date:   Fri, 3 Mar 2023 12:15:23 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <dan.j.williams@intel.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: fix compile warning for cxl_security_ops extern
Message-ID: <20230303121523.000064b2@Huawei.com>
In-Reply-To: <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
References: <20230228150911.00002535@Huawei.com>
        <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 01 Mar 2023 16:06:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Jonathan says he has observed compiler warning when using running with W=1
> C=1 for cxl_security_ops that is declared as an extern in cxl/pmem.c. Move
> to cxl.h to make it visible to all cxl sources.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Hi Jonathan, I was not able to reproduce the issue with W=1 C=1. Can you
> please see if this fixes what you were seeing? Thanks!

Meh. Compiler version difference I guess.

This indeed 'fixes' it. Thanks!

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
>  drivers/cxl/cxl.h  |    2 ++
>  drivers/cxl/pmem.c |    2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f2b0962a552d..6f00b938f342 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -10,6 +10,8 @@
>  #include <linux/log2.h>
>  #include <linux/io.h>
>  
> +extern const struct nvdimm_security_ops *cxl_security_ops;
> +
>  /**
>   * DOC: cxl objects
>   *
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 71cfa1fdf902..55930567fc01 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -11,8 +11,6 @@
>  #include "cxlmem.h"
>  #include "cxl.h"
>  
> -extern const struct nvdimm_security_ops *cxl_security_ops;
> -
>  static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  
>  static void clear_exclusive(void *cxlds)
> 
> 

