Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BFAC19F28
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Aug 2022 15:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiHCP2b (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Aug 2022 11:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238093AbiHCP2a (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Aug 2022 11:28:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944FC1658B
        for <linux-cxl@vger.kernel.org>; Wed,  3 Aug 2022 08:28:29 -0700 (PDT)
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LybKk3GjXz687vm;
        Wed,  3 Aug 2022 23:26:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 3 Aug 2022 17:28:27 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 3 Aug
 2022 16:28:26 +0100
Date:   Wed, 3 Aug 2022 16:28:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, kernel test robot <lkp@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <dave.jiang@intel.com>
Subject: Re: [PATCH 3/4] cxl/region: Fix port setup uninitialized variable
 warnings
Message-ID: <20220803162824.00005081@huawei.com>
In-Reply-To: <165951147487.967013.929590444907251028.stgit@dwillia2-xfh.jf.intel.com>
References: <165951145706.967013.3023584411011908037.stgit@dwillia2-xfh.jf.intel.com>
        <165951147487.967013.929590444907251028.stgit@dwillia2-xfh.jf.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml740-chm.china.huawei.com (10.201.108.190) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 03 Aug 2022 00:24:34 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> 0day robot reports:
> 
> drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'eiw'.
> drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peig'.
> drivers/cxl/core/region.c:1068 cxl_port_setup_targets() error: uninitialized symbol 'peiw'.
> 
> ...which are all valid reports. Add debug statement to consume the,
> albeit unexpected, errors.
> 
> Fixes: 27b3f8d13830 ("cxl/region: Program target lists")
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/region.c |   17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index a073f16355ca..5c931b6eb4e7 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -1059,8 +1059,21 @@ static int cxl_port_setup_targets(struct cxl_port *port,
>  		parent_iw = parent_cxld->interleave_ways;
>  	}
>  
> -	granularity_to_cxl(parent_ig, &peig);
> -	ways_to_cxl(parent_iw, &peiw);
> +	rc = granularity_to_cxl(parent_ig, &peig);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid parent granularity: %d\n",
> +			dev_name(parent_port->uport),
> +			dev_name(&parent_port->dev), parent_ig);
> +		return rc;
> +	}
> +
> +	rc = ways_to_cxl(parent_iw, &peiw);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev, "%s:%s: invalid parent interleave: %d\n",
> +			dev_name(parent_port->uport),
> +			dev_name(&parent_port->dev), parent_iw);
> +		return rc;
> +	}
>  
>  	iw = cxl_rr->nr_targets;
>  	ways_to_cxl(iw, &eiw);
> 

