Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51CBDC433EF
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:45:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 387B8610F7
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Sep 2021 14:45:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349193AbhICOqf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Sep 2021 10:46:35 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3736 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbhICOqd (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 3 Sep 2021 10:46:33 -0400
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4H1LC25MPcz67bGf;
        Fri,  3 Sep 2021 22:43:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 3 Sep 2021 16:45:30 +0200
Received: from localhost (10.52.121.127) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.8; Fri, 3 Sep 2021
 15:45:30 +0100
Date:   Fri, 3 Sep 2021 15:45:31 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 05/13] cxl/pci: Disambiguate cxl_pci further from
 cxl_mem
Message-ID: <20210903154531.00000d3f@Huawei.com>
In-Reply-To: <20210902195017.2516472-6-ben.widawsky@intel.com>
References: <20210902195017.2516472-1-ben.widawsky@intel.com>
        <20210902195017.2516472-6-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.121.127]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 2 Sep 2021 12:50:09 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Commit 21e9f76733a8 ("cxl: Rename mem to pci") introduced the cxl_pci
> driver which had formerly been named cxl_mem. At the time, the goal was
> to be as light touch as possible because there were other patches in
> flight. Since things have settled now, and a new cxl_mem driver will be
> introduced shortly, spend the LOC now to clean up the existing names.
> 
> While here, fix the kernel docs to explain the situation better after
> the core rework that has already landed.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

One thing below - otherwise fine. With that fixed.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 70 +++++++++++++++++++++++------------------------
>  1 file changed, 35 insertions(+), 35 deletions(-)
> 

...

> @@ -569,17 +569,17 @@ static const struct pci_device_id cxl_mem_pci_tbl[] = {
>  	{ PCI_DEVICE_CLASS((PCI_CLASS_MEMORY_CXL << 8 | CXL_MEMORY_PROGIF), ~0)},
>  	{ /* terminate list */ },
>  };
> -MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> +MODULE_DEVICE_TABLE(pci, cxl_pci_tbl);

Doesn't look like you have renamed the table this is using...


>  
> -static struct pci_driver cxl_mem_driver = {
> +static struct pci_driver cxl_pci_driver = {
>  	.name			= KBUILD_MODNAME,
>  	.id_table		= cxl_mem_pci_tbl,

As above, table rename?

> -	.probe			= cxl_mem_probe,
> +	.probe			= cxl_pci_probe,
>  	.driver	= {
>  		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
>  	},
>  };
>  
>  MODULE_LICENSE("GPL v2");
> -module_pci_driver(cxl_mem_driver);
> +module_pci_driver(cxl_pci_driver);
>  MODULE_IMPORT_NS(CXL);

