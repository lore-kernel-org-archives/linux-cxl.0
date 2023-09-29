Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD4AE77347
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:09:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjI2XJr (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:09:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjI2XJr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:09:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 283FEE6
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696028985; x=1727564985;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Nc5jQpp6R0sD2LAPV3rEK+Kfd6TmVd7I3i+IbEkCF20=;
  b=jaujVZvmLTbTO6V0yWcPodduLUnI3pEZ5A8xvq0YYQ7YK1xHSF4Ko8Bd
   Ka0h78C0xB9dYlwhTkTg54otsdeJ7FGZtZXf50YuEMnk/yziI6ldoD8Oo
   KquKZvUaE9ymv+fGuT1Y5oJh/s/2bAyMTGYw7Abiy2URA/ptK1ZmHjJNw
   QBKA36lSkxq6hxbjDiYAD757TD9fRUKIKFhTj9h8qOJeg6N6+BrJ7Evcp
   XCznOVHveDdAguf7cb9+DtnLDEU3am3vWXVxl1vJ3wk61/fuNSuVTVbLF
   HSUsc/PV7HplWX+T01hr1vPb5JAZ9vOZY9H+IkAoPQtCsI/mlR6MjXwEP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381279679"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381279679"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743572070"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743572070"
Received: from thamvo-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.56.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:44 -0700
Subject: [PATCH v2 3/4] cxl/pci: Fix sanitize notifier setup
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>, ira.weiny@intel.com
Date:   Fri, 29 Sep 2023 16:09:44 -0700
Message-ID: <169602898447.904193.4454973423100628922.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Fix a race condition between the mailbox-background command interrupt
firing and the security-state sysfs attribute being removed.

The race is difficult to see due to the awkward placement of the
sanitize-notifier setup code and the multiple places the teardown calls
are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().

Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
and let the cxl_memdev + irq be unregistered later in the flow.

This fix is also needed as a preparation fix for a memdev unregistration
crash.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |   42 ----------------------------------------
 drivers/cxl/pci.c         |   47 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 2a7a07f6d165..a950091e5640 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -556,20 +556,11 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
 
-static void cxl_memdev_security_shutdown(struct device *dev)
-{
-	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-
-	cancel_delayed_work_sync(&mds->security.poll_dwork);
-}
-
 static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	down_write(&cxl_memdev_rwsem);
-	cxl_memdev_security_shutdown(dev);
 	cxlmd->cxlds = NULL;
 	up_write(&cxl_memdev_rwsem);
 }
@@ -1001,35 +992,6 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
-static void put_sanitize(void *data)
-{
-	struct cxl_memdev_state *mds = data;
-
-	sysfs_put(mds->security.sanitize_node);
-}
-
-static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
-{
-	struct cxl_dev_state *cxlds = cxlmd->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	struct device *dev = &cxlmd->dev;
-	struct kernfs_node *sec;
-
-	sec = sysfs_get_dirent(dev->kobj.sd, "security");
-	if (!sec) {
-		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
-		return -ENODEV;
-	}
-	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
-	sysfs_put(sec);
-	if (!mds->security.sanitize_node) {
-		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
-		return -ENODEV;
-	}
-
-	return devm_add_action_or_reset(cxlds->dev, put_sanitize, mds);
- }
-
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
@@ -1058,10 +1020,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
-	rc = cxl_memdev_security_init(cxlmd);
-	if (rc)
-		goto err;
-
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index ac4e434b0806..b0023e479315 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -165,6 +165,49 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 	mutex_unlock(&mds->mbox_mutex);
 }
 
+static void cxl_sanitize_teardown_notifier(void *data)
+{
+	struct cxl_memdev_state *mds = data;
+	struct kernfs_node *state;
+
+	/*
+	 * Prevent new irq triggered invocations of the workqueue and
+	 * flush inflight invocations.
+	 */
+	mutex_lock(&mds->mbox_mutex);
+	state = mds->security.sanitize_node;
+	mds->security.sanitize_node = NULL;
+	mutex_unlock(&mds->mbox_mutex);
+
+	cancel_delayed_work_sync(&mds->security.poll_dwork);
+	sysfs_put(state);
+}
+
+static int cxl_sanitize_setup_notifier(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = cxlds->dev;
+	struct kernfs_node *sec;
+
+	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
+		return 0;
+
+	sec = sysfs_get_dirent(dev->kobj.sd, "security");
+	if (!sec) {
+		dev_err(dev, "sanitize notification setup failure\n");
+		return -ENOENT;
+	}
+	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
+	sysfs_put(sec);
+	if (!mds->security.sanitize_node) {
+		dev_err(dev, "sanitize notification setup failure\n");
+		return -ENOENT;
+	}
+
+	return devm_add_action_or_reset(dev, cxl_sanitize_teardown_notifier, mds);
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @mds: The memory device driver data
@@ -875,6 +918,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_sanitize_setup_notifier(cxlmd);
+	if (rc)
+		return rc;
+
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
 	for (i = 0; i < pmu_count; i++) {
 		struct cxl_pmu_regs pmu_regs;

