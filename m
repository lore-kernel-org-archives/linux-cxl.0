Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC676374E5
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 12:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87F0B189
	for <linux-cxl@vger.kernel.org>; Tue, 14 Nov 2023 04:47:18 -0800 (PST)
Received: from lhrpeml500006.china.huawei.com (unknown [172.18.147.200])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4SV5Z84BKNz6K6S1;
	Tue, 14 Nov 2023 20:43:28 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Tue, 14 Nov 2023 12:47:16 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [RFC PATCH 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
Date: Tue, 14 Nov 2023 20:47:09 +0800
Message-ID: <20231114124711.1128-2-shiju.jose@huawei.com>
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

CXL spec 3.0 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature and
optionally modified using Set Feature.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 140 +++++++++++++++++++++++++++++++++++++
 1 file changed, 140 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 6184f44339..93960afd44 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -66,6 +66,10 @@ enum {
     LOGS        = 0x04,
         #define GET_SUPPORTED 0x0
         #define GET_LOG       0x1
+    FEATURES    = 0x05,
+        #define GET_SUPPORTED 0x0
+        #define GET_FEATURE   0x1
+        #define SET_FEATURE   0x2
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -785,6 +789,135 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.0 section 8.2.9.6: Features */
+typedef struct CXLSupportedFeatureHeader {
+    uint16_t entries;
+    uint16_t nsuppfeats_dev;
+    uint32_t reserved;
+} QEMU_PACKED CXLSupportedFeatureHeader;
+
+typedef struct CXLSupportedFeatureEntry {
+    QemuUUID uuid;
+    uint16_t feat_index;
+    uint16_t get_feat_size;
+    uint16_t set_feat_size;
+    uint32_t attrb_flags;
+    uint8_t get_feat_version;
+    uint8_t set_feat_version;
+    uint16_t set_feat_effects;
+    uint8_t rsvd[18];
+} QEMU_PACKED CXLSupportedFeatureEntry;
+
+enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_MAX
+};
+
+typedef struct CXLSetFeatureInHeader {
+        QemuUUID uuid;
+        uint32_t flags;
+        uint16_t offset;
+        uint8_t version;
+        uint8_t rsvd[9];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
+
+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
+#define CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER    0
+#define CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER    1
+#define CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER    2
+#define CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER    3
+#define CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER    4
+
+/* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
+static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
+                                             uint8_t *payload_in,
+                                             size_t len_in,
+                                             uint8_t *payload_out,
+                                             size_t *len_out,
+                                             CXLCCI *cci)
+{
+    struct {
+        uint32_t count;
+        uint16_t start_index;
+        uint16_t reserved;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_in = (void *)payload_in;
+
+    struct {
+        CXLSupportedFeatureHeader hdr;
+        CXLSupportedFeatureEntry feat_entries[];
+    } QEMU_PACKED QEMU_ALIGNED(16) * supported_feats = (void *)payload_out;
+    uint16_t index;
+    uint16_t entry, req_entries;
+    uint16_t feat_entries = 0;
+
+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
+        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    } else {
+        req_entries = (get_feats_in->count -
+                        sizeof(CXLSupportedFeatureHeader)) /
+                        sizeof(CXLSupportedFeatureEntry);
+    }
+    if (req_entries > CXL_FEATURE_MAX) {
+        req_entries = CXL_FEATURE_MAX;
+    }
+    supported_feats->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
+    index = get_feats_in->start_index;
+
+    entry = 0;
+    while (entry < req_entries) {
+        switch (index) {
+        default:
+            break;
+        }
+        index++;
+        entry++;
+    }
+
+    supported_feats->hdr.entries = feat_entries;
+    *len_out = sizeof(CXLSupportedFeatureHeader) +
+                      feat_entries * sizeof(CXLSupportedFeatureEntry);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.0 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
+static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    struct {
+        QemuUUID uuid;
+        uint16_t offset;
+        uint16_t count;
+        uint8_t selection;
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feature;
+    uint16_t bytes_to_copy = 0;
+
+    get_feature = (void *)payload_in;
+
+    if (get_feature->offset + get_feature->count > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    *len_out = bytes_to_copy;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.0 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
+static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.5.1.1 */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1954,6 +2087,13 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
+                                  cmd_features_get_supported, 0x8, 0 },
+    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
+                                cmd_features_get_feature, 0x15, 0 },
+    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
+                                cmd_features_set_feature,
+                                ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
-- 
2.34.1

