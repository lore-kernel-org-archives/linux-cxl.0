Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC9B2641E3
	for <linux-cxl@vger.kernel.org>; Thu, 20 Feb 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080696; cv=none; b=boZpmLVaU0FKqIA35K9y1pXTAmXLlr8HRupaCJQqjdTX9n97IZv7YY3VKQ61V+VWm6vEqZ237CyxDlkWLrKdICvatfersWLmRY3u+zcu0M4RyJ47XiQ8x+OmrTb6pAbupTasf50hsfy1WQn5Cx2mqYrLYgP/K3eXSO/NyF6R6ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080696; c=relaxed/simple;
	bh=XrfIa68ntQwm5xdnVyr2UDbsKP6y7gI/ToL80KgMLM0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B78ZKuvdL/aSYleGiHEcK1Gags0gxNhkWpMj7hnFNKSF88Y3tqvlLyu9C/Gg6iW3u7KfP2gb/Gx00PVC9ZisPdQN6SBPhDHwHvnqLqtD2cJb0bwe8RnEDrTlGIkmzqsZr6tq8IitzHnzsfERU1ymBJoI/vP52g4hRgRmry/p9Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23241C4CED1;
	Thu, 20 Feb 2025 19:44:55 +0000 (UTC)
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
Subject: [PATCH v7 10/14] cxl: Add support to handle user feature commands for get feature
Date: Thu, 20 Feb 2025 12:42:48 -0700
Message-ID: <20250220194438.2281088-11-dave.jiang@intel.com>
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
send the parsed input parameters to cxl_get_feature() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v7:
- Move the flex array define here. (Jonathan)
---
 drivers/cxl/core/features.c | 44 +++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/cxl.h    | 11 ++++++++--
 2 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 6cec89977fa0..2a35581d2677 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -427,6 +427,47 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
+	const struct cxl_mbox_get_feat_in *feat_in;
+	u16 offset, count, return_code;
+	size_t out_size = *out_len;
+
+	if (rpc_in->op_size != sizeof(*feat_in))
+		return ERR_PTR(-EINVAL);
+
+	feat_in = &rpc_in->get_feat_in;
+	offset = le16_to_cpu(feat_in->offset);
+	count = le16_to_cpu(feat_in->count);
+
+	if (!count)
+		return ERR_PTR(-EINVAL);
+
+	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
+		kvzalloc(out_size, GFP_KERNEL);
+	if (!rpc_out)
+		return ERR_PTR(-ENOMEM);
+
+	out_size = cxl_get_feature(cxl_mbox, &feat_in->uuid,
+				   feat_in->selection, rpc_out->payload,
+				   count, offset, &return_code);
+	*out_len = sizeof(struct fwctl_rpc_cxl_out);
+	if (!out_size) {
+		rpc_out->size = 0;
+		rpc_out->retval = return_code;
+		return no_free_ptr(rpc_out);
+	}
+
+	rpc_out->size = out_size;
+	rpc_out->retval = CXL_MBOX_CMD_RC_SUCCESS;
+	*out_len += out_size;
+
+	return no_free_ptr(rpc_out);
+}
+
 static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
 				       const struct fwctl_rpc_cxl *rpc_in,
 				       enum fwctl_rpc_scope scope,
@@ -436,6 +477,7 @@ static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
 
 	switch (opcode) {
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
 		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
 			return false;
 		if (scope >= FWCTL_RPC_CONFIGURATION)
@@ -453,6 +495,8 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
 	switch (opcode) {
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
+	case CXL_MBOX_OP_GET_FEATURE:
+		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
 	}
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
index 4bbfd7727526..3dc7ffeb3eae 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -18,6 +18,7 @@
  * @op_size: Size of input payload.
  * @reserved1: Reserved. Must be 0s.
  * @get_sup_feats_in: Get Supported Features input
+ * @get_feat_in: Get Feature input
  */
 struct fwctl_rpc_cxl {
 	__struct_group(fwctl_rpc_cxl_hdr, hdr, /* no attrs */,
@@ -26,7 +27,10 @@ struct fwctl_rpc_cxl {
 		__u32 op_size;
 		__u32 reserved1;
 	);
-	struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
+	union {
+		struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
+		struct cxl_mbox_get_feat_in get_feat_in;
+	};
 };
 
 /**
@@ -40,7 +44,10 @@ struct fwctl_rpc_cxl_out {
 		__u32 size;
 		__u32 retval;
 	);
-	struct cxl_mbox_get_sup_feats_out get_sup_feats_out;
+	union {
+		struct cxl_mbox_get_sup_feats_out get_sup_feats_out;
+		__DECLARE_FLEX_ARRAY(__u8, payload);
+	};
 };
 
 #endif
-- 
2.48.1

