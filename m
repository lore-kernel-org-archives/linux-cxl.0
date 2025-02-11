Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 611031E231F
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 18:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298559; cv=none; b=kBFhl67DJyLPxqquMEVAj/HTbU3i8L8H5cR0bRCYWNtcEqbKH+MWraI/N6KVq8e8EsP4A667hHc1qRZDBtE6hxYgfMJnGTVpDp7sjR/b1LyOb61NRmMHtmk2JytkzieGGavN5fGFVchbXUGdEV+CojjCtrNQirVgqIH6pM9bFzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298559; c=relaxed/simple;
	bh=U0oqOYEd+7zeIY7evf+gA+2Y9Cz773pL9j9Y74Wi6Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YBx+jY/jqJntoshl6+ajuoT89lM4VNoNg8n+L4f+xQ2LVKsYQWBsCAfmD0Rb2kynECbpb7IYeAgPLUp7Yosx5KB3uuNTgrDmHSZ1i7+o59CodiR3y7Xk8ytlk+dKxz2RCC47Tk7MJu7ADgiyLpEBD6fk+4r2C6yt9y9h8ApyxU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D0C8C4CEDD;
	Tue, 11 Feb 2025 18:29:19 +0000 (UTC)
From: Dave Jiang <dave.jiang@intel.com>
To: linux-cxl@vger.kernel.org
Cc: dan.j.williams@intel.com,
	ira.weiny@intel.com,
	vishal.l.verma@intel.com,
	alison.schofield@intel.com,
	Jonathan.Cameron@huawei.com,
	dave@stgolabs.net,
	jgg@nvidia.com,
	shiju.jose@huawei.com,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v5 05/15] cxl/mbox: Add SET_FEATURE mailbox command
Date: Tue, 11 Feb 2025 11:27:59 -0700
Message-ID: <20250211182909.1650096-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250211182909.1650096-1-dave.jiang@intel.com>
References: <20250211182909.1650096-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiju Jose <shiju.jose@huawei.com>

Add support for SET_FEATURE mailbox command.

CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
The settings of a feature can be optionally modified using Set Feature
command.
CXL spec r3.2 section 8.2.9.6.3 describes Set Feature command.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v5:
- Make cxl_set_feature() header internal. (Dan)
- Add missing NULL check. (Dan)
---
 drivers/cxl/core/core.h     |  3 ++
 drivers/cxl/core/features.c | 83 +++++++++++++++++++++++++++++++++++++
 include/cxl/features.h      | 30 ++++++++++++++
 3 files changed, 116 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 7cd3b98150e6..f67b3d99461e 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,6 +122,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code);
+int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		    u8 feat_version, void *feat_data, size_t feat_data_size,
+		    u32 feat_flag, u16 offset, u16 *return_code);
 #endif
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 3fc6f8415f19..e6d5465b0af1 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -223,3 +223,86 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 
 	return data_rcvd_size;
 }
+
+/*
+ * FEAT_DATA_MIN_PAYLOAD_SIZE - min extra number of bytes should be
+ * available in the mailbox for storing the actual feature data so that
+ * the feature data transfer would work as expected.
+ */
+#define FEAT_DATA_MIN_PAYLOAD_SIZE 10
+int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
+		    const uuid_t *feat_uuid, u8 feat_version,
+		    void *feat_data, size_t feat_data_size,
+		    u32 feat_flag, u16 offset, u16 *return_code)
+{
+	struct cxl_memdev_set_feat_pi {
+		struct cxl_mbox_set_feat_hdr hdr;
+		u8 feat_data[];
+	}  __packed;
+	size_t data_in_size, data_sent_size = 0;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+	int rc = 0;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	struct cxl_memdev_set_feat_pi *pi __free(kfree) =
+			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	uuid_copy(&pi->hdr.uuid, feat_uuid);
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
+	if (hdr_size + feat_data_size <= cxl_mbox->payload_size) {
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
+		pi->hdr.offset = cpu_to_le16(offset + data_sent_size);
+		memcpy(pi->feat_data, feat_data + data_sent_size, data_in_size);
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_SET_FEATURE,
+			.size_in = hdr_size + data_in_size,
+			.payload_in = pi,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0) {
+			if (return_code)
+				*return_code = mbox_cmd.return_code;
+			return rc;
+		}
+
+		data_sent_size += data_in_size;
+		if (data_sent_size >= feat_data_size) {
+			if (return_code)
+				*return_code = CXL_MBOX_CMD_RC_SUCCESS;
+			return 0;
+		}
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
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 6ee4f152650f..edecf4e8c738 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -88,6 +88,36 @@ enum cxl_get_feat_selection {
 	CXL_GET_FEAT_SEL_MAX
 };
 
+/*
+ * Set Feature CXL spec r3.2  8.2.9.6.3
+ */
+
+/*
+ * Set Feature input payload
+ * CXL spec r3.2 section 8.2.9.6.3 Table 8-101
+ */
+struct cxl_mbox_set_feat_hdr {
+	uuid_t uuid;
+	__le32 flags;
+	__le16 offset;
+	u8 version;
+	u8 rsvd[9];
+}  __packed;
+
+/* Set Feature flags field */
+enum cxl_set_feat_flag_data_transfer {
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0,
+	CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_ABORT_DATA_TRANSFER,
+	CXL_SET_FEAT_FLAG_DATA_TRANSFER_MAX
+};
+
+#define CXL_SET_FEAT_FLAG_DATA_TRANSFER_MASK	GENMASK(2, 0)
+
+#define CXL_SET_FEAT_FLAG_DATA_SAVED_ACROSS_RESET	BIT(3)
+
 /**
  * struct cxl_features_state - The Features state for the device
  * @cxlds: Pointer to CXL device state
-- 
2.48.1

