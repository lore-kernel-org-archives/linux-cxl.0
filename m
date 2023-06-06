Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E183C7EE24
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Jun 2023 12:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236071AbjFFMg5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 6 Jun 2023 08:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232229AbjFFMg4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 6 Jun 2023 08:36:56 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66469E5D
        for <linux-cxl@vger.kernel.org>; Tue,  6 Jun 2023 05:36:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb90Z2v0Pz67fps;
        Tue,  6 Jun 2023 20:34:54 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 13:36:52 +0100
Date:   Tue, 6 Jun 2023 13:36:51 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 07/19] cxl/region: Manage decoder target_type at
 decoder-attach time
Message-ID: <20230606133651.00004f8d@Huawei.com>
In-Reply-To: <168592153599.1948938.3754212703217628741.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592153599.1948938.3754212703217628741.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:32:16 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Switch-level (mid-level) decoders between the platform root and an
> endpoint can dynamically switch modes between HDM-H and HDM-D[B]
> depending on which region they target. Use the region type to fixup each
> decoder that gets allocated to map the given region.
> 
> Note that endpoint decoders are meant to determine the region type, so
> warn if those ever need to be fixed up, but since it is possible to
> continue do so.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index dca94c458b8f..c7170d92f47f 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -809,6 +809,18 @@ static int cxl_rr_alloc_decoder(struct cxl_port *port, struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> +	/*
> +	 * Endpoints should already match the region type, but backstop that
> +	 * assumption with an assertion. Switch-decoders change mapping-type
> +	 * based on what is mapped when they are assigned to a region.
> +	 */
> +	dev_WARN_ONCE(&cxlr->dev,
> +		      port == cxled_to_port(cxled) &&
> +			      cxld->target_type != cxlr->type,
> +		      "%s:%s mismatch decoder type %d -> %d\n",
> +		      dev_name(&cxled_to_memdev(cxled)->dev),
> +		      dev_name(&cxld->dev), cxld->target_type, cxlr->type);
> +	cxld->target_type = cxlr->type;
>  	cxl_rr->decoder = cxld;
>  	return 0;
>  }
> 

