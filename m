Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5F063CC
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 07:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="U0npxT4t"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF6EE4
	for <linux-cxl@vger.kernel.org>; Fri,  6 Oct 2023 00:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696577170; x=1728113170;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8kvHwC+c6S61F3o2c58tYl95gq7aTQuRF2LyQEx6EBA=;
  b=U0npxT4tMfNgT9ngAy2MknAxHXw8fug5KM9pBT0kqrqfKmG3xCLT4WHf
   2LJlFJAbblpb4g3JKINEUivc5I4AsRdW4Xn79E+eMKXtbicD5ynB4Dj5U
   DDEiSMEK9AzXfBlYF4vRLdra3BGFT3FJ4Uq6ki2TRHekfKgxrG6GoQ+0a
   DOKM+QYCy80InCM3Kp3NztK94XU5Ub/op+/46FZ3UGf/WGoTrMtdNi56V
   Xhf3+QIZrg16H6oUD0z9xm+7QUT7q4NfprQQssgAIkHZgUD711O8wivfT
   q0PoFbX/rGyE5dojhIxtiAUPcVtx33CBwoHobivZLEi7H/4YRFxLS45JU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="2297883"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="2297883"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755760364"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755760364"
Received: from wbleichn-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.212.147.24])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 00:26:10 -0700
Subject: [PATCH v3 02/10] cxl/pci: Cleanup 'sanitize' to always poll
From: Dan Williams <dan.j.williams@intel.com>
To: linux-cxl@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Ira Weiny <ira.weiny@intel.com>
Date: Fri, 06 Oct 2023 00:26:10 -0700
Message-ID: <169657717034.1491153.300696666588880104.stgit@dwillia2-xfh.jf.intel.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

In preparation for fixing the init/teardown of the 'sanitize' workqueue
and sysfs notification mechanism, arrange for cxl_mbox_sanitize_work()
to be the single location where the sysfs attribute is notified. With
that change there is no distinction between polled mode and interrupt
mode. All the interrupt does is accelerate the polling interval.

The change to check for "mds->security.sanitize_node" under the lock is
there to ensure that the interrupt, the work routine and the
setup/teardown code can all have a consistent view of the registered
notifier and the workqueue state. I.e. the expectation is that the
interrupt is live past the point that the sanitize sysfs attribute is
published, and it may race teardown, so it must be consulted under a
lock. Given that new locking requirement, cxl_pci_mbox_irq() is moved
from hard to thread irq context.

Lastly, some opportunistic replacements of
"queue_delayed_work(system_wq, ...)", which is just open coded
schedule_delayed_work(), are included.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    3 +-
 drivers/cxl/cxlmem.h      |    2 --
 drivers/cxl/pci.c         |   60 +++++++++++++++++++--------------------------
 3 files changed, 26 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..2a7a07f6d165 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -561,8 +561,7 @@ static void cxl_memdev_security_shutdown(struct device *dev)
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
 
-	if (mds->security.poll)
-		cancel_delayed_work_sync(&mds->security.poll_dwork);
+	cancel_delayed_work_sync(&mds->security.poll_dwork);
 }
 
 static void cxl_memdev_shutdown(struct device *dev)
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 706f8a6d1ef4..55f00ad17a77 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -360,7 +360,6 @@ struct cxl_fw_state {
  *
  * @state: state of last security operation
  * @enabled_cmds: All security commands enabled in the CEL
- * @poll: polling for sanitization is enabled, device has no mbox irq support
  * @poll_tmo_secs: polling timeout
  * @poll_dwork: polling work item
  * @sanitize_node: sanitation sysfs file to notify
@@ -368,7 +367,6 @@ struct cxl_fw_state {
 struct cxl_security_state {
 	unsigned long state;
 	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
-	bool poll;
 	int poll_tmo_secs;
 	struct delayed_work poll_dwork;
 	struct kernfs_node *sanitize_node;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index aa1b3dd9e64c..49d9b2ef5c5c 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -128,10 +128,10 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		mutex_lock(&mds->mbox_mutex);
 		if (mds->security.sanitize_node)
-			sysfs_notify_dirent(mds->security.sanitize_node);
-
-		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
+			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
+		mutex_unlock(&mds->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
 		rcuwait_wake_up(&mds->mbox_wait);
@@ -160,8 +160,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		int timeout = mds->security.poll_tmo_secs + 10;
 
 		mds->security.poll_tmo_secs = min(15 * 60, timeout);
-		queue_delayed_work(system_wq, &mds->security.poll_dwork,
-				   timeout * HZ);
+		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
 	}
 	mutex_unlock(&mds->mbox_mutex);
 }
@@ -293,15 +292,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 * and allow userspace to poll(2) for completion.
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (mds->security.poll) {
-				/* give first timeout a second */
-				timeout = 1;
-				mds->security.poll_tmo_secs = timeout;
-				queue_delayed_work(system_wq,
-						   &mds->security.poll_dwork,
-						   timeout * HZ);
-			}
-
+			/* give first timeout a second */
+			timeout = 1;
+			mds->security.poll_tmo_secs = timeout;
+			schedule_delayed_work(&mds->security.poll_dwork,
+					      timeout * HZ);
 			dev_dbg(dev, "Sanitization operation started\n");
 			goto success;
 		}
@@ -384,7 +379,9 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	struct device *dev = cxlds->dev;
 	unsigned long timeout;
+	int irq, msgnum;
 	u64 md_status;
+	u32 ctrl;
 
 	timeout = jiffies + mbox_ready_timeout * HZ;
 	do {
@@ -432,33 +429,26 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
 
 	rcuwait_init(&mds->mbox_wait);
+	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
 
-	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
-		u32 ctrl;
-		int irq, msgnum;
-		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
-
-		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
-		irq = pci_irq_vector(pdev, msgnum);
-		if (irq < 0)
-			goto mbox_poll;
-
-		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
-			goto mbox_poll;
+	/* background command interrupts are optional */
+	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
+		return 0;
 
-		/* enable background command mbox irq support */
-		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
-		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
-		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
+	if (irq < 0)
+		return 0;
 
+	if (cxl_request_irq(cxlds, irq, NULL, cxl_pci_mbox_irq))
 		return 0;
-	}
 
-mbox_poll:
-	mds->security.poll = true;
-	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
+	dev_dbg(cxlds->dev, "Mailbox interrupts enabled\n");
+	/* enable background command mbox irq support */
+	ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+	ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
+	writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
-	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
 

