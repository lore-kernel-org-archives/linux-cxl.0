Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0F5C1E283E
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706074; cv=none; b=ChIam1XUSQbIOh1HJz3r0eBJ5QQh/lccAuIOAyiHzgQY0giDLS+UuAkd5tC2yfWpj35Uxm47D/uZ4PolzpvIDgdM3p97i6mnhytmI/LW8lxEjq1zByAUukhrW7DZPxqwMoWJbiPvDp2qN5w75tDc2rwsc/CpvH6DFbGbvDC4jCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706074; c=relaxed/simple;
	bh=r+z2m9Neq5I//V0BhWjlKEGisd9DSrWGdV77VIDBw48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hMDhhjM5TieGoGm5hN9zaAMu83Fm/E6Yb/F0bUD13JEuhF1AXw1oTQVSmxn2rMAmSHlMKhy7l0y3Mq8vczMkdlgoUiEHnmwShJFEfJdy5KbjD21sXgzvUo+z+ACPvt64tLarEpm8gsIcLxmps0jjljBtKRGOMf9KSkWID05FVRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6AB6C4CECF;
	Fri, 15 Nov 2024 21:27:53 +0000 (UTC)
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
Subject: [RFC PATCH v2 04/20] cxl/mbox: Add GET_FEATURE mailbox command
Date: Fri, 15 Nov 2024 14:25:37 -0700
Message-ID: <20241115212745.869552-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
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
This patch is not needed by this series except the opcode enumeration.
---
 drivers/cxl/core/mbox.c | 41 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 26 ++++++++++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4ba56f3d5a65..f70bd7d28ff8 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -968,6 +968,47 @@ int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *f
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_supported_feature_entry, CXL);
 
+size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	size_t data_to_rd_size, size_out;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	int rc;
+
+	if (!feat_out || !feat_out_size)
+		return 0;
+
+	size_out = min(feat_out_size, cxl_mbox->payload_size);
+	pi.uuid = feat_uuid;
+	pi.selection = selection;
+	do {
+		data_to_rd_size = min(feat_out_size - data_rcvd_size,
+				      cxl_mbox->payload_size);
+		pi.offset = cpu_to_le16(data_rcvd_size);
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
+		if (rc < 0 || !mbox_cmd.size_out)
+			return 0;
+		data_rcvd_size += mbox_cmd.size_out;
+	} while (data_rcvd_size < feat_out_size);
+
+	return data_rcvd_size;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 6685dd76985a..8fa3a817a0dd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -491,6 +491,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -800,6 +801,28 @@ struct cxl_mbox_get_sup_feats_out {
 	struct cxl_feat_entry ents[] __counted_by_le(supported_feats);
 } __packed;
 
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
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -863,4 +886,7 @@ void cxl_dpa_debug(struct seq_file *file, struct cxl_dev_state *cxlds);
 int cxl_get_supported_features(struct cxl_dev_state *cxlds);
 int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *feat_uuid,
 				    struct cxl_feat_entry *feat_entry_out);
+size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size);
 #endif /* __CXL_MEM_H__ */
-- 
2.47.0

