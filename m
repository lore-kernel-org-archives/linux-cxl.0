Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01432C636CC
	for <linux-cxl@archiver.kernel.org>; Thu, 16 Feb 2023 18:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229777AbjBPSml (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 16 Feb 2023 13:42:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjBPSml (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 16 Feb 2023 13:42:41 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9276250345
        for <linux-cxl@vger.kernel.org>; Thu, 16 Feb 2023 10:42:28 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230216184226usoutp0182e1b861ab0ab24282650b59e9d3b32b~EYjYyYt4i1561715617usoutp01G;
        Thu, 16 Feb 2023 18:42:26 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230216184226usoutp0182e1b861ab0ab24282650b59e9d3b32b~EYjYyYt4i1561715617usoutp01G
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676572946;
        bh=eprGYAk4QnCVNt4CAGGMJnUKYp18nsz/5bi2Mn3J9qo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=T+C5n0NHhZ6ySrfd28mvZVYUPrTQDWTGBoUMdIjCXOcp706CLPsMhmKcGHdG814Zr
         MYC3m5iHuwvB5bbgObUF+HTMAQRxTXW0+H71n3XsvLzdWO8n+Dk2KnR3zcNUCTMJ4O
         1Jshl+xUeSq8a5oGwGmL0wcXsOSa6+XPr5/38WBw=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230216184226uscas1p24143581c90b0ee4cd1b66bf1b01023bc~EYjYovFLC0071500715uscas1p2q;
        Thu, 16 Feb 2023 18:42:26 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 49.2C.06976.1197EE36; Thu,
        16 Feb 2023 13:42:25 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230216184225uscas1p2bb2f60fe3d6f0d1f8d9ffe2ff377e190~EYjYOOerU3227332273uscas1p2q;
        Thu, 16 Feb 2023 18:42:25 +0000 (GMT)
X-AuditID: cbfec36d-afdff70000011b40-a6-63ee791142a8
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 30.F7.11346.1197EE36; Thu,
        16 Feb 2023 13:42:25 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 16 Feb 2023 10:42:24 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        16 Feb 2023 10:42:24 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Thread-Topic: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
        and Persistent)
Thread-Index: AQHZQjZpWt0anxAoHU61497Cp1Ks6w==
Date:   Thu, 16 Feb 2023 18:42:24 +0000
Message-ID: <20230216184215.GA1083338@bgt-140510-bm03>
In-Reply-To: <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <4568609578EC874C9DDD31E891AE6461@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKKsWRmVeSWpSXmKPExsWy7djX87qCle+SDTb8NrNonryY0WL1zTWM
        Fi/+PGey2P/0OYvFqoXX2CzOzzrFYnF44xkmi99rHzNZ/P/1itVizQphi+O9O1gcuD12zrrL
        7tFy5C2rx+I9L5k8Nq3qZPO4c20Pm8eTa5uZPN7vu8rmMXV2vcfnTXIBnFFcNimpOZllqUX6
        dglcGcdPvGUvOLWEqWLG1ONsDYxP7jJ2MXJySAiYSPzf8IWti5GLQ0hgJaPElX1TmSGcViaJ
        65M6mGGqjjV+ZodIrGWUWL1gCZTziVFi8rTtLBDOMkaJmYtWsoG0sAkoSuzr2g5miwgYSby7
        MYkRpIhZ4AezxP6zT9hBEsICMRI7/+5mhCiKldi7tx2qQU/izY5pLCA2i4CqxPJFG8FqeAXM
        JB7sOA5WwyngKLHm3glWEJtRQEzi+6k1TCA2s4C4xK0n85kg7haUWDR7D9QPYhL/dj1kg7AV
        Je5/f8kOUa8ncWPqFDYI207i1trvjBC2tsSyha+ZIfYKSpyc+YQFoldS4uCKG2AfSwhM55R4
        0fwbKuEiMePeVShbWmL6mstANgeQnSyx6iMXRDhHYv6SLVAl1hIL/6xnmsCoMgvJ2bOQnDQL
        yUmzkJw0C8lJCxhZVzGKlxYX56anFhvmpZbrFSfmFpfmpesl5+duYgSmvNP/DufuYNxx66Pe
        IUYmDsZDjBIczEoivJtuvkkW4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmtoezJZSCA9sSQ1OzW1
        ILUIJsvEwSnVwDSrfJYK57pCi10JAbOOtL3Ka5JgLjqSE9ecHOr4tHuvCnfxG5PTdYa+G89H
        qXsm3Z50eGPr3kynt/feR5+Svi/ldq3Aj+nxdO/HOXfmaAmpPLBeuvDBT90FvQqZgitmVzJY
        JymsiHITs9//XyVOzY3Za/PJ7arWtckMLhWrDwg1KmUpzw5+9H2aY/ZLKaHcxkWBj1xtZ91a
        e/yCnc5uK3nbls9CCz3Djh071PpJqEI54+Hho9xVTtu5hSIeeDQ2hTAnXRMr3bfs/TT+eHme
        DjnTu8uWLFsrEehWtNJVeOonnwqpJrX9LhxXfE8uCFydcOP/wxbxSSFuNj+/tDVIidy1jRT8
        x5Ugf3uOoO51JZbijERDLeai4kQAz7XySugDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWS2cA0SVew8l2ywZlVMhbNkxczWqy+uYbR
        4sWf50wW+58+Z7FYtfAam8X5WadYLA5vPMNk8XvtYyaL/79esVqsWSFscbx3B4sDt8fOWXfZ
        PVqOvGX1WLznJZPHplWdbB53ru1h83hybTOTx/t9V9k8ps6u9/i8SS6AM4rLJiU1J7MstUjf
        LoEr4/iJt+wFp5YwVcyYepytgfHJXcYuRk4OCQETiWONn9m7GLk4hARWM0qcnb2dGcL5xCjx
        aUULVGYZo8S06Q/YQVrYBBQl9nVtZwOxRQSMJN7dmAQ2ilngB7NE0y0ZEFtYIEbiR/djpi5G
        DqCaWInXx9QgyvUk3uyYxgJiswioSixftBGslVfATOLBjuNgI4UEyiVW31sKZnMKOEqsuXeC
        FcRmFBCT+H5qDRPEKnGJW0/mM0F8ICCxZM95ZghbVOLl43+sELaixP3vL9kh6vUkbkydwgZh
        20ncWvsd6mRtiWULXzND3CAocXLmExaIXkmJgytusExglJiFZN0sJKNmIRk1C8moWUhGLWBk
        XcUoXlpcnJteUWycl1quV5yYW1yal66XnJ+7iRGYKk7/Oxyzg/HerY96hxiZOBgPMUpwMCuJ
        8G66+SZZiDclsbIqtSg/vqg0J7X4EKM0B4uSOK9H7MR4IYH0xJLU7NTUgtQimCwTB6dUA1Ps
        54n5pyZ/cNSds8tkTmDi1INz2U7kbtAX9a79f3Wt7CVfUSnB4N+tzDL1EjPmfDTN2vFS7mGb
        ZbNV/eY9yn4r3vlKxX5+viBYe8r26+22ToLdbgktdavbfvntilv9il3lygrnYnbzBy//ftPl
        zH/udv94Z/GWufsDcrp/rlSQuvbhZjLTvbJI5h1/+BMub2y1Wl948MHtLad7X/W3aR521164
        aMrP/gPWnF/O7jpcXL96Nb9GWWhHqTVHzPJ+Pa87LxzfPYw/ckW//7FU9/73jueLDk+patd2
        fJL4z6JmhuvtyylJD68y/7yzaTl7VudT394ZG9PXetw6Ize3YOWxdRuVoycvC+1yaZh9xFxZ
        iaU4I9FQi7moOBEAV+IJ9IQDAAA=
X-CMS-MailID: 20230216184225uscas1p2bb2f60fe3d6f0d1f8d9ffe2ff377e190
CMS-TYPE: 301P
X-CMS-RootMailID: 20230216184225uscas1p2bb2f60fe3d6f0d1f8d9ffe2ff377e190
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
        <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
        <CGME20230216184225uscas1p2bb2f60fe3d6f0d1f8d9ffe2ff377e190@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 31, 2023 at 04:38:47PM +0000, Jonathan Cameron wrote:

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
>=20

Reviewed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>

Tested a single HB, single RP, single volatile memdev setup (with
kernel volatile patch from Dan), it passed the following ops,
1. cxl list
2. cxl create-region
3. daxctl online-memory dax0.0
4. simple apps to use cxl memory with "numactl --membind=3D1"

> ---
> Chances since RFC V4:
> - Fixed up issue reported by Gregory of volatile regions being reported
>   as non volatile in CDAT.  Fix as suggested by Gregory.
> - Report volatile memory as EFI_MEMORY_SP.
> - Fixed some naming issues in tests including sticking to existing
>   naming for memory device of cxl-memX throughout.
> - Update the bios-tables-test.c test to use the new non deprecated
>   parameter name. Note this has no impact on generated tables.
> - Flipped logic of get_lsa_size() callback to slightly simplify change.
> - cxl_setup_memory() reduce scope of local variables and name them
>   to make it clear which are volatile and which are persistent related.
>=20
>  docs/system/devices/cxl.rst    |  49 ++++--
>  hw/cxl/cxl-mailbox-utils.c     |  26 +--
>  hw/mem/cxl_type3.c             | 300 +++++++++++++++++++++++++--------
>  include/hw/cxl/cxl_device.h    |  11 +-
>  tests/qtest/bios-tables-test.c |   8 +-
>  tests/qtest/cxl-test.c         |  76 +++++++--
>  6 files changed, 359 insertions(+), 111 deletions(-)
>=20
> diff --git a/docs/system/devices/cxl.rst b/docs/system/devices/cxl.rst
> index f25783a4ec..89a41cff73 100644
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
> +The Type 3 device [memdev] attribute has been deprecated in favor of the
> +[persistent-memdev] attributes. [memdev] will default to a persistent me=
mory
> +device for backward compatibility and is incapable of being used in comb=
ination
> +with [persistent-memdev].
> +
>  Kernel Configuration Options
>  ----------------------------
> =20
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 206e04a4b8..cc9c8b7380 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -141,7 +141,8 @@ static ret_code cmd_firmware_update_get_info(struct c=
xl_cmd *cmd,
>      } QEMU_PACKED *fw_info;
>      QEMU_BUILD_BUG_ON(sizeof(*fw_info) !=3D 0x50);
> =20
> -    if (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) {
> +    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
> +        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
>          return CXL_MBOX_INTERNAL_ERROR;
>      }
> =20
> @@ -288,20 +289,20 @@ static ret_code cmd_identify_memory_device(struct c=
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
> =20
>      *len =3D sizeof(*id);
> @@ -319,16 +320,19 @@ static ret_code cmd_ccls_get_partition_info(struct =
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
> +    /*
> +     * When both next_vmem and next_pmem are 0, there is no pending chan=
ge to
> +     * partitioning.
> +     */
>      part_info->next_vmem =3D 0;
> -    part_info->active_pmem =3D size / CXL_CAPACITY_MULTIPLIER;
> +    part_info->active_pmem =3D cxl_dstate->pmem_size / CXL_CAPACITY_MULT=
IPLIER;
>      part_info->next_pmem =3D 0;
> =20
>      *len =3D sizeof(*part_info);
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index e32bbac966..beb931d59a 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -31,7 +31,8 @@ enum {
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
> @@ -50,8 +51,8 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader =
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
> @@ -130,8 +131,11 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHead=
er **cdat_table,
>              .length =3D sizeof(*dsemts),
>          },
>          .DSMAS_handle =3D dsmad_handle,
> -        /* Reserved - the non volatile from DSMAS matters */
> -        .EFI_memory_type_attr =3D 2,
> +        /*
> +         * NV: Reserved - the non volatile from DSMAS matters
> +         * V: EFI_MEMORY_SP
> +         */
> +        .EFI_memory_type_attr =3D is_pmem ? 2 : 1,
>          .DPA_offset =3D 0,
>          .DPA_length =3D int128_get64(mr->size),
>      };
> @@ -150,33 +154,66 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHea=
der **cdat_table,
>  static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
>  {
>      g_autofree CDATSubHeader **table =3D NULL;
> -    MemoryRegion *nonvolatile_mr;
>      CXLType3Dev *ct3d =3D priv;
> +    MemoryRegion *volatile_mr =3D NULL, *nonvolatile_mr =3D NULL;
>      int dsmad_handle =3D 0;
> -    int rc;
> +    int cur_ent =3D 0;
> +    int len =3D 0;
> +    int rc, i;
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
> +                                           false, 0);
> +        if (rc < 0) {
> +            return rc;
> +        }
> +        cur_ent =3D CT3_CDAT_NUM_ENTRIES;
>      }
> =20
> +    if (nonvolatile_mr) {
> +        rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_ha=
ndle++,
> +                nonvolatile_mr, true, (volatile_mr ? volatile_mr->size :=
 0));
> +        if (rc < 0) {
> +            goto error_cleanup;
> +        }
> +        cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
> +    }
> +    assert(len =3D=3D cur_ent);
> +
>      *cdat_table =3D g_steal_pointer(&table);
> =20
> -    return CT3_CDAT_NUM_ENTRIES;
> +    return len;
> +error_cleanup:
> +    for (i =3D 0; i < cur_ent; i++) {
> +        g_free(table[i]);
> +    }
> +    return rc;
>  }
> =20
>  static void ct3_free_cdat_table(CDATSubHeader **cdat_table, int num, voi=
d *priv)
> @@ -264,16 +301,48 @@ static void build_dvsecs(CXLType3Dev *ct3d)
>  {
>      CXLComponentState *cxl_cstate =3D &ct3d->cxl_cstate;
>      uint8_t *dvsec;
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
> +        .range2_base_lo =3D range2_base_lo,
>      };
>      cxl_component_create_dvsec(cxl_cstate, CXL2_TYPE3_DEVICE,
>                                 PCIE_CXL_DEVICE_DVSEC_LENGTH,
> @@ -492,36 +561,69 @@ static void ct3d_reg_write(void *opaque, hwaddr off=
set, uint64_t value,
>  static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
>  {
>      DeviceState *ds =3D DEVICE(ct3d);
> -    MemoryRegion *mr;
> -    char *name;
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
> +        MemoryRegion *vmr;
> +        char *v_name;
> +
> +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +        if (!vmr) {
> +            error_setg(errp, "volatile memdev must have backing device")=
;
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(vmr, false);
> +        memory_region_set_enabled(vmr, true);
> +        host_memory_backend_set_mapped(ct3d->hostvmem, true);
> +        if (ds->id) {
> +            v_name =3D g_strdup_printf("cxl-type3-dpa-vmem-space:%s", ds=
->id);
> +        } else {
> +            v_name =3D g_strdup("cxl-type3-dpa-vmem-space");
> +        }
> +        address_space_init(&ct3d->hostvmem_as, vmr, v_name);
> +        ct3d->cxl_dstate.vmem_size =3D vmr->size;
> +        ct3d->cxl_dstate.mem_size +=3D vmr->size;
> +        g_free(v_name);
>      }
> -    address_space_init(&ct3d->hostmem_as, mr, name);
> -    g_free(name);
> =20
> -    ct3d->cxl_dstate.pmem_size =3D ct3d->hostmem->size;
> +    if (ct3d->hostpmem) {
> +        MemoryRegion *pmr;
> +        char *p_name;
> =20
> -    if (!ct3d->lsa) {
> -        error_setg(errp, "lsa property must be set");
> -        return false;
> +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
> +        if (!pmr) {
> +            error_setg(errp, "persistent memdev must have backing device=
");
> +            return false;
> +        }
> +        memory_region_set_nonvolatile(pmr, true);
> +        memory_region_set_enabled(pmr, true);
> +        host_memory_backend_set_mapped(ct3d->hostpmem, true);
> +        if (ds->id) {
> +            p_name =3D g_strdup_printf("cxl-type3-dpa-pmem-space:%s", ds=
->id);
> +        } else {
> +            p_name =3D g_strdup("cxl-type3-dpa-pmem-space");
> +        }
> +        address_space_init(&ct3d->hostpmem_as, pmr, p_name);
> +        ct3d->cxl_dstate.pmem_size =3D pmr->size;
> +        ct3d->cxl_dstate.mem_size +=3D pmr->size;
> +        g_free(p_name);
>      }
> =20
>      return true;
> @@ -607,7 +709,12 @@ err_release_cdat:
>      cxl_doe_cdat_release(cxl_cstate);
>      g_free(regs->special_ops);
>  err_address_space_free:
> -    address_space_destroy(&ct3d->hostmem_as);
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
>      return;
>  }
> =20
> @@ -620,7 +727,12 @@ static void ct3_exit(PCIDevice *pci_dev)
>      pcie_aer_exit(pci_dev);
>      cxl_doe_cdat_release(cxl_cstate);
>      g_free(regs->special_ops);
> -    address_space_destroy(&ct3d->hostmem_as);
> +    if (ct3d->hostpmem) {
> +        address_space_destroy(&ct3d->hostpmem_as);
> +    }
> +    if (ct3d->hostvmem) {
> +        address_space_destroy(&ct3d->hostvmem_as);
> +    }
>  }
> =20
>  /* TODO: Support multiple HDM decoders and DPA skip */
> @@ -655,51 +767,77 @@ static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr=
 host_addr, uint64_t *dpa)
>      return true;
>  }
> =20
> -MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *dat=
a,
> -                           unsigned size, MemTxAttrs attrs)
> +static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
> +                                       hwaddr host_addr,
> +                                       unsigned int size,
> +                                       AddressSpace **as,
> +                                       uint64_t *dpa_offset)
>  {
> -    CXLType3Dev *ct3d =3D CXL_TYPE3(d);
> -    uint64_t dpa_offset;
> -    MemoryRegion *mr;
> +    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
> =20
> -    /* TODO support volatile region */
> -    mr =3D host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        return MEMTX_ERROR;
> +    if (ct3d->hostvmem) {
> +        vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
> +    }
> +    if (ct3d->hostpmem) {
> +        pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
>      }
> =20
> -    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> -        return MEMTX_ERROR;
> +    if (!vmr && !pmr) {
> +        return -ENODEV;
> +    }
> +
> +    if (!cxl_type3_dpa(ct3d, host_addr, dpa_offset)) {
> +        return -EINVAL;
> +    }
> +
> +    if (*dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
> +        return -EINVAL;
> +    }
> +
> +    if (vmr) {
> +        if (*dpa_offset <=3D int128_get64(vmr->size)) {
> +            *as =3D &ct3d->hostvmem_as;
> +        } else {
> +            *as =3D &ct3d->hostpmem_as;
> +            *dpa_offset -=3D vmr->size;
> +        }
> +    } else {
> +        *as =3D &ct3d->hostpmem_as;
>      }
> =20
> -    if (dpa_offset > int128_get64(mr->size)) {
> +    return 0;
> +}
> +
> +MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *dat=
a,
> +                           unsigned size, MemTxAttrs attrs)
> +{
> +    uint64_t dpa_offset =3D 0;
> +    AddressSpace *as =3D NULL;
> +    int res;
> +
> +    res =3D cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
> +                                      &as, &dpa_offset);
> +    if (res) {
>          return MEMTX_ERROR;
>      }
> =20
> -    return address_space_read(&ct3d->hostmem_as, dpa_offset, attrs, data=
, size);
> +    return address_space_read(as, dpa_offset, attrs, data, size);
>  }
> =20
>  MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t dat=
a,
>                              unsigned size, MemTxAttrs attrs)
>  {
> -    CXLType3Dev *ct3d =3D CXL_TYPE3(d);
> -    uint64_t dpa_offset;
> -    MemoryRegion *mr;
> -
> -    mr =3D host_memory_backend_get_memory(ct3d->hostmem);
> -    if (!mr) {
> -        return MEMTX_OK;
> -    }
> +    uint64_t dpa_offset =3D 0;
> +    AddressSpace *as =3D NULL;
> +    int res;
> =20
> -    if (!cxl_type3_dpa(ct3d, host_addr, &dpa_offset)) {
> -        return MEMTX_OK;
> +    res =3D cxl_type3_hpa_to_as_and_dpa(CXL_TYPE3(d), host_addr, size,
> +                                      &as, &dpa_offset);
> +    if (res) {
> +        return MEMTX_ERROR;
>      }
> =20
> -    if (dpa_offset > int128_get64(mr->size)) {
> -        return MEMTX_OK;
> -    }
> -    return address_space_write(&ct3d->hostmem_as, dpa_offset, attrs,
> -                               &data, size);
> +    return address_space_write(as, dpa_offset, attrs, &data, size);
>  }
> =20
>  static void ct3d_reset(DeviceState *dev)
> @@ -714,7 +852,11 @@ static void ct3d_reset(DeviceState *dev)
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
> @@ -726,6 +868,10 @@ static uint64_t get_lsa_size(CXLType3Dev *ct3d)
>  {
>      MemoryRegion *mr;
> =20
> +    if (!ct3d->lsa) {
> +        return 0;
> +    }
> +
>      mr =3D host_memory_backend_get_memory(ct3d->lsa);
>      return memory_region_size(mr);
>  }
> @@ -743,6 +889,10 @@ static uint64_t get_lsa(CXLType3Dev *ct3d, void *buf=
, uint64_t size,
>      MemoryRegion *mr;
>      void *lsa;
> =20
> +    if (!ct3d->lsa) {
> +        return 0;
> +    }
> +
>      mr =3D host_memory_backend_get_memory(ct3d->lsa);
>      validate_lsa_access(mr, size, offset);
> =20
> @@ -758,6 +908,10 @@ static void set_lsa(CXLType3Dev *ct3d, const void *b=
uf, uint64_t size,
>      MemoryRegion *mr;
>      void *lsa;
> =20
> +    if (!ct3d->lsa) {
> +        return;
> +    }
> +
>      mr =3D host_memory_backend_get_memory(ct3d->lsa);
>      validate_lsa_access(mr, size, offset);
> =20
> @@ -929,7 +1083,7 @@ static void ct3_class_init(ObjectClass *oc, void *da=
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
> index d589f78202..edb9791bab 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -119,8 +119,10 @@ typedef struct cxl_device_state {
>          uint64_t host_set;
>      } timestamp;
> =20
> -    /* memory region for persistent memory, HDM */
> +    /* memory region size, HDM */
> +    uint64_t mem_size;
>      uint64_t pmem_size;
> +    uint64_t vmem_size;
>  } CXLDeviceState;
> =20
>  /* Initialize the register block for a device */
> @@ -245,12 +247,15 @@ struct CXLType3Dev {
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
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-tes=
t.c
> index 8608408213..b005c03a92 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1789,13 +1789,13 @@ static void test_acpi_q35_cxl(void)
>                               " -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,=
id=3Dcxl.1"
>                               " -device pxb-cxl,bus_nr=3D222,bus=3Dpcie.0=
,id=3Dcxl.2"
>                               " -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3D=
rp1,chassis=3D0,slot=3D2"
> -                             " -device cxl-type3,bus=3Drp1,memdev=3Dcxl-=
mem1,lsa=3Dlsa1"
> +                             " -device cxl-type3,bus=3Drp1,persistent-me=
mdev=3Dcxl-mem1,lsa=3Dlsa1"
>                               " -device cxl-rp,port=3D1,bus=3Dcxl.1,id=3D=
rp2,chassis=3D0,slot=3D3"
> -                             " -device cxl-type3,bus=3Drp2,memdev=3Dcxl-=
mem2,lsa=3Dlsa2"
> +                             " -device cxl-type3,bus=3Drp2,persistent-me=
mdev=3Dcxl-mem2,lsa=3Dlsa2"
>                               " -device cxl-rp,port=3D0,bus=3Dcxl.2,id=3D=
rp3,chassis=3D0,slot=3D5"
> -                             " -device cxl-type3,bus=3Drp3,memdev=3Dcxl-=
mem3,lsa=3Dlsa3"
> +                             " -device cxl-type3,bus=3Drp3,persistent-me=
mdev=3Dcxl-mem3,lsa=3Dlsa3"
>                               " -device cxl-rp,port=3D1,bus=3Dcxl.2,id=3D=
rp4,chassis=3D0,slot=3D6"
> -                             " -device cxl-type3,bus=3Drp4,memdev=3Dcxl-=
mem4,lsa=3Dlsa4"
> +                             " -device cxl-type3,bus=3Drp4,persistent-me=
mdev=3Dcxl-mem4,lsa=3Dlsa4"
>                               " -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.=
size=3D4G,cxl-fmw.0.interleave-granularity=3D8k,"
>                               "cxl-fmw.1.targets.0=3Dcxl.1,cxl-fmw.1.targ=
ets.1=3Dcxl.2,cxl-fmw.1.size=3D4G,cxl-fmw.1.interleave-granularity=3D8k",
>                               tmp_path, tmp_path, tmp_path, tmp_path,
> diff --git a/tests/qtest/cxl-test.c b/tests/qtest/cxl-test.c
> index eda2bbbbe6..edcad4a0ce 100644
> --- a/tests/qtest/cxl-test.c
> +++ b/tests/qtest/cxl-test.c
> @@ -34,32 +34,46 @@
>      "-device cxl-rp,id=3Drp2,bus=3Dcxl.1,chassis=3D0,slot=3D2 " \
>      "-device cxl-rp,id=3Drp3,bus=3Dcxl.1,chassis=3D0,slot=3D3 "
> =20
> -#define QEMU_T3D \
> +#define QEMU_T3D_DEPRECATED \
>      "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
>      "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-p=
mem0 "
> =20
> +#define QEMU_T3D_PMEM \
> +    "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M=
 " \
> +    "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> +    "-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0=
,id=3Dpmem0 "
> +
> +#define QEMU_T3D_VMEM \
> +    "-object memory-backend-ram,id=3Dcxl-mem0,size=3D256M " \
> +    "-device cxl-type3,bus=3Drp0,volatile-memdev=3Dcxl-mem0,id=3Dmem0 "
> +
> +#define QEMU_T3D_VMEM_LSA \
> +    "-object memory-backend-ram,id=3Dcxl-mem0,size=3D256M " \
> +    "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> +    "-device cxl-type3,bus=3Drp0,volatile-memdev=3Dcxl-mem0,lsa=3Dlsa0,i=
d=3Dmem0 "
> +
>  #define QEMU_2T3D \
>      "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> -    "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-p=
mem0 " \
> +    "-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0=
,id=3Dpmem0 " \
>      "-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa1,mem-path=3D%s,size=3D256M " \
> -    "-device cxl-type3,bus=3Drp1,memdev=3Dcxl-mem1,lsa=3Dlsa1,id=3Dcxl-p=
mem1 "
> +    "-device cxl-type3,bus=3Drp1,persistent-memdev=3Dcxl-mem1,lsa=3Dlsa1=
,id=3Dpmem1 "
> =20
>  #define QEMU_4T3D \
>      "-object memory-backend-file,id=3Dcxl-mem0,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa0,mem-path=3D%s,size=3D256M " \
> -    "-device cxl-type3,bus=3Drp0,memdev=3Dcxl-mem0,lsa=3Dlsa0,id=3Dcxl-p=
mem0 " \
> +    "-device cxl-type3,bus=3Drp0,persistent-memdev=3Dcxl-mem0,lsa=3Dlsa0=
,id=3Dpmem0 " \
>      "-object memory-backend-file,id=3Dcxl-mem1,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa1,mem-path=3D%s,size=3D256M " \
> -    "-device cxl-type3,bus=3Drp1,memdev=3Dcxl-mem1,lsa=3Dlsa1,id=3Dcxl-p=
mem1 " \
> +    "-device cxl-type3,bus=3Drp1,persistent-memdev=3Dcxl-mem1,lsa=3Dlsa1=
,id=3Dpmem1 " \
>      "-object memory-backend-file,id=3Dcxl-mem2,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa2,mem-path=3D%s,size=3D256M " \
> -    "-device cxl-type3,bus=3Drp2,memdev=3Dcxl-mem2,lsa=3Dlsa2,id=3Dcxl-p=
mem2 " \
> +    "-device cxl-type3,bus=3Drp2,persistent-memdev=3Dcxl-mem2,lsa=3Dlsa2=
,id=3Dpmem2 " \
>      "-object memory-backend-file,id=3Dcxl-mem3,mem-path=3D%s,size=3D256M=
 " \
>      "-object memory-backend-file,id=3Dlsa3,mem-path=3D%s,size=3D256M " \
> -    "-device cxl-type3,bus=3Drp3,memdev=3Dcxl-mem3,lsa=3Dlsa3,id=3Dcxl-p=
mem3 "
> +    "-device cxl-type3,bus=3Drp3,persistent-memdev=3Dcxl-mem3,lsa=3Dlsa3=
,id=3Dpmem3 "
> =20
>  static void cxl_basic_hb(void)
>  {
> @@ -98,14 +112,53 @@ static void cxl_2root_port(void)
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
> @@ -155,7 +208,10 @@ int main(int argc, char **argv)
>      qtest_add_func("/pci/cxl/rp", cxl_root_port);
>      qtest_add_func("/pci/cxl/rp_x2", cxl_2root_port);
>  #ifdef CONFIG_POSIX
> -    qtest_add_func("/pci/cxl/type3_device", cxl_t3d);
> +    qtest_add_func("/pci/cxl/type3_device", cxl_t3d_deprecated);
> +    qtest_add_func("/pci/cxl/type3_device_pmem", cxl_t3d_persistent);
> +    qtest_add_func("/pci/cxl/type3_device_vmem", cxl_t3d_volatile);
> +    qtest_add_func("/pci/cxl/type3_device_vmem_lsa", cxl_t3d_volatile_ls=
a);
>      qtest_add_func("/pci/cxl/rp_x2_type3_x2", cxl_1pxb_2rp_2t3d);
>      qtest_add_func("/pci/cxl/pxb_x2_root_port_x4_type3_x4", cxl_2pxb_4rp=
_4t3d);
>  #endif
> --=20
> 2.37.2
>=20
> =
