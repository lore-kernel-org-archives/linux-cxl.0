Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5938C64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 04:13:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229492AbjB1ENR (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 27 Feb 2023 23:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjB1ENQ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 27 Feb 2023 23:13:16 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DF7B776
        for <linux-cxl@vger.kernel.org>; Mon, 27 Feb 2023 20:13:14 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230228041313usoutp01f70b674c03f8183b2a5d14f6e9c4b57b~H4b5VBMxz1359613596usoutp01x;
        Tue, 28 Feb 2023 04:13:13 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230228041313usoutp01f70b674c03f8183b2a5d14f6e9c4b57b~H4b5VBMxz1359613596usoutp01x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677557593;
        bh=X9uQl9JqiSBl4TNCis9iJ44KEpcH13nq3bZ9fYvWn24=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=UXwIlH3qscfCzleElSLunIN18pxptDMBvRM6rYeYkPY8xtHs81490ZZzZaPDMD6WK
         kqOXAmuHG6TLZ6qI3UKVZP0e+hRVAQ/vX4hPkMJWkPGpYBata46j6rVzXQ2gKiYr+n
         A6nWwHtJV23k6Z9jlwAD57Hy1YV2SWX8XnNkTg38=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230228041312uscas1p285b54e92fef1eda5b77b59c01f5adf21~H4b4iAx0J3129631296uscas1p2A;
        Tue, 28 Feb 2023 04:13:12 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id A9.DB.06976.85F7DF36; Mon,
        27 Feb 2023 23:13:12 -0500 (EST)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230228041312uscas1p1baf3e096036cefdc0a843ec47126facc~H4b4OgY_C2639726397uscas1p1-;
        Tue, 28 Feb 2023 04:13:12 +0000 (GMT)
X-AuditID: cbfec36d-d99ff70000011b40-0b-63fd7f5823f2
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B7.E8.17110.85F7DF36; Mon,
        27 Feb 2023 23:13:12 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 27 Feb 2023 20:13:11 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        27 Feb 2023 20:13:11 -0800
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
Subject: Re: [PATCH v4 07/10] tests: acpi: Update q35/DSDT.cxl for removed
 duplicate UID
Thread-Topic: [PATCH v4 07/10] tests: acpi: Update q35/DSDT.cxl for removed
        duplicate UID
Thread-Index: AQHZSyr4HoUYoSjLhkiu2TwCupOsNA==
Date:   Tue, 28 Feb 2023 04:13:11 +0000
Message-ID: <20230228041311.GG1339780@bgt-140510-bm03>
In-Reply-To: <20230206172816.8201-8-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-ID: <48347A1005E35B47B2163A8674F6373C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsWy7djXc7oR9X+TDR7+MbFonryY0eLFn+dM
        FvufPmexWLXwGpvF+VmnWCwObzzDZPH/1ytWizUrhC2O9+5gceD02DnrLrtHy5G3rB6L97xk
        8ti0qpPN4861PWweT65tZvJ4v+8qm8fnTXIBHFFcNimpOZllqUX6dglcGQfeTmAsuMBV0dXz
        n7WBsZezi5GTQ0LAROLl78eMXYxcHEICKxklfh9bxA7htDJJ7Hv7gBWmqrl1KxtEYi2jxJLZ
        n1ghnE+MEldWbofKLGOU6DrVxw7SwiagKLGvCyTBySEiYCTx7sYksCXMAl+YJKbe3cgCkhAW
        iJKY9uUVUAMHUFG0xKl3vBCmnsSRe34gFSwCqhJvTmxlAgnzCphJ7O0Da+QUcJBo/3qZGcRm
        FBCT+H5qDROIzSwgLnHryXwmiKMFJRbN3sMMYYtJ/Nv1kA3CVpS4//0lO0S9nsSNqVPYIGw7
        iX/z97NC2NoSyxa+BuvlBZpzcuYTFoheSYmDK26wgHwiIdDOKXF6wmF2iISLxKM5r6ChJS3x
        9+4ysJslBJIlVn3kggjnSMxfsgVqjrXEwj/rmSYwqsxCcvYsJCfNQnLSLCQnzUJy0gJG1lWM
        4qXFxbnpqcWGeanlesWJucWleel6yfm5mxiByez0v8O5Oxh33Pqod4iRiYPxEKMEB7OSCO/C
        23+ShXhTEiurUovy44tKc1KLDzFKc7AoifMa2p5MFhJITyxJzU5NLUgtgskycXBKNTDJSWwq
        +rSJ3fOa409BD9H0I44btSNDeKX3fLB8cqv33tt+lhzbU+154uy/Hr2WO7FrxTz5XR2b7dfM
        Flwo0ND1e9Gc+595r82WzXb9PSnu+IJL2wUzp8XpHpX+738npbPjnimn6NEZiqUC59dnsncp
        vH2vlT2rTTror82D++d746ZF9ZxZc1j3b+HZFakF4kUK286o2r5ZXLtQ2XpNMjeDVt+Bt3um
        vp7eru0hqZBxjtH1ktnvEz5z/yzrEdWJUWnjSnyd1SZ7+Hf+95boOy/3/ZXRE9lesKVnzeqH
        DbIz315fl194Q+quZsSN4KgY3ytLPK/aicbFH/8vU1widmSG2eGmCL6XTSwH3P886vmrxFKc
        kWioxVxUnAgA2bViatUDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrAIsWRmVeSWpSXmKPExsWS2cA0UTei/m+ywYS18hbNkxczWrz485zJ
        Yv/T5ywWqxZeY7M4P+sUi8XhjWeYLP7/esVqsWaFsMXx3h0sDpweO2fdZfdoOfKW1WPxnpdM
        HptWdbJ53Lm2h83jybXNTB7v911l8/i8SS6AI4rLJiU1J7MstUjfLoEr48DbCYwFF7gqunr+
        szYw9nJ2MXJySAiYSDS3bmXrYuTiEBJYzSjxZvo0FgjnE6PEn3NfWSGcZYwS7xY/YAdpYRNQ
        lNjXtZ0NxBYRMJJ4d2MSI0gRs8AXJokbH76zgCSEBaIkpn15xQ5RFC3xZVEHUxcjB5CtJ3Hk
        nh9ImEVAVeLNia1gYV4BM4m9fSwgppBAqUR3rwBIBaeAg0T718vMIDajgJjE91NrmEBsZgFx
        iVtP5jNBPCAgsWTPeWYIW1Ti5eN/rBC2osT97y/ZIer1JG5MncIGYdtJ/Ju/nxXC1pZYtvA1
        WC+vgKDEyZlPWCB6JSUOrrjBMoFRYhaSdbOQjJqFZNQsJKNmIRm1gJF1FaN4aXFxbnpFsVFe
        arlecWJucWleul5yfu4mRmAiOP3vcPQOxtu3PuodYmTiYDzEKMHBrCTCu/D2n2Qh3pTEyqrU
        ovz4otKc1OJDjNIcLErivC+jJsYLCaQnlqRmp6YWpBbBZJk4OKUamJbqc0TtvGn5d8Hz5c63
        ygPyv7wI/5n8qmTXhF+8q/RfHTdm2uh2+fW3K2KTxPle/c3VvKZqxJOnXtCZVndEoeLUtZCj
        Urn5K/V1fVZ2l0yYVMpw41/5OrnJpRN3f7tsmrkzXKG8f86p1R8aV0k27BfNC+zz6L9b3vqn
        8eYamUNzr0+e+TNDecbvBanau34I2ZjdNKyR+nvtXMXN/nfMld1T1kXrcIndlbT16Hdl47Jk
        qLw9+S/fxmNTA1sMrzLMfD+pIaLLxye2/fzOqQ3vpsyq2d17IEjnzvI5pZxzTn4TceIJ3DXt
        3fEm974bR085TZGbsjrm9RVL70ztL48mODSGLc7mv7/rNv+7x4K6DLFKLMUZiYZazEXFiQCJ
        YGV/cwMAAA==
X-CMS-MailID: 20230228041312uscas1p1baf3e096036cefdc0a843ec47126facc
CMS-TYPE: 301P
X-CMS-RootMailID: 20230228041312uscas1p1baf3e096036cefdc0a843ec47126facc
References: <20230206172816.8201-1-Jonathan.Cameron@huawei.com>
        <20230206172816.8201-8-Jonathan.Cameron@huawei.com>
        <CGME20230228041312uscas1p1baf3e096036cefdc0a843ec47126facc@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Feb 06, 2023 at 05:28:13PM +0000, Jonathan Cameron wrote:
> Dropping the ID effects this table in trivial fashion.
>=20
> Reviewed-by: Gregory Price <gregory.price@memverge.com>
> Tested-by: Gregory Price <gregory.price@memverge.com>
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Fan Ni <fan.ni@samsung.com>

>  tests/data/acpi/q35/DSDT.cxl                | Bin 9578 -> 9564 bytes
>  tests/qtest/bios-tables-test-allowed-diff.h |   1 -
>  2 files changed, 1 deletion(-)
>=20
> diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
> index 3d18b9672d124a0cf11a79e92c396a1b883d0589..4586b9a18b24acd946cd32c7e=
3e3a70891a246d2 100644
> GIT binary patch
> delta 65
> zcmaFmb;pa#CD<h-MwNkqQEMaDUKwr|m6-Tor}*e5Z{^9CWUMyF%dcjfyiYC^MM6#<
> IB*D!F0I~xVRsaA1
>=20
> delta 79
> zcmccP^~#IOCD<h-OO=3D6vv2P>SUKwt0m6-Tor}*e5CzZ*UWUScYLp@!%?rjc`U&A<g
> SyId%Wytq76o(Cw;!v+8Y7Z@l2
>=20
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bi=
os-tables-test-allowed-diff.h
> index 9ce0f596cc..dfb8523c8b 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1,2 +1 @@
>  /* List of comma-separated changed AML files to ignore */
> -"tests/data/acpi/q35/DSDT.cxl",
> --=20
> 2.37.2
>=20
> =
