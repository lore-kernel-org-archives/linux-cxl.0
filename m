Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 640DCC6FA9D
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 19:01:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjCATBD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 14:01:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjCATBC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 14:01:02 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E28DC42BC4
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 11:00:58 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230301190056usoutp029e096d10280df2d62998aa2d20bf5f48~IYMQDqH-r1733017330usoutp02b;
        Wed,  1 Mar 2023 19:00:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230301190056usoutp029e096d10280df2d62998aa2d20bf5f48~IYMQDqH-r1733017330usoutp02b
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677697256;
        bh=hXZSUGuqyAQ+4HohbFQK93qzf/u5DDzV2MTjHeMsDDI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lds9n6i4Gt4kKSLkRQ2LDlEL20POJzzfRjUZfiNv7Joq2wUnm/04MdrCw3oneD94P
         BPPTmHzmyfUM9FgZKqe0e9xFFHZTq3uRMhn1EaRTv5vZyPhCfqxj2/iIhK3OejQ4Jx
         pCZNtoTvXquosoUnYkf2A1B/5x0cu59wKczuRbvU=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230301190056uscas1p29c0422d3cc90aaf8402db1bd1d3e903b~IYMP935iA0490304903uscas1p2O;
        Wed,  1 Mar 2023 19:00:56 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id F6.19.06976.7E0AFF36; Wed, 
        1 Mar 2023 14:00:55 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230301190055uscas1p1e774178c46cd229012fe942589cb3448~IYMPlPdHO1191011910uscas1p1F;
        Wed,  1 Mar 2023 19:00:55 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-df-63ffa0e7f543
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 8E.E9.11346.7E0AFF36; Wed, 
        1 Mar 2023 14:00:55 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 1 Mar 2023 11:00:54 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        1 Mar 2023 11:00:54 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: [PATCH 1/3] cxl/mbox: Add support for background operations
Thread-Topic: [PATCH 1/3] cxl/mbox: Add support for background operations
Thread-Index: AQHZSIiDmGie97vcfkSrQS6DlQwt1q7m1VIA
Date:   Wed, 1 Mar 2023 19:00:54 +0000
Message-ID: <20230301190047.GA1421354@bgt-140510-bm03>
In-Reply-To: <20230224194443.1990440-2-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3214757FAC06E74ABD29194516995043@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprBKsWRmVeSWpSXmKPExsWy7djXc7rPF/xPNmh9Y2UxfeoFRovVN9cw
        Wux/+pzFYtXCa2wW52edYnFg9Wg58pbVY/Gel0weU2fXe3zeJBfAEsVlk5Kak1mWWqRvl8CV
        sfTpWpaCdb4Vx/5XNTDusOxi5OSQEDCRmNL3mLGLkYtDSGAlo8TCteuYQRJCAq1MEvdnB8MU
        /Z72kh2iaC2jxJvZB9ggnI+MEs8+vWeD6FjKKDFrnzqIzSagKLGvaztYXERAXWLe2ttgK5gF
        +pgkdn7vYAdJCAt4SMw5P4UZoshToufpRCYI20ii9e59sGYWARWJC//nAzVzcPAKmEl8+5wG
        EuYUsJS4dO8eC4jNKCAm8f3UGrBWZgFxiVtP5jNBXC0osWj2HmYIW0zi366HbBC2osT97y/Z
        Iep1JBbs/sQGYdtJNB+dyghha0ssW/garJcXaM7JmU9YIHolJQ6uuMEC8ouEwBEOiXfdV5lA
        bpMQcJGY2hQFUSMtMX3NZRaIcLLEqo9cEOEciflLtkCNsZZY+Gc90wRGlVlIrp6F5KJZSC6a
        heSiWUguWsDIuopRvLS4ODc9tdgwL7Vcrzgxt7g0L10vOT93EyMw8Zz+dzh3B+OOWx/1DjEy
        cTAeYpTgYFYS4V14+0+yEG9KYmVValF+fFFpTmrxIUZpDhYlcV5D25PJQgLpiSWp2ampBalF
        MFkmDk6pBiYZprVrlIPk9p9Y9FMv9XZC9nnptXulS86sm3ldSLFLTM3tatw7lVkLMrYKLkpY
        0+AWkqWsuutIvnrjzn+MNzfP2Hf65ZM7HA+OVT4KZJwdeSdp7/R306XYOblXb0z+bGCq5OXO
        uvtf486+P24l1Xrfd+r8yY5NV4munvWnN5lr3aTDr+eVxqoallT5VLPF6fMmX9K47azyTI47
        qFT5fkVprE+G95GeK+s37vLuv6bZtnJ2wwxHhsszBS+WWG/6/aH85avopjbp6Dv8gcnnVGL6
        D1f++Gp058XnZZ0G3FsDHYuveqhmrquRjzpaYHeANVSy6k+uy+L5Xb+/Zz660/f33UT+hwvy
        0/YK/8tMuKXEUpyRaKjFXFScCADepYomqwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrFIsWRmVeSWpSXmKPExsWS2cA0Uff5gv/JBgt/KllMn3qB0WL1zTWM
        FvufPmexWLXwGpvF+VmnWBxYPVqOvGX1WLznJZPH1Nn1Hp83yQWwRHHZpKTmZJalFunbJXBl
        LH26lqVgnW/Fsf9VDYw7LLsYOTkkBEwkfk97yd7FyMUhJLCaUeLlgessEM5HRokDj5+wQThL
        GSVW3b/BAtLCJqAosa9rOxuILSKgLjFv7W1GkCJmgT4miZ3fO9hBEsICHhJzzk9hhijylOh5
        OpEJwjaSaL17H6yZRUBF4sL/+UDNHBy8AmYS3z6nQSzbzSjxZMp2sF5OAUuJS/fugS1mFBCT
        +H5qDdgcZgFxiVtP5jNB/CAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIep1JBbs/sQGYdtJNB+d
        yghha0ssW/garJdXQFDi5MwnLBC9khIHV9xgmcAoMQvJullIRs1CMmoWklGzkIxawMi6ilG8
        tLg4N72i2DgvtVyvODG3uDQvXS85P3cTIzB6T/87HLOD8d6tj3qHGJk4GA8xSnAwK4nwLrz9
        J1mINyWxsiq1KD++qDQntfgQozQHi5I4r0fsxHghgfTEktTs1NSC1CKYLBMHp1QDk6WFoPmJ
        c5p87026H89UuZO7OeqYf+K1ax8vsvosqqm+nFq34wqznWwqz4+jGvsldZ4pO0VP/BQ6P+jS
        h38zzu7iUeVnuWj5osR/E7NS7uLMXs/NlQtMDmW8U4tOKpnl+U1+tubv6Iltuy5PYHmbGFm6
        TsU/3sC79bB/VOaMSzulVAtjrCUtYqVsvcSCNHUvFh1x2r+3xb31wBGfePdKh5nxVyMbbs2M
        9wi/zPn6jkLY7sKFa3vn8X6b9DpriWnQZI5NTwOzv/g0lh4NYZges/GGm/pBdjPTiSzxheIR
        uUtnC1zJZtUv3HAi+ceHRL25Wn+TLPp0fvUnf/GynlJ1+bboz+fdR+JVXPYrro9VYinOSDTU
        Yi4qTgQAyA47nk0DAAA=
X-CMS-MailID: 20230301190055uscas1p1e774178c46cd229012fe942589cb3448
CMS-TYPE: 301P
X-CMS-RootMailID: 20230224194502uscas1p2674510e3a54bddc824f5fcac7719f3ce
References: <20230224194443.1990440-1-dave@stgolabs.net>
        <CGME20230224194502uscas1p2674510e3a54bddc824f5fcac7719f3ce@uscas1p2.samsung.com>
        <20230224194443.1990440-2-dave@stgolabs.net>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Feb 24, 2023 at 11:44:41AM -0800, Davidlohr Bueso wrote:

One minor thing. See below under bg_timercb.

> Support background commands in the mailbox, and update
> cmd_infostat_bg_op_sts() accordingly. This patch does
> not implement mbox interrupts upon completion, so the
> kernel driver must rely on polling to know when the
> operation is done.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  hw/cxl/cxl-device-utils.c   |   5 +-
>  hw/cxl/cxl-mailbox-utils.c  | 103 ++++++++++++++++++++++++++++++++++--
>  include/hw/cxl/cxl_device.h |  10 ++++
>  3 files changed, 111 insertions(+), 7 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 50c76c65e755..4bb4e85dae19 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -101,8 +101,7 @@ static void mailbox_mem_writeq(uint64_t *reg_state, h=
waddr offset,
>      case A_CXL_DEV_MAILBOX_CMD:
>          break;
>      case A_CXL_DEV_BG_CMD_STS:
> -        /* BG not supported */
> -        /* fallthrough */
> +        break;
>      case A_CXL_DEV_MAILBOX_STS:
>          /* Read only register, will get updated by the state machine */
>          return;
> @@ -273,7 +272,7 @@ static void device_reg_init_common(CXLDeviceState *cx=
l_dstate)
> =20
>  static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
>  {
> -    /* 2048 payload size, with no interrupt or background support */
> +    /* 2048 payload size, with no interrupt */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
>                       PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
>      cxl_dstate->payload_size =3D CXL_MAILBOX_MAX_PAYLOAD_SIZE;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index b02908c4a4ba..82923bb84eb0 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -350,7 +350,14 @@ static CXLRetCode cmd_infostat_bg_op_sts(struct cxl_=
cmd *cmd,
> =20
>      bg_op_status =3D (void *)cmd->payload;
>      memset(bg_op_status, 0, sizeof(*bg_op_status));
> -    /* No support yet for background operations so status all 0 */
> +    bg_op_status->status =3D ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state=
64,
> +                                            CXL_DEV_BG_CMD_STS, PERCENTA=
GE_COMP) << 1;
> +    if (cxl_dstate->bg.runtime > 0) {
> +        bg_op_status->status |=3D 1U << 0;
> +    }
> +    bg_op_status->opcode =3D cxl_dstate->bg.opcode;
> +    bg_op_status->returncode =3D ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_s=
tate64,
> +                                               CXL_DEV_BG_CMD_STS, RET_C=
ODE);
>      *len =3D sizeof(*bg_op_status);
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -808,6 +815,8 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_c=
md *cmd,
>  #define IMMEDIATE_DATA_CHANGE (1 << 2)
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> +#define SECURITY_STATE_CHANGE (1 << 5)
> +#define BACKGROUND_OPERATION (1 << 6)
> =20
>  static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>      [EVENTS][GET_RECORDS] =3D { "EVENTS_GET_RECORDS",
> @@ -856,12 +865,20 @@ static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D =
{
>          cmd_identify_switch_device, 0, 0x49 },
>  };
> =20
> +/*
> + * While the command is executing in the background, the device should
> + * update the percentage complete in the Background Command Status Regis=
ter
> + * at least once per second.
> + */
> +#define CXL_MBOX_BG_UPDATE_FREQ 1000UL
> +
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  {
>      uint16_t ret =3D CXL_MBOX_SUCCESS;
>      struct cxl_cmd *cxl_cmd;
> -    uint64_t status_reg;
> +    uint64_t status_reg =3D 0;
>      opcode_handler h;
> +    uint8_t bg_started =3D 0;
>      uint64_t command_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAIL=
BOX_CMD];
> =20
>      uint8_t set =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
_SET);
> @@ -873,7 +890,17 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>          if (len =3D=3D cxl_cmd->in || cxl_cmd->in =3D=3D ~0) {
>              cxl_cmd->payload =3D cxl_dstate->mbox_reg_state +
>                  A_CXL_DEV_CMD_PAYLOAD;
> +            /* Only one bg command at a time */
> +            if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> +                cxl_dstate->bg.runtime > 0) {
> +                    ret =3D CXL_MBOX_BUSY;
> +                    goto done;
> +            }
>              ret =3D (*h)(cxl_cmd, cxl_dstate, &len);
> +            if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> +                ret =3D=3D CXL_MBOX_BG_STARTED) {
> +                bg_started =3D 1;
> +            }
>              assert(len <=3D cxl_dstate->payload_size);
>          } else {
>              ret =3D CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> @@ -884,8 +911,12 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>          ret =3D CXL_MBOX_UNSUPPORTED;
>      }
> =20
> -    /* Set the return code */
> -    status_reg =3D FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
> +done:
> +    /* Set bg and the return code */
> +    if (bg_started) {
> +        status_reg =3D FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, bg_star=
ted);
> +    }
> +    status_reg =3D FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, re=
t);
> =20
>      /* Set the return length */
>      command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
_SET, 0);
> @@ -895,11 +926,70 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate=
)
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] =3D command_reg;
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] =3D status_reg;
> =20
> +    if (bg_started) {
> +        uint64_t bg_status_reg, now;
> +
> +        cxl_dstate->bg.opcode =3D (set << 8) | cmd;
> +
> +        bg_status_reg =3D FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP, cxl_dsta=
te->bg.opcode);
> +        bg_status_reg =3D FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> +                                   PERCENTAGE_COMP, 0);
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] =3D bg_status=
_reg;
> +
> +        now =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +        cxl_dstate->bg.starttime =3D now;
> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> +    }
> +
>      /* Tell the host we're done */
>      ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
>                       DOORBELL, 0);
>  }
> =20
> +static void bg_timercb(void *opaque)
> +{
> +    CXLDeviceState *cxl_dstate =3D opaque;
> +    uint64_t bg_status_reg =3D 0;
> +    uint64_t now =3D qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
> +    uint64_t total_time =3D cxl_dstate->bg.starttime + cxl_dstate->bg.ru=
ntime;
> +
> +    assert(cxl_dstate->bg.runtime > 0);
> +    bg_status_reg =3D FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
> +                               OP, cxl_dstate->bg.opcode);
> +
> +    if (now >=3D total_time) { /* we are done */
> +        uint64_t status_reg;
> +        uint16_t ret =3D CXL_MBOX_SUCCESS;
> +
> +        cxl_dstate->bg.complete_pct =3D 100;
> +        /* Clear bg */
> +        status_reg =3D FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
> +        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] =3D status_r=
eg;
> +
> +        bg_status_reg =3D FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, =
RET_CODE, ret);
> +
> +        /* TODO add ad-hoc cmd succesful completion handling */
> +
> +        qemu_log("Background command %04xh finished: %s\n",
> +                 cxl_dstate->bg.opcode,
> +                 ret =3D=3D CXL_MBOX_SUCCESS ? "success" : "aborted");
Seems ret will always be CXL_MBOX_SUCCESS, maybe bg_status_reg?
> +    } else {
> +        /* estimate only */
> +        cxl_dstate->bg.complete_pct =3D 100 * now / total_time;
> +        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
> +    }
> +
> +    bg_status_reg =3D FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, PERC=
ENTAGE_COMP,
> +                               cxl_dstate->bg.complete_pct);
> +    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] =3D bg_status_reg=
;
> +
> +    if (cxl_dstate->bg.complete_pct =3D=3D 100) {
> +        cxl_dstate->bg.starttime =3D 0;
> +        /* registers are updated, allow new bg-capable cmds */
> +        cxl_dstate->bg.runtime =3D 0;
> +    }
> +}
> +
>  void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
>  {
>      if (!switch_cci) {
> @@ -920,4 +1010,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dsta=
te, bool switch_cci)
>              }
>          }
>      }
> +    cxl_dstate->bg.complete_pct =3D 0;
> +    cxl_dstate->bg.starttime =3D 0;
> +    cxl_dstate->bg.runtime =3D 0;
> +    cxl_dstate->bg.timer =3D timer_new_ms(QEMU_CLOCK_VIRTUAL,
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
> =20
>  /* Initialize the register block for a device */
> --=20
> 2.39.2
> =
