Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8920C77B71
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Apr 2023 21:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229773AbjDNVG0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Apr 2023 17:06:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229703AbjDNVGZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Apr 2023 17:06:25 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A543E9B
        for <linux-cxl@vger.kernel.org>; Fri, 14 Apr 2023 14:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1681506384; x=1713042384;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MtjAxowinXr/JwD9NIaly7DXRcQy3rIQuZ4PQcHh2Vg=;
  b=chv8YhdltMcpSZ/9vx4PTH7JPzodPleCt6uGQmTQGBp+vUHXKrdKJb+a
   Eul1fiK9/0wEUvSqGThdrZvlC1mtNIuih3JnpFhA/a8HPJV2stL0ilzcz
   0dKR0bLppFPxfs7xToZ726KX6OfwWBNMWkUVONzHuzqH9lV8PGvv5AQZ6
   PlsIawcq1/LTWrNLtcWWXaLdmeHB4q1U95MvIjlD7fLopRW/ihXBB7JdN
   Fsv5D8LKBLVf3dy9qz4ENfmv0A1xQsZDgK+qnn+jDTTwcFrohOnexUSUB
   Wm1mG727bhzoBRUVrkmoJhjsUbBqQtin/b9C45a1HX/w/BGGW2ea12Wmb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="347298132"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="347298132"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10680"; a="692561508"
X-IronPort-AV: E=Sophos;i="5.99,198,1677571200"; 
   d="scan'208";a="692561508"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.22.80])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2023 14:06:23 -0700
Date:   Fri, 14 Apr 2023 14:06:21 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH 5/5] cxl/hdm: Add more HDM decoder debug messages at
 startup
Message-ID: <ZDnATXnWEG9FSpQb@aschofie-mobl2>
References: <168149842935.792294.13212627946146993066.stgit@dwillia2-xfh.jf.intel.com>
 <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168149845668.792294.11814353796371419167.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 14, 2023 at 11:54:16AM -0700, Dan Williams wrote:
> A recent debug session yielded a couple debug messages that were useful
> for determining the reason why the driver was or was not falling back
> to CXL range register emulation, and for identifying decoder setting
> enumeration problems.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/hdm.c |   12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index abe3877cfa63..7889ff203a34 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -130,6 +130,14 @@ static bool should_emulate_decoders(struct cxl_endpoint_dvsec_info *info)
>  	 */
>  	for (i = 0; i < cxlhdm->decoder_count; i++) {
>  		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		dev_dbg(&info->port->dev,
> +			"decoder%d.%d: committed: %ld base: %#x_%.8x size: %#x_%.8x\n",
> +			info->port->id, i,
> +			FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl),
> +			readl(hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i)),
> +			readl(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i)));
>  		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
>  			return false;
>  	}
> @@ -868,6 +876,10 @@ static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  	if (rc)
>  		return rc;
>  
> +	dev_dbg(&port->dev, "decoder%d.%d: range: %#llx-%#llx iw: %d ig: %d\n",
> +		port->id, cxld->id, cxld->hpa_range.start, cxld->hpa_range.end,
> +		cxld->interleave_ways, cxld->interleave_granularity);
> +
>  	if (!info) {
>  		lo = readl(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  		hi = readl(hdm + CXL_HDM_DECODER0_TL_HIGH(which));
> 
