Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9083237704
	for <linux-cxl@vger.kernel.org>; Mon, 19 Feb 2024 15:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708354848; cv=none; b=Ff0BRRjw1B5/1OTcPJ4qzQISKj+g6hY6mfoAntNqpckRv9O3MfjkF4YCICS7jgwt6p2Zp0Ng1GXkH9IVFSddjANKQ1UcCO/ipjTZ4FZluNHXRx1tLkVCR9P4zvxxVnq6rfI9zIDSvJrInlucilcp95MOKLnKzbVibp4JUwjAPrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708354848; c=relaxed/simple;
	bh=noSnqdHqNdI5Fk7y0xqE6Y5T+l6U1dq+ilpT1LW0kng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbaz/tVVe+QPK0WrnDuRXcIUtu9jnAB2riw1PpSsi0ZYiPQY2jjVm5snZVAZSlcgujWeJGa6UHMx91ERJth8S/TDiprrftP0lBr5pRTwGrC2+cNDGtrlDjJHJa0AF9dobjSzN5tVvRln9lLgk6K7j8+fGeEsjBS7GjPeSm8clkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdlxB3TM2z6K5ZX;
	Mon, 19 Feb 2024 22:56:46 +0800 (CST)
Received: from lhrpeml500006.china.huawei.com (unknown [7.191.161.198])
	by mail.maildlp.com (Postfix) with ESMTPS id 31A08141B49;
	Mon, 19 Feb 2024 23:00:43 +0800 (CST)
Received: from SecurePC30232.china.huawei.com (10.122.247.234) by
 lhrpeml500006.china.huawei.com (7.191.161.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 19 Feb 2024 15:00:42 +0000
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>
CC: <jonathan.cameron@huawei.com>, <tanxiaofei@huawei.com>,
	<prime.zeng@hisilicon.com>, <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v4 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
Date: Mon, 19 Feb 2024 23:00:24 +0800
Message-ID: <20240219150025.1531-3-shiju.jose@huawei.com>
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

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c | 97 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 96 insertions(+), 1 deletion(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 779ce80e3c..908ce16642 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -997,6 +997,7 @@ typedef struct CXLSupportedFeatureEntry {
 } QEMU_PACKED CXLSupportedFeatureEntry;
 
 enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_MAX
 };
 
@@ -1037,6 +1038,38 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
     CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
 };
 
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
+typedef struct CXLMemPatrolScrubReadAttrs {
+        uint8_t scrub_cycle_cap;
+        uint16_t scrub_cycle;
+        uint8_t scrub_flags;
+} QEMU_PACKED CXLMemPatrolScrubReadAttrs;
+
+typedef struct CXLMemPatrolScrubWriteAttrs {
+    uint8_t scrub_cycle_hr;
+    uint8_t scrub_flags;
+} QEMU_PACKED CXLMemPatrolScrubWriteAttrs;
+
+typedef struct CXLMemPatrolScrubSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemPatrolScrubWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
+static CXLMemPatrolScrubReadAttrs cxl_memdev_ps_feat_attrs;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1060,7 +1093,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     uint16_t feat_entries = 0;
 
     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
-        get_feats_in->start_index > CXL_FEATURE_MAX) {
+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
         return CXL_MBOX_INVALID_INPUT;
     }
     req_entries = (get_feats_in->count -
@@ -1072,6 +1105,31 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     entry = 0;
     while (entry < req_entries) {
         switch (index) {
+        case  CXL_FEATURE_PATROL_SCRUB:
+            /* Fill supported feature entry for device patrol scrub control */
+            get_feats_out->feat_entries[entry] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = patrol_scrub_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemPatrolScrubReadAttrs),
+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrs),
+                /* Bit[0] : 1, feature attributes changeable */
+                .attr_flags = 0x1,
+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
+                .set_feat_effects = 0,
+            };
+            feat_entries++;
+            /* Set default value for device patrol scrub read attributes */
+            cxl_memdev_ps_feat_attrs.scrub_cycle_cap =
+                                CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
+                                CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
+            cxl_memdev_ps_feat_attrs.scrub_cycle =
+                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
+                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
+            cxl_memdev_ps_feat_attrs.scrub_flags =
+                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
+            break;
         default:
             break;
         }
@@ -1112,6 +1170,20 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
+    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemPatrolScrubReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemPatrolScrubReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               &cxl_memdev_ps_feat_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     *len_out = bytes_to_copy;
 
     return CXL_MBOX_SUCCESS;
@@ -1125,6 +1197,29 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            size_t *len_out,
                                            CXLCCI *cci)
 {
+    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
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
+        ps_write_attrs = &ps_set_feature->feat_data;
+        cxl_memdev_ps_feat_attrs.scrub_cycle &= ~0xFF;
+        cxl_memdev_ps_feat_attrs.scrub_cycle |=
+                          ps_write_attrs->scrub_cycle_hr & 0xFF;
+        cxl_memdev_ps_feat_attrs.scrub_flags &= ~0x1;
+        cxl_memdev_ps_feat_attrs.scrub_flags |=
+                          ps_write_attrs->scrub_flags & 0x1;
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     return CXL_MBOX_SUCCESS;
 }
 
-- 
2.34.1

