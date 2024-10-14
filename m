Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029A233991
	for <linux-cxl@vger.kernel.org>; Mon, 14 Oct 2024 12:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728908502; cv=none; b=onH33VleJd6MwKQ4Q14oO050GBf+xXH4vwDvgxr+pU4P9wuQs+TJYlNe1dOgCEZnWRxmE6xHQX9lV41qog2BBgQIi7fQsfSWI6BwkD64Ti0gZByuwttOXfwCW39HZXJCuQ+CPhctIAqLWYVuaWhY+xVlaJDHeyYfpEF3sa16DU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728908502; c=relaxed/simple;
	bh=NRcVFrHsVg2YxtgAS3Yubg6On+OR7NiTLdO167FBhJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poWg46YPOIqR6ZhtsH/8LaNM5HCzlo0CzdM2TU8NxlfHv+97dfNsS7aD0e+grE2bAtDvrOvrFNiMJ6PMxLXxpV9ra4kFdxDv8LoCIXUSi1bptz2eEuU7ztfPOTgMoz+gCcEHCk+CQ+C4U/GMDxqHJ3jozyGsqHqhwHipg5yj+RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4XRxBX5353z6GBxp;
	Mon, 14 Oct 2024 20:20:04 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 25AF8140C72;
	Mon, 14 Oct 2024 20:21:39 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 frapeml500008.china.huawei.com (7.182.85.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 14 Oct 2024 14:21:38 +0200
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: Dmitry Frolov <frolov@swemel.ru>, Ajay Joshi <ajay.opensrc@micron.com>,
	Yao Xingtao <yaoxt.fnst@fujitsu.com>, Fan Ni <fan.ni@samsung.com>, Shiju Jose
	<shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>
Subject: [PATCH qemu 5/7] hw/cxl/cxl-mailbox-utils: Fix for device DDR5 ECS control feature tables
Date: Mon, 14 Oct 2024 13:19:00 +0100
Message-ID: <20241014121902.2146424-6-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
References: <20241014121902.2146424-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100005.china.huawei.com (7.191.160.25) To
 frapeml500008.china.huawei.com (7.182.85.71)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

ECS log capabilities field in following ECS tables, which is common for all
memory media FRUs in a CXL device.

Fix struct CXLMemECSReadAttrs and struct CXLMemECSWriteAttrs to make
log entry type field common.

Fixes: 2d41ce38fb9a ("hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature")
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 36 ++++++++++++++++++++++--------------
 hw/cxl/cxl-mailbox-utils.c  | 24 +++++++++---------------
 hw/mem/cxl_type3.c          |  9 ++++-----
 3 files changed, 35 insertions(+), 34 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e14e56ae4b..561b375dc8 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -463,18 +463,6 @@ typedef struct CXLMemPatrolScrubWriteAttrs {
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
@@ -483,6 +471,26 @@ typedef struct CXLMemECSWriteAttrs {
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
@@ -575,8 +583,8 @@ struct CXLType3Dev {
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
     /* ECS control attributes */
-    CXLMemECSReadAttrs ecs_attrs[CXL_ECS_NUM_MEDIA_FRUS];
-    CXLMemECSWriteAttrs ecs_wr_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+    CXLMemECSReadAttrs ecs_attrs;
+    CXLMemECSWriteAttrs ecs_wr_attrs;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 3a93966e77..67041f45d3 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1133,10 +1133,8 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
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
@@ -1204,13 +1202,10 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
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
@@ -1299,18 +1294,17 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
 
         ecs_set_feature = (void *)payload_in;
         ecs_write_attrs = ecs_set_feature->feat_data;
-        memcpy((uint8_t *)ct3d->ecs_wr_attrs + hdr->offset,
+        memcpy((uint8_t *)&ct3d->ecs_wr_attrs + hdr->offset,
                ecs_write_attrs,
                bytes_to_copy);
         set_feat_info->data_size += bytes_to_copy;
 
         if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
             data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->ecs_attrs.ecs_log_cap = ct3d->ecs_wr_attrs.ecs_log_cap;
             for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
-                ct3d->ecs_attrs[count].ecs_log_cap =
-                                  ct3d->ecs_wr_attrs[count].ecs_log_cap;
-                ct3d->ecs_attrs[count].ecs_config =
-                                  ct3d->ecs_wr_attrs[count].ecs_config & 0x1F;
+                ct3d->ecs_attrs.fru_attrs[count].ecs_config =
+                        ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
             }
         }
     } else {
@@ -1324,7 +1318,7 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
-            memset(ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+            memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6911d13fe6..5cf754b38f 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -920,16 +920,15 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
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
-- 
2.43.0

