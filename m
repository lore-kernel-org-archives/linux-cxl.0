Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAA2BC5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 22:53:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232976AbjAKWxt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234565AbjAKWxq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 17:53:46 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 319211D0D6
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 14:53:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673477626; x=1705013626;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jneDPPBemNpRcu3JLunQ3yotTwUSwIZPtVl3xyNfOXU=;
  b=fbODLxHU9DMLj6NZgZ2mvpr265LcskQAWOAyt8PadvMZkREw02Qlh2HV
   aTwpWls3uR7/TomlprHUzv65dsf9PQ9L+/lLZU6g74Rz2wWImw43wApWB
   YGxW2qrd5TcgN3TqiaiAARngnOLJST6AAa2xsuQ13EY+gaKnPPiur9V+2
   iETIv0FhJHEJJBfeN43retNVciemhHfkpdYy03zwVokjrL5pfmmyyiFfC
   pI9NBNkmzE6rGzlBr/4AK3zmAI1eQeKOK5enDgnLovF/SRGxfqUvQ4pn3
   1QZXmrr4XCZGoJ1qdPQ4el2GC/ai8Fb8gWqTJimEYzWFtOAW0HCcnxt9Q
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="303252834"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="303252834"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:53:45 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="781547820"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="781547820"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.147.120])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:53:45 -0800
Date:   Wed, 11 Jan 2023 14:53:43 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH ndctl 3/4] cxl/region: fix an out of bounds access in
 to_csv()
Message-ID: <Y78998QtaLH7p0uv@aschofie-mobl2>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
 <20230110-vv-coverity-fixes-v1-3-c7ee6c76b200@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110-vv-coverity-fixes-v1-3-c7ee6c76b200@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 10, 2023 at 04:09:16PM -0700, Vishal Verma wrote:
> Static analysis reports that when 'csv' is allocated for 'len' bytes,
> writing to csv[len] results in an out of bounds access. Fix this
> truncation operation to instead write the NUL terminator to csv[len -
> 1], which is the last byte of the memory allocated.
> 
> Fixes: 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  cxl/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 9a81113..89be9b5 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -156,7 +156,7 @@ static const char *to_csv(int *count, const char **strings)
>  			cursor += snprintf(csv + cursor, len - cursor, "%s%s",
>  					   arg, i + 1 < new_count ? "," : "");
>  			if (cursor >= len) {
> -				csv[len] = 0;
> +				csv[len - 1] = 0;
>  				break;
>  			}
>  		}
> 
> -- 
> 2.39.0
> 
