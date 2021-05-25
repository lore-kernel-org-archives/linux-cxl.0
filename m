Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0262BC2B9F8
	for <linux-cxl@archiver.kernel.org>; Tue, 25 May 2021 09:54:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0F4861421
	for <linux-cxl@archiver.kernel.org>; Tue, 25 May 2021 09:54:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232805AbhEYJ41 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 May 2021 05:56:27 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:3658 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232784AbhEYJ40 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 May 2021 05:56:26 -0400
Received: from dggems704-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Fq8VH0vQ5zQsgX;
        Tue, 25 May 2021 17:51:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 dggems704-chm.china.huawei.com (10.3.19.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 25 May 2021 17:54:55 +0800
Received: from localhost (10.52.120.147) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2176.2; Tue, 25 May
 2021 10:54:52 +0100
Date:   Tue, 25 May 2021 10:53:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/5] cxl/mem: Introduce cxl_decode_register_block()
Message-ID: <20210525105304.000029b8@Huawei.com>
In-Reply-To: <20210522001154.2680157-2-ira.weiny@intel.com>
References: <20210522001154.2680157-1-ira.weiny@intel.com>
        <20210522001154.2680157-2-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.147]
X-ClientProxiedBy: lhreml705-chm.china.huawei.com (10.201.108.54) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 21 May 2021 17:11:50 -0700
<ira.weiny@intel.com> wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> Each register block located in the DVSEC needs to be decoded from 2
> words, 'register offset high' and 'register offset low'.
> 
> Create a function, cxl_decode_register_block() to perform this decode
> and return the bar, offset, and register type of the register block.
> 
> Then use the values decoded in cxl_mem_map_regblock() instead of passing
> the raw registers.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Makes sense to factor this out.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes for V2:
> 	Push this to the start of the series
> ---
>  drivers/cxl/pci.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8bdae74d7d78..b2f978954daa 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -922,17 +922,13 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev)
>  	return cxlm;
>  }
>  
> -static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm, u32 reg_lo, u32 reg_hi)
> +static void __iomem *cxl_mem_map_regblock(struct cxl_mem *cxlm,
> +					  u8 bar, u64 offset)
>  {
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
> -	u64 offset;
> -	u8 bar;
>  	int rc;
>  
> -	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> -	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> -
>  	/* Basic sanity check that BAR is big enough */
>  	if (pci_resource_len(pdev, bar) < offset) {
>  		dev_err(dev, "BAR%d: %pr: too small (offset: %#llx)\n", bar,
> @@ -974,6 +970,14 @@ static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)
>  	return 0;
>  }
>  
> +static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
> +				      u8 *bar, u64 *offset, u8 *reg_type)
> +{
> +	*offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> +	*bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> +	*reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +}
> +
>  /**
>   * cxl_mem_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> @@ -1009,15 +1013,21 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  	for (i = 0; i < regblocks; i++, regloc += 8) {
>  		u32 reg_lo, reg_hi;
>  		u8 reg_type;
> +		u64 offset;
> +		u8 bar;
>  
>  		/* "register low and high" contain other bits */
>  		pci_read_config_dword(pdev, regloc, &reg_lo);
>  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
>  
> -		reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
> +					  &reg_type);
> +
> +		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
> +			bar, offset, reg_type);
>  
>  		if (reg_type == CXL_REGLOC_RBI_MEMDEV) {
> -			base = cxl_mem_map_regblock(cxlm, reg_lo, reg_hi);
> +			base = cxl_mem_map_regblock(cxlm, bar, offset);
>  			if (IS_ERR(base))
>  				return PTR_ERR(base);
>  			break;

