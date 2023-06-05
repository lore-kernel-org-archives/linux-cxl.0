Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710C2C77B73
	for <linux-cxl@archiver.kernel.org>; Mon,  5 Jun 2023 08:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbjFEIql (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Jun 2023 04:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjFEIqk (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Jun 2023 04:46:40 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811A5B0
        for <linux-cxl@vger.kernel.org>; Mon,  5 Jun 2023 01:46:38 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QZRxN5lvyz67j66;
        Mon,  5 Jun 2023 16:44:40 +0800 (CST)
Received: from localhost (10.195.244.35) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 5 Jun
 2023 09:46:35 +0100
Date:   Mon, 5 Jun 2023 09:46:34 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ira.weiny@intel.com>,
        <navneet.singh@intel.com>
Subject: Re: [PATCH 01/19] cxl/regs: Clarify when a 'struct
 cxl_register_map' is input vs output
Message-ID: <20230605094634.00002499@Huawei.com>
In-Reply-To: <168592150323.1948938.2728742883585170051.stgit@dwillia2-xfh.jf.intel.com>
References: <168592149709.1948938.8663425987110396027.stgit@dwillia2-xfh.jf.intel.com>
        <168592150323.1948938.2728742883585170051.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.35]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Sun, 04 Jun 2023 16:31:43 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The @map parameter to cxl_probe_X_registers() is filled in with the
> mapping parameters of the register block. The @map parameter to
> cxl_map_X_registers() only reads that information to perform the
> mapping. Mark @map const for cxl_map_X_registers() to clarify that it is
> only an input to those helpers.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
This makes sense as a stand alone clarification.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/regs.c |    8 ++++----
>  drivers/cxl/cxl.h       |    4 ++--
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 1476a0299c9b..52d1dbeda527 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -200,10 +200,10 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  }
>  
>  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map, unsigned long map_mask)
> +			   const struct cxl_register_map *map, unsigned long map_mask)
>  {
>  	struct mapinfo {
> -		struct cxl_reg_map *rmap;
> +		const struct cxl_reg_map *rmap;
>  		void __iomem **addr;
>  	} mapinfo[] = {
>  		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
> @@ -233,11 +233,11 @@ EXPORT_SYMBOL_NS_GPL(cxl_map_component_regs, CXL);
>  
>  int cxl_map_device_regs(struct device *dev,
>  			struct cxl_device_regs *regs,
> -			struct cxl_register_map *map)
> +			const struct cxl_register_map *map)
>  {
>  	resource_size_t phys_addr = map->resource;
>  	struct mapinfo {
> -		struct cxl_reg_map *rmap;
> +		const struct cxl_reg_map *rmap;
>  		void __iomem **addr;
>  	} mapinfo[] = {
>  		{ &map->device_map.status, &regs->status, },
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f93a28538962..dfc94e76c7d6 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -254,10 +254,10 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  			   struct cxl_device_reg_map *map);
>  int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
> -			   struct cxl_register_map *map,
> +			   const struct cxl_register_map *map,
>  			   unsigned long map_mask);
>  int cxl_map_device_regs(struct device *dev, struct cxl_device_regs *regs,
> -			struct cxl_register_map *map);
> +			const struct cxl_register_map *map);
>  
>  enum cxl_regloc_type;
>  int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
> 

