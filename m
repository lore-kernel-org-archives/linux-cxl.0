Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 915361CD1ED
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589947; cv=none; b=svje7gpkGU+Yy/QUpD+OMcakWVzi/EmO3z2E0nkMeGN8Fund8s3ySOdi9o9YUP5B/P090PnD+Zpx4NAngAt2TywhcfUG64mDenwVxIPVQKH8qTGA5otCHmcQgIpiIovXJvQIJ2AH6uDvvOExOJ0oWT1tiugLP4TuMdS83je2erU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589947; c=relaxed/simple;
	bh=KUy5UpMdcpjFl0z1dzwDYcR96s+vUAx0TNxrpykfiL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tdwWbU/Mwo9SIeSP1YXu/Oc88TTFhXOlo7mLMJFhSd6K+Bk7fkBCTa7FtJ54Wi70MI2qMeZZwsP6hXuyU4BT5PyWfqeUyi7Lh+6+nCYHG5rAiwyQ6t2SDRpKsvtNWM9OVzdo1Bdj3yQMiyowwQcmpNE6y/V2ogOpT4aEPcLJOSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4C7DC4CED2;
	Wed, 22 Jan 2025 23:52:26 +0000 (UTC)
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
Subject: [PATCH v1 18/19] cxl/test: Add Set Feature support to cxl_test
Date: Wed, 22 Jan 2025 16:50:49 -0700
Message-ID: <20250122235159.2716036-19-dave.jiang@intel.com>
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

Add emulation to support Set Feature mailbox command to cxl_test.
The only feature supported is the device patrol scrub feature. The
set feature allows activation of patrol scrub for the cxl_test
emulated device. The command does not support partial data transfer
even though the spec allows it. This restriction is to reduce complexity
of the emulation given the patrol scrub feature is very minimal.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 5b7b0420e3a0..f1d775968607 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -53,6 +53,10 @@ static struct cxl_cel_entry mock_cel[] = {
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
@@ -1408,6 +1412,49 @@ static int mock_get_feature(struct cxl_mockmem_data *mdata,
 	return -EOPNOTSUPP;
 }
 
+static int mock_set_test_feature(struct cxl_mockmem_data *mdata,
+				 struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_set_feat_in *input = cmd->payload_in;
+	struct vendor_test_feat *test = (struct vendor_test_feat *)input->data;
+	u32 action;
+
+	action = FIELD_GET(CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK,
+			   le32_to_cpu(input->hdr.flags));
+	/*
+	 * While it is spec compliant to support other set actions, it is not
+	 * necessary to add the complication in the emulation currently. Reject
+	 * anything besides full xfer.
+	 */
+	if (action != CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	/* Offset should be reserved when doing full transfer */
+	if (input->hdr.offset) {
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
+	struct cxl_mbox_set_feat_in *input = cmd->payload_in;
+
+	if (uuid_equal(&input->hdr.uuid, &CXL_VENDOR_FEATURE_TEST))
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
@@ -1541,6 +1588,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
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
2.47.1

