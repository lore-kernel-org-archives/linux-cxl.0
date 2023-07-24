Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6604EC41513
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjGXQXc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbjGXQXa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:30 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE56C19F
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162324usoutp01105f234ef75c19e0fa2a2c82576cdfad~02lGm3rk12719927199usoutp01z;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230724162324usoutp01105f234ef75c19e0fa2a2c82576cdfad~02lGm3rk12719927199usoutp01z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215804;
        bh=0lFWcB4DqM5aIudi8cl3SMn2Aw136RMry04GoncNhGc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=WPEo3M4sjD5axqvoj4nIVOHHNb7QOuNwSCaD8glJW+ireE3h3m1HFbm99GnpDBeo2
         xVZwwDjT1k6lGuV+PflHOT8yLtsPwF9xPOZ+22W6PFFQi25G2xoODzYArI3dmbreKv
         LHhNPNbzgoFclNhpDwy0lyQeU3irp6g8BPA9EGiw=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p26b08ff78320f7314afde394bd8adca00~02lGeTFt20598305983uscas1p2c;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 83.A5.62237.C75AEB46; Mon,
        24 Jul 2023 12:23:24 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p2f1a7176a3b646b5c790fb41372244713~02lGKFJGx0636506365uscas1p2D;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-31-64bea57c3962
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 71.D1.64580.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX2.ssi.samsung.com (105.128.2.227) with Microsoft SMTP Server
        (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
        15.1.2375.24; Mon, 24 Jul 2023 09:23:23 -0700
Received: from SSI-EX2.ssi.samsung.com ([105.128.2.227]) by
        SSI-EX2.ssi.samsung.com ([105.128.2.227]) with mapi id 15.01.2375.024; Mon,
        24 Jul 2023 09:23:23 -0700
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
Subject: [Qemu PATCH RESEND 6/9] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Thread-Topic: [Qemu PATCH RESEND 6/9] hw/mem/cxl_type3: Add DC extent list
        representative and get DC extent list mailbox support
Thread-Index: AQHZvksqpRKN14lEYEidzSMbndI4Pg==
Date:   Mon, 24 Jul 2023 16:23:22 +0000
Message-ID: <20230724162313.34196-7-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrFKsWRmVeSWpSXmKPExsWy7djXc7o1S/elGKy9zmnRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8bUKzPZCj5rVVz8f4y9gfGdQhcjJ4eEgInEgTnn2bsYuTiEBFYySuzqe84K4bQy
        SZxe08UKU7V13XeoqrWMEo23TjODJIQEPjFKrL3PApFYxijxYMdjsASbgKLEvq7tbCC2iICx
        xLHDS5hBipgF3rJIfFzzhgUkISxQK3H5QQMrRFETo8S+TZFdjBxAtp7EywlCIGEWAVWJQzv6
        2UFsXgFzib33XoG1cgpYSGy4dAKslVFATOL7qTVMIDazgLjErSfzmSCuFpRYNHsPM4QtJvFv
        10M2CFteYvKPGVC2osT97y/ZIXr1JG5MncIGYWtLLFv4mhlir6DEyZlPWCDqJSUOrrgB9rCE
        wHROiUvdr6BB5CJxd20nI4QtLTF9zWUWkF8kBJIlVn3kggjnSMxfsgVqjrXEwj/rmSYwqsxC
        cvYsJGfMQnLGLCRnLGBkWcUoXlpcnJueWmycl1quV5yYW1yal66XnJ+7iRGY3E7/O1ywg/HW
        rY96hxiZOBgPMUpwMCuJ8BrG7EsR4k1JrKxKLcqPLyrNSS0+xCjNwaIkzmtoezJZSCA9sSQ1
        OzW1ILUIJsvEwSnVwJQgycSaLP7i1K0K9SdBznwF5x+8vpn23W36DpfNrHf3f7hZ+cbZ6ffS
        3p9HDa7vqBXjWXNyWveOnsCyR526v/8cfRueYJdp9iaWV7tIPZf3W42Hmpyw2qv7Kaun75l7
        5MU9scowL4aFG1+zrPJdrH7ITqP1v7Tx/Ltsl018xacEKybLVbCvvffBUyjsw8af375c4Y6N
        yb36eXHytrcyO7/3zE2b5f4wT2BX3xfW05kl/T1TSivnmqkzW83TvBgltkckaWXZ6lT/JJfW
        zaoLpm+Ttk26HPbFpEZkk6vyqUvZ1qKJlVOr1mzxfdHE1cVZ3iN4TtThxSWeD4+dTqpHTr7f
        7hIuYsEg8q/urBZLthJLcUaioRZzUXEiAMHTdkzdAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0Ubd66b4Ug2lzDCy6z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyph6ZSZbwWetiov/j7E3ML5T6GLk5JAQMJHYuu47excjF4eQwGpGiZNbH7NAOJ8Y
        JeYu3scM4SxjlOg7tYUdpIVNQFFiX9d2NhBbRMBY4tjhJcwgNrPAaxaJbxe5QWxhgVqJyw8a
        WEGaRQSaGCUmX/8NNJYDyNGTeDlBCKSGRUBV4tCOfrCZvALmEnvvvWIBsYWA7DOb9oPFOQUs
        JDZcOsEKYjMKiEl8P7WGCWKXuMStJ/OZIF4QkFiy5zwzhC0q8fLxP1YIW15i8o8ZbBC2osT9
        7y/ZIXr1JG5MncIGYWtLLFv4mhniBkGJkzOfsEDUS0ocXHGDZQKjxCwk62YhaZ+FpH0WkvYF
        jCyrGMVLi4tz0yuKjfNSy/WKE3OLS/PS9ZLzczcxAlPD6X+HY3Yw3rv1Ue8QIxMH4yFGCQ5m
        JRFew5h9KUK8KYmVValF+fFFpTmpxYcYpTlYlMR5PWInxgsJpCeWpGanphakFsFkmTg4pRqY
        erdsFdNSCfd+d9U34Kjs6UmuvGu50s/ylTAtfeCqfCniwuntV4L0E9o+Bnnlb3T+Ili8KiL4
        EcM3mbkJWVZOMW1StyoneXVtd7q/OuaCuqq/xhZL2R/q/0LKC68sqnWe0d6d61V9SP0TxyFu
        tjk3mpn+pG7xZnriXmfptnHLJ7/kmL1J6XN+Xrr57GTDhZvzEs/z2v9sjevUc46w/ON0ez3j
        /GK9Xwd47i16PmFdo/HXIolnZ18xtr6YYX1b0eNvyKxT9xQi9JjkrGSy6x45iX54p136Vkt3
        rqvSuvXre2X9WZdze9046bCqU1knqvVP9AOLv5Ya6u5vcxIE7JQ3/p5+RTz5acFqt+bPJaZK
        LMUZiYZazEXFiQDE/dgefAMAAA==
X-CMS-MailID: 20230724162323uscas1p2f1a7176a3b646b5c790fb41372244713
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162323uscas1p2f1a7176a3b646b5c790fb41372244713
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162323uscas1p2f1a7176a3b646b5c790fb41372244713@uscas1p2.samsung.com>
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
index c497298a1d..754ab68b78 100644
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
index af1d919be3..608063ac52 100644
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
index ddb24271a8..a9cfe4e904 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -384,6 +384,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
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
@@ -432,6 +451,10 @@ struct CXLType3Dev {
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
