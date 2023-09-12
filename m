Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8AF23EE3F31
	for <linux-cxl@archiver.kernel.org>; Tue, 12 Sep 2023 21:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbjILVMw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 12 Sep 2023 17:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjILVMw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 12 Sep 2023 17:12:52 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D31E10CA
        for <linux-cxl@vger.kernel.org>; Tue, 12 Sep 2023 14:12:48 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230912211247usoutp0264d047a72e0f8c56d2d8c010abd4b02f~EQyCw7nWT2864628646usoutp02U;
        Tue, 12 Sep 2023 21:12:47 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230912211247usoutp0264d047a72e0f8c56d2d8c010abd4b02f~EQyCw7nWT2864628646usoutp02U
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1694553167;
        bh=vrJ9Xv0nSeHw73RZ0ZY6/6CHdHdk1ntnj1JgD0HIubQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WKfahQ2fjuf+EvrX5OzvqFk+ZbXDfYOqasKT2edRb5R/Ya6frFe2EmDTLYO/qYtIr
         RVXefGlJlNHeGoWDEs/vP06z7LBvEXfEQEYPjTXFWo9MTNXqonhJkAY2z77xC4gVmb
         3XCL5J1gxemyOCBkKcbrLEBYVi4lpkIy2ENTBLv0=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230912211247uscas1p2dbe4c2433b7eac59b638b1d36ec72a45~EQyClPOHI0466504665uscas1p2X;
        Tue, 12 Sep 2023 21:12:47 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 62.22.62237.F44D0056; Tue,
        12 Sep 2023 17:12:47 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230912211246uscas1p168389b2f62884b970e348f8b94e550d2~EQyCRsahY1803918039uscas1p1E;
        Tue, 12 Sep 2023 21:12:46 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-11-6500d44f192a
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 59.22.31200.E44D0056; Tue,
        12 Sep 2023 17:12:46 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 12 Sep 2023 14:12:46 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        12 Sep 2023 14:12:46 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Dave Jiang <dave.jiang@intel.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>
Subject: Re: [PATCH v2 2/3] hw/cxl: Add QTG _DSM support for ACPI0017 device
Thread-Topic: [PATCH v2 2/3] hw/cxl: Add QTG _DSM support for ACPI0017
        device
Thread-Index: AQHZ30ukYJg3kNCKi0GmQIpXWUW3L7AYMoGA
Date:   Tue, 12 Sep 2023 21:12:45 +0000
Message-ID: <20230912211245.GC2828853@sjcvldevvm72>
In-Reply-To: <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <0470824E4FEA984DA883B903FA2F7BC7@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrAKsWRmVeSWpSXmKPExsWy7djXc7r+VxhSDZoP8lmcuNnIZrFq4TU2
        i/OzTrFYHN54hsni/69XrBZrVghbHO/dweLA7tFy5C2rx+I9L5k87lzbw+bx5NpmJo/3+66y
        eXzeJBfAFsVlk5Kak1mWWqRvl8CVsfzRH7aCDo2Kr4/uMDUw9kp3MXJySAiYSFyY9oC5i5GL
        Q0hgJaPEp18PWCCcViaJTXcOssBUzWm8AFW1llHi2IY1rBDOJ0aJZ/8eQmWWMUpMebyUCaSF
        TUBRYl/XdjYQW0TASOLdjUmMIDazwGImifa/VSC2sICPxPHfjYwQNf4S+5t+s8DUL371EMxm
        EVCVaF66DKyGV8BY4uLDZ2A2p4CjxIZpb8HmMwqISXw/tYYJYr64xK0n85kgzhaUWDR7DzOE
        LSbxb9dDNghbUeL+95fsEPV6EjemTmGDsO0kFrVfh7K1JZYtfM0MsVdQ4uTMJ9CgkJQ4uOIG
        OIwkBO5wSHzvfgS1wEVi/Yxv7BC2tMTfu8uAjuAAspMlVn3kggjnSMxfsgVqjrXEwj/rmSYw
        qsxCcvYsJCfNQnLSLCQnzUJy0gJG1lWM4qXFxbnpqcXGeanlesWJucWleel6yfm5mxiBier0
        v8MFOxhv3fqod4iRiYPxEKMEB7OSCG/Job8pQrwpiZVVqUX58UWlOanFhxilOViUxHkNbU8m
        CwmkJ5akZqemFqQWwWSZODilGpjydt2PsThlWywU4RM+e8FcTtc3O+89YAhwMj+otf/wFCa5
        aVHWeldX3TjRcZf56Zn7Da/5WtyY2njKVM5xf84/1axy4fwq29t3W83FVup7OU83P+D9b5u9
        xCGWz1umGEf4ajc1dwdZH562/rPxcafeKSumvvNanbRFSVVCTNTyaf6GvB3BPbcKH0a7d618
        er2675bTivaQnXcXzGapzyzh2mOtpRV6X+f9l4hJ91XEFhp083QfbrMP2cv3hs9Ny6+qxlJd
        PyygdE2zdPeSNIP0r7/s1rK+COlKnpu22uvbrzvNeULx5jGuezx+6uZMWz11Vrxx5pTQfb/2
        Vy9tvdq71HpdZkfvbTFb4QNJd5VYijMSDbWYi4oTAXY4WfPDAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0SdfvCkOqwdkfRhYnbjayWaxaeI3N
        4vysUywWhzeeYbL4/+sVq8WaFcIWx3t3sDiwe7QcecvqsXjPSyaPO9f2sHk8ubaZyeP9vqts
        Hp83yQWwRXHZpKTmZJalFunbJXBlLH/0h62gQ6Pi66M7TA2MvdJdjJwcEgImEnMaLzB3MXJx
        CAmsZpRofrCTHcL5xCjxbclPFghnGaPE+i/rmUFa2AQUJfZ1bWcDsUUEjCTe3ZjECGIzCyxm
        kmj/WwViCwv4SBz/3cgIUeMr8XHuVHaY+sWvHrKA2CwCqhLNS5eB1fAKGEtcfPgMzBYSKJfo
        mNXPCmJzCjhKbJj2FmwXo4CYxPdTa5ggdolL3HoynwniBQGJJXvOM0PYohIvH/9jhbAVJe5/
        f8kOUa8ncWPqFDYI205iUft1KFtbYtnC18wQNwhKnJz5hAWiV1Li4IobLBMYJWYhWTcLyahZ
        SEbNQjJqFpJRCxhZVzGKlxYX56ZXFBvlpZbrFSfmFpfmpesl5+duYgRG+el/h6N3MN6+9VHv
        ECMTB+MhRgkOZiUR3pJDf1OEeFMSK6tSi/Lji0pzUosPMUpzsCiJ8+6YcjFFSCA9sSQ1OzW1
        ILUIJsvEwSnVwGS24OIes7e6YUv/7v2yaenhIx1MZ7pTE85VyE8vqrHl2fru6GsJ14sXHgYq
        LZmwW+5Ej43Cl2zHTZf1Cyd0+WgINm1vfNX878LLM/2v014vV2ucExi08Sxj7ZdKpbkJ/Fpn
        t3/XurX8gdrsPd8yJqXmcSlsZTw3uUvGPbLIRqG2Yv3x6JcXqnwvPjZgU2xfeabwOlv6CcNj
        dh+eBc3Sl3+1fnJMpUC393tlmZRSt6BF/ifVHJY3vergXeXOaOkeavfwl/nKb7xcEx0e+W05
        +F38Taxw+zy1V5NZnNnddJJNjWMnJdyNyDjWz/b+/J78vYuO6Uc4TezPW+20dNH91FW/TjX5
        uSyM7BAQlrXiaFFiKc5INNRiLipOBABCQuh7YQMAAA==
X-CMS-MailID: 20230912211246uscas1p168389b2f62884b970e348f8b94e550d2
CMS-TYPE: 301P
X-CMS-RootMailID: 20230912211246uscas1p168389b2f62884b970e348f8b94e550d2
References: <20230904161847.18468-1-Jonathan.Cameron@huawei.com>
        <20230904161847.18468-3-Jonathan.Cameron@huawei.com>
        <CGME20230912211246uscas1p168389b2f62884b970e348f8b94e550d2@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Sep 04, 2023 at 05:18:46PM +0100, Jonathan Cameron wrote:

> From: Dave Jiang <dave.jiang@intel.com>
>=20
> Add a simple _DSM call support for the ACPI0017 device to return a fake Q=
TG
> ID value of 0 in all cases. The enabling is for _DSM plumbing testing
> from the OS.
>=20
> Following edited for readbility only
>=20
> Device (CXLM)
> {
>     Name (_HID, "ACPI0017")  // _HID: Hardware ID
> ...
>     Method (_DSM, 4, Serialized)  // _DSM: Device-Specific Method
>     {
>         If ((Arg0 =3D=3D ToUUID ("f365f9a6-a7de-4071-a66a-b40c0b4f8e52"))=
)
>         {
>             If ((Arg2 =3D=3D Zero))
>             {
>                 Return (Buffer (One) { 0x01 })
>             }
>=20
>             If ((Arg2 =3D=3D One))
>             {
>                 Return (Package (0x02)
>                 {
>                     Buffer (0x02)
>                     { 0x01, 0x00 },
>                     Package (0x01)
>                     {
>                         Buffer (0x02)
>                         { 0x00, 0x00 }
>                     }
>                 })
>             }
>         }
>     }
>=20
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Looks good to me. One minor comment inline.
>=20
> --
> v2: Minor edit to drop reference to switches in patch description.
> ---
>  include/hw/acpi/cxl.h |  1 +
>  hw/acpi/cxl.c         | 57 +++++++++++++++++++++++++++++++++++++++++++
>  hw/i386/acpi-build.c  |  1 +
>  3 files changed, 59 insertions(+)
>=20
> diff --git a/include/hw/acpi/cxl.h b/include/hw/acpi/cxl.h
> index acf4418886..8f22c71530 100644
> --- a/include/hw/acpi/cxl.h
> +++ b/include/hw/acpi/cxl.h
> @@ -25,5 +25,6 @@ void cxl_build_cedt(GArray *table_offsets, GArray *tabl=
e_data,
>                      BIOSLinker *linker, const char *oem_id,
>                      const char *oem_table_id, CXLState *cxl_state);
>  void build_cxl_osc_method(Aml *dev);
> +void build_cxl_dsm_method(Aml *dev);
> =20
>  #endif
> diff --git a/hw/acpi/cxl.c b/hw/acpi/cxl.c
> index 92b46bc932..5e9039785a 100644
> --- a/hw/acpi/cxl.c
> +++ b/hw/acpi/cxl.c
> @@ -30,6 +30,63 @@
>  #include "qapi/error.h"
>  #include "qemu/uuid.h"
> =20
> +void build_cxl_dsm_method(Aml *dev)

Not a concern for now, I think, do we need to check the revision
field?

Fan
> +{
> +    Aml *method, *ifctx, *ifctx2;
> +
> +    method =3D aml_method("_DSM", 4, AML_SERIALIZED);
> +    {
> +        Aml *function, *uuid;
> +
> +        uuid =3D aml_arg(0);
> +        function =3D aml_arg(2);
> +        /* CXL spec v3.0 9.17.3.1 *, QTG ID _DSM */
> +        ifctx =3D aml_if(aml_equal(
> +            uuid, aml_touuid("F365F9A6-A7DE-4071-A66A-B40C0B4F8E52")));
> +
> +        /* Function 0, standard DSM query function */
> +        ifctx2 =3D aml_if(aml_equal(function, aml_int(0)));
> +        {
> +            uint8_t byte_list[1] =3D { 0x01 }; /* functions 1 only */
> +
> +            aml_append(ifctx2,
> +                       aml_return(aml_buffer(sizeof(byte_list), byte_lis=
t)));
> +        }
> +        aml_append(ifctx, ifctx2);
> +
> +        /*
> +         * Function 1
> +         * A return value of {1, {0}} inciate that
> +         * max supported QTG ID of 1 and recommended QTG is 0.
> +         * The values here are faked to simplify emulation.
> +         */
> +        ifctx2 =3D aml_if(aml_equal(function, aml_int(1)));
> +        {
> +            uint16_t word_list[1] =3D { 0x01 };
> +            uint16_t word_list2[1] =3D { 0 };
> +            uint8_t *byte_list =3D (uint8_t *)word_list;
> +            uint8_t *byte_list2 =3D (uint8_t *)word_list2;
> +            Aml *pak, *pak1;
> +
> +            /*
> +             * The return package is a package of a WORD and another pac=
kage.
> +             * The embedded package contains 0 or more WORDs for the
> +             * recommended QTG IDs.
> +             */
> +            pak1 =3D aml_package(1);
> +            aml_append(pak1, aml_buffer(sizeof(uint16_t), byte_list2));
> +            pak =3D aml_package(2);
> +            aml_append(pak, aml_buffer(sizeof(uint16_t), byte_list));
> +            aml_append(pak, pak1);
> +
> +            aml_append(ifctx2, aml_return(pak));
> +        }
> +        aml_append(ifctx, ifctx2);
> +    }
> +    aml_append(method, ifctx);
> +    aml_append(dev, method);
> +}
> +
>  static void cedt_build_chbs(GArray *table_data, PXBCXLDev *cxl)
>  {
>      PXBDev *pxb =3D PXB_DEV(cxl);
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index bb12b0ad43..d3bc5875eb 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1422,6 +1422,7 @@ static void build_acpi0017(Aml *table)
>      method =3D aml_method("_STA", 0, AML_NOTSERIALIZED);
>      aml_append(method, aml_return(aml_int(0x01)));
>      aml_append(dev, method);
> +    build_cxl_dsm_method(dev);
> =20
>      aml_append(scope, dev);
>      aml_append(table, scope);
> --=20
> 2.39.2
>=20
> =
