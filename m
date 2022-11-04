Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5084DC4332F
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Nov 2022 21:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbiKDVnl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Nov 2022 17:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiKDVnl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Nov 2022 17:43:41 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D58D9E
        for <linux-cxl@vger.kernel.org>; Fri,  4 Nov 2022 14:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667598220; x=1699134220;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=sjroNdZd82aap5u1aayWH4HSs5G5XU4pi385+5yzyWE=;
  b=YTOQOLbFzknvavcVkgXM2T96HzQi0JuNSzXSBosMey9l99LDG0xkf8LN
   lVmx/msgKhnYS2l+FRcEqTjAS3O/GumEusweqmZprJMnFrh6ijO7kT2Mr
   9TkN4Ba/466aarZB8t+4saHZENPzatNM+1q9544KDUyANe+ymS+ELc6Br
   U8Gezx2G5PXyi39xqIiJuYMv1BC3uMabdl0oGoNpbs4QltOV2P/Q7+rIK
   tL5Dh9h7kpzhS3/8s9qVrEdl6cU7XtfMrEEcajDn6MKtRr50xwv9ddyTH
   bAAfqD+MBSdsViMCMfqS/kGx4gB87YeZF6KZb9wT9R173mZJoZYlmL7Y8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="307702321"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="307702321"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 14:43:37 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10521"; a="635237480"
X-IronPort-AV: E=Sophos;i="5.96,138,1665471600"; 
   d="scan'208";a="635237480"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.112.74]) ([10.212.112.74])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2022 14:43:36 -0700
Message-ID: <5ae6721c-827c-0f80-bdec-ab6ab8dabd5d@intel.com>
Date:   Fri, 4 Nov 2022 14:43:35 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 4/7] tools/testing/cxl: Fix some error exits
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     vishal.l.verma@intel.com, alison.schofield@intel.com,
        ira.weiny@intel.com
References: <166752181697.947915.744835334283138352.stgit@dwillia2-xfh.jf.intel.com>
 <166752184255.947915.16163477849330181425.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <166752184255.947915.16163477849330181425.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 11/3/2022 5:30 PM, Dan Williams wrote:
> Fix a few typos where 'goto err_port' was used rather than the object
> specific cleanup.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   tools/testing/cxl/test/cxl.c |    4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index a072b2d3e726..133e4c73d370 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -695,7 +695,7 @@ static __init int cxl_test_init(void)
>   
>   		pdev = platform_device_alloc("cxl_switch_uport", i);
>   		if (!pdev)
> -			goto err_port;
> +			goto err_uport;
>   		pdev->dev.parent = &root_port->dev;
>   
>   		rc = platform_device_add(pdev);
> @@ -713,7 +713,7 @@ static __init int cxl_test_init(void)
>   
>   		pdev = platform_device_alloc("cxl_switch_dport", i);
>   		if (!pdev)
> -			goto err_port;
> +			goto err_dport;
>   		pdev->dev.parent = &uport->dev;
>   
>   		rc = platform_device_add(pdev);
> 
