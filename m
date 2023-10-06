Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5FF6D19
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aK9vLfO4"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6714BE4
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577195; x=1728113195;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=c5jZ2PPbXGifXbQhbdT0FI+5T+XU7dzV7zgnMFdn5q0=;
  b=aK9vLfO4WH/SkZA5oXgMs31q0cDiN972Y3MkiarrSmd4+O7IiSG+RsUr
   ewhSUxBcDIJ/Qh9HB5fwdIVY3ZGbDgC7M5qnUnVI1m+07vTWnRIzpcbzZ
   YvErjGH9tmzsMYXMHcjPJQuZgA9ixJSSGrgFmEMOFsCzXuoofjo9wdxJd
   QXzD9Eqyd4elm3dHjv5eoSErogYx9TB4BQ5jC6c5oX9wcHeJjqn5K9Aiy
   1V1tWnltKj7DlJ7SwQg/6H3RynWBgTGygAAl/p/lGXFrMeFoJ418Lc7Zg
   UPH5THHYT03K2m/jKlsIO6f8zP9HJJC6rRgQEu991OBgzoBVir80gFrpp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="450192246"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="450192246"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="817923228"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="817923228"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:34 -0700
Subject: [PATCH v3 06/10] cxl/pci: Fix sanitize notifier setup
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, Davidlohr Bueso <dave@stgolabs.net>,
 Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>
Date: Fri, 06 Oct 2023 00:26:33 -0700
Message-ID: <169657719381.1491153.1571837747024067070.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
References: <169657715790.1491153.3612164287133860191.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fix a race condition between the mailbox-background command interrupt
firing and the security-state sysfs attribute being removed.

The race is difficult to see due to the awkward placement of the
sanitize-notifier setup code and the multiple places the teardown calls
are made, cxl_memdev_security_init() and cxl_memdev_security_shutdown().

Unify setup in one place, cxl_sanitize_setup_notifier(). Arrange for
the paired cxl_sanitize_teardown_notifier() to safely quiet the notifier
and let the cxl_memdev + irq be unregistered later in the flow.

Note: The special wrinkle of the sanitize notifier is that it interacts
with interrupts, which are enabled early in the flow, and it interacts
with memdev sysfs which is not initialized until late in the flow. Hence
why this setup routine takes an @cxlmd argument, and not just @mds.

This fix is also needed as a preparation fix for a memdev unregistration
crash.

Reported-by: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Closes: http://lore.kernel.org/r/20230929100316.00004546@Huawei.com
Cc: Dave Jiang <dave.jiang@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Fixes: 0c36b6ad436a ("cxl/mbox: Add sanitization handling machinery")
Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |   86 +++++++++++++++++++++++----------------------
 drivers/cxl/cxlmem.h      |    2 +
 drivers/cxl/pci.c         |    4 ++
 3 files changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 63353d990374..4c2e24a1a89c 100644
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
@@ -991,35 +982,6 @@ static const struct file_operations cxl_memdev_fops = {
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
-}
-
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds)
 {
@@ -1049,10 +1011,6 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 	if (rc)
 		goto err;
 
-	rc = cxl_memdev_security_init(cxlmd);
-	if (rc)
-		goto err;
-
 	rc = devm_add_action_or_reset(host, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
@@ -1069,6 +1027,50 @@ struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 }
 EXPORT_SYMBOL_NS_GPL(devm_cxl_add_memdev, CXL);
 
+static void sanitize_teardown_notifier(void *data)
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
+int devm_cxl_sanitize_setup_notifier(struct device *host,
+				     struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct kernfs_node *sec;
+
+	if (!test_bit(CXL_SEC_ENABLED_SANITIZE, mds->security.enabled_cmds))
+		return 0;
+
+	/*
+	 * Note, the expectation is that @cxlmd would have failed to be
+	 * created if these sysfs_get_dirent calls fail.
+	 */
+	sec = sysfs_get_dirent(cxlmd->dev.kobj.sd, "security");
+	if (!sec)
+		return -ENOENT;
+	mds->security.sanitize_node = sysfs_get_dirent(sec, "state");
+	sysfs_put(sec);
+	if (!mds->security.sanitize_node)
+		return -ENOENT;
+
+	return devm_add_action_or_reset(host, sanitize_teardown_notifier, mds);
+}
+EXPORT_SYMBOL_NS_GPL(devm_cxl_sanitize_setup_notifier, CXL);
+
 __init int cxl_memdev_init(void)
 {
 	dev_t devt;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index fdb2c8dd98d0..fbdee1d63717 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -86,6 +86,8 @@ static inline bool is_cxl_endpoint(struct cxl_port *port)
 
 struct cxl_memdev *devm_cxl_add_memdev(struct device *host,
 				       struct cxl_dev_state *cxlds);
+int devm_cxl_sanitize_setup_notifier(struct device *host,
+				     struct cxl_memdev *cxlmd);
 struct cxl_memdev_state;
 int devm_cxl_setup_fw_upload(struct device *host, struct cxl_memdev_state *mds);
 int devm_cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7c117eb62750..9955871e9ec1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -875,6 +875,10 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
+	if (rc)
+		return rc;
+
 	pmu_count = cxl_count_regblock(pdev, CXL_REGLOC_RBI_PMU);
 	for (i = 0; i < pmu_count; i++) {
 		struct cxl_pmu_regs pmu_regs;

