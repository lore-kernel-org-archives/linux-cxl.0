Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A99C64ED6
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjB1ENC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjB1ENB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:13:01 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750FD3C13
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:12:55 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041254usoutp012c2a03e5bc3cea0f36391534307a3eb2~H4bnrHpGA1359613596usoutp01w;
        Tue, 28 Feb 2023 04:12:54 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230228041254usoutp012c2a03e5bc3cea0f36391534307a3eb2~H4bnrHpGA1359613596usoutp01w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557574;
        bh=w3Zht0KtIMmvXTVJVeROsMKEsAUVrgRuNwWHqsItE9Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=YBcLzO2nOn9XmHE3snNest9Fql+4eFDkXy8NcNcYErkFJg5Tlifp7AWe/fylcSRoF
         0DH6lNxsqKJjuvxAWFymte6iKdw9+s6I5fWCu+NOirIsTUcFpFkIvPc6fVmd58/K69
         J1GkqaryTPAFytlg005CgUvZ6RMLCdog51fidNhY=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041253uscas1p290ef25317da2cb7e23a5eece1efce856~H4bmpE5Zk3129231292uscas1p23;
        Tue, 28 Feb 2023 04:12:53 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id B6.DB.06976.54F7DF36; Mon,
        27 Feb 2023 23:12:53 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041253uscas1p229d8375093fdd4d2de21be8921e35e32~H4bmXMYFH3129631296uscas1p21;
        Tue, 28 Feb 2023 04:12:53 +0000 (GMT)
X-AuditID: cbfec36d-afdff70000011b40-e6-63fd7f45e6f7
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 05.B9.11378.54F7DF36; Mon,
        27 Feb 2023 23:12:53 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:12:52 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:12:52 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Gregory Price <gourry.memverge@gmail.com>,
        =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [PATCH v4 06/10] hw/i386/acpi: Drop duplicate _UID entry for
 CXL root bridge
Thread-Topic: [PATCH v4 06/10] hw/i386/acpi: Drop duplicate _UID entry for
        CXL root bridge
Thread-Index: AQHZSyrtVB+/OTsNb0moubI0flUVvQ==
Date:   Tue, 28 Feb 2023 04:12:52 +0000
Message-ID: <20230228041252.GF1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-7-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <079FBF10B0071C40962C09E6C827FC4F@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPKsWRmVeSWpSXmKPExsWy7djXc7qu9X+TDVYe0rRonryY0eLFn+dM
        FvufPmexWLXwGpvF+VmnWCwObzzDZPH/1ytWizUrhC2O9+5gceD02DnrLrtHy5G3rB6L97xk
        8ti0qpPN4861PWweT65tZvJ4v+8qm8fnTXIBHFFcNimpOZllqUX6dglcGatfnGMuOMRZ8Wnq
        WdYGxi3sXYwcHBICJhJH57t0MXJyCAmsZJTo+yfVxcgFZLcySSxaepUVJAFS833vIjaIxFpG
        iW9r7zJCOJ8YJZb+e8UO4SxjlNhw5gAjSAubgKLEvq7tbCC2iICRxLsbk8A6mAW+MElMvbuR
        BSQhLBAtcfhHGytEUYzExmtfmSBsPYmO1r9gNouAqsTdidPBbuUVMJO4OD0XJMwp4CDxbv0P
        dhCbUUBM4vupNWDlzALiEreezGeCOFtQYtHsPcwQtpjEv10P2SBsRYn731+yQ9TrSdyYOoUN
        ZDyzgJ3E7Fe6EGFtiWULX4O18gKNOTnzCQtEq6TEwRU3WEBekRBo55R4s+gINBhdJJpvQq2S
        lrh6fSozRDhZYtVHLohwjsT8JVugxlhLLPyznmkCo8osJEfPQnLQLISDZiE5aBaSgxYwsq5i
        FC8tLs5NTy02zEst1ytOzC0uzUvXS87P3cQITGOn/x3O3cG449ZHvUOMTByMhxglOJiVRHgX
        3v6TLMSbklhZlVqUH19UmpNafIhRmoNFSZzX0PZkspBAemJJanZqakFqEUyWiYNTqoFp5oUU
        /raQH38DN8genv+340D1HPdTsyQsraaskLt152jghI1Je455dU6eXeDeFVm+LF1DL2Or305N
        7yKR+LAMQ6E7T2qeSSc8WuV+N53tGR/f+q1p2n0/NOXiFb7N+/XSmH9Bv+oZ06fd+TOjpn/S
        /bsoRSWJr65qup6t3MNELjGrwqN3fMUueCy6nMN2IsfuyJLQfIGA0OM7H2luzMsL39D7v7P+
        QWXHbwbdyQ/2V+zQv7MvOvLBRH7JJxxPBc0XaWopLZt6NSMxvf3+p86szrOBlwu+McVZBkpZ
        LOTuXvpun/U9x/oj0nesMsRYJhbzx4Y+S982ebrDjS9NTfYLjvBc2hn/suFv+pJVTJFKLMUZ
        iYZazEXFiQAQjYKL0gMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWS2cA0Ude1/m+ywbLXQhbNkxczWrz485zJ
        Yv/T5ywWqxZeY7M4P+sUi8XhjWeYLP7/esVqsWaFsMXx3h0sDpweO2fdZfdoOfKW1WPxnpdM
        HptWdbJ53Lm2h83jybXNTB7v911l8/i8SS6AI4rLJiU1J7MstUjfLoErY/WLc8wFhzgrPk09
        y9rAuIW9i5GTQ0LAROL73kVsXYxcHEICqxkllj2ZxwrhfGKUePbhGxOEs4xR4ue/JWwgLWwC
        ihL7uraD2SICRhLvbkxiBCliFvjCJHHjw3cWkISwQLREV8t9ZoiiGIlz9zqZIGw9iY7Wv2A2
        i4CqxN2J04Hu4ODgFTCTuDg9FyQsJFAqcef3B1YQm1PAQeLd+h9gpzIKiEl8P7UGrJVZQFzi
        1pP5TBAvCEgs2XOeGcIWlXj5+B8rhK0ocf/7S3aIej2JG1OnsIGsYhawk5j9ShcirC2xbOFr
        sFZeAUGJkzOfsEC0SkocXHGDZQKjxCwk22YhmTQLYdIsJJNmIZm0gJF1FaN4aXFxbnpFsWFe
        arlecWJucWleul5yfu4mRmAiOP3vcOQOxqO3PuodYmTiYDzEKMHBrCTCu/D2n2Qh3pTEyqrU
        ovz4otKc1OJDjNIcLErivEKuE+OFBNITS1KzU1MLUotgskwcnFINTM3LXiV8mi/2sVfCW5VD
        5/7NoH2TrmTzyk0pF9D/feFP54X0dxPtp/2eH/j0rv3SlZUGEVu/dm81tki0K/zab+qju+NJ
        9LUFzEfmTC2xFvH1PBV74cn2uoq7z8wOHpL/wVq4ynVd9qQXc8pORXO+fO3dPPVgrfObn4+k
        s1Tbv7Mt5Cu9ZMjKsumIUNC/rkJjGZfZNpnH59zOu3ZE0j0h67qMUtCczWfY1jdp9oi/kqjI
        mF+2pyBruVPzLp2oX2llKYVP876+7P93/bDRti0rVzR+ZmX4uO7+7H/tk3Id85zfyly1SS25
        q2dSuHe+wNrJR+6bO6kVnX73I1BadAbDldO3HGztvF/UzZKfGxLUHa3EUpyRaKjFXFScCAC3
        g0oZcwMAAA==
X-CMS-MailID: 20230228041253uscas1p229d8375093fdd4d2de21be8921e35e32
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041253uscas1p229d8375093fdd4d2de21be8921e35e32
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-7-Jonathan.Cameron@huawei.com>
        <CGME20230228041253uscas1p229d8375093fdd4d2de21be8921e35e32@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:12PM +0000, Jonathan Cameron wrote:
> Noticed as this prevents iASL disasembling the DSDT table.
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  hw/i386/acpi-build.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
> index 145389aa58..4840d11799 100644
> --- a/hw/i386/acpi-build.c
> +++ b/hw/i386/acpi-build.c
> @@ -1514,7 +1514,6 @@ build_dsdt(GArray *table_data, BIOSLinker *linker,
>                  aml_append(pkg, aml_eisaid("PNP0A03"));
>                  aml_append(dev, aml_name_decl("_CID", pkg));
>                  aml_append(dev, aml_name_decl("_ADR", aml_int(0)));
> -                aml_append(dev, aml_name_decl("_UID", aml_int(bus_num)))=
;
>                  build_cxl_osc_method(dev);
>              } else if (pci_bus_is_express(bus)) {
>                  aml_append(dev, aml_name_decl("_HID", aml_eisaid("PNP0A0=
8")));
> --=20
> 2.37.2
>=20
> =
