Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35F88C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:11:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjB1ELR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:11:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjB1ELQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:11:16 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8AB20562
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:11:14 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041113usoutp016f61f875666952a73e8d129fa10fd674~H4aJmdJxz0732607326usoutp01d;
        Tue, 28 Feb 2023 04:11:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230228041113usoutp016f61f875666952a73e8d129fa10fd674~H4aJmdJxz0732607326usoutp01d
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557473;
        bh=KOhyQMWbONSt/X31d606gozh05ra0Lu0MiU6WnRSUIE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=AUdr/+EdCGBxP5Dh2CtDDf2U3kQe3Fmfw8uX0VkLYgHVV0ObysvSOq19jNApUgEud
         VpuebCAgXVzYWNrttfo0+nlShzkvk4r9uo95WhRl5CJ2UQJqP+Wz/FVxoYZTxK7/jk
         ZZyVh6A24TApRPp1uUmdvdgVTdfuadvkdBaGn2J0=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041113uscas1p175e618daf82d477829149cc70d5afbda~H4aJVtu_F2912729127uscas1p1p;
        Tue, 28 Feb 2023 04:11:13 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 9D.A8.49129.1EE7DF36; Mon,
        27 Feb 2023 23:11:13 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041113uscas1p1e62bf38766962db8de58b4c1b6cff804~H4aJBo-EZ0877608776uscas1p1M;
        Tue, 28 Feb 2023 04:11:13 +0000 (GMT)
X-AuditID: cbfec36f-eddff7000001bfe9-dc-63fd7ee145ba
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 43.B9.11346.0EE7DF36; Mon,
        27 Feb 2023 23:11:13 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:11:12 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:11:12 -0800
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
Subject: Re: [PATCH v4 03/10] hw/cxl: set cxl-type3 device type to
 PCI_CLASS_MEMORY_CXL
Thread-Topic: [PATCH v4 03/10] hw/cxl: set cxl-type3 device type to
        PCI_CLASS_MEMORY_CXL
Thread-Index: AQHZSyqxT97W4kECAUOyE5jtU4UlxQ==
Date:   Tue, 28 Feb 2023 04:11:12 +0000
Message-ID: <20230228041112.GC1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-4-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <1C38A0C87C2D1E458820069FFE59B27A@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAKsWRmVeSWpSXmKPExsWy7djX87oP6/4mG0y6LmXRPHkxo8WLP8+Z
        LPY/fc5isWrhNTaL87NOsVgc3niGyeL/r1esFmtWCFsc793B4sDpsXPWXXaPliNvWT0W73nJ
        5LFpVSebx51re9g8nlzbzOTxft9VNo/Pm+QCOKK4bFJSczLLUov07RK4MnZfSCuYxV3Rczqv
        gbGDs4uRk0NCwESi8e18ZhBbSGAlo8SRBTFdjFxAdiuTxLyZe1hhina+PssKUbSWUWLJP20I
        +xOjxISzKRANyxgl/sy+CDaJTUBRYl/XdjYQW0TASOLdjUmMIEXMAl+YJKbe3cgCkhAWiJRY
        u2wdVFGUxIPpV9khbD2JAy8gBrEIqEp0tnaDbeYVMJNo7drJCGJzCjhI7G3ZA2YzCohJfD+1
        hgnEZhYQl7j1ZD4TxNWCEotm72GGsMUk/u16yAZhK0rc//6SHaJeT+LG1ClsELadxLs3kxkh
        bG2JZQtfM0PsFZQ4OfMJC0SvpMTBFTdYQJ6REPjPIXHr81WohIvEpZ+XocElLTF9zWWgOAeQ
        nSyx6iMXRDhHYv6SLVDl1hIL/6xnmsCoMgvJ2bOQnDQLyUmzkJw0C8lJCxhZVzGKlxYX56an
        FhvlpZbrFSfmFpfmpesl5+duYgQmstP/DufvYLx+66PeIUYmDsZDjBIczEoivAtv/0kW4k1J
        rKxKLcqPLyrNSS0+xCjNwaIkzmtoezJZSCA9sSQ1OzW1ILUIJsvEwSnVwFQje+6Ex//sD+qx
        vasPf7m9wXRn1e8tDpcD4y52H0tlWqeYtHneU7GV6hHGTm3HvAx3b+adYbTzvGH1/OI1qVXr
        ts6wV4lcndcVJyUltugwq4U969JVnzX6mi5rqj26fyotj/Wamu2u+llrLlvXSoZ9FHgp/9S9
        7LDC34ofBes+Ll77midApfrrftnfPy0uLtJl/sgazbE+eVacxcRzUcJmxpY+wdzPdp8KTC0J
        8H+51/D1tx9NYs2zTyRdEt+66LPZVz6f5ZK7tz2vZ1ZgX2+/WGzW7eRM5UWmkwwj7a7ERplO
        EF7HcPPi+YBjn48tUHVZ8/x34Xzbz0mr5597+kxornXJ1uypt9ZWPLm4rthFiaU4I9FQi7mo
        OBEAYogMaNMDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrPIsWRmVeSWpSXmKPExsWS2cA0Ufdh3d9kg5ZeNovmyYsZLV78ec5k
        sf/pcxaLVQuvsVmcn3WKxeLwxjNMFv9/vWK1WLNC2OJ47w4WB06PnbPusnu0HHnL6rF4z0sm
        j02rOtk87lzbw+bx5NpmJo/3+66yeXzeJBfAEcVlk5Kak1mWWqRvl8CVsftCWsEs7oqe03kN
        jB2cXYycHBICJhI7X59l7WLk4hASWM0oMf/IbjYI5xOjRM/hnewgVUICyxglDmxmBbHZBBQl
        9nVtZwOxRQSMJN7dmMQI0sAs8IVJ4saH7ywgCWGBSIm1y9ZBFUVJNNxqZIaw9SQOvLgIZrMI
        qEp0tnaDDeUVMJNo7doJNIgDaFmpxKIVeSBhTgEHib0texhBbEYBMYnvp9YwgdjMAuISt57M
        Z4L4QEBiyZ7zzBC2qMTLx/9YIWxFifvfX7JD1OtJ3Jg6hQ3CtpN492YyI4StLbFs4WtmiBME
        JU7OfMIC0SspcXDFDZYJjBKzkKybhWTULCSjZiEZNQvJqAWMrKsYxUuLi3PTK4qN81LL9YoT
        c4tL89L1kvNzNzEC08Dpf4djdjDeu/VR7xAjEwfjIUYJDmYlEd6Ft/8kC/GmJFZWpRblxxeV
        5qQWH2KU5mBREuf1iJ0YLySQnliSmp2aWpBaBJNl4uCUamBSZuYufKRW75S0nyf17Kb/62cE
        /1jfZ8p7/7+tfonja4+Q14FVlyOLOWU9F1Qm6Yt8/cfIlRYWNM037cCRd+IHjf/+0ruQ1Mxg
        zFW2eN+ickVpNoUPNULL3z06OqPSKlBJfcZCe9OOHXPO7PT+l6eyQ65PceX39wLNrtd69lT1
        btZccPpmdMg9A/n3T1ZY3/fVM7qyLPLdOifr3/1/hLbNOvVHL23Swmdz1FZv5FX4vK7S6c01
        AdXuGeGvbxgdmFRZ/yni86G3u07ue3BSqH3JF8PCc+8WGzn68sQe+TzTdk+Mzx+Ok0rbAiW0
        WNIf3J4t3SWwepn/fau2+a5tR588+MMxpe5/TEdywZOa9HAVJZbijERDLeai4kQAtZOcm3ID
        AAA=
X-CMS-MailID: 20230228041113uscas1p1e62bf38766962db8de58b4c1b6cff804
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041113uscas1p1e62bf38766962db8de58b4c1b6cff804
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-4-Jonathan.Cameron@huawei.com>
        <CGME20230228041113uscas1p1e62bf38766962db8de58b4c1b6cff804@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:09PM +0000, Jonathan Cameron wrote:
> From: Gregory Price <gourry.memverge@gmail.com>
>=20
> Current code sets to STORAGE_EXPRESS and then overrides it.
>=20
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/mem/cxl_type3.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 252822bd82..217a5e639b 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -408,7 +408,6 @@ static void ct3_realize(PCIDevice *pci_dev, Error **e=
rrp)
>      }
> =20
>      pci_config_set_prog_interface(pci_conf, 0x10);
> -    pci_config_set_class(pci_conf, PCI_CLASS_MEMORY_CXL);
> =20
>      pcie_endpoint_cap_init(pci_dev, 0x80);
>      if (ct3d->sn !=3D UI64_NULL) {
> @@ -627,7 +626,7 @@ static void ct3_class_init(ObjectClass *oc, void *dat=
a)
> =20
>      pc->realize =3D ct3_realize;
>      pc->exit =3D ct3_exit;
> -    pc->class_id =3D PCI_CLASS_STORAGE_EXPRESS;
> +    pc->class_id =3D PCI_CLASS_MEMORY_CXL;
>      pc->vendor_id =3D PCI_VENDOR_ID_INTEL;
>      pc->device_id =3D 0xd93; /* LVF for now */
>      pc->revision =3D 1;
> --=20
> 2.37.2
>=20
> =
