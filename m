Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3833C00528
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231506AbjGYSkP (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231853AbjGYSkF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:05 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3F6212D
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:59 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183957usoutp0181b63791b8fd5bcf0241df45cedcc66c~1MFniA3Zc1034510345usoutp01W;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230725183957usoutp0181b63791b8fd5bcf0241df45cedcc66c~1MFniA3Zc1034510345usoutp01W
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310397;
        bh=QeyB8uxIUqjoxKrMmz+AjPCe1zFk9SF+BxXjnc8gHjU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bORs5KVhSsnK4ddXVm1eFZbY7p3gRCsFeHCEaK3hlIN9qvkQ1HFrxBjJ8yMpADVbs
         Jh1prTo5+BhU8AXgf82Cc+K42qn5e2wQTza7vUDLQUXH4EBytmxLkPoejZDoihF4df
         ycasaZas144BrqRHr5pqbMxze/KyL1z7W4srUZRM=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p1dfc3e7525e765eff3555a8bed5c38df2~1MFnV-LlP1453314533uscas1p16;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id 82.11.42611.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b~1MFm4O7XX0903609036uscas1p1v;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
X-AuditID: cbfec36f-fb1ff7000000a673-43-64c016fd47e9
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id C8.DA.64580.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Tue, 25 Jul 2023 11:39:56 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Tue,
        25 Jul 2023 11:39:56 -0700
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
Subject: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and address
 space handling for DC regions
Thread-Topic: [Qemu PATCH v2 5/9] hw/mem/cxl_type3: Add host backend and
        address space handling for DC regions
Thread-Index: AQHZvydo9CDYVoLKukCzVG4QTwqoCg==
Date:   Tue, 25 Jul 2023 18:39:56 +0000
Message-ID: <20230725183939.2741025-6-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djXc7p/xQ6kGDzaJ2HRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8bGtZ2MBQ0TGCuezr/D2sC4Ka2LkZNDQsBE4sz550xdjFwcQgIrGSXOtZ1nh3Ba
        mSSWLXnODFO15F4nVNVaRondPR1sIAkhgU+MEm/ueEIklgHZ7b/AOtgEFCX2dW0HKxIRMJY4
        dngJM0gRs8BbFomPa96wdDFycAgLZEvcvMoLUVMg0fTiHFS9nkRHF8QCFgFViRtHjjCClPMK
        WEpMPmQJEuYUsJJ49mU2K4jNKCAm8f3UGiYQm1lAXOLWk/lMEEcLSiyavQfqATGJf7seskHY
        8hKTf8yAshUl7n9/yQ7RqydxY+oUNghbW2LZwtdgvbxAc07OfMICUS8pcXDFDRaQVyQEJnNK
        LF7cDpVwkTi8ZysrhC0tMX3NZbAXJQSSJVZ95III50jMX7IFqtxaYuGf9UwTGFVmITl7FpIz
        ZiE5YxaSMxYwsqxiFC8tLs5NTy02ykst1ytOzC0uzUvXS87P3cQITG6n/x3O38F4/dZHvUOM
        TByMhxglOJiVRHgNY/alCPGmJFZWpRblxxeV5qQWH2KU5mBREuc1tD2ZLCSQnliSmp2aWpBa
        BJNl4uCUamCKX5DE6lQ6w+V+2sKqrY0Xmso3N870LP0Wv0T/7F21d/8/+puZCpyRkLrKtspv
        8YnQJx1aEw/efrvr3X7JK3Hv/NcKftdWj+metnnJm/Zw+3cWnadXWFyukOD7+u3l8bbAoLPV
        82L2+93Qr7E1aTdewdYQfPF5O9PZc7VndpkaLXDJ3rEzUlu1vUbZ8yCTotKJlRfZX3jLpTVV
        iYqrrfj4UsG45PT88CzWWM1wIzuDP7brfN1XyyX58sbNy1vHXN4iUHnSpaz15aw/p7L+vf48
        p2kGT/PNKYv+urf8m7B1+ZrFt+Z2heTPuMhVqOVTXXzogOOEl9Mvyih2WQcuPTGRzVZq7bNH
        /9uXSeZ3Z3xUYinOSDTUYi4qTgQA+m51Xd0DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWS2cA0SfeP2IEUg08bTC26z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyti4tpOxoGECY8XT+XdYGxg3pXUxcnJICJhILLnXydTFyMUhJLCaUeLGhH2sEM4n
        Rolzp15BOcsYJeYvXs0I0sImoCixr2s7G4gtImAscezwEmYQm1ngNYvEt4vcXYwcHMIC2RI3
        r/JClBRI/Nv3jwnC1pPo6OoAa2URUJW4ceQII0g5r4ClxORDliCmEJC5dWIcSAWngJXEsy+z
        WUFsRgExie+n1jBBLBKXuPVkPhPE/QISS/acZ4awRSVePv7HCmHLS0z+MYMNwlaUuP/9JTtE
        r57EjalT2CBsbYllC1+D9fIKCEqcnPmEBaJeUuLgihssExglZiFZNwtJ+ywk7bOQtC9gZFnF
        KF5aXJybXlFsnJdarlecmFtcmpeul5yfu4kRmBZO/zscs4Px3q2PeocYmTgYDzFKcDArifAa
        xuxLEeJNSaysSi3Kjy8qzUktPsQozcGiJM7rETsxXkggPbEkNTs1tSC1CCbLxMEp1cBUKvL0
        3uH1OQecOuSmFGvP/Xjt9rW7m25vODHt9rK1de9r/TmF2oxLrd/LX31UoaPnlVcZ+u28qsQ9
        0xmTeJiM+c7+7BXN3n71QPki8bbU6ogS4TciNTJct64mie6PttafFr0m93fvh943SalX7h9f
        feKsBkeR3yPbOcuWrRaqz+VRyckL+ifmmMl7nktmfdMlcdOMI5HKR8JdjinarHvJsfLo9sZ6
        3gDT3Z/uhBRum/brdPUaFVs1ns1RhzKNPYRm8i8uPi/zr2rmNqW1z6ZsFp/yO/vkjG2fjzPN
        PjT1gTPzNQ7bpRlfrOsWNZ/OOdCUH/P794mWxYuqH5gZ/Y3oOWFYr2lnrcEjay/4w/qpEktx
        RqKhFnNRcSIAFCKCiXoDAAA=
X-CMS-MailID: 20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p1eeb8e8eccc6c00b460d183027642374b@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add (file/memory backed) host backend, all the dynamic capacity regions
will share a single, large enough host backend. Set up address space for
DC regions to support read/write operations to dynamic capacity for DCD.

With the change, following supports are added:
1. add a new property to type3 device "nonvolatile-dc-memdev" to point to h=
ost
   memory backend for dynamic capacity;
2. add namespace for dynamic capacity for read/write support;
3. create cdat entries for each dynamic capacity region;
4. fix dvsec range registers to include DC regions.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  19 +++-
 hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 185 insertions(+), 41 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index dd5ea95af8..0511b8e6f7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -388,9 +388,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct =
cxl_cmd *cmd,
         char fw_rev4[0x10];
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) !=3D 0x50);
+    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dstate=
);
=20
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
=20
@@ -531,7 +533,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
     CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
=20
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER))=
 ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))=
) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))=
 ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER=
))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
=20
@@ -566,9 +569,11 @@ static CXLRetCode cmd_ccls_get_partition_info(struct c=
xl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info =3D (void *)cmd->payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) !=3D 0x20);
+    CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dstate=
);
=20
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER))=
 ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))=
) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))=
 ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER=
))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
=20
@@ -880,7 +885,13 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cm=
d *cmd,
     struct clear_poison_pl *in =3D (void *)cmd->payload;
=20
     dpa =3D ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE >=3D cxl_dstate->static_mem_size
+            && ct3d->dc.num_regions =3D=3D 0) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    if (ct3d->dc.num_regions && dpa + CXL_CACHE_LINE_SIZE >=3D
+            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
=20
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b29bb2309a..76bbd9f785 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -20,6 +20,7 @@
 #include "hw/pci/spdm.h"
=20
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
=20
 /* Default CDAT entries for a memory region */
 enum {
@@ -33,8 +34,8 @@ enum {
 };
=20
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *m=
r,
-                                         bool is_pmem, uint64_t dpa_base)
+        int dsmad_handle, uint8_t flags,
+        uint64_t dpa_base, uint64_t size)
 {
     g_autofree CDATDsmas *dsmas =3D NULL;
     g_autofree CDATDslbis *dslbis0 =3D NULL;
@@ -53,9 +54,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **=
cdat_table,
             .length =3D sizeof(*dsmas),
         },
         .DSMADhandle =3D dsmad_handle,
-        .flags =3D is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags =3D flags,
         .DPA_base =3D dpa_base,
-        .DPA_length =3D memory_region_size(mr),
+        .DPA_length =3D size,
     };
=20
     /* For now, no memory side cache, plausiblish numbers */
@@ -137,9 +138,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader =
**cdat_table,
          * NV: Reserved - the non volatile from DSMAS matters
          * V: EFI_MEMORY_SP
          */
-        .EFI_memory_type_attr =3D is_pmem ? 2 : 1,
+        .EFI_memory_type_attr =3D flags ? 2 : 1,
         .DPA_offset =3D 0,
-        .DPA_length =3D memory_region_size(mr),
+        .DPA_length =3D size,
     };
=20
     /* Header always at start of structure */
@@ -158,21 +159,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat=
_table, void *priv)
     g_autofree CDATSubHeader **table =3D NULL;
     CXLType3Dev *ct3d =3D priv;
     MemoryRegion *volatile_mr =3D NULL, *nonvolatile_mr =3D NULL;
+    MemoryRegion *dc_mr =3D NULL;
     int dsmad_handle =3D 0;
     int cur_ent =3D 0;
     int len =3D 0;
     int rc, i;
+    uint64_t vmr_size =3D 0, pmr_size =3D 0;
=20
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
         return 0;
     }
=20
+    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
+        warn_report("The device has static ram and pmem and dynamic capaci=
ty");
+    }
+
     if (ct3d->hostvmem) {
         volatile_mr =3D host_memory_backend_get_memory(ct3d->hostvmem);
         if (!volatile_mr) {
             return -EINVAL;
         }
         len +=3D CT3_CDAT_NUM_ENTRIES;
+        vmr_size =3D volatile_mr->size;
     }
=20
     if (ct3d->hostpmem) {
@@ -181,6 +189,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_=
table, void *priv)
             return -EINVAL;
         }
         len +=3D CT3_CDAT_NUM_ENTRIES;
+        pmr_size =3D nonvolatile_mr->size;
+    }
+
+    if (ct3d->dc.num_regions) {
+        if (ct3d->dc.host_dc) {
+            dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                return -EINVAL;
+            }
+            len +=3D CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+        } else {
+            return -EINVAL;
+        }
     }
=20
     table =3D g_malloc0(len * sizeof(*table));
@@ -190,8 +211,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_t=
able, void *priv)
=20
     /* Now fill them in */
     if (volatile_mr) {
-        rc =3D ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volati=
le_mr,
-                                           false, 0);
+        rc =3D ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
+                0, 0, vmr_size);
         if (rc < 0) {
             return rc;
         }
@@ -200,14 +221,37 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat=
_table, void *priv)
=20
     if (nonvolatile_mr) {
         rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_hand=
le++,
-                                           nonvolatile_mr, true,
-                                           (volatile_mr ?
-                                            memory_region_size(volatile_mr=
) : 0));
+                CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);
         if (rc < 0) {
             goto error_cleanup;
         }
         cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
     }
+
+    if (dc_mr) {
+        uint64_t region_base =3D vmr_size + pmr_size;
+
+        /*
+         * Currently we create cdat entries for each region, should we onl=
y
+         * create dsmas table instead??
+         * We assume all dc regions are non-volatile for now.
+         *
+         */
+        for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+            rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent])
+                    , dsmad_handle++
+                    , CDAT_DSMAS_FLAG_NV | CDAT_DSMAS_FLAG_DYNAMIC_CAP
+                    , region_base, ct3d->dc.regions[i].len);
+            if (rc < 0) {
+                goto error_cleanup;
+            }
+            ct3d->dc.regions[i].dsmadhandle =3D dsmad_handle - 1;
+
+            cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
+            region_base +=3D ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len =3D=3D cur_ent);
=20
     *cdat_table =3D g_steal_pointer(&table);
@@ -435,11 +479,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             range2_size_hi =3D ct3d->hostpmem->size >> 32;
             range2_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
                              (ct3d->hostpmem->size & 0xF0000000);
+        } else if (ct3d->dc.host_dc) {
+            range2_size_hi =3D ct3d->dc.host_dc->size >> 32;
+            range2_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
         }
-    } else {
+    } else if (ct3d->hostpmem) {
         range1_size_hi =3D ct3d->hostpmem->size >> 32;
         range1_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
                          (ct3d->hostpmem->size & 0xF0000000);
+        if (ct3d->dc.host_dc) {
+            range2_size_hi =3D ct3d->dc.host_dc->size >> 32;
+            range2_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
+        }
+    } else {
+        range1_size_hi =3D ct3d->dc.host_dc->size >> 32;
+        range1_size_lo =3D (2 << 5) | (2 << 2) | 0x3 |
+            (ct3d->dc.host_dc->size & 0xF0000000);
     }
=20
     dvsec =3D (uint8_t *)&(CXLDVSECDevice){
@@ -708,7 +765,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset,=
 uint64_t value,
 }
=20
 /*
- * Create a dc region to test "Get Dynamic Capacity Configuration" command=
.
+ * Create dc regions.
+ * TODO: region parameters are hard coded, may need to change in the futur=
e.
  */
 static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 {
@@ -739,7 +797,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
 {
     DeviceState *ds =3D DEVICE(ct3d);
=20
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+            && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -807,6 +866,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error =
**errp)
         return false;
     }
=20
+    ct3d->dc.total_capacity =3D 0;
+    if (ct3d->dc.host_dc) {
+        MemoryRegion *dc_mr;
+        char *dc_name;
+        uint64_t total_region_size =3D 0;
+        int i;
+
+        dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            error_setg(errp, "dynamic capacity must have backing device");
+            return false;
+        }
+        /* FIXME: set dc as nonvolatile for now */
+        memory_region_set_nonvolatile(dc_mr, true);
+        memory_region_set_enabled(dc_mr, true);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+        if (ds->id) {
+            dc_name =3D g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id)=
;
+        } else {
+            dc_name =3D g_strdup("cxl-dcd-dpa-dc-space");
+        }
+        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+
+        for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+            total_region_size +=3D ct3d->dc.regions[i].len;
+        }
+        /* Make sure the host backend is large enough to cover all dc rang=
e */
+        if (total_region_size > memory_region_size(dc_mr)) {
+            error_setg(errp,
+                "too small host backend size, increase to %lu MiB or more"=
,
+                total_region_size / 1024 / 1024);
+            return false;
+        }
+
+        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER !=3D 0) {
+            error_setg(errp, "DC region size is unaligned to %lx",
+                    CXL_CAPACITY_MULTIPLIER);
+            return false;
+        }
+
+        ct3d->dc.total_capacity =3D total_region_size;
+        g_free(dc_name);
+    }
+
     return true;
 }
=20
@@ -916,6 +1019,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -935,6 +1041,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -999,16 +1108,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *=
ct3d,
                                        AddressSpace **as,
                                        uint64_t *dpa_offset)
 {
-    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
+    MemoryRegion *vmr =3D NULL, *pmr =3D NULL, *dc_mr =3D NULL;
+    uint64_t vmr_size =3D 0, pmr_size =3D 0, dc_size =3D 0;
=20
     if (ct3d->hostvmem) {
         vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size =3D memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size =3D memory_region_size(pmr);
+    }
+    if (ct3d->dc.host_dc) {
+        dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+        /* Do we want dc_size to be dc_mr->size or not?? */
+        dc_size =3D ct3d->dc.total_capacity;
     }
=20
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
=20
@@ -1016,19 +1133,19 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev =
*ct3d,
         return -EINVAL;
     }
=20
-    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
+    if ((*dpa_offset >=3D vmr_size + pmr_size + dc_size) ||
+       (*dpa_offset >=3D vmr_size + pmr_size && ct3d->dc.num_regions =3D=
=3D 0)) {
         return -EINVAL;
     }
=20
-    if (vmr) {
-        if (*dpa_offset < memory_region_size(vmr)) {
-            *as =3D &ct3d->hostvmem_as;
-        } else {
-            *as =3D &ct3d->hostpmem_as;
-            *dpa_offset -=3D memory_region_size(vmr);
-        }
-    } else {
+    if (*dpa_offset < vmr_size) {
+        *as =3D &ct3d->hostvmem_as;
+    } else if (*dpa_offset < vmr_size + pmr_size) {
         *as =3D &ct3d->hostpmem_as;
+        *dpa_offset -=3D vmr_size;
+    } else {
+        *as =3D &ct3d->dc.host_dc_as;
+        *dpa_offset -=3D (vmr_size + pmr_size);
     }
=20
     return 0;
@@ -1101,6 +1218,8 @@ static Property ct3_props[] =3D {
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1167,33 +1286,43 @@ static void set_lsa(CXLType3Dev *ct3d, const void *=
buf, uint64_t size,
=20
 static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t =
*data)
 {
-    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
+    MemoryRegion *vmr =3D NULL, *pmr =3D NULL, *dc_mr =3D NULL;
     AddressSpace *as;
+    uint64_t vmr_size =3D 0, pmr_size =3D 0, dc_size =3D 0;
=20
     if (ct3d->hostvmem) {
         vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size =3D memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size =3D memory_region_size(pmr);
     }
+    if (ct3d->dc.host_dc) {
+        dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size =3D ct3d->dc.total_capacity;
+     }
=20
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return false;
     }
=20
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_siz=
e) {
+    if (dpa_offset >=3D vmr_size + pmr_size + dc_size) {
+        return false;
+    }
+    if (dpa_offset + CXL_CACHE_LINE_SIZE >=3D vmr_size + pmr_size
+            && ct3d->dc.num_regions =3D=3D 0) {
         return false;
     }
=20
-    if (vmr) {
-        if (dpa_offset < memory_region_size(vmr)) {
-            as =3D &ct3d->hostvmem_as;
-        } else {
-            as =3D &ct3d->hostpmem_as;
-            dpa_offset -=3D memory_region_size(vmr);
-        }
-    } else {
+    if (dpa_offset < vmr_size) {
+        as =3D &ct3d->hostvmem_as;
+    } else if (dpa_offset < vmr_size + pmr_size) {
         as =3D &ct3d->hostpmem_as;
+        dpa_offset -=3D vmr->size;
+    } else {
+        as =3D &ct3d->dc.host_dc_as;
+        dpa_offset -=3D (vmr_size + pmr_size);
     }
=20
     address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 503c344326..1c99b05a66 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -427,6 +427,10 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
=20
     struct dynamic_capacity {
+        HostMemoryBackend *host_dc;
+        AddressSpace host_dc_as;
+        uint64_t total_capacity; /* 256M aligned */
+
         uint8_t num_regions; /* 0-8 regions */
         struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
     } dc;
--=20
2.25.1
