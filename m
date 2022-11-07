Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DB4C4332F
	for <linux-cxl@archiver.kernel.org>; Mon,  7 Nov 2022 20:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232192AbiKGUhS (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 7 Nov 2022 15:37:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiKGUhR (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 7 Nov 2022 15:37:17 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0929C264A1
        for <linux-cxl@vger.kernel.org>; Mon,  7 Nov 2022 12:37:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1667853436; x=1699389436;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EvBJMt5izJ7lXkcPxO7wLj7Ll/WOJCkwBpH8+pZJIsQ=;
  b=f76IJC1vOcURarFvlAsijbDstjyh47FZHnOdoEUGfpr6fXrnag0UvEPG
   JkGrBqaWeekmqpIJCqo3uqUxZ3iX1URP6CCmDpaIfYio1xEwmGj6Nv07V
   MTAef3vBeZDJ9fmFsGUgtedTde+lTWrcyhxHKEtPEbY8RtY1Hr7p5/m0Y
   2FzXZm8XK57q3DlorVJUPckqriqyJ1IiRYfU7jq/Uuq9rPy9BW9S7C1dZ
   DYm6oWORFEHV1LfCt6DOv2go9aVg/XxUsqui2Bshw/8uasrbhpKNeT0TH
   04nhpUfmbaOF2J3t7iCU1c3JxGA4WRaRoFYChl55Y/EFhsQwDSI82OdPu
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="290908222"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="290908222"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:36:51 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10524"; a="638517760"
X-IronPort-AV: E=Sophos;i="5.96,145,1665471600"; 
   d="scan'208";a="638517760"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.209.100.77])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Nov 2022 12:36:51 -0800
Date:   Mon, 7 Nov 2022 12:36:49 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     vishal.l.verma@intel.com, linux-cxl@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [ndctl PATCH 13/15] cxl/region: Default to memdev mode for
 create with no arguments
Message-ID: <Y2lsYawI3eQayact@aschofie-mobl2>
References: <166777840496.1238089.5601286140872803173.stgit@dwillia2-xfh.jf.intel.com>
 <166777848122.1238089.2150948506074701593.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166777848122.1238089.2150948506074701593.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, Nov 06, 2022 at 03:48:01PM -0800, Dan Williams wrote:
> Allow for:
> 
>    cxl create-region -d decoderX.Y
> 
> ...to assume (-m -w $(count of memdevs beneath decoderX.Y))

I'm not understanding what the change is here. Poked around a bit
and still didn't get it. Help!

Leaving out the -m leads to this:
$ cxl create-region -d decoder3.3 mem0 mem1
cxl region: parse_create_options: must specify option for target object types (-m)
cxl region: cmd_create_region: created 0 regions

Leaving out the the -m and the memdevs fails because the memdev order is
not correct. 
$ cxl create-region -d decoder3.3
cxl region: create_region: region5: failed to set target0 to mem1
cxl region: cmd_create_region: created 0 regions

This still works, where I give the -m and the correct order of memdevs.
cxl create-region -m -d decoder3.3 mem0 mem1

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  cxl/region.c |   16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index aa0735194fa1..c0cf4ab350da 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -227,10 +227,13 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
>  	}
>  
>  	/*
> -	 * For all practical purposes, -m is the default target type, but
> -	 * hold off on actively making that decision until a second target
> -	 * option is available.
> +	 * For all practical purposes, -m is the default target type, but hold
> +	 * off on actively making that decision until a second target option is
> +	 * available. Unless there are no arguments then just assume memdevs.
>  	 */
> +	if (!count)
> +		param.memdevs = true;
> +
>  	if (!param.memdevs) {
>  		log_err(&rl,
>  			"must specify option for target object types (-m)\n");
> @@ -272,11 +275,8 @@ static int parse_create_options(struct cxl_ctx *ctx, int count,
>  		p->ways = count;
>  		if (!validate_ways(p, count))
>  			return -EINVAL;
> -	} else {
> -		log_err(&rl,
> -			"couldn't determine interleave ways from options or arguments\n");
> -		return -EINVAL;
> -	}
> +	} else
> +		p->ways = p->num_memdevs;
>  
>  	if (param.granularity < INT_MAX) {
>  		if (param.granularity <= 0) {
> 
