Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0EC881E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720184258; cv=none; b=iDADqaCaAmIgE2zhBTa2jj/eoNIdiRc4w/CuWzvLI8FIJmmf1usyMvRHTtpOugdpKIUmZiSB4n9WOWtt+YxtQ0P+Mr4ZVsWYECK0ycL5+A7QD+VKsBvh/9VIWobotT2mzcHovBlADJcdXyi8rGV+l1cT9/p2pyU4E2dCnOdaLhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720184258; c=relaxed/simple;
	bh=BYF/UFmxAnZlD0sep3niVrrKjh/4+kF26WHRy8s0Dsk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=USMWs+PDkUJje2rk+r8VoqYNWgjnRSQkY9o5tOXPnyj8W1bcLkT+RvBbdP7dZLDLOjMakNZouBbFz5UZwJ8Du1H3l73IJiflu6GVllPD6BUwwmESS+jjs/8BAK1SjUbvnvmFGiThV0iccHBabKi0viRw2p1tlvxkN9mE1EoQDtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtnW37Mlz6HJhW;
	Fri,  5 Jul 2024 20:56:47 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id AE4CA1400D3;
	Fri,  5 Jul 2024 20:57:31 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 13:57:31 +0100
Date: Fri, 5 Jul 2024 13:57:30 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v3 -qemu] hw/cxl: Support firmware updates
Message-ID: <20240705135730.000035ef@Huawei.com>
In-Reply-To: <20240627164912.25630-1-dave@stgolabs.net>
References: <20240627164912.25630-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500002.china.huawei.com (7.191.160.78) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Thu, 27 Jun 2024 09:49:12 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement transfer and activate functionality per 3.1 spec for
> supporting update metadata (no actual buffers). Transfer times
> are arbitrarily set to ten and two seconds for full and part
> transfers, respectively.
A couple of white space things + I want to drag this
earlier in my tree so I've done a rebase.   Sending what
is effectively a 'pull' request to Michael for this one shortly.

It's queued behind
+ scan media
+ get feature /scrub
And in parallel to:
+ mixed fixes and cleanup.
+ generic ports.

Fingers crossed that a lot if not all of these move forward.

Jonathan
 
> 
> cxl update-firmware mem0 -F fw.img
> 
> <on-going fw update>
> 
> cxl update-firmware mem0
>   "memdev":"mem0",
>   "pmem_size":"1024.00 MiB (1073.74 MB)",
>   "serial":"0",
>   "host":"0000:0d:00.0",
>   "firmware":{
>     "num_slots":2,
>     "active_slot":1,
>     "online_activate_capable":true,
>     "slot_1_version":"BWFW VERSION 0",
>     "fw_update_in_progress":true,
>     "remaining_size":22400
>   }
> }
> 
> <completed fw update>
> 
> cxl update-firmware mem0
> {
>   "memdev":"mem0",
>   "pmem_size":"1024.00 MiB (1073.74 MB)",
>   "serial":"0",
>   "host":"0000:0d:00.0",
>   "firmware":{
>     "num_slots":2,
>     "active_slot":1,
>     "staged_slot":2,
>     "online_activate_capable":true,
>     "slot_1_version":"BWFW VERSION 0",
>     "slot_2_version":"BWFW VERSION 1",
>     "fw_update_in_progress":false
>   }
> }
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
> 
> Changes from v2: https://lore.kernel.org/linux-cxl/20240205172942.13343-1-dave@stgolabs.net/
>  - Applies on top of 'cxl-2024-06-21' branch.
>  - Remove bogus member in transfer fw payload. (Fan)
>  - For partial xfers, only verify for overlaps when ensuring xfer order.
>  - Removed slot interleaving detection for partial xfers. (Jonathan)
>  - Upon init, do not stage a slot. (Jonathan)
>  - For get info, left the rev1 static within: as a new slot is staged,
>    it will shows both slot revs.
> 
>  hw/cxl/cxl-mailbox-utils.c  | 205 +++++++++++++++++++++++++++++++++++-
>  include/hw/cxl/cxl_device.h |  15 +++
>  2 files changed, 215 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7d60868bb6c0..77b226c19c28 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -63,6 +63,8 @@ enum {
>          #define SET_INTERRUPT_POLICY   0x3
>      FIRMWARE_UPDATE = 0x02,
>          #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
>      TIMESTAMP   = 0x03,
>          #define GET           0x0
>          #define SET           0x1
> @@ -641,6 +643,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +#define CXL_FW_SLOTS 2
> +#define CXL_FW_SIZE  0x02000000 /* 32 mb */
> +
>  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>                                                 uint8_t *payload_in,
> @@ -671,15 +676,192 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>  
>      fw_info = (void *)payload_out;
>  
> -    fw_info->slots_supported = 2;
> -    fw_info->slot_info = BIT(0) | BIT(3);
> -    fw_info->caps = 0;
> -    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> +    fw_info->slots_supported = CXL_FW_SLOTS;
> +    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
> +            ((cci->fw.staged_slot & 0x7) << 3);
> +    fw_info->caps = BIT(0);  /* online update supported */
> +
> +    if (cci->fw.slot[0]) {
> +        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> +    }
> +    if (cci->fw.slot[1]) {
> +        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
> +    }
>  
>      *len_out = sizeof(*fw_info);
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
> +#define CXL_FW_XFER_ALIGNMENT   128
> +
> +#define CXL_FW_XFER_ACTION_FULL	    0x0
> +#define CXL_FW_XFER_ACTION_INIT	    0x1
> +#define CXL_FW_XFER_ACTION_CONTINUE 0x2
> +#define CXL_FW_XFER_ACTION_END	    0x3
> +#define CXL_FW_XFER_ACTION_ABORT    0x4
> +
> +static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t action;
> +        uint8_t slot;
> +        uint8_t rsvd1[2];
> +        uint32_t offset;
> +        uint8_t rsvd2[0x78];
> +        uint8_t data[];
> +    } QEMU_PACKED *fw_transfer = (void *)payload_in;
> +    size_t offset, length;
> +
> +    if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
> +        /*
> +         * At this point there aren't any on-going transfers
> +         * running in the bg - this is serialized before this
> +         * call altogether. Just mark the state machine and
> +         * disregard any other input.
> +         */
> +        cci->fw.transferring = false;
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
> +    length = len - sizeof(*fw_transfer);
> +    if (offset + length > CXL_FW_SIZE) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (cci->fw.transferring) {
> +        if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
> +            fw_transfer->action == CXL_FW_XFER_ACTION_INIT) {
> +            return CXL_MBOX_FW_XFER_IN_PROGRESS;
> +        }
> +        /*
> +         * Abort partitioned package transfer if over 30 secs
> +         * between parts. As opposed to the explicit ABORT action,
> +         * semantically treat this condition as an error - as
> +         * if a part action were passed without a previous INIT.
> +         */
> +        if (difftime(time(NULL), cci->fw.last_partxfer) > 30.0) {
> +            cci->fw.transferring = false;
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    } else if (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
> +               fw_transfer->action == CXL_FW_XFER_ACTION_END) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    /* allow back-to-back retransmission */
> +    if ((offset != cci->fw.prev_offset || length != cci->fw.prev_len) &&
> +        (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
> +         fw_transfer->action == CXL_FW_XFER_ACTION_END)) {
> +        /* verify no overlaps */
> +        if (offset < cci->fw.prev_offset + cci->fw.prev_len) {
> +            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
> +        }
> +    }
> +
> +    switch (fw_transfer->action) {
> +    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
> +    case CXL_FW_XFER_ACTION_END:
> +        if (fw_transfer->slot == 0 ||
> +            fw_transfer->slot == cci->fw.active_slot ||
> +            fw_transfer->slot > CXL_FW_SLOTS) {
> +            return CXL_MBOX_FW_INVALID_SLOT;
> +        }
> +
> +        /* mark the slot used upon bg completion */
> +        break;
> +    case CXL_FW_XFER_ACTION_INIT:
> +        if (offset != 0) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        cci->fw.transferring = true;
> +        cci->fw.prev_offset = offset;
> +        cci->fw.prev_len = length;
> +        break;
> +    case CXL_FW_XFER_ACTION_CONTINUE:
> +        cci->fw.prev_offset = offset;
> +        cci->fw.prev_len = length;
> +        break;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL) {
> +        cci->bg.runtime = 10 * 1000UL;
> +    } else {
> +        cci->bg.runtime = 2 * 1000UL;
> +    }
> +    /* keep relevant context for bg completion */
> +    cci->fw.curr_action = fw_transfer->action;
> +    cci->fw.curr_slot = fw_transfer->slot;
> +    *len_out = 0;
> +
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
> +static void __do_firmware_xfer(CXLCCI *cci)
> +{
> +    switch (cci->fw.curr_action) {
> +    case CXL_FW_XFER_ACTION_FULL:
> +    case CXL_FW_XFER_ACTION_END:
> +        cci->fw.slot[cci->fw.curr_slot - 1] = true;
> +        cci->fw.transferring = false;
> +        break;
> +    case CXL_FW_XFER_ACTION_INIT:
> +    case CXL_FW_XFER_ACTION_CONTINUE:
> +        time(&cci->fw.last_partxfer);
> +        break;
> +    default:
> +        break;
> +    }
> +}
> +
> +/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
> +static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    struct {
> +        uint8_t action;
> +        uint8_t slot;
> +    } QEMU_PACKED *fw_activate = (void *)payload_in;
> +    QEMU_BUILD_BUG_ON(sizeof(*fw_activate) != 0x2);
> +
> +    if (fw_activate->slot == 0 ||
> +        fw_activate->slot == cci->fw.active_slot ||
> +        fw_activate->slot > CXL_FW_SLOTS) {
> +        return CXL_MBOX_FW_INVALID_SLOT;
> +    }
> +
> +    /* ensure that an actual fw package is there */
> +    if (!cci->fw.slot[fw_activate->slot - 1]) {
> +        return CXL_MBOX_FW_INVALID_SLOT;
> +    }
> +
> +    switch (fw_activate->action) {
> +    case 0: /* online */
> +        cci->fw.active_slot = fw_activate->slot;
> +        break;
> +    case 1: /* reset */
> +        cci->fw.staged_slot = fw_activate->slot;
> +        break;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    return CXL_MBOX_SUCCESS;
> +}
> +
>  /* CXL r3.1 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
>  static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
>                                      uint8_t *payload_in,
> @@ -2510,6 +2692,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>                                        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
> +    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
> +        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
> +    [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
> +        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
>                           8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
> @@ -2639,7 +2825,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>                  h == cmd_media_get_poison_list ||
>                  h == cmd_media_inject_poison ||
>                  h == cmd_media_clear_poison ||
> -                h == cmd_sanitize_overwrite) {
> +                h == cmd_sanitize_overwrite ||
> +                h == cmd_firmware_update_transfer ||
> +                h == cmd_firmware_update_activate) {
>                  return CXL_MBOX_MEDIA_DISABLED;
>              }
>          }
> @@ -2684,6 +2872,9 @@ static void bg_timercb(void *opaque)
>          cci->bg.complete_pct = 100;
>          cci->bg.ret_code = ret;
>          switch (cci->bg.opcode) {
> +        case 0x0201: /* fw transfer */
> +            __do_firmware_xfer(cci);
> +            break;
>          case 0x4400: /* sanitize */
>          {
>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> @@ -2755,6 +2946,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>      cci->bg.runtime = 0;
>      cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                   bg_timercb, cci);
> +
> +    memset(&cci->fw, 0, sizeof(cci->fw));
> +    cci->fw.active_slot = 1;
> +    cci->fw.slot[cci->fw.active_slot - 1] = true;
>  }
>  
>  static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index cb95ccbd6140..a048e2b1b46c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -203,7 +203,21 @@ typedef struct CXLCCI {
>          uint64_t runtime;
>          QEMUTimer *timer;
>      } bg;
> +
> +    /* firmware update */
> +    struct {
> +        uint8_t active_slot;
> +        uint8_t staged_slot;
> +        bool slot[4];
> +        uint8_t curr_action;
> +        uint8_t curr_slot;
> +        /* handle partial transfers */
> +        bool transferring;
> +        size_t prev_offset;
> +        size_t prev_len;
> +        time_t last_partxfer;
> +    } fw;
> +
>      size_t payload_max;
>      /* Pointer to device hosting the CCI */
>      DeviceState *d;
> --
> 2.45.2
> 

