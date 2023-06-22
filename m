Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FEDEB64D8
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 09:26:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231901AbjFVJ0N convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 05:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjFVJZs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 05:25:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC4AC2704
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 02:15:00 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QmvlR113jz6DB4F;
        Thu, 22 Jun 2023 17:12:19 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 10:14:58 +0100
Date:   Thu, 22 Jun 2023 10:14:57 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/region: Flag partially torn down regions as
 unusable
Message-ID: <20230622101457.00001c11@Huawei.com>
In-Reply-To: <168696507423.3590522.16254212607926684429.stgit@dwillia2-xfh.jf.intel.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
        <168696507423.3590522.16254212607926684429.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Jun 2023 18:24:34 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> cxl_region_decode_reset() walks all the decoders associated with a given
> region and disables them. Due to decoder ordering rules it is possible
> that a switch in the topology notices that a given decoder can not be
> shutdown before another region with a higher HPA is shutdown first. That
> can leave the region in a partially committed state.
> 
> Capture that state in a new CXL_REGION_F_NEEDS_RESET flag and require
> that a successful cxl_region_decode_reset() attempt must be completed
> before cxl_region_probe() accepts the region.
> 
> This is a corollary for the bug that Jonathan identified in "CXL/region
> :  commit reset of out of order region appears to succeed." [1].
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Link: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com [1]
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I'm sure I understood this flow better a while back....
I think this is right. The subtlety that had me for a while was a fialure
of the first cxld->reset() but if that fails we can assume that all decoders
are still in place so I think we are fine.

I wonder if a better approach (though heavy for a fix?) is a prepass
that checks it is possible to tear the region down, followed by actually doing it
(all under appropriate locking so state doesn't change on us)
That way no intermediate half torn down states to worry about in the state machine.

From a spec side of things I've never been convinced the ordering rules make sense.
Some hardware / firmware simplification at cost of nasty software limitations.

Jonathan


> ---
>  drivers/cxl/core/region.c |   12 ++++++++++++
>  drivers/cxl/cxl.h         |    8 ++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index d48c5916f2e9..31f498f0fb3a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -182,14 +182,19 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  				rc = cxld->reset(cxld);
>  			if (rc)
>  				return rc;
> +			set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  		}
>  
>  endpoint_reset:
>  		rc = cxled->cxld.reset(&cxled->cxld);
>  		if (rc)
>  			return rc;
> +		set_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
>  	}
>  
> +	/* all decoders associated with this region have been torn down */
> +	clear_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags);
> +
>  	return 0;
>  }
>  
> @@ -2876,6 +2881,13 @@ static int cxl_region_probe(struct device *dev)
>  		goto out;
>  	}
>  
> +	if (test_bit(CXL_REGION_F_NEEDS_RESET, &cxlr->flags)) {
> +		dev_err(&cxlr->dev,
> +			"failed to activate, re-commit region and retry\n");
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
>  	/*
>  	 * From this point on any path that changes the region's state away from
>  	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 187abd8ba673..cd7bf6697a51 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -469,6 +469,14 @@ struct cxl_region_params {
>   */
>  #define CXL_REGION_F_AUTO 0
>  
> +/*
> + * Require that a committed region successfully complete a teardown once
> + * any of its associated decoders have been torn down. This maintains
> + * the commit state for the region since there are committed decoders,
> + * but blocks cxl_region_probe().
> + */
> +#define CXL_REGION_F_NEEDS_RESET 1
> +
>  /**
>   * struct cxl_region - CXL region
>   * @dev: This region's device
> 

