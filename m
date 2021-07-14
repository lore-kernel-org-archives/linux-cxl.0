Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C60CC07E9A
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jul 2021 04:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0626C61374
	for <linux-cxl@archiver.kernel.org>; Wed, 14 Jul 2021 04:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbhGNETM (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 14 Jul 2021 00:19:12 -0400
Received: from mga09.intel.com ([134.134.136.24]:49579 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229518AbhGNETM (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Wed, 14 Jul 2021 00:19:12 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10044"; a="210261393"
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="210261393"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 21:16:21 -0700
X-IronPort-AV: E=Sophos;i="5.84,238,1620716400"; 
   d="scan'208";a="459826315"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2021 21:16:21 -0700
Date:   Tue, 13 Jul 2021 21:16:20 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] cxl/pci: Fix debug message
Message-ID: <20210714041620.GB69694@iweiny-DESK2.sc.intel.com>
References: <20210714032054.293737-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714032054.293737-1-ben.widawsky@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 13, 2021 at 08:20:54PM -0700, Widawsky, Ben wrote:
> When mapping a register, the debug message should use the verb 'map' not
> 'probe'.
> 
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Yep...  Thanks for catching that!

Reviewed-by: Ira Weiny <ira.weiny@intel.com>

> ---
>  drivers/cxl/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 4cf351a3cf99..fe240e1504d5 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1048,7 +1048,7 @@ static int cxl_map_regs(struct cxl_mem *cxlm, struct cxl_register_map *map)
>  		break;
>  	case CXL_REGLOC_RBI_MEMDEV:
>  		cxl_map_device_regs(pdev, &cxlm->regs.device_regs, map);
> -		dev_dbg(dev, "Probing device registers...\n");
> +		dev_dbg(dev, "Mapping device registers...\n");
>  		break;
>  	default:
>  		break;
> -- 
> 2.32.0
> 
