Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA8C24CEFB
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 18:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298566; cv=none; b=B89234RiVyg1dO5oFok/x2qxkY9xARyek5ZhMS84z00+IVzo33z6cGhQx64efFEp/C957VI12pEiC008vIx4fEhpwBKv9icITCE9og4L6x8NLMgC/k/D8A5dnnGPc9p84RL1jx2IeRANQgmS+7BQvUSLW0gOVoCThMuNhbdjHxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298566; c=relaxed/simple;
	bh=9RqiQTNrXrmzx3Dp5jnmgePlITS+PBW5ay6pSsUA5YI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TV+lDY5SxCke8NOr/9KMoHX8Srx5TndcLGZV7TnGeou1haDSISIBTmBThW+ahA3zd+a7o9MQtnVCHhCCQnEIOK2RydBt5cfy1zO84dtv1b0czU0cV7OO0FT5Yozlmx2m5bHRLsp+qbOk0R4SVNmp2+H6pQ4mCMJiBH1AuYQKL8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42EB1C4CEDD;
	Tue, 11 Feb 2025 18:29:26 +0000 (UTC)
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
Subject: [PATCH v5 10/15] cxl: Add support for fwctl RPC command to enable CXL feature commands
Date: Tue, 11 Feb 2025 11:28:04 -0700
Message-ID: <20250211182909.1650096-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211182909.1650096-1-dave.jiang@intel.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwctl provides a fwctl_ops->fw_rpc() callback in order to issue ioctls
to a device. The cxl fwctl driver will start by supporting the CXL
Feature commands: Get Supported Features, Get Feature, and Set Feature.

The fw_rpc() callback provides 'enum fwctl_rpc_scope' parameter where
it indicates the security scope of the call. The Get Supported Features
and Get Feature calls can be executed with the scope of
FWCTL_RPC_CONFIGRATION. The Set Feature call is gated by the effects
of the Feature reported by Get Supported Features call for the specific
Feature.

Only "Get Supported Features" is supported in this patch. Additional
commands will be added in follow on patches. "Get Supported Features"
will filter the Features that are exclusive to the kernel. The flag
field of the Feature details will be cleared of the "Changeable"
field and the "set feat size" will be set to 0 to indicate that
the feature is not changeable.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
---
v5:
- drop unused feature_cmds. (Dan)
- Fix index of for loop. (Ming)
---
 drivers/cxl/core/features.c | 218 +++++++++++++++++++++++++++++++++++-
 include/uapi/cxl/features.h |   1 +
 include/uapi/fwctl/cxl.h    |  29 +++++
 3 files changed, 246 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 923c054599ad..a43be03ada43 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -365,11 +365,225 @@ static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
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
+	for (int i = 0; i < cxlfs->entries->num_features; i++) {
+		feat = &cxlfs->entries->ent[i];
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
+	size_t out_size;
+	int requested;
+	u32 count;
+	u16 start;
+	int i;
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
+	if (start >= cxlfs->entries->num_features)
+		return ERR_PTR(-EINVAL);
+
+	requested = min_t(int, requested, cxlfs->entries->num_features - start);
+
+	out_size = sizeof(struct fwctl_rpc_cxl_out) +
+		struct_size(feat_out, ents, requested);
+
+	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
+		kvzalloc(out_size, GFP_KERNEL);
+	if (!rpc_out)
+		return ERR_PTR(-ENOMEM);
+
+	rpc_out->size = struct_size(feat_out, ents, requested);
+	feat_out = (struct cxl_mbox_get_sup_feats_out *)rpc_out->payload;
+	if (requested == 0) {
+		feat_out->num_entries = cpu_to_le16(requested);
+		feat_out->supported_feats =
+			cpu_to_le16(cxlfs->entries->num_features);
+		rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+		*out_len = out_size;
+		return no_free_ptr(rpc_out);
+	}
+
+	for (i = start, pos = &feat_out->ents[0];
+	     i < cxlfs->entries->num_features; i++, pos++) {
+		if (i - start == requested)
+			break;
+
+		memcpy(pos, &cxlfs->entries->ent[i], sizeof(*pos));
+		/*
+		 * If the feature is exclusive, set the set_feat_size to 0 to
+		 * indicate that the feature is not changeable.
+		 */
+		if (is_cxl_feature_exclusive(pos)) {
+			u32 flags;
+
+			pos->set_feat_size = 0;
+			flags = le32_to_cpu(pos->flags);
+			flags &= ~CXL_FEATURE_F_CHANGEABLE;
+			pos->flags = cpu_to_le32(flags);
+		}
+	}
+
+	feat_out->num_entries = cpu_to_le16(requested);
+	feat_out->supported_feats = cpu_to_le16(cxlfs->entries->num_features);
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
+	u16 effects, imm_mask, reset_mask;
+	struct cxl_feat_entry *feat;
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
+		dev_warn_once(cxlfs->cxlds->dev,
+			      "Reserved bits set in the Feature effects field!\n");
+		return false;
+	}
+
+	/* Currently no user background command support */
+	if (effects & CXL_CMD_BACKGROUND)
+		return false;
+
+	/* Effects cause immediate change, highest security scope is needed */
+	imm_mask = CXL_CMD_CONFIG_CHANGE_IMMEDIATE |
+		   CXL_CMD_DATA_CHANGE_IMMEDIATE |
+		   CXL_CMD_POLICY_CHANGE_IMMEDIATE |
+		   CXL_CMD_LOG_CHANGE_IMMEDIATE;
+
+	reset_mask = CXL_CMD_CONFIG_CHANGE_COLD_RESET |
+		     CXL_CMD_CONFIG_CHANGE_CONV_RESET |
+		     CXL_CMD_CONFIG_CHANGE_CXL_RESET;
+
+	/* If no immediate or reset effect set, The hardware has a bug */
+	if (!(effects & imm_mask) && !(effects & reset_mask))
+		return false;
+
+	/*
+	 * If the Feature setting causes immediate configuration change
+	 * then we need the full write permission policy.
+	 */
+	if (effects & imm_mask && scope >= FWCTL_RPC_DEBUG_WRITE_FULL)
+		return true;
+
+	/*
+	 * If the Feature setting only causes configuration change
+	 * after a reset, then the lesser level of write permission
+	 * policy is ok.
+	 */
+	if (!(effects & imm_mask) && scope >= FWCTL_RPC_DEBUG_WRITE)
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
+	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
+
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
+			return false;
+		if (scope >= FWCTL_RPC_CONFIGURATION)
+			return true;
+		return false;
+	case CXL_MBOX_OP_SET_FEATURE:
+		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
+			return false;
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
 			   void *in, size_t in_len, size_t *out_len)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct fwctl_device *fwctl_dev = uctx->fwctl;
+	struct cxl_memdev *cxlmd = fwctl_to_memdev(fwctl_dev);
+	struct cxl_features_state *cxlfs = to_cxlfs(cxlmd->cxlds);
+	const struct fwctl_rpc_cxl *rpc_in = in;
+	u16 opcode = rpc_in->opcode;
+
+	if (!cxlctl_validate_hw_command(cxlfs, rpc_in, scope, opcode))
+		return ERR_PTR(-EINVAL);
+
+	return cxlctl_handle_commands(cxlfs, rpc_in, out_len, opcode);
 }
 
 static const struct fwctl_ops cxlctl_ops = {
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
index d21fd6b80c20..e4cf6375a683 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -16,4 +16,33 @@
 struct fwctl_info_cxl {
 	__u32 reserved;
 };
+
+/**
+ * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
+ * @opcode: CXL mailbox command opcode
+ * @flags: Flags for the command (input).
+ * @op_size: Size of input payload.
+ * @reserved1: Reserved. Must be 0s.
+ * @in_payload: User address of the hardware op input structure
+ */
+struct fwctl_rpc_cxl {
+	__u32 opcode;
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
2.48.1

