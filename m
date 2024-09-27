Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAA882AD31
	for <linux-cxl@vger.kernel.org>; Fri, 27 Sep 2024 09:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727428703; cv=none; b=APOElswPzRrjeNl3TIHbI/bKS+TWbT/ihnjnmqVUnSd6wTxpPD9Tw4y3eDJjtzfihiRYAETt7RARkTIOg8Fee679VDZkO1zhunkof8WTs00R/Izor+vTscZk5GZ+iAZKJRFW7T5GMx6WHHFqgQawARwUi6kfPmh1m0agY+eiFVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727428703; c=relaxed/simple;
	bh=aseFo++Fmx/0FG22KhInRVuPTUW5EBqkoorXjZDHR3w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oh7R9XGL/0cj1e4OtZ/0Kpt5kNYSHbPk+X0aSwxcxGRwikYhEdXZ+zEkaqMXYAg9Pp2cZ8+0NxZHJNFHucvHotaXJadg7Zg9UoNKX5NQUKm40BtvzpJ+M3lhBt9X0L6LF/ZjZcLyZyV1lv79PuwcDWi/1G0BDzeCHzKQ3RG4eMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XFPxm648gz6GC7b;
	Fri, 27 Sep 2024 17:17:32 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id B5ADC140DE5;
	Fri, 27 Sep 2024 17:18:10 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.146.180) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 11:18:10 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <dave@stgolabs.net>, <fan.ni@samsung.com>, <jonathan.cameron@huawei.com>,
	<linuxarm@huawei.com>, <prime.zeng@hisilicon.com>, <tanxiaofei@huawei.com>,
	<shiju.jose@huawei.com>
Subject: [PATCH 1/1] hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS control feature tables
Date: Fri, 27 Sep 2024 10:17:43 +0100
Message-ID: <20240927091743.965-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

ECS log capabilities field in following ECS tables, which is common for all
memory media FRUs in a CXL device.

Fix struct CXLMemECSReadAttrs and struct CXLMemECSWriteAttrs to make
log entry type field common.

Fixes:2d41ce38fb9a (hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature)
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 27 ++++++++++-----------------
 hw/mem/cxl_type3.c          |  9 ++++-----
 include/hw/cxl/cxl_device.h | 36 ++++++++++++++++++++++--------------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c2d776bc96..fa06cd7910 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1152,10 +1152,8 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                          (struct CXLSupportedFeatureEntry) {
                 .uuid = ecs_uuid,
                 .feat_index = index,
-                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
-                                    sizeof(CXLMemECSReadAttrs),
-                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
-                                    sizeof(CXLMemECSWriteAttrs),
+                .get_feat_size = sizeof(CXLMemECSReadAttrs),
+                .set_feat_size = sizeof(CXLMemECSWriteAttrs),
                 .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
                 .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
                 .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
@@ -1223,13 +1221,10 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
                (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
                bytes_to_copy);
     } else if (qemu_uuid_is_equal(&get_feature->uuid, &ecs_uuid)) {
-        if (get_feature->offset >=  CXL_ECS_NUM_MEDIA_FRUS *
-                                sizeof(CXLMemECSReadAttrs)) {
+        if (get_feature->offset >= sizeof(CXLMemECSReadAttrs)) {
             return CXL_MBOX_INVALID_INPUT;
         }
-        bytes_to_copy = CXL_ECS_NUM_MEDIA_FRUS *
-                        sizeof(CXLMemECSReadAttrs) -
-                            get_feature->offset;
+        bytes_to_copy = sizeof(CXLMemECSReadAttrs) - get_feature->offset;
         bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
         memcpy(payload_out,
                (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
@@ -1318,19 +1313,17 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ecs_set_feature = (void *)payload_in;
         ecs_write_attrs = ecs_set_feature->feat_data;
-        memcpy((uint8_t *)ct3d->ecs_wr_attrs + hdr->offset,
+        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
                ecs_write_attrs,
                bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
-            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
-                ct3d->ecs_attrs[count].ecs_log_cap =
-                                  ct3d->ecs_wr_attrs[count].ecs_log_cap;
-                ct3d->ecs_attrs[count].ecs_config =
-                                  ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
-            }
+            ct3d->ecs_attrs.ecs_log_cap = ct3d->ecs_wr_attrs.ecs_log_cap;
+            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++)
+                ct3d->ecs_attrs.fru_attrs[count].ecs_config =
+                        ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
         }
     } else {
         return CXL_MBOX_UNSUPPORTED;
@@ -1343,7 +1336,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
-            memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 3006ca21ad..e10de42254 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1045,16 +1045,15 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
 
     /* Set default value for DDR5 ECS read attributes */
+    ct3d->ecs_attrs.ecs_log_cap = CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
     for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
-        ct3d->ecs_attrs[count].ecs_log_cap =
-                            CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
-        ct3d->ecs_attrs[count].ecs_cap =
+        ct3d->ecs_attrs.fru_attrs[count].ecs_cap =
                             CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
-        ct3d->ecs_attrs[count].ecs_config =
+        ct3d->ecs_attrs.fru_attrs[count].ecs_config =
                             CXL_ECS_THRESHOLD_COUNT_DEFAULT |
                             (CXL_ECS_MODE_DEFAULT << 3);
         /* Reserved */
-        ct3d->ecs_attrs[count].ecs_flags = 0;
+        ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
     return;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 4b68c52cdc..076eb9814a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -493,18 +493,6 @@ typedef struct CXLMemPatrolScrubWriteAttrs {
 #define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
 
 /* CXL memory device DDR5 ECS control attributes */
-typedef struct CXLMemECSReadAttrs {
-        uint8_t ecs_log_cap;
-        uint8_t ecs_cap;
-        uint16_t ecs_config;
-        uint8_t ecs_flags;
-} QEMU_PACKED CXLMemECSReadAttrs;
-
-typedef struct CXLMemECSWriteAttrs {
-   uint8_t ecs_log_cap;
-    uint16_t ecs_config;
-} QEMU_PACKED CXLMemECSWriteAttrs;
-
 #define CXL_ECS_GET_FEATURE_VERSION    0x01
 #define CXL_ECS_SET_FEATURE_VERSION    0x01
 #define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
@@ -513,6 +501,26 @@ typedef struct CXLMemECSWriteAttrs {
 #define CXL_ECS_MODE_DEFAULT    0
 #define CXL_ECS_NUM_MEDIA_FRUS   3 /* Default */
 
+typedef struct CXLMemECSFRUReadAttrs {
+    uint8_t ecs_cap;
+    uint16_t ecs_config;
+    uint8_t ecs_flags;
+} QEMU_PACKED CXLMemECSFRUReadAttrs;
+
+typedef struct CXLMemECSReadAttrs {
+    uint8_t ecs_log_cap;
+    CXLMemECSFRUReadAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+} QEMU_PACKED CXLMemECSReadAttrs;
+
+typedef struct CXLMemECSFRUWriteAttrs {
+    uint16_t ecs_config;
+} QEMU_PACKED CXLMemECSFRUWriteAttrs;
+
+typedef struct CXLMemECSWriteAttrs {
+    uint8_t ecs_log_cap;
+    CXLMemECSFRUWriteAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+} QEMU_PACKED CXLMemECSWriteAttrs;
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -609,8 +617,8 @@ struct CXLType3Dev {
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
     /* ECS control attributes */
-    CXLMemECSReadAttrs ecs_attrs[CXL_ECS_NUM_MEDIA_FRUS];
-    CXLMemECSWriteAttrs ecs_wr_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+    CXLMemECSReadAttrs ecs_attrs;
+    CXLMemECSWriteAttrs ecs_wr_attrs;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
-- 
2.34.1

