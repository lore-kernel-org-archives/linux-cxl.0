Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B9AB1FB3CF
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706083; cv=none; b=qecLJtgyHDTOJr6a/2n6PPE0Nds0wAYpMhnrJi44SS+L49nrTToj6KDaUL/2/mchzJE4inVnRObwzbnHOYSZCM2H5ETiMoQ+t1lB9onzwMOoZOITt+qnVKberFcRzUgcPw66FgsnuhmhkUAPmILpUa6TDbTm9e6tOqmrV2jzx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706083; c=relaxed/simple;
	bh=5f34DlUEiXdQEyWZe3WO9xzFVT135Bgjz52N124eNjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=laIWqlNHBCqKG6cie6vHKJTDcjeMhr6Gor7ehz517yuITAWDMVu4BaPTCg17c8erpkKMI9U9gQcc7E9Co3QbgPabJd6BfPCaZyZ4m8QOQonoVXxODZpG6KarEBuZN86SebrbePtXFxYTEckEs3iFJG9w0MZaGY/4l48prOqJb0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B4ABC4CECF;
	Fri, 15 Nov 2024 21:28:02 +0000 (UTC)
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
Subject: [RFC PATCH v2 10/20] fwctl/cxl: Add support for get driver information
Date: Fri, 15 Nov 2024 14:25:43 -0700
Message-ID: <20241115212745.869552-11-dave.jiang@intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241115212745.869552-1-dave.jiang@intel.com>
References: <20241115212745.869552-1-dave.jiang@intel.com>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add definition for fwctl_ops->info() to return driver information. The
function will return the number of device mailbox commands supported by the
fwctl char device.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Change driver info to report number of commands supported by the driver and device.
---
 drivers/cxl/core/mbox.c  | 46 ++++++++++++++++++++++++++++++++++++++++
 drivers/fwctl/cxl/cxl.c  | 23 ++++++++++++++++++--
 include/cxl/cxl.h        |  2 ++
 include/cxl/mailbox.h    |  1 +
 include/uapi/fwctl/cxl.h | 22 +++++++++++++++++++
 5 files changed, 92 insertions(+), 2 deletions(-)
 create mode 100644 include/uapi/fwctl/cxl.h

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 12758e763650..f464eb42f08a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -118,6 +118,14 @@ static u8 security_command_sets[] = {
 	0x46, /* Security Passthrough */
 };
 
+#define FWCTL_CXL_MAX_COMMANDS 3
+/* Command set that is allowed with FWCTL-CXL */
+static u16 fwctl_command_sets[] = {
+	CXL_MBOX_OP_GET_SUPPORTED_FEATURES,
+	CXL_MBOX_OP_GET_FEATURE,
+	CXL_MBOX_OP_SET_FEATURE,
+};
+
 static bool cxl_is_security_command(u16 opcode)
 {
 	int i;
@@ -527,6 +535,44 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 				 send_cmd->in.payload);
 }
 
+static struct cxl_mem_command *
+fwctl_cxl_find_command(struct cxl_mailbox *cxl_mbox, u16 opcode)
+{
+	struct cxl_command_info *info;
+	struct cxl_mem_command *cmd;
+
+	cmd = cxl_mem_find_command(opcode);
+	if (!cmd)
+		return NULL;
+
+	info = &cmd->info;
+	if (test_bit(info->id, cxl_mbox->enabled_cmds) &&
+	    !test_bit(info->id, cxl_mbox->exclusive_cmds))
+		return cmd;
+
+	return NULL;
+}
+
+/**
+ * cxl_mailbox_user_commands_supported() - Return number of user mailbox
+ *                                         commands supported.
+ * @cxl_mbox: cxl mailbox context
+ *
+ * Return: number of commands supported
+ */
+int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox)
+{
+	int nr_cmds = 0;
+
+	for (int i = 0; i < FWCTL_CXL_MAX_COMMANDS; i++) {
+		nr_cmds += !!fwctl_cxl_find_command(cxl_mbox,
+						    fwctl_command_sets[i]);
+	}
+
+	return nr_cmds;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mailbox_user_commands_supported, CXL);
+
 int cxl_query_cmd(struct cxl_mailbox *cxl_mbox,
 		  struct cxl_mem_query_commands __user *q)
 {
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
index c6a11cbbd937..5eb5eabf2bff 100644
--- a/drivers/fwctl/cxl/cxl.c
+++ b/drivers/fwctl/cxl/cxl.c
@@ -6,6 +6,7 @@
 #include <linux/device.h>
 #include <cxl/cxl.h>
 #include <cxl/mailbox.h>
+#include <uapi/fwctl/cxl.h>
 
 struct cxlctl_uctx {
 	struct fwctl_uctx uctx;
@@ -21,6 +22,15 @@ DEFINE_FREE(cxlctl, struct cxlctl_dev *, if (_T) fwctl_put(&_T->fwctl))
 
 static int cxlctl_open_uctx(struct fwctl_uctx *uctx)
 {
+	struct cxlctl_uctx *cxlctl_uctx =
+		container_of(uctx, struct cxlctl_uctx, uctx);
+	struct fwctl_device *fwctl = uctx->fwctl;
+	struct cxlctl_dev *cxlctl =
+		container_of(fwctl, struct cxlctl_dev, fwctl);
+
+	cxlctl_uctx->nr_commands =
+		cxl_mailbox_user_commands_supported(cxlctl->mbox);
+
 	return 0;
 }
 
@@ -30,8 +40,17 @@ static void cxlctl_close_uctx(struct fwctl_uctx *uctx)
 
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
+	info->nr_commands = cxlctl_uctx->nr_commands;
+
+	return info;
 }
 
 static void *cxlctl_fw_rpc(struct fwctl_uctx *uctx, enum fwctl_rpc_scope scope,
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 6bfd7942a3f7..d0939e3bcbc0 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -3,6 +3,8 @@
 #ifndef __CXL_GLOBAL_H__
 #define __CXL_GLOBAL_H__
 
+#include <linux/device.h>
+
 struct cxl_driver {
 	const char *name;
 	int (*probe)(struct device *dev);
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 16d21f63464c..af01fb78ae10 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -84,5 +84,6 @@ struct cxl_mailbox {
 };
 
 int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host);
+int cxl_mailbox_user_commands_supported(struct cxl_mailbox *cxl_mbox);
 
 #endif
diff --git a/include/uapi/fwctl/cxl.h b/include/uapi/fwctl/cxl.h
new file mode 100644
index 000000000000..a32c4c752db6
--- /dev/null
+++ b/include/uapi/fwctl/cxl.h
@@ -0,0 +1,22 @@
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
+ * @uctx_caps: The number of commands the driver and device supports
+ *
+ * Return basic information about the FW interface available.
+ */
+struct fwctl_info_cxl {
+	__u32 nr_commands;
+};
+
+#endif
-- 
2.47.0

