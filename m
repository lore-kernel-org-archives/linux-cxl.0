Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 133CCC7EE22
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbjEKSJt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239157AbjEKSJq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:09:46 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E0C6526A
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:09:23 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175643usoutp01f41b0c639ba9262c8774684c8b3afc97~eKHdL2JSz3198731987usoutp01r;
        Thu, 11 May 2023 17:56:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230511175643usoutp01f41b0c639ba9262c8774684c8b3afc97~eKHdL2JSz3198731987usoutp01r
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827803;
        bh=q8Aobqwfsz7443OdhZVgTB3Eu3TueAadI/bI7iaTUow=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=EjndZF8J/AOZy6fn7stoEVl06F13hlwE066Yd2yCEH11QodeCheFvKHNRVQvP80Ca
         koHtsbYiyDXHhwHBn+ZyT/X7lSYSPR/OyaTBo5S9YMige/uPTCOVSZi1fD/QVpyjkz
         g8ciau1R0uF+V320gL44Yp/GmA1jF+OM8PNmL6/I=
Received: from ussmges2new.samsung.com (u111.gpu85.samsung.co.kr
        [203.254.195.111]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175643uscas1p23306dc0dfe33a1b79ad2123375ecae7c~eKHc3evfM2037920379uscas1p2U;
        Thu, 11 May 2023 17:56:43 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges2new.samsung.com (USCPEMTA) with SMTP id A6.DA.42611.A5C2D546; Thu,
        11 May 2023 13:56:42 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d~eKHcUx5bS1951019510uscas1p2f;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
X-AuditID: cbfec36f-249ff7000000a673-94-645d2c5ab95e
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 5B.48.64580.95C2D546; Thu,
        11 May 2023 13:56:42 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 10:56:41 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 10:56:41 -0700
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
Subject: [RFC 7/7] hw/mem/cxl_type3: add read/write support to dynamic
 capacity
Thread-Topic: [RFC 7/7] hw/mem/cxl_type3: add read/write support to dynamic
        capacity
Thread-Index: AQHZhDHw5brNkJs1s0eH0nh3056ZGw==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-8-fan.ni@samsung.com>
In-Reply-To: <20230511175609.2091136-1-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrHKsWRmVeSWpSXmKPExsWy7djX87pROrEpBt8emlh0n9/AaDF96gVG
        i9U31zBaNDQ9YrFo2f2eyWL/0+csFqsWXmOzOD/rFIvF84nPmSyWLnnEbHG8dweLA7fHhckT
        WD0WN7h67Jx1l92j5chbIG/PSyaPjR//s3s8ubaZyWPz6xfMHlNn13t83iQXwBXFZZOSmpNZ
        llqkb5fAlfF3ahN7wabVjBWzVkxka2B80cLYxcjJISFgIvHr4B6mLkYuDiGBlYwSV+dMY4Nw
        WpkkNm5fxgxTdarzMStEYi2jxIITB6GqPjFKfLu/HcpZxijx/vsesBY2AUWJfV0gCU4OEQFj
        iWOHlzCDFDELvGWR+LjmDQtIQlggUGLFhGOMEEVhEp+On2eGsPUkFh7YBxZnEVCVOHdjB5jN
        K2Apcf/Yd3YQm1PASmJD8wkmEJtRQEzi+6k1YDazgLjErSfzmSDuFpRYNHsP1A9iEv92PWSD
        sOUlJv+YAWUrStz//pIdoldP4sbUKWwQtrbEsoWvmSH2CkqcnPmEBaJeUuLgihssIM9ICPRz
        SlxYfoEVIuEicWtLHzRYpSWmr7kMVMQBZCdLrPrIBRHOkZi/ZAvUHGuJhX/WM01gVJmF5OxZ
        SM6YheSMWUjOWMDIsopRvLS4ODc9tdgoL7Vcrzgxt7g0L10vOT93EyMwyZ3+dzh/B+P1Wx/1
        DjEycTAeYpTgYFYS4X27JDpFiDclsbIqtSg/vqg0J7X4EKM0B4uSOK+h7clkIYH0xJLU7NTU
        gtQimCwTB6dUAxPjw98Nfc2JQg7nzj5asmn5qVkuBfI+iqrChjfnPZdaHVgf6jFjXePJv9uz
        tbcdV/xpnqetPuPyQ12GE2Z29WXccrmhQofmLDtvVqgp0R5eKvu8n+vXrb7XV22eB6xcfizP
        sGCltvPH8EnTIw7JK39WVWcPqzT4pXbt6//+ur9Xdl03Dc9t/8Pi4zQjOKG3va2qxFaP/WJn
        5zkP4Q7BWo3CRUkvf0ksWf4xcep0Rgbr/98SUrvFCmstzqouXlri6SaQH2v2gGNG2l0Gc+WN
        xbnPP+w+vPTGZtNPM6p375+5VE7ryqUnutEP1sy9O3P6vRkaAd1R669O+ralqYNTPYaFe/LG
        xjdzKgt8fLJqipRYijMSDbWYi4oTAeiFzs3hAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNIsWRmVeSWpSXmKPExsWS2cA0UTdKJzbF4N03fovu8xsYLaZPvcBo
        sfrmGkaLhqZHLBYtu98zWex/+pzFYtXCa2wW52edYrF4PvE5k8XSJY+YLY737mBx4Pa4MHkC
        q8fiBlePnbPusnu0HHkL5O15yeSx8eN/do8n1zYzeWx+/YLZY+rseo/Pm+QCuKK4bFJSczLL
        Uov07RK4Mv5ObWIv2LSasWLWiolsDYwvWhi7GDk5JARMJE51PmbtYuTiEBJYzShx/8wTKOcT
        o8T/lu1MEM4yRonGretYQVrYBBQl9nVtZwOxRQSMJY4dXsIMYjMLvGaR+HaRG8QWFgiUWDHh
        GCNETZhE85b/zBC2nsTCA/vA4iwCqhLnbuwAs3kFLCXuH/vODmILAdkff+4EszkFrCQ2NJ9g
        ArEZBcQkvp9awwSxS1zi1pP5TBAvCEgs2XOeGcIWlXj5+B8rhC0vMfnHDDYIW1Hi/veX7BC9
        ehI3pk5hg7C1JZYtfM0McYOgxMmZT1gg6iUlDq64wTKBUWIWknWzkLTPQtI+C0n7AkaWVYzi
        pcXFuekVxcZ5qeV6xYm5xaV56XrJ+bmbGIHp4fS/wzE7GO/d+qh3iJGJg/EQowQHs5II79sl
        0SlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeT1iJ8YLCaQnlqRmp6YWpBbBZJk4OKUamHQvrPr7
        5l+ckXRTid9TTsMn944JcVh/0LDNU2U+pbpP1UONd3KbjqNYpIalueHkv9PklLRnuP1S/8Gr
        ZTxHV1Nmq/gHi6CKa1Oq3UrLFTddNzkSlfOqWk8hTvtFPoO456m1DkLPmb41TPux41jEwTjd
        CaoBRZdstX1ME6RCG9NbrlWsTqm43t5ypPP6tJ35Mml2Vav2f03cwad77pP1gtcNxwvrW9Zs
        4ovym1r3XXEO391cNnNzqxn72Duyj83c+en1x3nfG/i5dGT+h/Q9yeZ0VWfP+Zzye6fd/eA9
        vgISe5RNxNYfqDUoevb8dUBP6ykJibtid1KzePzNnBn+77cP8k/R26IkJPN2jaUSS3FGoqEW
        c1FxIgDylzB5fgMAAA==
X-CMS-MailID: 20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p2c037608a1dd26b19cf970f97ce434c6d@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Before the change, read from or write to dynamic capacity of the memory
device is not support as 1) no host backed file/memory is provided for
it; 2) no address space is created for the dynamic capacity.

With the change, add code to support following:
1. add a new property to type3 device "dc-memdev" to point to host
   memory backend for dynamic capacity;
2. add a bitmap for each region to track whether a block is host backed,
which will be used for address check when read/write dynamic capacity;
3. add namespace for dynamic capacity for read/write support;
4. create cdat entries for each dynamic capacity region;

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  21 ++-
 hw/mem/cxl_type3.c          | 336 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   8 +-
 3 files changed, 298 insertions(+), 67 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7212934627..efe61e67fb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -391,9 +391,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct =
cxl_cmd *cmd,
         char fw_rev4[0x10];
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) !=3D 0x50);
+	CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
=20
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+			(cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+		(ct3d->dc.total_dynamic_capicity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
=20
@@ -534,7 +536,9 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
     CXLType3Class *cvc =3D CXL_TYPE3_GET_CLASS(ct3d);
=20
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER))=
 ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))=
) {
+		(!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+		(!QEMU_IS_ALIGNED(ct3d->dc.total_dynamic_capicity,
+						CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
=20
@@ -543,7 +547,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl=
_cmd *cmd,
=20
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
=20
-    stq_le_p(&id->total_capacity, cxl_dstate->mem_size / CXL_CAPACITY_MULT=
IPLIER);
+	stq_le_p(&id->total_capacity,
+			cxl_dstate->static_mem_size / CXL_CAPACITY_MULTIPLIER);
     stq_le_p(&id->persistent_capacity, cxl_dstate->pmem_size / CXL_CAPACIT=
Y_MULTIPLIER);
     stq_le_p(&id->volatile_capacity, cxl_dstate->vmem_size / CXL_CAPACITY_=
MULTIPLIER);
     stl_le_p(&id->lsa_size, cvc->get_lsa_size(ct3d));
@@ -568,9 +573,12 @@ static CXLRetCode cmd_ccls_get_partition_info(struct c=
xl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info =3D (void *)cmd->payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) !=3D 0x20);
+	CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
=20
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER))=
 ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))=
) {
+		(!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+		(!QEMU_IS_ALIGNED(ct3d->dc.total_dynamic_capicity,
+						CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
=20
@@ -881,9 +889,8 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd=
 *cmd,
     struct clear_poison_pl *in =3D (void *)cmd->payload;
=20
     dpa =3D ldq_le_p(&in->dpa);
-    if (dpa + 64 > cxl_dstate->mem_size) {
-        return CXL_MBOX_INVALID_PA;
-    }
+	if (dpa + 64 > cxl_dstate->static_mem_size && ct3d->dc.num_regions =3D=3D=
 0)
+		return CXL_MBOX_INVALID_PA;
=20
     QLIST_FOREACH(ent, poison_list, node) {
         /*
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 70d47d43b9..334660bd0f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -33,8 +33,8 @@ enum {
 };
=20
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *m=
r,
-                                         bool is_pmem, uint64_t dpa_base)
+		int dsmad_handle, uint8_t flags,
+		uint64_t dpa_base, uint64_t size)
 {
     g_autofree CDATDsmas *dsmas =3D NULL;
     g_autofree CDATDslbis *dslbis0 =3D NULL;
@@ -53,9 +53,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **=
cdat_table,
             .length =3D sizeof(*dsmas),
         },
         .DSMADhandle =3D dsmad_handle,
-        .flags =3D is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+		.flags =3D flags,
         .DPA_base =3D dpa_base,
-        .DPA_length =3D int128_get64(mr->size),
+		.DPA_length =3D size,
     };
=20
     /* For now, no memory side cache, plausiblish numbers */
@@ -137,9 +137,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader =
**cdat_table,
          * NV: Reserved - the non volatile from DSMAS matters
          * V: EFI_MEMORY_SP
          */
-        .EFI_memory_type_attr =3D is_pmem ? 2 : 1,
+		.EFI_memory_type_attr =3D flags ? 2 : 1,
         .DPA_offset =3D 0,
-        .DPA_length =3D int128_get64(mr->size),
+		.DPA_length =3D size,
     };
=20
     /* Header always at start of structure */
@@ -158,14 +158,15 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat=
_table, void *priv)
     g_autofree CDATSubHeader **table =3D NULL;
     CXLType3Dev *ct3d =3D priv;
     MemoryRegion *volatile_mr =3D NULL, *nonvolatile_mr =3D NULL;
+	MemoryRegion *dc_mr =3D NULL;
     int dsmad_handle =3D 0;
     int cur_ent =3D 0;
     int len =3D 0;
     int rc, i;
+	uint64_t vmr_size =3D 0, pmr_size =3D 0;
=20
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
-        return 0;
-    }
+	if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions)
+		return 0;
=20
     if (ct3d->hostvmem) {
         volatile_mr =3D host_memory_backend_get_memory(ct3d->hostvmem);
@@ -173,6 +174,7 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_t=
able, void *priv)
             return -EINVAL;
         }
         len +=3D CT3_CDAT_NUM_ENTRIES;
+		vmr_size =3D volatile_mr->size;
     }
=20
     if (ct3d->hostpmem) {
@@ -181,7 +183,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_=
table, void *priv)
             return -EINVAL;
         }
         len +=3D CT3_CDAT_NUM_ENTRIES;
-    }
+		pmr_size =3D nonvolatile_mr->size;
+	}
+
+	if (ct3d->dc.num_regions) {
+		if (ct3d->dc.host_dc) {
+			dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+			if (!dc_mr)
+				return -EINVAL;
+			len +=3D CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+		} else {
+			return -EINVAL;
+		}
+	}
=20
     table =3D g_malloc0(len * sizeof(*table));
     if (!table) {
@@ -189,23 +203,45 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat=
_table, void *priv)
     }
=20
     /* Now fill them in */
-    if (volatile_mr) {
-        rc =3D ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volati=
le_mr,
-                                           false, 0);
-        if (rc < 0) {
-            return rc;
-        }
-        cur_ent =3D CT3_CDAT_NUM_ENTRIES;
-    }
+	if (volatile_mr) {
+		rc =3D ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
+				0, 0, vmr_size);
+		if (rc < 0)
+			return rc;
+		cur_ent =3D CT3_CDAT_NUM_ENTRIES;
+	}
+
+	if (nonvolatile_mr) {
+		rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
+				CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);
+		if (rc < 0)
+			goto error_cleanup;
+		cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
+	}
+
+	if (dc_mr) {
+		uint64_t region_base =3D vmr_size + pmr_size;
+
+		/*
+		 * Currently we create cdat entries for each region, should we only
+		 * create dsmas table instead??
+		 * We assume all dc regions are non-volatile for now.
+		 *
+		 */
+		for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+			rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent])
+					, dsmad_handle++
+					, CDAT_DSMAS_FLAG_NV|CDAT_DSMAS_FLAG_DYNAMIC_CAP
+					, region_base, ct3d->dc.regions[i].len);
+			if (rc < 0)
+				goto error_cleanup;
+			ct3d->dc.regions[i].dsmadhandle =3D dsmad_handle-1;
+
+			cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
+			region_base +=3D ct3d->dc.regions[i].len;
+		}
+	}
=20
-    if (nonvolatile_mr) {
-        rc =3D ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_hand=
le++,
-                nonvolatile_mr, true, (volatile_mr ? volatile_mr->size : 0=
));
-        if (rc < 0) {
-            goto error_cleanup;
-        }
-        cur_ent +=3D CT3_CDAT_NUM_ENTRIES;
-    }
     assert(len =3D=3D cur_ent);
=20
     *cdat_table =3D g_steal_pointer(&table);
@@ -706,6 +742,11 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
 		/* dsmad_handle is set when creating cdat table entries */
 		region->flags =3D 0;
=20
+		region->blk_bitmap =3D bitmap_new(region->len / region->block_size);
+		if (!region->blk_bitmap)
+			return -1;
+		bitmap_zero(region->blk_bitmap, region->len / region->block_size);
+
 		region_base +=3D region->len;
 	}
 	QTAILQ_INIT(&ct3d->dc.extents);
@@ -713,11 +754,24 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
 	return 0;
 }
=20
+static void cxl_destroy_toy_regions(CXLType3Dev *ct3d)
+{
+	int i;
+	struct CXLDCD_Region *region;
+
+	for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+		region =3D &ct3d->dc.regions[i];
+		if (region->blk_bitmap)
+			g_free(region->blk_bitmap);
+	}
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds =3D DEVICE(ct3d);
=20
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+	if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+			&& !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -754,7 +808,7 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error *=
*errp)
         }
         address_space_init(&ct3d->hostvmem_as, vmr, v_name);
         ct3d->cxl_dstate.vmem_size =3D vmr->size;
-        ct3d->cxl_dstate.mem_size +=3D vmr->size;
+		ct3d->cxl_dstate.static_mem_size +=3D vmr->size;
         g_free(v_name);
     }
=20
@@ -777,12 +831,47 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error=
 **errp)
         }
         address_space_init(&ct3d->hostpmem_as, pmr, p_name);
         ct3d->cxl_dstate.pmem_size =3D pmr->size;
-        ct3d->cxl_dstate.mem_size +=3D pmr->size;
+		ct3d->cxl_dstate.static_mem_size +=3D pmr->size;
         g_free(p_name);
     }
=20
-	if (cxl_create_toy_regions(ct3d))
-		return false;
+	ct3d->dc.total_dynamic_capicity =3D 0;
+	if (ct3d->dc.host_dc) {
+		MemoryRegion *dc_mr;
+		char *dc_name;
+		uint64_t total_region_size =3D 0;
+		int i;
+
+		dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+		if (!dc_mr) {
+			error_setg(errp, "dynamic capacity must have backing device");
+			return false;
+		}
+		/* FIXME: set dc as nonvolatile for now */
+		memory_region_set_nonvolatile(dc_mr, true);
+		memory_region_set_enabled(dc_mr, true);
+		host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+		if (ds->id) {
+			dc_name =3D g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+		} else {
+			dc_name =3D g_strdup("cxl-dcd-dpa-dc-space");
+		}
+		address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+
+		if (cxl_create_toy_regions(ct3d)) {
+			return false;
+		}
+
+		for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+			total_region_size +=3D ct3d->dc.regions[i].len;
+		}
+		/* Make sure the host backend is large enough to cover all dc range */
+		assert(total_region_size <=3D dc_mr->size);
+		assert(dc_mr->size % (256*1024*1024) =3D=3D 0);
+
+		ct3d->dc.total_dynamic_capicity =3D total_region_size;
+		g_free(dc_name);
+	}
=20
     return true;
 }
@@ -890,6 +979,10 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+	if (ct3d->dc.host_dc) {
+		cxl_destroy_toy_regions(ct3d);
+		address_space_destroy(&ct3d->dc.host_dc_as);
+	}
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -909,6 +1002,10 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
+	if (ct3d->dc.host_dc) {
+		cxl_destroy_toy_regions(ct3d);
+		address_space_destroy(&ct3d->dc.host_dc_as);
+	}
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -917,6 +1014,100 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
=20
+static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+		uint64_t len)
+{
+	int i;
+	CXLDCD_Region *region =3D NULL;
+
+	if (dpa < ct3d->dc.regions[0].base
+		|| dpa >=3D ct3d->dc.regions[0].base + ct3d->dc.total_dynamic_capicity)
+		return;
+
+	/*
+	 * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+	 * Region 0 being used for the lowest DPA of Dynamic Capacity and
+	 * Region 7 for the highest DPA.
+	 * So we check from the last region to find where the dpa belongs.
+	 * access across multiple regions is not allowed.
+	 **/
+	for (i =3D ct3d->dc.num_regions-1; i >=3D 0; i--) {
+		region =3D &ct3d->dc.regions[i];
+		if (dpa >=3D region->base)
+			break;
+	}
+
+	bitmap_set(region->blk_bitmap, (dpa-region->base)/region->block_size,
+			len/region->block_size);
+}
+
+static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+		uint64_t len)
+{
+	int i;
+	CXLDCD_Region *region =3D NULL;
+	uint64_t nbits;
+	long nr;
+
+	if (dpa < ct3d->dc.regions[0].base
+		   || dpa >=3D ct3d->dc.regions[0].base + ct3d->dc.total_dynamic_capicit=
y)
+		return false;
+
+	/*
+	 * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+	 * Region 0 being used for the lowest DPA of Dynamic Capacity and
+	 * Region 7 for the highest DPA.
+	 * So we check from the last region to find where the dpa belongs.
+	 * access across multiple regions is not allowed.
+	 **/
+	for (i =3D ct3d->dc.num_regions-1; i >=3D 0; i--) {
+		region =3D &ct3d->dc.regions[i];
+		if (dpa >=3D region->base)
+			break;
+	}
+
+	nr =3D (dpa-region->base)/region->block_size;
+	nbits =3D (len + region->block_size-1)/region->block_size;
+	if (find_next_zero_bit(region->blk_bitmap, nr+nbits, nr)
+			>=3D nr+nbits)
+		return true;
+
+	return false;
+}
+
+static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+		uint64_t len)
+{
+	int i;
+	CXLDCD_Region *region =3D NULL;
+	uint64_t nbits;
+	long nr;
+
+	if (dpa < ct3d->dc.regions[0].base
+		|| dpa >=3D ct3d->dc.regions[0].base + ct3d->dc.total_dynamic_capicity)
+		return;
+
+	/*
+	 * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+	 * Region 0 being used for the lowest DPA of Dynamic Capacity and
+	 * Region 7 for the highest DPA.
+	 * So we check from the last region to find where the dpa belongs.
+	 * access across multiple regions is not allowed.
+	 **/
+	for (i =3D ct3d->dc.num_regions-1; i >=3D 0; i--) {
+		region =3D &ct3d->dc.regions[i];
+		if (dpa >=3D region->base)
+			break;
+	}
+
+	nr =3D (dpa-region->base) / region->block_size;
+	nbits =3D (len + region->block_size-1) / region->block_size;
+	for (i =3D 0; i < nbits; i++) {
+		clear_bit(nr, region->blk_bitmap);
+		nr++;
+	}
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *d=
pa)
 {
     uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
@@ -973,16 +1164,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *=
ct3d,
                                        AddressSpace **as,
                                        uint64_t *dpa_offset)
 {
-    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
+	MemoryRegion *vmr =3D NULL, *pmr =3D NULL, *dc_mr =3D NULL;
+	uint64_t vmr_size =3D 0, pmr_size =3D 0, dc_size =3D 0;
=20
     if (ct3d->hostvmem) {
         vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
+		vmr_size =3D int128_get64(vmr->size);
     }
     if (ct3d->hostpmem) {
         pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
+		pmr_size =3D int128_get64(pmr->size);
     }
+	if (ct3d->dc.host_dc) {
+		dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+		/* Do we want dc_size to be dc_mr->size or not?? */
+		dc_size =3D ct3d->dc.total_dynamic_capicity;
+	}
=20
-    if (!vmr && !pmr) {
+	if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
=20
@@ -990,20 +1189,22 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *=
ct3d,
         return -EINVAL;
     }
=20
-    if (*dpa_offset > int128_get64(ct3d->cxl_dstate.mem_size)) {
+    if (*dpa_offset >=3D vmr_size + pmr_size + dc_size ||
+       (*dpa_offset >=3D vmr_size + pmr_size && ct3d->dc.num_regions =3D=
=3D 0)) {
         return -EINVAL;
     }
=20
-    if (vmr) {
-        if (*dpa_offset < int128_get64(vmr->size)) {
-            *as =3D &ct3d->hostvmem_as;
-        } else {
-            *as =3D &ct3d->hostpmem_as;
-            *dpa_offset -=3D vmr->size;
-        }
-    } else {
-        *as =3D &ct3d->hostpmem_as;
-    }
+	if (*dpa_offset < vmr_size)
+		*as =3D &ct3d->hostvmem_as;
+	else if (*dpa_offset < vmr_size + pmr_size) {
+		*as =3D &ct3d->hostpmem_as;
+		*dpa_offset -=3D vmr_size;
+	} else {
+		if (!test_region_block_backed(ct3d, *dpa_offset, size))
+			return -ENODEV;
+		*as =3D &ct3d->dc.host_dc_as;
+		*dpa_offset -=3D (vmr_size + pmr_size);
+	}
=20
     return 0;
 }
@@ -1069,6 +1270,8 @@ static Property ct3_props[] =3D {
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
 	DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+	DEFINE_PROP_LINK("dc-memdev", CXLType3Dev, dc.host_dc,
+					TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
=20
@@ -1135,34 +1338,41 @@ static void set_lsa(CXLType3Dev *ct3d, const void *=
buf, uint64_t size,
=20
 static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t =
*data)
 {
-    MemoryRegion *vmr =3D NULL, *pmr =3D NULL;
+	MemoryRegion *vmr =3D NULL, *pmr =3D NULL, *dc_mr =3D NULL;
     AddressSpace *as;
+	uint64_t vmr_size =3D 0, pmr_size =3D 0, dc_size =3D 0;
=20
     if (ct3d->hostvmem) {
         vmr =3D host_memory_backend_get_memory(ct3d->hostvmem);
+		vmr_size =3D int128_get64(vmr->size);
     }
     if (ct3d->hostpmem) {
         pmr =3D host_memory_backend_get_memory(ct3d->hostpmem);
+		pmr_size =3D int128_get64(pmr->size);
     }
+	if (ct3d->dc.host_dc) {
+		dc_mr =3D host_memory_backend_get_memory(ct3d->dc.host_dc);
+		dc_size =3D ct3d->dc.total_dynamic_capicity;
+	}
=20
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return false;
     }
=20
-    if (dpa_offset + 64 > int128_get64(ct3d->cxl_dstate.mem_size)) {
-        return false;
-    }
+	if (dpa_offset >=3D vmr_size + pmr_size + dc_size)
+		return false;
+	if (dpa_offset + 64 >=3D vmr_size + pmr_size && ct3d->dc.num_regions =3D=
=3D 0)
+		return false;
=20
-    if (vmr) {
-        if (dpa_offset <=3D int128_get64(vmr->size)) {
-            as =3D &ct3d->hostvmem_as;
-        } else {
-            as =3D &ct3d->hostpmem_as;
-            dpa_offset -=3D vmr->size;
-        }
-    } else {
-        as =3D &ct3d->hostpmem_as;
-    }
+	if (dpa_offset < vmr_size) {
+		as =3D &ct3d->hostvmem_as;
+	} else if (dpa_offset < vmr_size + pmr_size) {
+		as =3D &ct3d->hostpmem_as;
+		dpa_offset -=3D vmr->size;
+	} else {
+		as =3D &ct3d->dc.host_dc_as;
+		dpa_offset -=3D (vmr_size + pmr_size);
+	}
=20
     address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data, 64)=
;
     return true;
@@ -1711,6 +1921,14 @@ static void qmp_cxl_process_dynamic_capacity_event(c=
onst char *path, CxlEventLog
 		memcpy(&dCap.dynamic_capacity_extent, &extents[i]
 				, sizeof(CXLDCExtent_raw));
=20
+		if (dCap.type =3D=3D 0x0)
+			set_region_block_backed(dcd, extents[i].start_dpa, extents[i].len);
+		else if (dCap.type =3D=3D 0x1)
+			clear_region_block_backed(dcd, extents[i].start_dpa,
+					extents[i].len);
+		else
+			error_setg(errp, "DC event not support yet, no bitmap op");
+
 		if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
 					(CXLEventRecordRaw *)&dCap)) {
 			;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index c0c8fcc24b..d9b6776e2c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -211,7 +211,7 @@ typedef struct cxl_device_state {
     } timestamp;
=20
     /* memory region size, HDM */
-    uint64_t mem_size;
+	uint64_t static_mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
=20
@@ -412,6 +412,7 @@ typedef struct CXLDCD_Region {
 	uint64_t block_size;
 	uint32_t dsmadhandle;
 	uint8_t flags;
+	unsigned long *blk_bitmap;
 } CXLDCD_Region;
=20
 struct CXLType3Dev {
@@ -447,12 +448,17 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
=20
 	struct dynamic_capacity {
+		HostMemoryBackend *host_dc;
+		AddressSpace host_dc_as;
+
+		uint8_t num_hosts; //Table 7-55
 		uint8_t num_regions; // 1-8
 		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
 		CXLDCDExtentList extents;
=20
 		uint32_t total_extent_count;
 		uint32_t ext_list_gen_seq;
+		uint64_t total_dynamic_capicity; // 256M aligned
 	} dc;
 };
=20
--=20
2.25.1
