Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B2E0EB64DD
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjGTUin (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbjGTUim (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:42 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2058.outbound.protection.outlook.com [40.92.107.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 738611731
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GHJ2o2RkVxIdHIKSmi6s8hTMvrwSWHsHu2vugXa33PWmXIxp+fvoySayzkvd1ZtlCDOcUnO7lzrFAOywPH42Kn21rZRhP1kfSQOqbrgSpqiG1gvE6C6jmhuDOEipwgEnHb06vLlIk7TJGh7kEEQpDT6PPcSBGMrRubXzo7yqp/9TUDdcvq8tjvqe3gyJrvysRZmE6iN1F0ZMjpBasekPj+LkHTCYbYWnDmc73wPKxaG7fuvhC6xBhShhsy1LHnA0+87m9sqZlM2y9Q+DDCwAjmC2r7c/TZtgU4BW7rSTQEEjXOi1f/QYppKB4ja0FLsAPD0hQ9U57TFrzjCaQ6EdGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E5orTEgp313dgjIIm1iwcaXWxROhyMBCbIEjzU3IuzM=;
 b=DziEoSh9Av2h++iVBNsCgvj0tF7B4l34Azp3ghsYKEnS28gm3U5x6GjB0S5+5iQ9oFS1GDhuD8Bq88rpzU3jJ/0EUY6myJxYRaY5PscBbWLEi2aZ9r/9hScZ5lJDZsHEKgX5FNzGECXrUA8WdKue6cZvMWwzVzpgYvFRqNOb/xyErk34pCTBYdGB70SYbiuAPHBfsa+TqclK0TgYxM5a9BXhQe8ruCaABQyETpftIcG9BgOyzw1SbDGSyxiNK2iebkJhfBg7AWuoZmnpGbzfYDhYJEvkFigmyUoSGg2+eC9hGt8u3yBkYKm5Dm8IvLNijTMDjkL9ZfEIGVx62wBevw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E5orTEgp313dgjIIm1iwcaXWxROhyMBCbIEjzU3IuzM=;
 b=VeLiYgkk0cZ0Pub5pVhHlEg4DK2UKCYtnk8cCaRhPM9uuZr0hP4fhlvftm5GqolL7OAsZIMRIt7y872uyQGwiCmBHSYcjtrkepFzvqcYF1ZYZkT6QBoAoOTuNMmvdMsvWDT1W3H51sd8DKXuO8I3hNDU7pyBGwomOAtgZmzKyTgIFRNOF8kcUim+S7M6AlZJTx/bbGJsOGAFQdlJV09oQgJPXBIGJsr8fnaiU4nVnWf/1Ge9/CeCX4zwPkMMb6ps63MaHyA/2d/0LJdX8O1mxvEKcXzlrOdj8iqqHv4dWSRUQXYMGd6tbR9GSGUx5v7h1EaJVAoLKxIZHAgj7RNH1w==
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com (2603:1096:4:7a::17) by
 KL1PR0601MB4100.apcprd06.prod.outlook.com (2603:1096:820:24::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.24; Thu, 20 Jul
 2023 20:38:31 +0000
Received: from SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c]) by SG2PR06MB3397.apcprd06.prod.outlook.com
 ([fe80::450:9c8c:9058:c94c%5]) with mapi id 15.20.6609.024; Thu, 20 Jul 2023
 20:38:31 +0000
From:   nifan@outlook.com
To:     qemu-devel@nongnu.org
Cc:     jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
        gregory.price@memverge.com, hchkuo@avery-design.com.tw,
        cbrowy@avery-design.com, ira.weiny@intel.com,
        dan.j.williams@intel.com, a.manzanares@samsung.com,
        dave@stgolabs.net, nmtadam.samsung@gmail.com,
        Fan Ni <nifan@outlook.com>, Fan Ni <fan.ni@samsung.com>
Subject: [PATCH 5/9] hw/mem/cxl_type3: Add host backend and address space handling for DC regions
Date:   Thu, 20 Jul 2023 13:37:04 -0700
Message-ID: <SG2PR06MB33975BC8BD669EE2CE3880B0B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [C1sYar+TzjFE9yql5CsFQUwMDkFYDzDL]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-6-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfba9b9-558a-4948-b121-08db89612d38
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicAYce+YIvRqgnoEwnxu+bmn4WK0pvigUmRttW27tsG+DQnjrdGjJmgyRqkXVwSm/1WIMw8/qJSodpRrL27KyBUBmgzQfkhDpoE18z7dgg8TwDqKIQisVxRH7O2tBm0KOKZtLCqW7vNdBP3sEGgOnwBizw99GUlwv3WvKMfor1YuRZSd1VCItPmo5FSbxoUcaaxgmmHJMqm2dDx21ttjLIHXZWseSOrld2v2gfYAiLSE0bZsvvjMw7AWTv+y87/Qir8+CV8by1kVP3t8r5Ar7uoNyYi7z5b2oNIWZVLvMZPFhlQRmcKH9NN0taqJJ+Z0dmuxT6PYmlj1p1jeVHkomw485wb6rZ2Pu8+6rX5dhYmGuW3jIKFDiduhPtTRXSXWYsaNWbPLABhmq9/EJNLYPkXwmGgmPFGqLSQnSwC/6aM7PcgSyUziUn1K+NLnKviVk18aR85TkQp+XwSAdJEnvPcOgtpkNrHOp9dQoBmC2WwcquZDeGBSagwa4BCKeq7Wmlpemkm/4LkqV+XKSPDgcTcWOVLHmhC3i3+r1AkjGroyfp28QIJ0waZHMlmCWYEsMkKyCzwmAV3A+rGMwW+tV/536nRcfvUlpGSAJFC3kW1CRFq461wHU3BuA12LMZRVb4cMjzJCN+Oeay2h/w82J6haBLoSKe4ZFsspB95jeo/sAQzSUTJjYCCSZMV6MtBKGgiW+8TzRbV0fqkvaOnSyB4SHiOKZG6XfDNtVyQyQQIaOA==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: etgTZ0H0eZ0r3ktDP9FxZ/ThhL2It3i5Fyos/ec+7MrIXVIDr6DFDCGP2yBA3xV56+PZ+mQzUq17aKYySG/Qw56TQXtZBxbXepgWE2j3wilzHBe6q2DRxl0Xh/QxYp3dV/dAo8Gb6JhC50FPhbSNogq+wh7eUGy8IJZ8uaENZI4/Mzc4Ywwz+b2ORNaomsbk10XRDU5QJf9hT+mOS7KFalj7z4d+OrDCPriQUQhqafT/x45gznk5arXTi0N7SUXS5caPk0lmnAe/lV9CGzRs05uC7DVVDI15rOevBLkKSFCox+Ih0OBfjyLaGF8vz5mqDfsxK3QeVsdFdCmnOzDkOusgd0k5Z5JQ3RjQQtfWXMwtlK0Mjlz3ohLEly8mQu+SC61M4S7eCAoXa13f1Rg2pJwDrDt6ylJ4KUD9cSKI099qSBuKbwR55B6t/blHK3KBKfdNMIvmART6Y29UvJ4NdtMxqN/xxNmiH/z3EvD+noWxcSKiYJGUk2Kcx0g2RbiDQJUFJzphUJ1weFtdOxJoV030seAY4p+dZZ9Ly87hZyM4B5hAQVX1vtTHFlNIOSOej9GPcADdg+ektciVuRmczoJD3fL0Vt1XiA8jYVBtQ2rJarhUKPOLSdGgCp0AfMhZ
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YAf+Ciibf/Sl6MZcJoOkW5xgFlLwrecpgDa/1YD7szMYZtXhYs000bahQKdC?=
 =?us-ascii?Q?UjpRu7IBICn5gNQ+Fj+vucSOmyf9X48zouuzcahO3uuUAQSTz3f8t+5rzLVZ?=
 =?us-ascii?Q?vHeGA2epJFZKO5IOyKLnZf8JLga10ydPy0zih3dsUvYJIf60873F2vCF4f3r?=
 =?us-ascii?Q?XAwib6Sr2ISyQy/Mi3HY3ufcZ4l45lYPAiplcRTpXgk/JFZxZiSYxjDUSKAC?=
 =?us-ascii?Q?pLN+EGj+lTSJlXcpabFyAcsi0oXmFfv0cS1MpfzSidjPUDTMfDRnI6O081H0?=
 =?us-ascii?Q?1f0n8qrhsEurFPuENxmScKrY+Bv2yfeB5YlT1WYhFhI2kxEJchUqUWbUEepM?=
 =?us-ascii?Q?XYlZJ074pNNIJ9dmxRhhHoUSf2WUy7pu9DmshUY4BR/8iKmI9vXVsCa/ko6/?=
 =?us-ascii?Q?MyXiEk51MXygCRcLV8wNh2MO1HFCWsqSwumvfIRo4KlzdtjGoZGvddtp4tLX?=
 =?us-ascii?Q?SBQnSC1wSjJasZ/nDD55lvNq1SZUzPM3V7VPvtfgWvILWFzUAg7XVccV0t/F?=
 =?us-ascii?Q?LukW0qefnxKUbQrKPZhl2ugqrPsowcucjIdkYehzmsLJRgfcptp5qEdaXlPq?=
 =?us-ascii?Q?U8OZlLC53noN0pvOdCsJrN9cqYpSUO09sqky/1jtRE/xSFn9uYOUuvpAhsah?=
 =?us-ascii?Q?xVMF+HTGWQZ7j/O4OWe2ia6KSFfUBiJS1BpQyTrNcvUR/IURS4I8GLCKP9H7?=
 =?us-ascii?Q?B2mxJIyuReDi9uS4bfazHeinZpKfOJ3Xwla6Sg72s2yjcR3ed3d9YIQhSxrP?=
 =?us-ascii?Q?eJFNZtUU3rny0Uj/2w7167LdDoN4wP4m8TTbvT4g2BVPnq/JkZDWxT4D+yoc?=
 =?us-ascii?Q?EQces0jYosRJD8Xv7WCBsdH4foLWIsDyhQ0ckPDacL8e3EwaNO7M7ewvXJkv?=
 =?us-ascii?Q?2aBUZiY+D/Hw9YhDPced6eiBeinAr6B/vTrTq8KdzGFmSHlr4TDVe1jIao6d?=
 =?us-ascii?Q?2tg86rHwU5ytOYyEkEvUFL8N5MFfvtNtL+K/7Q6yLChTeNj5ccT+ScMNQe/g?=
 =?us-ascii?Q?hotCpRlB0G0KpCRidw/mtjroBXa4zaCKxLY2unTdPetabbogmCtrQ3hq2CCn?=
 =?us-ascii?Q?S6SmYEaDGweoqu3ozxaTSiHOib91QtCVZHLIITEMoQV8XyNWUUpY3ibshOic?=
 =?us-ascii?Q?C/fS5wqVQmwSClYdypPSqe9//0kWrspSgk/4ldbChuPm+CKzW4W7OSJ2YiI7?=
 =?us-ascii?Q?tQNLLG3XkFzaHxqakqmNH6ZhHzLHllxRUct91Q=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfba9b9-558a-4948-b121-08db89612d38
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:46.9303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Add (file/memory backed) host backend, all the dynamic capacity regions
will share a single, large enough host backend. Set up address space for
DC regions to support read/write operations to dynamic capacity for DCD.

With the change, following supports are added:
1. add a new property to type3 device "nonvolatile-dc-memdev" to point to host
   memory backend for dynamic capacity;
2. add namespace for dynamic capacity for read/write support;
3. create cdat entries for each dynamic capacity region;
4. fix dvsec range registers to include DC regions.

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/cxl/cxl-mailbox-utils.c  |  19 +++-
 hw/mem/cxl_type3.c          | 203 +++++++++++++++++++++++++++++-------
 include/hw/cxl/cxl_device.h |   4 +
 3 files changed, 185 insertions(+), 41 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 59d57ae245..c497298a1d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -388,9 +388,11 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
         char fw_rev4[0x10];
     } QEMU_PACKED *fw_info;
     QEMU_BUILD_BUG_ON(sizeof(*fw_info) != 0x50);
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
 
     if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
-        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (ct3d->dc.total_capacity < CXL_CAPACITY_MULTIPLIER)) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -531,7 +533,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -566,9 +569,11 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
         uint64_t next_pmem;
     } QEMU_PACKED *part_info = (void *)cmd->payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
+    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
-        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
+        (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER)) ||
+        (!QEMU_IS_ALIGNED(ct3d->dc.total_capacity, CXL_CAPACITY_MULTIPLIER))) {
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
@@ -880,7 +885,13 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     struct clear_poison_pl *in = (void *)cmd->payload;
 
     dpa = ldq_le_p(&in->dpa);
-    if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->static_mem_size) {
+    if (dpa + CXL_CACHE_LINE_SIZE >= cxl_dstate->static_mem_size
+            && ct3d->dc.num_regions == 0) {
+        return CXL_MBOX_INVALID_PA;
+    }
+
+    if (ct3d->dc.num_regions && dpa + CXL_CACHE_LINE_SIZE >=
+            cxl_dstate->static_mem_size + ct3d->dc.total_capacity) {
         return CXL_MBOX_INVALID_PA;
     }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 27b5920f7d..af1d919be3 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -20,6 +20,7 @@
 #include "hw/pci/spdm.h"
 
 #define DWORD_BYTE 4
+#define CXL_CAPACITY_MULTIPLIER   (256 * MiB)
 
 /* Default CDAT entries for a memory region */
 enum {
@@ -33,8 +34,8 @@ enum {
 };
 
 static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
-                                         int dsmad_handle, MemoryRegion *mr,
-                                         bool is_pmem, uint64_t dpa_base)
+        int dsmad_handle, uint8_t flags,
+        uint64_t dpa_base, uint64_t size)
 {
     g_autofree CDATDsmas *dsmas = NULL;
     g_autofree CDATDslbis *dslbis0 = NULL;
@@ -53,9 +54,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
             .length = sizeof(*dsmas),
         },
         .DSMADhandle = dsmad_handle,
-        .flags = is_pmem ? CDAT_DSMAS_FLAG_NV : 0,
+        .flags = flags,
         .DPA_base = dpa_base,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* For now, no memory side cache, plausiblish numbers */
@@ -137,9 +138,9 @@ static int ct3_build_cdat_entries_for_mr(CDATSubHeader **cdat_table,
          * NV: Reserved - the non volatile from DSMAS matters
          * V: EFI_MEMORY_SP
          */
-        .EFI_memory_type_attr = is_pmem ? 2 : 1,
+        .EFI_memory_type_attr = flags ? 2 : 1,
         .DPA_offset = 0,
-        .DPA_length = memory_region_size(mr),
+        .DPA_length = size,
     };
 
     /* Header always at start of structure */
@@ -158,21 +159,28 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
     g_autofree CDATSubHeader **table = NULL;
     CXLType3Dev *ct3d = priv;
     MemoryRegion *volatile_mr = NULL, *nonvolatile_mr = NULL;
+    MemoryRegion *dc_mr = NULL;
     int dsmad_handle = 0;
     int cur_ent = 0;
     int len = 0;
     int rc, i;
+    uint64_t vmr_size = 0, pmr_size = 0;
 
-    if (!ct3d->hostpmem && !ct3d->hostvmem) {
+    if (!ct3d->hostpmem && !ct3d->hostvmem && !ct3d->dc.num_regions) {
         return 0;
     }
 
+    if (ct3d->hostpmem && ct3d->hostvmem && ct3d->dc.host_dc) {
+        warn_report("The device has static ram and pmem and dynamic capacity");
+    }
+
     if (ct3d->hostvmem) {
         volatile_mr = host_memory_backend_get_memory(ct3d->hostvmem);
         if (!volatile_mr) {
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        vmr_size = volatile_mr->size;
     }
 
     if (ct3d->hostpmem) {
@@ -181,6 +189,19 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
             return -EINVAL;
         }
         len += CT3_CDAT_NUM_ENTRIES;
+        pmr_size = nonvolatile_mr->size;
+    }
+
+    if (ct3d->dc.num_regions) {
+        if (ct3d->dc.host_dc) {
+            dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+            if (!dc_mr) {
+                return -EINVAL;
+            }
+            len += CT3_CDAT_NUM_ENTRIES * ct3d->dc.num_regions;
+        } else {
+            return -EINVAL;
+        }
     }
 
     table = g_malloc0(len * sizeof(*table));
@@ -190,8 +211,8 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 
     /* Now fill them in */
     if (volatile_mr) {
-        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++, volatile_mr,
-                                           false, 0);
+        rc = ct3_build_cdat_entries_for_mr(table, dsmad_handle++,
+                0, 0, vmr_size);
         if (rc < 0) {
             return rc;
         }
@@ -200,14 +221,37 @@ static int ct3_build_cdat_table(CDATSubHeader ***cdat_table, void *priv)
 
     if (nonvolatile_mr) {
         rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent]), dsmad_handle++,
-                                           nonvolatile_mr, true,
-                                           (volatile_mr ?
-                                            memory_region_size(volatile_mr) : 0));
+                CDAT_DSMAS_FLAG_NV, vmr_size, pmr_size);
         if (rc < 0) {
             goto error_cleanup;
         }
         cur_ent += CT3_CDAT_NUM_ENTRIES;
     }
+
+    if (dc_mr) {
+        uint64_t region_base = vmr_size + pmr_size;
+
+        /*
+         * Currently we create cdat entries for each region, should we only
+         * create dsmas table instead??
+         * We assume all dc regions are non-volatile for now.
+         *
+         */
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            rc = ct3_build_cdat_entries_for_mr(&(table[cur_ent])
+                    , dsmad_handle++
+                    , CDAT_DSMAS_FLAG_NV | CDAT_DSMAS_FLAG_DYNAMIC_CAP
+                    , region_base, ct3d->dc.regions[i].len);
+            if (rc < 0) {
+                goto error_cleanup;
+            }
+            ct3d->dc.regions[i].dsmadhandle = dsmad_handle - 1;
+
+            cur_ent += CT3_CDAT_NUM_ENTRIES;
+            region_base += ct3d->dc.regions[i].len;
+        }
+    }
+
     assert(len == cur_ent);
 
     *cdat_table = g_steal_pointer(&table);
@@ -435,11 +479,24 @@ static void build_dvsecs(CXLType3Dev *ct3d)
             range2_size_hi = ct3d->hostpmem->size >> 32;
             range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                              (ct3d->hostpmem->size & 0xF0000000);
+        } else if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
         }
-    } else {
+    } else if (ct3d->hostpmem) {
         range1_size_hi = ct3d->hostpmem->size >> 32;
         range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
                          (ct3d->hostpmem->size & 0xF0000000);
+        if (ct3d->dc.host_dc) {
+            range2_size_hi = ct3d->dc.host_dc->size >> 32;
+            range2_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+                             (ct3d->dc.host_dc->size & 0xF0000000);
+        }
+    } else {
+        range1_size_hi = ct3d->dc.host_dc->size >> 32;
+        range1_size_lo = (2 << 5) | (2 << 2) | 0x3 |
+            (ct3d->dc.host_dc->size & 0xF0000000);
     }
 
     dvsec = (uint8_t *)&(CXLDVSECDevice){
@@ -708,7 +765,8 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
 }
 
 /*
- * Create a dc region to test "Get Dynamic Capacity Configuration" command.
+ * Create dc regions.
+ * TODO: region parameters are hard coded, may need to change in the future.
  */
 static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 {
@@ -739,7 +797,8 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
 {
     DeviceState *ds = DEVICE(ct3d);
 
-    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem) {
+    if (!ct3d->hostmem && !ct3d->hostvmem && !ct3d->hostpmem
+            && !ct3d->dc.num_regions) {
         error_setg(errp, "at least one memdev property must be set");
         return false;
     } else if (ct3d->hostmem && ct3d->hostpmem) {
@@ -807,6 +866,50 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
         return false;
     }
 
+    ct3d->dc.total_capacity = 0;
+    if (ct3d->dc.host_dc) {
+        MemoryRegion *dc_mr;
+        char *dc_name;
+        uint64_t total_region_size = 0;
+        int i;
+
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        if (!dc_mr) {
+            error_setg(errp, "dynamic capacity must have backing device");
+            return false;
+        }
+        /* FIXME: set dc as nonvolatile for now */
+        memory_region_set_nonvolatile(dc_mr, true);
+        memory_region_set_enabled(dc_mr, true);
+        host_memory_backend_set_mapped(ct3d->dc.host_dc, true);
+        if (ds->id) {
+            dc_name = g_strdup_printf("cxl-dcd-dpa-dc-space:%s", ds->id);
+        } else {
+            dc_name = g_strdup("cxl-dcd-dpa-dc-space");
+        }
+        address_space_init(&ct3d->dc.host_dc_as, dc_mr, dc_name);
+
+        for (i = 0; i < ct3d->dc.num_regions; i++) {
+            total_region_size += ct3d->dc.regions[i].len;
+        }
+        /* Make sure the host backend is large enough to cover all dc range */
+        if (total_region_size > memory_region_size(dc_mr)) {
+            error_setg(errp,
+                "too small host backend size, increase to %lu MiB or more",
+                total_region_size / 1024 / 1024);
+            return false;
+        }
+
+        if (dc_mr->size % CXL_CAPACITY_MULTIPLIER != 0) {
+            error_setg(errp, "DC region size is unaligned to %lx",
+                    CXL_CAPACITY_MULTIPLIER);
+            return false;
+        }
+
+        ct3d->dc.total_capacity = total_region_size;
+        g_free(dc_name);
+    }
+
     return true;
 }
 
@@ -916,6 +1019,9 @@ err_release_cdat:
 err_free_special_ops:
     g_free(regs->special_ops);
 err_address_space_free:
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -935,6 +1041,9 @@ static void ct3_exit(PCIDevice *pci_dev)
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
+    if (ct3d->dc.host_dc) {
+        address_space_destroy(&ct3d->dc.host_dc_as);
+    }
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
@@ -999,16 +1108,24 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
                                        AddressSpace **as,
                                        uint64_t *dpa_offset)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
+    }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        /* Do we want dc_size to be dc_mr->size or not?? */
+        dc_size = ct3d->dc.total_capacity;
     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return -ENODEV;
     }
 
@@ -1016,19 +1133,19 @@ static int cxl_type3_hpa_to_as_and_dpa(CXLType3Dev *ct3d,
         return -EINVAL;
     }
 
-    if (*dpa_offset > ct3d->cxl_dstate.static_mem_size) {
+    if ((*dpa_offset >= vmr_size + pmr_size + dc_size) ||
+       (*dpa_offset >= vmr_size + pmr_size && ct3d->dc.num_regions == 0)) {
         return -EINVAL;
     }
 
-    if (vmr) {
-        if (*dpa_offset < memory_region_size(vmr)) {
-            *as = &ct3d->hostvmem_as;
-        } else {
-            *as = &ct3d->hostpmem_as;
-            *dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (*dpa_offset < vmr_size) {
+        *as = &ct3d->hostvmem_as;
+    } else if (*dpa_offset < vmr_size + pmr_size) {
         *as = &ct3d->hostpmem_as;
+        *dpa_offset -= vmr_size;
+    } else {
+        *as = &ct3d->dc.host_dc_as;
+        *dpa_offset -= (vmr_size + pmr_size);
     }
 
     return 0;
@@ -1095,6 +1212,8 @@ static Property ct3_props[] = {
     DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
     DEFINE_PROP_UINT16("spdm", CXLType3Dev, spdm_port, 0),
     DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
+    DEFINE_PROP_LINK("nonvolatile-dc-memdev", CXLType3Dev, dc.host_dc,
+                    TYPE_MEMORY_BACKEND, HostMemoryBackend *),
     DEFINE_PROP_END_OF_LIST(),
 };
 
@@ -1161,33 +1280,43 @@ static void set_lsa(CXLType3Dev *ct3d, const void *buf, uint64_t size,
 
 static bool set_cacheline(CXLType3Dev *ct3d, uint64_t dpa_offset, uint8_t *data)
 {
-    MemoryRegion *vmr = NULL, *pmr = NULL;
+    MemoryRegion *vmr = NULL, *pmr = NULL, *dc_mr = NULL;
     AddressSpace *as;
+    uint64_t vmr_size = 0, pmr_size = 0, dc_size = 0;
 
     if (ct3d->hostvmem) {
         vmr = host_memory_backend_get_memory(ct3d->hostvmem);
+        vmr_size = memory_region_size(vmr);
     }
     if (ct3d->hostpmem) {
         pmr = host_memory_backend_get_memory(ct3d->hostpmem);
+        pmr_size = memory_region_size(pmr);
     }
+    if (ct3d->dc.host_dc) {
+        dc_mr = host_memory_backend_get_memory(ct3d->dc.host_dc);
+        dc_size = ct3d->dc.total_capacity;
+     }
 
-    if (!vmr && !pmr) {
+    if (!vmr && !pmr && !dc_mr) {
         return false;
     }
 
-    if (dpa_offset + CXL_CACHE_LINE_SIZE > ct3d->cxl_dstate.static_mem_size) {
+    if (dpa_offset >= vmr_size + pmr_size + dc_size) {
+        return false;
+    }
+    if (dpa_offset + CXL_CACHE_LINE_SIZE >= vmr_size + pmr_size
+            && ct3d->dc.num_regions == 0) {
         return false;
     }
 
-    if (vmr) {
-        if (dpa_offset < memory_region_size(vmr)) {
-            as = &ct3d->hostvmem_as;
-        } else {
-            as = &ct3d->hostpmem_as;
-            dpa_offset -= memory_region_size(vmr);
-        }
-    } else {
+    if (dpa_offset < vmr_size) {
+        as = &ct3d->hostvmem_as;
+    } else if (dpa_offset < vmr_size + pmr_size) {
         as = &ct3d->hostpmem_as;
+        dpa_offset -= vmr->size;
+    } else {
+        as = &ct3d->dc.host_dc_as;
+        dpa_offset -= (vmr_size + pmr_size);
     }
 
     address_space_write(as, dpa_offset, MEMTXATTRS_UNSPECIFIED, &data,
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a32ee6d6ba..ddb24271a8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -426,6 +426,10 @@ struct CXLType3Dev {
     uint64_t poison_list_overflow_ts;
 
     struct dynamic_capacity {
+        HostMemoryBackend *host_dc;
+        AddressSpace host_dc_as;
+        uint64_t total_capacity; /* 256M aligned */
+
         uint8_t num_regions; /* 0-8 regions */
         struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
     } dc;
-- 
2.39.2

