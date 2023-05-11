Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63502C7EE25
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:05:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239155AbjEKSF1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbjEKSFV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:05:21 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA857272C
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:04:50 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175642usoutp02a9bd665f90f5a3c3cab6da135743beb9~eKHcZj1N82433724337usoutp02V;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230511175642usoutp02a9bd665f90f5a3c3cab6da135743beb9~eKHcZj1N82433724337usoutp02V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827802;
        bh=QpULL+ioIPOqLvzKWs8eGwI8BmkLVsKBNOUsNKDjwoE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=HMBp7IYTtxXGbSnVxibPo2S3lQDG3JkZ23VOe64s/zLpOZZhpJm8DgWZvMWx5djlj
         mI+cl0PhXstiolNMjMXH+tybMmAnJtCu1pkLS8NuN01wF7r76ri2sbWmCuyxPiiixW
         mo50enQRlIkwYAWkD12wdynfio78c+MECkCMcmcA=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p24e812a44f9ce2ea34869a3486ae28eb4~eKHcFH3TW1429314293uscas1p2i;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id AF.8A.19925.A5C2D546; Thu,
        11 May 2023 13:56:42 -0400 (EDT)
Received: from ussmgxs2new.samsung.com (u91.gpu85.samsung.co.kr
        [203.254.195.91]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p1a998a2d4a20c370f0172db93d537ed39~eKHbyYsd30296202962uscas1p1G;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
X-AuditID: cbfec36d-975ff70000004dd5-86-645d2c5a8261
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs2new.samsung.com (USCPEXMTA) with SMTP id 1C.AE.44215.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
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
Subject: [RFC 5/7] hw/cxl/cxl-mailbox-utils: Add mailbox commands to support
 add/release dynamic capacity response
Thread-Topic: [RFC 5/7] hw/cxl/cxl-mailbox-utils: Add mailbox commands to
        support add/release dynamic capacity response
Thread-Index: AQHZhDHwpHEBWsJ1h0+7w9AQAuHaPg==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-6-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djX87pROrEpBj8mCVh0n9/AaDF96gVG
        i9U31zBaNDQ9YrFo2f2eyWL/0+csFqsWXmOzOD/rFIvF84nPmSyWLnnEbHG8dweLA7fHhckT
        WD0WN7h67Jx1l92j5chbIG/PSyaPjR//s3s8ubaZyWPz6xfMHlNn13t83iQXwBXFZZOSmpNZ
        llqkb5fAlbG5ZQNrwTznivajZ9gaGBeZdTFyckgImEg8utvC3MXIxSEksJJRYvqfVcwgCSGB
        ViaJT5v0YIp625+zQxStZZQ4umUilPOJUWLt2x+sEM4yRon33/eAtbMJKErs69rOBmKLCBhL
        HDu8BGwHs8BbFomPa96wgCSEBUoknt1axgJRVCmxYlcfVIOexLbevWCDWARUJc7d2MEIYvMK
        WEp823SaHcTmFLCS2NB8ggnEZhQQk/h+ag2YzSwgLnHryXwmiLsFJRbNhjhIAqjm366HbBC2
        vMTkHzOgbEWJ+99fskP06kncmDqFDcLWlli28DUzxF5BiZMzn7BA1EtKHFxxgwXkGQmBfk6J
        +UuPQyVcJHZuOAC1WFri791lQDYHkJ0sseojF0Q4R2L+ki1Q5dYSC/+sZ5rAqDILydmzkJwx
        C8kZs5CcsYCRZRWjeGlxcW56arFhXmq5XnFibnFpXrpecn7uJkZgejv973DuDsYdtz7qHWJk
        4mA8xCjBwawkwvt2SXSKEG9KYmVValF+fFFpTmrxIUZpDhYlcV5D25PJQgLpiSWp2ampBalF
        MFkmDk6pBiYP9SsMyy5vC9Q92spiah0npXf6x2rRY5KRm3inGe/5eGbukmv6ObWeoQdW6cWf
        qb3sfKlyxrNH/S1/n/762fWC43D0ikvV2YHvHpmdDv92s2BudfuTAL45mU3cDB8XNTyXuiD5
        0Oj1JI0VGwIVhI84lXJcmKob1xX7TH2Z64VTE7nO73vwxpgzkLtejzk5y/zpRB2l+Q/0Zplv
        3cOmeV3Tfu5CNebIOq8jiUFZ0o/9cuICn28oEJ2Wt94v7dNEg1vh9yMnVL+QP7ryBFvqj1qf
        rkiz824zDy/9qmeU0Kq5cqbR/v+RDPvKRO/+yn3492Px42mfl7ieulBwct1Xx80Zv63mLbTU
        nRd/Zl7On1nLlViKMxINtZiLihMBYvfvw94DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0UTdSJzbF4NV0I4vu8xsYLaZPvcBo
        sfrmGkaLhqZHLBYtu98zWex/+pzFYtXCa2wW52edYrF4PvE5k8XSJY+YLY737mBx4Pa4MHkC
        q8fiBlePnbPusnu0HHkL5O15yeSx8eN/do8n1zYzeWx+/YLZY+rseo/Pm+QCuKK4bFJSczLL
        Uov07RK4Mja3bGAtmOdc0X70DFsD4yKzLkZODgkBE4ne9ufsXYxcHEICqxklfnyYBOV8YpTo
        6Z/CCuEsY5Ro3LqOFaSFTUBRYl/XdjYQW0TAWOLY4SXMIDazwGsWiW8XuUFsYYESiWe3lrFA
        1FRK/L//hBHC1pPY1rsXrJ5FQFXi3I0dYHFeAUuJb5tOs4PYQkD2x587wWxOASuJDc0nmEBs
        RgExie+n1jBB7BKXuPVkPhPECwISS/acZ4awRSVePv7HCmHLS0z+MYMNwlaUuP/9JTtEr57E
        jalT2CBsbYllC18zQ9wgKHFy5hMWiHpJiYMrbrBMYJSYhWTdLCTts5C0z0LSvoCRZRWjeGlx
        cW56RbFRXmq5XnFibnFpXrpecn7uJkZgajj973D0Dsbbtz7qHWJk4mA8xCjBwawkwvt2SXSK
        EG9KYmVValF+fFFpTmrxIUZpDhYlcd6XURPjhQTSE0tSs1NTC1KLYLJMHJxSDUysp4OWLPoe
        ffTE+/ZJ3zeaizH+Nm+8nni+OWfd0y+RaYYf6rb0XHxy3YJB1TzkzuHJhcr5W/Z7aq6W/s/h
        acB2LSvy5Ju10Wum2PEF/1rSxB70VivGasGOC6lnVE6yVqkmt7BMOBxhW976SKhAbdLnh58X
        MjwrXuHk+dpfMlOJx2K1bzJX/BajyTUrp0Zc0Dt3q7NB8cKCzT9n7r6bUMAvZP5shk2giIFN
        Kt8Oh5ow91+LW512LWN8yzvFRvrjxMuPqr8u17a6nDqbyVG348R1Jkk/6c1PDu8IUWINqtyZ
        vrDLtbPI/nGxebGNcMYV9pArNzMfbo/KfV1Sa7LCeMPETSHBBxVqNL/y1XD7ZCmxFGckGmox
        FxUnAgAMiTOtfAMAAA==
X-CMS-MailID: 20230511175642uscas1p1a998a2d4a20c370f0172db93d537ed39
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175642uscas1p1a998a2d4a20c370f0172db93d537ed39
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175642uscas1p1a998a2d4a20c370f0172db93d537ed39@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Per CXL spec 3.0, we implemented the two mailbox commands:
Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
Release Dynamic Capacity Response (Opcode 4803h) 8.2.9.8.9.4.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 223 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   3 +-
 2 files changed, 225 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ed2ac154cb..7212934627 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,8 @@ enum {
 	DCD_CONFIG =3D 0x48, /*8.2.9.8.9*/
 		#define GET_DC_REGION_CONFIG   0x0
 		#define GET_DYN_CAP_EXT_LIST   0x1
+		#define ADD_DYN_CAP_RSP        0x2
+		#define RELEASE_DYN_CAP        0x3
     PHYSICAL_SWITCH =3D 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -1069,6 +1071,221 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(stru=
ct cxl_cmd *cmd,
 	return CXL_MBOX_SUCCESS;
 }
=20
+static inline int test_bits(const unsigned long *addr, int nr, int size)
+{
+	unsigned long res =3D find_next_zero_bit(addr, size + nr, nr);
+
+	if (res >=3D nr + size)
+		return 1;
+	else
+		return 0;
+}
+
+static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa
+		, uint64_t len)
+{
+	int8_t i =3D dev->dc.num_regions-1;
+
+	while (i > 0 && dpa < dev->dc.regions[i].base)
+		i--;
+
+	if (dpa < dev->dc.regions[i].base
+			|| dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].len)
+		return dev->dc.num_regions;
+
+	return i;
+}
+
+static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev, void *dat=
a)
+{
+	struct updated_dc_extent_list_in_pl {
+		uint32_t num_entries_updated;
+		uint8_t rsvd[4];
+		struct {
+			uint64_t start_dpa;
+			uint64_t len;
+			uint8_t rsvd[8];
+		} QEMU_PACKED updated_entries[];
+	} QEMU_PACKED;
+
+	struct updated_dc_extent_list_in_pl *in =3D data;
+	unsigned long *blk_bitmap;
+	uint64_t min_block_size =3D dev->dc.regions[0].block_size;
+	struct CXLDCD_Region *region =3D &dev->dc.regions[0];
+	uint32_t i;
+	uint64_t dpa, len;
+	uint8_t rid;
+
+	for (i =3D 1; i < dev->dc.num_regions; i++) {
+		region =3D &dev->dc.regions[i];
+		if (min_block_size > region->block_size)
+			min_block_size =3D region->block_size;
+	}
+	blk_bitmap =3D bitmap_new((region->len + region->base
+				- dev->dc.regions[0].base) / min_block_size);
+	g_assert(blk_bitmap);
+	bitmap_zero(blk_bitmap, (region->len + region->base
+				- dev->dc.regions[0].base) / min_block_size);
+
+	for (i =3D 0; i < in->num_entries_updated; i++) {
+		dpa =3D in->updated_entries[i].start_dpa;
+		len =3D in->updated_entries[i].len;
+
+		rid =3D find_region_id(dev, dpa, len);
+		if (rid =3D=3D dev->dc.num_regions) {
+			g_free(blk_bitmap);
+			return CXL_MBOX_INVALID_PA;
+		}
+		region =3D &dev->dc.regions[rid];
+		if (dpa % region->block_size || len % region->block_size) {
+			g_free(blk_bitmap);
+			return CXL_MBOX_INVALID_EXTENT_LIST;
+		}
+		/* the dpa range already covered by some other extents in the list */
+		if (test_bits(blk_bitmap, dpa/min_block_size, len/min_block_size)) {
+			g_free(blk_bitmap);
+			return CXL_MBOX_INVALID_EXTENT_LIST;
+		}
+		bitmap_set(blk_bitmap, dpa/min_block_size, len/min_block_size);
+	}
+
+	g_free(blk_bitmap);
+	return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * cxl spec 3.0: 8.2.9.8.9.3
+ * Add Dynamic Capacity Response (opcode 4802h)
+ * Assuming extent list is updated when a extent is added, when receiving
+ * the response, verify and ensure the extent is utilized by the host, and
+ * update extent list  as needed.
+ **/
+static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
+		CXLDeviceState *cxl_dstate,
+		uint16_t *len_unused)
+{
+	struct add_dyn_cap_ext_list_in_pl {
+		uint32_t num_entries_updated;
+		uint8_t rsvd[4];
+		struct {
+			uint64_t start_dpa;
+			uint64_t len;
+			uint8_t rsvd[8];
+		} QEMU_PACKED updated_entries[];
+	} QEMU_PACKED;
+
+	struct add_dyn_cap_ext_list_in_pl *in =3D (void *)cmd->payload;
+	struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_ds=
tate);
+	CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
+	CXLDCD_Extent *ent;
+	uint32_t i;
+	uint64_t dpa, len;
+	CXLRetCode rs;
+
+	if (in->num_entries_updated =3D=3D 0)
+		return CXL_MBOX_SUCCESS;
+
+	rs =3D detect_malformed_extent_list(ct3d, in);
+	if (rs !=3D CXL_MBOX_SUCCESS)
+		return rs;
+
+	for (i =3D 0; i < in->num_entries_updated; i++) {
+		dpa =3D in->updated_entries[i].start_dpa;
+		len =3D in->updated_entries[i].len;
+
+		/* Todo: check following
+		 * One or more of the updated extent lists contain Starting DPA
+		 * or Lengths that are out of range of a current extent list
+		 * maintained by the device.
+		 **/
+
+		QTAILQ_FOREACH(ent, extent_list, node) {
+			if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len)
+				return CXL_MBOX_INVALID_PA;
+			if (ent->start_dpa <=3D dpa
+				&& dpa + len <=3D ent->start_dpa + ent->len) {
+				ent->start_dpa =3D dpa;
+				ent->len =3D len;
+				break;
+			} else if ((dpa < ent->start_dpa + ent->len
+				&& dpa + len > ent->start_dpa + ent->len)
+				|| (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
+				return CXL_MBOX_INVALID_EXTENT_LIST;
+		}
+		// a new extent added
+		if (!ent) {
+			ent =3D g_new0(CXLDCD_Extent, 1);
+			assert(ent);
+			ent->start_dpa =3D dpa;
+			ent->len =3D len;
+			memset(ent->tag, 0, 0x10);
+			ent->shared_seq =3D 0;
+			QTAILQ_INSERT_TAIL(extent_list, ent, node);
+		}
+	}
+
+	return CXL_MBOX_SUCCESS;
+}
+
+/*
+ * Spec 3.0: 8.2.9.8.9.4
+ * Release Dynamic Capacity (opcode 4803h)
+ **/
+static CXLRetCode cmd_dcd_release_dcd_capacity(struct cxl_cmd *cmd,
+		CXLDeviceState *cxl_dstate,
+		uint16_t *len_unused)
+{
+	struct release_dcd_cap_in_pl {
+		uint32_t num_entries_updated;
+		uint8_t rsvd[4];
+		struct {
+			uint64_t start_dpa;
+			uint64_t len;
+			uint8_t rsvd[8];
+		} QEMU_PACKED updated_entries[];
+	} QEMU_PACKED;
+
+	struct release_dcd_cap_in_pl *in =3D (void *)cmd->payload;
+	struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_ds=
tate);
+	CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
+	CXLDCD_Extent *ent;
+	uint32_t i;
+	uint64_t dpa, len;
+	CXLRetCode rs;
+
+	if (in->num_entries_updated =3D=3D 0)
+		return CXL_MBOX_INVALID_INPUT;
+
+	rs =3D detect_malformed_extent_list(ct3d, in);
+	if (rs !=3D CXL_MBOX_SUCCESS)
+		return rs;
+
+		/* Todo: check following
+		 * One or more of the updated extent lists contain Starting DPA
+		 * or Lengths that are out of range of a current extent list
+		 * maintained by the device.
+		 **/
+
+	for (i =3D 0; i < in->num_entries_updated; i++) {
+		dpa =3D in->updated_entries[i].start_dpa;
+		len =3D in->updated_entries[i].len;
+
+		QTAILQ_FOREACH(ent, extent_list, node) {
+			if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len)
+				break;
+			else if ((dpa < ent->start_dpa + ent->len
+				&& dpa + len > ent->start_dpa + ent->len)
+				|| (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
+				return CXL_MBOX_INVALID_EXTENT_LIST;
+		}
+		/* found the entry, release it */
+		if (ent)
+			QTAILQ_REMOVE(extent_list, ent, node);
+	}
+
+	return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1112,6 +1329,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
 	[DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
 		"DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
 		8, 0 },
+	[DCD_CONFIG][ADD_DYN_CAP_RSP] =3D {
+		"ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
+		~0, IMMEDIATE_DATA_CHANGE },
+	[DCD_CONFIG][RELEASE_DYN_CAP] =3D {
+		"RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dcd_capacity,
+		~0, IMMEDIATE_DATA_CHANGE },
 };
=20
 static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 20ad5e7411..c0c8fcc24b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -131,7 +131,8 @@ typedef enum {
     CXL_MBOX_INCORRECT_PASSPHRASE =3D 0x14,
     CXL_MBOX_UNSUPPORTED_MAILBOX =3D 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH =3D 0x16,
-    CXL_MBOX_MAX =3D 0x17
+	CXL_MBOX_INVALID_EXTENT_LIST =3D 0x17,
+	CXL_MBOX_MAX =3D 0x18
 } CXLRetCode;
=20
 struct cxl_cmd;
--=20
2.25.1
