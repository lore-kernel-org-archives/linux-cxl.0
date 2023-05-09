Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3A8BC7EE22
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 15:30:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234673AbjEIPal (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 11:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjEIPak (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 11:30:40 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F58468B;
        Tue,  9 May 2023 08:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683646239; x=1715182239;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=R2xPIMfgvoJtrEPzrgFyA5tg4Dp7CA//fvaQ6VC7Wco=;
  b=fvVADmAkk9mF6pINygI9e3bIKxtsftI7yyG23Xl+ypuSkuwNGFylP+m0
   /XTM2Te/g9o531tAciZfi8EAYMuP+9D/92/FHmjQoUSFB+Z69BpTMp08l
   5YtqV8rz+gskPkpXWm+dQTL7ZQRx8Pjl598k0iyg3SOYJlQLQwfxDSwB2
   QEfF3mQaZ7toCmhDQ3CXlspc14exfEBPwMLdXsP3qBvBvTBvLJwUBfVpP
   IiG7fhsJb8bR1qY0FGPg4SmYfhQj0qbIGqikWzm9+TX4igNoFLFpKWSCu
   wVwVQuUP4X28s4b8/eaLnWeUQXtxlriRbNi7ztzoodig+Fl0Mgabt8GP7
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="378058129"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="378058129"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 08:30:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="1028849919"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="1028849919"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.97.226]) ([10.212.97.226])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 08:30:38 -0700
Message-ID: <faad76bc-897b-c2ed-2a39-97a2710efe4b@intel.com>
Date:   Tue, 9 May 2023 08:30:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH v4 2/2] cxl/region: Remove else after return statement
Content-Language: en-US
To:     Raghu Halharvi <raghuhack78@gmail.com>, linux-cxl@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        ira.weiny@intel.com, bwidawsk@kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com
Cc:     linux-kernel@vger.kernel.org
References: <20230509095016.138890-1-raghuhack78@gmail.com>
 <20230509095016.138890-3-raghuhack78@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230509095016.138890-3-raghuhack78@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/9/23 2:50 AM, Raghu Halharvi wrote:
> Issue found with checkpatch
> 
> The else section here is redundant after return statement, removing it.
> Sanity and correctness is not affected due to this fix.
> 
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>

Duplicate tags here. Just FYI. :)
> Signed-off-by: Raghu Halharvi <raghuhack78@gmail.com>
> ---
>   drivers/cxl/core/region.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f29028148806..a46d6ad9ef0a 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2666,11 +2666,11 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>   				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>   			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
>   			return 0;
> -		} else {
> -			dev_err(&cxlr->dev,
> -				"Failed to synchronize CPU cache state\n");
> -			return -ENXIO;
>   		}
> +
> +		dev_err(&cxlr->dev,
> +			"Failed to synchronize CPU cache state\n");
> +		return -ENXIO;
>   	}
>   
>   	cpu_cache_invalidate_memregion(IORES_DESC_CXL);
