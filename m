Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11D70C433F5
	for <linux-cxl@archiver.kernel.org>; Wed, 15 Dec 2021 15:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbhLOPEK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 15 Dec 2021 10:04:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4294 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbhLOPEJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 15 Dec 2021 10:04:09 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JDdlK5jFsz67wqt;
        Wed, 15 Dec 2021 23:02:37 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.20; Wed, 15 Dec 2021 16:04:07 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Wed, 15 Dec
 2021 15:04:06 +0000
Date:   Wed, 15 Dec 2021 15:04:04 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 7/9] cxl/acpi: Map component registers for Root Ports
Message-ID: <20211215150404.000035f5@huawei.com>
In-Reply-To: <20211129214721.1668325-8-ben.widawsky@intel.com>
References: <20211129214721.1668325-1-ben.widawsky@intel.com>
        <20211129214721.1668325-8-ben.widawsky@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 29 Nov 2021 13:47:19 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> This implements the TODO in cxl_acpi for mapping component registers.
> cxl_acpi becomes the second consumer of CXL register block enumeration
> (cxl_pci being the first). Moving the functionality to cxl_core allows
> both of these drivers to use the functionality. Equally importantly it
> allows cxl_core to use the functionality in the future.
> 
> CXL 2.0 root ports are similar to CXL 2.0 Downstream Ports with the main
> distinction being they're a part of the CXL 2.0 host bridge. While
> mapping their component registers is not immediately useful for the CXL
> drivers, the movement of register block enumeration into core is a vital
> step towards HDM decoder programming.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
> Changes since v1:
> - Add comment on why component register enumeration for root ports is
>   optional (Jonathan)
> - Fix kdoc for cxl_find_regblock (Jonathan)
> - Convert cxl_reg_block macro to static inline (Dan)
> - Rename cxl_reg_block cxl_reg_block to cxl_regmap_to_base (Dan)
> - Make cxl_regmap_to_base return CXL_RESOURCE_NONE on failure (Dan)
> ---
>  drivers/cxl/acpi.c      | 13 ++++++++--
>  drivers/cxl/core/regs.c | 54 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |  4 +++
>  drivers/cxl/pci.c       | 52 ---------------------------------------
>  drivers/cxl/pci.h       |  9 +++++++
>  5 files changed, 78 insertions(+), 54 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3163167ecc3a..c656a49a11a9 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -7,6 +7,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include "cxl.h"
> +#include "pci.h"
>  
>  /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
>  #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
> @@ -134,11 +135,13 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  
>  __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>  {
> +	resource_size_t creg = CXL_RESOURCE_NONE;
>  	struct cxl_walk_context *ctx = data;
>  	struct pci_bus *root_bus = ctx->root;
>  	struct cxl_port *port = ctx->port;
>  	int type = pci_pcie_type(pdev);
>  	struct device *dev = ctx->dev;
> +	struct cxl_register_map map;
>  	u32 lnkcap, port_num;
>  	int rc;
>  
> @@ -152,9 +155,15 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>  				  &lnkcap) != PCIBIOS_SUCCESSFUL)
>  		return 0;
>  
> -	/* TODO walk DVSEC to find component register base */
> +	/* The driver doesn't rely on component registers for Root Ports yet. */
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (!rc)
Check inverted.  cxl_find_regblock() returns 0 if it succeeded.
(or I've managed to miss a precursor patch).

> +		dev_info(&pdev->dev, "No component register block found\n");
