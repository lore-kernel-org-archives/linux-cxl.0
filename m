Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C1C2C61DA3
	for <linux-cxl@archiver.kernel.org>; Tue, 21 Feb 2023 16:07:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233775AbjBUQHZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 21 Feb 2023 11:07:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbjBUQHZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 21 Feb 2023 11:07:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8440B2A9B5
        for <linux-cxl@vger.kernel.org>; Tue, 21 Feb 2023 08:07:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1676995643; x=1708531643;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=EadcjIYMMY30h+I/4HAEymICvF67L3YlDgWLJRV8sWQ=;
  b=bWZe57y40CLx2fDt+14NuIFcE3nW1QrOx0bk65Zf1FYhMiOakwYimQRL
   WeEibWilLNmYLHuCmgiOlsfoUcjmSDmCs0jr8Yqe7NdLXPSv4VAi2Z7S7
   XTRaWdhSGtNWxMLJtgxpn6k8Hfecu7W5Dg3siU495LFJ4/YNeDA0XvZFQ
   YxcELSbFadW1rqriYcZ05kTfe0WFRM4KgGzZEToto5OwCaQJpqm9gdc7D
   RZBcQK4iSIuFiiXiGGKuFXNg4WNCoCutwAY9p5IAN8CguCCjI80Ym0bVV
   2Y1diiHONtIrTVLVs7GEG137PqE0N7lX57SoNHQMi0J8yECemNqAZaCA0
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="331339882"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="331339882"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:06:25 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10628"; a="814551133"
X-IronPort-AV: E=Sophos;i="5.97,315,1669104000"; 
   d="scan'208";a="814551133"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.213.184.163]) ([10.213.184.163])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2023 08:06:21 -0800
Message-ID: <af92217e-3993-f8d7-1205-04cb010bd4f8@intel.com>
Date:   Tue, 21 Feb 2023 09:06:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH v5 6/7] cxl/hdm: Add emulation when HDM decoders are not
 committed
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linuxarm@huawei.com
References: <167640366272.935665.1056268838301725481.stgit@dwillia2-xfh.jf.intel.com>
 <167640369536.935665.611974113442400127.stgit@dwillia2-xfh.jf.intel.com>
 <20230220113657.000042e1@huawei.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230220113657.000042e1@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/20/23 4:36 AM, Jonathan Cameron wrote:
> On Tue, 14 Feb 2023 11:41:35 -0800
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
>> From: Dave Jiang <dave.jiang@intel.com>
>>
>> For the case where DVSEC range register(s) are active and HDM decoders are
>> not committed, use RR to provide emulation. A first pass is done to note
>> whether any decoders are committed. If there are no committed endpoint
>> decoders, then DVSEC ranges will be used for emulation.
>>
>> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
>> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> 
> I'm confused a bit here.  I 'think' the aim should always be to use
> HDM decoders unless they either aren't present or we know the
> DVSEC range registers are in use.
> 
> The conditions in here are too broad + trip up current QEMU.
> There is a 'bug' in QEMU as it programs the base registers in DVSEC
> but it doesn't affect this flow (and shouldn't).
> 
> I'm not sure how you are detecting 'active' for the DVSEC range
> registers as described in this patch description. As far as I can
> tell there is no way to work that out other than if the top level
> CXL.mem_enabled == true;  The various active bits in the range registers
> refer to whether the memory behind them is ready to use, not anything
> to do whether the range registers are setup correctly and 'turned on'.

cxl.mem_enabled && range and size programmed in range register && no HDM 
decoders programmed. Does that imply active ranges via DVSEC range 
registers?

> 
> If CXL.mem is not enabled, the memory is definitely not
> in use. Equation 8-2
> 
> Memory_active AND CXL Mem_Enable=1
> 
> Now the snag is that CXL mem enabled has been set already in
> cxl_hdm_decode_init() called from cxl_endpoint_port_probe()
> 
> So the hack I'm carrying is to stash if 'it was not enabled when
> we would otherwise turn it on'.  If that condition is true and
> there are HDM decoders, we should use them.  Sometimes it feels
> like there is no right order possible for enabling all of a CXL
> device!
> 
> Note the QEMU device here is heaving like any unconfigured freshly
> reset type 3 device - or a hotplugged one.
> 
> 
>  From 5c3e6c5c5c6c37dd0e614273113daf1ff2487e53 Mon Sep 17 00:00:00 2001
> From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Date: Mon, 20 Feb 2023 11:24:34 +0000
> Subject: [PATCH] hack
> 
> ---
>   drivers/cxl/core/hdm.c | 11 ++++++++---
>   drivers/cxl/core/pci.c |  1 +
>   drivers/cxl/cxl.h      |  2 ++
>   3 files changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 45deda18ed32..a2b209cf9856 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -739,7 +739,8 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>   	return 0;
>   }
>   
> -static bool should_emulate_decoders(struct cxl_port *port)
> +static bool should_emulate_decoders(struct cxl_port *port,
> +				    struct cxl_endpoint_dvsec_info *info)
>   {
>   	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
>   	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> @@ -752,6 +753,9 @@ static bool should_emulate_decoders(struct cxl_port *port)
>   	if (!hdm)
>   		return true;
>   
> +	if (info->was_not_enabled_at_probe) {
> +		return false;
> +	}
>   	/*
>   	 * If any decoders are committed already, there should not be any
>   	 * emulated DVSEC decoders.
> @@ -780,7 +784,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		unsigned char target_id[8];
>   	} target_list;
>   
> -	if (should_emulate_decoders(port))
> +	if (should_emulate_decoders(port, info))
>   		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
>   
>   	if (is_endpoint_decoder(&cxld->dev))
> @@ -806,7 +810,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		.end = base + size - 1,
>   	};
>   
> -	if (cxled && !committed && range_len(&info->dvsec_range[which]))
> +	if ((!info || !info->was_not_enabled_at_probe) && cxled && !committed &&
> +	    range_len(&info->dvsec_range[which]))
>   		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
>   
>   	/* decoders are enabled if committed */
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 7328a2552411..a08c35216ad8 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -377,6 +377,7 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
>   	if (hdm)
>   		global_ctrl = readl(hdm + CXL_HDM_DECODER_CTRL_OFFSET);
>   
> +	info->was_not_enabled_at_probe = !info->mem_enabled;
>   	/*
>   	 * If the HDM Decoder Capability is already enabled then assume
>   	 * that some other agent like platform firmware set it up.
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d853a0238ad7..c32a9f9438e8 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -696,11 +696,13 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>   /**
>    * struct cxl_endpoint_dvsec_info - Cached DVSEC info
>    * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> + * @was_not_enabled_at_probe: hack
>    * @ranges: Number of active HDM ranges this device uses.
>    * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
>    */
>   struct cxl_endpoint_dvsec_info {
>   	bool mem_enabled;
> +	bool was_not_enabled_at_probe;
>   	int ranges;
>   	struct range dvsec_range[2];
>   };
