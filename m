Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B682E041E
	for <linux-cxl@vger.kernel.org>; Mon, 21 Jul 2025 17:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753118569; cv=none; b=HQiOUprJBTGLdxTBLzt7lz+xFWtB5yG6AnbU43EDvFwmllR+Mf/4vhICL3wAwi71hKSXGGXuIaJEbhu4KicEHJnc7GUZngLteRLLiZQbVeOArYqwBLiW2tMAropuJrkYFiDwv6wOdrnUO2ivJH518IMDBzazx0ripqMnfUgNC3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753118569; c=relaxed/simple;
	bh=1eNKS9lRLOsNyH/hC+Zw8kBMEovaEVLCq4t0ykk8mQU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DWF1EzN8t60X8clnaYrcQLrYyovOzrUKiwRbDjDYVybeyWyORsrQ6Vc0t0qBV52KH1zLDae/Krsg9cwwoyjcYS/uXy2mgPDVaSUAUYNfHKA8XGohrLN26fMeJ2kjlf6ht4JAE7tAZ3RF1Bn0+28mBH4HV70r3fmjSGp/+vvYZHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bm6cw6ZN8z6D9CW;
	Tue, 22 Jul 2025 01:21:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 84801140277;
	Tue, 22 Jul 2025 01:22:43 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.155.20) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 21 Jul 2025 19:22:42 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>, <fan.ni@samsung.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH qemu v4 6/7] hw/cxl: Add Maintenance support
Date: Mon, 21 Jul 2025 18:22:27 +0100
Message-ID: <20250721172228.2118-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250721172228.2118-1-shiju.jose@huawei.com>
References: <20250721172228.2118-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml100006.china.huawei.com (7.191.160.224) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Davidlohr Bueso <dave@stgolabs.net>

This adds initial support for the Maintenance command, specifically
the soft and hard PPR operations on a dpa. The implementation allows
to be executed at runtime, therefore semantically, data is retained
and CXL.mem requests are correctly processed.

Keep track of the requests upon a general media or DRAM event.

Post Package Repair (PPR) maintenance operations may be supported by CXL
devices that implement CXL.mem protocol. A PPR maintenance operation
requests the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support PPR features
may implement PPR Maintenance operations. DRAM components may support two
types of PPR, hard PPR (hPPR), for a permanent row repair, and Soft PPR
(sPPR), for a temporary row repair. Soft PPR is much faster than hPPR,
but the repair is lost with a power cycle.

CXL spec 3.2 section 8.2.10.7.1.2 describes the device's sPPR (soft PPR)
maintenance operation and section 8.2.10.7.1.3 describes the device's
hPPR (hard PPR) maintenance operation feature.

CXL spec 3.2 section 8.2.10.7.2.1 describes the sPPR feature discovery and
configuration.

CXL spec 3.2 section 8.2.10.7.2.2 describes the hPPR feature discovery and
configuration.

CXL spec 3.2 section 8.2.10.2.1.4 Table 8-60 describes the Memory Sparing
Event Record.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 243 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  59 +++++++++
 include/hw/cxl/cxl_device.h | 102 +++++++++++++++
 include/hw/cxl/cxl_events.h |  42 +++++++
 4 files changed, 444 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ce02ae8528..4dae357f7d 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -85,6 +85,8 @@ enum {
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
         #define SET_FEATURE   0x2
+    MAINTENANCE = 0x06,
+        #define PERFORM 0x0
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -1110,8 +1112,8 @@ typedef struct CXLSupportedFeatureEntry {
 #define CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE BIT(0)
 #define CXL_FEAT_ENTRY_ATTR_FLAG_DEEPEST_RESET_PERSISTENCE_MASK GENMASK(3, 1)
 #define CXL_FEAT_ENTRY_ATTR_FLAG_PERSIST_ACROSS_FIRMWARE_UPDATE BIT(4)
-#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SELECTION BIT(5)
-#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_SAVED_SELECTION BIT(6)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL BIT(5)
+#define CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_SAVED_SEL BIT(6)
 
 /* Supported Feature Entry : set feature effects */
 #define CXL_FEAT_ENTRY_SFE_CONFIG_CHANGE_COLD_RESET BIT(0)
@@ -1130,6 +1132,8 @@ typedef struct CXLSupportedFeatureEntry {
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_ECS,
+    CXL_FEATURE_SPPR,
+    CXL_FEATURE_HPPR,
     CXL_FEATURE_MAX
 };
 
@@ -1171,6 +1175,28 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
 };
 #define CXL_SET_FEAT_DATA_SAVED_ACROSS_RESET BIT(3)
 
+/* CXL r3.2 section 8.2.10.7.2.1: sPPR Feature Discovery and Configuration */
+static const QemuUUID soft_ppr_uuid = {
+    .data = UUID(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e,
+                 0x69, 0x2c, 0x91, 0x75, 0x68, 0xbb)
+};
+
+typedef struct CXLMemSoftPPRSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemSoftPPRWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemSoftPPRSetFeature;
+
+/* CXL r3.2 section 8.2.10.7.2.2: hPPR Feature Discovery and Configuration */
+static const QemuUUID hard_ppr_uuid = {
+    .data = UUID(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1,
+                 0xec, 0x74, 0x59, 0xfb, 0x0e, 0x24)
+};
+
+typedef struct CXLMemHardPPRSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemHardPPRWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemHardPPRSetFeature;
+
 /* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature */
 static const QemuUUID patrol_scrub_uuid = {
     .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
@@ -1234,6 +1260,38 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
     for (entry = 0, index = get_feats_in->start_index;
          entry < req_entries; index++) {
         switch (index) {
+        case CXL_FEATURE_SPPR:
+            /* Fill supported feature entry for soft-PPR */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = soft_ppr_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSoftPPRReadAttrs),
+                .set_feat_size = sizeof(CXLMemSoftPPRWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                              CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPPR_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPPR_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_HPPR:
+            /* Fill supported feature entry for hard-PPR */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = hard_ppr_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemHardPPRReadAttrs),
+                .set_feat_size = sizeof(CXLMemHardPPRWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                              CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_HPPR_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_HPPR_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         case  CXL_FEATURE_PATROL_SCRUB:
             /* Fill supported feature entry for device patrol scrub control */
             get_feats_out->feat_entries[entry++] =
@@ -1332,6 +1390,26 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &soft_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSoftPPRReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSoftPPRReadAttrs) -
+                        get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->soft_ppr_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &hard_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemHardPPRReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemHardPPRReadAttrs) -
+                        get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->hard_ppr_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1443,6 +1521,46 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                         ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
             }
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+        CXLMemSoftPPRSetFeature *sppr_set_feature = (void *)payload_in;
+        CXLMemSoftPPRWriteAttrs *sppr_write_attrs =
+                            &sppr_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPPR_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
+               sppr_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->soft_ppr_attrs.op_mode = ct3d->soft_ppr_wr_attrs.op_mode;
+            ct3d->soft_ppr_attrs.sppr_op_mode =
+                    ct3d->soft_ppr_wr_attrs.sppr_op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+        CXLMemHardPPRSetFeature *hppr_set_feature = (void *)payload_in;
+        CXLMemHardPPRWriteAttrs *hppr_write_attrs =
+                            &hppr_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_HPPR_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
+               hppr_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->hard_ppr_attrs.op_mode = ct3d->hard_ppr_wr_attrs.op_mode;
+            ct3d->hard_ppr_attrs.hppr_op_mode =
+                    ct3d->hard_ppr_wr_attrs.hppr_op_mode;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1455,6 +1573,10 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
             memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
@@ -1465,6 +1587,117 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
+                            uint8_t class, uint8_t sub_class)
+{
+    CXLEventSparing event_rec = {};
+
+    cxl_assign_event_header(&event_rec.hdr,
+                            &sparing_uuid,
+                            (1 << CXL_EVENT_TYPE_INFO),
+                            sizeof(event_rec),
+                            cxl_device_get_timestamp(&ct3d->cxl_dstate),
+                            1, class, 1, sub_class, 0, 0, 0, 0);
+
+    event_rec.flags = 0;
+    event_rec.result = 0;
+    event_rec.validity_flags = CXL_MSER_VALID_CHANNEL |
+                               CXL_MSER_VALID_RANK |
+                               CXL_MSER_VALID_NIB_MASK |
+                               CXL_MSER_VALID_BANK_GROUP |
+                               CXL_MSER_VALID_BANK |
+                               CXL_MSER_VALID_ROW |
+                               CXL_MSER_VALID_COLUMN |
+                               CXL_MSER_VALID_SUB_CHANNEL;
+
+    event_rec.res_avail = 1;
+    event_rec.channel = 2;
+    event_rec.rank = 5;
+    st24_le_p(event_rec.nibble_mask, 0xA59C);
+    event_rec.bank_group = 2;
+    event_rec.bank = 4;
+    st24_le_p(event_rec.row, 13);
+    event_rec.column = 23;
+    event_rec.sub_channel = 7;
+
+    if (cxl_event_insert(&ct3d->cxl_dstate,
+                         CXL_EVENT_TYPE_INFO,
+                         (CXLEventRecordRaw *)&event_rec)) {
+        cxl_event_irq_assert(ct3d);
+    }
+}
+
+
+static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
+{
+    CXLMaintenance *ent, *next;
+
+    QLIST_FOREACH_SAFE(ent, &ct3d->maint_list, node, next) {
+        if (dpa == ent->dpa) {
+            QLIST_REMOVE(ent, node);
+            g_free(ent);
+            break;
+        }
+    }
+
+    /* Produce a Memory Sparing Event Record */
+    if (ct3d->soft_ppr_attrs.sppr_op_mode &
+        CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN) {
+        cxl_mbox_create_mem_sparing_event_records(ct3d,
+                                CXL_MEMDEV_MAINT_CLASS_SPARING,
+                                CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING);
+    }
+}
+
+/* CXL r3.2 section 8.2.10.7.1 - Perform Maintenance (Opcode 0600h) */
+#define MAINTENANCE_PPR_QUERY_RESOURCES BIT(0)
+
+static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
+                                   uint8_t *payload_in, size_t len_in,
+                                   uint8_t *payload_out, size_t *len_out,
+                                   CXLCCI *cci)
+{
+    struct {
+        uint8_t class;
+        uint8_t subclass;
+        union {
+            struct {
+                uint8_t flags;
+                uint64_t dpa;
+                uint8_t nibble_mask[3];
+            } QEMU_PACKED ppr;
+        };
+    } QEMU_PACKED *maint_in = (void *)payload_in;
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+
+    if (maintenance_running(cci)) {
+        return CXL_MBOX_BUSY;
+    }
+
+    switch (maint_in->class) {
+    case CXL_MEMDEV_MAINT_CLASS_NO_OP:
+        return CXL_MBOX_SUCCESS; /* nop */
+    case CXL_MEMDEV_MAINT_CLASS_PPR:
+        if (maint_in->ppr.flags & MAINTENANCE_PPR_QUERY_RESOURCES) {
+            return CXL_MBOX_SUCCESS;
+        }
+
+        switch (maint_in->subclass) {
+        case CXL_MEMDEV_MAINT_SUBCLASS_SPPR:
+        case CXL_MEMDEV_MAINT_SUBCLASS_HPPR:
+            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
+            return CXL_MBOX_SUCCESS;
+        default:
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.9.1.1: Identify Memory Device (Opcode 4000h) */
 static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -3761,6 +3994,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                  CXL_MBOX_IMMEDIATE_POLICY_CHANGE |
                                  CXL_MBOX_IMMEDIATE_LOG_CHANGE |
                                  CXL_MBOX_SECURITY_STATE_CHANGE)},
+    [MAINTENANCE][PERFORM] = { "MAINTENANCE_PERFORM",
+                               cmd_media_perform_maintenance, ~0,
+                               CXL_MBOX_IMMEDIATE_CONFIG_CHANGE |
+                               CXL_MBOX_IMMEDIATE_DATA_CHANGE |
+                               CXL_MBOX_IMMEDIATE_LOG_CHANGE |
+                               CXL_MBOX_BACKGROUND_OPERATION },
     [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
         cmd_identify_memory_device, 0, 0 },
     [CCLS][GET_PARTITION_INFO] = { "CCLS_GET_PARTITION_INFO",
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index ab74395186..cf166ea05e 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -964,6 +964,32 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
+    /* Set default values for soft-PPR attributes */
+    ct3d->soft_ppr_attrs = (CXLMemSoftPPRReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_PPR,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_SPPR,
+        .sppr_flags = CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG |
+                      CXL_MEMDEV_SPPR_MEM_SPARING_EV_REC_CAP_FLAG,
+        .restriction_flags = 0,
+        .sppr_op_mode = CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN
+    };
+
+    /* Set default value for hard-PPR attributes */
+    ct3d->hard_ppr_attrs = (CXLMemHardPPRReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_PPR,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_HPPR,
+        .hppr_flags = CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG |
+                      CXL_MEMDEV_HPPR_MEM_SPARING_EV_REC_CAP_FLAG,
+        .restriction_flags = 0,
+        .hppr_op_mode = CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN
+    };
+
     return;
 
 err_release_cdat:
@@ -1667,6 +1693,21 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
         return -EINVAL;
     }
 }
+
+static void cxl_maintenance_insert(CXLType3Dev *ct3d, uint64_t dpa)
+{
+    CXLMaintenance *ent, *m;
+
+    QLIST_FOREACH(ent, &ct3d->maint_list, node) {
+        if (dpa == ent->dpa) {
+            return;
+        }
+    }
+    m = g_new0(CXLMaintenance, 1);
+    m->dpa = dpa;
+    QLIST_INSERT_HEAD(&ct3d->maint_list, m, node);
+}
+
 /* Component ID is device specific.  Define this as a string. */
 void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
                                         uint32_t flags, bool has_maint_op_class,
@@ -1715,6 +1756,11 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
         error_setg(errp, "Unhandled error log type");
         return;
     }
+    if (rc == CXL_EVENT_TYPE_INFO &&
+        (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED)) {
+        error_setg(errp, "Informational event cannot require maintenance");
+        return;
+    }
     enc_log = rc;
 
     memset(&gem, 0, sizeof(gem));
@@ -1773,6 +1819,10 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
+
+    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
+        cxl_maintenance_insert(ct3d, dpa);
+    }
 }
 
 #define CXL_DRAM_VALID_CHANNEL                          BIT(0)
@@ -1842,6 +1892,11 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
         error_setg(errp, "Unhandled error log type");
         return;
     }
+    if (rc == CXL_EVENT_TYPE_INFO &&
+        (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED)) {
+        error_setg(errp, "Informational event cannot require maintenance");
+        return;
+    }
     enc_log = rc;
 
     memset(&dram, 0, sizeof(dram));
@@ -1935,6 +1990,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&dram)) {
         cxl_event_irq_assert(ct3d);
     }
+
+    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
+        cxl_maintenance_insert(ct3d, dpa);
+    }
 }
 
 #define CXL_MMER_VALID_COMPONENT                        BIT(0)
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b77b6b2499..947288bf0a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -430,6 +430,12 @@ static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
     uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
     return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
 }
+
+static inline bool maintenance_running(CXLCCI *cci)
+{
+    return cci->bg.runtime && cci->bg.opcode == 0x0600;
+}
+
 static inline bool scan_media_running(CXLCCI *cci)
 {
     return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
@@ -443,6 +449,13 @@ typedef struct CXLError {
 
 typedef QTAILQ_HEAD(, CXLError) CXLErrorList;
 
+typedef struct CXLMaintenance {
+    uint64_t dpa;
+    QLIST_ENTRY(CXLMaintenance) node;
+} CXLMaintenance;
+
+typedef QLIST_HEAD(, CXLMaintenance) CXLMaintenanceList;
+
 typedef struct CXLPoison {
     uint64_t start, length;
     uint8_t type;
@@ -455,6 +468,87 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+/* CXL memory maintenance operation */
+/*
+ * CXL r3.2 section 8.2.10.7.2, Table 8-125: Mainteance Operation:
+ * Classes, Subclasses, and Feature UUIDs
+ */
+#define CXL_MEMDEV_MAINT_CLASS_NO_OP 0x0
+#define CXL_MEMDEV_MAINT_CLASS_PPR 0x1
+#define CXL_MEMDEV_MAINT_CLASS_SPARING 0x2
+#define CXL_MEMDEV_MAINT_CLASS_DEV_BUILT_IN_TEST 0x3
+
+#define CXL_MEMDEV_MAINT_SUBCLASS_SPPR 0x0
+#define CXL_MEMDEV_MAINT_SUBCLASS_HPPR 0x1
+
+#define CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING 0x0
+#define CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING 0x1
+#define CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING 0x2
+#define CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING 0x3
+
+/* CXL memory Post Package Repair control attributes */
+/*
+ * CXL r3.2 section 8.2.10.7.2.1, Table 8-128 and 8-129:
+ * sPPR Feature Readable/Writable Attributes
+ */
+typedef struct CXLMemSoftPPRReadAttrs {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[9];
+    uint8_t sppr_flags;
+    uint16_t restriction_flags;
+    uint8_t sppr_op_mode;
+} QEMU_PACKED CXLMemSoftPPRReadAttrs;
+
+typedef struct CXLMemSoftPPRWriteAttrs {
+    uint16_t op_mode;
+    uint8_t sppr_op_mode;
+} QEMU_PACKED CXLMemSoftPPRWriteAttrs;
+
+#define CXL_MEMDEV_SPPR_GET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_SPPR_SET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG               BIT(0)
+#define CXL_MEMDEV_SPPR_NIBBLE_SUPPORT_FLAG            BIT(1)
+#define CXL_MEMDEV_SPPR_MEM_SPARING_EV_REC_CAP_FLAG BIT(2)
+#define CXL_MEMDEV_SPPR_DEV_INITIATED_AT_BOOT_CAP_FLAG BIT(3)
+
+#define CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN BIT(0)
+#define CXL_MEMDEV_SPPR_OP_MODE_DEV_INITIATED_AT_BOOT BIT(1)
+
+/*
+ * CXL r3.2 section 8.2.10.7.2.2, Table 8-131 and 8-132:
+ * hPPR Feature Readable/Writable Attributes
+ */
+typedef struct CXLMemHardPPRReadAttrs {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[9];
+    uint8_t hppr_flags;
+    uint16_t restriction_flags;
+    uint8_t hppr_op_mode;
+} QEMU_PACKED CXLMemHardPPRReadAttrs;
+
+typedef struct CXLMemHardPPRWriteAttrs {
+    uint16_t op_mode;
+    uint8_t hppr_op_mode;
+} QEMU_PACKED CXLMemHardPPRWriteAttrs;
+
+#define CXL_MEMDEV_HPPR_GET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_HPPR_SET_FEATURE_VERSION    0x03
+#define CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG               BIT(0)
+#define CXL_MEMDEV_HPPR_NIBBLE_SUPPORT_FLAG            BIT(1)
+#define CXL_MEMDEV_HPPR_MEM_SPARING_EV_REC_CAP_FLAG    BIT(2)
+#define CXL_MEMDEV_HPPR_DEV_INITIATED_AT_BOOT_CAP_FLAG BIT(3)
+
+#define CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN BIT(0)
+#define CXL_MEMDEV_HPPR_OP_MODE_DEV_INITIATED_AT_BOOT BIT(1)
+
 /* CXL memory device patrol scrub control attributes */
 typedef struct CXLMemPatrolScrubReadAttrs {
         uint8_t scrub_cycle_cap;
@@ -605,6 +699,9 @@ struct CXLType3Dev {
     /* Error injection */
     CXLErrorList error_list;
 
+    /* Keep track of maintenance requests */
+    CXLMaintenanceList maint_list;
+
     /* Poison Injection - cache */
     CXLPoisonList poison_list;
     unsigned int poison_list_cnt;
@@ -617,6 +714,11 @@ struct CXLType3Dev {
 
     CXLSetFeatureInfo set_feat_info;
 
+    /* PPR control attributes */
+    CXLMemSoftPPRReadAttrs soft_ppr_attrs;
+    CXLMemSoftPPRWriteAttrs soft_ppr_wr_attrs;
+    CXLMemHardPPRReadAttrs hard_ppr_attrs;
+    CXLMemHardPPRWriteAttrs hard_ppr_wr_attrs;
     /* Patrol scrub control attributes */
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 4a7836ad72..3052bc9f18 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -219,4 +219,46 @@ typedef enum CXLDCEventType {
     DC_EVENT_CAPACITY_RELEASED = 0x5,
 } CXLDCEventType;
 
+/*
+ * CXL r3.2 section Table 8-60: Memory Sparing Event Record
+ * All fields little endian.
+ */
+#define CXL_MSER_VALID_CHANNEL BIT(0)
+#define CXL_MSER_VALID_RANK BIT(1)
+#define CXL_MSER_VALID_NIB_MASK BIT(2)
+#define CXL_MSER_VALID_BANK_GROUP BIT(3)
+#define CXL_MSER_VALID_BANK BIT(4)
+#define CXL_MSER_VALID_ROW BIT(5)
+#define CXL_MSER_VALID_COLUMN BIT(6)
+#define CXL_MSER_VALID_COMP_ID BIT(7)
+#define CXL_MSER_VALID_COMP_ID_FORMAT BIT(8)
+#define CXL_MSER_VALID_SUB_CHANNEL BIT(9)
+
+typedef struct CXLEventSparing {
+    CXLEventRecordHdr hdr;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t flags;
+    uint8_t result;
+    uint16_t validity_flags;
+    uint8_t reserved1[6];
+    uint16_t res_avail;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint16_t column;
+    uint8_t component_id[CXL_EVENT_GEN_MED_COMP_ID_SIZE];
+    uint8_t sub_channel;
+    uint8_t reserved2[0x25];
+} QEMU_PACKED CXLEventSparing;
+
+/* CXL r3.2 Table 8-60: Memory Sparing Event Record */
+static const QemuUUID sparing_uuid = {
+    .data = UUID(0xe71f3a40, 0x2d29, 0x4092, 0x8a, 0x39,
+                 0x4d, 0x1c, 0x96, 0x6c, 0x7c, 0x65),
+};
+
 #endif /* CXL_EVENTS_H */
-- 
2.43.0

