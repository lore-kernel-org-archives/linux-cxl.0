Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F186C0015E
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjGTUio (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjGTUin (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:43 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2098.outbound.protection.outlook.com [40.92.107.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33FF22726
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mzM4xvm4gb/YGNflkXd59nN7/nMp5HR5A/+Yr1c1wPCAIXmwHuaw6zx5Fz2nrMhAKriFirvOomrLyPypcycaUKcM5yFYdeBtC2atddnzngSKYVkx6/fa4oTfnZBX9Sv1wliPmVcOAbJrpm/wlt3jiYeUmKszIMjyHdolXGWkyEJho9YBNImdUEB+oYY4sR32JuGgigEbLiv8+MGS5hHjQHgRES1SxorJpOox7ZOAQ8NQf5dG86Tm4Ef+/ZB2jkGT8G1yxF9ocrLCrmmZgp+TvgWtvs42ow4mKa3HPNciORSEgpEUlWwPKpTJXIrcEUhhcnctKpy59VwKNGcLyyRUxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xchX4tF+wgvfzrYJrYOEhfjyoDWDLGbRTx5w9dajLqU=;
 b=BMGggIrqB+FBi+gNw6QdMXOIHXBTrc0E1cO1RFvdDT5yTSi0kXaZ1l0opQX9/xizBQuk5eptw4mWdalel9O1Zw766EQJheYYLEDJBFrsbxYbP3EeFL8zyRU/b+naupWEHLNHj9ePJj4IKubNzT5yTApjqz1ejQwhM98oatemX5n7bGggi4DvmHQcM3FGcoufL/Ew+nKk+4DeH04Acm8U8UBijjcd/Mb371t8nQudpJ1lp+XegAO4ya+Jp5orYygih/f59t3eUNm2g0kOQy2odjFZXWrCqd0DRiLvDAu+XAssHvk8fGJ90YHzIAkm7SlbfyEGq9byVWd19wYIkL/fKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xchX4tF+wgvfzrYJrYOEhfjyoDWDLGbRTx5w9dajLqU=;
 b=P7X/lgo+cxZqg9shNWaEXBuYxP6h+93iXgTfXcJB/WW6/Hdk/C0TGGh0AO7oiw/YwcS+nSvxYdpPXxbtPgPbdrYqea7lrvSjLR8X+c+DZWDZRF8kQirQo6bSG6IJwMMEJUbsKA1crNCY1fWvM5VhcQeVv9nZP6fqY+b2CutwBitdAdTG07QlVBR6enDRcYEJMrJpGMPHJTNZSA8Nrn4DVI5XVEjkFxvPS4CsTCRqJ/pgc3fDM6tTeUG8cd3ydfYlCXtooL7yGlJ8rg3uU4iMcICl2vEe+yRyTPz8OUODENvS+X26yeS5VraZOCefVL9DFG6mGXCMfZ++XvuPBO95SQ==
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
Subject: [PATCH 6/9] hw/mem/cxl_type3: Add DC extent list representative and get DC extent list mailbox support
Date:   Thu, 20 Jul 2023 13:37:05 -0700
Message-ID: <SG2PR06MB33979E360C762512BCDF4173B23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [uVeTdj6vuyl39quOT07lJpFu7L+ffF0K]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-7-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: b3b6f487-3e13-464a-039e-08db89612f5d
X-MS-Exchange-SLBlob-MailProps: quCBMN2EvO/qzAKd82WE1LuLgf/v/GCyEduUCc1jlcU90pe+mvHZutQxPkLDk+gMaZSWh+3JH4erfU/KBdCUWUS1kWuF/TVTx7o39JDWEDhATrSyHm1bvTXc5FHTIOlfpJSHSuhuDN+5X6dbEJav/2DXhE25h/zumpkW4+cTpk5UZ8V1O9jw9qYWs7hFzWMc354jLhdeENOkFkvDbijgqb6B1RxmSuBJ/pa7umC4iB7wev8e63lnxvc835a7TAEKMty70O8lo41+e4xy1N0iTJ8nBNccbiM5g3diZcSFa6Vm7r68+2kS2SHq0tluYpCoIphXYcdCqHExE9zNFWf3X/GF+Lk1WCI81d5VwBnoPTNuDKTaZEyh40pIZWqiKsuFgq4KzQxII4J6CJvDuyjuPb1MQSp85NDYp0PHq+PbeidqI+PoorzXKRdi0WLzyzThXWWcmSf4oMGl2H+Pn5sS90PHRvQw7zG26mAyTpZpdW6yCBhwbiPpIRbfCCJB2HPlPk5n+cL7/hWUZfXw0MA5hACDZsIxlIAkGiUet9X7+RYdIpyuj+NP8cXJuFb2xrQvzIRTgdvsH+2Y3eEh8+ELbLMgj0oLjTSUyVpk2QYIy0dOmuVZrIlPiaXMqIZqiCe18Cp1WN0b90MxteE+N/OD52lKlK4u4HpQNmXHhP/6AL2DtgR05LbhdFJxrjaJrYu2BUzfl7bjuPRWUvsqQkFvfw==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bml133tPTVYts+cFHP5oz4sutaFfyJ40nadWmrvhCw2/qCFIbj5ZWBY9yy1vHTfXXH/PJxjqBvGeqLaWiq8bOZoZVe4mmFgerqkw0ZkePEzGQIaw5e7VX0g7w6A5unGsMJU525act5hCcbwH2HZZODJBL0GNm25ukLVtsAUOmKDzjlngJuBsW6sG2MgEYx3kiYlKm9S8W7xRTBEag3fqwrUVChs4mu19aMikXvwXD1szcBBPV3KG97/4+rqi2HYF384cU9EnQ7B6PBCsqZfIJ0WHweJCqU1xtCehzOVJvnZwdV7s/Eir/famBMtPUzCB7tb8IZcWL62TM6VochsfR+TI4V4MKAS4mp/EnugPFO7ONU2kAU76bQ69urZtcazPvT2K/VVwWBh6pi5k0yRdUj95g+nBwHmYeWMvCqayxm+p/ZX2AabNVMUnooZ6WqCEsNYDKp5myvss/Z9YT+yUypkAxJBK2eycTu6yGdn3i1aeE4fCex/0oJSduhCyIckmD8aT8awVnu0b8DT0m6Weu1COsAVDyk7cn4SKBZpjaugODfeh8RKeZHQY7BuKQXgm0Ied4tM0M335nul6Lriaw3X5vfZYwooSyly3R7+2Tg2FfjYhQT6OdCsCTzaJsBgH
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?veK6YQ3sGVJFybsQdWbgQ6oanVKvgy6PaOHvI+iPpk9TLR+moAUzi2+SI/lC?=
 =?us-ascii?Q?xNU3ic74f8Eh3cWkY0yLbCaS2Yx86JygzK2V7Ja3nNXJzbq06eFOwO7hxfpC?=
 =?us-ascii?Q?j7JD78uNIsuBSj/BJQJiTPTUtT3Z5GuP1eVa3RZWcPx4vH9oaQKfCgr9kcIM?=
 =?us-ascii?Q?5LBxcsiZB8dS1ozxow5BxVCVosNa0O4LS7p1tiUfFnvRYrk2X+OK/zIQ/t9u?=
 =?us-ascii?Q?KKU/nUbs7hkaetYNYxTwqO0T6JHwGdBxYCOvoskKEXxrN75KEpYBGLd1KODj?=
 =?us-ascii?Q?fdTXbVa7GfKirG90jdwDblFE2N3GICOMz2tlx4u0KvJBQBkta617funECThQ?=
 =?us-ascii?Q?G18XolhlkwXYDmnK36UlzqCXwwbGiG5AvE+BmLeljb7SvzKyvn59KUg3TOg2?=
 =?us-ascii?Q?DZDmYB3qL3hsV1IwbBnwqIQZvedYFF2NVtfww3VDgtFtJLEjBNPiHUan4e16?=
 =?us-ascii?Q?IryNrUmL1v62OgrC8yjD7i4VDNWSjsPqHqmOnat/DBIJdmoyyarvt4k7TTZ5?=
 =?us-ascii?Q?GMxKpJuFg2+gctKcBZ1Oi+wZDMxQi3qJLabK5rV7Fv/CvWOumS5Pma4XRAoW?=
 =?us-ascii?Q?U76uhEijKLgac0/3Jlx6wa67QtAs6qkwSrjk9AFDVUaVMnbpDRNzWj5bbqxH?=
 =?us-ascii?Q?xeOHyvJ2W+YlqaOej7mrEyz54ygZe2IZ4LEIn2DbU4y3eJnYDuDspP/RJ3q4?=
 =?us-ascii?Q?Pc4MkdEuq8I6G+PVj/m0w8BFopdWS2ixoEbP3hjWR9QHt3qpZxDoRqHBxBYM?=
 =?us-ascii?Q?mGy/0fqposR5I+CufVdzcHaXDkvQYgFn+3fZJBQczRJy1ELuUt/Mk86C1Xjk?=
 =?us-ascii?Q?sgL56mQWyX8msJJZ0Zwq4pplxXs1HSNX/iCPuKNFSp/P9F+RRjhBH9CjIqio?=
 =?us-ascii?Q?O6lBtEtdrGEgsHqerIYmcxWuVfcNJY3sPOj1Tirimzk6N0flj/KkVe6/h+4n?=
 =?us-ascii?Q?7hKSg7TZAZ2i3TpCGTvuqNIxCZxXbzqOLdbqDbrflQI6p3bKb1+rpstKJ+Ye?=
 =?us-ascii?Q?IAEJ2UVtvOl/0N0974tVvu3vUdLIpUwU0zt/mg0ya+MPkNo7hj0FLO3VEAH0?=
 =?us-ascii?Q?pabm5lmFRfCWD+nYMeDiGQGytigbHOQHea87gZfSa+bxllHkNrEGbEFBv3VB?=
 =?us-ascii?Q?oPg/1tczShdgGBP/sSfZjEgKsS/dLMs7FYdPyJvOBajLzCmfmiqbj/NKPRDg?=
 =?us-ascii?Q?s7Y/pxG6HmKpYEqhqdUNI8WD4M25lyzsRztdPw=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3b6f487-3e13-464a-039e-08db89612f5d
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:50.4786
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
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
     DCD_CONFIG  = 0x48, /*r3.0: 8.2.9.8.9*/
         #define GET_DC_CONFIG          0x0
+        #define GET_DYN_CAP_EXT_LIST   0x1
     PHYSICAL_SWITCH = 0x51
         #define IDENTIFY_SWITCH_DEVICE      0x0
 };
@@ -1018,6 +1019,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
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
+    struct get_dyn_cap_ext_list_in_pl *in = (void *)cmd->payload;
+    struct get_dyn_cap_ext_list_out_pl *out = (void *)cmd->payload;
+    struct CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev,
+            cxl_dstate);
+    uint16_t record_count = 0, i = 0, record_done = 0;
+    CXLDCDExtentList *extent_list = &ct3d->dc.extents;
+    CXLDCD_Extent *ent;
+    uint16_t out_pl_len;
+    uint32_t start_extent_id = in->start_extent_id;
+
+    if (start_extent_id > ct3d->dc.total_extent_count) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    record_count = MIN(in->extent_cnt,
+            ct3d->dc.total_extent_count - start_extent_id);
+
+    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
+    /* May need more processing here in the future */
+    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
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
+            stq_le_p(&out->records[record_done].start_dpa, ent->start_dpa);
+            stq_le_p(&out->records[record_done].len, ent->len);
+            memcpy(&out->records[record_done].tag, ent->tag, 0x10);
+            stw_le_p(&out->records[record_done].shared_seq, ent->shared_seq);
+            record_done++;
+            if (record_done == record_count) {
+                break;
+            }
+        }
+    }
+
+    *len = out_pl_len;
+    return CXL_MBOX_SUCCESS;
+}
+
 #define IMMEDIATE_CONFIG_CHANGE (1 << 1)
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
@@ -1058,6 +1126,9 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
     [DCD_CONFIG][GET_DC_CONFIG] = { "DCD_GET_DC_CONFIG",
         cmd_dcd_get_dyn_cap_config, 2, 0 },
+    [DCD_CONFIG][GET_DYN_CAP_EXT_LIST] = {
+        "DCD_GET_DYNAMIC_CAPACITY_EXTENT_LIST", cmd_dcd_get_dyn_cap_ext_list,
+        8, 0 },
 };
 
 static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index af1d919be3..608063ac52 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -789,6 +789,7 @@ static int cxl_create_dc_regions(CXLType3Dev *ct3d)
 
         region_base += region->len;
     }
+    QTAILQ_INIT(&ct3d->dc.extents);
 
     return 0;
 }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index ddb24271a8..a9cfe4e904 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -384,6 +384,25 @@ typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 
 #define DCD_MAX_REGION_NUM 8
 
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
 
         uint8_t num_regions; /* 0-8 regions */
         struct CXLDCD_Region regions[DCD_MAX_REGION_NUM];
+        CXLDCDExtentList extents;
+
+        uint32_t total_extent_count;
+        uint32_t ext_list_gen_seq;
     } dc;
 };
 
-- 
2.39.2

