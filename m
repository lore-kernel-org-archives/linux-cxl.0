Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A99AC61DA4
	for <linux-cxl@archiver.kernel.org>; Thu,  2 Feb 2023 10:01:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjBBKBn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 2 Feb 2023 05:01:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232153AbjBBKBm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 2 Feb 2023 05:01:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6383387D36
        for <linux-cxl@vger.kernel.org>; Thu,  2 Feb 2023 02:01:40 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4P6vRh5D4cz6J9bP;
        Thu,  2 Feb 2023 18:00:32 +0800 (CST)
Received: from localhost (10.81.211.68) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 10:01:37 +0000
Date:   Thu, 2 Feb 2023 10:01:37 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Robert Richter <rrichter@amd.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] cxl/mem: Fix UAPI command comment
Message-ID: <20230202100137.0000150f@Huawei.com>
In-Reply-To: <20221222-cxl-misc-v3-4-60d4f35e4b39@intel.com>
References: <20221222-cxl-misc-v3-0-60d4f35e4b39@intel.com>
        <20221222-cxl-misc-v3-4-60d4f35e4b39@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.211.68]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, 01 Feb 2023 17:23:13 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> The command comment had grammatical errors.  In an attempt to fix those
> it was noted that the comment and the query command were not in sync.
> 
> Now that the query command returns excluded and device unsupported
> command information.  Update the kdoc and fix the grammatical errors.
> 
> [1] https://lore.kernel.org/all/63b4ec4e37cc1_5178e2941d@dwillia2-xfh.jf.intel.com.notmuch/
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Looks fine to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> ---
> Changes for v3:
> 	Adjust commit message for updated query command behavior.
> ---
>  include/uapi/linux/cxl_mem.h | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 4aee64b7cc1a..b1d41e3be4e5 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -11,9 +11,10 @@
>  /**
>   * DOC: UAPI
>   *
> - * Not all of all commands that the driver supports are always available for use
> - * by userspace. Userspace must check the results from the QUERY command in
> - * order to determine the live set of commands.
> + * Not all of the commands that the driver supports are available for use by
> + * userspace at all times.  Userspace can check the result of the QUERY command
> + * to determine the live set of commands.  Alternatively, it can issue the
> + * command and check for failure.
>   */
>  
>  #define CXL_MEM_QUERY_COMMANDS _IOR(0xCE, 1, struct cxl_mem_query_commands)
> 

