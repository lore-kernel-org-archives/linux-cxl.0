Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC1D198E92
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971563; cv=none; b=liZU2zbTFiiTY89JqHqR1fVcg9KURB0oK1Y9WhPLavHJEcj+biJQnjfftMaOITlsgdpb0NSSY/lmnACJLMJw00UStAN/5qNxJFmrCp9fnmj3WFrHNIk7zbh98drYmLWehdjWiadvPJvOl1nPk9TypDY8pCihWhznCqgIm6xVzG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971563; c=relaxed/simple;
	bh=hBfE7lHknsA/FMCSQmZ93YVL6QspN2w7wPX+u/i03Ho=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjrCoFXnsEtO2PJ04vrvGCiqFtUVtTTEvBYir29l15EdWYVAR25OU5o6UNjjMOT+P73TI85fEnxEbDGqddQHq0egPscXInGG2dsYUmZqyHQC53RJR2KNorTC/9ESZ1TGCBJaftIvfpaKq9EP9iHHAvmIFw0UmmgsIOGAq0Jg4y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C56C4CED1;
	Fri,  7 Feb 2025 23:39:22 +0000 (UTC)
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
Subject: [PATCH v4 04/15] cxl/mbox: Add GET_FEATURE mailbox command
Date: Fri,  7 Feb 2025 16:37:44 -0700
Message-ID: <20250207233914.2375110-5-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250207233914.2375110-1-dave.jiang@intel.com>
References: <20250207233914.2375110-1-dave.jiang@intel.com>
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
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 50 +++++++++++++++++++++++++++++++++++++
 include/cxl/features.h      | 37 +++++++++++++++++++++++++++
 2 files changed, 87 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 77a0bf3a4916..262e4b1cb7fc 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -177,3 +177,53 @@ int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 	return 0;
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
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
diff --git a/include/cxl/features.h b/include/cxl/features.h
index e8861e690701..85036604fdba 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -65,6 +65,29 @@ struct cxl_mbox_get_sup_feats_out {
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
@@ -81,9 +104,14 @@ struct cxl_features_state {
 	} *entries;
 };
 
+struct cxl_mailbox;
 #ifdef CONFIG_CXL_FEATURES
 inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds);
 int devm_cxl_setup_features(struct cxl_dev_state *cxlds);
+size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code);
 #else
 static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
@@ -94,6 +122,15 @@ static inline int devm_cxl_setup_features(struct cxl_dev_state *cxlds)
 {
 	return -EOPNOTSUPP;
 }
+
+static inline size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox,
+				     const uuid_t *feat_uuid,
+				     enum cxl_get_feat_selection selection,
+				     void *feat_out, size_t feat_out_size,
+				     u16 offset, u16 *return_code)
+{
+	return 0;
+}
 #endif
 
 #endif
-- 
2.48.1

