Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48B1EC7EE30
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Mar 2023 00:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjCBARM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 19:17:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjCBARI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 19:17:08 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345764FA91
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 16:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677716227; x=1709252227;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qU0+zCZ6gzF8j9PsE4U+CezqucY5RiDgi6fMnedAsKs=;
  b=ASOkaalznZ+TMijfrCJHl0uoq+T/A0cWkkgLjsPiOYeTvOdl1YnEWYmE
   HRgAWT7x3qBsBBk19S6t6MbR9G2nUYuhSPAQpoqF+KIXcY4kXWp+hNFAC
   HgUuCTa1rS+PnexB8bPg6ad7zjq/3PQZofY1to1TdfIbSvAQxBBZ5BOCr
   dIL4vRL7fzFyIJDJUr/ns6PBt8pgmzTKW5D6j21VOlo6AjZq3LezcByWp
   IQ0zKAACV2kS3MNRC6aqIUwUzhpGG8jjUPyVSYOCx0oGHVexP7BA8zQEj
   8ZRx38WeUh46cW6vlf3618uZvc0Yjd0NkE5fACIBL+tW5kjZ0hRFLW0lV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="336860256"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="336860256"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:17:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10636"; a="763787950"
X-IronPort-AV: E=Sophos;i="5.98,225,1673942400"; 
   d="scan'208";a="763787950"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.252.139.73])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Mar 2023 16:17:06 -0800
Date:   Wed, 1 Mar 2023 16:17:04 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     jonathan.cameron@huawei.com, dan.j.williams@intel.com,
        linux-cxl@vger.kernel.org
Subject: Re: [PATCH] cxl: fix compile warning for cxl_security_ops extern
Message-ID: <Y//rABaux/8Cgx0q@aschofie-mobl2>
References: <20230228150911.00002535@Huawei.com>
 <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167771196186.3285982.18283746206612049722.stgit@djiang5-mobl3.local>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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

I was seeing this with make C=2 -Wsparse-all
Works without complaint now.

Tested-by: Alison Schofield <alison.schofield@intel.com>

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
