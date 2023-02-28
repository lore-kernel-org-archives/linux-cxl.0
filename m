Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFD19C64EC7
	for <linux-cxl@archiver.kernel.org>; Tue, 28 Feb 2023 09:30:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjB1JaC (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 28 Feb 2023 04:30:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbjB1JaA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 28 Feb 2023 04:30:00 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845F421E
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 01:29:58 -0800 (PST)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230228092956epoutp04f140dcdc7cdff46e4f01a02adb6836da~H8wbD69xJ0479404794epoutp04K
        for <linux-cxl@vger.kernel.org>; Tue, 28 Feb 2023 09:29:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230228092956epoutp04f140dcdc7cdff46e4f01a02adb6836da~H8wbD69xJ0479404794epoutp04K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1677576596;
        bh=uQdhO84pCQls9fd9PJJGwXPrCWaWLWeHCPXtqEWTRY8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=puP2Hz7FuyfhFo/MbwhlMZgryA0Us3qnpbjVILMBoXpBFhwQUux0EyFjDv5j+vy3I
         RU6oJHLDA5rnoGjVPH9zUsyqSt/rsVr/AKfIZvjh41wkX84u7mdP/LQE4n1I1oEkuo
         n2qJIipDdBjDI4Y00JeqUlbeUDI1Bm5gDCLTRew8=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20230228092956epcas2p20564472234246e57e3a74a99d575af28~H8wau-SJw1607916079epcas2p2Y;
        Tue, 28 Feb 2023 09:29:56 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.101]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PQsXM4FyRz4x9Py; Tue, 28 Feb
        2023 09:29:55 +0000 (GMT)
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        A2.D9.61927.399CDF36; Tue, 28 Feb 2023 18:29:55 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20230228092955epcas2p1a216cbd36ac26fd7d2ac6af2d3e83c9c~H8wZq-LSI3223832238epcas2p1w;
        Tue, 28 Feb 2023 09:29:55 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230228092955epsmtrp105b6368070c37b2d9f4ce6299e5b15f2~H8wZqWe9Q2963829638epsmtrp1P;
        Tue, 28 Feb 2023 09:29:55 +0000 (GMT)
X-AuditID: b6c32a45-671ff7000001f1e7-ee-63fdc9935104
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        73.C0.17995.299CDF36; Tue, 28 Feb 2023 18:29:54 +0900 (KST)
Received: from dell-ArcherCity (unknown [10.229.83.212]) by
        epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20230228092954epsmtip198332c867dae747196c821d3482d335b~H8wZc3DrE0452304523epsmtip1U;
        Tue, 28 Feb 2023 09:29:54 +0000 (GMT)
Date:   Tue, 28 Feb 2023 18:31:06 +0900
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     linux-cxl@vger.kernel.org, dan.j.williams@intel.com,
        vishal.l.verma@intel.com, bwidawsk@kernel.org
Subject: Re: [ndctl 0/3] Support for inject poison
Message-ID: <Y/3J2nJTf97bHKb3@dell-ArcherCity>
MIME-Version: 1.0
In-Reply-To: <Y/wXnZjhplI9AUvv@aschofie-mobl2>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrCKsWRmVeSWpSXmKPExsWy7bCmhe7kk3+TDXoeKljcfXyBzaJ58mJG
        i+lTLzBanJ91isXi1oRjTA6sHov3vGTy2LSqk83j8ya5AOaobJuM1MSU1CKF1Lzk/JTMvHRb
        Je/geOd4UzMDQ11DSwtzJYW8xNxUWyUXnwBdt8wcoJVKCmWJOaVAoYDE4mIlfTubovzSklSF
        jPziElul1IKUnALzAr3ixNzi0rx0vbzUEitDAwMjU6DChOyMdS2NrAV3+Csu/33I1sB4nruL
        kZNDQsBEYndPI1sXIxeHkMAORokFex6xgySEBD4xSiyfKweR+MwocX/benaYjl39x6GKdjFK
        dLywhCh6yygx6VQ3K0iCRUBV4uTGQ0wgNpuAtsTf/umMXYwcHCIChhILpqmBmMwCGRJ7t4JV
        CAsYSVzt/Ahm8wroSczaspcRwhaUODnzCQuIzQkUn/D5KAvIKgmBc+wS9+92sULc4yLR+WAL
        G4QtLPHq+BaoO6UkXva3Qdn5ElMPToSySyTazhyAso0l3t18DjaHWSBTYlbvMzaQ2yQElCWO
        3GKBCPNJdBz+yw4R5pXoaBOC6FSV2LLhBdQUaYmjEzexQNgeEpPm9jBBQmQLo8S5ZbvYJzDK
        zULyziwk2yBsHYkFuz8B2aBQkZZY/o8DwtSUWL9LfwEj6ypGsdSC4tz01GKjAkN47Cbn525i
        BCc/LdcdjJPfftA7xMjEwXiIUYKDWUmEd+HtP8lCvCmJlVWpRfnxRaU5qcWHGE2BMTORWUo0
        OR+YfvNK4g1NLA1MzMwMzY1MDcyVxHmlbU8mCwmkJ5akZqemFqQWwfQxcXBKNTB5VjAf5mD5
        ovZYw+KjiO/d2DPbJJL2hzQU6gX1KMsF3C8Syr0gf2DWqk0ugpm77wolf7p8d+IWK/UH16es
        6PG9vImrTmGW6+TPxksiF4c6btjBa2jRd+Lfpv89Oy4ZFqtUzC26kqNj1jNBNb1aK2XrBeX2
        dO+ZPSbH3or8eyZzY/77ZZbLnvvdcOHgV37llTf9x68agf8fjYMqIn6cOMq+crLBje6jfx5M
        l3Jl0tilea/OYPpm3s1bFW+sYZ2odO9AWDFPSfKBv8s1pRnv+Ltv1Hu1LWJrxBbFnN41H6wF
        OefOdWVX8bc75l04MV3y7/JFT34l5Dg8TSgTf5KnKuy9sPieytfbzkvF+ByPuZ1VYinOSDTU
        Yi4qTgQAYPH6qAcEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDLMWRmVeSWpSXmKPExsWy7bCSnO6kk3+TDaa+tbS4+/gCm0Xz5MWM
        FtOnXmC0OD/rFIvFrQnHmBxYPRbvecnksWlVJ5vH501yAcxRXDYpqTmZZalF+nYJXBnrnq5g
        LZjJWzGhYx9bA+NSzi5GTg4JAROJXf3H2bsYuTiEBHYwSsw/sJQJIiEtceNRFxuELSxxv+UI
        K0TRa0aJO5OaWEASLAKqEic3HgJrYBPQlvjbP52xi5GDQ0TAUGLBNDUQk1kgQ2LvVrAKYQEj
        iaudH8FsXgE9iVlb9jJCjNzCKPH8w2NGiISgxMmZT8DGMwtoSdz495IJYo60xPJ/HCBhTqDe
        CZ+PskxgFJiFpGMWko5ZCB0LGJlXMUqmFhTnpucWGxYY5aWW6xUn5haX5qXrJefnbmIEB7CW
        1g7GPas+6B1iZOJgPMQowcGsJMK78PafZCHelMTKqtSi/Pii0pzU4kOM0hwsSuK8F7pOxgsJ
        pCeWpGanphakFsFkmTg4pRqYzqZ9K8vYrmq6w3uGotLS7RJ794c0JTTJOP8++ee38QdHb62N
        PxX689gXvXkscV6H9fphj2/xk9bzip14cSJNLuOWfpRM55J97Wqb3BdPv99sUaT5ZMcM1/iV
        Ad3ndja4yPt+evJ0D1tzdSlPV8ZZkepPvCvLyppDG2aGO+9fXeS7y3/poVymtJ1xDkVvdi7W
        PhAxQ9X+Z21UeVtr6vTsS9xNs6yWu3G3Hj+Z9WiR0fUD+cfLGYLfiW1nuMLKzRxbU9nnJneo
        7J+ql9Xy2etXNTff/rlBVmX65Mb5/YufrxGOl896rsdWESHCfXfLyby5v+x13rid9I982Hdo
        68rv5jMmify9Enqz7BDjPMV2JZbijERDLeai4kQA+OkOAc8CAAA=
X-CMS-MailID: 20230228092955epcas2p1a216cbd36ac26fd7d2ac6af2d3e83c9c
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_11d426_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513
References: <CGME20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513@epcas2p3.samsung.com>
        <20230220045709.94027-1-junhyeok.im@samsung.com>
        <Y/wXnZjhplI9AUvv@aschofie-mobl2>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_11d426_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Sun, Feb 26, 2023 at 06:38:21PM -0800, Alison Schofield wrote:
> On Mon, Feb 20, 2023 at 01:57:06PM +0900, Junhyeok Im wrote:
> > This series adds new ability to inject poison, including library update
> > and new command interface(inject-poison).
> 
> Hi Junhyeok,
> Nice to see this set, and sorry for the delay in trying it out. I'm
> using it now while prepping another version of the driver support 
> for inject and clear.
> 
> > 
> > Junhyeok Im (3):
> >   libcxl: add memdev inject poison support
> >   cxl: add inject-poison command to cxl tool
> >   Documentation: add man page documentation for inject-poison
> 
> The libcxl.sym and libclx.txt changes in the 3rd patch go better
> in the 1st patch that adds the libcxl support.
> 

Thank you Alison for your comments.
Since libcxl.sym changes are already in the 1st patch,
I will include libcxl.txt changes in the 1st patch of next series.

> > 
> >  Documentation/cxl/cxl-inject-poison.txt | 42 ++++++++++++++++++++
> >  Documentation/cxl/lib/libcxl.txt        |  4 ++
> >  Documentation/cxl/meson.build           |  1 +
> >  cxl/builtin.h                           |  1 +
> >  cxl/cxl.c                               |  1 +
> >  cxl/lib/libcxl.c                        | 26 ++++++++++++
> >  cxl/lib/libcxl.sym                      |  5 +++
> >  cxl/libcxl.h                            |  1 +
> >  cxl/memdev.c                            | 53 +++++++++++++++++++++++--
> >  9 files changed, 131 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/cxl/cxl-inject-poison.txt
> > 
> > 
> > base-commit: a88bdcfb4202c73aadfee6f83c5502eb5121cbd9
> > -- 
> > 2.34.1
> > 

------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_11d426_
Content-Type: text/plain; charset="utf-8"


------IPzR0Zmv7eUACe1AcPM4bhPiN.NxXwyEj5sj1OQa2HLEVOb4=_11d426_--
