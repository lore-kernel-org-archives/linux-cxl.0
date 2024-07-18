Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9D81751
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338498; cv=none; b=j9Jx794mj1DALaagyY70PULgWg2rzgC+/8+bXhd9OJGBU8lYsaKbJjYQ6If1fnHp7IMYAIEhf9FDjy9AjjkgVn+7BYBV7hArwBgJBCfaL/O5nXG1a6o77EdQ7IktHiTMAZu+LHVecPGAfK/hfMqsArych3a33EpjEUoupyZcSh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338498; c=relaxed/simple;
	bh=cmNAgy0MbiQUno8xCz5h9pGG2UjLl6+Xz6z+JYLrcaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbIYhJM4ROMoxw0TtN0E2abPOGrFdOAN5LYYuS06vjALjfNHEpwH6PYQyQAb/J4o/30JI35W3e9gQcieVsO1at34c8VDB9Uh2WL17bQeA7ubl24pS12Gl4ymdTLUL0VkmLAwL3ezNUno9B1rM5SDuy8pNAE9e91gCt8GIIBsx6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DD4C116B1;
	Thu, 18 Jul 2024 21:34:57 +0000 (UTC)
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
Subject: [RFC PATCH 05/13] cxl/test: Add Get Supported Features mailbox command support
Date: Thu, 18 Jul 2024 14:32:23 -0700
Message-ID: <20240718213446.1750135-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add cxl-test emulation of Get Supported Features mailbox command.
Currently only planning to add the Device Patrol Scrub Control feature
as a testing vehicle.

CXL spec r3.1 8.2.9.9.11.1 Device Patrol Scrub Control Feature.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 20d58f883ca2..c2e04dbc8af6 100644
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
@@ -1334,6 +1338,64 @@ static int mock_activate_fw(struct cxl_mockmem_data *mdata,
 	return -EINVAL;
 }
 
+#define DEV_PATROL_SCRUB_FEAT_UUID						\
+	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,	\
+		  0x06, 0xdb, 0x8a)
+
+static void fill_feature_device_patrol_scrub_control(struct cxl_feat_entry *feat)
+{
+	feat->uuid = DEV_PATROL_SCRUB_FEAT_UUID;
+	feat->id = 0;
+	feat->get_feat_size = cpu_to_le16(4);
+	feat->set_feat_size = cpu_to_le16(2);
+	feat->flags = cpu_to_le32(0x21);
+	feat->get_feat_ver = 1;
+	feat->set_feat_ver = 1;
+	feat->effects = cpu_to_le16(0x202);
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
+	out->num_entries = 1;
+	feat = out->ents;
+	fill_feature_device_patrol_scrub_control(feat);
+
+	return 0;
+}
+
 static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 			      struct cxl_mbox_cmd *cmd)
 {
@@ -1421,6 +1483,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_ACTIVATE_FW:
 		rc = mock_activate_fw(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+		rc = mock_get_supported_features(mdata, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1508,6 +1573,10 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 	if (rc)
 		return rc;
 
+	rc = cxl_get_supported_features(&cxlds->cxl_mbox);
+	if (rc)
+		dev_dbg(dev, "No features enumerated\n");
+
 	rc = cxl_poison_state_init(mds);
 	if (rc)
 		return rc;
-- 
2.45.2

