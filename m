Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 617FE4594A
	for <linux-cxl@vger.kernel.org>; Thu, 19 Jun 2025 15:16:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750346209; cv=none; b=unUAgExxJPwkYvCMv2dSIwvt3LmHePqRgUUjSRBhAP90MZDCAjKy9cDtjH+tcNt9pNmDCNJfEn+RPXjeVkY1UbHFUpNOXcCh00vBKLZXNbyCtfOnbrww5OzSrEs2mHRKxH2J2W9EnGQ6z7CIqrmyaTf7m3cc40GgKrp4TDgeiQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750346209; c=relaxed/simple;
	bh=ZuQKCgyB0nExESaUUiCkDUuH40jvGudSnf1R5PSpruQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipELpaQvb6y2cMdAVLR9Rc6FVRsCDg5A6BUft74GEMt8kNF6BoG3g1QoZj2gd2fslDq21FacIl9Axnz+w4QV3IKK9LHuXF6/GkUDxZuNLzqEJDCoCd2j9t1yilGtPYFQMFyBV+9xXwGOIDDGFQZos7JEda/j50LdEg2wAZVV3lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bNPKK2lQdz6L5s0;
	Thu, 19 Jun 2025 23:14:29 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 5AF021404C4;
	Thu, 19 Jun 2025 23:16:45 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.195.246.81) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Jun 2025 17:16:44 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
	<jonathan.cameron@huawei.com>
CC: <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>,
	<linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v2 6/7] hw/cxl: Add Maintenance support
Date: Thu, 19 Jun 2025 16:16:18 +0100
Message-ID: <20250619151619.1695-7-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250619151619.1695-1-shiju.jose@huawei.com>
References: <20250619151619.1695-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
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

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 191 ++++++++++++++++++++++++++++++++++++
 hw/mem/cxl_type3.c          |  57 +++++++++++
 include/hw/cxl/cxl_device.h |  88 +++++++++++++++++
 3 files changed, 336 insertions(+)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 83668d7d93..87c5df83b0 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -89,6 +89,8 @@ enum {
         #define GET_SUPPORTED 0x0
         #define GET_FEATURE   0x1
         #define SET_FEATURE   0x2
+    MAINTENANCE = 0x06,
+        #define PERFORM 0x0
     IDENTIFY    = 0x40,
         #define MEMORY_DEVICE 0x0
     CCLS        = 0x41,
@@ -1239,6 +1241,8 @@ typedef struct CXLSupportedFeatureEntry {
 enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_PATROL_SCRUB = 0,
     CXL_FEATURE_ECS,
+    CXL_FEATURE_SPPR,
+    CXL_FEATURE_HPPR,
     CXL_FEATURE_MAX
 };
 
@@ -1280,6 +1284,28 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
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
@@ -1343,6 +1369,38 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
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
+                              CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SELECTION,
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
+                              CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SELECTION,
+                .get_feat_version = CXL_MEMDEV_HPPR_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_HPPR_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         case  CXL_FEATURE_PATROL_SCRUB:
             /* Fill supported feature entry for device patrol scrub control */
             get_feats_out->feat_entries[entry++] =
@@ -1441,6 +1499,26 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->ecs_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &soft_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSoftPPRReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSoftPPRReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->soft_ppr_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &hard_ppr_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemHardPPRReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemHardPPRReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->hard_ppr_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1552,6 +1630,42 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
                         ct3d->ecs_wr_attrs.fru_attrs[count].ecs_config & 0x1F;
             }
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+        if (hdr->version != CXL_MEMDEV_SPPR_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        CXLMemSoftPPRSetFeature *sppr_set_feature = (void *)payload_in;
+        CXLMemSoftPPRWriteAttrs *sppr_write_attrs =
+                            &sppr_set_feature->feat_data;
+        memcpy((uint8_t *)&ct3d->soft_ppr_wr_attrs + hdr->offset,
+               sppr_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->soft_ppr_attrs.op_mode = ct3d->soft_ppr_wr_attrs.op_mode;
+            ct3d->soft_ppr_attrs.sppr_op_mode = ct3d->soft_ppr_wr_attrs.sppr_op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+        if (hdr->version != CXL_MEMDEV_HPPR_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        CXLMemHardPPRSetFeature *hppr_set_feature = (void *)payload_in;
+        CXLMemHardPPRWriteAttrs *hppr_write_attrs =
+                            &hppr_set_feature->feat_data;
+        memcpy((uint8_t *)&ct3d->hard_ppr_wr_attrs + hdr->offset,
+               hppr_write_attrs,
+               bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag ==  CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->hard_ppr_attrs.op_mode = ct3d->hard_ppr_wr_attrs.op_mode;
+            ct3d->hard_ppr_attrs.hppr_op_mode = ct3d->hard_ppr_wr_attrs.hppr_op_mode;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1564,7 +1678,12 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             memset(&ct3d->patrol_scrub_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &ecs_uuid)) {
             memset(&ct3d->ecs_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &soft_ppr_uuid)) {
+            memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
+            memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
         }
+
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
         set_feat_info->data_offset = 0;
@@ -1574,6 +1693,72 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
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
+    /* TODO: produce a Memory Sparing Event Record */
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
+    case 0:
+        return CXL_MBOX_SUCCESS; /* nop */
+    case 1:
+        if (maint_in->ppr.flags & MAINTENANCE_PPR_QUERY_RESOURCES) {
+            return CXL_MBOX_SUCCESS;
+        }
+
+        switch (maint_in->subclass) {
+        case 0: /* soft ppr */
+        case 1: /* hard ppr */
+            cxl_perform_ppr(ct3d, ldq_le_p(&maint_in->ppr.dpa));
+            return CXL_MBOX_SUCCESS;
+        default:
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        break;
+    case 2:
+    case 3:
+        return CXL_MBOX_UNSUPPORTED;
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
@@ -3902,6 +4087,12 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
index 81774bf4b9..965ad3402d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -1205,6 +1205,30 @@ void ct3_realize(PCIDevice *pci_dev, Error **errp)
         ct3d->ecs_attrs.fru_attrs[count].ecs_flags = 0;
     }
 
+    /* Set default values for soft-PPR attributes */
+    ct3d->soft_ppr_attrs = (CXLMemSoftPPRReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_PPR_MAINT_CLASS,
+        .maint_op_subclass = CXL_MEMDEV_SPPR_MAINT_SUBCLASS,
+        .sppr_flags = CXL_MEMDEV_SPPR_DPA_SUPPORT_FLAG,
+        .restriction_flags = 0,
+        .sppr_op_mode = 0
+    };
+
+    /* Set default value for hard-PPR attributes */
+    ct3d->hard_ppr_attrs = (CXLMemHardPPRReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_PPR_MAINT_CLASS,
+        .maint_op_subclass = CXL_MEMDEV_HPPR_MAINT_SUBCLASS,
+        .hppr_flags = CXL_MEMDEV_HPPR_DPA_SUPPORT_FLAG,
+        .restriction_flags = 0,
+        .hppr_op_mode = 0
+    };
+
     return;
 
 err_release_cdat:
@@ -1830,6 +1854,21 @@ static int ct3d_qmp_cxl_event_log_enc(CxlEventLog log)
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
                                         uint32_t flags, uint8_t class,
@@ -1871,6 +1910,11 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
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
@@ -1914,6 +1958,10 @@ void qmp_cxl_inject_general_media_event(const char *path, CxlEventLog log,
     if (cxl_event_insert(cxlds, enc_log, (CXLEventRecordRaw *)&gem)) {
         cxl_event_irq_assert(ct3d);
     }
+
+    if (flags & CXL_EVENT_REC_FLAGS_MAINT_NEEDED) {
+        cxl_maintenance_insert(ct3d, dpa);
+    }
 }
 
 #define CXL_DRAM_VALID_CHANNEL                          BIT(0)
@@ -1974,6 +2022,11 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags
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
@@ -2052,6 +2105,10 @@ void qmp_cxl_inject_dram_event(const char *path, CxlEventLog log, uint32_t flags
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
index fc6ec82670..b0e13b02b5 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -491,6 +491,12 @@ static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
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
@@ -504,6 +510,13 @@ typedef struct CXLError {
 
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
@@ -516,6 +529,73 @@ typedef struct CXLPoison {
 typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
 #define CXL_POISON_LIST_LIMIT 256
 
+/* CXL memory Post Package Repair control attributes */
+#define CXL_MEMDEV_PPR_MAINT_CLASS 0x1
+#define CXL_MEMDEV_SPPR_MAINT_SUBCLASS 0x0
+#define CXL_MEMDEV_HPPR_MAINT_SUBCLASS 0x1
+
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
+#define CXL_MEMDEV_HPPR_MEM_SPARING_EVENT_REC_CAP_FLAG BIT(2)
+#define CXL_MEMDEV_HPPR_DEV_INITIATED_AT_BOOT_CAP_FLAG BIT(3)
+
+#define CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN BIT(0)
+#define CXL_MEMDEV_HPPR_OP_MODE_DEV_INITIATED_AT_BOOT BIT(1)
+
 /* CXL memory device patrol scrub control attributes */
 typedef struct CXLMemPatrolScrubReadAttrs {
         uint8_t scrub_cycle_cap;
@@ -686,6 +766,9 @@ struct CXLType3Dev {
     /* Error injection */
     CXLErrorList error_list;
 
+    /* Keep track of maintenance requests */
+    CXLMaintenanceList maint_list;
+
     /* Poison Injection - cache */
     CXLPoisonList poison_list;
     unsigned int poison_list_cnt;
@@ -698,6 +781,11 @@ struct CXLType3Dev {
 
     CXLSetFeatureInfo set_feat_info;
 
+    /* PPR control attributes */
+    CXLMemSoftPPRReadAttrs soft_ppr_attrs;
+    CXLMemSoftPPRWriteAttrs soft_ppr_wr_attrs;
+    CXLMemHardPPRReadAttrs hard_ppr_attrs;
+    CXLMemHardPPRWriteAttrs hard_ppr_wr_attrs;
     /* Patrol scrub control attributes */
     CXLMemPatrolScrubReadAttrs patrol_scrub_attrs;
     CXLMemPatrolScrubWriteAttrs patrol_scrub_wr_attrs;
-- 
2.43.0

