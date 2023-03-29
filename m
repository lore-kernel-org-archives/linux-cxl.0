Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF2CC6FD18
	for <linux-cxl@archiver.kernel.org>; Wed, 29 Mar 2023 23:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjC2X7X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 19:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229763AbjC2X7W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 19:59:22 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CF3C03
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 16:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680134361; x=1711670361;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=SllLy98lboAQE6T/4iT0OsGN7/87AVlLaTbLqjhz2qk=;
  b=DmB5QO9KTtEENkjHcvQRlexplfTwQ6cgS+Tu2DGTe7rBgqw62c2h69Kq
   BBtaWNKJT4V+zuDES15crttumnaVa2sM9xIHgQSTSZjduu0LHK/KaRcmm
   scSn9jtmPnYur2woHgFq4ndfQkcSryzOpr10SYUHgd88Wp34kxv42S8Eh
   w6oqzKYMTVKX0hjyCRyLKSNpobmSXURoHqp8QNX2DZb9gZxHDGVMWsMFi
   0q9i27jKllzTyDfLH9lWCH8ZFVoKO8AAk+Z64lSvmzgB24zetYE39BQ+m
   O442T7hYNOmBKopZR+jgNauzoUYdhjoR7ReFrY0+YsiOP389ODgwi10Bf
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="343476937"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="343476937"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 16:59:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="748960150"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="748960150"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 16:59:21 -0700
Message-ID: <76fc93c5-bc5b-45e3-8e85-3b6ea48d013c@intel.com>
Date:   Wed, 29 Mar 2023 16:59:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] cxl/hdm: Avoid NULL deref when component registers are
 missing
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168012574357.221280.5001364964799725366.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/29/23 2:35 PM, Dan Williams wrote:
> The cxl_port driver attempts to support endpoint devices that do not
> advertise a component register block, but by inspection
> devm_cxl_setup_hdm() passes a NULL @crb to helper functions that should
> be skipped.
> 
> Return early and skip setting target_count since that is only relevant
> for switch decoders, not endpoint decoders.
> 
> Fixes: 757f6448b100 ("cxl/hdm: Fix double allocation of @cxlhdm")
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/hdm.c |    2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 5293fe13fce3..cc123996b1a4 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -123,7 +123,7 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port,
>   	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
>   	if (!crb && info && info->mem_enabled) {
>   		cxlhdm->decoder_count = info->ranges;
> -		cxlhdm->target_count = info->ranges;
> +		return cxlhdm;
>   	} else if (!crb) {
>   		dev_err(dev, "No component registers mapped\n");
>   		return ERR_PTR(-ENXIO);
> 
