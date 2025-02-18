Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284CC1D618E
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919459; cv=none; b=cbh2m67o/SboqLgVWwdlCWAJxWhuNWF2cHZc5TStDj+um5pMdC1jxlXPfCsiPsEC1DfIP9Mban1U/909dF9bfF60aHuHD1BYud4d3HkLoDmmULPO4nsbQeT0wp0OfccUFsR4ximIqhrbPrZylLMiU54aiLjG/xbxXRverYTR6EI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919459; c=relaxed/simple;
	bh=EqJ04/unX7tmOGoCuDxeeNww+BqnnLfyBJoNDstLr+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T3by8anv6ZHAl9C2j0glESqzXBjrZeIJxsw3bvy1yJeNsSbxMJ+Q0iO6CgmMmiwwdffFCQ6GkfJ3Oo6CnKQ/mgdjhqK8BywJlyZ3B/u2BkyZQqWzxbMeiq3FYBJ5+R5HWwu4+z6ZFp6KwNlPiKPptkJSDmGNPku5OiQJDEQTelU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDE38C4CEE2;
	Tue, 18 Feb 2025 22:57:38 +0000 (UTC)
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
Subject: [PATCH v6 03/14] cxl/test: Add Get Supported Features mailbox command support
Date: Tue, 18 Feb 2025 15:54:32 -0700
Message-ID: <20250218225721.2682235-4-dave.jiang@intel.com>
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

Add cxl-test emulation of Get Supported Features mailbox command.
Currently only adding a test feature with feature identifier of
all f's for testing.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Acked-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 70 ++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index e9494cd446ef..4809a90ff9b6 100644
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
@@ -1354,6 +1358,69 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
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
@@ -1439,6 +1506,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
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

