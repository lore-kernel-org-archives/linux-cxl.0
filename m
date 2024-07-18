Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48E96145B26
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338510; cv=none; b=J9bdOlNZ6HudJiKIl5Un/imcQcTJAvZ+ToVFhG31HCqB9L5noGajj5t75IX9rLHJ3KtHqU1Xfx5lqYuUnmKbPXkMm27MQifbWvYl8tUqYUty2/+XQWruauvQKli2Azdl4lHkZ2DWRtuuAB/U6VoDguKtlitvO+JMoG8zOjxSRKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338510; c=relaxed/simple;
	bh=vcPQBzcVpSJiEq7v3sqykVrw7W2mqBYzGNbbDIDAzk0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iy03jQ6wHcBGLQSpIz+0wEiFNGLQobKWAKZX7KDv33ThydzWt6rzWVRRELl5SleE86xmSLh3VizSKW+MA/yfe5WFEm10PTR316kQkvKwuoQevE4UhzBIj7QKim9yeRBKqeYc/Ua5miVpvu4xZR0ombA3i3YmcAUmMQp+TcletEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF831C4AF0C;
	Thu, 18 Jul 2024 21:35:09 +0000 (UTC)
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
Subject: [RFC PATCH 13/13] cxl/test: Add Set Feature support to cxl_test
Date: Thu, 18 Jul 2024 14:32:31 -0700
Message-ID: <20240718213446.1750135-14-dave.jiang@intel.com>
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

Add emulation to support Set Feature mailbox command to cxl_test.
The only feature supported is the device patrol scrub feature. The
set feature allows activation of patrol scrub for the cxl_test
emulated device. The command does not support partial data transfer
even though the spec allows it. This restriction is to reduce complexity
of the emulation given the patrol scrub feature is very minimal.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 89 ++++++++++++++++++++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index c779640cb610..c2018d894719 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -52,6 +52,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FEATURE),
 		.effect = CXL_CMD_EFFECT_NONE,
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_SET_FEATURE),
+		.effect = cpu_to_le16(EFFECT(CONF_CHANGE_IMMEDIATE)),
+	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
 		.effect = CXL_CMD_EFFECT_NONE,
@@ -1445,6 +1449,88 @@ static int mock_get_feature(struct cxl_mockmem_data *mdata,
 	return -EOPNOTSUPP;
 }
 
+struct scrub_feat_data {
+	u8 cycle;
+#define SCRUB_DATA_F_ENABLE		BIT(0)
+	u8 flags;
+};
+#define SCRUB_DATA_CYCLE_OFFSET		0
+#define SCRUB_DATA_FLAGS_OFFSET		1
+
+struct set_feat_input {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	u8 version;
+	u8 rsvd[9];
+	u8 data[];
+} __packed;
+
+enum set_feature_flags {
+	SET_FEATURE_F_FULL_XFER = 0,
+	SET_FEATURE_F_INIT_XFER,
+	SET_FEATURE_F_CONT_XFER,
+	SET_FEATURE_F_FIN_XFER,
+	SET_FEATURE_F_ABORT_XFER,
+};
+
+#define SET_FEATURE_F_ACTION_MASK	GENMASK(2, 0)
+
+static int mock_set_patrol_scrub(struct cxl_mockmem_data *mdata,
+				 struct cxl_mbox_cmd *cmd)
+{
+	struct set_feat_input *input = cmd->payload_in;
+	struct scrub_feat_data *data;
+	u32 action;
+
+	action = FIELD_GET(SET_FEATURE_F_ACTION_MASK,
+			   le32_to_cpu(input->flags));
+	/*
+	 * While it is spec compliant to support other set actions, it is not
+	 * necessary to add the complication in the emulation currently. Reject
+	 * anything besides full xfer.
+	 */
+	if (action != SET_FEATURE_F_FULL_XFER) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	/* Offset should be reserved when doing full transfer */
+	if (input->offset) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	data = (struct scrub_feat_data *)input->data;
+	/* Does not support changing cycle, should be reserved */
+	if (data->cycle) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	/* Check reserved fields */
+	if (data->flags & ~SCRUB_DATA_F_ENABLE) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+	mdata->patrol_feat.flags = data->flags & SCRUB_DATA_F_ENABLE;
+
+	return 0;
+}
+
+static int mock_set_feature(struct cxl_mockmem_data *mdata,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct set_feat_input *input = cmd->payload_in;
+
+	if (uuid_equal(&input->uuid, &DEV_PATROL_SCRUB_FEAT_UUID))
+		return mock_set_patrol_scrub(mdata, cmd);
+
+	cmd->return_code = CXL_MBOX_CMD_RC_UNSUPPORTED;
+
+	return -EOPNOTSUPP;
+}
+
 static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
 				       struct cxl_mbox_cmd *cmd)
 {
@@ -1580,6 +1666,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_GET_FEATURE:
 		rc = mock_get_feature(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_SET_FEATURE:
+		rc = mock_set_feature(mdata, cmd);
+		break;
 	default:
 		break;
 	}
-- 
2.45.2

