Received: from cornsilk.maple.relay.mailchannels.net (cornsilk.maple.relay.mailchannels.net [23.83.214.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD7462EFD81
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 20:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750191474; cv=pass; b=c4H0nrq2t1x6n17d8J4RDmExLcC76UHVmaayEqY6Qcv3W/yNluAkV9+1S0K3SKWT8NqhiX3F+UwuLone7qVnaR3KQ4GRJDPMkBtcYpWiUxkJEzWHaofufSRvCgPC8bxCnLTAR78ZNa236Lm0Q/G6OvF3LRI1gdIsaBGfi/Kuo8Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750191474; c=relaxed/simple;
	bh=a6oeRPuF/y5cqd+kPlvVPOe64PDkt2G20Jq07VH0ato=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UwM9fvVAoBgNyJ/Q/vF+6VDdm6pOOqiGosbLz8fFRQLXDBGbKlK2GRvMD49E4ewJJDvPQxP2oglzvIOACOEtKXmKUfvJfEEw6Ct6goWS9b/wsb6Slx3h4O9Z6+9epo8oc7buy9HUGXl/u8ankYslKsU/uK2Y7bCMQyHsmV8Gf14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=KKztIAzG; arc=pass smtp.client-ip=23.83.214.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="KKztIAzG"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id D0E178438EE;
	Tue, 17 Jun 2025 19:38:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-6.trex.outbound.svc.cluster.local [100.97.19.248])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 35AE5844B06;
	Tue, 17 Jun 2025 19:38:03 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189083; a=rsa-sha256;
	cv=none;
	b=9EobW4dWSxS4+E119f1uo39cAwrEMqnyNbvDuatwNLjUEOW9dH4bQzkAymrZNoz1Y+FUTo
	S5WA9frAKaQfW4Tehn+7zDYcI0sXAXQs8o5XE55Lv5BjqCpCzkfB40mUFm9Ar14qObMtB2
	Qt30ejK8pyg18lu35EFyJE7l5Xq7IMlTVvVsTfYesF3ad+69E+NRTAAu+nBJjsSMjUIs4/
	YvK53viqbN3QW2DGF9upZrIFfwMOkMAbFlHWZ1B4NghKTDRzxWtpGnkQVoO4VjPgYjlpGn
	DShqMlfIBYe1rQlGwyivkJaGd/5Dw8aARSbwu+YWHBCEN/z3jdRAZgzzv7EZtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189083;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=2VE6rLghgXpM7xKUR8pyVnxsot1hXuUvfeC7h8K2dsM=;
	b=1noEH/jubP2iHhsAs7Yfhek9U73nrh9aKNRwxtWXJbVnw1Ga/+Fvdy2aqbUQngbsGfJDo8
	e/v2dvMF7ZAuCW29lTgK9Q0vKrzhOCDz7r8VkwVgTm6hG22pPrqYucv9CiDmvuXYiFbu/i
	h26f1+iAEo6ZRsON2fEceHivzNtwLdwBZWDFiq/Qp4fBEGQoeSQyTIVxoU3e/R7/y/o2UR
	rGwNEgiJDhN0fT9L4CxTrD84ZwM+PKnBY39DZY/GO1qK4K8h69AiY9EkMHc1uSoHDelGtw
	gfX9y4gaHv5uq9iHxVYU2sUozwSmmBGA+ApCuvqjBEk6fdg1ipXjsCn+uTvupg==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-4xfms;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shelf-Arithmetic: 4d5a83af194fd562_1750189083635_1868781498
X-MC-Loop-Signature: 1750189083635:3008672761
X-MC-Ingress-Time: 1750189083633
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.19.248 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:03 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGK6gFQzQc;
	Tue, 17 Jun 2025 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189082;
	bh=2VE6rLghgXpM7xKUR8pyVnxsot1hXuUvfeC7h8K2dsM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=KKztIAzG/LYUzjAj3cFp/5PAUROhC8zQ4ahpjfExQ34l/L/2V9qdalj1d3FqJ77rr
	 4vhClelXfNmHYsv/OPhOiauTpPtHCQj2AE36gD+fn3KyR2Fh6/uQSJHPNOlev4usUn
	 fYvpsB1lTQ/Axre1bTasH+aPbf52mqvKbfHdE+2sIrQaZ3GduxD0RXbLz/bOoktDPu
	 nYX1q0G/rxYVof6VQa4jk3kqqYfXzNy09HY1h4wBXfZfZLCdt+QgtvKQLeqgem6ERI
	 +8SmbFRmTikIVzO9A4wRkt1pX+izi2jHJ35HWvLl48lVMWNa3YS/23VNMlycWTWMIO
	 +gxplsG7fIM3w==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: dan.j.williams@intel.com,
	jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	jgroves@micron.com,
	ravis.opensrc@micron.com,
	fan.ni@samsung.com,
	anisa.su@samsung.com,
	a.manzanares@samsung.com,
	linux-cxl@vger.kernel.org,
	dave@stgolabs.net
Subject: [PATCH 3/7] cxl/pci: Lockless background synchronous polling
Date: Tue, 17 Jun 2025 12:36:07 -0700
Message-Id: <20250617193611.564668-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250617193611.564668-1-dave@stgolabs.net>
References: <20250617193611.564668-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For timesliced background commands we rely on holding the mbox_mutex
throughout the duration of the operation. This causes other incoming
commands to queue up behind, and interleaving executions while the
background command is timesliced by the user.

However, in order to support the mbox request cancel background
operation command, the lock will need to be available to actually
perform the request. Semantically this allows other commands to
many times be at the mercy of hardware returning the respective error.
Potentially users would be exposed to changes in the form of errors
instead of commands taking longer to run - but this is not foreseen
as a problem.

In order to not loose sync with the hardware, introduce a mailbox
atomic that blocks any other incoming bg operations while the driver
is still polling (synchronously) on the current one.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |   1 +
 drivers/cxl/pci.c       | 112 ++++++++++++++++++++++++----------------
 include/cxl/mailbox.h   |   2 +
 3 files changed, 70 insertions(+), 45 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 4ea02f7a5b6b..aa1b04d8a78e 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1515,6 +1515,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 
 	cxl_mbox->host = host;
 	mutex_init(&cxl_mbox->mbox_mutex);
+	atomic_set(&cxl_mbox->poll_bgop, 0);
 	rcuwait_init(&cxl_mbox->mbox_wait);
 
 	return 0;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0d8f3605dc3f..3e6c231e9a8b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -312,23 +312,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
-	/*
-	 * Handle the background command in a synchronous manner.
-	 *
-	 * All other mailbox commands will serialize/queue on the mbox_mutex,
-	 * which we currently hold. Furthermore this also guarantees that
-	 * cxl_mbox_background_complete() checks are safe amongst each other,
-	 * in that no new bg operation can occur in between.
-	 *
-	 * Background operations are timesliced in accordance with the nature
-	 * of the command. In the event of timeout, the mailbox state is
-	 * indeterminate until the next successful command submission and the
-	 * driver can get back in sync with the hardware state.
-	 */
 	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
-		u64 bg_status_reg;
-		int i, timeout;
-
 		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
 			mbox_cmd->opcode);
 
@@ -338,6 +322,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE ||
 		    mbox_cmd->opcode == CXL_MBOX_OP_ACTIVATE_FW) {
+			int timeout;
+
 			if (mds->bg.opcode)
 				return -EBUSY;
 
@@ -347,41 +333,17 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 			mds->bg.opcode = mbox_cmd->opcode;
 			schedule_delayed_work(&mds->bg.poll_dwork,
 					      timeout * HZ);
-			goto success;
+		} else {
+			/* pairs with release/acquire semantics */
+			WARN_ON_ONCE(atomic_xchg(&cxl_mbox->poll_bgop,
+						 mbox_cmd->opcode));
 		}
-
-		timeout = mbox_cmd->poll_interval_ms;
-		for (i = 0; i < mbox_cmd->poll_count; i++) {
-			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
-						       cxl_mbox_background_complete(cxlds),
-						       TASK_UNINTERRUPTIBLE,
-						       msecs_to_jiffies(timeout)) > 0)
-				break;
-		}
-
-		if (!cxl_mbox_background_complete(cxlds)) {
-			dev_err(dev, "timeout waiting for background (%d ms)\n",
-				timeout * mbox_cmd->poll_count);
-			return -ETIMEDOUT;
-		}
-
-		bg_status_reg = readq(cxlds->regs.mbox +
-				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
-		mbox_cmd->return_code =
-			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
-				  bg_status_reg);
-		dev_dbg(dev,
-			"Mailbox background operation (0x%04x) completed\n",
-			mbox_cmd->opcode);
-	}
-
-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
+	} else if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
 		dev_dbg(dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0; /* completed but caller must check return_code */
 	}
 
-success:
 	/* #7 */
 	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
 	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
@@ -411,11 +373,71 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 			     struct cxl_mbox_cmd *cmd)
 {
 	int rc;
+	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
+	struct device *dev = cxlds->dev;
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
 	mutex_lock(&cxl_mbox->mbox_mutex);
+	/*
+	 * Ensure cxl_mbox_background_complete() checks are safe amongst
+	 * each other: no new bg operation can occur in between while polling.
+	 */
+	if (cxl_is_background_cmd(mds, cmd->opcode)) {
+		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
+			mutex_unlock(&cxl_mbox->mbox_mutex);
+			return -EBUSY;
+		}
+	}
+
 	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
 	mutex_unlock(&cxl_mbox->mbox_mutex);
 
+	if (cmd->return_code != CXL_MBOX_CMD_RC_BACKGROUND)
+		return rc;
+
+	/*
+	 * Handle the background command in a synchronous manner. Background
+	 * operations are timesliced in accordance with the nature of the
+	 * command.
+	 */
+	if (cmd->opcode != CXL_MBOX_OP_SANITIZE &&
+	    cmd->opcode != CXL_MBOX_OP_ACTIVATE_FW) {
+		int i, timeout;
+		u64 bg_status_reg;
+
+		timeout = cmd->poll_interval_ms;
+		for (i = 0; i < cmd->poll_count; i++) {
+			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
+				       cxl_mbox_background_complete(cxlds),
+				       TASK_UNINTERRUPTIBLE,
+				       msecs_to_jiffies(timeout)) > 0)
+				break;
+		}
+
+		/*
+		 * In the event of timeout, the mailbox state is indeterminate
+		 * until the next successful command submission and the driver
+		 * can get back in sync with the hardware state.
+		 */
+		if (!cxl_mbox_background_complete(cxlds)) {
+			dev_err(dev, "timeout waiting for background (%d ms)\n",
+				timeout * cmd->poll_count);
+			rc = -ETIMEDOUT;
+			goto done;
+		}
+
+		bg_status_reg = readq(cxlds->regs.mbox +
+				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+		cmd->return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
+					     bg_status_reg);
+		dev_dbg(dev,
+			"Mailbox background operation (0x%04x) completed\n",
+			cmd->opcode);
+done:
+		/* ensure clearing poll_bop is the last operation */
+		atomic_set_release(&cxl_mbox->poll_bgop, 0);
+	}
+
 	return rc;
 }
 
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index c4e99e2e3a9d..f3c60158bfca 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -51,6 +51,7 @@ struct cxl_mbox_cmd {
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
+ * @poll_bgop: current background operation being polled on
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  * @feat_cap: Features capability
  */
@@ -61,6 +62,7 @@ struct cxl_mailbox {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
+	atomic_t poll_bgop;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 	enum cxl_features_capability feat_cap;
 };
-- 
2.39.5

