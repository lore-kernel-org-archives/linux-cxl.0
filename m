Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F9E9ECAAA1
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 17:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbiJ1R74 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 13:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiJ1R7l (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 13:59:41 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D13260E
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 10:59:32 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221028175930usoutp026945037ef5baacaef10967d1d5c8d29e~iTXN3CWhN2400024000usoutp02I;
        Fri, 28 Oct 2022 17:59:30 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221028175930usoutp026945037ef5baacaef10967d1d5c8d29e~iTXN3CWhN2400024000usoutp02I
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1666979970;
        bh=NjE8dK1Kpd30SJt/A6l2UMfF8jA/8Ub9Tgj7N4q3p8Q=;
        h=From:To:CC:Subject:Date:References:From;
        b=eWfJKxV/goeKjxPbrYKBIIZ/s7F5cCbSv8T42cgc9MG0eTY9RduhtBv8fdEcwvzBy
         T3b6TlWw4jX9oBpYYZzBn16ZB8hc+gc5egruimpd9tbM4e4mzgjFvCLLMoWJd8k6bo
         KYKCmWDkgQgzHFm9q7UAKGiU/FQMAuYOHTXXIJ1w=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221028175930uscas1p214f48db449468fb9dfeb0a31f066a558~iTXNvHtgn1293012930uscas1p2D;
        Fri, 28 Oct 2022 17:59:30 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id E6.1C.35398.2881C536; Fri,
        28 Oct 2022 13:59:30 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f~iTXNdXG8A0088800888uscas1p1X;
        Fri, 28 Oct 2022 17:59:29 +0000 (GMT)
X-AuditID: cbfec370-817ff70000028a46-b0-635c18824f06
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 0A.41.36264.1881C536; Fri,
        28 Oct 2022 13:59:29 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 28 Oct 2022 10:59:28 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        28 Oct 2022 10:59:28 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH] cxl: Fix some naming typos
Thread-Topic: [ndctl PATCH] cxl: Fix some naming typos
Thread-Index: AQHY6vcF3+3pzDpW2kC/Zp5jFYLl5A==
Date:   Fri, 28 Oct 2022 17:59:28 +0000
Message-ID: <20221028175752.27879-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrDIsWRmVeSWpSXmKPExsWy7djXc7pNEjHJBu9381hMn3qB0eL8rFMs
        FrcmHGNyYPZYvOclk8fnTXIBTFFcNimpOZllqUX6dglcGYtWrGMtmCZWsfRDYgPjJOEuRg4O
        CQETiRczfLsYuTiEBFYyStx99oQVwmllkrizppG9i5ETrGjn0gUsILaQwFpGicfNURBFnxgl
        5i3dzQbhLGOUOPP8HTNIFZuAosS+ru1sILaIQJHE9c1zmUGKmAXWM0pMufEALCEsYCix8dd9
        RogiM4mO5++ZIGw9icur54LFWQRUJe62HQJbzStgLtHw+jUriM0oICbx/dQasHpmAXGJW0/m
        M0GcKiixaPYeZghbTOLfrodsELaixP3vL9kh6vUkbkydwgZha0ssW/iaGWK+oMTJmU9YIOol
        JQ6uuMECcrSEwE92iS1n9jBCJFwk1ix8AFUkLfH37jKoxdUSZ3rOMUE0tDBKXGrcDHWFtcS/
        zmtQm/kk/v56xAgJeV6JjjahCYxKs5D8MAvJfbOQ3DcLyX0LGFlWMYqXFhfnpqcWG+ellusV
        J+YWl+al6yXn525iBCaQ0/8OF+xgvHXro94hRiYOxkOMEhzMSiK89Wejk4V4UxIrq1KL8uOL
        SnNSiw8xSnOwKInzRs3QShYSSE8sSc1OTS1ILYLJMnFwSjUwdWjPDE+vd5wk/sk/znpn+8OE
        xhWTj203fvdC1fNYuZf1yhXrOT4zqNwS8LrF5PiO5e2adzt+MzK322+0m/dysdlEjVfZmmsP
        Vu1hzKyO8V+y7PP9dety+/SeCOy7N2memKjuPss25g2WAtPST1gpTfCuVFK8rCT5JVbQ3WSx
        +s/CG/7993l+PTBuWHD8j5nsKra5fzqM9nXdMf3BHO5uJbWXnb85/J103ur1HV0MbOmzp2cs
        U9dh7Kos2WCj5Rqi2c/FL248T3bvhQjl45Vnu6+mnlFeqBIu4VmX/Mk/co5coLThwoDs42EL
        LQ2+H9aTeMAhv01A6+XqVfJewl+lVi8zOuu98qLuncfrzz1XYinOSDTUYi4qTgQADgzFx48D
        AAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrOLMWRmVeSWpSXmKPExsWS2cA0UbdRIibZYNUMY4vpUy8wWpyfdYrF
        4taEY0wOzB6L97xk8vi8SS6AKYrLJiU1J7MstUjfLoErY9GKdawF08Qqln5IbGCcJNzFyMkh
        IWAisXPpApYuRi4OIYHVjBKHZj9jhXA+MUpMb/jIBuEsY5T42NjECtLCJqAosa9rOxuILSJQ
        JHF981xmkCJmgfWMElNuPABLCAsYSmz8dZ8RoshMouP5eyYIW0/i8uq5YHEWAVWJu22HWEBs
        XgFziYbXr8EWMAqISXw/tQasnllAXOLWk/lMELcKSCzZc54ZwhaVePn4HyuErShx//tLdoh6
        PYkbU6ewQdjaEssWvmaGmC8ocXLmExaIekmJgytusExgFJ2FZMUsJO2zkLTPQtK+gJFlFaN4
        aXFxbnpFsVFearlecWJucWleul5yfu4mRmDcnP53OHoH4+1bH/UOMTJxMB5ilOBgVhLhrT8b
        nSzEm5JYWZValB9fVJqTWnyIUZqDRUmc92XUxHghgfTEktTs1NSC1CKYLBMHp1QDk+r0o573
        ktrfN7uXtO++JFDgXy5vuTOXbVXK/ogrJR9c73lzzRK1nPPGz4VBfL1+0Ukx3+93Fu03yftv
        XLjDMFM7a8GvT1sXyaVOYcsOvTZD++KxRxp9H+XXrqjYrh+t/2iueUrtkmux1vX5P7mfrZ48
        72fAm6U2hUeEl2/4qfuQ4+A7mUirWdnXXtRfrvTUml4S/72p/9PVTcEmfWGOBUbnpM/Kyf6d
        dP15+HQxzuols/e1yfRN2NNu6PNX4bnFB+F3IRHndISulM3jaBXKquwuzHYTeMQ2cW/zV4HM
        hoc9j7uzV3Vmr/0Xs+/llocsphPtV17xuzxTvXlv5M9/c3MfTi9LCP24M3jRtK8K1UosxRmJ
        hlrMRcWJAI294WcKAwAA
X-CMS-MailID: 20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f
CMS-TYPE: 301P
X-CMS-RootMailID: 20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f
References: <CGME20221028175929uscas1p1c78e5cd1b684f0b9a79302b8bc769a4f@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The function for retrieving firmware version is named
`cxl_memdev_get_firmware_verison`, updated to `cxl_memdev_get_firmware_vers=
ion'.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 Documentation/cxl/lib/libcxl.txt | 2 +-
 cxl/lib/libcxl.c                 | 2 +-
 cxl/lib/libcxl.sym               | 2 +-
 cxl/libcxl.h                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

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
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d44..b7ad263 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1262,7 +1262,7 @@ CXL_EXPORT unsigned long long cxl_memdev_get_ram_size=
(struct cxl_memdev *memdev)
 	return memdev->ram_size;
 }
=20
-CXL_EXPORT const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *=
memdev)
+CXL_EXPORT const char *cxl_memdev_get_firmware_version(struct cxl_memdev *=
memdev)
 {
 	return memdev->firmware_version;
 }
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e0..febbca6 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -19,7 +19,7 @@ global:
 	cxl_memdev_get_ctx;
 	cxl_memdev_get_pmem_size;
 	cxl_memdev_get_ram_size;
-	cxl_memdev_get_firmware_verison;
+	cxl_memdev_get_firmware_version;
 	cxl_cmd_get_devname;
 	cxl_cmd_new_raw;
 	cxl_cmd_set_input_payload;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..c3c99b8 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -47,7 +47,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
-const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
 int cxl_memdev_enable(struct cxl_memdev *memdev);
--=20
2.25.1
