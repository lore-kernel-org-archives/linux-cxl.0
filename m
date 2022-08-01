Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05809C00144
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:43:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiHATnQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:43:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbiHATnP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:43:15 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C74C167EF
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659382994; x=1690918994;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hZ2DPbL0leHgMOfT8gHUQV8q+Mi2ikDy20hQT5Jj9WU=;
  b=Tl5sNQUrn1QAvHKwY4RwqsDr80HCQXuuQy/RKO0z2M/XqX0rcZQoRcsY
   FEO1pl7BJJENruuSt2V4M4Lb0pQnsDvgb7Xvd80jcGUErNOo1uGDlTXgG
   844VKVvs4mcIStXeNllPJAuamjljWxnfZdnA8KUIjbR1jIsH0FRGxDWLX
   04KDefhcPZiFJuo+OGvGTVv2/vRbc/+NUcfSQuFpk9POZkmQsQcRciMaO
   J8XRwcbYWtjWB1GTLMIzYgRmiXdqoJqAQEIBaMLfM8LXo52bZYkr77F1X
   nF7Fc0XXIAPWyJwFwNdh1slI4L8DqNl6qCXGnLfFeJoDmW54KIS/0/nOR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="276137286"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="276137286"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:43:14 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="552634938"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:43:13 -0700
Date:   Mon, 1 Aug 2022 12:41:13 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH 4/5] cxl/region: Stop initializing interleave granularity
Message-ID: <20220801194113.GC1722942@alison-desk>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853777484.2430596.3423921169034844397.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165853777484.2430596.3423921169034844397.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 22, 2022 at 05:56:14PM -0700, Dan Williams wrote:
> In preparation for a patch that validates that the region ways setting
> is compatible with the granularity setting, the initial granularity
> setting needs to start at zero to indicate "unset".
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/region.c |    2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index df35d3c475a0..05b6212e6399 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1524,7 +1524,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  					      enum cxl_decoder_type type)
>  {
>  	struct cxl_port *port = to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> -	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
>  	struct cxl_region_params *p;
>  	struct cxl_region *cxlr;
>  	struct device *dev;
> @@ -1536,7 +1535,6 @@ static struct cxl_region *devm_cxl_add_region(struct cxl_root_decoder *cxlrd,
>  	p = &cxlr->params;
>  	cxlr->mode = mode;
>  	cxlr->type = type;
> -	p->interleave_granularity = cxld->interleave_granularity;
>  
>  	dev = &cxlr->dev;
>  	rc = dev_set_name(dev, "region%d", id);
> 
