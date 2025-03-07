Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E055257449
	for <linux-cxl@vger.kernel.org>; Fri,  7 Mar 2025 20:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741381020; cv=none; b=mVQvyp1JDorY0MQVBKkVLbGdGshMi1YafvP1Zx4tuX0T1i37Yrh8rsH4vsR6V6iK0E7g8V4GBVeZVwlm/Xrc1PI5f5OTg94zNqQ8Q7azUmeQtxxkmuUh9Gumq3EnJHirXHl33AlRaEzfpdMd6zFU/X948wA2+mp2flVJoWZa8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741381020; c=relaxed/simple;
	bh=4VWrDW5zca75TVE5+3OPaGR1EKI5gVYQqbQDyApEeaI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IEqXib0zzP1Pmu/hDr6XyNK5Hu8ULBjkT+JOOvHcQNf7fcnLrTOsK+2CvTpaxYchxHFL42tu/w0jUc3qJtTGQXPkoseyIhrc3M06SRuNWiscBJ67iBRARqOQkDCQztxszIOW3fQGh9eSldosorHuYA1/fL5jWl1pcZcMdWvjkDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F454C4CED1;
	Fri,  7 Mar 2025 20:57:00 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: jgg@nvidia.com,
	saeedm@nvidia.com,
	jonathan.cameron@huawei.com,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v8 6/9] cxl/test: Add Get Feature support to cxl_test
Date: Fri,  7 Mar 2025 13:55:36 -0700
Message-ID: <20250307205648.1021626-7-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250307205648.1021626-1-dave.jiang@intel.com>
References: <20250307205648.1021626-1-dave.jiang@intel.com>
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

Link: https://patch.msgid.link/r/20250220194438.2281088-13-dave.jiang@intel.com
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
---
 tools/testing/cxl/test/mem.c | 56 ++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 848db399102c..af70932c9bb0 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -48,6 +48,10 @@ static struct cxl_cel_entry mock_cel[] = {
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
@@ -149,6 +153,10 @@ struct mock_event_store {
 	u32 ev_status;
 };
 
+struct vendor_test_feat {
+	__le32 data;
+} __packed;
+
 struct cxl_mockmem_data {
 	void *lsa;
 	void *fw;
@@ -165,6 +173,7 @@ struct cxl_mockmem_data {
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
 	unsigned long sanitize_timeout;
+	struct vendor_test_feat test_feat;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -1379,6 +1388,44 @@ static void fill_feature_vendor_test(struct cxl_feat_entry *feat)
 
 #define MAX_CXL_TEST_FEATS	1
 
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
@@ -1509,6 +1556,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		rc = mock_get_supported_features(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_FEATURE:
+		rc = mock_get_feature(mdata, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1556,6 +1606,11 @@ static int cxl_mock_mailbox_create(struct cxl_dev_state *cxlds)
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
@@ -1651,6 +1706,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		dev_dbg(dev, "No CXL FWCTL setup\n");
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mock_test_feat_init(mdata);
 
 	return 0;
 }
-- 
2.48.1

