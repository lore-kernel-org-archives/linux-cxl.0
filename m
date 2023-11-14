Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC6BF3D961
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EAB13A
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 04:47:18 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5Z85qdCz6K6KW;
	Tue, 14 Nov 2023 20:43:28 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:47:16 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
Date: Tue, 14 Nov 2023 20:47:10 +0800
Message-ID: <20231114124711.1128-3-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.35.1.windows.2
In-Reply-To: <20231114124711.1128-1-shiju.jose@huawei.com>
References: <20231114124711.1128-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.122.247.234]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500006.china.huawei.com (7.191.161.198)
X-CFilter-Loop: Reflected

From: Shiju Jose <shiju.jose@huawei.com>

CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
feature. The device patrol scrub proactively locates and makes corrections
to errors in regular cycle. The patrol scrub control allows the request to
configure patrol scrub input configurations.

The patrol scrub control allows the requester to specify the number of
hours for which the patrol scrub cycles must be completed, provided that
the requested number is not less than the minimum number of hours for the
patrol scrub cycle that the device is capable of. In addition, the patrol
scrub controls allow the host to disable and enable the feature in case
disabling of the feature is needed for other purposes such as
performance-aware operations which require the background operations to be
turned off.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 98 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 93960afd44..6ab3e74059 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {
 } QEMU_PACKED CXLSupportedFeatureEntry;
 
 enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_MAX
 };
 
@@ -827,6 +828,38 @@ typedef struct CXLSetFeatureInHeader {
 #define CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER    3
 #define CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER    4
 
+
+/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
+static const QemuUUID patrol_scrub_uuid = {
+    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
+                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
+};
+
+#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
+#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
+#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
+#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
+#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
+
+/* CXL memdev patrol scrub control attributes */
+struct CXLMemPatrolScrubReadAttrbs {
+        uint8_t scrub_cycle_cap;
+        uint16_t scrub_cycle;
+        uint8_t scrub_flags;
+} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
+
+typedef struct CXLMemPatrolScrubWriteAttrbs {
+    uint8_t scrub_cycle_hr;
+    uint8_t scrub_flags;
+} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
+
+typedef struct CXLMemPatrolScrubSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemPatrolScrubWriteAttrbs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
+
 /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -850,7 +883,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     uint16_t feat_entries = 0;
 
     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
-        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
         return CXL_MBOX_INVALID_INPUT;
     } else {
         req_entries = (get_feats_in->count -
@@ -866,6 +899,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     entry = 0;
     while (entry < req_entries) {
         switch (index) {
+        case  CXL_FEATURE_PATROL_SCRUB:
+            /* Fill supported feature entry for device patrol scrub control */
+            supported_feats->feat_entries[entry] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = patrol_scrub_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
+                /* Bit[0] : 1, feature attributes changable */
+                .attrb_flags = 0x1,
+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+            /* Set default value for device patrol scrub read attributes */
+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
+                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
+                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
+            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
+                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
+                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
+            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
+                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
+            break;
         default:
             break;
         }
@@ -902,6 +960,21 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
+        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
+                                             get_feature->offset;
+        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
+                               get_feature->count : bytes_to_copy;
+        memcpy(payload_out,
+               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
+               bytes_to_copy);
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     *len_out = bytes_to_copy;
 
     return CXL_MBOX_SUCCESS;
@@ -915,6 +988,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            size_t *len_out,
                                            CXLCCI *cci)
 {
+    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
+    CXLMemPatrolScrubSetFeature *ps_set_feature;
+    CXLSetFeatureInHeader *hdr = (void *)payload_in;
+
+    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
+            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
+                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ps_set_feature = (void *)payload_in;
+        ps_write_attrbs = &ps_set_feature->feat_data;
+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
+        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
+                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
+        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
+        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
+                          ps_write_attrbs->scrub_flags & 0x1;
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     return CXL_MBOX_SUCCESS;
 }
 
-- 
2.34.1

