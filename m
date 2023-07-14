Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24208EB64DC
	for <linux-cxl@archiver.kernel.org>; Fri, 14 Jul 2023 20:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbjGNUvD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 14 Jul 2023 16:51:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjGNUvD (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 14 Jul 2023 16:51:03 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 149F626AF
        for <linux-cxl@vger.kernel.org>; Fri, 14 Jul 2023 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689367862; x=1720903862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=s4dJvt67fZ2y9xAIHzjOMh7KSWEPv3jw0VUQ1rilKiM=;
  b=ir9Te1QUR9C7e4JNyog9J8ennkanclUjzMSYpUNP76tmrWIRq5h7TCUF
   Is8EPp6svZwDH0SjEfqHUr6OxTEj8Z9Cm+mnVedsO0ev9bDkd1jIPUlM3
   q/LCeXjwiZFdceDb9leA459xOdPcXA73fIR9V2PvmfNPh00iMjnuMq+DO
   IqbExv1aY9XB2l+5zsZdKTors5+O8ADnFhmnQ/Qi+CS7wyvqtCXBO3TTJ
   W8rtoa8kCFziI570G1cZ7qeo1c46if+lEF+XvZEdXW98pnbBIe2CfWpGl
   qRYwhJa94PgkR4dH8+5gDV2u5dr9jXen6JNFaU/uy/R97h+2CgD+yk/ao
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="396389736"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="396389736"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:51:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="896548865"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="896548865"
Received: from aschofie-mobl2.amr.corp.intel.com (HELO aschofie-mobl2) ([10.212.181.205])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 13:51:01 -0700
Date:   Fri, 14 Jul 2023 13:50:59 -0700
From:   Alison Schofield <alison.schofield@intel.com>
To:     Breno Leitao <leitao@debian.org>
Cc:     vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, linux-cxl@vger.kernel.org,
        dave.jiang@intel.com
Subject: Re: [PATCH v3 2/2] cxl/acpi: Do not swallow errors
Message-ID: <ZLG1M5e2RSMuGBvc@aschofie-mobl2>
References: <20230714093146.2253438-1-leitao@debian.org>
 <20230714093146.2253438-2-leitao@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714093146.2253438-2-leitao@debian.org>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jul 14, 2023 at 02:31:46AM -0700, Breno Leitao wrote:
> Driver initialization is returning success (return 0) even if the
> initialization (cxl_decoder_add() or acpi_table_parse_cedt()) failed,
> and the hardware was already released (put_device()).
> 
> Return the error instead of swallowing it.
> 
> Fixes: f4ce1f766f1e ("cxl/acpi: Convert CFMWS parsing to ACPI sub-table helpers")
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Alison Schofield <alison.schofield@intel.com>

> ---
>  drivers/cxl/acpi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 642983da01cb..815b43859c16 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -298,7 +298,7 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	if (rc) {
>  		dev_err(dev, "Failed to add decode range [%#llx - %#llx]\n",
>  			res->start, res->end);
> -		return 0;
> +		return rc;
>  	}
>  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>  		dev_name(&cxld->dev),
> -- 
> 2.34.1
> 
