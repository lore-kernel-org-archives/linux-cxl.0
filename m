Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BE5C00528
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjGTUip (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjGTUio (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:44 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91DC12F
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0MLuahxJW1EJkL392rbUBMPRPXHQlddHiaBrwfdcdWOxQrE/ucjorGrDpzaa2+0is38De5KI6Adb3mRFO0gQyPkFdQw4R98ioOASpymJ9enUr2cfJQjfN6uxaWKjeqzP9yMt1zqReFrUKwbrT3/b3eBhr7S6STXGEw5gpbMl1hP+11TDykOwQnOH1jlq7NNnFEEldRom3FxFDExjYcgooNJWzh4UxF78K1cSn+fcgMKATcVBf6JSHmlONfc92XbF1kzjTuW7ZjO+yI3ehYNQC0t/7XMjF4j0lVMQgDSZcDmRLxvJvzc49z18acQSsM4FJnZ7nii3npNOYJH5V/R7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFF1nbNGj3AAxJToXnITbaV8vQWbstQCqbAHwBy5ip0=;
 b=jxIXgHl6QknrX5j2QcR4ZzBLU90lHZCrGx/sOgVmtM9zXdUeiVJQYBgiRaqzcLSbQmagTMoYo2io1e8EsvUllkvmAQ7oB743KNfvTKWgB++c3iyKne6/KKb5oSDINIJcITysHc0R1j7SPkUHaiT146xzQlCzca7DSHzNE5tjezq7w2KUMXfbuFOxp2J9nTMqeydirS3Kt+Byqj2c2GIfzvDUfvBk1TeypwARcc0qRqSzODenU/pNFjUlRNWSwjYpKvQm9XFIoipbJHTGDP8twnEruSlqjDaSUIxh3tmtl6ACZhVlhkGSmxh8590NkE3RpxDJII9FMwYESwOfv60rKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFF1nbNGj3AAxJToXnITbaV8vQWbstQCqbAHwBy5ip0=;
 b=ap4wAmpFWcdZC2Uxk904bcyw0DxlfvBrHnDqRdjzMimGuC7gXpY4VHw0KFO1oPHhGFE88Wb299xDFaAEepRITEI/uI7oaMsv5P/RO2dK/EPNTIRvlezZF+lG55+toS5/+SkAeKo9/CeImBh2U5bQx2T6aEL3d+cWs9YacopTPQCiNZNsB9nTFTOaHa3mWhbBEwSeWySEegyGVIRDGy4KYFJQ74VTIGmRWxdWuij60cgfww9JgXHDopydSAkg6Qsk6d2iw4ZBgR1kncDAFZNxn5h54UkP5hzyA859aEqUK85sCaeKZFq0kn3mpSlE08I5egCM/9gXxFZLhMFz47oUKQ==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:32 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:32 +0000
From:   nifan@outlook.com
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 7/9] hw/cxl/cxl-mailbox-utils: Add mailbox commands to support add/release dynamic capacity response
Date:   Thu, 20 Jul 2023 13:37:06 -0700
Message-ID: <SG2PR06MB339794D68AB34F3236F4A29DB23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [tOBKb2hYzxa+4UvpSITWmuPe2Rk/5Vii]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-8-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c415240-ed86-428c-f3c9-08db8961317e
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicAYce+YIvRqgnoEwnxu+bmnb+JDpc9/iTTOP9ozNsAulVhyCddRZrdAydHlx9zkKjivmylR3sUpgdc6OS1qLfr3YHf49zkPZC8GXfYZCmByzls9RWqlXS8OGt6G6hz+QAvtWbzLNhLVUS8eC2lQIdLH2MYedaT7NI8FsO/deRnBmw3vLk2Ia4xs1XKI+IeyrUnlTlsH+GaCqyzmJSNdk0FXyRDEicA6IjVTFayGg216dwJLfHfR8qidXT7WcsHLc3aUrUwsGtID3+t2JbrhhdMt2Z0GgBqsdhv5Pomd4/lBifntId+cYqfWA8/8UXCE2Piz7xikJGWizYs5ZlMiGsTguSWpVQO5F1wwJMK5Rm6B3rs4ZRjXuNKxgtrtxntgwiBB+nPKOIHnIyPJRfk4U5DPJLndz+nCTomqfkVE06rRicfABKud51sER3YaLqx+UI8vOAMUmiGBQ81/crpZGtNsU5iID70j/Mwgq8QaMk6TkkO7KCmTGgdSpO243s9M2W+6KFFz/pL50HIBYiqB1USOHIsiOdgAjB10RyKaAvIhci7yl2wxsy533ulbZZwlg/a0snS6aEiG8E7g5q0PvcJDurfbiWgz/MLh7AXQDE/QX73UvwMHCBzjWjTWZgwQhexpM6ze72J6139NCtwxXtcABF0v4nDSxZcreupGf65ZK4R6TtC6LXOO30+ELrT1EpMnFIJK5kDq0RhF85Gl1B2nKMLk9U6eruhP1hvUkng7aQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MK9d7FwlqkcKIqQf7pVFQSNfMPoLG/OjKIJncVDLGxmZ9KmNUM+UCM20yR1BPlit96SHgEI9lEHRiLdzg79nT5lOdGNVrWE4se15nM/nJfURm7tOe2FdYp2T/XmfsSoU+PCrJ3+noTT80jY8vL15ZHboshE2fo1h1WrjzozsF6GvVtYPOpud6ldrLQ3XqVZEAWsF1H6LmB3nfalf9l+2DHHWHWwErb/I3IzHIV7foMIWLjPLhdd0LK30ALMsy3hMTaf08R0Sl0C4MzILG8CvAgOivy7IV7N2o2cx7dWddnCoBVbwbfBblGHdpF/UGhLlOqRQrBzoRQIT4Rh6tsb0daCV9gGJN6NLa/jy48p5uGX8nMLQzCh0vAHoNKV8JhL9Rjg0+e7J+6HmgYjqU55nign9eGhI0GtCldrHabtHU0sGhqCgMQHxVZbVtBlERezqXTCVwn6Y+4IsBSVRtsrBlpWj2qRFaEHdKrk2fRmu0izMYST+98sXTgBarmrGEK+Nc1k61nMh/gI1+1CUDlr8WKtOnlmRzhZ2QmAYBqyjyxsY16G6sRl2bkJjyOzyckQAYPAhKDPZil5GFUoUoqrSqKKlwv5XE2i/qDHm8fGNY1FMb2Ioz10BwER49m+GvOve
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Uj/Dj1JzEZwG22gFdmfmnozNoIWAZtyvw2bGSmNl/w9Bxn1i9DYeJGI8jTFG?=
 =?us-ascii?Q?Ga6FT+m7k6xXNeKvCG3MvXvHfCi++L+jK8rm3t8acGndUm9TOT5fOjw8B+3Y?=
 =?us-ascii?Q?w15fyd5VHnsfQAeSfzR+uVf1dDRMRkkx0KNFnD3MBE2RMpbNvicyxk5syOQ2?=
 =?us-ascii?Q?3fdh43gM8y1lZfORHLGAP8VGdb391Aa66lMC3SmxxIeUNyNgkJrX+f/x89v+?=
 =?us-ascii?Q?22fIQcY75eiwmG/el9zYRpPCOlDJFDt/BPJ8ORblDXe/BF//rqtgbnp1V4VP?=
 =?us-ascii?Q?NyJr/0qe/vzNoBq2iYrbu1GZQONmvPlfOCaOygaljysdN6rzHO0Php+m0C8a?=
 =?us-ascii?Q?5I/8EZINQr6OwWnjRqI53lf0SLge9Ll3Lzf3aMHGg5qo2OHAU8imTVuHQFyq?=
 =?us-ascii?Q?R9cSQxhuY9ww1yz5tlnxWjURGDK+wQjsKGEH7EJDE8JBLebRctZGt3zaYiAJ?=
 =?us-ascii?Q?W2M7MuvWjwHGqPHYKnJP+nw8l/cAkgirKaV/EDZ2DLYIdM0XVenys0atrZpc?=
 =?us-ascii?Q?OMZJgj1z9NpIhMH8Fg5zy7m+N55VDiHWmVGHpEiU5lAmegZNG0ZIU07t0OOR?=
 =?us-ascii?Q?6AJKu30+U7VDMW9PWY00z9jGY2ddbrKGA3ISqB0mXT9nLhWJ/UteU+v9poBx?=
 =?us-ascii?Q?kKRMtiR1S2xlK9DSpH5t4T1TUpYz0j5cjbruJCHAeiOBkhamPAt8qgBYB5/Q?=
 =?us-ascii?Q?ifx8zRJOL8ne0VtVUA9DhhYKyrKAQhsZqrzYhPmGEBSCHTmEc9hS3S1Z9Z6n?=
 =?us-ascii?Q?Af8zB1YDDKm7tnyeZpxJCzqEWMDnuukKalHqM+BEf96EWEuDsTabkHSQT2pi?=
 =?us-ascii?Q?ffkTs4ja3RGfhLSbe3Fqstvv7ZcejD0CLdMtgWeduRMAWZUUw3SpFL5xrDPu?=
 =?us-ascii?Q?zQrdkkbqwqS5fZ0npascK3qZumaGXGtB6mLXLUq7MmpXk+p3SHa6SJTA5wyX?=
 =?us-ascii?Q?1xbKCsj3VzFJ5vRqfquc3n7+ZzDwdYFjc4/UuJWKGzEckLeiGcdVPEBuPZZL?=
 =?us-ascii?Q?N7likx6vxXFNP0fO4WcTz9S/HBGYiwpqMFjvpWdj+EFpLJPQAfPCewgdtWAJ?=
 =?us-ascii?Q?G6JPKPiYdxgvXiw3hRHJcc0oEn4EaJNB10rZ93+RWVOYw/c1eajPP9MY43W3?=
 =?us-ascii?Q?wHs6YloeZMF6qb0rR+jRhhtz7nwpuaOGkgF67NmSiOMsOuR0d/SeESPZ0v+6?=
 =?us-ascii?Q?ja/Ru3bvIc1IzIFfwTVs5x+FiJngKjFbVNuK2w=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c415240-ed86-428c-f3c9-08db8961317e
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:54.1269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
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
     DCD_CONFIG  = 0x48, /*r3.0: 8.2.9.8.9*/
         #define GET_DC_CONFIG          0x0
         #define GET_DYN_CAP_EXT_LIST   0x1
+        #define ADD_DYN_CAP_RSP        0x2
+        #define RELEASE_DYN_CAP        0x3
     PHYSICAL_SWITCH = 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -1086,6 +1088,251 @@ static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/*
+ * Check whether the bits at addr between [nr, nr+size) are all set,
+ * return 1 if all 1s, else return 0
+ */
+static inline int test_bits(const unsigned long *addr, int nr, int size)
+{
+    unsigned long res = find_next_zero_bit(addr, size + nr, nr);
+
+    return (res >= nr + size) ? 1 : 0;
+}
+
+/*
+ * Find dynamic capacity region id based on dpa range [dpa, dpa+len)
+ */
+static uint8_t find_region_id(struct CXLType3Dev *dev, uint64_t dpa,
+        uint64_t len)
+{
+    int8_t i = dev->dc.num_regions - 1;
+
+    while (i > 0 && dpa < dev->dc.regions[i].base) {
+        i--;
+    }
+
+    if (dpa < dev->dc.regions[i].base
+            || dpa + len > dev->dc.regions[i].base + dev->dc.regions[i].len) {
+        return dev->dc.num_regions;
+    }
+
+    return i;
+}
+
+static void insert_extent_to_extent_list(CXLDCDExtentList *list, uint64_t dpa,
+        uint64_t len, uint8_t *tag, uint16_t shared_seq)
+{
+    CXLDCD_Extent *extent;
+    extent = g_new0(CXLDCD_Extent, 1);
+    extent->start_dpa = dpa;
+    extent->len = len;
+    if (tag) {
+        memcpy(extent->tag, tag, 0x10);
+    } else {
+        memset(extent->tag, 0, 0x10);
+    }
+    extent->shared_seq = shared_seq;
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
+    uint64_t min_block_size = dev->dc.regions[0].block_size;
+    struct CXLDCD_Region *region = &dev->dc.regions[0];
+    uint32_t i;
+    uint64_t dpa, len;
+    uint8_t rid;
+    CXLRetCode ret;
+
+    for (i = 1; i < dev->dc.num_regions; i++) {
+        region = &dev->dc.regions[i];
+        if (min_block_size > region->block_size) {
+            min_block_size = region->block_size;
+        }
+    }
+
+    blk_bitmap = bitmap_new((region->len + region->base
+                - dev->dc.regions[0].base) / min_block_size);
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        rid = find_region_id(dev, dpa, len);
+        if (rid == dev->dc.num_regions) {
+            ret = CXL_MBOX_INVALID_PA;
+            goto out;
+        }
+
+        region = &dev->dc.regions[rid];
+        if (dpa % region->block_size || len % region->block_size) {
+            ret = CXL_MBOX_INVALID_EXTENT_LIST;
+            goto out;
+        }
+        /* the dpa range already covered by some other extents in the list */
+        if (test_bits(blk_bitmap, dpa / min_block_size, len / min_block_size)) {
+            ret = CXL_MBOX_INVALID_EXTENT_LIST;
+            goto out;
+        }
+        bitmap_set(blk_bitmap, dpa / min_block_size, len / min_block_size);
+   }
+
+    ret = CXL_MBOX_SUCCESS;
+
+out:
+    g_free(blk_bitmap);
+    return ret;
+}
+
+/*
+ * cxl spec 3.0: 8.2.9.8.9.3
+ * Add Dynamic Capacity Response (opcode 4802h)
+ * Assume an extent is added only after the response is processed successfully
+ * TODO: for better extent list validation, a better solution would be
+ * maintaining a pending extent list and use it to verify the extent list in
+ * the response.
+ */
+static CXLRetCode cmd_dcd_add_dyn_cap_rsp(struct cxl_cmd *cmd,
+        CXLDeviceState *cxl_dstate, uint16_t *len_unused)
+{
+    updated_dc_extent_list_in_pl *in = (void *)cmd->payload;
+    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCD_Extent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+ 
+    if (in->num_entries_updated == 0) {
+        ret = CXL_MBOX_SUCCESS;
+        goto out;
+    }
+
+    ret = detect_malformed_extent_list(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        goto out;
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        /*
+         * Check if the DPA range of the to-be-added extent overlaps with
+         * existing extent list maintained by the device.
+         */
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa == dpa && ent->len == len) {
+                ret = CXL_MBOX_INVALID_PA;
+                goto out;
+            } else if (ent->start_dpa <= dpa
+                    && dpa + len <= ent->start_dpa + ent->len) {
+                ret = CXL_MBOX_INVALID_PA;
+                goto out;
+            } else if ((dpa < ent->start_dpa + ent->len
+                        && dpa + len > ent->start_dpa + ent->len)
+                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa)) {
+                ret = CXL_MBOX_INVALID_PA;
+                goto out;
+            }
+        }
+
+        /*
+         * TODO: add a pending extent list based on event log record and verify
+         * the input response
+         */
+
+        insert_extent_to_extent_list(extent_list, dpa, len, NULL, 0);
+    }
+    ret = CXL_MBOX_SUCCESS;
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
+    updated_dc_extent_list_in_pl *in = (void *)cmd->payload;
+    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCD_Extent *ent;
+    uint32_t i;
+    uint64_t dpa, len;
+    CXLRetCode ret;
+
+    if (in->num_entries_updated == 0) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    ret = detect_malformed_extent_list(ct3d, in);
+    if (ret != CXL_MBOX_SUCCESS) {
+        return ret;
+    }
+
+    for (i = 0; i < in->num_entries_updated; i++) {
+        dpa = in->updated_entries[i].start_dpa;
+        len = in->updated_entries[i].len;
+
+        QTAILQ_FOREACH(ent, extent_list, node) {
+            if (ent->start_dpa == dpa && ent->len == len) {
+                break;
+            } else if (ent->start_dpa < dpa
+                    && dpa + len <= ent->start_dpa + ent->len) {
+                /* remove partial extent */
+                uint64_t len1 = dpa - ent->start_dpa;
+                uint64_t len2 = ent->start_dpa + ent->len - dpa - len;
+
+                if (len1) {
+                    insert_extent_to_extent_list(extent_list, ent->start_dpa,
+                            len1, NULL, 0);
+                }
+                if (len2) {
+                    insert_extent_to_extent_list(extent_list, dpa + len, len2,
+                            NULL, 0);
+                }
+                break;
+            } else if ((dpa < ent->start_dpa + ent->len
+                        && dpa + len > ent->start_dpa + ent->len)
+                    || (dpa < ent->start_dpa && dpa + len > ent->start_dpa))
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
+ 
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1129,6 +1376,12 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
         "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
         8, 0 },
+    [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
+        "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
+        ~0, IMMEDIATE_DATA_CHANGE },
+    [DCD_CONFIG][RELEASE_DYN_CAP] = {
+        "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
+        ~0, IMMEDIATE_DATA_CHANGE },
 };
 
 static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a9cfe4e904..5bf1dd4024 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -130,7 +130,8 @@ typedef enum {
     CXL_MBOX_INCORRECT_PASSPHRASE = 0x14,
     CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
-    CXL_MBOX_MAX = 0x17
+    CXL_MBOX_INVALID_EXTENT_LIST = 0x1E, /* cxl r3.0: Table 8-34*/
+    CXL_MBOX_MAX = 0x1F
 } CXLRetCode;
 
 struct cxl_cmd;
-- 
2.39.2

