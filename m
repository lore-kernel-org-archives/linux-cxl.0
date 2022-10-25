Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE1EFA3740
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Oct 2022 19:25:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230324AbiJYTZu (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Oct 2022 15:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbiJYTZp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Oct 2022 15:25:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45A3DB553
        for <linux-cxl@vger.kernel.org>; Tue, 25 Oct 2022 12:25:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666725943; x=1698261943;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vRDFKKzpmj9YZ2OuBa2G6aXPMxCbziUlEN6sjE9xHaA=;
  b=g34tEZ70kh/vkDHXvZJvcOxPOL0oGQFXFuNSPSI6KUOyetVSOn923d5P
   uaREbYxuc8kYeuDUhSWQfnID68RfBOtsEUwOkrfyn9FVfFBw4Uu0nKZR5
   m2vBAU07v4u6lNQ38B0C6YouGJZ+FSVaeYQkLQYlt5XBKF4RIiwBSG2NB
   K3fkebOVRXPlracsDlUd/w8D5eWZsFQTFwn6A8/nI0k1Yo5UiHBsOdL+Q
   qvBrIkD5VeUxMmJm/xjapDSGBWaY5TglT3MlX1nxxEzPCX3hA4QrxYXxM
   +2w9hMQZnOSMVl2hKRRado5vMI15YPER5mkcAAGuEk2OG7QZpUU/GQO1j
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="288167144"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="288167144"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 12:25:43 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10511"; a="631746434"
X-IronPort-AV: E=Sophos;i="5.95,212,1661842800"; 
   d="scan'208";a="631746434"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.153.131])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2022 12:25:43 -0700
Date:   Tue, 25 Oct 2022 12:25:41 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        ira.weiny@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com
Subject: Re: [PATCH v5] cxl: update names for interleave granularity
 conversion macros
Message-ID: <Y1g4NXXw5pLWMGuZ@aschofie-mobl2>
References: <166671690569.878473.14156988187731937590.stgit@djiang5-desk3.ch.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166671690569.878473.14156988187731937590.stgit@djiang5-desk3.ch.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Oct 25, 2022 at 09:56:09AM -0700, Dave Jiang wrote:
> Change names for granularity macros to clearly indicate which
> variable is encoded and which is the actual granularity.
> 
> granularity == interleave granularity
> eig == encoded interleave granularity
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> 
> v5:
> - Merge mangled patch. Fixed mistake.
> v4:
> - rebased against cxl/pending branch. Conflict against Adam's patch.
> v3:
> - change enig to eig for better consistency of overall code (Jonathan, Dan)
> - Pick up Jonatha's review tag.
> v2:
> - change ig to granularity for better clarification (Alison)
> 
> 
>  drivers/cxl/acpi.c        |    2 +-
>  drivers/cxl/core/hdm.c    |    6 +++---
>  drivers/cxl/core/region.c |    6 +++---
>  drivers/cxl/cxl.h         |   13 +++++++------
>  4 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..9434f8333287 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -105,7 +105,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
>  	if (rc)
>  		return rc;
> -	rc = cxl_to_granularity(cfmws->granularity, &ig);
> +	rc = eig_to_granularity(cfmws->granularity, &ig);
>  	if (rc)
>  		return rc;
>  	for (i = 0; i < ways; i++)
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..a04ce9e6e186 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -492,7 +492,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>  	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
>  		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
>  		return;
> -	if (WARN_ONCE(granularity_to_cxl(cxld->interleave_granularity, &eig),
> +	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
>  		      "invalid interleave_granularity: %d\n",
>  		      cxld->interleave_granularity))
>  		return;
> @@ -744,8 +744,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			 port->id, cxld->id, ctrl);
>  		return rc;
>  	}
> -	rc = cxl_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				&cxld->interleave_granularity);
> +	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +				 &cxld->interleave_granularity);
>  	if (rc)
>  		return rc;
>  
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..df294a6fd2c9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -390,7 +390,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>  	if (rc)
>  		return rc;
>  
> -	rc = granularity_to_cxl(val, &ig);
> +	rc = granularity_to_eig(val, &ig);
>  	if (rc)
>  		return rc;
>  
> @@ -1002,7 +1002,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	rc = granularity_to_cxl(parent_ig, &peig);
> +	rc = granularity_to_eig(parent_ig, &peig);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
>  			dev_name(parent_port->uport),
> @@ -1039,7 +1039,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		eig = peig;
>  	}
>  
> -	rc = cxl_to_granularity(eig, &ig);
> +	rc = eig_to_granularity(eig, &ig);
>  	if (rc) {
>  		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
>  			dev_name(port->uport), dev_name(&port->dev),
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 3ab81ad9d2e5..b6abab1c622d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -73,11 +73,11 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  }
>  
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> -static inline int cxl_to_granularity(u16 ig, unsigned int *val)
> +static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>  {
> -	if (ig > CXL_DECODER_MAX_ENCODED_IG)
> +	if (eig > CXL_DECODER_MAX_ENCODED_IG)
>  		return -EINVAL;
> -	*val = CXL_DECODER_MIN_GRANULARITY << ig;
> +	*granularity = CXL_DECODER_MIN_GRANULARITY << eig;
>  	return 0;
>  }
>  
> @@ -98,11 +98,12 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
>  	return 0;
>  }
>  
> -static inline int granularity_to_cxl(int g, u16 *ig)
> +static inline int granularity_to_eig(int granularity, u16 *eig)
>  {
> -	if (g > SZ_16K || g < CXL_DECODER_MIN_GRANULARITY || !is_power_of_2(g))
> +	if (granularity > SZ_16K || granularity < CXL_DECODER_MIN_GRANULARITY ||
> +	    !is_power_of_2(granularity))
>  		return -EINVAL;
> -	*ig = ilog2(g) - 8;
> +	*eig = ilog2(granularity) - 8;
>  	return 0;
>  }
>  
> 
> 
