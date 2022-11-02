Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D09EC4332F
	for <linux-cxl@archiver.kernel.org>; Wed,  2 Nov 2022 16:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231420AbiKBQuq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 2 Nov 2022 12:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbiKBQu3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 2 Nov 2022 12:50:29 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 400E46386
        for <linux-cxl@vger.kernel.org>; Wed,  2 Nov 2022 09:50:20 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20221102165018usoutp01e1e9e941c42b1d6d04a8c752095dd8db~j0pOqw1L63093530935usoutp01X;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20221102165018usoutp01e1e9e941c42b1d6d04a8c752095dd8db~j0pOqw1L63093530935usoutp01X
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1667407818;
        bh=T1JmHcR3tchOAcOjxAPehKcbyEHiulHrmlh0gHZn18U=;
        h=From:To:CC:Subject:Date:References:From;
        b=qjn9CJv9VB6Yc3D7uKyx0HSjNCidrDA4Ixs0Da2rQW8vYuzO9aTAG+Y/m6UX9sIgg
         4MXVJ6d1RAPkA9EpxZH3B7ApG7MoQy9kdr9eNlg1Sfx4r8o6bcBuxhqOqERQCUWRMD
         OedpnoT815y0vllu8HB0Khg7mSg6kEaa9lz3rtRo=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20221102165018uscas1p22d4d77767d630e3315e1c1f90b7d42cb~j0pOhIsmh0303403034uscas1p2u;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 3C.67.18126.ACF92636; Wed, 
        2 Nov 2022 12:50:18 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20221102165018uscas1p1b1432e13909141dd8932df2c0117769d~j0pOI4k7T1062710627uscas1p1a;
        Wed,  2 Nov 2022 16:50:18 +0000 (GMT)
X-AuditID: cbfec36f-fe1ff700000146ce-a8-63629fca2534
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 34.97.19363.9CF92636; Wed, 
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
Subject: [ndctl PATCH v2 0/2] Fix some typos
Thread-Topic: [ndctl PATCH v2 0/2] Fix some typos
Thread-Index: AQHY7tsvAyrc5J9stEa5aSmxB0BVjA==
Date:   Wed, 2 Nov 2022 16:50:17 +0000
Message-ID: <20221102165004.171776-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpnleLIzCtJLcpLzFFi42LZduzred1T85OSDbY2y1pMn3qB0WL1zTWM
        FudnnWKxuDXhGJMDi8fiPS+ZPKbOrvf4vEkugDmKyyYlNSezLLVI3y6BK2P68z8sBTfZKpYs
        nsDawLiXtYuRk0NCwERi550HQDYXh5DASkaJgw0/2SGcViaJhU+6WWCqmt/ugEqsZZSYsm0V
        VMtHRomGue1QzlJGiSWPp7GDtLAJKErs69rOBmKLCBRJXN88lxmkiFlgI6PE/WtXGEESwgI6
        EtfPbmGEKDKUmHv/EpDNAWTrSbTcqQUJswioSOy8NBWshFfAQuIa0IcgNqOAmMT3U2vAbGYB
        cYlbT+YzQZwqKLFo9h5mCFtM4t+uh2wQtqLE/e8v2SHq9SRuTJ3CBmFrSyxb+JoZYr6gxMmZ
        T6BelpQ4uOIGC8jNEgKtHBKtB14xQiRcJJqWfoZaJi1x9fpUqGXVEmd6zjFBNLQwSlxq3AyV
        sJb413kNajOfxN9fj8CelBDglehoE5rAqDQLyQ+zkNw3C8l9s5Dct4CRZRWjeGlxcW56arFR
        Xmq5XnFibnFpXrpecn7uJkZgWjn973D+Dsbrtz7qHWJk4mA8xCjBwawkwlt/NjpZiDclsbIq
        tSg/vqg0J7X4EKM0B4uSOG/UDK1kIYH0xJLU7NTUgtQimCwTB6dUA9Nqy7aFaj9OBHdHyvCc
        O7H0jnH/j8C7rbu3l3dsufhu2hITLZYSriyJVVN/mDZ7PbBa0DilxIaR++A8m40t3V+ubumU
        m3HU+urnh64l6UeeuCf3OHIp7p/oc329N+fcTl+On/YSjJ56SgH3azxfdJ9YmpuvejFAwn6K
        zCXOmzVfjrUJ1/lxxi680ZDRy5MjnOuSLr/ComPmQ4b/CTVyYindC5L3O618Pm2SxtUkC5aZ
        /Hb6JmvifdsTbB86C8VwVz76EuiyIMblrv1uY5FdL4uu7plQdPDAquwbzd3mM6wquR5xSG/c
        srns1aKDZ5Yu3jjdrW6dXVLk76qOJT8am4/5XDFqc29dsfHN2b2G35VYijMSDbWYi4oTAUk9
        puaaAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpgkeLIzCtJLcpLzFFi42LJbGCaqHtqflKywYoLjBbTpwKJ1TfXMFqc
        n3WKxeLWhGNMDiwei/e8ZPKYOrve4/MmuQDmKC6blNSczLLUIn27BK6M6c//sBTcZKtYsngC
        awPjXtYuRk4OCQETiea3O9i7GLk4hARWM0psn3+IFcL5yCixZH0HI4SzlFHi163NjCAtbAKK
        Evu6trOB2CICRRLXN89lBiliFtjIKHH/2hWwImEBHYnrZ7cwQhQZSsy9fwnI5gCy9SRa7tSC
        hFkEVCR2XpoKVsIrYCFxDeh2EJtRQEzi+6k1YDazgLjErSfzmSBOFZBYsuc8M4QtKvHy8T+o
        FxQl7n9/yQ5RrydxY+oUNghbW2LZwtfMEPMFJU7OfMICUS8pcXDFDZYJjKKzkKyYhaR9FpL2
        WUjaFzCyrGIULy0uzk2vKDbMSy3XK07MLS7NS9dLzs/dxAiMpNP/DkfuYDx666PeIUYmDsZD
        jBIczEoivPVno5OFeFMSK6tSi/Lji0pzUosPMUpzsCiJ8wq5TowXEkhPLEnNTk0tSC2CyTJx
        cEo1MM2Nt9opKZSVySxwSyND1lGsKCHH9ZiZtsML/xWRB0SfBjz+eT21zGxPcL97zasJQUz6
        HinCS+8FbzeRzK/SYUk31t6+yo+70tdJIXuus9+ctU7TTjuwGuzJfht71rxhnUzWaV6fg9yq
        87XuBfQZNR5Y8fJz1aNH+aZLXq/RPJT/6qxlD5vMK/FF5vfOJiVer1zN8eBL/m/jjSmPUhct
        ifdp6P20p8fP9rT01EWMH7PVpeKcJiWUJtn7F57x4H6W/Iar0SuwvXNa1polPf+6fous+XR9
        44Y9e2OPFanef/L6xQw2gVJGyaSSTwEq552k/n1ZYr1t1xeZt4umP1inOGexyoTG/ed/b/qk
        ydCUo8RSnJFoqMVcVJwIABom+kUTAwAA
X-CMS-MailID: 20221102165018uscas1p1b1432e13909141dd8932df2c0117769d
CMS-TYPE: 301P
X-CMS-RootMailID: 20221102165018uscas1p1b1432e13909141dd8932df2c0117769d
References: <CGME20221102165018uscas1p1b1432e13909141dd8932df2c0117769d@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix typos found in libcxl code and documentation. The first is separate as
it deals with an ABI, while the second patch fixes the remaining documentat=
ion.

Changes from v1[1]:
- Removed export of cxl_memdev_get_firmware_version and instead
	implement it as an inline function in cxl/libcxl.h. (Dan)
- Reverted the changes to the cxl/lib/libcxl.sym. (Dan)
- Removed cxl_memdev_get_firmware_verison from
	Documentation/cxl/lib/libcxl.txt. (David)
- Fix typos in Documentation/cxl/lib/libcxl.txt. (David)

[1]: v1:
https://lore.kernel.org/linux-cxl/20221101154628.GB78088@bgt-140510-bm03/T/=
#t

Fan Ni (2):
  libcxl: Add cxl_memdev_get_firmware_version
  libcxl: Fix typos

 Documentation/cxl/lib/libcxl.txt | 6 +++---
 cxl/libcxl.h                     | 8 ++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

--=20
2.25.1
