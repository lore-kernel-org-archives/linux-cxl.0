Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41589C7EE25
	for <linux-cxl@archiver.kernel.org>; Thu, 11 May 2023 18:09:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239099AbjEKSJt (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 11 May 2023 14:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239167AbjEKSJp (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 11 May 2023 14:09:45 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389CE1FC8
        for <linux-cxl@vger.kernel.org>; Thu, 11 May 2023 11:09:23 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230511175642usoutp016ff44876c1154987e787f6a52be0b3fc~eKHcY73Xq3054030540usoutp01K;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230511175642usoutp016ff44876c1154987e787f6a52be0b3fc~eKHcY73Xq3054030540usoutp01K
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1683827802;
        bh=qnonfFhRqaQhfcHEEqB6lqEoDUX58PGX49mIU0WSJvw=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=J9awrlXHW3ewrOvyfVNQx7Apu1u6fEtn6XtIEydb/O4IsunKFp54sb7+G99twn/vD
         FHPY3M0+4CfWTu2m1XBX3kJ9X/dO6iefMJ6eVZ9Hx2BUQtAdZO7E8j7MVX32WbJpAH
         ESTBrej4jlWKWCacIBRjHrhPdStoU6AukGTQqwoo=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175642uscas1p28fed0f20cf98f207ebd0e580ce44da32~eKHcD9Mj21431814318uscas1p2l;
        Thu, 11 May 2023 17:56:42 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 9F.8A.19925.A5C2D546; Thu,
        11 May 2023 13:56:42 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230511175641uscas1p2b70d27b1f20dc2dd54a0530170117530~eKHbw18qu2038420384uscas1p2F;
        Thu, 11 May 2023 17:56:41 +0000 (GMT)
X-AuditID: cbfec36d-bdbfe70000004dd5-85-645d2c5a5174
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 9A.48.64580.95C2D546; Thu,
        11 May 2023 13:56:41 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Thu, 11 May 2023 10:56:40 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Thu,
        11 May 2023 10:56:40 -0700
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
Subject: [RFC 4/7] hw/mem/cxl_type3: Add DC extent representative to cxl
 type3 device
Thread-Topic: [RFC 4/7] hw/mem/cxl_type3: Add DC extent representative to
        cxl type3 device
Thread-Index: AQHZhDHwR5sIHyogW0GjyQHnw1WJeg==
Date:   Thu, 11 May 2023 17:56:40 +0000
Message-ID: <20230511175609.2091136-5-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA02Sf0yMcRzH932e5+6ezo6npD6y9QuzhUvDPOXnDHtotpRhynKuR+Hu6K6I
        Pzg/Gi7Wkchz1i+x5JS7jHT9UJk4djVWSy1W4rpdxy4jzIXuOVv/vd7fz/v7+by/n31JPMAq
        CCH3qbJYtUqmiBSKiYfPvtkW7lywK23RudypdF7HfURfK+xE9N23RkRrTw0S9BnLF4xu/mgn
        6KqybiHdwVkJ2n7JjtG3KgZxuv1iHbFmCtNZoBcwN7Xrmcdcv4g589T1TzU4MMbk/iNihrpr
        MabWOYwzhYYTzFdzaIJ4p3hFGqvYd5hVR6/aLc7oebfhUFF0jq7JINKi1nk6RJJALQH79y06
        JCYDqDsInrs8OC9yMTD8bBbqkJ/X9EFvI/jCPQRWx2WMF6MIurkGES9uI/CU9XuvCKkIaNI9
        8nIgtRietVV4++KUiwC3cYSYKEyntsNNj1vEm1LgXttZAc9SsBSd93oIai7YeurQBEuoWDBc
        yPeyHxUH908/xyYYUUEwZjV6GaeCoXeoBONz+0O5oQHnOQjG6wd87wmDgh9FPo6A92MOEX9X
        Cj2FV4Q8z4fbZU6cn+sPL64PEbx/JrRU9nh3AVSeH1QbTvoarYNP5gHf4FlwzfiG4Dcshyq3
        mD9WQEnFA1+f5VD2uwbTozncpNjcpBjcpBjcpBiliKhCwdkajTKd1cSo2CNSjUypyValS+UH
        lWb077u9HG9T1qG6Xre0FWEkakVA4pGBEldFclqAJE129BirPpiqzlawmlY0iyQigyUxK1/I
        A6h0WRZ7gGUPser/VYz0C9FiSyTVwVufiC0HnF2LxYr1C6NU6tJ2bltKgfTXqdCUZLg6UD2/
        0dK3pbnxJ7Z0Wvj0oXyUGa4+mWs6MmhKCuVmRq24xJREd7kiEhTFs/sqN/rr3+61xyZmrBz+
        44nvXiQzy8fW7s5c13I8Icspr7+higsqfjWDW/a12jbF1askH7T05nUKornG/dyvnCTLaFif
        9uzm0iv11s8eR3Lt+J72J5UdF9sHzNvDQuKKd5y4XEMsO6y/a0lEOoeryPam/FNXYKVjo57N
        Xm2KTVUMF7Q19V+vyakp2bTp3OYFynDniNGdlNm8plgYOhoiCG8aeWXc25BvKh0NO54ROPg6
        vio1ktBkyGKicLVG9hfLNra63QMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWS2cA0UTdSJzbF4MsbQ4vu8xsYLaZPvcBo
        sfrmGkaLhqZHLBYtu98zWex/+pzFYtXCa2wW52edYrF4PvE5k8XSJY+YLY737mBx4Pa4MHkC
        q8fiBlePnbPusnu0HHkL5O15yeSx8eN/do8n1zYzeWx+/YLZY+rseo/Pm+QCuKK4bFJSczLL
        Uov07RK4Mm7ccyuYoV/RtW82ewPjIfUuRk4OCQETiccTzrF0MXJxCAmsZpQ43L2aEcL5xCjx
        8f55NghnGaPE5sldjCAtbAKKEvu6trOB2CICxhLHDi9hBrGZBV6zSHy7yA1iCwuES5y/+oAR
        oiZGoq+9iQnC1pPYPaOTBcRmEVCVOHdjB1gNr4ClxOyefjBbCMj++HMnO4jNKWAlsaH5BFgv
        o4CYxPdTa5ggdolL3HoynwniBQGJJXvOM0PYohIvH/9jhbDlJSb/mMEGYStK3P/+kh2iV0/i
        xtQpbBC2tsSyha+ZIW4QlDg58wkLRL2kxMEVN1gmMErMQrJuFpL2WUjaZyFpX8DIsopRvLS4
        ODe9otg4L7Vcrzgxt7g0L10vOT93EyMwMZz+dzhmB+O9Wx/1DjEycTAeYpTgYFYS4X27JDpF
        iDclsbIqtSg/vqg0J7X4EKM0B4uSOK9H7MR4IYH0xJLU7NTUgtQimCwTB6dUA5NAn3KvKs+E
        yrqqNVJT96RzmKY/adTRatY+tDAnqyrr65n2so0Tjp1d/7rWUdJdszO/7pr5f6+c6a94Sktk
        VlmVbZ26IPmDsJRQ3xL3meyhDHxJV1+dM+S04bCqY3KZeWVzV9Ce6I03M2smKBj/XLOXQ2kj
        V+SeXQmNIR+Mr83tMbKMnVt+dtKXH19P57K9F3PZ1ib2o9DOPoHVw8Zzu2xUwQrBqkSGj9Uy
        7YErO0Ki17D4365XTFHQj7RLWyDdFPrZlr0r3iDh1+xtW9sVuBalRyurCnx1rZj33fLVjfA9
        08TL5NP3efOpKuv2ecxw6V/w9/bWWN4Fug4/bj6qrnfgWftGqmy577Nn39KVWIozEg21mIuK
        EwESj5NeewMAAA==
X-CMS-MailID: 20230511175641uscas1p2b70d27b1f20dc2dd54a0530170117530
CMS-TYPE: 301P
X-CMS-RootMailID: 20230511175641uscas1p2b70d27b1f20dc2dd54a0530170117530
References: <20230511175609.2091136-1-fan.ni@samsung.com>
        <CGME20230511175641uscas1p2b70d27b1f20dc2dd54a0530170117530@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add dynamic capacity extent information to the definition of
CXLType3Dev and add get DC extent list mailbox command based on
CXL.spec.3.0:.8.2.9.8.9.2.

With this command, we can create dc regions as below:

region=3D$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
echo $region> /sys/bus/cxl/devices/decoder0.0/create_dc_region
echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
echo 1 > /sys/bus/cxl/devices/$region/interleave_ways

echo "dc" >/sys/bus/cxl/devices/decoder2.0/mode
echo 0x30000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size

echo 0x30000000 > /sys/bus/cxl/devices/$region/size
echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
echo 1 > /sys/bus/cxl/devices/$region/commit
echo $region > /sys/bus/cxl/drivers/cxl_region/bind

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 73 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 23 ++++++++++++
 3 files changed, 96 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 61c77e52d8..ed2ac154cb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,7 @@ enum {
         #define CLEAR_POISON           0x2
 	DCD_CONFIG =3D 0x48, /*8.2.9.8.9*/
 		#define GET_DC_REGION_CONFIG   0x0
+		#define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH =3D 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -938,7 +939,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd=
 *cmd,
 }
=20
 /*
- * cxl spec 3.0: 8.2.9.8.9.2
+ * cxl spec 3.0: 8.2.9.8.9.1
  * Get Dynamic Capacity Configuration
  **/
 static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
@@ -1001,6 +1002,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(struct =
cxl_cmd *cmd,
 	return CXL_MBOX_SUCCESS;
 }
=20
+/*
+ * cxl spec 3.0: 8.2.9.8.9.2
+ * Get Dynamic Capacity Extent List (Opcode 4810h)
+ **/
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
+		CXLDeviceState *cxl_dstate,
+		uint16_t *len)
+{
+	struct get_dyn_cap_ext_list_in_pl {
+		uint32_t extent_cnt;
+		uint32_t start_extent_id;
+	} QEMU_PACKED;
+
+	struct get_dyn_cap_ext_list_out_pl {
+		uint32_t count;
+		uint32_t total_extents;
+		uint32_t generation_num;
+		uint8_t rsvd[4];
+		struct {
+			uint64_t start_dpa;
+			uint64_t len;
+			uint8_t tag[0x10];
+			uint16_t shared_seq;
+			uint8_t rsvd[6];
+		} QEMU_PACKED records[];
+	} QEMU_PACKED;
+
+	struct get_dyn_cap_ext_list_in_pl *in =3D (void *)cmd->payload;
+	struct get_dyn_cap_ext_list_out_pl *out =3D (void *)cmd->payload;
+	struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev, cxl_ds=
tate);
+	uint16_t record_count =3D 0, i =3D 0, record_done =3D 0;
+	CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
+	CXLDCD_Extent *ent;
+	uint16_t out_pl_len;
+
+	if (in->start_extent_id > ct3d->dc.total_extent_count)
+		return CXL_MBOX_INVALID_INPUT;
+
+	if (ct3d->dc.total_extent_count - in->start_extent_id < in->extent_cnt)
+		record_count =3D ct3d->dc.total_extent_count - in->start_extent_id;
+	else
+		record_count =3D in->extent_cnt;
+
+	out_pl_len =3D sizeof(*out) + record_count * sizeof(out->records[0]);
+	assert(out_pl_len <=3D CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+	memset(out, 0, out_pl_len);
+	stl_le_p(&out->count, record_count);
+	stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+	stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+	QTAILQ_FOREACH(ent, extent_list, node) {
+		if (i++ < in->start_extent_id)
+			continue;
+		stq_le_p(&out->records[i].start_dpa, ent->start_dpa);
+		stq_le_p(&out->records[i].len, ent->len);
+		memcpy(&out->records[i].tag, ent->tag, 0x10);
+		stw_le_p(&out->records[i].shared_seq, ent->shared_seq);
+		record_done++;
+		if (record_done =3D=3D record_count)
+			break;
+	}
+
+	*len =3D out_pl_len;
+	return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1041,6 +1109,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
         cmd_media_clear_poison, 72, 0 },
 	[DCD_CONFIG][GET_DC_REGION_CONFIG] =3D { "DCD_GET_DC_REGION_CONFIG",
 		cmd_dcd_get_dyn_cap_config, 2, 0 },
+	[DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
+		"DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+		8, 0 },
 };
=20
 static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index b9c375d9b4..23954711b5 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -708,6 +708,7 @@ static int cxl_create_toy_regions(CXLType3Dev *ct3d)
=20
 		region_base +=3D region->len;
 	}
+	QTAILQ_INIT(&ct3d->dc.extents);
=20
 	return 0;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 8a04e53e90..20ad5e7411 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -385,6 +385,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
=20
 #define DCD_MAX_REGION_NUM 8
=20
+typedef struct CXLDCD_Extent_raw {
+	uint64_t start_dpa;
+	uint64_t len;
+	uint8_t tag[0x10];
+	uint16_t shared_seq;
+	uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtent_raw;
+
+typedef struct CXLDCD_Extent {
+	uint64_t start_dpa;
+	uint64_t len;
+	uint8_t tag[0x10];
+	uint16_t shared_seq;
+	uint8_t rsvd[0x6];
+
+	QTAILQ_ENTRY(CXLDCD_Extent) node;
+} CXLDCD_Extent;
+typedef QTAILQ_HEAD(, CXLDCD_Extent) CXLDCDExtentList;
+
 typedef struct CXLDCD_Region {
 	uint64_t base;
 	uint64_t decode_len; /* in multiples of 256MB */
@@ -429,6 +448,10 @@ struct CXLType3Dev {
 	struct dynamic_capacity {
 		uint8_t num_regions; // 1-8
 		struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
+		CXLDCDExtentList extents;
+
+		uint32_t total_extent_count;
+		uint32_t ext_list_gen_seq;
 	} dc;
 };
=20
--=20
2.25.1
