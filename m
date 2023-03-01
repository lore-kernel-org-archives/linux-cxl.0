Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF715C7EE23
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Mar 2023 23:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbjCAXIK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Mar 2023 18:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjCAXIJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Mar 2023 18:08:09 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AEBE10F4
        for <linux-cxl@vger.kernel.org>; Wed,  1 Mar 2023 15:08:03 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230301230801usoutp01e18460aca9706999ef4e868f100599db~Ibj-ooO7J0175701757usoutp01T;
        Wed,  1 Mar 2023 23:08:01 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230301230801usoutp01e18460aca9706999ef4e868f100599db~Ibj-ooO7J0175701757usoutp01T
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677712082;
        bh=y6FMdj3R2ywpEtjkQRKVB8R956ygW+EjM8G+qnRkorM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZORRYD0C8kg86LL1NDwT31gDz2FaNlJXD4h6Kq72V/YRA+zTN0Hel3hPMO5OH6BnU
         /uGPLk2kLYfoRfCEqCGX7CikvLYQ3gpgtPpiLwaXnYe+PLgitTOPMXoLxThQpvIGam
         tCArHZFriA4qPX7EWo2QlW+EFwM1xVFOilSPOcRw=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230301230801uscas1p1054b7f07a54841f9f896061d74d6187c~Ibj-d0QIy2899428994uscas1p1j;
        Wed,  1 Mar 2023 23:08:01 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id A4.5C.49129.1DADFF36; Wed, 
        1 Mar 2023 18:08:01 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230301230801uscas1p155098774d0f921b4fd8a1f683343481c~Ibj-Q1Lm91447514475uscas1p13;
        Wed,  1 Mar 2023 23:08:01 +0000 (GMT)
X-AuditID: cbfec36f-eddff7000001bfe9-27-63ffdad1c966
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 99.CE.11378.1DADFF36; Wed, 
        1 Mar 2023 18:08:01 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 1 Mar 2023 15:08:00 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        1 Mar 2023 15:08:00 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH v2 2/6] hw/cxl: Introduce cxl_device_get_timestamp()
 utility function
Thread-Topic: [PATCH v2 2/6] hw/cxl: Introduce cxl_device_get_timestamp()
        utility function
Thread-Index: AQHZSs2JfYF69ar8nESkKIBaSgB23a7nFdOA
Date:   Wed, 1 Mar 2023 23:08:00 +0000
Message-ID: <20230301230753.GA1429848@bgt-140510-bm03>
In-Reply-To: <20230227170311.20054-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <01E891F4041D8B479DCB830395ECABAF@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMKsWRmVeSWpSXmKPExsWy7djX87oXb/1PNpjZpGNx4mYjm8X+p89Z
        LFYtvMZmcX7WKRaLwxvPMFn8//WK1WLNCmGL4707WBw4PFqOvGX1WLznJZPHnWt72DyeXNvM
        5PF+31U2j8+b5ALYorhsUlJzMstSi/TtErgyuvfuZitYKF7R2zWBsYGxW6iLkZNDQsBEoql1
        CiuILSSwklHiyGTGLkYuILuVSWJK00EWmKLeD/uhEmsZJWZvvs4E4XxklHi9/C5UZimjxJOP
        m8FmsQkoSuzr2s4GYosIGEm8uzEJrIhZ4BiTxMslV8GKhAWiJT5t+8sCURQj0bLnClARB1jD
        hNmhIGEWARWJiXtPgM3hFTCTOLzlLRNICaeAo8S2HieQMKOAmMT3U2uYQGxmAXGJW0/mM0Fc
        LSixaPYeZghbTOLfrodsELaixP3vL9kh6vUkbkydwgZh20lce/iKBcLWlli28DUzxFpBiZMz
        n0BDQlLi4IobLCCvSAi84JDoOf8ZaqiLxPzZS9ghbGmJq9enMoPcKSGQLLHqIxdEOEdi/pIt
        UHOsJRb+Wc80gVFlFpKzZyE5aRaSk2YhOWkWkpMWMLKuYhQvLS7OTU8tNspLLdcrTswtLs1L
        10vOz93ECExXp/8dzt/BeP3WR71DjEwcjIcYJTiYlUR4F97+kyzEm5JYWZValB9fVJqTWnyI
        UZqDRUmc19D2ZLKQQHpiSWp2ampBahFMlomDU6qBaUrruvYFsu4HGUT7S49dshE/z/sj8c71
        LNWJPiu6lunwTpWKXdTNrxS311VJxopPSGPS5mlZbhvurZfX1Lg6w3tyaJtE4zyhtCuTC769
        TzrdcutGb33ZnG1ZLRq6K33yby9PezLB632fq0pYiGwRu1tr5VXRRVH14ol/dmytK965Yl9p
        1o0nRTbKPNsmXesOnhAg/f91553WxFNa9i59Wy+qTJA5FXx08p7muJSkLRE6+1bu4zY7NemW
        8qlvD00FHtzSVRURiPwur5kTGNl6YPv2s+XnDc8tW1zwL2/re4bFpxfpbzLIncDym9N4/8Sr
        dw7PeGjlwxypnFzD9TGTI/RSefneVv5JSu9naz3oUWIpzkg01GIuKk4EAMSiPdHGAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIIsWRmVeSWpSXmKPExsWS2cA0Sffirf/JBlfXSlqcuNnIZrH/6XMW
        i1ULr7FZnJ91isXi8MYzTBb/f71itVizQtjieO8OFgcOj5Yjb1k9Fu95yeRx59oeNo8n1zYz
        ebzfd5XN4/MmuQC2KC6blNSczLLUIn27BK6M7r272QoWilf0dk1gbGDsFupi5OSQEDCR6P2w
        n7GLkYtDSGA1o8TrlvnMEM5HRokTp+dDZZYySpz+Oo0dpIVNQFFiX9d2NhBbRMBI4t2NSYwg
        NrPAMSaJPU/MQGxhgWiJT9v+skDUxEismLeOqYuRA6x+wuxQkDCLgIrExL0nwMbwCphJHN7y
        lgnEFhIol+jZ3coCUs4p4CixrccJJMwoICbx/dQaJohN4hK3nsxngnhAQGLJnvPMELaoxMvH
        /1ghbEWJ+99fskPU60ncmDqFDcK2k7j28BULhK0tsWzha2aIEwQlTs58wgLRKylxcMUNlgmM
        ErOQrJuFZNQsJKNmIRk1C8moBYysqxjFS4uLc9Mrig3zUsv1ihNzi0vz0vWS83M3MQJj/fS/
        w5E7GI/e+qh3iJGJg/EQowQHs5II78Lbf5KFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8wq5TowX
        EkhPLEnNTk0tSC2CyTJxcEo1MK25f+E009L+C+9NirLz5vvNOZaZUdBZm3a3v/PE/V3b3t/1
        ObP+SdcdndQ/BWdmnn5guTqfUfVdwWX96xXzI3alnXFwcZ02LSKBb9UBJpUanwVzJ1e96+i0
        ia74f3TZ1tdGj+PCeXNvnYo+nd6wM3RGQ8+CBUx5a3k3Hl3313kW38zWwH1x+UsY9c8cMmrY
        cuufUfZq1btMqt8UlX8fckuS4ezI335s7+wZRzfu+XAud+apS3xLHvIsXn57ob35rDuRe6qu
        3rwR9/OCvOG3hQn5ch7v5ZX2fd4vL1L4NC+wpfD80zPTw1eb3ir9sfxNqXYXf8nrZH7ewOyv
        vQIP48usjPlKilnn7f/o+jNmxlQeJZbijERDLeai4kQArJ8oTWQDAAA=
X-CMS-MailID: 20230301230801uscas1p155098774d0f921b4fd8a1f683343481c
CMS-TYPE: 301P
X-CMS-RootMailID: 20230301230801uscas1p155098774d0f921b4fd8a1f683343481c
References: <20230227170311.20054-1-Jonathan.Cameron@huawei.com>
        <20230227170311.20054-3-Jonathan.Cameron@huawei.com>
        <CGME20230301230801uscas1p155098774d0f921b4fd8a1f683343481c@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 27, 2023 at 05:03:07PM +0000, Jonathan Cameron wrote:
> From: Ira Weiny <ira.weiny@intel.com>
>=20
> There are new users of this functionality coming shortly so factor
> it out from the GET_TIMESTAMP mailbox command handling.
>=20
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Fan Ni <fan.ni@samsung.com>

> ---
>  hw/cxl/cxl-device-utils.c   | 15 +++++++++++++++
>  hw/cxl/cxl-mailbox-utils.c  | 11 +----------
>  include/hw/cxl/cxl_device.h |  2 ++
>  3 files changed, 18 insertions(+), 10 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
> index 4c5e88aaf5..86e1cea8ce 100644
> --- a/hw/cxl/cxl-device-utils.c
> +++ b/hw/cxl/cxl-device-utils.c
> @@ -269,3 +269,18 @@ void cxl_device_register_init_common(CXLDeviceState =
*cxl_dstate)
> =20
>      cxl_initialize_mailbox(cxl_dstate);
>  }
> +
> +uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
> +{
> +    uint64_t time, delta;
> +    uint64_t final_time =3D 0;
> +
> +    if (cxl_dstate->timestamp.set) {
> +        /* Find the delta from the last time the host set the time. */
> +        time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        delta =3D time - cxl_dstate->timestamp.last_set;
> +        final_time =3D cxl_dstate->timestamp.host_set + delta;
> +    }
> +
> +    return final_time;
> +}
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 7b2aef0d67..702e16ca20 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -163,17 +163,8 @@ static CXLRetCode cmd_timestamp_get(struct cxl_cmd *=
cmd,
>                                      CXLDeviceState *cxl_dstate,
>                                      uint16_t *len)
>  {
> -    uint64_t time, delta;
> -    uint64_t final_time =3D 0;
> -
> -    if (cxl_dstate->timestamp.set) {
> -        /* First find the delta from the last time the host set the time=
. */
> -        time =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> -        delta =3D time - cxl_dstate->timestamp.last_set;
> -        final_time =3D cxl_dstate->timestamp.host_set + delta;
> -    }
> +    uint64_t final_time =3D cxl_device_get_timestamp(cxl_dstate);
> =20
> -    /* Then adjust the actual time */
>      stq_le_p(cmd->payload, final_time);
>      *len =3D 8;
> =20
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index edb9791bab..02befda0f6 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -287,4 +287,6 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_=
addr, uint64_t *data,
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t dat=
a,
>                              unsigned size, MemTxAttrs attrs);
> =20
> +uint64_t cxl_device_get_timestamp(CXLDeviceState *cxlds);
> +
>  #endif
> --=20
> 2.37.2
>=20
> =
