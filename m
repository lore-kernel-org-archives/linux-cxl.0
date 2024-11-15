Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F0A21FB3CF
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706077; cv=none; b=U+eeBhoc9xHRoiIwQRp8ePyTtTL/I+yO2KHB/TCGv+TQr4yDVHC2QyLIMU2lWXp2liI8nrdChplfj9JvK3809S+CSlXjJCGp++fiyAyYHzm3Ks/ZLdAFrcebSPfQFcLiybJWp5QnKw/ID2Lfo59/az4/0E0NDYRk47RXNvsEpFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706077; c=relaxed/simple;
	bh=uEFtvFETEGtpihUgPT8NuYLndrNzM6AHbh29QNVbcPo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k99d5RsTropxkHZpYZORHvlb/azhkBcJg/hChp4Ablcl2XB07i0kXRhLY5rOdRoFXoafkwAB/prFjWuQ7FISEn2wo2dMEM2Bue296HLUrjNgDcYA9BhTY12QaNrK1Jkz5zdKz4qovySLFz5wzyioGMJv1x3gUZm5tVajrC/zADI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F5BC4CECF;
	Fri, 15 Nov 2024 21:27:56 +0000 (UTC)
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
Subject: [RFC PATCH v2 06/20] cxl/mbox: Add SET_FEATURE mailbox command
Date: Fri, 15 Nov 2024 14:25:39 -0700
Message-ID: <20241115212745.869552-7-dave.jiang@intel.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add support for SET_FEATURE mailbox command.

CXL spec 3.1 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
The settings of a feature can be optionally modified using Set Feature
command.
CXL spec 3.1 section 8.2.9.6.3 describes Set Feature command.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
This patch is not needed except for the opcode enumeration.
---
 drivers/cxl/core/mbox.c | 73 +++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h    | 34 +++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index f49665d3b4d6..4b9abf9a5b2b 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1010,6 +1010,79 @@ size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_feature, CXL);
 
+/*
+ * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
+ * available in the mailbox for storing the actual feature data so that
+ * the feature data transfer would work as expected.
+ */
+#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
+int cxl_set_feature(struct cxl_dev_state *cxlds,
+		    const uuid_t feat_uuid, u8 feat_version,
+		    void *feat_data, size_t feat_data_size,
+		    u8 feat_flag)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
+	struct cxl_memdev_set_feat_pi {
+		struct cxl_mbox_set_feat_hdr hdr;
+		u8 feat_data[];
+	}  __packed;
+	size_t data_in_size, data_sent_size = 0;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+	int rc = 0;
+
+	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
+					kmalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	pi->hdr.uuid = feat_uuid;
+	pi->hdr.version = feat_version;
+	feat_flag &= ~CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK;
+	feat_flag |= CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET;
+	hdr_size = sizeof(pi->hdr);
+	/*
+	 * Check minimum mbox payload size is available for
+	 * the feature data transfer.
+	 */
+	if (hdr_size + FEAT_DATA_MIN_PAYLOAD_SIZE > cxl_mbox->payload_size)
+		return -ENOMEM;
+
+	if ((hdr_size + feat_data_size) <= cxl_mbox->payload_size) {
+		pi->hdr.flags = cpu_to_le32(feat_flag |
+				       CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
+		data_in_size = feat_data_size;
+	} else {
+		pi->hdr.flags = cpu_to_le32(feat_flag |
+				       CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
+		data_in_size = cxl_mbox->payload_size - hdr_size;
+	}
+
+	do {
+		pi->hdr.offset = cpu_to_le16(data_sent_size);
+		memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_SET_FEATURE,
+			.size_in = hdr_size + data_in_size,
+			.payload_in = pi,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0)
+			return rc;
+
+		data_sent_size += data_in_size;
+		if (data_sent_size >= feat_data_size)
+			return 0;
+
+		if ((feat_data_size - data_sent_size) <= (cxl_mbox->payload_size - hdr_size)) {
+			data_in_size = feat_data_size - data_sent_size;
+			pi->hdr.flags = cpu_to_le32(feat_flag |
+					       CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
+		} else {
+			pi->hdr.flags = cpu_to_le32(feat_flag |
+					       CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
+		}
+	} while (true);
+}
+EXPORT_SYMBOL_NS_GPL(cxl_set_feature, CXL);
+
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
  * @mds: The driver data for the operation
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8fa3a817a0dd..2c15817c80a5 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -492,6 +492,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
 	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
 	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
@@ -823,6 +824,35 @@ struct cxl_mbox_get_feat_in {
 	u8 selection;
 }  __packed;
 
+/*
+ * Set Feature CXL 3.1 Spec 8.2.9.6.3
+ */
+
+/*
+ * Set Feature input payload
+ * CXL rev 3.1 section 8.2.9.6.3 Table 8-101
+ */
+/* Set Feature : Payload in flags */
+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
+enum cxl_set_feat_flag_data_transfer {
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
+};
+
+#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
+
+struct cxl_mbox_set_feat_hdr {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	u8 version;
+	u8 rsvd[9];
+}  __packed;
+
 int cxl_internal_send_cmd(struct cxl_mailbox *cxl_mbox,
 			  struct cxl_mbox_cmd *cmd);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
@@ -889,4 +919,8 @@ int cxl_get_supported_feature_entry(struct cxl_dev_state *cxlds, const uuid_t *f
 size_t cxl_get_feature(struct cxl_dev_state *cxlds, const uuid_t feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size);
+int cxl_set_feature(struct cxl_dev_state *cxlds,
+		    const uuid_t feat_uuid, u8 feat_version,
+		    void *feat_data, size_t feat_data_size,
+		    u8 feat_flag);
 #endif /* __CXL_MEM_H__ */
-- 
2.47.0

