Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198181CBE96
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589931; cv=none; b=BjM+CqBG8mpJ98MfG2auF+95nMtGB+LB3I1U94hHRUQlcgFhqSEjEr7k6LY0MOCQGNKssN28bU/wbZywCxI4YfgcmKANE3jnC9PLKftX9oH9SgpOMdsj9JJE8ER0NXcK04w4W1LhO90ttmowRN99V3AvtYr/gm9jcaGn4X3JO2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589931; c=relaxed/simple;
	bh=XlrVulVRU1y5mors2YYUBLELyZs4OSL9ZK3PT0NpI40=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aa1L0NWfwqS/JcJP3R9nJcgA6lOwWNYPfK7TvCruOgzGJMAN8eeJ7ZzqiQVscuZbfBxuDp8yofLAomOzbZMgcrwLmjjfpAXd+ierKclmOynGTJV3JwyCS+Tae9oN7TW3DXnZSE2N3g3aASDs9Ghfx50Oh1MWEoKZyZp5hkXXACc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70904C4CED6;
	Wed, 22 Jan 2025 23:52:10 +0000 (UTC)
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
Subject: [PATCH v1 06/19] cxl/test: Add Get Supported Features mailbox command support
Date: Wed, 22 Jan 2025 16:50:37 -0700
Message-ID: <20250122235159.2716036-7-dave.jiang@intel.com>
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

Add cxl-test emulation of Get Supported Features mailbox command.
Currently only adding a test feature with feature identifier of
all f's for testing.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v1:
- Fix setting of num_entries endieness issue. (Jonathan)
---
 include/cxl/features.h       | 23 ++++++++++
 tools/testing/cxl/test/mem.c | 87 ++++++++++++++++++++++++++++++++++++
 2 files changed, 110 insertions(+)

diff --git a/include/cxl/features.h b/include/cxl/features.h
index 429b9782667c..8ff7d90932d6 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -28,6 +28,29 @@ struct cxl_mbox_get_sup_feats_in {
 	u8 reserved[2];
 } __packed;
 
+/* CXL spec r3.2 Table 8-87 command effects */
+#define CXL_CMD_CONFIG_CHANGE_COLD_RESET	BIT(0)
+#define CXL_CMD_CONFIG_CHANGE_IMMEDIATE		BIT(1)
+#define CXL_CMD_DATA_CHANGE_IMMEDIATE		BIT(2)
+#define CXL_CMD_POLICY_CHANGE_IMMEDIATE		BIT(3)
+#define CXL_CMD_LOG_CHANGE_IMMEDIATE		BIT(4)
+#define CXL_CMD_SECURITY_STATE_CHANGE		BIT(5)
+#define CXL_CMD_BACKGROUND			BIT(6)
+#define CXL_CMD_BGCMD_ABORT_SUPPORTED		BIT(7)
+#define CXL_CMD_EFFECTS_EXTEND			BIT(9)
+#define CXL_CMD_CONFIG_CHANGE_CONV_RESET	BIT(10)
+#define CXL_CMD_CONFIG_CHANGE_CXL_RESET		BIT(11)
+
+/*
+ * CXL spec r3.2 Table 8-109
+ * Get Supported Features Supported Feature Entry
+ * Atribute Flags
+ */
+#define CXL_FEATURE_F_CHANGEABLE		BIT(0)
+#define CXL_FEATURE_F_PERSIST_FW_UPDATE		BIT(4)
+#define CXL_FEATURE_F_DEFAULT_SEL		BIT(5)
+#define CXL_FEATURE_F_SAVED_SEL			BIT(6)
+
 struct cxl_feat_entry {
 	uuid_t uuid;
 	__le16 id;
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 347c1e7b37bd..208337432bfe 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -44,6 +44,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_LOGS),
 		.effect = CXL_CMD_EFFECT_NONE,
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_FEATURES),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
 		.effect = CXL_CMD_EFFECT_NONE,
@@ -1337,6 +1341,67 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
 	return -EINVAL;
 }
 
+#define CXL_VENDOR_FEATURE_TEST							\
+	UUID_INIT(0xffffffff, 0xffff, 0xffff, 0xff, 0xff, 0xff, 0xff, 0xff,	\
+		  0xff, 0xff, 0xff)
+
+static void fill_feature_vendor_test(struct cxl_feat_entry *feat)
+{
+	feat->uuid = CXL_VENDOR_FEATURE_TEST;
+	feat->id = 0;
+	feat->get_feat_size = cpu_to_le16(0x4);
+	feat->set_feat_size = cpu_to_le16(0x4);
+	feat->flags = cpu_to_le32(CXL_FEATURE_F_CHANGEABLE |
+				  CXL_FEATURE_F_DEFAULT_SEL |
+				  CXL_FEATURE_F_SAVED_SEL);
+	feat->get_feat_ver = 1;
+	feat->set_feat_ver = 1;
+	feat->effects = cpu_to_le16(CXL_CMD_CONFIG_CHANGE_COLD_RESET |
+				    CXL_CMD_EFFECTS_EXTEND);
+}
+
+static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
+				       struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_sup_feats_in *in = cmd->payload_in;
+	struct cxl_mbox_get_sup_feats_out *out = cmd->payload_out;
+	struct cxl_feat_entry *feat;
+	u16 start_idx, count;
+
+	if (cmd->size_out < sizeof(*out)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
+		return -EINVAL;
+	}
+
+	/*
+	 * Current emulation only supports 1 feature
+	 */
+	start_idx = le16_to_cpu(in->start_idx);
+	if (start_idx != 0) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	count = le16_to_cpu(in->count);
+	if (count < sizeof(*out)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
+		return -EINVAL;
+	}
+
+	out->supported_feats = cpu_to_le16(1);
+	cmd->return_code = 0;
+	if (count < sizeof(*out) + sizeof(*feat)) {
+		out->num_entries = 0;
+		return 0;
+	}
+
+	out->num_entries = cpu_to_le16(1);
+	feat = out->ents;
+	fill_feature_vendor_test(feat);
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -1422,6 +1487,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_ACTIVATE_FW:
 		rc = mock_activate_fw(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		rc = mock_get_supported_features(mdata, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1469,6 +1537,21 @@ static int cxl_mock_mailbox_create(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static int cxl_mock_setup_features(struct cxl_memdev_state *mds)
+{
+	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_features *features;
+
+	features = cxl_features_alloc(cxl_mbox, cxlds->dev);
+	if (IS_ERR(features))
+		return PTR_ERR(features);
+
+	cxl_mbox->features = features;
+
+	return 0;
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1524,6 +1607,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_mock_setup_features(mds);
+	if (rc)
+		dev_dbg(dev, "cxl_test: No features setup\n");
+
 	rc = cxl_poison_state_init(mds);
 	if (rc)
 		return rc;
-- 
2.47.1

