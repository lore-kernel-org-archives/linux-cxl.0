Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B185C4332F
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Oct 2022 16:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229583AbiJTQyP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Oct 2022 12:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJTQyP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Oct 2022 12:54:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7233E1AE2B8
        for <linux-cxl@vger.kernel.org>; Thu, 20 Oct 2022 09:54:13 -0700 (PDT)
Received: from fraeml740-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MtYYP0mrjz67XMQ;
        Fri, 21 Oct 2022 00:52:25 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml740-chm.china.huawei.com (10.206.15.221) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 20 Oct 2022 18:54:11 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 20 Oct
 2022 17:54:10 +0100
Date:   Thu, 20 Oct 2022 17:54:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <alison.schofield@intel.com>,
        <vishal.l.verma@intel.com>, <bwidawsk@kernel.org>,
        <dan.j.williams@intel.com>, <shiju.jose@huawei.com>,
        <rrichter@amd.com>
Subject: Re: [PATCH RFC v2 5/9] cxl/port: Limit the port driver to just the
 HDM Decoder Capability
Message-ID: <20221020175409.0000370f@huawei.com>
In-Reply-To: <166336988294.3803215.7334374806071251168.stgit@djiang5-desk3.ch.intel.com>
References: <166336972295.3803215.1047199449525031921.stgit@djiang5-desk3.ch.intel.com>
        <166336988294.3803215.7334374806071251168.stgit@djiang5-desk3.ch.intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Sep 2022 16:11:22 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> Update the port driver to use cxl_map_component_registers() so that the
> component register block can be shared between the cxl_pci driver and
> the cxl_port driver. I.e. stop the port driver from reserving the entire
> component register block for itself via request_region() when it only
> needs the HDM Decoder Capability subset.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>

Makes sense
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index d1d2caea5c62..061551148cfe 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -82,18 +82,22 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>  }
>  
> -static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> -					  void __iomem *crb)
> +static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> +				struct cxl_component_regs *regs)
>  {
> -	struct cxl_component_reg_map map;
> +	struct cxl_register_map map = {
> +		.resource = port->component_reg_phys,
> +		.base = crb,
> +		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> +	};
>  
> -	cxl_probe_component_regs(&port->dev, crb, &map);
> -	if (!map.hdm_decoder.valid) {
> +	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> +	if (!map.component_map.hdm_decoder.valid) {
>  		dev_err(&port->dev, "HDM decoder registers invalid\n");
> -		return IOMEM_ERR_PTR(-ENXIO);
> +		return -ENXIO;
>  	}
>  
> -	return crb + map.hdm_decoder.offset;
> +	return cxl_map_component_regs(&port->dev, regs, &map);
>  }
>  
>  /**
> @@ -103,25 +107,25 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
>  {
>  	struct device *dev = &port->dev;
> -	void __iomem *crb, *hdm;
>  	struct cxl_hdm *cxlhdm;
> +	void __iomem *crb;
> +	int rc;
>  
>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
>  	if (!cxlhdm)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> -	crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
> -				   CXL_COMPONENT_REG_BLOCK_SIZE);
> +	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
>  	if (!crb) {
>  		dev_err(dev, "No component registers mapped\n");
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	hdm = map_hdm_decoder_regs(port, crb);
> -	if (IS_ERR(hdm))
> -		return ERR_CAST(hdm);
> -	cxlhdm->regs.hdm_decoder = hdm;
> +	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
> +	iounmap(crb);
> +	if (rc)
> +		return ERR_PTR(rc);
>  
>  	parse_hdm_decoder_caps(cxlhdm);
>  	if (cxlhdm->decoder_count == 0) {
> 
> 

