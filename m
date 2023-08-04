Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BEA2C001DB
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 14:56:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjHDO44 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 10:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjHDO4z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 10:56:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97CB749C6
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 07:56:51 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHTGq2D65z67LyQ;
        Fri,  4 Aug 2023 22:53:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 15:56:48 +0100
Date:   Fri, 4 Aug 2023 15:56:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        <junhee.ryu@sk.com>, <kwangjin.ko@sk.com>,
        Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH 1/4] cxl/mailbox: change CCI cmd set structure to be a
 member, not a refernce
Message-ID: <20230804155647.00007c12@Huawei.com>
In-Reply-To: <20230721163505.1910-2-gregory.price@memverge.com>
References: <20230721163505.1910-1-gregory.price@memverge.com>
        <20230721163505.1910-2-gregory.price@memverge.com>
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

On Fri, 21 Jul 2023 12:35:04 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

Typo in patch title. reference

> This allows devices to have fully customized CCIs, along with complex
> devices where wrapper devices can override or add additional CCI
> commands without having to replicate full command structures or
> pollute a base device with every command that might ever be used.
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>

Hi Gregory, 

This might give us a nice solution to a problem with rebasing Fan's
DCD set, so I'm reviewing it head of the later part of your series
and may pick it up in the meantime.


> ---
>  hw/cxl/cxl-mailbox-utils.c  | 18 ++++++++++++++----
>  include/hw/cxl/cxl_device.h |  2 +-
>  2 files changed, 15 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 2819914e8d..ddee3f1718 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -1373,9 +1373,19 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>                                   bg_timercb, cci);
>  }
>  
> +static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256]) {

Bracket on next line.

> +    for (int set = 0; set < 256; set++) {
> +        for (int cmd = 0; cmd < 256; cmd++) {
> +            if (cxl_cmds[set][cmd].handler) {
> +                cci->cxl_cmd_set[set][cmd] = cxl_cmds[set][cmd];
> +            }
> +        }
> +    }
> +}
> +
>  void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d, size_t payload_max)
>  {
> -    cci->cxl_cmd_set = cxl_cmd_set_sw;
> +    cxl_copy_cci_commands(cci, cxl_cmd_set_sw);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> @@ -1383,7 +1393,7 @@ void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf, DeviceState *d
>  
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
>  {
> -    cci->cxl_cmd_set = cxl_cmd_set;
> +    cxl_copy_cci_commands(cci, cxl_cmd_set);
>      cci->d = d;
>   
>      /* No separation for PCI MB as protocol handled in PCI device */
> @@ -1398,7 +1408,7 @@ static const struct cxl_cmd cxl_cmd_set_t3_mctp[256][256] = {
>  void cxl_initialize_t3_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf,
>                                 size_t payload_max)
>  {
> -    cci->cxl_cmd_set = cxl_cmd_set_t3_mctp;
> +    cxl_copy_cci_commands(cci, cxl_cmd_set_t3_mctp);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> @@ -1414,7 +1424,7 @@ static const struct cxl_cmd cxl_cmd_set_usp_mctp[256][256] = {
>  
>  void cxl_initialize_usp_mctpcci(CXLCCI *cci, DeviceState *d, DeviceState *intf, size_t payload_max)
>  {
> -    cci->cxl_cmd_set = cxl_cmd_set_usp_mctp;
> +    cxl_copy_cci_commands(cci, cxl_cmd_set_usp_mctp);
>      cci->d = d;
>      cci->intf = intf;
>      cxl_init_cci(cci, payload_max);
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index c68981b618..9a3c8b2dfa 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -163,7 +163,7 @@ typedef struct CXLEventLog {
>  } CXLEventLog;
>  
>  typedef struct CXLCCI {
> -    const struct cxl_cmd (*cxl_cmd_set)[256];
> +    struct cxl_cmd cxl_cmd_set[256][256];
>      struct cel_log {
>          uint16_t opcode;
>          uint16_t effect;

