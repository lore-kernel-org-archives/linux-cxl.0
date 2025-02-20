Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C753C2641D3
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080696; cv=none; b=ETlrqY/PjS60N9p1cZL7VR2zZnuFP39bVy3yViogx+MTpLcS8q+lefhERqwt0FN2+LglWe9W7G0o+WO75MWKSl/mFzMo0NFCk8fSvHpr9VIO8b7fXyjKP+lX2TAHqZs/qCAV29IxUKmqnjHINye6Nv6JGqUUWrHxseSmnq6kbe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080696; c=relaxed/simple;
	bh=lVq5aPQVgzzv7bcKu6Sr5ss7QbeOryHahWHN2f/gnSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fVMwCEdZvPvSl20q4NIOy279cmWo38YQCxsybGEeJCozkwIFks7PY0X5mMuz2f7hhv1N7xSzUkS5ZV0rTa3pJ5dYzcqyFtIpzyRl1SjG8RihBHhdt5OTTJuemYet2ZxAa/5JqT72dropUxjXcrkNNuIftfw7RMxIGcti723xovE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9239AC4CED6;
	Thu, 20 Feb 2025 19:44:56 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v7 11/14] cxl: Add support to handle user feature commands for set feature
Date: Thu, 20 Feb 2025 12:42:49 -0700
Message-ID: <20250220194438.2281088-12-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220194438.2281088-1-dave.jiang@intel.com>
References: <20250220194438.2281088-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add helper function to parse the user data from fwctl RPC ioctl and
send the parsed input parameters to cxl_set_feature() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v7:
- Set uuid to set_feat->uuid. (Jonathan)
---
 drivers/cxl/core/features.c | 146 +++++++++++++++++++++++++++++++++++-
 include/uapi/fwctl/cxl.h    |   2 +
 2 files changed, 146 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 2a35581d2677..caf92e9cea21 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -21,16 +21,21 @@ static const uuid_t cxl_exclusive_feats[] = {
 	CXL_FEAT_RANK_SPARING_UUID,
 };
 
-static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
+static bool is_cxl_feature_exclusive_by_uuid(const uuid_t *uuid)
 {
 	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
-		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
+		if (uuid_equal(uuid, &cxl_exclusive_feats[i]))
 			return true;
 	}
 
 	return false;
 }
 
+static bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
+{
+	return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
+}
+
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
 	return cxlds->cxlfs;
@@ -350,6 +355,27 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 {
 }
 
+static struct cxl_feat_entry *
+get_support_feature_info(struct cxl_features_state *cxlfs,
+			 const struct fwctl_rpc_cxl *rpc_in)
+{
+	struct cxl_feat_entry *feat;
+	const uuid_t *uuid;
+
+	if (rpc_in->op_size < sizeof(uuid))
+		return ERR_PTR(-EINVAL);
+
+	uuid = &rpc_in->set_feat_in.uuid;
+
+	for (int i = 0; i < cxlfs->entries->num_features; i++) {
+		feat = &cxlfs->entries->ent[i];
+		if (uuid_equal(uuid, &feat->uuid))
+			return feat;
+	}
+
+	return ERR_PTR(-EINVAL);
+}
+
 static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 					   const struct fwctl_rpc_cxl *rpc_in,
 					   size_t *out_len)
@@ -468,6 +494,116 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
+	const struct cxl_mbox_set_feat_in *feat_in;
+	size_t out_size, data_size;
+	u16 offset, return_code;
+	u32 flags;
+	int rc;
+
+	if (rpc_in->op_size <= sizeof(feat_in->hdr))
+		return ERR_PTR(-EINVAL);
+
+	feat_in = &rpc_in->set_feat_in;
+
+	if (is_cxl_feature_exclusive_by_uuid(&feat_in->uuid))
+		return ERR_PTR(-EPERM);
+
+	offset = le16_to_cpu(feat_in->offset);
+	flags = le32_to_cpu(feat_in->flags);
+	out_size = *out_len;
+
+	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
+		kvzalloc(out_size, GFP_KERNEL);
+	if (!rpc_out)
+		return ERR_PTR(-ENOMEM);
+
+	rpc_out->size = 0;
+
+	data_size = rpc_in->op_size - sizeof(feat_in->hdr);
+	rc = cxl_set_feature(cxl_mbox, &feat_in->uuid,
+			     feat_in->version, feat_in->feat_data,
+			     data_size, flags, offset, &return_code);
+	if (rc) {
+		rpc_out->retval = return_code;
+		return no_free_ptr(rpc_out);
+	}
+
+	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+	*out_len = sizeof(*rpc_out);
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
 static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
 				       const struct fwctl_rpc_cxl *rpc_in,
 				       enum fwctl_rpc_scope scope,
@@ -483,6 +619,10 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
 		if (scope >= FWCTL_RPC_CONFIGURATION)
 			return true;
 		return false;
+	case CXL_MBOX_OP_SET_FEATURE:
+		if (cxl_mbox->feat_cap < CXL_FEATURES_RW)
+			return false;
+		return cxlctl_validate_set_features(cxlfs, rpc_in, scope);
 	default:
 		return false;
 	}
@@ -497,6 +637,8 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
 		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_GET_FEATURE:
 		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
+	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_set_feature(cxlfs, rpc_in, out_len);
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
 	}
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index 3dc7ffeb3eae..becdada348d9 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -19,6 +19,7 @@
  * @reserved1: Reserved. Must be 0s.
  * @get_sup_feats_in: Get Supported Features input
  * @get_feat_in: Get Feature input
+ * @set_feat_in: Set Feature input
  */
 struct fwctl_rpc_cxl {
 	__struct_group(fwctl_rpc_cxl_hdr, hdr, /* no attrs */,
@@ -30,6 +31,7 @@ struct fwctl_rpc_cxl {
 	union {
 		struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
 		struct cxl_mbox_get_feat_in get_feat_in;
+		struct cxl_mbox_set_feat_in set_feat_in;
 	};
 };
 
-- 
2.48.1

