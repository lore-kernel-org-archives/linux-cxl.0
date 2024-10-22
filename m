Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C9F13E88C;
	Tue, 22 Oct 2024 03:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567781; cv=pass; b=UKivaN4sSbaSEPQ592DZrorFhgz4rU3/jgBSDN8BZPFGePcmkPK8oBXKZMKkc2YCuTmVAGKJk4NHyrFyIaxyMJdfDRZNN2XzCorxbWi1fwvVWmYnanxQ4bXwyM7nIUpugZfskqas6CN0tOwObVbxSrZtzExp6b7LIY3kxxP7dmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567781; c=relaxed/simple;
	bh=4eQKBL4lamxSiFpROmuWhyo4tQG6isTNpCHTeBH9oLU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n6wSkZT8ev9kWLdGJQW17n/iBrguayw/LHTndRoXtfzL9YtJlEdusbJLg7KHOBurg2t1Jys77cbRcyZr36pRMYcAKgJBEAjvru/4IlhwzLducw0C8IjJVKzWTTaGOkMmUr+8fa2EBA7sZ8BR+vkip02hb1btHyWtdNoWALAjqC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=DPFsl2Ma; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="DPFsl2Ma"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 934CAC2F31;
	Tue, 22 Oct 2024 03:21:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (100-98-255-245.trex-nlb.outbound.svc.cluster.local [100.98.255.245])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 14394C2AEA;
	Tue, 22 Oct 2024 03:21:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729567275; a=rsa-sha256;
	cv=none;
	b=KUdo40p3jNHxG6YFZ1+IEY/PeL4nytf3nxEqk46oEXE0ytk1uxyeMWs7XL9Esj0QLZCSM5
	WwB+IFyVXSQ7gUSih5RcD+Fl8bY2YoYZALlumNZbBgnrJIOGvScTRCyKyPs9+6MHcm83bo
	tukGliaR6keK6Op40qQDj2QC4xL6BtQfB5urRiA5QTVNMGzFGi0AX/wp7tVl9B4g08ZXMf
	Yzt0KbX6awZcUBNP7E14dUAjL7EVpbQIFkVNi+q32jQIt9aeHqvn2bLxBuSpyQlNpVFTf1
	tjIJ7kGWzAB33vewvM5dW65MKJFj1BPpzz2PFHhj+igbNpkWuLSxnZkoOvLANQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729567275;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=CCk2wco2OeAmTATlemc+OtbF0EDfORUEfM7CkmZnhEQ=;
	b=Ni3wAT6zV866cSi6uttkPTiWddFwM/b1y2t8TMbD5VfWOVy4bj7osdsDsIuT2DCcQVYQew
	EXweWBpXNKhUWvIRpbRkhk0ZkBC+DvsJSRXYMW3o8tQipGvMILozr6FXHHlMMN7bwWnBWi
	T3I64mwi3q6BnlDNT/RGu9mzsbLbvqWdPbLsJis+oxD9+ba2TWl8wQWkUMdsMPR8Wuvln3
	BfAwyGjPGOWVVRnJf9alSiSDtDrQHTdF6o91tv1357zGAM5L68iaJujFEjJRYpUgvpLekK
	wIyoKMbR8uuLTewnfy0Tnia88vAATV6WV/az5S2O6rJ3N6HjgA4+zPvVqvztCw==
ARC-Authentication-Results: i=1;
	rspamd-75d86777c9-lf85w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Grain: 0f648e5473dd4b9e_1729567275425_761448160
X-MC-Loop-Signature: 1729567275425:4151781414
X-MC-Ingress-Time: 1729567275424
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.98.255.245 (trex/7.0.2);
	Tue, 22 Oct 2024 03:21:15 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4XXcs56S12z1p;
	Mon, 21 Oct 2024 20:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729567274;
	bh=CCk2wco2OeAmTATlemc+OtbF0EDfORUEfM7CkmZnhEQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=DPFsl2MacD34Rlsa/zY/EIA8ah8KLL4cd7PqWbwn5uRWvtqHWxBFtq7whRX8ktVEy
	 hyRDxWkqz/ljk1crsD1bsLOsbj8Ow2doAKyXsLYC4kwFfVc9LtK/hRd5JwCO8qJB64
	 Jg6kkSATiArDhS23csbOjG7GQrRtHyp6QA6CvYDBRwionoF95Er2GsRIZXkNhlPrLR
	 NtV1UbzuNYMfCzllR9GbwvI+VHrrAe1kyYiC2RyXT0eCY/fSbFXfXc/MiZLftUQ0v0
	 W36BBIn4P+I5gBpUZhcx0O6iy7ztWoH7Uq7piMbqhP44bikeoQuSe81PRNTm32u0rQ
	 uxUieHO01KLtQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dan.j.williams@intel.com,
	dave.jiang@intel.com
Cc: jonathan.cameron@huawei.com,
	alison.schofield@intel.com,
	vishal.l.verma@intel.com,
	ira.weiny@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	sthanneeru.opensrc@micron.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	Ravis.OpenSrc@micron.com,
	sthanneeru@micron.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cxl/pci: lockless background synchronous polling
Date: Mon, 21 Oct 2024 20:18:07 -0700
Message-ID: <20241022031809.242591-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.46.1
In-Reply-To: <20241022031809.242591-1-dave@stgolabs.net>
References: <20241022031809.242591-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For non-sanitize background commands we rely on holding the mbox_mutex
throughout the duration of the operation. This causes other incoming
commands to queue up behind, and interleaving executions while the
background command is timesliced by the user.

However, in order to support the mbox request cancel background
operation command, the lock will need to be available to actually
perform the request. Semantically this allows other commands to
many times be at the mercy of hardware returning the respective error.
Potentially users would be exposed to changes in the form of errors
instead of commands taking longer to run - but this is not forseen
as a problem.

In order to not loose sync with the hardware, introduce a mailbox
atomic that blocks any other incoming bg operations while the driver
is still polling (synchronously) on the current one.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |   1 +
 drivers/cxl/cxlmem.h    |  13 +++++
 drivers/cxl/pci.c       | 114 +++++++++++++++++++++++-----------------
 include/cxl/mailbox.h   |   2 +
 4 files changed, 82 insertions(+), 48 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5175138c4fb7..9af3cd16d23d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1429,6 +1429,7 @@ int cxl_mailbox_init(struct cxl_mailbox *cxl_mbox, struct device *host)
 
 	cxl_mbox->host = host;
 	mutex_init(&cxl_mbox->mbox_mutex);
+	atomic_set(&cxl_mbox->poll_bgop, 0);
 	rcuwait_init(&cxl_mbox->mbox_wait);
 
 	return 0;
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2a25d1957ddb..b933fb73ef8a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -557,6 +557,19 @@ enum cxl_opcode {
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
+static inline bool cxl_is_background_cmd(u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_TRANSFER_FW:
+	case CXL_MBOX_OP_ACTIVATE_FW:
+	case CXL_MBOX_OP_SCAN_MEDIA:
+	case CXL_MBOX_OP_SANITIZE:
+		return true;
+	default:
+		return false;
+	}
+}
+
 #define DEFINE_CXL_CEL_UUID                                                    \
 	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
 		  0x3b, 0x3f, 0x17)
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 188412d45e0d..f2378604669b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -278,29 +278,15 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
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
 		/*
 		 * Sanitization is a special case which monopolizes the device
 		 * and cannot be timesliced. Handle asynchronously instead,
 		 * and allow userspace to poll(2) for completion.
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
+			int timeout;
+
 			if (mds->security.sanitize_active)
 				return -EBUSY;
 
@@ -311,44 +297,19 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 			schedule_delayed_work(&mds->security.poll_dwork,
 					      timeout * HZ);
 			dev_dbg(dev, "Sanitization operation started\n");
-			goto success;
-		}
-
-		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
-			mbox_cmd->opcode);
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
+		} else {
+			/* pairs with release/acquire semantics */
+			WARN_ON_ONCE(atomic_xchg(&cxl_mbox->poll_bgop,
+						 mbox_cmd->opcode));
+			dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+				mbox_cmd->opcode);
 		}
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
@@ -378,11 +339,68 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 			     struct cxl_mbox_cmd *cmd)
 {
 	int rc;
+	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
+	struct device *dev = cxlds->dev;
 
 	mutex_lock_io(&cxl_mbox->mbox_mutex);
+	/*
+	 * Ensure cxl_mbox_background_complete() checks are safe amongst
+	 * each other: no new bg operation can occur in between while polling.
+	 */
+	if (cxl_is_background_cmd(cmd->opcode)) {
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
+	if (cmd->opcode != CXL_MBOX_OP_SANITIZE) {
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
+		atomic_set_release(&cxl_mbox->poll_bgop, 0);
+	}
+
 	return rc;
 }
 
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index bacd111e75f1..23282a3c44f1 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -13,6 +13,7 @@ struct cxl_mbox_cmd;
  *                (CXL 3.1 8.2.8.4.3 Mailbox Capabilities Register)
  * @mbox_mutex: mutex protects device mailbox and firmware
  * @mbox_wait: rcuwait for mailbox
+ * @poll_bgop: current background operation being polled on
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  */
 struct cxl_mailbox {
@@ -20,6 +21,7 @@ struct cxl_mailbox {
 	size_t payload_size;
 	struct mutex mbox_mutex; /* lock to protect mailbox context */
 	struct rcuwait mbox_wait;
+	atomic_t poll_bgop;
 	int (*mbox_send)(struct cxl_mailbox *cxl_mbox, struct cxl_mbox_cmd *cmd);
 };
 
-- 
2.46.1

