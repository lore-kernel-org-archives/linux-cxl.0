Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E1DC433DB
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 02:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A11EB619C1
	for <linux-cxl@archiver.kernel.org>; Tue, 30 Mar 2021 02:48:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbhC3CsV (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 29 Mar 2021 22:48:21 -0400
Received: from mga09.intel.com ([134.134.136.24]:41700 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhC3Cru (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Mon, 29 Mar 2021 22:47:50 -0400
IronPort-SDR: OktDNNihDnMiC/D9JJGKyUXk/jFpNxB7AMXj6VUTHHLo7FGtMFhvejkZYD71NfACzD1a/dOHMW
 0BtY5gPxnQEA==
X-IronPort-AV: E=McAfee;i="6000,8403,9938"; a="191770679"
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="191770679"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:47:50 -0700
IronPort-SDR: LT6Riyh3WxMBkTcK0pZPPykgNfVuCa8TxElLqTGgXvWXa6cJ4mQb5uYyshKO5kAcqf3sVo2eFj
 yM448i7eJUDw==
X-IronPort-AV: E=Sophos;i="5.81,289,1610438400"; 
   d="scan'208";a="444887209"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2021 19:47:49 -0700
Subject: [PATCH v2 2/4] cxl/mem: Fix synchronization mechanism for device
 removal vs ioctl operations
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jason Gunthorpe <jgg@nvidia.com>, linux-kernel@vger.kernel.org,
        vishal.l.verma@intel.com, ira.weiny@intel.com,
        alison.schofield@intel.com
Date:   Mon, 29 Mar 2021 19:47:49 -0700
Message-ID: <161707246948.2072157.2116502455691653472.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <161707245893.2072157.6743322596719518693.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Use srcu + device_is_registered() to achieve the same effect and add the
missing reference counting for cxlmd in cxl_memdev_open() and
cxl_memdev_release_file().

Fixes: b39cb1052a5c ("cxl/mem: Register CXL memX devices")
Reported-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/mem.c |   83 +++++++++++++++++++++++++++--------------------------
 1 file changed, 43 insertions(+), 40 deletions(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 30bf4f0f3c17..548d696f1f54 100644
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
+DEFINE_STATIC_SRCU(cxl_memdev_srcu);
 static struct dentry *cxl_debugfs;
 static bool cxl_raw_allow_all;
 
@@ -763,6 +760,14 @@ static int cxl_send_cmd(struct cxl_memdev *cxlmd,
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
+	/*
+	 * Stop servicing ioctls once the device has been unregistered
+	 * which indicates it has been disconnected from its cxlm driver
+	 * context
+	 */
+	if (!device_is_registered(&cxlmd->dev))
+		return -ENXIO;
+
 	switch (cmd) {
 	case CXL_MEM_QUERY_COMMANDS:
 		return cxl_query_cmd(cxlmd, (void __user *)arg);
@@ -776,26 +781,42 @@ static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 static long cxl_memdev_ioctl(struct file *file, unsigned int cmd,
 			     unsigned long arg)
 {
-	struct cxl_memdev *cxlmd;
-	struct inode *inode;
-	int rc = -ENOTTY;
+	struct cxl_memdev *cxlmd = file->private_data;
+	int rc, idx;
 
-	inode = file_inode(file);
-	cxlmd = container_of(inode->i_cdev, typeof(*cxlmd), cdev);
+	idx = srcu_read_lock(&cxl_memdev_srcu);
+	rc = __cxl_memdev_ioctl(cxlmd, cmd, arg);
+	srcu_read_unlock(&cxl_memdev_srcu, idx);
 
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
@@ -1049,7 +1070,6 @@ static void cxl_memdev_release(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
-	percpu_ref_exit(&cxlmd->ops_active);
 	ida_free(&cxl_memdev_ida, cxlmd->id);
 	kfree(cxlmd);
 }
@@ -1155,21 +1175,12 @@ static void cxlmdev_unregister(void *_cxlmd)
 	struct cxl_memdev *cxlmd = _cxlmd;
 	struct device *dev = &cxlmd->dev;
 
-	percpu_ref_kill(&cxlmd->ops_active);
 	cdev_device_del(&cxlmd->cdev, dev);
-	wait_for_completion(&cxlmd->ops_dead);
+	synchronize_srcu(&cxl_memdev_srcu);
 	cxlmd->cxlm = NULL;
 	put_device(dev);
 }
 
-static void cxlmdev_ops_active_release(struct percpu_ref *ref)
-{
-	struct cxl_memdev *cxlmd =
-		container_of(ref, typeof(*cxlmd), ops_active);
-
-	complete(&cxlmd->ops_dead);
-}
-
 static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 {
 	struct pci_dev *pdev = cxlm->pdev;
@@ -1181,17 +1192,12 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	cxlmd = kzalloc(sizeof(*cxlmd), GFP_KERNEL);
 	if (!cxlmd)
 		return -ENOMEM;
-	init_completion(&cxlmd->ops_dead);
 
 	/*
-	 * @cxlm is deallocated when the driver unbinds so operations
-	 * that are using it need to hold a live reference.
+	 * @cxlm is released when the driver unbinds so srcu and
+	 * device_is_registered() protect usage of this through @cxlmd.
 	 */
 	cxlmd->cxlm = cxlm;
-	rc = percpu_ref_init(&cxlmd->ops_active, cxlmdev_ops_active_release, 0,
-			     GFP_KERNEL);
-	if (rc)
-		goto err_ref;
 
 	rc = ida_alloc_range(&cxl_memdev_ida, 0, CXL_MEM_MAX_DEVS, GFP_KERNEL);
 	if (rc < 0)
@@ -1216,16 +1222,13 @@ static int cxl_mem_add_memdev(struct cxl_mem *cxlm)
 	return devm_add_action_or_reset(dev->parent, cxlmdev_unregister, cxlmd);
 
 err_add:
-	ida_free(&cxl_memdev_ida, cxlmd->id);
-err_id:
 	/*
-	 * Theoretically userspace could have already entered the fops,
-	 * so flush ops_active.
+	 * The cdev was briefly live, flush any ioctl operations that
+	 * saw that state.
 	 */
-	percpu_ref_kill(&cxlmd->ops_active);
-	wait_for_completion(&cxlmd->ops_dead);
-	percpu_ref_exit(&cxlmd->ops_active);
-err_ref:
+	synchronize_srcu(&cxl_memdev_srcu);
+	ida_free(&cxl_memdev_ida, cxlmd->id);
+err_id:
 	kfree(cxlmd);
 
 	return rc;

