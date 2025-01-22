Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E5111C5D54
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589943; cv=none; b=lLnx5KgixsW6WMGgIHh6JPcGix+U2SFcTXjjQi2ikB05Zydsbd6RY3BREZPkuMuDbsq3YZfmkP9rrLsRvL8fUf1yfC/Z5pDjfRjKNAs/oO7ebqOzzcsrvuVGYBBVKyZIjkQ7TrpIjb2vLjvXpLtUvBeWfRmy5dzjORAu88csCFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589943; c=relaxed/simple;
	bh=HlJAVLOEDjjWh2ADTL6fk5FrTEsD6dYTpGhEIuq4FXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eaEStjGUNmrn/ISmDXkoHt1UM893XHK+qJ6L2TFGhtamazosbvJXTEosDvGtxyKwaUWaZhmCqlef218wUngf6uyOl1KvvAWdaSnVX2k1TaXkMNmA/D2AA4A3dqaia7etnjxkEVRb7GPZRdsbpr/PlgH+o1i/qbz1QsdgbeV9/5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDD3CC4CED2;
	Wed, 22 Jan 2025 23:52:22 +0000 (UTC)
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
Subject: [PATCH v1 15/19] cxl: Add support to handle user feature commands for get feature
Date: Wed, 22 Jan 2025 16:50:46 -0700
Message-ID: <20250122235159.2716036-16-dave.jiang@intel.com>
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

Add helper function to parse the user data from fwctl RPC ioctl and
send the parsed input parameters to cxl_get_feature() call.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/features.c | 46 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index e65fc8479d21..7c726f1512d0 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -146,6 +146,51 @@ static void *cxlctl_get_supported_features(struct cxl_features_state *cfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_get_feature(struct cxl_features_state *cfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
+	struct cxl_mbox_get_feat_in feat_in;
+	u16 offset, count, return_code;
+	size_t out_size = *out_len;
+	void *feat_out;
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
+	feat_out = (void *)rpc_out->payload;
+	out_size = cxl_get_feature(cfs->features, feat_in.uuid,
+				   feat_in.selection, feat_out,
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
 static bool cxlctl_validate_set_features(struct cxl_features_state *cfs,
 					 const struct fwctl_rpc_cxl *rpc_in,
 					 enum fwctl_rpc_scope scope)
@@ -228,6 +273,7 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cfs,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		return cxlctl_get_supported_features(cfs, rpc_in, out_len);
 	case CXL_MBOX_OP_GET_FEATURE:
+		return cxlctl_get_feature(cfs, rpc_in, out_len);
 	case CXL_MBOX_OP_SET_FEATURE:
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
-- 
2.47.1

