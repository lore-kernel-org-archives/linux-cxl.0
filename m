Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E21E82CC9
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Sep 2023 19:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjI0T1X (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjI0T1W (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Sep 2023 15:27:22 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C614E12A
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 12:27:18 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230927192715usoutp02240240ced1b91737a1aa47abbb48dfcd~I2BLS5JXM3097330973usoutp029;
        Wed, 27 Sep 2023 19:27:15 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230927192715usoutp02240240ced1b91737a1aa47abbb48dfcd~I2BLS5JXM3097330973usoutp029
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695842835;
        bh=YHBADoYj1oRRPESXUy1ag6zYoK8vydZBK5c0Von7ck0=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=d9lBljpc6vKQGj1eulwopdCMeR5Hak/K8hEansYPij42C997D3ZUQU1bStyHyV7D+
         1slE/1EirQwFVSDE5GaVMhn2ryIsT0g65FGVSoKB7iKQr9ISFpajFahRRVX3d3S4Pw
         bUrTKW0rH3IpARvjMooY0zxwwO7lHcFzapJW7XsQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230927192714uscas1p20190549dc236812d3f030d7d8fedcb30~I2BLKbYMd3181831818uscas1p2a;
        Wed, 27 Sep 2023 19:27:14 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 49.9E.62237.21284156; Wed,
        27 Sep 2023 15:27:14 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230927192714uscas1p26fdea557a163bb08d23fa7004050579e~I2BKrfASl3181831818uscas1p2Z;
        Wed, 27 Sep 2023 19:27:14 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-4b-65148212896b
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id AD.88.31200.21284156; Wed,
        27 Sep 2023 15:27:14 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 27 Sep 2023 12:27:13 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        27 Sep 2023 12:27:13 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "Davidlohr Bueso" <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        "Klaus Jensen" <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: Re: [PATCH 01/19] hw/cxl/mbox: Pull the payload out of struct
 cxl_cmd and make instances constant
Thread-Topic: [PATCH 01/19] hw/cxl/mbox: Pull the payload out of struct
        cxl_cmd and make instances constant
Thread-Index: AQHZ78sHbUc8lWJQ0E2xpo9Dt0cg67AvhvmA
Date:   Wed, 27 Sep 2023 19:27:13 +0000
Message-ID: <20230927192706.GA4139409@sjcvldevvm72>
In-Reply-To: <20230925161124.18940-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <758883042A1EA54F8678E049938EC369@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djXc7pCTSKpBlOf6Fk8njKRzWL1zTWM
        Fg1Nj1gs9h/8xmqxauE1Novzs06xWBzeeIbJ4v+vV6wWa1YIWxzv3cHiwOXRcuQtq8e5HefZ
        Pe5c28PmsfHjf3aP87tnsHo8ubaZyeP9vqtsHlNn13t83iQXwBnFZZOSmpNZllqkb5fAldHw
        fj1zwfmJjBXnWgobGKemdjFyckgImEhsOXCFqYuRi0NIYCWjxP67i5ghnFYmiekN05lgqj6s
        3cQCkVjLKPHj1jpWCOcTo8Tfz5uh+pcB9U/oYgdpYRNQlNjXtZ0NxBYRMJJ4d2MSI0gRs8Bx
        ZomXnRPAioQFciTeth9khCjKlTi1ZxkTXMPNw8wgNouAqsS6qS/A4rwCxhJXrs8Gq+cUcJTY
        OW0Z2AJGATGJ76fWgNUwC4hL3HoyH+puQYlFs/cwQ9hiEv92PWSDsBUl7n9/yQ5RrydxY+oU
        NgjbTqLz/VWoOdoSyxa+ZobYKyhxcuYTFoheSYmDK26Aw0JCoJtTYtLEA0AHcQA5LhLPb+RB
        1EhL/L0L8gtIOFli1UcuiHCOxPwlW6DGWEss/LOeaQKjyiwkV89CctEsJBfNQnLRLCQXLWBk
        XcUoXlpcnJueWmycl1quV5yYW1yal66XnJ+7iRGY4k7/O1ywg/HWrY96hxiZOBgPMUpwMCuJ
        8D68LZQqxJuSWFmVWpQfX1Sak1p8iFGag0VJnNfQ9mSykEB6YklqdmpqQWoRTJaJg1OqgWmv
        nv7ETK/D3s1PmrpbmCZO396WuatzAYe5vkHD5UPSBxNzTP79dfnBl9dzf4HACtXwec3zjnzn
        NRCRml+wYedDfs6jzFpXeM+fV75z/I9K22nvr6mX7mV8i65auP3Mo/9tO+T4nBc/S7xk+s4s
        jttJpLiju1mFwWirTwiza6j8TJ+cGicu2T/lfhuXPDf70reT5fPeptMxswXKr5xp97Xzid8b
        6erPIvz150ed/6E+b8+tzVI3LhDNFtD5E7fjm/xTGW1D7sMrFsYvn2CiI7dV51JIVJnJ7Jcl
        HSwGuxjLV02c02E77dGEXxPDBdR0rBwEjVf9CHQ7YrGS1eDN0b05j7d1nef+sKG+TjjbW4ml
        OCPRUIu5qDgRAFgfr+HgAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrDIsWRmVeSWpSXmKPExsWS2cA0UVeoSSTVYO87QYvHUyayWay+uYbR
        oqHpEYvF/oPfWC1WLbzGZnF+1ikWi8MbzzBZ/P/1itVizQphi+O9O1gcuDxajrxl9Ti34zy7
        x51re9g8Nn78z+5xfvcMVo8n1zYzebzfd5XNY+rseo/Pm+QCOKO4bFJSczLLUov07RK4Mhre
        r2cuOD+RseJcS2ED49TULkZODgkBE4kPazexgNhCAqsZJQ5/4Oli5AKyPzFKzF95hgnCWcYo
        MfvCGbAqNgFFiX1d29lAbBEBI4l3NyYxghQxCxxnlnjZOYEdJCEskCPxY/M+RoiiXIlFa/4z
        wjXcPMwMYrMIqEqsm/qCCcTmFTCWuHJ9NiPEttOMEl+bf7CCJDgFHCV2TlsGto1RQEzi+6k1
        YA3MAuISt57MZ4L4QUBiyZ7zzBC2qMTLx/9YIWxFifvfX7JD1OtJ3Jg6hQ3CtpPofH8Vao62
        xLKFr5khjhCUODnzCQtEr6TEwRU3WCYwSsxCsm4WklGzkIyahWTULCSjFjCyrmIULy0uzk2v
        KDbKSy3XK07MLS7NS9dLzs/dxAhMEKf/HY7ewXj71ke9Q4xMHIyHGCU4mJVEeB/eFkoV4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzrtjysUUIYH0xJLU7NTUgtQimCwTB6dUA1Pkob7aOScaIt7q
        BdZsW7HozItOho70H+0Pnmu8d/vTmCW2/32nlNbLmE75BmvZ7/zfvNfxvgt3ZFth5xX0xWjb
        egHG+SH7uy+G3K3aYbKn+EWDocyN4ryZzzvae+4G/DFnmTfhBW/JRvX8VRkP3x1Q1v+d2HO1
        se2swU+GvL1RDBFv7n98kOHk5pvW/jVSdbmfpcmfP383HJsaeC9erEZhSRCrVaBb6Q4BKRnn
        5HSrq4LO8efjYh+fCWhlmFlg83pG//9EBlOH+xP1OiK2TXXgCrn1jmnVhHvLXV5Pfln++9bq
        5iXzrqcYcUfOmj3zyJX3/x5N/K7Z+P+p05vCVbvmm7pcYnv67O8hvVy5xLtKLMUZiYZazEXF
        iQC36n14fwMAAA==
X-CMS-MailID: 20230927192714uscas1p26fdea557a163bb08d23fa7004050579e
CMS-TYPE: 301P
X-CMS-RootMailID: 20230925161202uscas1p2a71527e8e6d37b6ca44c3652002dfcd8
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
        <CGME20230925161202uscas1p2a71527e8e6d37b6ca44c3652002dfcd8@uscas1p2.samsung.com>
        <20230925161124.18940-2-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 05:11:06PM +0100, Jonathan Cameron wrote:
> Putting the pointer in the structure for command handling puts a single
> variable element inside an otherwise constant structure. Move it out as
> a directly passed variable and take the cxl_cmd structures constant.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_device.h |  13 ++++
>  hw/cxl/cxl-mailbox-utils.c  | 121 +++++++++++++++++++-----------------
>  2 files changed, 78 insertions(+), 56 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 007ddaf078..556953469c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -111,6 +111,18 @@ typedef enum {
>      CXL_MBOX_MAX =3D 0x17
>  } CXLRetCode;
> =20
> +typedef struct cxl_device_state CXLDeviceState;
> +struct cxl_cmd;
> +typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
> +                                     uint8_t *payload,
> +                                     CXLDeviceState *cxl_dstate, uint16_=
t *len);
> +struct cxl_cmd {
> +    const char *name;
> +    opcode_handler handler;
> +    ssize_t in;
> +    uint16_t effect; /* Reported in CEL */
> +};
> +
>  typedef struct CXLEvent {
>      CXLEventRecordRaw data;
>      QSIMPLEQ_ENTRY(CXLEvent) node;
> @@ -178,6 +190,7 @@ typedef struct cxl_device_state {
>      uint64_t pmem_size;
>      uint64_t vmem_size;
> =20
> +    const struct cxl_cmd (*cxl_cmd_set)[256];
>      CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
>  } CXLDeviceState;
> =20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ab082ec9de..c02de06943 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -69,18 +69,9 @@ enum {
>          #define CLEAR_POISON           0x2
>  };
> =20
> -struct cxl_cmd;
> -typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
> -                                   CXLDeviceState *cxl_dstate, uint16_t =
*len);
> -struct cxl_cmd {
> -    const char *name;
> -    opcode_handler handler;
> -    ssize_t in;
> -    uint16_t effect; /* Reported in CEL */
> -    uint8_t *payload;
> -};
> =20
> -static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload,
>                                           CXLDeviceState *cxlds,
>                                           uint16_t *len)
>  {
> @@ -92,9 +83,9 @@ static CXLRetCode cmd_events_get_records(struct cxl_cmd=
 *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
> =20
> -    log_type =3D *((uint8_t *)cmd->payload);
> +    log_type =3D payload[0];
> =20
> -    pl =3D (CXLGetEventPayload *)cmd->payload;
> +    pl =3D (CXLGetEventPayload *)payload;
>      memset(pl, 0, sizeof(*pl));
> =20
>      max_recs =3D (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
> @@ -106,25 +97,27 @@ static CXLRetCode cmd_events_get_records(struct cxl_=
cmd *cmd,
>      return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
>  }
> =20
> -static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
> +                                           uint8_t *payload,
>                                             CXLDeviceState *cxlds,
>                                             uint16_t *len)
>  {
>      CXLClearEventPayload *pl;
> =20
> -    pl =3D (CXLClearEventPayload *)cmd->payload;
> +    pl =3D (CXLClearEventPayload *)payload;
>      *len =3D 0;
>      return cxl_event_clear_records(cxlds, pl);
>  }
> =20
> -static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *=
cmd,
> +                                                  uint8_t *payload,
>                                                    CXLDeviceState *cxlds,
>                                                    uint16_t *len)
>  {
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
> =20
> -    policy =3D (CXLEventInterruptPolicy *)cmd->payload;
> +    policy =3D (CXLEventInterruptPolicy *)payload;
>      memset(policy, 0, sizeof(*policy));
> =20
>      log =3D &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
> @@ -157,7 +150,8 @@ static CXLRetCode cmd_events_get_interrupt_policy(str=
uct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *=
cmd,
> +                                                  uint8_t *payload,
>                                                    CXLDeviceState *cxlds,
>                                                    uint16_t *len)
>  {
> @@ -168,7 +162,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(str=
uct cxl_cmd *cmd,
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
> =20
> -    policy =3D (CXLEventInterruptPolicy *)cmd->payload;
> +    policy =3D (CXLEventInterruptPolicy *)payload;
> =20
>      log =3D &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
>      log->irq_enabled =3D (policy->info_settings & CXL_EVENT_INT_MODE_MAS=
K) =3D=3D
> @@ -200,7 +194,8 @@ static CXLRetCode cmd_events_set_interrupt_policy(str=
uct cxl_cmd *cmd,
>  }
> =20
>  /* 8.2.9.2.1 */
> -static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd=
,
> +                                               uint8_t *payload,
>                                                 CXLDeviceState *cxl_dstat=
e,
>                                                 uint16_t *len)
>  {
> @@ -221,7 +216,7 @@ static CXLRetCode cmd_firmware_update_get_info(struct=
 cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> -    fw_info =3D (void *)cmd->payload;
> +    fw_info =3D (void *)payload;
>      memset(fw_info, 0, sizeof(*fw_info));
> =20
>      fw_info->slots_supported =3D 2;
> @@ -234,27 +229,29 @@ static CXLRetCode cmd_firmware_update_get_info(stru=
ct cxl_cmd *cmd,
>  }
> =20
>  /* 8.2.9.3.1 */
> -static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
> +                                    uint8_t *payload,
>                                      CXLDeviceState *cxl_dstate,
>                                      uint16_t *len)
>  {
>      uint64_t final_time =3D cxl_device_get_timestamp(cxl_dstate);
> =20
> -    stq_le_p(cmd->payload, final_time);
> +    stq_le_p(payload, final_time);
>      *len =3D 8;
> =20
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.3.2 */
> -static CXLRetCode cmd_timestamp_set(struct cxl_cmd *cmd,
> -                                  CXLDeviceState *cxl_dstate,
> -                                  uint16_t *len)
> +static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
> +                                    uint8_t *payload,
> +                                    CXLDeviceState *cxl_dstate,
> +                                    uint16_t *len)
>  {
>      cxl_dstate->timestamp.set =3D true;
>      cxl_dstate->timestamp.last_set =3D qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL);
> =20
> -    cxl_dstate->timestamp.host_set =3D le64_to_cpu(*(uint64_t *)cmd->pay=
load);
> +    cxl_dstate->timestamp.host_set =3D le64_to_cpu(*(uint64_t *)payload)=
;
> =20
>      *len =3D 0;
>      return CXL_MBOX_SUCCESS;
> @@ -267,7 +264,8 @@ static const QemuUUID cel_uuid =3D {
>  };
> =20
>  /* 8.2.9.4.1 */
> -static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload,
>                                           CXLDeviceState *cxl_dstate,
>                                           uint16_t *len)
>  {
> @@ -278,7 +276,7 @@ static CXLRetCode cmd_logs_get_supported(struct cxl_c=
md *cmd,
>              QemuUUID uuid;
>              uint32_t size;
>          } log_entries[1];
> -    } QEMU_PACKED *supported_logs =3D (void *)cmd->payload;
> +    } QEMU_PACKED *supported_logs =3D (void *)payload;
>      QEMU_BUILD_BUG_ON(sizeof(*supported_logs) !=3D 0x1c);
> =20
>      supported_logs->entries =3D 1;
> @@ -290,7 +288,8 @@ static CXLRetCode cmd_logs_get_supported(struct cxl_c=
md *cmd,
>  }
> =20
>  /* 8.2.9.4.2 */
> -static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload,
>                                     CXLDeviceState *cxl_dstate,
>                                     uint16_t *len)
>  {
> @@ -298,7 +297,9 @@ static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cm=
d,
>          QemuUUID uuid;
>          uint32_t offset;
>          uint32_t length;
> -    } QEMU_PACKED QEMU_ALIGNED(16) *get_log =3D (void *)cmd->payload;
> +    } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
> +
> +    get_log =3D (void *)payload;
> =20
>      /*
>       * 8.2.9.4.2
> @@ -324,14 +325,15 @@ static CXLRetCode cmd_logs_get_log(struct cxl_cmd *=
cmd,
>      /* Store off everything to local variables so we can wipe out the pa=
yload */
>      *len =3D get_log->length;
> =20
> -    memmove(cmd->payload, cxl_dstate->cel_log + get_log->offset,
> +    memmove(payload, cxl_dstate->cel_log + get_log->offset,
>             get_log->length);
> =20
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.5.1.1 */
> -static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
> +                                             uint8_t *payload,
>                                               CXLDeviceState *cxl_dstate,
>                                               uint16_t *len)
>  {
> @@ -361,7 +363,7 @@ static CXLRetCode cmd_identify_memory_device(struct c=
xl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> -    id =3D (void *)cmd->payload;
> +    id =3D (void *)payload;
>      memset(id, 0, sizeof(*id));
> =20
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> @@ -382,7 +384,8 @@ static CXLRetCode cmd_identify_memory_device(struct c=
xl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
> +                                              uint8_t *payload,
>                                                CXLDeviceState *cxl_dstate=
,
>                                                uint16_t *len)
>  {
> @@ -391,7 +394,7 @@ static CXLRetCode cmd_ccls_get_partition_info(struct =
cxl_cmd *cmd,
>          uint64_t active_pmem;
>          uint64_t next_vmem;
>          uint64_t next_pmem;
> -    } QEMU_PACKED *part_info =3D (void *)cmd->payload;
> +    } QEMU_PACKED *part_info =3D (void *)payload;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) !=3D 0x20);
> =20
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER=
)) ||
> @@ -414,7 +417,8 @@ static CXLRetCode cmd_ccls_get_partition_info(struct =
cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload,
>                                     CXLDeviceState *cxl_dstate,
>                                     uint16_t *len)
>  {
> @@ -426,7 +430,7 @@ static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cm=
d,
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      uint32_t offset, length;
> =20
> -    get_lsa =3D (void *)cmd->payload;
> +    get_lsa =3D (void *)payload;
>      offset =3D get_lsa->offset;
>      length =3D get_lsa->length;
> =20
> @@ -439,7 +443,8 @@ static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cm=
d,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
> +                                   uint8_t *payload,
>                                     CXLDeviceState *cxl_dstate,
>                                     uint16_t *len)
>  {
> @@ -448,7 +453,7 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cm=
d,
>          uint32_t rsvd;
>          uint8_t data[];
>      } QEMU_PACKED;
> -    struct set_lsa_pl *set_lsa_payload =3D (void *)cmd->payload;
> +    struct set_lsa_pl *set_lsa_payload =3D (void *)payload;
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      const size_t hdr_len =3D offsetof(struct set_lsa_pl, data);
> @@ -474,7 +479,8 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cm=
d,
>   * make this stateful. We may want to allow longer poison lists to aid
>   * testing that kernel functionality.
>   */
> -static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
> +                                            uint8_t *payload,
>                                              CXLDeviceState *cxl_dstate,
>                                              uint16_t *len)
>  {
> @@ -496,8 +502,8 @@ static CXLRetCode cmd_media_get_poison_list(struct cx=
l_cmd *cmd,
>          } QEMU_PACKED records[];
>      } QEMU_PACKED;
> =20
> -    struct get_poison_list_pl *in =3D (void *)cmd->payload;
> -    struct get_poison_list_out_pl *out =3D (void *)cmd->payload;
> +    struct get_poison_list_pl *in =3D (void *)payload;
> +    struct get_poison_list_out_pl *out =3D (void *)payload;
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      uint16_t record_count =3D 0, i =3D 0;
>      uint64_t query_start, query_length;
> @@ -550,7 +556,8 @@ static CXLRetCode cmd_media_get_poison_list(struct cx=
l_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
> +                                          uint8_t *payload,
>                                            CXLDeviceState *cxl_dstate,
>                                            uint16_t *len_unused)
>  {
> @@ -560,7 +567,7 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_=
cmd *cmd,
>      struct inject_poison_pl {
>          uint64_t dpa;
>      };
> -    struct inject_poison_pl *in =3D (void *)cmd->payload;
> +    struct inject_poison_pl *in =3D (void *)payload;
>      uint64_t dpa =3D ldq_le_p(&in->dpa);
>      CXLPoison *p;
> =20
> @@ -589,7 +596,8 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_=
cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> +                                         uint8_t *payload,
>                                           CXLDeviceState *cxl_dstate,
>                                           uint16_t *len_unused)
>  {
> @@ -603,7 +611,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_c=
md *cmd,
>      CXLPoison *ent;
>      uint64_t dpa;
> =20
> -    struct clear_poison_pl *in =3D (void *)cmd->payload;
> +    struct clear_poison_pl *in =3D (void *)payload;
> =20
>      dpa =3D ldq_le_p(&in->dpa);
>      if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> @@ -673,7 +681,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_c=
md *cmd,
>  #define IMMEDIATE_POLICY_CHANGE (1 << 3)
>  #define IMMEDIATE_LOG_CHANGE (1 << 4)
> =20
> -static struct cxl_cmd cxl_cmd_set[256][256] =3D {
> +static const struct cxl_cmd cxl_cmd_set[256][256] =3D {
>      [EVENTS][GET_RECORDS] =3D { "EVENTS_GET_RECORDS",
>          cmd_events_get_records, 1, 0 },
>      [EVENTS][CLEAR_RECORDS] =3D { "EVENTS_CLEAR_RECORDS",
> @@ -709,21 +717,21 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>  {
>      uint16_t ret =3D CXL_MBOX_SUCCESS;
> -    struct cxl_cmd *cxl_cmd;
> -    uint64_t status_reg;
> +    const struct cxl_cmd *cxl_cmd;
> +    uint64_t status_reg =3D 0;
>      opcode_handler h;
>      uint64_t command_reg =3D cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAIL=
BOX_CMD];
> =20
>      uint8_t set =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
_SET);
>      uint8_t cmd =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
);
>      uint16_t len =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH=
);
> -    cxl_cmd =3D &cxl_cmd_set[set][cmd];
> +    uint8_t *pl =3D cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> +
> +    cxl_cmd =3D &cxl_dstate->cxl_cmd_set[set][cmd];
>      h =3D cxl_cmd->handler;
>      if (h) {
>          if (len =3D=3D cxl_cmd->in || cxl_cmd->in =3D=3D ~0) {
> -            cxl_cmd->payload =3D cxl_dstate->mbox_reg_state +
> -                A_CXL_DEV_CMD_PAYLOAD;
> -            ret =3D (*h)(cxl_cmd, cxl_dstate, &len);
> +            ret =3D (*h)(cxl_cmd, pl, cxl_dstate, &len);
>              assert(len <=3D cxl_dstate->payload_size);
>          } else {
>              ret =3D CXL_MBOX_INVALID_PAYLOAD_LENGTH;
> @@ -752,10 +760,11 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate=
)
> =20
>  void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
>  {
> +    cxl_dstate->cxl_cmd_set =3D cxl_cmd_set;
>      for (int set =3D 0; set < 256; set++) {
>          for (int cmd =3D 0; cmd < 256; cmd++) {
> -            if (cxl_cmd_set[set][cmd].handler) {
> -                struct cxl_cmd *c =3D &cxl_cmd_set[set][cmd];
> +            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
> +                const struct cxl_cmd *c =3D &cxl_dstate->cxl_cmd_set[set=
][cmd];
>                  struct cel_log *log =3D
>                      &cxl_dstate->cel_log[cxl_dstate->cel_size];
> =20
> --=20
> 2.39.2
> =
