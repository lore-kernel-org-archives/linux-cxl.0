Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC4B8C19F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiHATpP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:45:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234082AbiHATpO (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:45:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3F0F10A3
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659383112; x=1690919112;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0L+q0k0Dzpue+D1CiGmBdrBBEuTKadK7G2qppMpMWKs=;
  b=NFAB5DAE2LB825vDbo76IAqf3rzTu20B5B/IwWSRyfP1KoLetqb7RF+D
   u7hOX0Jtu5HxBJHp6r2YNWF5pxvLLBfbH5zdIKbAJtPCqF2P6gIw2eAgG
   rsAPUmT3LkyOHNYFwlWd2VZE3L7Trrw+h7YivOJJTrp2eGcohG03rR8c2
   5jyf//fzdrWrSXwmoQc51Z618nyspJ1+B1BMJ4t3dbNam9FCrJ+5MHTog
   t+L49fcfoRvHN8CZkHlEc3G6sTqCPsRzVNcLa6EBqNCRGRVv0ZUdD0zeX
   s82AWVZf52qEd7wx4Xwkx4oEcbK4NSCeno2I9wCt8pjo6XsL9e2ppcCy6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="287986677"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="287986677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:45:12 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="552635301"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:45:12 -0700
Date:   Mon, 1 Aug 2022 12:43:11 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: Re: [PATCH 5/5] cxl/region: Constrain region granularity scaling
 factor
Message-ID: <20220801194311.GD1722942@alison-desk>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165853778028.2430596.7493880465382850752.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 22, 2022 at 05:56:20PM -0700, Dan Williams wrote:
> Consider the scenario where a platform provides for a x2 host-bridge
> interleave at a granularity of 256 bytes. The only permitted region
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

I appreciate the code comments!

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

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
