Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C274CC64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:15:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjB1EPQ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbjB1EPP (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:15:15 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9D6222C2
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:15:13 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041512usoutp02e0edf6a787fb51eff9907da1cf1b4e07~H4dndybJi1262212622usoutp02N;
        Tue, 28 Feb 2023 04:15:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230228041512usoutp02e0edf6a787fb51eff9907da1cf1b4e07~H4dndybJi1262212622usoutp02N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557712;
        bh=mbIzfCKyjKaIdxH+/8k1JP3aVSVXGPmWKDnEDTqqy2A=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=sTQXId+MAtQWy/JzUZ24W07aR8PXlMzL5XGb3p7Vf2F/iLkLInvb29OE7cLLDIOYn
         69zgmU2sDdB1b3K5bOopvKDOD3b+hdljW/h+kP/aukCzex2WF/bWHi3ZpIn+3WbPRC
         7aLOI3q4/jdR00PgViVssr+/Pl8UNUyqhsWe312c=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041511uscas1p2a3b6888d9d31f0b0ff7df80e5fc9db97~H4dnTeMyo2463924639uscas1p23;
        Tue, 28 Feb 2023 04:15:11 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 15.F2.12196.FCF7DF36; Mon,
        27 Feb 2023 23:15:11 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041511uscas1p29bfa83f0efe2632d89d5d76ea1be0245~H4dnIHYPE2463924639uscas1p22;
        Tue, 28 Feb 2023 04:15:11 +0000 (GMT)
X-AuditID: cbfec370-5b3ff70000012fa4-7d-63fd7fcf534d
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id F2.F8.17110.FCF7DF36; Mon,
        27 Feb 2023 23:15:11 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:15:10 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:15:10 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 10/10] hw/cxl/mailbox: Use new UUID network order
 define for cel_uuid
Thread-Topic: [PATCH v4 10/10] hw/cxl/mailbox: Use new UUID network order
        define for cel_uuid
Thread-Index: AQHZSys/HAMpeEHzhUiuPAL7AephLA==
Date:   Tue, 28 Feb 2023 04:15:10 +0000
Message-ID: <20230228041510.GJ1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-11-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <E6FC4462C9BFC14882EAD423592C39A1@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrIKsWRmVeSWpSXmKPExsWy7djX87rn6/8mG3ydYGLRPHkxo8WLP8+Z
        LPY/fc5isWrhNTaL87NOsVgc3niGyeL/r1esFmtWCFsc793B4sDpsXPWXXaPliNvWT0W73nJ
        5LFpVSebx51re9g8nlzbzOTxft9VNo/Pm+QCOKK4bFJSczLLUov07RK4MhYe3sVeMFGm4ugy
        jQbG2WJdjJwcEgImEhf/zWbvYuTiEBJYySjx+v9VNpCEkEArk8SXDwIwRacb9jFCFK1llHh6
        CqQIxPnEKNFz4xErhLOMUeLEyjZmkBY2AUWJfV3bwUaJCBhJvLsxCaydWeALk8TUuxtZQBLC
        AnESG78vZoUoipdY3bwOqkFPYvOK52A1LAKqEqf3bwOL8wqYSUz4uJIdxOYUcJRY9LIRrIZR
        QEzi+6k1TCA2s4C4xK0n85kg7haUWDR7DzOELSbxb9dDNghbUeL+95fsEPV6EjemTgGKcwDZ
        dhIfblhAhLUlli18zQyxVlDi5MwnLBCtkhIHV9xgAflFQqCZU+LHiw1QCReJE0ffQe2Slvh7
        dxkTyEwJgWSJVR+5IMI5EvOXbIEqt5ZY+Gc90wRGlVlIrp6F5KJZCBfNQnLRLCQXLWBkXcUo
        XlpcnJueWmycl1quV5yYW1yal66XnJ+7iRGYyk7/O1ywg/HWrY96hxiZOBgPMUpwMCuJ8C68
        /SdZiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+h7clkIYH0xJLU7NTUgtQimCwTB6dUA1PB3aod
        dfq3zmswtxyR8d32uLM+91bI60c56q8Zuf3sDkh+bzTrlDG79UP9ScSxaplFV+aKtpfM38Fx
        1//Jp9O8wgf/TvgekuMzuzBg2ltOl6NB8u0T/z5If7ukVNkhbNW6UIPW7tdiqnu0Ni/p5Z2l
        WG9rs6NqwtSuSR4sxn9kFkWV5jNz2HazL5kjL3cn5jVHnmm3adK74nSXxg8cpzkeJcqfm2XT
        Ib1gy98NL04EXHZcZP9swdb4d08X9tR9XxGk7aoQX/mwJCvvdNmW3S3RNTpNQg8q1qjrvfiw
        2qPMerflnenOFcq+eZ2ed8JcVOZOEA2Jbwi/+PHN0quxN6duPevBOn/GdhFlHhFlDiWW4oxE
        Qy3mouJEAFqhZxfUAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWS2cA0Sfd8/d9kg7OHVC2aJy9mtHjx5zmT
        xf6nz1ksVi28xmZxftYpFovDG88wWfz/9YrVYs0KYYvjvTtYHDg9ds66y+7RcuQtq8fiPS+Z
        PDat6mTzuHNtD5vHk2ubmTze77vK5vF5k1wARxSXTUpqTmZZapG+XQJXxsLDu9gLJspUHF2m
        0cA4W6yLkZNDQsBE4nTDPsYuRi4OIYHVjBIbT85kgnA+MUrcP7EaylnGKDFxbgc7SAubgKLE
        vq7tbCC2iICRxLsbk8DamQW+MEnc+PCdBSQhLBAnsfH7YlaIoniJ21f2M0PYehKbVzwHq2ER
        UJU4vX8b2CBeATOJCR9XAi3gANpWJrHjUApImFPAUWLRy0awckYBMYnvp9YwgdjMAuISt57M
        Z4J4QUBiyZ7zzBC2qMTLx/9YIWxFifvfX7JD1OtJ3Jg6hQ1kPLOAncSHGxYQYW2JZQtfM0Nc
        IChxcuYTFohWSYmDK26wTGCUmIVk2ywkk2YhTJqFZNIsJJMWMLKuYhQvLS7OTa8oNspLLdcr
        TswtLs1L10vOz93ECEwDp/8djt7BePvWR71DjEwcjIcYJTiYlUR4F97+kyzEm5JYWZValB9f
        VJqTWnyIUZqDRUmc92XUxHghgfTEktTs1NSC1CKYLBMHp1QDk/u9Wxde97EeXbSk58qz9F2T
        KpnbXSZPefqFOe3YLJajjsseuoUqp61bo6+/64ey//Ns84BAy6xKWdPJeU+vPPVoTb1YPs3I
        zzTOakbw9bq188VPfNkQvS/z4nFu3QsHbYUrs5W+rN6w+L7Ygb+Gos75i+88vVXvybcwl62a
        aenTp9XTdq6QV3Ll8Ddls6vhMHk/41ua8snPv9LPK12KkF7+2TSS63quUnvz8f5i36dOn69d
        vXZUdXt/isq7s+e8GJYd2swklK8b3fS1rJt534LTuixr3q3ojPd4UZ0lJ7WuqN72Dsf+ZqPp
        53dvfjDzEsM3yY2Rdbrrnkm/ncTRbj5Tqn/lDNZq+8Qjqwwe9CuxFGckGmoxFxUnAgD6m7Hs
        cgMAAA==
X-CMS-MailID: 20230228041511uscas1p29bfa83f0efe2632d89d5d76ea1be0245
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041511uscas1p29bfa83f0efe2632d89d5d76ea1be0245
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-11-Jonathan.Cameron@huawei.com>
        <CGME20230228041511uscas1p29bfa83f0efe2632d89d5d76ea1be0245@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:16PM +0000, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> The cel_uuid was programatically generated previously because there was
> no static initializer for network order UUIDs.
>=20
> Use the new network order initializer for cel_uuid.  Adjust
> cxl_initialize_mailbox() because it can't fail now.
>=20
> Update specification reference.
>=20
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
> v2:
> Make it const (Philippe)
> ---
>  hw/cxl/cxl-device-utils.c   |  2 +-
>  hw/cxl/cxl-mailbox-utils.c  | 13 ++++++-------
>  include/hw/cxl/cxl_device.h |  2 +-
>  3 files changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 83ce7a8270..4c5e88aaf5 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -267,5 +267,5 @@ void cxl_device_register_init_common(CXLDeviceState *=
cxl_dstate)
>      cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000);
>      memdev_reg_init_common(cxl_dstate);
> =20
> -    assert(cxl_initialize_mailbox(cxl_dstate) =3D=3D 0);
> +    cxl_initialize_mailbox(cxl_dstate);
>  }
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 3f67b665f5..206e04a4b8 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -193,7 +193,11 @@ static ret_code cmd_timestamp_set(struct cxl_cmd *cm=
d,
>      return CXL_MBOX_SUCCESS;
>  }
> =20
> -static QemuUUID cel_uuid;
> +/* CXL 3.0 8.2.9.5.2.1 Command Effects Log (CEL) */
> +static const QemuUUID cel_uuid =3D {
> +    .data =3D UUID(0x0da9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79,
> +                 0x96, 0xb1, 0x62, 0x3b, 0x3f, 0x17)
> +};
> =20
>  /* 8.2.9.4.1 */
>  static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
> @@ -458,11 +462,8 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
>                       DOORBELL, 0);
>  }
> =20
> -int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
> +void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
>  {
> -    /* CXL 2.0: Table 169 Get Supported Logs Log Entry */
> -    const char *cel_uuidstr =3D "0da9c0b5-bf41-4b78-8f79-96b1623b3f17";
> -
>      for (int set =3D 0; set < 256; set++) {
>          for (int cmd =3D 0; cmd < 256; cmd++) {
>              if (cxl_cmd_set[set][cmd].handler) {
> @@ -476,6 +477,4 @@ int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate=
)
>              }
>          }
>      }
> -
> -    return qemu_uuid_parse(cel_uuidstr, &cel_uuid);
>  }
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 250adf18b2..7e5ad65c1d 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -170,7 +170,7 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
>                                        CXL_DEVICE_CAP_HDR1_OFFSET +
>                                            CXL_DEVICE_CAP_REG_SIZE * 2)
> =20
> -int cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
> +void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
>  void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
> =20
>  #define cxl_device_cap_init(dstate, reg, cap_id)                        =
   \
> --=20
> 2.37.2
>=20
> =
