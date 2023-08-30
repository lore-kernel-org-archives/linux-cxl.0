Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A857C6FA8F
	for <linux-cxl@archiver.kernel.org>; Wed, 30 Aug 2023 18:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244526AbjH3SxH (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 30 Aug 2023 14:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243454AbjH3LDn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 30 Aug 2023 07:03:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B14091BF
        for <linux-cxl@vger.kernel.org>; Wed, 30 Aug 2023 04:03:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RbLrT3hGrz6K631;
        Wed, 30 Aug 2023 18:58:49 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Wed, 30 Aug
 2023 12:03:36 +0100
Date:   Wed, 30 Aug 2023 12:03:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <dave.jiang@intel.com>,
        <alison.schofield@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <deepak.ukey@samsung.com>,
        <sathya.m@samsung.com>, <d.palani@samsung.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH] cxl: Add Support for Get Timestamp
Message-ID: <20230830120336.00006308@Huawei.com>
In-Reply-To: <20230829152014.15452-1-dave@stgolabs.net>
References: <20230829152014.15452-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 29 Aug 2023 08:20:14 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Add the call to the UAPI such that userspace may corelate the
> timestamps from the device log with system wall time, if, for
> example there's any sort of inaccuracy or skew in the device.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

Seems sensible to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/mbox.c      | 1 +
>  drivers/cxl/cxlmem.h         | 1 +
>  include/uapi/linux/cxl_mem.h | 1 +
>  3 files changed, 3 insertions(+)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index ca60bb8114f2..2444faac1e4c 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -63,6 +63,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
>  	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
>  	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
>  	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
> +	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
>  };
>  
>  /*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 706f8a6d1ef4..ec6dfcc7bb99 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -500,6 +500,7 @@ enum cxl_opcode {
>  	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>  	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>  	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
> +	CXL_MBOX_OP_GET_TIMESTAMP	= 0x0300,
>  	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>  	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>  	CXL_MBOX_OP_GET_LOG		= 0x0401,
> diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
> index 14bc6e742148..42066f4eb890 100644
> --- a/include/uapi/linux/cxl_mem.h
> +++ b/include/uapi/linux/cxl_mem.h
> @@ -46,6 +46,7 @@
>  	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
>  	___DEPRECATED(SCAN_MEDIA, "Scan Media"),                          \
>  	___DEPRECATED(GET_SCAN_MEDIA, "Get Scan Media Results"),          \
> +	___C(GET_TIMESTAMP, "Get Timestamp"),                             \
>  	___C(MAX, "invalid / last command")
>  
>  #define ___C(a, b) CXL_MEM_COMMAND_ID_##a

