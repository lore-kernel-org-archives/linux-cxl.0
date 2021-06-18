Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4B08C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:08:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8254F6044F
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:08:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234013AbhFROKm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:10:42 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3284 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbhFROKf (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 10:10:35 -0400
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G60rY3rVMz6M4lW;
        Fri, 18 Jun 2021 21:58:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:08:24 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 15:08:24 +0100
Date:   Fri, 18 Jun 2021 15:08:15 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 1/5] cxl/region: Only allow CXL capable targets
Message-ID: <20210618150815.00007cfd@Huawei.com>
In-Reply-To: <20210618005200.997804-2-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
        <20210618005200.997804-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.28]
X-ClientProxiedBy: lhreml748-chm.china.huawei.com (10.201.108.198) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 17 Jun 2021 17:51:56 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> A cxl_memdev exists for all CXL endpoints that support the CXL.io
> protocol. If that device cannot participate in CXL.mem protocol, then it
> cannot be part of a region's interleave set.
> 
> The ABI allows setting a target which is currently not CXL.mem capable
> and only will fail when the binding to the region driver occurs. This is
> in line with the other configuration parameters which are only strictly
> validated when the driver gets bound to the region.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.h    |  5 +++++
>  drivers/cxl/region.c | 12 +++++++++++-
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
> index ff1f9c57e089..3d51bf6c090f 100644
> --- a/drivers/cxl/mem.h
> +++ b/drivers/cxl/mem.h
> @@ -84,4 +84,9 @@ struct cxl_mem {
>  	struct range ram_range;
>  };
>  
> +static inline bool is_cxl_capable(struct cxl_memdev *cxlmd)

is_cxl_mem_capable()?

Can be cxl capable in many other senses!

> +{
> +	return false;
> +}
> +
>  #endif /* __CXL_MEM_H__ */
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 2e73ece001ec..837f4314ffcc 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -176,6 +176,10 @@ static size_t set_targetN(struct cxl_region *region, const char *buf, int n, siz
>  		return -ENOENT;
>  
>  	cxlmd = to_cxl_memdev(memdev_dev);
> +	if (!is_cxl_capable(cxlmd))
> +		dev_dbg(&region->dev,
> +			"Setting a target which doesn't support CXL.mem");
> +
>  	get_device(&cxlmd->dev);
>  	region->targets[n] = cxlmd;
>  
> @@ -432,11 +436,17 @@ static int bind_region(struct cxl_region *region)
>  		return -ENXIO;
>  	}
>  
> -	for (i = 0; i < region->eniw; i++)
> +	for (i = 0; i < region->eniw; i++) {
>  		if (!region->targets[i]) {
>  			trace_cxl_region_bind(region, "Missing memory device target");
>  			return -ENXIO;
>  		}
> +		if (!is_cxl_capable(region->targets[i])) {
> +			trace_cxl_region_bind(region,
> +					      "Target isn't CXL.mem capable");
> +			return -ENODEV;
> +		}
> +	}
>  
>  	rc = allocate_region_addr(region);
>  	if (rc)

