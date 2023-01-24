Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D5BC25B4E
	for <linux-cxl@archiver.kernel.org>; Tue, 24 Jan 2023 17:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234121AbjAXRAt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 24 Jan 2023 12:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234380AbjAXRAs (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 24 Jan 2023 12:00:48 -0500
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0591245F57
        for <linux-cxl@vger.kernel.org>; Tue, 24 Jan 2023 09:00:37 -0800 (PST)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230124170034usoutp016f4b39e8af096842ea23dec8dccf6246~9TU4fKvfq3145731457usoutp01p;
        Tue, 24 Jan 2023 17:00:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230124170034usoutp016f4b39e8af096842ea23dec8dccf6246~9TU4fKvfq3145731457usoutp01p
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1674579634;
        bh=FMDrPaTF0+Vi9fjCCtYMriQMtblV6FJtS64E1cQbpFk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ulEn8uCN44kljbp8hWzy+ryVJe4pRQNeyUup+JF4gGL53ax+Ovnd0iz2lTEweb6EY
         0rDdpTkRRqBsYHfBEFWYGyd+cqH/iV59fanoRFq8TG89VLNkZUb79Oyk3Df4qao8Vr
         8V9HLPUpAqwFlmgP+s/9BRhfKSGLugQepVQ/Yx6c=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230124170034uscas1p2fa263e7c5e873b4b347f427f2eff3b92~9TU4Q8jZo1958219582uscas1p27;
        Tue, 24 Jan 2023 17:00:34 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 9F.E2.49129.2BE00D36; Tue,
        24 Jan 2023 12:00:34 -0500 (EST)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230124170033uscas1p10baa61b555ae09696d2f5cfa74555913~9TU3-2xF11230912309uscas1p1r;
        Tue, 24 Jan 2023 17:00:33 +0000 (GMT)
X-AuditID: cbfec36f-6f006a800001bfe9-f4-63d00eb29eb9
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 75.5E.11346.1BE00D36; Tue,
        24 Jan 2023 12:00:33 -0500 (EST)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 24 Jan 2023 09:00:33 -0800
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        24 Jan 2023 09:00:33 -0800
From:   Fan Ni <fan.ni@samsung.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
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
Thread-Index: AQHZLySkNAH6qX3/wkmwdVXQT9dTIK6szvqAgAEKjACAAHkEAA==
Date:   Tue, 24 Jan 2023 17:00:32 +0000
Message-ID: <20230124170008.GA173757@bgt-140510-bm03>
In-Reply-To: <20230124094720.00005c97@Huawei.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="us-ascii"
Content-ID: <209EB741507E2448A133E680AE32429C@ssi.samsung.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrBKsWRmVeSWpSXmKPExsWy7djX87qb+C4kGxz/yWJx9/EFNovmyYsZ
        LU7cbGSzWH1zDaPF/qfPWSxWLbzGZnF+1ikWi8MbzzBZHO/dweLA6dFy5C2rx+I9L5k8Nq3q
        ZPN4cm0zk8fU2fUenzfJBbBFcdmkpOZklqUW6dslcGU8+Zte0C9dsevXE/YGxkWiXYycHBIC
        JhLv9p1i6mLk4hASWMko8ff0ZyinlUniyJ5prDBVbR9bmEFsIYG1jBJfF3JBFH1ilGi8fBiq
        YxmjxJ5ZXWAdbAKKEvu6trOB2CICRhJXlh1kByliFpjLLHHz0VqwUcICbhJT3s2HKnKX2HBm
        MzOE7STxonMp2CAWAVWJOV2fGLsYOTh4BUwlOpYEgIQ5BQwlWp7tAytnFBCT+H5qDROIzSwg
        LnHryXwmiKsFJRbN3sMMYYtJ/Nv1kA3CVpS4//0lO0S9jsSC3Z/YIGw7iZUXH7NC2NoSyxa+
        BuvlBZpzcuYTFoheSYmDK26wgPwiIfCGQ+JK5zd2iISLRNfXeVC2tMT0NZdZQG6WEEiWWPWR
        CyKcIzF/yRaoOdYSC/+sZ5rAqDILydmzkJw0C8lJs5CcNAvJSQsYWVcxipcWF+empxYb5aWW
        6xUn5haX5qXrJefnbmIEJq7T/w7n72C8fuuj3iFGJg7GQ4wSHMxKIrw9s88nC/GmJFZWpRbl
        xxeV5qQWH2KU5mBREuc1tD2ZLCSQnliSmp2aWpBaBJNl4uCUamCa6jzVSWLupD8XuireMZg/
        lRLRzFwkuugSC98PZ+FLFRXfqxl2iPiJX2ROWvEsJfja09/hm+sZkmzPKr+xnPDz6zyzGy5b
        MqYdmNs9Q+PPJfXi6ETmR46Lfbm+vTiQqiVTfbdxtmJD/4KV3uqLri1LZfSd9+ryPvsClyU7
        jv14fMvVwMDY8naWx1zbaJkGTqPHicd+Hl2gV1I/QWseR4hd4LP4S2el7WucnrPKHEg947ao
        N2XaHd7Fx1sM5B1sLAPXrHzN+eiusFXWohtbrEuu8m59N8FWtHibSVO587VOntbv1YIf2X7s
        SNzuLPbv2QnF1SVSXw7s73os6G6Xe+HR5dZWmXKnkGkRfwrbZdiVWIozEg21mIuKEwH91OZ7
        ywMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWS2cA0SXcj34Vkg9s7dS3uPr7AZtE8eTGj
        xYmbjWwWq2+uYbTY//Q5i8WqhdfYLM7POsVicXjjGSaL4707WBw4PVqOvGX1WLznJZPHplWd
        bB5Prm1m8pg6u97j8ya5ALYoLpuU1JzMstQifbsErownf9ML+qUrdv16wt7AuEi0i5GTQ0LA
        RKLtYwtzFyMXh5DAakaJZW1nGCGcT4wS5w/eY4FwljFK7Pu9iA2khU1AUWJf13YwW0TASOLK
        soPsIEXMAnOZJW4+WssMkhAWcJOY8m4+VJG7xIYzm5khbCeJF51LWUFsFgFViTldn4DWcXDw
        CphKdCwJAAkLCTxnlFg/Vx/E5hQwlGh5tg+slVFATOL7qTVMIDazgLjErSfzmSBeEJBYsuc8
        M4QtKvHy8T9WCFtR4v73l+wQ9ToSC3Z/YoOw7SRWXnzMCmFrSyxb+Bqsl1dAUOLkzCcsEL2S
        EgdX3GCZwCgxC8m6WUhGzUIyahaSUbOQjFrAyLqKUby0uDg3vaLYOC+1XK84Mbe4NC9dLzk/
        dxMjMO5P/zscs4Px3q2PeocYmTgYDzFKcDArifD2zD6fLMSbklhZlVqUH19UmpNafIhRmoNF
        SZzXI3ZivJBAemJJanZqakFqEUyWiYNTqoHJeY7Vs829Fuy1ce2c5ayvsxnV+s8r9H5bzRJa
        amd5dnvllK4am5net4xfN84vjG86VMMkwOt4O2bKlJWChQFR/LsfSruxbxFrnWucFW63+uZC
        BVmLNz3HFksdtdOwlvCN+GlncOj88o3Nq1vf7ZDfdnOF/75Dh11qZ5197MbAMiPm+CbW3slu
        SxctNzsrnuPLdcAu54Wp5Stdi1YpLpYnZ37dmTNNYrW67cLqe2Ic2h61/mdn9nYYMLf8n/lK
        1OtXf2RF4c3E4oS6mM2cc9XMZkvPMbosLrC6//rMqvQFFyvSlrbUsJ8IylQIfsTQMO85t8/R
        utSLDEKKnnnJqyWfXNrPrhc7vyj8Ts4eBiWW4oxEQy3mouJEALj1+1pqAwAA
X-CMS-MailID: 20230124170033uscas1p10baa61b555ae09696d2f5cfa74555913
CMS-TYPE: 301P
X-CMS-RootMailID: 20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351
References: <20230123121712.29892-1-Jonathan.Cameron@huawei.com>
        <CGME20230123175325uscas1p134d834ae3636c7c56e93299c01a4f351@uscas1p1.samsung.com>
        <20230123175315.GA168673@bgt-140510-bm03>
        <20230124094720.00005c97@Huawei.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Tue, Jan 24, 2023 at 09:47:20AM +0000, Jonathan Cameron wrote:

> On Mon, 23 Jan 2023 17:53:24 +0000
> Fan Ni <fan.ni@samsung.com> wrote:
>=20
> > On Mon, Jan 23, 2023 at 12:17:10PM +0000, Jonathan Cameron wrote:
> >=20
> >=20
> >=20
> > > Until now, testing using CXL has relied up always using two root port=
s
> > > below a host bridge, to work around a current assumption in the Linux
> > > kernel support that, in the single root port case, the implementation=
 will
> > > use the allowed passthrough decoder implementation choice. If that ch=
oice
> > > is made all accesses are routed from the host bridge to the single
> > > root port that is present. Effectively we have a pass through decoder
> > > (it is called that in the kernel driver).
> > >=20
> > > This patch series implements that functionality and makes it the defa=
ult
> > > See patch 2 for a discussion of why I think we can make this change
> > > without backwards compatibility issues (basically if it didn't work b=
efore
> > > who are we breaking by making it work?)
> > >=20
> > > Whilst this limitation has been known since the initial QEMU patch
> > > postings / kernel CXL region support, Fan Ni Ran into it recently rem=
inding
> > > me that we should solve it.
> > >=20
> > > https://urldefense.com/v3/__https://lore.kernel.org/linux-cxl/2023011=
3171044.GA24788@bgt-140510-bm03/__;!!EwVzqGoTKBqv-0DWAJBm!WsD6FV-KV_YnhhHWL=
ll72cHLqLQ_8kpps3MlpAa6Bonsdz6aifuWT40-QnlRyFqWyeyaVb-RiC03_qajbeCGsI5DcPYv=
$=20
> > >=20
> > > Tree with a large set of patches before this at:
> > > https://urldefense.com/v3/__https://gitlab.com/jic23/qemu/-/tree/cxl-=
2023-01-20__;!!EwVzqGoTKBqv-0DWAJBm!WsD6FV-KV_YnhhHWLll72cHLqLQ_8kpps3MlpAa=
6Bonsdz6aifuWT40-QnlRyFqWyeyaVb-RiC03_qajbeCGsPjbv12T$=20
> > >=20
> > > I've done some basic testing, though I did hit what appears to be
> > > a kernel race on region bring up of existing region / namespace in a
> > > 1HB 2RP 2EP test case. That is proving hard to replicate consistently
> > > but doesn't seem to have anything to do with the emulation other than
> > > perhaps we are opening up a race by responding slowly to something.
> > >=20
> > > Jonathan Cameron (2):
> > >   hw/pci: Add pcie_count_ds_port() and pcie_find_port_first() helpers
> > >   hw/pxb-cxl: Support passthrough HDM Decoders unless overridden
> > >=20
> > >  hw/cxl/cxl-host.c                   | 31 +++++++++++++--------
> > >  hw/pci-bridge/pci_expander_bridge.c | 43 +++++++++++++++++++++++++--=
--
> > >  hw/pci/pcie_port.c                  | 38 +++++++++++++++++++++++++
> > >  include/hw/cxl/cxl.h                |  1 +
> > >  include/hw/cxl/cxl_component.h      |  1 +
> > >  include/hw/pci/pci_bridge.h         |  1 +
> > >  include/hw/pci/pcie_port.h          |  2 ++
> > >  7 files changed, 100 insertions(+), 17 deletions(-)
> > >=20
> > > --=20
> > > 2.37.2
> > >=20
> > >  =20
> > Tried three different cxl topology setups (1HB1RP, 1HB2RP2Memdev, with
> > switch), the patch works fine for me.
> > Btw, there seem some format issues with the patch, got warnings with
> > checkpatch tool.
> Thanks! I'll clean those up.  Was being lazy on it as it's an RFC for
> now :)  Given this is small and useful I'll probably pull it nearer the
> head of the queue.
>=20
> When I repost, if you could give a Tested-by tag that would be great!
>=20
> Thanks,
>=20
> Jonathan
>=20
Will do. Thanks.=
