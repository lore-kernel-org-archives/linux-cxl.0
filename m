Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C8C9461
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370709; cv=none; b=FGPuycq6D+RESQEF4wf4WODFypS/LA5PopofssFr/JwhLgfHTad7XV9NzxcYx7XSRYgyx8nk3USJ4rCv/79nQakL7eCVzgIH8qlCTxdwP4ZcH12yJ0hfUesVYqZvWYfg9MzbEwCP5f4ouW4qjlerAtHjlXCB6BpNihriQ+x29tQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370709; c=relaxed/simple;
	bh=RYXrY3QHNpNUNgho5y1PuE761DcaLkxZcUIunyimT88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EFSiHD+Xild2z9i8Qw4M35erOjrxujkdRYNb38j6C8mU98N33HrnSLWAhvXtumSednO3YXb+H70h/nMYt343LegBHhqQ3DXy3chZGOsa1wAwaS/QWJR0wZV1MkhsvTNxiGb4usG7OqO4NUZR86MrBYA2o7YiI35d8pLshkSd2Fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32595C4CED1;
	Sat,  1 Feb 2025 00:45:09 +0000 (UTC)
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
Subject: [PATCH v2 05/16] cxl/mbox: Add GET_FEATURE mailbox command
Date: Fri, 31 Jan 2025 17:41:58 -0700
Message-ID: <20250201004459.466499-6-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250201004459.466499-1-dave.jiang@intel.com>
References: <20250201004459.466499-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shiju Jose <shiju.jose@huawei.com>

Add support for GET_FEATURE mailbox command.

CXL spec r3.2 section 8.2.9.6 describes optional device specific features.
The settings of a feature can be retrieved using Get Feature command.
CXL spec r3.2 section 8.2.9.6.2 describes Get Feature command.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Set input as 'struct cxl_mailbox' for cxl_get_feature() (Dan)
- Set feat_uuid as 'uuid_t *' (Dan)
- Use uuid_copy() to assign uuid
---
 drivers/cxl/core/Makefile   |  1 +
 drivers/cxl/core/features.c | 59 +++++++++++++++++++++++++++++++++++++
 include/cxl/features.h      | 29 ++++++++++++++++++
 tools/testing/cxl/Kbuild    |  1 +
 4 files changed, 90 insertions(+)
 create mode 100644 drivers/cxl/core/features.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 9259bcc6773c..73b6348afd67 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -14,5 +14,6 @@ cxl_core-y += pci.o
 cxl_core-y += hdm.o
 cxl_core-y += pmu.o
 cxl_core-y += cdat.o
+cxl_core-y += features.o
 cxl_core-$(CONFIG_TRACING) += trace.o
 cxl_core-$(CONFIG_CXL_REGION) += region.o
diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
new file mode 100644
index 000000000000..b01dc5ebb24d
--- /dev/null
+++ b/drivers/cxl/core/features.c
@@ -0,0 +1,59 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <cxl/mailbox.h>
+#include <cxl/features.h>
+#include "cxl.h"
+#include "core.h"
+#include "cxlmem.h"
+#include "features.h"
+
+size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code)
+{
+	size_t data_to_rd_size, size_out;
+	struct cxl_mbox_get_feat_in pi;
+	struct cxl_mbox_cmd mbox_cmd;
+	size_t data_rcvd_size = 0;
+	int rc;
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_INPUT;
+
+	if (!feat_out || !feat_out_size)
+		return 0;
+
+	size_out = min(feat_out_size, cxl_mbox->payload_size);
+	uuid_copy(&pi.uuid, feat_uuid);
+	pi.selection = selection;
+	do {
+		data_to_rd_size = min(feat_out_size - data_rcvd_size,
+				      cxl_mbox->payload_size);
+		pi.offset = cpu_to_le16(offset + data_rcvd_size);
+		pi.count = cpu_to_le16(data_to_rd_size);
+
+		mbox_cmd = (struct cxl_mbox_cmd) {
+			.opcode = CXL_MBOX_OP_GET_FEATURE,
+			.size_in = sizeof(pi),
+			.payload_in = &pi,
+			.size_out = size_out,
+			.payload_out = feat_out + data_rcvd_size,
+			.min_out = data_to_rd_size,
+		};
+		rc = cxl_internal_send_cmd(cxl_mbox, &mbox_cmd);
+		if (rc < 0 || !mbox_cmd.size_out) {
+			if (return_code)
+				*return_code = mbox_cmd.return_code;
+			return 0;
+		}
+		data_rcvd_size += mbox_cmd.size_out;
+	} while (data_rcvd_size < feat_out_size);
+
+	if (return_code)
+		*return_code = CXL_MBOX_CMD_RC_SUCCESS;
+
+	return data_rcvd_size;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature, "CXL");
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 56dc3b78c725..b80164fa18ef 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -89,4 +89,33 @@ struct cxl_mbox_get_sup_feats_out {
 	struct cxl_feat_entry ents[] __counted_by_le(num_entries);
 } __packed;
 
+/*
+ * Get Feature CXL spec r3.2 Spec 8.2.9.6.2
+ */
+
+/*
+ * Get Feature input payload
+ * CXL spec r3.2 section 8.2.9.6.2 Table 8-99
+ */
+struct cxl_mbox_get_feat_in {
+	uuid_t uuid;
+	__le16 offset;
+	__le16 count;
+	u8 selection;
+}  __packed;
+
+/* Selection field for 'struct cxl_mbox_get_feat_in' */
+enum cxl_get_feat_selection {
+	CXL_GET_FEAT_SEL_CURRENT_VALUE,
+	CXL_GET_FEAT_SEL_DEFAULT_VALUE,
+	CXL_GET_FEAT_SEL_SAVED_VALUE,
+	CXL_GET_FEAT_SEL_MAX
+};
+
+struct cxl_mailbox;
+size_t cxl_get_feature(struct cxl_mailbox *cxl_mbox, const uuid_t *feat_uuid,
+		       enum cxl_get_feat_selection selection,
+		       void *feat_out, size_t feat_out_size, u16 offset,
+		       u16 *return_code);
+
 #endif
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 47be82a2dd5b..6b0a992af4a7 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -61,6 +61,7 @@ cxl_core-y += $(CXL_CORE_SRC)/pci.o
 cxl_core-y += $(CXL_CORE_SRC)/hdm.o
 cxl_core-y += $(CXL_CORE_SRC)/pmu.o
 cxl_core-y += $(CXL_CORE_SRC)/cdat.o
+cxl_core-y += $(CXL_CORE_SRC)/features.o
 cxl_core-$(CONFIG_TRACING) += $(CXL_CORE_SRC)/trace.o
 cxl_core-$(CONFIG_CXL_REGION) += $(CXL_CORE_SRC)/region.o
 cxl_core-y += config_check.o
-- 
2.48.1

