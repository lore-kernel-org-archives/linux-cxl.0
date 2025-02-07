Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61731BFE10
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971564; cv=none; b=J9Vd+t4JF8mcq6cdlqsMKFhoBPx1o1HY62zsN041p26DtHjmY56CpiXr0kocL4213+r+762UVGpYfXF1nJ63nlt2vl8N66+DDg3GhHS2x4JWQnB/7QSwhNGBMaaIG+W/v8W4Zh4P+zA1ADVWZ4sgZsCZhFqaaum151RUEUqdWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971564; c=relaxed/simple;
	bh=AgUHn0sUq1J+bnPOxt6+rIbbT1+c8G0D07St/7pbPnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pDp4VPlPns0V6tzkoeN4m/lxlJacnykG4A45ZeldMCljR8Pk6UP7t42b1S8pNvLhmaTA6VpmoI2nMeciGM8+ujMiNpcIa1zdx/8s+aobACeGslr+06L8A30HuRI/PO7E5N1rRKCjjA0z/IFRa63uF6e9wrSuIArIYBt46MDbfKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94EDAC4CED1;
	Fri,  7 Feb 2025 23:39:24 +0000 (UTC)
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
Subject: [PATCH v4 05/15] cxl/mbox: Add SET_FEATURE mailbox command
Date: Fri,  7 Feb 2025 16:37:45 -0700
Message-ID: <20250207233914.2375110-6-dave.jiang@intel.com>
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

From: Shiju Jose <shiju.jose@huawei.com>

Add support for SET_FEATURE mailbox command.

CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
CXL devices supports features with changeable attributes.
The settings of a feature can be optionally modified using Set Feature
command.
CXL spec r3.2 section 8.2.9.6.3 describes Set Feature command.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 81 +++++++++++++++++++++++++++++++++++++
 include/cxl/features.h      | 42 +++++++++++++++++++
 2 files changed, 123 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 262e4b1cb7fc..d337224158fa 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -227,3 +227,84 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 	return data_rcvd_size;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
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
+EXPORT_SYMBOL_NS_GPL(cxl_set_feature, "CXL");
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 85036604fdba..4e3527ba8a1d 100644
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
@@ -112,6 +142,9 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code);
+int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		    u8 feat_version, void *feat_data, size_t feat_data_size,
+		    u32 feat_flag, u16 offset, u16 *return_code);
 #else
 static inline struct cxl_features_state *to_cxlfs(struct cxl_dev_state *cxlds)
 {
@@ -131,6 +164,15 @@ static inline size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox,
 {
 	return 0;
 }
+
+static inline int cxl_set_feature(struct cxl_mailbox *cxl_mbox,
+				  const uuid_t *feat_uuid,
+				  u8 feat_version, void *feat_data,
+				  size_t feat_data_size, u32 feat_flag,
+				  u16 offset, u16 *return_code)
+{
+	return -EOPNOTSUPP;
+}
 #endif
 
 #endif
-- 
2.48.1

