Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A266EC77B78
	for <linux-cxl@archiver.kernel.org>; Wed,  3 May 2023 15:30:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjECPaX (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 3 May 2023 11:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229889AbjECPaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 3 May 2023 11:30:23 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 038A35271
        for <linux-cxl@vger.kernel.org>; Wed,  3 May 2023 08:30:19 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 26B7F3E1A97;
        Wed,  3 May 2023 15:30:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9B8593E1A25;
        Wed,  3 May 2023 15:30:14 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1683127814; a=rsa-sha256;
        cv=none;
        b=j81KrkaCWkUWeq9nJkYbSJ7+BwnZTsqsLOAToaGXMz0CAbB6UxeCmZ0LB3/+AVaCKgs2tI
        L5TPi0iHHsH8kIrY9YJg683qh16PXpekS6P5u4qcWIPZMQLb8gU7lweeAww9owRGicUG1D
        Red/AkGwpa86CmNARID2EPdmATTmB/XE/e3l5AxlmqiQs8euP7EkiSY7V6lhUkqimdVWSO
        xIxwXS96DiCg/M7kJEkpTZmWvMcaIMtYRgmjb2+OZOan3wjSS143hgmpJP5Vdku49VEA9X
        PvosDa3HfdQyId/uW24vFq+5uaXJmtYlAKfGjKCPGWMBJb6R5dx0/9brK+tKWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1683127814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=MRSV0ZHPNY47j1yjVtCBRfBDmkK4HIe0qsw1K+wd6DE=;
        b=fGTGFn6lTjtCalBfH1tn8rDka7JpksQKq5yDppJG7Lx3ak3XTnWtW+tfZRNdL41y9wPE59
        2t2jMyaLk9nIWyvGqBwKMtryZefgYnr6lHi/G9EVeEBjs4LfrnGf/qEv98r6MteKzxB33D
        Bg+JxyUa8Lt235alihWMmdtF2+SjNcsNvWxsSMxmGC4lKq+IlASzi/CF0tPILqkXAoglEf
        A7srAmhFeOf/MCFpurWS0t8H+rEWV8ZPc+FKi6u+r7LnEw7VGRi98vm4HDo7Bl1Mr03igE
        2Kxp+aJzYTTvgwe8EtHyHwGAfFTFUk7JmokPst9FhqLkVKMM6Qr1jruOpQoBgg==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-hk64m;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Drop-Share: 16cb915715ccd2f9_1683127814970_1541072855
X-MC-Loop-Signature: 1683127814970:637207707
X-MC-Ingress-Time: 1683127814969
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.108 (trex/6.7.2);
        Wed, 03 May 2023 15:30:14 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4QBLVY6NlvzDF;
        Wed,  3 May 2023 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1683127814;
        bh=MRSV0ZHPNY47j1yjVtCBRfBDmkK4HIe0qsw1K+wd6DE=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=INP24OEFMCjCsS4RlkUNVKARVo/7Uwkv5XyEr2kqla23c5N0uHuj4tBUDa1S0c8jv
         Dm6YwTCO1XIRqfo8J7+SErrjsGz0n44KYRfBc05maevX5y0jwckxmUgGDOsrvbkXQT
         bT3QHfSk79T0rNfvAOn4wXftzO5iH3qwNz56ZYVCUjJbj8faGMuwncx6Rwksp8cnrF
         ws+Cx1Fam57UK8PTkY2ABHM58C7pajchboJce3a7F3FoiF9yJM7Xzof6OaLTDwG+hf
         34VvpZC+5+FJOnExAh57Dqiq8ej7Xans7geh7FTXOhFCkJ7guZMvAx9oVbdaqUgmvJ
         bm0Q73d0oVbxw==
Date:   Wed, 3 May 2023 07:57:56 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, alison.schofield@intel.com,
        vishal.l.verma@intel.com, Jonathan.Cameron@huawei.com,
        fan.ni@samsung.com, a.manzanares@samsung.com,
        linux-cxl@vger.kernel.org
Subject: [PATCH v2] cxl/mbox: Add background cmd handling machinery
Message-ID: <gtvozgdx2ak7tekc3heczk5g7gj3cwuoptez6tjmkecader4lo@7t2em7rclcxn>
References: <20230502171841.21317-1-dave@stgolabs.net>
 <20230502171841.21317-4-dave@stgolabs.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230502171841.21317-4-dave@stgolabs.net>
User-Agent: NeoMutt/20230407
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

Changes from v2:
- make the wait ret a long.
- pass correct param orders to the wait (cond and state were inversed).

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
index 8bdf58c0c643..10dc4a4fbb4a 100644
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
+		long ret;
+		u64 bg_status_reg;
+		int i, timeout = mbox_cmd->poll_interval;
+
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
+		for (i = 0; i < mbox_cmd->poll_count; i++) {
+			ret = rcuwait_wait_event_timeout(&cxlds->mbox_wait,
+					cxl_mbox_background_complete(cxlds),
+					TASK_INTERRUPTIBLE,
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
