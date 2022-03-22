Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52757C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 19:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbiCVTi0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 15:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiCVTiY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 15:38:24 -0400
X-Greylist: delayed 511 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Mar 2022 12:36:56 PDT
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95EDE8A337
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 12:36:56 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220322192819usoutp02a5845e6e28daf9086ef0bd16454fd919~eyp9tPuJH0137301373usoutp021;
        Tue, 22 Mar 2022 19:28:19 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220322192819usoutp02a5845e6e28daf9086ef0bd16454fd919~eyp9tPuJH0137301373usoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647977299;
        bh=AAdEzoNu3j3z5Oy5qIKOYuzDbpWR7WTLJcKt91tTNtI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=aVLomMCys5AMQfUZ8/ZWTTLn9J9r8dml+AQ4r/07skRcvEkp7N92F17vR3bxAee4f
         JE4Kxwl5mYsFxdQWIdBqfq3cUTMlwEaUmLJ2wIZjUV97Wkqdk2LBTBhBAHmq8Dp+DD
         ifObTYaxFJK19J/cHsCydUfifBHJ88LOElixomCo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220322192819uscas1p2bbe5f1a7aecfaaa14fa2837a86b1c499~eyp9Zq2Va1907219072uscas1p2m;
        Tue, 22 Mar 2022 19:28:19 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 55.F4.09642.3532A326; Tue,
        22 Mar 2022 15:28:19 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220322192819uscas1p295d53f4302435e98c58de1226fb2a1db~eyp9FZlkz0319403194uscas1p2T;
        Tue, 22 Mar 2022 19:28:19 +0000 (GMT)
X-AuditID: cbfec36f-c15ff700000025aa-00-623a23530934
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id E3.A8.09665.2532A326; Tue,
        22 Mar 2022 15:28:18 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Tue, 22 Mar 2022 12:28:18 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Tue, 22 Mar 2022 12:28:18 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 1/5] cxl/mbox: Move mbox_mutex usage comment
Thread-Topic: [PATCH 1/5] cxl/mbox: Move mbox_mutex usage comment
Thread-Index: AQHYPiL7VtLXqLwBxkOqjGs0XVNNLw==
Date:   Tue, 22 Mar 2022 19:28:18 +0000
Message-ID: <20220322192803.GA197988@bgt-140510-bm01>
In-Reply-To: <20220317234049.69323-2-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <41F1F1FE76D8964EBA597EB623B1AEB2@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrMKsWRmVeSWpSXmKPExsWy7djXc7rBylZJBheaxSzuPr7AZtH1rJ/Z
        YvrUC4wWq2+uYbTY//Q5i8X5WadYLG5NOMbkwO6xeM9LJo+ps+s9Pm+SC2CO4rJJSc3JLEst
        0rdL4Mp49WYyU8Evzop1My6xNzD+Yu9i5OSQEDCR2Np0gK2LkYtDSGAlo8T9wwtYQRJCAq1M
        Et8/l8IUbbp1nBWiaC2jxIylE5khnI+MEn9+bGCEcA4AZfbtBZvLJmAg8fv4RmYQW0RAXWLe
        2ttgRcwC55gkOr+2gu0QFnCQuHellwWiyFHi0pdF7BC2nsSxXXcZQWwWAVWJV8cmANVzcPAK
        mEp0N7KBhDkFzCV29q8EsxkFxCS+n1rDBGIzC4hL3HoynwnibEGJRbP3MEPYYhL/dj1kg7AV
        Je5/f8kOUa8jsWD3JzYI207i2d6TrBC2tsSyha/BenmB5pyc+YQFoldS4uCKGywgv0gInOGQ
        mH+pH2qZi8TEC08ZIWxpielrLkMVrWKUmPKtjR3C2QwMol8XoDqsJf51XmOfwKgyC8nls5Bc
        NQvJVbOQXDULyVULGFlXMYqXFhfnpqcWG+WllusVJ+YWl+al6yXn525iBKaj0/8O5+9gvH7r
        o94hRiYOxkOMEhzMSiK8iz+YJwnxpiRWVqUW5ccXleakFh9ilOZgURLnXZa5IVFIID2xJDU7
        NbUgtQgmy8TBKdXAtHXhjZYj3NPDptmaJJQvfBiy3fyo+rJCPlunwO23uHS8n0oLf1iqvLDj
        xLr1R1YrTVsU+sh/W1TR/b9WqfcahSfIGYcvXfbPKolFy8lcR2jfBJvH09iN4nkm7/ipnX04
        cUGMWvLGSsaUyGzxIkmV0K7pLNd++Jw5raG65ZCbhZfKDR2u969qG9MEQnc4PI5dsunClN8P
        dyxbISP3Kb6qiqPwUE12WtV6jqhTr1nvW1dM/KcY3b6kdfMSUV/OqwnaN6a1T364h4UzzH3T
        FnW+N+5HJSr/V1yZb3ovR1T4V2qEZn/dHvO5Agflp82ZunftGTatPzMWnLitsjTydquVh/PM
        N5NEw7apzneWjFjXpsRSnJFoqMVcVJwIADyPhg22AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWS2cA0UTdI2SrJ4Mt/S4u7jy+wWXQ962e2
        mD71AqPF6ptrGC32P33OYnF+1ikWi1sTjjE5sHss3vOSyWPq7HqPz5vkApijuGxSUnMyy1KL
        9O0SuDJevZnMVPCLs2LdjEvsDYy/2LsYOTkkBEwkNt06ztrFyMUhJLCaUaJ163ImkISQwEdG
        iQ8/CyASBxgl5p77CtbBJmAg8fv4RmYQW0RAXWLe2tuMIEXMAmeYJD48ugxWJCzgIHHvSi8L
        RJGjxKUvi9ghbD2JY7vuMoLYLAKqEq+OTQBazcHBK2Aq0d3IBrE4WaJjyTywVk4Bc4md/SvB
        4owCYhLfT60BO45ZQFzi1pP5TBAfCEgs2XOeGcIWlXj5+B8rhK0ocf/7S3aIeh2JBbs/sUHY
        dhLP9p5khbC1JZYtfA3WyysgKHFy5hMWiF5JiYMrbrBMYJSYhWTdLCSjZiEZNQvJqFlIRi1g
        ZF3FKF5aXJybXlFsnJdarlecmFtcmpeul5yfu4kRGMWn/x2O2cF479ZHvUOMTByMhxglOJiV
        RHgXfzBPEuJNSaysSi3Kjy8qzUktPsQozcGiJM7rETsxXkggPbEkNTs1tSC1CCbLxMEp1cDE
        bHvpZ8zm6dfaXmxYMCNrwxsFHuGF22SZF+WKf/tUl/Smk//WaYOsSyx/dypsv/7zx839ac+n
        fs1Kmu/B0bYuJrb21UnrBgfd6ZJbEryrgt41NwVItLTXnzv3+NsVbwPdo7G9qosK9u8UnmMS
        F8zMmLJqgyZbluW6SRvb2ENYy9kFP6xyPMbOXRRnz+q9w/hchRTX83Knp/6Ohwvm9qruXtQv
        XTSBKeaR4kPrY7VHl/7tKTpRecjz0k5XxgvLbpZ3nHkTEvZxlv0/nlmLD7c3fVUVXXPNVKti
        Y8KxtXMvLjaL5tFd1+JvfH1Bgbv9Yw/nE1UruBdyrZV/wM2ZP6vQM5RlRtPZT1cPHTp+SkxM
        iaU4I9FQi7moOBEAbkee21EDAAA=
X-CMS-MailID: 20220322192819uscas1p295d53f4302435e98c58de1226fb2a1db
CMS-TYPE: 301P
X-CMS-RootMailID: 20220322192819uscas1p295d53f4302435e98c58de1226fb2a1db
References: <20220317234049.69323-1-dave@stgolabs.net>
        <20220317234049.69323-2-dave@stgolabs.net>
        <CGME20220322192819uscas1p295d53f4302435e98c58de1226fb2a1db@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 04:40:45PM -0700, Davidlohr Bueso wrote:
> ... this is better served in the callback that actually
> grabs the lock.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/core/mbox.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index be61a0d8016b..778b04a0fb0a 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -136,7 +136,7 @@ static struct cxl_mem_command *cxl_mem_find_command(u=
16 opcode)
>   * @out: Caller allocated buffer for the output.
>   * @out_size: Expected size of output.
>   *
> - * Context: Any context. Will acquire and release mbox_mutex.
> + * Context: Any context.
>   * Return:
>   *  * %>=3D0	- Number of bytes returned in @out.
>   *  * %-E2BIG	- Payload is too large for hardware.
> @@ -165,6 +165,7 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u1=
6 opcode, void *in,
>  	if (out_size > cxlds->payload_size)
>  		return -E2BIG;
> =20
> +	/* acquire and releases the mbox_mutex */
>  	rc =3D cxlds->mbox_send(cxlds, &mbox_cmd);
>  	if (rc)
>  		return rc;
>=20
> --=20
> 2.26.2
>=20

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
