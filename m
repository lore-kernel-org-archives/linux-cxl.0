Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1524025A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706679; cv=none; b=AfpU/tjOd8ulvvBAOpgfswx6IEHge2QGuk9GbJyWmIzc9ZiVYWTVfAeYpvMGrL8k7iTYGqWnc4PDD4pqyRf2S7G3agRH2w7DnugOkWuDPaIWvAbQzjFi7EDgGxUQJ32xtya5XWQU0cFd5lUBFKY2sYhEDLnm1dI5GVzDe3vu/KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706679; c=relaxed/simple;
	bh=uCd5MZK6mF0CELpfKUVpzsyEO9l02BbSwHkgcKaTQuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tmv7YTybFGGVfPofc7348LobGsc48M5RUTaHrZdqe3jvnLa5x/w7+BSBYfL7/cM0qW2q5VOfsQKb4NJ6bVdKVaKytPmodIZhrdMRnq+ZdnFJJGV3zWx5RShFrcDF+x6SteRxcOsJZ0C+qoHdmv/ndFM9yMN+cGlVNwOUo/wYkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 586B9C4CEDF;
	Tue,  4 Feb 2025 22:04:38 +0000 (UTC)
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
Subject: [PATCH v3 02/16] cxl: Enumerate feature commands
Date: Tue,  4 Feb 2025 15:03:03 -0700
Message-ID: <20250204220430.4146187-3-dave.jiang@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250204220430.4146187-1-dave.jiang@intel.com>
References: <20250204220430.4146187-1-dave.jiang@intel.com>
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

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Add comma to enum entries that are not end entry. (Jonathan)
- Pull devm_cxfs_allocate() forward from patch 8. (Jonathan)
- Return NULL for failure path of allocate function. (Jonathan)
---
 drivers/cxl/Makefile     |  2 +-
 drivers/cxl/core/mbox.c  | 30 +++++++++++++
 drivers/cxl/cxl.h        |  2 +
 drivers/cxl/cxlmem.h     |  5 +++
 drivers/cxl/features.c   | 91 ++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/features.h   |  8 ++++
 drivers/cxl/mem.c        |  5 +++
 include/cxl/features.h   | 35 ++++++++++++++++
 include/cxl/mailbox.h    |  2 +
 tools/testing/cxl/Kbuild |  2 +-
 10 files changed, 180 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/features.c
 create mode 100644 drivers/cxl/features.h
 create mode 100644 include/cxl/features.h

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 2caa90fa4bf2..12fbc35081bb 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -17,5 +17,5 @@ obj-$(CONFIG_CXL_PCI) += cxl_pci.o
 cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
-cxl_mem-y := mem.o
+cxl_mem-y := mem.o features.o
 cxl_pci-y := pci.o
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bdb8f060f2c1..9fe552e3d465 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -69,6 +69,29 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_TIMESTAMP, 0, 0x8, 0),
 };
 
+static u16 cxl_feature_commands[] = {
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+	CXL_MBOX_OP_GET_FEATURE,
+	CXL_MBOX_OP_SET_FEATURE,
+};
+
+/**
+ * cxl_get_feature_command_id() - Get the index id for a feature command
+ * @opcode: The device opcode for the feature command
+ *
+ * Return the index id on success or -errno on failure
+ */
+int cxl_get_feature_command_id(u16 opcode)
+{
+	for (int i = 0; i < ARRAY_SIZE(cxl_feature_commands); i++) {
+		if (cxl_feature_commands[i] == opcode)
+			return i;
+	}
+
+	return -ENOENT;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_get_feature_command_id, "CXL");
+
 /*
  * Commands that RAW doesn't permit. The rationale for each:
  *
@@ -734,6 +757,13 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		if (cmd) {
 			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
 			enabled++;
+		} else {
+			int fid = cxl_get_feature_command_id(opcode);
+
+			if (fid >= 0) {
+				set_bit(fid, cxl_mbox->feature_cmds);
+				enabled++;
+			}
 		}
 
 		if (cxl_is_poison_command(opcode)) {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f6015f24ad38..2d6f7c87e5e8 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -911,6 +911,8 @@ void cxl_coordinates_combine(struct access_coordinate *out,
 
 bool cxl_endpoint_decoder_reset_detected(struct cxl_port *port);
 
+int cxl_get_feature_command_id(u16 opcode);
+
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
  * of these symbols in tools/testing/cxl/.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index a0a49809cd76..4a42cdb64b5c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -39,6 +39,7 @@
  * @dev: driver core device object
  * @cdev: char dev core object for ioctl operations
  * @cxlds: The device state backing this device
+ * @cxlfs: The features state for the device
  * @detach_work: active memdev lost a port in its ancestry
  * @cxl_nvb: coordinate removal of @cxl_nvd if present
  * @cxl_nvd: optional bridge to an nvdimm if the device supports pmem
@@ -50,6 +51,7 @@ struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_dev_state *cxlds;
+	struct cxl_features_state *cxlfs;
 	struct work_struct detach_work;
 	struct cxl_nvdimm_bridge *cxl_nvb;
 	struct cxl_nvdimm *cxl_nvd;
@@ -490,6 +492,9 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_LOG_CAPS	= 0x0402,
 	CXL_MBOX_OP_CLEAR_LOG           = 0x0403,
 	CXL_MBOX_OP_GET_SUP_LOG_SUBLIST = 0x0405,
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES	= 0x0500,
+	CXL_MBOX_OP_GET_FEATURE		= 0x0501,
+	CXL_MBOX_OP_SET_FEATURE		= 0x0502,
 	CXL_MBOX_OP_IDENTIFY		= 0x4000,
 	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
 	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
new file mode 100644
index 000000000000..958e4828a58d
--- /dev/null
+++ b/drivers/cxl/features.c
@@ -0,0 +1,91 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/device.h>
+#include <cxl/mailbox.h>
+#include <cxl/features.h>
+#include "cxl.h"
+#include "cxlmem.h"
+#include "features.h"
+
+static void enumerate_feature_cmds(struct cxl_memdev *cxlmd,
+				   struct cxl_features_state *cxlfs)
+{
+	struct cxl_mailbox *cxl_mbox = &cxlmd->cxlds->cxl_mbox;
+	int fid;
+
+	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_SUPPORTED_FEATURES);
+	if (!test_bit(fid, cxl_mbox->feature_cmds))
+		return;
+
+	fid = cxl_get_feature_command_id(CXL_MBOX_OP_GET_FEATURE);
+	if (!test_bit(fid, cxl_mbox->feature_cmds))
+		return;
+
+	cxlfs->cap = CXL_FEATURES_RO;
+
+	fid = cxl_get_feature_command_id(CXL_MBOX_OP_SET_FEATURE);
+	if (!test_bit(fid, cxl_mbox->feature_cmds))
+		return;
+
+	cxlfs->cap = CXL_FEATURES_RW;
+}
+
+static void cxlfs_free(void *_cxlfs)
+{
+	kfree(_cxlfs);
+}
+DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxlfs_free(_T))
+
+static struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
+{
+	int rc;
+
+	struct cxl_features_state *cxlfs __free(free_cxlfs) =
+		kzalloc(sizeof(*cxlfs), GFP_KERNEL);
+	if (!cxlfs)
+		return NULL;
+
+	cxlfs->cxlmd = cxlmd;
+
+	rc = devm_add_action_or_reset(&cxlmd->dev, cxlfs_free, cxlfs);
+	if (rc)
+		return NULL;
+
+	return no_free_ptr(cxlfs);
+}
+
+static void devm_cxlfs_free(struct cxl_memdev *cxlmd)
+{
+	kfree(cxlmd->cxlfs);
+	/* Set in devm_cxl_add_features(), make sure it's cleared */
+	cxlmd->cxlfs = NULL;
+}
+
+static void cxl_cxlfs_free(void *_cxlfs)
+{
+	struct cxl_features_state *cxlfs = _cxlfs;
+
+	devm_cxlfs_free(cxlfs->cxlmd);
+}
+DEFINE_FREE(cxl_free_cxlfs, struct cxl_features_state *, if (_T) cxl_cxlfs_free(_T))
+
+/**
+ * devm_cxl_add_features() - Allocate and initialize features context
+ * @cxlmd: CXL memory device
+ *
+ * Return 0 on success or -errno on failure.
+ */
+int devm_cxl_add_features(struct cxl_memdev *cxlmd)
+{
+	struct cxl_features_state *cxlfs __free(cxl_free_cxlfs) =
+		devm_cxlfs_allocate(cxlmd);
+	if (!cxlfs)
+		return -ENOMEM;
+
+	enumerate_feature_cmds(cxlmd, cxlfs);
+
+	cxlmd->cxlfs = no_free_ptr(cxlfs);
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
new file mode 100644
index 000000000000..0cc6d9e6c441
--- /dev/null
+++ b/drivers/cxl/features.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2025 Intel Corporation. */
+#ifndef __CXL_FEATURES_LOCAL__
+#define __CXL_FEATURES_LOCAL__
+
+int devm_cxl_add_features(struct cxl_memdev *cxlmd);
+
+#endif
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 2f03a4d5606e..47348a52bc05 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -7,6 +7,7 @@
 
 #include "cxlmem.h"
 #include "cxlpci.h"
+#include "features.h"
 
 /**
  * DOC: cxl mem
@@ -180,6 +181,10 @@ static int cxl_mem_probe(struct device *dev)
 			return rc;
 	}
 
+	rc = devm_cxl_add_features(cxlmd);
+	if (rc)
+		dev_dbg(dev, "No CXL Features enumerated.\n");
+
 	/*
 	 * The kernel may be operating out of CXL memory on this device,
 	 * there is no spec defined way to determine whether this device
diff --git a/include/cxl/features.h b/include/cxl/features.h
new file mode 100644
index 000000000000..8e1830f0ccba
--- /dev/null
+++ b/include/cxl/features.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2024-2025 Intel Corporation. */
+#ifndef __CXL_FEATURES_H__
+#define __CXL_FEATURES_H__
+
+struct cxl_mailbox;
+
+/* Index IDs for CXL mailbox Feature commands */
+enum feature_cmds {
+	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
+	CXL_FEATURE_ID_GET_FEATURE,
+	CXL_FEATURE_ID_SET_FEATURE,
+	CXL_FEATURE_ID_MAX
+};
+
+/* Feature commands capability supported by a device */
+enum cxl_features_capability {
+	CXL_FEATURES_NONE = 0,
+	CXL_FEATURES_RO,
+	CXL_FEATURES_RW,
+};
+
+/**
+ * struct cxl_features_state - The Features state for the device
+ * @cxlmd: Pointer to cxl mem device
+ * @cap: Feature commands capability
+ * @num_features: total Features supported by the device
+ */
+struct cxl_features_state {
+	struct cxl_memdev *cxlmd;
+	enum cxl_features_capability cap;
+	int num_features;
+};
+
+#endif
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index cc894f07a435..99d3bbe1ba2a 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
+#include <cxl/features.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
@@ -56,6 +57,7 @@ struct cxl_mailbox {
 	struct device *host;
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(feature_cmds, CXL_FEATURE_ID_MAX);
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index b1256fee3567..47be82a2dd5b 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -46,7 +46,7 @@ cxl_port-y += cxl_port_test.o
 
 obj-m += cxl_mem.o
 
-cxl_mem-y := $(CXL_SRC)/mem.o
+cxl_mem-y := $(CXL_SRC)/mem.o $(CXL_SRC)/features.o
 cxl_mem-y += config_check.o
 cxl_mem-y += cxl_mem_test.o
 
-- 
2.48.1

