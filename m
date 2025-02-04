Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FFA25A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706690; cv=none; b=qjKBzgn2yOPzrH50j6NIMAzWd3ZsP4U0/oL2Yd0MfoULSCyNQv6IPfdhMMZzNzPAirj4HDFwiKxP2zRqBJNR9QK5dcxYrB4j2P9WlJCqsriOX9RrT0wx28lIqSJ67tT6MSW40FytDs8dlcKC8MV5fJvriNh7TPwlD8Ynv1NPNmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706690; c=relaxed/simple;
	bh=i9zckXiawJdK7UCsszm7YOLbjagjZfXgkO1egOW9J2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JCyVjFi4D0iudKpXcHEJorG+qoDFdhnC6MjLmlA5CdZSR29TamoM44mb3JmAwjq1Ne9N4s76lCZ2mENTExPNS4s3aTr2bbB0xDBI3yt+KlRD9Ba9ZYznAy321KEjLn5PkD8vPmIABjdL2bgjPrHkOezjcuidERBl5ksmlkkxWN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845AAC4CEE3;
	Tue,  4 Feb 2025 22:04:49 +0000 (UTC)
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
Subject: [PATCH v3 08/16] cxl: Add FWCTL support to the CXL memdev driver
Date: Tue,  4 Feb 2025 15:03:09 -0700
Message-ID: <20250204220430.4146187-9-dave.jiang@intel.com>
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

Add fwctl support code to allow sending of CXL feature commands from
userspace through as ioctls via FWCTL. Provide initial setup bits.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v3:
- Fix spelling error in Kconfig text
- Remove errant blank line
- Drop using of __weak. (Jason)
- Return NULL for allocate function. (Jonathan)
---
 drivers/cxl/Kconfig        | 15 +++++++
 drivers/cxl/Makefile       |  1 +
 drivers/cxl/features.c     |  8 +++-
 drivers/cxl/features.h     | 29 +++++++++++++
 drivers/cxl/fwctl.c        | 89 ++++++++++++++++++++++++++++++++++++++
 include/cxl/features.h     |  3 ++
 include/uapi/fwctl/fwctl.h |  1 +
 tools/testing/cxl/Kbuild   |  1 +
 8 files changed, 145 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cxl/fwctl.c

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 876469e23f7a..6bb1ffc74956 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -102,6 +102,21 @@ config CXL_MEM
 
 	  If unsure say 'm'.
 
+config CXL_FWCTL
+	bool "CXL: Firmware Control support"
+	depends on CXL_MEM
+	select FWCTL
+	help
+	  Enable support for firmware control of CXL devices. This allows
+	  a FWCTL char device to be created in order to issue ioctls from
+	  user space to exercise the CXL Features commands supported by
+	  a CXL mailbox. There are some Features defined in the CXL spec
+	  such as memory sparing. However a lot of those features are
+	  exclusive to the kernel. Most likely the Features manipulated
+	  by CXL_FWCTL will be vendor defined Features.
+
+	  If unsure say 'n'.
+
 config CXL_PORT
 	default CXL_BUS
 	tristate
diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 12fbc35081bb..cd28fb3bf855 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -18,4 +18,5 @@ cxl_port-y := port.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o security.o
 cxl_mem-y := mem.o features.o
+cxl_mem-$(CONFIG_CXL_FWCTL) += fwctl.o
 cxl_pci-y := pci.o
diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 0086fdb20bfd..c14dc6d45985 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -1,6 +1,8 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2024-2025 Intel Corporation. All rights reserved. */
+#include <linux/pci.h>
 #include <linux/device.h>
+#include <linux/module.h>
 #include <cxl/mailbox.h>
 #include <cxl/features.h>
 #include "cxl.h"
@@ -173,7 +175,7 @@ static void cxlfs_free(void *_cxlfs)
 }
 DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) cxlfs_free(_T))
 
-static struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
+struct cxl_features_state *_devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
 {
 	int rc;
 
@@ -191,7 +193,7 @@ static struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
 	return no_free_ptr(cxlfs);
 }
 
-static void devm_cxlfs_free(struct cxl_memdev *cxlmd)
+void _devm_cxlfs_free(struct cxl_memdev *cxlmd)
 {
 	kfree(cxlmd->cxlfs);
 	/* Set in devm_cxl_add_features(), make sure it's cleared */
@@ -231,3 +233,5 @@ int devm_cxl_add_features(struct cxl_memdev *cxlmd)
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_features, "CXL");
+
+MODULE_IMPORT_NS("CXL");
diff --git a/drivers/cxl/features.h b/drivers/cxl/features.h
index 8706f944b476..a51625774b58 100644
--- a/drivers/cxl/features.h
+++ b/drivers/cxl/features.h
@@ -3,8 +3,37 @@
 #ifndef __CXL_FEATURES_LOCAL__
 #define __CXL_FEATURES_LOCAL__
 
+struct cxl_features_state *_devm_cxlfs_allocate(struct cxl_memdev *cxlmd);
+void _devm_cxlfs_free(struct cxl_memdev *cxlmd);
+
+#ifdef CONFIG_CXL_FWCTL
+struct cxl_features_state *_devm_cxlfs_fwctl_allocate(struct cxl_memdev *cxlmd);
+void _devm_cxlfs_fwctl_free(struct cxl_memdev *cxlmd);
+#endif
+
+static inline struct cxl_features_state *
+devm_cxlfs_allocate(struct cxl_memdev *cxlmd)
+{
+#ifdef CONFIG_CXL_FWCTL
+	return _devm_cxlfs_fwctl_allocate(cxlmd);
+#else
+	return _devm_cxlfs_allocate(cxlmd);
+#endif
+}
+
+static inline void devm_cxlfs_free(struct cxl_memdev *cxlmd)
+{
+#ifdef CONFIG_CXL_FWCTL
+	_devm_cxlfs_fwctl_free(cxlmd);
+#else
+	_devm_cxlfs_free(cxlmd);
+#endif
+}
+
 struct cxl_feat_entry;
 
+struct cxl_features_state *devm_cxlfs_allocate(struct cxl_memdev *cxlmd);
+void devm_cxlfs_free(struct cxl_memdev *cxlmd);
 int devm_cxl_add_features(struct cxl_memdev *cxlmd);
 bool is_cxl_feature_exclusive(struct cxl_feat_entry *entry);
 
diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
new file mode 100644
index 000000000000..985315d5d503
--- /dev/null
+++ b/drivers/cxl/fwctl.c
@@ -0,0 +1,89 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2025 Intel Corporation. All rights reserved. */
+#include <linux/fwctl.h>
+#include <linux/device.h>
+#include <cxl/features.h>
+#include "cxlmem.h"
+#include "features.h"
+
+static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
+{
+	return 0;
+}
+
+static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
+{
+}
+
+static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
+{
+	/* Place holder */
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
+			   void *in, size_t in_len, size_t *out_len)
+{
+	/* Place holder */
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static const struct fwctl_ops cxlctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_CXL,
+	.uctx_size = sizeof(struct fwctl_uctx),
+	.open_uctx = cxlctl_open_uctx,
+	.close_uctx = cxlctl_close_uctx,
+	.info = cxlctl_info,
+	.fw_rpc = cxlctl_fw_rpc,
+};
+
+static void remove_cxlfs(void *_cxlfs)
+{
+	struct cxl_features_state *cxlfs = _cxlfs;
+	struct cxl_memdev *cxlmd = cxlfs->cxlmd;
+	struct fwctl_device *fwctl = &cxlfs->fwctl;
+
+	/* Set in devm_cxl_add_features(), make sure it's cleared */
+	cxlmd->cxlfs = NULL;
+	fwctl_unregister(fwctl);
+	fwctl_put(fwctl);
+}
+
+DEFINE_FREE(free_cxlfs, struct cxl_features_state *, if (_T) fwctl_put(&_T->fwctl))
+
+static struct cxl_features_state *
+__devm_cxlfs_fwctl_allocate(struct cxl_memdev *cxlmd, const struct fwctl_ops *ops)
+{
+	struct device *dev = &cxlmd->dev;
+	int rc;
+
+	struct cxl_features_state *cxlfs __free(free_cxlfs) =
+		fwctl_alloc_device(dev, ops, struct cxl_features_state, fwctl);
+	if (!cxlfs)
+		return NULL;
+
+	cxlfs->cxlmd = cxlmd;
+	rc = fwctl_register(&cxlfs->fwctl);
+	if (rc)
+		return NULL;
+
+	rc = devm_add_action_or_reset(dev, remove_cxlfs, cxlfs);
+	if (rc)
+		return NULL;
+
+	return no_free_ptr(cxlfs);
+}
+
+struct cxl_features_state *_devm_cxlfs_fwctl_allocate(struct cxl_memdev *cxlmd)
+{
+	return __devm_cxlfs_fwctl_allocate(cxlmd, &cxlctl_ops);
+}
+EXPORT_SYMBOL_NS_GPL(_devm_cxlfs_fwctl_allocate, "CXL");
+
+void _devm_cxlfs_fwctl_free(struct cxl_memdev *cxlmd)
+{
+	devm_release_action(&cxlmd->dev, remove_cxlfs, cxlmd);
+}
+EXPORT_SYMBOL_NS_GPL(_devm_cxlfs_fwctl_free, "CXL");
+
+MODULE_IMPORT_NS("FWCTL");
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 869a18559f2b..b11b964e6384 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -4,6 +4,7 @@
 #define __CXL_FEATURES_H__
 
 #include <linux/uuid.h>
+#include <linux/fwctl.h>
 
 /* Feature UUIDs used by the kernel */
 #define CXL_FEAT_PATROL_SCRUB_UUID						\
@@ -57,6 +58,7 @@ enum cxl_features_capability {
 
 /**
  * struct cxl_features_state - The Features state for the device
+ * @fwctl: FWCTL device
  * @cxlmd: Pointer to cxl mem device
  * @cap: Feature commands capability
  * @num_features: total Features supported by the device
@@ -64,6 +66,7 @@ enum cxl_features_capability {
  * @entries: Feature detail entries fetched from the device
  */
 struct cxl_features_state {
+	struct fwctl_device fwctl;
 	struct cxl_memdev *cxlmd;
 	enum cxl_features_capability cap;
 	int num_features;
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index f9b27fb5c161..4e4d30104667 100644
--- a/include/uapi/fwctl/fwctl.h
+++ b/include/uapi/fwctl/fwctl.h
@@ -43,6 +43,7 @@ enum {
 enum fwctl_device_type {
 	FWCTL_DEVICE_TYPE_ERROR = 0,
 	FWCTL_DEVICE_TYPE_MLX5 = 1,
+	FWCTL_DEVICE_TYPE_CXL = 2,
 };
 
 /**
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 6b0a992af4a7..6396d1296cef 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -47,6 +47,7 @@ cxl_port-y += cxl_port_test.o
 obj-m += cxl_mem.o
 
 cxl_mem-y := $(CXL_SRC)/mem.o $(CXL_SRC)/features.o
+cxl_mem-$(CONFIG_CXL_FWCTL) += $(CXL_SRC)/fwctl.o
 cxl_mem-y += config_check.o
 cxl_mem-y += cxl_mem_test.o
 
-- 
2.48.1

