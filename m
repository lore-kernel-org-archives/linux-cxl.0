Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A91DC352A1
	for <linux-cxl@archiver.kernel.org>; Sat,  3 Dec 2022 19:59:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiLCT7I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sat, 3 Dec 2022 14:59:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLCT7H (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sat, 3 Dec 2022 14:59:07 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86B201C429
        for <linux-cxl@vger.kernel.org>; Sat,  3 Dec 2022 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1670097544; x=1701633544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GHNVJVM7WiNm8eFnRvQEwLrWxzCZ9Qh5vTBh6yHomWI=;
  b=FsPyZ0wOFDvpN+4PxIZJmlJYY2TtJVFZlZpvl90/iuuk2E0B7tg7YgJ7
   N2UbxRtS++Ib30f69ks7f9j8Ml6Pd0AZ0RO1NpK2e0CKOeiDBROkga8Gv
   QtYscNHqMC56o6dQjgK96WnvhnttTSSJ7FVe78DpLD32eGxE1wQo5yyYi
   ON5oc/Uab/hyz3pe84pU/0XE6IT1Q13HyXaoMo27EZs8B8d38v4ssWXtT
   yIxh2liGmYyDaRAqRGrsW5XWe4frGonfXVqXrQsmc+YgLCJXZzN57NBG0
   uD17PqZ4hN6LTioghkG8nBXfqlipsuP4ZDO5bfrhJyZBBKP2B1ugGPlgo
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="318000064"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="318000064"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 11:59:04 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10550"; a="819774668"
X-IronPort-AV: E=Sophos;i="5.96,214,1665471600"; 
   d="scan'208";a="819774668"
Received: from xieyunxi-mobl1.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.133.36])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2022 11:59:03 -0800
Date:   Sat, 3 Dec 2022 11:59:02 -0800
From:   Alison Schofield <alison.schofield@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, kernel test robot <lkp@intel.com>,
        rrichter@amd.com, terry.bowman@amd.com
Subject: Re: [PATCH] cxl/regs: Fix sparse warning
Message-ID: <Y4uqhj60zFgeCfNd@aschofie-mobl2>
References: <167008768190.2516013.11918622906007677341.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167008768190.2516013.11918622906007677341.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sat, Dec 03, 2022 at 09:14:41AM -0800, Dan Williams wrote:
> The 0day robot belatedly points out that @addr is not properly tagged as
> an iomap pointer:
> 
> "drivers/cxl/core/regs.c:332:14: sparse: sparse: incorrect type in
> assignment (different address spaces) @@     expected void *addr @@
> got void [noderef] __iomem * @@"
> 
> Fixes: 1168271ca054 ("cxl/acpi: Extract component registers of restricted hosts from RCRB")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/core/regs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1173912b9cf7..5a812583aee1 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -313,8 +313,8 @@ resource_size_t cxl_rcrb_to_component(struct device *dev,
>  				      enum cxl_rcrb which)
>  {
>  	resource_size_t component_reg_phys;
> +	void __iomem *addr;
>  	u32 bar0, bar1;
> -	void *addr;
>  	u16 cmd;
>  	u32 id;
>  
> 
