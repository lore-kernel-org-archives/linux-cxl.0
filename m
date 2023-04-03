Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B59C76188
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Apr 2023 23:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231246AbjDCXob (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Apr 2023 19:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233886AbjDCXo3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Apr 2023 19:44:29 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E806235A1
        for <linux-cxl@vger.kernel.org>; Mon,  3 Apr 2023 16:44:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680565465; x=1712101465;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=cykA4A8nqg/kZp5yVx1emL8MjYljRQhmKPPNOaEXNVM=;
  b=hW3YrV6m39D1mD7RhS6TFW8S4MQCvRzNh1VJo8kfa6VabSqMWhpN4tnC
   0dZFVDeOvAg0Q5EMJp4JDSjvL0NGY8Hk9MWGJCFrPMr429iAdenlp5Q0i
   G2/7C2EZvr7ABmxwRLRdCbuuEcxFd/LhSRmAj+eAAKVzBcOVKl/OxXp3v
   vxmHP+60SqbcEkruRDES0wcoph9tI1YpQ/uw/auHIr3W6MlhlVDREI3Cu
   pcaaOiSy+++q0y2gk9mLBUZaVwnbw6N056R1mxltcPGa5MnFZUv6DC3XR
   fuCS+MMeFxjAGjzvdz0IhcSikTF1Syq50gvtygXacMnMDMQMktDvS5UqG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="322438167"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="322438167"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 16:44:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10669"; a="750691519"
X-IronPort-AV: E=Sophos;i="5.98,316,1673942400"; 
   d="scan'208";a="750691519"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.181.144]) ([10.213.181.144])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2023 16:44:25 -0700
Message-ID: <1dc1b324-8e77-f98d-3fd0-a20cbf328d2f@intel.com>
Date:   Mon, 3 Apr 2023 16:44:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH v2] cxl/hdm: Extend DVSEC range register emulation for
 region enumeration
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Gregory Price <gregory.price@memverge.com>
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
 <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168056315526.436217.14417826023537916154.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/3/23 4:06 PM, Dan Williams wrote:
> One motivation for mapping range registers to decoder objects is
> to use those settings for region autodiscovery.
> 
> The need to map a region for devices programmed to use range registers
> is especially urgent now that the kernel no longer routes "Soft
> Reserved" ranges in the memory map to device-dax by default. The CXL
> memory range loses all access mechanisms.
> 
> Complete the implementation by filling out ways and granularity, marking
> the DPA reservation, and setting the endpoint-decoder state to signal
> autodiscovery.

If you don't mind making a note that the default values of ways and 
granularity are coming from cxl_decode_init(). Thanks.

> 
> Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Link: https://lore.kernel.org/r/168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
> Changes since v1:
> - Swap out the local @range variable which was mostly only used for the
>    mapping length with a @len variable for that purpose (Jonathan)
> 
>   drivers/cxl/core/hdm.c |   27 ++++++++++++++++++++++-----
>   1 file changed, 22 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9884b6d4d930..02cc2c38b44b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -738,14 +738,20 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
>   	return 0;
>   }
>   
> -static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
> -					    struct cxl_decoder *cxld, int which,
> -					    struct cxl_endpoint_dvsec_info *info)
> +static int cxl_setup_hdm_decoder_from_dvsec(
> +	struct cxl_port *port, struct cxl_decoder *cxld, u64 *dpa_base,
> +	int which, struct cxl_endpoint_dvsec_info *info)
>   {
> +	struct cxl_endpoint_decoder *cxled;
> +	u64 len;
> +	int rc;
> +
>   	if (!is_cxl_endpoint(port))
>   		return -EOPNOTSUPP;
>   
> -	if (!range_len(&info->dvsec_range[which]))
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	len = range_len(&info->dvsec_range[which]);
> +	if (!len)
>   		return -ENOENT;
>   
>   	cxld->target_type = CXL_DECODER_EXPANDER;
> @@ -760,6 +766,16 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>   	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>   	port->commit_end = cxld->id;
>   
> +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, len, 0);
> +	if (rc) {
> +		dev_err(&port->dev,
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			port->id, cxld->id, *dpa_base, *dpa_base + len - 1, rc);
> +		return rc;
> +	}
> +	*dpa_base += len;
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +
>   	return 0;
>   }
>   
> @@ -779,7 +795,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	} target_list;
>   
>   	if (should_emulate_decoders(info))
> -		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> +		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, dpa_base,
> +							which, info);
>   
>   	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>   	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> 
