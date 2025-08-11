Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288EE23B613
	for <linux-cxl@vger.kernel.org>; Mon, 11 Aug 2025 08:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754902559; cv=none; b=adGo3r9KYYeB2U9jz74HV8SH9skX3TyaHvOR3nLhdN+gMtSHix62QWZiijJocS5fviEiZfoGR7Z5ufhFLlXzq4nEh2xH6fUpFuLBOpsn5g+gWWu1OPDm8LFNBApGoIm7+IVEmic7E5ftxMFFcZID2tB+5WkWM25AVxdeAMSqW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754902559; c=relaxed/simple;
	bh=A6UKhrFkd/HooaefNH3KHvH/1sVV1AiAb2ZlIJcKq/o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QRjTzicJgrxuAkpDfYQDpRqXZDbJ7iH6Z3lcTaQlQPqcOUE53g5bkahxnoIts5qJQ1Ognp3p2c7qXmzVg2/z8snYhQ85OBIWfrTiCZwsLcQeibPrz0WXzi52JyTL52B8P2HCxPB8ZbHtLEMlmmagahA2lfRtA04VSWD2n6wHE3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0pM40Fdhz6L5HN;
	Mon, 11 Aug 2025 16:53:20 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id E75091402F3;
	Mon, 11 Aug 2025 16:55:53 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.146.213) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 10:55:53 +0200
From: <shiju.jose@huawei.com>
To: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <armbru@redhat.com>,
	<jonathan.cameron@huawei.com>, <dave@stgolabs.net>
CC: <linuxarm@huawei.com>, <shiju.jose@huawei.com>
Subject: [PATCH v6 8/8] hw/cxl: Add emulation for memory sparing control feature
Date: Mon, 11 Aug 2025 09:55:30 +0100
Message-ID: <20250811085530.2263-9-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250811085530.2263-1-shiju.jose@huawei.com>
References: <20250811085530.2263-1-shiju.jose@huawei.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500012.china.huawei.com (7.191.174.4) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

Memory sparing is defined as a repair function that replaces a portion of
memory with a portion of functional memory at that same DPA. The
subclasses for this operation vary in terms of the scope of the sparing
being performed. The Cacheline sparing subclass refers to a sparing
action that can replace a full cacheline. Row sparing is provided as an
alternative to PPR sparing functions and its scope is that of a single
DDR row. Bank sparing allows an entire bank to be replaced. Rank sparing
is defined as an operation in which an entire DDR rank is replaced.

Memory sparing maintenance operations may be supported by CXL devices
that implement CXL.mem protocol. A sparing maintenance operation requests
the CXL device to perform a repair operation on its media.
For example, a CXL device with DRAM components that support memory sparing
features may implement sparing Maintenance operations.

The host may issue a query command by setting Query Resources flag in the
Input Payload (CXL Spec 3.2 Table 8-120) to determine availability of
sparing resources for a given address. In response to a query request,
the device shall report the resource availability by producing the Memory
Sparing Event Record (CXL Spec 3.2 Table 8-60) in which the Channel, Rank,
Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields are a copy
of the values specified in the request.

During the execution of a sparing maintenance operation, a CXL memory
device:
- May or may not retain data
- May or may not be able to process CXL.mem requests correctly.
These CXL memory device capabilities are specified by restriction flags
in the memory sparing feature readable attributes.

When a CXL device identifies error on a memory component, the device
may inform the host about the need for a memory sparing maintenance
operation by using DRAM event record, where the 'maintenance needed' flag
may set. The event record contains some of the DPA, Channel, Rank,
Nibble Mask, Bank Group, Bank, Row, Column, Sub-Channel fields that
should be repaired. The userspace tool requests for maintenance operation
if the 'maintenance needed' flag set in the CXL DRAM error record.

CXL spec 3.2 section 8.2.10.7.2.3 describes the memory sparing feature
discovery and configuration.

CXL spec 3.2 section 8.2.10.7.1.4 describes the device's memory sparing
maintenance operation feature.

Add emulation for CXL memory device memory sparing control feature
and memory sparing maintenance operation command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 317 +++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  44 +++++
 include/hw/cxl/cxl_device.h |  33 ++++
 include/hw/cxl/cxl_events.h |   5 +
 4 files changed, 395 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 254154ceda..a3ab3b48f2 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -1134,6 +1134,10 @@ enum CXL_SUPPORTED_FEATURES_LIST {
     CXL_FEATURE_ECS,
     CXL_FEATURE_SPPR,
     CXL_FEATURE_HPPR,
+    CXL_FEATURE_CACHELINE_SPARING,
+    CXL_FEATURE_ROW_SPARING,
+    CXL_FEATURE_BANK_SPARING,
+    CXL_FEATURE_RANK_SPARING,
     CXL_FEATURE_MAX
 };
 
@@ -1222,6 +1226,35 @@ typedef struct CXLMemECSSetFeature {
         CXLMemECSWriteAttrs feat_data[];
 } QEMU_PACKED QEMU_ALIGNED(16) CXLMemECSSetFeature;
 
+/*
+ * CXL r3.2 section 8.2.10.7.2.3:
+ * Memory Sparing Features Discovery and Configuration
+ */
+static const QemuUUID cacheline_sparing_uuid = {
+    .data = UUID(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb,
+                 0xfd, 0xaf, 0x65, 0x03, 0xba, 0xc4)
+};
+
+static const QemuUUID row_sparing_uuid = {
+    .data = UUID(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98,
+                 0xc2, 0xd5, 0x7f, 0x27, 0x9b, 0xed)
+};
+
+static const QemuUUID bank_sparing_uuid = {
+    .data = UUID(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef,
+                 0xfa, 0xac, 0x5d, 0x18, 0xa8, 0x63)
+};
+
+static const QemuUUID rank_sparing_uuid = {
+    .data = UUID(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76,
+                 0xda, 0x0b, 0x5e, 0x7a, 0x76, 0xa7)
+};
+
+typedef struct CXLMemSparingSetFeature {
+        CXLSetFeatureInHeader hdr;
+        CXLMemSparingWriteAttrs feat_data;
+} QEMU_PACKED QEMU_ALIGNED(16) CXLMemSparingSetFeature;
+
 /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
 static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                              uint8_t *payload_in,
@@ -1322,6 +1355,70 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
                                     CXL_FEAT_ENTRY_SFE_CEL_VALID,
             };
             break;
+        case CXL_FEATURE_CACHELINE_SPARING:
+            /* Fill supported feature entry for Cacheline Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = cacheline_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_ROW_SPARING:
+            /* Fill supported feature entry for Row Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = row_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_BANK_SPARING:
+            /* Fill supported feature entry for Bank Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = bank_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
+        case CXL_FEATURE_RANK_SPARING:
+            /* Fill supported feature entry for Rank Memory Sparing */
+            get_feats_out->feat_entries[entry++] =
+                           (struct CXLSupportedFeatureEntry) {
+                .uuid = rank_sparing_uuid,
+                .feat_index = index,
+                .get_feat_size = sizeof(CXLMemSparingReadAttrs),
+                .set_feat_size = sizeof(CXLMemSparingWriteAttrs),
+                .attr_flags = CXL_FEAT_ENTRY_ATTR_FLAG_CHANGABLE |
+                            CXL_FEAT_ENTRY_ATTR_FLAG_SUPPORT_DEFAULT_SEL,
+                .get_feat_version = CXL_MEMDEV_SPARING_GET_FEATURE_VERSION,
+                .set_feat_version = CXL_MEMDEV_SPARING_SET_FEATURE_VERSION,
+                .set_feat_effects = CXL_FEAT_ENTRY_SFE_IMMEDIATE_CONFIG_CHANGE |
+                                    CXL_FEAT_ENTRY_SFE_CEL_VALID,
+            };
+            break;
         default:
             __builtin_unreachable();
         }
@@ -1410,6 +1507,47 @@ static CXLRetCode cmd_features_get_feature(const struct cxl_cmd *cmd,
         memcpy(payload_out,
                (uint8_t *)&ct3d->hard_ppr_attrs + get_feature->offset,
                bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid,
+                                  &cacheline_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->cacheline_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &row_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->row_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &bank_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->bank_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
+    } else if (qemu_uuid_is_equal(&get_feature->uuid, &rank_sparing_uuid)) {
+        if (get_feature->offset >= sizeof(CXLMemSparingReadAttrs)) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        bytes_to_copy = sizeof(CXLMemSparingReadAttrs) -
+                                             get_feature->offset;
+        bytes_to_copy = MIN(bytes_to_copy, get_feature->count);
+        memcpy(payload_out,
+               (uint8_t *)&ct3d->rank_sparing_attrs + get_feature->offset,
+               bytes_to_copy);
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1559,6 +1697,78 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             ct3d->hard_ppr_attrs.hppr_op_mode =
                     ct3d->hard_ppr_wr_attrs.hppr_op_mode;
         }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &cacheline_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->cacheline_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->cacheline_sparing_attrs.op_mode =
+                                    ct3d->cacheline_sparing_wr_attrs.op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &row_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->row_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->row_sparing_attrs.op_mode =
+                              ct3d->row_sparing_wr_attrs.op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &bank_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->bank_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->bank_sparing_attrs.op_mode =
+                              ct3d->bank_sparing_wr_attrs.op_mode;
+        }
+    } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
+        CXLMemSparingSetFeature *mem_sparing_set_feature = (void *)payload_in;
+        CXLMemSparingWriteAttrs *mem_sparing_write_attrs =
+                            &mem_sparing_set_feature->feat_data;
+
+        if (hdr->version != CXL_MEMDEV_SPARING_SET_FEATURE_VERSION) {
+            return CXL_MBOX_UNSUPPORTED;
+        }
+
+        memcpy((uint8_t *)&ct3d->rank_sparing_wr_attrs + hdr->offset,
+               mem_sparing_write_attrs, bytes_to_copy);
+        set_feat_info->data_size += bytes_to_copy;
+
+        if (data_transfer_flag == CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER ||
+            data_transfer_flag == CXL_SET_FEATURE_FLAG_FINISH_DATA_TRANSFER) {
+            ct3d->rank_sparing_attrs.op_mode =
+                             ct3d->rank_sparing_wr_attrs.op_mode;
+        }
     } else {
         return CXL_MBOX_UNSUPPORTED;
     }
@@ -1575,6 +1785,15 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
             memset(&ct3d->soft_ppr_wr_attrs, 0, set_feat_info->data_size);
         } else if (qemu_uuid_is_equal(&hdr->uuid, &hard_ppr_uuid)) {
             memset(&ct3d->hard_ppr_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &cacheline_sparing_uuid)) {
+            memset(&ct3d->cacheline_sparing_wr_attrs, 0,
+                   set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &row_sparing_uuid)) {
+            memset(&ct3d->row_sparing_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &bank_sparing_uuid)) {
+            memset(&ct3d->bank_sparing_wr_attrs, 0, set_feat_info->data_size);
+        } else if (qemu_uuid_is_equal(&hdr->uuid, &rank_sparing_uuid)) {
+            memset(&ct3d->rank_sparing_wr_attrs, 0, set_feat_info->data_size);
         }
         set_feat_info->data_transfer_flag = 0;
         set_feat_info->data_saved_across_reset = false;
@@ -1585,9 +1804,27 @@ static CXLRetCode cmd_features_set_feature(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
+#define CXL_MEM_SPARING_FLAGS_QUERY_RESOURCES BIT(0)
+#define CXL_MEM_SPARING_FLAGS_HARD_SPARING BIT(1)
+#define CXL_MEM_SPARING_FLAGS_SUB_CHANNEL_VALID BIT(2)
+#define CXL_MEM_SPARING_FLAGS_NIB_MASK_VALID BIT(3)
+
+typedef struct CXLMemSparingMaintInPayload {
+    uint8_t flags;
+    uint8_t channel;
+    uint8_t rank;
+    uint8_t nibble_mask[3];
+    uint8_t bank_group;
+    uint8_t bank;
+    uint8_t row[3];
+    uint16_t column;
+    uint8_t sub_channel;
+} QEMU_PACKED CXLMemSparingMaintInPayload;
+
+static void cxl_create_mem_sparing_event_records(CXLType3Dev *ct3d,
                             uint8_t maint_op_class, uint8_t maint_op_sub_class,
-                            CXLMaintenance *ent)
+                            CXLMaintenance *ent,
+                            CXLMemSparingMaintInPayload *sparing_pi)
 {
     CXLEventSparing event_rec = {};
 
@@ -1615,6 +1852,31 @@ static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
             strncpy((char *)event_rec.component_id, (char *)ent->component_id,
                     sizeof(event_rec.component_id));
         }
+    } else if (sparing_pi) {
+        event_rec.flags = CXL_MSER_FLAGS_QUERY_RESOURCES;
+        event_rec.result = 0;
+        event_rec.validity_flags = CXL_MSER_VALID_CHANNEL |
+                                   CXL_MSER_VALID_RANK |
+                                   CXL_MSER_VALID_NIB_MASK |
+                                   CXL_MSER_VALID_BANK_GROUP |
+                                   CXL_MSER_VALID_BANK |
+                                   CXL_MSER_VALID_ROW |
+                                   CXL_MSER_VALID_COLUMN;
+        event_rec.res_avail = 1;
+        event_rec.channel = sparing_pi->channel;
+        event_rec.rank = sparing_pi->rank;
+        if (sparing_pi->flags & CXL_MEM_SPARING_FLAGS_NIB_MASK_VALID) {
+            __builtin_memcpy(event_rec.nibble_mask, sparing_pi->nibble_mask,
+                             sizeof(uint32_t));
+        }
+        event_rec.bank_group = sparing_pi->bank_group;
+        event_rec.bank = sparing_pi->bank;
+        event_rec.column = sparing_pi->column;
+        __builtin_memcpy(event_rec.row, sparing_pi->row, sizeof(uint32_t));
+        if (sparing_pi->flags & CXL_MEM_SPARING_FLAGS_SUB_CHANNEL_VALID) {
+            event_rec.sub_channel = sparing_pi->sub_channel;
+            event_rec.validity_flags |= CXL_MSER_VALID_SUB_CHANNEL;
+        }
     } else {
         return;
     }
@@ -1626,6 +1888,26 @@ static void cxl_mbox_create_mem_sparing_event_records(CXLType3Dev *ct3d,
     }
 }
 
+static CXLRetCode cxl_perform_mem_sparing(CXLType3Dev *ct3d, uint8_t sub_class,
+                                          void *maint_pi)
+{
+    switch (sub_class) {
+    case CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING:
+        qemu_log("Cacheline Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    case CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING:
+        qemu_log("Row Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    case CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING:
+        qemu_log("Bank Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    case CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING:
+        qemu_log("Rank Memory Sparing\n");
+        return CXL_MBOX_SUCCESS;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+}
 
 static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
 {
@@ -1636,10 +1918,10 @@ static void cxl_perform_ppr(CXLType3Dev *ct3d, uint64_t dpa)
             /* Produce a Memory Sparing Event Record */
             if (ct3d->soft_ppr_attrs.sppr_op_mode &
                 CXL_MEMDEV_SPPR_OP_MODE_MEM_SPARING_EV_REC_EN) {
-                cxl_mbox_create_mem_sparing_event_records(ct3d,
+                cxl_create_mem_sparing_event_records(ct3d,
                                 CXL_MEMDEV_MAINT_CLASS_SPARING,
                                 CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
-                                ent);
+                                ent, NULL);
             }
             break;
         }
@@ -1663,6 +1945,7 @@ static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
                 uint64_t dpa;
                 uint8_t nibble_mask[3];
             } QEMU_PACKED ppr;
+            CXLMemSparingMaintInPayload mem_sparing_pi;
         };
     } QEMU_PACKED *maint_in = (void *)payload_in;
     CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
@@ -1688,6 +1971,32 @@ static CXLRetCode cmd_media_perform_maintenance(const struct cxl_cmd *cmd,
             return CXL_MBOX_INVALID_INPUT;
         }
         break;
+    case CXL_MEMDEV_MAINT_CLASS_SPARING:
+        if (maint_in->mem_sparing_pi.flags &
+            CXL_MEM_SPARING_FLAGS_QUERY_RESOURCES) {
+            /*
+             * CXL r3.2 sect 8.2.10.7.1.4 - Memory Sparing Maintenance Operation
+             * Produce Memory Sparing Event record to report resources
+             * availability.
+             */
+            cxl_create_mem_sparing_event_records(ct3d, maint_in->class,
+                                                 maint_in->subclass, NULL,
+                                                 &maint_in->mem_sparing_pi);
+
+            return CXL_MBOX_SUCCESS;
+        }
+
+        switch (maint_in->subclass) {
+        case CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING:
+        case CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING:
+        case CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING:
+        case CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING:
+            return cxl_perform_mem_sparing(ct3d, maint_in->subclass,
+                                           &maint_in->mem_sparing_pi);
+        default:
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        break;
     default:
         return CXL_MBOX_INVALID_INPUT;
     }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 6036c610e6..2149775508 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -990,6 +990,50 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         .hppr_op_mode = CXL_MEMDEV_HPPR_OP_MODE_MEM_SPARING_EV_REC_EN
     };
 
+    /* Set default value for Cacheline Memory Sparing attributes */
+    ct3d->cacheline_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_CACHELINE_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
+    /* Set default value for Row Memory Sparing attributes */
+    ct3d->row_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_ROW_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
+    /* Set default value for Bank Memory Sparing attributes */
+    ct3d->bank_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_BANK_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
+    /* Set default value for Rank Memory Sparing attributes */
+    ct3d->rank_sparing_attrs = (CXLMemSparingReadAttrs) {
+        .max_maint_latency = 0x5, /* 100 ms */
+        .op_caps = 0, /* require host involvement */
+        .op_mode = 0,
+        .maint_op_class = CXL_MEMDEV_MAINT_CLASS_SPARING,
+        .maint_op_subclass = CXL_MEMDEV_MAINT_SUBCLASS_RANK_SPARING,
+        .restriction_flags = CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG |
+                             CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG,
+    };
+
     return;
 
 err_release_cdat:
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 959049aa46..59f8fa7c24 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -608,6 +608,30 @@ typedef struct CXLMemECSWriteAttrs {
     CXLMemECSFRUWriteAttrs fru_attrs[CXL_ECS_NUM_MEDIA_FRUS];
 } QEMU_PACKED CXLMemECSWriteAttrs;
 
+/*
+ * CXL r3.2 section 8.2.10.7.2.3, Table 8-134 and 8-135:
+ * Memory Sparing Feature Readable/Writable Attributes
+ */
+typedef struct CXLMemSparingReadAttrs {
+    uint8_t max_maint_latency;
+    uint16_t op_caps;
+    uint16_t op_mode;
+    uint8_t maint_op_class;
+    uint8_t maint_op_subclass;
+    uint8_t rsvd[10];
+    uint16_t restriction_flags;
+} QEMU_PACKED CXLMemSparingReadAttrs;
+
+typedef struct CXLMemSparingWriteAttrs {
+    uint16_t op_mode;
+} QEMU_PACKED CXLMemSparingWriteAttrs;
+
+#define CXL_MEMDEV_SPARING_GET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_SPARING_SET_FEATURE_VERSION    0x01
+#define CXL_MEMDEV_SPARING_SAFE_IN_USE_FLAG    BIT(0)
+#define CXL_MEMDEV_HARD_SPARING_SUPPORT_FLAG    BIT(1)
+#define CXL_MEMDEV_SOFT_SPARING_SUPPORT_FLAG    BIT(2)
+
 #define DCD_MAX_NUM_REGION 8
 
 typedef struct CXLDCExtentRaw {
@@ -735,6 +759,15 @@ struct CXLType3Dev {
     /* ECS control attributes */
     CXLMemECSReadAttrs ecs_attrs;
     CXLMemECSWriteAttrs ecs_wr_attrs;
+    /* Memory Sparing control attributes */
+    CXLMemSparingReadAttrs cacheline_sparing_attrs;
+    CXLMemSparingWriteAttrs cacheline_sparing_wr_attrs;
+    CXLMemSparingReadAttrs row_sparing_attrs;
+    CXLMemSparingWriteAttrs row_sparing_wr_attrs;
+    CXLMemSparingReadAttrs bank_sparing_attrs;
+    CXLMemSparingWriteAttrs bank_sparing_wr_attrs;
+    CXLMemSparingReadAttrs rank_sparing_attrs;
+    CXLMemSparingWriteAttrs rank_sparing_wr_attrs;
 
     struct dynamic_capacity {
         HostMemoryBackend *host_dc;
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 3052bc9f18..89f6aad531 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -223,6 +223,11 @@ typedef enum CXLDCEventType {
  * CXL r3.2 section Table 8-60: Memory Sparing Event Record
  * All fields little endian.
  */
+
+#define CXL_MSER_FLAGS_QUERY_RESOURCES BIT(0)
+#define CXL_MSER_FLAGS_HARD_SPARING BIT(1)
+#define CXL_MSER_FLAGS_DEV_INITIATED BIT(2)
+
 #define CXL_MSER_VALID_CHANNEL BIT(0)
 #define CXL_MSER_VALID_RANK BIT(1)
 #define CXL_MSER_VALID_NIB_MASK BIT(2)
-- 
2.43.0

