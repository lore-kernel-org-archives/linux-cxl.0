Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946A7C4338F
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Aug 2021 07:58:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DDDA60F8F
	for <linux-cxl@archiver.kernel.org>; Tue,  3 Aug 2021 07:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234331AbhHCH7I (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 3 Aug 2021 03:59:08 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3566 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234386AbhHCH7G (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 3 Aug 2021 03:59:06 -0400
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gf6h41ycBz6DK0C;
        Tue,  3 Aug 2021 15:58:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Tue, 3 Aug 2021 09:58:53 +0200
Received: from localhost (10.210.169.87) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Tue, 3 Aug 2021
 08:58:52 +0100
Date:   Tue, 3 Aug 2021 08:58:24 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>, <linux-cxl@vger.kernel.org>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 3/3] cxl/pci: Retain map information in cxl_mem_probe
Message-ID: <20210803085824.000015a9@Huawei.com>
In-Reply-To: <CAPcyv4iWmZtcGPDNsFebL=kZNQ+GvSEAqfR77gM9Z5bojTEqDQ@mail.gmail.com>
References: <20210716231548.174778-1-ben.widawsky@intel.com>
        <20210716231548.174778-4-ben.widawsky@intel.com>
        <20210802165656.000036f0@Huawei.com>
        <CAPcyv4jQ=jSOzcyt=0JCn_sSBQEo+23taG4O-QPU9xwTjUKw5w@mail.gmail.com>
        <CAPcyv4iWmZtcGPDNsFebL=kZNQ+GvSEAqfR77gM9Z5bojTEqDQ@mail.gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.169.87]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 2 Aug 2021 10:09:45 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> On Mon, Aug 2, 2021 at 9:10 AM Dan Williams <dan.j.williams@intel.com> wrote:
> >
> > On Mon, Aug 2, 2021 at 8:57 AM Jonathan Cameron
> > <Jonathan.Cameron@huawei.com> wrote:  
> > >
> > > On Fri, 16 Jul 2021 16:15:48 -0700
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >  
> > > > In order for a memdev to participate in cxl_core's port APIs, the
> > > > physical address of the memdev's component registers is needed. This is
> > > > accomplished by allocating the array of maps in probe so they can be
> > > > used after the memdev is created.
> > > >
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > >
> > > Hmm. I don't entirely like the the passing of an array of
> > > unknown size into cxl_mem_setup_regs.  It is perhaps paranoid
> > > but I'd separately pass in the size and error out should we
> > > overflow with a suitable message to highlight the bug.  
> >
> > Agree.  
> 
> Here's the incremental diff I came up with:
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c370ab2e48bc..ff72286142e7 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1086,7 +1086,8 @@ static void cxl_decode_register_block(u32
> reg_lo, u32 reg_hi,
>   * regions. The purpose of this function is to enumerate and map those
>   * registers.
>   */
> -static int cxl_mem_setup_regs(struct cxl_mem *cxlm, struct
> cxl_register_map maps[])
> +static int cxl_mem_setup_regs(struct cxl_mem *cxlm,
> +                             struct cxl_register_maps *maps)
>  {
>         struct pci_dev *pdev = cxlm->pdev;
>         struct device *dev = &pdev->dev;
> @@ -1135,7 +1136,9 @@ static int cxl_mem_setup_regs(struct cxl_mem
> *cxlm, struct cxl_register_map maps
>                 if (!base)
>                         return -ENOMEM;
> 
> -               map = &maps[n_maps];
> +               if (n_maps > ARRAY_SIZE(maps->map))
> +                       return -ENXIO;
> +               map = &maps->map[n_maps++];
>                 map->barno = bar;
>                 map->block_offset = offset;
>                 map->reg_type = reg_type;
> @@ -1147,14 +1150,12 @@ static int cxl_mem_setup_regs(struct cxl_mem
> *cxlm, struct cxl_register_map maps
> 
>                 if (ret)
>                         return ret;
> -
> -               n_maps++;

I found original form of this block with the separate n_maps++ a little
bit more readable.  But otherwise this approach looks good to me.

Jonathan


>         }
> 
>         pci_release_mem_regions(pdev);
> 
>         for (i = 0; i < n_maps; i++) {
> -               ret = cxl_map_regs(cxlm, &maps[i]);
> +               ret = cxl_map_regs(cxlm, &maps->map[i]);
>                 if (ret)
>                         break;
>         }
> @@ -1370,7 +1371,7 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
> 
>  static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  {
> -       struct cxl_register_map maps[CXL_REGLOC_RBI_TYPES];
> +       struct cxl_register_maps maps;
>         struct cxl_memdev *cxlmd;
>         struct cxl_mem *cxlm;
>         int rc;
> @@ -1383,7 +1384,7 @@ static int cxl_mem_probe(struct pci_dev *pdev,
> const struct pci_device_id *id)
>         if (IS_ERR(cxlm))
>                 return PTR_ERR(cxlm);
> 
> -       rc = cxl_mem_setup_regs(cxlm, maps);
> +       rc = cxl_mem_setup_regs(cxlm, &maps);
>         if (rc)
>                 return rc;
> 
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> index 8c1a58813816..5b7828003b76 100644
> --- a/drivers/cxl/pci.h
> +++ b/drivers/cxl/pci.h
> @@ -2,6 +2,7 @@
>  /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>  #ifndef __CXL_PCI_H__
>  #define __CXL_PCI_H__
> +#include "cxlmem.h"
> 
>  #define CXL_MEMORY_PROGIF      0x10
> 
> @@ -29,4 +30,8 @@
> 
>  #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
> 
> +struct cxl_register_maps {
> +       struct cxl_register_map map[CXL_REGLOC_RBI_TYPES];
> +};
> +
>  #endif /* __CXL_PCI_H__ */

