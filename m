Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 031B8ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 20:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiJ1UFm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 16:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229936AbiJ1UFl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 16:05:41 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 601AB25EA8
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 13:05:38 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221028200535usoutp023b9026fca45aa4dc28cb22c0bc443e2c~iVFTqp-mm1275812758usoutp02g;
        Fri, 28 Oct 2022 20:05:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221028200535usoutp023b9026fca45aa4dc28cb22c0bc443e2c~iVFTqp-mm1275812758usoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666987535;
        bh=evhKpQm02W65IPpn2uee2isjKeENNQtkM/CqF20u86o=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=e2XA3EzHYWFM+NK9OxwvIX9VpcbORHt3EmaJbpMp12W5TLQVSjiRc0WL+AtZp/JG0
         T/RHVFOTx5xr2G5rh5pTXIfDTGgMIn7dsjoacjfWDXGHK43fQ2DtIM8CZQz1In6+gg
         oRFab8CItcjDAY4t4ybRK8euEqLXzrV3kOxZljeY=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221028200535uscas1p25b59a8f946877a017b68e2d539e37c59~iVFTam8Bw0488804888uscas1p23;
        Fri, 28 Oct 2022 20:05:35 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id B8.EE.18126.F063C536; Fri,
        28 Oct 2022 16:05:35 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221028200535uscas1p1c538de7521884c6bc56429f80f517ca3~iVFTLN62v1585415854uscas1p1b;
        Fri, 28 Oct 2022 20:05:35 +0000 (GMT)
X-AuditID: cbfec36f-fe1ff700000146ce-39-635c360fdb94
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 1E.84.19363.E063C536; Fri,
        28 Oct 2022 16:05:35 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 28 Oct 2022 13:05:34 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        28 Oct 2022 13:05:34 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
CC:     Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>
Subject: Re: [ndctl PATCH] cxl: Fix some naming typos
Thread-Topic: [ndctl PATCH] cxl: Fix some naming typos
Thread-Index: AQHY6vcF3+3pzDpW2kC/Zp5jFYLl5K4kNcqAgAB64YA=
Date:   Fri, 28 Oct 2022 20:05:34 +0000
Message-ID: <20221028200526.GA29212@bgt-140510-bm03>
In-Reply-To: <54c31beb1bc124f5cb2e79660d311453760fcf1e.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <6FC11D7AE421A64E8697693C45A1B9BD@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupkleLIzCtJLcpLzFFi42LZduzrOV1+s5hkg3XPJC2mT73AaHF+1ikW
        i1sTjjE5MHss3vOSyePzJrkApigum5TUnMyy1CJ9uwSujGevFrAXdCtWPGpQbmBcLtPFyMkh
        IWAiMWfifpYuRi4OIYGVjBIr/h1jh3BamSSWrdjHAlf1eA0riC0ksJZR4v13fQj7E6PE8mna
        EA3LGCVWHZzJBpJgE1CU2Ne1HcwWETCQ2D5rLSNIEbPAaUaJ5u5tYAlhAVOJKTtesUAUmUl0
        PH/PBGFbSbz+/hOshkVAVeLqtE6wzbxAV1xqmQZmcwq4S5xrusgOYjMKiEl8P7UGrJdZQFzi
        1pP5TBBXC0osmr2HGcIWk/i36yEbhK0ocf/7S3aIej2JG1OnsEHYdhInr26EmqMtsWzha2aI
        vYISJ2c+gYaEpMTBFTfA4SUhsJBD4tX9LVAJF4k3W9uglklLXL0+FcquljjTc44JoqGFUeJS
        42aohLXEv85r7BMYVWYhOXwWkqNmITlqFpKjZiE5agEj6ypG8dLi4tz01GKjvNRyveLE3OLS
        vHS95PzcTYzA1HL63+H8HYzXb33UO8TIxMF4iFGCg1lJhLf+bHSyEG9KYmVValF+fFFpTmrx
        IUZpDhYlcd6oGVrJQgLpiSWp2ampBalFMFkmDk6pBiZnX6FERq997GLFlufuiW29b5jeErsn
        MCn7a/BTFYOQm6fWsQrK/bOx+berYddX16nb3ge0Hv9jWb5RtTNr5xWtP3U26XX2ZXE9n29G
        /frlMHHXzdUyL58XKNm/u7lX2fEm29GWSOemeW9uu1dPCncSnLUgevbS2EONb2fyfkl5tH7d
        R7t3soFOR2yMX53ZffrjTZZPhl1NSzXK8zPXB705b/ZJg/9xkoeoVlbNwSrGgrJDt++eXVu4
        fK1724TrnXPtZG2365qEhTBfOrP5/pLU/g33whau0GOY/vir2ZllIgI/prPPct9lcOt2maTz
        Q37vd//qjFdVWCxVc1+/ZgNj17VZM7pm/lGf9XR6AMceJZbijERDLeai4kQAKKBmhJwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBIsWRmVeSWpSXmKPExsWS2cA0SZffLCbZYOpqdovpUy8wWpyfdYrF
        4taEY0wOzB6L97xk8vi8SS6AKYrLJiU1J7MstUjfLoEr49mrBewF3YoVjxqUGxiXy3QxcnJI
        CJhIzHm8hrWLkYtDSGA1o8TT7Z8YIZxPjBLn/25hgXCWMUq8XrWBEaSFTUBRYl/XdjYQW0TA
        QGL7rLVgHcwCpxklmru3gSWEBUwlpux4xQJRZCbR8fw9E4RtJfH6+0+wGhYBVYmr0zpZQWxe
        oDsutUyDuuMEo8T7RfPBGjgF3CXONV1kB7EZBcQkvp9aAxZnFhCXuPUEokZCQEBiyZ7zzBC2
        qMTLx/9YIWxFifvfX7JD1OtJ3Jg6hQ3CtpM4eXUj1BxtiWULXzNDHCEocXLmExaIXkmJgytu
        sExglJiFZN0sJKNmIRk1C8moWUhGLWBkXcUoXlpcnJteUWyYl1quV5yYW1yal66XnJ+7iREY
        maf/HY7cwXj01ke9Q4xMHIyHGCU4mJVEeOvPRicL8aYkVlalFuXHF5XmpBYfYpTmYFES5xVy
        nRgvJJCeWJKanZpakFoEk2Xi4JRqYLrJunL11DlcFzYwr70dVGr04uHyxqf5fxdq+R5ucvez
        NJxe9n6FvPpU5zkf7PgCKs/vXenyN96O76dzlYJy90U57q3pMh9c5kXy3pH4Kpm/9dk3c5aP
        sYZvkhP/rVv06VDhuwnZPQ9ub948P9uBjfmA9saHCTrbH/va1b3g+xO3WmXlzUdiE6sjAh5e
        v/NAxfj72TXVTn8Cty6q7z+/d/dlhmnO1k9Mn3Hf/lh7yuNuiBwzQ7WuVLPIFLljDy78XPz8
        v1oNs3W2C+cL+de3sxMex1q8q3xm+caj914g/zOX9s5JKzaEbSh5zHWCMah/5Y/rHYcUfgnJ
        89fPs9M3PL90aZS/xu+vfa+XTtyb/O20EktxRqKhFnNRcSIAp5z/tzsDAAA=
X-CMS-MailID: 20221028200535uscas1p1c538de7521884c6bc56429f80f517ca3
CMS-TYPE: 301P
X-CMS-RootMailID: 20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f
References: <CGME20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f@uscas1p1.samsung.com>
        <20221028175752.27879-1-fan.ni@samsung.com>
        <54c31beb1bc124f5cb2e79660d311453760fcf1e.camel@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, Oct 28, 2022 at 07:45:42PM +0000, Verma, Vishal L wrote:

> On Fri, 2022-10-28 at 17:59 +0000, Fan Ni wrote:
> > The function for retrieving firmware version is named
> > `cxl_memdev_get_firmware_verison`, updated to `cxl_memdev_get_firmware_=
version'.
> >=20
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> > =A0Documentation/cxl/lib/libcxl.txt | 2 +-
> > =A0cxl/lib/libcxl.c=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2=
 +-
> > =A0cxl/lib/libcxl.sym=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 | 2 +-
> > =A0cxl/libcxl.h=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 | 2 +-
> > =A04 files changed, 4 insertions(+), 4 deletions(-)
>=20
> Hi Fan,
>=20
> Thanks for catching this. However since the typo is in an exported API,
> we can't simply change it to the right spelling, as that would break
> library compatibility, cause an soname bump (which we try to avoid).
>=20
> A solution would be to /add/ the fixed spelling version of the api
> alongside the misspelled one. Would you like to take a crack at doing
> that instead?
>=20
> Note that for the new API, the libcxl.sym addition will need to go into
> a new section at the bottom instead of alongside the old one.
>=20

Sure. I will fix as you suggested and send out a new patch for review.
Thanks.

> >=20
> > diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/l=
ibcxl.txt
> > index fd2962a..edc852d 100644
> > --- a/Documentation/cxl/lib/libcxl.txt
> > +++ b/Documentation/cxl/lib/libcxl.txt
> > @@ -68,7 +68,7 @@ int cxl_memdev_get_major(struct cxl_memdev *memdev);
> > =A0int cxl_memdev_get_minor(struct cxl_memdev *memdev);
> > =A0unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memde=
v);
> > =A0unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev=
);
> > -const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)=
;
> > +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev)=
;
> > =A0size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
> > =A0int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
> > =A0int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
> > diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
> > index e8c5d44..b7ad263 100644
> > --- a/cxl/lib/libcxl.c
> > +++ b/cxl/lib/libcxl.c
> > @@ -1262,7 +1262,7 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_=
size(struct cxl_memdev *memdev)
> > =A0=A0=A0=A0=A0=A0=A0=A0return memdev->ram_size;
> > =A0}
> > =A0
> > -CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memd=
ev *memdev)
> > +CXL_EXPORT const char *cxl_memdev_get_firmware_version(struct cxl_memd=
ev *memdev)
> > =A0{
> > =A0=A0=A0=A0=A0=A0=A0=A0return memdev->firmware_version;
> > =A0}
> > diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
> > index 8bb91e0..febbca6 100644
> > --- a/cxl/lib/libcxl.sym
> > +++ b/cxl/lib/libcxl.sym
> > @@ -19,7 +19,7 @@ global:
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_ctx;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_pmem_size;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_ram_size;
> > -=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_firmware_verison;
> > +=A0=A0=A0=A0=A0=A0=A0cxl_memdev_get_firmware_version;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_cmd_get_devname;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_cmd_new_raw;
> > =A0=A0=A0=A0=A0=A0=A0=A0cxl_cmd_set_input_payload;
> > diff --git a/cxl/libcxl.h b/cxl/libcxl.h
> > index 9fe4e99..c3c99b8 100644
> > --- a/cxl/libcxl.h
> > +++ b/cxl/libcxl.h
> > @@ -47,7 +47,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
> > =A0struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
> > =A0unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memde=
v);
> > =A0unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev=
);
> > -const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev)=
;
> > +const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev)=
;
> > =A0size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
> > =A0int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
> > =A0int cxl_memdev_enable(struct cxl_memdev *memdev);
> =
