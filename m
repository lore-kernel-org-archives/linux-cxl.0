Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1D0A12C7E0
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994955; cv=none; b=PIFqys3AfYak8b7/sDnnEFTJcHNj2t0K/KWA8zgPd45P21jK+kAStI5qyiBLl5zdutMXh0LlXtsXapVETab4ZSGGvXid1YHfJan8HTXgrt8am2dq6T3pGfDnFuS8dO1xHtzGQyEZo/JZGk6QB40fLHIz20IqjaxWN4KrtLTUPbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994955; c=relaxed/simple;
	bh=2bHkvvEUZbLLtUgot+znOm86qA7JHoUesV/3BP4bK9w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eeFT0ewXG+zK25iQIzOf2nAUFtcRIx90l+PyUQTCStrKboXgj/vyJliennew7KuTuWLT48OCtT+Ye9FXAGYg+305/xalcz2q9I2ezKfFlHzYv54Lxdp/k8KBEvvcrYKv/vOYXxW51CcFUTvQBEacLnI3jh5X0kIA4Fsso5Ole1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbBrP2pS3z67lbN;
	Thu, 15 Feb 2024 18:58:45 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id B39311400D4;
	Thu, 15 Feb 2024 19:02:29 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:02:29 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS control feature
Date: Thu, 15 Feb 2024 19:01:46 +0800
Message-ID: <20240215110146.1444-4-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20240215110146.1444-1-shiju.jose@huawei.com>
References: <20240215110146.1444-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 100 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 9557c38dd9..a14eee9ff5 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -998,6 +998,7 @@ typedef struct CXLSupportedFeatureEntry {
 
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
+    CXL_FEATURE_DDR5_ECS,
     CXL_FEATURE_MAX
 };
 
@@ -1069,6 +1070,42 @@ typedef struct CXLMemPatrolScrubSetFeature {
         CXLMemPatrolScrubWriteAttrbs feat_data;
 } QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
 
+/*
+ * CXL r3.1 section 8.2.9.9.11.2:
+ * DDR5 Error Check Scrub (ECS) Control Feature
+ */
+static const QemuUUID ddr5_ecs_uuid = {
+    .data = UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
+                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86)
+};
+
+#define CXL_DDR5_ECS_GET_FEATURE_VERSION    0x01
+#define CXL_DDR5_ECS_SET_FEATURE_VERSION    0x01
+#define CXL_DDR5_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
+#define CXL_DDR5_ECS_REALTIME_REPORT_CAP_DEFAULT    1
+#define CXL_DDR5_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5: 4096 */
+#define CXL_DDR5_ECS_MODE_DEFAULT    0
+
+#define CXL_DDR5_ECS_NUM_MEDIA_FRUS   3
+
+/* CXL memdev DDR5 ECS control attributes */
+struct CXLMemECSReadAttrbs {
+        uint8_t ecs_log_cap;
+        uint8_t ecs_cap;
+        uint16_t ecs_config;
+        uint8_t ecs_flags;
+} QEMU_PACKED cxl_ddr5_ecs_feat_read_attrbs[CXL_DDR5_ECS_NUM_MEDIA_FRUS];
+
+typedef struct CXLDDR5ECSWriteAttrbs {
+    uint8_t ecs_log_cap;
+    uint16_t ecs_config;
+} QEMU_PACKED CXLDDR5ECSWriteAttrbs;
+
+typedef struct CXLDDR5ECSSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLDDR5ECSWriteAttrbs feat_data[];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLDDR5ECSSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1087,7 +1124,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
         CXLSupportedFeatureHeader hdr;
         CXLSupportedFeatureEntry feat_entries[];
     } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
-    uint16_t index;
+    uint16_t count, index;
     uint16_t entry, req_entries;
     uint16_t feat_entries = 0;
 
@@ -1129,6 +1166,35 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
             cxl_memdev_ps_feat_read_attrbs.scrub_flags =
                                 CXL_MEMDEV_PS_ENABLE_DEFAULT;
             break;
+        case  CXL_FEATURE_DDR5_ECS:
+            /* Fill supported feature entry for device DDR5 ECS control */
+            get_feats_out->feat_entries[entry] =
+                         (struct CXLSupportedFeatureEntry) {
+                .uuid = ddr5_ecs_uuid,
+                .feat_index = index,
+                .get_feat_size = CXL_DDR5_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(struct CXLMemECSReadAttrbs),
+                .set_feat_size = CXL_DDR5_ECS_NUM_MEDIA_FRUS *
+                                    sizeof(CXLDDR5ECSWriteAttrbs),
+                .attrb_flags = 0x1,
+                .get_feat_version = CXL_DDR5_ECS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_DDR5_ECS_SET_FEATURE_VERSION,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+            /* Set default value for DDR5 ECS read attributes */
+            for (count = 0; count < CXL_DDR5_ECS_NUM_MEDIA_FRUS; count++) {
+                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_log_cap =
+                                    CXL_DDR5_ECS_LOG_ENTRY_TYPE_DEFAULT;
+                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_cap =
+                                    CXL_DDR5_ECS_REALTIME_REPORT_CAP_DEFAULT;
+                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_config =
+                                    CXL_DDR5_ECS_THRESHOLD_COUNT_DEFAULT |
+                                    (CXL_DDR5_ECS_MODE_DEFAULT << 3);
+                /* Reserved */
+                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_flags = 0;
+            }
+            break;
         default:
             break;
         }
@@ -1180,6 +1246,19 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &ddr5_ecs_uuid)) {
+        if (get_feature->offset >=  CXL_DDR5_ECS_NUM_MEDIA_FRUS *
+                                sizeof(struct CXLMemECSReadAttrbs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = CXL_DDR5_ECS_NUM_MEDIA_FRUS *
+                        sizeof(struct CXLMemECSReadAttrbs) -
+                                     get_feature->offset;
+        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
+                                    get_feature->count : bytes_to_copy;
+        memcpy(payload_out,
+               &cxl_ddr5_ecs_feat_read_attrbs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1197,8 +1276,11 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            size_t *len_out,
                                            CXLCCI *cci)
 {
+    uint16_t count;
     CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
+    CXLDDR5ECSWriteAttrbs *ecs_write_attrbs;
     CXLMemPatrolScrubSetFeature *ps_set_feature;
+    CXLDDR5ECSSetFeature *ecs_set_feature;
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
 
     if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
@@ -1216,6 +1298,22 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
         cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
         cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
                           ps_write_attrbs->scrub_flags & 0x1;
+    } else if (qemu_uuid_is_equal(&hdr->uuid,
+                                  &ddr5_ecs_uuid)) {
+        if (hdr->version != CXL_DDR5_ECS_SET_FEATURE_VERSION ||
+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ecs_set_feature = (void *)payload_in;
+        ecs_write_attrbs = ecs_set_feature->feat_data;
+        for (count = 0; count < CXL_DDR5_ECS_NUM_MEDIA_FRUS; count++) {
+                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_log_cap =
+                                  ecs_write_attrbs[count].ecs_log_cap;
+                cxl_ddr5_ecs_feat_read_attrbs[count].ecs_config =
+                                  ecs_write_attrbs[count].ecs_config & 0x1F;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
-- 
2.34.1

