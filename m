Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 700CEC001DE
	for <linux-cxl@archiver.kernel.org>; Thu, 20 Jul 2023 20:38:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229756AbjGTUiq (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 20 Jul 2023 16:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbjGTUip (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Thu, 20 Jul 2023 16:38:45 -0400
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01olkn2098.outbound.protection.outlook.com [40.92.107.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8B6C271D
        for <linux-cxl@vger.kernel.org>; Thu, 20 Jul 2023 13:38:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EXsOOlTNpA/ZeR0I3v8+6Jw2brL6uHwo/GcACLJwTHyGDDGCAf2563B3dG9+HXeBaENWAEwXsIFxy1G5n02bvLBydANGZ8GZuC9mZsmMMWFVkVfrvQqFG+GkutONccQFr1jbfKko/ysO6A027uSLtutFgyB55CdN+knY0kJRghBWnKdXvFmhf4uO7GWkVlMeEvFKat60ORctu9PCf0ixrngLmD3pO51LMXNsJ3/5xjEZw8odBleHX0Vlb+RrqyMbe9XhaK8BKyR56JczsiTY5C6DT9KrdTzGp9hpZfWKOB7kqhRR2P++2hJVo5c1/fsDakB0ctCl19XCi/ZEYm1ctQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=90ziaoiq/m1HqxdkBxLqRSdvriBHEYoBvHYlkoDeh9w=;
 b=Fvhu8FBEjUhahIqtdfHY212EC/OeVUVv32Q9muCm2iGlWpiqaE9ci5h1b6lQagK+bt3LBw2HUfIWq1ibrbM85zlMGl4qe+1Eufnarw198yIk4zMcQn++PLvHtN4VBGNhUcoyj4ygPtH96pTbTLhvwo0ncULEOdhkGFT7y1y/laYpdbrIv/oXM9lqhEQt88EYsuHsfpsRdQUlkTDP+eugvykfXfuB/PbiJAGRzGphcaA741P4CuRYhN2fDNsGilOTYs/iQ+06kLZTmp9ubYZ0EoISMVJasneZw+t3rLbiTymXrMM+wfN9NYbpDMZxuiVn23m6MXNyGYGb942e1vP8VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=90ziaoiq/m1HqxdkBxLqRSdvriBHEYoBvHYlkoDeh9w=;
 b=Dp7/TMj6vMd5jtVoPscejXsxksTJ74+YgGYioypcejFLgevsBkKoxX7dChTv5grY2f4MsGkbKsuIzZQE0/EGdgnvwj2pJxOoVz41H6ScXlPf2T0yVhiO3xvwucgCf2aG+VqBC3T9C8yQjzgG3CZk6PlgykX1NmyY0Ze1sUclfKfDekXR/lKem0v/SZIHpO8OXzy6arzjmfmV/vtRNEaWNvZy3oSPujV5fdK1PE9yUUUnOIb+FaGpSqzClCRZqjweCaotgpBMjjV6zKeKUUPxMo8KomgE4WOXlp5bkUREHW+kffuZg+x6+Cd1919gGdqX8lHpGdusAnU6a+cA5p9D/w==
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
Subject: [PATCH 8/9] hw/cxl/events: Add qmp interfaces to add/release dynamic capacity extents
Date:   Thu, 20 Jul 2023 13:37:07 -0700
Message-ID: <SG2PR06MB339733D0FD518A13F890FF4CB23EA@SG2PR06MB3397.apcprd06.prod.outlook.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230720203708.25825-1-nifan@outlook.com>
References: <20230720203708.25825-1-nifan@outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [cBjt15ghAnLmumpRyfOUEfEoZ/IRdx0e]
X-ClientProxiedBy: BYAPR03CA0008.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::21) To SG2PR06MB3397.apcprd06.prod.outlook.com
 (2603:1096:4:7a::17)
X-Microsoft-Original-Message-ID: <20230720203708.25825-9-nifan@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PR06MB3397:EE_|KL1PR0601MB4100:EE_
X-MS-Office365-Filtering-Correlation-Id: 49369720-3f38-4618-cf7a-08db896133ac
X-MS-Exchange-SLBlob-MailProps: 9IecXKUgicAYce+YIvRqgnoEwnxu+bmn3AnhMUBFieGGYFasq7+cboh4s0BhU5+qsNgpAtEX6OQgrM1lYwnUY24pe+3hp8xjWJHT8yTZsJugHJmY0mcHfegb1kgjAC36bm+248XTz9nKDcnIWYIoSjQ+C7LYFDkGQZz0f3dnecnr0FfsmRiivvSHep9HiGTffaGhKcFnBmiBv6jW+oSh/KJ/qWb8Z8GadYleMHBswNW3aw9tDuHRUShfznCqF9kVyh0Xtn/pyskQb9xiSf+F5rbQpT7F+MMdWEInqCqbkKrCbQxDvq3ln1qiVOaTyf/ZNh3VcJf+ti+bp3lMKqKoSpTBZUr3iKbrAfQeVNWxfIM+hJaO3EFzIzluoQyFYK4zX8XEn8DfgPS2NKLvZy8XwJXQAMRtAiDd9PfNxQXUj5u12DyOiecLTnzfnd2P9o557qFxsAuf+5oqxBZveDfOt3+QVdt0aEuh6Qg2oBv22Jn0M47uYGpLtUnPovSQzj8Erunm61+KqmJKuhpb6Yg+vR8lqJTDIFoFxKhi/VHYwnQp6m65rAmregfkYZ72qReMjt2W+Tx05QRlyRVLB3n5FxcRMAuCPi62odm0NlFZXf2PQ8DNbSOgSOtQiLmBlJju7FjT9FcaP9n7BErIr62ylPl6iwgMWU5cDPO20LgePQDH0DKzuiaUJlXfTfkGM4I0RJGX/FzCSh/j8v5DML8isadNKFirHCDx3iEX/gnAmgmnUYo2l/4JZQ==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GX8hUyrarleUkGK+z6nrNtiK+STf6OdleQqVb8tG/6dlCg2wYQLRDvk9bmB9nEigNK7LVD61qyfaP/FGlP+X4B4TA5mAFvQ44Ut3shobx6YUV+P6vMfe4p1dkzVW+QPcCFbjkugGhfqKP2mnThSMGdkb/qOs+QCALhcLMC+tdwdRT4USkf0jNeMrTggiDCMa5v615riWmP4rUaxue0ZyruxECaJn3bhX7zKFYSXTgGiJrnL5Su4GZx50oqWtIjix0XhbDkkOvh3r4ojoC2zAFNom4jvyCyRadbPbg03pEPXiK9sTGmNzeKTPo39QVxK+OmSRbcxWgITScUc9MxJfTM2Ija+5pNCghczyM9P+JLmd3+EiOW5JjnuFNw34qaHVaeJ8c9nZXf9s0b3j7KWAhPavdsGj+SNxFXS8foYcbg0PNUY/rw2bPp1CqIpoUvRVLrLb37IF7H4hzByJIJi5gfDaqcquaWMXRxbetC9xdTWQ27XD57RCmYtpmjZIKL3taGLGASL7ncJTESjs6fixnN983vpMMHGt0akiRuikbOVdmo4Pp44jC5Slal323ZNxQ6tYqbeVRM/Wx/yjNau+x7b4JfYVHqkw9Mca3cBkY5UADBY30hLVH01FgWK0XFL5
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LH5nTTj5nt6bgCJNrnLCBhW/5Lf4JZTqNAMuiUBaclIpeMFeuMP4gDtNKGBg?=
 =?us-ascii?Q?OBEr60udtSyN7HlC/NYqL15vFH7Z5WefavD6cXRbH2WQcGbnP9pXffhUqk8I?=
 =?us-ascii?Q?BQuvzqPoyM3vNqWf1MfhmNzCGUJcjbqyRestyaMxmvr93Zo4p0VI6bMB8X43?=
 =?us-ascii?Q?fY2p+3vlIAtfwRCNSkpPrPsLFBzkzsLB5VnnpdF/vKZZbh77wo2Ra8w8WxG5?=
 =?us-ascii?Q?v8Si3LFhkLGN1HW5Disp/5kbY8cJ8kQEy0B1xBdSGamFnZeuKGreu02XHOdA?=
 =?us-ascii?Q?2qa8IqmRP8CRbFT5LstpW79pNKDcJOyglqX+5/ymIjtVqPUFrlbDACvFS2jt?=
 =?us-ascii?Q?gbi4A26QAJ2QXAnEG5AAp2rUqcHbgZoD92lxqIJKLDRrwTlqudyZKjinc5J+?=
 =?us-ascii?Q?IL4YFfCCSxlHAbRpayVdL5HdqxTWWnWk+3vhy3AiWpNYXtf6rV/KlyzJk3at?=
 =?us-ascii?Q?E0gHCSvO6/iWJdb+Y9YWRr5asQn+rnId7aIm2q/5VHOZqMhjNVCQ2u4FUPW7?=
 =?us-ascii?Q?37PCwz1VHtK7Y5D+zey6JQv7Q70cJ4WLULYsYpikZz6ROY7u5hGtC4dyJjuD?=
 =?us-ascii?Q?yR1sG7+skujfDPTQivS8cOwnjaxg/wyig3sG1xp5lnPDQTSHel9co9txzQQY?=
 =?us-ascii?Q?8V21SvNf5eL9ogsLe3LMFSb/8mXbxepLc6VxTHo3hQ4AXJOiIi6QCx1evzO5?=
 =?us-ascii?Q?9X2r6D87iKGRiOJjkAjtKajaY8wYaMMnQtn1R9Xd8XrNPpNuPeyRi1S01Ceh?=
 =?us-ascii?Q?1k5IHQv0e7c3jlK1rZte979jy6zQWS8gZTjFGkNC6xbYp+92gX870omArcul?=
 =?us-ascii?Q?16yvqh0UhlCdFceM5kyWLsO4icQFlv2KhT0UoVoQKx07qHQ8UH+TH9ngst48?=
 =?us-ascii?Q?/YOxUKFCAmqlXHFIjGvMslhfVMSwPj+bL+gy6DpWM2ZJhMRsXXSk4RttjGJv?=
 =?us-ascii?Q?M5N+rcGOOZo/8uGaed+OsRTpD2ySu81uEeo1JUclxgLF/c7bURbpgZONaIn7?=
 =?us-ascii?Q?BSKrf2F1M7KKvCcb0pYAUR0hrr+K/6/19dVHDVDnh+o31fyanHpVt2Pga4bJ?=
 =?us-ascii?Q?7EXE3nW0LysZyWx0TqtIi/u+rZ+9A+1FHmxgTa6hgoKO+GbZo07WShofHzyh?=
 =?us-ascii?Q?ohDlGYQ/L/l0dxHJoVxs4g4ZW4guIi9e9dvOYZ0rVbf12zkdbHig9xcPSXWk?=
 =?us-ascii?Q?QuksSkCieyOyoJarrXjrt7rdGKUBmwDt+n247A=3D=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49369720-3f38-4618-cf7a-08db896133ac
X-MS-Exchange-CrossTenant-AuthSource: SG2PR06MB3397.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2023 20:37:57.7587
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0601MB4100
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Fan Ni <nifan@outlook.com>

Since fabric manager emulation is not supported yet, the change implements
the functions to add/release dynamic capacity extents as QMP interfaces.

1. Add dynamic capacity extents:

For example, the command to add two continuous extents (each is 128MB long)
to region 0 (starting at dpa offset 0 and 128MB) looks like below:

{ "execute": "qmp_capabilities" }

{ "execute": "cxl-add-dynamic-capacity-event",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "extents": [
      {
          "region-id": 0,
          "dpa": 0,
          "len": 128
      },
      {
          "region-id": 0,
          "dpa": 128,
          "len": 128
      }
      ]
  }
}

2. Release dynamic capacity extents:

For example, the command to release an extent of size 128MB from region 0
(starting at dpa offset 128MB) look like below:

{ "execute": "cxl-release-dynamic-capacity-event",
  "arguments": {
      "path": "/machine/peripheral/cxl-dcd0",
      "extents": [
      {
          "region-id": 0,
          "dpa": 128,
          "len": 128
      }
      ]
  }
}

Signed-off-by: Fan Ni <fan.ni@samsung.com>
---
 hw/mem/cxl_type3.c          | 145 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3_stubs.c    |   6 ++
 include/hw/cxl/cxl_events.h |  16 ++++
 qapi/cxl.json               |  49 ++++++++++++
 4 files changed, 216 insertions(+)

diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 608063ac52..cb1f9182e6 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1811,6 +1811,151 @@ void qmp_cxl_inject_memory_module_event(const char *path, CxlEventLog log,
     }
 }
 
+static const QemuUUID dynamic_capacity_uuid = {
+    .data = UUID(0xca95afa7, 0xf183, 0x4018, 0x8c, 0x2f,
+            0x95, 0x26, 0x8e, 0x10, 0x1a, 0x2a),
+};
+
+/*
+ * cxl r3.0: Table 8-47
+ * 00h: add capacity
+ * 01h: release capacity
+ * 02h: forced capacity release
+ * 03h: region configuration updated
+ * 04h: Add capacity response
+ * 05h: capacity released
+ */
+enum DC_Event_Type {
+    DC_EVENT_ADD_CAPACITY,
+    DC_EVENT_RELEASE_CAPACITY,
+    DC_EVENT_FORCED_RELEASE_CAPACITY,
+    DC_EVENT_REGION_CONFIG_UPDATED,
+    DC_EVENT_ADD_CAPACITY_RSP,
+    DC_EVENT_CAPACITY_RELEASED,
+    DC_EVENT_NUM
+};
+
+#define MEM_BLK_SIZE_MB 128
+static void qmp_cxl_process_dynamic_capacity_event(const char *path,
+        CxlEventLog log, enum DC_Event_Type type,
+        uint16_t hid, CXLDCExtentRecordList *records, Error **errp)
+{
+    Object *obj = object_resolve_path(path, NULL);
+    CXLEventDynamicCapacity dCap;
+    CXLEventRecordHdr *hdr = &dCap.hdr;
+    CXLDeviceState *cxlds;
+    CXLType3Dev *dcd;
+    uint8_t flags = 1 << CXL_EVENT_TYPE_INFO;
+    uint32_t num_extents = 0;
+    CXLDCExtentRecordList *list = records;
+    CXLDCExtent_raw *extents;
+    uint64_t dpa, len;
+    uint8_t rid;
+    int i;
+
+    if (!obj) {
+        error_setg(errp, "Unable to resolve path");
+        return;
+    }
+    if (!object_dynamic_cast(obj, TYPE_CXL_TYPE3)) {
+        error_setg(errp, "Path not point to a valid CXL type3 device");
+        return;
+    }
+
+    dcd = CXL_TYPE3(obj);
+    cxlds = &dcd->cxl_dstate;
+    memset(&dCap, 0, sizeof(dCap));
+
+    if (!dcd->dc.num_regions) {
+        error_setg(errp, "No dynamic capacity support from the device");
+        return;
+    }
+
+    while (list) {
+        dpa = list->value->dpa * 1024 * 1024;
+        len = list->value->len * 1024 * 1024;
+        rid = list->value->region_id;
+
+        if (rid >= dcd->dc.num_regions) {
+            error_setg(errp, "region id is too large");
+            return;
+        }
+
+        if (dpa % dcd->dc.regions[rid].block_size
+                || len % dcd->dc.regions[rid].block_size) {
+            error_setg(errp, "dpa or len is not aligned to region block size");
+            return;
+        }
+
+        if (dpa + len > dcd->dc.regions[rid].decode_len * 256 * 1024 * 1024) {
+            error_setg(errp, "extent range is beyond the region end");
+            return;
+        }
+
+        num_extents++;
+        list = list->next;
+    }
+
+    i = 0;
+    list = records;
+    extents = g_new0(CXLDCExtent_raw, num_extents);
+    while (list) {
+        dpa = list->value->dpa * 1024 * 1024;
+        len = list->value->len * 1024 * 1024;
+        rid = list->value->region_id;
+
+        extents[i].start_dpa = dpa + dcd->dc.regions[rid].base;
+        extents[i].len = len;
+        memset(extents[i].tag, 0, 0x10);
+        extents[i].shared_seq = 0;
+
+        list = list->next;
+        i++;
+    }
+
+    /*
+     * 8.2.9.1.5
+     * All Dynamic Capacity event records shall set the Event Record
+     * Severity field in the Common Event Record Format to Informational
+     * Event. All Dynamic Capacity related events shall be logged in the
+     * Dynamic Capacity Event Log.
+     */
+    cxl_assign_event_header(hdr, &dynamic_capacity_uuid, flags, sizeof(dCap),
+            cxl_device_get_timestamp(&dcd->cxl_dstate));
+
+    dCap.type = type;
+    stw_le_p(&dCap.host_id, hid);
+    /* only valid for DC_REGION_CONFIG_UPDATED event */
+    dCap.updated_region_id = rid;
+    for (i = 0; i < num_extents; i++) {
+        memcpy(&dCap.dynamic_capacity_extent, &extents[i]
+                , sizeof(CXLDCExtent_raw));
+
+        if (cxl_event_insert(cxlds, CXL_EVENT_TYPE_DYNAMIC_CAP,
+                    (CXLEventRecordRaw *)&dCap)) {
+            cxl_event_irq_assert(dcd);
+        }
+    }
+
+    g_free(extents);
+}
+
+void qmp_cxl_add_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records,
+        Error **errp)
+{
+   qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
+           DC_EVENT_ADD_CAPACITY, 0, records, errp);
+}
+
+void qmp_cxl_release_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records,
+        Error **errp)
+{
+    qmp_cxl_process_dynamic_capacity_event(path, CXL_EVENT_LOG_INFORMATIONAL,
+            DC_EVENT_RELEASE_CAPACITY, 0, records, errp);
+}
+
 static void ct3_class_init(ObjectClass *oc, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(oc);
diff --git a/hw/mem/cxl_type3_stubs.c b/hw/mem/cxl_type3_stubs.c
index f3e4a9fa72..482229f3bd 100644
--- a/hw/mem/cxl_type3_stubs.c
+++ b/hw/mem/cxl_type3_stubs.c
@@ -56,3 +56,9 @@ void qmp_cxl_inject_correctable_error(const char *path, CxlCorErrorType type,
 {
     error_setg(errp, "CXL Type 3 support is not compiled in");
 }
+
+void qmp_cxl_add_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records, Error **errp) {}
+
+void qmp_cxl_release_dynamic_capacity_event(const char *path,
+        struct CXLDCExtentRecordList  *records, Error **errp) {}
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 089ba2091f..3baf745f8d 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -165,4 +165,20 @@ typedef struct CXLEventMemoryModule {
     uint8_t reserved[0x3d];
 } QEMU_PACKED CXLEventMemoryModule;
 
+/*
+ * Dynamic Capacity Event Record
+ * CXL Rev 3.0 Section 8.2.9.2.1.5: Table 8-47
+ * All fields little endian.
+ */
+typedef struct CXLEventDynamicCapacity {
+    CXLEventRecordHdr hdr;
+    uint8_t type;
+    uint8_t reserved1;
+    uint16_t host_id;
+    uint8_t updated_region_id;
+    uint8_t reserved2[3];
+    uint8_t dynamic_capacity_extent[0x28]; /* defined in cxl_device.h */
+    uint8_t reserved[0x20];
+} QEMU_PACKED CXLEventDynamicCapacity;
+
 #endif /* CXL_EVENTS_H */
diff --git a/qapi/cxl.json b/qapi/cxl.json
index 05c560cfe5..fb04ec4c41 100644
--- a/qapi/cxl.json
+++ b/qapi/cxl.json
@@ -369,3 +369,52 @@
 ##
 {'command': 'cxl-inject-correctable-error',
  'data': {'path': 'str', 'type': 'CxlCorErrorType'}}
+
+##
+# @CXLDCExtentRecord:
+#
+# Record of a single extent to add/release
+#
+# @region-id: id of the region where the extent to add/release
+# @dpa: start dpa (in MiB) of the extent, related to region base address
+# @len: extent size (in MiB)
+#
+# Since: 8.0
+##
+{ 'struct': 'CXLDCExtentRecord',
+  'data': {
+      'region-id': 'uint8',
+      'dpa':'uint64',
+      'len': 'uint64'
+  }
+}
+
+##
+# @cxl-add-dynamic-capacity-event:
+#
+# Command to add dynamic capacity extent event
+#
+# @path: CXL DCD canonical QOM path
+# @extents: Extents to add
+#
+##
+{ 'command': 'cxl-add-dynamic-capacity-event',
+  'data': { 'path': 'str',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
+
+##
+# @cxl-release-dynamic-capacity-event:
+#
+# Command to release dynamic capacity extent event
+#
+# @path: CXL DCD canonical QOM path
+# @extents: Extents to release
+#
+##
+{ 'command': 'cxl-release-dynamic-capacity-event',
+  'data': { 'path': 'str',
+            'extents': [ 'CXLDCExtentRecord' ]
+           }
+}
-- 
2.39.2

