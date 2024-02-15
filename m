Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D55128806
	for <linux-cxl@vger.kernel.org>; Thu, 15 Feb 2024 11:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707994955; cv=none; b=qQJe2FiVc/UxXCbfAg/XTwRQGQk6VSnSew5j34gRASKCKDyzipIm3RyUwduFxySO52cS7evQI5qd3ugmbcAj5Jq933hfQLUJcXdPqrjTqh8LUDrEB5bfmHgl0F2NxxGBgRDTuwToMg3K2/ivzGC8/FX1XLUCBk2tduAOYcoRYBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707994955; c=relaxed/simple;
	bh=y3g2bO1jONyBoRNC/NA6efl/+wYk4C7CV+l+fGQ/BWg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q1r+uRQ8CrvlP6OgnOYUOMP9n2E1NAYZcjXKc0AvAduZsLQ0pfu0ktJo1frKlLftWm2J8YnHvPAiiHAy4tCt5AA1NXBTmDJ7FwXf5k/MjLR1QFPOztywgonNkifsadc+9NQ6HpQ+b6W0rMXfDw/RMJlKhjeQY7CnhFS1bBv2sIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TbBrj3Xd9z6K8tP;
	Thu, 15 Feb 2024 18:59:01 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 0C54B141F5D;
	Thu, 15 Feb 2024 19:02:29 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 15 Feb 2024 11:02:28 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v3 1/3] hw/cxl/cxl-mailbox-utils: Add support for feature commands (8.2.9.6)
Date: Thu, 15 Feb 2024 19:01:44 +0800
Message-ID: <20240215110146.1444-2-shiju.jose@huawei.com>
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

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
Get Supported Features retrieves the list of supported device specific
features. The settings of a feature can be retrieved using Get Feature and
optionally modified using Set Feature.

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 175 +++++++++++++++++++++++++++++++++++++
 1 file changed, 175 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 80a80f1ec2..f761ac49b5 100644
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
@@ -965,6 +969,165 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.6: Features */
+/*
+ * Get Supported Features output payload
+ * CXL r3.1 section 8.2.9.6.1 Table 8-96
+ */
+typedef struct CXLSupportedFeatureHeader {
+    uint16_t entries;
+    uint16_t nsuppfeats_dev;
+    uint32_t reserved;
+} QEMU_PACKED CXLSupportedFeatureHeader;
+
+/*
+ * Get Supported Features Supported Feature Entry
+ * CXL r3.1 section 8.2.9.6.1 Table 8-97
+ */
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
+/* Get Feature CXL 3.1 Spec 8.2.9.6.2 */
+/*
+ * Get Feature input payload
+ * CXL r3.1 section 8.2.9.6.2 Table 8-99
+ */
+/* Get Feature : Payload in selection */
+enum CXL_GET_FEATURE_SELECTION {
+    CXL_GET_FEATURE_SEL_CURRENT_VALUE,
+    CXL_GET_FEATURE_SEL_DEFAULT_VALUE,
+    CXL_GET_FEATURE_SEL_SAVED_VALUE,
+    CXL_GET_FEATURE_SEL_MAX
+};
+
+/* Set Feature CXL 3.1 Spec 8.2.9.6.3 */
+/*
+ * Set Feature input payload
+ * CXL r3.1 section 8.2.9.6.3 Table 8-101
+ */
+typedef struct CXLSetFeatureInHeader {
+        QemuUUID uuid;
+        uint32_t flags;
+        uint16_t offset;
+        uint8_t version;
+        uint8_t rsvd[9];
+} QEMU_PACKED QEMU_ALIGNED(16) CXLSetFeatureInHeader;
+
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK   0x7
+enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
+    CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_INITIATE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_CONTINUE_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER,
+    CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
+};
+
+/* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
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
+    } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
+    uint16_t index;
+    uint16_t entry, req_entries;
+    uint16_t feat_entries = 0;
+
+    if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
+        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+    req_entries = (get_feats_in->count -
+                   sizeof(CXLSupportedFeatureHeader)) /
+                   sizeof(CXLSupportedFeatureEntry);
+    req_entries = MIN(req_entries, CXL_FEATURE_MAX);
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
+    get_feats_out->hdr.nsuppfeats_dev = CXL_FEATURE_MAX;
+    get_feats_out->hdr.entries = feat_entries;
+    *len_out = sizeof(CXLSupportedFeatureHeader) +
+                      feat_entries * sizeof(CXLSupportedFeatureEntry);
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.2: Get Feature (Opcode 0501h) */
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
+    if (get_feature->selection != CXL_GET_FEATURE_SEL_CURRENT_VALUE) {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+    if (get_feature->offset + get_feature->count > cci->payload_max) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    *len_out = bytes_to_copy;
+
+    return CXL_MBOX_SUCCESS;
+}
+
+/* CXL r3.1 section 8.2.9.6.3: Set Feature (Opcode 0502h) */
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
 /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -2166,6 +2329,18 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported,
                               0, 0 },
     [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
+    [FEATURES][GET_SUPPORTED] = { "FEATURES_GET_SUPPORTED",
+                                  cmd_features_get_supported, 0x8, 0 },
+    [FEATURES][GET_FEATURE] = { "FEATURES_GET_FEATURE",
+                                cmd_features_get_feature, 0x15, 0 },
+    [FEATURES][SET_FEATURE] = { "FEATURES_SET_FEATURE",
+                                cmd_features_set_feature,
+                                ~0,
+                                (CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
+                                 CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                                 CXL_MBOX_SECURITY_STATE_CHANGE)},
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
-- 
2.34.1

