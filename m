Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC641143C6F
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338508; cv=none; b=D6drV862Zz0vVn8S3wVvj/CnbZP5O+4HnzsmSwipO8imcOPIg8gxEZHHoL85UOmdJT5kMR6vo2rz+Plap4av15NW8oXsJHQAcw5lyjJy2nlP57oWW9jDhnEyeebjIoiSnp2+io/j82jsDC09ifFMrsqoJdjVZFBlMc4RjjypbMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338508; c=relaxed/simple;
	bh=1PbyGhZhue74eMwDpmlWlI5dznv/Vu/2ks5f3ykVvOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dr7Ss4crngp7K89XYNMMew4wMYgQE8p8KVwfDvzNja9jd6C2VeXzjAjBCq7OZSqFXD9dRCs8lfMsvM22O95n5cO57LCxtGNho7EuHI0qFCvKJHvYabZ3XX+8o9rL1P/8p627kEfHlKjYOR/URdQl1f/R1Z+qjBNHk3XPdZJPdpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10CF9C4AF0E;
	Thu, 18 Jul 2024 21:35:07 +0000 (UTC)
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
Subject: [RFC PATCH 12/13] cxl/test: Add Get Feature support to cxl_test
Date: Thu, 18 Jul 2024 14:32:30 -0700
Message-ID: <20240718213446.1750135-13-dave.jiang@intel.com>
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

Add emulation of Get Feature command to cxl_test. The feature for
device patrol scrub is returned by the emulation code. This is
the only feature currently supported by cxl_test. It returns
the information for the device patrol scrub feature.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 tools/testing/cxl/test/mem.c | 107 +++++++++++++++++++++++++++++++++++
 1 file changed, 107 insertions(+)

diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index c2e04dbc8af6..c779640cb610 100644
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
@@ -149,6 +153,16 @@ struct mock_event_store {
 	u32 ev_status;
 };
 
+struct scrub_patrol_read_feat {
+	u8 cap;
+#define SCRUB_HOURS_CYCLE_DEFAULT	6
+#define SCRUB_HOURS_CYCLE_MASK		GENMASK(7, 0)
+#define SCRUB_SMALLEST_HOURS_DEFAULT	2
+#define SCRUB_SMALLEST_HOURS_MASK	GENMASK(15, 8)
+	__le16 cycle_support;
+	u8 flags;
+} __packed;
+
 struct cxl_mockmem_data {
 	void *lsa;
 	void *fw;
@@ -165,6 +179,7 @@ struct cxl_mockmem_data {
 	u8 event_buf[SZ_4K];
 	u64 timestamp;
 	unsigned long sanitize_timeout;
+	struct scrub_patrol_read_feat patrol_feat;
 };
 
 static struct mock_event_log *event_find_log(struct device *dev, int log_type)
@@ -1354,6 +1369,82 @@ static void fill_feature_device_patrol_scrub_control(struct cxl_feat_entry *feat
 	feat->effects = cpu_to_le16(0x202);
 }
 
+struct get_feat_input {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+} __packed;
+
+enum scrub_patrol_selection {
+	SCRUB_PATROL_CURRENT_VALUE = 0,
+	SCRUB_PATROL_DEFAULT_VALUE = 1,
+	SCRUB_PATROL_SAVED_VALUE = 2,
+};
+
+static int mock_get_patrol_scrub(struct cxl_mockmem_data *mdata,
+				 struct cxl_mbox_cmd *cmd)
+{
+	struct scrub_patrol_read_feat *output = cmd->payload_out;
+	struct get_feat_input *input = cmd->payload_in;
+	struct scrub_patrol_read_feat feat = { 0 };
+	u16 offset = le16_to_cpu(input->offset);
+	u16 count = le16_to_cpu(input->count);
+	u16 support;
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
+	/*
+	 * CXL Spec r3.1 Table 8-206
+	 * Saved selection is not supported
+	 */
+	switch (input->selection) {
+	case SCRUB_PATROL_SAVED_VALUE:
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EOPNOTSUPP;
+	case SCRUB_PATROL_DEFAULT_VALUE:
+		support = FIELD_PREP(SCRUB_HOURS_CYCLE_MASK,
+				     SCRUB_HOURS_CYCLE_DEFAULT) |
+			  FIELD_PREP(SCRUB_SMALLEST_HOURS_MASK,
+				     SCRUB_SMALLEST_HOURS_DEFAULT);
+		feat.cycle_support = cpu_to_le16(support);
+		ptr = (u8 *)&feat + offset;
+		break;
+	case SCRUB_PATROL_CURRENT_VALUE:
+		ptr = (u8 *)&mdata->patrol_feat + offset;
+		break;
+	default:
+		cmd->return_code = CXL_MBOX_CMD_RC_INPUT;
+		return -EINVAL;
+	}
+
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
+	if (uuid_equal(&input->uuid, &DEV_PATROL_SCRUB_FEAT_UUID))
+		return mock_get_patrol_scrub(mdata, cmd);
+
+	cmd->return_code = CXL_MBOX_CMD_RC_UNSUPPORTED;
+
+	return -EOPNOTSUPP;
+}
+
 static int mock_get_supported_features(struct cxl_mockmem_data *mdata,
 				       struct cxl_mbox_cmd *cmd)
 {
@@ -1486,6 +1577,9 @@ static int cxl_mock_mbox_send(struct cxl_mailbox *cxl_mbox,
 	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
 		rc = mock_get_supported_features(mdata, cmd);
 		break;
+	case CXL_MBOX_OP_GET_FEATURE:
+		rc = mock_get_feature(mdata, cmd);
+		break;
 	default:
 		break;
 	}
@@ -1522,6 +1616,18 @@ static ssize_t event_trigger_store(struct device *dev,
 }
 static DEVICE_ATTR_WO(event_trigger);
 
+static void cxl_mock_mem_set_default_feat(struct cxl_mockmem_data *mdata)
+{
+	u16 support;
+
+	support = FIELD_PREP(SCRUB_HOURS_CYCLE_MASK,
+			     SCRUB_HOURS_CYCLE_DEFAULT) |
+		  FIELD_PREP(SCRUB_SMALLEST_HOURS_MASK,
+			     SCRUB_SMALLEST_HOURS_DEFAULT);
+
+	mdata->patrol_feat.cycle_support = cpu_to_le16(support);
+}
+
 static int cxl_mock_mem_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
@@ -1609,6 +1715,7 @@ static int cxl_mock_mem_probe(struct platform_device *pdev)
 		return rc;
 
 	cxl_mem_get_event_records(mds, CXLDEV_EVENT_STATUS_ALL);
+	cxl_mock_mem_set_default_feat(mdata);
 
 	return 0;
 }
-- 
2.45.2

