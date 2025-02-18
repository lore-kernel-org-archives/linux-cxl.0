Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0092A1DC98C
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919462; cv=none; b=a64DBmMNBkVaThoL56vXKBN6BejuViaRZW6+CoyVYYxyGF0AiX7f90F3DDky9K8WlfoOVswS1GTixSLYj1yL8VR/Bg0cIyN1XJydSsiyskVUCH5y2b0X2SJ86cURD53T7kmmBT9lHomWcSEQoyvbJowFyJIwwHOkUgHFnadNXRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919462; c=relaxed/simple;
	bh=cv1LrOL2WBSKN0jbKNe/GSQUePP/+VXaiOdkXW6aqb0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jndZKjPhlnZhJtCRTx1I0lxMoh1++ForJlbIE+vgyvvFHojDh1Thv3hA1ePXXztVw9c0VjFBpXKMgsUab14KKyY3JwLcxRDZesloXo/IxaNTlGRqh3C1n2Twa8fMOUUcuVQuztoEZEmpWRXRQLgt4jO8TGD3uu1NEeCEp1Von3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE582C4CEE2;
	Tue, 18 Feb 2025 22:57:41 +0000 (UTC)
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
	saeed@kernel.org,
	Li Ming <ming.li@zohomail.com>
Subject: [PATCH v6 05/14] cxl/mbox: Add SET_FEATURE mailbox command
Date: Tue, 18 Feb 2025 15:54:34 -0700
Message-ID: <20250218225721.2682235-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218225721.2682235-1-dave.jiang@intel.com>
References: <20250218225721.2682235-1-dave.jiang@intel.com>
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
v6:
- move 'rc' into scope. (Jonathan)
- label feat_data as const.
- use __struct_group() for cxl_mbox_get_sup_feats_out.
---
 drivers/cxl/core/core.h     |  4 ++
 drivers/cxl/core/features.c | 80 +++++++++++++++++++++++++++++++++++++
 include/cxl/features.h      | 33 +++++++++++++++
 3 files changed, 117 insertions(+)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 7cd3b98150e6..17e99a25c29a 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -122,6 +122,10 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code);
+int cxl_set_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		    u8 feat_version, const void *feat_data,
+		    size_t feat_data_size, u32 feat_flag, u16 offset,
+		    u16 *return_code);
 #endif
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 3fc6f8415f19..17a82734a340 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -223,3 +223,83 @@ size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
 
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
+		    const void *feat_data, size_t feat_data_size,
+		    u32 feat_flag, u16 offset, u16 *return_code)
+{
+	size_t data_in_size, data_sent_size = 0;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t hdr_size;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	struct cxl_mbox_set_feat_in *pi __free(kfree) =
+			kzalloc(cxl_mbox->payload_size, GFP_KERNEL);
+	if (!pi)
+		return -ENOMEM;
+
+	uuid_copy(&pi->uuid, feat_uuid);
+	pi->version = feat_version;
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
+		pi->flags = cpu_to_le32(feat_flag |
+					CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER);
+		data_in_size = feat_data_size;
+	} else {
+		pi->flags = cpu_to_le32(feat_flag |
+					CXL_SET_FEAT_FLAG_INITIATE_DATA_TRANSFER);
+		data_in_size = cxl_mbox->payload_size - hdr_size;
+	}
+
+	do {
+		int rc;
+
+		pi->offset = cpu_to_le16(offset + data_sent_size);
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
+			pi->flags = cpu_to_le32(feat_flag |
+						CXL_SET_FEAT_FLAG_FINISH_DATA_TRANSFER);
+		} else {
+			pi->flags = cpu_to_le32(feat_flag |
+						CXL_SET_FEAT_FLAG_CONTINUE_DATA_TRANSFER);
+		}
+	} while (true);
+}
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 766c09978e5e..ae56ef7ec9ab 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -90,6 +90,39 @@ enum cxl_get_feat_selection {
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
+struct cxl_mbox_set_feat_in {
+	__struct_group(cxl_mbox_set_feat_hdr, hdr, /* no attrs */,
+		uuid_t uuid;
+		__le32 flags;
+		__le16 offset;
+		u8 version;
+		u8 rsvd[9];
+	);
+	__u8 feat_data[];
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

