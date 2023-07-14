Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D75AEB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 20:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236134AbjGNUue (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 16:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNUud (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 16:50:33 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C6A130DA
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 13:50:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689367832; x=1720903832;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uPFMi+iE0E94281ENVkyQuOgql3DoJAcR00uYZSxamo=;
  b=PyzYP7o0cKaEBTDZArBTDbgW6XKDs/NmSU6H7T3QSKOORVi+I7H28WfN
   6k7f1j/jYo6l0rEFSbS3FrB4ilDxV/h4T95qp9FvNu/J4jfqidMtx+mcD
   QB3LdW/Oe/lAjXsMaRKAQhS5d/hJ1zua7u/llaPve6kjurVe9b79DUFu7
   9AfIjFWk+yoj0MtbIHxNJQqfHbOoTbJroPTlDD9L7SzdoWSF9tXK2pJE/
   MrZQv2zgO7za4bTww/v0ZTa0K4JyjwTeEhnLojNf6xVH0vSJ4A6rI7h4F
   dZqkRiWpsi1aPEJLq+ZZYh9oolm1HhDfrnCMD+VARTmhvL4d4Mf3t8sZp
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="396389471"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="396389471"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:50:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="896548776"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="896548776"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.181.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:50:30 -0700
Date:   Fri, 14 Jul 2023 13:50:29 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        dave.jiang@intel.com
Subject: Re: [PATCH v3 1/2] cxl/acpi: Fix UAF in the error path
Message-ID: <ZLG1FYrdc/6gHl+E@aschofie-mobl2>
References: <20230714093146.2253438-1-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714093146.2253438-1-leitao@debian.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 14, 2023 at 02:31:45AM -0700, Breno Leitao wrote:
> KASAN and KFENCE detected an user-after-free in the CXL driver. This
> happens in the cxl_decoder_add() fail path. KASAN prints the following
> error:
> 
>    BUG: KASAN: slab-use-after-free in cxl_parse_cfmws (drivers/cxl/acpi.c:299)
> 
> This is happening in cxl_parse_cfmws(), where put_device() is called,
> releasing cxld, which is accessed later.
> 
> Just use the local variables in the dev_err() instead of pointing to the
> released memory.
> 
> Fixes: e50fe01e1f2a ("cxl/core: Drop ->platform_res attribute for root decoders")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>


> ---
> v1 -> v2
>  * Return the error (rc) instead of swalling it
> v2 -> v3
>  * Split the change in two patches
>  * Fix the reference instead of the order
> 
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 658e6b84a769..642983da01cb 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -297,7 +297,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  		rc = cxl_decoder_autoremove(dev, cxld);
>  	if (rc) {
>  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
> -			cxld->hpa_range.start, cxld->hpa_range.end);
> +			res->start, res->end);
>  		return 0;
>  	}
>  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
> -- 
> 2.34.1
> 
