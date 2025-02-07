Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A032198E92
	for <linux-cxl@vger.kernel.org>; Fri,  7 Feb 2025 23:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738971569; cv=none; b=rvrr8R8VAD9BZLx8ytpwnBGCkuZi01F/JH92NZPRhH3eng/6BQIPuCcht8f9pirlwubY94bpc8ASK10F+YyMiw0+uXgTNCWEqpNpiTjZZLlZM0qgLXHq8xSBTF5LXqEEwWT6NBPIv06pNIOCq2/7FRmb6tRg7PBulTFStnsZ/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738971569; c=relaxed/simple;
	bh=D3rbaORlrDAJqXFhSbt8dDPx99b9HgmXz8Y+cwWY6ts=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sJxNa6KCoxteg3YI/MaG3QarqK0DyfIrN9CQVsrSt4zLcnbOIBpAibhjcjImIzK1/0o/T9jG+igxnGmbVHyad3HZ1EdsLa0buARG/hlkDzeZE6PWLsEcVisw5vi9MNCzm99Vnd9ACOJpBxkKceuUPw4kZaTUahXmGCzc7llQo7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E690EC4CED1;
	Fri,  7 Feb 2025 23:39:28 +0000 (UTC)
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
Subject: [PATCH v4 08/15] cxl: Add support for FWCTL get driver information callback
Date: Fri,  7 Feb 2025 16:37:48 -0700
Message-ID: <20250207233914.2375110-9-dave.jiang@intel.com>
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

Add definition for fwctl_ops->info() to return driver information. The
function will return a data structure with a reserved u32. This is setup
for future usages.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v4:
- Remove entries check as it is not needed. (Dan)
---
 drivers/cxl/core/features.c | 11 +++++++++--
 include/cxl/mailbox.h       |  1 +
 include/uapi/fwctl/cxl.h    | 19 +++++++++++++++++++
 3 files changed, 29 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/cxl/core/features.c b/drivers/cxl/core/features.c
index 81e8ff66c12e..b2836b951360 100644
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

