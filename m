Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B759B1DA0E0
	for <linux-cxl@vger.kernel.org>; Tue, 18 Feb 2025 22:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739919456; cv=none; b=pJ2O6NSxxBqUouygKIpvtBzjBo6Mvr2K4zAeXGrAE4VSram1py9fHmwk1dsk79azul4j7L5Ej0TIBem+sClMt+b+Jz/ZfBeNIS7w0/ICDq/ZdpqIlcWF34WFb//XD01gLlgPvNljQjr56QfVJUOoIZ91U/ioGhCdVnJ6kp2idQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739919456; c=relaxed/simple;
	bh=PAw8ia+l/mYFRkZJ5e1rDgYuefQPaZwsVFipxUZjeTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiFBhoCJOTkjs5f1SuwMu/QNCOw1O1J5BRYX0OwPpug+oO0YECk/LjcUm3wGNZdTdJCSNwg5VmKqLVJph/nKBNp+i3QfzIP3Gq1ziKZ6MVRCYTkhjvm0SVDanEMoWGLmKERiV74GyvGYG4PX1xEnN8T+X9JGzKlTVBywI3+RrQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C19AC4CEE2;
	Tue, 18 Feb 2025 22:57:36 +0000 (UTC)
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
Subject: [PATCH v6 01/14] cxl: Enumerate feature commands
Date: Tue, 18 Feb 2025 15:54:30 -0700
Message-ID: <20250218225721.2682235-2-dave.jiang@intel.com>
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

Add feature commands enumeration code in order to detect and enumerate
the 3 feature related commands "get supported features", "get feature",
and "set feature". The enumeration will help determine whether the driver
can issue any of the 3 commands to the device.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/mbox.c | 36 +++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxlmem.h    |  3 +++
 include/cxl/features.h  | 13 +++++++++++++
 include/cxl/mailbox.h   |  3 +++
 4 files changed, 54 insertions(+), 1 deletion(-)
 create mode 100644 include/cxl/features.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 9c1b9e353e3e..78c5346e3e89 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -706,6 +706,35 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 	return 0;
 }
 
+static int check_features_opcodes(u16 opcode, int *ro_cmds, int *wr_cmds)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_GET_SUPPORTED_FEATURES:
+	case CXL_MBOX_OP_GET_FEATURE:
+		(*ro_cmds)++;
+		return 1;
+	case CXL_MBOX_OP_SET_FEATURE:
+		(*wr_cmds)++;
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+/* 'Get Supported Features' and 'Get Feature' */
+#define MAX_FEATURES_READ_CMDS	2
+static void set_features_cap(struct cxl_mailbox *cxl_mbox,
+			     int ro_cmds, int wr_cmds)
+{
+	/* Setting up Features capability while walking the CEL */
+	if (ro_cmds == MAX_FEATURES_READ_CMDS) {
+		if (wr_cmds)
+			cxl_mbox->feat_cap = CXL_FEATURES_RW;
+		else
+			cxl_mbox->feat_cap = CXL_FEATURES_RO;
+	}
+}
+
 /**
  * cxl_walk_cel() - Walk through the Command Effects Log.
  * @mds: The driver data for the operation
@@ -721,7 +750,7 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
 	struct device *dev = mds->cxlds.dev;
-	int i;
+	int i, ro_cmds = 0, wr_cmds = 0;
 
 	cel_entry = (struct cxl_cel_entry *) cel;
 
@@ -735,6 +764,9 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 			enabled++;
 		}
 
+		enabled += check_features_opcodes(opcode, &ro_cmds,
+						  &wr_cmds);
+
 		if (cxl_is_poison_command(opcode)) {
 			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
 			enabled++;
@@ -748,6 +780,8 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		dev_dbg(dev, "Opcode 0x%04x %s\n", opcode,
 			enabled ? "enabled" : "unsupported by driver");
 	}
+
+	set_features_cap(cxl_mbox, ro_cmds, wr_cmds);
 }
 
 static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0a49809cd76..55c55685cb39 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -490,6 +490,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/include/cxl/features.h b/include/cxl/features.h
new file mode 100644
index 000000000000..357d3acf8429
--- /dev/null
+++ b/include/cxl/features.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024-2025 Intel Corporation. */
+#ifndef __CXL_FEATURES_H__
+#define __CXL_FEATURES_H__
+
+/* Feature commands capability supported by a device */
+enum cxl_features_capability {
+	CXL_FEATURES_NONE = 0,
+	CXL_FEATURES_RO,
+	CXL_FEATURES_RW,
+};
+
+#endif
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index cc894f07a435..c4e99e2e3a9d 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
+#include <cxl/features.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
@@ -51,6 +52,7 @@ struct cxl_mbox_cmd {
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @feat_cap: Features capability
  */
 struct cxl_mailbox {
 	struct device *host;
@@ -60,6 +62,7 @@ struct cxl_mailbox {
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
+	enum cxl_features_capability feat_cap;
 };
 
 int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
-- 
2.48.1

