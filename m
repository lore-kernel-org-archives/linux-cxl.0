Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899EF25A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706697; cv=none; b=W8yHlj/8QtuGqa4D1EAeJ0uNQ/NMPM4PI6soTjkRneGXizMdttiKEomhSgbXvBzeU7NkaXeGS2QgidsxzaRyvQ5LsZwc7jmI725XEMEFHnu0Fzxe3z6Z7Gt7RMhvnEsnsi4vu+smIMc/btzfzAErNkju10ztF15qS3wj0Ovf944=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706697; c=relaxed/simple;
	bh=YOfMXciiKq14lpl56ec1f1NH8FLYv3CzZYLlgH2vyak=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxrGfptiMSnO0lx05a6HXT1zeKNs+X7zFYBtD71XHvflovkjAShhCNxzNEfElEfyhSgQxd5BzqvNxmGR69C06JmveQV7stH/pngdau/jz9HTk3hCA9sa3nXMqZFHd3ey4+9pW3F1Qq6fXx2ZvPjQgmOyNP7apJdr6ZAZmOKvIfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A8C6C4CEDF;
	Tue,  4 Feb 2025 22:04:57 +0000 (UTC)
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
Subject: [PATCH v3 12/16] cxl: Add support to handle user feature commands for get feature
Date: Tue,  4 Feb 2025 15:03:13 -0700
Message-ID: <20250204220430.4146187-13-dave.jiang@intel.com>
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

Add helper function to parse the user data from fwctl RPC ioctl and
send the parsed input parameters to cxl_get_feature() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/fwctl.c | 46 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
index 39c01ef4dbf2..959845a466ff 100644
--- a/drivers/cxl/fwctl.c
+++ b/drivers/cxl/fwctl.c
@@ -132,6 +132,51 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
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
@@ -214,6 +259,7 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		return cxlctl_get_supported_features(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_GET_FEATURE:
+		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_SET_FEATURE:
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.48.1

