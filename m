Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8339C001B0
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGXQXf (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231303AbjGXQXb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:31 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B038E4F
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:26 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162324usoutp02f7f58cedbc725731c692aff9ff1199d1~02lG0pWe51330013300usoutp022;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230724162324usoutp02f7f58cedbc725731c692aff9ff1199d1~02lG0pWe51330013300usoutp022
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215804;
        bh=19jO8AQKlPnjvTG/qAmQR958D7VywZQOcO0U0leP8tM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=t9RBhoO37r/+1eBQHzaXsnvTdhtQyzTVEUEei9CibaF2NlyoO/guDczlkYWVpLP9L
         CzULxtGWzm+qY5uzL24HCEvokL8zukfxS2FUXbu0Fq/HfiUZJJ4JeIMw1uX6+XAPQT
         8FzdFsZydBrExSY0byW2Gl3MjCZuNcqbKG/UD9Pw=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p2a98acca4ed1916794fe694fb091a570a~02lGqaXvv0628606286uscas1p2K;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 44.A5.62237.C75AEB46; Mon,
        24 Jul 2023 12:23:24 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p1004474b4ac5267f90a97a6eeabe68db8~02lGRrH4t2262822628uscas1p1P;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-32-64bea57c8842
Received: from SSI-EX4.ssi.samsung.com ( [105.128.2.146]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 81.D1.64580.B75AEB46; Mon,
        24 Jul 2023 12:23:23 -0400 (EDT)
Received: from SSI-EX2.ssi.samsung.com (105.128.2.227) by
        SSI-EX4.ssi.samsung.com (105.128.2.229) with Microsoft SMTP Server
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
Subject: [Qemu PATCH RESEND 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox
 commands to support add/release dynamic capacity response
Thread-Topic: [Qemu PATCH RESEND 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox
        commands to support add/release dynamic capacity response
Thread-Index: AQHZvksql9OmCbCKwEW6gosXJjHlUw==
Date:   Mon, 24 Jul 2023 16:23:23 +0000
Message-ID: <20230724162313.34196-8-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djXc7o1S/elGDScF7ToPr+B0WL61AuM
        FqtvrmG0aGh6xGLRsvs9k8X+p89ZLFYtvMZmcX7WKRaL5xOfM1ksXfKI2eJ47w4WB26PC5Mn
        sHosbnD12DnrLrtHy5G3QN6el0weGz/+Z/d4cm0zk8fm1y+YPabOrvf4vEkugCuKyyYlNSez
        LLVI3y6BK+P20V6WggWBFQ8v+jQwbrXsYuTkkBAwkbjZsp8NxBYSWMkoceUikM0FZLcySTw7
        v5oZpujFl35miMRaRokl3SuZIJxPjBKTn+5ih3CWMUo82PEYrIVNQFFiX9d2sLkiAsYSxw4v
        AWtnFnjLIvFxzRsWEEdYoIlR4uK8B6wQVe2MEtuWanUxcgDZehJ7+qpATBYBVYmji+JAKngF
        zCUmTrnGDmJzClhIbLh0AqyTUUBM4vupNUwgNrOAuMStJ/OZIM4WlFg0ew/UC2IS/3Y9ZIOw
        5SUm/5gBZStK3P/+kh2iV0/ixtQpbBC2tsSyha+ZIfYKSpyc+YQFol5S4uCKG2DnSwhM5pQ4
        cPAwC8idEgIuEnduyELUSEtMX3MZKpwsseojF0Q4R2L+ki1QY6wlFv5ZzzSBUWUWkqtnIbli
        FpIrZiG5YgEjyypG8dLi4tz01GLjvNRyveLE3OLSvHS95PzcTYzAxHb63+GCHYy3bn3UO8TI
        xMF4iFGCg1lJhNcwZl+KEG9KYmVValF+fFFpTmrxIUZpDhYlcV5D25PJQgLpiSWp2ampBalF
        MFkmDk6pBqbEJwvZjfL4k07dU8hMWuvOfn/K8gk9DDZPZlenfvWdPjVf6UL4UqMT2zeu4eg+
        nfjq/qcNP+7u2F1YOGnZS869vyY2BLBaT4lm4j3zS1b7jk1TVTyv+T/fIzUHvM8/MU48zb1D
        kWn1HD3Li0/s3dKVrkls4XG7oR+2v8c4fn7PbJHFzMzh7WKrzJ6fD/YJDeK5NKniUtLs/U3P
        T/RLBjQ3BVn+/c9gPlc3evaKjW6ZB6P9M2Y9aH6Zu+PHuYiSuTpbedMXZ7ux3tzpk8lh+Emy
        Nf/rS4Uwxgcz15etK9MumhnIZHBmC4s73z4lPaUnZ878s3yiZp4YnpSp+Um9M/eF9YRgns99
        Gza8rFzaqKDEUpyRaKjFXFScCABoyHS/2wMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrBIsWRmVeSWpSXmKPExsWS2cA0Sbd66b4Ug5mPzC26z29gtJg+9QKj
        xeqbaxgtGpoesVi07H7PZLH/6XMWi1ULr7FZnJ91isXi+cTnTBZLlzxitjjeu4PFgdvjwuQJ
        rB6LG1w9ds66y+7RcuQtkLfnJZPHxo//2T2eXNvM5LH59Qtmj6mz6z0+b5IL4IrisklJzcks
        Sy3St0vgyrh9tJelYEFgxcOLPg2MWy27GDk5JARMJF586WfuYuTiEBJYzSjR0HURyvnEKPH8
        +2E2CGcZo0TfqS3sIC1sAooS+7q2s4HYIgLGEscOL2EGsZkFXrNIfLvIDdIgLNDEKHFx3gNW
        EEdEoJ1R4v739UxdjBxAjp7Enr4qEJNFQFXi6KI4kF5eAXOJiVOugc0XArLPbNoPZnMKWEhs
        uHSCFcRmFBCT+H5qDRPELnGJW0/mM0G8ICCxZM95ZghbVOLl43+sELa8xOQfM9ggbEWgC16y
        Q/TqSdyYOoUNwtaWWLbwNTPEDYISJ2c+YYGol5Q4uOIGywRGiVlI1s1C0j4LSfssJO0LGFlW
        MYqXFhfnplcUG+ellusVJ+YWl+al6yXn525iBCaG0/8Ox+xgvHfro94hRiYOxkOMEhzMSiK8
        hjH7UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzesROjBcSSE8sSc1OTS1ILYLJMnFwSjUwHWKX
        FpNO+W16vPPxs1l250+LLuZkX6jxYPWi7ab3ThpmTHGsUPV3l/Oq6F0f9cFmaZK4PP/Z1d88
        8+7vndbVvXa1qNfriBebV0ceSjy2v2Wqhnua66r9lzvVt0+8zit/t+npurZVHh9jQoWqK4/m
        Kk361dBi/ve8INvkAwyb92TPCTZ2WlHi7eL8YtPc2Tez5ugenHEmUU37T0LI3tzde9ItbqvJ
        TtqwozRnI/uKKezsR63EEuU/vLbOc3HjaLl3WkSx02rvjWWCH3sTfpdNXWpzZMoGJl9DK85N
        n7fqrHdNmrSxPY7xZPb0RZx7lE7oiJe7fLZUzXupID7507S7Pf0tChm9qnEb3ZPW/Fb5rsRS
        nJFoqMVcVJwIAMihyZp7AwAA
X-CMS-MailID: 20230724162324uscas1p1004474b4ac5267f90a97a6eeabe68db8
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162324uscas1p1004474b4ac5267f90a97a6eeabe68db8
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162324uscas1p1004474b4ac5267f90a97a6eeabe68db8@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Per CXL spec 3.0, two mailbox commands are implemented:
Add Dynamic Capacity Response (Opcode 4802h) 8.2.9.8.9.3, and
Release Dynamic Capacity (Opcode 4803h) 8.2.9.8.9.4.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 253 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   3 +-
 2 files changed, 255 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 754ab68b78..d547385ba7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -84,6 +84,8 @@ enum {
     DCD_CONFIG  =3D 0x48, /*r3.0: 8.2.9.8.9*/
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
     PHYSICAL_SWITCH =3D 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -1086,6 +1088,251 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(stru=
ct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
=20
+/*
+ * Check whether the bits at addr between [nr, nr+size) are all set,
+ * return 1 if all 1s, else return 0
+ */
+static inline int test_bits(const unsigned long *addr, int nr, int size)
+{
+    unsigned long res =3D find_next_zero_bit(addr, size + nr, nr);
+
+    return (res >=3D nr + size) ? 1 : 0;
+}
+
+/*
+ * Find dynamic capacity region id based on dpa range [dpa, dpa+len)
+ */
+static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa,
+        uint64_t len)
+{
+    int8_t i =3D dev->dc.num_regions - 1;
+
+    while (i > 0 && dpa < dev->dc.regions[i].base) {
+        i--;
+    }
+
+    if (dpa < dev->dc.regions[i].base
+            || dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].le=
n) {
+        return dev->dc.num_regions;
+    }
+
+    return i;
+}
+
+static void insert_extent_to_extent_list(CXLDCDExtentList *list, uint64_t =
dpa,
+        uint64_t len, uint8_t *tag, uint16_t shared_seq)
+{
+    CXLDCD_Extent *extent;
+    extent =3D g_new0(CXLDCD_Extent, 1);
+    extent->start_dpa =3D dpa;
+    extent->len =3D len;
+    if (tag) {
+        memcpy(extent->tag, tag, 0x10);
+    } else {
+        memset(extent->tag, 0, 0x10);
+    }
+    extent->shared_seq =3D shared_seq;
+
+    QTAILQ_INSERT_TAIL(list, extent, node);
+}
+
+typedef struct updated_dc_extent_list_in_pl {
+    uint32_t num_entries_updated;
+    uint8_t rsvd[4];
+    struct { /* r3.0: Table 8-130 */
+        uint64_t start_dpa;
+        uint64_t len;
+        uint8_t rsvd[8];
+    } QEMU_PACKED updated_entries[];
+} QEMU_PACKED updated_dc_extent_list_in_pl;
+
+/*
+ * The function only check the input extent list against itself.
+ */
+static CXLRetCode detect_malformed_extent_list(CXLType3Dev *dev,
+        const updated_dc_extent_list_in_pl *in)
+{
+    unsigned long *blk_bitmap;
+    uint64_t min_block_size =3D dev->dc.regions[0].block_size;
+    struct CXLDCD_Region *region =3D &dev->dc.regions[0];
+    uint32_t i;
+    uint64_t dpa, len;
+    uint8_t rid;
+    CXLRetCode ret;
+
+    for (i =3D 1; i < dev->dc.num_regions; i++) {
+        region =3D &dev->dc.regions[i];
+        if (min_block_size > region->block_size) {
+            min_block_size =3D region->block_size;
+        }
+    }
+
+    blk_bitmap =3D bitmap_new((region->len + region->base
+                - dev->dc.regions[0].base) / min_block_size);
+
+    for (i =3D 0; i < in->num_entries_updated; i++) {
+        dpa =3D in->updated_entries[i].start_dpa;
+        len =3D in->updated_entries[i].len;
+
+        rid =3D find_region_id(dev, dpa, len);
+        if (rid =3D=3D dev->dc.num_regions) {
+            ret =3D CXL_MBOX_INVALID_PA;
+            goto out;
+        }
+
+        region =3D &dev->dc.regions[rid];
+        if (dpa % region->block_size || len % region->block_size) {
+            ret =3D CXL_MBOX_INVALID_EXTENT_LIST;
+            goto out;
+        }
+        /* the dpa range already covered by some other extents in the list=
 */
+        if (test_bits(blk_bitmap, dpa / min_block_size, len / min_block_si=
ze)) {
+            ret =3D CXL_MBOX_INVALID_EXTENT_LIST;
+            goto out;
+        }
+        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size)=
;
+   }
+
+    ret =3D CXL_MBOX_SUCCESS;
+
+out:
+    g_free(blk_bitmap);
+    return ret;
+}
+
+/*
+ * cxl spec 3.0: 8.2.9.8.9.3
+ * Add Dynamic Capacity Response (opcode 4802h)
+ * Assume an extent is added only after the response is processed successf=
ully
+ * TODO: for better extent list validation, a better solution would be
+ * maintaining a pending extent list and use it to verify the extent list =
in
+ * the response.
+ */
+static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
+        CXLDeviceState *cxl_dstate, uint16_t *len_unused)
+{
+    updated_dc_extent_list_in_pl *in =3D (void *)cmd->payload;
+    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
+    CXLDCD_Extent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+=20
+    if (in->num_entries_updated =3D=3D 0) {
+        ret =3D CXL_MBOX_SUCCESS;
+        goto out;
+    }
+
+    ret =3D detect_malformed_extent_list(ct3d, in);
+    if (ret !=3D CXL_MBOX_SUCCESS) {
+        goto out;
+    }
+
+    for (i =3D 0; i < in->num_entries_updated; i++) {
+        dpa =3D in->updated_entries[i].start_dpa;
+        len =3D in->updated_entries[i].len;
+
+        /*
+         * Check if the DPA range of the to-be-added extent overlaps with
+         * existing extent list maintained by the device.
+         */
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len) {
+                ret =3D CXL_MBOX_INVALID_PA;
+                goto out;
+            } else if (ent->start_dpa <=3D dpa
+                    && dpa + len <=3D ent->start_dpa + ent->len) {
+                ret =3D CXL_MBOX_INVALID_PA;
+                goto out;
+            } else if ((dpa < ent->start_dpa + ent->len
+                        && dpa + len > ent->start_dpa + ent->len)
+                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa=
)) {
+                ret =3D CXL_MBOX_INVALID_PA;
+                goto out;
+            }
+        }
+
+        /*
+         * TODO: add a pending extent list based on event log record and v=
erify
+         * the input response
+         */
+
+        insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
+    }
+    ret =3D CXL_MBOX_SUCCESS;
+
+out:
+    return ret;
+}
+
+/*
+ * Spec 3.0: 8.2.9.8.9.4
+ * Release Dynamic Capacity (opcode 4803h)
+ **/
+static CXLRetCode cmd_dcd_release_dyn_cap(struct cxl_cmd *cmd,
+        CXLDeviceState *cxl_dstate,
+        uint16_t *len_unused)
+{
+    updated_dc_extent_list_in_pl *in =3D (void *)cmd->payload;
+    struct CXLType3Dev *ct3d =3D container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    CXLDCDExtentList *extent_list =3D &ct3d->dc.extents;
+    CXLDCD_Extent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+
+    if (in->num_entries_updated =3D=3D 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    ret =3D detect_malformed_extent_list(ct3d, in);
+    if (ret !=3D CXL_MBOX_SUCCESS) {
+        return ret;
+    }
+
+    for (i =3D 0; i < in->num_entries_updated; i++) {
+        dpa =3D in->updated_entries[i].start_dpa;
+        len =3D in->updated_entries[i].len;
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa =3D=3D dpa && ent->len =3D=3D len) {
+                break;
+            } else if (ent->start_dpa < dpa
+                    && dpa + len <=3D ent->start_dpa + ent->len) {
+                /* remove partial extent */
+                uint64_t len1 =3D dpa - ent->start_dpa;
+                uint64_t len2 =3D ent->start_dpa + ent->len - dpa - len;
+
+                if (len1) {
+                    insert_extent_to_extent_list(extent_list, ent->start_d=
pa,
+                            len1, NULL, 0);
+                }
+                if (len2) {
+                    insert_extent_to_extent_list(extent_list, dpa + len, l=
en2,
+                            NULL, 0);
+                }
+                break;
+            } else if ((dpa < ent->start_dpa + ent->len
+                        && dpa + len > ent->start_dpa + ent->len)
+                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa=
))
+                return CXL_MBOX_INVALID_EXTENT_LIST;
+        }
+
+        if (ent) {
+            QTAILQ_REMOVE(extent_list, ent, node);
+            g_free(ent);
+        } else {
+            /* Try to remove a non-existing extent */
+            return CXL_MBOX_INVALID_PA;
+        }
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+=20
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1129,6 +1376,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] =3D {
     [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] =3D {
         "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_li=
st,
         8, 0 },
+    [DCD_CONFIG][ADD_DYN_CAP_RSP] =3D {
+        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
+        ~0, IMMEDIATE_DATA_CHANGE },
+    [DCD_CONFIG][RELEASE_DYN_CAP] =3D {
+        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
+        ~0, IMMEDIATE_DATA_CHANGE },
 };
=20
 static struct cxl_cmd cxl_cmd_set_sw[256][256] =3D {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a9cfe4e904..5bf1dd4024 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -130,7 +130,8 @@ typedef enum {
     CXL_MBOX_INCORRECT_PASSPHRASE =3D 0x14,
     CXL_MBOX_UNSUPPORTED_MAILBOX =3D 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH =3D 0x16,
-    CXL_MBOX_MAX =3D 0x17
+    CXL_MBOX_INVALID_EXTENT_LIST =3D 0x1E, /* cxl r3.0: Table 8-34*/
+    CXL_MBOX_MAX =3D 0x1F
 } CXLRetCode;
=20
 struct cxl_cmd;
--=20
2.25.1
