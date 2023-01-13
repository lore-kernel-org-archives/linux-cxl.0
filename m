Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F22C54EBD
	for <linux-cxl@archiver.kernel.org>; Fri, 13 Jan 2023 13:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240696AbjAMNoi (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 13 Jan 2023 08:44:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbjAMNm6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 13 Jan 2023 08:42:58 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC9DB24
        for <linux-cxl@vger.kernel.org>; Fri, 13 Jan 2023 05:36:37 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Ntj7615XTz686d6;
        Fri, 13 Jan 2023 21:33:54 +0800 (CST)
Received: from localhost (10.81.201.219) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 13 Jan
 2023 13:36:35 +0000
Date:   Fri, 13 Jan 2023 13:36:34 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>
Subject: Re: [PATCH v2 1/8] cxl: break out range register decoding from
 cxl_hdm_decode_init()
Message-ID: <20230113133634.000057ee@Huawei.com>
In-Reply-To: <167330058797.975161.6614835520451455277.stgit@djiang5-mobl3.local>
References: <167330048147.975161.8832707018372221375.stgit@djiang5-mobl3.local>
        <167330058797.975161.6614835520451455277.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.201.219]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, 09 Jan 2023 14:43:09 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> There are 2 scenarios that requires additional handling. 1. A device that
> has active ranges in DVSEC range registers (RR) but no HDM decoder register
> block. 2. A device that has both RR active and HDM, but the HDM decoders
> are not programmed. The goal is to create emulated decoder software structs
> based on the RR.
> 
> Move the CXL DVSEC range register decoding code block from
> cxl_hdm_decode_init() to its own function. Refactor code in preparation for
> the HDM decoder emulation.  There is no functionality change to the code.
> Name the new function to cxl_dvsec_rr_decode().
> 
> The only change is to set range->start and range->end to CXL_RESOURCE_NONE
> and skipping the reading of base registers if the range size is 0, which
> equates to range not active.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> 
> ---
> 
> v2:
> - Refactor to return when size is 0. (Jonathan)
I think you continue rather than return when size is 0 unless I'm looking in the
wrong place. 

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/pci.c |   63 ++++++++++++++++++++++++++++++------------------
>  1 file changed, 40 insertions(+), 23 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 57764e9cd19d..a8ecc6ddb3d7 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -141,11 +141,10 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_await_media_ready, CXL);
>  
