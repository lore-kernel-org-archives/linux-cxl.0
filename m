Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CEE81FB733
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706091; cv=none; b=tR4nLKYAgQU8EWl264Gk+Na0k6ytTDF4dmeORQXEVq/M0tFyYzgDwQVOifsGknOOGT3l+0OUX1QXLK4cCnNsdtsCGaon9ZX9cXZ9TW+xtO9bAvr0rum++maRJhJCjsMb2kV5HD6P/m1mSHbmWYdtt72dOKIddIi18zB/oRctE10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706091; c=relaxed/simple;
	bh=0pUxAN0rBFPf5K0jx1ZADdSpz4O3Cax0rtRrjZ05JV4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hKszRttAmDUUWeIm0Us188GeA/69LSo40uHbI73rlIGjVH4G0hLWKpElVxLwqTo2J5qCWJs0SdzwpRGFiwk/nbrwiFyr0itIXyVXHGEs9byVoOUvc1HjzZkWZ9EwnLqv6znSonf2Sgmm1Ams6cXydgRqeRlra5Rv7TGvtN8iacA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD550C4CECF;
	Fri, 15 Nov 2024 21:28:10 +0000 (UTC)
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
Subject: [RFC PATCH v2 16/20] fwctl/cxl: Add support to filter exclusive features
Date: Fri, 15 Nov 2024 14:25:49 -0700
Message-ID: <20241115212745.869552-17-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support to allow filtering of CXL features that are exclusive to the
kernel and make them not visible to user space. The "get supported
features" mailbox command returned to the userspace is emulated and
will skip the features that is marked exclusive for the kernel. The
exclusion allows certain the feature setting of certain commands such
as claimed by RAS to be exclusive to the kernel.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 115 ++++++++++++++++++++++++++++++++++++----
 drivers/fwctl/cxl/cxl.c |   7 +--
 include/cxl/features.h  |  52 ++++++++++++++++++
 include/cxl/mailbox.h   |   8 ++-
 4 files changed, 168 insertions(+), 14 deletions(-)
 create mode 100644 include/cxl/features.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index e7c5c709ac79..12ace2951f7c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -5,6 +5,7 @@
 #include <linux/ktime.h>
 #include <linux/mutex.h>
 #include <linux/unaligned.h>
+#include <cxl/features.h>
 #include <cxl/mailbox.h>
 #include <cxlpci.h>
 #include <cxlmem.h>
@@ -897,6 +898,78 @@ static int handle_mailbox_cmd_from_fwctl(struct cxl_mailbox *cxl_mbox,
 	return 0;
 }
 
+/*
+ * Emulate the 'get supported features' mailbox command and only copy out the
+ * features that are not marked as exclusive for kernel.
+ */
+static void cxl_mbox_get_supported_features_filtered(struct cxl_mailbox *cxl_mbox,
+						     struct cxl_mbox_cmd *mbox_cmd)
+{
+	struct cxl_mbox_get_sup_feats_in *feat_in = mbox_cmd->payload_in;
+	struct cxl_mbox_get_sup_feats_out *feat_out = mbox_cmd->payload_out;
+	const int feat_out_size = sizeof(*feat_out);
+	struct cxl_feat_entry *pos;
+	const int feat_ent_size = sizeof(*pos);
+	int out_count, ents, u;
+	u32 count;
+	u16 start;
+
+	count = le32_to_cpu(feat_in->count);
+	start = le16_to_cpu(feat_in->start_idx);
+	ents = count / sizeof(struct cxl_feat_entry);
+	ents -= start;
+	if (ents < 0) {
+		mbox_cmd->size_out = 0;
+		mbox_cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return;
+	}
+
+	if (mbox_cmd->size_out < feat_out_size) {
+		mbox_cmd->size_out = 0;
+		mbox_cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return;
+	}
+
+	feat_out->supported_feats =
+		cpu_to_le16(cxl_mbox->num_user_feats);
+	if (ents == 0) {
+		feat_out->num_entries = cpu_to_le16(0);
+		mbox_cmd->size_out = feat_out_size;
+		mbox_cmd->return_code = CXL_MBOX_CMD_RC_SUCCESS;
+		return;
+	}
+
+	pos = &feat_out->ents[0];
+	out_count = feat_out_size;
+	for (int i = 0, u = 0; i < cxl_mbox->num_features; i++) {
+		struct cxl_feature *feat = &cxl_mbox->entries[i];
+
+		if (feat->exclusive)
+			continue;
+
+		if (u < start) {
+			u++;
+			continue;
+		}
+
+		memcpy(pos, &feat->entry, feat_ent_size);
+		out_count += feat_ent_size;
+		pos++;
+		u++;
+
+		if (u == count)
+			break;
+
+		/* Make sure it does not go over total output buffer size */
+		if (out_count + feat_ent_size >= mbox_cmd->size_out)
+			break;
+	}
+
+	feat_out->num_entries = cpu_to_le16(u);
+	mbox_cmd->size_out = out_count;
+	mbox_cmd->return_code = CXL_MBOX_CMD_RC_SUCCESS;
+}
+
 int cxl_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		      struct fwctl_rpc_cxl *rpc_in,
 		      struct cxl_mbox_cmd *mbox_cmd, size_t *out_len)
@@ -925,9 +998,13 @@ int cxl_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		return rc;
 
 	guard(rwsem_read)(&cxl_memdev_rwsem);
-	rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
-	if (rc)
-		return rc;
+	if (send_cmd.raw.opcode != CXL_MBOX_OP_GET_SUPPORTED_FEATURES) {
+		rc = cxl_mbox->mbox_send(cxl_mbox, mbox_cmd);
+		if (rc)
+			return rc;
+	} else {
+		cxl_mbox_get_supported_features_filtered(cxl_mbox, mbox_cmd);
+	}
 
 	*out_len = mbox_cmd->size_out;
 
@@ -1128,6 +1205,18 @@ static int cxl_get_supported_features_count(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static bool is_feature_exclusive(struct cxl_feature *feat)
+{
+	int i;
+
+	for (i = 0; i < CXL_FEAT_UUID_MAX; i++) {
+		if (uuid_equal(&feat->entry.uuid, &cxl_exclusive_feats[i]))
+			return true;
+	}
+
+	return false;
+}
+
 int cxl_get_supported_features(struct cxl_dev_state *cxlds)
 {
 	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) = NULL;
@@ -1138,7 +1227,7 @@ int cxl_get_supported_features(struct cxl_dev_state *cxlds)
 	int hdr_size = sizeof(*mbox_out);
 	struct cxl_mbox_cmd mbox_cmd;
 	struct cxl_mem_command *cmd;
-	struct cxl_feat_entry *entry;
+	struct cxl_feature *feat;
 
 	/* Get supported features is optional, need to check */
 	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
@@ -1156,7 +1245,7 @@ int cxl_get_supported_features(struct cxl_dev_state *cxlds)
 		return 0;
 	}
 
-	struct cxl_feat_entry *entries __free(kvfree) =
+	struct cxl_feature *entries __free(kvfree) =
 		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
 
 	if (!entries)
@@ -1165,7 +1254,7 @@ int cxl_get_supported_features(struct cxl_dev_state *cxlds)
 	max_size = cxl_mbox->payload_size - hdr_size;
 	/* max feat entries that can fit in mailbox max payload size */
 	max_feats = max_size / feat_size;
-	entry = &entries[0];
+	feat = &entries[0];
 
 	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
 	if (!mbox_out)
@@ -1228,8 +1317,13 @@ int cxl_get_supported_features(struct cxl_dev_state *cxlds)
 			goto err;
 		}
 
-		memcpy(entry, mbox_out->ents, retrieved);
-		entry++;
+		memcpy(&feat->entry, mbox_out->ents, retrieved);
+		if (is_feature_exclusive(feat))
+			feat->exclusive = true;
+		else
+			cxl_mbox->num_user_feats++;
+		feat++;
+
 		/*
 		 * If the number of output entries is less than expected, add the
 		 * remaining entries to the next batch.
@@ -1256,13 +1350,14 @@ int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *f
 				    struct cxl_feat_entry *feat_entry_out)
 {
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
-	struct cxl_feat_entry *feat_entry;
+	struct cxl_feature *feat_entry;
 	int count;
 
 	/* Check CXL dev supports the feature */
 	feat_entry = &cxl_mbox->entries[0];
 	for (count = 0; count < cxl_mbox->num_features; count++, feat_entry++) {
-		if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+		if (uuid_equal(&feat_entry->entry.uuid, feat_uuid) &&
+		    !is_feature_exclusive(feat_entry)) {
 			memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
 			return 0;
 		}
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index 164f6774a2c1..3915a59c7408 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -81,7 +81,7 @@ static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
 					 const struct fwctl_rpc_cxl *rpc_in,
 					 enum fwctl_rpc_scope scope)
 {
-	struct cxl_feat_entry *feat;
+	struct cxl_feature *feat;
 	bool found = false;
 	uuid_t uuid;
 	u16 effects, mask;
@@ -95,7 +95,8 @@ static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
 
 	for (int i = 0; i < cxl_mbox->num_features; i++) {
 		feat = &cxl_mbox->entries[i];
-		if (uuid_equal(&uuid, &feat->uuid)) {
+		if (uuid_equal(&uuid, &feat->entry.uuid) &&
+		    !feat->exclusive) {
 			found = true;
 			break;
 		}
@@ -104,7 +105,7 @@ static bool cxlctl_validate_set_features(struct cxl_mailbox *cxl_mbox,
 	if (!found)
 		return false;
 
-	effects = le16_to_cpu(feat->effects);
+	effects = le16_to_cpu(feat->entry.effects);
 	/* Currently no user background command support */
 	if (effects & CXL_CMD_BACKGROUND)
 		return false;
diff --git a/include/cxl/features.h b/include/cxl/features.h
new file mode 100644
index 000000000000..6074a3f79d70
--- /dev/null
+++ b/include/cxl/features.h
@@ -0,0 +1,52 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024 Intel Corporation. */
+#ifndef __CXL_FEATS_H_
+#define __CXL_FEATS_H_
+
+#include <linux/uuid.h>
+
+#define CXL_FEAT_PATROL_SCRUB_UUID						\
+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,	\
+		  0x06, 0xdb, 0x8a)
+
+#define CXL_FEAT_ECS_UUID							\
+	UUID_INIT(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba, 0xb9, 0x69, 0x1e,	\
+		  0x89, 0x33, 0x86)
+
+#define CXL_FEAT_SPPR_UUID							\
+	UUID_INIT(0x892ba475, 0xfad8, 0x474e, 0x9d, 0x3e, 0x69, 0x2c, 0x91,	\
+		  0x75, 0x68, 0xbb)
+
+#define CXL_FEAT_HPPR_UUID							\
+	UUID_INIT(0x80ea4521, 0x786f, 0x4127, 0xaf, 0xb1, 0xec, 0x74, 0x59,	\
+		  0xfb, 0x0e, 0x24)
+
+#define CXL_FEAT_CACHELINE_SPARING_UUID						\
+	UUID_INIT(0x96C33386, 0x91dd, 0x44c7, 0x9e, 0xcb, 0xfd, 0xaf, 0x65,	\
+		  0x03, 0xba, 0xc4)
+
+#define CXL_FEAT_ROW_SPARING_UUID						\
+	UUID_INIT(0x450ebf67, 0xb135, 0x4f97, 0xa4, 0x98, 0xc2, 0xd5, 0x7f,	\
+		  0x27, 0x9b, 0xed)
+
+#define CXL_FEAT_BANK_SPARING_UUID						\
+	UUID_INIT(0x78b79636, 0x90ac, 0x4b64, 0xa4, 0xef, 0xfa, 0xac, 0x5d,	\
+		  0x18, 0xa8, 0x63)
+
+#define CXL_FEAT_RANK_SPARING_UUID						\
+	UUID_INIT(0x34dbaff5, 0x0552, 0x4281, 0x8f, 0x76, 0xda, 0x0b, 0x5e,	\
+		  0x7a, 0x76, 0xa7)
+
+#define CXL_FEAT_UUID_MAX	8
+static uuid_t cxl_exclusive_feats[CXL_FEAT_UUID_MAX] = {
+	CXL_FEAT_PATROL_SCRUB_UUID,
+	CXL_FEAT_ECS_UUID,
+	CXL_FEAT_SPPR_UUID,
+	CXL_FEAT_HPPR_UUID,
+	CXL_FEAT_CACHELINE_SPARING_UUID,
+	CXL_FEAT_ROW_SPARING_UUID,
+	CXL_FEAT_BANK_SPARING_UUID,
+	CXL_FEAT_RANK_SPARING_UUID,
+};
+
+#endif
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 3e5e9c9362f5..f44ac93ebdf4 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -80,7 +80,8 @@ struct cxl_mailbox {
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
 	int num_features;
-	struct cxl_feat_entry *entries;
+	int num_user_feats;
+	struct cxl_feature *entries;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 };
 
@@ -165,6 +166,11 @@ struct cxl_feat_entry {
 	u8 reserved[18];
 } __packed;
 
+struct cxl_feature {
+	bool exclusive;
+	struct cxl_feat_entry entry;
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
-- 
2.47.0

