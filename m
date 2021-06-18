Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56411C48BDF
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A73E6124C
	for <linux-cxl@archiver.kernel.org>; Fri, 18 Jun 2021 14:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233642AbhFRO0v (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 18 Jun 2021 10:26:51 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3286 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbhFRO0u (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 18 Jun 2021 10:26:50 -0400
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G617M0NRWz6GBPl;
        Fri, 18 Jun 2021 22:11:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 18 Jun 2021 16:24:40 +0200
Received: from localhost (10.52.125.28) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 18 Jun
 2021 15:24:39 +0100
Date:   Fri, 18 Jun 2021 15:24:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [RFC PATCH 5/5] cxl/mem: Check that the device is CXL.mem
 capable
Message-ID: <20210618152430.00001c60@Huawei.com>
In-Reply-To: <20210618005200.997804-6-ben.widawsky@intel.com>
References: <20210618005200.997804-1-ben.widawsky@intel.com>
        <20210618005200.997804-6-ben.widawsky@intel.com>
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

On Thu, 17 Jun 2021 17:52:00 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/mem.c | 18 ++++++++++++++++++
>  drivers/cxl/pci.h |  5 ++++-
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> index cbf18df24109..7f26937c7151 100644
> --- a/drivers/cxl/mem.c
> +++ b/drivers/cxl/mem.c
> @@ -4,6 +4,7 @@
>  #include <linux/module.h>
>  #include <linux/pci.h>
>  #include "mem.h"
> +#include "pci.h"
>  
>  /**
>   * DOC: cxl mem
> @@ -41,14 +42,31 @@ static int cxl_memdev_probe(struct device *dev)
>  {
>  	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
>  	struct cxl_mem *cxlm = cxlmd->cxlm;
> +	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *pdev_parent = cxlm->pdev->dev.parent;
>  	struct device *port_dev;
> +	int pcie_dvsec;
> +	u16 dvsec_ctrl;
>  
>  	port_dev =
>  		bus_find_device(&cxl_bus_type, NULL, pdev_parent, port_match);
>  	if (!port_dev)
>  		return -ENODEV;
>  
> +	pcie_dvsec = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID);
> +	if (!pcie_dvsec) {
> +		dev_err(dev, "Unable to determine CXL protocol support");
> +		return -ENODEV;
> +	}
> +
> +	pci_read_config_word(pdev,
> +			     pcie_dvsec + PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET,
> +			     &dvsec_ctrl);
> +	if (!(dvsec_ctrl & CXL_PCIE_MEM_ENABLE)) {

Checking control rather than capability?  If you want to know if it supports
it read the bit in register at offset 0x0a

If there is a good reason to see if it's turned on, then document that
with a comment here somewhere and change the error message appropriately.

> +		dev_err(dev, "CXL.cache protocol not supported on device");
> +		return -ENODEV;
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 0d6f50f725bc..ee26bc8c2ec8 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -11,7 +11,10 @@
>   */
>  #define PCI_DVSEC_HEADER1_LENGTH_MASK	GENMASK(31, 20)
>  #define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> -#define PCI_DVSEC_ID_CXL		0x0
> +
> +#define PCI_DVSEC_ID_PCIE_DVSEC_CXL_DVSEC_ID	0x0

????  That's a non obvious bit of naming!

> +#define PCI_DVSEC_ID_CXL_PCIE_CTRL_OFFSET	0xC
> +#define   CXL_PCIE_MEM_ENABLE			BIT(2)
>  
>  #define PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID	0x8
>  #define PCI_DVSEC_ID_CXL_REGLOC_BLOCK1_OFFSET	0xC

