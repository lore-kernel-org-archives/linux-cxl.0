Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32302C5479D
	for <linux-cxl@archiver.kernel.org>; Wed, 11 Jan 2023 22:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233540AbjAKWyX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 11 Jan 2023 17:54:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232580AbjAKWyW (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 11 Jan 2023 17:54:22 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8F6F71
        for <linux-cxl@vger.kernel.org>; Wed, 11 Jan 2023 14:54:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673477661; x=1705013661;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5uBLHB9cbk7mSKEFflbdc2SuHGQr8PDUw+lPftxj7q4=;
  b=S5EtBuwxFUNKQNXqTEXTtg72YNenY7JUK9bTibu8WJqxupB2BoCgE12k
   o4FBKTON9x0iRYCaX34c/80KrJMZeH1sGDcE9G4VmUyy68jy8zNDhBt4C
   EqIu7UoKV5vxWifAlpi8KZSfXXVGVSOKpQ/+8yq5cfSRCVt2qB69cgPLd
   WclFD/h9pbBf3u7c6UP+2pYBXZH655Wc8J4fjsa9bPv4l8nF0tPwM859i
   Z6lBTafRW0D4bnmaXA0VB3RLQizYnb45gNiuCUvGtIWndOjiHd2vmFaSQ
   3l+sy5kYvtJl4KH4OzJIEJnLS3yFa3LdoeFiKY6bO/W3g+SJggQzC61x0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="307079406"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="307079406"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:54:20 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10586"; a="659551847"
X-IronPort-AV: E=Sophos;i="5.96,318,1665471600"; 
   d="scan'208";a="659551847"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.147.120])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2023 14:54:17 -0800
Date:   Wed, 11 Jan 2023 14:54:15 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
Cc:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        Dave Jiang <dave.jiang@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH ndctl 4/4] cxl/region: fix a comment typo
Message-ID: <Y78+F14RdTGaPQP4@aschofie-mobl2>
References: <20230110-vv-coverity-fixes-v1-0-c7ee6c76b200@intel.com>
 <20230110-vv-coverity-fixes-v1-4-c7ee6c76b200@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230110-vv-coverity-fixes-v1-4-c7ee6c76b200@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 10, 2023 at 04:09:17PM -0700, Vishal Verma wrote:
> Fix a typo: s/separted/separated/
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  cxl/region.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index 89be9b5..efe05aa 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -103,7 +103,7 @@ static const struct option destroy_options[] = {
>  
>  /*
>   * Convert an array of strings that can be a mixture of single items, a
> - * command separted list, or a space separated list, into a flattened
> + * command separated list, or a space separated list, into a flattened
>   * comma-separated string. That single string can then be used as a
>   * filter argument to cxl_filter_walk(), or an ordering constraint for
>   * json_object_array_sort()
> 
> -- 
> 2.39.0
