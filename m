Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBBC0C7EE22
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 13:02:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242064AbjEONCy (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 09:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242073AbjEONCr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 09:02:47 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1CA319A1
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 06:02:45 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKfZ40PhTz6J70t;
        Mon, 15 May 2023 20:58:36 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 14:02:43 +0100
Date:   Mon, 15 May 2023 14:02:42 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Fan Ni <fan.ni@samsung.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: [RFC 1/7] hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field
 to output payload of identify memory device command
Message-ID: <20230515140242.00006764@Huawei.com>
In-Reply-To: <20230511175609.2091136-2-fan.ni@samsung.com>
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175641uscas1p2e2dd6a5b681f73870e33869af0247c06@uscas1p2.samsung.com>
        <20230511175609.2091136-2-fan.ni@samsung.com>
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

On Thu, 11 May 2023 17:56:40 +0000
Fan Ni <fan.ni@samsung.com> wrote:

> From: Fan Ni <nifan@outlook.com>
> 
> Based on CXL spec 3.0 Table 8-94 (Identify Memory Device Output
> Payload), dynamic capacity event log size should be part of
> output of the Identify command.
> Add dc_event_log_size to the output payload for the host to get the info.
> 
> Signed-off-by: Fan Ni <fan.ni@samsung.com>

Trivial formatting aside, looks good to me.

Jonathan


> ---
>  hw/cxl/cxl-mailbox-utils.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 9f8e6722d7..7ff4fbdf22 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -21,6 +21,8 @@
>  #include "sysemu/hostmem.h"
>  
>  #define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
> +/* Experimental value: dynamic capacity event log size */
> +#define CXL_DC_EVENT_LOG_SIZE 8
>  
>  /*
>   * How to add a new command, example. The command set FOO, with cmd BAR.
> @@ -519,8 +521,9 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>          uint16_t inject_poison_limit;
>          uint8_t poison_caps;
>          uint8_t qos_telemetry_caps;
> +		uint16_t dc_event_log_size;
Qemu uses 4 space indentation not tabs.

>      } QEMU_PACKED *id;
> -    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
> +    QEMU_BUILD_BUG_ON(sizeof(*id) != 0x45);
>  
>      CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
>      CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
> @@ -543,6 +546,7 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
>      st24_le_p(id->poison_list_max_mer, 256);
>      /* No limit - so limited by main poison record limit */
>      stw_le_p(&id->inject_poison_limit, 0);
> +	stw_le_p(&id->dc_event_log_size, CXL_DC_EVENT_LOG_SIZE);
>  
>      *len = sizeof(*id);
>      return CXL_MBOX_SUCCESS;

