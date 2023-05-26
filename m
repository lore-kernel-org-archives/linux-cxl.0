Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10C11C7EE23
	for <linux-cxl@archiver.kernel.org>; Fri, 26 May 2023 04:07:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjEZEHa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 26 May 2023 00:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbjEZEH2 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 26 May 2023 00:07:28 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24275183
        for <linux-cxl@vger.kernel.org>; Thu, 25 May 2023 21:07:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 9A3F3101A19;
        Fri, 26 May 2023 04:07:26 +0000 (UTC)
Received: from pdx1-sub0-mail-a281.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 141B310157F;
        Fri, 26 May 2023 04:07:26 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1685074046; a=rsa-sha256;
        cv=none;
        b=3vl3X0iIurvZHVHP3GmQYWTfg3CJU1LKVwfyBO2OSRw5sZmRGPgJrZUr1f9YHLrPghhspt
        qAPN0rdfaSUuvpSVmSUo6PHwA8GuQMVmuUS8nf5fSw9GqKnFWTn+8q/0gXQZKzVOP8iJip
        /g75YwFxgt13fDcWpjs1mZIzRiMZlW9wUGXw1GElkDT5L6Nf0cNC60172IUp6s9xdni0Yr
        Yn8QDyGjYg+4S0Yy3tEXODAJ+E6fVxziNqUmjXsaFEX7z10xQiDs/M6fAQv6OubB51XO9S
        hH+82GF7I/g7HKP6cQ2Q0p8nKmsBuxGEtkNIyI2OO3lv0wyyM8C9Uj1ynKn/uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1685074046;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=vOnOye1HDT3dummA83nLeK3SCXz4EarHieWOzwkty7M=;
        b=NtgQE6t8ov7Y4sZGqimBX4BxBQoOY+DSQAA+rmwQCRckJwS4tuoGHa44CFFfuBuiUq6ryO
        4PAv9LwpZOtTddghTWh1OtHGXyu2cY3gHSOFxUHv7cjKcC3ubgpBpGuwIvcHevhfAJU+du
        GjGDw7JuC3SjAC83qdCZAzM4o+HCA0XGMrhZJX3o+/FkydTnrbW/dfVVWBBGt4sM9mKAYO
        nQmwWmsGj6bx7ITK+8QdhVLh7WRehR052au3NsnwRy5wdr3fgww4sFJwdiG/068rNIgTAQ
        pdypQqBwZXSgPOt296nus3xIFQHMTUxgxyNMyv4B9d5BUxi1c+35hk0CQsgZRA==
ARC-Authentication-Results: i=1;
        rspamd-7d4b855556-8m4kk;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Trade-Eyes: 1f54494379320c04_1685074046395_1891032754
X-MC-Loop-Signature: 1685074046394:3837721383
X-MC-Ingress-Time: 1685074046394
Received: from pdx1-sub0-mail-a281.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.109.138.46 (trex/6.8.1);
        Fri, 26 May 2023 04:07:26 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a281.dreamhost.com (Postfix) with ESMTPSA id 4QSBG52fqLz36;
        Thu, 25 May 2023 21:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1685074045;
        bh=vOnOye1HDT3dummA83nLeK3SCXz4EarHieWOzwkty7M=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=facGoaUJa8mVq4ilsaygtz15nn27xnQLXGzqt2dpHmz+cpy5aqWRK+gmHBYE7ZNsR
         3ypD8RQWytnfcvpArk6uP8zqolqb+v6p0F/HsnBrqNCZEoj3hJm/E/A2NaY0Tmlc6Y
         uaY0uyD/q5LounuGbEmOnxxSOBco/Rp9b5pNGoyw78mAxTQG5DgzkQKELE1Ids2JLy
         8i3xHjwYx04nzSmu+s0rJ8tmqkZvdT1KvjAJFTRRWbwXQYyqdXNoIQTlQnuW+VQs/o
         qg8h3liAMPAdwwKfzC1xuWUBZkiYj4gRJc3tSEYsH8ZqXi/lvZzvN1mBL530V4A95F
         eFIE1ffXujCpQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/6] cxl/mbox: Add sanitation handling machinery
Date:   Thu, 25 May 2023 20:33:40 -0700
Message-Id: <20230526033344.17167-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526033344.17167-1-dave@stgolabs.net>
References: <20230526033344.17167-1-dave@stgolabs.net>
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
check for 'sanitize_tmo' for uncommon poll scenarios. This flag
also serves for sanitation (the only user of async polling) to know
when to queue work or simply rely on irqs.

The irq case is much simpler as hardware will serialize/error
appropriately.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/memdev.c | 10 +++++
 drivers/cxl/cxlmem.h      | 10 +++++
 drivers/cxl/pci.c         | 83 +++++++++++++++++++++++++++++++++++++--
 3 files changed, 99 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 6e1d7d3610a2..02763e83545c 100644
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
+	if (cxlds->security.poll_tmo_secs != -1)
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
index 5329274b0076..02ec68f97de2 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -264,9 +264,18 @@ struct cxl_poison_state {
  * struct cxl_security_state - Device security state
  *
  * @state: state of last security operation
+ * @poll_tmo_secs: polling timeout
+ * @poll_dwork: polling work item
+ *
+ * Polling (sanitation) is only used when device mbox irqs are not
+ * supported. As such, @poll_tmo_secs == -1 indicates that polling
+ * is disabled. Otherwise, when enabled, @poll_tmo_secs is maxed
+ * at 15 minutes and serialized by the mbox_mutex.
  */
 struct cxl_security_state {
 	unsigned long state;
+	int poll_tmo_secs;
+	struct delayed_work poll_dwork;
 };
 
 /**
@@ -380,6 +389,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index a78e40e6d0e0..a0d93719ab18 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -115,16 +115,52 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
 
 static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 {
+	u64 reg;
+	u16 opcode;
 	struct cxl_dev_id *dev_id = id;
 	struct cxl_dev_state *cxlds = dev_id->cxlds;
 
-	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-	if (cxl_mbox_background_complete(cxlds))
-		rcuwait_wake_up(&cxlds->mbox_wait);
+	if (!cxl_mbox_background_complete(cxlds))
+		goto done;
 
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
+	} else {
+		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+		rcuwait_wake_up(&cxlds->mbox_wait);
+	}
+done:
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
@@ -185,6 +221,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
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
@@ -233,11 +279,34 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 	 */
 	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
 		u64 bg_status_reg;
-		int i, timeout = mbox_cmd->poll_interval_ms;
+		int i, timeout;
+
+		/*
+		 * Sanitation is a special case which monopolizes the device
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
@@ -268,6 +337,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		return 0; /* completed but caller must check return_code */
 	}
 
+success:
 	/* #7 */
 	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
 	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
@@ -376,10 +446,15 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
 		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
+		/* flag that irqs are enabled */
+		cxlds->security.poll_tmo_secs = -1;
 		return 0;
 	}
 
 mbox_poll:
+	cxlds->security.poll_tmo_secs = 0;
+	INIT_DELAYED_WORK(&cxlds->security.poll_dwork,
+			  cxl_mbox_sanitize_work);
 	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
-- 
2.40.1

