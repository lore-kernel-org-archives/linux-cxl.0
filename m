Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32AA25234
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370721; cv=none; b=P6Yrh7pZSknqB+VlzS/fhHkBpeqfxBY7Sjq4pnuHqw8tcF3Tgei4OjyluLxAb0k95VOhjN56wVRiOOIVgyjGnLQ7Q2rdOttQq415/lmDARHdwadKuUtFDDAt23MDivCThblcFFp+ustrtJF9KoVm5GsHzOXa/VsYSrAnvhPwEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370721; c=relaxed/simple;
	bh=VWqTIyu054N2IMsGgVtS68IIjT2tHk7fqXY0kXjVqUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OddUwEKklAraAdJnpIgHMzRFH+rgxK4DsyvPNdsta0NaoBaPGF4KCKifBnmDX6ZLDSoJbsMcP1yCbSkHR4xwE59OCkkhmOgGS2SK9Axch97dewjrq4OmJnicqBR15itIuI/BywiNJfXJmGpbj9xbhhUsX2A5TE95iCAMDqGzJF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F463C4CED1;
	Sat,  1 Feb 2025 00:45:20 +0000 (UTC)
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
Subject: [PATCH v2 13/16] cxl: Add support to handle user feature commands for set feature
Date: Fri, 31 Jan 2025 17:42:06 -0700
Message-ID: <20250201004459.466499-14-dave.jiang@intel.com>
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
send the parsed input parameters to cxl_set_feature() call.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Adjust to new cxl_set_feature() input params.
- Add check for exclusive feature during Set Feature call
---
 drivers/cxl/core/features.c | 18 ++++++++-----
 drivers/cxl/features.h      |  1 +
 drivers/cxl/fwctl.c         | 53 +++++++++++++++++++++++++++++++++++++
 include/uapi/cxl/features.h |  5 ++++
 4 files changed, 71 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 132f93050d1c..205594a670d4 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -20,6 +20,17 @@ static const uuid_t cxl_exclusive_feats[] = {
 	CXL_FEAT_RANK_SPARING_UUID,
 };
 
+bool is_cxl_feature_exclusive_by_uuid(uuid_t *uuid)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
+		if (uuid_equal(uuid, &cxl_exclusive_feats[i]))
+			return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_NS_GPL(is_cxl_feature_exclusive_by_uuid, "CXL");
+
 /**
  * is_cxl_feature_exclusive() - Check if a CXL feature is exclusive to kernel
  * @entry: cxl feature entry
@@ -28,12 +39,7 @@ static const uuid_t cxl_exclusive_feats[] = {
  */
 bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry)
 {
-	for (int i = 0; i < ARRAY_SIZE(cxl_exclusive_feats); i++) {
-		if (uuid_equal(&entry->uuid, &cxl_exclusive_feats[i]))
-			return true;
-	}
-
-	return false;
+	return is_cxl_feature_exclusive_by_uuid(&entry->uuid);
 }
 EXPORT_SYMBOL_NS_GPL(is_cxl_feature_exclusive, "CXL");
 
diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
index e487c24ff06f..e22d7d899253 100644
--- a/drivers/cxl/features.h
+++ b/drivers/cxl/features.h
@@ -8,6 +8,7 @@ struct cxl_feat_entry;
 struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd);
 void devm_cxlfs_free(struct cxl_memdev *cxlmd);
 int devm_cxl_add_features(struct cxl_memdev *cxlmd);
+bool is_cxl_feature_exclusive_by_uuid(uuid_t *uuid);
 bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
 #endif
diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
index b1d4ca8786c4..e0ccf41ff9a5 100644
--- a/drivers/cxl/fwctl.c
+++ b/drivers/cxl/fwctl.c
@@ -179,6 +179,58 @@ static void *cxlctl_get_feature(struct cxl_features_state *cxlfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_set_feature(struct cxl_features_state *cxlfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
+	struct cxl_dev_state *cxlds = cxlfs->cxlmd->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	size_t out_size, data_size;
+	u16 offset, return_code;
+	u32 flags;
+	int rc;
+
+	if (rpc_in->op_size <= sizeof(struct cxl_mbox_set_feat_hdr))
+		return ERR_PTR(-EINVAL);
+
+	struct cxl_mbox_set_feat_in *feat_in __free(kvfree) =
+		kvzalloc(rpc_in->op_size, GFP_KERNEL);
+	if (!feat_in)
+		return ERR_PTR(-ENOMEM);
+
+	if (copy_from_user(feat_in, u64_to_user_ptr(rpc_in->in_payload),
+			   rpc_in->op_size))
+		return ERR_PTR(-EFAULT);
+
+	if (is_cxl_feature_exclusive_by_uuid(&feat_in->hdr.uuid))
+		return ERR_PTR(-EPERM);
+
+	offset = le16_to_cpu(feat_in->hdr.offset);
+	flags = le32_to_cpu(feat_in->hdr.flags);
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
+	rc = cxl_set_feature(cxl_mbox, &feat_in->hdr.uuid,
+			     feat_in->hdr.version, feat_in->data,
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
 static bool cxlctl_validate_set_features(struct cxl_features_state *cxlfs,
 					 const struct fwctl_rpc_cxl *rpc_in,
 					 enum fwctl_rpc_scope scope)
@@ -263,6 +315,7 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cxlfs,
 	case CXL_MBOX_OP_GET_FEATURE:
 		return cxlctl_get_feature(cxlfs, rpc_in, out_len);
 	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_set_feature(cxlfs, rpc_in, out_len);
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
 	}
diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
index 05c8a06a5dff..30138506b286 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -107,6 +107,11 @@ struct cxl_mbox_set_feat_hdr {
 	__u8 rsvd[9];
 } __attribute__ ((__packed__));
 
+struct cxl_mbox_set_feat_in {
+	struct cxl_mbox_set_feat_hdr hdr;
+	__u8 data[];
+} __attribute__ ((__packed__));
+
 /* Set Feature flags field */
 enum cxl_set_feat_flag_data_transfer {
 	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0,
-- 
2.48.1

