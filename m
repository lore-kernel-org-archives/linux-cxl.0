Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193ABC77B7C
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 17:23:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235136AbjEIRXc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 13:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234985AbjEIRXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 13:23:30 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC242D79
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 10:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1683653000; x=1715189000;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=M5PazGlCXvjC+zyM0X70XOVeZlM614co03KycejRQlM=;
  b=RztywSJ38IA2cvGGFiEch3EAZ6JO990kulzfXoj4NKcTtVY3cFmzRVtV
   JCuz0mhCvk9YnrsawRCnQh1IZ1oOKsDvjo0wFxWf1yCxOK8dioTtUBD8t
   DLqQ4Z+thqhyxXgbezlVIJL5g4g7VwcRNO7xGNd9v2Q2Kg4jqWAuOy5G1
   Gxi5S9mKH9V8EPkJDHKzk3wJAd84JtTSYI7j52JRgcHRP6dCayDta0J6R
   E8jsjgSmjsOIwHu0HVt3eLEgCDg2XMi36vmt+O1C3i3J7jUYQT7i2Bv7A
   togd0ZrZDlQw7kKQSG8nu2BM2VFttKDhbWd05utwvxjkiFvUdIUvS8x1I
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="339231843"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="339231843"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 10:22:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10705"; a="810793559"
X-IronPort-AV: E=Sophos;i="5.99,262,1677571200"; 
   d="scan'208";a="810793559"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.97.226]) ([10.212.97.226])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2023 10:22:35 -0700
Message-ID: <9572825f-9b1d-8a41-808c-49048d64affa@intel.com>
Date:   Tue, 9 May 2023 10:22:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.10.0
Subject: Re: [PATCH] cxl/region: Fix typo in region comment in RAM mode
Content-Language: en-US
To:     Minwoo Im <minwoo.im.dev@gmail.com>, linux-cxl@vger.kernel.org
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
References: <20230509153821.7740-1-minwoo.im.dev@gmail.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230509153821.7740-1-minwoo.im.dev@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 5/9/23 8:38 AM, Minwoo Im wrote:
> s/manged/managed
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index f822de44bee0..d5832a1d1da3 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -2871,7 +2871,7 @@ static int cxl_region_probe(struct device *dev)
>   		return devm_cxl_add_pmem_region(cxlr);
>   	case CXL_DECODER_RAM:
>   		/*
> -		 * The region can not be manged by CXL if any portion of
> +		 * The region can not be managed by CXL if any portion of
>   		 * it is already online as 'System RAM'
>   		 */
>   		if (walk_iomem_res_desc(IORES_DESC_NONE,
