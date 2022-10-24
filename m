Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0068DC67871
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Oct 2022 23:21:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230478AbiJXXVB (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Oct 2022 19:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbiJXXUl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Oct 2022 19:20:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 005D32E6482
        for <linux-cxl@vger.kernel.org>; Mon, 24 Oct 2022 14:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666647690; x=1698183690;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=c9OAJv9yrllrg46GrT7C8uf1bFGFgStzbtNQiJBa9lc=;
  b=ixNqN9ODU4G1/GvGnxhcOy6QGLd5b6/yFnhmyI1Fmf1oFM79QY/Pipc3
   EusHA76jK1kxkxl+OMUDEYE7GsvnPSJPVhYaILl3qtvnQKN0dLvoEJ5az
   xNJ2ydDpJbIWnfbCrS/XE3XyiDzA6531iAaOY5DP3ZU6IstzfFKFqUqib
   E6MAgGgIRrxM7/6iBl/AjhUdWORfL1uanUck/mF+1mcuq4Qk8UKPrP08J
   R/rKCD4j5neGKWiTDsLtDAgikLboVuMsw5ak6+txMbxErk/FPe3loY6A3
   a1foSbNa8l7mEY8pk0SVpjmr5lA2ZluBuSGEPiiRU1i16bSJhTMs+lpI1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="334120422"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="334120422"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:41:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10510"; a="736570664"
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="736570664"
Received: from djiang5-mobl2.amr.corp.intel.com (HELO [10.212.92.195]) ([10.212.92.195])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2022 14:41:06 -0700
Message-ID: <c763de54-eb7b-782d-e98f-6349ba738fce@intel.com>
Date:   Mon, 24 Oct 2022 14:41:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.0
Subject: Re: [PATCH v2] cxl: update names for interleave granularity
 conversion macros
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com
References: <166663045135.483782.14419343939744575817.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166663045135.483782.14419343939744575817.stgit@djiang5-desk3.ch.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 10/24/2022 9:54 AM, Dave Jiang wrote:
> Change names for granularity macros to clearly indicate which
> variable is encoded and which is the actual granularity.
>
> granularity == interleave granularity
> eig == encoded interleave granularity
>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>
> v2:
> - Change enig to eig. (Jonathan, Dan)

Sigh. This should be v3. And I need to pick up Jonathan's review tags 
that I didn't see. Will send fixed.


>
>   drivers/cxl/acpi.c        |    2 +-
>   drivers/cxl/core/hdm.c    |    6 +++---
>   drivers/cxl/core/region.c |    6 +++---
>   drivers/cxl/cxl.h         |   12 ++++++------
>   4 files changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index fb649683dd3a..9434f8333287 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -105,7 +105,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>   	rc = cxl_to_ways(cfmws->interleave_ways, &ways);
>   	if (rc)
>   		return rc;
> -	rc = cxl_to_granularity(cfmws->granularity, &ig);
> +	rc = eig_to_granularity(cfmws->granularity, &ig);
>   	if (rc)
>   		return rc;
>   	for (i = 0; i < ways; i++)
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..a04ce9e6e186 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -492,7 +492,7 @@ static void cxld_set_interleave(struct cxl_decoder *cxld, u32 *ctrl)
>   	if (WARN_ONCE(ways_to_cxl(cxld->interleave_ways, &eiw),
>   		      "invalid interleave_ways: %d\n", cxld->interleave_ways))
>   		return;
> -	if (WARN_ONCE(granularity_to_cxl(cxld->interleave_granularity, &eig),
> +	if (WARN_ONCE(granularity_to_eig(cxld->interleave_granularity, &eig),
>   		      "invalid interleave_granularity: %d\n",
>   		      cxld->interleave_granularity))
>   		return;
> @@ -744,8 +744,8 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>   			 port->id, cxld->id, ctrl);
>   		return rc;
>   	}
> -	rc = cxl_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> -				&cxld->interleave_granularity);
> +	rc = eig_to_granularity(FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl),
> +				 &cxld->interleave_granularity);
>   	if (rc)
>   		return rc;
>   
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 401148016978..df294a6fd2c9 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -390,7 +390,7 @@ static ssize_t interleave_granularity_store(struct device *dev,
>   	if (rc)
>   		return rc;
>   
> -	rc = granularity_to_cxl(val, &ig);
> +	rc = granularity_to_eig(val, &ig);
>   	if (rc)
>   		return rc;
>   
> @@ -1002,7 +1002,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   		parent_iw = parent_cxld->interleave_ways;
>   	}
>   
> -	rc = granularity_to_cxl(parent_ig, &peig);
> +	rc = granularity_to_eig(parent_ig, &peig);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
>   			dev_name(parent_port->uport),
> @@ -1039,7 +1039,7 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>   		eig = peig;
>   	}
>   
> -	rc = cxl_to_granularity(eig, &ig);
> +	rc = eig_to_granularity(eig, &ig);
>   	if (rc) {
>   		dev_dbg(&cxlr->dev, "%s:%s: invalid interleave: %d\n",
>   			dev_name(port->uport), dev_name(&port->dev),
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f680450f0b16..dacb1d769dae 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -69,11 +69,11 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>   }
>   
>   /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
> -static inline int cxl_to_granularity(u16 ig, unsigned int *val)
> +static inline int eig_to_granularity(u16 eig, unsigned int *granularity)
>   {
> -	if (ig > 6)
> +	if (eig > 6)
>   		return -EINVAL;
> -	*val = 256 << ig;
> +	*granularity = 256 << eig;
>   	return 0;
>   }
>   
> @@ -94,11 +94,11 @@ static inline int cxl_to_ways(u8 eniw, unsigned int *val)
>   	return 0;
>   }
>   
> -static inline int granularity_to_cxl(int g, u16 *ig)
> +static inline int granularity_to_eig(int granularity, u16 *eig)
>   {
> -	if (g > SZ_16K || g < 256 || !is_power_of_2(g))
> +	if (granularity > SZ_16K || granularity < 256 || !is_power_of_2(granularity))
>   		return -EINVAL;
> -	*ig = ilog2(g) - 8;
> +	*eig = ilog2(granularity) - 8;
>   	return 0;
>   }
>   
>
>
