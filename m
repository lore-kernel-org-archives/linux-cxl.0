Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 053DAC77B75
	for <linux-cxl@archiver.kernel.org>; Tue,  9 May 2023 09:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbjEIJUG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 9 May 2023 05:20:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234929AbjEIJUF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 9 May 2023 05:20:05 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BA1DE702
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 02:19:53 -0700 (PDT)
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230509091950epoutp04c7c4176cd0ceda181a700a82fe084584~dbxl3HSZw2638926389epoutp04F
        for <linux-cxl@vger.kernel.org>; Tue,  9 May 2023 09:19:50 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230509091950epoutp04c7c4176cd0ceda181a700a82fe084584~dbxl3HSZw2638926389epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683623990;
        bh=ZSu+pwQl9lMFcUupiNYpxc3azXOUoB5dczdS4yE4kM8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MbwTaQWbrHzvxpz18r87di/ogn6fNIKtolbkgg0goWI+FWKzOHdCC6DPSJ5DMxLMI
         YAH5flK7sOEgUXPfh4Yb4F/tiJcj8u0gAZ3TlA/rC8+r2jIewzy7pWUPCI1Wj8HA0I
         5sLOVlwxmsRoTiMZd37aqrla0mto6dcMgp0fNQv4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTP id
        20230509091950epcas2p1d0291d77de3f1bbbc585cda26fee267d~dbxlhTBn91672116721epcas2p19;
        Tue,  9 May 2023 09:19:50 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.91]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4QFt0P6fX5z4x9Q3; Tue,  9 May
        2023 09:19:49 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C9.BF.03265.5301A546; Tue,  9 May 2023 18:19:49 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20230509091949epcas2p49756506b70e9d14094a42ec2cd90cf20~dbxkPxce31686316863epcas2p4M;
        Tue,  9 May 2023 09:19:49 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20230509091949epsmtrp151b775e9b361ef356380c639d4f716be~dbxkPKUDK1606316063epsmtrp1j;
        Tue,  9 May 2023 09:19:49 +0000 (GMT)
X-AuditID: b6c32a45-465ff70000020cc1-d4-645a1035337d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EC.F9.28392.5301A546; Tue,  9 May 2023 18:19:49 +0900 (KST)
Received: from dell-ArcherCity (unknown [10.229.83.212]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230509091948epsmtip2cadda762b7b927a3ebdd822c94f46a4a~dbxkGNNfk1195611956epsmtip2i;
        Tue,  9 May 2023 09:19:48 +0000 (GMT)
Date:   Tue, 9 May 2023 18:19:52 +0900
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     "Verma, Vishal L" <vishal.l.verma@intel.com>
Cc:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "Schofield, Alison" <alison.schofield@intel.com>
Subject: Re: [ndctl 0/3] Support for inject poison
Message-ID: <ZFoQOBnrX8ukE/o0@dell-ArcherCity>
MIME-Version: 1.0
In-Reply-To: <eb792ae37ebe68dee94d7445084ff99855f0268f.camel@intel.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTVNdUICrFYPZdU4u7jy+wWTRPXsxo
        MX3qBUaL87NOsVjcmnCMyYHVY/Gel0wem1Z1snl83iQXwByVbZORmpiSWqSQmpecn5KZl26r
        5B0c7xxvamZgqGtoaWGupJCXmJtqq+TiE6DrlpkDtFJJoSwxpxQoFJBYXKykb2dTlF9akqqQ
        kV9cYquUWpCSU2BeoFecmFtcmpeul5daYmVoYGBkClSYkJ0x73R9wROBirUrbzE1MDbxdTFy
        ckgImEg8mH2GtYuRi0NIYAejxLHu/8wQzidGiQPnF7BBOJ8ZJT707mCEadly8yZUyy5GiUUN
        76Ba3jJKTD++gwWkikVARWLdz3esIDabgLbE3/7pYN0iAgYS22etZQRpYBY4wygxYdofJpCE
        sICRxNXOj2A2r4CexN5rh1khbEGJkzOfgA3lFHCXOPt2NwtIs4TAPXaJuW/XsEDc5CLxeO9b
        dghbWOLV8S1QtpTEy/42KDtfYurBiVB2iUTbmQNQtrHEu5vPwZYxC2RIXGl6C/Q0B1BcWeLI
        LRaIMJ9Ex+G/7BBhXomONiGITlWJLRteQE2Rljg6cRPUNR4Sk+b2MEEC5SyjxJ4bP9knMMrN
        QvLOLCTbIGw9iRtTp0DZ8hLNW2czzwJaxww0d/k/DghTU2L9Lv0FjGyrGMVSC4pz01OLjQoM
        4bGdnJ+7iRGcHLVcdzBOfvtB7xAjEwfjIUYJDmYlEd5VCWEpQrwpiZVVqUX58UWlOanFhxhN
        gRE1kVlKNDkfmJ7zSuINTSwNTMzMDM2NTA3MlcR5pW1PJgsJpCeWpGanphakFsH0MXFwSjUw
        pS0UMj3HNllKwNgv6Z2LzHPV2/LLP17iq02T6mJl51LeJt+61sxAofZRoj7znYK5N1fy3r5+
        4JSz7sKy5Zy3LdV7n+aqK1xtFM16ICAuzG7bflHwZ1z+5jMcG4QXrToaKKWydV4vV/9lldtq
        NRNmaf4/3rB+d9XGKB8Hz9Ui+73Puv3u+tMbcFfexP22T6yv/rUpC639Ll7fwxRzYHXDJZH7
        0WZ7fufNOsW2vPGpQ8fq9vrF9ibHvv5ortd4EL5RcevZ42IOZ1fOW/a3bpU5v2j3xk9SbN8v
        6ul+PPatXEb7hlxN0vO37RFpL5cn3d27atoLFvX9L7LYlB3b9jP9WH92xYPDd859Vr1eGjNv
        hhJLcUaioRZzUXEiALnv2xwXBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOLMWRmVeSWpSXmKPExsWy7bCSvK6pQFSKwYb3zBZ3H19gs2ievJjR
        YvrUC4wW52edYrG4NeEYkwOrx+I9L5k8Nq3qZPP4vEkugDmKyyYlNSezLLVI3y6BK6Nx2mPG
        gka+ipk/mtgaGHdzdzFyckgImEhsuXmTtYuRi0NIYAejxLk/TxghEtISNx51sUHYwhL3W45A
        Fb1mlHjRsJ0JJMEioCKx7uc7VhCbTUBb4m//dLBmEQEDie2z1jKCNDALnGOUOLGhlxkkISxg
        JHG18yNYM6+AnsTea4ehpp4FWn1qAzNEQlDi5MwnLCA2s4COxM6td4DO4ACypSWW/+OACMtL
        NG+dDVbOKeAucfbtbpYJjIKzkHTPQtI9C6F7FpLuBYwsqxglUwuKc9Nziw0LjPJSy/WKE3OL
        S/PS9ZLzczcxgsNeS2sH455VH/QOMTJxMB5ilOBgVhLhXZUQliLEm5JYWZValB9fVJqTWnyI
        UZqDRUmc90LXyXghgfTEktTs1NSC1CKYLBMHp1QD0y7jr19WXNvaHLTa+9jlA4bBOz+4hn1a
        n3qI6+PcurvTU62eTa+bfsm9ZWfCV+Wl8umn1sZUvd//4A/jh4kdZ+M5zolmCt7XettzfHu/
        prxpuYGbwSqFPeUKeVuTH2YHa/T+77L0Yep4FTP1WU/F1GtdOf2nhJnbppd5difMEgzkWJy+
        8Pr0C3PeHeFR9Yy9GT53dk6h+95T+zO2y/e9Np276oPIOUlGmzOK0TJhBy3ltbPu8OecfBfH
        379ZNzL1Xf6D27dUdH3e8MxaVal7NverddvOcmWOewG34w0dy6rO9y66kTO15SJPVcDZq5Nj
        u/LkmXTSDrZ+Z4hes1Prq398oKbvkjeTfq86f/CalhJLcUaioRZzUXEiAMs9XIHqAgAA
X-CMS-MailID: 20230509091949epcas2p49756506b70e9d14094a42ec2cd90cf20
X-Msg-Generator: CA
Content-Type: multipart/mixed;
        boundary="----1dbzyif4j0YpjGqSLVGfmJjuaj1ZP5WSi6pSpGWKIR8.wATe=_e4ddb_"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513
References: <CGME20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513@epcas2p3.samsung.com>
        <20230220045709.94027-1-junhyeok.im@samsung.com>
        <eb792ae37ebe68dee94d7445084ff99855f0268f.camel@intel.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

------1dbzyif4j0YpjGqSLVGfmJjuaj1ZP5WSi6pSpGWKIR8.wATe=_e4ddb_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline

On Mon, May 08, 2023 at 06:39:39PM +0000, Verma, Vishal L wrote:
> On Mon, 2023-02-20 at 13:57 +0900, Junhyeok Im wrote:
> > This series adds new ability to inject poison, including library update
> > and new command interface(inject-poison).
> 
> Hi Junhyeok,
> 
> With the now queued for the 6.4 kernel, the userspace side of this can
> also target the next ndctl release, v78.
> 
> I see these patches will at least need a bit of rework to move from the
> sysfs interface to the new debugfs interface.
> 
> Did you have a new revision of these in progress?
> 

Hi Vishal,

Thank you for confirming.
Yes, I recently found the history including Alison's inject/clear poison patch.
I am now reworking the previous patch including debugfs modification,
and I think I can submit a new patch soon including clear poison interface.

Thanks!

> > 
> > Junhyeok Im (3):
> >   libcxl: add memdev inject poison support
> >   cxl: add inject-poison command to cxl tool
> >   Documentation: add man page documentation for inject-poison
> > 
> >  Documentation/cxl/cxl-inject-poison.txt | 42 ++++++++++++++++++++
> >  Documentation/cxl/lib/libcxl.txt        |  4 ++
> >  Documentation/cxl/meson.build           |  1 +
> >  cxl/builtin.h                           |  1 +
> >  cxl/cxl.c                               |  1 +
> >  cxl/lib/libcxl.c                        | 26 ++++++++++++
> >  cxl/lib/libcxl.sym                      |  5 +++
> >  cxl/libcxl.h                            |  1 +
> >  cxl/memdev.c                            | 53 +++++++++++++++++++++++--
> >  9 files changed, 131 insertions(+), 3 deletions(-)
> >  create mode 100644 Documentation/cxl/cxl-inject-poison.txt
> > 
> > 
> > base-commit: a88bdcfb4202c73aadfee6f83c5502eb5121cbd9
> 

------1dbzyif4j0YpjGqSLVGfmJjuaj1ZP5WSi6pSpGWKIR8.wATe=_e4ddb_
Content-Type: text/plain; charset="utf-8"


------1dbzyif4j0YpjGqSLVGfmJjuaj1ZP5WSi6pSpGWKIR8.wATe=_e4ddb_--
