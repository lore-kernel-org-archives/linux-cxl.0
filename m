Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9804EC5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 22:52:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbjAKWwa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjAKWwa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 17:52:30 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61D9AF71
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 14:52:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673477549; x=1705013549;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0+miRoWk1/XBQzLnm9tE5na0Pmf8+9CnqdL7nH6BRZk=;
  b=UfulRVMvcRmt+X9zkfD6f+ceOsJ6vRxs0Kp911F95ZSEdLrVNiegMZU2
   /6YwlASnEFFcJPm8NkmVfZx/YoNAbeeDG0bhijqtHgvBKsBS3TKfHeZMQ
   lR6iGCPeVuoCndCnl391abCb01QErVtnxahvtMsuwbpVtA8xFFmSp/0lJ
   97dt4KW0SHJx21cdx1qsjstjCNaHW8wxG4tcY6wSORJ/9aekXeSiOvwc0
   21TmPW7pgQcz99K9BhkgP5c0shpAK/JcX9xqRCvk3gmkkKpztdwu9XsXv
   bgO61scRIVPyPZL+b/WF8XhFctloQ0PREKmhW2uv9sAArX0e8QV6g9JO5
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="385871842"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="385871842"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:52:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="799993332"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="799993332"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.147.120])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:52:28 -0800
Date:   Wed, 11 Jan 2023 14:52:26 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH ndctl 2/4] cxl/region: fix a resource leak in to_csv()
Message-ID: <Y789qoHN9jkSAdTW@aschofie-mobl2>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
 <20230110-vv-coverity-fixes-v1-2-c7ee6c76b200@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110-vv-coverity-fixes-v1-2-c7ee6c76b200@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 10, 2023 at 04:09:15PM -0700, Vishal Verma wrote:
> Static analysis reports there can be a memory leak in to_csv as an exit
> path returns from the function before freeing 'csv'. Since this is the
> only errpr path exit point after the allocation, just free() before
> returning.
> 
> Fixes: 3d6cd829ec08 ("cxl/region: Use cxl_filter_walk() to gather create-region targets")
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
>  cxl/region.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index bb3a10a..9a81113 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -146,8 +146,10 @@ static const char *to_csv(int *count, const char **strings)
>  		return NULL;
>  	for (i = 0; i < *count; i++) {
>  		list = strdup(strings[i]);
> -		if (!list)
> +		if (!list) {
> +			free(csv);
>  			return NULL;
> +		}
>  
>  		for (arg = strtok_r(list, which_sep(list), &save); arg;
>  		     arg = strtok_r(NULL, which_sep(list), &save)) {
> 
> -- 
> 2.39.0
