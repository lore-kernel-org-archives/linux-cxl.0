Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A90BC54EBD
	for <linux-cxl@archiver.kernel.org>; Mon,  9 Jan 2023 14:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229530AbjAIOTt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 9 Jan 2023 09:19:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbjAIOTX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 9 Jan 2023 09:19:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C415D167EF
        for <linux-cxl@vger.kernel.org>; Mon,  9 Jan 2023 06:19:20 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NrGGT4Xglz67PvV;
        Mon,  9 Jan 2023 22:16:49 +0800 (CST)
Received: from localhost (10.45.145.18) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 9 Jan
 2023 14:19:18 +0000
Date:   Mon, 9 Jan 2023 14:19:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl: fix cxl_report_and_clear() RAS UE addr
 mis-assignment
Message-ID: <20230109141918.00001f48@Huawei.com>
In-Reply-To: <167302318779.580155.15233596744650706167.stgit@djiang5-mobl3.local>
References: <167302318779.580155.15233596744650706167.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.45.145.18]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 06 Jan 2023 09:39:49 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> 'addr' that contains RAS UE register address is re-assigned to
> RAS_CAP_CONTROL offset if there are multiple UE errors. Use different addr
> variable to avoid the reassignment mistake.
> 
> Fixes: 2905cb5236cb ("cxl/pci: Add (hopeful) error handling support")
> Reported-by: Jonathan Cameron <jonathan.cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Exactly what I expected. Thanks for the quick turn around.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

I'm working on adding multiple header log handling on top of your
code.  Will hopefully have something to share on that later in the week.

> ---
>  drivers/cxl/pci.c |    7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 33083a522fd1..258004f34281 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -554,8 +554,11 @@ static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
>  
>  	/* If multiple errors, log header points to first error from ctrl reg */
>  	if (hweight32(status) > 1) {
> -		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> -		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK, readl(addr)));
> +		void __iomem *rcc_addr =
> +			cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
> +
> +		fe = BIT(FIELD_GET(CXL_RAS_CAP_CONTROL_FE_MASK,
> +				   readl(rcc_addr)));
>  	} else {
>  		fe = status;
>  	}
> 
> 

