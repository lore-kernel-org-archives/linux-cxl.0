Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF4AC05027
	for <linux-cxl@archiver.kernel.org>; Mon, 20 Feb 2023 04:56:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbjBTE4N (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 19 Feb 2023 23:56:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjBTE4M (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 19 Feb 2023 23:56:12 -0500
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED86C646
        for <linux-cxl@vger.kernel.org>; Sun, 19 Feb 2023 20:56:07 -0800 (PST)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20230220045605epoutp04400371c1b9741400ecbbdbc4ebab1a61~Fb3CW220M1754517545epoutp04I
        for <linux-cxl@vger.kernel.org>; Mon, 20 Feb 2023 04:56:05 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20230220045605epoutp04400371c1b9741400ecbbdbc4ebab1a61~Fb3CW220M1754517545epoutp04I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1676868965;
        bh=39IiQ7oRkksZeq7cYm0LKZuY0ScNNMJ5Wa9QJ5QqWlM=;
        h=From:To:Cc:Subject:Date:References:From;
        b=UpMaq4EyhUsDgA5063CUQLf0QydMaewgbnIGNBYPEOGi8ISIWTU1g6NtAiuOQYBA4
         94dRxjLaq8efyp8fMyEAeo8DpkxuOoYq9UPKHsPAv7fQlDrOe6ciLxNBZRPlvYN1/Z
         gu5+g2KaFE2PCIFxVtMIPVagmSZALL7tp78nYbvc=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTP id
        20230220045605epcas2p36d2a83e3bf7d70a181cad751d85110f0~Fb3CC_96_1651616516epcas2p32;
        Mon, 20 Feb 2023 04:56:05 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4PKqr45N8Pz4x9Q0; Mon, 20 Feb
        2023 04:56:04 +0000 (GMT)
Received: from epcas2p2.samsung.com ( [182.195.41.54]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        39.0A.61927.46DF2F36; Mon, 20 Feb 2023 13:56:04 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513~Fb3A2hoam0473304733epcas2p3X;
        Mon, 20 Feb 2023 04:56:04 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20230220045603epsmtrp27e57f85c2f83cea2dc70e75b85b502a1~Fb3A1t6CS0918909189epsmtrp2I;
        Mon, 20 Feb 2023 04:56:03 +0000 (GMT)
X-AuditID: b6c32a45-8bdf87000001f1e7-3b-63f2fd647bc8
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        EB.50.17995.36DF2F36; Mon, 20 Feb 2023 13:56:03 +0900 (KST)
Received: from dell-ArcherCity.dsn.sec.samsung.com (unknown [10.229.83.212])
        by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20230220045603epsmtip2fb76d63f560b72c64a9bc62a73fb9c26~Fb3AoFbw32919129191epsmtip2a;
        Mon, 20 Feb 2023 04:56:03 +0000 (GMT)
From:   Junhyeok Im <junhyeok.im@samsung.com>
To:     linux-cxl@vger.kernel.org
Cc:     dan.j.williams@intel.com, vishal.l.verma@intel.com,
        bwidawsk@kernel.org, alison.schofield@intel.com,
        Junhyeok Im <junhyeok.im@samsung.com>
Subject: [ndctl 0/3] Support for inject poison
Date:   Mon, 20 Feb 2023 13:57:06 +0900
Message-Id: <20230220045709.94027-1-junhyeok.im@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrKKsWRmVeSWpSXmKPExsWy7bCmmW7K30/JBq9uS1rcfXyBzaJ58mJG
        i+lTLzBaLD46g9ni/KxTLBa3JhxjcmDzWLznJZPHplWdbB59W1YxenzeJBfAEpVtk5GamJJa
        pJCal5yfkpmXbqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQO0XEmhLDGnFCgUkFhc
        rKRvZ1OUX1qSqpCRX1xiq5RakJJTYF6gV5yYW1yal66Xl1piZWhgYGQKVJiQnbF4ZzNrwUX2
        iuMd01kbGKezdjFyckgImEi0nf/E0sXIxSEksINRYvLCF1DOJ0aJzwuOMkI4nxklfiw7Dtey
        4/kbVojELkaJiR++Q7U0MklMf7eEEaSKTUBb4m//dDBbREBWonndAyaQImaBCYwSS+ceZAZJ
        CAvoSVw8/IGti5GDg0VAVWLNVGGQMK+AjcStJQfYILbJS+w/eJYZIi4ocXLmExYQmxko3rx1
        NjPITAmBXewSkzYvZodocJE4dPY/C4QtLPHq+BaouJTE53d7oYbmS0w9OBEqXiLRduYAlG0s
        8e7mc1aQe5gFNCXW79IHMSUElCWO3IJayyfRcfgvO0SYV6KjTQiiUVViy4YXUEOkJY5O3AR1
        gIfEpLk9TCC2kECsxLHbU1gnMMrPQvLMLCTPzELYu4CReRWjWGpBcW56arFRgSE8UpPzczcx
        gtOflusOxslvP+gdYmTiYDzEKMHBrCTCK33oQ7IQb0piZVVqUX58UWlOavEhRlNg6E5klhJN
        zgcm4LySeEMTSwMTMzNDcyNTA3MlcV5p25PJQgLpiSWp2ampBalFMH1MHJxSDUwpE3TOfnDz
        t3C/vH89n8H7iwnT1iQkBZxg37OrmtN6W3CmuVYCi07jfFs9kbBjs0SelJYZ3XlZvML5i9Ol
        m6sZlLL+VzzfHr5cozi0/1Flnv385U1rt79rzqr55zahxTdBetoqnimerDr2txzk1u9mv/re
        wtinfs8yrsnzvrGxPLmRJCbrceBUbnNZxSnl9+nXfCZa3s7d4LLYTd54R2T89bw3RRvit51c
        Kr0k98dBOWvT/5e5H1/7vN2/npP/8eO3Jbt/bT5o/av1peYpMSeeybZ6n7InfjIQYq1bOt1o
        fgNb3E6j1RH6l09Gm8tfrHulI9fVK7wjYsLGm2qxG9+oay6R8Fi0VHdC95YtjAeVWIozEg21
        mIuKEwEifVFpCAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCLMWRmVeSWpSXmKPExsWy7bCSvG7y30/JBrf+m1ncfXyBzaJ58mJG
        i+lTLzBaLD46g9ni/KxTLBa3JhxjcmDzWLznJZPHplWdbB59W1YxenzeJBfAEsVlk5Kak1mW
        WqRvl8CVsXhnM2vBRfaK4x3TWRsYp7N2MXJySAiYSOx4/gbI5uIQEtjBKHF39hxmiIS0xI1H
        XWwQtrDE/ZYjUEX/GSVWzlsHlmAT0Jb42z+dEcQWEZCVaF73gAnEZhaYxiixfW8iiC0soCdx
        8fAHoHoODhYBVYk1U4VBwrwCNhK3lhyAmi8vsf/gWWaIuKDEyZlPWCDGyEs0b53NPIGRbxaS
        1CwkqQWMTKsYJVMLinPTc4sNC4zyUsv1ihNzi0vz0vWS83M3MYIDUktrB+OeVR/0DjEycTAe
        YpTgYFYS4ZU+9CFZiDclsbIqtSg/vqg0J7X4EKM0B4uSOO+FrpPxQgLpiSWp2ampBalFMFkm
        Dk6pBqZmN1eh46s7Iwxs15hlfTLZMUFFoSs8WblS50RzYUvPdKUQm6XljYKBMy+9mX+03ndi
        YE2fq+iRfZWfD6jdauyOnlJwIbapnUHePJbnHBdLzYffxnm/hS8yO5SuvsuixbaQtede8r5f
        PY8PtnptDJva6ffxqqmN8MV109n7JosvlnK0WvD/xq45Lsttwg9INd9T19Zh3xj4/JdFcdvC
        paHzUvJP1InocsoeLWXfa7Dvwi/bpdXdC8rYnzn2fT3ze5OxBV/uAV+Z2unCiicW5qcw6GUr
        iuZnCXnaWKZocu0PXvVSsKDN0JVTjU//zW2eKKYmgzrTh/dVVsounK+yJjr67HnVAzke6uZ2
        +zcrsRRnJBpqMRcVJwIAHzvq4rcCAAA=
X-CMS-MailID: 20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513
References: <CGME20230220045604epcas2p3bc0b1fb688c48ec0b8ae2512adba3513@epcas2p3.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This series adds new ability to inject poison, including library update
and new command interface(inject-poison).

Junhyeok Im (3):
  libcxl: add memdev inject poison support
  cxl: add inject-poison command to cxl tool
  Documentation: add man page documentation for inject-poison

 Documentation/cxl/cxl-inject-poison.txt | 42 ++++++++++++++++++++
 Documentation/cxl/lib/libcxl.txt        |  4 ++
 Documentation/cxl/meson.build           |  1 +
 cxl/builtin.h                           |  1 +
 cxl/cxl.c                               |  1 +
 cxl/lib/libcxl.c                        | 26 ++++++++++++
 cxl/lib/libcxl.sym                      |  5 +++
 cxl/libcxl.h                            |  1 +
 cxl/memdev.c                            | 53 +++++++++++++++++++++++--
 9 files changed, 131 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/cxl/cxl-inject-poison.txt


base-commit: a88bdcfb4202c73aadfee6f83c5502eb5121cbd9
-- 
2.34.1

