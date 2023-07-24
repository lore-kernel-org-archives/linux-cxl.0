Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E460CC00528
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjGXQXd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGXQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:30 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF4A61BC
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162324usoutp029c061439fc7dd542962553e3522675ad~02lGfWLQR1330013300usoutp021;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230724162324usoutp029c061439fc7dd542962553e3522675ad~02lGfWLQR1330013300usoutp021
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215804;
        bh=WQr2LrRXl3XQtQGPB07JnzxaUKwKp30D1H0fKKDUSRc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=f0xSx6x/5gi71MR0N50OC8Orn2aYQ9eCPFlWgEL7C4qcp4XdkMwEOlLO+F3KomExa
         IsfhIS0yxKW4p7fFxh5njvihDmHQuQsqYdZXzoM+SI0WsucqMXJueZydqZCRGNzPzY
         RyBNg5dw6Wx6YTT4RMUaJbL9ujJM7siBeAN8kqMA=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p2b66277f3a8e9393c6b72f46727974f91~02lGSYWgx0635306353uscas1p2P;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id C2.A5.62237.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p103885ae76e95ba7b55e707f3270d14e4~02lF6Bihb2699226992uscas1p1h;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-30-64bea57b92d4
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id B0.D1.64580.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 09:23:22 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 09:23:22 -0700
From:   Fan Ni <fan.ni@samsung.com>
To:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC:     "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "gregory.price@memverge.com" <gregory.price@memverge.com>,
        "hchkuo@avery-design.com.tw" <hchkuo@avery-design.com.tw>,
        "cbrowy@avery-design.com" <cbrowy@avery-design.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        Adam Manzanares <a.manzanares@samsung.com>,
        "dave@stgolabs.net" <dave@stgolabs.net>,
        "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
        "nifan@outlook.com" <nifan@outlook.com>,
        Fan Ni <fan.ni@samsung.com>
Subject: [Qemu PATCH RESEND 3/9] include/hw/cxl/cxl_device: Rename mem_size
 as static_mem_size for type3 memory devices
Thread-Topic: [Qemu PATCH RESEND 3/9] include/hw/cxl/cxl_device: Rename
        mem_size as static_mem_size for type3 memory devices
Thread-Index: AQHZvksqvUEFvMt+DkeO9/kVLpnyUQ==
Date:   Mon, 24 Jul 2023 16:23:22 +0000
Message-ID: <20230724162313.34196-4-fan.ni@samsung.com>
In-Reply-To: <20230724162313.34196-1-fan.ni@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
x-originating-ip: [105.128.2.176]
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-CFilter-Loop: Reflected
X-Brightmail-Tracker: H4sIAAAAAAAAA02SWUwTURSGvTPTdqhWh0LgAK6NvqBUGzSOC4qJkonGiA8aNCba0BGILZAW
        3IOIJSagUoKglMiigFBbAYtaxSAWRQEjuCMRkc3SKLIoYkCptFMT3r7/nv+c89+bS+LiZp4/
        GRObwKpj5UoJX0jcaRhtCTpRUqtYMZmzlk5vqUT0pexWRN/4YER0cko3QWtrBjH6YZ+NoA1F
        7/h0i76JoG2ZNowuKe7G6afnLUToTKY1S8djriVvYe7pOwSM9vHAlHpgx5iqYYeA6X1nxhjz
        136cyc47xfy4NT9cuFe4XsEqYw6z6uUbDgijs6yjvPjRgKMZbbmCZGTwSUMkCdRK6LKEpSEh
        KabKERT3T/A4kYpBz/vCKeHhMhnqHiKuYEIwUvPd7RpBcP35GYITpQjeF54TOFv41CKoTbvL
        d7I3FQwN9cW404RTAwQMG78RzoIXdQxuVxa6TUnwJSMH51gKLwtSXbsJaglYLRmuoSJqNdRo
        P7n8HhQNla+euTyI8oGxJiPmZJzyhfbeAozL7QlX8x7gHPvA5P0uPscLIOv3ZTcvgs4xu4Dr
        lUJb9kU+x0uhtOgrzu31hMbcXoLz+8GjsjbXjYFK94AuR597wWYYqnvr5gC4ZHxNcC8cCYZh
        IXeshILiavecdVD0pwLTocX6abH102Lop8XQT4tRiAgD8k3UaFRRrCY4lj0i1chVmsTYKGlk
        nOoWmvpvzZP18RbU3j4stSKMRFYEJC7xFsn21SrEIoX82HFWHbdfnahkNVYUQBISX5EspDFS
        TEXJE9hDLBvPqv9XMdLDPxmTJgSETPiWjyXuFBh73rSOH7zz4Qjve8dK7e2r0S9ENyPOhcri
        TE0XqubwK0wK6Wnd2V93VUNaW2qn7ulr7b76Ez33BaajM6v0kj0/Ag915u6KyP/bYc+515Rq
        9zTrSvoSUMSSpMN0cDWpS/nmNYjmP/Lrqvt92lqat8Z/JMh0cmz8i3kkjOmxRa2lxLuehFkz
        eb86L8PPt9vKBjK9tmwvUPvJugODV4Uqw3dninaEjG8yrzo7OpdXsTRociKmb9lQdXndnBSJ
        o7o/POLKntbupKJGR3p9eP6MwY/qKvu8z/MI02zSZ8B7w8JZZSH+vFLHjf0bBVuHVA18y5Pl
        Wl3zDgmhiZbLAnG1Rv4PLZR66N4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA02SbUhTYRTHe+692+5W0tMyfXI2baBS4jQUu1JUYMGFCiSqD7HSkbdl6bRd
        NXsfMQu08mWTdFYmThnTmq1Ia7blLC0VdH4QX8rAls5EMiuNFEt3Cfz2+5/z/z/nHHhIXOwl
        gsg0dTajUSvTZXwRkabFSqIu1TpSY3rtIVRhTyOg7pb1Aqp+sAFQ2uujBKWzf8Mo55dxgrJU
        9/OpHmMnQY2XjGNUrWkUpzpuNxN7VtO9+mIeXaPdR78wfhTQujdTS6plAqOffP8roD39TzH6
        6aQXp8sqr9E/bNIk0THRzlQmPS2X0UTvShGd1rt+8bJ+SfKKBioEWmAJKABCEsE4ZHntBAVA
        RIphPUDNw118TswA5HJ8EHCiDqCb5Xr+coQPNyNHQZOP/WEsam8z4cuMw0kCzbpXL/N6eAHN
        2qZ4BYBc8lxF3kEBZ5cjd1U+b5kJGIZczUW+uh/cjuy6Ed+T4iXutjl9dSGkUGPfO58fwAA0
        19mAcaMC0ZCnCuMugMjU0oNzvAFNfF7kcRyC9L/L+RxvRp/mJgRcVo4Gygx8jiNRXfUkzu2w
        Dr2v8BCcfyNqNQ8QxQAZV4wzrogbV8SNK+IPAWEBgTksm6HKY2PVzHk5q8xgc9Qq+cnMDBtY
        +gxdi22KZjAy9F3uAhgJXACRuMzfb5vCkSr2S1VeuMhoMpM1OekM6wISkpAF+tHHS5LFUKXM
        Zs4yTBaj+d/FSGGQFnvLmx2Rj7HPrwAImd/bI5IER8rve4HBUy+7Zuhb9afVay455H+vCZfg
        74+aKjJi2r8edAanTJVBRUBCqCfeNFTotOsXA4kd5xKprmppYsieoChD97zt1qB0/5bHbcfX
        tHZFJrvJsJOqmlJy7Ge1wlp7q2JheBjqGMmY9kxhgmR0IdpqjfwTvol/4r7aXtdQ6hAnVZpz
        y/Wi7IR7d2hhD3v2Rpz0gfIA/dK8til6OtSqhBtvLs6tsxqvXo7ZMZ8Z0a4W9t0Oe4RXvlww
        xp8KrnR+Ez+LN1x5lT/96bDb+cSr2K1T6YPM850z04rujlCvCbdIczvfxLn3hssI9rRy21Zc
        wyr/ASgn9Gx7AwAA
X-CMS-MailID: 20230724162323uscas1p103885ae76e95ba7b55e707f3270d14e4
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162323uscas1p103885ae76e95ba7b55e707f3270d14e4
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162323uscas1p103885ae76e95ba7b55e707f3270d14e4@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Rename mem_size as static_mem_size for type3 memdev to cover static RAM and
pmem capacity, preparing for the introduction of dynamic capacity to suppor=
t
dynamic capacity devices.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 5 +++--
 hw/mem/cxl_type3.c          | 8 ++++----
 include/hw/cxl/cxl_device.h | 2 +-
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 41e43ec231..59d57ae245 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -540,7 +540,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
=20
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
=20
-    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULT=
IPLIER);
+    stq_le_p(&id->total_capacity,
+            cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACIT=
Y_MULTIPLIER);
     stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_=
MULTIPLIER);
     stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
@@ -879,7 +880,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd=
 *cmd,
     struct clear_poison_pl *in =3D (void *)cmd->payload;
=20
     dpa =3D ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
         return CXL_MBOX_INVALID_PA;
     }
=20
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 862107c5ef..237b544b9c 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -748,7 +748,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size =3D memory_region_size(vmr);
-        ct3d->cxl_dstate.mem_size +=3D memory_region_size(vmr);
+        ct3d->cxl_dstate.static_mem_size +=3D memory_region_size(vmr);
         g_free(v_name);
     }
=20
@@ -771,7 +771,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size =3D memory_region_size(pmr);
-        ct3d->cxl_dstate.mem_size +=3D memory_region_size(pmr);
+        ct3d->cxl_dstate.static_mem_size +=3D memory_region_size(pmr);
         g_free(p_name);
     }
=20
@@ -984,7 +984,7 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3=
d,
         return -EINVAL;
     }
=20
-    if (*dpa_offset > ct3d->cxl_dstate.mem_size) {
+    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
         return -EINVAL;
     }
=20
@@ -1142,7 +1142,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t=
 dpa_offset, uint8_t *data)
         return false;
     }
=20
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.mem_size) {
+    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_siz=
e) {
         return false;
     }
=20
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index bf564f4a0b..a32ee6d6ba 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -209,7 +209,7 @@ typedef struct cxl_device_state {
     } timestamp;
=20
     /* memory region size, HDM */
-    uint64_t mem_size;
+    uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
=20
--=20
2.25.1
