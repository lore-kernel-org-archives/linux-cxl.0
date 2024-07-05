Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E5A381E
	for <linux-cxl@vger.kernel.org>; Fri,  5 Jul 2024 12:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720182737; cv=none; b=amPIZBPpriAOLosi0VfzMFgHOFMR4L59rI83QooSELfRaNbYB/gnJ7Bc8U/kdkVPVtChYHQO2Z5Z+MBga2cFs/cuaQGVN1gof85880koIoYG9ALsUk6wtu+0O2/FZ3/xXgPWNZhRt7x3kvyBh4155GFBxzP11b2KzlbMqLdYea4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720182737; c=relaxed/simple;
	bh=mcUbcN98llNeFBX+y9EtQTU8EOyuhv2uvw33Hq/FFGE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Oft7UVFc7kPNUlAFWe0JRAo45tENRbL3Jrml/5HEU4piOpMbNlEMUITB+riAQITg8aCmJ3z7jXBj9S3iHdYnVUixWSFs5Mu15yQcS0YdaDkw+G98jiXel6SUG9q6m1EwduR0xWc6U1aW3pUXVsnGa/uZan0aHysmDG5khsNSf5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFtCp1LF2z6K62N;
	Fri,  5 Jul 2024 20:31:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 467421400D3;
	Fri,  5 Jul 2024 20:32:12 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.19.247) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 13:32:11 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <linux-cxl@vger.kernel.org>, <mst@redhat.com>, <qemu-devel@nongnu.org>
CC: <shiju.jose@huawei.com>, Gregory Price <gregory.price@memverge.com>,
	<linuxarm@huawei.com>
Subject: [PATCH v6 3/4] hw/cxl/cxl-mailbox-utils: Add device patrol scrub control feature
Date: Fri, 5 Jul 2024 13:30:37 +0100
Message-ID: <20240705123039.963781-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
References: <20240705123039.963781-1-Jonathan.Cameron@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

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
Link: https://lore.kernel.org/r/20240223085902.1549-3-shiju.jose@huawei.com
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 24 +++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 79 ++++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3.c          |  9 +++++
 3 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 48ed0d9240..2c1df25453 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -427,6 +427,26 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+/* CXL memory device patrol scrub control attributes */
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
+#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
+#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT    BIT(1)
+#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
+#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
+#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -511,6 +531,10 @@ struct CXLType3Dev {
 
     CXLSetFeatureInfo set_feat_info;
 
+    /* Patrol scrub control attributes */
+    CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
+    CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
+
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
         AddressSpace host_dc_as;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 5c4424d8fe..5f95771acf 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -829,6 +829,7 @@ typedef struct CXLSupportedFeatureEntry {
 #define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_CXL_RESET BIT(11)
 
 enum CXL_SUPPORTED_FEATURES_LIST {
+    CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_MAX
 };
 
@@ -870,6 +871,17 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
 };
 #define CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET BIT(3)
 
+/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
+static const QemuUUID patrol_scrub_uuid = {
+    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
+                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a)
+};
+
+typedef struct CXLMemPatrolScrubSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemPatrolScrubWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -895,11 +907,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
         return CXL_MBOX_UNSUPPORTED;
     }
     if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
-        /*
-         * Temporary: suppress compiler error due to unsigned
-         * comparioson to zero.
-         */
-        true /*get_feats_in->start_index >= CXL_FEATURE_MAX*/) {
+        get_feats_in->start_index >= CXL_FEATURE_MAX) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -912,6 +920,21 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     for (entry = 0, index = get_feats_in->start_index;
          entry < req_entries; index++) {
         switch (index) {
+        case  CXL_FEATURE_PATROL_SCRUB:
+            /* Fill supported feature entry for device patrol scrub control */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = patrol_scrub_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemPatrolScrubReadAttrs),
+                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE,
+                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         default:
             __builtin_unreachable();
         }
@@ -961,6 +984,20 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
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
+               (uint8_t *)&ct3d->patrol_scrub_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
+
     *len_out = bytes_to_copy;
 
     return CXL_MBOX_SUCCESS;
@@ -975,7 +1012,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                                            CXLCCI *cci)
 {
     CXLSetFeatureInHeader *hdr = (void *)payload_in;
+    CXLMemPatrolScrubWriteAttrs *ps_write_attrs;
+    CXLMemPatrolScrubSetFeature *ps_set_feature;
     CXLSetFeatureInfo *set_feat_info;
+    uint16_t bytes_to_copy = 0;
     uint8_t data_transfer_flag;
     CXLType3Dev *ct3d;
 
@@ -1004,11 +1044,40 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     }
     set_feat_info->data_transfer_flag = data_transfer_flag;
     set_feat_info->data_offset = hdr->offset;
+    bytes_to_copy = len_in - sizeof(CXLSetFeatureInHeader);
+
+    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        ps_set_feature = (void *)payload_in;
+        ps_write_attrs = &ps_set_feature->feat_data;
+        memcpy((uint8_t *)&ct3d->patrol_scrub_wr_attrs + hdr->offset,
+               ps_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->patrol_scrub_attrs.scrub_cycle &= ~0xFF;
+            ct3d->patrol_scrub_attrs.scrub_cycle |=
+                          ct3d->patrol_scrub_wr_attrs.scrub_cycle_hr & 0xFF;
+            ct3d->patrol_scrub_attrs.scrub_flags &= ~0x1;
+            ct3d->patrol_scrub_attrs.scrub_flags |=
+                          ct3d->patrol_scrub_wr_attrs.scrub_flags & 0x1;
+        }
+    } else {
+        return CXL_MBOX_UNSUPPORTED;
+    }
 
     if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER ||
         data_transfer_flag ==  CXL_SET_FEATURE_FLAG_ABORT_DATA_TRANSFER) {
         memset(&set_feat_info->uuid, 0, sizeof(QemuUUID));
+        if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
+            memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
+        }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
         set_feat_info->data_offset = 0;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 925c88ac5d..dda35f2528 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -893,6 +893,15 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     }
     cxl_event_init(&ct3d->cxl_dstate, 2);
 
+    /* Set default value for patrol scrub attributes */
+    ct3d->patrol_scrub_attrs.scrub_cycle_cap =
+                           CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
+                           CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
+    ct3d->patrol_scrub_attrs.scrub_cycle =
+                           CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
+                           (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
+    ct3d->patrol_scrub_attrs.scrub_flags = CXL_MEMDEV_PS_ENABLE_DEFAULT;
+
     return;
 
 err_release_cdat:
-- 
2.43.0

