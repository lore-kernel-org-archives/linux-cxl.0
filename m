Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C561CD1EA
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589932; cv=none; b=QB9ICgoKKcxMeT3HSIMM/i8WIDlm942fatqOW5NcSIXXoPtwO66HSuX8W/UQzu+z/SHMcXaWSQVZGrD9aByBdoRrmm1UCTRLQmN5mr3xCgvzpkdXyFL4ptIEToLCLWnejL+sa2TWl0CZB27JoHas/wYJFI0Ai6/h/1sTrOuEVpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589932; c=relaxed/simple;
	bh=e6XFUgkrU2imjzu+WJjfu5d7Yp1JoVBxvZLn0kKAjAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB12R3JjxZrVU3/uQV9XmVlmu4zn1ozaasSuBRLc5k/YMUpIYDg1RqFFj/dCVsLHTYgu2Gsesj4ALuDnxdMKzMxuoj5blw8z3aHNVs3MHob+JD8Y77tUDDq/RAJzJOQnFReQLe6sRI//ySkCpOiIOEgaQlKWpHfI+PxjYDRzV24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0649C4CED6;
	Wed, 22 Jan 2025 23:52:11 +0000 (UTC)
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
Subject: [PATCH v1 07/19] cxl/mbox: Add GET_FEATURE mailbox command
Date: Wed, 22 Jan 2025 16:50:38 -0700
Message-ID: <20250122235159.2716036-8-dave.jiang@intel.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.
CXL spec 3.1 section 8.2.9.6.2 describes Get Feature command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v1:
- pass in cxl_mbox instead of cxlds (Dan)
- Move to the feature driver model. (Dan)
---
 drivers/cxl/core/features.c | 74 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/features.c      |  6 +--
 include/cxl/features.h      | 27 ++++++++++++++
 3 files changed, 102 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 66a4b82910e6..ab9386b53a95 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -4,6 +4,7 @@
 #include <cxl/mailbox.h>
 #include "cxl.h"
 #include "core.h"
+#include "cxlmem.h"
 
 #define CXL_FEATURE_MAX_DEVS 65536
 static DEFINE_IDA(cxl_features_ida);
@@ -97,3 +98,76 @@ cxl_get_supported_feature_entry(struct cxl_features *features,
 	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, "CXL");
+
+bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode)
+{
+	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
+	struct cxl_mem_command *cmd;
+
+	cmd = cxl_find_feature_command(opcode);
+	if (!cmd)
+		return false;
+
+	return test_bit(cmd->info.id, cxl_mbox->feature_cmds);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_feature_enabled, "CXL");
+
+size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code)
+{
+	size_t data_to_rd_size, size_out;
+	struct cxl_features_state *cfs;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mailbox *cxl_mbox;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	int rc;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	cfs = dev_get_drvdata(&features->dev);
+	if (!cfs)
+		return 0;
+
+	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_GET_FEATURE))
+		return 0;
+
+	if (!feat_out || !feat_out_size)
+		return 0;
+
+	cxl_mbox = features->cxl_mbox;
+	size_out = min(feat_out_size, cxl_mbox->payload_size);
+	pi.uuid = feat_uuid;
+	pi.selection = selection;
+	do {
+		data_to_rd_size = min(feat_out_size - data_rcvd_size,
+				      cxl_mbox->payload_size);
+		pi.offset = cpu_to_le16(offset + data_rcvd_size);
+		pi.count = cpu_to_le16(data_to_rd_size);
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_FEATURE,
+			.size_in = sizeof(pi),
+			.payload_in = &pi,
+			.size_out = size_out,
+			.payload_out = feat_out + data_rcvd_size,
+			.min_out = data_to_rd_size,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0 || !mbox_cmd.size_out) {
+			if (return_code)
+				*return_code = mbox_cmd.return_code;
+			return 0;
+		}
+		data_rcvd_size += mbox_cmd.size_out;
+	} while (data_rcvd_size < feat_out_size);
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
+
+	return data_rcvd_size;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 0d1fc3da9e35..6b061bef3a6a 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -47,14 +47,10 @@ static int cxl_get_supported_features(struct cxl_features_state *cfs)
 	struct cxl_mbox_get_sup_feats_in mbox_in;
 	struct cxl_feat_entry *entry;
 	struct cxl_mbox_cmd mbox_cmd;
-	struct cxl_mem_command *cmd;
 	int count;
 
 	/* Get supported features is optional, need to check */
-	cmd = cxl_find_feature_command(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
-	if (!cmd)
-		return -EOPNOTSUPP;
-	if (!test_bit(cmd->info.id, cxl_mbox->feature_cmds))
+	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_GET_SUPPORTED_FEATURES))
 		return -EOPNOTSUPP;
 
 	count = cxl_get_supported_features_count(cxl_mbox);
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 8ff7d90932d6..872edd0a4417 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -76,10 +76,37 @@ struct cxl_features_state {
 	struct cxl_feat_entry *entries;
 };
 
+/*
+ * Get Feature CXL 3.1 Spec 8.2.9.6.2
+ */
+
+/*
+ * Get Feature input payload
+ * CXL rev 3.1 section 8.2.9.6.2 Table 8-99
+ */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
+	CXL_GET_FEAT_SEL_SAVED_VALUE,
+	CXL_GET_FEAT_SEL_MAX
+};
+
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+}  __packed;
+
+bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode);
 struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
 					struct device *parent);
 struct cxl_feat_entry *
 cxl_get_supported_feature_entry(struct cxl_features *features,
 				const uuid_t *feat_uuid);
+size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code);
 
 #endif
-- 
2.47.1

