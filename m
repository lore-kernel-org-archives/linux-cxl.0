Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA24C38A02
	for <linux-cxl@archiver.kernel.org>; Fri, 28 Oct 2022 23:58:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229681AbiJ1X6O (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 28 Oct 2022 19:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ1X55 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 28 Oct 2022 19:57:57 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C2C1BA1C2
        for <linux-cxl@vger.kernel.org>; Fri, 28 Oct 2022 16:57:55 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20221028235753usoutp0240db122afd0caa89ae5abed29a7572e2~iYQH6344H2083620836usoutp025;
        Fri, 28 Oct 2022 23:57:53 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20221028235753usoutp0240db122afd0caa89ae5abed29a7572e2~iYQH6344H2083620836usoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667001473;
        bh=+ZZudy7Jo0FAl5/LL54Sx2uGG4DiwagkS0mcQhSIxIU=;
        h=From:To:CC:Subject:Date:References:From;
        b=Zeo45dJheSakbydsZIsV4rOmaLsA3vMTPsgE1SAj/G0gDAQGlOc9g1Px2Z7SHiC1R
         HU1yboseyAElj73KKulO3fPpny9O9fhXekAp8xP41ZvDssYlTfvFOc2ntj9AeMLamq
         GZMStv8JW/iRdNts7a4k6qBe3/CwaqPBCPA2BEmI=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221028235752uscas1p2a5975dfee0f45ca9c34295114f0f8227~iYQHgHkzQ2374823748uscas1p28;
        Fri, 28 Oct 2022 23:57:52 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 5A.16.65516.08C6C536; Fri,
        28 Oct 2022 19:57:52 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b~iYQGyD50w0122001220uscas1p1c;
        Fri, 28 Oct 2022 23:57:51 +0000 (GMT)
X-AuditID: cbfec36d-5b5ff7000000ffec-6d-635c6c8049d3
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id EF.77.32876.F7C6C536; Fri,
        28 Oct 2022 19:57:51 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Fri, 28 Oct 2022 16:57:51 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Fri,
        28 Oct 2022 16:57:51 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>
CC:     "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Davidlohr Bueso <d.bueso@samsung.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Topic: [ndctl PATCH] Adding cxl_memdev_get_firmware_version
Thread-Index: AQHY6ykWpXsE/hQsVUualGBz0TCrfg==
Date:   Fri, 28 Oct 2022 23:57:51 +0000
Message-ID: <20221028235705.32890-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsWy7djX87oNOTHJBlePalhMn3qB0eL8rFMs
        FrcmHGNyYPZYvOclk8fnTXIBTFFcNimpOZllqUX6dglcGRMe5hfsE63oPnGIsYFxr1AXIyeH
        hICJxP7X35i6GLk4hARWMko8Pj6JBSQhJNDKJPHunlUXIwdY0fy17hA1axklri68yw7hfGKU
        aJg9gRHCWcYoMXvydjaQbjYBRYl9XRC2iECRxPXNc5lBipgF1jNKTLnxACwhLGArsfPNFKgi
        J4mDSzZA2XoS3ZtngNksAqoS/54sYQexeQXMJV5eawGLMwqISXw/tYYJxGYWEJe49WQ+E8Q/
        ghKLZu9hhrDFJP7tesgGYStK3P/+kh2iXk/ixlSIvcwC2hLLFr5mhpgvKHFy5hMWiHpJiYMr
        brCAHC0h8JddYsmxpcyQsHCRmLe3AqJGWmL6mstQ9dUSZ3rOMUHUtzBKXGrcDHWEtcS/zmtQ
        i/kk/v56xAgxh1eio01oAqPSLCQvzEJy3iwk581Cct4CRpZVjOKlxcW56anFhnmp5XrFibnF
        pXnpesn5uZsYgenj9L/DuTsYd9z6qHeIkYmD8RCjBAezkghv/dnoZCHelMTKqtSi/Pii0pzU
        4kOM0hwsSuK8UTO0koUE0hNLUrNTUwtSi2CyTBycUg1MZR2hhqvCm6pentYKrXFZF+nq8s5l
        4zKJVV3eFxhSQ6bzHzvDyPx+SnvbceMtTjzZc/OSl3AZGgf028aH3DivXJdjb/v0p/HBDfU7
        vOb6nUvJ5zb/W+261bwpNUaieJl6/14OvsszTTd5P9u7ezL/ok5Rlfal7DYxC53nZgodiswu
        2XYt597fVWy+n/kPcdyZXl9wdPVLlZu9Lf+6a29v/1L28dw3t+jZd47YlDz+W5XEuOjvh+1b
        Zjz5mCG3vnPZ0Wcq8z3DZ29wvneh+OovCw6LqYtr4yOSbiszijtd9jjisTq9uEjzs+/7qIrl
        /Ex6Wa+/N6/ul5n0xlr/cu/5bScs1n2Nqt60r5hVeepiJZbijERDLeai4kQAHx7cWY4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGLMWRmVeSWpSXmKPExsWS2cA0Ubc+JybZYP5nE4vpUy8wWpyfdYrF
        4taEY0wOzB6L97xk8vi8SS6AKYrLJiU1J7MstUjfLoErY8LD/IJ9ohXdJw4xNjDuFepi5OCQ
        EDCRmL/WvYuRi0NIYDWjxP7XLxghnE+MEl9/z2aHcJYxSvT938LcxcjJwSagKLGvazsbiC0i
        UCRxffNcZpAiZoH1jBJTbjwASwgL2ErsfDMFqshJ4uCSDVC2nkT35hlgNouAqsS/J0vYQWxe
        AXOJl9dawOKMAmIS30+tYQKxmQXEJW49mQ9mSwgISCzZc54ZwhaVePn4HyuErShx//tLdoh6
        PYkbUyH2MgtoSyxb+JoZYr6gxMmZT1gg6iUlDq64wTKBUXQWkhWzkLTPQtI+C0n7AkaWVYzi
        pcXFuekVxcZ5qeV6xYm5xaV56XrJ+bmbGIFRc/rf4ZgdjPdufdQ7xMjEwXiIUYKDWUmEt/5s
        dLIQb0piZVVqUX58UWlOavEhRmkOFiVxXo/YifFCAumJJanZqakFqUUwWSYOTqkGpjPzXc+0
        bpqpuvnOdB/3NrlQoyXtmq/ibs6O3H7JJkJWIqN06ac/D9/NXlZy9QH/g+MXHBqD7vYdnx7e
        8GHS4rVyEX+D5vP8CYmddbP23L1ipWlLq40L/7Ysf5zxT02J0ULYS/6i28m/X7/wOxZZMy58
        1/44gtVh35azuhcFwx0yBDzu6z//H34v3/dCATeD1tyC2U8EJRlkfNh8kooXn066ePOOEA/7
        60P/3N5xfX95qexdz/d04Txx1oA1r8NKGIxfb3BmUHrzSfHpxWSb44bTnC+p2rJt+Pr97pT/
        AstX5+/87BUuf8Hky7wN1YG9987+XXpQeMK1GuOKDR+Etu1nKC3ZOofZ4sba+n4Du+VKLMUZ
        iYZazEXFiQBln403CQMAAA==
X-CMS-MailID: 20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b
CMS-TYPE: 301P
X-CMS-RootMailID: 20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b
References: <CGME20221028235751uscas1p1f5e84bab0e196e19610ec68373e09e4b@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The function for retrieving firmware version is named
`cxl_memdev_get_firmware_verison`, updated to
`cxl_memdev_get_firmware_version'.
keeping `cxl_memdev_get_firmware_verison` for library compatibility.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 Documentation/cxl/lib/libcxl.txt | 1 +
 cxl/lib/libcxl.c                 | 5 +++++
 cxl/lib/libcxl.sym               | 5 +++++
 cxl/libcxl.h                     | 1 +
 4 files changed, 12 insertions(+)

diff --git a/Documentation/cxl/lib/libcxl.txt b/Documentation/cxl/lib/libcx=
l.txt
index fd2962a..5a8d980 100644
--- a/Documentation/cxl/lib/libcxl.txt
+++ b/Documentation/cxl/lib/libcxl.txt
@@ -69,6 +69,7 @@ int cxl_memdev_get_minor(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_nvdimm_bridge_active(struct cxl_memdev *memdev);
 int cxl_memdev_get_numa_node(struct cxl_memdev *memdev);
diff --git a/cxl/lib/libcxl.c b/cxl/lib/libcxl.c
index e8c5d44..1b7e9d2 100644
--- a/cxl/lib/libcxl.c
+++ b/cxl/lib/libcxl.c
@@ -1267,6 +1267,11 @@ CXL_EXPORT const char *cxl_memdev_get_firmware_veris=
on(struct cxl_memdev *memdev
 	return memdev->firmware_version;
 }
=20
+CXL_EXPORT const char *cxl_memdev_get_firmware_version(struct cxl_memdev *=
memdev)
+{
+	return memdev->firmware_version;
+}
+
 static void bus_invalidate(struct cxl_bus *bus)
 {
 	struct cxl_ctx *ctx =3D cxl_bus_get_ctx(bus);
diff --git a/cxl/lib/libcxl.sym b/cxl/lib/libcxl.sym
index 8bb91e0..d46c50e 100644
--- a/cxl/lib/libcxl.sym
+++ b/cxl/lib/libcxl.sym
@@ -217,3 +217,8 @@ global:
 	cxl_decoder_get_max_available_extent;
 	cxl_decoder_get_region;
 } LIBCXL_2;
+
+LIBCXL_4 {
+global:
+	cxl_memdev_get_firmware_version;
+} LIBCXL_3;
diff --git a/cxl/libcxl.h b/cxl/libcxl.h
index 9fe4e99..7951e78 100644
--- a/cxl/libcxl.h
+++ b/cxl/libcxl.h
@@ -48,6 +48,7 @@ struct cxl_ctx *cxl_memdev_get_ctx(struct cxl_memdev *mem=
dev);
 unsigned long long cxl_memdev_get_pmem_size(struct cxl_memdev *memdev);
 unsigned long long cxl_memdev_get_ram_size(struct cxl_memdev *memdev);
 const char *cxl_memdev_get_firmware_verison(struct cxl_memdev *memdev);
+const char *cxl_memdev_get_firmware_version(struct cxl_memdev *memdev);
 size_t cxl_memdev_get_label_size(struct cxl_memdev *memdev);
 int cxl_memdev_disable_invalidate(struct cxl_memdev *memdev);
 int cxl_memdev_enable(struct cxl_memdev *memdev);
--=20
2.25.1
