Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C702F25A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706682; cv=none; b=NCAgx7JifJTZdu1j6nMrVUIpIONwv94BncgLDZT2KlLeRJ6ZtBb2G0ifQbo/zARL8lr/4suSLB/nSH8XjVb1eRBFG1hAEANtjsbsdkBtgcsmT4UPMOgwPoVuc/qHo5fzFGm3CZe0uk61BNXAgeSEvRPwL0TR2M93kxsZRkfDs9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706682; c=relaxed/simple;
	bh=sUSnSN+jZ+9rwsBbHRUth3BPnecu5WDmFpXyZzQn4TE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/qtFMrQTuk7v3Bk5mhHvnrl+4mfg2A1fYZwcNMt8HrL4WgCGmRZseTKQHmn6RZF+kN195B0fYSWszZcqqrL1kKcz5pCthHuScZLjp9gQ06hQKNN0o7/foD0mSn1SwcVoGY+ktmTWqy/T1sPmnJV2u0qOQR/0MhRGQTAWamlsVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27E86C4CEDF;
	Tue,  4 Feb 2025 22:04:40 +0000 (UTC)
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
Subject: [PATCH v3 03/16] cxl: Add Get Supported Features command for kernel usage
Date: Tue,  4 Feb 2025 15:03:04 -0700
Message-ID: <20250204220430.4146187-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204220430.4146187-1-dave.jiang@intel.com>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CXL spec r3.2 8.2.9.6.1 Get Supported Features (Opcode 0500h)
The command retrieve the list of supported device-specific features
(identified by UUID) and general information about each Feature.

The driver will retrieve the feature entries in order to make checks and
provide information for the Get Feature and Set Feature command. One of
the main piece of information retrieved are the effects a Set Feature
command would have for a particular feature.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Use struct_size() instead of open coding the calculation. (Jonathan)
---
 drivers/cxl/features.c | 138 +++++++++++++++++++++++++++++++++++++++++
 include/cxl/features.h |  57 +++++++++++++++++
 2 files changed, 195 insertions(+)

diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 958e4828a58d..4d8c603121f0 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -7,6 +7,139 @@
 #include "cxlmem.h"
 #include "features.h"
 
+static void cxl_free_feature_entries(void *entries)
+{
+	kvfree(entries);
+}
+
+static int cxl_get_supported_features_count(struct cxl_mailbox *cxl_mbox)
+{
+	struct cxl_mbox_get_sup_feats_out mbox_out;
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	struct cxl_mbox_cmd mbox_cmd;
+	int rc;
+
+	memset(&mbox_in, 0, sizeof(mbox_in));
+	mbox_in.count = cpu_to_le32(sizeof(mbox_out));
+	memset(&mbox_out, 0, sizeof(mbox_out));
+	mbox_cmd = (struct cxl_mbox_cmd) {
+		.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+		.size_in = sizeof(mbox_in),
+		.payload_in = &mbox_in,
+		.size_out = sizeof(mbox_out),
+		.payload_out = &mbox_out,
+		.min_out = sizeof(mbox_out),
+	};
+	rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+	if (rc < 0)
+		return rc;
+
+	return le16_to_cpu(mbox_out.supported_feats);
+}
+
+static int get_supported_features(struct cxl_memdev *cxlmd,
+				  struct cxl_features_state *cxlfs)
+{
+	int remain_feats, max_size, max_feats, start, rc, hdr_size;
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	int feat_size = sizeof(struct cxl_feat_entry);
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	struct cxl_feat_entry *entry;
+	struct cxl_mbox_cmd mbox_cmd;
+	int count;
+
+	if (cxlfs->cap < CXL_FEATURES_RO)
+		return -EOPNOTSUPP;
+
+	count = cxl_get_supported_features_count(cxl_mbox);
+	if (count == 0)
+		return -ENOENT;
+	if (count < 0)
+		return -ENXIO;
+
+	struct cxl_feat_entry *entries __free(kvfree) =
+		kvmalloc(count * sizeof(*entries), GFP_KERNEL);
+	if (!entries)
+		return -ENOMEM;
+
+	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) =
+		kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!mbox_out)
+		return -ENOMEM;
+
+	hdr_size = struct_size(mbox_out, ents, 0);
+	max_size = cxl_mbox->payload_size - hdr_size;
+	/* max feat entries that can fit in mailbox max payload size */
+	max_feats = max_size / feat_size;
+	entry = entries;
+
+	start = 0;
+	remain_feats = count;
+	do {
+		int retrieved, alloc_size, copy_feats;
+		int num_entries;
+
+		if (remain_feats > max_feats) {
+			alloc_size = struct_size(mbox_out, ents, max_feats);
+			remain_feats = remain_feats - max_feats;
+			copy_feats = max_feats;
+		} else {
+			alloc_size = struct_size(mbox_out, ents, remain_feats);
+			copy_feats = remain_feats;
+			remain_feats = 0;
+		}
+
+		memset(&mbox_in, 0, sizeof(mbox_in));
+		mbox_in.count = cpu_to_le32(alloc_size);
+		mbox_in.start_idx = cpu_to_le16(start);
+		memset(mbox_out, 0, alloc_size);
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+			.size_in = sizeof(mbox_in),
+			.payload_in = &mbox_in,
+			.size_out = alloc_size,
+			.payload_out = mbox_out,
+			.min_out = hdr_size,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		if (mbox_cmd.size_out <= hdr_size)
+			return -ENXIO;
+
+		/*
+		 * Make sure retrieved out buffer is multiple of feature
+		 * entries.
+		 */
+		retrieved = mbox_cmd.size_out - hdr_size;
+		if (retrieved % feat_size)
+			return -ENXIO;
+
+		num_entries = le16_to_cpu(mbox_out->num_entries);
+		/*
+		 * If the reported output entries * defined entry size !=
+		 * retrieved output bytes, then the output package is incorrect.
+		 */
+		if (num_entries * feat_size != retrieved)
+			return -ENXIO;
+
+		memcpy(entry, mbox_out->ents, retrieved);
+		entry++;
+		/*
+		 * If the number of output entries is less than expected, add the
+		 * remaining entries to the next batch.
+		 */
+		remain_feats += copy_feats - num_entries;
+		start += num_entries;
+	} while (remain_feats);
+
+	cxlfs->num_features = count;
+	cxlfs->entries = no_free_ptr(entries);
+	return devm_add_action_or_reset(&cxlmd->dev, cxl_free_feature_entries,
+					cxlfs->entries);
+}
+
 static void enumerate_feature_cmds(struct cxl_memdev *cxlmd,
 				   struct cxl_features_state *cxlfs)
 {
@@ -77,12 +210,17 @@ DEFINE_FREE(cxl_free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(
  */
 int devm_cxl_add_features(struct cxl_memdev *cxlmd)
 {
+	int rc;
+
 	struct cxl_features_state *cxlfs __free(cxl_free_cxlfs) =
 		devm_cxlfs_allocate(cxlmd);
 	if (!cxlfs)
 		return -ENOMEM;
 
 	enumerate_feature_cmds(cxlmd, cxlfs);
+	rc = get_supported_features(cxlmd, cxlfs);
+	if (rc)
+		return rc;
 
 	cxlmd->cxlfs = no_free_ptr(cxlfs);
 
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 8e1830f0ccba..c65760342f97 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -3,6 +3,8 @@
 #ifndef __CXL_FEATURES_H__
 #define __CXL_FEATURES_H__
 
+#include <linux/uuid.h>
+
 struct cxl_mailbox;
 
 /* Index IDs for CXL mailbox Feature commands */
@@ -25,11 +27,66 @@ enum cxl_features_capability {
  * @cxlmd: Pointer to cxl mem device
  * @cap: Feature commands capability
  * @num_features: total Features supported by the device
+ * @entries: Feature detail entries fetched from the device
  */
 struct cxl_features_state {
 	struct cxl_memdev *cxlmd;
 	enum cxl_features_capability cap;
 	int num_features;
+	struct cxl_feat_entry *entries;
 };
 
+/* Get Supported Features (0x500h) CXL r3.2 8.2.9.6.1 */
+struct cxl_mbox_get_sup_feats_in {
+	__le32 count;
+	__le16 start_idx;
+	u8 reserved[2];
+} __packed;
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
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 effects;
+	u8 reserved[18];
+} __packed;
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
+	u8 reserved[4];
+	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
+} __packed;
+
 #endif
-- 
2.48.1

