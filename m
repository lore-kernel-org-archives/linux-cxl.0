Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D56FC4320E
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:57:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77B5D61103
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:57:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235432AbhHBP5i (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:57:38 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3558 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235426AbhHBP5g (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 11:57:36 -0400
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4GdjLh38Jmz6F7xw;
        Mon,  2 Aug 2021 23:57:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:57:25 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:57:24 +0100
Date:   Mon, 2 Aug 2021 16:56:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 3/3] cxl/pci: Retain map information in cxl_mem_probe
Message-ID: <20210802165656.000036f0@Huawei.com>
In-Reply-To: <20210716231548.174778-4-ben.widawsky@intel.com>
References: <20210716231548.174778-1-ben.widawsky@intel.com>
        <20210716231548.174778-4-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.9.82]
X-ClientProxiedBy: lhreml743-chm.china.huawei.com (10.201.108.193) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 16 Jul 2021 16:15:48 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> In order for a memdev to participate in cxl_core's port APIs, the
> physical address of the memdev's component registers is needed. This is
> accomplished by allocating the array of maps in probe so they can be
> used after the memdev is created.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Hmm. I don't entirely like the the passing of an array of 
unknown size into cxl_mem_setup_regs.  It is perhaps paranoid
but I'd separately pass in the size and error out should we
overflow with a suitable message to highlight the bug.

So far this code is also not justified by anything using the
array now it's been moved up a layer. Looks that doesn't happen
until patch 22 of your large WIP series. I think this patch needs
to be in the same series as that one as it doesn't stand on
it's own.

Jonathan


> ---
>  drivers/cxl/pci.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8be18daa1420..f924a8c5a831 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1066,21 +1066,22 @@ static void cxl_decode_register_block(u32 reg_lo, u32 reg_hi,
>  /**
>   * cxl_mem_setup_regs() - Setup necessary MMIO.
>   * @cxlm: The CXL memory device to communicate with.
> + * @maps: Array of maps populated by this function.
>   *
> - * Return: 0 if all necessary registers mapped.
> + * Return: 0 if all necessary registers mapped. The results are stored in @maps.
>   *
>   * A memory device is required by spec to implement a certain set of MMIO
>   * regions. The purpose of this function is to enumerate and map those
>   * registers.
>   */
> -static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
> +static int cxl_mem_setup_regs(struct cxl_mem *cxlm, struct cxl_register_map maps[])
>  {
>  	struct pci_dev *pdev = cxlm->pdev;
>  	struct device *dev = &pdev->dev;
>  	u32 regloc_size, regblocks;
>  	void __iomem *base;
>  	int regloc, i, n_maps;
> -	struct cxl_register_map *map, maps[CXL_REGLOC_RBI_TYPES];
> +	struct cxl_register_map *map;
>  	int ret = 0;
>  
>  	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC_DVSEC_ID);
> @@ -1364,6 +1365,7 @@ static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
>  
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> +	struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
>  	struct cxl_memdev *cxlmd;
>  	struct cxl_mem *cxlm;
>  	int rc;
> @@ -1376,7 +1378,7 @@ static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (IS_ERR(cxlm))
>  		return PTR_ERR(cxlm);
>  
> -	rc = cxl_mem_setup_regs(cxlm);
> +	rc = cxl_mem_setup_regs(cxlm, maps);
>  	if (rc)
>  		return rc;
>  

