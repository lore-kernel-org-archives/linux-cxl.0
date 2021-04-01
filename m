Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9B23C433ED
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEA5161001
	for <linux-cxl@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236753AbhDAR6h (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:59020 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236893AbhDARzk (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Thu, 1 Apr 2021 13:55:40 -0400
IronPort-SDR: U1sJuOYSwqkoVr5A2b6V0KElHdsztjkDeQNLzO7rN5Whm30jy8/bvgdjxdZcwjlPkhk6KKiOFR
 72UiJQsUtcgg==
X-IronPort-AV: E=McAfee;i="6000,8403,9941"; a="191734627"
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="191734627"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:22 -0700
IronPort-SDR: sElXlFcU6PLxT1vSpePXLl46lI7T8lRNPYIX4uYZJ11nwEkx9CM1dqrgkUZEBD6pdPW00Vim9U
 vJKXHmn155kQ==
X-IronPort-AV: E=Sophos;i="5.81,296,1610438400"; 
   d="scan'208";a="446110675"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2021 07:33:19 -0700
Subject: [PATCH v4 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>,
        linux-kernel@vger.kernel.org, vishal.l.verma@intel.com,
        ira.weiny@intel.com, alison.schofield@intel.com
Date:   Thu, 01 Apr 2021 07:33:19 -0700
Message-ID: <161728759948.2474381.17481500816783671817.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161728758895.2474381.12683589190335430004.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The percpu_ref to gate whether cxl_memdev_ioctl() is free to use the
driver context (@cxlm) to issue I/O is overkill, implemented incorrectly
(missing a device reference before accessing the percpu_ref), and the
complexities of shutting down a percpu_ref contributed to a bug in the
error unwind in cxl_mem_add_memdev() (missing put_device() to be fixed
separately).

Use an rwsem to explicitly synchronize the usage of cxlmd->cxlm, and add
the missing reference counting for cxlmd in cxl_memdev_open() and
cxl_memdev_release_file().

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   97 +++++++++++++++++++++++++++--------------------------
 1 file changed, 50 insertions(+), 47 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 30bf4f0f3c17..c77d375fad95 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -96,21 +96,18 @@ struct mbox_cmd {
  * @dev: driver core device object
  * @cdev: char dev core object for ioctl operations
  * @cxlm: pointer to the parent device driver data
- * @ops_active: active user of @cxlm in ops handlers
- * @ops_dead: completion when all @cxlm ops users have exited
  * @id: id number of this memdev instance.
  */
 struct cxl_memdev {
 	struct device dev;
 	struct cdev cdev;
 	struct cxl_mem *cxlm;
-	struct percpu_ref ops_active;
-	struct completion ops_dead;
 	int id;
 };
 
 static int cxl_mem_major;
 static DEFINE_IDA(cxl_memdev_ida);
+static DECLARE_RWSEM(cxl_memdev_rwsem);
 static struct dentry *cxl_debugfs;
 static bool cxl_raw_allow_all;
 
@@ -776,26 +773,43 @@ static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
-	struct cxl_memdev *cxlmd;
-	struct inode *inode;
-	int rc = -ENOTTY;
+	struct cxl_memdev *cxlmd = file->private_data;
+	int rc = -ENXIO;
 
-	inode = file_inode(file);
-	cxlmd = container_of(inode->i_cdev, typeof(*cxlmd), cdev);
+	down_read(&cxl_memdev_rwsem);
+	if (cxlmd->cxlm)
+		rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
+	up_read(&cxl_memdev_rwsem);
 
-	if (!percpu_ref_tryget_live(&cxlmd->ops_active))
-		return -ENXIO;
+	return rc;
+}
 
-	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
+static int cxl_memdev_open(struct inode *inode, struct file *file)
+{
+	struct cxl_memdev *cxlmd =
+		container_of(inode->i_cdev, typeof(*cxlmd), cdev);
 
-	percpu_ref_put(&cxlmd->ops_active);
+	get_device(&cxlmd->dev);
+	file->private_data = cxlmd;
 
-	return rc;
+	return 0;
+}
+
+static int cxl_memdev_release_file(struct inode *inode, struct file *file)
+{
+	struct cxl_memdev *cxlmd =
+		container_of(inode->i_cdev, typeof(*cxlmd), cdev);
+
+	put_device(&cxlmd->dev);
+
+	return 0;
 }
 
 static const struct file_operations cxl_memdev_fops = {
 	.owner = THIS_MODULE,
 	.unlocked_ioctl = cxl_memdev_ioctl,
+	.open = cxl_memdev_open,
+	.release = cxl_memdev_release_file,
 	.compat_ioctl = compat_ptr_ioctl,
 	.llseek = noop_llseek,
 };
@@ -1049,7 +1063,6 @@ static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
-	percpu_ref_exit(&cxlmd->ops_active);
 	ida_free(&cxl_memdev_ida, cxlmd->id);
 	kfree(cxlmd);
 }
@@ -1150,24 +1163,21 @@ static const struct device_type cxl_memdev_type = {
 	.groups = cxl_memdev_attribute_groups,
 };
 
-static void cxlmdev_unregister(void *_cxlmd)
+static void cxl_memdev_shutdown(struct cxl_memdev *cxlmd)
 {
-	struct cxl_memdev *cxlmd = _cxlmd;
-	struct device *dev = &cxlmd->dev;
-
-	percpu_ref_kill(&cxlmd->ops_active);
-	cdev_device_del(&cxlmd->cdev, dev);
-	wait_for_completion(&cxlmd->ops_dead);
+	down_write(&cxl_memdev_rwsem);
 	cxlmd->cxlm = NULL;
-	put_device(dev);
+	up_write(&cxl_memdev_rwsem);
 }
 
-static void cxlmdev_ops_active_release(struct percpu_ref *ref)
+static void cxl_memdev_unregister(void *_cxlmd)
 {
-	struct cxl_memdev *cxlmd =
-		container_of(ref, typeof(*cxlmd), ops_active);
+	struct cxl_memdev *cxlmd = _cxlmd;
+	struct device *dev = &cxlmd->dev;
 
-	complete(&cxlmd->ops_dead);
+	cdev_device_del(&cxlmd->cdev, dev);
+	cxl_memdev_shutdown(cxlmd);
+	put_device(dev);
 }
 
 static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
@@ -1181,17 +1191,6 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
 	if (!cxlmd)
 		return -ENOMEM;
-	init_completion(&cxlmd->ops_dead);
-
-	/*
-	 * @cxlm is deallocated when the driver unbinds so operations
-	 * that are using it need to hold a live reference.
-	 */
-	cxlmd->cxlm = cxlm;
-	rc = percpu_ref_init(&cxlmd->ops_active, cxlmdev_ops_active_release, 0,
-			     GFP_KERNEL);
-	if (rc)
-		goto err_ref;
 
 	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
 	if (rc < 0)
@@ -1209,23 +1208,27 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	cdev = &cxlmd->cdev;
 	cdev_init(cdev, &cxl_memdev_fops);
 
+	/*
+	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
+	 * needed as this is ordered with cdev_add() publishing the device.
+	 */
+	cxlmd->cxlm = cxlm;
+
 	rc = cdev_device_add(cdev, dev);
 	if (rc)
 		goto err_add;
 
-	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
+	return devm_add_action_or_reset(dev->parent, cxl_memdev_unregister,
+					cxlmd);
 
 err_add:
-	ida_free(&cxl_memdev_ida, cxlmd->id);
-err_id:
 	/*
-	 * Theoretically userspace could have already entered the fops,
-	 * so flush ops_active.
+	 * The cdev was briefly live, shutdown any ioctl operations that
+	 * saw that state.
 	 */
-	percpu_ref_kill(&cxlmd->ops_active);
-	wait_for_completion(&cxlmd->ops_dead);
-	percpu_ref_exit(&cxlmd->ops_active);
-err_ref:
+	cxl_memdev_shutdown(cxlmd);
+	ida_free(&cxl_memdev_ida, cxlmd->id);
+err_id:
 	kfree(cxlmd);
 
 	return rc;

