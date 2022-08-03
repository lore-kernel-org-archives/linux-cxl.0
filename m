Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00B30C19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 16:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiHCQRl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 12:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235741AbiHCQRk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 12:17:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA361C13E
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 09:17:37 -0700 (PDT)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LycNN2nsYz67yKy;
        Thu,  4 Aug 2022 00:13:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 18:17:34 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 17:17:34 +0100
Date:   Wed, 3 Aug 2022 17:17:32 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 5/5] cxl/region: Constrain region granularity scaling
 factor
Message-ID: <20220803171732.0000482d@huawei.com>
In-Reply-To: <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
        <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
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

On Fri, 22 Jul 2022 17:56:20 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Consider the scenario where a platform provides for a x2 host-bridge
> interleave at a granularity of 256 bytes.
Hi Dan,

Terminology not clear to me.  Is this interleave across 2 host bridges?

I'm lost in the explanation.

> The only permitted region
> granularities for that configuration are 256 or 512. Anything larger
> than 512 results in unmapped capacity within a given decoder. Also, if
> the region granularity is 512 then the interleave_ways for the region
> must be 4 to keep the scaling matched.
> 
> Here are the translations for the first (4) 256-byte blocks where an
> endpoint decoder is configured for a 512-byte granularity:
> 
> Block[0] => HB0 => DPA: 0
> Block[1] => HB1 => DPA: 0
> Block[2] => HB0 => DPA: 0
> Block[3] => HB1 => DPA: 0
> 
> In order for those translations to not alias the region interleave ways
> must be 4 resulting in:
> 
> Block[0] => HB0 => Dev0 => DPA: 0
> Block[1] => HB1 => Dev1 => DPA: 0
> Block[2] => HB0 => Dev2 => DPA: 0
> Block[3] => HB1 => Dev3 => DPA: 0

Block[4] => HBA0 => Dev0 => DPA: 512 ?

which means we are only using alternate 256 blocks of the EP.  Does that make
sense?

> 
> ...not 2, resulting in:
> 
> Block[0] => HB0 => Dev0 => DPA: 0
> Block[1] => HB1 => Dev1 => DPA: 0
> Block[2] => HB0 => Dev0 => DPA: 0 !
> Block[3] => HB1 => Dev1 => DPA: 0 !

> 
> Given tooling is already being built around this ABI allow for
> granularity and ways to be set in either order and validate the
> combination once both are set.
> 
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Typo inline.

> ---
>  drivers/cxl/core/region.c |   63 +++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 60 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 05b6212e6399..a34e537e4cb2 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -348,6 +348,25 @@ static ssize_t interleave_ways_store(struct device *dev,
>  		goto out;
>  	}
>  
> +	/*
> +	 * If region granularity has been set and xHB interleave is active,
> +	 * validate that granularity is compatible with specified ways.
> +	 * Otherwise allow ways to be set now and depend on
> +	 * interleave_granularity_store() to validate this constraint.
> +	 */
> +	if (cxld->interleave_ways > 1 &&
> +	    p->interleave_granularity > cxld->interleave_granularity &&
> +	    p->interleave_granularity / cxld->interleave_granularity !=
> +		    val / cxld->interleave_ways) {
> +		dev_dbg(dev,
> +			"ways scaling factor %d mismatch with granularity %d\n",
> +			val / cxld->interleave_ways,
> +			p->interleave_granularity /
> +				cxld->interleave_granularity);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
>  	save = p->interleave_ways;
>  	p->interleave_ways = val;
>  	rc = sysfs_update_group(&cxlr->dev.kobj, get_cxl_region_target_group());
> @@ -386,7 +405,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region *cxlr = to_cxl_region(dev);
>  	struct cxl_region_params *p = &cxlr->params;
> -	int rc, val;
> +	int rc, val, ways;
>  	u16 ig;
>  
>  	rc = kstrtoint(buf, 0, &val);
> @@ -403,9 +422,29 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	 * granularity less than the root interleave result in needing
>  	 * multiple endpoints to support a single slot in the
>  	 * interleave.
> +	 *
> +	 * When the root interleave ways is 1 then the root granularity is a
> +	 * don't care.
> +	 *
> +	 * Limit region granularity to cxld->interleave_granularity *
> +	 * rounddown_pow_of_two(cxld->interleave_ways) otherwise holes result in
> +	 * the decode at each endpoint. Note that rounddown_pow_of_two()
> +	 * accounts for x3, x6, and x9 root intereleave.

interleave

>  	 */
> -	if (val < cxld->interleave_granularity)
> -		return -EINVAL;
> +	ways = rounddown_pow_of_two(cxld->interleave_ways);
> +	if (ways > 1) {
> +		if (val < cxld->interleave_granularity) {
> +			dev_dbg(dev, "granularity %d must be >= %d\n", val,
> +				cxld->interleave_granularity);
> +			return -EINVAL;
> +		}
> +
> +		if (val > cxld->interleave_granularity * ways) {
> +			dev_dbg(dev, "granularity %d must be <= %d\n", val,
> +				cxld->interleave_granularity * ways);
> +			return -EINVAL;
> +		}
> +	}
>  
>  	rc = down_write_killable(&cxl_region_rwsem);
>  	if (rc)
> @@ -415,6 +454,24 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  		goto out;
>  	}
>  
> +	/*
> +	 * If region ways has been set and xHB interleave is active, validate
> +	 * that ways is compatible with specified granularity.  Otherwise allow
> +	 * granularity to be set now and depend on interleave_ways_store() to
> +	 * validate this constraint.
> +	 */
> +	if (cxld->interleave_ways > 1 && p->interleave_ways &&
> +	    val > cxld->interleave_granularity &&
> +	    p->interleave_ways / cxld->interleave_ways !=
> +		    val / cxld->interleave_granularity) {
> +		dev_dbg(dev,
> +			"granularity scaling factor %d mismatch with ways %d\n",
> +			val / cxld->interleave_granularity,
> +			p->interleave_ways / cxld->interleave_ways);
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
>  	p->interleave_granularity = val;
>  out:
>  	up_write(&cxl_region_rwsem);
> 
> 

