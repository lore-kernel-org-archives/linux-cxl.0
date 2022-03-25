Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D40BEC433F5
	for <linux-cxl@archiver.kernel.org>; Fri, 25 Mar 2022 11:35:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358002AbiCYLgi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 25 Mar 2022 07:36:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357600AbiCYLgY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 25 Mar 2022 07:36:24 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3781DD4C95
        for <linux-cxl@vger.kernel.org>; Fri, 25 Mar 2022 04:34:25 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KQ0Ls3wnDz67y8J;
        Fri, 25 Mar 2022 19:32:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 25 Mar 2022 12:34:16 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 25 Mar
 2022 11:34:16 +0000
Date:   Fri, 25 Mar 2022 11:34:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Davidlohr Bueso <dave@stgolabs.net>,
        <ben.widawsky@intel.com>, <ira.weiny@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>
Subject: Re: [PATCH v2 1/6] cxl/mem: Drop DVSEC vs EFI Memory Map sanity
 check
Message-ID: <20220325113414.00004754@huawei.com>
In-Reply-To: <164730734246.3806189.13995924771963139898.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164730733718.3806189.9721916820488234094.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164730734246.3806189.13995924771963139898.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml745-chm.china.huawei.com (10.201.108.195) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 14 Mar 2022 18:22:22 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> When the driver finds legacy DVSEC ranges active on a CXL Memory
> Expander it indicates that platform firmware is not aware of, or is
> deliberately disabling common CXL 2.0 operation. In this case Linux
> generally has no choice, but to leave the device alone.
> 
> The driver attempts to validate that the DVSEC range is in the EFI
> memory map. Remove that logic since there is no requirement that the
> BIOS publish DVSEC ranges in the EFI Memory Map.
> 
> In the future the driver will want to permanently reserve this capacity
> out of the available CFMWS capacity and hide it from
> request_free_mem_region(), but it serves no purpose to warn about the
> range not appearing in the EFI Memory Map.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/mem.c |   24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index 49a4b1c47299..cd4e8bba82aa 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -158,30 +158,8 @@ static int cxl_mem_probe(struct device *dev)
>  	 * is no use in trying to manage those.
>  	 */
>  	if (!cxl_dvsec_decode_init(cxlds)) {
> -		struct cxl_endpoint_dvsec_info *info = &cxlds->info;
> -		int i;
> -
> -		/* */
> -		for (i = 0; i < 2; i++) {
> -			u64 base, size;
> -
> -			/*
> -			 * Give a nice warning to the user that BIOS has really
> -			 * botched things for them if it didn't place DVSEC
> -			 * ranges in the memory map.
> -			 */
> -			base = info->dvsec_range[i].start;
> -			size = range_len(&info->dvsec_range[i]);
> -			if (size && !region_intersects(base, size,
> -						       IORESOURCE_SYSTEM_RAM,
> -						       IORES_DESC_NONE)) {
> -				dev_err(dev,
> -					"DVSEC range %#llx-%#llx must be reserved by BIOS, but isn't\n",
> -					base, base + size - 1);
> -			}
> -		}
>  		dev_err(dev,
> -			"Active DVSEC range registers in use. Will not bind.\n");
> +			"Legacy range registers configuration prevents HDM operation.\n");
>  		return -EBUSY;
>  	}
>  
> 

