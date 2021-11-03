Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE8ACC433F5
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 15:54:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A0086109F
	for <linux-cxl@archiver.kernel.org>; Wed,  3 Nov 2021 15:54:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbhKCP4o (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 Nov 2021 11:56:44 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:4057 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbhKCP4m (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 Nov 2021 11:56:42 -0400
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hkrms6F15z67mL5;
        Wed,  3 Nov 2021 23:49:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Wed, 3 Nov 2021 16:54:03 +0100
Received: from localhost (10.52.126.31) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.15; Wed, 3 Nov
 2021 15:54:02 +0000
Date:   Wed, 3 Nov 2021 15:53:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Chet Douglas <chet.r.douglas@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH v2 13/28] cxl: Flesh out register names
Message-ID: <20211103155359.0000343d@Huawei.com>
In-Reply-To: <20211022183709.1199701-14-ben.widawsky@intel.com>
References: <20211022183709.1199701-1-ben.widawsky@intel.com>
        <20211022183709.1199701-14-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.126.31]
X-ClientProxiedBy: lhreml734-chm.china.huawei.com (10.201.108.85) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 22 Oct 2021 11:36:54 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Get a better naming scheme in place for upcoming additions. To solidify
> the schema, add all the DVSEC identifiers to start with.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> ---
> See:
> https://lore.kernel.org/linux-pci/20210913190131.xiiszmno46qie7v5@intel.com/
> ---
>  drivers/cxl/core/regs.c | 14 ++++++++------
>  drivers/cxl/pci.h       | 38 ++++++++++++++++++++++++++++++--------
>  2 files changed, 38 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index c8ab8880b81b..b837196fbf39 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -253,9 +253,11 @@ static void cxl_decode_regblock(u32 reg_lo, u32 reg_hi,
>  				struct cxl_register_map *map)
>  {
>  	map->block_offset =
> -		((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
> -	map->barno = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
> -	map->reg_type = FIELD_GET(CXL_REGLOC_RBI_MASK, reg_lo);
> +		((u64)reg_hi << 32) |
> +		(reg_lo & DVSEC_REGISTER_LOCATOR_BLOCK_OFFSET_LOW_MASK);
> +	map->barno = FIELD_GET(DVSEC_REGISTER_LOCATOR_BIR_MASK, reg_lo);
> +	map->reg_type =
> +		FIELD_GET(DVSEC_REGISTER_LOCATOR_BLOCK_IDENTIFIER_MASK, reg_lo);
>  }
>  
>  /**
> @@ -276,15 +278,15 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  	int regloc, i;
>  
>  	regloc = pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL,
> -					   PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> +					   CXL_DVSEC_REGISTER_LOCATOR);
>  	if (!regloc)
>  		return -ENXIO;
>  
>  	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
>  	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
>  
> -	regloc += PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET;
> -	regblocks = (regloc_size - PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET) / 8;
> +	regloc += DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET;
> +	regblocks = (regloc_size - DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET) / 8;
>  
>  	for (i = 0; i < regblocks; i++, regloc += 8) {
>  		u32 reg_lo, reg_hi;
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 12fdcb1b14e5..fe2898b17736 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -7,17 +7,36 @@
>  
>  /*
>   * See section 8.1 Configuration Space Registers in the CXL 2.0
> - * Specification
> + * Specification. Names are taken straight from the specification with "CXL" and
> + * "DVSEC" redundancies removed.
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> -#define PCI_DVSEC_ID_CXL		0x0
>  
> -#define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
> -#define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC
> +/* 8.1.3: PCIe DVSEC for CXL Device */
> +#define CXL_DVSEC_PCIE_DEVICE					0
>  
> -/* BAR Indicator Register (BIR) */
> -#define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
> +/* 8.1.4: Non-CXL Function Map DVSEC */
> +#define CXL_DVSEC_FUNCTION_MAP					2
> +
> +/* 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
> +#define CXL_DVSEC_PORT_EXTENSIONS				3
> +
> +/* 8.1.6: GPF DVSEC for CXL Port */
> +#define CXL_DVSEC_PORT_GPF					4
> +
> +/* 8.1.7: GPF DVSEC for CXL Device */
> +#define CXL_DVSEC_DEVICE_GPF					5
> +
> +/* 8.1.8: PCIe DVSEC for Flex Bus Port */
> +#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
> +
> +/* 8.1.9: Register Locator DVSEC */
> +#define CXL_DVSEC_REGISTER_LOCATOR				8
> +#define   DVSEC_REGISTER_LOCATOR_BLOCK1_OFFSET			0xC

Hmm. I'm not particularly keen on not having CXL in the naming for the offset
and fields.  They get used in places where, to the casual reader, they may look
like generic PCI_DVSEC_ defintiions....  the do get very long though, but I'm not
sure that's the right place to abbreviate. 

Agreed with your comment in the thread that it's really hard to
get a good consistent model for what are near enough free form names
in a spec (or seem like it when read long after they were defined).

> +#define     DVSEC_REGISTER_LOCATOR_BIR_MASK			GENMASK(2, 0)
> +#define	    DVSEC_REGISTER_LOCATOR_BLOCK_IDENTIFIER_MASK	GENMASK(15, 8)
> +#define     DVSEC_REGISTER_LOCATOR_BLOCK_OFFSET_LOW_MASK	GENMASK(31, 16) 
>  
>  /* Register Block Identifier (RBI) */
>  enum cxl_regloc_type {
> @@ -28,8 +47,11 @@ enum cxl_regloc_type {
>  	CXL_REGLOC_RBI_TYPES
>  };
>  
> -#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
> -#define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> +/* 8.1.10: MLD DVSEC */
> +#define CXL_DVSEC_MLD						9
> +
> +/* 14.16.1 CXL Device Test Capability Advertisement */
> +#define CXL_DVSEC_PCIE_TEST_CAPABILITY				10
>  
>  #define cxl_reg_block(pdev, map)                                               \
>  	((resource_size_t)(pci_resource_start(pdev, (map)->barno) +            \

