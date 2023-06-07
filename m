Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFFCDC7EE25
	for <linux-cxl@archiver.kernel.org>; Wed,  7 Jun 2023 18:31:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230424AbjFGSbP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 7 Jun 2023 14:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjFGSbN (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 7 Jun 2023 14:31:13 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72D9E79
        for <linux-cxl@vger.kernel.org>; Wed,  7 Jun 2023 11:31:09 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230607183108usoutp0134783ad18167962300d210b06fd9ccd0~mdANq7yWc1898518985usoutp01H;
        Wed,  7 Jun 2023 18:31:08 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230607183108usoutp0134783ad18167962300d210b06fd9ccd0~mdANq7yWc1898518985usoutp01H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1686162668;
        bh=PmCOE2J5E5WCbnaLCneJHFc3Oh48+OBpYXQhn+M3ZAU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=nEFX178QASY2GEUNgUSlRnunIyd04crhvmlDUzXlSn5rfVE6iRUuB8s2vZLqXSjwF
         iLiRrVXN8+A53q00993EMZZ8HaPMcXlkEg1nETwVzYrS8/XZYtcSsH8F4hy4odtZgl
         8VNFTjO0cnidFqzh24zfhc4hCbuRPCm17UR2qijY=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230607183108uscas1p29036b118f6c1a73df6d373d61360405c~mdANX78_k2687226872uscas1p2e;
        Wed,  7 Jun 2023 18:31:08 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 33.6C.42611.CECC0846; Wed, 
        7 Jun 2023 14:31:08 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230607183107uscas1p2c41fdce65faa305ba7fd2598ec801b65~mdANBsqyK0137001370uscas1p2y;
        Wed,  7 Jun 2023 18:31:07 +0000 (GMT)
X-AuditID: cbfec36f-249ff7000000a673-21-6480ccec5c3c
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 8F.57.44215.BECC0846; Wed, 
        7 Jun 2023 14:31:07 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 7 Jun 2023 11:31:06 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        7 Jun 2023 11:31:06 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>
CC:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Topic: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu
Thread-Index: AQHZhDHwBF2t8l6CHEO7jqFQqFgBOK99FUkAgAAEUYCAAyq+gIAABQqA
Date:   Wed, 7 Jun 2023 18:31:06 +0000
Message-ID: <20230607183059.GA2354376@bgt-140510-bm03>
In-Reply-To: <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <7B8924E83A75D7488D909233119FDCA9@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAKsWRmVeSWpSXmKPExsWy7djX87pvzjSkGNy8w2rRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sFo+vX2R1
        4PG4MHkCq8fiBlePnbPusnu0HHkL5O15yeQxeeFFZo+NH/+zezy5tpnJY/PrF8weU2fXe3ze
        JBfAHcVlk5Kak1mWWqRvl8CVsfbGIqaC5gbGiul/HrA3MK7P7WLk5JAQMJHY9nwicxcjF4eQ
        wEpGiV275jJBOK1MEofP/GCEqbr49QgLRGIto8TTqR+gnI+MEq87rkO1LGWU+L/5KytIC5uA
        osS+ru1sILaIgKXE0jXrwZYwC7xikfj6dDILSEJYwFli8vITQDs4gIpcJC4984Ood5PYsnMa
        M4jNIqAicanlEzuIzStgJjH7y31WkHJOgViJAxfBpjAKiEl8P7WGCcRmFhCXuPVkPhPE1YIS
        i2bvYYawxST+7XrIBmErStz//pIdol5P4sbUKWwQtp3E5cbprBC2tsSyha+ZIdYKSpyc+YQF
        oldS4uCKG2DPSwis5pQ4feUwC8g9EkDnnz4KVSMt8ffuMiaIcLLEqo9cEOEciflLtkCVWEss
        /LOeaQKjyiwkV89CctEsJBfNQnLRLCQXLWBkXcUoXlpcnJueWmyUl1quV5yYW1yal66XnJ+7
        iRGYCE//O5y/g/H6rY96hxiZOBgPMUpwMCuJ8GbZ16cI8aYkVlalFuXHF5XmpBYfYpTmYFES
        5zW0PZksJJCeWJKanZpakFoEk2Xi4JRqYCr9pTFbInZh+Fnncxv/mT3Qi/GeZ/35p/PH9FzP
        t11b+K7N0fmYaPh6UWXszivFGxjiFgeVflzk8Vvpnb5m2Dbvm6+yX0W8X9uecs3v8eJJYdVy
        81V1AjdqPy4oUb3x5Y/304/+ffJrG/acf/ee8Zf9FblXDA3Nuzk7S2tDbh/YfH3/Q9+Hh/8G
        q4roH2teeuPXobNcR1r/swmxP/T3U4hca9vKELghsE7ccG5FT10228H3F/by6KcU57Usy7H7
        tHyNqUrn7GfxaxPOKZnyqrbfya/9dik7dkKmTYGuZtM/xzNzFnP4O0eXiB35/U4vIs8+7Im0
        3gR1HW7laev7BO6/SP166Uf5ybcCDcEMB5RYijMSDbWYi4oTARPG477zAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+c45287M0WlafhYZWX9U6rqZnNA0sMupoCISzQtz5cnUqbFp
        phLOHBgLrVwqHWmpbSq60Ka5ieYtzaxozsJrZaTOlkWaWVChOQ/B/vu9PM/7PN8HL44KF7G1
        eFxSCi1Lkkg9uU5YnAIp8Jl+qYjZkZPrTV431wGyuLAPkDXDekAqrn7ESGXzN4Rsm5zCyOqy
        AS5pZp5j5NStKYTUaT+iZE+eCSPHBy2c/c5Un/omh7qvOEg1Me94lLLr69LUYkModZkFpR7O
        LvKoiYF6hKqf/oRShSVZ1JzB4+SKcKeAGFoad4mWbQ+MdrrwYKgcuZijAJeL/37gKUBtogrw
        cUj4Qst8F6YCTriQqAHwz3AXaheExCyAw5V8VtABWGEyYXaBS2yErSoj186uxF6o09eidhNK
        fMbg/KR62eRCBEN15TOgAviS6QDstx5n/YdgQ1PRcgFGbIb9yu88OwsIP1jyY4zDlrUiMDe/
        nWff5RNRsN2yHAmINfDXcz1iZ5RwgyMT9xD2BwTUtphRlldD2/gCh+WNcOyXjcf6RXCo8DaX
        5UD4OruYw7IXrCibRtk3rIK9dyYwdtcddlQNYTcBZBzqGIcoxiGKcYhiHKJKAacauKXK5Ymx
        l+W7kug0kVySKE9NihWdS040gKUbebHwJMIERkdmRZ0AwUEngDjq6SqID8qKEQpiJOkZtCxZ
        LEuV0vJOsA7HPN0EtvBbYiERK0mhE2j6Ii37ryI4f60C0e61PNYpRQ1VZo/wU4HG+x14P3i/
        +o048km078w+YcNo2Eos96nyMJoPFoNaXlvd45tDmK09mWFt/Cu63JyjUXd+NurV5cEnRgfT
        tGKy60tA+0oT2e+TEOGxRq/JtmpKNbxMytsvwgAib2fNG46dVG9Iy2obKpjHfMSNpztP5fy+
        6peSr9kU4N4rCh0oCpGS1QtInsukr/UaPyS74lCyS8fOEqvKn2lcbzT+nLo7sW63Leh0d5Wz
        d1TknKj7/FgeUvCy5NWRcaNgz9O3vYqEHumcN1q026yuCdVuuZGSUTyTEQ66q5Wgo86Q/in9
        bEiLZjHSa9PBM2pz8CN/T0x+QbJzGyqTS/4BAQG+SJIDAAA=
X-CMS-MailID: 20230607183107uscas1p2c41fdce65faa305ba7fd2598ec801b65
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c
References: <CGME20230511175641uscas1p2b1877f9179709b69e293acdd7e57104c@uscas1p2.samsung.com>
        <20230511175609.2091136-1-fan.ni@samsung.com>
        <647e1cf4e7e5e_7471a2948f@iweiny-mobl.notmuch>
        <20230605175112.GA2290821@bgt-140510-bm03>
        <DM6PR18MB2844A78EB692A69CE10031E2AF53A@DM6PR18MB2844.namprd18.prod.outlook.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Wed, Jun 07, 2023 at 06:13:01PM +0000, Shesha Bhushan Sreenivasamurthy w=
rote:
> Hi Fan,
>    I am implementing DCD FMAPI commands and planning to start pushing cha=
nges to the below branch. That requires the contributions you have made. Ca=
n your changes be pushed to the below branch ?
>=20
> https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-2023=
-05-25__;!!EwVzqGoTKBqv-0DWAJBm!Vt5uIqwW-L4c4gh02ulI4M762JNQ3_aE9k9lb6QlwE2=
xm6T23ic7ig7Y77i1VN7l_RX_ySIQhre_z7Q0JA$=20

Can you push changes to the branch directly? I think it is Jonathan's priva=
te
branch. However, I can fork the branch and rebase my patch series atop and
share with you the new repo if that helps you move forward your
work.
Let me know your thought.

Fan

>=20
>=20
> From: Fan Ni <fan.ni@samsung.com>
> Sent: Monday, June 5, 2023 10:51 AM
> To: Ira Weiny <ira.weiny@intel.com>
> Cc: qemu-devel@nongnu.org <qemu-devel@nongnu.org>; jonathan.cameron@huawe=
i.com <jonathan.cameron@huawei.com>; linux-cxl@vger.kernel.org <linux-cxl@v=
ger.kernel.org>; gregory.price@memverge.com <gregory.price@memverge.com>; h=
chkuo@avery-design.com.tw <hchkuo@avery-design.com.tw>; cbrowy@avery-design=
.com <cbrowy@avery-design.com>; dan.j.williams@intel.com <dan.j.williams@in=
tel.com>; Adam Manzanares <a.manzanares@samsung.com>; dave@stgolabs.net <da=
ve@stgolabs.net>; nmtadam.samsung@gmail.com <nmtadam.samsung@gmail.com>; ni=
fan@outlook.com <nifan@outlook.com>
> Subject: Re: [Qemu RFC 0/7] Early enabling of DCD emulation in Qemu=20
> =A0
> On Mon, Jun 05, 2023 at 10:35:48AM -0700, Ira Weiny wrote:
> > Fan Ni wrote:
> > > Since the early draft of DCD support in kernel is out
> > > (https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/202304=
17164126.GA1904906@bgt-140510-bm03/T/*t__;Iw!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcS=
iGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21LzAGNOk=
$ ),
> > > this patch series provide dcd emulation in qemu so people who are int=
erested
> > > can have an early try. It is noted that the patch series may need to =
be updated
> > > accordingly if the kernel side implementation changes.
> >=20
> > Fan,
> >=20
> > Do you have a git tree we can pull this from which is updated to a more
> > recent CXL branch from Jonathan?
> >=20
> > Thanks,
> > Ira
>=20
> Hi Ira,
>=20
> I have a git tree of the patch series based on Jonathan's branch
> cxl-2023-02-28: https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__gi=
thub.com_moking_qemu-2Ddev_tree_dcd-2Drfe&d=3DDwIFAg&c=3DnKjWec2b6R0mOyPaz7=
xtfQ&r=3DZta64bwn4nurTRpD4LY2OGr8KklkMRPn7Z_Qy0o4unU&m=3Dw6dicn5kXEG4Imk6Tp=
ICIjdA6KJ-xt84dtHui-Y0fv5H13bijtzEvjxECKE5MHYf&s=3D3yeO9RN5FY3gPfO2y19X057Y=
eqRTTQTQNfNA-Gfir_Q&e=3D .
>=20
> That may be not new enough to include some of the recent patches, but I c=
an
> rebase it to a newer branch if you can tell me which branch you want to u=
se.
>=20
> Thanks,
> Fan
>=20
> >=20
> > >=20
> > > To support DCD emulation, the patch series add DCD related mailbox co=
mmand
> > > support (CXL Spec 3.0: 8.2.9.8.9), and extend the cxl type3 memory de=
vice
> > > with dynamic capacity extent and region representative.
> > > To support read/write to the dynamic capacity of the device, a host b=
ackend
> > > is provided and necessary check mechnism is added to ensure the dynam=
ic
> > > capacity accessed is backed with active dc extents.
> > > Currently FM related mailbox commands (cxl spec 3.0: 7.6.7.6) is not =
supported
> > > , but we add two qmp interfaces for adding/releasing dynamic capacity=
 extents.
> > > Also, the support for multiple hosts sharing the same DCD case is mis=
sing.
> > >=20
> > > Things we can try with the patch series together with kernel dcd code=
:
> > > 1. Create DC regions to cover the address range of the dynamic capaci=
ty
> > > regions.
> > > 2. Add/release dynamic capacity extents to the device and notify the
> > > kernel.
> > > 3. Test kernel side code to accept added dc extents and create dax de=
vices,
> > > and release dc extents and notify the device
> > > 4. Online the memory range backed with dc extents and let application=
 use
> > > them.
> > >=20
> > > The patch series is based on Jonathan's local qemu branch:
> > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-=
2023-02-28__;!!EwVzqGoTKBqv-0DWAJBm!RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeU=
FdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr21OO3UHEM$=20
> > >=20
> > > Simple tests peformed with the patch series:
> > > 1 Install cxl modules:
> > >=20
> > > modprobe -a cxl_acpi cxl_core cxl_pci cxl_port cxl_mem
> > >=20
> > > 2 Create dc regions:
> > >=20
> > > region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > > echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > > echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
> > > echo 0x10000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > > echo 0x10000000 > /sys/bus/cxl/devices/$region/size
> > > echo=A0 "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > > echo 1 > /sys/bus/cxl/devices/$region/commit
> > > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > >=20
> > > /home/fan/cxl/tools-and-scripts# cxl list
> > > [
> > >=A0=A0 {
> > >=A0=A0=A0=A0 "memdevs":[
> > >=A0=A0=A0=A0=A0=A0 {
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "memdev":"mem0",
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "pmem_size":536870912,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "ram_size":0,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "serial":0,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "host":"0000:0d:00.0"
> > >=A0=A0=A0=A0=A0=A0 }
> > >=A0=A0=A0=A0 ]
> > >=A0=A0 },
> > >=A0=A0 {
> > >=A0=A0=A0=A0 "regions":[
> > >=A0=A0=A0=A0=A0=A0 {
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "region":"region0",
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "resource":45365592064,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "size":268435456,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_ways":1,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "interleave_granularity":256,
> > >=A0=A0=A0=A0=A0=A0=A0=A0 "decode_state":"commit"
> > >=A0=A0=A0=A0=A0=A0 }
> > >=A0=A0=A0=A0 ]
> > >=A0=A0 }
> > > ]
> > >=20
> > > 3 Add two dc extents (128MB each) through qmp interface
> > >=20
> > > { "execute": "qmp_capabilities" }
> > >=20
> > > { "execute": "cxl-add-dynamic-capacity-event",
> > >=A0=A0=A0=A0=A0 "arguments": {
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "path": "/machine/periphera=
l/cxl-pmem0",
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "region-id" : 0,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "num-extent": 2,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "dpa":0,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 "extent-len": 128
> > >=A0=A0=A0=A0=A0 }
> > > }
> > >=20
> > > /home/fan/cxl/tools-and-scripts# lsmem
> > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE=A0=A0 BLOCK
> > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=A0=
=A0=A0=A0 yes=A0=A0=A0 0-15
> > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=A0=
=A0=A0=A0 yes=A0=A0 32-79
> > > 0x0000000a90000000-0x0000000a9fffffff=A0 256M offline=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 338-339
> > >=20
> > > Memory block size:=A0=A0=A0=A0=A0=A0 128M
> > > Total online memory:=A0=A0=A0=A0=A0=A0 8G
> > > Total offline memory:=A0=A0=A0 256M
> > >=20
> > >=20
> > > 4.Online the momory with 'daxctl online-memory dax0.0' to online the =
memory
> > >=20
> > > /home/fan/cxl/ndctl# ./build/daxctl/daxctl online-memory dax0.0
> > > [=A0 230.730553] Fallback order for Node 0: 0 1
> > > [=A0 230.730825] Fallback order for Node 1: 1 0
> > > [=A0 230.730953] Built 2 zonelists, mobility grouping on.=A0 Total pa=
ges: 2042541
> > > [=A0 230.731110] Policy zone: Normal
> > > onlined memory for 1 device
> > >=20
> > > root@bgt-140510-bm03:/home/fan/cxl/ndctl# lsmem
> > > RANGE=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 SIZE=A0=A0 STATE REMOVABLE BLOCK
> > > 0x0000000000000000-0x000000007fffffff=A0=A0=A0 2G=A0 online=A0=A0=A0=
=A0=A0=A0 yes=A0 0-15
> > > 0x0000000100000000-0x000000027fffffff=A0=A0=A0 6G=A0 online=A0=A0=A0=
=A0=A0=A0 yes 32-79
> > > 0x0000000a90000000-0x0000000a97ffffff=A0 128M=A0 online=A0=A0=A0=A0=
=A0=A0 yes=A0=A0 338
> > > 0x0000000a98000000-0x0000000a9fffffff=A0 128M offline=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 339
> > >=20
> > > Memory block size:=A0=A0=A0=A0=A0=A0 128M
> > > Total online memory:=A0=A0=A0=A0 8.1G
> > > Total offline memory:=A0=A0=A0 128M
> > >=20
> > > 5 using dc extents as regular memory
> > >=20
> > > /home/fan/cxl/ndctl# numactl --membind=3D1 ls
> > > CONTRIBUTING.md=A0 README.md=A0 clean_config.sh=A0 cscope.out=A0=A0 g=
it-version-gen
> > > ndctl=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 scripts=A0=A0 test.h=A0=
=A0=A0=A0=A0 version.h.in COPYING=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 acpi.h
> > > config.h.meson=A0=A0 cxl=A0=A0=A0=A0=A0=A0=A0=A0=A0 make-git-snapshot=
.sh=A0=A0 ndctl.spec.in=A0 sles=A0=A0=A0=A0 tools
> > > Documentation=A0=A0=A0=A0=A0=A0=A0 build=A0=A0=A0=A0=A0=A0 contrib=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 daxctl=A0=A0=A0=A0=A0=A0=A0 meson.build=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 rhel
> > > tags=A0=A0=A0=A0=A0=A0=A0 topology.png LICENSES=A0=A0=A0 ccan=A0=A0=
=A0=A0=A0=A0=A0 cscope.files
> > > git-version=A0 meson_options.txt=A0=A0=A0=A0=A0 rpmbuild.sh=A0=A0=A0 =
test=A0=A0=A0=A0 util
> > >=20
> > >=20
> > > QEMU command line cxl configuration:
> > >=20
> > > RP1=3D"-object memory-backend-file,id=3Dcxl-mem1,share=3Don,mem-path=
=3D/tmp/cxltest.raw,size=3D512M \
> > > -object memory-backend-file,id=3Dcxl-mem2,share=3Don,mem-path=3D/tmp/=
cxltest2.raw,size=3D512M \
> > > -object memory-backend-file,id=3Dcxl-lsa1,share=3Don,mem-path=3D/tmp/=
lsa.raw,size=3D512M \
> > > -device pxb-cxl,bus_nr=3D12,bus=3Dpcie.0,id=3Dcxl.1 \
> > > -device cxl-rp,port=3D0,bus=3Dcxl.1,id=3Droot_port13,chassis=3D0,slot=
=3D2 \
> > > -device cxl-type3,bus=3Droot_port13,memdev=3Dcxl-mem1,lsa=3Dcxl-lsa1,=
dc-memdev=3Dcxl-mem2,id=3Dcxl-pmem0,num-dc-regions=3D1\
> > > -M cxl-fmw.0.targets.0=3Dcxl.1,cxl-fmw.0.size=3D4G,cxl-fmw.0.interlea=
ve-granularity=3D8k"
> > >=20
> > >=20
> > > Kernel DCD support used to test the changes
> > >=20
> > > The code is tested with the posted kernel dcd support:
> > > https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kern=
el/git/cxl/cxl.git/log/?h=3Dfor-6.5*dcd-preview__;Lw!!EwVzqGoTKBqv-0DWAJBm!=
RHzXPIcSiGsqUciUIH6HnlG_W--4L5CHfvcOIeUFdwKFhAujXuFDxjymmpCdOu7SLr61rww7lr2=
1q5Iza3M$=20
> > >=20
> > > commit: f425bc34c600e2a3721d6560202962ec41622815
> > >=20
> > > To make the test work, we have made the following changes to the abov=
e kernel commit:
> > >=20
> > > diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> > > index 5f04bbc18af5..5f421d3c5cef 100644
> > > --- a/drivers/cxl/core/mbox.c
> > > +++ b/drivers/cxl/core/mbox.c
> > > @@ -68,6 +68,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_=
MEM_COMMAND_ID_MAX] =3D {
> > >=A0=A0=A0=A0=A0 CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
> > >=A0=A0=A0=A0=A0 CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
> > >=A0=A0=A0=A0=A0 CXL_CMD(GET_DC_EXTENT_LIST, 0x8, CXL_VARIABLE_PAYLOAD,=
 0),
> > > +=A0=A0 CXL_CMD(GET_DC_CONFIG, 0x2, CXL_VARIABLE_PAYLOAD, 0),
> > >=A0 };
> > >=A0=20
> > >=A0 /*
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index 291c716abd49..ae10e3cf43a1 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -194,7 +194,7 @@ static int cxl_region_manage_dc(struct cxl_region=
 *cxlr)
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 cxlds->dc_list_gen_num =3D ext=
ent_gen_num;
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_dbg(cxlds->dev, "No of pre=
allocated extents :%d\n", rc);
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 enable_irq(cxlds->cxl_irq[CXL_EVENT_T=
YPE_DCD]);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*enable_irq(cxlds->cxl_irq[CXL_EVENT=
_TYPE_DCD]);*/
> > >=A0=A0=A0=A0=A0 }
> > >=A0=A0=A0=A0=A0 return 0;
> > >=A0 err:
> > > @@ -2810,7 +2810,8 @@ int cxl_add_dc_extent(struct cxl_dev_state *cxl=
ds, struct resource *alloc_dpa_re
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 dev_dax->align, memremap_compat_align()))) {
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 rc =3D alloc_dev_dax_range(dev=
_dax, hpa,
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 resource_size(alloc_dpa_res));
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (rc)
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
> > >=A0=A0=A0=A0=A0 }
> > >=A0=20
> > >=A0=A0=A0=A0=A0 rc =3D xa_insert(&cxlr_dc->dax_dev_list, hpa, dev_dax,=
 GFP_KERNEL);
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 9e45b1056022..653bec203838 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -659,7 +659,7 @@ static int cxl_event_irqsetup(struct cxl_dev_stat=
e *cxlds)
> > >=A0=20
> > >=A0=A0=A0=A0=A0 /* Driver enables DCD interrupt after creating the dc =
cxl_region */
> > >=A0=A0=A0=A0=A0 rc =3D cxl_event_req_irq(cxlds, policy.dyncap_settings=
, CXL_EVENT_TYPE_DCD,
> > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT | IRQF_NO_A=
UTOEN);
> > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 IRQF_SHARED | IRQF_ONESHOT);
> > >=A0=A0=A0=A0=A0 if (rc) {
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 dev_err(cxlds->dev, "Failed to=
 get interrupt for event dc log\n");
> > >=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 return rc;
> > > diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_me=
m.h
> > > index 6ca85861750c..910a48259239 100644
> > > --- a/include/uapi/linux/cxl_mem.h
> > > +++ b/include/uapi/linux/cxl_mem.h
> > > @@ -47,6 +47,7 @@
> > >=A0=A0=A0=A0=A0 ___C(SCAN_MEDIA, "Scan Media"),=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 \
> > >=A0=A0=A0=A0=A0 ___C(GET_SCAN_MEDIA, "Get Scan Media Results"),=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 \
> > >=A0=A0=A0=A0=A0 ___C(GET_DC_EXTENT_LIST, "Get dynamic capacity extents=
"),=A0=A0=A0=A0=A0=A0=A0=A0 \
> > > +=A0=A0 ___C(GET_DC_CONFIG, "Get dynamic capacity configuration"),=A0=
=A0=A0=A0=A0=A0=A0=A0 \
> > >=A0=A0=A0=A0=A0 ___C(MAX, "invalid / last command")
> > >=A0=20
> > >=A0 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
> > >=20
> > >=20
> > >=20
> > > Fan Ni (7):
> > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> > >=A0=A0=A0=A0 payload of identify memory device command
> > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add dynamic capacity region represent=
ative
> > >=A0=A0=A0=A0 and mailbox command support
> > >=A0=A0 hw/mem/cxl_type3: Add a parameter to pass number of DC regions =
the
> > >=A0=A0=A0=A0 device supports in qemu command line
> > >=A0=A0 hw/mem/cxl_type3: Add DC extent representative to cxl type3 dev=
ice
> > >=A0=A0 hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/r=
elease
> > >=A0=A0=A0=A0 dynamic capacity response
> > >=A0=A0 Add qmp interfaces to add/release dynamic capacity extents
> > >=A0=A0 hw/mem/cxl_type3: add read/write support to dynamic capacity
> > >=20
> > >=A0 hw/cxl/cxl-mailbox-utils.c=A0 | 389 +++++++++++++++++++++++++++-
> > >=A0 hw/mem/cxl_type3.c=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 492 ++++++++++++++=
+++++++++++++++++-----
> > >=A0 include/hw/cxl/cxl_device.h |=A0 50 +++-
> > >=A0 include/hw/cxl/cxl_events.h |=A0 16 ++
> > >=A0 qapi/cxl.json=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=A0 44 ++=
++
> > >=A0 5 files changed, 924 insertions(+), 67 deletions(-)
> > >=20
> > > --=20
> > > 2.25.1
> >=20
> > =
