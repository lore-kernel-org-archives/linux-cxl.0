Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E22C5C433EF
	for <linux-cxl@archiver.kernel.org>; Tue, 22 Mar 2022 20:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233776AbiCVUb7 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 22 Mar 2022 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiCVUb6 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 22 Mar 2022 16:31:58 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5976CDDA
        for <linux-cxl@vger.kernel.org>; Tue, 22 Mar 2022 13:30:30 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20220322203028usoutp02abf66cf96ebcb63473130db15a0b1f5b~ezgOP8QFD2027520275usoutp02A;
        Tue, 22 Mar 2022 20:30:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20220322203028usoutp02abf66cf96ebcb63473130db15a0b1f5b~ezgOP8QFD2027520275usoutp02A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647981028;
        bh=BSKUA6nk7UMcPltgxvTGRVs7e+LMWJp2UDzGo8h2wNQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=kFFacWFo6K5xGphqFjWx/jGK6soqVuf3QliySCwt5GHD5ndHl9n92uxhva7WOO5Ls
         zR/86J7D8vmSdwLggDba3hUGK4nMVaMoptg8vF7vmA+xEKDvDngleby9BpleaBLvxJ
         4UVwl/1krGEwCU+eTJnSj6cCbVRbsYNVHf1YbLdM=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20220322203028uscas1p229566cbf2707411c65eefc210755e8a8~ezgOCQjec0596605966uscas1p2M;
        Tue, 22 Mar 2022 20:30:28 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id CC.7F.09760.4E13A326; Tue,
        22 Mar 2022 16:30:28 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20220322203027uscas1p1b141b932ca4659a7b2cee1faf9dddf50~ezgNufvIV1492514925uscas1p1B;
        Tue, 22 Mar 2022 20:30:27 +0000 (GMT)
X-AuditID: cbfec36d-503ff70000002620-1d-623a31e465c2
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 60.79.09702.3E13A326; Tue,
        22 Mar 2022 16:30:27 -0400 (EDT)
Received: from SSI-EX3.ssi.samsung.com (105.128.2.228) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2242.4; Tue, 22 Mar 2022 13:30:26 -0700
Received: from SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36]) by
        SSI-EX3.ssi.samsung.com ([fe80::8d80:5816:c578:8c36%3]) with mapi id
        15.01.2242.008; Tue, 22 Mar 2022 13:30:26 -0700
From:   Adam Manzanares <a.manzanares@samsung.com>
To:     Davidlohr Bueso <dave@stgolabs.net>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "ben.widawsky@intel.com" <ben.widawsky@intel.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>
Subject: Re: [PATCH 2/5] cxl/pci: Use CXL_MBOX_SUCCESS to check against
 mbox_cmd return code
Thread-Topic: [PATCH 2/5] cxl/pci: Use CXL_MBOX_SUCCESS to check against
        mbox_cmd return code
Thread-Index: AQHYPiuqoyMhaPwbYkCI6p2onMztYA==
Date:   Tue, 22 Mar 2022 20:30:26 +0000
Message-ID: <20220322203020.GA198593@bgt-140510-bm01>
In-Reply-To: <20220317234049.69323-3-dave@stgolabs.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C9DCEB15D4E169439F5E9EF89B377889@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsWy7djXc7pPDK2SDJY/Yba4+/gCm0XXs35m
        i+lTLzBarL65htFi/9PnLBbnZ51isbg14RiTA7vH4j0vmTymzq73+LxJLoA5issmJTUnsyy1
        SN8ugStjwtVHLAUNHBU9T5ezNjAeYOti5OSQEDCR6L59nL2LkYtDSGAlo8T8nh9MEE4rk8TX
        D3+YYar+35vABpFYyyhxsvUSI4TzkVFi1+NPUC0HGCWm3uxnAWlhEzCQ+H18I1i7iIC6xLy1
        t8E6mAXOMUl0fm1lBUkIC8RJzHm5jA2iKF5iyt5DjBC2nsTHhjNgg1gEVCVWPNsDVs8rYCox
        ZeU3MJtTwFzi69O/YL2MAmIS30+tYQKxmQXEJW49mc8EcbegxKLZe6B+EJP4t+sh1NeKEve/
        v2SHqNeRWLD7ExuEbSex+sQmFghbW2LZwtfMEHsFJU7OfMIC0SspcXDFDRaQZyQETnBITD3w
        D8jhAHJcJB6dj4OokZa4en0qM0TNKkaJKd/a2CGczYwSM35dgLrOWuJf5zX2CYwqs5AcPgvJ
        UbOQHDULyVGzkBy1gJF1FaN4aXFxbnpqsWFearlecWJucWleul5yfu4mRmBCOv3vcO4Oxh23
        PuodYmTiYDzEKMHBrCTCu/iDeZIQb0piZVVqUX58UWlOavEhRmkOFiVx3mWZGxKFBNITS1Kz
        U1MLUotgskwcnFINTMvrMgNWrp/81C0saWvhlmvNclP6b72Xs2ee+eq23fV655fByVcuRDWc
        URCNuer8J7ya1aSjT9GtosR1c9yjLapfztl+nC3TGXoq03aewsQF7Z8nS79hk7jb7zvdZrPj
        jEWu/tKGB8sDuLi4ZsloCRyWt9muvy47k3FJ7pHnvo3ix3rXmC8ODgxdP41/NXfg2h9T2Y9/
        s44uuWH6kb34ye6FG5cH/2aSmCd40eHM/Nl1dz6nFaQ98fp6vqtfVuphimnsmbb6lVeC73mX
        3jPo3J2U+XZpr6Bj4tPdp4/JLrbefEaH42HemWfrxJ9vm9Mu03tCfGJXuvfOXzIHJt12Dwvf
        uuCDv1lM6MFdghImP5RYijMSDbWYi4oTAU6h27G3AwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrPIsWRmVeSWpSXmKPExsWS2cA0UfexoVWSwawTShZ3H19gs+h61s9s
        MX3qBUaL1TfXMFrsf/qcxeL8rFMsFrcmHGNyYPdYvOclk8fU2fUenzfJBTBHcdmkpOZklqUW
        6dslcGVMuPqIpaCBo6Ln6XLWBsYDbF2MnBwSAiYS/+9NALK5OIQEVjNK7Ph8hxHC+cgocWre
        ThYI5wCjxKEpJ5hBWtgEDCR+H98IZosIqEvMW3sbrINZ4AyTxIdHl9lBEsICcRJzXi5jgyiK
        l7jw7ACUrSfxseEMC4jNIqAqseLZHlYQm1fAVGLKym9ANgfQtmSJ5xu4QMKcAuYSX5/+BWtl
        FBCT+H5qDROIzSwgLnHryXwmiBcEJJbsOc8MYYtKvHz8jxXCVpS4//0lO0S9jsSC3Z/YIGw7
        idUnNrFA2NoSyxa+ZoY4QVDi5MwnLBC9khIHV9xgmcAoMQvJullIRs1CMmoWklGzkIxawMi6
        ilG8tLg4N72i2DAvtVyvODG3uDQvXS85P3cTIzCOT/87HLmD8eitj3qHGJk4GA8xSnAwK4nw
        Lv5gniTEm5JYWZValB9fVJqTWnyIUZqDRUmcV8h1YryQQHpiSWp2ampBahFMlomDU6qBKetA
        6IyvnqdjPJbJJjLMOruQS9NVvT2O8+XUWMcN+6vSars12/T2B8fUiJnK2kwoZkstft70PTXs
        Z8qJ9GcR2heWKUneufOxo10rcd/e0oeMM7d4LnpokrDv60IGi29nOG+9PLx/1Zaar0XH/fzM
        t4rvU23x40vf/uCJ7i5Zl2/yWZL3bJ4uqio9tvP9hXkJORP7bpn+f3DRacOdTwtVGpv9xC4E
        /LkqK8F9e4tcefnDWd5vk3t2n4l5uXzK2oauNSK3P/+VbFsnwG2upVypu2ZCg8rr2geFSpXr
        +xk521km/A+/s+PWb56Thccfpnx4vHGfxanJDluOtkfIGH3x+2XZH9yiab9J4cEOHxFrRSWW
        4oxEQy3mouJEAAaU67JSAwAA
X-CMS-MailID: 20220322203027uscas1p1b141b932ca4659a7b2cee1faf9dddf50
CMS-TYPE: 301P
X-CMS-RootMailID: 20220322203027uscas1p1b141b932ca4659a7b2cee1faf9dddf50
References: <20220317234049.69323-1-dave@stgolabs.net>
        <20220317234049.69323-3-dave@stgolabs.net>
        <CGME20220322203027uscas1p1b141b932ca4659a7b2cee1faf9dddf50@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Mar 17, 2022 at 04:40:46PM -0700, Davidlohr Bueso wrote:
> Also mention the need for the caller to check against any
> errors from the hardware in return_code.
>=20
> Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
> ---
>  drivers/cxl/pci.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 8a7267d116b7..c77e06aff8dc 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -177,9 +177,9 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_sta=
te *cxlds,
>  	mbox_cmd->return_code =3D
>  		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
> =20
> -	if (mbox_cmd->return_code !=3D 0) {
> +	if (mbox_cmd->return_code !=3D CXL_MBOX_SUCCESS) {
>  		dev_dbg(dev, "Mailbox operation had an error\n");
> -		return 0;
> +		return 0;  /* completed but caller must check return_code */
>  	}
> =20
>  	/* #7 */
>=20
> --=20
> 2.26.2
>=20

Reviewed by: Adam Manzanares <a.manzanares@samsung.com>=
