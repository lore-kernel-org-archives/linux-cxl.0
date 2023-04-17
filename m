Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CFECC77B7A
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Apr 2023 16:41:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbjDQQln (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Apr 2023 12:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230077AbjDQQlh (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Apr 2023 12:41:37 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E153086BE
        for <linux-cxl@vger.kernel.org>; Mon, 17 Apr 2023 09:41:35 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230417164134usoutp02a6e41d805b6b4e852b1ee1e50c876e60~Wxm-mEt-f0077800778usoutp02B;
        Mon, 17 Apr 2023 16:41:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230417164134usoutp02a6e41d805b6b4e852b1ee1e50c876e60~Wxm-mEt-f0077800778usoutp02B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1681749694;
        bh=bYUsiynD2KENR+cZ2Cp98A//v9MpBDVFm5iUTeRXItM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=m7v6qswL6xasqf9m7LSS+CLrQFTFECCdhjUGRJkWn/KZUkK74y38l0HPuga3SSvyX
         RprB87qE/yq9rSJXzmAHYlzl9WkAVOSOe/txyui1FYFXvMqbCdrdWipeyLqZ8d70hS
         eeTzNa5CfM3X1ZgGJq2OGoCbePK1gpTpRpweu+Oo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230417164134uscas1p184517f597ff390c5930241ea22cf6c87~Wxm-ZXxwv0955309553uscas1p1i;
        Mon, 17 Apr 2023 16:41:34 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 51.34.09670.EB67D346; Mon,
        17 Apr 2023 12:41:34 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230417164134uscas1p1a279ed4d3e5ebe9fa95aef849f2c560b~Wxm-IkrQk2877428774uscas1p1V;
        Mon, 17 Apr 2023 16:41:34 +0000 (GMT)
X-AuditID: cbfec36f-6f9ff700000025c6-f3-643d76be0d59
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 95.FF.09579.DB67D346; Mon,
        17 Apr 2023 12:41:34 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 17 Apr 2023 09:41:33 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        17 Apr 2023 09:41:33 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Gregory Price <gregory.price@memverge.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "navneet.singh@intel.com" <navneet.singh@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "Adam Manzanares" <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>
Subject: Re: "release early" preview of DCD enabling
Thread-Topic: "release early" preview of DCD enabling
Thread-Index: AQHZcUt3kFPBdpMVEEuuNcLbtI03sA==
Date:   Mon, 17 Apr 2023 16:41:33 +0000
Message-ID: <20230417164126.GA1904906@bgt-140510-bm03>
In-Reply-To: <20230414130414.00007c88@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <014EBFBDD355DD418490042A40F4AA71@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djXc7r7ymxTDE6dk7WYPvUCo8Xqm2sY
        LRqaHrFY7H/6nMVi1cJrbBbnZ51isTi+ZgKrxfOJz5ksli55xOzA6bFz1l12j5Yjb1k9Fu95
        yeSx8eN/do/Nr18we0ydXe/xeZNcAHsUl01Kak5mWWqRvl0CV0Zbyx+2gtWSFdOPrWFtYHwk
        3MXIySEhYCJxcPsk9i5GLg4hgZWMEl83r2WGcFqZJP41f2WGqfp48SYbiC0ksJZR4tXdCIii
        T4wSf6dfZoNwljFK3Ht+jxWkik1AUWJf13awDhEBI4kryw6C7WAW2M4sce/hbBaQhDDQ2JMb
        z7NDFJlKbFvdywhh60ns7O0Ei7MIqEqc2PabCcTmFTCT6Gu5BGZzChhK7GzvB6tnFBCT+H5q
        DVicWUBc4taT+UwQZwtKLJq9B+oFMYl/ux6yQdiKEve/v2SHqNeRWLD7ExuEbSfRvrgTao62
        xLKFr5kh9gpKnJz5hAWiV1Li4IobLCDPSAj84JD4/+ceI0TCReL22b3sELa0xN+7y4AGcQDZ
        yRKrPnJBhHMk5i/ZAjXHWmLhn/VMExhVZiE5exaSk2YhOWkWkpNmITlpASPrKkbx0uLi3PTU
        YqO81HK94sTc4tK8dL3k/NxNjMA0dvrf4fwdjNdvfdQ7xMjEwXiIUYKDWUmE94yrVYoQb0pi
        ZVVqUX58UWlOavEhRmkOFiVxXkPbk8lCAumJJanZqakFqUUwWSYOTqkGppQlPUHlCac+Bt/S
        fXL78J/WW6Fij5K+WrNY3pM6qvL5FEswu6SipIMgx6/wN19fRYtMNtnz0jtku8HJl3Ob1rwX
        eFXI/XnljbXaO5PznS/+OeJo91jsSdYT7eCqzLC8WMMN80PjZMMTIpfefd863WZR7yYn43S/
        Y4x9vaKL2eTWxb/YfmXqZJWbRr5Lajmyrm3+13KhKPJspnngjg/6j2Rkvvec320qcGpniWJV
        ofOZlVa317wtZTFPXWT2S9Fz0rHTJTf+86fbqJaG8e+a4fTGQvGaSOAM/TOVlzd4KNwxrzeL
        LMud+1RVaP+O+7clIzfPX5gwZ4+hb+Sigzt3aEQwFxUdvPboaPVmmbQsRyWW4oxEQy3mouJE
        ANa17JDSAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrHIsWRmVeSWpSXmKPExsWS2cA0UXdfmW2KwbVl3BbTp15gtFh9cw2j
        RUPTIxaL/U+fs1isWniNzeL8rFMsFsfXTGC1eD7xOZPF0iWPmB04PXbOusvu0XLkLavH4j0v
        mTw2fvzP7rH59Qtmj6mz6z0+b5ILYI/isklJzcksSy3St0vgymhr+cNWsFqyYvqxNawNjI+E
        uxg5OSQETCQ+XrzJ1sXIxSEksJpR4tLZk+wgCSGBT4wSu34pQCSWMUocmbKLBSTBJqAosa9r
        OxuILSJgJHFl2UF2kCJmge3MEm2bJzGDJISBxp7ceJ4doshUYtvqXkYIW09iZ28nWJxFQFXi
        xLbfTCA2r4CZRF/LJSaIbdMYJWZc+soKkuAUMJTY2d4P1swoICbx/dQasAZmAXGJW0/mM0H8
        ICCxZM95ZghbVOLl43+sELaixP3vL9kh6nUkFuz+xAZh20m0L+6EmqMtsWzha2aIIwQlTs58
        wgLRKylxcMUNlgmMErOQrJuFZNQsJKNmIRk1C8moBYysqxjFS4uLc9Mrio3yUsv1ihNzi0vz
        0vWS83M3MQKTwOl/h6N3MN6+9VHvECMTB+MhRgkOZiUR3jOuVilCvCmJlVWpRfnxRaU5qcWH
        GKU5WJTEeV9GTYwXEkhPLEnNTk0tSC2CyTJxcEo1MM19Uvg+el33uwNn1yhu/d7i2XI7+snx
        B4vqT7/uzlxtuJD32vOPOnI9D1c467bnGfT6Z056WDqd08SnMDR1fepMZpuiM/+WKHC97z0s
        zbw8yi3Y5V7upsONtZxyltoHy9YvuSXI9PFX79na7NULtwvs3vigQf3EbpHCnUWm8z5JXVww
        tX3ZLLPcO6k/U3brrrssnG68rV9R5iEv485frqWpm4saXnyrn+UY21m/6t3KPnXekpjFN9cf
        2RJQYqZ1lO+5XoPQwpqYHoeSnmXuJmdP/5j5jXPJzu2TOHn2sxytWLYprf3Aiaeb5/9iM5TM
        Odg1cWlNNa/XgvRfv+z9XtvtedPTNUVTQnT2qfZfM5WVWIozEg21mIuKEwFHHQ7jcQMAAA==
X-CMS-MailID: 20230417164134uscas1p1a279ed4d3e5ebe9fa95aef849f2c560b
CMS-TYPE: 301P
X-CMS-RootMailID: 20230417164134uscas1p1a279ed4d3e5ebe9fa95aef849f2c560b
References: <64326437c1496_934b2949f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
        <ZDWVkJKVThJzhMzM@memverge.com> <20230414130414.00007c88@Huawei.com>
        <CGME20230417164134uscas1p1a279ed4d3e5ebe9fa95aef849f2c560b@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Apr 14, 2023 at 01:04:14PM +0100, Jonathan Cameron wrote:

> On Tue, 11 Apr 2023 13:14:56 -0400
> Gregory Price <gregory.price@memverge.com> wrote:
>=20
> > On Sun, Apr 09, 2023 at 12:07:36AM -0700, Dan Williams wrote:
> > > Here is an early draft of the DCD work that Navneet has spearheaded.
> > > Given the interest level I thought it best to do the remaining
> > > development and refinement of the functionality in the open.  For now
> > > this is just a git branch that will become a patchkit on the mailing
> > > list in a few weeks.
> > >=20
> > > Questions are welcome, but I do not recommend a formal review until t=
he
> > > patches hit the mailing list.
> > >=20
> > > This has had some checkout on an internal functional model, I expect
> > > QEMU and/or cxl_test grows an emulation of DCD before this patchkit i=
s
> > > committed for mainline.
> > >=20
> > > https://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl.git/log/?h=3D=
for-6.5/dcd-preview =20
> >=20
> > Awesome!
> >=20
> > for the QEMU folks, has anyone be actively working on a DCD device? I
> > was going to start looking at it, but didn't want to duplicate work.
>=20
> Not that I know of.  Was thinking I might hack some of it together, but
> not gotten to it yet.=20
>=20
> For and end goal I think we want:
>=20
> a) Add all the config stuff for DCD regions - perhaps hardcode one initia=
lly.
> b) Device that generates DCD events (don't care on interface to make them=
 happen but maybe start
>    with QMP similar to injection interfaces).
> c) Device that maps the DCD extents through to doing the correct read and=
 write behavior for
>    reads that aren't in DCD extents.
> d) A standards based way to poke the FM-API. Tunneling and / or MCTP CCIs
>=20
>=20
> Can probably split this up though so if multiple people are hacking on it=
 they don't clash.
>=20
> (a) and (b) needed to do anything useful with kernel side.
> (c) needed for testing long term, but don't care initially.
>=20
> (d) mostly separable - needed for a 'nice' test setup but not for basic f=
unctionality testing.
>=20
> If you want to take a look at (a) and (b) and maybe (c) that would be gre=
at.
>=20
> There is lots of independent stuff to do for (d) so maybe I'll focus on t=
hat in short term?
>=20
> How's that work for you?
>=20
> Jonathan
>=20

Hi Jonathan and Gregory,
I have some initial code for DCD support for qemu emulation. It
mainly includes following
1. DCD mailbox command support at qemu side;
2. QMP interface to support DCD event like adding/removing dynamic
capacity
3. DCD Device representative for Qemu emulation (based on
cxl_type3.c)

The code is only draft now and not completed or tested with early
enabling code posted by Dan in the thread.
If you are interested, feel free to use it as base and carry it on.
I will also continue to work on it.
My next step would be to check the kernel side DCD code and
try to fix anything missing/incorrect at qemu side, and then see if we can =
do
some very simple DCD test with both kernel and qemu support.

Here is the code:
https://github.com/moking/qemu-dev/tree/dcd

Fan

>=20
> >=20
> > ~Gregory
>=20
> =
