Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBC5234
	for <linux-cxl@vger.kernel.org>; Sat,  1 Feb 2025 00:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738370715; cv=none; b=CMMwfW6ggGz+bAqZDbOTbXJqfP5Qc8eEuk1nEwvqimj1vfn/CP3cSb47WFl1rDPc4nXY2qacwlHmFtUS2MCrUkwdtqFTDfUUEN1x5ut21XkIro9nKWEWIUJmZkst86dbZhNXO2ZMJlR6r4A43HVZwng69phWDunHzG5thllD+do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738370715; c=relaxed/simple;
	bh=N1PAJsj2/ToHEWu0jWOcMNFDe3bZz0yvdkTHBhyUtIk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EqgZjVOD2gh9cFUr1VVaHV11eXNucKywQZMCukcjn6SGz1n8eWp8eJvJMnCrlFYKUyE+sPIm3zjkZyGt53T6gyJCubYidPDVME7dtQU6u1cKvOmDbHPrX9zAGBzqTJep6/k1opRwcRDCxfFcGhrXbw02OFG1JLn2dwhemmEKtdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB073C4CED1;
	Sat,  1 Feb 2025 00:45:14 +0000 (UTC)
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
Subject: [PATCH v2 09/16] cxl: Add support for FWCTL get driver information callback
Date: Fri, 31 Jan 2025 17:42:02 -0700
Message-ID: <20250201004459.466499-10-dave.jiang@intel.com>
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

Add definition for fwctl_ops->info() to return driver information. The
function will return a data structure with a reserved u32. This is setup
for future usages.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Set command_info to reserved. (Dan)
---
 drivers/cxl/fwctl.c      | 18 ++++++++++++++++--
 include/cxl/mailbox.h    |  1 +
 include/uapi/fwctl/cxl.h | 19 +++++++++++++++++++
 3 files changed, 36 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/cxl/fwctl.c b/drivers/cxl/fwctl.c
index d8fd68ac8982..b7984c98645c 100644
--- a/drivers/cxl/fwctl.c
+++ b/drivers/cxl/fwctl.c
@@ -6,6 +6,8 @@
 #include "cxlmem.h"
 #include "features.h"
 
+#define to_cxl_features_state(fwctl) container_of(fwctl, struct cxl_features_state, fwctl)
+
 static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
 {
 	return 0;
@@ -17,8 +19,20 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 
 static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct fwctl_device *fwctl = uctx->fwctl;
+	struct cxl_features_state *cxlfs = to_cxl_features_state(fwctl);
+	struct fwctl_info_cxl *info;
+
+	if (!cxlfs->num_user_features)
+		return ERR_PTR(-EOPNOTSUPP);
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	*length = sizeof(*info);
+
+	return info;
 }
 
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 99d3bbe1ba2a..bbbbff3af61f 100644
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
index 000000000000..4e766ffb1388
--- /dev/null
+++ b/include/uapi/fwctl/cxl.h
@@ -0,0 +1,19 @@
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
+/**
+ * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
+ * @reserved: Place older for future usages
+ */
+struct fwctl_info_cxl {
+	__u32 reserved;
+};
+#endif
-- 
2.48.1

