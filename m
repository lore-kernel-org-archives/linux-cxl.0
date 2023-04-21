Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58975C77B75
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjDUJzp (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbjDUJzo (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:44 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E8FA27E
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:37 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id C7AF66418CF;
        Fri, 21 Apr 2023 09:55:36 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4BB49641639;
        Fri, 21 Apr 2023 09:55:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070936; a=rsa-sha256;
        cv=none;
        b=W+nHAS7yzkxdqAFiF4jYdrsgEDPbYPslL+ORUXG26gKCtUFssoocGBf5BN6kkTjVLe/NeU
        pwZkHNkkME8LSnT2Xr+pxjyEUz5pusMX3Xf/qV+Gi0qwtZ1FZECZsvK234gR3SGW6rUSV6
        nD7TKXdSPuo23eihOXwbBn1mClBU1oLJ5KFQCDIxNG2FPyJoRzFJN5Hnv4+1WhIpfFNtt+
        8e1LyYO53IzNP5fSIKLKCxeCkDFfIcQVdjbMmy/tQ8fQtqWgDCqU8LqwVQHKIDTc5tKYDb
        7gCn9QNbjf1c2Jp+KdyfLdeP09rCgM9m3041/huUyA1rcXnpGWe1dpoAU0Kimg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070936;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=bTyajGi9OpkKPti+WzY/KQlEAmD3TJJttUX754l1rso=;
        b=4FF3gYEivdEEu9TF7u+u86S587H2oxubgaiCMVYwC0wHtYnF56tWoGRqdGRpBkESBjJK8M
        FHVgLGwyGwdWNNi1LQDeZ6j0JTR6N9L8rHaUjkVOF0TrkczZx9Y8nax9svU6/YZ8M1Rpbp
        wVUcRZ8Cv+WO3taR2t5OPb900y2+E0o5VdS2Jiyma4DEJJ+3PqJggYbgNFY/NfWdUVLUOO
        KbFkJGLYCML3fZND3lEAK/iUc/lEdFxL64H0Ml0R7XJG3ClL3/nuCg6uuDJFoYoZC35m0N
        1GkZHo8ne3PMP2R/hdQ2cVWoffjUNdXb5UCn2LOVs5gpPNNcXw0Jjkj9je6Byw==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-7mggl;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illustrious-Slimy: 5f6e4e805bde2b34_1682070936638_443159484
X-MC-Loop-Signature: 1682070936638:4265306344
X-MC-Ingress-Time: 1682070936638
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.36 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:36 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qdz26kMz2F;
        Fri, 21 Apr 2023 02:55:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070935;
        bh=bTyajGi9OpkKPti+WzY/KQlEAmD3TJJttUX754l1rso=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=UlTjT+C52O50i73Aln2OQLcAMYkFx7/LdVhIuq464uNeircVjExosRXQk1PL2VwHG
         bWfJyMCseC923zQ7EU5xspPyujFK7e9RT7rHNJyEUieO2Ss0UGBzWOI36knhICdq6W
         AFof6U4UypPwX8w6e0iI4Gjw1baqvkKwIVI0tE4l9UKftTqvNih3kiew9RvLb+TXPD
         P1QpicoYUVdG6WvMQMvvEA/uwZHEXwbIbO1LjTS9MXbuDO4Pbj47vnxULt1d16O4al
         sONgH2++u6jf2kQKgyIMD67IsUgNqRgDzqgqAKam2Cx+pKnX0Sb21ubKU8Am7RCsc7
         oq8YNNcd6WKcA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/7] cxl/mbox: Add background cmd handling machinery
Date:   Fri, 21 Apr 2023 02:23:16 -0700
Message-Id: <20230421092321.12741-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
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
handler will simply awake a blocked cmd, which is also safe vs a
task that is either waking (timing out) or already awoken. Similarly
any irq setup error during the probing falls back to polling, thus
avoids unnecessarily erroring out.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |   3 +-
 drivers/cxl/cxl.h       |   7 +++
 drivers/cxl/cxlmem.h    |   5 ++
 drivers/cxl/pci.c       | 104 +++++++++++++++++++++++++++++++++++++++-
 4 files changed, 117 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6198637cb0bb..cde7270c6037 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -180,7 +180,8 @@ int cxl_internal_send_cmd(struct cxl_dev_state *cxlds,
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
index 090acebba4fa..8c3302fc7738 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -108,6 +108,9 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ * @poll_count: (input)  Number of timeouts to attempt.
+ * @poll_interval: (input) Number of ms between mailbox background command
+ *                 polling intervals timeouts.
  * @return_code: (output) Error code returned from hardware.
  *
  * This is the primary mechanism used to send commands to the hardware.
@@ -123,6 +126,8 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+	int poll_count;
+	int poll_interval;
 	u16 return_code;
 };
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 39b829a29f6c..aa1bb74a52a1 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -51,6 +51,7 @@
 static unsigned short mbox_ready_timeout = 60;
 module_param(mbox_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
+static DECLARE_WAIT_QUEUE_HEAD(mbox_wait);
 
 static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
 {
@@ -85,6 +86,33 @@ static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
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
+	if (!cxl_mbox_background_complete(cxlds)) {
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		dev_warn(&pdev->dev,
+			 "Mailbox background operation IRQ but incomplete\n");
+		goto done;
+	}
+
+	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+	wake_up(&mbox_wait);
+done:
+	return IRQ_HANDLED;
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -178,7 +206,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
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
+		u64 bg_status_reg;
+		int i;
+
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
+		for (i = 0; i < mbox_cmd->poll_count; i++) {
+			int ret = wait_event_interruptible_timeout(
+				mbox_wait, cxl_mbox_background_complete(cxlds),
+				msecs_to_jiffies(mbox_cmd->poll_interval));
+			if (ret > 0)
+				break;
+
+			/* interrupted by a signal */
+			if (ret < 0)
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
+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS &&
+	    mbox_cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND) {
 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0; /* completed but caller must check return_code */
@@ -224,6 +304,7 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	unsigned long timeout;
 	u64 md_status;
+	int rc, irq;
 
 	timeout = jiffies + mbox_ready_timeout * HZ;
 	do {
@@ -272,6 +353,27 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
 		cxlds->payload_size);
 
+	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
+		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+
+		irq = pci_irq_vector(pdev,
+			     FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap));
+		if (irq < 0)
+			goto mbox_poll;
+
+		rc = devm_request_irq(cxlds->dev, irq, cxl_pci_mbox_irq,
+				      IRQF_SHARED, "mailbox", cxlds);
+		if (rc)
+			goto mbox_poll;
+
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
2.40.0

