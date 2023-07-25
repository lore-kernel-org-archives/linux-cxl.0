Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E904C001DF
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbjGYSkD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbjGYSkA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:00 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8097319BD
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:58 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183957usoutp027b4de56e6490a6180a47d3fd2584a026~1MFndHyew1430014300usoutp02k;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230725183957usoutp027b4de56e6490a6180a47d3fd2584a026~1MFndHyew1430014300usoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310397;
        bh=lBr/qyVNRvXVjZ/owLK3vUCLHdyi81JwmP39aawYy7E=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=g4EYZf8CQj9bQ2nGOjltiuK92Sjs67JyCHJyajbJI+/ncJtzn1eHgAwTLw6GTUSuk
         uVfq64DdH3+6SVeBaFvYY6jzGqyZKLR8suC7qvquECxh598J8e/M8ze6DE6uvCRemB
         XipR+6tFKoyIa854tVJcsOKRa0MaI5CWZrdfg1mo=
Received: from ussmges1new.samsung.com (u109.gpu85.samsung.co.kr
        [203.254.195.109]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p19e9491c5c92badc2d2c8ffd5c5996421~1MFnUl-l00901509015uscas1p1g;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges1new.samsung.com (USCPEMTA) with SMTP id 13.DD.51475.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p28b38d294f90b97f99769466cc533b4de~1MFm_jFbK0167001670uscas1p2k;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
X-AuditID: cbfec36d-8a3ff7000001c913-42-64c016fd02fb
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id A3.54.38326.CF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
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
Subject: [Qemu PATCH v2 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Thread-Topic: [Qemu PATCH v2 6/9] hw/mem/cxl_type3: Add DC extent list
        representative and get DC extent list mailbox support
Thread-Index: AQHZvydobNJU5Smx1kW/FPcC4N6b9Q==
Date:   Tue, 25 Jul 2023 18:39:56 +0000
Message-ID: <20230725183939.2741025-7-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJKsWRmVeSWpSXmKPExsWy7djXc7p/xQ6kGGzdI2XRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV0bD4/iCz1oV794fZWlgfKfQxcjJISFgItG19TNLFyMXh5DASkaJqZeWsEI4rUwS
        K99MBcpwgFW9nC0JEV/LKNF/cAkjhPOJUaLh9QMmCGcZo8Sb9l/MIHPZBBQl9nVtZwOxRQSM
        JY4dXsIMUsQs8JZF4uOaNywgCWGBSolDZ54yQRTVSVzt3cwIsk5EQE/i83kvkDCLgKrEjSNH
        GEFsXgFLic2LHoLN5xSwknj2ZTYriM0oICbx/dQasDHMAuISt57MZ4L4TVBi0ew9zBC2mMS/
        XQ/ZIGx5ick/ZkDZihL3v79kh+jVk7gxdQobhK0tsWzha2aIvYISJ2c+YYGol5Q4uOIGOLwk
        BKZzSjz9s48VIuEicX33GXYIW1ri6vWpzJCgS5ZY9ZELIpwjMX/JFqg51hIL/6xnmsCoMgvJ
        2bOQnDELyRmzkJyxgJFlFaN4aXFxbnpqsWFearlecWJucWleul5yfu4mRmBqO/3vcO4Oxh23
        PuodYmTiYDzEKMHBrCTCaxizL0WINyWxsiq1KD++qDQntfgQozQHi5I4r6HtyWQhgfTEktTs
        1NSC1CKYLBMHp1QD0wru4rDgB9tcD+841dp0bHrHIR2LpX+i2x4oblNetsPgzlbrpxPXPfu0
        Nf5NqFb5LQkP949Mv7yeMTd7Ovy10/tc9DJDbZG+00YPwyWeFx9XZqpcdXRpcuyrmJhw0GYX
        /zPrl50J6+N2HzjvNUfe+XGeyf9/M1b+iAhX80v+e1R0No/R3/m9du9Wmz9tNTT/s/z4uneH
        l/+yLJkrHKr7UDzAV2xFbdF95eVbl/w5Gp93ZY+zYuHSX22LN31haf77c8o67fnlNw7e4zgj
        O2v7pKSdBYeX3HFTOWCslu8ddaSQOaEhW45f5orODJu0tdudDkSqJE7S1f354dHXPbtbTaa0
        PdzQxTytWtnNyoRtjbYSS3FGoqEWc1FxIgCLUL5n3AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA02Se0hTYRjG+845Ho8T47Q0Pwu7DCq0Wo0sjiVhLOtYRhcCK0odeZoznWtH
        S4Ny1BCaWC5b1kRMnRZqWNrFzOu8rLw0s4tmSV62qUh5JRMzcx0C//s97/c87/P98RIo34ot
        J2TyWEYpl0QJcB4mUyHaTbPLasK3NJQiVLL5MaDSdW2AKvxcBCjV1T6MUr8aQahq6wBGFWR/
        wimzvgmjBrQDCJVn6EMpU0oZ5u9Mt6WlOtC5qgD6pb7bkVbXf59XFUMI/WRszpG2fCpF6NLh
        QZTWZSTSEyUrD/NO8vzCmSjZBUa5eVcYL0LVH6qY8I7/MdKAqcCP1RpAEJD0gUMZHhrAI/hk
        IYAPk+pwTowDmJTTjHIiH8Cs3EKgAU4ETq6BVZoXuJ1dya2wsc6A2hklhzH4852znZeSCdDY
        YkU4zxXYUdaI29tcSSGcMO+3jzFyLeysr/+30oX0haU5vajdwp/nZ9oQ+9iJ3AFtkxkOdgbk
        MjjVVIRwTe6wy5L1jyFJQkOFGeXYDQ71/3HgeBVM+3UX53gN/DY15MhlhbBTdxvneAPMzx5G
        uS8sgW/uWTDO7wFrH3ZiqQDqF9TpF8T1C+L6BfH7ACsA7nEsGy2NZ0Vy5qKQlUSzcXKp8ExM
        dAmYv4TmP3UnykBD15jQCBACGAEkUIGri+hUVTjfJVyScIlRxoQq46IY1ghWEJjA3YUfoA3l
        k1JJLHOOYRSM8v8rQjgtVyFwfaS3ZK5GIZ6LMbUqrIK3vq+vzXpaieKdjY7be9JL8kKCtp35
        6h/YU7X1dJLJ9mS38nNN+7EJdWumwuvm8yO5MnG8jRgvPho29qDNz1/aP/p4z9GCtGHPaXxy
        ClSVewUY2xUGdU/Jtpabi6RZeyvLT91LPGjyyxWd7S4u/3jnwHlxgGJgbZh544dxTXp+h0+K
        4Xp1YrvJMGsZGSW8+bKOjmA+LC7MieiTB/amVT71lIQS/Xcd9tmmL8cFqwOdT67LVuuTMw+J
        E48v1qXagr6II5nf2ket21NnvJpdsd9eg6o8UZNFHfECcXvuo/mY0pV8f6Y89tYoXXuD1c28
        F2BshETkjSpZyV/wthbdeAMAAA==
X-CMS-MailID: 20230725183957uscas1p28b38d294f90b97f99769466cc533b4de
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183957uscas1p28b38d294f90b97f99769466cc533b4de
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p28b38d294f90b97f99769466cc533b4de@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add dynamic capacity extent list representative to the definition of
CXLType3Dev and add get DC extent list mailbox command per
CXL.spec.3.0:.8.2.9.8.9.2.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  1 +
 include/hw/cxl/cxl_device.h | 23 ++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0511b8e6f7..3d25a9697e 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -83,6 +83,7 @@ enum {
         #define CLEAR_POISON           0x2
     DCD_CONFIG  =3D 0x48, /*r3.0: 8.2.9.8.9*/
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH =3D 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -1018,6 +1019,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(struct =
cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
=20
+/*
+ * cxl spec 3.0: 8.2.9.8.9.2
+ * Get Dynamic Capacity Extent List (Opcode 4810h)
+ */
+static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
+        CXLDeviceState *cxl_dstate,
+        uint16_t *len)
+{
+    struct get_dyn_cap_ext_list_in_pl {
+        uint32_t extent_cnt;
+        uint32_t start_extent_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_out_pl {
+        uint32_t count;
+        uint32_t total_extents;
+        uint32_t generation_num;
+        uint8_t rsvd[4];
+        CXLDCExtent_raw records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_ext_list_in_pl *in =3D (void *)cmd->payload;
+    struct get_dyn_cap_ext_list_out_pl *out =3D (void *)cmd->payload;
+    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    uint16_t record_count =3D 0, i =3D 0, record_done =3D 0;
+    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
+    CXLDCD_Extent *ent;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id =3D in->start_extent_id;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count =3D MIN(in->extent_cnt,
+            ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len =3D sizeof(*out) + record_count * sizeof(out->records[0]);
+    /* May need more processing here in the future */
+    assert(out_pl_len <=3D CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    stl_le_p(&out->count, record_count);
+    stl_le_p(&out->total_extents, ct3d->dc.total_extent_count);
+    stl_le_p(&out->generation_num, ct3d->dc.ext_list_gen_seq);
+
+    if (record_count > 0) {
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (i++ < start_extent_id) {
+                continue;
+            }
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa)=
;
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_se=
q);
+            record_done++;
+            if (record_done =3D=3D record_count) {
+                break;
+            }
+        }
+    }
+
+    *len =3D out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1058,6 +1126,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
         cmd_media_clear_poison, 72, 0 },
     [DCD_CONFIG][GET_DC_CONFIG] =3D { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_li=
st,
+        8, 0 },
 };
=20
 static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 76bbd9f785..f1170b8047 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -789,6 +789,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
=20
         region_base +=3D region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
=20
     return 0;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1c99b05a66..3a338b3b37 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -385,6 +385,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
=20
 #define DCD_MAX_REGION_NUM 8
=20
+typedef struct CXLDCD_Extent_raw {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+} QEMU_PACKED CXLDCExtent_raw;
+
+typedef struct CXLDCD_Extent {
+    uint64_t start_dpa;
+    uint64_t len;
+    uint8_t tag[0x10];
+    uint16_t shared_seq;
+    uint8_t rsvd[0x6];
+
+    QTAILQ_ENTRY(CXLDCD_Extent) node;
+} CXLDCD_Extent;
+typedef QTAILQ_HEAD(, CXLDCD_Extent) CXLDCDExtentList;
+
 typedef struct CXLDCD_Region {
     uint64_t base;
     uint64_t decode_len; /* in multiples of 256MB */
@@ -433,6 +452,10 @@ struct CXLType3Dev {
=20
         uint8_t num_regions; /* 0-8 regions */
         struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
+        CXLDCDExtentList extents;
+
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
     } dc;
 };
=20
--=20
2.25.1
