Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537051D54D
	for <linux-cxl@vger.kernel.org>; Fri, 26 Jan 2024 15:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706283751; cv=none; b=ALsr9gevogMcdjUUcEqDBtBIgfHMTdvyEwHdqw6Jw/xdc5yrcM/ovjNTB91kdLYaUIZwRJQ9uapxcxcu9B0IiZbNEwYflFoj3pTGSYAjII+E+R/0aeqjqIKUCMM8dImmK6nw5NjVp/DYmZ3MEKq4ToZs55HE00wDyvc1/ESfMdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706283751; c=relaxed/simple;
	bh=VZtYS/vu5U/lBOH/P/hb3mhl+/bfgOTG1sRIB2iz2Es=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KcUwAg+u/kiUOYhAJa3Rqkweas8VOYnLpUJiXv/2+hIyN1NQKLTGO+mnwQBMDGXtB26LRtXb2VpU7j/pQc8ZHiK1VSr1QWwr/B8k1L9q8UAsdNEG41oZY6i24O+Y7QookSVvcCxXYtNz5dnsHA17UQ/hIYjdgsQUt5gVlcgzVV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TM21n26t3z6K6DL;
	Fri, 26 Jan 2024 23:39:41 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 29B92140516;
	Fri, 26 Jan 2024 23:42:22 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Fri, 26 Jan
 2024 15:42:21 +0000
Date: Fri, 26 Jan 2024 15:42:20 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <mounika.k@samsung.com>,
	<linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/2] hw/cxl: Add Transfer FW support
Message-ID: <20240126154220.00002797@Huawei.com>
In-Reply-To: <20240109070436.21253-2-dave@stgolabs.net>
References: <20240109070436.21253-1-dave@stgolabs.net>
	<20240109070436.21253-2-dave@stgolabs.net>
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
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  8 Jan 2024 23:04:35 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Per the latest 3.1 spec for supporting firmware update metadata
> (no actual buffers). Aborting a xfer is currently unsupported
> through a nop.
> 
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr.

Whilst we may never notice from the OS as we expect it to send valid
sets of transfers only, I'd like the emulation to incorporate more
of the validity checks the spec requires such as:
- Multiple part transfers must all be for same slot - any interleaved
  ones for other slots result in error.
- Retry of previous transfer or one that starts where previous transfer
  ended - otherwise Out of Order detected.

So we have to hold state, and as such will have the information to
set the slot as occupied with just one extra flag stored to say it is
a FULL or END message.

Otherwise lgtm.

Thanks,

Jonathan


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

Only support 2 slots... So could skip these 2.

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
Need to return this also if the slot number is different from
an earlier transfer.

> +    }
> +
> +    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;

If not INIT or FULL, we need to stash the end of previous
transfer and make sure this comes next as otherwise should
return FW Transfer Out of Order.
For extra fun we also need to stash the previous transfer
parameters to allow for 'Back-to-back retransmission of any FW
package part is permitted during a transfer.' in 8.2.9.3.2 or r3.1

So minimum needed across multiple calls is length + end address of
previous transfer (so we can find the start or the end).


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
> +            return CXL_MBOX_FW_INVALID_SLOT;
> +        }
> +        /*
> +         * Optimistically mark the slot used now (as opposed
> +         * to at the end of the successful transfer). That
> +         * way we don't need to keep command context.

Hmm. I doubt the OS will even notice this, but it's not ideal.
Given for ordering checks we have to store a bunch of stuff
is it really that bad to store the slot as well?

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

