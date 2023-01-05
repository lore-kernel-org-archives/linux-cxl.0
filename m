Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96DCCC54EBD
	for <linux-cxl@archiver.kernel.org>; Thu,  5 Jan 2023 17:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234866AbjAERbz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 5 Jan 2023 12:31:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbjAERbu (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 5 Jan 2023 12:31:50 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FCC28F
        for <linux-cxl@vger.kernel.org>; Thu,  5 Jan 2023 09:31:48 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Nntgl4Vgzz687x5;
        Fri,  6 Jan 2023 01:26:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 5 Jan
 2023 17:31:45 +0000
Date:   Thu, 5 Jan 2023 17:31:44 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 3/3] cxl/uapi: Add warning on CXL command enum
Message-ID: <20230105173144.00004cf1@Huawei.com>
In-Reply-To: <20221222-cxl-misc-v1-3-9343bab16e72@intel.com>
References: <20221222-cxl-misc-v1-0-9343bab16e72@intel.com>
        <20221222-cxl-misc-v1-3-9343bab16e72@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 27 Dec 2022 06:52:11 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> The CXL command enum is exported to user space and must maintain
> backwards compatibility.
> 
> Add comment that new defines must be added to the end of the list.
> 
> Suggested-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  include/uapi/linux/cxl_mem.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 555f9140e2bc..b3fd46af70f8 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -19,6 +19,10 @@
>  #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
>  #define CXL_MEM_SEND_COMMAND _IOWR(0xCE, 2, struct cxl_send_command)
>  
> +/*
> + * NOTE: New defines must be added to the end of the list to preserve
> + * compatibility because this enum is exported to user space.
> + */
>  #define CXL_CMDS                                                          \
>  	___C(INVALID, "Invalid Command"),                                 \
>  	___C(IDENTIFY, "Identify Command"),                               \
> 

