Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0DCAC636C8
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:49:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AEF561285
	for <linux-cxl@archiver.kernel.org>; Thu, 15 Jul 2021 19:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244959AbhGOTwn (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 15 Jul 2021 15:52:43 -0400
Received: from mga02.intel.com ([134.134.136.20]:23282 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344491AbhGOTtj (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 15 Jul 2021 15:49:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10046"; a="197803806"
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="197803806"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:35 -0700
X-IronPort-AV: E=Sophos;i="5.84,243,1620716400"; 
   d="scan'208";a="489564804"
Received: from cherrera-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.135.149])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2021 12:41:34 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 6/6] cxl/core: Move memdev management to core
Date:   Thu, 15 Jul 2021 12:41:25 -0700
Message-Id: <20210715194125.898305-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210715194125.898305-1-ben.widawsky@intel.com>
References: <20210715194125.898305-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The CXL core must own memdev management so that CXL drivers may register
for services. At present, only cxl_pci cares about this functionality,
which is why the functionality was implemented there. The immediate need
for this is a memdev driver which will be needed to manage CXL regions.
Potentially, drivers for other types of devices may desire this
functionality as well - an accelerator wishing to present itself as a
memory device for example.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Makefile      |   2 +-
 drivers/cxl/core/memdev.c | 224 +++++++++++++++++++++++++++++++++++++
 drivers/cxl/mem.h         |   5 +
 drivers/cxl/pci.c         | 228 ++------------------------------------
 4 files changed, 237 insertions(+), 222 deletions(-)
 create mode 100644 drivers/cxl/core/memdev.c

diff --git a/drivers/cxl/Makefile b/drivers/cxl/Makefile
index 607d8e6ab199..60941699c9ac 100644
--- a/drivers/cxl/Makefile
+++ b/drivers/cxl/Makefile
@@ -5,7 +5,7 @@ obj-$(CONFIG_CXL_ACPI) += cxl_acpi.o
 obj-$(CONFIG_CXL_PMEM) += cxl_pmem.o
 
 ccflags-y += -DDEFAULT_SYMBOL_NAMESPACE=CXL
-cxl_core-y := core/bus.o core/pmem.o core/regs.o
+cxl_core-y := core/bus.o core/memdev.o core/pmem.o core/regs.o
 cxl_pci-y := pci.o
 cxl_acpi-y := acpi.o
 cxl_pmem-y := pmem.o
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
new file mode 100644
index 000000000000..dce43e03a05b
--- /dev/null
+++ b/drivers/cxl/core/memdev.c
@@ -0,0 +1,224 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/* Copyright(c) 2020 Intel Corporation. */
+
+#include <linux/device.h>
+#include <linux/slab.h>
+#include <linux/idr.h>
+#include <linux/pci.h>
+#include "core.h"
+
+static DEFINE_IDA(cxl_memdev_ida);
+
+static struct cxl_memdev *to_cxl_memdev(struct device *dev)
+{
+	return container_of(dev, struct cxl_memdev, dev);
+}
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
+
+	cdev_device_del(&cxlmd->cdev, dev);
+	if (cxlmd->shutdown)
+		cxlmd->shutdown(cxlmd);
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
+		    const struct file_operations *fops,
+		    void (*shutdown)(struct cxl_memdev *cxlmd))
+{
+	struct cxl_memdev *cxlmd;
+	struct device *dev;
+	struct cdev *cdev;
+	int rc;
+
+	cxlmd = cxl_memdev_alloc(cxlm, fops);
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
+	cxlmd->shutdown = shutdown;
+	return cxlmd;
+
+err:
+	/*
+	 * The cdev was briefly live, shutdown any ioctl operations that
+	 * saw that state.
+	 */
+	if (shutdown)
+		shutdown(cxlmd);
+	put_device(dev);
+	return ERR_PTR(rc);
+}
+EXPORT_SYMBOL_GPL(devm_cxl_add_memdev);
diff --git a/drivers/cxl/mem.h b/drivers/cxl/mem.h
index 2b7481376621..3730e3509ab6 100644
--- a/drivers/cxl/mem.h
+++ b/drivers/cxl/mem.h
@@ -52,6 +52,11 @@ struct cxl_memdev {
 	void (*shutdown)(struct cxl_memdev *cxlmd);
 };
 
+struct cxl_memdev *
+devm_cxl_add_memdev(struct device *host, struct cxl_mem *cxlm,
+		    const struct file_operations *fops,
+		    void (*shutdown)(struct cxl_memdev *cxlmd));
+
 /**
  * struct cxl_mem - A CXL memory device
  * @pdev: The PCI device associated with this CXL device.
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 418ae0eac188..00b7f9502e04 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -94,7 +94,6 @@ struct mbox_cmd {
 #define CXL_MBOX_SUCCESS 0
 };
 
-static DEFINE_IDA(cxl_memdev_ida);
 static DECLARE_RWSEM(cxl_memdev_rwsem);
 static struct dentry *cxl_debugfs;
 static bool cxl_raw_allow_all;
@@ -1160,226 +1159,6 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 	return ret;
 }
 
-static struct cxl_memdev *to_cxl_memdev(struct device *dev)
-{
-	return container_of(dev, struct cxl_memdev, dev);
-}
-
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
-static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
-{
-	down_write(&cxl_memdev_rwsem);
-	cxlmd->cxlm = NULL;
-	up_write(&cxl_memdev_rwsem);
-}
-
-static void cxl_memdev_unregister(void *_cxlmd)
-{
-	struct cxl_memdev *cxlmd = _cxlmd;
-	struct device *dev = &cxlmd->dev;
-
-	cdev_device_del(&cxlmd->cdev, dev);
-	if (cxlmd->shutdown)
-		cxlmd->shutdown(cxlmd);
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
-		    const struct file_operations *fops,
-		    void (*shutdown)(struct cxl_memdev *cxlmd))
-{
-	struct cxl_memdev *cxlmd;
-	struct device *dev;
-	struct cdev *cdev;
-	int rc;
-
-	cxlmd = cxl_memdev_alloc(cxlm, fops);
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
-	cxlmd->shutdown = shutdown;
-	return cxlmd;
-
-err:
-	/*
-	 * The cdev was briefly live, shutdown any ioctl operations that
-	 * saw that state.
-	 */
-	if (shutdown)
-		shutdown(cxlmd);
-	put_device(dev);
-	return ERR_PTR(rc);
-}
-
 static int cxl_xfer_log(struct cxl_mem *cxlm, uuid_t *uuid, u32 size, u8 *out)
 {
 	u32 remaining = size;
@@ -1586,6 +1365,13 @@ static int cxl_mem_identify(struct cxl_mem *cxlm)
 	return 0;
 }
 
+static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
+{
+	down_write(&cxl_memdev_rwsem);
+	cxlmd->cxlm = NULL;
+	up_write(&cxl_memdev_rwsem);
+}
+
 static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_memdev *cxlmd;
-- 
2.32.0

