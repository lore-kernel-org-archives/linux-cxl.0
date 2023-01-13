Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0D4CC61DB3
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 14:12:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241320AbjAMOMi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 09:12:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241624AbjAMOMQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 09:12:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1768E995
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 06:08:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NtjpQ5Prlz67Qtq;
        Fri, 13 Jan 2023 22:04:30 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 14:08:18 +0000
Date:   Fri, 13 Jan 2023 14:08:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 8/8] cxl: remove locked check for
 dvsec_range_allowed()
Message-ID: <20230113140817.000022b1@Huawei.com>
In-Reply-To: <167330065180.975161.18302590071676919347.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330065180.975161.18302590071676919347.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 09 Jan 2023 14:44:13 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> There is no reason that the CFMWS will always set the "Fixed Device
> Configuration" bit in the "Window Restrictions" field. Remove the
> CXL_DECODER_F_LOCK check.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Makes sense to me though I'd be curious why someone added the check in
the first place...
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c6d6d7b720c5..931ac4be539a 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -228,8 +228,6 @@ static int dvsec_range_allowed(struct device *dev, void *arg)
>  
>  	cxld = to_cxl_decoder(dev);
>  
> -	if (!(cxld->flags & CXL_DECODER_F_LOCK))
> -		return 0;
>  	if (!(cxld->flags & CXL_DECODER_F_RAM))
>  		return 0;
>  
> 
> 

