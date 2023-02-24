Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9015BC64ED6
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 00:29:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229448AbjBXA3y (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 23 Feb 2023 19:29:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjBXA3y (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 23 Feb 2023 19:29:54 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 275D24AFCD
        for <linux-cxl@vger.kernel.org>; Thu, 23 Feb 2023 16:29:52 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230224002949usoutp01af754898b75e2b5b3ec59c80ee708f61~GmzsO8Ylw3151831518usoutp01W;
        Fri, 24 Feb 2023 00:29:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230224002949usoutp01af754898b75e2b5b3ec59c80ee708f61~GmzsO8Ylw3151831518usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677198589;
        bh=psARQxrFQ9u3ZCSnmIKS2dxGF9XHTMrU0qHOF3hJQzA=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=QuPeTqlSJ4wlL2YtZyFzhY3iIiuH3fofNF/h1ZwA773FK/YU7Mxq+dezgLOPcmma+
         4jOXdlxdWJx0G30SKfVaxRqC2VnlxBY+sYuRN8KBiH8JtaywkNWdxs6UbqBSuRWDkq
         yk8TBN80tstyBlj5d+IYLeVV2+nfsCNcN36h040c=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230224002949uscas1p2c9b3d0495cd7428781ec47a69aeb013f~GmzsGJD7b0553205532uscas1p2l;
        Fri, 24 Feb 2023 00:29:49 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 6B.1A.06976.CF408F36; Thu,
        23 Feb 2023 19:29:48 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230224002948uscas1p220ab1ec9fbe16138e0fd314b7412f833~GmzrwEwed0553105531uscas1p2m;
        Fri, 24 Feb 2023 00:29:48 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-b7-63f804fcf069
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 4A.39.17110.CF408F36; Thu,
        23 Feb 2023 19:29:48 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 23 Feb 2023 16:29:47 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        23 Feb 2023 16:29:47 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Jonathan Cameron via <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
        Mike Maslenkin <mike.maslenkin@gmail.com>
Subject: Re: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
 and Persistent)
Thread-Topic: [PATCH 2/2] hw/cxl: Multi-Region CXL Type-3 Devices (Volatile
        and Persistent)
Thread-Index: AQHZR+cZWt0anxAoHU61497Cp1Ks6w==
Date:   Fri, 24 Feb 2023 00:29:47 +0000
Message-ID: <20230224002940.GA1282789@bgt-140510-bm03>
In-Reply-To: <20230220114646.000000ff@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6EC59CC48AB86F42AA9D173222C05044@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrEKsWRmVeSWpSXmKPExsWy7djXc7p/WH4kG8xaY2XRPHkxo8WLP8+Z
        LBqaHrFY7H/6nMVi1cJrbBbnZ51isTi88QyTxe+1j5ks/v96xWqxZoWwxfHeHSwO3B47Z91l
        92g58pbVY/Gel0wem1Z1snncubaHzWPjx//sHk+ubWbyeL/vKpvH501yAZxRXDYpqTmZZalF
        +nYJXBnTjs5jK2hXr3gy4x5jA+NF2S5GTg4JAROJrknX2LoYuTiEBFYySrze1MIO4bQySdxc
        NJ0VpmrTrblQVWsZJV7N/ccM4XxilNjQNAcqs4xRYlPLNbAWNgFFiX1d29lAbBEBI4kryw6y
        g9jMAmeYJTZP8AKxhQViJHb+3c0IURMrsXdvO1A9B5CtJ3GluwYkzCKgKrF32UawkbwCZhJP
        5lwAszkFDCW+7WgDG8koICbx/dQaJojx4hK3nsxngrhaUGLR7D3MELaYxL9dD9kgbEWJ+99f
        Qp2jJ3Fj6hQ2CNtO4ufuMywQtrbEsoWvmSH2CkqcnPmEBaJXUuLgihssIP9KCEznlNhy9zU0
        iFwkNkycC7VMWuLv3WVMIL9ICCRLrPrIBRHOkZi/ZAvUHGuJhX/WM01gVJmF5OxZSE6aheSk
        WUhOmoXkpAWMrKsYxUuLi3PTU4sN81LL9YoTc4tL89L1kvNzNzECk93pf4dzdzDuuPVR7xAj
        EwfjIUYJDmYlEd6pTN+ThXhTEiurUovy44tKc1KLDzFKc7AoifMa2p5MFhJITyxJzU5NLUgt
        gskycXBKNTDV3Di35fP6K/f4umQ6N9R8iAvjcFsW1Xm24cTeSKXtD7hWdkZ5Lre+nvRYcmmv
        3MGGlq9xX06/UdV9ZpJdvyWa5V64iEaNmG9zqv2dbzyJDw/9UA3be/fy28SpkWZVQidtZuRn
        6RRlvsgX/LZke0Su5TehI88Ejv71f7xJ72O/7l2BpQ+YUl91POyXZQzhrU0Oir356MWS9ZKr
        0y7/ljF6NdvQQlz7aeiK9ojEJafW/tw01fnHv9RdJ20V5z3gCckTfvlP16fV8Oi9Xr/mC2ZT
        9xuFvvwQwvUpdvrC5gesE5ydFn7ecYbfT37KpflF51ZPde3Tan3zKkL982VXqcj47h+95/n/
        CYvNN0yfxS6sxFKckWioxVxUnAgA3bcpguUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrIIsWRmVeSWpSXmKPExsWS2cA0SfcPy49kgzVTlS2aJy9mtHjx5zmT
        RUPTIxaL/U+fs1isWniNzeL8rFMsFoc3nmGy+L32MZPF/1+vWC3WrBC2ON67g8WB22PnrLvs
        Hi1H3rJ6LN7zkslj06pONo871/aweWz8+J/d48m1zUwe7/ddZfP4vEkugDOKyyYlNSezLLVI
        3y6BK2Pa0XlsBe3qFU9m3GNsYLwo28XIySEhYCKx6dZcti5GLg4hgdWMEsebJrFCOJ8YJTqm
        bWeBcJYxSqxb8ZgNpIVNQFFiX9d2MFtEwEjiyrKD7CBFzAJnmCWa151nAkkIC8RI/Oh+DGRz
        ABXFSrw+pgZh6klc6a4BqWARUJXYu2wjK4jNK2Am8WTOBajFTxklWp5OYAdJcAoYSnzb0QZm
        MwqISXw/tQZsPLOAuMStJ/OZIF4QkFiy5zwzhC0q8fLxP1YIW1Hi/veX7BD1ehI3pk5hg7Dt
        JH7uPsMCYWtLLFv4mhniCEGJkzOfsED0SkocXHGDZQKjxCwk62YhGTULyahZSEbNQjJqASPr
        Kkbx0uLi3PSKYqO81HK94sTc4tK8dL3k/NxNjMBUcfrf4egdjLdvfdQ7xMjEwXiIUYKDWUmE
        dyrT92Qh3pTEyqrUovz4otKc1OJDjNIcLErivC+jJsYLCaQnlqRmp6YWpBbBZJk4OKUamAqv
        PpX+/847LfiKOaOn79KQia92MC5LkP7YY7R21aLbmw9+Om9id7I8zUN9zhmJeuZbi+ImHbyt
        Ir1AZMuz0w1WNRnuMmzX/rR4iZrvlv/4neEY89ZZUrf3X/nz+efMtZ1l11a1TcthEI/XcSz1
        WVpXLrycxcd02c/Lb0y5nzk25R5z23dysuYHkY0Tc16yZa+tnRvIqLRxisDyoqXRxi7lz+xk
        84I2+W5h/ntm7leGM0srJ91iuJHGMoX1dYrpniWG8/pCnjLtndhg6Biq0G9hEP+34J1Irby7
        5pqdPa/83L+UVXzb/Icl+Jb87CUpnktK57k+fDGbxWfTnjv9BTeCbOYUlmufZwuwMtrMKq/E
        UpyRaKjFXFScCACK5A4MhAMAAA==
X-CMS-MailID: 20230224002948uscas1p220ab1ec9fbe16138e0fd314b7412f833
CMS-TYPE: 301P
X-CMS-RootMailID: 20230224002948uscas1p220ab1ec9fbe16138e0fd314b7412f833
References: <20230131163847.23025-1-Jonathan.Cameron@huawei.com>
        <20230131163847.23025-3-Jonathan.Cameron@huawei.com>
        <20230217161617.000064d1@huawei.com> <Y+9gSWadbRfdqJGS@memverge.com>
        <20230220114646.000000ff@Huawei.com>
        <CGME20230224002948uscas1p220ab1ec9fbe16138e0fd314b7412f833@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 20, 2023 at 11:46:46AM +0000, Jonathan Cameron wrote:

> On Fri, 17 Feb 2023 06:08:57 -0500
> Gregory Price <gregory.price@memverge.com> wrote:
>=20
> > On Fri, Feb 17, 2023 at 04:16:17PM +0000, Jonathan Cameron via wrote:
> > > On Tue, 31 Jan 2023 16:38:47 +0000
> > > Jonathan Cameron via <qemu-devel@nongnu.org> wrote:
> > >  =20
> > > > From: Gregory Price <gourry.memverge@gmail.com>
> > > >=20
> > > > This commit enables each CXL Type-3 device to contain one volatile
> > > > memory region and one persistent region.
> > > >=20
> > > > Two new properties have been added to cxl-type3 device initializati=
on:
> > > >     [volatile-memdev] and [persistent-memdev]
> > > >=20
> > > > The existing [memdev] property has been deprecated and will default=
 the
> > > > memory region to a persistent memory region (although a user may as=
sign
> > > > the region to a ram or file backed region). It cannot be used in
> > > > combination with the new [persistent-memdev] property.
> > > >=20
> > > > Partitioning volatile memory from persistent memory is not yet supp=
orted.
> > > >=20
> > > > Volatile memory is mapped at DPA(0x0), while Persistent memory is m=
apped
> > > > at DPA(vmem->size), per CXL Spec 8.2.9.8.2.0 - Get Partition Info.
> > > >=20
> > > > Signed-off-by: Gregory Price <gregory.price@memverge.com>
> > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > > >  =20
> > > Hi Gregory,
> > >=20
> > > I've added support for multiple HDM decoders and hence can now
> > > test both volatile and non volatile on same device.
> > > It very nearly all works. With one exception which is I couldn't
> > > poke the first byte of the non volatile region.
> > >=20
> > > I think we have an off by one in a single check.
> > >=20
> > > Interestingly it makes no difference when creating an FS on top
> > > (which was my standard test) so I only noticed when poking memory
> > > addresses directly to sanity check the HDM decoder setup.
> > >=20
> > > I'll roll a v2 if no one shouts out that I'm wrong.
> > >=20
> > > Note that adding multiple HDM decoders massively increases
> > > the number of test cases over what we had before to poke all the
> > > corners so I may well be missing stuff.  Hopefully can send an RFC
> > > of that support out next week.
> > >=20
> > > Jonathan
> > >  =20
> >=20
> > Very cool! Thanks for pushing this over the finishing line.
> >=20
> > All my testing so far has been really smooth since getting the TCG issu=
e
> > worked out.
> >=20
> > > > -MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_=
t *data,
> > > > -                           unsigned size, MemTxAttrs attrs) =20
> > [...]
> > > > +    if (vmr) {
> > > > +        if (*dpa_offset <=3D int128_get64(vmr->size)) { =20
> > >=20
> > > Off by one I think.  <=20
> > >  =20
> >=20
> > Yes that makes sense, should be <.  Derp derp.
> >=20
> > Though I think this may alludes to more off-by-one issues?  This says
> >=20
> > if (dpa_offset < vmr->size)
> >=20
> > but dpa_offset should be (hpa - memory_region_base),
> >=20
> > The HPA is used by memory access routing for the whole system to determ=
ine
> > what device it should access.
> >=20
> > If that corner case is being hit, doesn't it imply the higher level cod=
e
> > is also susceptible to this, and is routing accesses to the wrong devic=
e?
>=20
> I don't think so though I may be missing something.=20
>=20
> Say vmr->size =3D 8
>=20
> hpa  dpa_offset
> 0       0
> 1       1
> 2       2
> 3       3
> 4       4
> 5       5
> 6       6
> 7       7
> 8       0
>=20
> etc

If vmr->size=3D8, we should expect that at most 8 offsets (e.g., hpa [0,7])=
 will
access vmem and hpa=3D8 will access offset=3D0 at pmem, right?
If with hpa=3D8, dpa_offset round to 0, does it mean we never get a
dpa_offset larger than 7? If so, when pmem will be accessed?

>=20
> Also the writes are turning up where I expect them to.
>=20
> Also just noticed that the code is setting Memory_base in the CXL dvsec.
> Given we are emulating a device as if it has been freshly powered up
> those should not be set - it's the OS or firmware's job to set them up.
> Harmless though, so can be a cleanup to follow the main series.
>=20
> We don't currently handle dvsec range based routing anyway and
> I'm not sure we ever will as it is a pain to test without some firmware
> or OS code to program them for us.
>=20
> Note that if you update your kernel to cxl/next it will currently fail
> as the Range register emulation is (I think) rather over enthusiastic
> and currently decides to emulate the HDM decoders for the QEMU emulated
> type 3 devices.
>=20
> https://lore.kernel.org/linux-cxl/167640366272.935665.1056268838301725481=
.stgit@dwillia2-xfh.jf.intel.com/T/#m6c025d5c9b27d8360a64079593f6c5adaa4087=
72
>=20
> Jonathan
>=20
>=20
> >=20
> > ~Gregory
>=20
> =
