Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF808C678D4
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 22:49:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjCAWtx (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 17:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjCAWtw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 17:49:52 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AA3303E7
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 14:49:50 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230301224948usoutp01a366b6b55ec8c1f02e8073154be7f58d~IbUFarNuj1111011110usoutp01j;
        Wed,  1 Mar 2023 22:49:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230301224948usoutp01a366b6b55ec8c1f02e8073154be7f58d~IbUFarNuj1111011110usoutp01j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677710988;
        bh=f5fvsfUYLls9BB9PQX6bPnVsXXg60znQjTTWY1wm1NI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=h1FdmlQvEAT9iZxvvx79u3iH4hpPBeNsLEihlJI2OZ5jN/dstpy/XGqYBYxtz/mbZ
         9Bz65/Cw1cYMqpoWi+SO1FyQ/nbfuQ59fmcMPF/iPRn5Xup0Sgh9S2y2g2Pys1PiAW
         LnnSQeqStC6cXDMmPfS6GwMSaW5JgmwV+enEoclY=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230301224948uscas1p124951d22c183dd76cc70d4fb6dab7480~IbUFKioaN1945619456uscas1p1X;
        Wed,  1 Mar 2023 22:49:48 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 0D.3A.49129.C86DFF36; Wed, 
        1 Mar 2023 17:49:48 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230301224948uscas1p25eb7c2a56486532a290fe1bb63553cfd~IbUE3VuUq0297902979uscas1p2y;
        Wed,  1 Mar 2023 22:49:48 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-a6-63ffd68c57ec
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 01.4D.17110.B86DFF36; Wed, 
        1 Mar 2023 17:49:47 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 1 Mar 2023 14:49:47 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        1 Mar 2023 14:49:47 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 1/6] hw/cxl: rename mailbox return code type from
 ret_code to CXLRetCode
Thread-Topic: [PATCH v2 1/6] hw/cxl: rename mailbox return code type from
        ret_code to CXLRetCode
Thread-Index: AQHZSs12BBryuVWrXEqfQPLqBk7SZq7nELuA
Date:   Wed, 1 Mar 2023 22:49:47 +0000
Message-ID: <20230301224940.GA1427276@bgt-140510-bm03>
In-Reply-To: <20230227170311.20054-2-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6C524BE4D72DC844B5C6EEF804BB7B0A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrEKsWRmVeSWpSXmKPExsWy7djXc7o91/4nG1x7J2Bx4mYjm8X+p89Z
        LFYtvMZmcX7WKRaLwxvPMFn8//WK1WLNCmGL4707WBw4PFqOvGX1WLznJZPHnWt72DyeXNvM
        5PF+31U2j8+b5ALYorhsUlJzMstSi/TtErgyJk69xFZw0aGir+UPWwPjDbUuRk4OCQETia5N
        pxlBbCGBlYwSi686dzFyAdmtTBKHOt+zwhS9ffuTGSKxllHiw6keRgjnI6PEiksHmSCcpYwS
        x78fAmthE1CU2Ne1nQ3EFhEwknh3YxJYB7PAMSaJl0uuAhVxcAgLJEpsfSQLUZMksXXFW7j6
        fStuM4GUsAioSOx/lAIS5hUwk7j05AwzSJhTwFFiR2sdSJhRQEzi+6k1TCA2s4C4xK0n85kg
        jhaUWDR7DzOELSbxb9dDNghbUeL+95fsEPV6EjemTmGDsO0kDsz6BjVHW2LZwtfMEGsFJU7O
        fMIC0SspcXDFDRaQTyQEnnBIHF27lx0i4SIxoW0DVJG0xN+7y8DOlxBIllj1kQsinCMxf8kW
        qBJriYV/1jNNYFSZheTsWUhOmoXkpFlITpqF5KQFjKyrGMVLi4tz01OLjfJSy/WKE3OLS/PS
        9ZLzczcxApPV6X+H83cwXr/1Ue8QIxMH4yFGCQ5mJRHehbf/JAvxpiRWVqUW5ccXleakFh9i
        lOZgURLnNbQ9mSwkkJ5YkpqdmlqQWgSTZeLglGpgCg5r278vbF70qyN+8za6d8oXr3jmeryn
        9ubM76KzvCep8fjx5rS8jZwZfKGDiY+XyeMDa9Dskj8lOQti7/9ams1YLGqbL/grJsFK2Yfb
        UFWuvPr+n1t+60rm/q6b8ihFUFHu1/IrykmTT+abbLjt2amYwTtb5xf/hRNveB0FFNzlyk4b
        dvLInU+u25LMmrecOZUpldsu7Kt174u7PFpn/2VWv8spfZOZdiXGT+aum19lyd5arwvH9lwS
        9J+0rfvPzbXuqQFzk/f/vuOuy2X28YaxhSn7702iSR79P+O/zn/Qfvv/0a+SLYeT5L9K5nfv
        qTnXnS55faHlpJUnEw0vx8t1HPy1siRp87VPBquUWIozEg21mIuKEwHP9fXZxQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrPIsWRmVeSWpSXmKPExsWS2cA0Sbf72v9kg5P3rSxO3Gxks9j/9DmL
        xaqF19gszs86xWJxeOMZJov/v16xWqxZIWxxvHcHiwOHR8uRt6wei/e8ZPK4c20Pm8eTa5uZ
        PN7vu8rm8XmTXABbFJdNSmpOZllqkb5dAlfGxKmX2AouOlT0tfxha2C8odbFyMkhIWAi8fbt
        T+YuRi4OIYHVjBLtN6+xgCSEBD4ySvS+0oNILGWUeHRrNjNIgk1AUWJf13Y2EFtEwEji3Y1J
        jCA2s8AxJok9T8y6GDk4hAUSJbY+koUoSZLo7j/CDlO+b8VtJpASFgEVif2PUkDCvAJmEpee
        nGGGWFsuMePSFlaQEk4BR4kdrXUgYUYBMYnvp9YwQSwSl7j1ZD4TxPkCEkv2nGeGsEUlXj7+
        xwphK0rc//6SHaJeT+LG1ClsELadxIFZ36DmaEssW/iaGeIEQYmTM5+wQPRKShxccYNlAqPE
        LCTrZiEZNQvJqFlIRs1CMmoBI+sqRvHS4uLc9Ipio7zUcr3ixNzi0rx0veT83E2MwDg//e9w
        9A7G27c+6h1iZOJgPMQowcGsJMK78PafZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8L6MmxgsJ
        pCeWpGanphakFsFkmTg4pRqYKk3WR4e98JqZdYNXWU7V69jZX/PPBTXW5exe+WHBb//yH5rn
        dvonb3ezijvl9ef4i76Jm77fC/h5fL32Oj7ZQvNNG+8eahDQu+T25OeiRyfv+vvPrgmqfzFR
        zbP3U0aBbr/goZ2PZ3L+EPqu5PqN7yiH05o2/h1LxGe7Rv6/WjnV3vlVgLlyE3PH3Dsdh4JL
        DoSf6vVi/+j9Zn260wuNVEUZps/X6p2O/fQ0F5l2Sb9/m0/10pe+K7W6njfvrckzcGyxf7Pt
        2zzRJ+6mPOZhqVMUP+xUMtD+6urLrXWe/byxVc2KgwobVeLbpG3z16pcnq02WafWsNm+55/g
        y1V8t2WskmJXT5x0bMHNOO3lSizFGYmGWsxFxYkAHu04F2IDAAA=
X-CMS-MailID: 20230301224948uscas1p25eb7c2a56486532a290fe1bb63553cfd
CMS-TYPE: 301P
X-CMS-RootMailID: 20230301224948uscas1p25eb7c2a56486532a290fe1bb63553cfd
References: <20230227170311.20054-1-Jonathan.Cameron@huawei.com>
        <20230227170311.20054-2-Jonathan.Cameron@huawei.com>
        <CGME20230301224948uscas1p25eb7c2a56486532a290fe1bb63553cfd@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 27, 2023 at 05:03:06PM +0000, Jonathan Cameron wrote:
> Given the increasing usage of this mailbox return code type, now
> is a good time to switch to QEMU style naming.
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> --
> v7: (thanks to Ira Weiny for review)
> - Rename in place as the move to the header isn't needed for this series
>   That move patch will now be the start of the CXL events series that
>   will follow this one.
> ---
>  hw/cxl/cxl-mailbox-utils.c | 64 +++++++++++++++++++-------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index ed663cc04a..7b2aef0d67 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -23,7 +23,7 @@
>   *     FOO    =3D 0x7f,
>   *          #define BAR 0
>   *  2. Implement the handler
> - *    static ret_code cmd_foo_bar(struct cxl_cmd *cmd,
> + *    static CXLRetCode cmd_foo_bar(struct cxl_cmd *cmd,
>   *                                  CXLDeviceState *cxl_dstate, uint16_t=
 *len)
>   *  3. Add the command to the cxl_cmd_set[][]
>   *    [FOO][BAR] =3D { "FOO_BAR", cmd_foo_bar, x, y },
> @@ -90,10 +90,10 @@ typedef enum {
>      CXL_MBOX_UNSUPPORTED_MAILBOX =3D 0x15,
>      CXL_MBOX_INVALID_PAYLOAD_LENGTH =3D 0x16,
>      CXL_MBOX_MAX =3D 0x17
> -} ret_code;
> +} CXLRetCode;
> =20
>  struct cxl_cmd;
> -typedef ret_code (*opcode_handler)(struct cxl_cmd *cmd,
> +typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
>                                     CXLDeviceState *cxl_dstate, uint16_t =
*len);
>  struct cxl_cmd {
>      const char *name;
> @@ -105,16 +105,16 @@ struct cxl_cmd {
> =20
>  #define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                       =
  \
>      uint16_t __zero##name =3D size;                                     =
    \
> -    static ret_code cmd_##name(struct cxl_cmd *cmd,                     =
  \
> -                               CXLDeviceState *cxl_dstate, uint16_t *len=
) \
> +    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                   =
    \
> +                                 CXLDeviceState *cxl_dstate, uint16_t *l=
en) \
>      {                                                                   =
  \
>          *len =3D __zero##name;                                          =
    \
>          memset(cmd->payload, 0, *len);                                  =
  \
>          return CXL_MBOX_SUCCESS;                                        =
  \
>      }
>  #define DEFINE_MAILBOX_HANDLER_NOP(name)                                =
  \
> -    static ret_code cmd_##name(struct cxl_cmd *cmd,                     =
  \
> -                               CXLDeviceState *cxl_dstate, uint16_t *len=
) \
> +    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                   =
    \
> +                                 CXLDeviceState *cxl_dstate, uint16_t *l=
en) \
>      {                                                                   =
  \
>          return CXL_MBOX_SUCCESS;                                        =
  \
>      }
> @@ -125,9 +125,9 @@ DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_po=
licy, 4);
>  DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
> =20
>  /* 8.2.9.2.1 */
> -static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> -                                             CXLDeviceState *cxl_dstate,
> -                                             uint16_t *len)
> +static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
> +                                               CXLDeviceState *cxl_dstat=
e,
> +                                               uint16_t *len)
>  {
>      struct {
>          uint8_t slots_supported;
> @@ -159,9 +159,9 @@ static ret_code cmd_firmware_update_get_info(struct c=
xl_cmd *cmd,
>  }
> =20
>  /* 8.2.9.3.1 */
> -static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
> -                                  CXLDeviceState *cxl_dstate,
> -                                  uint16_t *len)
> +static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
> +                                    CXLDeviceState *cxl_dstate,
> +                                    uint16_t *len)
>  {
>      uint64_t time, delta;
>      uint64_t final_time =3D 0;
> @@ -181,7 +181,7 @@ static ret_code cmd_timestamp_get(struct cxl_cmd *cmd=
,
>  }
> =20
>  /* 8.2.9.3.2 */
> -static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
> +static CXLRetCode cmd_timestamp_set(struct cxl_cmd *cmd,
>                                    CXLDeviceState *cxl_dstate,
>                                    uint16_t *len)
>  {
> @@ -201,9 +201,9 @@ static const QemuUUID cel_uuid =3D {
>  };
> =20
>  /* 8.2.9.4.1 */
> -static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
> -                                       CXLDeviceState *cxl_dstate,
> -                                       uint16_t *len)
> +static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
> +                                         CXLDeviceState *cxl_dstate,
> +                                         uint16_t *len)
>  {
>      struct {
>          uint16_t entries;
> @@ -224,9 +224,9 @@ static ret_code cmd_logs_get_supported(struct cxl_cmd=
 *cmd,
>  }
> =20
>  /* 8.2.9.4.2 */
> -static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
> -                                 CXLDeviceState *cxl_dstate,
> -                                 uint16_t *len)
> +static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
> +                                   CXLDeviceState *cxl_dstate,
> +                                   uint16_t *len)
>  {
>      struct {
>          QemuUUID uuid;
> @@ -265,9 +265,9 @@ static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
>  }
> =20
>  /* 8.2.9.5.1.1 */
> -static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
> -                                           CXLDeviceState *cxl_dstate,
> -                                           uint16_t *len)
> +static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
> +                                             CXLDeviceState *cxl_dstate,
> +                                             uint16_t *len)
>  {
>      struct {
>          char fw_revision[0x10];
> @@ -309,9 +309,9 @@ static ret_code cmd_identify_memory_device(struct cxl=
_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> -                                           CXLDeviceState *cxl_dstate,
> -                                           uint16_t *len)
> +static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
> +                                              CXLDeviceState *cxl_dstate=
,
> +                                              uint16_t *len)
>  {
>      struct {
>          uint64_t active_vmem;
> @@ -339,9 +339,9 @@ static ret_code cmd_ccls_get_partition_info(struct cx=
l_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
> -                                 CXLDeviceState *cxl_dstate,
> -                                 uint16_t *len)
> +static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
> +                                   CXLDeviceState *cxl_dstate,
> +                                   uint16_t *len)
>  {
>      struct {
>          uint32_t offset;
> @@ -364,9 +364,9 @@ static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
> -                                 CXLDeviceState *cxl_dstate,
> -                                 uint16_t *len)
> +static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
> +                                   CXLDeviceState *cxl_dstate,
> +                                   uint16_t *len)
>  {
>      struct set_lsa_pl {
>          uint32_t offset;
> --=20
> 2.37.2
>=20
>=20
