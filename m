Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A13EC4338F
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 17:30:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CC6761103
	for <linux-cxl@archiver.kernel.org>; Mon,  2 Aug 2021 17:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbhHBRaU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 2 Aug 2021 13:30:20 -0400
Received: from mga17.intel.com ([192.55.52.151]:13754 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232127AbhHBRaR (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 2 Aug 2021 13:30:17 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10064"; a="193783440"
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="193783440"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 10:30:07 -0700
X-IronPort-AV: E=Sophos;i="5.84,289,1620716400"; 
   d="scan'208";a="458009761"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2021 10:30:05 -0700
Subject: [PATCH v5 6/6] cxl/core: Move memdev management to core
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Jonathan.Cameron@huawei.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com
Date:   Mon, 02 Aug 2021 10:30:05 -0700
Message-ID: <162792540495.368511.9748638751088219595.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162792537312.368511.15862521152871631343.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162792537312.368511.15862521152871631343.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

The motivation for moving cxl_memdev allocation to the core (beyond
better file organization of sysfs attributes in core/ and drivers in
cxl/), is that device lifetime is longer than module lifetime. The cxl_pci
module should be free to come and go without needing to coordinate with
devices that need the text associated with cxl_memdev_release() to stay
resident. The move fixes a use after free bug when looping driver
load / unload with CONFIG_DEBUG_KOBJECT_RELEASE=y.

Another motivation for disconnecting cxl_memdev creation from cxl_pci is
to enable other drivers, like a unit test driver, to registers memdevs.

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/Makefile |    1 
 drivers/cxl/core/bus.c    |   16 +++
 drivers/cxl/core/core.h   |    3 +
 drivers/cxl/core/memdev.c |  246 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/cxl/cxlmem.h      |   15 ++-
 drivers/cxl/pci.c         |  228 ------------------------------------------
 6 files changed, 275 insertions(+), 234 deletions(-)
 create mode 100644 drivers/cxl/core/memdev.c

diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index a3522d2fbf5b..0fdbf3c6ac1a 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -5,3 +5,4 @@ ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL -I$(srctree)/drivers/cxl
 cxl_core-y := bus.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
+cxl_core-y += memdev.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
index c938d8590c9f..37b87adaa33f 100644
--- a/drivers/cxl/core/bus.c
+++ b/drivers/cxl/core/bus.c
@@ -634,12 +634,26 @@ EXPORT_SYMBOL_GPL(cxl_bus_type);
 
 static __init int cxl_core_init(void)
 {
-	return bus_register(&cxl_bus_type);
+	int rc;
+
+	rc = cxl_memdev_init();
+	if (rc)
+		return rc;
+
+	rc = bus_register(&cxl_bus_type);
+	if (rc)
+		goto err;
+	return 0;
+
+err:
+	cxl_memdev_exit();
+	return rc;
 }
 
 static void cxl_core_exit(void)
 {
 	bus_unregister(&cxl_bus_type);
+	cxl_memdev_exit();
 }
 
 module_init(cxl_core_init);
diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 49045daf8bd7..036a3c8106b4 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -14,4 +14,7 @@ static inline void unregister_cxl_dev(void *dev)
 	device_unregister(dev);
 }
 
+int cxl_memdev_init(void);
+void cxl_memdev_exit(void);
+
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
new file mode 100644
index 000000000000..a9c317e32010
--- /dev/null
+++ b/drivers/cxl/core/memdev.c
@@ -0,0 +1,246 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/pci.h>
+#include <cxlmem.h>
+#include "core.h"
+
+/*
+ * An entire PCI topology full of devices should be enough for any
+ * config
+ */
+#define CXL_MEM_MAX_DEVS 65536
+
+static int cxl_mem_major;
+static DEFINE_IDA(cxl_memdev_ida);
+
+static void cxl_memdev_release(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+
+	ida_free(&cxl_memdev_ida, cxlmd->id);
+	kfree(cxlmd);
+}
+
+static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
+				kgid_t *gid)
+{
+	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
+}
+
+static ssize_t firmware_version_show(struct device *dev,
+				     struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%.16s\n", cxlm->firmware_version);
+}
+static DEVICE_ATTR_RO(firmware_version);
+
+static ssize_t payload_max_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%zu\n", cxlm->payload_size);
+}
+static DEVICE_ATTR_RO(payload_max);
+
+static ssize_t label_storage_size_show(struct device *dev,
+				       struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+
+	return sysfs_emit(buf, "%zu\n", cxlm->lsa_size);
+}
+static DEVICE_ATTR_RO(label_storage_size);
+
+static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
+			     char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	unsigned long long len = range_len(&cxlm->ram_range);
+
+	return sysfs_emit(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_ram_size =
+	__ATTR(size, 0444, ram_size_show, NULL);
+
+static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
+			      char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_mem *cxlm = cxlmd->cxlm;
+	unsigned long long len = range_len(&cxlm->pmem_range);
+
+	return sysfs_emit(buf, "%#llx\n", len);
+}
+
+static struct device_attribute dev_attr_pmem_size =
+	__ATTR(size, 0444, pmem_size_show, NULL);
+
+static struct attribute *cxl_memdev_attributes[] = {
+	&dev_attr_firmware_version.attr,
+	&dev_attr_payload_max.attr,
+	&dev_attr_label_storage_size.attr,
+	NULL,
+};
+
+static struct attribute *cxl_memdev_pmem_attributes[] = {
+	&dev_attr_pmem_size.attr,
+	NULL,
+};
+
+static struct attribute *cxl_memdev_ram_attributes[] = {
+	&dev_attr_ram_size.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_memdev_attribute_group = {
+	.attrs = cxl_memdev_attributes,
+};
+
+static struct attribute_group cxl_memdev_ram_attribute_group = {
+	.name = "ram",
+	.attrs = cxl_memdev_ram_attributes,
+};
+
+static struct attribute_group cxl_memdev_pmem_attribute_group = {
+	.name = "pmem",
+	.attrs = cxl_memdev_pmem_attributes,
+};
+
+static const struct attribute_group *cxl_memdev_attribute_groups[] = {
+	&cxl_memdev_attribute_group,
+	&cxl_memdev_ram_attribute_group,
+	&cxl_memdev_pmem_attribute_group,
+	NULL,
+};
+
+static const struct device_type cxl_memdev_type = {
+	.name = "cxl_memdev",
+	.release = cxl_memdev_release,
+	.devnode = cxl_memdev_devnode,
+	.groups = cxl_memdev_attribute_groups,
+};
+
+static void cxl_memdev_unregister(void *_cxlmd)
+{
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct device *dev = &cxlmd->dev;
+	struct cdev *cdev = &cxlmd->cdev;
+	const struct cdevm_file_operations *cdevm_fops;
+
+	cdevm_fops = container_of(cdev->ops, typeof(*cdevm_fops), fops);
+	cdevm_fops->shutdown(dev);
+
+	cdev_device_del(&cxlmd->cdev, dev);
+	put_device(dev);
+}
+
+static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
+					   const struct file_operations *fops)
+{
+	struct pci_dev *pdev = cxlm->pdev;
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
+	if (!cxlmd)
+		return ERR_PTR(-ENOMEM);
+
+	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
+	if (rc < 0)
+		goto err;
+	cxlmd->id = rc;
+
+	dev = &cxlmd->dev;
+	device_initialize(dev);
+	dev->parent = &pdev->dev;
+	dev->bus = &cxl_bus_type;
+	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
+	dev->type = &cxl_memdev_type;
+	device_set_pm_not_required(dev);
+
+	cdev = &cxlmd->cdev;
+	cdev_init(cdev, fops);
+	return cxlmd;
+
+err:
+	kfree(cxlmd);
+	return ERR_PTR(rc);
+}
+
+struct cxl_memdev *
+devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
+		    const struct cdevm_file_operations *cdevm_fops)
+{
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlmd = cxl_memdev_alloc(cxlm, &cdevm_fops->fops);
+	if (IS_ERR(cxlmd))
+		return cxlmd;
+
+	dev = &cxlmd->dev;
+	rc = dev_set_name(dev, "mem%d", cxlmd->id);
+	if (rc)
+		goto err;
+
+	/*
+	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
+	 * needed as this is ordered with cdev_add() publishing the device.
+	 */
+	cxlmd->cxlm = cxlm;
+
+	cdev = &cxlmd->cdev;
+	rc = cdev_device_add(cdev, dev);
+	if (rc)
+		goto err;
+
+	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
+	if (rc)
+		return ERR_PTR(rc);
+	return cxlmd;
+
+err:
+	/*
+	 * The cdev was briefly live, shutdown any ioctl operations that
+	 * saw that state.
+	 */
+	cdevm_fops->shutdown(dev);
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_memdev);
+
+__init int cxl_memdev_init(void)
+{
+	dev_t devt;
+	int rc;
+
+	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
+	if (rc)
+		return rc;
+
+	cxl_mem_major = MAJOR(devt);
+
+	return 0;
+}
+
+void cxl_memdev_exit(void)
+{
+	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
+}
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 0cd463de1342..25345ece25f8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -28,12 +28,6 @@
 	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
 	 CXLMDEV_RESET_NEEDED_NOT)
 
-/*
- * An entire PCI topology full of devices should be enough for any
- * config
- */
-#define CXL_MEM_MAX_DEVS 65536
-
 /**
  * struct cdevm_file_operations - devm coordinated cdev file operations
  * @fops: file operations that are synchronized against @shutdown
@@ -63,6 +57,15 @@ struct cxl_memdev {
 	int id;
 };
 
+static inline struct cxl_memdev *to_cxl_memdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_memdev, dev);
+}
+
+struct cxl_memdev *
+devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
+		    const struct cdevm_file_operations *cdevm_fops);
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f7a5ad5e1f4a..193983e6edce 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -94,8 +94,6 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
-static int cxl_mem_major;
-static DEFINE_IDA(cxl_memdev_ida);
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 static struct dentry *cxl_debugfs;
 static bool cxl_raw_allow_all;
@@ -806,11 +804,6 @@ static int cxl_memdev_release_file(struct inode *inode, struct file *file)
 	return 0;
 }
 
-static struct cxl_memdev *to_cxl_memdev(struct device *dev)
-{
-	return container_of(dev, struct cxl_memdev, dev);
-}
-
 static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
@@ -1178,214 +1171,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	return ret;
 }
 
-static void cxl_memdev_release(struct device *dev)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-
-	ida_free(&cxl_memdev_ida, cxlmd->id);
-	kfree(cxlmd);
-}
-
-static char *cxl_memdev_devnode(struct device *dev, umode_t *mode, kuid_t *uid,
-				kgid_t *gid)
-{
-	return kasprintf(GFP_KERNEL, "cxl/%s", dev_name(dev));
-}
-
-static ssize_t firmware_version_show(struct device *dev,
-				     struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_mem *cxlm = cxlmd->cxlm;
-
-	return sysfs_emit(buf, "%.16s\n", cxlm->firmware_version);
-}
-static DEVICE_ATTR_RO(firmware_version);
-
-static ssize_t payload_max_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_mem *cxlm = cxlmd->cxlm;
-
-	return sysfs_emit(buf, "%zu\n", cxlm->payload_size);
-}
-static DEVICE_ATTR_RO(payload_max);
-
-static ssize_t label_storage_size_show(struct device *dev,
-				struct device_attribute *attr, char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_mem *cxlm = cxlmd->cxlm;
-
-	return sysfs_emit(buf, "%zu\n", cxlm->lsa_size);
-}
-static DEVICE_ATTR_RO(label_storage_size);
-
-static ssize_t ram_size_show(struct device *dev, struct device_attribute *attr,
-			     char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_mem *cxlm = cxlmd->cxlm;
-	unsigned long long len = range_len(&cxlm->ram_range);
-
-	return sysfs_emit(buf, "%#llx\n", len);
-}
-
-static struct device_attribute dev_attr_ram_size =
-	__ATTR(size, 0444, ram_size_show, NULL);
-
-static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
-			      char *buf)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_mem *cxlm = cxlmd->cxlm;
-	unsigned long long len = range_len(&cxlm->pmem_range);
-
-	return sysfs_emit(buf, "%#llx\n", len);
-}
-
-static struct device_attribute dev_attr_pmem_size =
-	__ATTR(size, 0444, pmem_size_show, NULL);
-
-static struct attribute *cxl_memdev_attributes[] = {
-	&dev_attr_firmware_version.attr,
-	&dev_attr_payload_max.attr,
-	&dev_attr_label_storage_size.attr,
-	NULL,
-};
-
-static struct attribute *cxl_memdev_pmem_attributes[] = {
-	&dev_attr_pmem_size.attr,
-	NULL,
-};
-
-static struct attribute *cxl_memdev_ram_attributes[] = {
-	&dev_attr_ram_size.attr,
-	NULL,
-};
-
-static struct attribute_group cxl_memdev_attribute_group = {
-	.attrs = cxl_memdev_attributes,
-};
-
-static struct attribute_group cxl_memdev_ram_attribute_group = {
-	.name = "ram",
-	.attrs = cxl_memdev_ram_attributes,
-};
-
-static struct attribute_group cxl_memdev_pmem_attribute_group = {
-	.name = "pmem",
-	.attrs = cxl_memdev_pmem_attributes,
-};
-
-static const struct attribute_group *cxl_memdev_attribute_groups[] = {
-	&cxl_memdev_attribute_group,
-	&cxl_memdev_ram_attribute_group,
-	&cxl_memdev_pmem_attribute_group,
-	NULL,
-};
-
-static const struct device_type cxl_memdev_type = {
-	.name = "cxl_memdev",
-	.release = cxl_memdev_release,
-	.devnode = cxl_memdev_devnode,
-	.groups = cxl_memdev_attribute_groups,
-};
-
-static void cxl_memdev_unregister(void *_cxlmd)
-{
-	struct cxl_memdev *cxlmd = _cxlmd;
-	struct device *dev = &cxlmd->dev;
-	struct cdev *cdev = &cxlmd->cdev;
-	const struct cdevm_file_operations *cdevm_fops;
-
-	cdevm_fops = container_of(cdev->ops, typeof(*cdevm_fops), fops);
-	cdevm_fops->shutdown(dev);
-
-	cdev_device_del(&cxlmd->cdev, dev);
-	put_device(dev);
-}
-
-static struct cxl_memdev *cxl_memdev_alloc(struct cxl_mem *cxlm,
-					   const struct file_operations *fops)
-{
-	struct pci_dev *pdev = cxlm->pdev;
-	struct cxl_memdev *cxlmd;
-	struct device *dev;
-	struct cdev *cdev;
-	int rc;
-
-	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
-	if (!cxlmd)
-		return ERR_PTR(-ENOMEM);
-
-	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
-	if (rc < 0)
-		goto err;
-	cxlmd->id = rc;
-
-	dev = &cxlmd->dev;
-	device_initialize(dev);
-	dev->parent = &pdev->dev;
-	dev->bus = &cxl_bus_type;
-	dev->devt = MKDEV(cxl_mem_major, cxlmd->id);
-	dev->type = &cxl_memdev_type;
-	device_set_pm_not_required(dev);
-
-	cdev = &cxlmd->cdev;
-	cdev_init(cdev, fops);
-	return cxlmd;
-
-err:
-	kfree(cxlmd);
-	return ERR_PTR(rc);
-}
-
-static struct cxl_memdev *
-devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
-		    const struct cdevm_file_operations *cdevm_fops)
-{
-	struct cxl_memdev *cxlmd;
-	struct device *dev;
-	struct cdev *cdev;
-	int rc;
-
-	cxlmd = cxl_memdev_alloc(cxlm, &cdevm_fops->fops);
-	if (IS_ERR(cxlmd))
-		return cxlmd;
-
-	dev = &cxlmd->dev;
-	rc = dev_set_name(dev, "mem%d", cxlmd->id);
-	if (rc)
-		goto err;
-
-	/*
-	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
-	 * needed as this is ordered with cdev_add() publishing the device.
-	 */
-	cxlmd->cxlm = cxlm;
-
-	cdev = &cxlmd->cdev;
-	rc = cdev_device_add(cdev, dev);
-	if (rc)
-		goto err;
-
-	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
-	if (rc)
-		return ERR_PTR(rc);
-	return cxlmd;
-
-err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	cdevm_fops->shutdown(dev);
-	put_device(dev);
-	return ERR_PTR(rc);
-}
-
 static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
 {
 	u32 remaining = size;
@@ -1651,25 +1436,15 @@ static struct pci_driver cxl_mem_driver = {
 static __init int cxl_mem_init(void)
 {
 	struct dentry *mbox_debugfs;
-	dev_t devt;
 	int rc;
 
 	/* Double check the anonymous union trickery in struct cxl_regs */
 	BUILD_BUG_ON(offsetof(struct cxl_regs, memdev) !=
 		     offsetof(struct cxl_regs, device_regs.memdev));
 
-	rc = alloc_chrdev_region(&devt, 0, CXL_MEM_MAX_DEVS, "cxl");
-	if (rc)
-		return rc;
-
-	cxl_mem_major = MAJOR(devt);
-
 	rc = pci_register_driver(&cxl_mem_driver);
-	if (rc) {
-		unregister_chrdev_region(MKDEV(cxl_mem_major, 0),
-					 CXL_MEM_MAX_DEVS);
+	if (rc)
 		return rc;
-	}
 
 	cxl_debugfs = debugfs_create_dir("cxl", NULL);
 	mbox_debugfs = debugfs_create_dir("mbox", cxl_debugfs);
@@ -1683,7 +1458,6 @@ static __exit void cxl_mem_exit(void)
 {
 	debugfs_remove_recursive(cxl_debugfs);
 	pci_unregister_driver(&cxl_mem_driver);
-	unregister_chrdev_region(MKDEV(cxl_mem_major, 0), CXL_MEM_MAX_DEVS);
 }
 
 MODULE_LICENSE("GPL v2");

