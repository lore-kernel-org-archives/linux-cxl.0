Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BDDBC4332F
	for <linux-cxl@archiver.kernel.org>; Thu,  8 Dec 2022 22:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229715AbiLHW4g (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 8 Dec 2022 17:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbiLHW4H (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 8 Dec 2022 17:56:07 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E00975BF3
        for <linux-cxl@vger.kernel.org>; Thu,  8 Dec 2022 14:56:02 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20221208225600usoutp01dd38b1c5514a2b230306b4dbc9ad57a1~u82y56DpZ1962919629usoutp01N;
        Thu,  8 Dec 2022 22:56:00 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20221208225600usoutp01dd38b1c5514a2b230306b4dbc9ad57a1~u82y56DpZ1962919629usoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1670540160;
        bh=ocsYp28Tth+3zD5MLF5QT9tb+Rg9WD1gFA4PZyZC4mc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=LEeGCQS9sNg78rCMQ8LYpAnwSV6Epv3CNO++6GQYAv26IXasCtgK2idftwfPkloSa
         NyNxFq30JiLOD6OUtqs1+9iHOO5akGQjEHN9r8IS22YMhbpf9DSBDpnDBxxuISsoFD
         IU7Kb1S2XegE8sZaIwi0PVHwNzu1Gc9vpIY13GRU=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221208225559uscas1p2d6c077b638b1972e49b83f4016a05450~u82yU7irG1552415524uscas1p2r;
        Thu,  8 Dec 2022 22:55:59 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 20.7F.09913.F7B62936; Thu, 
        8 Dec 2022 17:55:59 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221208225559uscas1p1e9e2c7c8f9a1654a5f41cef2c47859a8~u82x4lxh53169031690uscas1p1_;
        Thu,  8 Dec 2022 22:55:59 +0000 (GMT)
X-AuditID: cbfec370-75dff700000026b9-a7-63926b7f7bc2
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 5B.0F.09775.E7B62936; Thu, 
        8 Dec 2022 17:55:58 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 8 Dec 2022 14:55:58 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        8 Dec 2022 14:55:58 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Gregory Price <gourry.memverge@gmail.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>
Subject: Re: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Thread-Topic: [RFC v4 3/3] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
        and Persistent)
Thread-Index: AQHZC1g8x4Cae0a18kydNyc5okwvVQ==
Date:   Thu, 8 Dec 2022 22:55:58 +0000
Message-ID: <20221208225515.GA2510517@bgt-140510-bm03>
In-Reply-To: <20221128150157.97724-4-gregory.price@memverge.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <78375C6CD99D5F479807009127196A3D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrNKsWRmVeSWpSXmKPExsWy7djX87r12ZOSDTpviVjcfXyBzaJ58mJG
        i+7zGxgtVt9cw2jx4s9zJouGpkcsFi273zNZ7H/6nMVi1cJrbBbnZ51isTjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHplWdbB4bP/5n93hybTOTx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZSyZf4m54HEfU8Wc9naWBsb5Fxi7GDk5JARMJC7/uc/SxcjFISSwklFiW99+Jgin
        lUniysGD7DBVy37/YYRIrGWUeLLpMhuE85FR4kTjW1YIZymjxN/2q2wgLWwCihL7uraD2SIC
        uhI7Og+DdTALXGCROP7uMNAsDg5hgViJ1i4+iJo4iQlbJ0DV60lMevqOCcRmEVCReNZ1Eczm
        FTCTaL52BOwkTgEHiSOznoLVMwqISXw/tQashllAXOLWk/lMEGcLSiyavYcZwhaT+LfrIRuE
        rShx//tLdoh6PYkbU6ewQdh2EhOavrBC2NoSyxa+ZobYKyhxcuYTFoheSYmDK26AA0xCYDqn
        xLuPK6Fh5CJxcfdhqGXSEn/vLoM6olriTM85JoiGFkaJS42boYqsJf51XmOfwKgyC8nhs5Ac
        NQvJUbOQHDULyVELGFlXMYqXFhfnpqcWG+ellusVJ+YWl+al6yXn525iBKa/0/8OF+xgvHXr
        o94hRiYOxkOMEhzMSiK8y5ZNTBbiTUmsrEotyo8vKs1JLT7EKM3BoiTOu2ZKR7KQQHpiSWp2
        ampBahFMlomDU6qBKXXhuvki7XmL3BZ3XledUz65vu6I8mMntfXOTJs+v0+erXJ2+bov/8tb
        zDNm7Ctj+aqvtzb4rM3PgC9BgRlbLv7c7nD89zXpwLsrAxYIXC2eojvbavP1SRv/NJr+aOo9
        IWo3+/i0U8d3Oz6teqzZ5Oe5LKLpneijiOXmxxteMNio1axt2aCjm/Ao6+eX9ZM4j2QorbrC
        9UGJr6Rw+eU0hg+i7ct9FU7YnT3n67570sWpfztE3JR19FddmNXuem1H/Q/TCD2Vma9f9fLJ
        b1qx51Hi2p/6/d3z36/1uP5SeoLMj47bNUc+8Yq7VZkVyK261lQ/40rQT41X4T+fzeTPZBSO
        DT0+91va1nMTYs3F3qxTYinOSDTUYi4qTgQAwUbW1O4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOIsWRmVeSWpSXmKPExsWS2cA0Sbcue1KywcerphZ3H19gs2ievJjR
        ovv8BkaL1TfXMFq8+POcyaKh6RGLRcvu90wW+58+Z7FYtfAam8X5WadYLI737mBx4Pa4MHkC
        q8fiBlePnbPusnu0HHkL5O15yeSxaVUnm8fGj//ZPZ5c28zkMXV2vcfnTXIBXFFcNimpOZll
        qUX6dglcGUvmX2IueNzHVDGnvZ2lgXH+BcYuRk4OCQETiWW//wDZXBxCAqsZJSYseQnlfGSU
        WLXsDxOEs5RR4tq6iWwgLWwCihL7uraD2SICuhI7Og+zgRQxC1xgkTj+7jBQOweHsECsRGsX
        H0RNnMTc87tYIWw9iUlP3zGB2CwCKhLPui6C2bwCZhLN146wg9hCAqUSR1sXgcU5BRwkjsx6
        CraLUUBM4vupNWBxZgFxiVtP5jNBvCAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIer1JG5MncIG
        YdtJTGj6wgpha0ssW/iaGeIGQYmTM5+wQPRKShxccYNlAqPELCTrZiEZNQvJqFlIRs1CMmoB
        I+sqRvHS4uLc9Ipio7zUcr3ixNzi0rx0veT83E2MwLRx+t/h6B2Mt2991DvEyMTBeIhRgoNZ
        SYR32bKJyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5X0ZNjBcSSE8sSc1OTS1ILYLJMnFwSjUw
        GV2use+w7eBScEx358zoKDNbct6+s+v4nbIGjkuuf9le/vGaXmXq6OLR08EWKzx37rUa9r/F
        zK8F9ZkONm7UKgrUbrxzI69tA9+Co2d7DTPijDR311RcvPWJ+c7UqMtPNliGe/Bff+ql7XFv
        G+sl7efLVThuNpVyGfPlr7c+efnD8zMTTe/Mi1q0+fv3K2lmSr9+aBadf73qktMSzT8fxfiD
        Er6u5V7LHLX4zduiOsYd0y5wTvKu1j1zW+LZ1Ll72FdKWZZlZh/ePfuVjPkrTZdlWZsiDErd
        1AQn2B402nGx4cmqukMr3jQ2zfup4bvVuLf9nAH7BO1ollsb+o6Ez803Dl26UnzFNO5k/6o5
        SizFGYmGWsxFxYkAe5pMpIoDAAA=
X-CMS-MailID: 20221208225559uscas1p1e9e2c7c8f9a1654a5f41cef2c47859a8
CMS-TYPE: 301P
X-CMS-RootMailID: 20221208225559uscas1p1e9e2c7c8f9a1654a5f41cef2c47859a8
References: <20221128150157.97724-1-gregory.price@memverge.com>
        <20221128150157.97724-4-gregory.price@memverge.com>
        <CGME20221208225559uscas1p1e9e2c7c8f9a1654a5f41cef2c47859a8@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Nov 28, 2022 at 10:01:57AM -0500, Gregory Price wrote:

> From: Gregory Price <gourry.memverge@gmail.com>
>=20
> This commit enables each CXL Type-3 device to contain one volatile
> memory region and one persistent region.
>=20
> Two new properties have been added to cxl-type3 device initialization:
>     [volatile-memdev] and [persistent-memdev]
>=20
> The existing [memdev] property has been deprecated and will default the
> memory region to a persistent memory region (although a user may assign
> the region to a ram or file backed region). It cannot be used in
> combination with the new [persistent-memdev] property.
>=20
> Partitioning volatile memory from persistent memory is not yet supported.
>=20
> Volatile memory is mapped at DPA(0x0), while Persistent memory is mapped
> at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.
>=20
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  docs/system/devices/cxl.rst |  49 ++++--
>  hw/cxl/cxl-mailbox-utils.c  |  22 +--
>  hw/mem/cxl_type3.c          | 292 +++++++++++++++++++++++++++---------
>  include/hw/cxl/cxl_device.h |  11 +-
>  tests/qtest/cxl-test.c      |  78 ++++++++--
>  5 files changed, 347 insertions(+), 105 deletions(-)
>=20
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index f25783a4ec..45639a676a 100644
> --- a/docs/system/devices/cxl.rst
> +++ b/docs/system/devices/cxl.rst
> @@ -300,7 +300,7 @@ Example topology involving a switch::
> =20
>  Example command lines
>  ---------------------
> -A very simple setup with just one directly attached CXL Type 3 device::
> +A very simple setup with just one directly attached CXL Type 3 Persisten=
t Memory device::
> =20
>    qemu-system-aarch64 -M virt,gic-version=3D3,cxl=3Don -m 4g,maxmem=3D8G=
,slots=3D8 -cpu max \
>    ...
> @@ -308,7 +308,28 @@ A very simple setup with just one directly attached =
CXL Type 3 device::
>    -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/l=
sa.raw,size=3D256M \
>    -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
>    -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> -  -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,i=
d=3Dcxl-pmem0 \
> +  -device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1,lsa=
=3Dcxl-lsa1,id=3Dcxl-pmem0 \
> +  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G
> +
> +A very simple setup with just one directly attached CXL Type 3 Volatile =
Memory device::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3D3,cxl=3Don -m 4g,maxmem=3D8G=
,slots=3D8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D256M \
> +  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> +  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> +  -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,id=3Dcxl-v=
mem0 \
> +  -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G
> +
> +The same volatile setup may optionally include an LSA region::
> +
> +  qemu-system-aarch64 -M virt,gic-version=3D3,cxl=3Don -m 4g,maxmem=3D8G=
,slots=3D8 -cpu max \
> +  ...
> +  -object memory-backend-ram,id=3Dvmem0,share=3Don,size=3D256M \
> +  -object memory-backend-file,id=3Dcxl-lsa0,share=3Don,mem-path=3D/tmp/l=
sa.raw,size=3D256M \
> +  -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> +  -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> +  -device cxl-type3,bus=3Droot_port13,volatile-memdev=3Dvmem0,lsa=3Dcxl-=
lsa0,id=3Dcxl-vmem0 \
>    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G
> =20
>  A setup suitable for 4 way interleave. Only one fixed window provided, t=
o enable 2 way
> @@ -328,13 +349,13 @@ the CXL Type3 device directly attached (no switches=
).::
>    -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
>    -device pxb-cxl,bus_nr=3D222,bus=3Dpcie.0,id=3Dcxl.2 \
>    -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> -  -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,i=
d=3Dcxl-pmem0 \
> +  -device cxl-type3,bus=3Droot_port13,persistent-memdev=3Dcxl-mem1,lsa=
=3Dcxl-lsa1,id=3Dcxl-pmem0 \
>    -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port14,chassis=3D0,slot=
=3D3 \
> -  -device cxl-type3,bus=3Droot_port14,memdev=3Dcxl-mem2,lsa=3Dcxl-lsa2,i=
d=3Dcxl-pmem1 \
> +  -device cxl-type3,bus=3Droot_port14,persistent-memdev=3Dcxl-mem2,lsa=
=3Dcxl-lsa2,id=3Dcxl-pmem1 \
>    -device cxl-rp,port=3D0,bus=3Dcxl.2,id=3Droot_port15,chassis=3D0,slot=
=3D5 \
> -  -device cxl-type3,bus=3Droot_port15,memdev=3Dcxl-mem3,lsa=3Dcxl-lsa3,i=
d=3Dcxl-pmem2 \
> +  -device cxl-type3,bus=3Droot_port15,persistent-memdev=3Dcxl-mem3,lsa=
=3Dcxl-lsa3,id=3Dcxl-pmem2 \
>    -device cxl-rp,port=3D1,bus=3Dcxl.2,id=3Droot_port16,chassis=3D0,slot=
=3D6 \
> -  -device cxl-type3,bus=3Droot_port16,memdev=3Dcxl-mem4,lsa=3Dcxl-lsa4,i=
d=3Dcxl-pmem3 \
> +  -device cxl-type3,bus=3Droot_port16,persistent-memdev=3Dcxl-mem4,lsa=
=3Dcxl-lsa4,id=3Dcxl-pmem3 \
>    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.targets.1=3Dcxl.2,cxl-fmw.0.s=
ize=3D4G,cxl-fmw.0.interleave-granularity=3D8k
> =20
>  An example of 4 devices below a switch suitable for 1, 2 or 4 way interl=
eave::
> @@ -354,15 +375,23 @@ An example of 4 devices below a switch suitable for=
 1, 2 or 4 way interleave::
>    -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3Droot_port1,chassis=3D0,slot=
=3D1 \
>    -device cxl-upstream,bus=3Droot_port0,id=3Dus0 \
>    -device cxl-downstream,port=3D0,bus=3Dus0,id=3Dswport0,chassis=3D0,slo=
t=3D4 \
> -  -device cxl-type3,bus=3Dswport0,memdev=3Dcxl-mem0,lsa=3Dcxl-lsa0,id=3D=
cxl-pmem0,size=3D256M \
> +  -device cxl-type3,bus=3Dswport0,persistent-memdev=3Dcxl-mem0,lsa=3Dcxl=
-lsa0,id=3Dcxl-pmem0,size=3D256M \
>    -device cxl-downstream,port=3D1,bus=3Dus0,id=3Dswport1,chassis=3D0,slo=
t=3D5 \
> -  -device cxl-type3,bus=3Dswport1,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,id=3D=
cxl-pmem1,size=3D256M \
> +  -device cxl-type3,bus=3Dswport1,persistent-memdev=3Dcxl-mem1,lsa=3Dcxl=
-lsa1,id=3Dcxl-pmem1,size=3D256M \
>    -device cxl-downstream,port=3D2,bus=3Dus0,id=3Dswport2,chassis=3D0,slo=
t=3D6 \
> -  -device cxl-type3,bus=3Dswport2,memdev=3Dcxl-mem2,lsa=3Dcxl-lsa2,id=3D=
cxl-pmem2,size=3D256M \
> +  -device cxl-type3,bus=3Dswport2,persistent-memdev=3Dcxl-mem2,lsa=3Dcxl=
-lsa2,id=3Dcxl-pmem2,size=3D256M \
>    -device cxl-downstream,port=3D3,bus=3Dus0,id=3Dswport3,chassis=3D0,slo=
t=3D7 \
> -  -device cxl-type3,bus=3Dswport3,memdev=3Dcxl-mem3,lsa=3Dcxl-lsa3,id=3D=
cxl-pmem3,size=3D256M \
> +  -device cxl-type3,bus=3Dswport3,persistent-memdev=3Dcxl-mem3,lsa=3Dcxl=
-lsa3,id=3Dcxl-pmem3,size=3D256M \
>    -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interleav=
e-granularity=3D4k
> =20
> +Deprecations
> +------------
> +
> +The Type 3 device [memdev] attribute has been deprecated in favor
> +of the [persistent-memdev] and [volatile-memdev] attributes. [memdev]
> +will default to a persistent memory device for backward compatibility
> +and is incapable of being used in combination with [persistent-memdev].
> +
>  Kernel Configuration Options
>  ----------------------------
> =20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index d7543fd5b4..44cebb950a 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -269,7 +269,8 @@ static ret_code cmd_firmware_update_get_info(struct c=
xl_cmd *cmd,
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) !=3D 0x50);
> =20
> -    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
> +    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
For a cxl configuration with only pmem or vmem, vmem_size or pmem_size
can be 0 and fail the check?=20

> =20
> @@ -412,20 +413,20 @@ static ret_code cmd_identify_memory_device(struct c=
xl_cmd *cmd,
> =20
>      CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dsta=
te);
>      CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
> -    uint64_t size =3D cxl_dstate->pmem_size;
> =20
> -    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
> +    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER=
)) ||
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER=
))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
>      id =3D (void *)cmd->payload;
>      memset(id, 0, sizeof(*id));
> =20
> -    /* PMEM only */
>      snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
> =20
> -    id->total_capacity =3D size / CXL_CAPACITY_MULTIPLIER;
> -    id->persistent_capacity =3D size / CXL_CAPACITY_MULTIPLIER;
> +    id->total_capacity =3D cxl_dstate->mem_size / CXL_CAPACITY_MULTIPLIE=
R;
> +    id->persistent_capacity =3D cxl_dstate->pmem_size / CXL_CAPACITY_MUL=
TIPLIER;
> +    id->volatile_capacity =3D cxl_dstate->vmem_size / CXL_CAPACITY_MULTI=
PLIER;
>      id->lsa_size =3D cvc->get_lsa_size(ct3d);
>      id->poison_list_max_mer[1] =3D 0x1; /* 256 poison records */
> =20
> @@ -444,16 +445,15 @@ static ret_code cmd_ccls_get_partition_info(struct =
cxl_cmd *cmd,
>          uint64_t next_pmem;
>      } QEMU_PACKED *part_info =3D (void *)cmd->payload;
>      QEMU_BUILD_BUG_ON(sizeof(*part_info) !=3D 0x20);
> -    uint64_t size =3D cxl_dstate->pmem_size;
> =20
> -    if (!QEMU_IS_ALIGNED(size, CXL_CAPACITY_MULTIPLIER)) {
> +    if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER=
)) ||
> +        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER=
))) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> -    /* PMEM only */
> -    part_info->active_vmem =3D 0;
> +    part_info->active_vmem =3D cxl_dstate->vmem_size / CXL_CAPACITY_MULT=
IPLIER;
>      part_info->next_vmem =3D 0;
> -    part_info->active_pmem =3D size / CXL_CAPACITY_MULTIPLIER;
> +    part_info->active_pmem =3D cxl_dstate->pmem_size / CXL_CAPACITY_MULT=
IPLIER;
>      part_info->next_pmem =3D 0;
> =20
>      *len =3D sizeof(*part_info);
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 0317bd96a6..81dc3def01 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -32,7 +32,8 @@ enum {
>  };
> =20
>  static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
> -                                         int dsmad_handle, MemoryRegion =
*mr)
> +                                         int dsmad_handle, MemoryRegion =
*mr,
> +                                         bool is_pmem, uint64_t dpa_base=
)
>  {
>      g_autofree CDATDsmas *dsmas =3D NULL;
>      g_autofree CDATDslbis *dslbis0 =3D NULL;
> @@ -51,8 +52,8 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader =
**cdat_table,
>              .length =3D sizeof(*dsmas),
>          },
>          .DSMADhandle =3D dsmad_handle,
> -        .flags =3D CDAT_DSMAS_FLAG_NV,
> -        .DPA_base =3D 0,
> +        .flags =3D is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
> +        .DPA_base =3D dpa_base,
>          .DPA_length =3D int128_get64(mr->size),
>      };
> =20
> @@ -151,33 +152,67 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHea=
der **cdat_table,
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  {
>      g_autofree CDATSubHeader **table =3D NULL;
> -    MemoryRegion *nonvolatile_mr;
>      CXLType3Dev *ct3d =3D priv;
> +    MemoryRegion *volatile_mr =3D NULL, *nonvolatile_mr =3D NULL;
>      int dsmad_handle =3D 0;
> +    int cur_ent =3D 0;
> +    int len =3D 0;
>      int rc;
> =20
> -    if (!ct3d->hostmem) {
> +    if (!ct3d->hostpmem && !ct3d->hostvmem) {
>          return 0;
>      }
> =20
> -    nonvolatile_mr =3D host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!nonvolatile_mr) {
> -        return -EINVAL;
> +    if (ct3d->hostvmem) {
> +        volatile_mr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (!volatile_mr) {
> +            return -EINVAL;
> +        }
> +        len +=3D CT3_CDAT_NUM_ENTRIES;
> +    }
> +
> +    if (ct3d->hostpmem) {
> +        nonvolatile_mr =3D host_memory_backend_get_memory(ct3d->hostpmem=
);
> +        if (!nonvolatile_mr) {
> +            return -EINVAL;
> +        }
> +        len +=3D CT3_CDAT_NUM_ENTRIES;
>      }
> =20
> -    table =3D g_malloc0(CT3_CDAT_NUM_ENTRIES * sizeof(*table));
> +    table =3D g_malloc0(len * sizeof(*table));
>      if (!table) {
>          return -ENOMEM;
>      }
> =20
> -    rc =3D ct3_build_cdat_entries_for_mr(table, dsmad_handle++, nonvolat=
ile_mr);
> -    if (rc < 0) {
> -        return rc;
> +    /* Now fill them in */
> +    if (volatile_mr) {
> +        rc =3D ct3_build_cdat_entries_for_mr(table, dsmad_handle++, vola=
tile_mr,
> +                                           true, 0);
> +        if (rc < 0) {
> +            return rc;
> +        }
> +        cur_ent =3D CT3_CDAT_NUM_ENTRIES;
> +    }
> +
> +    if (nonvolatile_mr) {
> +        rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_ha=
ndle++,
> +                nonvolatile_mr, true, (volatile_mr ? volatile_mr->size :=
 0));
> +        if (rc < 0) {
> +            goto error_cleanup;
> +        }
> +        cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
>      }
> +    assert(len =3D=3D cur_ent);
> =20
>      *cdat_table =3D g_steal_pointer(&table);
> =20
> -    return CT3_CDAT_NUM_ENTRIES;
> +    return len;
> +error_cleanup:
> +    int i;
> +    for (i =3D 0; i < cur_ent; i++) {
> +        g_free(table[i]);
> +    }
> +    return rc;
>  }

I hit an error when compiling with gcc version 9.4.0
(Ubuntu 9.4.0-1ubuntu1~20.04.1), maybe moving the declaration of `i` to
the following loop.


../hw/mem/cxl_type3.c:211:5: error: a label can only be part of a statement
and a declaration is not a statement
=A0 211 | =A0 =A0 int i;
=A0 =A0 =A0 | =A0 =A0 ^~~
> =20
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, voi=
d *priv)
> @@ -378,16 +413,48 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>      CXLDVSECRegisterLocator *regloc_dvsec;
>      uint8_t *dvsec;
>      int i;
> +    uint32_t range1_size_hi, range1_size_lo,
> +             range1_base_hi, range1_base_lo,
> +             range2_size_hi =3D 0, range2_size_lo =3D 0,
> +             range2_base_hi =3D 0, range2_base_lo =3D 0;
> +
> +    /*
> +     * Volatile memory is mapped as (0x0)
> +     * Persistent memory is mapped at (volatile->size)
> +     */
> +    if (ct3d->hostvmem) {
> +        range1_size_hi =3D ct3d->hostvmem->size >> 32;
> +        range1_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
> +                         (ct3d->hostvmem->size & 0xF0000000);
> +        range1_base_hi =3D 0;
> +        range1_base_lo =3D 0;
> +        if (ct3d->hostpmem) {
> +            range2_size_hi =3D ct3d->hostpmem->size >> 32;
> +            range2_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
> +                             (ct3d->hostpmem->size & 0xF0000000);
> +            range2_base_hi =3D ct3d->hostvmem->size >> 32;
> +            range2_base_lo =3D ct3d->hostvmem->size & 0xF0000000;
> +        }
> +    } else {
> +        range1_size_hi =3D ct3d->hostpmem->size >> 32;
> +        range1_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
> +                         (ct3d->hostpmem->size & 0xF0000000);
> +        range1_base_hi =3D 0;
> +        range1_base_lo =3D 0;
> +    }
> =20
>      dvsec =3D (uint8_t *)&(CXLDVSECDevice){
>          .cap =3D 0x1e,
>          .ctrl =3D 0x2,
>          .status2 =3D 0x2,
> -        .range1_size_hi =3D ct3d->hostmem->size >> 32,
> -        .range1_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
> -        (ct3d->hostmem->size & 0xF0000000),
> -        .range1_base_hi =3D 0,
> -        .range1_base_lo =3D 0,
> +        .range1_size_hi =3D range1_size_hi,
> +        .range1_size_lo =3D range1_size_lo,
> +        .range1_base_hi =3D range1_base_hi,
> +        .range1_base_lo =3D range1_base_lo,
> +        .range2_size_hi =3D range2_size_hi,
> +        .range2_size_lo =3D range2_size_lo,
> +        .range2_base_hi =3D range2_base_hi,
> +        .range2_base_lo =3D range2_base_lo
>      };
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
>                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
> @@ -475,33 +542,62 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Err=
or **errp)
>      MemoryRegion *mr;
>      char *name;
> =20
> -    if (!ct3d->hostmem) {
> -        error_setg(errp, "memdev property must be set");
> +    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
> +        error_setg(errp, "at least one memdev property must be set");
>          return false;
> +    } else if (ct3d->hostmem && ct3d->hostpmem) {
> +        error_setg(errp, "[memdev] cannot be used with new "
> +                         "[persistent-memdev] property");
> +        return false;
> +    } else if (ct3d->hostmem) {
> +        /* Use of hostmem property implies pmem */
> +        ct3d->hostpmem =3D ct3d->hostmem;
> +        ct3d->hostmem =3D NULL;
>      }
> =20
> -    mr =3D host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        error_setg(errp, "memdev property must be set");
> +    if (ct3d->hostpmem && !ct3d->lsa) {
> +        error_setg(errp, "lsa property must be set for persistent device=
s");
>          return false;
>      }
> -    memory_region_set_nonvolatile(mr, true);
> -    memory_region_set_enabled(mr, true);
> -    host_memory_backend_set_mapped(ct3d->hostmem, true);
> =20
> -    if (ds->id) {
> -        name =3D g_strdup_printf("cxl-type3-dpa-space:%s", ds->id);
> -    } else {
> -        name =3D g_strdup("cxl-type3-dpa-space");
> +    if (ct3d->hostvmem) {
> +        mr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (!mr) {
> +            error_setg(errp, "volatile memdev must have backing device")=
;
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(mr, false);
> +        memory_region_set_enabled(mr, true);
> +        host_memory_backend_set_mapped(ct3d->hostvmem, true);
> +        if (ds->id) {
> +            name =3D g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds->=
id);
> +        } else {
> +            name =3D g_strdup("cxl-type3-dpa-vmem-space");
> +        }
> +        address_space_init(&ct3d->hostvmem_as, mr, name);
> +        ct3d->cxl_dstate.vmem_size =3D mr->size;
> +        ct3d->cxl_dstate.mem_size +=3D mr->size;
> +        g_free(name);
>      }
> -    address_space_init(&ct3d->hostmem_as, mr, name);
> -    g_free(name);
> -
> -    ct3d->cxl_dstate.pmem_size =3D ct3d->hostmem->size;
> =20
> -    if (!ct3d->lsa) {
> -        error_setg(errp, "lsa property must be set");
> -        return false;
> +    if (ct3d->hostpmem) {
> +        mr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (!mr) {
> +            error_setg(errp, "persistent memdev must have backing device=
");
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(mr, true);
> +        memory_region_set_enabled(mr, true);
> +        host_memory_backend_set_mapped(ct3d->hostpmem, true);
> +        if (ds->id) {
> +            name =3D g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds->=
id);
> +        } else {
> +            name =3D g_strdup("cxl-type3-dpa-pmem-space");
> +        }
> +        address_space_init(&ct3d->hostpmem_as, mr, name);
> +        ct3d->cxl_dstate.pmem_size =3D mr->size;
> +        ct3d->cxl_dstate.mem_size +=3D mr->size;
> +        g_free(name);
>      }
> =20
>      return true;
> @@ -609,7 +705,12 @@ err_free_spdm_socket:
>  err_free_special_ops:
>      g_free(regs->special_ops);
>  err_address_space_free:
> -    address_space_destroy(&ct3d->hostmem_as);
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }
>      return;
>  }
> =20
> @@ -623,7 +724,12 @@ static void ct3_exit(PCIDevice *pci_dev)
>      cxl_doe_cdat_release(cxl_cstate);
>      spdm_sock_fini(ct3d->doe_spdm.socket);
>      g_free(regs->special_ops);
> -    address_space_destroy(&ct3d->hostmem_as);
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }
>  }
> =20
>  /* TODO: Support multiple HDM decoders and DPA skip */
> @@ -663,11 +769,17 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr hos=
t_addr, uint64_t *data,
>  {
>      CXLType3Dev *ct3d =3D CXL_TYPE3(d);
>      uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
> +    AddressSpace *as;
> =20
> -    /* TODO support volatile region */
> -    mr =3D host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    if (ct3d->hostvmem) {
> +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
>          return MEMTX_ERROR;
>      }
> =20
> @@ -675,11 +787,22 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr hos=
t_addr, uint64_t *data,
>          return MEMTX_ERROR;
>      }
> =20
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
>          return MEMTX_ERROR;
>      }
> =20
> -    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data=
, size);
> +    if (vmr) {
> +        if (dpa_offset <=3D int128_get64(vmr->size)) {
> +            as =3D &ct3d->hostvmem_as;
> +        } else {
> +            as =3D &ct3d->hostpmem_as;
> +            dpa_offset -=3D vmr->size;
> +        }
> +    }
> +    else {
> +        as =3D &ct3d->hostpmem_as;
> +    }
> +    return address_space_read(as, dpa_offset, attrs, data, size);
>  }
> =20
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t dat=
a,
> @@ -687,10 +810,17 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr ho=
st_addr, uint64_t data,
>  {
>      CXLType3Dev *ct3d =3D CXL_TYPE3(d);
>      uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
> +    AddressSpace *as;
> =20
> -    mr =3D host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> +    if (ct3d->hostvmem) {
> +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> +    }
> +
> +    if (!vmr && !pmr) {
>          return MEMTX_OK;
>      }
> =20
> @@ -698,11 +828,22 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr ho=
st_addr, uint64_t data,
>          return MEMTX_OK;
>      }
> =20
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    if (dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
>          return MEMTX_OK;
>      }
> -    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
> -                               &data, size);
> +
> +    if (vmr) {
> +        if (dpa_offset <=3D int128_get64(vmr->size)) {
> +            as =3D &ct3d->hostvmem_as;
> +        } else {
> +            as =3D &ct3d->hostpmem_as;
> +            dpa_offset -=3D vmr->size;
> +        }
> +    }
> +    else {
> +        as =3D &ct3d->hostpmem_as;
> +    }
> +    return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
> =20
>  static void ct3d_reset(DeviceState *dev)
> @@ -717,7 +858,11 @@ static void ct3d_reset(DeviceState *dev)
> =20
>  static Property ct3_props[] =3D {
>      DEFINE_PROP_LINK("memdev", CXLType3Dev, hostmem, TYPE_MEMORY_BACKEND=
,
> -                     HostMemoryBackend *),
> +                     HostMemoryBackend *), /* for backward compatibility=
 */
> +    DEFINE_PROP_LINK("persistent-memdev", CXLType3Dev, hostpmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
> +    DEFINE_PROP_LINK("volatile-memdev", CXLType3Dev, hostvmem,
> +                     TYPE_MEMORY_BACKEND, HostMemoryBackend *),
>      DEFINE_PROP_LINK("lsa", CXLType3Dev, lsa, TYPE_MEMORY_BACKEND,
>                       HostMemoryBackend *),
>      DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> @@ -728,10 +873,12 @@ static Property ct3_props[] =3D {
> =20
>  static uint64_t get_lsa_size(CXLType3Dev *ct3d)
>  {
> -    MemoryRegion *mr;
> -
> -    mr =3D host_memory_backend_get_memory(ct3d->lsa);
> -    return memory_region_size(mr);
> +    MemoryRegion *mr =3D NULL;
> +    if (ct3d->lsa) {
> +        mr =3D host_memory_backend_get_memory(ct3d->lsa);
> +        return memory_region_size(mr);
> +    }
> +    return 0;
>  }
> =20
>  static void validate_lsa_access(MemoryRegion *mr, uint64_t size,
> @@ -744,30 +891,35 @@ static void validate_lsa_access(MemoryRegion *mr, u=
int64_t size,
>  static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf, uint64_t size,
>                      uint64_t offset)
>  {
> -    MemoryRegion *mr;
> +    MemoryRegion *mr =3D NULL;
>      void *lsa;
> =20
> -    mr =3D host_memory_backend_get_memory(ct3d->lsa);
> -    validate_lsa_access(mr, size, offset);
> +    if (ct3d->lsa) {
> +        mr =3D host_memory_backend_get_memory(ct3d->lsa);
> +        validate_lsa_access(mr, size, offset);
> =20
> -    lsa =3D memory_region_get_ram_ptr(mr) + offset;
> -    memcpy(buf, lsa, size);
> +        lsa =3D memory_region_get_ram_ptr(mr) + offset;
> +        memcpy(buf, lsa, size);
> +        return size;
> +    }
> =20
> -    return size;
> +    return 0;
>  }
> =20
>  static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
>                      uint64_t offset)
>  {
> -    MemoryRegion *mr;
> -    void *lsa;
> +    MemoryRegion *mr =3D NULL;
> +    void *lsa =3D NULL;
> =20
> -    mr =3D host_memory_backend_get_memory(ct3d->lsa);
> -    validate_lsa_access(mr, size, offset);
> +    if (ct3d->lsa) {
> +        mr =3D host_memory_backend_get_memory(ct3d->lsa);
> +        validate_lsa_access(mr, size, offset);
> =20
> -    lsa =3D memory_region_get_ram_ptr(mr) + offset;
> -    memcpy(lsa, buf, size);
> -    memory_region_set_dirty(mr, offset, size);
> +        lsa =3D memory_region_get_ram_ptr(mr) + offset;
> +        memcpy(lsa, buf, size);
> +        memory_region_set_dirty(mr, offset, size);
> +    }
> =20
>      /*
>       * Just like the PMEM, if the guest is not allowed to exit gracefull=
y, label
> @@ -978,7 +1130,7 @@ static void ct3_class_init(ObjectClass *oc, void *da=
ta)
>      pc->config_read =3D ct3d_config_read;
> =20
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
> -    dc->desc =3D "CXL PMEM Device (Type 3)";
> +    dc->desc =3D "CXL Memory Device (Type 3)";
>      dc->reset =3D ct3d_reset;
>      device_class_set_props(dc, ct3_props);
> =20
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index 1cd71afcb6..1b366b739c 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -180,8 +180,10 @@ typedef struct cxl_device_state {
>          uint64_t host_set;
>      } timestamp;
> =20
> -    /* memory region for persistent memory, HDM */
> +    /* memory region size, HDM */
> +    uint64_t mem_size;
>      uint64_t pmem_size;
> +    uint64_t vmem_size;
> =20
>      struct cxl_cmd (*cxl_cmd_set)[256];
>      /* Move me later */
> @@ -311,12 +313,15 @@ struct CXLType3Dev {
>      PCIDevice parent_obj;
> =20
>      /* Properties */
> -    HostMemoryBackend *hostmem;
> +    HostMemoryBackend *hostmem; /* deprecated */
> +    HostMemoryBackend *hostvmem;
> +    HostMemoryBackend *hostpmem;
>      HostMemoryBackend *lsa;
>      uint64_t sn;
> =20
>      /* State */
> -    AddressSpace hostmem_as;
> +    AddressSpace hostvmem_as;
> +    AddressSpace hostpmem_as;
>      CXLComponentState cxl_cstate;
>      CXLDeviceState cxl_dstate;
> =20
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index e59ba22387..6893f54e28 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -40,32 +40,46 @@
>    "-device cxl-rp,id=3Drp2,bus=3Dcxl.1,chassis=3D0,slot=3D2 " \
>    "-device cxl-rp,id=3Drp3,bus=3Dcxl.1,chassis=3D0,slot=3D3 "
> =20
> -#define QEMU_T3D \
> +#define QEMU_T3D_DEPRECATED \
>    "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M "=
 \
> -  "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M "    =
\
> +  "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
>    "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-pme=
m0 "
> =20
> +#define QEMU_T3D_PMEM \
> +  "-object memory-backend-file,id=3Dm0,mem-path=3D%s,size=3D256M " \
> +  "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> +  "-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-m0,lsa=3Dlsa0,id=
=3Dpmem0 "
> +
> +#define QEMU_T3D_VMEM \
> +  "-object memory-backend-ram,id=3Dmem0,size=3D256M " \
> +  "-device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,id=3Dmem0 "
> +
> +#define QEMU_T3D_VMEM_LSA \
> +  "-object memory-backend-ram,id=3Dmem0,size=3D256M " \
> +  "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> +  "-device cxl-type3,bus=3Drp0,volatile-memdev=3Dmem0,lsa=3Dlsa0,id=3Dme=
m0 "
> +
>  #define QEMU_2T3D \
>    "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M "=
 \
>    "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> -  "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-pme=
m0 " \
> +  "-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0,i=
d=3Dpmem0 " \
>    "-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D%s,size=3D256M "=
 \
>    "-object memory-backend-file,id=3Dlsa1,mem-path=3D%s,size=3D256M " \
> -  "-device cxl-type3,bus=3Drp1,memdev=3Dcxl-mem1,lsa=3Dlsa1,id=3Dcxl-pme=
m1 "
> +  "-device cxl-type3,bus=3Drp1,persistent-memdev=3Dcxl-mem1,lsa=3Dlsa1,i=
d=3Dpmem1 "
> =20
>  #define QEMU_4T3D \
>    "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M "=
 \
>    "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> -  "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-pme=
m0 " \
> +  "-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0,i=
d=3Dpmem0 " \
>    "-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D%s,size=3D256M "=
 \
>    "-object memory-backend-file,id=3Dlsa1,mem-path=3D%s,size=3D256M " \
> -  "-device cxl-type3,bus=3Drp1,memdev=3Dcxl-mem1,lsa=3Dlsa1,id=3Dcxl-pme=
m1 " \
> +  "-device cxl-type3,bus=3Drp1,persistent-memdev=3Dcxl-mem1,lsa=3Dlsa1,i=
d=3Dpmem1 " \
>    "-object memory-backend-file,id=3Dcxl-mem2,mem-path=3D%s,size=3D256M "=
 \
>    "-object memory-backend-file,id=3Dlsa2,mem-path=3D%s,size=3D256M " \
> -  "-device cxl-type3,bus=3Drp2,memdev=3Dcxl-mem2,lsa=3Dlsa2,id=3Dcxl-pme=
m2 " \
> +  "-device cxl-type3,bus=3Drp2,persistent-memdev=3Dcxl-mem2,lsa=3Dlsa2,i=
d=3Dpmem2 " \
>    "-object memory-backend-file,id=3Dcxl-mem3,mem-path=3D%s,size=3D256M "=
 \
>    "-object memory-backend-file,id=3Dlsa3,mem-path=3D%s,size=3D256M " \
> -  "-device cxl-type3,bus=3Drp3,memdev=3Dcxl-mem3,lsa=3Dlsa3,id=3Dcxl-pme=
m3 "
> +  "-device cxl-type3,bus=3Drp3,persistent-memdev=3Dcxl-mem3,lsa=3Dlsa3,i=
d=3Dpmem3 "
> =20
>  static void cxl_basic_hb(void)
>  {
> @@ -104,14 +118,53 @@ static void cxl_2root_port(void)
>  }
> =20
>  #ifdef CONFIG_POSIX
> -static void cxl_t3d(void)
> +static void cxl_t3d_deprecated(void)
> +{
> +    g_autoptr(GString) cmdline =3D g_string_new(NULL);
> +    g_autofree const char *tmpfs =3D NULL;
> +
> +    tmpfs =3D g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> +
> +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_DEPRECATED,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +}
> +
> +static void cxl_t3d_persistent(void)
> +{
> +    g_autoptr(GString) cmdline =3D g_string_new(NULL);
> +    g_autofree const char *tmpfs =3D NULL;
> +
> +    tmpfs =3D g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> +
> +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_PMEM,
> +                    tmpfs, tmpfs);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +}
> +
> +static void cxl_t3d_volatile(void)
> +{
> +    g_autoptr(GString) cmdline =3D g_string_new(NULL);
> +
> +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM);
> +
> +    qtest_start(cmdline->str);
> +    qtest_end();
> +}
> +
> +static void cxl_t3d_volatile_lsa(void)
>  {
>      g_autoptr(GString) cmdline =3D g_string_new(NULL);
>      g_autofree const char *tmpfs =3D NULL;
> =20
>      tmpfs =3D g_dir_make_tmp("cxl-test-XXXXXX", NULL);
> =20
> -    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D, tmpfs, tmpfs=
);
> +    g_string_printf(cmdline, QEMU_PXB_CMD QEMU_RP QEMU_T3D_VMEM_LSA,
> +                    tmpfs);
> =20
>      qtest_start(cmdline->str);
>      qtest_end();
> @@ -179,7 +232,10 @@ int main(int argc, char **argv)
>          qtest_add_func("/pci/cxl/rp", cxl_root_port);
>          qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>  #ifdef CONFIG_POSIX
> -        qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
> +        qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> +        qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent)=
;
> +        qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> +        qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatil=
e_lsa);
>          qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
>          qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4",
>                         cxl_2pxb_4rp_4t3d);
> --=20
> 2.37.3
>=20
> =
