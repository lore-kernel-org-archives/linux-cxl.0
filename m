Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB971C6FD1D
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 17:28:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjC3R2M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 30 Mar 2023 13:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbjC3R2L (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 30 Mar 2023 13:28:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713EBD52B
        for <linux-cxl@vger.kernel.org>; Thu, 30 Mar 2023 10:28:10 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PnVdz17pgz6J9ZP;
        Fri, 31 Mar 2023 01:24:23 +0800 (CST)
Received: from localhost (10.48.159.148) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 30 Mar
 2023 18:28:08 +0100
Date:   Thu, 30 Mar 2023 18:28:07 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH] cxl/region: Move coherence tracking into
 cxl_region_attach()
Message-ID: <20230330182807.0000662a@Huawei.com>
In-Reply-To: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
References: <168002858817.50647.1217607907088920888.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.159.148]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 28 Mar 2023 11:36:28 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Each time the contents of a given HPA are potentially changed in a cache
> incoherent manner the CXL core sets CXL_REGION_F_INCOHERENT to
> invalidate CPU caches before the region is used.
> 
> Successful invocation of attach_target() indicates that DPA has been
> newly assigned to a given HPA in the dynamic region creation flow.
> However, attach_target() is also reused in the autodiscovery flow where
> the region was activated by platform firmware. In that case there is no
> need to invalidate caches because that region is already in active use
> and nothing about the autodiscovery flow modifies the HPA-to-DPA
> relationship.
> 
> Fixes: a32320b71f08 ("cxl/region: Add region autodiscovery")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Looks correct to me.  Might be worth making it clear in the patch description
that for auto discovered regions, we have exited cxl_region_attach()
before the point where you set the flag.

I'm also fairly sure that in previous flow the cache flush was happening on
each target being added rather than just on the final one being added which
would be a significant overhead also avoided via this patch.

Jonathan

> ---
>  drivers/cxl/core/region.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 52bbf6268d5f..b2fd67fcebfb 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1674,6 +1674,7 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		if (rc)
>  			goto err_decrement;
>  		p->state = CXL_CONFIG_ACTIVE;
> +		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  	}
>  
>  	cxled->cxld.interleave_ways = p->interleave_ways;
> @@ -1775,8 +1776,6 @@ static int attach_target(struct cxl_region *cxlr,
>  
>  	down_read(&cxl_dpa_rwsem);
>  	rc = cxl_region_attach(cxlr, cxled, pos);
> -	if (rc == 0)
> -		set_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>  	up_read(&cxl_dpa_rwsem);
>  	up_write(&cxl_region_rwsem);
>  	return rc;
> 

