Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD8CC61DA4
	for <linux-cxl@archiver.kernel.org>; Fri, 27 Jan 2023 17:03:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234787AbjA0RDF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 27 Jan 2023 12:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234748AbjA0RDC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 27 Jan 2023 12:03:02 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA2480002
        for <linux-cxl@vger.kernel.org>; Fri, 27 Jan 2023 09:02:40 -0800 (PST)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230127170237usoutp015da475b7283befbc9a83301c92e90015~_OSiTnbQg1456614566usoutp01l;
        Fri, 27 Jan 2023 17:02:37 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230127170237usoutp015da475b7283befbc9a83301c92e90015~_OSiTnbQg1456614566usoutp01l
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674838957;
        bh=xo6NKWcssS3cWVTN3ib4J243PkzFucJeyUEbGHIt8wc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=lX9Js2b824u67rr+wya6L5qJDfOozLiGP8jF6QZZwPxxZSjh9sfCXtg15T3cB3X1S
         DksMgggnHquFTy5vVEYchCaYHAMHhlwEhjLp/F1syV6cl+z33lxBoFRC9zE5RwIrKn
         vG2OyoVPbuoLVj5I50TUJT3HfAvYz6EW+bq1dB7U=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230127170237uscas1p2a23f4246445d6eaedb452b9620a7eab7~_OSiGC6Uy2640226402uscas1p2i;
        Fri, 27 Jan 2023 17:02:37 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 4B.6B.49129.DA304D36; Fri,
        27 Jan 2023 12:02:37 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230127170237uscas1p1fd9a04985d119f0db94c46d7018c1ef1~_OSh0Pqh81326713267uscas1p1O;
        Fri, 27 Jan 2023 17:02:37 +0000 (GMT)
X-AuditID: cbfec36f-167fe7000001bfe9-a9-63d403ad3991
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id F4.05.11378.DA304D36; Fri,
        27 Jan 2023 12:02:37 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 27 Jan 2023 09:02:36 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        27 Jan 2023 09:02:36 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 2/2] hw/pxb-cxl: Support passthrough HDM Decoders unless
 overridden
Thread-Topic: [PATCH 2/2] hw/pxb-cxl: Support passthrough HDM Decoders
        unless overridden
Thread-Index: AQHZMNGiiun86hSl3USF52ioTTSPk66xxtgAgADKX4CAAHWLgA==
Date:   Fri, 27 Jan 2023 17:02:36 +0000
Message-ID: <20230127170210.GA211474@bgt-140510-bm03>
In-Reply-To: <20230127100149.0000563e@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C3AFFFC303202247A691699BE082781D@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrOKsWRmVeSWpSXmKPExsWy7djXc7prma8kG+zrUba4+/gCm0Xz5MWM
        FiduNrJZ7H/6nMVi1cJrbBbnZ51isTi88QyTxf9fr1gtjvfuYHHg9Gg58pbVY/Gel0wem1Z1
        snk8ubaZyeP9vqtsHp83yQWwRXHZpKTmZJalFunbJXBlbLjezFYwRbTi7vovbA2MtwW6GDk5
        JARMJHo+zmMFsYUEVjJKtP127WLkArJbmSROXVrKClN0dfVHNoiitYwSf+6bQhR9YpSYfqUR
        qnsZo8TeFkcQm01AUWJf13awBhEBI4kryw6ygzQwC7xgkvh79TFzFyMHh7BApMS5XguImiiJ
        H+/msEPYThJf228xgtgsAqoSC2YdA5vDK2AqseBWMyNIK6eAocStayogYUYBMYnvp9YwgdjM
        AuISt57MZ4K4WVBi0ew9zBC2mMS/XQ/ZIGxFifvfX7JD1OtILNj9iQ3CtpM43LQXao62xLKF
        r5kh1gpKnJz5hAWiV1Li4IobLCCvSAh84JDYPW0f1AIXiXff+qGBJS1x9fpUsBclBJIlVn3k
        ggjnSMxfsgVqjrXEwj/rmSYwqsxCcvYsJCfNQnLSLCQnzUJy0gJG1lWM4qXFxbnpqcVGeanl
        esWJucWleel6yfm5mxiBaev0v8P5Oxiv3/qod4iRiYPxEKMEB7OSCO9Wx0vJQrwpiZVVqUX5
        8UWlOanFhxilOViUxHkNbU8mCwmkJ5akZqemFqQWwWSZODilGpi466OT+KZ8/PRfS2lye9X/
        k8XsL+Z9LTxxIuay9GWuPe5xVrzq6yUClDpCFmxNzOE80R/1d0ryabvchXf5Hz9Osm7y9X8V
        8zB73dm9RmHbp0ZIHpzydtdpt6768sx9B5QO7PEyMZm0ZMIiq1vO+ukpsfdaU5dNnJiRvWpR
        PC/XFl2XgJws3YKSo6cKDPW39vh9X7aybOK2xLz66Uo37roeavwgl6P/p8lc+sGH6cVHF6Vs
        naH9c4PohIau9qe5a3tP793hlpj7TffppyWBVi3O+wRqm6+8nf9owTzFsKkJhqH2T+31T/5l
        nHXkxP31kyvF/VZrezCylezcddrruoSXE/dU6d665/fmVBx66pOnxFKckWioxVxUnAgAfOZC
        ZMoDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBIsWRmVeSWpSXmKPExsWS2cA0SXct85VkgznzeC3uPr7AZtE8eTGj
        xYmbjWwW+58+Z7FYtfAam8X5WadYLA5vPMNk8f/XK1aL4707WBw4PVqOvGX1WLznJZPHplWd
        bB5Prm1m8ni/7yqbx+dNcgFsUVw2Kak5mWWpRfp2CVwZG643sxVMEa24u/4LWwPjbYEuRk4O
        CQETiaurP7KB2EICqxklFn/P7WLkArI/MUp0v93MDuEsY5R4M+sWM0gVm4CixL6u7WAdIgJG
        EleWHQQrYhZ4wSTxdGoXUIKDQ1ggUuJcrwVETZTEr4bdLBC2k8TX9luMIDaLgKrEglnHwObw
        CphKLLjVzAixbA6TxOqrU1lB5nAKGErcuqYCUsMoICbx/dQaJhCbWUBc4taT+UwQHwhILNlz
        nhnCFpV4+fgfK4StKHH/+0t2iHodiQW7P7FB2HYSh5v2Qs3Rlli28DUzxA2CEidnPmGB6JWU
        OLjiBssERolZSNbNQjJqFpJRs5CMmoVk1AJG1lWM4qXFxbnpFcWGeanlesWJucWleel6yfm5
        mxiBkX/63+HIHYxHb33UO8TIxMF4iFGCg1lJhHer46VkId6UxMqq1KL8+KLSnNTiQ4zSHCxK
        4rxCrhPjhQTSE0tSs1NTC1KLYLJMHJxSDUxuJ1Pk3pT7CvQ6cTq+uyRwMuupZmXzXI1lNlWX
        5ry8uefN5WCRq2HtaSl2C/mCDvPovvvn8l7b65m8Rnjpj8f3I3a9nsFyImYai8ybn34f/3pf
        ObKYpzpP/1qSndLUh6ZCd2UfhrYemL5v2s7Tm8z3KRV4plT+Dpz66eaSxat+GjjeuZiuHn5g
        wz+hxlhB6baLtX3PW1doz566r8H6nt2mJU8VVn0sV//Jsbp2Q7h49kfJjk3GV4/fc/WL52VS
        eutssG3FGXHX11+VF/J/ZUmu51zpHW5pHLhfYWtZMOs0fr3Vjmu3evt/SnWVbvvQrGp/dOad
        cys//eVavjrD557U9NT1Zad0Tr/T+/5avGW7EktxRqKhFnNRcSIACG9S5WsDAAA=
X-CMS-MailID: 20230127170237uscas1p1fd9a04985d119f0db94c46d7018c1ef1
CMS-TYPE: 301P
X-CMS-RootMailID: 20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5
References: <20230125152703.9928-1-Jonathan.Cameron@huawei.com>
        <20230125152703.9928-3-Jonathan.Cameron@huawei.com>
        <CGME20230126215736uscas1p2166334bf8185239cf6ac70053dc386c5@uscas1p2.samsung.com>
        <20230126215727.GA203951@bgt-140510-bm03>
        <20230127100149.0000563e@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Jan 27, 2023 at 10:01:49AM +0000, Jonathan Cameron wrote:

> On Thu, 26 Jan 2023 21:57:35 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
>=20
> > On Wed, Jan 25, 2023 at 03:27:03PM +0000, Jonathan Cameron wrote:
> >=20
> > > The CXL r3.0 specification allows for there to be no HDM decoders on =
CXL
> > > Host Bridges if they have only a single root port. Instead, all acces=
ses
> > > directed to the host bridge (as specified in CXL Fixed Memory Windows=
)
> > > are assumed to be routed to the single root port.
> > >=20
> > > Linux currently assumes this implementation choice. So to simplify te=
sting,
> > > make QEMU emulation also default to no HDM decoders under these parti=
cular
> > > circumstances, but provide a hdm_for_passthrough boolean option to ha=
ve
> > > HDM decoders as previously.
> > >=20
> > > Technically this is breaking backwards compatibility, but given the o=
nly
> > > known software stack used with the QEMU emulation is the Linux kernel
> > > and this configuration did not work before this change, there are
> > > unlikely to be any complaints that it now works. The option is retain=
ed
> > > to allow testing of software that does allow for these HDM decoders t=
o exist,
> > > once someone writes it.
> > >=20
> > > Reported-by: Fan Ni <fan.ni@samsung.com>
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
>=20
> > >      pxb_dev_realize_common(dev, CXL, errp);
> > > -    pxb_dev_reset(DEVICE(dev));
> > > +    pxb_cxl_dev_reset(DEVICE(dev));
> > >  }
> > > =20
> > > +static Property pxb_cxl_dev_properties[] =3D {
> > > +    /* Note: 0 is not a legal PXB bus number. */
> > > +    DEFINE_PROP_UINT8("bus_nr", PXBDev, bus_nr, 0),
> > > +    DEFINE_PROP_UINT16("numa_node", PXBDev, numa_node, NUMA_NODE_UNA=
SSIGNED),
> > > +    DEFINE_PROP_BOOL("bypass_iommu", PXBDev, bypass_iommu, false),
> > > +    DEFINE_PROP_BOOL("hdm_for_passthrough", PXBDev, hdm_for_passthro=
ugh, false), =20
> > when setting hdm_for_passthrough to true at the qemu command line, we
> > will see the segfault issue as before. I think this is expected as it
> > is the logic in cxl_cfmws_find_device. Wondering if there will be
> > following fixes to handle the case when hdm_for_passthrough is true.
>=20
> Absolutely, I'd expect a kernel fix for that case, but it's probably not
> high priority for anyone given we don't yet have any hardware that does t=
hat
> (as far as I know anyway!)
>=20
> I wanted to keep the control here to make that easy to test when we do
> have the fix in place.
>=20
> Jonathan
Make sense!

Reviwed-by: Fan Ni <fan.ni@samsung.com>
Tested-by: Fan Ni <fan.ni@samsung.com>
