Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4939C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 20:58:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbiCVU7x (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234852AbiCVU5o (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 16:57:44 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CC1DBC3C
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 13:56:14 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20220322205613usoutp0174cbf89fcb87b671a2216fcb2d07d6fc~ez2tTUmLu0479804798usoutp01B;
        Tue, 22 Mar 2022 20:56:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20220322205613usoutp0174cbf89fcb87b671a2216fcb2d07d6fc~ez2tTUmLu0479804798usoutp01B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647982573;
        bh=3k/90JxAGtBKGB5sG5DrzHqzah7cfLsOx5PHQ5Pahuk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=dR1EUkMTLSVjxwjrzDxByk5nPicI5AnTLdluA2PZ1EMGUzx1FQTgQY8n0amSoFoKC
         UMhO1xIvKMCv8Eo0SPJjXMALqYGhfy7rTi/e00MMSGI+idX5+DSxRS2X6ZN3SS0jt8
         US1LN9Q7xYfd7GWuQvBoZT65OQNFWi8K6z2AAtpU=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220322205613uscas1p1e2ead63cac99d7d0aded287df5c2d7b9~ez2s8Fbnt2806128061uscas1p1z;
        Tue, 22 Mar 2022 20:56:13 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id CF.43.09760.CE73A326; Tue,
        22 Mar 2022 16:56:13 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220322205612uscas1p17d7f32b9b23dbadc106ae0daf69477f9~ez2skKThu2011220112uscas1p14;
        Tue, 22 Mar 2022 20:56:12 +0000 (GMT)
X-AuditID: cbfec36d-503ff70000002620-8b-623a37ec8e5b
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 90.1A.09672.CE73A326; Tue,
        22 Mar 2022 16:56:12 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Tue, 22 Mar 2022 13:56:11 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Tue, 22 Mar 2022 13:56:11 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 3/5] cxl/mbox: Improve handling of mbox_cmd return codes
Thread-Topic: [PATCH 3/5] cxl/mbox: Improve handling of mbox_cmd return
        codes
Thread-Index: AQHYPi9D4ceNxUWrl0OhKtLUrv93Ig==
Date:   Tue, 22 Mar 2022 20:56:11 +0000
Message-ID: <20220322205611.GB198593@bgt-140510-bm01>
In-Reply-To: <20220317234049.69323-4-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <7C87C55488B6224E8A3B977515335DAD@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djXc7pvza2SDCZsYbK4+/gCm0XXs35m
        i+lTLzBarL65htFi/9PnLBbnZ51isbg14RiTA7vH4j0vmTymzq73+LxJLoA5issmJTUnsyy1
        SN8ugSvj5OszzAUX9CsezNvL2sD4R62LkZNDQsBEYn1DP3MXIxeHkMBKRolHNxYwQTitTBIr
        309kg6la9qeLBSKxllFi/8LHYAkhgY+MEnP+ekIkDjBKLF33mRUkwSZgIPH7+EZmEFtEQF1i
        3trbjCBFzALnmCQ6v7aCFQkL+Egs/PmYBaLIX+L8n5dQDXoSa893g9ksAqoSz3oOMYLYvAKm
        En27/gHdx8HBKWAucak1HSTMKCAm8f3UGiYQm1lAXOLWk/lMEFcLSiyavYcZwhaT+LfrIdQ3
        ihL3v79kh6jXkViw+xMbhG0ncWzZX6g52hLLFr5mhlgrKHFy5hMWiF5JiYMrboBDQkLgBIfE
        9IOLoYa6SKzvOQpVJC3x9+4yJoiiVYwSU761sUM4mxklZvy6AHWetcS/zmvsExhVZiG5fBaS
        q2YhuWoWkqtmIblqASPrKkbx0uLi3PTUYsO81HK94sTc4tK8dL3k/NxNjMB0dPrf4dwdjDtu
        fdQ7xMjEwXiIUYKDWUmEd/EH8yQh3pTEyqrUovz4otKc1OJDjNIcLErivMsyNyQKCaQnlqRm
        p6YWpBbBZJk4OKUamCa8/JlrdE/smLVJ1TPzpXoGewM7E3tObrBieXrKy9N7StL+6fcidgVz
        Btmwxz7vmn5pxXfDVzazt3WrTq7SWJG8mSn76cuDj59xTg33FF8+7/fpNO0N/XZpae++nHJe
        c0zT4k73b0bhUyzKgs4x99KW8L5b87Z99/3s2XP0/6bOTYy+cS+xRKZp44sF7oIdmls3S1Rf
        azgTVCp4aeVKO5YDWc5lxjeMFK+0GqZf3/4tXWn25a283pu6dY7bs8uH6Su3R39R2hV88aDg
        8pNFPKvt3v2vbCpgNDnj8P2zbZEc6/GkY6JB8x/XFNz8co9tTtvJXS12FycECE9eVR/2hXNq
        9r2PCkUVupfcJVaJ2ymxFGckGmoxFxUnAgDcyY73tgMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrLIsWRmVeSWpSXmKPExsWS2cA0UfeNuVWSQfM2VYu7jy+wWXQ962e2
        mD71AqPF6ptrGC32P33OYnF+1ikWi1sTjjE5sHss3vOSyWPq7HqPz5vkApijuGxSUnMyy1KL
        9O0SuDJOvj7DXHBBv+LBvL2sDYx/1LoYOTkkBEwklv3pYgGxhQRWM0qs6y2CsD8ySrxtNu1i
        5AKyDzBKnN59kR0kwSZgIPH7+EZmEFtEQF1i3trbjCBFzAJnmCQ+PLoMViQs4COx8OdjFogi
        X4n2tb+gbD2Jtee7wZpZBFQlnvUcYgSxeQVMJfp2/WOC2JwscfrILKA4BwengLnEpdZ0kDCj
        gJjE91NrwEqYBcQlbj2ZzwTxgIDEkj3nmSFsUYmXj/+xQtiKEve/v2SHqNeRWLD7ExuEbSdx
        bNlfqDnaEssWvmaGOEFQ4uTMJywQvZISB1fcYJnAKDELybpZSEbNQjJqFpJRs5CMWsDIuopR
        vLS4ODe9otgoL7Vcrzgxt7g0L10vOT93EyMwhk//Oxy9g/H2rY96hxiZOBgPMUpwMCuJ8C7+
        YJ4kxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdl1MR4IYH0xJLU7NTUgtQimCwTB6dUA5ME66of
        btMui8hs+C70tOn9pzvhQapl1TnbFG4JsG+a1bh4fVFV4bqTVyqDZ/ZPfz0nrVJ/3x4xxS2z
        bA/JlGyurjQy/JS/Ye61a5n+uyWLbNikr5lOZI07KZPwwoiXy2EFi6zinJPWXy5bqM2dpFwh
        eiJlwh2HhTzBh5b/2vusrS93x8cdK3VVjqvZLk5+y39yfb7wweRAD92Mg8sr/L4FTjz5MUsj
        Z7KNL4NaoJxN0iH/EukvS4LOXDldE6b8+0+L0NHIvIzTYbnVXncb/+2MjhZVEC1cUdpe8Xeb
        tP/aAO+fc78l/v2iJ7vzRNh61XYXJs+HmhdFco8aSt9cG9nmrn94yq6NMduZjxu/XqTEUpyR
        aKjFXFScCACtDOtjUAMAAA==
X-CMS-MailID: 20220322205612uscas1p17d7f32b9b23dbadc106ae0daf69477f9
CMS-TYPE: 301P
X-CMS-RootMailID: 20220322205612uscas1p17d7f32b9b23dbadc106ae0daf69477f9
References: <20220317234049.69323-1-dave@stgolabs.net>
        <20220317234049.69323-4-dave@stgolabs.net>
        <CGME20220322205612uscas1p17d7f32b9b23dbadc106ae0daf69477f9@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 04:40:47PM -0700, Davidlohr Bueso wrote:
> Upon a completed command the caller is still expected to check
> the actual return_code register for to ensure it succeed. This

Is  MB Status register =3D=3D return_code register here. s/for to/to
> adds, per the spec, the potential command return codes. It maps
> the hardware return code with the kernel's errno style, and by
> default continues to use -ENXIO (Command completed, but device
> reported an error).
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c |  2 +-
>  drivers/cxl/cxlmem.h    | 90 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/pci.c       |  2 +-
>  3 files changed, 91 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 778b04a0fb0a..d4d4a16820b7 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -171,7 +171,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u1=
6 opcode, void *in,
>  		return rc;
> =20
>  	/* TODO: Map return code to proper kernel style errno */
> -	if (mbox_cmd.return_code !=3D CXL_MBOX_SUCCESS)
> +	if (mbox_cmd.return_code !=3D CXL_MBOX_CMD_RC_SUCCESS)
>  		return -ENXIO;
> =20
>  	/*
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 5d33ce24fe09..268597d1ff33 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -85,9 +85,97 @@ struct cxl_mbox_cmd {
>  	size_t size_in;
>  	size_t size_out;
>  	u16 return_code;
> -#define CXL_MBOX_SUCCESS 0
>  };
> =20
> +/*
> + * Per CXL 2.0 Section 8.2.8.4.5.1
> + */
> +enum {
> +	CXL_MBOX_CMD_RC_SUCCESS =3D 0,
> +	CXL_MBOX_CMD_RC_BACKGROUND,
> +	CXL_MBOX_CMD_RC_INVINPUT,
> +	CXL_MBOX_CMD_RC_UNSUPPORTED,
> +	CXL_MBOX_CMD_RC_INTERNAL,
> +	CXL_MBOX_CMD_RC_RETRY,
> +	CXL_MBOX_CMD_RC_BUSY,
> +	CXL_MBOX_CMD_RC_MEDIADISABLED,
> +	CXL_MBOX_CMD_RC_FWINPROGRESS,
> +	CXL_MBOX_CMD_RC_FWOOO,
> +	CXL_MBOX_CMD_RC_FWAUTH,
> +	CXL_MBOX_CMD_RC_INVSLOT,

Should we keep the FW prefix for INVSLOT, since this is still related to a=
=20
FW operation?

> +	CXL_MBOX_CMD_RC_FWROLLBACK,
> +	CXL_MBOX_CMD_RC_FWRESET,
> +	CXL_MBOX_CMD_RC_INVHANDLE,
> +	CXL_MBOX_CMD_RC_INVPA,
> +	CXL_MBOX_CMD_RC_INJPOISON,

We should indicate that we hit the poison limit, something like the=20
following POISONLMT

> +	CXL_MBOX_CMD_RC_MEDIAFAILURE,
> +	CXL_MBOX_CMD_RC_ABORT,
> +	CXL_MBOX_CMD_RC_INVSECURITY,
> +	CXL_MBOX_CMD_RC_PASSPHRASE,
> +	CXL_MBOX_CMD_RC_MBOXUNSUPPORTED,
> +	CXL_MBOX_CMD_RC_INVPAYLOAD,

Might as well be more descriptive here PAYLOADLEN, looking at this more now
maybe we drop all of the INV prefixes since most of the return codes are er=
ror
codes.=20

> +};
> +
> +#define CXL_CMD_RC(_value, errno, str)		\
> +	[CXL_MBOX_CMD_RC_##_value] =3D {		\
> +		.err =3D errno,			\
> +		.desc =3D	str,			\
> +	}
> +
> +/*
> + * mbox cmd hardware return_code handling
> + */
> +struct cxl_mbox_cmd_rc {
> +	int err; /* proper kernel style errno */
> +	const char *desc;
> +};
> +
> +static const struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] =3D {
> +	CXL_CMD_RC(SUCCESS, 0, NULL),
> +	CXL_CMD_RC(BACKGROUND, ENXIO, "background cmd started successfully"),
> +	/* errors here on out */
> +	CXL_CMD_RC(INVINPUT, ENXIO, "cmd input was invalid"),
> +	CXL_CMD_RC(UNSUPPORTED, ENXIO, "cmd is not supported"),
> +	CXL_CMD_RC(INTERNAL, ENXIO, "internal device error"),
> +	CXL_CMD_RC(RETRY, ENXIO, "temporary error, retry once"),
> +	CXL_CMD_RC(BUSY, ENXIO, "ongoing background operation"),
> +	CXL_CMD_RC(MEDIADISABLED, ENXIO, "media access is disabled"),
> +	CXL_CMD_RC(FWINPROGRESS, ENXIO,
> +			"only one FW package can be transferred at a time"),
> +	CXL_CMD_RC(FWOOO, ENXIO,
> +			"FW package content was transferred out of order"),
> +	CXL_CMD_RC(FWAUTH, ENXIO, "FW package authentication failed"),
> +	CXL_CMD_RC(INVSLOT, ENXIO,
> +			"FW slot specified is not supported for requested op"),
> +	CXL_CMD_RC(FWROLLBACK, ENXIO,
> +			"rolled back to the previous active FW"),
> +	CXL_CMD_RC(FWRESET, ENXIO, "FW failed to activate, needs cold reset"),
> +	CXL_CMD_RC(INVHANDLE, ENXIO,
> +			"one or more Event Record Handles were invalid"),
> +	CXL_CMD_RC(INVPA, ENXIO, "physical address specified is invalid"),
> +	CXL_CMD_RC(INJPOISON, ENXIO,
> +			"allowed poison injection has been reached"),

injection limit

> +	CXL_CMD_RC(MEDIAFAILURE, ENXIO, "permanent issue with the media"),
> +	CXL_CMD_RC(ABORT, ENXIO, "background cmd was aborted by device"),
> +	CXL_CMD_RC(INVSECURITY, ENXIO,
> +		   "not valid in the current security state"),
> +	CXL_CMD_RC(PASSPHRASE, ENXIO,
> +			"passphrase doesn't match current passphrase"),

current set passphrase

> +	CXL_CMD_RC(MBOXUNSUPPORTED, ENXIO,
> +			"not supported on the mailbox it was issued on"),
> +	CXL_CMD_RC(INVPAYLOAD, ENXIO, "invalid payload length"),
> +};
> +
> +static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_=
cmd)
> +{
> +	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
> +}
> +
> +static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
> +{
> +	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
> +}
> +
>  /*
>   * CXL 2.0 - Memory capacity multiplier
>   * See Section 8.2.9.5
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index c77e06aff8dc..0c36d111232b 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -177,7 +177,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_sta=
te *cxlds,
>  	mbox_cmd->return_code =3D
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> =20
> -	if (mbox_cmd->return_code !=3D CXL_MBOX_SUCCESS) {
> +	if (mbox_cmd->return_code !=3D CXL_MBOX_CMD_RC_SUCCESS) {
>  		dev_dbg(dev, "Mailbox operation had an error\n");
>  		return 0;  /* completed but caller must check return_code */
>  	}
>=20
> --=20
> 2.26.2
>

Other than the minor nits.=20
Looks good.

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
