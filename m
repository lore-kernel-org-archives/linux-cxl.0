Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2A99EB64DD
	for <linux-cxl@archiver.kernel.org>; Tue, 25 Jul 2023 18:40:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbjGYSkN (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 25 Jul 2023 14:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbjGYSkH (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 25 Jul 2023 14:40:07 -0400
Received: from mailout1.w2.samsung.com (mailout1.w2.samsung.com [211.189.100.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 012102135
        for <linux-cxl@vger.kernel.org>; Tue, 25 Jul 2023 11:39:59 -0700 (PDT)
Received: from uscas1p2.samsung.com (unknown [182.198.245.207])
        by mailout1.w2.samsung.com (KnoxPortal) with ESMTP id 20230725183958usoutp010c978e34254344b55caf1b3bb61edc49~1MFn1eQt51059910599usoutp01E;
        Tue, 25 Jul 2023 18:39:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w2.samsung.com 20230725183958usoutp010c978e34254344b55caf1b3bb61edc49~1MFn1eQt51059910599usoutp01E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690310398;
        bh=CIC36SxZn+TjeOeeE9nzntOUDOaaeK63Kru21bJOxSI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=bKmNuMJAjrTSVZVtUoyuapUjDFvMQIXjJbZje6OyXNXiWQJAT+MqhQaP+DJLhsy5s
         V+cyPsMgnpqlIdQLnaYH7TMZuJYbfnckMXXCNGDYRriSw0JtwhBPRnBa7z+hifDh7q
         a+aOuOGr3ULgknB5VhzDfkvjIJxkdQzvbIAh4PBQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p2392a7252cb4b8139ef782dc4e3fd0365~1MFnqGJYV1580715807uscas1p2R;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
Received: from uscas1p1.samsung.com ( [182.198.245.206]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 7A.4E.62237.DF610C46; Tue,
        25 Jul 2023 14:39:57 -0400 (EDT)
Received: from ussmgxs1new.samsung.com (u89.gpu85.samsung.co.kr
        [203.254.195.89]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7~1MFnT2UFB1972119721uscas1p2u;
        Tue, 25 Jul 2023 18:39:57 +0000 (GMT)
X-AuditID: cbfec370-b17ff7000001f31d-95-64c016fd5f19
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs1new.samsung.com (USCPEXMTA) with SMTP id 74.54.38326.DF610C46; Tue,
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
Subject: [Qemu PATCH v2 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox commands
 to support add/release dynamic capacity response
Thread-Topic: [Qemu PATCH v2 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox
        commands to support add/release dynamic capacity response
Thread-Index: AQHZvydoEWnb5qMfxEi9SRoRqte0zA==
Date:   Tue, 25 Jul 2023 18:39:56 +0000
Message-ID: <20230725183939.2741025-8-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrNKsWRmVeSWpSXmKPExsWy7djXc7p/xQ6kGEydoWfRfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8behS2MBQsCK27uqG9g3GrZxcjJISFgIjFp2jmWLkYuDiGBlYwSl29OZYVwWpkk
        Hs7oZIOp6plylREisRaoqvE9VNUnRomG1w+YIJxljBJv2n8xg7SwCShK7OvaDtYuImAscezw
        EmaQImaBtywSH9e8YQFJCAvUSfy7+w8sISLQzCgxa+EiVogOPYlrG9+wg9gsAqoSN44cAVrO
        wcErYClxfI8VSJhTwEri2ZfZYOWMAmIS30+tYQKxmQXEJW49mc8EcbegxKLZe5ghbDGJf7se
        Qv0jLzH5xwwoW1Hi/veX7BC9ehI3pk5hg7C1JZYtfA3Wyws05+TMJywQ9ZISB1fcAIeYhMBk
        TontTz+xQiRcJO7e+QlVJC1x9fpUZpCbJQSSJVZ95III50jMX7IFqsRaYuGf9UwTGFVmITl7
        FpIzZiE5YxaSMxYwsqxiFC8tLs5NTy02zkst1ytOzC0uzUvXS87P3cQITG+n/x0u2MF469ZH
        vUOMTByMhxglOJiVRHgNY/alCPGmJFZWpRblxxeV5qQWH2KU5mBREuc1tD2ZLCSQnliSmp2a
        WpBaBJNl4uCUamCSX/3E3iJkyukn/srJGVJc0erm2158mxCxyWJ/64QQr/um0W4tMitClj8R
        r4hS3eN0+MSrgN1H7zDNULPdo1WcO7uZ5d19IdGU20ueTj+i98F9LfuCP7+u6zD+3xYrNaVi
        4V6ztW2JS6/4v9nWlD/v23wvg7XrIx0t+D7fcjtvf8SS9/ty52DPaxWZT79P9V5knnpV54bC
        Nt715nPyao8o/TgmJ2564NnLaSuX2psxpNyR0zi25tTd56L3dnEEftn30fqiXuav/Zkq3KcN
        RFkLX7fMDWGxPJ16vTmn1DHuMsPLxztu6rs8WpxX8rhFPuLdKpcMvvn7j+tcfJ4uv/NHgVE8
        U96bavGETu23E/yPKrEUZyQaajEXFScCABc2v7TeAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrOIsWRmVeSWpSXmKPExsWS2cA0Ufev2IEUg6YzEhbd5zcwWkyfeoHR
        YvXNNYwWDU2PWCxadr9nstj/9DmLxaqF19gszs86xWLxfOJzJoulSx4xWxzv3cHiwO1xYfIE
        Vo/FDa4eO2fdZfdoOfIWyNvzkslj48f/7B5Prm1m8tj8+gWzx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZexd2MJYsCCw4uaO+gbGrZZdjJwcEgImEj1TrjJ2MXJxCAmsZpRoPrydBcL5xCjR
        tug0M4SzjFFi/uLVjCAtbAKKEvu6trOB2CICxhLHDi9hBrGZBV6zSHy7yA1iCwvUSRx+O50N
        pFlEoJlR4vLck0wQDXoS1za+YQexWQRUJW4cOQI0lIODV8BS4vgeKxBTCMjcOjEOpIJTwEri
        2ZfZrCA2o4CYxPdTa5ggVolL3HoynwniAwGJJXvOM0PYohIvH/9jhbDlJSb/mMEGYStK3P/+
        kh2iV0/ixtQpbBC2tsSyha/BenkFBCVOznzCAlEvKXFwxQ2WCYwSs5Csm4WkfRaS9llI2hcw
        sqxiFC8tLs5Nryg2zEst1ytOzC0uzUvXS87P3cQITAun/x2O3MF49NZHvUOMTByMhxglOJiV
        RHgNY/alCPGmJFZWpRblxxeV5qQWH2KU5mBREucVcp0YLySQnliSmp2aWpBaBJNl4uCUamDS
        eLqKuUw053qmxkNhm7R/zVUqXtt2ztxyNZh1h03ehgLLxeFbRc6pVPXOzxLw1LwqdmHi/q+d
        Rlcli5n9r26pfWaUvYDf+FPjqvR/zq//KxlHnPPeZfs4U+rC5ru68gKnZlmsb/0ml/j/ynyf
        mDWzbAtjO468SVpZf3u30i3LdisXNsU4nkVKPXuPFHU9yWCZ8cav1yB5mZWEdq5EieDavvgn
        LVvzHs0OlTtcJCz3Vf7AbsGrLfOlLjAzLQ8r3Fhqbl5g3RhjW3Np7WQ1kwzPoNinZouFHA84
        WNX98W82qz3VuszRuFW6cu3F+7xHIqpjAxMn/FtZVpH9zvCgtfOqrTpzzKuv9gj+Y4ubrMRS
        nJFoqMVcVJwIAA+iSr96AwAA
X-CMS-MailID: 20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7
CMS-TYPE: 301P
X-CMS-RootMailID: 20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7
References: <20230725183939.2741025-1-fan.ni@samsung.com>
        <CGME20230725183957uscas1p2a076b6f7b694d2e632a0b8025ec331d7@uscas1p2.samsung.com>
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
index 3d25a9697e..1e4944da95 100644
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
index 3a338b3b37..01a5eaca48 100644
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
