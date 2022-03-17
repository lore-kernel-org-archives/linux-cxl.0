Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AFF6C433F5
	for <linux-cxl@archiver.kernel.org>; Thu, 17 Mar 2022 17:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235431AbiCQRzx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 17 Mar 2022 13:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiCQRzw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 17 Mar 2022 13:55:52 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C420617335C
        for <linux-cxl@vger.kernel.org>; Thu, 17 Mar 2022 10:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647539675; x=1679075675;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Ci4UZyEUgV3K9m4QFcKzFcK7BM6qLPC3BkYen78c34=;
  b=LwYr4zoB+0Mn2ZoTZqOsXMYZCla/NCeL9xK0m72XbF0Xv53rsmjJlAfT
   4U/oZQbBl/jPrXQGaAznjYqtMSx3ss8EvsTmQOxOp/JqXfaVYX659CbLj
   Io1qgKmqZslVl8DNsufUH39OpuZBbfcbVpGBUg4+wCz8SLrus5m4bI8oG
   dsNSFFLX5TPI+cFRnMX9em5BEv2PMNcLbwDquFCtnrGMJbgpyPUt/WNoW
   zlhO8GeWPYgGV64nDUD8PcyQD4KbkI7Sb9juijWrz4VfAnPnALWmQXMfD
   ZuKF5O9qr6ijfwvWf7u5zW5Hp/wZpjYjVC1IgbHI88ZMGnSvNKsBc5/Az
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="236882409"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="236882409"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:54:35 -0700
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="645183155"
Received: from dshkut-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.132.229])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 10:54:34 -0700
Date:   Thu, 17 Mar 2022 10:54:26 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com
Subject: Re: [PATCH v2 5/6] cxl/mem: Rename cxl_dvsec_decode_init() to
 cxl_hdm_decode_init()
Message-ID: <20220317175426.bj2bfmrkc4ep2uxk@intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164730736435.3806189.2537160791687837469.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164730736435.3806189.2537160791687837469.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 22-03-14 18:22:44, Dan Williams wrote:
> cxl_dvsec_decode_init() is tasked with checking whether legacy DVSEC
> range based decode is in effect, or whether HDM can be enabled / already
> is enabled. As such it either succeeds or fails and that result is the
> return value. The @do_hdm_init variable is misleading in the case where
> HDM operation is already found to be active, so just call it @retval.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

If we're doing the rename, which I'm in favor of, maybe making it something else
instead? I think init is usually something which cannot fail. Perhaps
cxl_hdm_decode_probe()?

> ---
>  drivers/cxl/mem.c            |   12 ++++++------
>  tools/testing/cxl/mock_mem.c |    2 +-
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 50704deb2ff0..3baae1332760 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -68,7 +68,7 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>  }
>  
>  /**
> - * cxl_dvsec_decode_init() - Setup HDM decoding for the endpoint
> + * cxl_hdm_decode_init() - Setup HDM decoding for the endpoint
>   * @cxlds: Device state
>   *
>   * Additionally, enables global HDM decoding. Warning: don't call this outside
> @@ -79,12 +79,12 @@ static int create_endpoint(struct cxl_memdev *cxlmd,
>   * decoders, or if it can not be determined if DVSEC Ranges are in use.
>   * Otherwise, returns true.
>   */
> -__mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> +__mock bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  {
>  	struct cxl_endpoint_dvsec_info *info = &cxlds->info;
>  	struct cxl_register_map map;
>  	struct cxl_component_reg_map *cmap = &map.component_map;
> -	bool global_enable, do_hdm_init = false;
> +	bool global_enable, retval = false;
>  	void __iomem *crb;
>  	u32 global_ctrl;
>  
> @@ -113,7 +113,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>  		goto out;
>  	}
>  
> -	do_hdm_init = true;
> +	retval = true;
>  
>  	/*
>  	 * Permanently (for this boot at least) opt the device into HDM
> @@ -129,7 +129,7 @@ __mock bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
>  
>  out:
>  	iounmap(crb);
> -	return do_hdm_init;
> +	return retval;
>  }
>  
>  static int cxl_mem_probe(struct device *dev)
> @@ -160,7 +160,7 @@ static int cxl_mem_probe(struct device *dev)
>  	 * If DVSEC ranges are being used instead of HDM decoder registers there
>  	 * is no use in trying to manage those.
>  	 */
> -	if (!cxl_dvsec_decode_init(cxlds)) {
> +	if (!cxl_hdm_decode_init(cxlds)) {
>  		dev_err(dev,
>  			"Legacy range registers configuration prevents HDM operation.\n");
>  		return -EBUSY;
> diff --git a/tools/testing/cxl/mock_mem.c b/tools/testing/cxl/mock_mem.c
> index d1dec5845139..69946f678cfa 100644
> --- a/tools/testing/cxl/mock_mem.c
> +++ b/tools/testing/cxl/mock_mem.c
> @@ -4,7 +4,7 @@
>  #include <linux/types.h>
>  
>  struct cxl_dev_state;
> -bool cxl_dvsec_decode_init(struct cxl_dev_state *cxlds)
> +bool cxl_hdm_decode_init(struct cxl_dev_state *cxlds)
>  {
>  	return true;
>  }
> 
