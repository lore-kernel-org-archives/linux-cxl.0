Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 607B32595
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370719; cv=none; b=tBQX+qBHsMry1R4CCmGKynYf5tUhz0t+LDCAUcCOkDxGkBCDko1TX2/L7cmG4YWIGW+s0Ds2E26h1EwYc3EdX6IJyGW/zCw9xV20x49RNmT21cNU8Ef3qbTagbfk+KTI8FYayh0I+Yd9kGiwG0NiE3yTT5vkRaVfVc1Dwf2iXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370719; c=relaxed/simple;
	bh=NT6Io2FldZlGT9JlcTBhxbDhuFOg5f9YWQDiEusP5eI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kd0bpaupg/Cq5wU0CCW1o3gjNrnek91ACva4dxltr3nhVzvlmB9QChYFBqaesq/4LUwV2SWBXZJ4JkF63aU2jYmc0XY8fupiHIxqFzuX2hZl3P4urwAhwwc4Q2IAK55SYXeH+SEaGZH577MoiAUY46ZEUrujgbQgvMnx75VFiSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C95EC4CED1;
	Sat,  1 Feb 2025 00:45:19 +0000 (UTC)
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
Subject: [PATCH v2 12/16] cxl: Add support to handle user feature commands for get feature
Date: Fri, 31 Jan 2025 17:42:05 -0700
Message-ID: <20250201004459.466499-13-dave.jiang@intel.com>
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

Add helper function to parse the user data from fwctl RPC ioctl and
send the parsed input parameters to cxl_get_feature() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Use rpc_out->payload inline. (Jonathan)
- Adjust to new cxl_get_feature() input params.
---
 drivers/cxl/fwctl.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
index 93c6174ded20..b1d4ca8786c4 100644
--- a/drivers/cxl/fwctl.c
+++ b/drivers/cxl/fwctl.c
@@ -134,6 +134,51 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
+	struct cxl_dev_state *cxlds = cxlfs->cxlmd->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
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
@@ -216,6 +261,7 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_GET_FEATURE:
+		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_SET_FEATURE:
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.48.1

