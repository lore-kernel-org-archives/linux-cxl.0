Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20C9AE77347
	for <linux-cxl@archiver.kernel.org>; Fri, 29 Sep 2023 23:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229824AbjI2XJm (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 29 Sep 2023 19:09:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2XJl (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 29 Sep 2023 19:09:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB5A6E6
        for <linux-cxl@vger.kernel.org>; Fri, 29 Sep 2023 16:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696028979; x=1727564979;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8ICWG5Rj5Ygb9LNVot50TB/RHvKwqUo+oZjEDvT4vjc=;
  b=kswC5VFu1CFGg3KYhB/rfJ8fP0fbm7jdV6BeHElz/bW1rgn4Cuxdjrvb
   SlGjM4fKn+ssX+yxp6RTsiRn1h8Dcwz2mH7sxHD2jG4DFo8n+lhqexECn
   vbZ9fYzaSIWlhfRhHZrvdLcIdh2GDZjQHPMLM3wOOccyYwlxo/zXgOVYL
   9dSqcpAeRQ9pDQM5r3tWij2yd/jrZSWeeKbRrziLEacAAX2wO+3CnBLr9
   fmMz3SHXo89iyprO3cpgzS59pcxPq1F63ZezEcq0gbg2CF3VsUupCocsy
   PSQGmc+AMJw6PnAWWalBLTxGw13x81MHRwXLoTAkcx8aIykgbfi/LCT3r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381279664"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381279664"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743572035"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="743572035"
Received: from thamvo-mobl.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.56.79])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 16:09:39 -0700
Subject: [PATCH v2 2/4] cxl/pci: Cleanup 'sanitize' to always poll
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ira.weiny@intel.com
Date:   Fri, 29 Sep 2023 16:09:39 -0700
Message-ID: <169602897906.904193.9057960720070253436.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
References: <169602896768.904193.11292185494339980455.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

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
lock.

Lastly, some opportunistic replacements of
"queue_delayed_work(system_wq, ...)", which is just open coded
schedule_delayed_work(), are included.

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
index aa1b3dd9e64c..ac4e434b0806 100644
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
+	if ((cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) == 0)
+		return 0;
 
-		/* enable background command mbox irq support */
-		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
-		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
-		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+	msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+	irq = pci_irq_vector(to_pci_dev(cxlds->dev), msgnum);
+	if (irq < 0)
+		return 0;
 
+	if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
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
 

