Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50573C77B72
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 21:25:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjDNVZn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:25:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjDNVZm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 17:25:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1615A249;
        Fri, 14 Apr 2023 14:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681507516; x=1713043516;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=S8yTcSG44gsgm1lfz6qJPly3etIpP7fg89Z+p3On3Vs=;
  b=TJ92r1/10hR5CpJTHdjfIsxX8PcLY23JRMGhPv+uhUqeapBfCI5LQelA
   v2MtFxkuiONEFavvtcMXdl2qKZ1OFA2bVV2Y8HFfQnd46myT5Uu0H2mll
   8JdoWe6JVJlqXGbUHOpewtOLrmUde2Ym4hg1J6Yq9sAKSSRy18iRBB4J6
   /62MQIIM+xMKX8v6/orCPNl4fjI/RhQ5WxFkgpjNUiPRU36loXoaV0EiU
   i2G8Y9hHr/Ax4ClOcmM0AhH8Ntc4tGtYn51B9NSEaa1347UCtxccXacIE
   k+SMHNvfWU5vtACZoB1JXk9Y/ynBq/p7M3TKla5XnkbZgMmMVPYzxYA2n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="342067274"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="342067274"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:24:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="779335815"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="779335815"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO [10.212.122.87]) ([10.212.122.87])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:24:47 -0700
Message-ID: <e8537f40-8a2c-4fc1-0c4d-c771c12b4386@intel.com>
Date:   Fri, 14 Apr 2023 14:24:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.9.0
Subject: Re: [PATCH 4/5] cxl/port: Scan single-target ports for decoders
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        stable@vger.kernel.org
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
 <168149845130.792294.3210421233937427962.stgit@dwillia2-xfh.jf.intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <168149845130.792294.3210421233937427962.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org



On 4/14/23 11:54 AM, Dan Williams wrote:
> Do not assume that a single-target port falls back to a passthrough
> decoder configuration. Scan for decoders and only fallback after probing
> that the HDM decoder capability is not present.
> 
> One user visible affect of this bug is the inability to enumerate
> present CXL regions as the decoder settings for the present decoders are
> skipped.
> 
> Fixes: d17d0540a0db ("cxl/core/hdm: Add CXL standard decoder enumeration to the core")
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Link: http://lore.kernel.org/r/20230227153128.8164-1-Jonathan.Cameron@huawei.com
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> ---
>   drivers/cxl/core/hdm.c |    5 +++--
>   drivers/cxl/port.c     |   18 +++++++++++++-----
>   2 files changed, 16 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 6fdf7981ddc7..abe3877cfa63 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -92,8 +92,9 @@ static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
>   
>   	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
>   	if (!map.component_map.hdm_decoder.valid) {
> -		dev_err(&port->dev, "HDM decoder registers invalid\n");
> -		return -ENXIO;
> +		dev_dbg(&port->dev, "HDM decoder registers not implemented\n");
> +		/* unique error code to indicate no HDM decoder capability */
> +		return -ENODEV;
>   	}
>   
>   	return cxl_map_component_regs(&port->dev, regs, &map,
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 22a7ab2bae7c..eb57324c4ad4 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -66,14 +66,22 @@ static int cxl_switch_port_probe(struct cxl_port *port)
>   	if (rc < 0)
>   		return rc;
>   
> -	if (rc == 1)
> -		return devm_cxl_add_passthrough_decoder(port);
> -
>   	cxlhdm = devm_cxl_setup_hdm(port, NULL);
> -	if (IS_ERR(cxlhdm))
> +	if (!IS_ERR(cxlhdm))
> +		return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +
> +	if (PTR_ERR(cxlhdm) != -ENODEV) {
> +		dev_err(&port->dev, "Failed to map HDM decoder capability\n");
>   		return PTR_ERR(cxlhdm);
> +	}
> +
> +	if (rc == 1) {
> +		dev_dbg(&port->dev, "Fallback to passthrough decoder\n");
> +		return devm_cxl_add_passthrough_decoder(port);
> +	}
>   
> -	return devm_cxl_enumerate_decoders(cxlhdm, NULL);
> +	dev_err(&port->dev, "HDM decoder capability not found\n");
> +	return -ENXIO;
>   }
>   
>   static int cxl_endpoint_port_probe(struct cxl_port *port)
> 
