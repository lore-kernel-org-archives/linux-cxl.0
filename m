Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33EEFC433F5
	for <linux-cxl@archiver.kernel.org>; Fri,  3 Dec 2021 19:29:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382867AbhLCTcb (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 3 Dec 2021 14:32:31 -0500
Received: from mga02.intel.com ([134.134.136.20]:15933 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1382878AbhLCTcb (ORCPT <rfc822;linux-cxl@vger.kernel.org>);
        Fri, 3 Dec 2021 14:32:31 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="224293264"
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="224293264"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:29:06 -0800
X-IronPort-AV: E=Sophos;i="5.87,284,1631602800"; 
   d="scan'208";a="460993967"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 11:29:06 -0800
Subject: [PATCH 2/2] cxl/pci: Defer mailbox status checks to command timeouts
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, Jonathan.Cameron@huawei.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com
Date:   Fri, 03 Dec 2021 11:29:06 -0800
Message-ID: <163855974678.1338601.8865645356209268622.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163855973642.1338601.12855868083437118567.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Device status can change without warning at any point in time. This
effectively means that no amount of status checking before a command is
submitted can guarantee that the device is not in an error condition
when the command is later submitted. The clearest signal that a device
is not able to process commands is if it fails to process commands.

With the above understanding in hand, update cxl_pci_setup_mailbox() to
validate the readiness of the mailbox once at the beginning of time, and
then use timeouts and busy sequencing errors as the only occasions to
report status.

Just as before, unless and until the driver gains a reset recovery path,
doorbell clearing failures by the device are fatal to mailbox
operations.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |  138 ++++++++++++++---------------------------------------
 1 file changed, 36 insertions(+), 102 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 519795432708..36f80437a11a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -72,14 +72,16 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
-static void cxl_pci_mbox_timeout(struct cxl_dev_state *cxlds,
-				 struct cxl_mbox_cmd *mbox_cmd)
-{
-	struct device *dev = cxlds->dev;
+#define report_status(dev, status, msg)                                        \
+	dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
+			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
+			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
-	dev_dbg(dev, "Mailbox command (opcode: %#x size: %zub) timed out\n",
-		mbox_cmd->opcode, mbox_cmd->size_in);
-}
+#define report_cmd_status(dev, cmd, status, msg)                               \
+	dev_err_ratelimited(dev, msg " (opcode: %#x), device state %s%s\n",    \
+			    (cmd)->opcode,                                     \
+			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
+			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
@@ -133,7 +135,11 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 
 	/* #1 */
 	if (cxl_doorbell_busy(cxlds)) {
-		dev_err_ratelimited(dev, "Mailbox re-busy after acquiring\n");
+		u64 md_status =
+			readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+		report_cmd_status(cxlds->dev, mbox_cmd, md_status,
+				  "mailbox queue busy");
 		return -EBUSY;
 	}
 
@@ -159,7 +165,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	/* #5 */
 	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
 	if (rc == -ETIMEDOUT) {
-		cxl_pci_mbox_timeout(cxlds, mbox_cmd);
+		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+		report_cmd_status(cxlds->dev, mbox_cmd, md_status,
+				  "mailbox timeout");
 		return rc;
 	}
 
@@ -197,98 +206,13 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	return 0;
 }
 
-/**
- * cxl_pci_mbox_get() - Acquire exclusive access to the mailbox.
- * @cxlds: The device state to gain access to.
- *
- * Context: Any context. Takes the mbox_mutex.
- * Return: 0 if exclusive access was acquired.
- */
-static int cxl_pci_mbox_get(struct cxl_dev_state *cxlds)
-{
-	struct device *dev = cxlds->dev;
-	u64 md_status;
-	int rc;
-
-	mutex_lock_io(&cxlds->mbox_mutex);
-
-	/*
-	 * XXX: There is some amount of ambiguity in the 2.0 version of the spec
-	 * around the mailbox interface ready (8.2.8.5.1.1).  The purpose of the
-	 * bit is to allow firmware running on the device to notify the driver
-	 * that it's ready to receive commands. It is unclear if the bit needs
-	 * to be read for each transaction mailbox, ie. the firmware can switch
-	 * it on and off as needed. Second, there is no defined timeout for
-	 * mailbox ready, like there is for the doorbell interface.
-	 *
-	 * Assumptions:
-	 * 1. The firmware might toggle the Mailbox Interface Ready bit, check
-	 *    it for every command.
-	 *
-	 * 2. If the doorbell is clear, the firmware should have first set the
-	 *    Mailbox Interface Ready bit. Therefore, waiting for the doorbell
-	 *    to be ready is sufficient.
-	 */
-	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
-	if (rc) {
-		dev_warn(dev, "Mailbox interface not ready\n");
-		goto out;
-	}
-
-	md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
-	if (!(md_status & CXLMDEV_MBOX_IF_READY && CXLMDEV_READY(md_status))) {
-		dev_err(dev, "mbox: reported doorbell ready, but not mbox ready\n");
-		rc = -EBUSY;
-		goto out;
-	}
-
-	/*
-	 * Hardware shouldn't allow a ready status but also have failure bits
-	 * set. Spit out an error, this should be a bug report
-	 */
-	rc = -EFAULT;
-	if (md_status & CXLMDEV_DEV_FATAL) {
-		dev_err(dev, "mbox: reported ready, but fatal\n");
-		goto out;
-	}
-	if (md_status & CXLMDEV_FW_HALT) {
-		dev_err(dev, "mbox: reported ready, but halted\n");
-		goto out;
-	}
-	if (CXLMDEV_RESET_NEEDED(md_status)) {
-		dev_err(dev, "mbox: reported ready, but reset needed\n");
-		goto out;
-	}
-
-	/* with lock held */
-	return 0;
-
-out:
-	mutex_unlock(&cxlds->mbox_mutex);
-	return rc;
-}
-
-/**
- * cxl_pci_mbox_put() - Release exclusive access to the mailbox.
- * @cxlds: The device state to communicate with.
- *
- * Context: Any context. Expects mbox_mutex to be held.
- */
-static void cxl_pci_mbox_put(struct cxl_dev_state *cxlds)
-{
-	mutex_unlock(&cxlds->mbox_mutex);
-}
-
 static int cxl_pci_mbox_send(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd)
 {
 	int rc;
 
-	rc = cxl_pci_mbox_get(cxlds);
-	if (rc)
-		return rc;
-
+	mutex_lock_io(&cxlds->mbox_mutex);
 	rc = __cxl_pci_mbox_send_cmd(cxlds, cmd);
-	cxl_pci_mbox_put(cxlds);
+	mutex_unlock(&cxlds->mbox_mutex);
 
 	return rc;
 }
@@ -309,12 +233,22 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	} while (!time_after(jiffies, timeout));
 
 	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
-		dev_err(cxlds->dev,
-			"timeout awaiting mailbox ready, device state:%s%s\n",
-			md_status & CXLMDEV_DEV_FATAL ? " fatal" : "",
-			md_status & CXLMDEV_FW_HALT ? " firmware-halt" : "");
-		return -EIO;
-        }
+		report_status(cxlds->dev, md_status,
+			      "timeout awaiting mailbox ready");
+		return -ETIMEDOUT;
+	}
+
+	/*
+	 * A command may be in flight from a previous driver instance,
+	 * think kexec, do one doorbell wait so that
+	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
+	 * source for future doorbell busy events.
+	 */
+	if (cxl_pci_mbox_wait_for_doorbell(cxlds) != 0) {
+		report_status(cxlds->dev, md_status,
+			      "timeout awaiting mailbox idle");
+		return -ETIMEDOUT;
+	}
 
 	cxlds->mbox_send = cxl_pci_mbox_send;
 	cxlds->payload_size =

