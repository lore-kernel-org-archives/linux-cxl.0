Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B9A1C00528
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 13:55:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230169AbjHDNzm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 09:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjHDNzl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 09:55:41 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6241EB1
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 06:55:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHRwW2vtyz6J6bH;
        Fri,  4 Aug 2023 21:52:11 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 4 Aug
 2023 14:55:36 +0100
Date:   Fri, 4 Aug 2023 14:55:35 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 2/2] hw/cxl: Add the Get Supported Logs Sub-List cmd
Message-ID: <20230804145535.000052ea@Huawei.com>
In-Reply-To: <20230728165705.5889-3-dave@stgolabs.net>
References: <20230728165705.5889-1-dave@stgolabs.net>
        <20230728165705.5889-3-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 28 Jul 2023 09:57:05 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> The spec is quite clear that system software should try using
> this instead of the traditional GSL - albeit both qemu and driver
> only have CEL. In addition make the already existing commands a
> bit more generic for any addition of future logs.
> 
> As noted in the code, the spec is also not explicit about all
> input scan range errors - for which qemu can return 0 entries but
> still set the total number of entries available.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr

Comments inline.  I think we should look at implementing some other
randomly chosen log so as to be able to test the loops etc in here.

I guess could be either the really generic vendor debug log, or
the slightly more specific component state dump log.

Or do them both and return suitable a text quote of your choosing
as the debug information for now. 

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c | 101 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 94 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 5152a83c6fdd..0110797b7b52 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -64,6 +64,7 @@ enum {
>      LOGS        = 0x04,
>          #define GET_SUPPORTED 0x0
>          #define GET_LOG       0x1
> +        #define GET_SUPPORTED_SUBLIST  0x5
>      IDENTIFY    = 0x40,
>          #define MEMORY_DEVICE 0x0
>      CCLS        = 0x41,
> @@ -602,6 +603,11 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +enum {
> +    CXL_LOGS_CEL,
> +    CXL_MAX_SUPPORTED_LOGS,
> +};
> +
>  /* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
>  static const QemuUUID cel_uuid = {
>      .data = UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> @@ -616,20 +622,28 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
>                                           size_t *len_out,
>                                           CXLCCI *cci)
>  {
> +    uint16_t i;
>      struct {
>          uint16_t entries;
>          uint8_t rsvd[6];
>          struct {
>              QemuUUID uuid;
>              uint32_t size;
> -        } log_entries[1];
> +        } log_entries[CXL_MAX_SUPPORTED_LOGS];
>      } QEMU_PACKED *supported_logs = (void *)payload_out;
>      QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
>  
> -    supported_logs->entries = 1;
> -    supported_logs->log_entries[0].uuid = cel_uuid;
> -    supported_logs->log_entries[0].size = 4 * cci->cel_size;
> -
> +    supported_logs->entries = CXL_MAX_SUPPORTED_LOGS;
> +    for (i = 0; i < CXL_MAX_SUPPORTED_LOGS; i++) { /* all */
> +        switch (i) {
> +        case CXL_LOGS_CEL:
> +            supported_logs->log_entries[i].uuid = cel_uuid;
> +            supported_logs->log_entries[i].size = 4 * cci->cel_size;
> +            break;
> +        default:
> +            break;
> +        }
> +    }

Arguably premature flexibility given it's a loop that always goes around once only.

>      *len_out = sizeof(*supported_logs);
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -642,6 +656,8 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>                                     size_t *len_out,
>                                     CXLCCI *cci)
>  {
> +    uint8_t i;
> +    bool found = false;
>      struct {
>          QemuUUID uuid;
>          uint32_t offset;
> @@ -661,8 +677,15 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
>  
> -    if (!qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> -        return CXL_MBOX_UNSUPPORTED;
> +    for (i = 0; i < CXL_MAX_SUPPORTED_LOGS; i++) { /* all */
> +        if (i == CXL_LOGS_CEL &&
> +            qemu_uuid_is_equal(&get_log->uuid, &cel_uuid)) {
> +                found = true;
> +                break;
> +        }
> +    }
> +    if (!found) {
> +         return CXL_MBOX_UNSUPPORTED;
>      }
>  
>      /* Store off everything to local variables so we can wipe out the payload */
> @@ -673,6 +696,66 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.0 8.2.9.5.6 */

Please update as per previous patch comment.

> +static CXLRetCode cmd_logs_get_supported_sublist(const struct cxl_cmd *cmd,
> +                                                 uint8_t *payload_in,
> +                                                 size_t len_in,
> +                                                 uint8_t *payload_out,
> +                                                 size_t *len_out,
> +                                                 CXLCCI *cci)
> +{
> +    uint8_t i, entries, start;
> +    struct inject_poison_pl {

? :)

> +        uint8_t max_entries;
> +        uint8_t start_idx;
> +    } QEMU_PACKED *in = (void *)payload_in;
> +    struct {
> +        uint8_t entries;
> +        uint8_t rsvd1;
> +        uint16_t total_entries;
> +        uint8_t start_idx;
> +        uint8_t rsvd2[3];
> +        struct {
> +            QemuUUID uuid;
> +            uint32_t size;
> +        } log_entries[CXL_MAX_SUPPORTED_LOGS];
> +    } QEMU_PACKED *supported_logs = (void *)payload_out;
> +    QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);

Why the size check (which will break the moment the number of logs changes?)
Those don't really make sense for variable length replies.

> +
> +    if (in->max_entries < 1) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +    /*
> +     * XXX: Handle other bogus input by returning zero entries but
> +     * setting the total_entries such that software user can
> +     * get it right next time(?) CXL spec mentions nothing about
> +     * handling this.

In my view, software that doesn't first issue in->start_idx == 0
has shot itself in the foot. Return CXL_MBOX_INVALID_INPUT.
I don't think ti's valid to return start = 0...

However I agree there may be a space for a spec clarification.

> +     */
> +    if (in->start_idx > CXL_MAX_SUPPORTED_LOGS - 1) {
> +        start = 0;
> +        entries = 0;
> +    } else {
> +        start = in->start_idx;
> +        entries = MIN(CXL_MAX_SUPPORTED_LOGS - start, in->max_entries);
> +    }
> +    supported_logs->entries = entries;
> +    supported_logs->total_entries = CXL_MAX_SUPPORTED_LOGS;
> +    supported_logs->start_idx = start;
> +    for (i = start; i < entries; i++) {
> +        switch (i) {
> +        case CXL_LOGS_CEL:
> +            supported_logs->log_entries[i].uuid = cel_uuid;

Need a second index counting in log_entries as that needs to always start at 0.

Also, I think we should move to an array of data structures containing
the uuids and sizes for each log type so the switch statement here goes away
as does the if stuff above.


> +            supported_logs->log_entries[i].size = 4 * cci->cel_size;
> +            break;
> +        default:
> +            break;
> +        }
> +    }
> +
> +    *len_out = sizeof(*supported_logs);
> +    return CXL_MBOX_SUCCESS;
> +}
> +


