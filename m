Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79628C6FA9D
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 15:45:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjCAPpt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 10:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjCAPpt (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 10:45:49 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64FEA125B7
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 07:45:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677685548; x=1709221548;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9FjLy1Z8YhxTWe2QdViwIKTvRVdSHhvi/ww6HcHXY50=;
  b=HgkEZbs5xMpOq+SBTSfOBzs4zYCKfYKk15MnKXIgGEQMxKbrZ+nxJ0U/
   U78mCJxryy76MhLwj1/DBJQQA5cT0mSPXwoli46IAjeEFZF/xPZphjOoJ
   iIvkqj2+mCO/MyIi8FIrzIIxUOli/BSC8gfSIUBRoGal0uHLRc7201c94
   SY1segaShsBXmgqYKOaTAg34fDiJKYxCsrDLqu7PGo+NuMJ3ADT6zQtmK
   Kar+Ql/MNOzU+WyJO73n/1aLK6fRLnVJvTzituOr9Q+Y+lozPdW19h55E
   RR2Al2yT5YIJDkKGnbqjC2z3NMwBnobMlmqzzAn1QjtLfuWwst3h4ZJVb
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="362022369"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="362022369"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 07:45:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="1003709281"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="1003709281"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 01 Mar 2023 07:45:46 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1pXOeH-00DoiO-1O;
        Wed, 01 Mar 2023 17:45:45 +0200
Date:   Wed, 1 Mar 2023 17:45:45 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com
Subject: Re: [PATCH] cxl/mbox: Drop extra struct resource cast
Message-ID: <Y/9zKXOKI1h2nvEI@smile.fi.intel.com>
References: <20230228152112.14774-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228152112.14774-1-Jonathan.Cameron@huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Feb 28, 2023 at 03:21:12PM +0000, Jonathan Cameron wrote:
> DEFINE_RES_MEM() is a wrapper around the DEFINE_RES_NAMED()
> macro which already has the (struct resource) cast.

It's not a cast. As commit message that brought it says: "Converting it to be
a compound literal..."

> Fixes warnings with W=1 C=1
>   CC [M]  drivers/cxl/core/mbox.o
>   CHECK   drivers/cxl/core/mbox.c
> drivers/cxl/core/mbox.c:1064:18: warning: cast to non-scalar
> drivers/cxl/core/mbox.c:1064:18: warning: cast from non-scalar

Otherwise it's a correct fix, thank you!
For the corrected version:

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

> Fixes: 52c4d11f1dce ("resource: Convert DEFINE_RES_NAMED() to be compound literal")
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
> 
> I'm seeing a couple of other instances of this
> drivers/acpi/arm64/gtdt.c
> arch/arm/mach-shmobile/pm-rcar-gen2.c
> 
> Might get around to fixing them but more than happy if someone beats me to it.
> 
>  drivers/cxl/core/mbox.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index f2addb457172..dce16088ceee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -1052,8 +1052,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds)
>  	struct device *dev = cxlds->dev;
>  	int rc;
>  
> -	cxlds->dpa_res =
> -		(struct resource)DEFINE_RES_MEM(0, cxlds->total_bytes);
> +	cxlds->dpa_res = DEFINE_RES_MEM(0, cxlds->total_bytes);
>  
>  	if (cxlds->partition_align_bytes == 0) {
>  		rc = add_dpa_res(dev, &cxlds->dpa_res, &cxlds->ram_res, 0,
> -- 
> 2.37.2
> 

-- 
With Best Regards,
Andy Shevchenko


