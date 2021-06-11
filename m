Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50ED1C48BE5
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 10:37:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25428613E7
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 10:37:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230291AbhFKKjJ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 06:39:09 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3207 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbhFKKjJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 06:39:09 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1cQS6ldZz6J8j8;
        Fri, 11 Jun 2021 18:24:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 12:37:10 +0200
Received: from localhost (10.52.120.251) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 11:37:09 +0100
Date:   Fri, 11 Jun 2021 11:37:05 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/hdm: Fix decoder count calculation
Message-ID: <20210611113705.000024bb@Huawei.com>
In-Reply-To: <20210610215332.991905-1-ben.widawsky@intel.com>
References: <20210610215332.991905-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.120.251]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Jun 2021 14:53:32 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The decoder count in the HDM decoder capability structure is an encoded
> field. As defined in the spec:
> 
> Decoder Count: Reports the number of memory address decoders implemented
> by the component.
> 0 – 1 Decoder
> 1 – 2 Decoders
> 2 – 4 Decoders
> 3 – 6 Decoders
> 4 – 8 Decoders
> 5 – 10 DecodersAll other values are reserved
> 
> Nothing is actually fixed by this as nothing actually used this mapping
> yet.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
lgtm.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core.c | 3 ++-
>  drivers/cxl/cxl.h  | 1 +
>  2 files changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index cda09a9cd98e..92db02fe7aa8 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -666,7 +666,8 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  
>  			hdr = readl(register_block);
>  
> -			decoder_cnt = FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, hdr);
> +			decoder_cnt =
> +				cxl_hdm_decoder_count(FIELD_GET(CXL_HDM_DECODER_COUNT_MASK, hdr));
>  			length = 0x20 * decoder_cnt + 0x10;
>  
>  			map->hdm_decoder.valid = true;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1ffc5e07e24d..f0dff7d96286 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -35,6 +35,7 @@
>  /* HDM decoders CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure */
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
> +#define	    cxl_hdm_decoder_count(bits) ((bits) == 0 ? 1 : (bits) * 2)
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
>  #define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
>  #define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14

