Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDD21FB733
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706094; cv=none; b=EBYrHUpr1huUFhCrnY8nYuWpKEgHiHvm8r29A3/Q65Tf0anc71GX0XHu6jYL9aT/O7v/JuKrkajyGPZ0x442TvrE+S6q+g1eYTqjErnTE8j3yNLKAivhvrxCYj+mUgRy1RUV6HVhoxTMdOSrEqwDxX0IA9Ktmyp11nCQVTj2TNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706094; c=relaxed/simple;
	bh=eYr2Y57/DWFFYj9Nk2Jxd8yT40zqiBcaB4xQB6CYOlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdu9QCytOz7BU7tCqODRWjBBsvy2tj7Y1men1Eu063EJ58/5bYRuQEie3gv1LCwad6AqnqUVtBp3Ejjk/jRNSNigzz4deunR4ljnb2+1VZnddF9VsvhGVlT4iE2CtRepQTvjy7Mu1hpWUWZJNj65+PiKlPb7BJSHFVvfAzW9+Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E796C4CECF;
	Fri, 15 Nov 2024 21:28:13 +0000 (UTC)
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
Subject: [RFC PATCH v2 18/20] cxl/test: Add Set Feature support to cxl_test
Date: Fri, 15 Nov 2024 14:25:51 -0700
Message-ID: <20241115212745.869552-19-dave.jiang@intel.com>
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

Add emulation to support Set Feature mailbox command to cxl_test.
The only feature supported is the device patrol scrub feature. The
set feature allows activation of patrol scrub for the cxl_test
emulated device. The command does not support partial data transfer
even though the spec allows it. This restriction is to reduce complexity
of the emulation given the patrol scrub feature is very minimal.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 547d7289d8df..25f07843cb84 100644
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
@@ -1411,6 +1415,68 @@ static int mock_get_feature(struct cxl_mockmem_data *mdata,
 	return -EOPNOTSUPP;
 }
 
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
+static int mock_set_test_feature(struct cxl_mockmem_data *mdata,
+				 struct cxl_mbox_cmd *cmd)
+{
+	struct set_feat_input *input = cmd->payload_in;
+	struct vendor_test_feat *test = (struct vendor_test_feat *)input->data;
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
+	memcpy(&mdata->test_feat.data, &test->data, sizeof(u32));
+
+	return 0;
+}
+
+static int mock_set_feature(struct cxl_mockmem_data *mdata,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct set_feat_input *input = cmd->payload_in;
+
+	if (uuid_equal(&input->uuid, &CXL_VENDOR_FEATURE_TEST))
+		return mock_set_test_feature(mdata, cmd);
+
+	cmd->return_code = CXL_MBOX_CMD_RC_UNSUPPORTED;
+
+	return -EOPNOTSUPP;
+}
+
 static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
 				       struct cxl_mbox_cmd *cmd)
 {
@@ -1544,6 +1610,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
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
2.47.0

