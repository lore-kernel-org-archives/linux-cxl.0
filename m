Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F7F2C4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:49:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C98610FE
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 15:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhHBPuD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 11:50:03 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3556 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230131AbhHBPuC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 2 Aug 2021 11:50:02 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Gdj9y6ZTlz6F7yk;
        Mon,  2 Aug 2021 23:49:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 2 Aug 2021 17:49:51 +0200
Received: from localhost (10.47.9.82) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Mon, 2 Aug 2021
 16:49:50 +0100
Date:   Mon, 2 Aug 2021 16:49:22 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 1/3] cxl/pci: Ignore unknown register block types
Message-ID: <20210802164922.0000223f@Huawei.com>
In-Reply-To: <20210716231548.174778-2-ben.widawsky@intel.com>
References: <20210716231548.174778-1-ben.widawsky@intel.com>
        <20210716231548.174778-2-ben.widawsky@intel.com>
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

On Fri, 16 Jul 2021 16:15:46 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> In an effort to explicit avoid supporting vendor specific register
> blocks (which can happily be mapped from userspace), entirely skip
> probing unknown types. The secondary benefit of this will be revealed
> in the future with code simplification.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Seems sensible even on it's own as we don't do anything with unknown
blocks anyway.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/pci.c | 20 ++++++++++++--------
>  1 file changed, 12 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index d7da18ebba81..dd0ac89fbdf4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -1106,14 +1106,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		u64 offset;
>  		u8 bar;
>  
> -		map = kzalloc(sizeof(*map), GFP_KERNEL);
> -		if (!map) {
> -			ret = -ENOMEM;
> -			goto free_maps;
> -		}
> -
> -		list_add(&map->list, &register_maps);
> -
>  		pci_read_config_dword(pdev, regloc, &reg_lo);
>  		pci_read_config_dword(pdev, regloc + 4, &reg_hi);
>  
> @@ -1123,6 +1115,18 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
>  		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
>  			bar, offset, reg_type);
>  
> +		/* Ignore unknown register block types */
> +		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
> +			continue;
> +
> +		map = kzalloc(sizeof(*map), GFP_KERNEL);
> +		if (!map) {
> +			ret = -ENOMEM;
> +			goto free_maps;
> +		}
> +
> +		list_add(&map->list, &register_maps);
> +
>  		base = cxl_mem_map_regblock(cxlm, bar, offset);
>  		if (!base) {
>  			ret = -ENOMEM;

