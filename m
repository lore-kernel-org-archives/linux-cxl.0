Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D91AC76196
	for <linux-cxl@archiver.kernel.org>; Mon,  3 Apr 2023 16:47:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbjDCQrh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 3 Apr 2023 12:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbjDCQrh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 3 Apr 2023 12:47:37 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F137E4
        for <linux-cxl@vger.kernel.org>; Mon,  3 Apr 2023 09:47:34 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Pqxck71K7z67Ct8;
        Tue,  4 Apr 2023 00:46:46 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 3 Apr
 2023 17:47:31 +0100
Date:   Mon, 3 Apr 2023 17:47:30 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <ira.weiny@intel.com>,
        <fan.ni@samsung.com>, <a.manzanares@samsung.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Message-ID: <20230403174730.00003920@Huawei.com>
In-Reply-To: <20230224194443.1990440-2-dave@stgolabs.net>
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <20230224194443.1990440-2-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 24 Feb 2023 11:44:41 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Support background commands in the mailbox, and update
> cmd_infostat_bg_op_sts() accordingly. This patch does
> not implement mbox interrupts upon completion, so the
> kernel driver must rely on polling to know when the
> operation is done.

Better to wrap a little nearer 70-75 chars for a commit message.

> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I suspect we need to ensure the timer is stopped in the tear down
path via timer_free(), but otherwise a few comments inline.

Jonathan

> ---
>  hw/cxl/cxl-device-utils.c   |   5 +-
>  hw/cxl/cxl-mailbox-utils.c  | 103 ++++++++++++++++++++++++++++++++++--
>  include/hw/cxl/cxl_device.h |  10 ++++
>  3 files changed, 111 insertions(+), 7 deletions(-)
> 
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 50c76c65e755..4bb4e85dae19 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -101,8 +101,7 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
>      case A_CXL_DEV_MAILBOX_CMD:
>          break;
>      case A_CXL_DEV_BG_CMD_STS:
> -        /* BG not supported */
> -        /* fallthrough */
> +        break;
>      case A_CXL_DEV_MAILBOX_STS:
>          /* Read only register, will get updated by the state machine */
>          return;
> @@ -273,7 +272,7 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
>  
>  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    /* 2048 payload size, with no interrupt or background support */
> +    /* 2048 payload size, with no interrupt */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
>      cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index b02908c4a4ba..82923bb84eb0 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -350,7 +350,14 @@ static CXLRetCode cmd_infostat_bg_op_sts(struct cxl_cmd *cmd,
>  
>      bg_op_status = (void *)cmd->payload;
>      memset(bg_op_status, 0, sizeof(*bg_op_status));
> -    /* No support yet for background operations so status all 0 */
> +    bg_op_status->status = ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state64,
> +                                            CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP) << 1;

Ah. I'd forgotten I bodged this one in for the switch.  

> +    if (cxl_dstate->bg.runtime > 0) {
> +        bg_op_status->status |= 1U << 0;
> +    }
> +    bg_op_status->opcode = cxl_dstate->bg.opcode;
> +    bg_op_status->returncode = ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state64,
> +                                               CXL_DEV_BG_CMD_STS, RET_CODE);
>      *len = sizeof(*bg_op_status);
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -808,6 +815,8 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> +#define SECURITY_STATE_CHANGE (1 << 5)

I'd be either tempted to drop defining SECURITY_STATE_CHANGE or go all the way
and define all the bits in CXL 3.0.  Slight preference for just dropping the
unused one for now.

> +#define BACKGROUND_OPERATION (1 << 6)

>  
>  static struct cxl_cmd cxl_cmd_set[256][256] = {
>      [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
> @@ -856,12 +865,20 @@ static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>          cmd_identify_switch_device, 0, 0x49 },
>  };
>  
> +/*
> + * While the command is executing in the background, the device should
> + * update the percentage complete in the Background Command Status Register
> + * at least once per second.
> + */
> +#define CXL_MBOX_BG_UPDATE_FREQ 1000UL
> +
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  {
>      uint16_t ret = CXL_MBOX_SUCCESS;
>      struct cxl_cmd *cxl_cmd;
> -    uint64_t status_reg;
> +    uint64_t status_reg = 0;
>      opcode_handler h;
> +    uint8_t bg_started = 0;
>      uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
>  
>      uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
> @@ -873,7 +890,17 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>          if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
>              cxl_cmd->payload = cxl_dstate->mbox_reg_state +
>                  A_CXL_DEV_CMD_PAYLOAD;
> +            /* Only one bg command at a time */
> +            if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> +                cxl_dstate->bg.runtime > 0) {
> +                    ret = CXL_MBOX_BUSY;
> +                    goto done;
> +            }
>              ret = (*h)(cxl_cmd, cxl_dstate, &len);
> +            if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> +                ret == CXL_MBOX_BG_STARTED) {
> +                bg_started = 1;
> +            }
>              assert(len <= cxl_dstate->payload_size);
>          } else {
>              ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> @@ -884,8 +911,12 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>          ret = CXL_MBOX_UNSUPPORTED;
>      }
>  
> -    /* Set the return code */
> -    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
> +done:
> +    /* Set bg and the return code */
> +    if (bg_started) {
> +        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, bg_started);

You've set status_reg to 0 above, so just do FIELD_DP64(status_reg, ..
here and ave a reviewer have to check if we might be wiping something out.
Or reorder this to after setting the ERRNO field thus reducing the diff.

> +    }
> +    status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, ret);
>  
>      /* Set the return length */
>      command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
> @@ -895,11 +926,70 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
>  
> +    if (bg_started) {
> +        uint64_t bg_status_reg, now;
> +
> +        cxl_dstate->bg.opcode = (set << 8) | cmd;
> +
> +        bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP, cxl_dstate->bg.opcode);
> +        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> +                                   PERCENTAGE_COMP, 0);
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
> +
> +        now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +        cxl_dstate->bg.starttime = now;
> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> +    }
> +
>      /* Tell the host we're done */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
>                       DOORBELL, 0);
>  }
>  
> +static void bg_timercb(void *opaque)
> +{
> +    CXLDeviceState *cxl_dstate = opaque;
> +    uint64_t bg_status_reg = 0;
> +    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    uint64_t total_time = cxl_dstate->bg.starttime + cxl_dstate->bg.runtime;
> +
> +    assert(cxl_dstate->bg.runtime > 0);
> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> +                               OP, cxl_dstate->bg.opcode);
> +
> +    if (now >= total_time) { /* we are done */
> +        uint64_t status_reg;
> +        uint16_t ret = CXL_MBOX_SUCCESS;
> +
> +        cxl_dstate->bg.complete_pct = 100;
> +        /* Clear bg */
> +        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
> +
> +        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
> +
> +        /* TODO add ad-hoc cmd succesful completion handling */
> +
> +        qemu_log("Background command %04xh finished: %s\n",
> +                 cxl_dstate->bg.opcode,
> +                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");

Useful for debug, but we probably don't want it there in final code.

> +    } else {
> +        /* estimate only */
> +        cxl_dstate->bg.complete_pct = 100 * now / total_time;
> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> +    }
> +
> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP,
> +                               cxl_dstate->bg.complete_pct);
> +    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
> +
> +    if (cxl_dstate->bg.complete_pct == 100) {
> +        cxl_dstate->bg.starttime = 0;
> +        /* registers are updated, allow new bg-capable cmds */
> +        cxl_dstate->bg.runtime = 0;

Looks like this could all move into the if (now >=.. 
block above as I'm not seeing either of these fields being used after that.

> +    }
> +}
> +
>  void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>  {
>      if (!switch_cci) {
> @@ -920,4 +1010,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>              }
>          }
>      }
> +    cxl_dstate->bg.complete_pct = 0;
> +    cxl_dstate->bg.starttime = 0;
> +    cxl_dstate->bg.runtime = 0;
> +    cxl_dstate->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +                                        bg_timercb, cxl_dstate);
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 1fa8522d33fa..dbb8a955723b 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -216,6 +216,16 @@ typedef struct cxl_device_state {
>      struct cxl_cmd (*cxl_cmd_set)[256];
>      CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
>      CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
> +
> +    /* background command handling (times in ms) */
> +    struct {
> +        uint16_t opcode;
> +        uint16_t complete_pct;
> +        uint64_t starttime;
> +        /* set by each bg cmd, cleared by the bg_timer when complete */
> +        uint64_t runtime;
> +        QEMUTimer *timer;
> +    } bg;
>  } CXLDeviceState;
>  
>  /* Initialize the register block for a device */

