Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1025C001DF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230191AbjGXQXf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231204AbjGXQXb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:31 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0CD3E4E
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:25 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162324usoutp02c18e7d70d551f78314c0c8358f5baf24~02lGVgsPf1330813308usoutp02i;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230724162324usoutp02c18e7d70d551f78314c0c8358f5baf24~02lGVgsPf1330813308usoutp02i
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215804;
        bh=QdhsTlPOjfPS50+L27TzshjXC2bd/OfwpwsRqKlBcb8=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=jhAK6eXmZIJ+IYJyj+Ud2zcNwH79On7+hvPqxUklQyVGRTnFqA18n/H3hc8RyMUJE
         b8F1rKDuAgF5GIX7/fGN2jJHYbmfGrezcgDycyIpQITuNguFddJ0mI8EIkJcM8BZrQ
         PvZ4lI4w4wjGUTnfgjJ2p7b+Rw7Xm9/lGmKQDojo=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p2f437b5dd7cf792fe20ac40d7da1a080a~02lGMSE6d0402104021uscas1p2c;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 02.A5.62237.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724162323uscas1p1c9f1ab1af688efbfc50d3246da5d0f7c~02lF0mHVm1474714747uscas1p1s;
        Mon, 24 Jul 2023 16:23:23 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-2f-64bea57b4280
Received: from SSI-EX1.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id DB.8B.38326.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX1.ssi.samsung.com (105.128.2.226) with Microsoft SMTP Server
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
Subject: [Qemu PATCH RESEND 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic
 capacity region representative and mailbox command support
Thread-Topic: [Qemu PATCH RESEND 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic
        capacity region representative and mailbox command support
Thread-Index: AQHZvksqExHVXG8u5USYZ0Vv6oRqLA==
Date:   Mon, 24 Jul 2023 16:23:22 +0000
Message-ID: <20230724162313.34196-3-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrDKsWRmVeSWpSXmKPExsWy7djX87rVS/elGBzpM7ToPr+B0WL61AuM
        FqtvrmG0aGh6xGLRsvs9k8X+p89ZLFYtvMZmcX7WKRaL5xOfM1ksXfKI2eJ47w4WB26PC5Mn
        sHosbnD12DnrLrtHy5G3QN6el0weGz/+Z/d4cm0zk8fm1y+YPabOrvf4vEkugCuKyyYlNSez
        LLVI3y6BK+Pgr1vsBbPUK5ru5DYwPpXtYuTgkBAwkXi6XaqLkYtDSGAlo8Tss82sEE4rk8TM
        N/eZuxg5wYqeNJ+DSqxllPh99CyU84lR4llbHxuEs4xR4vqCHnaQFjYBRYl9XdvZQGwRAWOJ
        Y4eXMIMUMQu8ZZH4uOYNC4gjLNDMKLFoVT9YRkSgg1Hi0J//zBAtehKNX9cwgtgsAqoSh3b0
        g43lFTCXePlxGlicU8BCYsOlE6wgNqOAmMT3U2uYQGxmAXGJW0/mM0FcLiixaPYeqC/EJP7t
        esgGYctLTP4xA8pWlLj//SU7RK+exI2pU9ggbG2JZQtfM0PsFZQ4OfMJC0S9pMTBFTfAPpAQ
        mMwpceREJytEwkVi3p+3UEXSElevT2WGhHGyxKqPXBDhHIn5S7ZAlVhLLPyznmkCo8osJGfP
        QnLGLCRnzEJyxgJGllWM4qXFxbnpqcXGeanlesWJucWleel6yfm5mxiBCe70v8MFOxhv3fqo
        d4iRiYPxEKMEB7OSCK9hzL4UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4ryGtieThQTSE0tSs1NT
        C1KLYLJMHJxSDUzCiYIzfT8rH759WOWVGbu22s5z2kKL9meUFF7zufre7+lr4ZfPpQ66KtZW
        5PNYX/0jvlArmMVTfLFS2AKLy58absxadNPEOb0pr6jv4CyjQMUzHnx7Fjn1t+9Sbth9ljPj
        m+PZjRK1P6Z9U1S7mxO50i42n9Gm8/vd+qUsqecyzY3r68tNTLMq7u3aVNz3u+j3Gm0drkPs
        6Y8F97x+te6Njk/v6nfvXqv2ZLS772tcFbCNOeBgY0CPlcmyaTba5SdOdG/92VSid/zCqg8z
        21fwKqxVe3LP7/XGs+tX/vt9WDPuWdtZW6E9zW1s64JPzzix3riFeeGThLueTTebzpUV+519
        ytv65O3lIPGX3RZKLMUZiYZazEXFiQC92B0F3wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJIsWRmVeSWpSXmKPExsWS2cA0Sbd66b4Ug6e7JS26z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyjj46xZ7wSz1iqY7uQ2MT2W7GDk5JARMJJ40n2MFsYUEVjNK/Hjo3MXIBWR/YpRY
        872TDcJZxijRPmMyG0gVm4CixL6u7WC2iICxxLHDS5hBbGaB1ywS3y5ygzQICzQzSixa1c8M
        4ogIdDBKnH9ykhGiQ0+i8esaMJtFQFXi0I5+dhCbV8Bc4uXHaYwQd5hLnNm0HyzOKWAhseHS
        CbD7GAXEJL6fWsMEsU1c4taT+UwQPwhILNlznhnCFpV4+fgfK4QtLzH5xww2CFtR4v73l+wQ
        vXoSN6ZOYYOwtSWWLXzNDHGDoMTJmU9YIOolJQ6uuMEygVFiFpJ1s5C0z0LSPgtJ+wJGllWM
        4qXFxbnpFcWGeanlesWJucWleel6yfm5mxiBqeH0v8OROxiP3vqod4iRiYPxEKMEB7OSCK9h
        zL4UId6UxMqq1KL8+KLSnNTiQ4zSHCxK4rxCrhPjhQTSE0tSs1NTC1KLYLJMHJxSDUw+V5KF
        yp9PnPjswbvSlUcXzG3NFD1XujfyofP2NX+MprGwee03KlsncyB+w/ykAmbxpxo8E7gtpR7/
        UDwTwpzF8PtJ532PZ/PyI35rH3kTHHEu4qAv09JHFqtm3m8yEXDfVTD/Qp9ne9im747K595K
        3QkWkXr5Wv7mqe37Xz3PcT91OH3XvDVeqveDI4tzs//oxXYdY7aNebI2Mu7l5R9dhh9bbk6O
        L70oa+xu1bNiY05aoP8U9qTVGbOfzgr1vD9hiePLXWcO/hd47TFB21zLKqj2uEpU357O2Isz
        N79J3GxeWvNB8ttai93Pxau73h36ydgfaJy2VtVn9dUWhUbFhRlfnp1Tyuqb2ccfJPRRiaU4
        I9FQi7moOBEAYM2eSnwDAAA=
X-CMS-MailID: 20230724162323uscas1p1c9f1ab1af688efbfc50d3246da5d0f7c
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162323uscas1p1c9f1ab1af688efbfc50d3246da5d0f7c
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162323uscas1p1c9f1ab1af688efbfc50d3246da5d0f7c@uscas1p1.samsung.com>
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
 hw/cxl/cxl-mailbox-utils.c  | 69 +++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h | 16 +++++++++
 2 files changed, 85 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b013e30314..41e43ec231 100644
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
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cd7f28dba8..bf564f4a0b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -382,6 +382,17 @@ typedef struct CXLPoison {
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
@@ -413,6 +424,11 @@ struct CXLType3Dev {
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
