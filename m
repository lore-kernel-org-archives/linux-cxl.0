Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8A24C7EE25
	for <linux-cxl@archiver.kernel.org>; Tue,  2 May 2023 17:51:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjEBRvF (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 2 May 2023 13:51:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBRvE (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 2 May 2023 13:51:04 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF7B10D9
        for <linux-cxl@vger.kernel.org>; Tue,  2 May 2023 10:50:59 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9D0056C18C6;
        Tue,  2 May 2023 17:50:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a310.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 164766C108C;
        Tue,  2 May 2023 17:50:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683049858; a=rsa-sha256;
        cv=none;
        b=ohzi0GN7dJjXAhIEig8IJDJloMLrhjvf/E+rr1oybfT3mLbJs3GiYxhwH1nYVncO+ngmMs
        uqfy5AOR8ZK7h0PZAK3ANSn3nvmMy7XNp/IU+M0uMY/LUfD89860dbTVjhzedYTBSTXiW2
        UBEymRRBHOs9NdbbTKtvFga+Fl7SSlLqWjAVUxzBkJwKrnwkgNEwn4eBMrGOre37It9PqM
        gi7glejhFaN8k0svKeL33AbyvpwNR+qkMD+QcNJm0cspaPUXhUkFhcZ+3ms3/yb6a5e9zz
        x5lN7z3naS9NyeG85cKIJq1ZD9uJPF/aFBij5JPWFL4/x1FCfUaJLRwZo93HhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683049858;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=OdtwqKwJd/xunKLmOjg+asgwoNr9P+NpkAM/p5L5FHY=;
        b=4rT3gbcReBhCYWIGycEmasYg84NAizVhQFDdNJQomIEZ0VpUjRdia/K8T/JW5UW5lYPdny
        oYUnwbmQtHlYXK7IK1CgpnkJHA0ca/cEEeNYw/VM7wCUjbPUEr5H23YrwbzCh4B5qSp59T
        eWxhCXl8OAxga/kaGb0RZmnX+djjchz5KLnJVbDQ8urGRDjkDOK8n1BYlBZCRR5EXY8AKI
        69tH2KHrjT99HlUQO3MeON8UJRqR2g1JT8a63OO/Ur1HrKMyxnllGRtuzaalSpTuxZFLB3
        5rSQHO/x3JQPVZxb75SOEDGDy0u/0tC04YkGsld+I5WZmjDai8Gn0D0i5esHMw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-v5ksg;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Bored-Callous: 11c2d4300c77fdb4_1683049858461_1907806902
X-MC-Loop-Signature: 1683049858461:4143956017
X-MC-Ingress-Time: 1683049858460
Received: from pdx1-sub0-mail-a310.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.114.243.54 (trex/6.7.2);
        Tue, 02 May 2023 17:50:58 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a310.dreamhost.com (Postfix) with ESMTPSA id 4Q9ngP2CFWz6K;
        Tue,  2 May 2023 10:50:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683049857;
        bh=OdtwqKwJd/xunKLmOjg+asgwoNr9P+NpkAM/p5L5FHY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=LP7nUfy4/fw4FUCSv0qR3IgkPE1XoVDqAa3tzu8HdKzhoPQbZMKgbqL4/c3c4tnZS
         dj3ixh7EVo04+oSHmpdRyk3icEqcXKPywtXrX8G7ySwu+Otuc28By2sJFkDLrEtWy9
         h11HGrh5axXR0ddnb61AuiZIjle8SGvYC/TTSDrILsf5/IAk3byyY6lWYMcDP5lMB+
         JeKl4UXUQFHV9P65q0RzjRV3oVAl4CwJLHAGcjLuOB8JUEArp1RTLvRlLJs4rJTEPf
         lyj1ID8UueWraDvPvUulQaiNIrVZIu1NLSMnHO3GZWtSOMkscW5IUd8JPILtL3ogka
         ieWC2m4Hrjc5Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/3] cxl/mbox: Add background cmd handling machinery
Date:   Tue,  2 May 2023 10:18:41 -0700
Message-Id: <20230502171841.21317-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502171841.21317-1-dave@stgolabs.net>
References: <20230502171841.21317-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This adds support for handling background operations, as defined in
the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
can run in the background asynchronously (to the hardware).

The driver will deal with such commands synchronously, blocking all
other incoming commands for a specified period of time, allowing
time-slicing the command such that the caller can send incremental
requests to avoid monopolizing the driver/device. This approach
makes the code simpler, where any out of sync (timeout) between the
driver and hardware is just disregarded as an invalid state until
the next successful submission.

On devices where mbox interrupts are supported, this will still use
a poller that will wakeup in the specified wait intervals. The irq
handler will simply awake the blocked cmd, which is also safe vs a
task that is either waking (timing out) or already awoken. Similarly
any irq setup error during the probing falls back to polling, thus
avoids unnecessarily erroring out.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |   3 +-
 drivers/cxl/cxl.h       |   7 +++
 drivers/cxl/cxlmem.h    |   7 +++
 drivers/cxl/pci.c       | 102 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 23b9ff920d7e..7345ed4118b0 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -220,7 +220,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
 	if (rc)
 		return rc;
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS)
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
+	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
 		return cxl_mbox_cmd_rc2errno(mbox_cmd);
 
 	if (!out_size)
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 044a92d9813e..72731a896f58 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -176,14 +176,21 @@ static inline int ways_to_eiw(unsigned int ways, u8 *eiw)
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK GENMASK(10, 7)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
 #define CXLDEV_MBOX_CTRL_OFFSET 0x04
 #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
+#define   CXLDEV_MBOX_CTRL_BG_CMD_IRQ BIT(2)
 #define CXLDEV_MBOX_CMD_OFFSET 0x08
 #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
 #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
 #define CXLDEV_MBOX_STATUS_OFFSET 0x10
+#define   CXLDEV_MBOX_STATUS_BG_CMD BIT(0)
 #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index db12b6313afb..d2f751d6583c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -5,6 +5,7 @@
 #include <uapi/linux/cxl_mem.h>
 #include <linux/cdev.h>
 #include <linux/uuid.h>
+#include <linux/rcuwait.h>
 #include "cxl.h"
 
 /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
@@ -108,6 +109,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ * @poll_count: (input)  Number of timeouts to attempt.
+ * @poll_interval: (input) Number of ms between mailbox background command
+ *                 polling intervals timeouts.
  * @return_code: (output) Error code returned from hardware.
  *
  * This is the primary mechanism used to send commands to the hardware.
@@ -123,6 +127,8 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+	int poll_count;
+	int poll_interval;
 	u16 return_code;
 };
 
@@ -329,6 +335,7 @@ struct cxl_dev_state {
 	struct cxl_event_state event;
 	struct cxl_poison_state poison;
 
+	struct rcuwait mbox_wait;
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8bdf58c0c643..5ca1423a4d92 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -51,6 +51,7 @@ static unsigned short mbox_ready_timeout = 60;
 module_param(mbox_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
 
+
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
 	const unsigned long start = jiffies;
@@ -84,6 +85,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
 			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
 
+static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
+{
+	u64 reg;
+
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
+}
+
+static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
+{
+	struct cxl_dev_state *cxlds = id;
+
+	/* spurious or raced with hw? */
+	if (unlikely(!cxl_mbox_background_complete(cxlds))) {
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		dev_warn(&pdev->dev,
+			 "Mailbox background operation IRQ but incomplete\n");
+		goto done;
+	}
+
+	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+	rcuwait_wake_up(&cxlds->mbox_wait);
+done:
+	return IRQ_HANDLED;
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -177,6 +205,57 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
+	/*
+	 * Handle the background command in a synchronous manner.
+	 *
+	 * All other mailbox commands will serialize/queue on the mbox_mutex,
+	 * which we currently hold. Furthermore this also guarantees that
+	 * cxl_mbox_background_complete() checks are safe amongst each other,
+	 * in that no new bg operation can occur in between.
+	 *
+	 * Background operations are timesliced in accordance with the nature
+	 * of the command. In the event of timeout, the mailbox state is
+	 * indeterminate until the next successful command submission and the
+	 * driver can get back in sync with the hardware state.
+	 */
+	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
+		int i, ret;
+		u64 bg_status_reg;
+		int timeout = mbox_cmd->poll_interval;
+
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
+		for (i = 0; i < mbox_cmd->poll_count; i++) {
+			ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
+					TASK_INTERRUPTIBLE,
+					cxl_mbox_background_complete(cxlds),
+					msecs_to_jiffies(timeout));
+			if (ret > 0)
+				break;
+			if (ret < 0) /* interrupted by a signal */
+				return ret;
+		}
+
+		if (!cxl_mbox_background_complete(cxlds)) {
+			u64 md_status =
+				readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+
+			cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
+				    "background timeout");
+			return -ETIMEDOUT;
+		}
+
+		bg_status_reg = readq(cxlds->regs.mbox +
+				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+		mbox_cmd->return_code =
+			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
+				  bg_status_reg);
+		dev_dbg(dev,
+			"Mailbox background operation (0x%04x) completed\n",
+			mbox_cmd->opcode);
+	}
+
 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
@@ -271,6 +350,29 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
 		cxlds->payload_size);
 
+	rcuwait_init(&cxlds->mbox_wait);
+	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
+		int irq, msgnum;
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
+		irq = pci_irq_vector(pdev, msgnum);
+		if (irq < 0)
+			goto mbox_poll;
+
+		if (devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
+				     IRQF_SHARED, NULL, cxlds))
+			goto mbox_poll;
+
+		/* only enable background cmd mbox irq support */
+		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
+		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+
+		return 0;
+	}
+
+mbox_poll:
+	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
 
-- 
2.40.1

