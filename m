Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E93E7D0B4
	for <linux-cxl@archiver.kernel.org>; Thu, 21 Sep 2023 22:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjIUWvl (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 21 Sep 2023 18:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIUWvj (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 21 Sep 2023 18:51:39 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3695CF7
        for <linux-cxl@vger.kernel.org>; Thu, 21 Sep 2023 15:51:32 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230921225130usoutp01c164b655d0bca7461a6d726b900f8721~HC7z4TkG23250232502usoutp01N;
        Thu, 21 Sep 2023 22:51:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230921225130usoutp01c164b655d0bca7461a6d726b900f8721~HC7z4TkG23250232502usoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1695336691;
        bh=MkEbi34F4tluczqqGV3/F3vVfH4sk6DrOrlcbZjWohk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=diifxKEsdsSW1Wsyl9eKjFGYnuSTd2fnWNb+P+k9KIhFU+6LS+VBMzBMzhMuNE+tU
         F/ztvnxv+qnRDC215kJSDirDvW8O6d4AlJJx7cNkLnhoAYJUqYLIpPAiSGptvo0NSw
         rpnton1WCjNv2jxq2rah/aJY+63/M+QAc2DNJssY=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230921225130uscas1p1d4eca551dc23e7c36234564b19aa074c~HC7zxgFUk1981419814uscas1p1J;
        Thu, 21 Sep 2023 22:51:30 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id B8.24.50148.2F8CC056; Thu,
        21 Sep 2023 18:51:30 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230921225130uscas1p10cf7036ed3f8191d3dc19aeca9586c5b~HC7zaoD_11986419864uscas1p1J;
        Thu, 21 Sep 2023 22:51:30 +0000 (GMT)
X-AuditID: cbfec36d-559ff7000002c3e4-b0-650cc8f2dfe3
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 73.6B.28590.2F8CC056; Thu,
        21 Sep 2023 18:51:30 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 21 Sep 2023 15:51:29 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        21 Sep 2023 15:51:29 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "Singh, Naveen" <naveen.c.singh@intel.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>
Subject: Re: Questions about the qemu DCD support in cxl-2023-09-13
Thread-Topic: Questions about the qemu DCD support in cxl-2023-09-13
Thread-Index: AQHZ7NppV1BJ02wCEEmUKS7pYu48ybAmV/CA
Date:   Thu, 21 Sep 2023 22:51:29 +0000
Message-ID: <20230921225123.GA3690460@sjcvldevvm72>
In-Reply-To: <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <8855B4C4DDCE1F4EB8B96688BDD3EDF8@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupnleLIzCtJLcpLzFFi42LZduzrOd1PJ3hSDT7M17PY//Q5i8WqhdfY
        LM7POsVicaljEaMDi0fLkbesHov3vGTy+LxJLoA5issmJTUnsyy1SN8ugStj97dv7AUbeCo+
        nJ/I2sD4kbOLkZNDQsBE4mz/RcYuRi4OIYGVjBKXlyxmgXBamSQWbl3KCFPV+m85VNVaRonH
        ux5CVX1ilOhq/wHlLGOUeDnzJjtIC5uAosS+ru1sILaIgLLE6X9X2UCKmAVmM0pcmn8MLCEs
        4CzRvHwmK0SRi0TH+XcsELaRxN/7K5i6GDk4WARUJa7czu1iZOfgFTCWWOYPUsApYC3xaP0U
        sOMYBcQkvp9awwRiMwuIS9x6Mp8J4mhBiUWz9zBD2GIS/3Y9ZIOwFSXuf3/JDlGvI7Fg9yc2
        kEXMAnYSu+96QIS1JZYtfA3Wygs05uTMJywQrZISB1fcAPtWQuAAh8TFw/PYIRIuEic3LYCa
        Ly1x9fpUZpCZEgLJEqs+ckGEcyTmL9kCNcdaYuGf9UwTGFVmIbl6FpKLZiFcNAvJRbOQXLSA
        kXUVo3hpcXFuemqxYV5quV5xYm5xaV66XnJ+7iZGYJo5/e9w7g7GHbc+6h1iZOJgPMQowcGs
        JMKb/IkrVYg3JbGyKrUoP76oNCe1+BCjNAeLkjivoe3JZCGB9MSS1OzU1ILUIpgsEwenVANT
        pduFJ+b8T2I3PuuZLr/mZjzjsVhX8X2vd77btmSRrjXLm/z9E78rqxyNeGO+pWP+2j/rfYVc
        Y9l4Ghyc5/1xyFPxuq77KO/axvcbz/+fyHUiLMufL39h87TvBhYXt/uUzQu15Gc9HCxtdfPy
        NZlL+5aeYQmUZrz+e3HXKtbfnCmiF0V/haw9bOb9Q9DP+/P2W09Vl2bOulm9ch3v5ryXtzX1
        q7+z7RBpc7uent44N3BrScWpANM/c7fJdVx5yFrGLrFAWerH35MvWc9VlJb1XllZL7fkXJPv
        Fjudf3dntIQcrGblX6a4+Wcof5fshR4nX8OrXD8j39jn1mrlLdUq+Wc4dUdg6P6VaxYL6+Us
        VWIpzkg01GIuKk4EABczLraiAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLIsWRmVeSWpSXmKPExsWS2cA0UffTCZ5Ug8v/xS32P33OYrFq4TU2
        i/OzTrFYXOpYxOjA4tFy5C2rx+I9L5k8Pm+SC2CO4rJJSc3JLEst0rdL4MrY/e0be8EGnooP
        5yeyNjB+5Oxi5OSQEDCRaP23nLGLkYtDSGA1o8SmhetZIZxPjBIvplxiAakSEljGKPFoBjOI
        zSagKLGvazsbiC0ioCxx+t9VNpAGZoHZjBKX5h8DSwgLOEs0L5/JClHkItFx/h0LhG0k8ff+
        CqYuRg4OFgFViSu3c7sY2Tl4BYwllvlDrO1jlLj6ZBbYFE4Ba4lH66cwgtiMAmIS30+tYQKx
        mQXEJW49mc8E8YCAxJI955khbFGJl4//sULYihL3v79kh6jXkViw+xMbyFZmATuJ3Xc9IMLa
        EssWvgZr5RUQlDg58wkLRKukxMEVN1gmMErMQrJtFpJJsxAmzUIyaRaSSQsYWVcxipcWF+em
        VxQb5qWW6xUn5haX5qXrJefnbmIExujpf4cjdzAevfVR7xAjEwfjIUYJDmYlEd7kT1ypQrwp
        iZVVqUX58UWlOanFhxilOViUxHl3TLmYIiSQnliSmp2aWpBaBJNl4uCUamAy69unzd242rXH
        KrdbTLXsZ9ePO3xPPdIf9svs873/xiR24tatPMY/k3/cc2XIiWRkScqzCbM4YRXodHjGv9f9
        6ZFHbvJz2B5dsXiq4cyZV7oPT+fndOrVq77Yxs230KQtcXcQ25muhmVrLrMzWlmnf35p76MS
        /WmpdTxnt8u8Y6/8TVYtl37UcoWlmtus/EC6hvasO2Ztl6wWHPjTcN22eMb10gMG6/Z+TclZ
        m2m/iut9+tP7slk+11MZ0/5NeXN309Zlc4Nf+fxQzb+7svF6wL+n708deBN8TnNV4BXOZ9t3
        SGXvsYtdoLho06HEfTPqTi0I/Xtjwea1tX8MHnG80F9yUCZhxla16Y52zMXuSizFGYmGWsxF
        xYkACI6OfUADAAA=
X-CMS-MailID: 20230921225130uscas1p10cf7036ed3f8191d3dc19aeca9586c5b
CMS-TYPE: 301P
X-CMS-RootMailID: 20230921222437uscas1p158e5ceecab50dcb39e33811f567152d8
References: <CGME20230921222437uscas1p158e5ceecab50dcb39e33811f567152d8@uscas1p1.samsung.com>
        <650cc29ab3f64_50d07294e7@iweiny-mobl.notmuch>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Thu, Sep 21, 2023 at 03:24:26PM -0700, Ira Weiny wrote:

Hi Ira,

Thanks for reaching out.
For DCD, I think Jonathan's branch does not change much compared to the pat=
ch
series sent out except some obvious issues that blocks the test.

My initial plan was to update the patches after I have tested the
current version with more stable kernel DCD driver.

See below.


> Fan,
>=20
> I'm working off of Jonathan's latest CXL branch with the DCD patches.[1]
>=20
> I've been testing various things and so far I have a couple of questions.
>=20
> 1) If the qmp command is used to add extents which overlap other extents
>    shouldn't that throw an error?  I don't see any validation of this and
>    I would think a real device would reject such a request from the FM.
>=20

Yes. We do not have any validation for the overlapped extents here
in current code.

> 2) Where is CXLType3Dev->dc.total_extent_count set?  Attempting to add
>    extents prior to driver load does not seem to work.  And I think this
>    is because total_extent_count is 0 in cmd_dcd_get_dyn_cap_ext_list().

I am aware of the issue, yet have not got a chance to fix it.=20

My understanding is whenever we complete adding/releasing
extents, we update it.

I will fix it and other issues mentioned in the comments in the next versio=
n.

Fan
>=20
> Ira
>=20
> [1] https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-=
2023-09-13__;!!EwVzqGoTKBqv-0DWAJBm!WrndoKsXHVaUoln-Jsq7MFRemLlcFYg788t_tDa=
Ft1lS7WFhE2s_5hsI4-WuNzlgLOc0e0DgdcepR368SHU$ =
