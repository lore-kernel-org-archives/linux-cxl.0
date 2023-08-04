Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AB85C001DE
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 18:03:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjHDSD0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 14:03:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHDSDZ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 14:03:25 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2AA49D7
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 11:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691172204; x=1722708204;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dg8DBI53nZCcbbH3zDVqTXjL3ZBkJPf/j9EHD3oVgWc=;
  b=OEfXL2JTYk2Sf/IZ3sEaQUs8fDOWDO2EIZY6WoQHuRxJHBtXdIALnnQB
   9D02tHE8BMdsDmX7+D8H6v1LjuxAtntZ5XcyvcX6RoGIYkBmkWpeya9Vh
   qkU3IFqFf1hc6fvsJFza/CsdwgPnO8DchvDDm/9/cAtuVumtXQ2XcXQqS
   zExoqfI6XmmNzok5h3my5s+B3vjHuU+k1BvBiTbPkRn9HFCAbyXD+RMvX
   gLw7v8aGxQYcYfueO7pAHJa6w5naFtxD6gkO7SZ3AUCJwObHhqhzavzf8
   YWWlqPIK46ibAOPT/fAgszk+TXkZkNJ8sAU8ugcW9nHpr7K/7vV+E/a4G
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="349805338"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="349805338"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:02:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="903974117"
X-IronPort-AV: E=Sophos;i="6.01,255,1684825200"; 
   d="scan'208";a="903974117"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.168.219])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 11:02:39 -0700
Date:   Fri, 4 Aug 2023 11:02:37 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     jonathan.cameron@huawei.com, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: fix compile warning for cxl_security_ops extern
Message-ID: <ZM09PdyOkS+KQtH7@aschofie-mobl2>
References: <20230228150911.00002535@Huawei.com>
 <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org


Hi Dave,

I'm seeing this sparse warning today, and it appears this patch was
never merged. Please check on it.

Alison


On Wed, Mar 01, 2023 at 04:06:58PM -0700, Dave Jiang wrote:
> Jonathan says he has observed compiler warning when using running with W=1
> C=1 for cxl_security_ops that is declared as an extern in cxl/pmem.c. Move
> to cxl.h to make it visible to all cxl sources.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
> 
> Hi Jonathan, I was not able to reproduce the issue with W=1 C=1. Can you
> please see if this fixes what you were seeing? Thanks!
> 
>  drivers/cxl/cxl.h  |    2 ++
>  drivers/cxl/pmem.c |    2 --
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f2b0962a552d..6f00b938f342 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -10,6 +10,8 @@
>  #include <linux/log2.h>
>  #include <linux/io.h>
>  
> +extern const struct nvdimm_security_ops *cxl_security_ops;
> +
>  /**
>   * DOC: cxl objects
>   *
> diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
> index 71cfa1fdf902..55930567fc01 100644
> --- a/drivers/cxl/pmem.c
> +++ b/drivers/cxl/pmem.c
> @@ -11,8 +11,6 @@
>  #include "cxlmem.h"
>  #include "cxl.h"
>  
> -extern const struct nvdimm_security_ops *cxl_security_ops;
> -
>  static __read_mostly DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
>  
>  static void clear_exclusive(void *cxlds)
> 
> 
