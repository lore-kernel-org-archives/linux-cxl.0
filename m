Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA6DC48BD1
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:03:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF0A61364
	for <linux-cxl@archiver.kernel.org>; Fri, 11 Jun 2021 13:03:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbhFKNFb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 11 Jun 2021 09:05:31 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56]:3220 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbhFKNFa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 11 Jun 2021 09:05:30 -0400
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4G1gpN6SSNz6K5my;
        Fri, 11 Jun 2021 20:56:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 11 Jun 2021 15:03:31 +0200
Received: from localhost (10.52.120.251) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2; Fri, 11 Jun
 2021 14:03:30 +0100
Date:   Fri, 11 Jun 2021 14:03:27 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl/component_regs: Fix offset
Message-ID: <20210611140327.000042f2@Huawei.com>
In-Reply-To: <20210611051113.224328-1-ben.widawsky@intel.com>
References: <20210611051113.224328-1-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.120.251]
X-ClientProxiedBy: lhreml742-chm.china.huawei.com (10.201.108.192) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, 10 Jun 2021 22:11:13 -0700
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The CXL.cache and CXL.mem registers begin after the CXL.io registers
> which occupy the first 0x1000 bytes. The current code wasn't setting
> this up properly for future users of the component registers. It was
> correct for the probing code however.
> 
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

I guess we could have assumed that this offset was always form CXL_CM_OFFSET
but as that's a bit odd, this change makes sense.

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core.c b/drivers/cxl/core.c
> index 92db02fe7aa8..c7f956fa3ada 100644
> --- a/drivers/cxl/core.c
> +++ b/drivers/cxl/core.c
> @@ -671,7 +671,7 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
>  			length = 0x20 * decoder_cnt + 0x10;
>  
>  			map->hdm_decoder.valid = true;
> -			map->hdm_decoder.offset = offset;
> +			map->hdm_decoder.offset = CXL_CM_OFFSET + offset;
>  			map->hdm_decoder.size = length;
>  			break;
>  		default:

