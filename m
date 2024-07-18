Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4B81219
	for <linux-cxl@vger.kernel.org>; Thu, 18 Jul 2024 21:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721338502; cv=none; b=CmoDmTLt5SgIt8Xu87e0NJ86IDwZzOcTbVF7rHTjcNpCnjIhOHYSUB+Xhq3x+a3EFf7UeaQGskf1JkQ6IlzJBin2ndo9Qnq2CTf7NNXdjA5NRgtYuV2jf0PJrorRfZbrbDIjT2fOxYEb7q6bqFpRsLQPmZ/zmHJkRrLp7a3Wf+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721338502; c=relaxed/simple;
	bh=88XMW+ArlhbwSSxJTeIF4sdiTGUwgV2EhkazfHHXUAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aOLlBdJsJ44vE/G1/uBbw3X0oXMwgigf6Axn1vWnHOJTrSB95Ow2dPi7wP3XXH5VMuip+1woINGsk3bppki0VQaeUWT+CWi4qI+03LJi38XeQ5/O3f/haMEceN44MUlPd19AlyyyO9UY2choiVAWJqD76NE2n9jj+fPMA2eXZ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 282D9C4AF09;
	Thu, 18 Jul 2024 21:35:02 +0000 (UTC)
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
Subject: [RFC PATCH 08/13] fwctl/cxl: Add driver for CXL mailbox for handling CXL features commands
Date: Thu, 18 Jul 2024 14:32:26 -0700
Message-ID: <20240718213446.1750135-9-dave.jiang@intel.com>
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

Add an fwctl (auxiliary bus) driver to allow sending of CXL feature
commands from userspace through as ioctls. Create a driver skeleton for
initial setup.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 MAINTAINERS                |   7 +++
 drivers/cxl/core/memdev.c  |  19 +++++++
 drivers/fwctl/Kconfig      |   9 ++++
 drivers/fwctl/Makefile     |   1 +
 drivers/fwctl/cxl/Makefile |   4 ++
 drivers/fwctl/cxl/cxl.c    | 103 +++++++++++++++++++++++++++++++++++++
 include/uapi/fwctl/fwctl.h |   1 +
 7 files changed, 144 insertions(+)
 create mode 100644 drivers/fwctl/cxl/Makefile
 create mode 100644 drivers/fwctl/cxl/cxl.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 3e1934b7e044..5d6c470c06ea 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9073,6 +9073,13 @@ L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	drivers/fwctl/mlx5/
 
+FWCTL CXL DRIVER
+M:	Dave Jiang <dave.jiang@intel.com>
+R:	Dan Williams <dan.j.williams@intel.com>
+L:	linux-cxl@vger.kernel.org
+S:	Maintained
+F:	drivers/fwctl/cxl/
+
 GALAXYCORE GC0308 CAMERA SENSOR DRIVER
 M:	Sebastian Reichel <sre@kernel.org>
 L:	linux-media@vger.kernel.org
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 9f0fe698414d..0f6ec85ef9c4 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -13,6 +13,8 @@
 
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 
+#define CXL_ADEV_NAME "fwctl-cxl"
+
 /*
  * An entire PCI topology full of devices should be enough for any
  * config
@@ -1030,6 +1032,7 @@ static const struct file_operations cxl_memdev_fops = {
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds)
 {
+	struct auxiliary_device *adev;
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
@@ -1056,11 +1059,27 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	if (rc)
 		goto err;
 
+	adev = &cxlds->cxl_mbox.adev;
+	adev->id = cxlmd->id;
+	adev->name = CXL_ADEV_NAME;
+	adev->dev.parent = dev;
+
+	rc = auxiliary_device_init(adev);
+	if (rc)
+		goto err;
+
+	rc = auxiliary_device_add(adev);
+	if (rc)
+		goto aux_err;
+
 	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
 	return cxlmd;
 
+aux_err:
+	auxiliary_device_uninit(adev);
+
 err:
 	/*
 	 * The cdev was briefly live, shutdown any ioctl operations that
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
index 000000000000..518ba2afada8
--- /dev/null
+++ b/drivers/fwctl/cxl/cxl.c
@@ -0,0 +1,103 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2024, Intel Corporation
+ */
+#include <linux/fwctl.h>
+#include <linux/auxiliary_bus.h>
+#include <linux/cxl/mailbox.h>
+#include <linux/auxiliary_bus.h>
+
+struct cxlctl_uctx {
+	struct fwctl_uctx uctx;
+	u32 uctx_caps;
+	u32 uctx_uid;
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
+static int cxlctl_probe(struct auxiliary_device *adev,
+			const struct auxiliary_device_id *id)
+{
+	struct cxl_mailbox *mbox = container_of(adev, struct cxl_mailbox, adev);
+	struct cxlctl_dev *cxlctl __free(cxlctl) =
+		fwctl_alloc_device(mbox->host, &cxlctl_ops,
+				   struct cxlctl_dev, fwctl);
+	int rc;
+
+	if (!cxlctl)
+		return -ENOMEM;
+
+	cxlctl->mbox = mbox;
+
+	rc = fwctl_register(&cxlctl->fwctl);
+	if (rc)
+		return rc;
+
+	auxiliary_set_drvdata(adev, no_free_ptr(cxlctl));
+
+	return 0;
+}
+
+static void cxlctl_remove(struct auxiliary_device *adev)
+{
+	struct cxlctl_dev *ctldev __free(cxlctl) = auxiliary_get_drvdata(adev);
+
+	fwctl_unregister(&ctldev->fwctl);
+}
+
+static const struct auxiliary_device_id cxlctl_id_table[] = {
+	{ .name = "CXL.fwctl", },
+	{},
+};
+MODULE_DEVICE_TABLE(auxiliary, cxlctl_id_table);
+
+static struct auxiliary_driver cxlctl_driver = {
+	.name = "cxl_fwctl",
+	.probe = cxlctl_probe,
+	.remove = cxlctl_remove,
+	.id_table = cxlctl_id_table,
+};
+
+module_auxiliary_driver(cxlctl_driver);
+
+MODULE_IMPORT_NS(CXL);
+MODULE_IMPORT_NS(FWCTL);
+MODULE_DESCRIPTION("CXL fwctl driver");
+MODULE_AUTHOR("Intel Corporation");
+MODULE_LICENSE("GPL");
diff --git a/include/uapi/fwctl/fwctl.h b/include/uapi/fwctl/fwctl.h
index 49a357e1bc71..6edcc38a6eee 100644
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
2.45.2

