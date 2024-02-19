Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF66237705
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354848; cv=none; b=uRIQXEfLbJGHsHy0407rGS5ZM5NYY54k38ITMZtd/3DeE3mzrnSey6bphsb7V2NqV9U6kpZMjwv4T9RGldcc6Tci/n+fDA04jnODF3TEla+3B9ulFjuJ1qRUboFxE2FwrjjD3X5TpIwCT+yYX6ToXPqVpsPW8ejv/XiJ5G4UWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354848; c=relaxed/simple;
	bh=OnTR2rAkI3hha5nkw0sjHjnM/WBxzcz6CCfnIBMZLSw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fWDDsF32RzXkAOYAJXmxdGNSv4lmE/fz749FFQvD87yjJCiN2pXFGyH5SmkVDjElsPChPOmVaxFfRdIDQ8daLtVBlPVMK/QYL1X4rlbUMWna6ZkM/tgPd/Yr0ZBcsGbalj4Zl3RHyUr6QYXKBQBamSQ27NTwP9M8vWYQ7ZESjfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Tdlws1bxGz6D8W0;
	Mon, 19 Feb 2024 22:56:29 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 8AF57140B38;
	Mon, 19 Feb 2024 23:00:43 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 15:00:43 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature
Date: Mon, 19 Feb 2024 23:00:25 +0800
Message-ID: <20240219150025.1531-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240219150025.1531-1-shiju.jose@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
 lhrpeml500006.china.huawei.com (7.191.161.198)

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
control feature.

The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
Specification (JESD79-5) and allows the DRAM to internally read, correct
single-bit errors, and write back corrected data bits to the DRAM array
while providing transparency to error counts. The ECS control feature
allows the request to configure ECS input configurations during system
boot or at run-time.

The ECS control allows the requester to change the log entry type, the ECS
threshold count provided that the request is within the definition
specified in DDR5 mode registers, change mode between codeword mode and
row count mode, and reset the ECS counter.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 100 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 908ce16642..2277418c07 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -998,6 +998,7 @@ typedef struct CXLSupportedFeatureEntry {
 
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
+    CXL_FEATURE_ECS,
     CXL_FEATURE_MAX
 };
 
@@ -1070,6 +1071,43 @@ typedef struct CXLMemPatrolScrubSetFeature {
 } QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
 static CXLMemPatrolScrubReadAttrs cxl_memdev_ps_feat_attrs;
 
+/*
+ * CXL r3.1 section 8.2.9.9.11.2:
+ * DDR5 Error Check Scrub (ECS) Control Feature
+ */
+static const QemuUUID ecs_uuid = {
+    .data = UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
+                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86)
+};
+
+#define CXL_ECS_GET_FEATURE_VERSION    0x01
+#define CXL_ECS_SET_FEATURE_VERSION    0x01
+#define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
+#define CXL_ECS_REALTIME_REPORT_CAP_DEFAULT    1
+#define CXL_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5: 4096 */
+#define CXL_ECS_MODE_DEFAULT    0
+
+#define CXL_ECS_NUM_MEDIA_FRUS   3
+
+/* CXL memdev DDR5 ECS control attributes */
+typedef struct CXLMemECSReadAttrs {
+        uint8_t ecs_log_cap;
+        uint8_t ecs_cap;
+        uint16_t ecs_config;
+        uint8_t ecs_flags;
+} QEMU_PACKED CXLMemECSReadAttrs;
+
+typedef struct CXLMemECSWriteAttrs {
+    uint8_t ecs_log_cap;
+    uint16_t ecs_config;
+} QEMU_PACKED CXLMemECSWriteAttrs;
+
+typedef struct CXLMemECSSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemECSWriteAttrs feat_data[];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemECSSetFeature;
+static CXLMemECSReadAttrs cxl_ecs_feat_attrs[CXL_ECS_NUM_MEDIA_FRUS];
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1088,7 +1126,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
         CXLSupportedFeatureHeader hdr;
         CXLSupportedFeatureEntry feat_entries[];
     } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
-    uint16_t index;
+    uint16_t count, index;
     uint16_t entry, req_entries;
     uint16_t feat_entries = 0;
 
@@ -1130,6 +1168,35 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
             cxl_memdev_ps_feat_attrs.scrub_flags =
                                 CXL_MEMDEV_PS_ENABLE_DEFAULT;
             break;
+        case  CXL_FEATURE_ECS:
+            /* Fill supported feature entry for device DDR5 ECS control */
+            get_feats_out->feat_entries[entry] =
+                         (struct CXLSupportedFeatureEntry) {
+                .uuid = ecs_uuid,
+                .feat_index = index,
+                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLMemECSReadAttrs),
+                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLMemECSWriteAttrs),
+                .attr_flags = 0x1,
+                .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+            /* Set default value for DDR5 ECS read attributes */
+            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
+                cxl_ecs_feat_attrs[count].ecs_log_cap =
+                                    CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
+                cxl_ecs_feat_attrs[count].ecs_cap =
+                                    CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
+                cxl_ecs_feat_attrs[count].ecs_config =
+                                    CXL_ECS_THRESHOLD_COUNT_DEFAULT |
+                                    (CXL_ECS_MODE_DEFAULT << 3);
+                /* Reserved */
+                cxl_ecs_feat_attrs[count].ecs_flags = 0;
+            }
+            break;
         default:
             break;
         }
@@ -1180,6 +1247,18 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                &cxl_memdev_ps_feat_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &ecs_uuid)) {
+        if (get_feature->offset >=  CXL_ECS_NUM_MEDIA_FRUS *
+                                sizeof(CXLMemECSReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = CXL_ECS_NUM_MEDIA_FRUS *
+                        sizeof(CXLMemECSReadAttrs) -
+                            get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               &cxl_ecs_feat_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1197,8 +1276,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            size_t *len_out,
                                            CXLCCI *cci)
 {
+    uint16_t count;
     CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
+    CXLMemECSWriteAttrs *ecs_write_attrs;
     CXLMemPatrolScrubSetFeature *ps_set_feature;
+    CXLMemECSSetFeature *ecs_set_feature;
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
 
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
@@ -1216,6 +1298,22 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         cxl_memdev_ps_feat_attrs.scrub_flags &= ~0x1;
         cxl_memdev_ps_feat_attrs.scrub_flags |=
                           ps_write_attrs->scrub_flags & 0x1;
+    } else if (qemu_uuid_is_equal(&hdr->uuid,
+                                  &ecs_uuid)) {
+        if (hdr->version != CXL_ECS_SET_FEATURE_VERSION ||
+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ecs_set_feature = (void *)payload_in;
+        ecs_write_attrs = ecs_set_feature->feat_data;
+        for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
+                cxl_ecs_feat_attrs[count].ecs_log_cap =
+                                  ecs_write_attrs[count].ecs_log_cap;
+                cxl_ecs_feat_attrs[count].ecs_config =
+                                  ecs_write_attrs[count].ecs_config & 0x1F;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
-- 
2.34.1

