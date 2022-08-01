Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFD94C19F2C
	for <linux-cxl@archiver.kernel.org>; Mon,  1 Aug 2022 19:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233553AbiHATeI (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 1 Aug 2022 15:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiHATeH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 1 Aug 2022 15:34:07 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EB322AC79
        for <linux-cxl@vger.kernel.org>; Mon,  1 Aug 2022 12:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659382446; x=1690918446;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dd0N//4fnJJwknm5JDVRw/ynWUFMyLFTd+vEOUF9brc=;
  b=ib46c7rZ2YXG61RelPRt1e8TRR/eDXL3KMvRzk20hYuv9/zx6PUCamkl
   4ZbErwai1dTezNoTCl4zilQq/xIu2TMiObkjCWkK/IKeDXhXTufLKEslF
   UnSXLEcYHnb6gqxmL9eOP2oy8EuJAW3JL98XYO9vYhNFYBV1kzz78RyOq
   xPQMcnZ32DN6xSI0u451ZzBoBJGLonlCHUC9/XiDUuzr31BA9n8qwbO/H
   lZLFBRr0AxtoxbwZ1Laa/fbiryfntkJd+KghbJ0oucxKhvEQpZbKFvelc
   8IeyGDtn62+bRV762k9iMJFIh1GsOm5hL4EGVb2X02DtIzpeylRX8KpDz
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10426"; a="353233838"
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="353233838"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:34:05 -0700
X-IronPort-AV: E=Sophos;i="5.93,208,1654585200"; 
   d="scan'208";a="670164518"
Received: from alison-desk.jf.intel.com (HELO alison-desk) ([10.54.74.41])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 12:34:05 -0700
Date:   Mon, 1 Aug 2022 12:32:04 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/5] cxl/region: Delete 'region' attribute from root
 decoders
Message-ID: <20220801193204.GA1722942@alison-desk>
References: <165853775181.2430596.3054032756974329979.stgit@dwillia2-xfh.jf.intel.com>
 <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <165853776328.2430596.4647259305040072751.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 22, 2022 at 05:56:03PM -0700, Dan Williams wrote:
> For switch and endpoint decoders the relationship of decoders to regions
> is 1:1. However, for root decoders the relationship is 1:N. Also,
> regions are already children of root decoders, so the 1:N relationship
> is observed by walking the following glob:
> 
>     /sys/bus/cxl/devices/$decoder/region*
> 
> Hide the vestigial 'region' attribute for root decoders.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/port.c |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 3d2d0119cc3d..bffde862de0b 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -290,7 +290,6 @@ static struct attribute *cxl_decoder_base_attrs[] = {
>  	&dev_attr_locked.attr,
>  	&dev_attr_interleave_granularity.attr,
>  	&dev_attr_interleave_ways.attr,
> -	SET_CXL_REGION_ATTR(region)
>  	NULL,
>  };
>  
> @@ -345,6 +344,7 @@ static const struct attribute_group *cxl_decoder_root_attribute_groups[] = {
>  static struct attribute *cxl_decoder_switch_attrs[] = {
>  	&dev_attr_target_type.attr,
>  	&dev_attr_target_list.attr,
> +	SET_CXL_REGION_ATTR(region)
>  	NULL,
>  };
>  
> @@ -364,6 +364,7 @@ static struct attribute *cxl_decoder_endpoint_attrs[] = {
>  	&dev_attr_mode.attr,
>  	&dev_attr_dpa_size.attr,
>  	&dev_attr_dpa_resource.attr,
> +	SET_CXL_REGION_ATTR(region)
>  	NULL,
>  };
>  
> 
