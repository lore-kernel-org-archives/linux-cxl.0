Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00879E732FD
	for <linux-cxl@archiver.kernel.org>; Thu, 28 Sep 2023 18:22:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbjI1SWR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 28 Sep 2023 14:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbjI1SWQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 28 Sep 2023 14:22:16 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5615698
        for <linux-cxl@vger.kernel.org>; Thu, 28 Sep 2023 11:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.us; s=s31663417;
 t=1695925300; x=1696530100; i=fan.ni@gmx.us;
 bh=UfOI6vyIRiGBHe7ZCWPGemrwVXXsHLD0DBk4/NEoACY=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HKJdM3tsqeLJGXxT6kOQteNUMXjM559B1zyR94+ukuoe9U3U1XNa3w9kUgRWWGOoQp31n68QBoe
 jbmmYFq/Ny92xPtB12xG/aKkw9/0Op1rE+F3bfJwMAZzzIyjlcQG321gPDGdoQXKi6aJjNuQ/knQw
 hzoD3pWLj612pNhzQeDZPkBXhT1117z2LosmKyf1B8eiffNfOe1VbcGLxKwzWXLS46LnhVJCie6Aa
 IE563mDkPc/EUnXpNPFAlOPL4vT580MxY4oyN3TYLwGNOzb5cJ3A6exbebjnc3LcqJ1slepYoELLA
 QY/ErvXv2O2SYxZUdvmI4sMR7/nry3qLDNRQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from debian ([99.13.228.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MQeA2-1qyWZh0Dbi-00Nlm1; Thu, 28
 Sep 2023 20:21:39 +0200
Date:   Thu, 28 Sep 2023 11:21:31 -0700
From:   Fan Ni <fan.ni@gmx.us>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
        Michael Tsirkin <mst@redhat.com>, linuxarm@huawei.com,
        Fan Ni <fan.ni@samsung.com>,
        Philippe Mathieu-Daud? <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 04/19] hw/cxl/mbox: Generalize the CCI command processing
Message-ID: <ZRXEKxUTwrP_8U0v@debian>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
 <20230925161124.18940-5-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925161124.18940-5-Jonathan.Cameron@huawei.com>
X-Provags-ID: V03:K1:Z697vS6oUizMDH2lC6ZsefviT1+WwjEhiUg5aj9tgUvpW4xhXu2
 f6dNdgSA+DegwvvD12wdmFqBiFpquzmfKJxqhbYKRlODfv/rtBq3cViXt7kh6Majo6MC5rr
 KDmJEUjl/ZG9uC4hUdU2+NdpWG0mzZ1RkIEhXDAUtwZpBs+4UJSMyrOIExcuHE0eozjDYRe
 JMJItK3sf+yGg+CGazX4A==
UI-OutboundReport: notjunk:1;M01:P0:LU/SxjILlNU=;pjNCpyyanKvO1tp3QYnlC+6ueoc
 VLEF6v9HX0ov8waxCwV5iuw2i/T46VM0FaJh3IYwW/C12MeeVlKG0zDHAdG/cwrjuuRemKm7m
 ZOxcQSkYkLDEQvNrp5EwfMYWoQphhF0eUoRtx6Gedn17hYDigZwzAcymnXs8w12fYcqwrKf15
 hnR/Zv2PqHT6b5ucZRMpUI9V/xLoM6NXZTMcnLR/YAEocn+DuKi9pyKwxzNhuGrutoWCrA+tG
 NCSwfHxDTItudQ16eU+SCKLgs1m6hluTt7GjsJ+jVmjNMfg05Nv8aZ2AeZIwvKKWeFrJm7ENt
 dINgj5v5WJ/1vaFRh2wVXvpWX478hF8pH6Qscumeo8yjGm/ISqgUAfYQva+iVEiIe7Cnw8tRo
 5BMD94vVCHnBhZHMmhTKQ6dEetNc1JlqQVlbYNMgEYeVUllN6xSF7Ebdif0bB63bn1LNy60zL
 wnm0uWSaWy30oPBCe/F7ph37nyO/wLI2eRU9FhqRdqhQNpqLMDCtkfWQaFQusOs+Dh6HOLxWZ
 ThG+2Tyx/o3YyrdPhcHO8GkefbHUa0y3ss3UHT1Cs7cjjES4Dw3fseXpToizKNmpdYX50u2w7
 s2fXNLuv2ldGiv4/OdKgiXqF3tjeKb2vz1gGw/nCSTMBXUMRdsVOmtmwmZVs2I1cNejI1wdhM
 LOc9Cse2elyIojfAOPL5Hq74bnesKgsV6jKAAKDpN64yZ9la3nNMv22TuukjrYeoGQ08R5rV3
 NPqpNX8FrPGThJYY0CACJHDPCpEitPrGBPBWKgiSHapDssO6kt12Gb5cH4cZEBP8Kij/4dDDm
 vX5CUiR3EqyscQMGzfuyAnFYI+Gy4GeYJVecdmYtRWP/myBg3dQPwDWhx/fLui4s4h/bSg4gq
 x43jQ1ab4PsJtk2kagUc0HNNFTVVAloSGgwqgQQsJlYfKWfTBwTGF/ECsFc7ZfUGZCyW21aJb
 PPVlUzwQ+vy6G/AvVoinHqv1kFg=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 05:11:09PM +0100, Jonathan Cameron wrote:
> By moving the parts of the mailbox command handling that are CCI type
> specific out to the caller, make the main handling code generic. Rename =
it
> to cxl_process_cci_message() to reflect this new generality.
>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_device.h |  5 +++-
>  hw/cxl/cxl-device-utils.c   | 51 ++++++++++++++++++++++++++++++++++++-
>  hw/cxl/cxl-mailbox-utils.c  | 43 ++++++++-----------------------
>  3 files changed, 64 insertions(+), 35 deletions(-)
>
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index c883d9dd8f..0e3f6c3c0b 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -270,7 +270,10 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE=
,
>
>  void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payl=
oad_max);
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max);
> -void cxl_process_mailbox(CXLCCI *cci);
> +int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> +                            size_t len_in, uint8_t *pl_in,
> +                            size_t *len_out, uint8_t *pl_out,
> +                            bool *bg_started);
>
>  #define cxl_device_cap_init(dstate, reg, cap_id, ver)                  =
    \
>      do {                                                               =
    \
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 327949a805..f3a6e17154 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -79,6 +79,25 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr=
 offset, unsigned size)
>      case 4:
>          return cxl_dstate->mbox_reg_state32[offset / size];
>      case 8:
> +        if (offset =3D=3D A_CXL_DEV_BG_CMD_STS) {
> +            uint64_t bg_status_reg;
> +            bg_status_reg =3D FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP,
> +                                       cci->bg.opcode);
> +            bg_status_reg =3D FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_=
STS,
> +                                       PERCENTAGE_COMP, cci->bg.complet=
e_pct);
> +            bg_status_reg =3D FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_=
STS,
> +                                       RET_CODE, cci->bg.ret_code);
> +            /* endian? */
> +            cxl_dstate->mbox_reg_state64[offset / size] =3D bg_status_r=
eg;
> +        }
> +        if (offset =3D=3D A_CXL_DEV_MAILBOX_STS) {
> +            uint64_t status_reg =3D cxl_dstate->mbox_reg_state64[offset=
 / size];
> +            if (cci->bg.complete_pct) {
> +                status_reg =3D FIELD_DP64(status_reg, CXL_DEV_MAILBOX_S=
TS, BG_OP,
> +                                        0);
> +                cxl_dstate->mbox_reg_state64[offset / size] =3D status_=
reg;
> +            }
> +        }
>          return cxl_dstate->mbox_reg_state64[offset / size];
>      default:
>          g_assert_not_reached();
> @@ -157,7 +176,37 @@ static void mailbox_reg_write(void *opaque, hwaddr =
offset, uint64_t value,
>
>      if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_=
CTRL,
>                           DOORBELL)) {
> -        cxl_process_mailbox(cci);
> +        uint64_t command_reg =3D
> +            cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
> +        uint8_t cmd_set =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD=
,
> +                                     COMMAND_SET);
> +        uint8_t cmd =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, CO=
MMAND);
> +        size_t len_in =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, =
LENGTH);
> +        uint8_t *pl =3D cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYL=
OAD;
> +        size_t len_out;
> +        uint64_t status_reg;
> +        bool bg_started;
> +        int rc;
> +
> +        rc =3D cxl_process_cci_message(cci, cmd_set, cmd, len_in, pl,
> +                                     &len_out, pl, &bg_started);
> +
> +        /* Set bg and the return code */
> +        status_reg =3D FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP,
> +                                bg_started ? 1 : 0);
> +        status_reg =3D FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRN=
O, rc);
> +        /* Set the return length */
> +        command_reg =3D FIELD_DP64(0, CXL_DEV_MAILBOX_CMD, COMMAND_SET,=
 cmd_set);
> +        command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
> +                                 COMMAND, cmd);
> +        command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD,
> +                                 LENGTH, len_out);
> +
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] =3D command=
_reg;
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] =3D status_=
reg;
> +        /* Tell the host we're done */
> +        ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_=
CTRL,
> +                         DOORBELL, 0);
>      }
>  }
>
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 376367c118..239acc659d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -754,50 +754,27 @@ static const struct cxl_cmd cxl_cmd_set[256][256] =
=3D {
>          cmd_media_clear_poison, 72, 0 },
>  };
>
> -void cxl_process_mailbox(CXLCCI *cci)
> +int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
> +                            size_t len_in, uint8_t *pl_in, size_t *len_=
out,
> +                            uint8_t *pl_out, bool *bg_started)
>  {
> -    uint16_t ret =3D CXL_MBOX_SUCCESS;
>      const struct cxl_cmd *cxl_cmd;
> -    uint64_t status_reg =3D 0;
>      opcode_handler h;
> -    CXLDeviceState *cxl_dstate =3D &CXL_TYPE3(cci->d)->cxl_dstate;
> -    uint64_t command_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAI=
LBOX_CMD];
> -
> -    uint8_t set =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAN=
D_SET);
> -    uint8_t cmd =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAN=
D);
> -    uint16_t len_in =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LE=
NGTH);
> -    uint8_t *pl =3D cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> -    size_t len_out =3D 0;
>
> +    *len_out =3D 0;
>      cxl_cmd =3D &cci->cxl_cmd_set[set][cmd];
>      h =3D cxl_cmd->handler;
> -    if (h) {
> -        if (len_in =3D=3D cxl_cmd->in || cxl_cmd->in =3D=3D ~0) {
> -            ret =3D (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
> -            assert(len_out <=3D cci->payload_max);
> -        } else {
> -            ret =3D CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> -        }
> -    } else {
> +    if (!h) {
>          qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
>                        set << 8 | cmd);
> -        ret =3D CXL_MBOX_UNSUPPORTED;
> +        return CXL_MBOX_UNSUPPORTED;
>      }
>
> -    /* Set the return code */
> -    status_reg =3D FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
> -
> -    /* Set the return length */
> -    command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAN=
D_SET, 0);
> -    command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAN=
D, 0);
> -    command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH=
, len_out);
> -
> -    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] =3D command_reg=
;
> -    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] =3D status_reg;
> +    if (len_in !=3D cxl_cmd->in && cxl_cmd->in !=3D ~0) {
> +        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> +    }
>
> -    /* Tell the host we're done */
> -    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL=
,
> -                     DOORBELL, 0);
> +    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
>  }
>
>  void cxl_init_cci(CXLCCI *cci, size_t payload_max)
> --
> 2.39.2
>
