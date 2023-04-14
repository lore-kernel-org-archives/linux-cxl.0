Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3397BC77B72
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 21:26:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbjDNV0M (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbjDNV0E (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 17:26:04 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3FB92
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 14:25:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681507548; x=1713043548;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=2A1jlpB013w03MJkHh4Zh78JTTQ/39jEsxGdGDvODRU=;
  b=WeoL4s0BXNwIcNKn9jlNUMf9w/f9K1QXor7E3CHPaRxnU1Jr/x1hFVdh
   R2OcIBstMWsN+Pts+Ev0Pr82uWmFxBk/Fhbc/X1+R1nkYZepgJM5oMq+8
   fpwwBP0IA4XvMYMuxQxpqtjvBMqfvu9bdlLLoSbLvy6IMJIiCjySIAw2X
   6KCGE05dHsmr9Z7ymbwzsw7PofvNaPg6yPlnGd9mAYmm98ohnjWpq4mFE
   2Aq0Ou+osZhnnvatBPlRrj+jhri8HiQARgpP6danNCqoDcjP6zM3wTTZR
   tnL9LGUbGpzrbLPvJ0cTHNFXPniZGNIoq0UcXVWp5V8HPzLVHAR+wUJDX
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="342067385"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="342067385"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:25:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="779335926"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="779335926"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.122.87]) ([10.212.122.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:25:48 -0700
Message-ID: <f573b441-17ac-add9-c154-ebbb794bfc4d@intel.com>
Date:   Fri, 14 Apr 2023 14:25:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 5/5] cxl/hdm: Add more HDM decoder debug messages at
 startup
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
 <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/14/23 11:54 AM, Dan Williams wrote:
> A recent debug session yielded a couple debug messages that were useful
> for determining the reason why the driver was or was not falling back
> to CXL range register emulation, and for identifying decoder setting
> enumeration problems.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/hdm.c |   12 ++++++++++++
>   1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index abe3877cfa63..7889ff203a34 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -130,6 +130,14 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>   	 */
>   	for (i = 0; i < cxlhdm->decoder_count; i++) {
>   		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		dev_dbg(&info->port->dev,
> +			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
> +			info->port->id, i,
> +			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
> +			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
>   		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
>   			return false;
>   	}
> @@ -868,6 +876,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	if (rc)
>   		return rc;
>   
> +	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
> +		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
> +		cxld->interleave_ways, cxld->interleave_granularity);
> +
>   	if (!info) {
>   		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>   		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> 
