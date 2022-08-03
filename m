Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAACC19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 15:41:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbiHCPlp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbiHCPlp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 11:41:45 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2B71638D
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 08:41:43 -0700 (PDT)
Received: from fraeml743-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LybZ83ygPz682vm;
        Wed,  3 Aug 2022 23:36:48 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml743-chm.china.huawei.com (10.206.15.224) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 17:41:41 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 16:41:40 +0100
Date:   Wed, 3 Aug 2022 16:41:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH 4/4] cxl/region: Fix region commit uninitialized
 variable warning
Message-ID: <20220803164137.00003c33@huawei.com>
In-Reply-To: <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
        <165951148105.967013.14191992449932268431.stgit@dwillia2-xfh.jf.intel.com>
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

On Wed, 03 Aug 2022 00:24:41 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> 0day robot reports:
> 
> drivers/cxl/core/region.c:196 cxl_region_decode_commit() error: uninitialized symbol 'rc'.
> 
> The re-checking of loop termination conditions to determine "success"
> makes it hard to see that @rc is initialized in all cases. Remove those
> to make it explicit that @rc reflects a commit error and that the rest
> of logic is concerned with unwinding committed decoders.
> 
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One comment inline but this looks basically fine to me.
Whilst it's more indented, I'd personally slightly prefer the
bad path indented rather than using continue for the good path.

Either way

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c |   12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 5c931b6eb4e7..a68e4e0cf169 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -159,7 +159,7 @@ static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
>  static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  {
>  	struct cxl_region_params *p = &cxlr->params;
> -	int i, rc;
> +	int i, rc = 0;
>  
>  	for (i = 0; i < p->nr_targets; i++) {
>  		struct cxl_endpoint_decoder *cxled = p->targets[i];
> @@ -180,7 +180,7 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  		}
>  
>  		/* success, all decoders up to the root are programmed */
> -		if (is_cxl_root(iter))
> +		if (rc == 0)
Personally slight preference for
if (rc) {
	error handling.
}

because it makes me think a tiny bit less :)

>  			continue;
>  
>  		/* programming @iter failed, teardown */
> @@ -192,14 +192,12 @@ static int cxl_region_decode_commit(struct cxl_region *cxlr)
>  		}
>  
>  		cxled->cxld.reset(&cxled->cxld);
> -		if (i == 0)

Possibly worth calling out in patch description that
cxl_region_decode_reset() is a noop if i == 0
so this special path wasn't needed before this patch.

> -			return rc;
> -		break;
> +		goto err;
>  	}
>  
> -	if (i >= p->nr_targets)
> -		return 0;
> +	return 0;
>  
> +err:
>  	/* undo the targets that were successfully committed */
>  	cxl_region_decode_reset(cxlr, i);
>  	return rc;
> 

