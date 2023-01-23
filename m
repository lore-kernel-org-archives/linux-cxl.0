Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B9EDC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 23 Jan 2023 17:53:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbjAWRxd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230128AbjAWRxc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 23 Jan 2023 12:53:32 -0500
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA31A2BECF
        for <linux-cxl@vger.kernel.org>; Mon, 23 Jan 2023 09:53:28 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230123175325usoutp027e50b4d21a8c305282fe4dd944612a96~9AZv2xCtu0305803058usoutp02m;
        Mon, 23 Jan 2023 17:53:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230123175325usoutp027e50b4d21a8c305282fe4dd944612a96~9AZv2xCtu0305803058usoutp02m
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674496405;
        bh=GRvL4gXakwKMIDoKtUTjWt6yZPRkduZViqmeyuTVG3Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=JdbwwT5c+mg+YgiQwzBluZ4KMB7g/ug6DV0OqZAO9acqx8u25YCy5s9Ol4raLXVOB
         Zv6n55q7CfWIN2/DMs//J9hAc7LsbHu04JPxn3Of3MbhZFdd8l+J744m54ipZFMHif
         mBC39nwB0FLyQCK+q4XS9C1uQThqQ6M8AGlc1C14=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230123175325uscas1p26ff788d3798b9b9ad1f36cc886f960b5~9AZvthcGC0413304133uscas1p23;
        Mon, 23 Jan 2023 17:53:25 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 87.85.12196.599CEC36; Mon,
        23 Jan 2023 12:53:25 -0500 (EST)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351~9AZvcJpuB2188521885uscas1p1H;
        Mon, 23 Jan 2023 17:53:25 +0000 (GMT)
X-AuditID: cbfec370-83dfe70000012fa4-ef-63cec9954309
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id F6.48.11378.599CEC36; Mon,
        23 Jan 2023 12:53:25 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 23 Jan 2023 09:53:24 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        23 Jan 2023 09:53:24 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        Ben Widawsky <bwidawsk@kernel.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "linuxarm@huawei.com" <linuxarm@huawei.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        "alison.schofield@intel.com" <alison.schofield@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>
Subject: Re: [RFC PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation
Thread-Topic: [RFC PATCH 0/2] hw/cxl: Passthrough HDM decoder emulation
Thread-Index: AQHZLySkNAH6qX3/wkmwdVXQT9dTIK6szvqA
Date:   Mon, 23 Jan 2023 17:53:24 +0000
Message-ID: <20230123175315.GA168673@bgt-140510-bm03>
In-Reply-To: <20230123121712.29892-1-Jonathan.Cameron@huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <59D01FB680A00541A2A9514160D0E097@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNKsWRmVeSWpSXmKPExsWy7djXc7pTT55LNnjUqWxx9/EFNovmyYsZ
        LU7cbGSzWH1zDaPF/qfPWSxWLbzGZnF+1ikWi8MbzzBZHO/dweLA6dFy5C2rx+I9L5k8Nq3q
        ZPN4cm0zk8fU2fUenzfJBbBFcdmkpOZklqUW6dslcGVM37uDpWChcMXuq/uZGxhn8ncxcnJI
        CJhIrOp6ztrFyMUhJLCSUeJ63yJmCKeVSaJn0QYWmKq1N9oYIRJrGSV2NLYzQTifGCVuH1vM
        BuEsY5T4MPcfK0gLm4CixL6u7WwgtoiAkcS7G5PA2pkF5jJL3Hy0lhkkISzgJjHl3XyoIneJ
        DWc2M8M0tJx6AGazCKhKvNo1D2wor4CpxOZNzWD1nAKOEm2T37CD2IwCYhLfT61hArGZBcQl
        bj2ZzwRxt6DEotl7mCFsMYl/ux6yQdiKEve/v2SHqNeRWLD7ExuEbSfxrW06VFxbYtnC18wQ
        ewUlTs58Ag0LSYmDK26wgDwjIfCCQ+Lpv3XsEAkXiYObn0IVSUtcvT4VqJkDyE6WWPWRCyKc
        IzF/yRaoEmuJhX/WM01gVJmF5OxZSE6aheSkWUhOmoXkpAWMrKsYxUuLi3PTU4uN81LL9YoT
        c4tL89L1kvNzNzEC09fpf4cLdjDeuvVR7xAjEwfjIUYJDmYlEd7peeeShXhTEiurUovy44tK
        c1KLDzFKc7AoifMa2p5MFhJITyxJzU5NLUgtgskycXBKNTDlL2BUPnD95bWEVJajl07drZ81
        ydC4dOo3YfmgzfHrf255MG/Wyq/ywrtn7Zuw3rvHzSL14Y1PW4ol7DYtd/Jx4XJ9c72ioCh3
        okSOT6DZ8fTiGr6oHx/mff8hvSfaY86moPJX1m/uuD+6vu/NzgOXmM5X2NtwGqYfvNO+/EbU
        9Qnu7Cp238XFg7M7zasuNbxcyvml8Pr8vQxbozcyBE6auOrljyPBl+90pm+ZyCwecdmiT8Po
        ZhqDWH7usq4lJxfOin16Uy+6YLJq9Z+XXQc/MnhmsWw0lGJUDF1f8NhhNz9jzJeUE893Bc16
        GH/4k8o+R99+wZtP7Yt+XzyYy2FZwnK6qcQnIjdCcV7tGYldSizFGYmGWsxFxYkAEg+ntc4D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrJIsWRmVeSWpSXmKPExsWS2cA0UXfqyXPJBkcu8VvcfXyBzaJ58mJG
        ixM3G9ksVt9cw2ix/+lzFotVC6+xWZyfdYrF4vDGM0wWx3t3sDhwerQcecvqsXjPSyaPTas6
        2TyeXNvM5DF1dr3H501yAWxRXDYpqTmZZalF+nYJXBnT9+5gKVgoXLH76n7mBsaZ/F2MnBwS
        AiYSa2+0MXYxcnEICaxmlLiy5SE7hPOJUWLv3wNMEM4yRolf/VtYQVrYBBQl9nVtZwOxRQSM
        JN7dmATWziwwl1ni5qO1zCAJYQE3iSnv5kMVuUtsOLOZGaah5dQDMJtFQFXi1a55YEN5BUwl
        Nm9qBqsXEnAAsmeA1XAKOEq0TX7DDmIzCohJfD+1hgnEZhYQl7j1ZD4TxA8CEkv2nGeGsEUl
        Xj7+xwphK0rc//6SHaJeR2LB7k9sELadxLe26VBxbYllC18zQ9wgKHFy5hMWiF5JiYMrbrBM
        YJSYhWTdLCSjZiEZNQvJqFlIRi1gZF3FKF5aXJybXlFsmJdarlecmFtcmpeul5yfu4kRGPun
        /x2O3MF49NZHvUOMTByMhxglOJiVRHin551LFuJNSaysSi3Kjy8qzUktPsQozcGiJM4r5Dox
        XkggPbEkNTs1tSC1CCbLxMEp1cDU3F0em/rft26e0ewnv7JfXL5yQpjz4T7zj0Vbve87PXLe
        UG6dkx5tv5HbuDf+//yArdfLfgvvdtmo+SPudoq465UItbNesrP8eV2csy4q+W2Z3Lp3p1Xs
        9iZrvpRg52gOaddu7uqar75bHLVfTxetaJu1k1UreqKF08b6niS+PxM+nI5/UNC96fbrg8Z/
        ead8Evs1Zd8slyO6jxdHbU9t51jzccUbv8Xf9Z3WOE1+ndGpOjEp32ym+g5jzWAT0fr5yoXT
        Z3Tm/b+3XarymonfNLGSJ/UCtR+Wtu2Y++rRstxVrEpbGf6azTVfHRqxYYufs5L06r2L435O
        UNTcZ8p3fGZv7Btj3aLJ7i96OoyVWIozEg21mIuKEwHBqetcbAMAAA==
X-CMS-MailID: 20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351
CMS-TYPE: 301P
X-CMS-RootMailID: 20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351
References: <20230123121712.29892-1-Jonathan.Cameron@huawei.com>
        <CGME20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Mon, Jan 23, 2023 at 12:17:10PM +0000, Jonathan Cameron wrote:



> Until now, testing using CXL has relied up always using two root ports
> below a host bridge, to work around a current assumption in the Linux
> kernel support that, in the single root port case, the implementation wil=
l
> use the allowed passthrough decoder implementation choice. If that choice
> is made all accesses are routed from the host bridge to the single
> root port that is present. Effectively we have a pass through decoder
> (it is called that in the kernel driver).
>=20
> This patch series implements that functionality and makes it the default
> See patch 2 for a discussion of why I think we can make this change
> without backwards compatibility issues (basically if it didn't work befor=
e
> who are we breaking by making it work?)
>=20
> Whilst this limitation has been known since the initial QEMU patch
> postings / kernel CXL region support, Fan Ni Ran into it recently remindi=
ng
> me that we should solve it.
>=20
> https://lore.kernel.org/linux-cxl/20230113171044.GA24788@bgt-140510-bm03/
>=20
> Tree with a large set of patches before this at:
> https://gitlab.com/jic23/qemu/-/tree/cxl-2023-01-20
>=20
> I've done some basic testing, though I did hit what appears to be
> a kernel race on region bring up of existing region / namespace in a
> 1HB 2RP 2EP test case. That is proving hard to replicate consistently
> but doesn't seem to have anything to do with the emulation other than
> perhaps we are opening up a race by responding slowly to something.
>=20
> Jonathan Cameron (2):
>   hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
>   hw/pxb-cxl: Support passthrough HDM Decoders unless overridden
>=20
>  hw/cxl/cxl-host.c                   | 31 +++++++++++++--------
>  hw/pci-bridge/pci_expander_bridge.c | 43 +++++++++++++++++++++++++----
>  hw/pci/pcie_port.c                  | 38 +++++++++++++++++++++++++
>  include/hw/cxl/cxl.h                |  1 +
>  include/hw/cxl/cxl_component.h      |  1 +
>  include/hw/pci/pci_bridge.h         |  1 +
>  include/hw/pci/pcie_port.h          |  2 ++
>  7 files changed, 100 insertions(+), 17 deletions(-)
>=20
> --=20
> 2.37.2
>=20
>=20
Tried three different cxl topology setups (1HB1RP, 1HB2RP2Memdev, with
switch), the patch works fine for me.
Btw, there seem some format issues with the patch, got warnings with
checkpatch tool.=
