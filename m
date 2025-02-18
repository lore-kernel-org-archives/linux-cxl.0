Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61990286297
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919469; cv=none; b=mDhVdGuje39FI/SAjFyXco6FrM4vEb8VeNcqC/ew4r027UGXKLfQ+45bBdXOREGBBxILr3V4OqfVTVobKUUOiMLh5hvvNZ1Qn4p7lgcmsQG2sWXk2PxxKppWkBYCq76coCo0a5qIyaW1J4+faFlWufJaT9i46Dl4JAq+LKMSuwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919469; c=relaxed/simple;
	bh=qn7Lhq7I5lfqyT+EO0aUDw9KYLWCj5402gqUdQ3ni/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lKoVRtSkeHMpmvlBngxMdLiJdN9YoIdwM2qfQxgvcCnRSMFOQQktXnCSOCdHE4DoEjrlMLPC3Nqsno1rn7BUSsZvjZkFj1Ffd+j9UkmTMmDKkZczt/CH8FcVaWwgXoy3FiHFFC+XgsDEOxa6RsdUdbbLAEK0zu/VTxzGTyxuLGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0626C4CEE2;
	Tue, 18 Feb 2025 22:57:48 +0000 (UTC)
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
	saeed@kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v6 10/14] cxl: Add support to handle user feature commands for get feature
Date: Tue, 18 Feb 2025 15:54:39 -0700
Message-ID: <20250218225721.2682235-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218225721.2682235-1-dave.jiang@intel.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
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
v6:
- adjust for embedded input payload
- move get_feature bits here from previous patch
---
 drivers/cxl/core/features.c | 44 +++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/cxl.h    |  3 +++
 2 files changed, 47 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 106ea9e25c82..ec0e3ace1803 100644
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
index 39996ec56816..07b7e5bab461 100644
--- a/include/uapi/fwctl/cxl.h
+++ b/include/uapi/fwctl/cxl.h
@@ -13,6 +13,7 @@
 
 struct cxl_mbox_get_sup_feats_in;
 struct cxl_mbox_get_sup_feats_out;
+struct cxl_mbox_get_feat_in;
 
 /**
  * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
@@ -21,6 +22,7 @@ struct cxl_mbox_get_sup_feats_out;
  * @op_size: Size of input payload.
  * @reserved1: Reserved. Must be 0s.
  * @get_sup_feats_in: Get Supported Features input
+ * @get_feat_in: Get Feature input
  * @op: hardware operation input byte array
  */
 struct fwctl_rpc_cxl {
@@ -32,6 +34,7 @@ struct fwctl_rpc_cxl {
 	);
 	union {
 		struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
+		struct cxl_mbox_get_feat_in get_feat_in;
 		__DECLARE_FLEX_ARRAY(__u8, op);
 	};
 };
-- 
2.48.1

