Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345967F7C7
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338504; cv=none; b=WwY1fiL4N9WdSM0TwAxu79zaKlWIJLjIsr+hwN4g4XTXqqHfr4DH8csCAa/EO92RZtIPaBO/kc/ug+BwjD0hMwKi0PA474wSWFmAV1GvtBMG1lGw1WESqpxka1Tmib7Nq07OVPRTx7ivqywt6sbpGMt3biVHfGpWUtlJXYqh0iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338504; c=relaxed/simple;
	bh=PpSGVZPVcaZ03xWfeeCBlRVlHzdZxtQDPK2EXDRVE9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uwaARfVjGsuPI2f+wrHd87nVZkyemLjQGL0CpVbLlZrWpUH5WmlgAer24lpfFL8qsRrIUE7ZnBG8xN9Od0EjTpPW/S3qKa4HaFOU/gm8r2pj/iCdf5kqzX2J0p/+k4K0671rOTfPPxmKHAshj6uKdOrRiAXIXvZru73iJRf9PPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91766C116B1;
	Thu, 18 Jul 2024 21:35:03 +0000 (UTC)
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
Subject: [RFC PATCH 09/13] fwctl/cxl: Add support for get driver information
Date: Thu, 18 Jul 2024 14:32:27 -0700
Message-ID: <20240718213446.1750135-10-dave.jiang@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718213446.1750135-1-dave.jiang@intel.com>
References: <20240718213446.1750135-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definition for fwctl_ops->info() to return driver information. The
function will return the commands supported by the fwctl char device as
a bitmap of enable commands.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/fwctl/cxl/cxl.c  | 20 ++++++++++++++++++--
 include/uapi/fwctl/cxl.h | 25 +++++++++++++++++++++++++
 2 files changed, 43 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index 518ba2afada8..22f62034c021 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -6,6 +6,7 @@
 #include <linux/auxiliary_bus.h>
 #include <linux/cxl/mailbox.h>
 #include <linux/auxiliary_bus.h>
+#include <uapi/fwctl/cxl.h>
 
 struct cxlctl_uctx {
 	struct fwctl_uctx uctx;
@@ -22,6 +23,12 @@ DEFINE_FREE(cxlctl, struct cxlctl_dev *, if (_T) fwctl_put(&_T->fwctl))
 
 static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
 {
+	struct cxlctl_uctx *cxlctl_uctx =
+		container_of(uctx, struct cxlctl_uctx, uctx);
+
+	cxlctl_uctx->uctx_caps = BIT(FWCTL_CXL_QUERY_COMMANDS) |
+				 BIT(FWCTL_CXL_SEND_COMMAND);
+
 	return 0;
 }
 
@@ -31,8 +38,17 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 
 static void *cxlctl_info(struct fwctl_uctx *uctx, size_t *length)
 {
-	/* Place holder */
-	return ERR_PTR(-EOPNOTSUPP);
+	struct cxlctl_uctx *cxlctl_uctx =
+		container_of(uctx, struct cxlctl_uctx, uctx);
+	struct fwctl_info_cxl *info;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info)
+		return ERR_PTR(-ENOMEM);
+
+	info->uctx_caps = cxlctl_uctx->uctx_caps;
+
+	return info;
 }
 
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
new file mode 100644
index 000000000000..d3a735f1fe4e
--- /dev/null
+++ b/include/uapi/fwctl/cxl.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
+/*
+ * Copyright (c) 2024, Intel Corporation
+ *
+ * These are definitions for the mailbox command interface of CXL subsystem.
+ */
+#ifndef _UAPI_FWCTL_CXL_H_
+#define _UAPI_FWCTL_CXL_H_
+
+enum fwctl_cxl_commands {
+	FWCTL_CXL_QUERY_COMMANDS = 0,
+	FWCTL_CXL_SEND_COMMAND,
+};
+
+/**
+ * struct fwctl_info_cxl - ioctl(FWCTL_INFO) out_device_data
+ * @uctx_caps: The command capabilities driver accepts.
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_cxl {
+	__u32 uctx_caps;
+};
+
+#endif
-- 
2.45.2

