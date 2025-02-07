Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A144198E92
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971578; cv=none; b=YCH7x/iqNU3WMLuYWKivp9NiIoQOG1NOFrtIZbyFPycNV1PJehG86uVZMMvqTzeDGjuvp8ogdqDeqaQHmXGnzHMBVjEbTBEEUY1MRqJ4Mo4zrU4j14yCGrWNzKqrRYBrLDtsB4v3mTX9ckZLjVwf8DHIZ6aEbySpZU3DZVCNTfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971578; c=relaxed/simple;
	bh=fIMF1gjsRcx8QTt4TlPkMH+S4HIE4lCayuTlA36Hlck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tFbllMXSQtI/ezMr/Q87O/ffsGA/kFnz5GEzJgQCAsBVENSToPGoY/udB8sDLahKGLfpePdva10dBr12wf58kS24mgVYxDioX+GB/ENFzd+/kCw036fnp7gg5l5lnJpPp+OwqeAo0CUPMSFVQUDLyXnxE/llkMqQgoO5npHqHSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66A92C4CED1;
	Fri,  7 Feb 2025 23:39:37 +0000 (UTC)
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
Subject: [PATCH v4 14/15] cxl/test: Add Set Feature support to cxl_test
Date: Fri,  7 Feb 2025 16:37:54 -0700
Message-ID: <20250207233914.2375110-15-dave.jiang@intel.com>
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

Add emulation to support Set Feature mailbox command to cxl_test.
The only feature supported is the device patrol scrub feature. The
set feature allows activation of patrol scrub for the cxl_test
emulated device. The command does not support partial data transfer
even though the spec allows it. This restriction is to reduce complexity
of the emulation given the patrol scrub feature is very minimal.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 50 ++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 0ada4a747bf3..0fc45d46ba69 100644
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
@@ -1426,6 +1430,49 @@ static int mock_get_feature(struct cxl_mockmem_data *mdata,
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
@@ -1559,6 +1606,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
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
2.48.1

