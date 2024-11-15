Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D691FB733
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706092; cv=none; b=pM2qIwI8ac4x3UYedaDIkIm6BWLMjktD+PkH7Rqq0NOMCHQIEf9W7lXRaeMmmpkYAe0DT81ZP3gI55c9aPxQSExgLEsm96iBRz0F222BRB0R7/zrO3LWHruPIA8um1hxQY0/pX+xLAvKKeir9dPp6RCV41KpF7EpsDowMy2LlGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706092; c=relaxed/simple;
	bh=Pg3M7VwAvmfMzigp9SmXmMFd+cztJ/wWo94uproU6Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dzeXPuKk2/K+1hak9IcVq8NeYqbfAet2OU6o9JC+laefgImlrRXJTwvypSWW2SXRZyuSz/JuBOV6IIJTlcplvt7UICRs2iusEXC6acc9Wn/6nwvzu6BuOEvf+EVAYB8QGkr8ghndzOyr/2CYX63iBcKWsUsRoW51sbPHu01Z5sA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15C7DC4CECF;
	Fri, 15 Nov 2024 21:28:12 +0000 (UTC)
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
Subject: [RFC PATCH v2 17/20] cxl/test: Add Get Feature support to cxl_test
Date: Fri, 15 Nov 2024 14:25:50 -0700
Message-ID: <20241115212745.869552-18-dave.jiang@intel.com>
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

Add emulation of Get Feature command to cxl_test. The feature for
device patrol scrub is returned by the emulation code. This is
the only feature currently supported by cxl_test. It returns
the information for the device patrol scrub feature.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 9103bac054b9..547d7289d8df 100644
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
@@ -1357,6 +1366,51 @@ static void fill_feature_vendor_test(struct cxl_feat_entry *feat)
 	feat->effects = cpu_to_le16(BIT(0) | BIT(9));
 }
 
+struct get_feat_input {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+} __packed;
+
+static int mock_get_test_feature(struct cxl_mockmem_data *mdata,
+				 struct cxl_mbox_cmd *cmd)
+{
+	struct vendor_test_feat *output = cmd->payload_out;
+	struct get_feat_input *input = cmd->payload_in;
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
+	struct get_feat_input *input = cmd->payload_in;
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
@@ -1487,6 +1541,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		rc = mock_get_supported_features(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_FEATURE:
+		rc = mock_get_feature(mdata, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1534,6 +1591,11 @@ static int cxl_mock_mailbox_create(struct cxl_dev_state *cxlds)
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
@@ -1625,6 +1687,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return rc;
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mock_test_feat_init(mdata);
 
 	return 0;
 }
-- 
2.47.0

