Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92D80A920
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370716; cv=none; b=KNQzsBbA+QbwGRuJQdfZCmExmYvtGFByEM1m/ECwQyt6KDCZj+jkwmnKbfWWS0TFrfw2VFgGP/lR9RmVMd/XkCx5mItnm/EqD1+cXAh/Xhux1XuqyBx06SbAUC3f/u33rsiooK6c9+8jMUA5B8wsrNShtz9Q/R85I6rNfCrs1PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370716; c=relaxed/simple;
	bh=x6E3wQTvjW9IGeqJIHlOThUKmgElwH+nfW26vhGHSPE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LngO5yAkpJEQiBZ7+xPqVKcSioz9Ubliy/CbQVMTQ48QYABpE5JmQoqReUHGYbNMmsa5u4JVlRTPrpxKZC/lQSeccuKDhu//9QVNlkg1q5uBp4s6qb+x0JU0cevC1kuWP97OkaAMUYX/WIuOSKl0jNUJXbL3gIqogTtYraKRsnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B81C4CED1;
	Sat,  1 Feb 2025 00:45:16 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com
Subject: [PATCH v2 10/16] cxl: Move cxl feature command structs to user header
Date: Fri, 31 Jan 2025 17:42:03 -0700
Message-ID: <20250201004459.466499-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201004459.466499-1-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In preparation for cxl fwctl enabling, move data structures related to
cxl feature commands to a user header file.

Reviewed-by; Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 include/cxl/features.h      | 107 +------------------------------
 include/uapi/cxl/features.h | 122 ++++++++++++++++++++++++++++++++++++
 2 files changed, 123 insertions(+), 106 deletions(-)
 create mode 100644 include/uapi/cxl/features.h

diff --git a/include/cxl/features.h b/include/cxl/features.h
index 7c43ac021a8c..eb13d7ee64f0 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -5,6 +5,7 @@
 
 #include <linux/uuid.h>
 #include <linux/fwctl.h>
+#include <uapi/cxl/features.h>
 
 /* Feature UUIDs used by the kernel */
 #define CXL_FEAT_PATROL_SCRUB_UUID						\
@@ -74,112 +75,6 @@ struct cxl_features_state {
 	struct cxl_feat_entry *entries;
 };
 
-/* Get Supported Features (0x500h) CXL r3.2 8.2.9.6.1 */
-struct cxl_mbox_get_sup_feats_in {
-	__le32 count;
-	__le16 start_idx;
-	u8 reserved[2];
-} __packed;
-
-/* CXL spec r3.2 Table 8-87 command effects */
-#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
-#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
-#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
-#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
-#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
-#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
-#define CXL_CMD_BACKGROUND			BIT(6)
-#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
-#define CXL_CMD_EFFECTS_VALID			BIT(9)
-#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
-#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
-
-/*
- * CXL spec r3.2 Table 8-109
- * Get Supported Features Supported Feature Entry
- */
-struct cxl_feat_entry {
-	uuid_t uuid;
-	__le16 id;
-	__le16 get_feat_size;
-	__le16 set_feat_size;
-	__le32 flags;
-	u8 get_feat_ver;
-	u8 set_feat_ver;
-	__le16 effects;
-	u8 reserved[18];
-} __packed;
-
-/* @flags field for 'struct cxl_feat_entry' */
-#define CXL_FEATURE_F_CHANGEABLE		BIT(0)
-#define CXL_FEATURE_F_PERSIST_FW_UPDATE		BIT(4)
-#define CXL_FEATURE_F_DEFAULT_SEL		BIT(5)
-#define CXL_FEATURE_F_SAVED_SEL			BIT(6)
-
-/*
- * CXL spec r3.2 Table 8-108
- * Get supported Features Output Payload
- */
-struct cxl_mbox_get_sup_feats_out {
-	__le16 num_entries;
-	__le16 supported_feats;
-	u8 reserved[4];
-	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
-} __packed;
-
-/*
- * Get Feature CXL spec r3.2 Spec 8.2.9.6.2
- */
-
-/*
- * Get Feature input payload
- * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
- */
-struct cxl_mbox_get_feat_in {
-	uuid_t uuid;
-	__le16 offset;
-	__le16 count;
-	u8 selection;
-}  __packed;
-
-/* Selection field for 'struct cxl_mbox_get_feat_in' */
-enum cxl_get_feat_selection {
-	CXL_GET_FEAT_SEL_CURRENT_VALUE,
-	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
-	CXL_GET_FEAT_SEL_SAVED_VALUE,
-	CXL_GET_FEAT_SEL_MAX
-};
-
-/*
- * Set Feature CXL spec r3.2  8.2.9.6.3
- */
-
-/*
- * Set Feature input payload
- * CXL spec r3.2 section 8.2.9.6.3 Table 8-101
- */
-struct cxl_mbox_set_feat_hdr {
-	uuid_t uuid;
-	__le32 flags;
-	__le16 offset;
-	u8 version;
-	u8 rsvd[9];
-}  __packed;
-
-/* Set Feature flags field */
-enum cxl_set_feat_flag_data_transfer {
-	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0,
-	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
-	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
-	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
-	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
-	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
-};
-
-#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
-
-#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
-
 struct cxl_mailbox;
 size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
new file mode 100644
index 000000000000..2e98efb9abf1
--- /dev/null
+++ b/include/uapi/cxl/features.h
@@ -0,0 +1,122 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024,2025, Intel Corporation
+ *
+ * These are definitions for the mailbox command interface of CXL subsystem.
+ */
+#ifndef _UAPI_CXL_FEATURES_H_
+#define _UAPI_CXL_FEATURES_H_
+
+#include <linux/types.h>
+#ifndef __KERNEL__
+#include <uuid/uuid.h>
+#else
+#include <linux/uuid.h>
+#endif
+
+/* Get Supported Features (0x500h) CXL r3.2 8.2.9.6.1 */
+struct cxl_mbox_get_sup_feats_in {
+	__le32 count;
+	__le16 start_idx;
+	__u8 reserved[2];
+} __attribute__ ((__packed__));
+
+/* CXL spec r3.2 Table 8-87 command effects */
+#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
+#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
+#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
+#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
+#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
+#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
+#define CXL_CMD_BACKGROUND			BIT(6)
+#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
+#define CXL_CMD_EFFECTS_VALID			BIT(9)
+#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
+#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
+
+/*
+ * CXL spec r3.2 Table 8-109
+ * Get Supported Features Supported Feature Entry
+ */
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 flags;
+	__u8 get_feat_ver;
+	__u8 set_feat_ver;
+	__le16 effects;
+	__u8 reserved[18];
+} __attribute__ ((__packed__));
+
+/* @flags field for 'struct cxl_feat_entry' */
+#define CXL_FEATURE_F_CHANGEABLE		BIT(0)
+#define CXL_FEATURE_F_PERSIST_FW_UPDATE		BIT(4)
+#define CXL_FEATURE_F_DEFAULT_SEL		BIT(5)
+#define CXL_FEATURE_F_SAVED_SEL			BIT(6)
+
+/*
+ * CXL spec r3.2 Table 8-108
+ * Get supported Features Output Payload
+ */
+struct cxl_mbox_get_sup_feats_out {
+	__le16 num_entries;
+	__le16 supported_feats;
+	__u8 reserved[4];
+	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
+} __attribute__ ((__packed__));
+
+/*
+ * Get Feature CXL spec r3.2 Spec 8.2.9.6.2
+ */
+
+/*
+ * Get Feature input payload
+ * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
+ */
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	__u8 selection;
+} __attribute__ ((__packed__));
+
+/* Selection field for 'struct cxl_mbox_get_feat_in' */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
+	CXL_GET_FEAT_SEL_SAVED_VALUE,
+	CXL_GET_FEAT_SEL_MAX
+};
+
+/*
+ * Set Feature CXL spec r3.2  8.2.9.6.3
+ */
+
+/*
+ * Set Feature input payload
+ * CXL spec r3.2 section 8.2.9.6.3 Table 8-101
+ */
+struct cxl_mbox_set_feat_hdr {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	__u8 version;
+	__u8 rsvd[9];
+} __attribute__ ((__packed__));
+
+/* Set Feature flags field */
+enum cxl_set_feat_flag_data_transfer {
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0,
+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
+};
+
+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK		GENMASK(2, 0)
+#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
+
+#endif
-- 
2.48.1

