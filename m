Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE2F61CD1E4
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589945; cv=none; b=RYpf8XqJpybHA92S0wgAIapPMOZdVxHkDQ8dxngnTlqyzAgwDfsjSlzSRJCAXuRErxJahFqAW7qoYC1noT3vKFbV3AHjW0nPceKs4fi6MQieBUX2xY5qE/dbdCUyhrwN0T4JnvOyNBZ9BPESwfrC6tB9ujF+JsomtlxBnp0QhKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589945; c=relaxed/simple;
	bh=X5NjDRcDvcbL/JwgOg2Afb8v9pAhVyRLi5mrQcgKoeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eNlk43QezcHx8YbdzyqyadiKx2JkPDrAHT55rYIPm6mgzAKCEy1q8aNRmhtaJrGVo9ktbPzDJtiUJaRXu+lLR4oIb2UZ4OIWJeJQNWPmmZ0slGsDsg69sNV4usRQS14yTpUzyQET0knsbcaGNDPPDToH4t1CiduvTq7nb4Ifswo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90184C4CED2;
	Wed, 22 Jan 2025 23:52:25 +0000 (UTC)
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
Subject: [PATCH v1 17/19] cxl/test: Add Get Feature support to cxl_test
Date: Wed, 22 Jan 2025 16:50:48 -0700
Message-ID: <20250122235159.2716036-18-dave.jiang@intel.com>
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

Add emulation of Get Feature command to cxl_test. The feature for
device patrol scrub is returned by the emulation code. This is
the only feature currently supported by cxl_test. It returns
the information for the device patrol scrub feature.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 2b111142b2c0..5b7b0420e3a0 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -49,6 +49,10 @@ static struct cxl_cel_entry mock_cel[] = {
 		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_SUPPORTED_FEATURES),
 		.effect = CXL_CMD_EFFECT_NONE,
 	},
+	{
+		.opcode = cpu_to_le16(CXL_MBOX_OP_GET_FEATURE),
+		.effect = CXL_CMD_EFFECT_NONE,
+	},
 	{
 		.opcode = cpu_to_le16(CXL_MBOX_OP_IDENTIFY),
 		.effect = CXL_CMD_EFFECT_NONE,
@@ -150,6 +154,10 @@ struct mock_event_store {
 	u32 ev_status;
 };
 
+struct vendor_test_feat {
+	__le32 data;
+} __packed;
+
 struct cxl_mockmem_data {
 	void *lsa;
 	void *fw;
@@ -166,6 +174,7 @@ struct cxl_mockmem_data {
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
 	unsigned long sanitize_timeout;
+	struct vendor_test_feat test_feat;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -1361,6 +1370,44 @@ static void fill_feature_vendor_test(struct cxl_feat_entry *feat)
 				    CXL_CMD_EFFECTS_EXTEND);
 }
 
+static int mock_get_test_feature(struct cxl_mockmem_data *mdata,
+				 struct cxl_mbox_cmd *cmd)
+{
+	struct vendor_test_feat *output = cmd->payload_out;
+	struct cxl_mbox_get_feat_in *input = cmd->payload_in;
+	u16 offset = le16_to_cpu(input->offset);
+	u16 count = le16_to_cpu(input->count);
+	u8 *ptr;
+
+	if (offset > sizeof(*output)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	if (offset + count > sizeof(*output)) {
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
+	ptr = (u8 *)&mdata->test_feat + offset;
+	memcpy((u8 *)output + offset, ptr, count);
+
+	return 0;
+}
+
+static int mock_get_feature(struct cxl_mockmem_data *mdata,
+			    struct cxl_mbox_cmd *cmd)
+{
+	struct cxl_mbox_get_feat_in *input = cmd->payload_in;
+
+	if (uuid_equal(&input->uuid, &CXL_VENDOR_FEATURE_TEST))
+		return mock_get_test_feature(mdata, cmd);
+
+	cmd->return_code = CXL_MBOX_CMD_RC_UNSUPPORTED;
+
+	return -EOPNOTSUPP;
+}
+
 static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
 				       struct cxl_mbox_cmd *cmd)
 {
@@ -1491,6 +1538,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		rc = mock_get_supported_features(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_FEATURE:
+		rc = mock_get_feature(mdata, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1553,6 +1603,11 @@ static int cxl_mock_setup_features(struct cxl_memdev_state *mds)
 	return 0;
 }
 
+static void cxl_mock_test_feat_init(struct cxl_mockmem_data *mdata)
+{
+	mdata->test_feat.data = cpu_to_le32(0xdeadbeef);
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1644,6 +1699,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return rc;
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mock_test_feat_init(mdata);
 
 	return 0;
 }
-- 
2.47.1

