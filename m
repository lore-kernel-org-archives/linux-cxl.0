Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70FE6C32796
	for <linux-cxl@archiver.kernel.org>; Wed, 24 Aug 2022 09:31:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiHXJby (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 24 Aug 2022 05:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235339AbiHXJb3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 24 Aug 2022 05:31:29 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FBB910BF
        for <linux-cxl@vger.kernel.org>; Wed, 24 Aug 2022 02:31:01 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4MCLRt0kFRz683mQ;
        Wed, 24 Aug 2022 17:30:34 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 24 Aug 2022 11:30:57 +0200
Received: from localhost (10.202.226.42) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 24 Aug
 2022 10:30:57 +0100
Date:   Wed, 24 Aug 2022 10:30:55 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Vishal Verma <vishal.l.verma@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH v2 1/3] cxl/region: fix a dereferecnce after NULL
 check
Message-ID: <20220824103055.0000056f@huawei.com>
In-Reply-To: <20220823074527.404435-2-vishal.l.verma@intel.com>
References: <20220823074527.404435-1-vishal.l.verma@intel.com>
        <20220823074527.404435-2-vishal.l.verma@intel.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 23 Aug 2022 01:45:25 -0600
Vishal Verma <vishal.l.verma@intel.com> wrote:

> A NULL check in region_action() implies that 'decoder' might be NULL, but
> later we dereference it during cxl_decoder_foreach(). The NULL check is
> valid because it was the filter result being checked, however, while
> doing this, the original 'decoder' variable was being clobbered.
> 
> Check the filter results independently of the original decoder variable.
> 
> Cc: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>

Typo in patch title.

> ---
>  cxl/region.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/cxl/region.c b/cxl/region.c
> index a30313c..334fcc2 100644
> --- a/cxl/region.c
> +++ b/cxl/region.c
> @@ -686,9 +686,8 @@ static int region_action(int argc, const char **argv, struct cxl_ctx *ctx,
>  			continue;
>  
>  		cxl_decoder_foreach (port, decoder) {
> -			decoder = util_cxl_decoder_filter(decoder,
> -							  param.root_decoder);
> -			if (!decoder)
> +			if (!util_cxl_decoder_filter(decoder,
> +						     param.root_decoder))
>  				continue;
>  			rc = decoder_region_action(p, decoder, action, count);
>  			if (rc)

