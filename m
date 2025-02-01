Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6478AAD21
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370718; cv=none; b=dMaXGxAmYCbW+oLt5k8HPL/QiR3hQJhuCRgqW3p4YFJQoKeEZkzRv/udYWtk+JwXlUwZJFNgJ+NJaHfSEw1F6FzjddVCHkBu0y4v1mWZlK46n/uhwlEccMTwW9S8D+I8xjggkJUGLIVovxyss2xx+priVTAofR5SThEzHErKZWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370718; c=relaxed/simple;
	bh=zaxUaEvgQRav1SiTxdXkMzAoczj6+4u92VM7Om8IjxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rdyS+6bmK6bx9Ia5H7SF0FsfG8iyNt2NeQ+3ISQDGUTeOuF51YeUuNn2Ft2pgOFwqAMQx8bxmuu5xBPuaVnB+J8fC92DAUUDihubEV/6YA3LmFCe/2iVODJQy3RDcVWo9JGmVlPiRNkQztOSjETF8rABcGZQ+6JOhvn617wt9sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1614C4CED1;
	Sat,  1 Feb 2025 00:45:17 +0000 (UTC)
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
Subject: [PATCH v2 11/16] cxl: Add support for fwctl RPC command to enable CXL feature commands
Date: Fri, 31 Jan 2025 17:42:04 -0700
Message-ID: <20250201004459.466499-12-dave.jiang@intel.com>
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
v2:
- Return -EINVAL for get_support_feature_info() instead of -ENOENT. (Dan)
- Set set_feat_size to 0 for kernel exclusive features.
- Just don't bother checking the valid (9) bit. (Dan)
- Reject if the reserved bits are set. (Dan)
---
 drivers/cxl/core/mbox.c     |   9 ++
 drivers/cxl/cxl.h           |   1 +
 drivers/cxl/fwctl.c         | 204 +++++++++++++++++++++++++++++++++++-
 include/cxl/features.h      |   9 +-
 include/uapi/cxl/features.h |   1 +
 include/uapi/fwctl/cxl.h    |  37 +++++++
 6 files changed, 250 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 25fb7bd770b3..71ab331830bf 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -92,6 +92,15 @@ int cxl_get_feature_command_id(u16 opcode)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_feature_command_id, "CXL");
 
+u16 cxl_get_feature_command_opcode(int feature_id)
+{
+	if (feature_id >= ARRAY_SIZE(cxl_feature_commands))
+		return 0xffff;
+
+	return cxl_feature_commands[feature_id];
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature_command_opcode, "CXL");
+
 /*
  * Commands that RAW doesn't permit. The rationale for each:
  *
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 2d6f7c87e5e8..451b2c7e995b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -912,6 +912,7 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
 int cxl_get_feature_command_id(u16 opcode);
+u16 cxl_get_feature_command_opcode(int feature_id);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
index b7984c98645c..93c6174ded20 100644
--- a/drivers/cxl/fwctl.c
+++ b/drivers/cxl/fwctl.c
@@ -35,11 +35,209 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 	return info;
 }
 
+static struct cxl_feat_entry *
+get_support_feature_info(struct cxl_features_state *cxlfs,
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
+	for (int i = 0; i < cxlfs->num_features; i++) {
+		feat = &cxlfs->entries[i];
+		if (uuid_equal(&uuid, &feat->uuid))
+			return feat;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
+static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
+					   const struct fwctl_rpc_cxl *rpc_in,
+					   size_t *out_len)
+{
+	struct cxl_mbox_get_sup_feats_out *feat_out;
+	struct cxl_mbox_get_sup_feats_in feat_in;
+	struct cxl_feat_entry *pos;
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
+	if (start >= cxlfs->num_user_features)
+		return ERR_PTR(-EINVAL);
+
+	requested = min_t(int, requested, cxlfs->num_user_features - start);
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
+		feat_out->supported_feats =
+			cpu_to_le16(cxlfs->num_user_features);
+		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+		*out_len = out_size;
+		return no_free_ptr(rpc_out);
+	}
+
+	pos = &feat_out->ents[0];
+
+	copied = 0;
+	for (int i = 0; i < cxlfs->num_features; i++, pos++) {
+		memcpy(pos, &cxlfs->entries[i], sizeof(*pos));
+		/*
+		 * If the feature is exclusive, set the set_feat_size to 0 to
+		 * indicate that the feature is not changeable.
+		 */
+		if (is_cxl_feature_exclusive(pos))
+			pos->set_feat_size = 0;
+
+		copied++;
+		if (copied == requested)
+			break;
+	}
+
+	feat_out->num_entries = cpu_to_le16(requested);
+	feat_out->supported_feats = cpu_to_le16(cxlfs->num_features);
+	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+	*out_len = out_size;
+
+	return no_free_ptr(rpc_out);
+}
+
+static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
+					 const struct fwctl_rpc_cxl *rpc_in,
+					 enum fwctl_rpc_scope scope)
+{
+	struct cxl_feat_entry *feat;
+	u16 effects, mask;
+	u32 flags;
+
+	feat = get_support_feature_info(cxlfs, rpc_in);
+	if (IS_ERR(feat))
+		return false;
+
+	/* Ensure that the attribute is changeable */
+	flags = le32_to_cpu(feat->flags);
+	if (!(flags & CXL_FEATURE_F_CHANGEABLE))
+		return false;
+
+	effects = le16_to_cpu(feat->effects);
+
+	/*
+	 * Reserved bits are set, rejecting since the effects is not
+	 * comprehended by the driver.
+	 */
+	if (effects & CXL_CMD_EFFECTS_RESERVED) {
+		dev_warn_once(&cxlfs->cxlmd->dev,
+			      "Reserved bits set in the Feature effects field!\n");
+		return false;
+	}
+
+	/* Currently no user background command support */
+	if (effects & CXL_CMD_BACKGROUND)
+		return false;
+
+	/* Effects cause immediate change, highest security scope is needed */
+	mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
+	       CXL_CMD_DATA_CHANGE_IMMEDIATE |
+	       CXL_CMD_POLICY_CHANGE_IMMEDIATE |
+	       CXL_CMD_LOG_CHANGE_IMMEDIATE;
+	if (effects & mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
+		return true;
+
+	/* These effects supported for all WRITE scope */
+	if ((effects & CXL_CMD_CONFIG_CHANGE_COLD_RESET ||
+	     effects & CXL_CMD_CONFIG_CHANGE_CONV_RESET ||
+	     effects & CXL_CMD_CONFIG_CHANGE_CXL_RESET) &&
+	    scope >= FWCTL_RPC_DEBUG_WRITE)
+		return true;
+
+	return false;
+}
+
+static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
+				       const struct fwctl_rpc_cxl *rpc_in,
+				       enum fwctl_rpc_scope scope,
+				       u16 opcode)
+{
+	if (!cxlfs->num_features)
+		return false;
+
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+		if (cxlfs->cap < CXL_FEATURES_RO)
+			return false;
+		if (scope >= FWCTL_RPC_CONFIGURATION)
+			return true;
+		return false;
+	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_validate_set_features(cxlfs, rpc_in, scope);
+	default:
+		return false;
+	}
+}
+
+static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
+				    const struct fwctl_rpc_cxl *rpc_in,
+				    size_t *out_len, u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
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
+	struct cxl_features_state *cxlfs = to_cxl_features_state(fwctl);
+	const struct fwctl_rpc_cxl *rpc_in = in;
+	u16 opcode;
+
+	opcode = cxl_get_feature_command_opcode(rpc_in->command_id);
+	if (opcode == 0xffff)
+		return ERR_PTR(-EINVAL);
+
+	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
+		return ERR_PTR(-EINVAL);
+
+	return cxlctl_handle_commands(cxlfs, rpc_in, out_len, opcode);
 }
 
 static const struct fwctl_ops cxlctl_ops = {
diff --git a/include/cxl/features.h b/include/cxl/features.h
index eb13d7ee64f0..f43aa761a7ee 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -42,14 +42,6 @@
 
 struct cxl_mailbox;
 
-/* Index IDs for CXL mailbox Feature commands */
-enum feature_cmds {
-	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
-	CXL_FEATURE_ID_GET_FEATURE,
-	CXL_FEATURE_ID_SET_FEATURE,
-	CXL_FEATURE_ID_MAX
-};
-
 /* Feature commands capability supported by a device */
 enum cxl_features_capability {
 	CXL_FEATURES_NONE = 0,
@@ -83,5 +75,6 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		    u8 feat_version, void *feat_data, size_t feat_data_size,
 		    u32 feat_flag, u16 offset, u16 *return_code);
+bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
 #endif
diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
index 2e98efb9abf1..05c8a06a5dff 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -33,6 +33,7 @@ struct cxl_mbox_get_sup_feats_in {
 #define CXL_CMD_EFFECTS_VALID			BIT(9)
 #define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
 #define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
+#define CXL_CMD_EFFECTS_RESERVED		GENMASK(15, 12)
 
 /*
  * CXL spec r3.2 Table 8-109
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index 4e766ffb1388..3b95e0903856 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -16,4 +16,41 @@
 struct fwctl_info_cxl {
 	__u32 reserved;
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
+/* command_id for CXL mailbox Feature commands */
+enum feature_cmds {
+	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
+	CXL_FEATURE_ID_GET_FEATURE,
+	CXL_FEATURE_ID_SET_FEATURE,
+	CXL_FEATURE_ID_MAX
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
2.48.1

