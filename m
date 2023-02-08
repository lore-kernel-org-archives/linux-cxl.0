Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF3CC636D3
	for <linux-cxl@archiver.kernel.org>; Wed,  8 Feb 2023 23:50:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbjBHXuF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 8 Feb 2023 18:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjBHXuE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 8 Feb 2023 18:50:04 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F4030EE
        for <linux-cxl@vger.kernel.org>; Wed,  8 Feb 2023 15:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675900202; x=1707436202;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=SYQhMYG3Vg+R1XwA5IkrRq+88eN1Re4OeIzHmMIR4ZU=;
  b=epeuU2uoDdM7WUV6nsl/rjAdYnVx8S31BRZLKcunQbFqDLXiwsGOB671
   3TtHQ5u1xopeLQYB5XpRteKgwz8/0HiooptUr9IvJPGQkmrZge5x3Z3Bv
   iDHCkpP4iQh7O7KXomXaawGGfrbTN8hjjzOM/6+7lUM5fNT2Vdm9nbOaJ
   GsLqXHrw/9fUeMtjRRBZjbwzPH+gMc5sAL/UnaTPq4Ba4DREn1gHyQlM9
   X5cpaNcSNwJWukPl81RfdFLliQlE5fZ73MrytkcVtsSC5Xg+SiIyWZd6z
   npvWfjYnAJ4rsKzUVhdqPOsz+Mz7Hqww7DUQgCC9Tb+dj8cDcZkD1MrqM
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="357361689"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="357361689"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 15:50:02 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="776253401"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="776253401"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.48.215]) ([10.212.48.215])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 15:50:01 -0800
Message-ID: <44e69271-bcdc-8389-d9d0-9761db5108bf@intel.com>
Date:   Wed, 8 Feb 2023 16:50:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH] cxl/mem: Correct full ID range allocation
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     linux-cxl@vger.kernel.org
References: <20230208181944.240261-1-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230208181944.240261-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/8/23 11:19 AM, Davidlohr Bueso wrote:
> For ID allocations we want 0-(max-1), ie: smatch complains:
> 
> 	 error: Calling ida_alloc_range() with a 'max' argument which is a power of 2. -1 missing?
> 
> Correct this and also replace the call to use the max() flavor instead.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/memdev.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index a74a93310d26..12bd9ddaba22 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -242,7 +242,7 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
>   	if (!cxlmd)
>   		return ERR_PTR(-ENOMEM);
>   
> -	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
> +	rc = ida_alloc_max(&cxl_memdev_ida, CXL_MEM_MAX_DEVS - 1, GFP_KERNEL);
>   	if (rc < 0)
>   		goto err;
>   	cxlmd->id = rc;
