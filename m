Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8808A1FB3F1
	for <linux-cxl@vger.kernel.org>; Fri, 15 Nov 2024 21:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731706081; cv=none; b=h1ZHks6MFTI7PUxlJZIdvPgefOLzwYWy1lIzqG6NAsbjZmuR2FMXP70pZJ2lIeFBV5I4FpW3pcQJSNxG2JXRP4/X6zqNtjkKzIASFyHCvB7AZIX1udaGqDGtHQuR0V3/QIRNmI1TIdBkrHSuXIiJtkcCqU6tT/VaLqgeKDig4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731706081; c=relaxed/simple;
	bh=ky7QqMBksymCTVGtHG3BmsMmLlJN9Wy39+RORoFfwZk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HezarrhKV43a7EMAruKhP40JUF3RN0elAIaJGtxpn2hUEk9xm5OzpcOTChyiJ/A+9B3mX14Rc5Sjbj1189d4axrZZz3iXSiRxeUCtPW/Bssi1GA53w8mosN+g9dwydnWH7hGLS+Kzlyz7lC4sD8EjRFZERbidtX+KIlSBXv+mgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4228C4CECF;
	Fri, 15 Nov 2024 21:28:00 +0000 (UTC)
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
Subject: [RFC PATCH v2 09/20] fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
Date: Fri, 15 Nov 2024 14:25:42 -0700
Message-ID: <20241115212745.869552-10-dave.jiang@intel.com>
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

Add a cxl fwctl driver to allow sending of CXL feature
commands from userspace through as ioctls. Create a driver skeleton for
initial setup.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
v2:
- Move to cxl_bus from auxiliary_bus (Jonathan)
---
 MAINTAINERS                |  8 ++++
 drivers/cxl/core/mbox.c    | 41 +++++++++++++++-
 drivers/fwctl/Kconfig      |  9 ++++
 drivers/fwctl/Makefile     |  1 +
 drivers/fwctl/cxl/Makefile |  4 ++
 drivers/fwctl/cxl/cxl.c    | 97 ++++++++++++++++++++++++++++++++++++++
 include/cxl/cxl.h          |  1 +
 include/cxl/mailbox.h      | 17 +++++++
 include/uapi/fwctl/fwctl.h |  1 +
 9 files changed, 178 insertions(+), 1 deletion(-)
 create mode 100644 drivers/fwctl/cxl/Makefile
 create mode 100644 drivers/fwctl/cxl/cxl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 93f74bc58d99..6b52c4168b94 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9389,6 +9389,14 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/mlx5/
 
+FWCTL CXL DRIVER
+M:	Dave Jiang <dave.jiang@intel.com>
+R:	Dan Williams <dan.j.williams@intel.com>
+R:	Jonathan Cameron <jonathan.cameron@huawei.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/cxl/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 739444d34130..12758e763650 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1712,8 +1712,29 @@ int cxl_poison_state_init(struct cxl_memdev_state *mds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_poison_state_init, CXL);
 
+static void cxl_fwctl_release(struct device *dev)
+{
+	struct cxl_fwctl *fwctl = to_cxl_fwctl(dev);
+
+	kfree(fwctl);
+}
+
+static void remove_fwctl_dev(void *dev)
+{
+	device_unregister(dev);
+}
+
+static const struct device_type cxl_fwctl_type = {
+	.name = "cxl_fwctl",
+	.release = cxl_fwctl_release,
+};
+
 int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 {
+	struct cxl_fwctl *fwctl __free(kfree) = kzalloc(sizeof(*fwctl), GFP_KERNEL);
+	struct device *dev;
+	int rc;
+
 	if (!cxl_mbox || !host)
 		return -EINVAL;
 
@@ -1721,7 +1742,25 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 	mutex_init(&cxl_mbox->mbox_mutex);
 	rcuwait_init(&cxl_mbox->mbox_wait);
 
-	return 0;
+	fwctl->cxl_mbox = cxl_mbox;
+	dev = &fwctl->dev;
+	device_initialize(dev);
+	device_set_pm_not_required(dev);
+	dev->parent = host;
+	dev->bus = &cxl_bus_type;
+	dev->type = &cxl_fwctl_type;
+
+	rc = device_add(dev);
+	if (rc)
+		goto err;
+
+	cxl_mbox->fwctl = no_free_ptr(fwctl);
+
+	return devm_add_action_or_reset(host, remove_fwctl_dev, dev);
+
+err:
+	put_device(&fwctl->dev);
+	return rc;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mailbox_init, CXL);
 
diff --git a/drivers/fwctl/Kconfig b/drivers/fwctl/Kconfig
index e5ee2d46d431..e49903a9d0d3 100644
--- a/drivers/fwctl/Kconfig
+++ b/drivers/fwctl/Kconfig
@@ -19,5 +19,14 @@ config FWCTL_MLX5
 	  This will allow configuration and debug tools to work out of the box on
 	  mainstream kernel.
 
+	  If you don't know what to do here, say N.
+
+config FWCTL_CXL
+	tristate "CXL fwctl driver"
+	depends on CXL_BUS
+	help
+	  CXLCTL provides interface for the user process to access user allowed
+	  mailbox commands for CXL device.
+
 	  If you don't know what to do here, say N.
 endif
diff --git a/drivers/fwctl/Makefile b/drivers/fwctl/Makefile
index 1c535f694d7f..bd356e6f2e5a 100644
--- a/drivers/fwctl/Makefile
+++ b/drivers/fwctl/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_FWCTL) += fwctl.o
 obj-$(CONFIG_FWCTL_MLX5) += mlx5/
+obj-$(CONFIG_FWCTL_CXL) += cxl/
 
 fwctl-y += main.o
diff --git a/drivers/fwctl/cxl/Makefile b/drivers/fwctl/cxl/Makefile
new file mode 100644
index 000000000000..623194521572
--- /dev/null
+++ b/drivers/fwctl/cxl/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_FWCTL_CXL) += cxl_fwctl.o
+
+cxl_fwctl-y += cxl.o
diff --git a/drivers/fwctl/cxl/cxl.c b/drivers/fwctl/cxl/cxl.c
new file mode 100644
index 000000000000..c6a11cbbd937
--- /dev/null
+++ b/drivers/fwctl/cxl/cxl.c
@@ -0,0 +1,97 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Intel Corporation
+ */
+#include <linux/fwctl.h>
+#include <linux/device.h>
+#include <cxl/cxl.h>
+#include <cxl/mailbox.h>
+
+struct cxlctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 nr_commands;
+};
+
+struct cxlctl_dev {
+	struct fwctl_device fwctl;
+	struct cxl_mailbox *mbox;
+};
+
+DEFINE_FREE(cxlctl, struct cxlctl_dev *, if (_T) fwctl_put(&_T->fwctl))
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
+			   void *rpc_in, size_t in_len, size_t *out_len)
+{
+	/* Place holder */
+	return ERR_PTR(-EOPNOTSUPP);
+}
+
+static const struct fwctl_ops cxlctl_ops = {
+	.device_type = FWCTL_DEVICE_TYPE_CXL,
+	.uctx_size = sizeof(struct cxlctl_uctx),
+	.open_uctx = cxlctl_open_uctx,
+	.close_uctx = cxlctl_close_uctx,
+	.info = cxlctl_info,
+	.fw_rpc = cxlctl_fw_rpc,
+};
+
+static int cxlctl_probe(struct device *dev)
+{
+	struct cxl_fwctl *cxl_fwctl = to_cxl_fwctl(dev);
+	struct cxl_mailbox *cxl_mbox = cxl_fwctl->cxl_mbox;
+	struct cxlctl_dev *cxlctl __free(cxlctl) =
+		fwctl_alloc_device(cxl_mbox->host, &cxlctl_ops,
+				   struct cxlctl_dev, fwctl);
+	int rc;
+
+	if (!cxlctl)
+		return -ENOMEM;
+
+	cxlctl->mbox = cxl_mbox;
+
+	rc = fwctl_register(&cxlctl->fwctl);
+	if (rc)
+		return rc;
+
+	dev_set_drvdata(dev, no_free_ptr(cxlctl));
+
+	return 0;
+}
+
+static void cxlctl_remove(struct device *dev)
+{
+	struct cxlctl_dev *ctldev  = dev_get_drvdata(dev);
+
+	fwctl_unregister(&ctldev->fwctl);
+}
+
+static struct cxl_driver cxl_fwctl_driver = {
+	.name = "cxl_fwctl",
+	.probe = cxlctl_probe,
+	.remove = cxlctl_remove,
+	.id = CXL_DEVICE_FWCTL,
+};
+
+module_cxl_driver(cxl_fwctl_driver);
+
+MODULE_IMPORT_NS(CXL);
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("CXL fwctl driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_CXL(CXL_DEVICE_FWCTL);
diff --git a/include/cxl/cxl.h b/include/cxl/cxl.h
index 07a2983275a0..6bfd7942a3f7 100644
--- a/include/cxl/cxl.h
+++ b/include/cxl/cxl.h
@@ -30,6 +30,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PMEM_REGION		7
 #define CXL_DEVICE_DAX_REGION		8
 #define CXL_DEVICE_PMU			9
+#define CXL_DEVICE_FWCTL		10
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index 03c4b8ad84c1..16d21f63464c 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -3,6 +3,7 @@
 #ifndef __CXL_MBOX_H__
 #define __CXL_MBOX_H__
 #include <linux/rcuwait.h>
+#include <linux/auxiliary_bus.h>
 #include <uapi/linux/cxl_mem.h>
 
 /**
@@ -41,8 +42,23 @@ struct cxl_mbox_cmd {
 	u16 return_code;
 };
 
+struct cxl_mailbox;
+
+/**
+ * struct cxl_fwctl - context for FWCTL
+ * @dev: device for fwctl
+ * @cxl_mbox: pointer to cxl mailbox context
+ */
+struct cxl_fwctl {
+	struct device dev;
+	struct cxl_mailbox *cxl_mbox;
+};
+
+#define to_cxl_fwctl(dev) container_of(dev, struct cxl_fwctl, dev)
+
 /**
  * struct cxl_mailbox - context for CXL mailbox operations
+ * @fwctl: points to fwctl context
  * @host: device that hosts the mailbox
  * @enabled_cmds: mailbox commands that are enabled by the driver
  * @exclusive_cmds: mailbox commands that are exclusive to the kernel
@@ -55,6 +71,7 @@ struct cxl_mbox_cmd {
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  */
 struct cxl_mailbox {
+	struct cxl_fwctl *fwctl;
 	struct device *host;
 	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
 	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
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
-- 
2.47.0

