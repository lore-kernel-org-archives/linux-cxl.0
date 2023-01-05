Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67D64C46467
	for <linux-cxl@archiver.kernel.org>; Tue, 10 Jan 2023 16:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232009AbjAJQ43 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 10 Jan 2023 11:56:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238983AbjAJQ4Q (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 10 Jan 2023 11:56:16 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1F7F319
        for <linux-cxl@vger.kernel.org>; Tue, 10 Jan 2023 08:56:14 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nrxhy5kFfz6J6gk;
        Wed, 11 Jan 2023 00:53:38 +0800 (CST)
Received: from localhost (10.122.247.231) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Tue, 10 Jan
 2023 16:56:11 +0000
Date:   Thu, 5 Jan 2023 17:32:21 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/3] cxl/mem: Remove unused CXL_CMD_FLAG_NONE define
Message-ID: <20230105173221.00007555@Huawei.com>
In-Reply-To: <20221222-cxl-misc-v1-2-9343bab16e72@intel.com>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
        <20221222-cxl-misc-v1-2-9343bab16e72@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 27 Dec 2022 06:52:10 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> CXL_CMD_FLAG_NONE is not used, remove it.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
That is a bit odd. Good to get rid of it.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/cxlmem.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index ab138004f644..2d85776236dd 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -393,7 +393,6 @@ struct cxl_mem_command {
>  	struct cxl_command_info info;
>  	enum cxl_opcode opcode;
>  	u32 flags;
> -#define CXL_CMD_FLAG_NONE 0
>  #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
>  };
>  
> 

