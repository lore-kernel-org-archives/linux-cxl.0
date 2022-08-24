Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EF8CC32793
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 00:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbiHXADt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 23 Aug 2022 20:03:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbiHXADs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 23 Aug 2022 20:03:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC7B895CB
        for <linux-cxl@vger.kernel.org>; Tue, 23 Aug 2022 17:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661299427; x=1692835427;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=USYtyS9txue+9Z8Mvp2ve/yVO/VLpsG+Ts8bt/IDfBw=;
  b=FUn4Sv8ORxpki/rgDbiSWeBy0paZpo1UMWe9pWhpRjh5frgKhNIBRt/c
   /mxcZEiqt6JF+VdhGSlMJrgLcOthjP2OmeM+ZAG4Zo54Fm25k9vsOdGg4
   OtvwGKzQAQnwii2EwjesMPggdNTIEh1YyitXbWLXSzP+PFHqsLWURLOut
   dG7WAWLQx2yvCv69mOVosIdQlzekbOj6cHQqoNV//l/kH7vy8X8b2MUSM
   sF2DkCSvYvEOKY6RkDWxpsqGSwMiSPK4NqJCzpYCsRDgP8I80YJvHZcrG
   ZefJrVDW0xGv2n3YYivyYQEIf2B2zHGFnWFY8uOJYnUnv4hhEB2l2muE9
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10448"; a="294613205"
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="294613205"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:03:28 -0700
X-IronPort-AV: E=Sophos;i="5.93,259,1654585200"; 
   d="scan'208";a="612592886"
Received: from djiang5-mobl1.amr.corp.intel.com (HELO [10.212.86.80]) ([10.212.86.80])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 17:03:28 -0700
Message-ID: <effb66ee-ef89-07f7-af6d-f2d32931ac91@intel.com>
Date:   Tue, 23 Aug 2022 17:03:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Firefox/91.0 Thunderbird/91.12.0
Subject: Re: [ndctl PATCH v2 1/3] cxl/region: fix a dereferecnce after NULL
 check
Content-Language: en-US
To:     Vishal Verma <vishal.l.verma@intel.com>, linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, Dan Williams <dan.j.williams@intel.com>
References: <20220823074527.404435-1-vishal.l.verma@intel.com>
 <20220823074527.404435-2-vishal.l.verma@intel.com>
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20220823074527.404435-2-vishal.l.verma@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


On 8/23/2022 12:45 AM, Vishal Verma wrote:
> A NULL check in region_action() implies that 'decoder' might be NULL, but
> later we dereference it during cxl_decoder_foreach(). The NULL check is
> valid because it was the filter result being checked, however, while
> doing this, the original 'decoder' variable was being clobbered.
>
> Check the filter results independently of the original decoder variable.
>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>   cxl/region.c | 5 ++---
>   1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/cxl/region.c b/cxl/region.c
> index a30313c..334fcc2 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -686,9 +686,8 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
>   			continue;
>   
>   		cxl_decoder_foreach (port, decoder) {
> -			decoder = util_cxl_decoder_filter(decoder,
> -							  param.root_decoder);
> -			if (!decoder)
> +			if (!util_cxl_decoder_filter(decoder,
> +						     param.root_decoder))
>   				continue;
>   			rc = decoder_region_action(p, decoder, action, count);
>   			if (rc)
