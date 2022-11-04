Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB94EC433FE
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 22:15:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbiKDWPH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229830AbiKDWPG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 18:15:06 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6278C429B8
        for <linux-cxl@vger.kernel.org>; Fri,  4 Nov 2022 15:15:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667600105; x=1699136105;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yuV2tZtVr80DFlzA96ZFM0qaHO1vS0r7eOMk4C046NI=;
  b=YlNPQ/s4BP0Rup7pTT7QvJzoFziZr57m53fe6wWys56n3lpsFeSWOc2a
   3mGFbL36PnBpGrOycodVAy7V/TXv7n7STL3vxGyKBogblYIGltdeSRna8
   HVZaqRuYNEm3l1j9F6DLjUV7BczqQNRb8QXtIF5vqzjqK8SocKR9zIsqg
   RgUSIAvRliMIgCdKHHyAhfKxeeT8E/3/nNOzNwET++BZ6WF9recY9ceK0
   9iMHfjweUnJGt8aaJOqpT1K2qACDEWj74ltjctGnIT3yN/Hjq7uVeqlQK
   rQOm3XYFqk69IzIjRG+p+irr4pOTCqwzHuYK1qvn/dM8DqrdSHM5Nz+9F
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="289813016"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="289813016"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:15:05 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="704243428"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="704243428"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.112.74]) ([10.212.112.74])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 15:15:04 -0700
Message-ID: <00e5d2b3-e5b5-00b0-a6cc-d3dfcf258743@intel.com>
Date:   Fri, 4 Nov 2022 15:15:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 7/7] cxl/region: Recycle region ids
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        ira.weiny@intel.com
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
 <166752186062.947915.13200195701224993317.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <166752186062.947915.13200195701224993317.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/3/2022 5:31 PM, Dan Williams wrote:
> At region creation time the next region-id is atomically cached so that
> there is predictability of region device names. If that region is
> destroyed and then a new one is created the region id increments. That
> ends up looking like a memory leak, or is otherwise surprising that
> identifiers roll forward even after destroying all previously created
> regions.
> 
> Try to reuse rather than free old region ids at region release time.
> 
> While this fixes a cosmetic issue, the needlessly advancing memory
> region-id gives the appearance of a memory leak, hence the "Fixes" tag,
> but no "Cc: stable" tag.
> 
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Fixes: 779dd20cfb56 ("cxl/region: Add region creation support")
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c |   20 ++++++++++++++++++++
>   1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index c0253de74945..f9ae5ad284ff 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1534,9 +1534,24 @@ static const struct attribute_group *region_groups[] = {
>   
>   static void cxl_region_release(struct device *dev)
>   {
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
>   	struct cxl_region *cxlr = to_cxl_region(dev);
> +	int id = atomic_read(&cxlrd->region_id);
> +
> +	/*
> +	 * Try to reuse the recently idled id rather than the cached
> +	 * next id to prevent the region id space from increasing
> +	 * unnecessarily.
> +	 */
> +	if (cxlr->id < id)
> +		if (atomic_try_cmpxchg(&cxlrd->region_id, &id, cxlr->id)) {
> +			memregion_free(id);
> +			goto out;
> +		}
>   
>   	memregion_free(cxlr->id);
> +out:
> +	put_device(dev->parent);
>   	kfree(cxlr);
>   }
>   
> @@ -1598,6 +1613,11 @@ static struct cxl_region *cxl_region_alloc(struct cxl_root_decoder *cxlrd, int i
>   	device_initialize(dev);
>   	lockdep_set_class(&dev->mutex, &cxl_region_key);
>   	dev->parent = &cxlrd->cxlsd.cxld.dev;
> +	/*
> +	 * Keep root decoder pinned through cxl_region_release to fixup
> +	 * region id allocations
> +	 */
> +	get_device(dev->parent);
>   	device_set_pm_not_required(dev);
>   	dev->bus = &cxl_bus_type;
>   	dev->type = &cxl_region_type;
> 
