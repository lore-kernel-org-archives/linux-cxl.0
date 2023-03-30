Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F82C74A5B
	for <linux-cxl@archiver.kernel.org>; Thu, 30 Mar 2023 00:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbjC3AG4 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 29 Mar 2023 20:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229560AbjC3AG4 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 29 Mar 2023 20:06:56 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0382D48
        for <linux-cxl@vger.kernel.org>; Wed, 29 Mar 2023 17:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1680134815; x=1711670815;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=dGadilSoT9Vj9/AI9sz+osqg9wohVe/t5ElMIIGFvR0=;
  b=BdLLussT8jAhSmw7dM9V3RCjMFaDHNhRld6BWPENreeixO83Ti5G4JEM
   tgDDWyqNA7TKG7oMestpU9UiTB9jHGBkLw/vPW4G+5ARZMYtuatkWgVZ9
   UVzHp0pU6WpTIJ+lMmI+0WghHN0tz7X9iq8GsYbxQDWTRZ112uZw134MC
   kBc6g5zY0/aj+GQVYzP4DoAU4MuXtnSS1+FefUtfcKkTK57eEP5Bn19Bs
   Cjk8Lb8FE3qIkrPap8KJ7qpEn9K+ZAt9BMNZhUbOFkubU6YbISXOOH7In
   qe9goCkjsRAiij4YhECoN+tpDeCwkkW7maUE/G2LOlXoRF8gtGRW7r5SK
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="339752773"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="339752773"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:06:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10664"; a="717098550"
X-IronPort-AV: E=Sophos;i="5.98,301,1673942400"; 
   d="scan'208";a="717098550"
Received: from sandrew-mobl2.amr.corp.intel.com (HELO [10.212.109.34]) ([10.212.109.34])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2023 17:06:41 -0700
Message-ID: <bfdc6772-e62c-e950-415d-a5b3d502295a@intel.com>
Date:   Wed, 29 Mar 2023 17:06:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH] cxl/hdm: Extend DVSEC range register emulation for region
 enumeration
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
References: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168012575521.221280.14177293493678527326.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 3/29/23 2:35 PM, Dan Williams wrote:
> One motivation for mapping range registers to decoder objects is
> to use those settings for region autodiscovery.
> 
> The need to map a region for devices programmed to use range registers
> is especially urgent now that the kernel no longer routes "Soft
> Reserved" ranges in the memory map to device-dax by default. The CXL
> memory range loses all access mechanisms.
> 
> Complete the implementation by filling out ways and granularity, marking

Where is the ways and granularity set done in code?

DJ

> the DPA reservation, and setting the endpoint-decoder state to signal
> autodiscovery.
> 
> Fixes: 09d09e04d2fc ("cxl/dax: Create dax devices for CXL RAM regions")
> Tested-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>   drivers/cxl/core/hdm.c |   30 ++++++++++++++++++++++++------
>   1 file changed, 24 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 9884b6d4d930..5339c0719177 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -738,20 +738,26 @@ static int cxl_decoder_reset(struct cxl_decoder *cxld)
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
> +	struct range *range;
> +	int rc;
> +
>   	if (!is_cxl_endpoint(port))
>   		return -EOPNOTSUPP;
>   
> -	if (!range_len(&info->dvsec_range[which]))
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
> +	range = &info->dvsec_range[which];
> +	if (!range_len(range))
>   		return -ENOENT;
>   
>   	cxld->target_type = CXL_DECODER_EXPANDER;
>   	cxld->commit = NULL;
>   	cxld->reset = NULL;
> -	cxld->hpa_range = info->dvsec_range[which];
> +	cxld->hpa_range = *range;
>   
>   	/*
>   	 * Set the emulated decoder as locked pending additional support to
> @@ -760,6 +766,17 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>   	cxld->flags |= CXL_DECODER_F_ENABLE | CXL_DECODER_F_LOCK;
>   	port->commit_end = cxld->id;
>   
> +	rc = devm_cxl_dpa_reserve(cxled, *dpa_base, range_len(range), 0);
> +	if (rc) {
> +		dev_err(&port->dev,
> +			"decoder%d.%d: Failed to reserve DPA range %#llx - %#llx\n (%d)",
> +			port->id, cxld->id, *dpa_base,
> +			*dpa_base + range_len(range) - 1, rc);
> +		return rc;
> +	}
> +	*dpa_base += range_len(range);
> +	cxled->state = CXL_DECODER_STATE_AUTO;
> +
>   	return 0;
>   }
>   
> @@ -779,7 +796,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
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
