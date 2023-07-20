Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9ECAEB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjGTUir (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjGTUiq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:46 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E066271E
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FlDaaNdEGkltMSJ8F4vJWChgQyHScQ7BexnXmQq0K2n+asBIskHUSK5Z6q5kMvxUXROMwnzuWVD2eM0Z1Ev9nMTKquOsZx8eK/l+UXC/XtNfMm4us7pFv2pzq/N+6FMtf0TzXWr4F+tlhQXTF8SGYOZ1T9OafsjOzu6cFcoxtTNMDVRahb3cuXxF0vaMLVnD8B2RAd23KHt2CKlzet1oUm/SLe42uu4UIHLDerAM92nep8BT71DW4PnjmQoTMkNQ1SvqHuhKkwk1iTqqWWl+5psoGV00jm1IB1v+TnLH9s0fNQ+yfATitA9RgPD1BdYWrfz6nPtsPb8Ek3SSwdC6hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gsh8kP1EgJWpxeSgOgVo0+O5DAGAipoxDYWpKkWlfSA=;
 b=WS3y++p5SKmHACKqkx3qS0c2eymLf/awHOPhiAGifCwP5CoYzX4D+TyDGyFQk8cs9iy0KkJPRJVgBTopXtOZpH874+yCqGbUnN56mIwCK8JCjpxnZNi8Xhv6w/CQc/mqGDwuKXInSrozeMuHm3VfPHtCW7lv/FndvFFIqk6j/Bktt8mNnBu9WdqzkLlT7x5fkr4bV2BYgSAbRD6c+0XhbnyFeIBTbsCayy/qs1+dHXXwsf8yAieEJU8DF/f7xIyVRu6jdlFrhQ3n52x6rPT7AHe1XR5r4RqPANe22LQwr7aXC4YkKOj2JPTcplRKYw7KA6fE+Gs2EYM5zLpgrWaLGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gsh8kP1EgJWpxeSgOgVo0+O5DAGAipoxDYWpKkWlfSA=;
 b=UZ2/0PnKJFjGt94EN86uRjw1SKh1AcSu5XOvOwo6d4Tacd/Y+tGhdorQH09V4VXaUXGxoIWGwbfwmhQoTG+865Ip82Ed7sw4fvrcEFnbCIag2WdMsNaK15T02MIyGi3W+qbVu23Eyhx5hw14kbD1WM9Am9SzFuoovck64jxc5miC5ldLiL+hZyLSu1K9st3c4MovswmsFmTndamL+cGF3sgvngNILNN7QmbyBm2xh6uyj3yPtq5p7+Oj5JBsKLkR48Sm+vjj+c5ohbLTf2gm9aJekPUh1jKEx2MExVvMzATwgq8VKurSSa4cT5SgVdwbCO4GAg62i+rFatV094VC+Q==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:33 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:33 +0000
From:   nifan@outlook.com
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 9/9] hw/mem/cxl_type3: Add dpa range validation for accesses to dc regions
Date:   Thu, 20 Jul 2023 13:37:08 -0700
Message-ID: <SG2PR06MB33979CBDFCDBC38D1CEE5441B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [qQh3J7BVfZZjI22LtyqYFNIiJcuDM0LM]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-10-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd02a43-139c-4f61-a922-08db896135f9
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO/qzAKd82WE1LuLgf/v/GCyTnXHa0xOAKujNjF/WtriZQzWycWlXTo22N0ZO2+HWeLpml0qDhHRs/60ayRrGSU+pJzrtU5Ys/ltqVlfrzdvzjtFRXH8OFP5VifuekEiWharz1r8MW5y8UGJ4HSMElVcrRHGpxVFmBZqvksu/XS0YxdYd6oSROzUymy4a1CeNim6uy8b6E8M5qT6wN/niNn5DQ78yoTstu9BJacfyYWvWzelUQEU2h+8ZoOKpWQ3ZL4MfYyRYql33KHxO376xaFLdfjwYds8fgQDhdxYeTwzqjaugoQgWStsBEkT5BPcsMoeWDO7z5NqAwI79RIsBg8W5/Rb2J0Ii5u3w0XuZu+gHUBreP4v4+rR3y5f830oiNurjBgAB70gNLhCPRP4TFlkdr/e/if5ZVldB9VRqrVZtkyHWJmxpQe6nid0kfdDqwAflYlGicA25wO6lF0O5dQqnn10+Qr4kqf2bltLeeXksjWwaNQEPvUYcZyJn7i7i9AN2dQ5RA8Ut8FMi1GxSie/bTiDnanaF1PKYQ3AMG7xyGR+aGKyZQsnv5a4FmzaiTsWuzso39vWv2Dnxeg0xbbhXzKR2TahCUV2J0G6Dti8bXC21jszqThZs5QuQvcA/LqlzpoSkdxSnEEfY100cBxqjyiQyp0bfpNjg8WAos65SIugEdyjVc/d1aIrie585i+hmakINjfsNA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +4ulVeJUOwea+cd/6gt/TTBgdqI9Fy1ieswQV2cAhOlZQliR6eTdfXoFuajCZ7MXGpvfVcH+O7+aMRdE6d2e5ZYeSceTAngtaXMqtcrHJFgq2z4BxNYBQPUnIuyoCfO6WZHEFywmCOZ6wPhL4kPlnNnhtgJc+s6Btm0mPY6eqTrBwHmt/yc34NEfYr02/jkoKtGNK2fj8jXBfQe4pnBlNfYknkmwOolyoQIYGSehuZReXJQpyNwZY9BnZlWuOFBS0h3TgDiPTJ83smpTFwYviOAm1VRGd632AeMS7PV0kHzmktohNxKyOvsoPUcmVQOtD+7YzdVmvCIylcvCPq8BHRtepILqq/lfmGhyZOjueBMmkoXRDF+AT9aEy39vux34zv+ojT96kg4UMRm8jW/yWlEtyKNhCuLbrdiqtR3x1iqjzcw8FDOCUr1ncTOvubB8+gZ2UnGkDIAaNsUr5TInUv8f9S49Zg4FaE3Pk354cxQDrzxflyVhaY0kaiWqHrhQlQ75j9BRZN2YT/IAas6YWWNgypIyzhSE19yrkHM0fUZY20+ke+7eyqq4za//BDTWUvYGZXmuqHKayv7XdQfkbfFVsS9i/1RGak6i2f1dFhNfzQ6M2vXDOlIqni8zsRId
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yXyN0x379BhT0vDxyu07kjWgUEsloM2JzXsJU1jP/flNQnyW9ozCtxCLsmBZ?=
 =?us-ascii?Q?zL12yVYwcu23lPKKcGhaAvTMgeMMgbqp9IxgSAR1uh+PfJPq+8o3TQtl2/hb?=
 =?us-ascii?Q?Nytjo01wfQariOeuMGHrnIk6isGhGe+jmY5HajUTQArJ40BZ8a3hFe9TlKF3?=
 =?us-ascii?Q?nT8Q8O2xTH0aKAO/qmfYN1kmLq2MQGIWYNoqs90VQI9FGWQhKDg2xgLRtN8T?=
 =?us-ascii?Q?3J6DCDZDdOWWZuUyGq9/irLCNB6MNsR6Vfn2rMFzDuBFQCUyd3AMwaJA+Cc0?=
 =?us-ascii?Q?B5RoN8wRJMNvrv7KPGmoYD16JDcclfDhaoUytngc1/ahMzF4uPq5M40R3U6C?=
 =?us-ascii?Q?ydTdvQqpCMi+VkONHvhqLX4duiTCAQtl6jqVYiyhrTb9lSW6BCcvuBsdkDwU?=
 =?us-ascii?Q?6UzvXPiwq48Clio56utUWAh4ergAKcgJTDBzdECA6JtpaX9hqeR5Vo9TMkFZ?=
 =?us-ascii?Q?OIcsWGAGkXufwJM0k/QA9RFKNGZqWKSzn8z/u2k/WOqW102nf/PKMw18i80e?=
 =?us-ascii?Q?EUBguErmWifUfwc7PGqvvPkeGWnIRhZx0GVVv3ZkICxOnddzrpeO4k91t9E1?=
 =?us-ascii?Q?COqhPxPuGWSEr91Lv2FdZQUskhOoQfjPo6n1Y0TmdLgKjdHPM2i//iTaFuCu?=
 =?us-ascii?Q?WUSiYfC/WfUaIxgvwL5oHw7KlFULh8AcYJKEiPybQBxB9fl2GYlo6wIP0L07?=
 =?us-ascii?Q?SIaMpSD5F+LXvfiVFdhZUkyOoehl22i9iJyX49fGeo685vJa7fAb3Dn6XkCT?=
 =?us-ascii?Q?TNtL0y9abAmMp71RrhUYXjTs8CyXEwhrTkfF0ssF/dX6YjEmD3a/EBQyUPu/?=
 =?us-ascii?Q?E4ZTW5hIEYslRHIIIAx8emtIWvShn9orejLLRSNvWtKjwQXOwdJ3CrTms/fQ?=
 =?us-ascii?Q?0hsmb3aw5ZfHIzpsdrgiTfJQMy7LcoR8zqnZlhJaEo5w8iT5xgW+FU+4H9gJ?=
 =?us-ascii?Q?XzmB5G/mcRW+zlXTv0a5WGohSaD3xSFdzksDCKB4SGJ8EJtlnI0saMHF0wtA?=
 =?us-ascii?Q?2TGM25yuOaNglkarS3Ne/n1wcUdweKM/iJQeKThxSZEu8ksIV4wloSW23qP9?=
 =?us-ascii?Q?SZIKoF02QdeWlDLBlKW/6K8AN9ZxanLrjBsTVxbclXGHQ8jO/dFzaQQbsojZ?=
 =?us-ascii?Q?Wk4/lffWmBc0mM/zL62yrA5APOQNBaeGRI5zl64hVjKofzPtOBhHtU6goZyA?=
 =?us-ascii?Q?GMNJvnyVGoLuMPsFiCPreOLu9QJlzY9Y371pqQ=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd02a43-139c-4f61-a922-08db896135f9
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:38:01.6097
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
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
         region->flags = 0;
 
+        region->blk_bitmap = bitmap_new(region->len / region->block_size);
+        if (!region->blk_bitmap) {
+            break;
+        }
+
         region_base += region->len;
     }
+
+    if (i < ct3d->dc.num_regions) {
+        while (--i >= 0) {
+            g_free(ct3d->dc.regions[i].blk_bitmap);
+        }
+        return -1;
+    }
+
     QTAILQ_INIT(&ct3d->dc.extents);
 
     return 0;
 }
 
+static void cxl_destroy_dc_regions(CXLType3Dev *ct3d)
+{
+    int i;
+    struct CXLDCD_Region *region;
+
+    for (i = 0; i < ct3d->dc.num_regions; i++) {
+        region = &ct3d->dc.regions[i];
+        g_free(region->blk_bitmap);
+    }
+}
+
 static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
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
 
+/*
+ * This function will marked the dpa range [dpa, dap + len) to be backed and
+ * accessible, this happens when a dc extent is added and accepted by the
+ * host.
+ */
+static void set_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region = &ct3d->dc.regions[0];
+
+    if (dpa < region->base
+            || dpa >= region->base + ct3d->dc.total_capacity)
+        return;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     **/
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            break;
+        }
+    }
+
+    bitmap_set(region->blk_bitmap, (dpa - region->base) / region->block_size,
+            len / region->block_size);
+}
+
+/*
+ * This function check whether a dpa range [dpa, dpa + len) has been backed
+ * with dc extents, used when validating read/write to dc regions
+ */
+static bool test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region = &ct3d->dc.regions[0];
+    uint64_t nbits;
+    long nr;
+
+    if (dpa < region->base
+            || dpa >= region->base + ct3d->dc.total_capacity)
+        return false;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     */
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            break;
+        }
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = len / region->block_size;
+    return find_next_zero_bit(region->blk_bitmap, nbits, nr) >= nr + nbits;
+}
+
+/*
+ * This function will marked the dpa range [dpa, dap + len) to be unbacked and
+ * inaccessible, this happens when a dc extent is added and accepted by the
+ * host.
+ */
+static void clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
+        uint64_t len)
+{
+    int i;
+    CXLDCD_Region *region = &ct3d->dc.regions[0];
+    uint64_t nbits;
+    long nr;
+
+    if (dpa < region->base
+            || dpa >= region->base + ct3d->dc.total_capacity)
+        return;
+
+    /*
+     * spec 3.0 9.13.3: Regions are used in increasing-DPA order, with
+     * Region 0 being used for the lowest DPA of Dynamic Capacity and
+     * Region 7 for the highest DPA.
+     * So we check from the last region to find where the dpa belongs.
+     * access across multiple regions is not allowed.
+     */
+    for (i = ct3d->dc.num_regions - 1; i >= 0; i--) {
+        region = &ct3d->dc.regions[i];
+        if (dpa >= region->base) {
+            break;
+        }
+    }
+
+    nr = (dpa - region->base) / region->block_size;
+    nbits = len / region->block_size;
+    bitmap_clear(region->blk_bitmap, nr, nbits);
+}
+
 static bool cxl_type3_dpa(CXLType3Dev *ct3d, hwaddr host_addr, uint64_t *dpa)
 {
     uint32_t *cache_mem = ct3d->cxl_cstate.crb.cache_mem_registers;
@@ -1145,6 +1275,10 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         *as = &ct3d->hostpmem_as;
         *dpa_offset -= vmr_size;
     } else {
+        if (!test_region_block_backed(ct3d, *dpa_offset, size)) {
+            return -ENODEV;
+        }
+
         *as = &ct3d->dc.host_dc_as;
         *dpa_offset -= (vmr_size + pmr_size);
     }
@@ -1938,6 +2072,27 @@ static void qmp_cxl_process_dynamic_capacity_event(const char *path,
     }
 
     g_free(extents);
+
+    /* Another choice is to do the set/clear after getting mailbox response*/
+    list = records;
+    while (list) {
+        dpa = list->value->dpa * 1024 * 1024;
+        len = list->value->len * 1024 * 1024;
+        rid = list->value->region_id;
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
+        list = list->next;
+    }
 }
 
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
 
 struct CXLType3Dev {
-- 
2.39.2

