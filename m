Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8071DC98C
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919461; cv=none; b=RuoDutwzUlA9fvsb72orZOhENBCtY0+C/kjADwBe3+Z1qBeAXt5Rj41EwsTqaZavL75Owgj5DIbnZq/bJS+j8V9EJAP58eHhAMOQ5O/89TMdN8B36Xcdq/3QvU/C3gdsHhCHtgztB27pGsmTjs9Lk50mZoR12JUhWuA9NQTmpnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919461; c=relaxed/simple;
	bh=75jNbwskFiCjF9IlfMH/45mYOzVC55+QrPvhKF9ciUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GwzLvFgn3boKXvsEeRCrkd+d3DH3zwbTpTsVh2TE8h4GwBsz677LywGbmLXoicRP7MvckeNzAs4ESoqiu4QhOMspcAmUZ1agReCe8D5Up8JA2VNu5t2hRkq+4FCVHMXy8vcODyVEV8tH58STj23uOd/J3wQt93ZqE0zMwSzd7nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFBAC4CEE2;
	Tue, 18 Feb 2025 22:57:40 +0000 (UTC)
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
Subject: [PATCH v6 04/14] cxl/mbox: Add GET_FEATURE mailbox command
Date: Tue, 18 Feb 2025 15:54:33 -0700
Message-ID: <20250218225721.2682235-5-dave.jiang@intel.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_FEATURE mailbox command.

CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.
CXL spec r3.2 section 8.2.9.6.2 describes Get Feature command.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/core.h     |  7 ++++++
 drivers/cxl/core/features.c | 50 +++++++++++++++++++++++++++++++++++++
 include/cxl/features.h      | 24 ++++++++++++++++++
 3 files changed, 81 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index f77fcf71ade5..7cd3b98150e6 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -117,4 +117,11 @@ bool cxl_need_node_perf_attrs_update(int nid);
 int cxl_port_get_switch_dport_bandwidth(struct cxl_port *port,
 					struct access_coordinate *c);
 
+#ifdef CONFIG_CXL_FEATURES
+size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code);
+#endif
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index f2898a56bd63..3fc6f8415f19 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -4,6 +4,7 @@
 #include <cxl/mailbox.h>
 #include <cxl/features.h>
 #include "cxl.h"
+#include "core.h"
 #include "cxlmem.h"
 
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
@@ -173,3 +174,52 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 	return devm_add_action_or_reset(cxlds->dev, free_cxlfs, no_free_ptr(cxlfs));
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_features, "CXL");
+
+size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code)
+{
+	size_t data_to_rd_size, size_out;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	int rc;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	if (!feat_out || !feat_out_size)
+		return 0;
+
+	size_out = min(feat_out_size, cxl_mbox->payload_size);
+	uuid_copy(&pi.uuid, feat_uuid);
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
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 5b3485eb0f77..766c09978e5e 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -67,6 +67,29 @@ struct cxl_mbox_get_sup_feats_out {
 	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
 } __packed;
 
+/*
+ * Get Feature CXL spec r3.2 Spec 8.2.9.6.2
+ */
+
+/*
+ * Get Feature input payload
+ * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
+ */
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+}  __packed;
+
+/* Selection field for 'struct cxl_mbox_get_feat_in' */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
+	CXL_GET_FEAT_SEL_SAVED_VALUE,
+	CXL_GET_FEAT_SEL_MAX
+};
+
 /**
  * struct cxl_features_state - The Features state for the device
  * @cxlds: Pointer to CXL device state
@@ -82,6 +105,7 @@ struct cxl_features_state {
 	} *entries;
 };
 
+struct cxl_mailbox;
 #ifdef CONFIG_CXL_FEATURES
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
-- 
2.48.1

