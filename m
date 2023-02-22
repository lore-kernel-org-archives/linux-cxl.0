Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CFA9C61DA4
	for <linux-cxl@archiver.kernel.org>; Wed, 22 Feb 2023 16:59:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbjBVQ7u (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 22 Feb 2023 11:59:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231584AbjBVQ7t (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 22 Feb 2023 11:59:49 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E23F38035
        for <linux-cxl@vger.kernel.org>; Wed, 22 Feb 2023 08:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677085188; x=1708621188;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1ZyZi4a059ghy9xS+pFY8yi7VAAK4yk7l7nUhlJ9WDs=;
  b=P1uQlXxeET/0s3flgcmIvjkjPIbxz3E9koli+T6V+NLBFyzSt6xCG1wE
   CRs32+bKOTGqOcaABEQWxkMC+kK5pmp8Y0lU3RKZZC5ucwAyC0Z9unVBO
   v3MVd2h032Vuhpm8FrTXdQmDnYIePxjCLLK4GP9y2amM2dhDoWLJjO8I5
   5r2DVFKYR/2I+3KX9PNOD5XJBKoNql7adQlSRGleDPk+fnK+TUBtukrcV
   qUZQ1HClv1aJlQtOeH0DqE3I5npwOr3nF4wM7KFQ6QQMVWhc58jNVHqWd
   lU0Y578kZKx7OoeP4IAIqTvNCeDvBYQyz80WEcbLMl2qr/N8nfjGahlNE
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="312605823"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="312605823"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 08:59:48 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10629"; a="672138934"
X-IronPort-AV: E=Sophos;i="5.97,319,1669104000"; 
   d="scan'208";a="672138934"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.50.122]) ([10.212.50.122])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2023 08:59:47 -0800
Message-ID: <45ca3274-3a9f-5bb3-cdbc-9e75414ff763@intel.com>
Date:   Wed, 22 Feb 2023 09:59:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.6.0
Subject: Re: [PATCH 2/2] cxl/hdm: Skip emulation when driver manages
 mem_enable
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
References: <167703067373.185722.16579529992799939220.stgit@dwillia2-xfh.jf.intel.com>
 <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <167703068474.185722.664126485486344246.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 2/21/23 6:51 PM, Dan Williams wrote:
> If the driver is allowed to enable memory operation itself then it can
> also turn on HDM decoder support at will.
> 
> With this the second call to cxl_setup_hdm_decoder_from_dvsec(), when
> an HDM decoder is not committed, is not needed.
> 
> Fixes: b777e9bec960 ("cxl/hdm: Emulate HDM decoder from DVSEC range registers")
> Link: http://lore.kernel.org/r/20230220113657.000042e1@huawei.com
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/hdm.c |   31 ++++++++++++++++++-------------
>   drivers/cxl/cxl.h      |    4 +++-
>   drivers/cxl/port.c     |    2 +-
>   3 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 520814130928..5293fe13fce3 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -717,19 +717,29 @@ static int cxl_setup_hdm_decoder_from_dvsec(struct cxl_port *port,
>   	return 0;
>   }
>   
> -static bool should_emulate_decoders(struct cxl_port *port)
> +static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>   {
> -	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> -	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_hdm *cxlhdm;
> +	void __iomem *hdm;
>   	u32 ctrl;
>   	int i;
>   
> -	if (!is_cxl_endpoint(cxlhdm->port))
> +	if (!info)
>   		return false;
>   
> +	cxlhdm = dev_get_drvdata(&info->port->dev);
> +	hdm = cxlhdm->regs.hdm_decoder;
> +
>   	if (!hdm)
>   		return true;
>   
> +	/*
> +	 * If HDM decoders are present and the driver is in control of
> +	 * Mem_Enable skip DVSEC based emulation
> +	 */
> +	if (!info->mem_enabled)
> +		return false;
> +
>   	/*
>   	 * If any decoders are committed already, there should not be any
>   	 * emulated DVSEC decoders.
> @@ -747,7 +757,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			    int *target_map, void __iomem *hdm, int which,
>   			    u64 *dpa_base, struct cxl_endpoint_dvsec_info *info)
>   {
> -	struct cxl_endpoint_decoder *cxled = NULL;
> +	struct cxl_endpoint_decoder *cxled;
>   	u64 size, base, skip, dpa_size;
>   	bool committed;
>   	u32 remainder;
> @@ -758,12 +768,9 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		unsigned char target_id[8];
>   	} target_list;
>   
> -	if (should_emulate_decoders(port))
> +	if (should_emulate_decoders(info))
>   		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
>   
> -	if (is_endpoint_decoder(&cxld->dev))
> -		cxled = to_cxl_endpoint_decoder(&cxld->dev);
> -
>   	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
>   	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
>   	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> @@ -784,9 +791,6 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		.end = base + size - 1,
>   	};
>   
> -	if (cxled && !committed && range_len(&info->dvsec_range[which]))
> -		return cxl_setup_hdm_decoder_from_dvsec(port, cxld, which, info);
> -
>   	/* decoders are enabled if committed */
>   	if (committed) {
>   		cxld->flags |= CXL_DECODER_F_ENABLE;
> @@ -824,7 +828,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   	if (rc)
>   		return rc;
>   
> -	if (!cxled) {
> +	if (!info) {
>   		target_list.value =
>   			ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>   		for (i = 0; i < cxld->interleave_ways; i++)
> @@ -844,6 +848,7 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   		return -ENXIO;
>   	}
>   	skip = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SKIP_LOW(which));
> +	cxled = to_cxl_endpoint_decoder(&cxld->dev);
>   	rc = devm_cxl_dpa_reserve(cxled, *dpa_base + skip, dpa_size, skip);
>   	if (rc) {
>   		dev_err(&port->dev,
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d853a0238ad7..dd4b7a729419 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -695,13 +695,15 @@ int cxl_endpoint_autoremove(struct cxl_memdev *cxlmd, struct cxl_port *endpoint)
>   
>   /**
>    * struct cxl_endpoint_dvsec_info - Cached DVSEC info
> - * @mem_enabled: cached value of mem_enabled in the DVSEC, PCIE_DEVICE
> + * @mem_enabled: cached value of mem_enabled in the DVSEC at init time
>    * @ranges: Number of active HDM ranges this device uses.
> + * @port: endpoint port associated with this info instance
>    * @dvsec_range: cached attributes of the ranges in the DVSEC, PCIE_DEVICE
>    */
>   struct cxl_endpoint_dvsec_info {
>   	bool mem_enabled;
>   	int ranges;
> +	struct cxl_port *port;
>   	struct range dvsec_range[2];
>   };
>   
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 1049bb5ea496..9c8f46ed336b 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -78,8 +78,8 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>   
>   static int cxl_endpoint_port_probe(struct cxl_port *port)
>   {
> +	struct cxl_endpoint_dvsec_info info = { .port = port };
>   	struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
> -	struct cxl_endpoint_dvsec_info info = { 0 };
>   	struct cxl_dev_state *cxlds = cxlmd->cxlds;
>   	struct cxl_hdm *cxlhdm;
>   	struct cxl_port *root;
> 
