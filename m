Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D54B41E3DFD
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 18:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298567; cv=none; b=S158OjI0JegE3E0S9VhaZ5O1cKWrnx07q3h44Zotxc0FeZ1nDmK8hwL40vuNqsA2qqrVLcLkYHQ0R5w512ShnyXGEdfHD2f/bQOjgu7hyXaqAyALO9mTt1wpPRHxQqXiXGdA861yL1tx9+UTeW/nns8f3vkZ8FdIftem6VcAovQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298567; c=relaxed/simple;
	bh=VgiYln52AIgwZyJZdd/WSqNWIBWQcUTodh+u/Ne7uhY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e0ToAwrr1KAb79wcF8b9lh3GZgkbmR9KkTLh60rVoG15LCWmvM3ksXDPuDiSuVvNAG0GX7FLt9pbDHuGN8d9ZqCiI9yMldF5IfYOJobfyuDi45wqoyCWMQKu5qt7qUEHBjMgO3ECKSphFwHCblTIaeRhSDvmVdpU0p34uBKwYwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0DD6C4CEDD;
	Tue, 11 Feb 2025 18:29:27 +0000 (UTC)
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
Subject: [PATCH v5 11/15] cxl: Add support to handle user feature commands for get feature
Date: Tue, 11 Feb 2025 11:28:05 -0700
Message-ID: <20250211182909.1650096-12-dave.jiang@intel.com>
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

Add helper function to parse the user data from fwctl RPC ioctl and
send the parsed input parameters to cxl_get_feature() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 45 +++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index a43be03ada43..b684a2259a08 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -468,6 +468,50 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
+	struct cxl_mbox_get_feat_in feat_in;
+	u16 offset, count, return_code;
+	size_t out_size = *out_len;
+
+	if (rpc_in->op_size != sizeof(feat_in))
+		return ERR_PTR(-EINVAL);
+
+	if (copy_from_user(&feat_in, u64_to_user_ptr(rpc_in->in_payload),
+			   rpc_in->op_size))
+		return ERR_PTR(-EFAULT);
+
+	offset = le16_to_cpu(feat_in.offset);
+	count = le16_to_cpu(feat_in.count);
+
+	if (!count)
+		return ERR_PTR(-EINVAL);
+
+	struct fwctl_rpc_cxl_out *rpc_out __free(kvfree) =
+		kvzalloc(out_size, GFP_KERNEL);
+	if (!rpc_out)
+		return ERR_PTR(-ENOMEM);
+
+	out_size = cxl_get_feature(cxl_mbox, &feat_in.uuid,
+				   feat_in.selection, rpc_out->payload,
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
 static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
 					 const struct fwctl_rpc_cxl *rpc_in,
 					 enum fwctl_rpc_scope scope)
@@ -565,6 +609,7 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_GET_FEATURE:
+		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_SET_FEATURE:
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.48.1

