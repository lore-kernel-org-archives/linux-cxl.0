Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DC62C88CB7
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235905AbjFLSpd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbjFLSpb (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:31 -0400
Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC3EE73
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:28 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id EA0AA101CA6;
        Mon, 12 Jun 2023 18:45:24 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 6843D101D52;
        Mon, 12 Jun 2023 18:45:24 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595524; a=rsa-sha256;
        cv=none;
        b=mRo0zQLg2Bg9B/ZPD3d5nlENWzq8ty3jvOaFbyqDFDUL42sCFQNK+keb87Q3Ud9BUeW1ef
        Q/WmaQ3Cn8bnxn7iI88XfmNjeFR4OOtmzfIcmJIVJtJdwUCWucL9EmUNSZhrS+/oTu5iHw
        roPNWHwjGjmcge8q+6Exrz1i64gyGHjH9UM01/ph/1W9UBLfPpVwee/olI8zaGJC8ZY87G
        Qt7COVwgmC5wP7yPWCZ66ghwVVpUN/vI4AmKEFIru5kOeRZAw/vrHYaIafw+EsoG+KWXkc
        Y+PairanoHEjDzcLkNZVguPzxVvxOitDW1x0/mw9BfAmB9X1IB8lFpC4qQSiWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595524;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=eBD1Co068xhnB0vmLO6xcn0kgLtwJxPxxxxwf2m906k=;
        b=bs05gforqirMwsnZvfS9p1zozPu7VG7uLxNn6PDy5hPczTOZ5hi/aN57Y1NiZ1FRyCCNJS
        gZFnJ709vPqFIZQ5INiew7te/crltKl7QFHIukgH3icRaffr5DAhRutIlGUtb2RTWCjQvO
        Guo6GrYwtR0Wazbuc2/p6dBiC68NmgmvYHH2k8Oxn1gxt1JpJ3MXeyqK3DdLU8O2y2fF+X
        tR0BGQcUY4QjJ6GtRF+/XAj2n9eS70Oey4KmtRhisTgBknZLOGd4HlRh1cijGq60BhGnMj
        QnspArf3L+6PZSAwU50+iecCxnnEHjicwtOC2JwfNfa0bbrdzdl4Lw+wX3eKPg==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-szjxp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wipe-Trade: 156dfcc139e59b83_1686595524770_655619332
X-MC-Loop-Signature: 1686595524769:1410291216
X-MC-Ingress-Time: 1686595524769
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.2 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:24 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xH5YYfzRV;
        Mon, 12 Jun 2023 11:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595524;
        bh=eBD1Co068xhnB0vmLO6xcn0kgLtwJxPxxxxwf2m906k=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=mp40jON/jhv6rW04U4MvFscMDupZSvFkKawSGdRfL+nqtwF0II+7pCz0v1KswnRgv
         a74hTmEw32/oknBy3Btt5u2Kc6GtRxL9Ar/2EVot10uz7djBKNBs0Kx6BFB1dKuVFz
         KNeQlmk4eMroSmgQBDAjeT4OTgVShUlUW/LpBHqIts0MIckZ8TTpc7Ep3nkdR7TqAQ
         4pXNwiDaYl04+P7Ib+CRJ9ckY5CHSKHblDX6oOnSo36f62ySlz4UH+DYcQhMXdtFf6
         4fBU9M20p1dY2Mw8z8QDqDu5h5mVJFnOwPVuAIYDpiM/4PXn99KpbR/F8BWRIL6cNZ
         QXsrIovH0mgwA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Date:   Mon, 12 Jun 2023 11:10:34 -0700
Message-ID: <20230612181038.14421-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Sanitation is by definition a device-monopolizing operation, and thus
the timeslicing rules for other background commands do not apply.
As such handle this special case asynchronously and return immediately.
Subsequent changes will allow completion to be pollable from userspace
via a sysfs file interface.

For devices that don't support interrupts for notifying background
command completion, self-poll with the caveat that the poller can
be out of sync with the ready hardware, and therefore care must be
taken to not allow any new commands to go through until the poller
sees the hw completion. The poller takes the mbox_mutex to stabilize
the flagging, minimizing any runtime overhead in the send path to
check for 'sanitize_tmo' for uncommon poll scenarios.

The irq case is much simpler as hardware will serialize/error
appropriately.

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/memdev.c | 10 +++++
 drivers/cxl/cxlmem.h      |  7 ++++
 drivers/cxl/pci.c         | 77 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1bbb7e39fc93..834f418b6bcb 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -460,11 +460,21 @@ void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cm
 }
 EXPORT_SYMBOL_NS_GPL(clear_exclusive_cxl_commands, CXL);
 
+static void cxl_memdev_security_shutdown(struct device *dev)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+
+	if (cxlds->security.poll)
+		cancel_delayed_work_sync(&cxlds->security.poll_dwork);
+}
+
 static void cxl_memdev_shutdown(struct device *dev)
 {
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 
 	down_write(&cxl_memdev_rwsem);
+	cxl_memdev_security_shutdown(dev);
 	cxlmd->cxlds = NULL;
 	up_write(&cxl_memdev_rwsem);
 }
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 091f1200736b..3a9df1044144 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -264,9 +264,15 @@ struct cxl_poison_state {
  * struct cxl_security_state - Device security state
  *
  * @state: state of last security operation
+ * @poll: polling for sanitation is enabled, device has no mbox irq support
+ * @poll_tmo_secs: polling timeout
+ * @poll_dwork: polling work item
  */
 struct cxl_security_state {
 	unsigned long state;
+	bool poll;
+	int poll_tmo_secs;
+	struct delayed_work poll_dwork;
 };
 
 /**
@@ -379,6 +385,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 4b2575502f49..c92eab55a5a7 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -115,18 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
 
 static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 {
+	u64 reg;
+	u16 opcode;
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 
 	if (!cxl_mbox_background_complete(cxlds))
 		return IRQ_NONE;
 
-	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-	rcuwait_wake_up(&cxlds->mbox_wait);
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
+	} else {
+		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+		rcuwait_wake_up(&cxlds->mbox_wait);
+	}
 
 	return IRQ_HANDLED;
 }
 
+/*
+ * Sanitation operation polling mode.
+ */
+static void cxl_mbox_sanitize_work(struct work_struct *work)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = container_of(work,
+			     struct cxl_dev_state, security.poll_dwork.work);
+
+	mutex_lock(&cxlds->mbox_mutex);
+	if (cxl_mbox_background_complete(cxlds)) {
+		cxlds->security.poll_tmo_secs = 0;
+		put_device(cxlds->dev);
+
+		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
+	} else {
+		int timeout = cxlds->security.poll_tmo_secs + 10;
+
+		cxlds->security.poll_tmo_secs = min(15 * 60, timeout);
+		queue_delayed_work(system_wq, &cxlds->security.poll_dwork,
+				   timeout * HZ);
+	}
+	mutex_unlock(&cxlds->mbox_mutex);
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -187,6 +221,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		return -EBUSY;
 	}
 
+	/*
+	 * With sanitize polling, hardware might be done and the poller still
+	 * not be in sync. Ensure no new command comes in until so. Keep the
+	 * hardware semantics and only allow device health status.
+	 */
+	if (unlikely(cxlds->security.poll_tmo_secs > 0)) {
+		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
+			return -EBUSY;
+	}
+
 	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
 			     mbox_cmd->opcode);
 	if (mbox_cmd->size_in) {
@@ -235,11 +279,34 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	 */
 	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
 		u64 bg_status_reg;
-		int i, timeout = mbox_cmd->poll_interval_ms;
+		int i, timeout;
+
+		/*
++		 * Sanitation is a special case which monopolizes the device
+		 * and cannot be timesliced. Handle asynchronously instead,
+		 * and allow userspace to poll(2) for completion.
+		 */
+		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
+			if (cxlds->security.poll_tmo_secs != -1) {
+				/* hold the device throughout */
+				get_device(cxlds->dev);
+
+				/* give first timeout a second */
+				timeout = 1;
+				cxlds->security.poll_tmo_secs = timeout;
+				queue_delayed_work(system_wq,
+						   &cxlds->security.poll_dwork,
+						   timeout * HZ);
+			}
+
+			dev_dbg(dev, "Sanitation operation started\n");
+			goto success;
+		}
 
 		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
 			mbox_cmd->opcode);
 
+		timeout = mbox_cmd->poll_interval_ms;
 		for (i = 0; i < mbox_cmd->poll_count; i++) {
 			if (rcuwait_wait_event_timeout(&cxlds->mbox_wait,
 				       cxl_mbox_background_complete(cxlds),
@@ -270,6 +337,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		return 0; /* completed but caller must check return_code */
 	}
 
+success:
 	/* #7 */
 	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
 	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
@@ -382,6 +450,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	}
 
 mbox_poll:
+	cxlds->security.poll = true;
+	INIT_DELAYED_WORK(&cxlds->security.poll_dwork, cxl_mbox_sanitize_work);
+
 	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
-- 
2.41.0

