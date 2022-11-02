Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93C21C433FE
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231802AbiKBQur (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232107AbiKBQua (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 12:50:30 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 255EE6378
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 09:50:19 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221102165018usoutp029fcad8bc7925d24e8aaaab1b7fba7f51~j0pO2S65P2100321003usoutp02g;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221102165018usoutp029fcad8bc7925d24e8aaaab1b7fba7f51~j0pO2S65P2100321003usoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667407818;
        bh=XEK6r/nT+boLJBJRw0k4TBenPR6SJtrwZ1RE4n+ScTE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZHWeqwq50NiJlUkuvJPj4T9mPSH/vb1xjrqQoVUISTUJd2AqhMs/b4CowRZc7mocT
         Fnc5E11Rkyu+RYviBdECKHe0mBaQb/KjpIFLPtdzxnnrhEfLecH0VsT0ULS8r7vEEe
         qma0lb6qC+Ol7oWSq3rDLiXIXVywOCXXDE9lU6/I=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221102165018uscas1p2093574618240f80a48aff223feef6b1e~j0pOvVu9J1225512255uscas1p2I;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 22.52.65516.ACF92636; Wed, 
        2 Nov 2022 12:50:18 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221102165018uscas1p1c30d87c92c1cdf4e4eb05cce141052f5~j0pOZKkwf0501005010uscas1p1s;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
X-AuditID: cbfec36d-59dff7000000ffec-2d-63629fcab8e8
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 84.97.19363.ACF92636; Wed, 
        2 Nov 2022 12:50:18 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Wed, 2 Nov 2022 09:50:17 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Wed,
        2 Nov 2022 09:50:17 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 1/2] libcxl: Add cxl_memdev_get_firmware_version
Thread-Topic: [PATCH 1/2] libcxl: Add cxl_memdev_get_firmware_version
Thread-Index: AQHY7tsve3L3Pj+XA0+4uDe8i18cvw==
Date:   Wed, 2 Nov 2022 16:50:17 +0000
Message-ID: <20221102165004.171776-2-fan.ni@samsung.com>
In-Reply-To: <20221102165004.171776-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SfUhTYRTGe++9266r2W2aHjWqrSBQXBlFM8OMpo0Kqj8Ey8DWdlNpm7Wr
        ZoW1TDNNRamlzUmr1D7MKCUtk2RGSn7markEy7IPLAU/moskze0a+N/vnPOc93k4vCQuzOL4
        k4naZFqnVajFXD5R1+LoCm67fli5rnMyWFpseI2kVe/vI2m3sY2Q9hW2YBGE/FbjECY3lJ6V
        T9Qs34sf4G9R0erEVFq3NvwQP+FvXRHv2MjitOxClR4NCnIRSQK1ATKHRLmITwqpuwgGz1Vi
        bJGFwUhpE8pFHm6Rqewylx1UI3jzsAqxxRgCfVk2hy0qEJQPXuW5VriUCJ7n1nNd7E3poLe2
        DHeJcOoRgo/v3rrf9aIiwPr9B86KIiGjyo6xLAGH+ae7T1Cr4anVgFxhBZQUMsz7XW0PKhTy
        e5oIFyPKB5xt992rOOULfV+uY2zsJXCztBFn2QemGz5xWRbBR+cQj9VLwG64wmU5CCpvsLaC
        2d1X174QrN4PLHfsc3yDBL1TyLIMMgsGeCwHgK3XMOd1Gjryutx3BCoTgfVc7dwgDKZz3s0Z
        e8LfP59RIVplnJfbOC+TcV4m47xMZkTcQ74pDKOJp5kQLX1Cwig0TIo2XqJM0tSg2Z/SPv1C
        8wQ96RuTNCOMRM0ISFzsLTjbGasUClSKk6doXVKcLkVNM80ogCTEvoIDJYFKIRWvSKaP0vQx
        Wvd/ipEe/nosrby9dSRBUlCfpwzf8KBc1ySvfjk64NzRoF3vs2ej5cqzTw9s6q/tDnP3AqWw
        XmTyUrVQ/W+eXwLphyzDi7GwnOye/O2hVetoU6Ijas2ZmMYOU+rwptC4bhHK58lWjvbypyzS
        pHyurUdmWzgQGyXp/VYd9MviWcoXec9sje6vNAdc0zZqsKUlx8UZ9vKHHl6RFzKW2enPDu9q
        v4qT4ytXpJct8gz8TeLJNTVMOudI+MHirt2kc6q2yK9lwZ6JiuESr4vj0jjZa+5UnlnVvDP6
        8bY6BWdmX+SPAkuCoqhQNtlqjVWb5NmyzSG7hjOTcP1t2/j5UHx3Q7+VI4kRE0yCIiQQ1zGK
        f+dPm26YAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOIsWRmVeSWpSXmKPExsWS2cA0UffU/KRkg48bhCymT73AaLH65hpG
        i/OzTrFY3JpwjMmBxWPxnpdMHlNn13t83iQXwBzFZZOSmpNZllqkb5fAlfF320T2grf8Fe0T
        UhoYH/N2MXJySAiYSMyZO5mti5GLQ0hgNaPEjZv/mCCcj4wSS9Z3MEI4Sxklft3azAjSwiag
        KLGvazsbiC0iUCRxffNcZpAiZoGNjBL3r10BKxIWcJC49PwVM0SRq0TT6htMELaexNcFr8Hi
        LAIqEjsvTQWq5+DgFbCQaFoQCRIWAjKPvf0CNoZTwFKi9+J+FhCbUUBM4vupNWBjmAXEJW49
        mc8E8YKAxJI955khbFGJl4//sULYihL3v79kh6jXk7gxdQobhK0tsWwhxAm8AoISJ2c+YYGo
        l5Q4uOIGywRG8VlIVsxC0j4LSfssJO0LGFlWMYqXFhfnplcUG+allusVJ+YWl+al6yXn525i
        BMbd6X+HI3cwHr31Ue8QIxMH4yFGCQ5mJRHe+rPRyUK8KYmVValF+fFFpTmpxYcYpTlYlMR5
        hVwnxgsJpCeWpGanphakFsFkmTg4pRqY7D/E3GQ8KyMas0Ha9uO6f9IvWCQL6g7ZnPYL7fXv
        f1K68a7qr9/fgx9KyhvU3f+boPb7lcufmGPf63cK9yiXvT/F2/vastHlzN+Etgr9Ny9lua/3
        nwo/875795UTKbO+qIu9md5449h1z5gp2z8l2n9od6liS999UTLCtkreYXOEsf5eebN/XQl2
        XG8LQn/O1PNPfPBD7tbmhPJFGj/kAr67aS3ZI7nfOs/uy99cwVr/04XKwsJhy/2WeR8zux7S
        N89ERqikfd6p8/rPJiUonL38J43rlWPY9Ynylx5NiM4OttH3+HZ9ZUOxZ8mJNxuLkjjrLZtL
        9a+pLJZm+b+9LiP625LsV8a9d68EsO5SYinOSDTUYi4qTgQAfdQabSoDAAA=
X-CMS-MailID: 20221102165018uscas1p1c30d87c92c1cdf4e4eb05cce141052f5
CMS-TYPE: 301P
X-CMS-RootMailID: 20221102165018uscas1p1c30d87c92c1cdf4e4eb05cce141052f5
References: <20221102165004.171776-1-fan.ni@samsung.com>
        <CGME20221102165018uscas1p1c30d87c92c1cdf4e4eb05cce141052f5@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

cxl_memdev_get_firmware_verison is a typo and part of the ABI.
Avoid breakage by introducing a stub with the correct name and update
the documentation accordingly.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 Documentation/cxl/lib/libcxl.txt | 2 +-
 cxl/libcxl.h                     | 8 ++++++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcx=
l.txt
index fd2962a..edc852d 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -68,7 +68,7 @@ int cxl_memdev_get_major(struct cxl_memdev *memdev);
 int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
-const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
 int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..d097026 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -48,6 +48,14 @@ struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *me=
mdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
+
+/* ABI spelling mistakes are forever */
+static inline const char *cxl_memdev_get_firmware_version(
+		struct cxl_memdev *memdev)
+{
+	return cxl_memdev_get_firmware_verison(memdev);
+}
+
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
 int cxl_memdev_enable(struct cxl_memdev *memdev);
--=20
2.25.1
