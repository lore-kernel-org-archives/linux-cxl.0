Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39A8BC433FE
	for <linux-cxl@archiver.kernel.org>; Tue,  1 Nov 2022 15:42:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiKAPmp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 1 Nov 2022 11:42:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231373AbiKAPmo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 1 Nov 2022 11:42:44 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFCBCB1
        for <linux-cxl@vger.kernel.org>; Tue,  1 Nov 2022 08:42:42 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221101154239usoutp02531d84fdf9a4c8c09a5cc629564bf385~jgE3numT-2306123061usoutp02x;
        Tue,  1 Nov 2022 15:42:39 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221101154239usoutp02531d84fdf9a4c8c09a5cc629564bf385~jgE3numT-2306123061usoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667317359;
        bh=zrGSS6mqMb2NcKMyMDQTbv/3rONT25X7S5klyDVk/DU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=Qm2QJkzi3RuPiMCUbxl4/oMCjXwTQ/URgYw6G3m7dlsGgTwjrapMQZ2kkkeMT2gGz
         c3eDXswih9ZaDBHQSy9pjXeapw0TelQKa7t1yF1LvMZY4+eNjxXKxJ8LZfliEGQLEa
         UXBaYrPTfu01nbGvY6j7ZSqVg5V56vL9n/kvL5bs=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221101154239uscas1p259a67fc2bb219c3e47cfb52c66266b67~jgE3foHW_2594225942uscas1p2s;
        Tue,  1 Nov 2022 15:42:39 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id E4.6D.18126.E6E31636; Tue, 
        1 Nov 2022 11:42:38 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221101154238uscas1p1fd6f25025ecd4c0b930721c1b5649af7~jgE3Lvpck1694716947uscas1p11;
        Tue,  1 Nov 2022 15:42:38 +0000 (GMT)
X-AuditID: cbfec36f-fe1ff700000146ce-0c-63613e6e4c63
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 33.C0.36264.E6E31636; Tue, 
        1 Nov 2022 11:42:38 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 1 Nov 2022 08:42:37 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        1 Nov 2022 08:42:37 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>
Subject: Re: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Topic: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Index: AQHY6ykWpXsE/hQsVUualGBz0TCrfq4k9ikAgAU0X4CAAIWcgA==
Date:   Tue, 1 Nov 2022 15:42:37 +0000
Message-ID: <20221101154218.GA78088@bgt-140510-bm03>
In-Reply-To: <d90e2d92cd48749b17d162ba330bf49086372cfd.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <5007835D1AB968428F2F67C5D9A5D783@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFuphleLIzCtJLcpLzFFi42LZduzrOd08u8Rkg8f/zS2mT73AaHF+1ikW
        i1sTjjE5MHss3vOSyePzJrkApigum5TUnMyy1CJ9uwSujEWvzrAWNCpUTPizmLGB8YFUFyMn
        h4SAicTaTevZuxi5OIQEVjJKvDuznAXCaWWSmHihhQ2m6mTzCkaIxFpGiW/7t0NVfQRqWX6B
        CcJZyijx4t8GFpAWNgFFiX1d28HaRQQyJSZ9/sgKUsQsMIFRYuHBeYwgCWEBR4lX374xQRQ5
        SRxcsoENxl74fhqYzSKgIrF36RqwobxAd7w80gsW5xRwl/h9cwnYHEYBMYnvp9aAzWEWEJe4
        9WQ+E8TdghKLZu9hhrDFJP7tegj1j6LE/e8v2SHq9SRuTJ3CBmHbSXz5eh0qri2xbOFrZoi9
        ghInZz5hgeiVlDi44gbY+xICCzkkjm64AZVwkTh3cj4rhC0t8ffuMqgjqiXO9JxjgmhoYZS4
        1LgZ6iJriX+d19gnMKrMQnL4LCRHzUJy1CwkR81CctQCRtZVjOKlxcW56anFRnmp5XrFibnF
        pXnpesn5uZsYgQnm9L/D+TsYr9/6qHeIkYmD8RCjBAezkghv/dnoZCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8UTO0koUE0hNLUrNTUwtSi2CyTBycUg1Ms9N0/qRnM4rHtzeH10it4/5eZVUm
        sOZD+xyHd11Xiwzkog8eZ3x2aedk8cmb71rfYD78b+K/ys/d51nP/nhyUGrj+3SXy7y3eqsZ
        ZXkWvWe9fiP534kzty9s1uGb2OGS/b1w9uQPV7ofTjqUVx/6aILGige9lW2+75Nk/vTtSu9c
        23bNsNfhd9iFrhsLarc6LYn7n3tn2uXcj0/qgmx9o6SFWteW3t724xl7Uehu479sq+/t7M36
        lFcebrTvs/jVdf8bzX1Kd0hZdkde5Q35ExjuPjVeN8rdPnDB+j/3JQok/5e2fN6+u9n/Ucyi
        h1vt4jZU1u2Yf/eZ99/4ulMXHgn/uuz/L7qd75KqUFxVnRJLcUaioRZzUXEiALOzTZ2fAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWS2cA0STfPLjHZoPmEosX0qRcYLc7POsVi
        cWvCMSYHZo/Fe14yeXzeJBfAFMVlk5Kak1mWWqRvl8CVsejVGdaCRoWKCX8WMzYwPpDqYuTk
        kBAwkTjZvIKxi5GLQ0hgNaPEnGXdzCAJIYGPjBJ/1otDJJYySsz69IodJMEmoCixr2s7G4gt
        IpApMenzR1aQImaBCYwSCw/OYwRJCAs4Srz69o0JoshJ4uCSDWww9sL308BsFgEVib1L17CA
        2LxAZ7w80ssGsa2NSeJMz1uwbZwC7hK/by4BG8ooICbx/dQasKHMAuISt57MZ4L4QUBiyZ7z
        zBC2qMTLx/9YIWxFifvfX7JD1OtJ3Jg6hQ3CtpP48vU6VFxbYtnC18wQRwhKnJz5hAWiV1Li
        4IobLEA/zUKybhaSUbOQjJqFZNQsJKMWMLKuYhQvLS7OTa8oNspLLdcrTswtLs1L10vOz93E
        CIzM0/8OR+9gvH3ro94hRiYOxkOMEhzMSiK89Wejk4V4UxIrq1KL8uOLSnNSiw8xSnOwKInz
        voyaGC8kkJ5YkpqdmlqQWgSTZeLglGpg0tdaEOO6kOlv45+E3Rzcf3zW3tsS4bh72nyez/cX
        37hQ1aUoZb3hD9f3oiv/NkbbzvBqqr93fm6v55Gm297upX9O/stg7T6iFW5a58WnGrDmQ82B
        ReqTP6x0lvm48Y7g5qsZ8gFCPEKrhDgSGnIeqtVqVZ/ZzuHjyvFilkr2HQs+42n8+3LcLie3
        uC2d3Rt3ardseLhJWtkb7SRHti61/T7tGtd4Nh7KUlpV1fJbndFM8GnA9i873xquUePfc+rQ
        Uz6zO0J2L3fNvdfs6hhd9Wb50dLt7je5+ljuLPKpv/Iv5ML9W1WMUVP4Gvsd1mbfdOB6MkW/
        aEtcmfBqlVCXv4Y/GY/FxVt/a2yXaY1TYinOSDTUYi4qTgQAYwSbIjsDAAA=
X-CMS-MailID: 20221101154238uscas1p1fd6f25025ecd4c0b930721c1b5649af7
CMS-TYPE: 301P
X-CMS-RootMailID: 20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b
References: <CGME20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b@uscas1p1.samsung.com>
        <20221028235705.32890-1-fan.ni@samsung.com>
        <635c70a8460b3_6be129497@dwillia2-xfh.jf.intel.com.notmuch>
        <d90e2d92cd48749b17d162ba330bf49086372cfd.camel@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Nov 01, 2022 at 07:44:21AM +0000, Verma, Vishal L wrote:

Thanks Vishal & Dan for the comments. I will update the patch and send
it out for review.

Fan
> On Fri, 2022-10-28 at 17:15 -0700, Dan Williams wrote:
> > Fan Ni wrote:
>=20
> >> Subject:	RE: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
>=20
> General note - please make sure to denote a revision correctly with
> something like [PATCH v2] in the subject line.
>=20
> > > The function for retrieving firmware version is named
> > > `cxl_memdev_get_firmware_verison`, updated to
> > > `cxl_memdev_get_firmware_version'.
> > > keeping `cxl_memdev_get_firmware_verison` for library compatibility.
> > >=20
> > > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > > ---
> > > =A0Documentation/cxl/lib/libcxl.txt | 1 +
> > > =A0cxl/lib/libcxl.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 |=
 5 +++++
> > > =A0cxl/lib/libcxl.sym=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 5 +=
++++
> > > =A0cxl/libcxl.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 1 +
> > > =A04 files changed, 12 insertions(+)
> > >=20
> > > diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib=
/libcxl.txt
> > > index fd2962a..5a8d980 100644
> > > --- a/Documentation/cxl/lib/libcxl.txt
> > > +++ b/Documentation/cxl/lib/libcxl.txt
> > > @@ -69,6 +69,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev)=
;
> > > =A0unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *mem=
dev);
> > > =A0unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memd=
ev);
> > > =A0const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *mem=
dev);
> > > +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memde=
v);
> > > =A0size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
> > > =A0int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
> > > =A0int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
> > > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > > index e8c5d44..1b7e9d2 100644
> > > --- a/cxl/lib/libcxl.c
> > > +++ b/cxl/lib/libcxl.c
> > > @@ -1267,6 +1267,11 @@ CXL_EXPORT const char *cxl_memdev_get_firmware=
_verison(struct cxl_memdev *memdev
> > > =A0=A0=A0=A0=A0=A0=A0=A0return memdev->firmware_version;
> > > =A0}
> > > =A0
> > > +CXL_EXPORT const char *cxl_memdev_get_firmware_version(struct cxl_me=
mdev *memdev)
> > > +{
> > > +=A0=A0=A0=A0=A0=A0=A0return memdev->firmware_version;
> > > +}
> > > +
> >=20
> > It occurs to me that a new export is not needed for this...
> >=20
> > > =A0static void bus_invalidate(struct cxl_bus *bus)
> > > =A0{
> > > =A0=A0=A0=A0=A0=A0=A0=A0struct cxl_ctx *ctx =3D cxl_bus_get_ctx(bus);
> > > diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> > > index 8bb91e0..d46c50e 100644
> > > --- a/cxl/lib/libcxl.sym
> > > +++ b/cxl/lib/libcxl.sym
> > > @@ -217,3 +217,8 @@ global:
> > > =A0=A0=A0=A0=A0=A0=A0=A0cxl_decoder_get_max_available_extent;
> > > =A0=A0=A0=A0=A0=A0=A0=A0cxl_decoder_get_region;
> > > =A0} LIBCXL_2;
> > > +
> > > +LIBCXL_4 {
> > > +global:
> > > +=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_firmware_version;
> > > +} LIBCXL_3;
> > > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > > index 9fe4e99..7951e78 100644
> > > --- a/cxl/libcxl.h
> > > +++ b/cxl/libcxl.h
> > > @@ -48,6 +48,7 @@ struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memde=
v *memdev);
> > > =A0unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *mem=
dev);
> > > =A0unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memd=
ev);
> > > =A0const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *mem=
dev);
> > > +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memde=
v);
> >=20
> > ...just make this the following instead:
> >=20
> > /* ABI spelling mistakes are forever */
> > static inline const char *cxl_memdev_get_firmware_version(struct cxl_me=
mdev *memdev)
> > {
> > =A0=A0=A0=A0=A0=A0=A0=A0return cxl_memdev_get_firmware_verison(memdev);
> > }
>=20
> Agreed with this.
> =
