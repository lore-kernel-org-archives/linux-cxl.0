Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE4A6C0015E
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231539AbjGXQly (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:41:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231517AbjGXQlw (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:41:52 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0B73125
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:41:50 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230724164149usoutp015ac6e635c966b359661c546fbf457b62~021L9XV421790317903usoutp01C;
        Mon, 24 Jul 2023 16:41:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230724164149usoutp015ac6e635c966b359661c546fbf457b62~021L9XV421790317903usoutp01C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690216909;
        bh=85A2EvZjU0d13Wi+zWn4IH0l4SRoVqMVOLly2F2YE2s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ttk+SBfvOS6kc44wE1wZtMOLwPW5MmkFCwNDBk/mWiaQ2mo0IaHLrdTRb/uH+M+Cd
         YCl42hfeDcAq5gGlSUS+otNE3U1eno7QQeAkbhiSBZ+xNGv224PC6hDHJkYjVH3WES
         re69NdprhSHYHM0bjsdKYuA7g/GETs1euR2m5C84=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724164149uscas1p164c041243785e00b6dd1b494692a40aa~021LnEVhd0122501225uscas1p1K;
        Mon, 24 Jul 2023 16:41:49 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 1E.48.62237.DC9AEB46; Mon,
        24 Jul 2023 12:41:49 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724164148uscas1p2094eb209cadef83526227eb62cdda65c~021LQvfWZ1193911939uscas1p2S;
        Mon, 24 Jul 2023 16:41:48 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-a7-64bea9cd7b90
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id F0.EB.38326.CC9AEB46; Mon,
        24 Jul 2023 12:41:48 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 09:41:48 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 09:41:48 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     Ira Weiny <ira.weiny@intel.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>
Subject: Re: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Thread-Topic: [Qemu PATCH 0/9] Enabling DCD emulation support in Qemu
Thread-Index: AQHZvk29IO9xT2nfDk6tpnSlp3N0qQ==
Date:   Mon, 24 Jul 2023 16:41:47 +0000
Message-ID: <20230724164136.GA130206@bgt-140510-bm03>
In-Reply-To: <20230724095748.00007e46@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <87D00D381C76BC4F861FDC2EFC483125@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrBKsWRmVeSWpSXmKPExsWy7djXc7pnV+5LMfg2jcui+/wGRovpUy8w
        Wqy+uYbRoqHpEYtFy+73TBb7nz5nsVi18BqbxflZp1gsnk98zmSxdMkjZovjvTtYHLg9Lkye
        wOqxuMHVY+esu+weLUfeAnl7XjJ5bPz4n93jybXNTB6bX79g9pg6u97j8ya5AK4oLpuU1JzM
        stQifbsErownfy4wFxxWqzg2ZRNjA+MmuS5GTg4JAROJY91/GLsYuTiEBFYySly9to8dwmll
        krh36wMzTNWGO52sEIm1jBLLJx2Hcj4xSvTMaYfqXwbUf/MwG0gLm4CixL6u7WC2iICRxJVl
        B8HmMgtsY5HYdHkqC0hCWMBF4saRBlaIIleJuVMaGCFsPYkjv6eBNbMIqEr8OfaNCcTmFTCV
        uDvvJFgNp4ChxMx1J8BqGAXEJL6fWgNWwywgLnHryXwmiLsFJRbN3gP1g5jEv10P2SBsRYn7
        31+yQ9TrSCzY/YkNwraTOPCzjwXC1pZYtvA1M8ReQYmTM5+wQPRKShxccYMF5BkJgemcEmsa
        Z7JCJFwkvlw+CrVAWuLq9alAzRxAdrLEqo9cEOEciflLtkDNsZZY+Gc90wRGlVlIzp6F5KRZ
        SE6aheSkWUhOWsDIuopRvLS4ODc9tdg4L7Vcrzgxt7g0L10vOT93EyMw8Z3+d7hgB+OtWx/1
        DjEycTAeYpTgYFYS4TWM2ZcixJuSWFmVWpQfX1Sak1p8iFGag0VJnNfQ9mSykEB6Yklqdmpq
        QWoRTJaJg1OqgWmH/Nr4VXV/Ixe6yMWder+Ry+h567XlD+46ef7h0t+1Icxd/+TqOZWZ6adE
        g7f5r24/LLzXl0EyN/nYUwfp2b7CjdclPtYGyj28sv48u0+z8/a+9yqJGxhsGI7x6CbM89rl
        Lyl1/MLs98XH39kla81LuH0sbnb3vRX1HgVLV2bWzN8pqXnOztzv9cxPWdPVU498XaQ1MWWa
        kbNjvdblvdbfgzS3q/78YHfxcojiw4zlK+Wjc59Omagza9X9HR9W7NaXPm5V8FFa1Vm1JvDE
        RJ+s+WJFknJ7eh4mBe5Xq1M6uKPy+fd58uf7li6abei99tmFowJm53P0ZuWI7zmSOyHG6L9L
        9KL42U0Os3YHzwtSYinOSDTUYi4qTgQAlj8/c+sDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKIsWRmVeSWpSXmKPExsWS2cA0SffMyn0pBpP36lt0n9/AaDF96gVG
        i9U31zBaNDQ9YrFo2f2eyWL/0+csFqsWXmOzOD/rFIvF84nPmSyWLnnEbHG8dweLA7fHhckT
        WD0WN7h67Jx1l92j5chbIG/PSyaPjR//s3s8ubaZyWPz6xfMHlNn13t83iQXwBXFZZOSmpNZ
        llqkb5fAlfHkzwXmgsNqFcembGJsYNwk18XIySEhYCKx4U4naxcjF4eQwGpGiU9//jCCJIQE
        PjFKPHyrC5FYxihx5scbVpAEm4CixL6u7WwgtoiAkcSVZQfZQYqYBbaxSKyecoMFJCEs4CJx
        40gDK0SRq8TcKQ2MELaexJHf08CaWQRUJf4c+8YEYvMKmErcnXcSavMWRonPSyxBbE4BQ4mZ
        606A1TMKiEl8P7UGrJ5ZQFzi1pP5TBAvCEgs2XOeGcIWlXj5+B8rhK0ocf/7S3aIeh2JBbs/
        sUHYdhIHfvaxQNjaEssWvmaGuEFQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CM
        WsDIuopRvLS4ODe9otgwL7Vcrzgxt7g0L10vOT93EyMwZZz+dzhyB+PRWx/1DjEycTAeYpTg
        YFYS4TWM2ZcixJuSWFmVWpQfX1Sak1p8iFGag0VJnFfIdWK8kEB6YklqdmpqQWoRTJaJg1Oq
        gWmzpprsm92cc/9rHdx3sZ2fOVvJnbXjcJzG2vVbL7cUHz7J9iT4+H+B/bPs/As9nTvT8w6b
        s31dOitOQXXNjCcbT7pcO+bQ91sxS+esNP+O1YvdPtyb4/Ni/fOEdJfAe5qSP5/NjLeb1KgX
        1i9d9L5HaMFh9dz8zt4EWTY5xjd9ItKVyxL9ts1yfxXow868X7fw+1SD4y//7Nh479G86ESV
        DfvV6zPas3gl98ws6+24bjuD/WDS32tKmzjOeclKpc0r+HH1whwjH+m4wi4n6yN7khMWu3wu
        y5h2cN6SFu9z+r26jE6131YyTp7GcqXpbWW9WsMPo66AbMMX9Xu/SBvsyrTyuFnd/7Z5m+Te
        RCWW4oxEQy3mouJEALlirlWIAwAA
X-CMS-MailID: 20230724164148uscas1p2094eb209cadef83526227eb62cdda65c
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724164148uscas1p2094eb209cadef83526227eb62cdda65c
References: <SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
        <64bcb1f6ee016_760de2943b@iweiny-mobl.notmuch>
        <20230724095748.00007e46@Huawei.com>
        <CGME20230724164148uscas1p2094eb209cadef83526227eb62cdda65c@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jul 24, 2023 at 09:57:48AM +0100, Jonathan Cameron wrote:

Hi Ira & Jonathan,

Thanks for helping check. I resend the patch series and now they
look normal now. Although I am still not sure what happened to my
previous sending.

The resend is here:
https://lore.kernel.org/linux-cxl/20230724162313.34196-1-fan.ni@samsung.com=
/T/#t

Thanks,
Fan



> On Sat, 22 Jul 2023 21:52:06 -0700
> Ira Weiny <ira.weiny@intel.com> wrote:
>=20
> > nifan@ wrote:
> > > From: Fan Ni <nifan@outlook.com>
> > >=20
> > > The patch series provides dynamic capacity device (DCD) emulation in =
Qemu. =20
> >=20
> > I don't the patches on the list.
> >=20
> > https://lore.kernel.org/all/SG2PR06MB33976BB3F9C47CBE08F02D09B23EA@SG2P=
R06MB3397.apcprd06.prod.outlook.com/
> >=20
> > Did they get sent?
> Something odd going on...
> They are in https://lists.nongnu.org/archive/html/qemu-devel/2023-07/msg0=
4105.html
> though threading is broken.
> Also seems to have made it to qemu-devel on lore
> https://lore.kernel.org/all/SG2PR06MB3397F3E74A083607F7492FA4B23EA@SG2PR0=
6MB3397.apcprd06.prod.outlook.com/
>=20
> Might be a backlog somewhere that will take a while to drain...
>=20
> Fan, perhaps just resend the lot and make sure the threading works so we =
can find them more easily.
>=20
> Jonathan
>=20
>=20
> >=20
> > Ira
> >=20
> > > More specifically, it provides the following functionalities:
> > > 1. Extended type3 memory device to support DC regions and extents.
> > > 2. Implemented DCD related mailbox command support in CXL r3.0: 8.2.9=
.8.9.
> > > 3. ADD QMP interfaces for adding and releasing DC extents to simulate=
 FM
> > > functions for DCD described in cxl r3.0: 7.6.7.6.5 and 7.6.7.6.6.
> > > 4. Add new ct3d properties for DCD devices (host backend, number of d=
c
> > > regions, etc.)
> > > 5. Add read/write support from/to DC regions of the device.
> > > 6. Add mechanism to validate accessed to DC region address space.
> > >=20
> > > A more detailed description can be found from the previously posted R=
FC[1].
> > >=20
> > > Compared to the previously posted RFC[1], following changes have been=
 made:
> > > 1. Rebased the code on top of Jonathan's branch
> > > https://gitlab.com/jic23/qemu/-/tree/cxl-2023-05-25.
> > > 2. Extracted the rename of mem_size to a separated patch.(Jonathan)
> > > 3. Reordered the patch series to improve its readability.(Jonathan)
> > > 4. Split the validation of accesses to DC region address space as a s=
eparate
> > > patch.
> > > 5. Redesigned the QMP interfaces for adding and releasing DC extents =
to make
> > > them easier to understand and act like existing QMP interfaces (like =
the
> > > interface for cxl-inject-uncorrectable-errors). (Jonathan)
> > > 6. Updated dvsec range register setting to support DCD devices withou=
t static
> > > capacity.
> > > 7. Fixed other issues mentioned in the comments (Jonathan&Nathan Font=
enot).
> > > 8. Fixed the format issues and checked with checkpatch.pl under qemu =
code dir.
> > >=20
> > >=20
> > > The code is tested with the DCD patch series at the kernel side[2]. T=
he test
> > > is similar to those mentioned in the cover letter of [1].
> > >=20
> > >=20
> > > [1]: https://lore.kernel.org/all/20230511175609.2091136-1-fan.ni@sams=
ung.com/
> > > [2]: https://lore.kernel.org/linux-cxl/649da378c28a3_968bb29420@iwein=
y-mobl.notmuch/T/#t
> > >=20
> > > Fan Ni (9):
> > >   hw/cxl/cxl-mailbox-utils: Add dc_event_log_size field to output
> > >     payload of identify memory device command
> > >   hw/cxl/cxl-mailbox-utils: Add dynamic capacity region representativ=
e
> > >     and mailbox command support
> > >   include/hw/cxl/cxl_device: Rename mem_size as static_mem_size for
> > >     type3 memory devices
> > >   hw/mem/cxl_type3: Add support to create DC regions to type3 memory
> > >     devices
> > >   hw/mem/cxl_type3: Add host backend and address space handling for D=
C
> > >     regions
> > >   hw/mem/cxl_type3: Add DC extent list representative and get DC exte=
nt
> > >     list mailbox support
> > >   hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/relea=
se
> > >     dynamic capacity response
> > >   hw/cxl/events: Add qmp interfaces to add/release dynamic capacity
> > >     extents
> > >   hw/mem/cxl_type3: Add dpa range validation for accesses to dc regio=
ns
> > >=20
> > >  hw/cxl/cxl-mailbox-utils.c  | 421 +++++++++++++++++++++++++++-
> > >  hw/mem/cxl_type3.c          | 539 +++++++++++++++++++++++++++++++++-=
--
> > >  hw/mem/cxl_type3_stubs.c    |   6 +
> > >  include/hw/cxl/cxl_device.h |  49 +++-
> > >  include/hw/cxl/cxl_events.h |  16 ++
> > >  qapi/cxl.json               |  49 ++++
> > >  6 files changed, 1034 insertions(+), 46 deletions(-)
> > >=20
> > > --=20
> > > 2.39.2
> > >  =20
> >=20
> >=20
> >=20
>=20
> =
