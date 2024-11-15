Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE1341E283E
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706071; cv=none; b=Yd7uITWGCBAEwmtMjgPkjqS+V2MOzW5BspTgB0CoCS+eUt2JsHK5NRRfJMpc6l5xlNBznQj+Eq4gHqw9oTYZlU+mFqSGQNNfjwgi6avCkAw4ax0i/wYCBxSbIe221EGHJKx8pM8KuymOMDvLkabggZkb+ZWLq8aahUC0bR+KZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706071; c=relaxed/simple;
	bh=aXs2FCLNzmX8sLkqu9yB6CPfRgIx+6f/6EOCt/B9d8o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hb4G6xSu1QR/DDpjWVgCwNnzjAVsxhuKVBJ6QtghwYMtaNqEN7McKFZt6Tvb+mZcFk9RLL7a+BDURHnXFeKi9LLTm3QpxMugsHgGqsamQAeKWkEABKbsHo6RFeIj5iSLmD4Di9J3oEgPb2aEBiY47NB+7xBBVSaSjZkLWw2E7IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24028C4CECF;
	Fri, 15 Nov 2024 21:27:51 +0000 (UTC)
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
Subject: [RFC PATCH v2 02/20] cxl: Add Get Supported Features command for kernel usage
Date: Fri, 15 Nov 2024 14:25:35 -0700
Message-ID: <20241115212745.869552-3-dave.jiang@intel.com>
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

CXL spec r3.1 8.2.9.6.1 Get Supported Features (Opcode 0500h)
The command retrieve the list of supported device-specific features
(identified by UUID) and general information about each Feature.

The driver will retrieve the feature entries in order to make checks and
provide information for the Get Feature and Set Feature command. One of
the main piece of information retrieved are the effects a Set Feature
command would have for a particular feature.

Co-developed-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---

v2:
- fix feature entry pointer math.
- free mbox_out in cxl_get_supported_features(). (Shiju, Jonathan)
- replace sizeof(struct) with feat_size. (Shiju)
- replace reserved in feature structs with u8 type. (Shiju)
- change cxl_feat_entry->effects to set_effects. (Shiju)
- rearrange assigment of cxl_mbox->entries. (Jonathan)
- Separate no features from actual error. (Jonathan)
- Fix missing kdoc for entries. (Jonathan)
---
 drivers/cxl/core/mbox.c      | 178 +++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h         |  31 ++++++
 drivers/cxl/pci.c            |   4 +
 include/cxl/mailbox.h        |   4 +
 include/uapi/linux/cxl_mem.h |   1 +
 5 files changed, 218 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 880ac1dba3cc..4ba56f3d5a65 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -67,6 +67,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
+	CXL_CMD(GET_SUPPORTED_FEATURES, 0x8, CXL_VARIABLE_PAYLOAD, 0),
 };
 
 /*
@@ -790,6 +791,183 @@ static const uuid_t log_uuid[] = {
 	[VENDOR_DEBUG_UUID] = DEFINE_CXL_VENDOR_DEBUG_UUID,
 };
 
+static void cxl_free_features(void *features)
+{
+	kvfree(features);
+}
+
+static int cxl_get_supported_features_count(struct cxl_dev_state *cxlds)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
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
+	cxl_mbox->num_features = le16_to_cpu(mbox_out.supported_feats);
+
+	return 0;
+}
+
+int cxl_get_supported_features(struct cxl_dev_state *cxlds)
+{
+	struct cxl_mbox_get_sup_feats_out *mbox_out __free(kvfree) = NULL;
+	int remain_feats, max_size, max_feats, start, rc;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	int feat_size = sizeof(struct cxl_feat_entry);
+	struct cxl_mbox_get_sup_feats_in mbox_in;
+	int hdr_size = sizeof(*mbox_out);
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mem_command *cmd;
+	struct cxl_feat_entry *entry;
+
+	/* Get supported features is optional, need to check */
+	cmd = cxl_mem_find_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
+	if (!cmd)
+		return -EOPNOTSUPP;
+	if (!test_bit(cmd->info.id, cxl_mbox->enabled_cmds))
+		return -EOPNOTSUPP;
+
+	rc = cxl_get_supported_features_count(cxlds);
+	if (rc)
+		return rc;
+
+	if (!cxl_mbox->num_features) {
+		dev_dbg(cxl_mbox->host, "No CXL features enumerated.\n");
+		return 0;
+	}
+
+	struct cxl_feat_entry *entries __free(kvfree) =
+		kvmalloc(cxl_mbox->num_features * feat_size, GFP_KERNEL);
+
+	if (!entries)
+		return -ENOMEM;
+
+	max_size = cxl_mbox->payload_size - hdr_size;
+	/* max feat entries that can fit in mailbox max payload size */
+	max_feats = max_size / feat_size;
+	entry = &entries[0];
+
+	mbox_out = kvmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!mbox_out)
+		return -ENOMEM;
+
+	start = 0;
+	remain_feats = cxl_mbox->num_features;
+	do {
+		int retrieved, alloc_size, copy_feats;
+		int num_entries;
+
+		if (remain_feats > max_feats) {
+			alloc_size = sizeof(*mbox_out) + max_feats * feat_size;
+			remain_feats = remain_feats - max_feats;
+			copy_feats = max_feats;
+		} else {
+			alloc_size = sizeof(*mbox_out) + remain_feats * feat_size;
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
+		if (mbox_cmd.size_out <= hdr_size) {
+			rc = -ENXIO;
+			goto err;
+		}
+
+		/*
+		 * Make sure retrieved out buffer is multiple of feature
+		 * entries.
+		 */
+		retrieved = mbox_cmd.size_out - hdr_size;
+		if (retrieved % feat_size) {
+			rc = -ENXIO;
+			goto err;
+		}
+
+		num_entries = le16_to_cpu(mbox_out->num_entries);
+		/*
+		 * If the reported output entries * defined entry size !=
+		 * retrieved output bytes, then the output package is incorrect.
+		 */
+		if (num_entries * feat_size != retrieved) {
+			rc = -ENXIO;
+			goto err;
+		}
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
+	cxl_mbox->entries = no_free_ptr(entries);
+	rc = devm_add_action_or_reset(cxl_mbox->host, cxl_free_features,
+				      cxl_mbox->entries);
+	if (rc)
+		return rc;
+
+	return 0;
+
+err:
+	cxl_mbox->num_features = 0;
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_features, CXL);
+
+int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
+				    struct cxl_feat_entry *feat_entry_out)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_feat_entry *feat_entry;
+	int count;
+
+	/* Check CXL dev supports the feature */
+	feat_entry = &cxl_mbox->entries[0];
+	for (count = 0; count < cxl_mbox->num_features; count++, feat_entry++) {
+		if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
+			memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
+			return 0;
+		}
+	}
+
+	return -EOPNOTSUPP;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0a49809cd76..6685dd76985a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -490,6 +490,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -773,6 +774,32 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
+/* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
+struct cxl_mbox_get_sup_feats_in {
+	__le32 count;
+	__le16 start_idx;
+	u8 reserved[2];
+} __packed;
+
+struct cxl_feat_entry {
+	uuid_t uuid;
+	__le16 id;
+	__le16 get_feat_size;
+	__le16 set_feat_size;
+	__le32 flags;
+	u8 get_feat_ver;
+	u8 set_feat_ver;
+	__le16 set_effects;
+	u8 reserved[18];
+} __packed;
+
+struct cxl_mbox_get_sup_feats_out {
+	__le16 num_entries;
+	__le16 supported_feats;
+	u8 reserved[4];
+	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
+} __packed;
+
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -832,4 +859,8 @@ struct cxl_hdm {
 struct seq_file;
 struct dentry *cxl_debugfs_create_dir(const char *dir);
 void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
+
+int cxl_get_supported_features(struct cxl_dev_state *cxlds);
+int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
+				    struct cxl_feat_entry *feat_entry_out);
 #endif /* __CXL_MEM_H__ */
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..cbb86ecf0e2f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -887,6 +887,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_get_supported_features(cxlds);
+	if (rc)
+		dev_dbg(&pdev->dev, "No features enumerated.\n");
+
 	rc = cxl_set_timestamp(mds);
 	if (rc)
 		return rc;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index cc894f07a435..03c4b8ad84c1 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -50,6 +50,8 @@ struct cxl_mbox_cmd {
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
+ * @num_features: number of supported features entries
+ * @features: list of supported feature entries
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  */
 struct cxl_mailbox {
@@ -59,6 +61,8 @@ struct cxl_mailbox {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
+	int num_features;
+	struct cxl_feat_entry *entries;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index c6c0fe27495d..bd2535962f70 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -50,6 +50,7 @@
 	___C(GET_LOG_CAPS, "Get Log Capabilities"),			  \
 	___C(CLEAR_LOG, "Clear Log"),					  \
 	___C(GET_SUP_LOG_SUBLIST, "Get Supported Logs Sub-List"),	  \
+	___C(GET_SUPPORTED_FEATURES, "Get Supported Features"),		  \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.47.0

