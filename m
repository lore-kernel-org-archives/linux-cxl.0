Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 074AFC433EF
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Oct 2021 23:36:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC8516108E
	for <linux-cxl@archiver.kernel.org>; Mon, 18 Oct 2021 23:36:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbhJRXiW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 18 Oct 2021 19:38:22 -0400
Received: from mga01.intel.com ([192.55.52.88]:5913 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229608AbhJRXiV (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 18 Oct 2021 19:38:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10141"; a="251852560"
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="251852560"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 16:36:09 -0700
X-IronPort-AV: E=Sophos;i="5.85,382,1624345200"; 
   d="scan'208";a="482987258"
Received: from rgduran-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.135.129])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2021 16:36:09 -0700
Date:   Mon, 18 Oct 2021 16:36:08 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, Chet Douglas <chet.r.douglas@intel.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 27/27] dont-merge: My QEMU CFMWS is wrong
Message-ID: <20211018233608.7bokwy7htgl5hp2k@intel.com>
References: <20211016051531.622613-1-ben.widawsky@intel.com>
 <20211016051531.622613-28-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211016051531.622613-28-ben.widawsky@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On 21-10-15 22:15:31, Ben Widawsky wrote:
> It seems to only be me... Use this at your own risk.
> ---

I wasn't building the right QEMU SHA. This patch shouldn't be needed.

>  drivers/cxl/region.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index a861001ced5b..6e4d79b32e41 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -404,8 +404,10 @@ static bool cfmws_valid(const struct cxl_region *region,
>  	if (!qtg_match(cfmws, endpoint))
>  		return false;
>  
> +#if 0
>  	if (!cxl_is_pmem_t3(cfmws->flags))
>  		return false;
> +#endif
>  
>  	if (!region_xhb_config_valid(region, cfmws))
>  		return false;
> -- 
> 2.33.1
> 
