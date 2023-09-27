Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B018E7F14F
	for <linux-cxl@archiver.kernel.org>; Wed, 27 Sep 2023 22:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbjI0W60 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 27 Sep 2023 18:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjI0W6Z (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 27 Sep 2023 18:58:25 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90E37AF
        for <linux-cxl@vger.kernel.org>; Wed, 27 Sep 2023 15:58:22 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230927225821usoutp019c0c3296cfd0b8c9de18b189f747a0e1~I45faL0o-2757927579usoutp01B;
        Wed, 27 Sep 2023 22:58:21 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230927225821usoutp019c0c3296cfd0b8c9de18b189f747a0e1~I45faL0o-2757927579usoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695855501;
        bh=bsnJ8XuAOqJ7Wh7Fp8ClOoUI+Kz/oFj0ua/4aIWXt9E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ltjZww/ihpuU6sTtAqaT8fUVvqirZGiaEUwdnzjZQnAlkUlXKlmrylBTN7qxwvdHn
         l+ayz21Z4tcrxaXfeiKpFPvvFSVNWRgC2z57x9vhw+RAfXAubtbBMM1hkXWoywzvvv
         KBFS+2E/7Txs2qY5lTmKJu/n3agKATLSzjaXzmV0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230927225820uscas1p18b610779b47751666c6d0742d94825ac~I45fCwAlq2836128361uscas1p14;
        Wed, 27 Sep 2023 22:58:20 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 3E.E2.62237.C83B4156; Wed,
        27 Sep 2023 18:58:20 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230927225820uscas1p1208320932a39780c0af89ea2254e0a03~I45eqFSmi2835628356uscas1p18;
        Wed, 27 Sep 2023 22:58:20 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-04-6514b38c79b0
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 3A.22.31200.B83B4156; Wed,
        27 Sep 2023 18:58:20 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 27 Sep 2023 15:58:19 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        27 Sep 2023 15:58:19 -0700
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
Subject: Re: [PATCH 02/19] hw/cxl/mbox: Split mailbox command payload into
 separate input and output
Thread-Topic: [PATCH 02/19] hw/cxl/mbox: Split mailbox command payload into
        separate input and output
Thread-Index: AQHZ78sXRL9hgipMekiq9FbvR0MKnrAvwfMA
Date:   Wed, 27 Sep 2023 22:58:19 +0000
Message-ID: <20230927225813.GA4174457@sjcvldevvm72>
In-Reply-To: <20230925161124.18940-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <CFC1EBF2D9A54F4E941B0ACACF08F5F2@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djXc7o9m0VSDe49kLV4PGUim8Xqm2sY
        LRqaHrFY7D/4jdVi1cJrbBbnZ51isTi88QyTxf9fr1gt1qwQtjjeu4PFgcuj5chbVo9zO86z
        e9y5tofNY+PH/+we53fPYPV4cm0zk8f7fVfZPKbOrvf4vEkugDOKyyYlNSezLLVI3y6BK2Pp
        oj7GgjVnGSumr3/A1MDYWtvFyMkhIWAise3wA2YQW0hgJaPEjWvuXYxcQHYrk0Rj/1NmmKLv
        jz4wQSTWMkq8u9XBAuF8YpT4//s+O4SzjFHiy/21LCAtbAKKEvu6trOB2CICRhLvbkxiBCli
        FjjOLPGycwI7SEJYIE1i/fEVQDYHUFG6xKKvFjD1s1dMYAQJswioSnxbEAUS5hUwlnj84ibY
        eE4BR4nXm2eBTWEUEJP4fmoNE4jNLCAucevJfCaIqwUlFs3eA/WBmMS/XQ/ZIGxFifvfX7JD
        1OtJ3Jg6hQ3CtpP48e00K4StLbFs4WtmiL2CEidnPmGB6JWUOLjiBtjzEgL9nBIHuk+xQiRc
        JDZvf8IOYUtL/L27jAnkfgmBZIlVH7kgwjkS85dsgZpjLbHwz3qmCYwqs5CcPQvJSbOQnDQL
        yUmzkJy0gJF1FaN4aXFxbnpqsXFearlecWJucWleul5yfu4mRmCCO/3vcMEOxlu3PuodYmTi
        YDzEKMHBrCTC+/C2UKoQb0piZVVqUX58UWlOavEhRmkOFiVxXkPbk8lCAumJJanZqakFqUUw
        WSYOTqkGppz20G18RjV3/Y5/XzZVOv3IwVf9TQtOdrQqpnIpmYus3mZ0Indf70oZka2aXy6z
        KC2aV1QSM9VDYsFH/fNc1VNlir7P3RnmZPrkY57Drutvz83NEtz7xm6q/celukWVzkuL931N
        OHTu0Imzk03u/D8psvvnNF2dyIt8ZwsEvkVc2nTn9okDXI2a53NNl85MvfNRf33PvqOZXXF3
        vq741r5YrkDz/lcbg6nzLD/8qRKIPeH4y6dckMUq6GnOHYeTdzJt3615ECAts85+VtDa9uSJ
        m3dfUE0McTu8LEQ+9tjqCyseOO++Fjr/8fLyBzcv9WpNylm+bMrxzReZ5yutn5lcsGNKsfDn
        27f6VO5e++NgrMRSnJFoqMVcVJwIANKjIZbfAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLIsWRmVeSWpSXmKPExsWS2cA0Sbdns0iqwbr97BaPp0xks1h9cw2j
        RUPTIxaL/Qe/sVqsWniNzeL8rFMsFoc3nmGy+P/rFavFmhXCFsd7d7A4cHm0HHnL6nFux3l2
        jzvX9rB5bPz4n93j/O4ZrB5Prm1m8ni/7yqbx9TZ9R6fN8kFcEZx2aSk5mSWpRbp2yVwZSxd
        1MdYsOYsY8X09Q+YGhhba7sYOTkkBEwkvj/6wNTFyMUhJLCaUWLFr13MEM4nRomNbxayQzjL
        GCUuXzzPDNLCJqAosa9rOxuILSJgJPHuxiRGkCJmgePMEi87J7CDJIQF0iTWH1/BDlGULnH8
        ygy4htkrJgA1cHCwCKhKfFsQBRLmFTCWePziJgvEstOMEt2neplAEpwCjhKvN88Cm8MoICbx
        /dQasDizgLjErSfzmSB+EJBYsgfiOAkBUYmXj/+xQtiKEve/v2SHqNeTuDF1ChuEbSfx49tp
        VghbW2LZwtfMEEcISpyc+YQFoldS4uCKGywTGCVmIVk3C8moWUhGzUIyahaSUQsYWVcxipcW
        F+emVxQb5aWW6xUn5haX5qXrJefnbmIEpojT/w5H72C8feuj3iFGJg7GQ4wSHMxKIrwPbwul
        CvGmJFZWpRblxxeV5qQWH2KU5mBREufdMeViipBAemJJanZqakFqEUyWiYNTqoEpbcqSfj6z
        5BTrT1c2h6ssKi1RVr5c8zSPTTFHyGXW9dRipx1tYV1q3/oWTbvPXXfo5cWv2Wzbt0r/W/f+
        TytnqFFFceyLH6VsyaXp2Q+P5u/bsmY2+wbhT53Wq373Hj13f3H2F5/QPXKip+56ThA4ZXTw
        NXei3sWIVYLCB9Y9j/07QfNP+0mTOSv43qVFzv4y49Djfv24N59P1hwXqytqjF9Rna2yqdj5
        evh50Zt9zTu4edIFQhas/KWVcXv5kiPfDv5uaQh2VOPkTMxZV/2k8GHgm7DSVON5LCa3A6/d
        lEh7Kvqj9u488ducl1xOHnGYm9Wn45k7UcD7s+GPHTVGn5vOLWVO814W/+Kk53QzJZbijERD
        Leai4kQActXcuIADAAA=
X-CMS-MailID: 20230927225820uscas1p1208320932a39780c0af89ea2254e0a03
CMS-TYPE: 301P
X-CMS-RootMailID: 20230925161231uscas1p1a9f693fc848ccb8333d16209f09b16a3
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
        <CGME20230925161231uscas1p1a9f693fc848ccb8333d16209f09b16a3@uscas1p1.samsung.com>
        <20230925161124.18940-3-Jonathan.Cameron@huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 25, 2023 at 05:11:07PM +0100, Jonathan Cameron wrote:

> New CCI types that will be supported shortly do not have a single buffer
> used in both directions. As such, split it up. For CXL mailboxes the two
> pointers will be aliases of the same memory so all callbacks must allow
> for that.
>=20
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  include/hw/cxl/cxl_device.h |   7 +-
>  hw/cxl/cxl-events.c         |   2 +-
>  hw/cxl/cxl-mailbox-utils.c  | 222 +++++++++++++++++++++---------------
>  3 files changed, 132 insertions(+), 99 deletions(-)
>=20
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 556953469c..d7a2c4009e 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -114,8 +114,9 @@ typedef enum {
>  typedef struct cxl_device_state CXLDeviceState;
>  struct cxl_cmd;
>  typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
> -                                     uint8_t *payload,
> -                                     CXLDeviceState *cxl_dstate, uint16_=
t *len);
> +                                     uint8_t *payload_in, size_t len_in,
> +                                     uint8_t *payload_out, size_t *len_o=
ut,
> +                                     CXLDeviceState *cxl_dstate);
>  struct cxl_cmd {
>      const char *name;
>      opcode_handler handler;
> @@ -390,7 +391,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEvent=
LogType log_type,
>                        CXLEventRecordRaw *event);
>  CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPaylo=
ad *pl,
>                                   uint8_t log_type, int max_recs,
> -                                 uint16_t *len);
> +                                 size_t *len);
>  CXLRetCode cxl_event_clear_records(CXLDeviceState *cxlds,
>                                     CXLClearEventPayload *pl);
> =20
> diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
> index e2172b94b9..bee6dfaf14 100644
> --- a/hw/cxl/cxl-events.c
> +++ b/hw/cxl/cxl-events.c
> @@ -143,7 +143,7 @@ bool cxl_event_insert(CXLDeviceState *cxlds, CXLEvent=
LogType log_type,
> =20
>  CXLRetCode cxl_event_get_records(CXLDeviceState *cxlds, CXLGetEventPaylo=
ad *pl,
>                                   uint8_t log_type, int max_recs,
> -                                 uint16_t *len)
> +                                 size_t *len)
>  {
>      CXLEventLog *log;
>      CXLEvent *entry;
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index c02de06943..4bdbc2ee83 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -71,9 +71,9 @@ enum {
> =20
> =20
>  static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
> -                                         uint8_t *payload,
> -                                         CXLDeviceState *cxlds,
> -                                         uint16_t *len)
> +                                         uint8_t *payload_in, size_t len=
_in,
> +                                         uint8_t *payload_out, size_t *l=
en_out,
> +                                         CXLDeviceState *cxlds)
>  {
>      CXLGetEventPayload *pl;
>      uint8_t log_type;
> @@ -83,9 +83,9 @@ static CXLRetCode cmd_events_get_records(const struct c=
xl_cmd *cmd,
>          return CXL_MBOX_INVALID_INPUT;
>      }
> =20
> -    log_type =3D payload[0];
> +    log_type =3D payload_in[0];
> =20
> -    pl =3D (CXLGetEventPayload *)payload;
> +    pl =3D (CXLGetEventPayload *)payload_out;
>      memset(pl, 0, sizeof(*pl));
> =20
>      max_recs =3D (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
> @@ -94,30 +94,34 @@ static CXLRetCode cmd_events_get_records(const struct=
 cxl_cmd *cmd,
>          max_recs =3D 0xFFFF;
>      }
> =20
> -    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
> +    return cxl_event_get_records(cxlds, pl, log_type, max_recs, len_out)=
;
>  }
> =20
>  static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
> -                                           uint8_t *payload,
> -                                           CXLDeviceState *cxlds,
> -                                           uint16_t *len)
> +                                           uint8_t *payload_in,
> +                                           size_t len_in,
> +                                           uint8_t *payload_out,
> +                                           size_t *len_out,
> +                                           CXLDeviceState *cxlds)
>  {
>      CXLClearEventPayload *pl;
> =20
> -    pl =3D (CXLClearEventPayload *)payload;
> -    *len =3D 0;
> +    pl =3D (CXLClearEventPayload *)payload_in;
> +    *len_out =3D 0;
>      return cxl_event_clear_records(cxlds, pl);
>  }
> =20
>  static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *=
cmd,
> -                                                  uint8_t *payload,
> -                                                  CXLDeviceState *cxlds,
> -                                                  uint16_t *len)
> +                                                  uint8_t *payload_in,
> +                                                  size_t len_in,
> +                                                  uint8_t *payload_out,
> +                                                  size_t *len_out,
> +                                                  CXLDeviceState *cxlds)
>  {
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
> =20
> -    policy =3D (CXLEventInterruptPolicy *)payload;
> +    policy =3D (CXLEventInterruptPolicy *)payload_out;
>      memset(policy, 0, sizeof(*policy));
> =20
>      log =3D &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
> @@ -146,23 +150,25 @@ static CXLRetCode cmd_events_get_interrupt_policy(c=
onst struct cxl_cmd *cmd,
>          policy->dyn_cap_settings =3D CXL_INT_MSI_MSIX;
>      }
> =20
> -    *len =3D sizeof(*policy);
> +    *len_out =3D sizeof(*policy);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *=
cmd,
> -                                                  uint8_t *payload,
> -                                                  CXLDeviceState *cxlds,
> -                                                  uint16_t *len)
> +                                                  uint8_t *payload_in,
> +                                                  size_t len_in,
> +                                                  uint8_t *payload_out,
> +                                                  size_t *len_out,
> +                                                  CXLDeviceState *cxlds)
>  {
>      CXLEventInterruptPolicy *policy;
>      CXLEventLog *log;
> =20
> -    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
> +    if (len_in < CXL_EVENT_INT_SETTING_MIN_LEN) {
>          return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>      }
> =20
> -    policy =3D (CXLEventInterruptPolicy *)payload;
> +    policy =3D (CXLEventInterruptPolicy *)payload_in;
> =20
>      log =3D &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
>      log->irq_enabled =3D (policy->info_settings & CXL_EVENT_INT_MODE_MAS=
K) =3D=3D
> @@ -181,7 +187,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(con=
st struct cxl_cmd *cmd,
>                          CXL_INT_MSI_MSIX;
> =20
>      /* DCD is optional */
> -    if (*len < sizeof(*policy)) {
> +    if (len_in < sizeof(*policy)) {
>          return CXL_MBOX_SUCCESS;
>      }
> =20
> @@ -189,15 +195,17 @@ static CXLRetCode cmd_events_set_interrupt_policy(c=
onst struct cxl_cmd *cmd,
>      log->irq_enabled =3D (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_=
MASK) =3D=3D
>                          CXL_INT_MSI_MSIX;
> =20
> -    *len =3D sizeof(*policy);
> +    *len_out =3D 0;
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.2.1 */
>  static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd=
,
> -                                               uint8_t *payload,
> -                                               CXLDeviceState *cxl_dstat=
e,
> -                                               uint16_t *len)
> +                                               uint8_t *payload_in,
> +                                               size_t len,
> +                                               uint8_t *payload_out,
> +                                               size_t *len_out,
> +                                               CXLDeviceState *cxl_dstat=
e)
>  {
>      struct {
>          uint8_t slots_supported;
> @@ -216,7 +224,7 @@ static CXLRetCode cmd_firmware_update_get_info(const =
struct cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> -    fw_info =3D (void *)payload;
> +    fw_info =3D (void *)payload_out;
>      memset(fw_info, 0, sizeof(*fw_info));
> =20
>      fw_info->slots_supported =3D 2;
> @@ -224,36 +232,40 @@ static CXLRetCode cmd_firmware_update_get_info(cons=
t struct cxl_cmd *cmd,
>      fw_info->caps =3D 0;
>      pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0"=
);
> =20
> -    *len =3D sizeof(*fw_info);
> +    *len_out =3D sizeof(*fw_info);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.3.1 */
>  static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
> -                                    uint8_t *payload,
> -                                    CXLDeviceState *cxl_dstate,
> -                                    uint16_t *len)
> +                                    uint8_t *payload_in,
> +                                    size_t len_in,
> +                                    uint8_t *payload_out,
> +                                    size_t *len_out,
> +                                    CXLDeviceState *cxl_dstate)
>  {
>      uint64_t final_time =3D cxl_device_get_timestamp(cxl_dstate);
> =20
> -    stq_le_p(payload, final_time);
> -    *len =3D 8;
> +    stq_le_p(payload_out, final_time);
> +    *len_out =3D 8;
> =20
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.3.2 */
>  static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
> -                                    uint8_t *payload,
> -                                    CXLDeviceState *cxl_dstate,
> -                                    uint16_t *len)
> +                                    uint8_t *payload_in,
> +                                    size_t len_in,
> +                                    uint8_t *payload_out,
> +                                    size_t *len_out,
> +                                    CXLDeviceState *cxl_dstate)
>  {
>      cxl_dstate->timestamp.set =3D true;
>      cxl_dstate->timestamp.last_set =3D qemu_clock_get_ns(QEMU_CLOCK_VIRT=
UAL);
> =20
> -    cxl_dstate->timestamp.host_set =3D le64_to_cpu(*(uint64_t *)payload)=
;
> +    cxl_dstate->timestamp.host_set =3D le64_to_cpu(*(uint64_t *)payload_=
in);
> =20
> -    *len =3D 0;
> +    *len_out =3D 0;
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> @@ -265,9 +277,11 @@ static const QemuUUID cel_uuid =3D {
> =20
>  /* 8.2.9.4.1 */
>  static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
> -                                         uint8_t *payload,
> -                                         CXLDeviceState *cxl_dstate,
> -                                         uint16_t *len)
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          uint16_t entries;
> @@ -276,22 +290,24 @@ static CXLRetCode cmd_logs_get_supported(const stru=
ct cxl_cmd *cmd,
>              QemuUUID uuid;
>              uint32_t size;
>          } log_entries[1];
> -    } QEMU_PACKED *supported_logs =3D (void *)payload;
> +    } QEMU_PACKED *supported_logs =3D (void *)payload_out;
>      QEMU_BUILD_BUG_ON(sizeof(*supported_logs) !=3D 0x1c);
> =20
>      supported_logs->entries =3D 1;
>      supported_logs->log_entries[0].uuid =3D cel_uuid;
>      supported_logs->log_entries[0].size =3D 4 * cxl_dstate->cel_size;
> =20
> -    *len =3D sizeof(*supported_logs);
> +    *len_out =3D sizeof(*supported_logs);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.4.2 */
>  static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
> -                                   uint8_t *payload,
> -                                   CXLDeviceState *cxl_dstate,
> -                                   uint16_t *len)
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          QemuUUID uuid;
> @@ -299,7 +315,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_c=
md *cmd,
>          uint32_t length;
>      } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
> =20
> -    get_log =3D (void *)payload;
> +    get_log =3D (void *)payload_in;
> =20
>      /*
>       * 8.2.9.4.2
> @@ -323,19 +339,21 @@ static CXLRetCode cmd_logs_get_log(const struct cxl=
_cmd *cmd,
>      }
> =20
>      /* Store off everything to local variables so we can wipe out the pa=
yload */
> -    *len =3D get_log->length;
> +    *len_out =3D get_log->length;
> =20
> -    memmove(payload, cxl_dstate->cel_log + get_log->offset,
> -           get_log->length);
> +    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
> +            get_log->length);
> =20
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  /* 8.2.9.5.1.1 */
>  static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
> -                                             uint8_t *payload,
> -                                             CXLDeviceState *cxl_dstate,
> -                                             uint16_t *len)
> +                                             uint8_t *payload_in,
> +                                             size_t len_in,
> +                                             uint8_t *payload_out,
> +                                             size_t *len_out,
> +                                             CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          char fw_revision[0x10];
> @@ -363,7 +381,7 @@ static CXLRetCode cmd_identify_memory_device(const st=
ruct cxl_cmd *cmd,
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> -    id =3D (void *)payload;
> +    id =3D (void *)payload_out;
>      memset(id, 0, sizeof(*id));
> =20
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> @@ -380,21 +398,23 @@ static CXLRetCode cmd_identify_memory_device(const =
struct cxl_cmd *cmd,
>      /* No limit - so limited by main poison record limit */
>      stw_le_p(&id->inject_poison_limit, 0);
> =20
> -    *len =3D sizeof(*id);
> +    *len_out =3D sizeof(*id);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
> -                                              uint8_t *payload,
> -                                              CXLDeviceState *cxl_dstate=
,
> -                                              uint16_t *len)
> +                                              uint8_t *payload_in,
> +                                              size_t len_in,
> +                                              uint8_t *payload_out,
> +                                              size_t *len_out,
> +                                              CXLDeviceState *cxl_dstate=
)
>  {
>      struct {
>          uint64_t active_vmem;
>          uint64_t active_pmem;
>          uint64_t next_vmem;
>          uint64_t next_pmem;
> -    } QEMU_PACKED *part_info =3D (void *)payload;
> +    } QEMU_PACKED *part_info =3D (void *)payload_out;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) !=3D 0x20);
> =20
>      if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER=
)) ||
> @@ -413,14 +433,16 @@ static CXLRetCode cmd_ccls_get_partition_info(const=
 struct cxl_cmd *cmd,
>               cxl_dstate->pmem_size / CXL_CAPACITY_MULTIPLIER);
>      stq_le_p(&part_info->next_pmem, 0);
> =20
> -    *len =3D sizeof(*part_info);
> +    *len_out =3D sizeof(*part_info);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
> -                                   uint8_t *payload,
> -                                   CXLDeviceState *cxl_dstate,
> -                                   uint16_t *len)
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLDeviceState *cxl_dstate)
>  {
>      struct {
>          uint32_t offset;
> @@ -430,46 +452,47 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl=
_cmd *cmd,
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      uint32_t offset, length;
> =20
> -    get_lsa =3D (void *)payload;
> +    get_lsa =3D (void *)payload_in;
>      offset =3D get_lsa->offset;
>      length =3D get_lsa->length;
> =20
>      if (offset + length > cvc->get_lsa_size(ct3d)) {
> -        *len =3D 0;
> +        *len_out =3D 0;
>          return CXL_MBOX_INVALID_INPUT;
>      }
> =20
> -    *len =3D cvc->get_lsa(ct3d, get_lsa, length, offset);
> +    *len_out =3D cvc->get_lsa(ct3d, payload_out, length, offset);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
> -                                   uint8_t *payload,
> -                                   CXLDeviceState *cxl_dstate,
> -                                   uint16_t *len)
> +                                   uint8_t *payload_in,
> +                                   size_t len_in,
> +                                   uint8_t *payload_out,
> +                                   size_t *len_out,
> +                                   CXLDeviceState *cxl_dstate)
>  {
>      struct set_lsa_pl {
>          uint32_t offset;
>          uint32_t rsvd;
>          uint8_t data[];
>      } QEMU_PACKED;
> -    struct set_lsa_pl *set_lsa_payload =3D (void *)payload;
> +    struct set_lsa_pl *set_lsa_payload =3D (void *)payload_in;
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
>      const size_t hdr_len =3D offsetof(struct set_lsa_pl, data);
> -    uint16_t plen =3D *len;
> =20
> -    *len =3D 0;
> -    if (!plen) {
> +    *len_out =3D 0;
> +    if (!len_in) {
>          return CXL_MBOX_SUCCESS;
>      }
> =20
> -    if (set_lsa_payload->offset + plen > cvc->get_lsa_size(ct3d) + hdr_l=
en) {
> +    if (set_lsa_payload->offset + len_in > cvc->get_lsa_size(ct3d) + hdr=
_len) {
>          return CXL_MBOX_INVALID_INPUT;
>      }
> -    plen -=3D hdr_len;
> +    len_in -=3D hdr_len;
> =20
> -    cvc->set_lsa(ct3d, set_lsa_payload->data, plen, set_lsa_payload->off=
set);
> +    cvc->set_lsa(ct3d, set_lsa_payload->data, len_in, set_lsa_payload->o=
ffset);
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> @@ -480,9 +503,11 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_=
cmd *cmd,
>   * testing that kernel functionality.
>   */
>  static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
> -                                            uint8_t *payload,
> -                                            CXLDeviceState *cxl_dstate,
> -                                            uint16_t *len)
> +                                            uint8_t *payload_in,
> +                                            size_t len_in,
> +                                            uint8_t *payload_out,
> +                                            size_t *len_out,
> +                                            CXLDeviceState *cxl_dstate)
>  {
>      struct get_poison_list_pl {
>          uint64_t pa;
> @@ -502,8 +527,8 @@ static CXLRetCode cmd_media_get_poison_list(const str=
uct cxl_cmd *cmd,
>          } QEMU_PACKED records[];
>      } QEMU_PACKED;
> =20
> -    struct get_poison_list_pl *in =3D (void *)payload;
> -    struct get_poison_list_out_pl *out =3D (void *)payload;
> +    struct get_poison_list_pl *in =3D (void *)payload_in;
> +    struct get_poison_list_out_pl *out =3D (void *)payload_out;
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      uint16_t record_count =3D 0, i =3D 0;
>      uint64_t query_start, query_length;
> @@ -552,14 +577,16 @@ static CXLRetCode cmd_media_get_poison_list(const s=
truct cxl_cmd *cmd,
>          stq_le_p(&out->overflow_timestamp, ct3d->poison_list_overflow_ts=
);
>      }
>      stw_le_p(&out->count, record_count);
> -    *len =3D out_pl_len;
> +    *len_out =3D out_pl_len;
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
> -                                          uint8_t *payload,
> -                                          CXLDeviceState *cxl_dstate,
> -                                          uint16_t *len_unused)
> +                                          uint8_t *payload_in,
> +                                          size_t len_in,
> +                                          uint8_t *payload_out,
> +                                          size_t *len_out,
> +                                          CXLDeviceState *cxl_dstate)
>  {
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      CXLPoisonList *poison_list =3D &ct3d->poison_list;
> @@ -567,7 +594,7 @@ static CXLRetCode cmd_media_inject_poison(const struc=
t cxl_cmd *cmd,
>      struct inject_poison_pl {
>          uint64_t dpa;
>      };
> -    struct inject_poison_pl *in =3D (void *)payload;
> +    struct inject_poison_pl *in =3D (void *)payload_in;
>      uint64_t dpa =3D ldq_le_p(&in->dpa);
>      CXLPoison *p;
> =20
> @@ -592,14 +619,17 @@ static CXLRetCode cmd_media_inject_poison(const str=
uct cxl_cmd *cmd,
>       */
>      QLIST_INSERT_HEAD(poison_list, p, node);
>      ct3d->poison_list_cnt++;
> +    *len_out =3D 0;
> =20
>      return CXL_MBOX_SUCCESS;
>  }
> =20
>  static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> -                                         uint8_t *payload,
> -                                         CXLDeviceState *cxl_dstate,
> -                                         uint16_t *len_unused)
> +                                         uint8_t *payload_in,
> +                                         size_t len_in,
> +                                         uint8_t *payload_out,
> +                                         size_t *len_out,
> +                                         CXLDeviceState *cxl_dstate)
>  {
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      CXLPoisonList *poison_list =3D &ct3d->poison_list;
> @@ -611,7 +641,7 @@ static CXLRetCode cmd_media_clear_poison(const struct=
 cxl_cmd *cmd,
>      CXLPoison *ent;
>      uint64_t dpa;
> =20
> -    struct clear_poison_pl *in =3D (void *)payload;
> +    struct clear_poison_pl *in =3D (void *)payload_in;
> =20
>      dpa =3D ldq_le_p(&in->dpa);
>      if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
> @@ -672,6 +702,7 @@ static CXLRetCode cmd_media_clear_poison(const struct=
 cxl_cmd *cmd,
>      }
>      /* Any fragments have been added, free original entry */
>      g_free(ent);
> +    *len_out =3D 0;
> =20
>      return CXL_MBOX_SUCCESS;
>  }
> @@ -724,15 +755,16 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate=
)
> =20
>      uint8_t set =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
_SET);
>      uint8_t cmd =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
);
> -    uint16_t len =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH=
);
> +    uint16_t len_in =3D FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LEN=
GTH);
>      uint8_t *pl =3D cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
> +    size_t len_out =3D 0;
> =20
>      cxl_cmd =3D &cxl_dstate->cxl_cmd_set[set][cmd];
>      h =3D cxl_cmd->handler;
>      if (h) {
> -        if (len =3D=3D cxl_cmd->in || cxl_cmd->in =3D=3D ~0) {
> -            ret =3D (*h)(cxl_cmd, pl, cxl_dstate, &len);
> -            assert(len <=3D cxl_dstate->payload_size);
> +        if (len_in =3D=3D cxl_cmd->in || cxl_cmd->in =3D=3D ~0) {
> +            ret =3D (*h)(cxl_cmd, pl, len_in, pl, &len_out, cxl_dstate);
> +            assert(len_out <=3D cxl_dstate->payload_size);
>          } else {
>              ret =3D CXL_MBOX_INVALID_PAYLOAD_LENGTH;
>          }
> @@ -748,7 +780,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>      /* Set the return length */
>      command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
_SET, 0);
>      command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND=
, 0);
> -    command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH,=
 len);
> +    command_reg =3D FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH,=
 len_out);
> =20
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] =3D command_reg;
>      cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] =3D status_reg;
> --=20
> 2.39.2
> =
