Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678F725745C
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381016; cv=none; b=dmE7LWgYKvoRNHwHZm9sp+3+GGLzUlO7QsTK2MYiaY1+QMmKSzLmuSr5MGppLIh2UvokD7JxJiOXpTqAQWjFNRUxu6lyOL7edCsYDLrbUEx23KDudDJiAFjEnl1VH5n9AUzG0wJ+i8Gz0WDGv9sqJ7mUhduwld56x4lniP7ubBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381016; c=relaxed/simple;
	bh=+T95i0YHvEg01b2XXlfdSVmKoreJyaQrweXAx1pscqI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VgFvR/CU7Qvlm/nVCPXW1q/mnEhFOLPYIHjb45huPI/rEP89ZZNeVPk5zM3apYXUOz6srPodYhoK9Wybe009MYRghIjEkqXrdcL0NKxvA5os2AatI3NsZT9P1isvcQmKFm2fmGh9pqhOn38lFwNIn2f/bre7Rgfevmk3qdosEGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A552AC4CED1;
	Fri,  7 Mar 2025 20:56:55 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jgg@nvidia.com,
	saeedm@nvidia.com,
	jonathan.cameron@huawei.com,
	Dan Williams <dan.j.williams@intel.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v8 3/9] cxl: Add support for fwctl RPC command to enable CXL feature commands
Date: Fri,  7 Mar 2025 13:55:33 -0700
Message-ID: <20250307205648.1021626-4-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307205648.1021626-1-dave.jiang@intel.com>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
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

Link: https://patch.msgid.link/r/20250220194438.2281088-10-dave.jiang@intel.com
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 drivers/cxl/core/features.c | 121 +++++++++++++++++++++++++++++++++++-
 include/uapi/cxl/features.h |   1 +
 include/uapi/fwctl/cxl.h    |  46 ++++++++++++++
 3 files changed, 166 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 846de3294a5e..6cec89977fa0 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -4,6 +4,7 @@
 #include <linux/device.h>
 #include <cxl/mailbox.h>
 #include <cxl/features.h>
+#include <uapi/fwctl/cxl.h>
 #include "cxl.h"
 #include "core.h"
 #include "cxlmem.h"
@@ -349,11 +350,127 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 {
 }
 
+static void *cxlctl_get_supported_features(struct cxl_features_state *cxlfs,
+					   const struct fwctl_rpc_cxl *rpc_in,
+					   size_t *out_len)
+{
+	const struct cxl_mbox_get_sup_feats_in *feat_in;
+	struct cxl_mbox_get_sup_feats_out *feat_out;
+	struct cxl_feat_entry *pos;
+	size_t out_size;
+	int requested;
+	u32 count;
+	u16 start;
+	int i;
+
+	if (rpc_in->op_size != sizeof(*feat_in))
+		return ERR_PTR(-EINVAL);
+
+	feat_in = &rpc_in->get_sup_feats_in;
+	count = le32_to_cpu(feat_in->count);
+	start = le16_to_cpu(feat_in->start_idx);
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
+	feat_out = &rpc_out->get_sup_feats_out;
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
+static bool cxlctl_validate_hw_command(struct cxl_features_state *cxlfs,
+				       const struct fwctl_rpc_cxl *rpc_in,
+				       enum fwctl_rpc_scope scope,
+				       u16 opcode)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlfs->cxlds->cxl_mbox;
+
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		if (cxl_mbox->feat_cap < CXL_FEATURES_RO)
+			return false;
+		if (scope >= FWCTL_RPC_CONFIGURATION)
+			return true;
+		return false;
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
index 7f7ab4aefec2..d6db8984889f 100644
--- a/include/uapi/cxl/features.h
+++ b/include/uapi/cxl/features.h
@@ -42,6 +42,7 @@ struct cxl_mbox_get_sup_feats_in {
 #define CXL_CMD_EFFECTS_VALID			BIT(9)
 #define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
 #define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
+#define CXL_CMD_EFFECTS_RESERVED		GENMASK(15, 12)
 
 /*
  * struct cxl_feat_entry - Supported Feature Entry
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
new file mode 100644
index 000000000000..4bbfd7727526
--- /dev/null
+++ b/include/uapi/fwctl/cxl.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024-2025 Intel Corporation
+ *
+ * These are definitions for the mailbox command interface of CXL subsystem.
+ */
+#ifndef _UAPI_FWCTL_CXL_H_
+#define _UAPI_FWCTL_CXL_H_
+
+#include <linux/types.h>
+#include <linux/stddef.h>
+#include <cxl/features.h>
+
+/**
+ * struct fwctl_rpc_cxl - ioctl(FWCTL_RPC) input for CXL
+ * @opcode: CXL mailbox command opcode
+ * @flags: Flags for the command (input).
+ * @op_size: Size of input payload.
+ * @reserved1: Reserved. Must be 0s.
+ * @get_sup_feats_in: Get Supported Features input
+ */
+struct fwctl_rpc_cxl {
+	__struct_group(fwctl_rpc_cxl_hdr, hdr, /* no attrs */,
+		__u32 opcode;
+		__u32 flags;
+		__u32 op_size;
+		__u32 reserved1;
+	);
+	struct cxl_mbox_get_sup_feats_in get_sup_feats_in;
+};
+
+/**
+ * struct fwctl_rpc_cxl_out - ioctl(FWCTL_RPC) output for CXL
+ * @size: Size of the output payload
+ * @retval: Return value from device
+ * @get_sup_feats_out: Get Supported Features output
+ */
+struct fwctl_rpc_cxl_out {
+	__struct_group(fwctl_rpc_cxl_out_hdr, hdr, /* no attrs */,
+		__u32 size;
+		__u32 retval;
+	);
+	struct cxl_mbox_get_sup_feats_out get_sup_feats_out;
+};
+
+#endif
-- 
2.48.1

