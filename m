Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0B217741
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370708; cv=none; b=AsPn5FnB3DuSoaP2s2LJfXKb/SOnPZKkWaaNLzU3DyWCjF/lNPXGhusmJk4FRstye+QgGdUF4RQRT3PbJGQhuemsezlWkEXNyJwJdBNX4c8AKJMN58qU/lxL4Lb4o3J0eV5yCseV88brQgehGLU6SN9xh4kHyhUKko+OUOM8WU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370708; c=relaxed/simple;
	bh=IYWmv49CVuV8Dlq54kOpNIBPoXOA+QbkV58/kTPrT7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q55Nc26+/2kS8KhbiV9C2y6/WEciW5MxzWXVVF7kALE+pKExd2cF6WI/8PrM4cqpU8rFOCwmmuhGOt2mG0KtT/ROLksr+Hbkpb/WLH8/LmJTSupant5TdD1qHxD4Zb9CVTEgB2FWGnU93QBX9nbVcpQmcEjDMWezXy5w/coZmss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA0C6C4CEE1;
	Sat,  1 Feb 2025 00:45:07 +0000 (UTC)
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
Subject: [PATCH v2 04/16] cxl/test: Add Get Supported Features mailbox command support
Date: Fri, 31 Jan 2025 17:41:57 -0700
Message-ID: <20250201004459.466499-5-dave.jiang@intel.com>
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
 tools/testing/cxl/test/mem.c | 68 ++++++++++++++++++++++++++++++++++++
 1 file changed, 68 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 347c1e7b37bd..9394c48cf38e 100644
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
+				    CXL_CMD_EFFECTS_VALID);
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
-- 
2.48.1

