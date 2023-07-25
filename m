Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57101C04A6A
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231691AbjGYSkD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjGYSkA (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:00 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 811881FD2
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:58 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183957usoutp02b24c4a556f889ae031c04ff97bc50505~1MFm8ztg41412514125usoutp02g;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230725183957usoutp02b24c4a556f889ae031c04ff97bc50505~1MFm8ztg41412514125usoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310397;
        bh=ZRlzd8c3g2KsOYA3+M84nuNHo77atunwbmjFOddYgGk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KKcOQYCq6PZhL5kUA+eItmSciDQmMebDT5+KSUYYQX/DvD0dyWNq8rFbL3s5hsf9I
         4N981wONc2a+zsjuwqad0oP0cRgUfZH+nzBogXx7+jnEz24ZJ5iUoWLf2hNuYYlMpi
         FC49pYlQsXO5hXc9Xe9xYYSor+IQs72IFhknvS9I=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183956uscas1p2b3d33248e5971edd48e1fcad422a4b6c~1MFmz5tqs0167001670uscas1p2i;
        Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id B7.4E.62237.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183956uscas1p296403063c710f4b546d4fec7650915c4~1MFmgQ-Q62755227552uscas1p2B;
        Tue, 25 Jul 2023 18:39:56 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-8f-64c016fc55dc
Received: from SSI-EX3.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 08.DA.64580.CF610C46; Tue,
        25 Jul 2023 14:39:56 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX3.ssi.samsung.com (105.128.2.228) with Microsoft SMTP Server
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
Subject: [Qemu PATCH v2 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Thread-Topic: [Qemu PATCH v2 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic
        capacity region representative and mailbox command support
Thread-Index: AQHZvydoz7fRgsZIjkm5D4vXR5iWWg==
Date:   Tue, 25 Jul 2023 18:39:55 +0000
Message-ID: <20230725183939.2741025-3-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrLKsWRmVeSWpSXmKPExsWy7djXc7p/xA6kGEz8ZmbRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8ar1XPYCnYbVSyYtZ+pgXGuWhcjJ4eEgIlE17ONrF2MXBxCAisZJfbdWM4I4bQy
        SZy5tZAJpmrC+RksEIm1jBJ/H/5ngnA+MUrM+7cTylnGKNHaepoVpIVNQFFiX9d2NhBbRMBY
        4tjhJcwgRcwCb1kkPq55wwKSEBaol2h89hWsW0SghVGi4/0fRogOPYmV8/eDFbEIqEp0rNwB
        dgivgKXE1I7LYDWcAlYSz77MBtvGKCAm8f3UGrAaZgFxiVtP5kMdLiixaPYeZghbTOLfrods
        ELa8xOQfM6BsRYn731+yQ/TqSdyYOoUNwtaWWLbwNTPEXkGJkzOfsEDUS0ocXHEDHBgSAtM5
        Jaas2cwIkXCR+N7dBLVYWmL6mstARRxAdrLEqo9cEOEciflLtkDNsZZY+Gc90wRGlVlIzp6F
        5IxZSM6YheSMBYwsqxjFS4uLc9NTi43zUsv1ihNzi0vz0vWS83M3MQJT3Ol/hwt2MN669VHv
        ECMTB+MhRgkOZiURXsOYfSlCvCmJlVWpRfnxRaU5qcWHGKU5WJTEeQ1tTyYLCaQnlqRmp6YW
        pBbBZJk4OKUamEx+nDv1gnvBR+W/PQK1zwzLbFnmplmGKH3o/ad/Vueu2KPYfX9XaywXL9yk
        EfP8xQIGhqAqRYGmgiyvnZO81gtsiwo558i8gK9Co3ez9sk3vFVKRzz6tt5LLfsdzHTpQPIU
        hWeVm2dYKOxXO6Fpz9N+VXlB+Hqv+M0Tn1nWrNpkkvHMOOjkkmzrb5r2k1++/H+Gc26NKO/v
        38bi//s14o5/4KqfuOx85C/+9QxvFshM3JFnsez1xXOCcxp+FGptN635LWl19tPfpS7iGWb3
        Q3Ii85PuSHRN0awTeigd4+spEJa4/cD0LfpWO5+uP7xr9US3DxqC/NYvPWe1frwz2Tj497PL
        V5i0v5w5u9Pl+jElluKMREMt5qLiRABR4GZy4AMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0SfeP2IEUg+a98hbd5zcwWkyfeoHR
        YvXNNYwWDU2PWCxadr9nstj/9DmLxaqF19gszs86xWLxfOJzJoulSx4xWxzv3cHiwO1xYfIE
        Vo/FDa4eO2fdZfdoOfIWyNvzkslj48f/7B5Prm1m8tj8+gWzx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZbxaPYetYLdRxYJZ+5kaGOeqdTFyckgImEhMOD+DpYuRi0NIYDWjROOmS0wQzidG
        iUv9DYwQzjJGicWHF7CDtLAJKErs69rOBmKLCBhLHDu8hBnEZhZ4zSLx7SI3iC0sUC/R+Owr
        2CQRgRZGiVfHJzBCNOhJrJy/nwXEZhFQlehYuYMJxOYVsJSY2nEZqIYDaJulxNaJcSBhTgEr
        iWdfZrOC2IwCYhLfT61hgtglLnHryXwmiBcEJJbsOc8MYYtKvHz8jxXClpeY/GMGG4StKHH/
        +0t2iF49iRtTp7BB2NoSyxa+ZoY4QVDi5MwnLBD1khIHV9xgmcAoMQvJullI2mchaZ+FpH0B
        I8sqRvHS4uLc9Ipi47zUcr3ixNzi0rx0veT83E2MwNRw+t/hmB2M92591DvEyMTBeIhRgoNZ
        SYTXMGZfihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFej9iJ8UIC6YklqdmpqQWpRTBZJg5OqQam
        CbcK4i8f8I/23rvTbZHKVg25yWziuX3aVevOf+6U5l4SOPGQpsHir5qnErJChUR8TQzLb8le
        SkpwPaQmNm2/V3KjwfPM2Bihcs2snL9e99otH897e/P05muHkg5Um625eKT0ghCT47R1LLXH
        fn1zeDH/3a7nK3PdzFbr959OC10dfnyP+6sIvaaAxZOVjSw3hj348b2vyDCl8dyfXUV5+oln
        9jbOmpP0MrX2S4xCy43DrSrp/Q/+d3r6Rc3+kS4p8KZeXvCgnKdKpqjpNaeKoxtSXXbY32w5
        ki11d+WHM5+eHmR6dmUnkyXHy8bg+F8uLxKCtijJOVmYfxcu5rRqFeouM/72fte1o4dfS55R
        YinOSDTUYi4qTgQAuFnZTHwDAAA=
X-CMS-MailID: 20230725183956uscas1p296403063c710f4b546d4fec7650915c4
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183956uscas1p296403063c710f4b546d4fec7650915c4
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183956uscas1p296403063c710f4b546d4fec7650915c4@uscas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Per cxl spec 3.0, add dynamic capacity region representative based on
Table 8-126 and extend the cxl type3 device definition to include dc region
information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
Configuration' mailbox support.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 72 +++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  6 ++++
 include/hw/cxl/cxl_device.h | 17 +++++++++
 3 files changed, 95 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b013e30314..0fe9f3eb5d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -81,6 +81,8 @@ enum {
         #define GET_POISON_LIST        0x0
         #define INJECT_POISON          0x1
         #define CLEAR_POISON           0x2
+    DCD_CONFIG  =3D 0x48, /*r3.0: 8.2.9.8.9*/
+        #define GET_DC_CONFIG          0x0
     PHYSICAL_SWITCH =3D 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -939,6 +941,71 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cm=
d *cmd,
     return CXL_MBOX_SUCCESS;
 }
=20
+/*
+ * cxl spec 3.0: 8.2.9.8.9.1
+ * Get Dynamic Capacity Configuration
+ **/
+static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
+        CXLDeviceState *cxl_dstate,
+        uint16_t *len)
+{
+    struct get_dyn_cap_config_in_pl {
+        uint8_t region_cnt;
+        uint8_t start_region_id;
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_out_pl {
+        uint8_t num_regions;
+        uint8_t rsvd1[7];
+        struct {
+            uint64_t base;
+            uint64_t decode_len;
+            uint64_t region_len;
+            uint64_t block_size;
+            uint32_t dsmadhandle;
+            uint8_t flags;
+            uint8_t rsvd2[3];
+        } QEMU_PACKED records[];
+    } QEMU_PACKED;
+
+    struct get_dyn_cap_config_in_pl *in =3D (void *)cmd->payload;
+    struct get_dyn_cap_config_out_pl *out =3D (void *)cmd->payload;
+    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    uint16_t record_count =3D 0, i;
+    uint16_t out_pl_len;
+    uint8_t start_region_id =3D in->start_region_id;
+
+    if (start_region_id >=3D ct3d->dc.num_regions) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count =3D MIN(ct3d->dc.num_regions - in->start_region_id,
+            in->region_cnt);
+
+    out_pl_len =3D sizeof(*out) + record_count * sizeof(out->records[0]);
+    assert(out_pl_len <=3D CXL_MAILBOX_MAX_PAYLOAD_SIZE);
+
+    memset(out, 0, out_pl_len);
+    out->num_regions =3D record_count;
+    for (i =3D 0; i < record_count; i++) {
+        stq_le_p(&out->records[i].base,
+                ct3d->dc.regions[start_region_id + i].base);
+        stq_le_p(&out->records[i].decode_len,
+                ct3d->dc.regions[start_region_id + i].decode_len);
+        stq_le_p(&out->records[i].region_len,
+                ct3d->dc.regions[start_region_id + i].len);
+        stq_le_p(&out->records[i].block_size,
+                ct3d->dc.regions[start_region_id + i].block_size);
+        stl_le_p(&out->records[i].dsmadhandle,
+                ct3d->dc.regions[start_region_id + i].dsmadhandle);
+        out->records[i].flags =3D ct3d->dc.regions[start_region_id + i].fl=
ags;
+    }
+
+    *len =3D out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -977,6 +1044,8 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
         cmd_media_inject_poison, 8, 0 },
     [MEDIA_AND_POISON][CLEAR_POISON] =3D { "MEDIA_AND_POISON_CLEAR_POISON"=
,
         cmd_media_clear_poison, 72, 0 },
+    [DCD_CONFIG][GET_DC_CONFIG] =3D { "DCD_GET_DC_CONFIG",
+        cmd_dcd_get_dyn_cap_config, 2, 0 },
 };
=20
 static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
@@ -1164,6 +1233,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstat=
e, bool switch_cci)
     }
     for (int set =3D 0; set < 256; set++) {
         for (int cmd =3D 0; cmd < 256; cmd++) {
+            if (!cxl_dstate->is_dcd && set =3D=3D DCD_CONFIG) {
+                continue;
+            }
             if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
                 struct cxl_cmd *c =3D &cxl_dstate->cxl_cmd_set[set][cmd];
                 struct cel_log *log =3D
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 862107c5ef..4d68824dfe 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1046,6 +1046,12 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *reg_state =3D ct3d->cxl_cstate.crb.cache_mem_registers;
     uint32_t *write_msk =3D ct3d->cxl_cstate.crb.cache_mem_regs_write_mask=
;
=20
+    if (ct3d->dc.num_regions) {
+        ct3d->cxl_dstate.is_dcd =3D true;
+    } else {
+        ct3d->cxl_dstate.is_dcd =3D false;
+    }
+
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DE=
VICE);
     cxl_device_register_init_common(&ct3d->cxl_dstate);
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cd7f28dba8..dae39da438 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -212,6 +212,7 @@ typedef struct cxl_device_state {
     uint64_t mem_size;
     uint64_t pmem_size;
     uint64_t vmem_size;
+    bool is_dcd;
=20
     struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
@@ -382,6 +383,17 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
=20
+#define DCD_MAX_REGION_NUM 8
+
+typedef struct CXLDCD_Region {
+    uint64_t base;
+    uint64_t decode_len; /* in multiples of 256MB */
+    uint64_t len;
+    uint64_t block_size;
+    uint32_t dsmadhandle;
+    uint8_t flags;
+} CXLDCD_Region;
+
 struct CXLType3Dev {
     /* Private */
     PCIDevice parent_obj;
@@ -413,6 +425,11 @@ struct CXLType3Dev {
     unsigned int poison_list_cnt;
     bool poison_list_overflowed;
     uint64_t poison_list_overflow_ts;
+
+    struct dynamic_capacity {
+        uint8_t num_regions; /* 0-8 regions */
+        struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
+    } dc;
 };
=20
 #define TYPE_CXL_TYPE3 "cxl-type3"
--=20
2.25.1
