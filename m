Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2E9AEB64DA
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Jun 2023 09:28:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbjFVJ2B (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 22 Jun 2023 05:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231414AbjFVJ1e (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 22 Jun 2023 05:27:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B41F2D40
        for <linux-cxl@vger.kernel.org>; Thu, 22 Jun 2023 02:18:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qmvrm5J67z6J6FS;
        Thu, 22 Jun 2023 17:16:56 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 22 Jun
 2023 10:18:03 +0100
Date:   Thu, 22 Jun 2023 10:18:02 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/region: Fix state transitions after reset
 failure
Message-ID: <20230622101802.00003556@Huawei.com>
In-Reply-To: <168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com>
References: <168696506332.3590522.12981963617215460385.stgit@dwillia2-xfh.jf.intel.com>
        <168696507968.3590522.14484000711718573626.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Jun 2023 18:24:39 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan reports that failed attempts to reset a region (teardown its
> HDM decoder configuration) mistakenly advance the state of the region
> to "not committed". Revert to the previous state of the region on reset
> failure so that the reset can be re-attempted.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Closes: http://lore.kernel.org/r/20230316171441.0000205b@Huawei.com
> Fixes: 176baefb2eb5 ("cxl/hdm: Commit decoder state to hardware")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
LGTM - though maybe even nicer if we can be pretty sure this will succeed
before trying it.. (same comment as previous patch)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/cxl/core/region.c |   26 +++++++++++++++-----------
>  1 file changed, 15 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 31f498f0fb3a..38db377e13f1 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -296,9 +296,11 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  	if (rc)
>  		return rc;
>  
> -	if (commit)
> +	if (commit) {
>  		rc = cxl_region_decode_commit(cxlr);
> -	else {
> +		if (rc == 0)
> +			p->state = CXL_CONFIG_COMMIT;
> +	} else {
>  		p->state = CXL_CONFIG_RESET_PENDING;
>  		up_write(&cxl_region_rwsem);
>  		device_release_driver(&cxlr->dev);
> @@ -308,18 +310,20 @@ static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
>  		 * The lock was dropped, so need to revalidate that the reset is
>  		 * still pending.
>  		 */
> -		if (p->state == CXL_CONFIG_RESET_PENDING)
> +		if (p->state == CXL_CONFIG_RESET_PENDING) {
>  			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
> +			/*
> +			 * Revert to committed since there may still be active
> +			 * decoders associated with this region, or move forward
> +			 * to active to mark the reset successful
> +			 */
> +			if (rc)
> +				p->state = CXL_CONFIG_COMMIT;
> +			else
> +				p->state = CXL_CONFIG_ACTIVE;
> +		}
>  	}
>  
> -	if (rc)
> -		goto out;
> -
> -	if (commit)
> -		p->state = CXL_CONFIG_COMMIT;
> -	else if (p->state == CXL_CONFIG_RESET_PENDING)
> -		p->state = CXL_CONFIG_ACTIVE;
> -
>  out:
>  	up_write(&cxl_region_rwsem);
>  
> 

