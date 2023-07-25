Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 834E0C001DE
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbjGYSkG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbjGYSkA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:00 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8132B2126
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:58 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183957usoutp026402224fe014bd2558dcb703be77d9f2~1MFnGVPaO1493014930usoutp025;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230725183957usoutp026402224fe014bd2558dcb703be77d9f2~1MFnGVPaO1493014930usoutp025
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310397;
        bh=4zHhiX+VKvsm4sZJl9tl93+G8ban/i2aXGty2+poNFg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=iVAx0/9RcpLhBXX+yfLPsDR5hbgcwVTBfCeDQw8InbD5RD0Qelkdgr+AvVe72F7TA
         NCXPOdABavQBm8U0OHYnLar+DUShPyei528+GXqQq/FOvS7K+XfOUHhFzmIAiISbwL
         gsow8v63EAXEII83HHtBoJXin/LSgjXVt9FMbJhM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p16fd7936ec77be6b2ccc8b60bc1f08eef~1MFm4GIwg0903709037uscas1p1X;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id A1.11.42611.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4~1MFmiu1U-1453314533uscas1p14;
        Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-41-64c016fcb123
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id B3.83.44215.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 25 Jul 2023 11:39:55 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        25 Jul 2023 11:39:55 -0700
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
Subject: [Qemu PATCH v2 3/9] include/hw/cxl/cxl_device: Rename mem_size as
 static_mem_size for type3 memory devices
Thread-Topic: [Qemu PATCH v2 3/9] include/hw/cxl/cxl_device: Rename mem_size
        as static_mem_size for type3 memory devices
Thread-Index: AQHZvydogN6RnRodckK9r+0ZvWb2uQ==
Date:   Tue, 25 Jul 2023 18:39:55 +0000
Message-ID: <20230725183939.2741025-4-fan.ni@samsung.com>
In-Reply-To: <20230725183939.2741025-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djX87p/xA6kGExqt7ToPr+B0WL61AuM
        FqtvrmG0aGh6xGLRsvs9k8X+p89ZLFYtvMZmcX7WKRaL5xOfM1ksXfKI2eJ47w4WB26PC5Mn
        sHosbnD12DnrLrtHy5G3QN6el0weGz/+Z/d4cm0zk8fm1y+YPabOrvf4vEkugCuKyyYlNSez
        LLVI3y6BK2NjXztzQbNMxbsHp1kaGDeJdTFycEgImEjMe6XXxcjFISSwklFi+/QNrF2MnEBO
        K5PE+WnKIDZIzfWXP9kgitYySvSu3cUEUfSJUWLRdDOIxDJGidbW02DdbAKKEvu6trOB2CIC
        xhLHDi9hBiliFnjLIvFxzRsWkISwQKnE/Bm7WSCKqiQurFsP1aAn8XfXBbA4i4CqRMfKHWDb
        eAUsJRYeWs0IYnMKWEk8+zIbbBmjgJjE91NrwGqYBcQlbj2ZzwRxtqDEotl7mCFsMYl/ux6y
        QdjyEpN/zICyFSXuf3/JDtGrJ3Fj6hQ2CFtbYtnC18wQewUlTs58wgJRLylxcMUNFpBnJAQm
        c0q0XzgNlXCRmLJ8MSOELS3x9+4yJkj4Jkus+sgFEc6RmL9kC1S5tcTCP+uZJjCqzEJy9iwk
        Z8xCcsYsJGcsYGRZxSheWlycm55abJSXWq5XnJhbXJqXrpecn7uJEZjaTv87nL+D8fqtj3qH
        GJk4GA8xSnAwK4nwGsbsSxHiTUmsrEotyo8vKs1JLT7EKM3BoiTOa2h7MllIID2xJDU7NbUg
        tQgmy8TBKdXAtOLTFusnLayvHBzceEwvKv/nnROs/C32gKteZPGbPaxT+l6n7Tleuyvp6yTW
        A9evs688eHH6jXDvLrkTWVqR1+U0mXx1D/l8mNvLnGZkqvLgYGa+BHvzgjdvBVy8HK41NO8R
        3bM0h1P4/78HbhatgdZm3K4uT0JX9TJ/mLwxgY119obYgx0Nk9jW3VphoFMU564b2tihEFit
        Hmpvu/6tf5bN3AfHLlz0LNxt07ho5e+Lfkl8McLpL27fcfK7ckL+tpqMyTqxQmUjsRX6TL5q
        516vM/9/86V/lMv/T45xB56ZMXjOWyt3h7nQr7Xzo+/8iYtXOGS67WD8PIste9aX2dOWVziH
        TgjMvqnDdlRaiaU4I9FQi7moOBEApGarQdwDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWS2cA0SfeP2IEUgy0TlSy6z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgytjY185c0CxT8e7BaZYGxk1iXYycHBICJhLXX/5k62Lk4hASWM0osezORjaQhJDA
        J0aJ7W0uEIlljBKLDy9gB0mwCShK7OvaDlYkImAscezwEmYQm1ngNYvEt4vcILawQKnE/Bm7
        WSBqqiRWdZ1jhrD1JP7uugAWZxFQlehYuYMJxOYVsJRYeGg1YxcjB9AyS4mtE+NAwpwCVhLP
        vsxmBbEZBcQkvp9awwSxSlzi1pP5TBAPCEgs2XOeGcIWlXj5+B8rhC0vMfnHDDYIW1Hi/veX
        7BC9ehI3pk5hg7C1JZYtfM0McYKgxMmZT1gg6iUlDq64wTKBUWIWknWzkLTPQtI+C0n7AkaW
        VYzipcXFuekVxUZ5qeV6xYm5xaV56XrJ+bmbGIFp4fS/w9E7GG/f+qh3iJGJg/EQowQHs5II
        r2HMvhQh3pTEyqrUovz4otKc1OJDjNIcLErivC+jJsYLCaQnlqRmp6YWpBbBZJk4OKUamKZ9
        Y3e5fdm9uTK/PHaeoOhLppwDU/2c74fMEf1h1XvdpHeFRIDT5RmT8rdrh21fukg399QP7flf
        7N7yScYtVL+5OvDSLc/X952UQxn7nlT52l4O7bdIlzumJymzcvmdwqLdpUF3A84uC11+s1W8
        3mJtY+1W52thdz/4GwVu33GkmHluY1n1DEUfmRPxacdSeebNUvRpu8qwy7Vgx6FinSkrFoXG
        BbCvfZWTsJtFTvWcnIpS03PO6HXrnPa/vrDX8Po95g27dr4UqRS6e49ZmPPRstqk1e3HbuUF
        +R3WaVv3q8OMbw2Xw1758vzySk41620Wi6PjTv4uUXlwtFgn38BRs3b+ss98Wb6eETFRSizF
        GYmGWsxFxYkA1BosnnoDAAA=
X-CMS-MailID: 20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183956uscas1p153242eb4b12cb9cb6529476b4e9058c4@uscas1p1.samsung.com>
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
index 0fe9f3eb5d..dd5ea95af8 100644
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
index 4d68824dfe..3d7acffcb7 100644
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
@@ -1148,7 +1148,7 @@ static bool set_cacheline(CXLType3Dev *ct3d, uint64_t=
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
index dae39da438..503c344326 100644
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
     bool is_dcd;
--=20
2.25.1
