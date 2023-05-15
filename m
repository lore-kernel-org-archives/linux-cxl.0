Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26706C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 10:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240807AbjEOKtF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 06:49:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240871AbjEOKtC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 06:49:02 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8010210DF
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 03:49:01 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKbgR0zNvz688Wb;
        Mon, 15 May 2023 18:48:03 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 11:48:56 +0100
Date:   Mon, 15 May 2023 11:48:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/5] cxl/core: Drop unused io-64-nonatomic-lo-hi.h
Message-ID: <20230515114855.0000771e@Huawei.com>
In-Reply-To: <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
        <168149844596.792294.8273108394688012953.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 14 Apr 2023 11:54:06 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> After the discovery of a case where an implementation misbehaves with
> register reads larger than the definition of the register the other
> usages of readq() were audited and found to be correct, but some cases
> where the io-64-nonatomic-lo-hi.h include is not needed were discovered,
> delete them.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Fair enough if this passes 0-day.  Everytime I try to drop
io-64-nonatomic-lo-hi.h or similar I find some weird arch choice that
needs it (mostly 32 bit arches, so maybe we don't care here).

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c |    1 -
>  drivers/cxl/core/port.c |    1 -
>  2 files changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..6198637cb0bb 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/security.h>
>  #include <linux/debugfs.h>
>  #include <linux/ktime.h>
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4d1f9c5b5029..b060757c4000 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -1,6 +1,5 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> -#include <linux/io-64-nonatomic-lo-hi.h>
>  #include <linux/memregion.h>
>  #include <linux/workqueue.h>
>  #include <linux/debugfs.h>
> 

