Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711DE1C5D54
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589944; cv=none; b=sIMe06ToZmVQSsh0hMxTiq5sluCBZ6flvuifnIrY71b0NC/E9ayXTxgDozslTUC1cb+wsNAW0d96PY4mXg40jFc55USJ3S9pDRpfY3cQ2iwEQeD0OYMBoHHNgYsvTLajlnR/0Gol9YREYORZMglDWD3Qt3mrNE1QPIW9gTvRzS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589944; c=relaxed/simple;
	bh=38RanBwofiKJJw5GPskz1TGMTfcZlJjTEFtaRtc9zGY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z5l2qWelevq1HLapqQw0X/T6WkHe0iY+Kr8qt57NNarLRCzaWFuOXY0Dsj13rrAXKgMv9wFsrhCtDjLnGSmC0Uf7xhYVDH9igOltB4BF7y9Iy6Wnc/gThcs9v6/8Q5SHqzfbZAKTtRHE9DVIOrXzLyVNiIZGg94wLSGyoUHyCZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A919C4CED2;
	Wed, 22 Jan 2025 23:52:24 +0000 (UTC)
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
Subject: [PATCH v1 16/19] cxl: Add support to handle user feature commands for set feature
Date: Wed, 22 Jan 2025 16:50:47 -0700
Message-ID: <20250122235159.2716036-17-dave.jiang@intel.com>
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
send the parsed input parameters to cxl_set_feature() call.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/features.c      | 48 +++++++++++++++++++++++++++++++++++++
 include/uapi/cxl/features.h |  5 ++++
 2 files changed, 53 insertions(+)

diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 7c726f1512d0..4c5c93278e58 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -191,6 +191,53 @@ static void *cxlctl_get_feature(struct cxl_features_state *cfs,
 	return no_free_ptr(rpc_out);
 }
 
+static void *cxlctl_set_feature(struct cxl_features_state *cfs,
+				const struct fwctl_rpc_cxl *rpc_in,
+				size_t *out_len)
+{
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
+	rc = cxl_set_feature(cfs->features, feat_in->hdr.uuid,
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
 static bool cxlctl_validate_set_features(struct cxl_features_state *cfs,
 					 const struct fwctl_rpc_cxl *rpc_in,
 					 enum fwctl_rpc_scope scope)
@@ -275,6 +322,7 @@ static void *cxlctl_handle_commands(struct cxl_features_state *cfs,
 	case CXL_MBOX_OP_GET_FEATURE:
 		return cxlctl_get_feature(cfs, rpc_in, out_len);
 	case CXL_MBOX_OP_SET_FEATURE:
+		return cxlctl_set_feature(cfs, rpc_in, out_len);
 	default:
 		return ERR_PTR(-EOPNOTSUPP);
 	}
diff --git a/include/uapi/cxl/features.h b/include/uapi/cxl/features.h
index 55fa5b2a5d17..67ed8b08f7e9 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -127,4 +127,9 @@ struct cxl_mbox_set_feat_hdr {
 	__u8 rsvd[9];
 } __attribute__ ((__packed__));
 
+struct cxl_mbox_set_feat_in {
+	struct cxl_mbox_set_feat_hdr hdr;
+	__u8 data[];
+} __attribute__ ((__packed__));
+
 #endif
-- 
2.47.1

