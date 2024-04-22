Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 050371514D6
	for <linux-cxl@vger.kernel.org>; Mon, 22 Apr 2024 15:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713801094; cv=none; b=tBnQp090ohvFJSixMYNCCEvDXgYok3F9SmPvRpKN5teYa4qG/wsClj1SfOZ7npjNeffoGoSgpPmqgz/f/Pu9gRlZx1CcYEhurYEGGa8kMBWvbgU8VIhT6/ogPLAd/ZytX51Vu+ntdEljr0hJXwWpsYA3Hw0oaYCA5p0emNiIgKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713801094; c=relaxed/simple;
	bh=Hr+X/e7xeMGG26NNkyIs051XvFMnjOeA6RaAzH7JOT4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T8asva20AoXxp8pS9rLN893stoerqX3Jyy+T8e4I3GvlK9v8K9pMh9HOte/guSPYSzsCSPb92KtZCiAmULLiMvpS9N3STsfYlgS1dtvCsulfX80XSCwYBn8DEyV2JJ/l4im9uWaw+dxQzfXDpGT8g4W/GiSXEOjBZRbm1hcWdjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4VNV95685Xz6D9BC;
	Mon, 22 Apr 2024 23:51:21 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id C4D4B140AB8;
	Mon, 22 Apr 2024 23:51:27 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 22 Apr
 2024 16:51:27 +0100
Date: Mon, 22 Apr 2024 16:51:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Davidlohr Bueso <dave@stgolabs.net>
CC: <vishal.l.verma@intel.com>, <fan.ni@samsung.com>,
	<a.manzanares@samsung.com>, <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Message-ID: <20240422165126.00006567@Huawei.com>
In-Reply-To: <20240205172942.13343-1-dave@stgolabs.net>
References: <20240205172942.13343-1-dave@stgolabs.net>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon,  5 Feb 2024 09:29:42 -0800
Davidlohr Bueso <dave@stgolabs.net> wrote:

> Implement transfer and activate functionality per 3.1 spec for
> supporting update metadata (no actual buffers). Transfer times
> are arbitrarily set to ten and two seconds for full and part
> transfers, respectively.
>=20
> Testing for both a successful part fw package transfer success
> and abort/cancel cases:
>=20
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
>=20
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
>=20
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
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Hi Davidlohr,

I was going to just pick this up and make the tweaks Fan suggested,
but there are more issues vs the spec that I think should be resolved
first.  If you are busy shout and I'll just make the changes and send
a v3.

Thanks,

Jonathan

> ---
> Changes from v1:
>  - robustify part transfer checking (Jonathan)
>  - implement abort
>  - increase runtime for full transfer
>  - no longer prematurely mark the slot
>  - fold both cmds into a single patch
>=20
>  hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
>  include/hw/cxl/cxl_device.h |  16 +++
>  2 files changed, 228 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 80a80f1ec29b..74054855b1fa 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -60,6 +60,8 @@ enum {
>          #define SET_INTERRUPT_POLICY   0x3
>      FIRMWARE_UPDATE =3D 0x02,
>          #define GET_INFO      0x0
> +        #define TRANSFER      0x1
> +        #define ACTIVATE      0x2
>      TIMESTAMP   =3D 0x03,
>          #define GET           0x0
>          #define SET           0x1
> @@ -815,6 +817,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct=
 cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> +#define CXL_FW_SLOTS 2
> +#define CXL_FW_SIZE  0x02000000 /* 32 mb */
> +
>  /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
>                                                 uint8_t *payload_in,
> @@ -846,15 +851,204 @@ static CXLRetCode cmd_firmware_update_get_info(con=
st struct cxl_cmd *cmd,
>      fw_info =3D (void *)payload_out;
>      memset(fw_info, 0, sizeof(*fw_info));
> =20
> -    fw_info->slots_supported =3D 2;
> -    fw_info->slot_info =3D BIT(0) | BIT(3);
> -    fw_info->caps =3D 0;
> -    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0"=
);
> +    fw_info->slots_supported =3D CXL_FW_SLOTS;
> +    fw_info->slot_info =3D (cci->fw.active_slot & 0x7) |
> +            ((cci->fw.staged_slot & 0x7) << 3);
> +    fw_info->caps =3D BIT(0);

I'd add a comment on this one for what it is. "Online update supported"
Given this is trivial I amend the patch on my tree.

> +
> +    if (cci->fw.slot[0]) {
> +        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSIO=
N 0");
Hmm. Maybe we should fake something up in the way of an ID that changes as =
fw's are
uploaded.  Maybe as simple as not initiating slot[1] until a firmware has b=
ee
uploaded.  I just want to see this change with an upload.
> +    }
> +    if (cci->fw.slot[1]) {
> +        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSIO=
N 1");
> +    }
> =20
>      *len_out =3D sizeof(*fw_info);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
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
> +        uint8_t caps;

Dropped caps as per Fan's comment.

> +        uint8_t rsvd1[2];
> +        uint32_t offset;
> +        uint8_t rsvd2[0x78];
> +        uint8_t data[];
> +    } QEMU_PACKED *fw_transfer =3D (void *)payload_in;
> +    size_t offset, length;
> +
> +    if (fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_ABORT) {
> +        /*
> +         * At this point there aren't any on-going transfers
> +         * running in the bg - this is serialized before this
> +         * call altogether. Just mark the state machine and
> +         * disregard any other input.
> +         */
> +        cci->fw.transferring =3D false;
> +        return CXL_MBOX_SUCCESS;
> +    }
> +
> +    offset =3D fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
> +    length =3D len - sizeof(*fw_transfer);
> +    if (offset + length > CXL_FW_SIZE) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (cci->fw.transferring) {
> +        if (fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_FULL ||
> +            fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_INIT) {
> +            return CXL_MBOX_FW_XFER_IN_PROGRESS;
> +        }
> +        /*
> +         * Abort partitioned package transfer if over 30 secs
> +         * between parts. As opposed to the explicit ABORT action,
> +         * semantically treat this condition as an error - as
> +         * if a part action were passed without a previous INIT.
> +         */
> +        if (difftime(time(NULL), cci->fw.last_partxfer) > 30.0) {
> +            cci->fw.transferring =3D false;
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +    } else if (fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_CONTINUE ||
> +               fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_END) {
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    /* allow back-to-back retransmission */
> +    if ((offset !=3D cci->fw.prev_offset || length !=3D cci->fw.prev_len=
) &&
> +        (fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_CONTINUE ||
> +         fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_END)) {
> +        /*
> +         * XXX: Linux is happy to send overlapping chunks,
> +         * so just verify no gaps.
> +         */

Does the CXL spec allow overlapping?  I see text about parts being
in order (with an exception for back to band transfer). So I think
we need to reject any overlap and make sure Linux doesn't do it!


The 3rd example in the imp note implies that overlap definitely isn't
allowed.

> +        if (offset > cci->fw.prev_offset + cci->fw.prev_len) {
> +            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
> +        }
> +    }
> +
> +    switch (fw_transfer->action) {
> +    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
> +    case CXL_FW_XFER_ACTION_END:
> +        if (fw_transfer->slot =3D=3D 0 ||
> +            fw_transfer->slot =3D=3D cci->fw.active_slot ||
> +            fw_transfer->slot > CXL_FW_SLOTS) {
> +            return CXL_MBOX_FW_INVALID_SLOT;
> +        }
> +
> +        /* mark the slot used upon bg completion */
> +        break;
> +    case CXL_FW_XFER_ACTION_INIT:
> +        if (offset !=3D 0) {
> +            return CXL_MBOX_INVALID_INPUT;
> +        }
> +
> +        cci->fw.transferring =3D true;
> +        cci->fw.prev_slot =3D fw_transfer->slot;

Why?  This is only valid for Full and End.

> +        cci->fw.prev_offset =3D offset;
> +        cci->fw.prev_len =3D length;
> +        break;
> +    case CXL_FW_XFER_ACTION_CONTINUE:
> +        /* forbid slot interleaving */

=46rom 3.1 spec the slot is only specified in the final transfer.

> +        if (cci->fw.prev_slot !=3D fw_transfer->slot) {
> +            return CXL_MBOX_FW_XFER_IN_PROGRESS;
> +        }
> +
> +        cci->fw.prev_offset =3D offset;
> +        cci->fw.prev_len =3D length;
> +        break;
> +    default:
> +        return CXL_MBOX_INVALID_INPUT;
> +    }
> +
> +    if (fw_transfer->action =3D=3D CXL_FW_XFER_ACTION_FULL) {
> +        cci->bg.runtime =3D 10 * 1000UL;
> +    } else {
> +        cci->bg.runtime =3D 2 * 1000UL;
> +    }
> +    /* keep relevant context for bg completion */
> +    cci->fw.curr_action =3D fw_transfer->action;
> +    cci->fw.curr_slot =3D fw_transfer->slot;
> +    *len_out =3D 0;
> +
> +    return CXL_MBOX_BG_STARTED;
> +}
> +
> +static void __do_firmware_xfer(CXLCCI *cci)
> +{
> +    switch (cci->fw.curr_action) {
> +    case CXL_FW_XFER_ACTION_FULL:
> +    case CXL_FW_XFER_ACTION_END:
> +        cci->fw.slot[cci->fw.curr_slot - 1] =3D true;
> +        cci->fw.transferring =3D false;
> +        break;

return early would be my preference.

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
> +    } QEMU_PACKED *fw_activate =3D (void *)payload_in;
> +
> +    if (fw_activate->slot =3D=3D 0 ||
> +        fw_activate->slot =3D=3D cci->fw.active_slot ||

Whilst I don't see spec text on this case, I can't see a request
for clarification resulting in an errata for this given it's
nonsense to do it so software shouldn't care if this is an error
return or a noop 'sure I'll set the firmware to the firmware I'm
running - it'll be really quick!'.

> +        fw_activate->slot > CXL_FW_SLOTS) {
> +        return CXL_MBOX_FW_INVALID_SLOT;
> +    }
> +
> +    /*
> +     * XXX: Check that an actual fw package is there - spec
> +     * does not mention this case.
Obviously and error, so I guess you mean which one?
Between this an Invalid Input.=20

Given it's an error case software shouldn't hit anyway another
one where an errata is unlikely.  Maybe worth asking the question
however..

> +     */
> +    if (!cci->fw.slot[fw_activate->slot - 1]) {
> +        return CXL_MBOX_FW_INVALID_SLOT;
> +    }
> +
> +    switch (fw_activate->action) {
> +    case 0: /* online */
> +        cci->fw.active_slot =3D fw_activate->slot;
> +        break;
> +    case 1: /* reset */
> +        cci->fw.staged_slot =3D fw_activate->slot;
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
> @@ -2160,6 +2354,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>                                        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHAN=
GE },
>      [FIRMWARE_UPDATE][GET_INFO] =3D { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
> +    [FIRMWARE_UPDATE][TRANSFER] =3D { "FIRMWARE_UPDATE_TRANSFER",
> +        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION =
},
> +    [FIRMWARE_UPDATE][ACTIVATE] =3D { "FIRMWARE_UPDATE_ACTIVATE",
> +        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
>      [TIMESTAMP][GET] =3D { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] =3D { "TIMESTAMP_SET", cmd_timestamp_set,
>                           8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
> @@ -2275,7 +2473,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t se=
t, uint8_t cmd,
>              h =3D=3D cmd_media_get_poison_list ||
>              h =3D=3D cmd_media_inject_poison ||
>              h =3D=3D cmd_media_clear_poison ||
> -            h =3D=3D cmd_sanitize_overwrite) {
> +            h =3D=3D cmd_sanitize_overwrite ||
> +            h =3D=3D cmd_firmware_update_transfer ||
> +            h =3D=3D cmd_firmware_update_activate) {

This clashed with an updated fix in my tree to avoid accessing
fields that don't exist on non type 3 CCIs (Switch-cci etC).

The overall check is currently using state in the type3 device
structure.  Ultimately we should make this work for switches
as well but that can be a job for another day.

>              return CXL_MBOX_MEDIA_DISABLED;
>          }
>      }
> @@ -2319,6 +2519,9 @@ static void bg_timercb(void *opaque)
>          cci->bg.complete_pct =3D 100;
>          cci->bg.ret_code =3D ret;
>          switch (cci->bg.opcode) {
> +        case 0x0201: /* fw transfer */
> +            __do_firmware_xfer(cci);
> +            break;
>          case 0x4400: /* sanitize */
>          {
>              CXLType3Dev *ct3d =3D CXL_TYPE3(cci->d);
> @@ -2390,6 +2593,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
>      cci->bg.runtime =3D 0;
>      cci->bg.timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
>                                   bg_timercb, cci);
> +
> +    memset(&cci->fw, 0, sizeof(cci->fw));
> +    cci->fw.active_slot =3D cci->fw.staged_slot =3D 1;

Why not set staged_slot to 0 on init?

"If 0, no FW is currently staged for activation."

> +    cci->fw.slot[cci->fw.active_slot - 1] =3D true;
>  }
> =20
>  static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cx=
l_cmds)[256])
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
>=20

