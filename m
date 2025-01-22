Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72E421CEE9F
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589933; cv=none; b=jWXhMRfBEbyryYaYpKtxVpTZxK1MFrakAFml1rZVHhhozPWTwFe7kSy9FhXqseQ149jSCXmuLvtFyhbwBNc5wsz/MaumH3gx4UdD8MvLEMZ5oX63itJ30tg7ezHqdPjhvqfpF/ytOXP1/tvLzDxalSzlFg7fC11C/AkU89HmAcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589933; c=relaxed/simple;
	bh=cnmqNZClW1YUNWFxOCsbvZ1yVnN0dnG2tyyDPjsyAVs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nLkKqxR4MZNkok5SRVvM9jhyfhlTN/gJO1B2LJrnFmr0f3h7kHzJpMNQxyHqQjLw70erd73yywvN3F9l0tXv84jIgBEq36crt/9KSYnfI6sLZk7cfs6wV2zfxHl8n3rZ1nPpOFouaqacJGR8gePiKVxrEjNPE+lcwVUtOpLibjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FDDC4CED2;
	Wed, 22 Jan 2025 23:52:13 +0000 (UTC)
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
Subject: [PATCH v1 08/19] cxl/mbox: Add SET_FEATURE mailbox command
Date: Wed, 22 Jan 2025 16:50:39 -0700
Message-ID: <20250122235159.2716036-9-dave.jiang@intel.com>
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
v1:
- CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER enum must be set to 0.
---
 drivers/cxl/core/features.c  | 92 ++++++++++++++++++++++++++++++++++++
 include/cxl/features.h       | 32 +++++++++++++
 tools/testing/cxl/test/mem.c |  1 +
 3 files changed, 125 insertions(+)

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index ab9386b53a95..932e82b52f90 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -171,3 +171,95 @@ size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
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
+int cxl_set_feature(struct cxl_features *features,
+		    const uuid_t feat_uuid, u8 feat_version,
+		    void *feat_data, size_t feat_data_size,
+		    u32 feat_flag, u16 offset, u16 *return_code)
+{
+	struct cxl_memdev_set_feat_pi {
+		struct cxl_mbox_set_feat_hdr hdr;
+		u8 feat_data[];
+	}  __packed;
+	size_t data_in_size, data_sent_size = 0;
+	struct cxl_features_state *cfs;
+	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mailbox *cxl_mbox;
+	size_t hdr_size;
+	int rc = 0;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	cfs = dev_get_drvdata(&features->dev);
+	if (!cfs)
+		return -EOPNOTSUPP;
+
+	if (!cxl_feature_enabled(cfs, CXL_MBOX_OP_SET_FEATURE))
+		return -EOPNOTSUPP;
+
+	cxl_mbox = features->cxl_mbox;
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
index 872edd0a4417..370c8d57c728 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -98,6 +98,35 @@ struct cxl_mbox_get_feat_in {
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
+	CXL_SET_FEAT_FLAG_FULL_DATA_TRANSFER = 0,
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
 bool cxl_feature_enabled(struct cxl_features_state *cfs, u16 opcode);
 struct cxl_features *cxl_features_alloc(struct cxl_mailbox *cxl_mbox,
 					struct device *parent);
@@ -108,5 +137,8 @@ size_t cxl_get_feature(struct cxl_features *features, const uuid_t feat_uuid,
 		       enum cxl_get_feat_selection selection,
 		       void *feat_out, size_t feat_out_size, u16 offset,
 		       u16 *return_code);
+int cxl_set_feature(struct cxl_features *features, const uuid_t feat_uuid,
+		    u8 feat_version, void *feat_data, size_t feat_data_size,
+		    u32 feat_flag, u16 offset, u16 *return_code);
 
 #endif
diff --git a/tools/testing/cxl/test/mem.c b/tools/testing/cxl/test/mem.c
index 208337432bfe..2b111142b2c0 100644
--- a/tools/testing/cxl/test/mem.c
+++ b/tools/testing/cxl/test/mem.c
@@ -9,6 +9,7 @@
 #include <linux/sizes.h>
 #include <linux/bits.h>
 #include <cxl/mailbox.h>
+#include <cxl/features.h>
 #include <linux/unaligned.h>
 #include <crypto/sha2.h>
 #include <cxlmem.h>
-- 
2.47.1

