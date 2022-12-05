Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CE0C4321E
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Dec 2022 21:02:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233747AbiLEVCn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 16:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiLEVCY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 16:02:24 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F29B2CC99
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 13:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670274072; x=1701810072;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=IWwKVHtFd5xqa1GXUUhNnG2NUjcRxtlc+cvJjJidEb4=;
  b=EEmtFXO5UhsQ5UpGlRI2Pi7FuCnKQFJqK/Yr6xeLNPdg0IGWxBpDyUm3
   Rc+gaCUKV8Nyuj6+JWpNZBnUfLrBsrp1ku1WavLBS+HfOtdwa2cRtcmp+
   Kumz2sCtSFTcmZX2Nl2Q13te+O6S6v84ieGalX6dHZtBmgpl0u/4cwLgX
   PSua976+EEHf3ASZyDqA43Efbrgt+BaDzA5lFzsTSQtlkH6tl3hCriJXR
   Gmcow7iqS9dSKCHsUqXRa67B643V7Mh6SdSltGp+BN3devmwCGifCKY2G
   TvpSFoQJ+rDuDXd26k8KgBizTjG7LuNikFaUG8XQJMO+Hyr6PTj8LdG3J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="380757742"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="380757742"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:01:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10552"; a="709398751"
X-IronPort-AV: E=Sophos;i="5.96,220,1665471600"; 
   d="scan'208";a="709398751"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.26.166]) ([10.212.26.166])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2022 13:01:05 -0800
Message-ID: <08d4f315-4c91-225b-d2dd-98ed111ce950@intel.com>
Date:   Mon, 5 Dec 2022 14:01:04 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.5.1
Subject: Re: [PATCH] cxl/acpi: Warn about an invalid CHBCR in an existing CHBS
 entry
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Robert Richter <rrichter@amd.com>
References: <167027170051.3542509.10494781536638424397.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167027170051.3542509.10494781536638424397.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 12/5/2022 1:21 PM, Dan Williams wrote:
> From: Robert Richter <rrichter@amd.com>
> 
> After parsing for a CHBCR in cxl_get_chbcr() the case of (ctx.chbcr ==
> CXL_RESOURCE_NONE) is a slighly different error reason than the
> !ctx.chbcr case. In the first case the CHBS was found but the CHBCR
> was invalid or something else failed to determine it, while in the
> latter case no CHBS entry exists at all.
> 
> Update the warning message to reflect this. The log messages for both
> cases can be differentiated now and the reason for a failure can be
> determined better.
> 
> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/acpi.c |    3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 420e322c85a1..f495f3ce45d1 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -455,7 +455,8 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>   		dev_dbg(match, "RCRB found for UID %lld: %pa\n", uid, &ctx.rcrb);
>   
>   	if (ctx.chbcr == CXL_RESOURCE_NONE) {
> -		dev_warn(match, "No CHBS found for Host Bridge (UID %lld)\n", uid);
> +		dev_warn(match, "CHBCR invalid for Host Bridge (UID %lld)\n",
> +			 uid);
>   		return 0;
>   	}
>   
> 
