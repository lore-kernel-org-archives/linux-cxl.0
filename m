Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15B17EB64DD
	for <linux-cxl@archiver.kernel.org>; Tue, 11 Jul 2023 22:49:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbjGKWtT (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 11 Jul 2023 18:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGKWtS (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 11 Jul 2023 18:49:18 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47BD0E60
        for <linux-cxl@vger.kernel.org>; Tue, 11 Jul 2023 15:49:16 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230711224913usoutp019f1d320a8baaa7bc3bb5406c42b94613~w8dQMP2BM2936829368usoutp01M;
        Tue, 11 Jul 2023 22:49:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230711224913usoutp019f1d320a8baaa7bc3bb5406c42b94613~w8dQMP2BM2936829368usoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1689115753;
        bh=sFweNCKhG7E54EIGPm6/RuXmlOxvRSiAKak1tVdYwak=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=F4T2SFYuea2iiAdCBcJZCZukBlrbbTWFrUoP8aFPROOEtrxPrzYtNwgJQCqpNfsiY
         fAsXAoMYP3W8jcuwPJ3eGMugYU2e4JMmjLf6xbK7hDIT1DX0IV1tUqRyqzbGVHbNaJ
         ti6brSaI1OxUTeIBNyWXvzh+7uwEswFPjmFO4VQg=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230711224913uscas1p196939264637d373605192a012213f2e5~w8dQFZeX-2786227862uscas1p1C;
        Tue, 11 Jul 2023 22:49:13 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 0C.21.42611.96CDDA46; Tue,
        11 Jul 2023 18:49:13 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230711224912uscas1p13a8ce52f80c2aeca704946df81a4ccd1~w8dP3cC9l1553015530uscas1p1A;
        Tue, 11 Jul 2023 22:49:12 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-62-64addc697c2e
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 7F.ED.64580.86CDDA46; Tue,
        11 Jul 2023 18:49:12 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 11 Jul 2023 15:49:12 -0700
Received: from SSI-EX3.ssi.samsung.com ([105.128.5.228]) by
        SSI-EX3.ssi.samsung.com ([105.128.5.228]) with mapi id 15.01.2375.024; Tue,
        11 Jul 2023 15:49:12 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Ben Widawsky" <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [PATCH] cxl: Update MAINTAINERS
Thread-Topic: [PATCH] cxl: Update MAINTAINERS
Thread-Index: AQHZtEkyvPCPUHdgmEK8Uhrv9G/+EK+1oJKA
Date:   Tue, 11 Jul 2023 22:49:11 +0000
Message-ID: <11d50b02-4936-40f2-9071-51d511ff6886@nmtadam.samsung>
In-Reply-To: <168911543699.1871721.9186039943252294173.stgit@dwillia2-xfh.jf.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <32AFE03532CAC4448F8E7264F1E56714@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0xSURzHO/de8EqxbkT6K62ps7YemNGL9a7VRluvlWVvpbiRieBAyvon
        M+zlH9lKnTyG5CQiH2lmqTiHGJQ9tGlpmJZlMyNbaeWW1RKvbfz3Oef3/Z7zOdshcV4paxqZ
        oEihVQqJPILNISpdP54JEl4XS6OvD7JFne+b2aKzVwuQKDe7GYluvSpCoroPvYTIZn7JFjXp
        GgmRJ8uFrSHF2oZ+lrjA3oeJy20X2eJs/WnxYPmMbay9nBVSWp5wnFbNXxXPOdpYWE0kf+Wm
        vmun01DF+EsokARqEXS8G2b5mEfdRPDyzI5LiDPCGRj8NP5k/Q99tHpZzKAYgb3AijGLAQTn
        P/3BmYUFweXKjgBfhU1Fw7C7DPcxn5oLVwyO0RBOVWFgu+MifIPJ1DzQOe0EExJAn6MMY1gI
        Z7IMo0xQM8GeeWekTJJcah10pSX5tgOpWKiympCPERUEQ41Fo3GcCgZPjwljtCfBdb0dZzgI
        /lZ3sxkOhzdDfQFMfh7k1wywGV4F34y5iOG5YDF7R7vckXMe5fUQTHcqOKzthO8tQPWQkP6k
        ZOyC9WD+U4IYDoHcopaxghKqz7WOZVLhhTdzTGI5mH+XYlkoUufnrfNz0vk56fycdH5O+Yhl
        Q8EatTpJRquFCvpElFqSpNYoZFGHlUnlaORPPf7rVN5HbZ5vUfUII1E9AhKP4HOTHTYpjyuV
        nDxFq5RxKo2cVtejEJKICOYuWPnoMI+SSVLoRJpOplX/pxgZOC0N2x6zv2srh5/ctLbZpnVn
        5LqyEqArnMo2yocXOTbyu58/DYvsFchd4gvpUypKr2WcvF0bY55oNW13r7HUrs8JTV3+dpwr
        snC+8bHWfF9aS9E7QnmHts6efis7NVPwilPzqz1Ou1RReqqjc/PdT93CpiO3NfEpfEH1Z+eW
        gT1Xau7NavDsVh7QfH5el2ifaYgexL6c8xbXmGQrjxW2/Yr17HpQtiGs1fag9+BifUDw249H
        8j4cL7FUTVpdEZbj7O98URRioRr039ONipaFiaYD+7xVbW1LhG69k27uP732zf597TtDY9zh
        +XOWbdp2Iy9WWCibOhQ4QWvAHwaF5xma6iojCPVRyYI5uEot+QdMed3LwgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHIsWRmVeSWpSXmKPExsWS2cA0STfjztoUg3tXjSzuPr7AZtE8eTGj
        xfSpFxgtVt9cw2ix/+lzFotVC6+xWZyfdYrF4taEY0wOHB4tR96yeize85LJY9OqTjaPqbPr
        PT5vkgtgjeKySUnNySxLLdK3S+DKOLV0F0vBB96KRzdSGxi3cHcxcnJICJhIvFjxmrWLkYtD
        SGA1o0TvxE3MEM4nRolrN3+xQTjLGCVm9x5jAmlhEzCQ+H18IzOILSKgLTFxzkGwDmaBnUwS
        qzYfYwFJCAvoSMw6vIcFokhX4uXBjUwQtpFE44Q5YDaLgKrEnu7NQM0cHLwCThL3GnIhlq1i
        lPjW0M4KUsMpEC6xc8V8RhCbUUBM4vupNWC9zALiEreezGeC+EFAYsme88wQtqjEy8f/WCFs
        RYn731+yQ9TrSCzY/YkNwraT+Dh3OiOErS2xbOFrsF5eAUGJkzOfsED0SkocXHGDZQKjxCwk
        62YhGTULyahZSEbNQjJqASPrKkbx0uLi3PSKYuO81HK94sTc4tK8dL3k/NxNjMAoP/3vcMwO
        xnu3PuodYmTiYDzEKMHBrCTCW3BwVYoQb0piZVVqUX58UWlOavEhRmkOFiVxXo/YifFCAumJ
        JanZqakFqUUwWSYOTqkGpsLtgZlvdC7WPTN0K277J8c56bvgRsNGiy8rWHP/hhTeFuCu71+d
        nx888/SrNytMmTsKtIOfvjpbMfvebpvWy6Z3P5eLx3J3SC31fle98upFF62o9O1vX086fvLO
        WqYTS2y4rq2e5HbIPF7uUODPxaWTVXPvSpwoNNju9yHMyOpr0aNZcx6LSX/dv/LzRL7P3rKM
        3m+sWA+cWl1gtPqniIbxtry+H1dfGnuEnGB5xRenFtvd2fa3gkmPbcuWupK4V9Yxy/snGfIU
        vv568u3URZOudFxaoq/bYFe8K+ptw04RgediE/P+b+vyvJCxqKZF+4IK41K/fQvXdhnNr3vg
        I7zy3v/bs0qzVhzqWGn5jFOJpTgj0VCLuag4EQAHdy2wYQMAAA==
X-CMS-MailID: 20230711224912uscas1p13a8ce52f80c2aeca704946df81a4ccd1
CMS-TYPE: 301P
X-CMS-RootMailID: 20230711224403uscas1p1b4b82b803ddd0cc47ec02ddf574aa604
References: <CGME20230711224403uscas1p1b4b82b803ddd0cc47ec02ddf574aa604@uscas1p1.samsung.com>
        <168911543699.1871721.9186039943252294173.stgit@dwillia2-xfh.jf.intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jul 11, 2023 at 03:43:57PM -0700, Dan Williams wrote:
> Ben, thank you for all the work to get the CXL subsystem off the ground
> and establishing QEMU as a place where hardware vendors can collaborate
> on the new advancements and mechanisms appearing in the CXL
> specification.
>=20

+1

> Jonathan, thank you for your continued review and collaboration, you have
> been a defacto CXL maintainer for a while now.
>

+1

> Davidlohr, thank you for getting the background command infrastructure
> off the ground and your leadership on and off the lists.

+1

>=20
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
> Cc: Ben Widawsky <bwidawsk@kernel.org>
> Cc: Adam Manzanares <a.manzanares@samsung.com>
> Cc: Alison Schofield <alison.schofield@intel.com>
> Cc: Vishal Verma <vishal.l.verma@intel.com>
> Cc: Ira Weiny <ira.weiny@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  MAINTAINERS |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..eba395274018 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5140,10 +5140,11 @@ S:	Maintained
>  F:	include/linux/compiler_attributes.h
> =20
>  COMPUTE EXPRESS LINK (CXL)
> +M:	Davidlohr Bueso <dave@stgolabs.net>
> +M:	Jonathan Cameron <jonathan.cameron@huawei.com>
>  M:	Alison Schofield <alison.schofield@intel.com>
>  M:	Vishal Verma <vishal.l.verma@intel.com>
>  M:	Ira Weiny <ira.weiny@intel.com>
> -M:	Ben Widawsky <bwidawsk@kernel.org>
>  M:	Dan Williams <dan.j.williams@intel.com>
>  L:	linux-cxl@vger.kernel.org
>  S:	Maintained
>


Looks good.

Reviewed-by: Adam Manzanares <a.manzanares@samsung.com>=
