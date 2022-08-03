Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD45C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 15:24:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237005AbiHCPYI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiHCPYH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 11:24:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92ADD5FDB
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 08:24:05 -0700 (PDT)
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LybBd00btz67yqQ;
        Wed,  3 Aug 2022 23:19:52 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 17:24:03 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 16:24:02 +0100
Date:   Wed, 3 Aug 2022 16:24:00 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <ira.weiny@intel.com>,
        <dave.jiang@intel.com>
Subject: Re: [PATCH 1/4] cxl/region: Fix decoder interleave programming
Message-ID: <20220803162400.000078a0@huawei.com>
In-Reply-To: <165951146336.967013.11160153960900111443.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
        <165951146336.967013.11160153960900111443.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 03 Aug 2022 00:24:23 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan notes:
> 
> "Curiously interleave ways = 1 for the EPs which is obviously wrong"
> 
> ...while testing the latest CXL development branch on QEMU.
> 
> It turns out the region creation process failed to program the endpoint
> decoders. This was missed because the default settings of x1 at 4K
> intereleave still results in the region appearing to function. Jonathan
> caught the bug by reverse mapping the translations that need to happen
> for the QEMU support.
> 
> Link: https://lore.kernel.org/r/62e95fdf9f6e2_30440294e4@dwillia2-xfh.jf.intel.com.notmuch
> Fixes: 384e624bb211 ("cxl/region: Attach endpoint decoders")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks good to me.  Minimal testing done so far.
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index cf5d5811fe4c..8e6ff3f39755 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1294,6 +1294,9 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		p->state = CXL_CONFIG_ACTIVE;
>  	}
>  
> +	cxled->cxld.interleave_ways = p->interleave_ways;
> +	cxled->cxld.interleave_granularity = p->interleave_granularity;
> +
>  	return 0;
>  
>  err_decrement:
> 

