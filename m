Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FF471C5D54
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589942; cv=none; b=Jzq5E5tVm8SuApD3DRj0JRTuqSwhFJ3DvlP0FFaWn9ylhQSdAAoRm0MsO0ETNd7ZptKs+4LR4tpuY1LbpHi44pS3YpbOiZuaOOTT0uJmnUsktVdh3pQcrOztIEwGlX+Od/PqD0eVV+tWmYEy8wfIprbcn+fpO/LSiXfqnFBjEP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589942; c=relaxed/simple;
	bh=VXXSaRvuYDO2bdX4ogPUAXl+Tl0K9odGFbx4C7vrZt0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ww0FUQy+fEVWw7xb91DIxWanZUXsD44ybs8K0vrmNkL6iX6bfHz5/J1CFMjQB4AY4NObDmPv23uG4rSNXXND8a0WJvBP8AJE26nSqeINV44oid9NX0PPQItN00CmoJPVaqVV0w9N9srjig3Z0JD2rbCZjLpJpkheVMz07mV/o+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FABC4CED2;
	Wed, 22 Jan 2025 23:52:21 +0000 (UTC)
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
Subject: [PATCH v1 14/19] cxl: Add support for fwctl RPC command to enable CXL feature commands
Date: Wed, 22 Jan 2025 16:50:45 -0700
Message-ID: <20250122235159.2716036-15-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250122235159.2716036-1-dave.jiang@intel.com>
References: <20250122235159.2716036-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
to a device. The cxl fwctl driver will start by supporting the CXL
feature commands: Get Supported Features, Get Feature, and Set Feature.

The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
it indicates the security scope of the call. The Get Supported Features
and Get Feature calls can be executed with the scope of
FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
of the feature reported by Get Supported Features call for the specific
feature.

Only "get supported features" is supported in this patch. Additional
commands will be added in follow on patches. "Get supported features"
will filter the features that are exclusive to the kernel and only
report out features that are not kernel only.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c     |  12 +++
 drivers/cxl/features.c      | 198 +++++++++++++++++++++++++++++++++++-
 include/cxl/features.h      |   1 +
 include/uapi/cxl/features.h |  13 +++
 include/uapi/fwctl/cxl.h    |  29 ++++++
 5 files changed, 250 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 0b4946205910..f818e452dbca 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -246,6 +246,18 @@ struct cxl_mem_command *cxl_find_feature_command(u16 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_find_feature_command, "CXL");
 
+struct cxl_mem_command *cxl_find_feature_command_by_id(u32 id)
+{
+	struct cxl_mem_command *c;
+
+	cxl_for_each_feature_cmd(c)
+		if (c->info.id == id)
+			return c;
+
+	return NULL;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_find_feature_command_by_id, "CXL");
+
 static const char *cxl_mem_opcode_to_name(u16 opcode)
 {
 	struct cxl_mem_command *c;
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index cc72e73ae8d6..e65fc8479d21 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -50,11 +50,203 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 	return info;
 }
 
+static struct cxl_feat_entry *
+get_support_feature_info(struct cxl_features_state *cfs,
+			 const struct fwctl_rpc_cxl *rpc_in)
+{
+	struct cxl_feat_entry *feat;
+	uuid_t uuid;
+
+	if (rpc_in->op_size < sizeof(uuid))
+		return ERR_PTR(-EINVAL);
+
+	if (copy_from_user(&uuid, u64_to_user_ptr(rpc_in->in_payload),
+			   sizeof(uuid)))
+		return ERR_PTR(-EFAULT);
+
+	for (int i = 0; i < cfs->num_features; i++) {
+		feat = &cfs->entries[i];
+		if (uuid_equal(&uuid, &feat->uuid))
+			return feat;
+	}
+
+	return ERR_PTR(-ENOENT);
+}
+
+static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
+					   const struct fwctl_rpc_cxl *rpc_in,
+					   size_t *out_len)
+{
+	struct cxl_mbox_get_sup_feats_out *feat_out;
+	struct cxl_mbox_get_sup_feats_in feat_in;
+	struct cxl_feat_entry *saved, *pos;
+	int requested, copied;
+	size_t out_size;
+	u32 count;
+	u16 start;
+
+	if (rpc_in->op_size != sizeof(feat_in))
+		return ERR_PTR(-EINVAL);
+
+	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
+			   rpc_in->op_size))
+		return ERR_PTR(-EFAULT);
+
+	count = le32_to_cpu(feat_in.count);
+	start = le16_to_cpu(feat_in.start_idx);
+	requested = count / sizeof(*pos);
+
+	/*
+	 * Make sure that the total requested number of entries is not greater
+	 * than the total number of supported features allowed for userspace.
+	 */
+	if (start >= cfs->num_user_features)
+		return ERR_PTR(-EINVAL);
+
+	requested = min_t(int, requested, cfs->num_user_features - start);
+
+	out_size = sizeof(struct fwctl_rpc_cxl_out) + sizeof(*feat_out) +
+		   requested * sizeof(*pos);
+
+	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
+		kvzalloc(out_size, GFP_KERNEL);
+	if (!rpc_out)
+		return ERR_PTR(-ENOMEM);
+
+	rpc_out->size = sizeof(*feat_out) + requested * sizeof(*pos);
+	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
+	if (requested == 0) {
+		feat_out->num_entries = cpu_to_le16(requested);
+		feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
+		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+		*out_len = out_size;
+		return no_free_ptr(rpc_out);
+	}
+
+	pos = &feat_out->ents[0];
+	saved = &cfs->entries[0];
+
+	copied = 0;
+	for (int i = 0; i < cfs->num_features; i++, saved++) {
+		if (is_cxl_feature_exclusive(saved))
+			continue;
+
+		memcpy(pos, saved, sizeof(*saved));
+		copied++;
+		if (copied == requested)
+			break;
+		pos++;
+	}
+
+	feat_out->num_entries = cpu_to_le16(requested);
+	feat_out->supported_feats = cpu_to_le16(cfs->num_user_features);
+	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+	*out_len = out_size;
+
+	return no_free_ptr(rpc_out);
+}
+
+static bool cxlctl_validate_set_features(struct cxl_features_state *cfs,
+					 const struct fwctl_rpc_cxl *rpc_in,
+					 enum fwctl_rpc_scope scope)
+{
+	struct cxl_feat_entry *feat;
+	u16 effects, mask;
+	u32 flags;
+
+	feat = get_support_feature_info(cfs, rpc_in);
+	if (IS_ERR(feat))
+		return false;
+
+	/* Ensure that the attribute is changeable */
+	flags = le32_to_cpu(feat->flags);
+	if (!(flags & CXL_FEATURE_F_CHANGEABLE))
+		return false;
+
+	effects = le16_to_cpu(feat->effects);
+	/* Currently no user background command support */
+	if (effects & CXL_CMD_BACKGROUND)
+		return false;
+
+	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
+	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
+	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
+	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
+	if (effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
+		return true;
+
+	/* These effects supported for all scope */
+	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
+	     (effects & CXL_CMD_EFFECTS_EXTEND &&
+	      (effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
+	       effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET))) &&
+	    scope >= FWCTL_RPC_DEBUG_WRITE)
+		return true;
+
+	return false;
+}
+
+static struct cxl_mem_command *
+cxlctl_get_valid_hw_command(struct cxl_features_state *cfs,
+			    const struct fwctl_rpc_cxl *rpc_in,
+			    enum fwctl_rpc_scope scope)
+{
+	struct cxl_mem_command *cmd;
+
+	if (!cfs->num_features)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	cmd = cxl_find_feature_command_by_id(rpc_in->command_id);
+	if (!cmd)
+		return ERR_PTR(-ENOENT);
+
+	if (!cxl_feature_enabled(cfs, cmd->opcode))
+		return ERR_PTR(-EPERM);
+
+	switch (cmd->opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+		if (scope >= FWCTL_RPC_CONFIGURATION)
+			return cmd;
+		break;
+	case CXL_MBOX_OP_SET_FEATURE:
+		if (cxlctl_validate_set_features(cfs, rpc_in, scope))
+			return cmd;
+		break;
+	default:
+		return ERR_PTR(-EINVAL);
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void *cxlctl_handle_commands(struct cxl_features_state *cfs,
+				    const struct fwctl_rpc_cxl *rpc_in,
+				    size_t *out_len, struct cxl_mem_command *cmd)
+{
+	switch (cmd->opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		return cxlctl_get_supported_features(cfs, rpc_in, out_len);
+	case CXL_MBOX_OP_GET_FEATURE:
+	case CXL_MBOX_OP_SET_FEATURE:
+	default:
+		return ERR_PTR(-EOPNOTSUPP);
+	}
+}
+
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
-			   void *rpc_in, size_t in_len, size_t *out_len)
+			   void *in, size_t in_len, size_t *out_len)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct fwctl_device *fwctl = uctx->fwctl;
+	struct cxl_features_state *cfs = to_cxl_features_state(fwctl);
+	const struct fwctl_rpc_cxl *rpc_in = in;
+	struct cxl_mem_command *cmd;
+
+	cmd = cxlctl_get_valid_hw_command(cfs, rpc_in, scope);
+	if (IS_ERR(cmd))
+		return (void *)cmd;
+
+	return cxlctl_handle_commands(cfs, rpc_in, out_len, cmd);
 }
 
 static const struct fwctl_ops cxlctl_ops = {
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 9f234659ca2d..b5dacc1665c7 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -69,6 +69,7 @@ size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
 int cxl_set_feature(struct cxl_features *features, const uuid_t feat_uuid,
 		    u8 feat_version, void *feat_data, size_t feat_data_size,
 		    u32 feat_flag, u16 offset, u16 *return_code);
+struct cxl_mem_command *cxl_find_feature_command_by_id(u32 id);
 bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
 #endif
diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
index 18b74252058a..55fa5b2a5d17 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -14,6 +14,19 @@
 #include <linux/uuid.h>
 #endif
 
+/* CXL spec r3.2 Table 8-87 command effects */
+#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
+#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
+#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
+#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
+#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
+#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
+#define CXL_CMD_BACKGROUND			BIT(6)
+#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
+#define CXL_CMD_EFFECTS_EXTEND			BIT(9)
+#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
+#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
+
 /* Get Supported Features (0x500h) CXL r3.1 8.2.9.6.1 */
 struct cxl_mbox_get_sup_feats_in {
 	__le32 count;
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index 79b822dbfafd..ad23c65ce724 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -28,4 +28,33 @@ enum feature_cmds {
 struct fwctl_info_cxl {
 	__u32 cmd_mask;
 };
+
+/**
+ * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
+ * @command_id: the defined command id by 'enum feature_cmds'
+ * @flags: Flags for the command (input).
+ * @op_size: Size of input payload.
+ * @reserved1: Reserved. Must be 0s.
+ * @in_payload: User address of the hardware op input structure
+ */
+struct fwctl_rpc_cxl {
+	__u32 command_id;
+	__u32 flags;
+	__u32 op_size;
+	__u32 reserved1;
+	__aligned_u64 in_payload;
+};
+
+/**
+ * struct fwctl_rpc_cxl_out - ioctl(FWCTL_RPC) output for CXL
+ * @size: Size of the output payload
+ * @retval: Return value from device
+ * @payload: Return data from device
+ */
+struct fwctl_rpc_cxl_out {
+	__u32 size;
+	__u32 retval;
+	__u8 payload[] __counted_by(size);
+};
+
 #endif
-- 
2.47.1

