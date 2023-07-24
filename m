Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2244DC04FDF
	for <linux-cxl@archiver.kernel.org>; Mon, 24 Jul 2023 16:23:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230162AbjGXQXh (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 24 Jul 2023 12:23:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230080AbjGXQXc (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 24 Jul 2023 12:23:32 -0400
Received: from mailout2.w2.samsung.com (mailout2.w2.samsung.com [211.189.100.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1DC319F
        for <linux-cxl@vger.kernel.org>; Mon, 24 Jul 2023 09:23:30 -0700 (PDT)
Received: from uscas1p1.samsung.com (unknown [182.198.245.206])
        by mailout2.w2.samsung.com (KnoxPortal) with ESMTP id 20230724162325usoutp02fa3a52a5ee42051a707743f9fb0765ed~02lHd4YT81330613306usoutp02x;
        Mon, 24 Jul 2023 16:23:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w2.samsung.com 20230724162325usoutp02fa3a52a5ee42051a707743f9fb0765ed~02lHd4YT81330613306usoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1690215805;
        bh=bLMxAjBAZdbCpVqPKl5Hm275HdjbtWNyWIeKHx1+BWU=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=ZYCU8Vn46ccI68nhfY5EOn5HE2cXG+iiSj6PisDfFWMvIiHGBP1yCqAQUS39D7epV
         EhrcGm66kZ8UiUSLrhmYkeNdLNOTsMVYbVF/OU1iqP8Y0KsoH3BIO5zQ76omBpJV26
         N+VjljFMPlrhzTO2NwK8pjFPP8C5FT/5ZfJ04rtQ=
Received: from ussmges3new.samsung.com (u112.gpu85.samsung.co.kr
        [203.254.195.112]) by uscas1p2.samsung.com (KnoxPortal) with ESMTP id
        20230724162325uscas1p29d37defd143779f4bfeeb2b1583a8b6e~02lHMR9eS0598705987uscas1p2R;
        Mon, 24 Jul 2023 16:23:25 +0000 (GMT)
Received: from uscas1p2.samsung.com ( [182.198.245.207]) by
        ussmges3new.samsung.com (USCPEMTA) with SMTP id 35.A5.62237.C75AEB46; Mon,
        24 Jul 2023 12:23:24 -0400 (EDT)
Received: from ussmgxs3new.samsung.com (u92.gpu85.samsung.co.kr
        [203.254.195.92]) by uscas1p1.samsung.com (KnoxPortal) with ESMTP id
        20230724162324uscas1p13cc0d1ad05aa272df2b118d7a2477d18~02lG6LC1R1471614716uscas1p1C;
        Mon, 24 Jul 2023 16:23:24 +0000 (GMT)
X-AuditID: cbfec370-823ff7000001f31d-36-64bea57c0f0b
Received: from SSI-EX2.ssi.samsung.com ( [105.128.2.145]) by
        ussmgxs3new.samsung.com (USCPEXMTA) with SMTP id 53.D1.64580.C75AEB46; Mon,
        24 Jul 2023 12:23:24 -0400 (EDT)
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
Subject: [Qemu PATCH RESEND 9/9] hw/mem/cxl_type3: Add dpa range validation
 for accesses to dc regions
Thread-Topic: [Qemu PATCH RESEND 9/9] hw/mem/cxl_type3: Add dpa range
        validation for accesses to dc regions
Thread-Index: AQHZvksq06BUate0j0Ohda1LoX59zw==
Date:   Mon, 24 Jul 2023 16:23:23 +0000
Message-ID: <20230724162313.34196-10-fan.ni@samsung.com>
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
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrBKsWRmVeSWpSXmKPExsWy7djX87o1S/elGDyda23RfX4Do8X0qRcY
        LVbfXMNo0dD0iMWiZfd7Jov9T5+zWKxaeI3N4vysUywWzyc+Z7JYuuQRs8Xx3h0sDtweFyZP
        YPVY3ODqsXPWXXaPliNvgbw9L5k8Nn78z+7x5NpmJo/Nr18we0ydXe/xeZNcAFcUl01Kak5m
        WWqRvl0CV8ap/YeZC87bVOzvbmVvYOzU6WLk5JAQMJHYtf8vYxcjF4eQwEpGidNf77JAOK1M
        Em9unWHqYuQAq1r31AQivpZRovvJIVaQbiGBT4wSa+9DNSxjlHiw4zEzSIJNQFFiX9d2NhBb
        RMBY4tjhJcwgRcwCb1kkPq55wwKSEBbIkPjZeJwRoihXYsOkZ1ANehIvb51jB9nMIqAqcXRR
        HEiYV8BCYsrpaWCLOYHsDZdOgNmMAmIS30+tYQKxmQXEJW49mc8E8ZqgxKLZe5ghbDGJf7se
        skHY8hKTf8yAshUl7n9/yQ7RqydxY+oUNghbW2LZwtfMEHsFJU7OfMICUS8pcXDFDbCHJQQm
        c0qsOniKBRJCLhLvVlZB1EhLTF9zGSqcLLHqIxdEOEdi/pItUGOsJRb+Wc80gVFlFpKrZyG5
        YhaSK2YhuWIBI8sqRvHS4uLc9NRi47zUcr3ixNzi0rx0veT83E2MwMR2+t/hgh2Mt2591DvE
        yMTBeIhRgoNZSYTXMGZfihBvSmJlVWpRfnxRaU5q8SFGaQ4WJXFeQ9uTyUIC6YklqdmpqQWp
        RTBZJg5OqQamZdHHnaQz5idsU5p2bUrjhpbQpfIveY8/PNlqsc9poo0Ua93khzNnROi+fX/r
        E8NX/u9mt3fZf+pftSE0/9B0bW7OFSsSd5+aMnOXe0+Ryfv4+2v/RMiv36QZbSm7uovnCu/1
        bvudx4zEdwn1WntlnJXeePXDyR0vs08lfwnvP7Yxwo/73DOPP046n4P9DVMFJ3xWDNnaMlfl
        m8T9zY7B+3MMJ/w5JL3V3LRI+3gNd8Wy5nZj7rMMWZtSJsyz/+e24f+FksVXkrNLc1V/fyqa
        5SE19ZGUe3PPh8dWyWVzQ3OmSy6JWiTFWfs4ov8B7zWewB0NbWZJNsv3dXRKn6t4s+Dj6Znv
        lTzqO76bRc1+p8RSnJFoqMVcVJwIAATEorDbAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrGIsWRmVeSWpSXmKPExsWS2cA0Ubdm6b4Ug6NdKhbd5zcwWkyfeoHR
        YvXNNYwWDU2PWCxadr9nstj/9DmLxaqF19gszs86xWLxfOJzJoulSx4xWxzv3cHiwO1xYfIE
        Vo/FDa4eO2fdZfdoOfIWyNvzkslj48f/7B5Prm1m8tj8+gWzx9TZ9R6fN8kFcEVx2aSk5mSW
        pRbp2yVwZZzaf5i54LxNxf7uVvYGxk6dLkYODgkBE4l1T026GLk4hARWM0rsaP/DBuF8YpSY
        u3gfM4SzjFGi79QW9i5GTg42AUWJfV3b2UBsEQFjiWOHlzCD2MwCr1kkvl3kBrGFBTIkfjYe
        ZwTZICKQKzF1pQ5EuZ7Ey1vn2EHCLAKqEkcXxYGEeQUsJKacnsYKYgsJmEuc2bQfbBMnUHzD
        pRNgcUYBMYnvp9YwQWwSl7j1ZD6YLSEgILFkz3lmCFtU4uXjf6wQtrzE5B8z2CBsRYn731+y
        Q/TqSdyYOoUNwtaWWLbwNTPEDYISJ2c+YYGol5Q4uOIGywRGiVlI1s1C0j4LSfssJO0LGFlW
        MYqXFhfnplcUG+ellusVJ+YWl+al6yXn525iBCaF0/8Ox+xgvHfro94hRiYOxkOMEhzMSiK8
        hjH7UoR4UxIrq1KL8uOLSnNSiw8xSnOwKInzesROjBcSSE8sSc1OTS1ILYLJMnFwSjUwXbRp
        KXNZumcKv0VkYw+bIks9w7w1E/s3dU04+3AXd8brR7NyOmVfSrlff+C54J+q2eeHK7rzXzmV
        n1p6OVgpuTDq8fblWw74pft6nfMJzOspXrxX20TcPMHk84bfVqs5Gxc4Mm2LvvuBTaHnZtGG
        2zul/OfPsZHL6Hrm38v6L6v+XZFkhpi67zO1FH3GlFyu/wvudbDYzHa/VXPA022f6/15aia3
        3HeUdkf3i/9TO3bkpJHTq9x4m9V909bOUt5ewHxnL5vd7Y2ZW3u3rom0LS+6Lrm+Y/LNRY2v
        QiarTFxnsrp82cEVmi89u7Omfom4sP+3qeeE7x8nNX9uXvN7s7t1YPfsJSv3ZP5sXWuVoMRS
        nJFoqMVcVJwIAA2d1E55AwAA
X-CMS-MailID: 20230724162324uscas1p13cc0d1ad05aa272df2b118d7a2477d18
CMS-TYPE: 301P
X-CMS-RootMailID: 20230724162324uscas1p13cc0d1ad05aa272df2b118d7a2477d18
References: <20230724162313.34196-1-fan.ni@samsung.com>
        <CGME20230724162324uscas1p13cc0d1ad05aa272df2b118d7a2477d18@uscas1p1.samsung.com>
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Not all dpa range in the dc regions is valid to access until an extent
covering the range has been added. Add a bitmap for each region to
record whether a dc block in the region has been backed by dc extent.
For the bitmap, a bit in the bitmap represents a dc block. When a dc
extent is added, all the bits of the blocks in the extent will be set,
which will be cleared when the extent is released.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c          | 155 ++++++++++++++++++++++++++++++++++++
 include/hw/cxl/cxl_device.h |   1 +
 2 files changed, 156 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index cb1f9182e6..e673287804 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -787,13 +787,37 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
         /* dsmad_handle is set when creating cdat table entries */
         region->flags =3D 0;
=20
+        region->blk_bitmap =3D bitmap_new(region->len / region->block_size=
);
+        if (!region->blk_bitmap) {
+            break;
+        }
+
         region_base +=3D region->len;
     }
+
+    if (i < ct3d->dc.num_regions) {
+        while (--i >=3D 0) {
+            g_free(ct3d->dc.regions[i].blk_bitmap);
+        }
+        return -1;
+    }
+
     QTAILQ_INIT(&ct3d->dc.extents);
=20
     return 0;
 }
=20
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    struct CXLDCD_Region *region;
+
+    for (i =3D 0; i < ct3d->dc.num_regions; i++) {
+        region =3D &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds =3D DEVICE(ct3d);
@@ -1021,6 +1045,7 @@ err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1043,6 +1068,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
     if (ct3d->dc.host_dc) {
+        cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
     }
     if (ct3d->hostpmem) {
@@ -1053,6 +1079,110 @@ static void ct3_exit(PCIDevice *pci_dev)
     }
 }
=20
+/*
+ * This function will marked the dpa range [dpa, dap + len) to be backed a=
nd
+ * accessible, this happens when a dc extent is added and accepted by the
+ * host.
+ */
+static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
+
+    if (dpa < region->base
+            || dpa >=3D region->base + ct3d->dc.total_capacity)
+        return;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     **/
+    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
+        region =3D &ct3d->dc.regions[i];
+        if (dpa >=3D region->base) {
+            break;
+        }
+    }
+
+    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_si=
ze,
+            len / region->block_size);
+}
+
+/*
+ * This function check whether a dpa range [dpa, dpa + len) has been backe=
d
+ * with dc extents, used when validating read/write to dc regions
+ */
+static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
+    uint64_t nbits;
+    long nr;
+
+    if (dpa < region->base
+            || dpa >=3D region->base + ct3d->dc.total_capacity)
+        return false;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     */
+    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
+        region =3D &ct3d->dc.regions[i];
+        if (dpa >=3D region->base) {
+            break;
+        }
+    }
+
+    nr =3D (dpa - region->base) / region->block_size;
+    nbits =3D len / region->block_size;
+    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >=3D nr + nbi=
ts;
+}
+
+/*
+ * This function will marked the dpa range [dpa, dap + len) to be unbacked=
 and
+ * inaccessible, this happens when a dc extent is added and accepted by th=
e
+ * host.
+ */
+static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region =3D &ct3d->dc.regions[0];
+    uint64_t nbits;
+    long nr;
+
+    if (dpa < region->base
+            || dpa >=3D region->base + ct3d->dc.total_capacity)
+        return;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     */
+    for (i =3D ct3d->dc.num_regions - 1; i >=3D 0; i--) {
+        region =3D &ct3d->dc.regions[i];
+        if (dpa >=3D region->base) {
+            break;
+        }
+    }
+
+    nr =3D (dpa - region->base) / region->block_size;
+    nbits =3D len / region->block_size;
+    bitmap_clear(region->blk_bitmap, nr, nbits);
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *d=
pa)
 {
     uint32_t *cache_mem =3D ct3d->cxl_cstate.crb.cache_mem_registers;
@@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *=
ct3d,
         *as =3D &ct3d->hostpmem_as;
         *dpa_offset -=3D vmr_size;
     } else {
+        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
+            return -ENODEV;
+        }
+
         *as =3D &ct3d->dc.host_dc_as;
         *dpa_offset -=3D (vmr_size + pmr_size);
     }
@@ -1938,6 +2072,27 @@ static void qmp_cxl_process_dynamic_capacity_event(c=
onst char *path,
     }
=20
     g_free(extents);
+
+    /* Another choice is to do the set/clear after getting mailbox respons=
e*/
+    list =3D records;
+    while (list) {
+        dpa =3D list->value->dpa * 1024 * 1024;
+        len =3D list->value->len * 1024 * 1024;
+        rid =3D list->value->region_id;
+
+        switch (type) {
+        case DC_EVENT_ADD_CAPACITY:
+            set_region_block_backed(dcd, dpa, len);
+            break;
+        case DC_EVENT_RELEASE_CAPACITY:
+            clear_region_block_backed(dcd, dpa, len);
+            break;
+        default:
+            error_setg(errp, "DC event type not handled yet");
+            break;
+        }
+        list =3D list->next;
+    }
 }
=20
 void qmp_cxl_add_dynamic_capacity_event(const char *path,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 5bf1dd4024..40ae96d824 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -411,6 +411,7 @@ typedef struct CXLDCD_Region {
     uint64_t block_size;
     uint32_t dsmadhandle;
     uint8_t flags;
+    unsigned long *blk_bitmap;
 } CXLDCD_Region;
=20
 struct CXLType3Dev {
--=20
2.25.1
