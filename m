Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528E925A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706682; cv=none; b=EBtIScLBcXKHs7hgtlLv9HJRMKss10Iypp3TNPv2J7QDTz4khWNQf/CUvMVKSlxmJ1p9ICEm3gfpcoSXma4HrKiPHxNljb3EVv1Szbt3ZH34esF0FG3pTZTFRDMAY196YCVs+YoGjSBWviFdyPI5Nh6GWzVd6LIYQE9Qx/MiweQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706682; c=relaxed/simple;
	bh=+wc622QJR8VqjKLXtai3m00mcOyD3B6Ss44340D4Ems=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBURZ3oJ6u2YvRlRirlmNNrIU2EbEZMIF3PcEu3C9+qa60t2aPDGYXcYwx/V1nVzS9zqRyqHdpXS1oPYhodVt50409eGDNTuibbL6JOjiAdP9ybH6/dm0uDykPgJADN7a8GchqYpn1sYCxAtc48X4BOn4H4DWF/sHx2ZVEmc/Fw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A309C4CEE2;
	Tue,  4 Feb 2025 22:04:41 +0000 (UTC)
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
Subject: [PATCH v3 04/16] cxl/test: Add Get Supported Features mailbox command support
Date: Tue,  4 Feb 2025 15:03:05 -0700
Message-ID: <20250204220430.4146187-5-dave.jiang@intel.com>
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

Add cxl-test emulation of Get Supported Features mailbox command.
Currently only adding a test feature with feature identifier of
all f's for testing.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Use struct_size(). (Jonathan)
---
 tools/testing/cxl/test/mem.c | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 347c1e7b37bd..90069dd686b5 100644
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
@@ -1337,6 +1341,69 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
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
+				    CXL_CMD_EFFECTS_VALID);
+}
+
+#define MAX_CXL_TEST_FEATS	1
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
+	if (count < struct_size(out, ents, 0)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_PAYLOADLEN;
+		return -EINVAL;
+	}
+
+	out->supported_feats = cpu_to_le16(MAX_CXL_TEST_FEATS);
+	cmd->return_code = 0;
+	if (count < struct_size(out, ents, MAX_CXL_TEST_FEATS)) {
+		out->num_entries = 0;
+		return 0;
+	}
+
+	out->num_entries = cpu_to_le16(MAX_CXL_TEST_FEATS);
+	feat = out->ents;
+	fill_feature_vendor_test(feat);
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -1422,6 +1489,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_ACTIVATE_FW:
 		rc = mock_activate_fw(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		rc = mock_get_supported_features(mdata, cmd);
+		break;
 	default:
 		break;
 	}
-- 
2.48.1

