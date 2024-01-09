Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4B93E462
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 22:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7ckwTcS"
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dbed788aad4so2586758276.3
        for <linux-cxl@vger.kernel.org>; Tue, 09 Jan 2024 14:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704839833; x=1705444633; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ilGp1Nj7YreKplY3xvWz50y04Y0ON1mWt/F1RjJED10=;
        b=B7ckwTcScrrRKG5kqv478JA0PeQW9HKSzdLRBkWr0KSgJeUDlhwHP3CI9ywtd/ZKRX
         yBop/774DvQaBkxuCl1on+515rFhH4/0cTNFeac4BNHr+x3awD/PeUf5Cxi72GUmu9A/
         3UmmeBT0c9Ux9CE0nEXfFT5rPDrd3LgXPVmrHcP93b928Xt7oaDOSVV8NZS0SVeQOjv0
         pva4dm4IN7gv9hGpzbvveXeidP8U9yeTD8gacmckur6oEY+umGLmms2+Ct4H97B9c7OY
         tRz9BJbzr3GNFwFOHA36kJw2RJ5Sf+e5/W9+G5HntlB1F4BZczdips6zliRuHpo+cF5y
         T9dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704839833; x=1705444633;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ilGp1Nj7YreKplY3xvWz50y04Y0ON1mWt/F1RjJED10=;
        b=J2zYrR1A2Mgya6b3hPZOSaYRycE7+4cyMdOJ1josG04KsiHB5BCOT4Y5s87O900kc7
         EGzkeptHnOZLpw++vrsTzmdaHQwvxkoYtCA/AQX1vgCh7YEUa4QlyLsQfnc0/wFHysF9
         ueDidWOBilFe689JfKq58OYk6k9F9F4NlSvH0fj4yRbjOzJUmanG5dOcUQa0cxUtxtcL
         Cjhrs53dVY75JnCosG3tga9Q5N7mZEe5jjylDiF/Gs/Gizn/d5rn/ECBguggwSWP5zRW
         Du3Br+5sAIEzabDV4FtyDlyYndAG0ANYCu8DX94f1MPNhEfToOWU3FI5hsHB/4WBAVUF
         05FA==
X-Gm-Message-State: AOJu0YwxwOj09n8PYF96LGaEKprjLdRlluYcV8xac41xUOQw69vhp6fX
	On4tC7o6Y0N4mXF+tTTUle0=
X-Google-Smtp-Source: AGHT+IG4ud6HlNOPxfPKiVZZJNl8OdMbB5oU1pF+UGp/OV5kzdga2j8YoKEH27Bb5pLJ9Nh0DnUqHw==
X-Received: by 2002:a5b:84d:0:b0:dbd:73ec:4c19 with SMTP id v13-20020a5b084d000000b00dbd73ec4c19mr82338ybq.83.1704839833194;
        Tue, 09 Jan 2024 14:37:13 -0800 (PST)
Received: from debian ([50.205.20.42])
        by smtp.gmail.com with ESMTPSA id l4-20020a25bf84000000b00db41482d349sm984318ybk.57.2024.01.09.14.37.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 14:37:12 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Tue, 9 Jan 2024 14:36:57 -0800
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
	fan.ni@samsung.com, a.manzanares@samsung.com, mounika.k@samsung.com,
	linux-cxl@vger.kernel.org
Subject: Re: [PATCH 1/2] hw/cxl: Add Transfer FW support
Message-ID: <ZZ3KiceGpf5RUC5a@debian>
References: <20240109070436.21253-1-dave@stgolabs.net>
 <20240109070436.21253-2-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240109070436.21253-2-dave@stgolabs.net>

On Mon, Jan 08, 2024 at 11:04:35PM -0800, Davidlohr Bueso wrote:
> Per the latest 3.1 spec for supporting firmware update metadata
> (no actual buffers). Aborting a xfer is currently unsupported
> through a nop.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-mailbox-utils.c  | 124 ++++++++++++++++++++++++++++++++++--
>  include/hw/cxl/cxl_device.h |   9 +++
>  2 files changed, 129 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 11ec8b648baf..0295ea8b29aa 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -60,6 +60,7 @@ enum {
>          #define SET_INTERRUPT_POLICY   0x3
>      FIRMWARE_UPDATE = 0x02,
>          #define GET_INFO      0x0
> +        #define TRANSFER      0x1
>      TIMESTAMP   = 0x03,
>          #define GET           0x0
>          #define SET           0x1
> @@ -815,6 +816,8 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> +#define CXL_FW_SLOTS 2
> +
>  /* CXL r3.0 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>                                                 uint8_t *payload_in,
> @@ -846,15 +849,118 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>      fw_info = (void *)payload_out;
>      memset(fw_info, 0, sizeof(*fw_info));
>  
> -    fw_info->slots_supported = 2;
> -    fw_info->slot_info = BIT(0) | BIT(3);
> +    fw_info->slots_supported = CXL_FW_SLOTS;
> +    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
> +            ((cci->fw.staged_slot & 0x7) << 3);
>      fw_info->caps = 0;
> -    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> +
> +    if (cci->fw.slot[0]) {
> +        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
> +    }
> +    if (cci->fw.slot[1]) {
> +        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
> +    }
> +    if (cci->fw.slot[2]) {
> +        pstrcpy(fw_info->fw_rev3, sizeof(fw_info->fw_rev3), "BWFW VERSION 2");
> +    }
> +    if (cci->fw.slot[3]) {
> +        pstrcpy(fw_info->fw_rev4, sizeof(fw_info->fw_rev4), "BWFW VERSION 3");
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
> +#define CXL_FW_SIZE  0x02000000 /* 32 mb */
> +
> +static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
> +                                               uint8_t *payload_in,
> +                                               size_t len,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLCCI *cci)
> +{
> +    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
> +    struct {
> +        uint8_t action;
> +        uint8_t slot;
> +        uint8_t caps;
> +        uint8_t rsvd1[2];
> +        uint32_t offset;
> +        uint8_t rsvd2[0x78];
> +        uint8_t data[];
> +    } QEMU_PACKED *fw_transfer;
> +    size_t offset, length;
> +
> +    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
> +        return CXL_MBOX_INTERNAL_ERROR;
> +    }
> +
> +    fw_transfer = (void *)payload_in;
> +
> +    if (cci->fw.transfering &&
> +        (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
> +         fw_transfer->action == CXL_FW_XFER_ACTION_INIT)) {
> +        return CXL_MBOX_FW_XFER_IN_PROGRESS;
> +    }
> +
> +    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
> +    length = len - sizeof(*fw_transfer);
> +    if (offset + length > CXL_FW_SIZE) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    switch (fw_transfer->action) {
> +    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
> +    case CXL_FW_XFER_ACTION_END:
> +        if (fw_transfer->slot == 0 ||
> +            fw_transfer->slot == cci->fw.active_slot ||
> +            fw_transfer->slot > CXL_FW_SLOTS) {
Should here be >= instead of > ?
> +            return CXL_MBOX_FW_INVALID_SLOT;
> +        }
> +        /*
> +         * Optimistically mark the slot used now (as opposed
> +         * to at the end of the successful transfer). That
> +         * way we don't need to keep command context.
> +         */
> +        cci->fw.slot[fw_transfer->slot - 1] = true;
> +        break;
> +    case CXL_FW_XFER_ACTION_INIT:
> +        if (offset != 0) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +        /* fallthrough */
> +    case CXL_FW_XFER_ACTION_CONTINUE:
> +        break;
> +    case CXL_FW_XFER_ACTION_ABORT: /* nop */
> +        return CXL_MBOX_SUCCESS;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    cci->fw.transfering = true;
> +
> +    cci->bg.runtime = 2 * 1000UL;

How we get this? I see the spec mentioned the timeout between FW package ports
is 30 seconds.

Fan
> +    *len_out = 0;
> +
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
> +static void __do_firmware_xfer(CXLCCI *cci)
> +{
> +    cci->fw.transfering = false;
> +}
> +
>  /* CXL r3.0 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
>  static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
>                                      uint8_t *payload_in,
> @@ -2165,6 +2271,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>                                        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
> +    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
> +        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
>                           8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
> @@ -2278,7 +2386,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>              h == cmd_media_get_poison_list ||
>              h == cmd_media_inject_poison ||
>              h == cmd_media_clear_poison ||
> -            h == cmd_sanitize_overwrite) {
> +            h == cmd_sanitize_overwrite ||
> +            h == cmd_firmware_update_transfer) {
>              return CXL_MBOX_MEDIA_DISABLED;
>          }
>      }
> @@ -2325,6 +2434,9 @@ static void bg_timercb(void *opaque)
>              CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
>  
>              switch (cci->bg.opcode) {
> +            case 0x0201: /* fw transfer */
> +                __do_firmware_xfer(cci);
> +                break;
>              case 0x4400: /* sanitize */
>                  __do_sanitization(ct3d);
>                  cxl_dev_enable_media(&ct3d->cxl_dstate);
> @@ -2388,6 +2500,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>      cci->payload_max = payload_max;
>      cxl_rebuild_cel(cci);
>  
> +    cci->fw.active_slot = cci->fw.staged_slot = 1;
> +    memset(cci->fw.slot, 0, sizeof(cci->fw.slot));
> +    cci->fw.slot[cci->fw.active_slot - 1] = true;
> +
>      cci->bg.complete_pct = 0;
>      cci->bg.starttime = 0;
>      cci->bg.runtime = 0;
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index b2cb280e1631..b4373bfe4d2a 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -201,6 +201,15 @@ typedef struct CXLCCI {
>          uint64_t runtime;
>          QEMUTimer *timer;
>      } bg;
> +
> +    /* firmware update */
> +    struct {
> +        bool transfering;
> +        int active_slot;
> +        int staged_slot;
> +        bool slot[4];
> +    } fw;
> +
>      size_t payload_max;
>      /* Pointer to device hosting the CCI */
>      DeviceState *d;
> -- 
> 2.43.0
> 
