Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32361E3DFD
	for <linux-cxl@vger.kernel.org>; Tue, 11 Feb 2025 18:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739298564; cv=none; b=UH2uEtG00lHRCE9+HTIpR0GFtwevWayytflNd7gOD5VjraaQgWiMNC7Db+Iwjjiy7M0XciqHKRXyYsmHMv3CwD9owcePElZZ4SaPZJ7HOUIRm9K70r5UR3BLWqpeBADUCBVW0Z8s2/GVffb+EYoCLocEMBhRDeMb1eFWumk9ZI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739298564; c=relaxed/simple;
	bh=jfD26y7ujlhaKE2qq8IkOsYFnb6VOwtiDDWJS1uYSKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKl4XPyaY+rpdzdECrwZrp4HoCYYNcJ2K4D55qYqZ/lnphyVZrBLmxJV0YQOCMD3H8rwdaZZ0YWpMfsOA/ttXx17Qf0pkHLKz2ua99vCF0V36Acx9K0tCRMjk31D5ttduOolT+QvfjJpqfoyp55B7sgU7UA+KxlZdbIy8nhOscA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6620AC4CEDD;
	Tue, 11 Feb 2025 18:29:23 +0000 (UTC)
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
Subject: [PATCH v5 08/15] cxl: Add support for FWCTL get driver information callback
Date: Tue, 11 Feb 2025 11:28:02 -0700
Message-ID: <20250211182909.1650096-9-dave.jiang@intel.com>
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

Add definition for fwctl_ops->info() to return driver information. The
function will return a data structure with a reserved u32. This is setup
for future usages.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Li Ming <ming.li@zohomail.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/features.c | 11 +++++++++--
 include/cxl/mailbox.h       |  1 +
 include/uapi/fwctl/cxl.h    | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index db48a8fbde81..923c054599ad 100644
--- a/drivers/cxl/core/features.c
+++ b/drivers/cxl/core/features.c
@@ -354,8 +354,15 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 
 static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct fwctl_info_cxl *info;
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
index c4e99e2e3a9d..60a26a0d8f1f 100644
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
index 000000000000..d21fd6b80c20
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
+ * @reserved: zero
+ */
+struct fwctl_info_cxl {
+	__u32 reserved;
+};
+#endif
-- 
2.48.1

