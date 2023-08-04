Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863F0C00528
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 13:30:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230393AbjHDNaQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:30:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbjHDNaF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 09:30:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099293598
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 06:29:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHRKJ1W5Yz67Lmq;
        Fri,  4 Aug 2023 21:25:08 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 14:29:55 +0100
Date:   Fri, 4 Aug 2023 14:29:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: Update comments for Get Log
Message-ID: <20230804142954.00003b8a@Huawei.com>
In-Reply-To: <20230728165705.5889-2-dave@stgolabs.net>
References: <20230728165705.5889-1-dave@stgolabs.net>
        <20230728165705.5889-2-dave@stgolabs.net>
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

On Fri, 28 Jul 2023 09:57:04 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> The current notes regarding some of the literature in the spec
> no longer applies, update from 2.0 to 3.0.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

Thanks for tidying this bit up.

We aren't doing great on consistency of how we list the version numbers
in the QEMU code, but I'd like to definitely make it easier to tell
what is revision and what is section.

So I've tweak your changes here to the format

/* CXL r3.0 section xxxxxx: Section title */

and put it on top of my tree (I'll push out once I've finished queuing anything
else that is ready up on top.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 10 ++--------
>  1 file changed, 2 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2819914e8d09..5152a83c6fdd 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -608,7 +608,7 @@ static const QemuUUID cel_uuid = {
>                   0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
>  };
>  
> -/* 8.2.9.4.1 */
> +/* CXL 3.0 8.2.9.5.1 */
>  static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
>                                           uint8_t *payload_in,
>                                           size_t len_in,
> @@ -634,7 +634,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -/* 8.2.9.4.2 */
> +/* CXL 3.0 8.2.9.5.2 */
>  static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>                                     uint8_t *payload_in,
>                                     size_t len_in,
> @@ -651,12 +651,6 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      get_log = (void *)payload_in;
>  
>      /*
> -     * 8.2.9.4.2
> -     *   The device shall return Invalid Parameter if the Offset or Length
> -     *   fields attempt to access beyond the size of the log as reported by Get
> -     *   Supported Logs.
> -     *
> -     * XXX: Spec is wrong, "Invalid Parameter" isn't a thing.
>       * XXX: Spec doesn't address incorrect UUID incorrectness.
>       *
>       * The CEL buffer is large enough to fit all commands in the emulation, so

