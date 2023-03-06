Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC5EDC64EC4
	for <linux-cxl@archiver.kernel.org>; Mon,  6 Mar 2023 18:03:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjCFSDr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 6 Mar 2023 13:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229972AbjCFSDq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 6 Mar 2023 13:03:46 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FC5457DD
        for <linux-cxl@vger.kernel.org>; Mon,  6 Mar 2023 10:03:13 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230306175233usoutp01efa1bbfe39c81c07160749a75bfc3934~J5e_G3bCK1140011400usoutp01E;
        Mon,  6 Mar 2023 17:52:33 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230306175233usoutp01efa1bbfe39c81c07160749a75bfc3934~J5e_G3bCK1140011400usoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1678125153;
        bh=cJg1QiFWMwTLD7xxHcec2K4s0FzISKNLwzPg6C88pno=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Ku94gpFdMKZowyW6roDVYiqfYbZacPjUbhHOp8OYLDkHCaCGRyh/ACJ3gX/41DfQM
         Mq6ruZYE1xBOvjQR0KJfVqYORzcJ5sUiuSw3/KYj/6Zqir5PRIDWVrkQFK+1/RPdmp
         CQtbGDNlpLfXso0TsAzN266//S6tgtDw5z4iir1c=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230306175232uscas1p119ef1749e42f00d9df0f71a4b269446b~J5e96335X1056010560uscas1p1h;
        Mon,  6 Mar 2023 17:52:32 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id E6.2E.06976.06826046; Mon, 
        6 Mar 2023 12:52:32 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230306175232uscas1p18d8022fab9b5bd5a10a367a6b597aee4~J5e9khsCC0315703157uscas1p1G;
        Mon,  6 Mar 2023 17:52:32 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-d9-64062860bf50
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id A5.45.11378.06826046; Mon, 
        6 Mar 2023 12:52:32 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 6 Mar 2023 09:52:31 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        6 Mar 2023 09:52:31 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?iso-8859-1?Q?Daniel_P_=2E_Berrang=E9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?iso-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: Re: [RESEND PATCH v6 6/8] hw/cxl: Fix endian issues in CXL RAS
 capability defaults / masks
Thread-Topic: [RESEND PATCH v6 6/8] hw/cxl: Fix endian issues in CXL RAS
        capability defaults / masks
Thread-Index: AQHZTQyINWjuWWcxb0CvzdrNhq0gIq7ulNuA
Date:   Mon, 6 Mar 2023 17:52:31 +0000
Message-ID: <20230306175231.GF1489326@bgt-140510-bm03>
In-Reply-To: <20230302133709.30373-7-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <16B9C1F6EF05164A88F4C466C42701A8@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKKsWRmVeSWpSXmKPExsWy7djXc7oJGmwpBs8ajS3uPr7AZjF/7X0W
        izdv1jBZnLjZyGYx8e16Vov9T5+zWKxaeI3N4vysUywWhzeeYbJY0NbOarHm/iFWi99rHzNZ
        /P/1CshdIWxxvHcHi8XKYzYOAh6tl/6yeeycdZfdo+XIW1aPxXteMnncubaHzePJtc1MHu/3
        XWXz+LxJLoAjissmJTUnsyy1SN8ugSvj4qF2toIu4YqjC4QbGE/xdzFyckgImEhs/fiZuYuR
        i0NIYCWjROPtTjYIp5VJYtfHNcwwVfv3T4RKrGWUOLFrMzuE85FRov1CHxOEs5RRYnn3LRaQ
        FjYBRYl9XdvZQGwRASOJdzcmMYIUMQvsYZX4OGM+UDsHh7BAqsTcnmiImjSJRWces8DU77lz
        lgnEZhFQkdh/YxlYnFfATGLR1hVgJ3EKOErM/HqbHcRmFBCT+H5qDVg9s4C4xK0n85kgzhaU
        WDR7D9QLYhL/dj1kg7AVJe5/f8kOUa8ncWPqFDYI207iw+zJUHFtiWULXzND7BWUODnzCQtE
        r6TEwRU3WEB+kRBYzSkx7+pLqKEuEi1nzkAtk5a4en0qM8iPEgLJEqs+ckGEcyTmL9kCNcda
        YuGf9UwTGFVmITl7FpKTZiE5aRaSk2YhOWkBI+sqRvHS4uLc9NRiw7zUcr3ixNzi0rx0veT8
        3E2MwJR4+t/h3B2MO2591DvEyMTBeIhRgoNZSYS36jdrihBvSmJlVWpRfnxRaU5q8SFGaQ4W
        JXFeQ9uTyUIC6YklqdmpqQWpRTBZJg5OqQamvluMssX/v634pKTz2jvEuCLy1dl5rQb13LKN
        Z+QU3qpnvD0VvjdsUoiQvjcTk5b1yuxc98dni/c+iDg7Jah1f7ebbMnhxZ59XFkP3rAmzst6
        wuI+k8mDq1dgYtLaP0vNmP8Fb9Je+YAj8qHqwkP2028xhRTeVXb2yZZYWHfy9eMnsU6zXkeb
        MzZObZwy4Xtz2Sa9E8tTOG5t+c053chOZzHXZPt2P6kL+Zb9c1ivb69/3ie0uPjkUU6d6JeZ
        zF6JpdNU6nIOHOZp2XShkV367iEepWXNr6qsZvbmlv/K0XOxFRbvaXOJEDRijfno0vRjZQvL
        r2zZ7X6881b1vpq4P6B/cZaHTcc2znc8OUosxRmJhlrMRcWJAAioRX74AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmleLIzCtJLcpLzFFi42LJbGCaqJugwZZi8PWoqMXdxxfYLOavvc9i
        8ebNGiaLEzcb2Swmvl3ParH/6XMWi1ULr7FZnJ91isXi8MYzTBYL2tpZLdbcP8Rq8XvtYyaL
        /79eAbkrhC2O9+5gsVh5zMZBwKP10l82j52z7rJ7tBx5y+qxeM9LJo871/aweTy5tpnJ4/2+
        q2wenzfJBXBEcdmkpOZklqUW6dslcGVcPNTOVtAlXHF0gXAD4yn+LkZODgkBE4n9+yeydTFy
        cQgJrGaUeD79OjuE85FR4u7dH4wQzlJGiYe3FrOAtLAJKErs69rOBmKLCBhJvLsxCayIWWAX
        q8Tjpc+B2jk4hAVSJeb2REPUpEnsWj6LHaZ+z52zTCA2i4CKxP4by8Bm8gqYSSzauoIZxBYS
        KJfY1/OBFcTmFHCUmPn1Nlgvo4CYxPdTa8B6mQXEJW49mc8E8YKAxJI955khbFGJl4//sULY
        ihL3v79kh6jXk7gxdQobhG0n8WH2ZKi4tsSyha+ZIW4QlDg58wkLRK+kxMEVN1gmMErMQrJu
        FpJRs5CMmoVk1CwkoxYwsq5iFC8tLs5Nryg2zEst1ytOzC0uzUvXS87P3cQITCen/x2O3MF4
        9NZHvUOMTByMhxglOJiVRHirfrOmCPGmJFZWpRblxxeV5qQWH2KU5mBREucVcp0YLySQnliS
        mp2aWpBaBJNl4uCUamCa3y7zdb/nc+emyskX//3iuxff2HhAKXrvi6TwBfIbfhk1sftUnGbh
        2fBlT25DQtfyptVri9ozMtafm7x1p2Vbw4vtLWs8FBvX/ynu4Eldkb9QvuPOoTyjn0dWR5v4
        +hXulbjBmN99+UPWSvUeL93DsnecH5s1edapvH23eUXgWvsjyj9qlry6KNr2Qa/k+9L8O537
        9A1rhF0ZlI1EnOJC9ZoOGf4Mvdq4f/3hV13ec7/+lToUWZeuFzJjkujf3w/fzjrVZBf14E29
        w2W54svHuVtnH9zSKXZn0iPm42x7Czc2MPD7rdDqMa/rzlnMceA/O5fulphIkVWzTlxZpmnz
        bUVzLrOUkVbH15N6xiJKLMUZiYZazEXFiQCSwzfplgMAAA==
X-CMS-MailID: 20230306175232uscas1p18d8022fab9b5bd5a10a367a6b597aee4
CMS-TYPE: 301P
X-CMS-RootMailID: 20230306175232uscas1p18d8022fab9b5bd5a10a367a6b597aee4
References: <20230302133709.30373-1-Jonathan.Cameron@huawei.com>
        <20230302133709.30373-7-Jonathan.Cameron@huawei.com>
        <CGME20230306175232uscas1p18d8022fab9b5bd5a10a367a6b597aee4@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 02, 2023 at 01:37:07PM +0000, Jonathan Cameron wrote:
> As these are about to be modified, fix the endian handle for
> this set of registers rather than making it worse.
>=20
> Note that CXL is currently only supported in QEMU on
> x86 (arm64 patches out of tree) so we aren't going to yet hit
> an problems with big endian. However it is good to avoid making
> things worse for that support in the future.
>=20
> Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> Reviewed-by: Philippe Mathieu-Daud=E9 <philmd@linaro.org>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/cxl/cxl-component-utils.c | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
>=20
> diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> index 3edd303a33..737b4764b9 100644
> --- a/hw/cxl/cxl-component-utils.c
> +++ b/hw/cxl/cxl-component-utils.c
> @@ -141,17 +141,17 @@ static void ras_init_common(uint32_t *reg_state, ui=
nt32_t *write_msk)
>       * Error status is RW1C but given bits are not yet set, it can
>       * be handled as RO.
>       */
> -    reg_state[R_CXL_RAS_UNC_ERR_STATUS] =3D 0;
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_STATUS, 0);
>      /* Bits 12-13 and 17-31 reserved in CXL 2.0 */
> -    reg_state[R_CXL_RAS_UNC_ERR_MASK] =3D 0x1cfff;
> -    write_msk[R_CXL_RAS_UNC_ERR_MASK] =3D 0x1cfff;
> -    reg_state[R_CXL_RAS_UNC_ERR_SEVERITY] =3D 0x1cfff;
> -    write_msk[R_CXL_RAS_UNC_ERR_SEVERITY] =3D 0x1cfff;
> -    reg_state[R_CXL_RAS_COR_ERR_STATUS] =3D 0;
> -    reg_state[R_CXL_RAS_COR_ERR_MASK] =3D 0x7f;
> -    write_msk[R_CXL_RAS_COR_ERR_MASK] =3D 0x7f;
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
> +    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_MASK, 0x1cfff);
> +    stl_le_p(reg_state + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
> +    stl_le_p(write_msk + R_CXL_RAS_UNC_ERR_SEVERITY, 0x1cfff);
> +    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_STATUS, 0);
> +    stl_le_p(reg_state + R_CXL_RAS_COR_ERR_MASK, 0x7f);
> +    stl_le_p(write_msk + R_CXL_RAS_COR_ERR_MASK, 0x7f);
>      /* CXL switches and devices must set */
> -    reg_state[R_CXL_RAS_ERR_CAP_CTRL] =3D 0x00;
> +    stl_le_p(reg_state + R_CXL_RAS_ERR_CAP_CTRL, 0x00);
>  }
> =20
>  static void hdm_init_common(uint32_t *reg_state, uint32_t *write_msk,
> --=20
> 2.37.2
>=20
> =
