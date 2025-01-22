Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00E61CAA94
	for <linux-cxl@vger.kernel.org>; Wed, 22 Jan 2025 23:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737589938; cv=none; b=RFwnkWwMKL9GKgytExLXEJSHWd0Ja7LpgJ75gK/tELh0HU7Di+Jc9ftDl0gCJxk6qgJGivrn+ayK4gisO3npw1sZd3Pu7iqr+pI1yX7MV/sTO9WqujhO+2kNl66QQmZzdJZu6Wi3+0WyaiwNyNHNwRfxxQSCFeXt8l6O5vc5YCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737589938; c=relaxed/simple;
	bh=gguz5muXhSjTF6W7I8s/W/qMAdRTwcOeqz1w57KAmn8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EEuygAW41my7YwNiWfLlBTD5zDsBZZbrXezKiuZUhNZQs9qhRGJ037x2HpXa9bPuX52Vo10I6NWsZT+MaxXdI+nxIjlwx1rPygNi8+AAN6r/SklamUGUfFpMTg4CEm1sAZPz29ZM8y29/lKtyIBl0fJwlDNJ80aFbi1JvFcd+TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48DDCC4CED2;
	Wed, 22 Jan 2025 23:52:17 +0000 (UTC)
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
Subject: [PATCH v1 11/19] cxl: Add support for get driver information
Date: Wed, 22 Jan 2025 16:50:42 -0700
Message-ID: <20250122235159.2716036-12-dave.jiang@intel.com>
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

Add definition for fwctl_ops->info() to return driver information. The
function will return a mask of the feature mailbox commands supported
by the fwctl char device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v1:
- Add missed setting of *length for ->info().
- Use BIT() instead of enum directly.
---
 drivers/cxl/features.c   | 30 ++++++++++++++++++++++++++++--
 include/cxl/features.h   |  7 -------
 include/cxl/mailbox.h    |  1 +
 include/uapi/fwctl/cxl.h | 31 +++++++++++++++++++++++++++++++
 4 files changed, 60 insertions(+), 9 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/cxl/features.c b/drivers/cxl/features.c
index 5a2b771586d3..cc72e73ae8d6 100644
--- a/drivers/cxl/features.c
+++ b/drivers/cxl/features.c
@@ -9,6 +9,8 @@
 #include "cxl.h"
 #include "cxlmem.h"
 
+#define to_cxl_features_state(fwctl) container_of(fwctl, struct cxl_features_state, fwctl)
+
 static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
 {
 	return 0;
@@ -18,10 +20,34 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 {
 }
 
+static void set_command_mask(struct cxl_features_state *cfs, u32 *mask)
+{
+	struct cxl_mailbox *cxl_mbox = cfs->features->cxl_mbox;
+
+	*mask = 0;
+	if (test_bit(CXL_FEATURE_ID_GET_SUPPORTED_FEATURES,
+		     cxl_mbox->feature_cmds))
+		*mask |= BIT(CXL_FEATURE_ID_GET_SUPPORTED_FEATURES);
+	if (test_bit(CXL_FEATURE_ID_GET_FEATURE, cxl_mbox->feature_cmds))
+		*mask |= BIT(CXL_FEATURE_ID_GET_FEATURE);
+	if (test_bit(CXL_FEATURE_ID_SET_FEATURE, cxl_mbox->feature_cmds))
+		*mask |= BIT(CXL_FEATURE_ID_SET_FEATURE);
+}
+
 static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct fwctl_device *fwctl = uctx->fwctl;
+	struct cxl_features_state *cfs = to_cxl_features_state(fwctl);
+	struct fwctl_info_cxl *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	set_command_mask(cfs, &info->cmd_mask);
+	*length = sizeof(*info);
+
+	return info;
 }
 
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
diff --git a/include/cxl/features.h b/include/cxl/features.h
index 69697c069e63..e38ee777328d 100644
--- a/include/cxl/features.h
+++ b/include/cxl/features.h
@@ -40,13 +40,6 @@
 
 struct cxl_mailbox;
 
-enum feature_cmds {
-	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
-	CXL_FEATURE_ID_GET_FEATURE,
-	CXL_FEATURE_ID_SET_FEATURE,
-	CXL_FEATURE_ID_MAX,
-};
-
 struct cxl_features {
 	int id;
 	struct device dev;
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 263fc346aeb1..1157b19175a5 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -4,6 +4,7 @@
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
 #include <cxl/features.h>
+#include <uapi/fwctl/cxl.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
new file mode 100644
index 000000000000..79b822dbfafd
--- /dev/null
+++ b/include/uapi/fwctl/cxl.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, Intel Corporation
+ *
+ * These are definitions for the mailbox command interface of CXL subsystem.
+ */
+#ifndef _UAPI_FWCTL_CXL_H_
+#define _UAPI_FWCTL_CXL_H_
+
+#include <linux/types.h>
+
+enum feature_cmds {
+	CXL_FEATURE_ID_GET_SUPPORTED_FEATURES = 0,
+	CXL_FEATURE_ID_GET_FEATURE,
+	CXL_FEATURE_ID_SET_FEATURE,
+	CXL_FEATURE_ID_MAX,
+};
+
+/**
+ * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
+ * @cmd_mask: Mask indicate which commands are supported based on 'enum feature_cmds'
+ *
+ * Return basic information about the FW interface available.
+ *
+ * nr_commands is number of hardware commands the driver supports. Use
+ * FWCTL_CMD_HW_INFO ioctl to request additional information.
+ */
+struct fwctl_info_cxl {
+	__u32 cmd_mask;
+};
+#endif
-- 
2.47.1

