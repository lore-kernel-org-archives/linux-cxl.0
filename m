Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17474C433F5
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 21:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiCVVLn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 17:11:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbiCVVLn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 17:11:43 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CDE7663
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 14:10:14 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220322211013usoutp010977bb71ac94f1cc579a9651e45b1985~e0C8BCaaV1608616086usoutp01S;
        Tue, 22 Mar 2022 21:10:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220322211013usoutp010977bb71ac94f1cc579a9651e45b1985~e0C8BCaaV1608616086usoutp01S
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647983414;
        bh=2fLUvOVdm5xcn3ytlYcayfxxnh5/sus9E+wX91HrNb4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=fiUTLAUiOdfrCrGEFZkodP6AjuZ1ohjrWWH5WEVRZyCdduvrXQYr1qvVf143yvHlj
         nWXciHhScxtKcST+wU2E3Xp3ix3ltHV+rhZXNPlvc5ApgzUZ43V2sEt8OdhfiySMnA
         IdCcFRvnRdjwnQmgfLCKS/CRBMNAGbuUIMb2xJDA=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220322211013uscas1p2c5519fa03c8fb47c58ff7d12a11eb3df~e0C7x1Fid1053710537uscas1p2h;
        Tue, 22 Mar 2022 21:10:13 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id F6.85.09642.53B3A326; Tue,
        22 Mar 2022 17:10:13 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220322211013uscas1p2fe8d81180e00417559e3971ddf5bc2fc~e0C7XpbI22075020750uscas1p2h;
        Tue, 22 Mar 2022 21:10:13 +0000 (GMT)
X-AuditID: cbfec36f-bfdff700000025aa-b2-623a3b35e40f
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id EB.4A.09672.43B3A326; Tue,
        22 Mar 2022 17:10:13 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Tue, 22 Mar 2022 14:10:12 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Tue, 22 Mar 2022 14:10:12 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 5/5] cxl/mbox: Retry sending mbox command upon RETRY
 return_code
Thread-Topic: [PATCH 5/5] cxl/mbox: Retry sending mbox command upon RETRY
        return_code
Thread-Index: AQHYPjE4CeSEzxQasEGdCPz6IHnPew==
Date:   Tue, 22 Mar 2022 21:10:12 +0000
Message-ID: <20220322211012.GD198593@bgt-140510-bm01>
In-Reply-To: <20220317234049.69323-6-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <B03BDFD83AE67A4BB393E91770A2DDE9@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrEKsWRmVeSWpSXmKPExsWy7djXc7qm1lZJBttfaljcfXyBzaLrWT+z
        xfSpFxgtVt9cw2ix/+lzFovzs06xWNyacIzJgd1j8Z6XTB5TZ9d7fN4kF8AcxWWTkpqTWZZa
        pG+XwJVxbesbloJOgYrFd66xNDDe4+li5OSQEDCR+HVsBhuILSSwklHi++mCLkYuILuVSWLB
        h18sMEVnm+4wQRStZZR48yAAougjo8TWpg2MEM4BRokDn3+CdbAJGEj8Pr6RGcQWEVCXmLf2
        NlgRs8A5JonOr62sIAlhgTCJw4uOs0EUhUsc+/qPEcLWk5j2fzlYM4uAqsSKGRvB6nkFTCVO
        HdzKDmJzCphL9J6/DWYzCohJfD+1Buw8ZgFxiVtP5jNBnC0osWj2HmYIW0zi366HbBC2osT9
        7y/ZIep1JBbs/sQGYdtJPPn1BCquLbFs4WtmiL2CEidnPoEGhaTEwRU3WECekRA4wSHRMfs9
        0NEcQI6LxJtGYYgaaYm/d5cxQdSsYpSY8q2NHcLZzCgx49cFqOusJf51XmOfwKgyC8nhs5Ac
        NQvJUbOQHDULyVELGFlXMYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525iBCaj0/8O5+9gvH7r
        o94hRiYOxkOMEhzMSiK8iz+YJwnxpiRWVqUW5ccXleakFh9ilOZgURLnXZa5IVFIID2xJDU7
        NbUgtQgmy8TBKdXAJPK9ef32L4af0/V8LPYYcVZI+TU+u2HxX1BB98aJ5CQRi23zr81tiP74
        6NP7s7O8JjRO6hC4k1vF6rYkeu67a+envPg5ebXpk81rKzu3lx19xbl7vsUNfzMH4e+rtf7v
        cbfa/mCfTq//5e+vJbS0alP2Rk+ZsH9NxO3zwpNumT1ivruuwf5TYNhnptUvql0lV9iLFNgK
        hjHdfS+QkRP7IkCWd5Ll7339JQ+jBdm7subnbHvnJ8r0tJ9bd867LVMaX316LiMrfS3OY82H
        tz4W7H5mPI/3vJj399u05gPMZXZr7I48vnfpkvPeJ+bTZUWy3JfsvLrq0/UkLc17znKlMgXT
        NUvKWD+z/Nsvy92SH6zEUpyRaKjFXFScCABGFmHetQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRmVeSWpSXmKPExsWS2cA0SdfU2irJ4G43t8XdxxfYLLqe9TNb
        TJ96gdFi9c01jBb7nz5nsTg/6xSLxa0Jx5gc2D0W73nJ5DF1dr3H501yAcxRXDYpqTmZZalF
        +nYJXBnXtr5hKegUqFh85xpLA+M9ni5GTg4JAROJs013mLoYuTiEBFYzSrz5N4UNwvnIKPH8
        xHVWCOcAo8Sd6ydYQVrYBAwkfh/fyAxiiwioS8xbe5sRpIhZ4AyTxIdHl9lBEsICYRKHFx1n
        gygKl9h4qI8dwtaTmPZ/OVgzi4CqxIoZG8GG8gqYSpw6uBWsRkggWWLn5PuMIDangLlE7/nb
        YHFGATGJ76fWMIHYzALiEreezGeC+EFAYsme88wQtqjEy8f/WCFsRYn731+yQ9TrSCzY/YkN
        wraTePLrCVRcW2LZwtfMEDcISpyc+YQFoldS4uCKGywTGCVmIVk3C8moWUhGzUIyahaSUQsY
        WVcxipcWF+emVxQb5aWW6xUn5haX5qXrJefnbmIERvLpf4ejdzDevvVR7xAjEwfjIUYJDmYl
        Ed7FH8yThHhTEiurUovy44tKc1KLDzFKc7AoifO+jJoYLySQnliSmp2aWpBaBJNl4uCUamBK
        dbhuuDvfurlAN8fFdTJ70M7a4Hl5y3aWHFuWMyt6G89SvomWhiuXxvKcCGp69N5gn5Wq99v5
        voffrwkWmzKvZYf355RnT012dNSv4TSSdldM+yn7dU7xtvWJa7meLSs+o/H1WH2IzSzHdOtU
        z9maj76FSi+ZFBBn9SA081bHcd0ms+7w+b9+xtQHFr1w12RZJDfBIs1Bp/hxggd/a1nWypJK
        aU8zK9kdSf2+HPpzf3MvbVv1Temz9OnLz+Q+VHNdL7tj1Kb3epXVpHweT0bpLww9PE+tPf5a
        We+yidt8p+7nzKsXzX4UhSi9LLg4h1czY8Jqp8tXbAVaf2keL5usEBQTsyHYjvOBp8/BZCWW
        4oxEQy3mouJEAA/Gm4FTAwAA
X-CMS-MailID: 20220322211013uscas1p2fe8d81180e00417559e3971ddf5bc2fc
CMS-TYPE: 301P
X-CMS-RootMailID: 20220322211013uscas1p2fe8d81180e00417559e3971ddf5bc2fc
References: <20220317234049.69323-1-dave@stgolabs.net>
        <20220317234049.69323-6-dave@stgolabs.net>
        <CGME20220322211013uscas1p2fe8d81180e00417559e3971ddf5bc2fc@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 04:40:49PM -0700, Davidlohr Bueso wrote:
> As mentioned in CXL 2.0 specs: the hardware can set a Retry
> Required if the the command was not completed due to a
> temporary error. An optional single retry may resolve the
> issue. This is the only retry case as in general they are
> not recommended for commands that return an error.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index fa9e7043f158..567987052b68 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -160,20 +160,25 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, =
u16 opcode, void *in,

Can you update the documentation cxl_mbox_send_cmd that the function now=20
retries commands if the RC indicates it should be done?

>  		.size_out =3D out_size,
>  		.payload_out =3D out,
>  	};
> -	int rc;
> +	int rc, retry =3D 1;
> =20
>  	if (out_size > cxlds->payload_size)
>  		return -E2BIG;
> =20
> -	/* acquire and releases the mbox_mutex */
> -	rc =3D cxlds->mbox_send(cxlds, &mbox_cmd);
> -	if (rc)
> -		return rc;
> +	do {
> +		/* acquire and releases the mbox_mutex */
> +		rc =3D cxlds->mbox_send(cxlds, &mbox_cmd);
> +		if (rc)
> +			return rc;
> =20
> -	if (mbox_cmd.return_code !=3D CXL_MBOX_CMD_RC_SUCCESS) {
> -		int err =3D cxl_mbox_cmd_rc2errno(&mbox_cmd);
> -		return -err;
> -	}
> +		if (mbox_cmd.return_code =3D=3D CXL_MBOX_CMD_RC_SUCCESS)
> +			break;
> +
> +		if (mbox_cmd.return_code !=3D CXL_MBOX_CMD_RC_RETRY || !retry) {
> +			int err =3D cxl_mbox_cmd_rc2errno(&mbox_cmd);
> +			return -err;
> +		}
> +	} while (retry--);
> =20
>  	/*
>  	 * Variable sized commands can't be validated and so it's up to the
>=20
> --=20
> 2.26.2
>

Other than the doc change for the cxl_mbox_send_cmd function.
LGTM

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
