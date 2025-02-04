Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA9425A623
	for <linux-cxl@vger.kernel.org>; Tue,  4 Feb 2025 22:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738706692; cv=none; b=OMPuNJpZB12IOF7AB5VZ4e9uXuxPicGoAwAWF30ALUkEvpFfWCaDHVGCtrOrfgucGbYKYsu3KZEKsAl/jwT5SuF+vIQ7UUP9JQtuW5YWmk7jIduf/i2gMbAjJ0kudBo3sHwyPlzGzqCq+ergjgf01RBtPcCGPC9WeDLsLKRgjK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738706692; c=relaxed/simple;
	bh=WTyj6IsUVpmJXJpYmDCdiiFkpUl39i7soEnJzk42BTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gmHVEnkplJLdQdxZrZ4IKSICL7Q+vr8Ezxi3f+wj66opcGbIUqjLbZXV543+1vK1UTdTT6uYD1BlbKf4sboVGjfnB9BdHfsyr+XDszzcRdQouvKTUim9ZkomlkUp4hao6DJWE46JGrrGwC20W4SRbXSzFMInXxwhwsprBfoWHSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CDFCC4CEDF;
	Tue,  4 Feb 2025 22:04:51 +0000 (UTC)
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
Subject: [PATCH v3 09/16] cxl: Add support for FWCTL get driver information callback
Date: Tue,  4 Feb 2025 15:03:10 -0700
Message-ID: <20250204220430.4146187-10-dave.jiang@intel.com>
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
index 985315d5d503..85dee01d89d1 100644
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

