Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C485C4167B
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Dec 2022 19:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229462AbiLOTWE (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Dec 2022 14:22:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiLOTWC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 15 Dec 2022 14:22:02 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E146022B25
        for <linux-cxl@vger.kernel.org>; Thu, 15 Dec 2022 11:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671132121; x=1702668121;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=t69pW1pwt4+nXhdeJwtVnvUS+Dyg3u7norLrZBIJmLw=;
  b=lKMqmpHHfcR06qteiNem1g/FepO+D5pZ1lpMeSfZ4DswQeeDl9Hyj8V/
   rKNpINvqcgnkIWE3wUOk36GaT6PkKv1LnXKxHybfDHGOJ4o590k1yDWAQ
   ApvwXgdDTYlkvHKMqOzsU0Ikha/8/eP9xSTi2jmPMnVGKw5PrPVnwKY8Y
   D5oR3m8u35uWc2ydCIVGxTjefuC4+zkpirWD4c7F1lfRR96TY/lImJSXR
   KjbuqoxAYEgQ+qYC8CCFyRmAIeMc3S7I+KFD0//x8pM9EZ9p4V90S5unP
   42+qZeXWWJu+PMD5MNTfhhWYpcscnPlGm5S+CUKCiXehSMKbcsR8x9a44
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="320664833"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="320664833"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 11:21:58 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10562"; a="791786667"
X-IronPort-AV: E=Sophos;i="5.96,248,1665471600"; 
   d="scan'208";a="791786667"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.109.231]) ([10.212.109.231])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2022 11:21:58 -0800
Message-ID: <78888c92-c536-1a8d-65f5-74cc507d8695@intel.com>
Date:   Thu, 15 Dec 2022 12:21:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH v2] cxl/region: Only warn about
 cpu_cache_invalidate_memregion() once
Content-Language: en-US
To:     Davidlohr Bueso <dave@stgolabs.net>, dan.j.williams@intel.com
Cc:     mcgrof@kernel.org, linux-cxl@vger.kernel.org
References: <20221215183836.24136-1-dave@stgolabs.net>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20221215183836.24136-1-dave@stgolabs.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/15/2022 11:38 AM, Davidlohr Bueso wrote:
> No need for more than once per region.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/region.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 02f28da519e3..c11a6ab5e48d 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1967,7 +1967,7 @@ static int cxl_region_invalidate_memregion(struct cxl_region *cxlr)
>   
>   	if (!cpu_cache_has_invalidate_memregion()) {
>   		if (IS_ENABLED(CONFIG_CXL_REGION_INVALIDATION_TEST)) {
> -			dev_warn(
> +			dev_warn_once(
>   				&cxlr->dev,
>   				"Bypassing cpu_cache_invalidate_memregion() for testing!\n");
>   			clear_bit(CXL_REGION_F_INCOHERENT, &cxlr->flags);
