Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D325323772
	for <linux-cxl@vger.kernel.org>; Tue, 19 Mar 2024 17:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710871020; cv=none; b=dZAnziufEnlNeS/ai9IepsQWyNJ8cyFppSD0SOdg+uT3nlQzWCxMIwgYEkgBn+xixSyhqJXb3d+13KRwdiy5EV3aiXKrcfcNe7DQzFwcboESpx4/K75lN560oM5Js7hkZbvZ0eHH70zePKMjRYP3jnw6jObqc1Mw2oUW+2o0e8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710871020; c=relaxed/simple;
	bh=VYknkGiysyYCDOmdTKYdpWWvhOk9DT68PC1OD4YXDFg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lgst6mx1PJvZaG46FkkmkeuOcqMjhxP7to9HPyPNxmYdMg5Z9lhtVOja114ZLXvi5kIyjBlO6Mo0I6T3PeryNw872dRmWygLPYkktbZFvWHrSUdecdM/2IA9Xu5ATypYH9US0ohx3e/xTH2b+EGkBmqALZS/4yg0Z4xKrR0I0vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1RAoUo+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1RAoUo+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1def142ae7bso40151995ad.3
        for <linux-cxl@vger.kernel.org>; Tue, 19 Mar 2024 10:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710871018; x=1711475818; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vk3v0kywgwvVWbnwjzmM/7bIcMHSQ4i8ACXVfX0xqE8=;
        b=F1RAoUo+5i8JVAKWOgGhNQTl6P1ewISlqfDdYEGfpRVOi23H+mSOzEjiqJHAq/z7yi
         AcTJO7UiNJ9+gaJQwrDCayeOE7qGUITL4zZjxnazA9UvQk2embRKH+3jbPiCOgyrYGEp
         kxPjao78Kgzv2I2RZbpiZ48NfWuSH7m9cyVWqpgYu7RYytSmLHUfaTzGj2wG17NurvEZ
         pnVcD21zr7jOVesvtLKuZwD1CnRCjacARXmGLhErYhxPBLdQREornWvkbcaEQ5Z5zbv7
         J4oFU5RT+Rb0Je9xd/GR/HtwogM252mzJ6Ca0i7oUZ4G/52RpDyV4RDPB3lAVMNUbvxx
         Y/0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710871018; x=1711475818;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vk3v0kywgwvVWbnwjzmM/7bIcMHSQ4i8ACXVfX0xqE8=;
        b=mu4bfcT52xzv7jhScLKUShaxAcxaNuBPDHGO/qX8EVetEJLvwqUMoNbwefS/knxHXJ
         J+BHSvGgRhi3cEFN8tVSG9/oRJRdaHxYvYWlMKyuWFbInAha1cmqag3rkvcFb07/0zVd
         1DL99H/+tU4x3F942roM3cuNpQqeOswUZ3U95mK6RD0hrxKlubZi4Q3Wtm5h4nD8Zs4y
         2E3O+46MmW+SPTndgmOrvQGargvcgfU2g8yZAwROu2bXRhovPvbURzxQDd4ZYagkvL9Z
         zGfyzkYX2j423XYAvFX/ZI8IIjBiesvPIN2oicYC1O3CJQ+hPb1lsnT6oPAK7k90c/YX
         uRKQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQh2lqZv9QXYPMqgSXy5cfsnDhnaujdkHM394/FVaBYbxrfwo6XGv/K1b63ZtPlVEBQss0RxJPOW/3UOZ20qnIL1x85iwdxxzS
X-Gm-Message-State: AOJu0YzLtEMOFQvpHAr0MmhFA9GRtwzbPxKndRy3EoBO/1aSvYhiOw/M
	sPLzv72XTw62f5a1Fe1b3e3SL3a/sx6H5wDmzRER+B4iWuB++GgjSWIbBwXI
X-Google-Smtp-Source: AGHT+IHHysP2gQSg5CwUkv90xd7nbgfQ7uYyUuj9kfnP2lAdfunRH/P4QNxeXj4LtGRiJFSQXW3I0g==
X-Received: by 2002:a17:902:f54a:b0:1de:e128:e8bb with SMTP id h10-20020a170902f54a00b001dee128e8bbmr18021571plf.53.1710871017917;
        Tue, 19 Mar 2024 10:56:57 -0700 (PDT)
Received: from debian ([2601:641:300:14de:5e6e:89c3:f72f:6138])
        by smtp.gmail.com with ESMTPSA id ki3-20020a170903068300b001dd02f4c2casm11754549plb.164.2024.03.19.10.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 10:56:57 -0700 (PDT)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 19 Mar 2024 10:56:38 -0700
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: jonathan.cameron@huawei.com, vishal.l.verma@intel.com,
	fan.ni@samsung.com, a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Message-ID: <ZfnR1jTLG_e5KCIE@debian>
References: <20240205172942.13343-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240205172942.13343-1-dave@stgolabs.net>

On Mon, Feb 05, 2024 at 09:29:42AM -0800, Davidlohr Bueso wrote:
> Implement transfer and activate functionality per 3.1 spec for
> supporting update metadata (no actual buffers). Transfer times
> are arbitrarily set to ten and two seconds for full and part
> transfers, respectively.
> 
> Testing for both a successful part fw package transfer success
> and abort/cancel cases:
> 
> // on-going partial xfer
> {
>   "firmware":{
>     "num_slots":2,
>     "active_slot":1,
>     "staged_slot":1,
>     "online_activate_capable":true,
>     "slot_1_version":"BWFW VERSION 0",
>     "fw_update_in_progress":true,
>     "remaining_size":1280
>   }
> }
> 
> // xfer complete
> {
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
> // on-going (new) partial xfer
> {
>   "firmware":{
>     "num_slots":2,
>     "active_slot":1,
>     "staged_slot":1,
>     "online_activate_capable":true,
>     "slot_1_version":"BWFW VERSION 0",
>     "fw_update_in_progress":false
>   }
> }
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
Hi David,

Some minor comments inlined.

> Changes from v1:
>  - robustify part transfer checking (Jonathan)
>  - implement abort
>  - increase runtime for full transfer
>  - no longer prematurely mark the slot
>  - fold both cmds into a single patch
> 
>  hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
>  include/hw/cxl/cxl_device.h |  16 +++
>  2 files changed, 228 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 80a80f1ec29b..74054855b1fa 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -60,6 +60,8 @@ enum {
>          #define SET_INTERRUPT_POLICY   0x3
>      FIRMWARE_UPDATE = 0x02,
>          #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
>      TIMESTAMP   = 0x03,
>          #define GET           0x0
>          #define SET           0x1
> @@ -815,6 +817,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +#define CXL_FW_SLOTS 2
> +#define CXL_FW_SIZE  0x02000000 /* 32 mb */
> +
>  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>                                                 uint8_t *payload_in,
> @@ -846,15 +851,204 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>      fw_info = (void *)payload_out;
>      memset(fw_info, 0, sizeof(*fw_info));
>  
> -    fw_info->slots_supported = 2;
> -    fw_info->slot_info = BIT(0) | BIT(3);
> -    fw_info->caps = 0;
> -    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> +    fw_info->slots_supported = CXL_FW_SLOTS;
> +    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
> +            ((cci->fw.staged_slot & 0x7) << 3);
> +    fw_info->caps = BIT(0);
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

The above definitions have "tab" used, cannot pass checkpatch check.

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
> +        uint8_t caps;

Based on table 8-66, I cannot find the field "caps" and it is unused.

Fan

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
> +        /*
> +         * XXX: Linux is happy to send overlapping chunks,
> +         * so just verify no gaps.
> +         */
> +        if (offset > cci->fw.prev_offset + cci->fw.prev_len) {
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
> +        cci->fw.prev_slot = fw_transfer->slot;
> +        cci->fw.prev_offset = offset;
> +        cci->fw.prev_len = length;
> +        break;
> +    case CXL_FW_XFER_ACTION_CONTINUE:
> +        /* forbid slot interleaving */
> +        if (cci->fw.prev_slot != fw_transfer->slot) {
> +            return CXL_MBOX_FW_XFER_IN_PROGRESS;
> +        }
> +
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
> +
> +    if (fw_activate->slot == 0 ||
> +        fw_activate->slot == cci->fw.active_slot ||
> +        fw_activate->slot > CXL_FW_SLOTS) {
> +        return CXL_MBOX_FW_INVALID_SLOT;
> +    }
> +
> +    /*
> +     * XXX: Check that an actual fw package is there - spec
> +     * does not mention this case.
> +     */
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
> @@ -2160,6 +2354,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
> @@ -2275,7 +2473,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>              h == cmd_media_get_poison_list ||
>              h == cmd_media_inject_poison ||
>              h == cmd_media_clear_poison ||
> -            h == cmd_sanitize_overwrite) {
> +            h == cmd_sanitize_overwrite ||
> +            h == cmd_firmware_update_transfer ||
> +            h == cmd_firmware_update_activate) {
>              return CXL_MBOX_MEDIA_DISABLED;
>          }
>      }
> @@ -2319,6 +2519,9 @@ static void bg_timercb(void *opaque)
>          cci->bg.complete_pct = 100;
>          cci->bg.ret_code = ret;
>          switch (cci->bg.opcode) {
> +        case 0x0201: /* fw transfer */
> +            __do_firmware_xfer(cci);
> +            break;
>          case 0x4400: /* sanitize */
>          {
>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> @@ -2390,6 +2593,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>      cci->bg.runtime = 0;
>      cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                   bg_timercb, cci);
> +
> +    memset(&cci->fw, 0, sizeof(cci->fw));
> +    cci->fw.active_slot = cci->fw.staged_slot = 1;
> +    cci->fw.slot[cci->fw.active_slot - 1] = true;
>  }
>  
>  static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index d38391b26f0e..8c17ba9d2131 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -203,7 +203,22 @@ typedef struct CXLCCI {
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
> +        uint8_t prev_slot;
> +        size_t prev_offset;
> +        size_t prev_len;
> +        time_t last_partxfer;
> +    } fw;
> +
>      size_t payload_max;
>      /* Pointer to device hosting the CCI */
>      DeviceState *d;
> --
> 2.43.0
> 
