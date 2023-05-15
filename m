Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9D20C77B7D
	for <linux-cxl@archiver.kernel.org>; Mon, 15 May 2023 12:32:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241863AbjEOMc5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 15 May 2023 08:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241865AbjEOMcm (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 15 May 2023 08:32:42 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B73FB1BCC
        for <linux-cxl@vger.kernel.org>; Mon, 15 May 2023 05:32:39 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4QKdvK57CJz6J6lS;
        Mon, 15 May 2023 20:28:29 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 13:32:36 +0100
Date:   Mon, 15 May 2023 13:32:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     <dan.j.williams@intel.com>, <fan.ni@samsung.com>,
        <a.manzanares@samsung.com>, <dave.jiang@intel.com>,
        <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/5] cxl/mbox: Add support for background operations
Message-ID: <20230515133236.000000bb@Huawei.com>
In-Reply-To: <20230418172337.19207-2-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
        <20230418172337.19207-2-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, 18 Apr 2023 10:23:33 -0700
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Support background commands in the mailbox, and while at it update
> cmd_infostat_bg_op_sts() accordingly. This patch does not implement
> mbox interrupts upon completion, so the kernel driver must rely on
> polling to know when the operation is done.

> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>

I've (mostly) ignored the endian fun in reviewing this as it's not making it any
worse and I should really just do a blanket fix of remaining code.

> ---
>  hw/cxl/cxl-device-utils.c   |  5 +-
>  hw/cxl/cxl-mailbox-utils.c  | 95 ++++++++++++++++++++++++++++++++++++-
>  hw/mem/cxl_type3.c          |  2 +
>  include/hw/cxl/cxl_device.h | 10 ++++
>  4 files changed, 107 insertions(+), 5 deletions(-)
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

It's a read only register. So why allow it to be written?  More than likely
I'm forgetting how this works.

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
> index b02908c4a4ba..1a4480d42908 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c

...
> +/*
> + * While the command is executing in the background, the device should
> + * update the percentage complete in the Background Command Status Register
> + * at least once per second.
> + */
> +#define CXL_MBOX_BG_UPDATE_FREQ 1000ULL
> +
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  {
>      uint16_t ret = CXL_MBOX_SUCCESS;
>      struct cxl_cmd *cxl_cmd;
>      uint64_t status_reg;
>      opcode_handler h;
> +    uint8_t bg_started = 0;
>      uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
>  
>      uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
> @@ -873,7 +889,17 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
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
> @@ -884,8 +910,13 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>          ret = CXL_MBOX_UNSUPPORTED;
>      }
>  
> -    /* Set the return code */
> +done:
> +    /* Set the return code and background status */
>      status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
> +    if (bg_started) {
> +        status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS,
> +                                BG_OP, bg_started);

Isn't this a noop if bg_started == 0 in which case, no real point in
making it conditional on if (bg_started)? 

> +    }
>  
>      /* Set the return length */
>      command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
> @@ -895,11 +926,66 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
>  
> +    if (bg_started) {
> +        uint64_t bg_status_reg, now;
> +
> +        cxl_dstate->bg.opcode = (set << 8) | cmd;
> +
> +        bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP, cxl_dstate->bg.opcode);

Line wraps a bit to variable. I'd split the one above.

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

So far at least, this is only used in this function. So local variable?

> +        /* clear bg */
> +        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
> +
> +        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
> +
> +        /* TODO add ad-hoc cmd succesful completion handling */

What does that mean?  Short cutting the timing for some commands?

> +    } else {
> +        /* estimate only */
> +        cxl_dstate->bg.complete_pct = 100 * now / total_time;
> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> +    }
> +
> +    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP,
> +                               cxl_dstate->bg.complete_pct);
> +    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;

Shouldn't be doing this directly as not handling big endian hosts etc.

> +
> +    if (cxl_dstate->bg.complete_pct == 100) {
> +        cxl_dstate->bg.starttime = 0;
> +        /* registers are updated, allow new bg-capable cmds */
> +        cxl_dstate->bg.runtime = 0;
> +    }
> +}
> +
>  void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>  {
>      if (!switch_cci) {
> @@ -920,4 +1006,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>              }
>          }
>      }
> +    cxl_dstate->bg.complete_pct = 0;
> +    cxl_dstate->bg.starttime = 0;
> +    cxl_dstate->bg.runtime = 0;
> +    cxl_dstate->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
> +                                        bg_timercb, cxl_dstate);
>  }
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 334ce92f5e0f..63c28a1ed5d2 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -870,12 +870,14 @@ static void ct3_exit(PCIDevice *pci_dev)
>  {
>      CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
>      CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
> +    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
>      ComponentRegisters *regs = &cxl_cstate->crb;
>  
>      pcie_aer_exit(pci_dev);
>      cxl_doe_cdat_release(cxl_cstate);
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
> +    timer_free(cxl_dstate->bg.timer);
>      if (ct3d->hostpmem) {
>          address_space_destroy(&ct3d->hostpmem_as);
>      }
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

Trivial but I'm a fan of naming variables so you can tell units without
relying on comments.

> +    struct {
> +        uint16_t opcode;
> +        uint16_t complete_pct;
> +        uint64_t starttime;
starttime_ms
> +        /* set by each bg cmd, cleared by the bg_timer when complete */
> +        uint64_t runtime;
runtime_ms

> +        QEMUTimer *timer;
> +    } bg;
>  } CXLDeviceState;
>  
>  /* Initialize the register block for a device */

