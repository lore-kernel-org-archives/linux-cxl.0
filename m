Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3D94C83F12
	for <linux-cxl@archiver.kernel.org>; Tue, 29 Aug 2023 13:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235213AbjH2Nyb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 29 Aug 2023 09:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236525AbjH2NyI (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 29 Aug 2023 09:54:08 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB8E194;
        Tue, 29 Aug 2023 06:54:05 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RZph9186cz67nc4;
        Tue, 29 Aug 2023 21:49:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 29 Aug
 2023 14:54:02 +0100
Date:   Tue, 29 Aug 2023 14:54:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Terry Bowman <terry.bowman@amd.com>
CC:     <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>, <rrichter@amd.com>,
        <linux-kernel@vger.kernel.org>, <bhelgaas@google.com>
Subject: Re: [PATCH v9 15/15] cxl/core/regs: Rename phys_addr in
 cxl_map_component_regs()
Message-ID: <20230829145401.0000554a@Huawei.com>
In-Reply-To: <20230825233211.3029825-16-terry.bowman@amd.com>
References: <20230825233211.3029825-1-terry.bowman@amd.com>
        <20230825233211.3029825-16-terry.bowman@amd.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 25 Aug 2023 18:32:11 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> From: Robert Richter <rrichter@amd.com>
> 
> Trivial change that renames variable phys_addr in
> cxl_map_component_regs() to shorten its length to keep the 80 char
> size limit for the line and also for consistency between the different
> paths.
> 
LGTM
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> Signed-off-by: Robert Richter <rrichter@amd.com>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/regs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 5cb78b76c757..f8f26fe80489 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -217,16 +217,16 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
>  
>  	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
>  		struct mapinfo *mi = &mapinfo[i];
> -		resource_size_t phys_addr;
> +		resource_size_t addr;
>  		resource_size_t length;
>  
>  		if (!mi->rmap->valid)
>  			continue;
>  		if (!test_bit(mi->rmap->id, &map_mask))
>  			continue;
> -		phys_addr = map->resource + mi->rmap->offset;
> +		addr = map->resource + mi->rmap->offset;
>  		length = mi->rmap->size;
> -		*(mi->addr) = devm_cxl_iomap_block(dev, phys_addr, length);
> +		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
>  		if (!*(mi->addr))
>  			return -ENOMEM;
>  	}

