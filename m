Received: from bumble.maple.relay.mailchannels.net (bumble.maple.relay.mailchannels.net [23.83.214.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0397C198A22;
	Tue, 22 Oct 2024 03:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.214.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729567286; cv=pass; b=RjmqcvFFTiByopCU2yUtMXIcz7S/6vhSAStEGpHkKL6s0zVr698RHaWhB9J7Mp5wuyPJvDfNfVvAWYV8UoDYDWypuWuyORXGCFFkIFFTITwT1qK6Qf1tfk4pa6GPWOceCoDJIxha21ySDadlSAkloKArq23mH3WGMIBFmgKiGNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729567286; c=relaxed/simple;
	bh=bo68H4faO1bWI30btJNP3hJMZkRXPCXCvTz/JcusREQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WPmKlZh6OqCEuZNAy54QYtuDDvFb122VtsNLVBoDq2jPAArAV1TbIdPDtHPbFfyvKVSF6uuQJg4opjnezhHhfTUooMSV9cJ0MkUsLwvTrE3dVXyIt1VvPdPH3A0cqkYgsAMUnSRfChUuGazOc90v24tLMPIvOHN7JjbiTqDMevg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=JRymzZpZ; arc=pass smtp.client-ip=23.83.214.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="JRymzZpZ"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F216D3220B1;
	Tue, 22 Oct 2024 03:21:16 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (trex-9.trex.outbound.svc.cluster.local [100.99.180.193])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 53225321FD8;
	Tue, 22 Oct 2024 03:21:16 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729567276; a=rsa-sha256;
	cv=none;
	b=x5MYd7IflK0gA1sN+/fI2dIpgpV9FWonZdfVgrfbEJ0ZH2L66cJmqjCrqMGfvi0VDKrtCP
	Uv/nzf0HX7gdFXcrCmJkhll79bLe+yVPLrA01eNx0JxAdAhpfQv+4TGNTsUOxEAzr81c32
	kA/LFE8c5U7A+Ox3h3Hc9RE19TaYB19Wvvi0Se0CHp6S6wDtu8PZwuWe1Hrsx4EwGCxq7v
	nb7NSeXKPc1KnXt3D6i8M//WqBu7t8ozZTcqdVF2Uk3fz6YxJYi+Y8ggPIIpiuDR+1QAcK
	cou/W+oSSp5/h0hS0lCoL9jN4jPacoRInCuPV3PV47UXt460GIh43iXqd/DyZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729567276;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=xWuXI1STFWVB6JAkyrFpy2OWqAiJ2oDnJCL4Dlt8unk=;
	b=OFoaxKFyvrq+ReC9+/o3l5qBF+Tb4fSyoTT2jpx5th1pDwIdP0NfCUleeK1LJPnzhe4FxH
	9fn04CGD5IasN5+XrORrTF1jHTZBIm3YKPUTVcygblsWwIqURBipnZOco2K3Xi+4pWYZqc
	r1xwtSihXbJpXfTpc2O0yep+DkwoEjEMcXyXkbBOwKXPAznXy0tdoUaRsE+/M2CtY4x539
	z1BXZxARhBIQCdTbTIgBOgVltk78Tdw+Rup9SqM3CUqWn4pBSywa1rTOETt42jep6ZbXgj
	RD6NeLjesdTFY/FB2q46ArPBIRsjWTxDlyKgi1eRIS6mAuqZ8CkK+vX9uA1dVA==
ARC-Authentication-Results: i=1;
	rspamd-75d86777c9-m4jlz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Stupid: 1e699014540633d4_1729567276827_3440509185
X-MC-Loop-Signature: 1729567276827:160516643
X-MC-Ingress-Time: 1729567276826
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.180.193 (trex/7.0.2);
	Tue, 22 Oct 2024 03:21:16 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4XXcs70rrkzC9;
	Mon, 21 Oct 2024 20:21:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729567276;
	bh=xWuXI1STFWVB6JAkyrFpy2OWqAiJ2oDnJCL4Dlt8unk=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=JRymzZpZt8j0qA4FrbQ8+cClG2+G0e7BtsNnJd7cVOu+BH/B3npfqY1RVzkEEe4ox
	 k0fCFjbXUgBZpixaDYOejC4ugfQGsXPqsL6j8kiZa7kYZrb2Uekx2Y1q8TlN+PTUfF
	 eHQl+/nj+NL464XM9cgVrk5dLRJ2tAw9JlNZqnMl3BvDBnZ4UDf/rSN3sbycWcUC8w
	 9Xeyuq1CMWruUgBOm//i9sJbLlYw6IztIV5qcbCjC9N9arlf2NG6q2+CFJ4Oscq1qG
	 s4V7qU1FxUZp6k6T0rbRWG8DDP/rBlUL9beGhnj4e88pBOs7a+9xZMAS5DDCh3UABA
	 gmzIBXcEbrEIQ==
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
Subject: [PATCH 2/3] cxl/mbox: support aborting the current background operation
Date: Mon, 21 Oct 2024 20:18:08 -0700
Message-ID: <20241022031809.242591-3-dave@stgolabs.net>
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

CXL 3.1 introduced the ability to request that the current on-going
background command be aborted. Add support for this, where the current
policy is for the request to occur whenever a new incoming bg command
wants to run. As such everything is left to user discretion and it
becomes impossible to hog the device/mailbox.

The context of doing the cancellation request is the same as the new
incoming command, and will always hold the mbox_mutex, guaranteeing
that any successful cancel does not race with a third thread coming
in and stealing the effort.

- For Sanitize, the thread doing the will cancel the work, and clean
on behalf of the respective wq callback that will never come.

- For the other bg commands, the sleeping thread is kicked and we
busy-wait until the polling flag is cleared.

In both scenarios, we guarantee that the aborted op's thread is no
longer around, giving the new bg op full authority to submit the command.

Semantics for devices that do not support such functionality are left
unchanged, and hence, with this, the driver benefits in both scenarios.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/cxlmem.h |  1 +
 drivers/cxl/pci.c    | 81 +++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 73 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index b933fb73ef8a..e843ffc3c23a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -516,6 +516,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_REQUEST_ABORT_BG_OP = 0x0005,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
 	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index f2378604669b..5da50e26e4c4 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -115,8 +115,8 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
 {
 	u64 reg;
 
-	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
-	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
+	return FIELD_GET(CXLDEV_MBOX_STATUS_BG_CMD, reg) == 0;
 }
 
 static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
@@ -241,7 +241,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 	 * hardware semantics and only allow device health status.
 	 */
 	if (mds->security.poll_tmo_secs > 0) {
-		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
+		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO &&
+		    mbox_cmd->opcode != CXL_MBOX_OP_REQUEST_ABORT_BG_OP)
 			return -EBUSY;
 	}
 
@@ -335,11 +336,64 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 	return 0;
 }
 
+/*
+ * Return true implies that the request was successful and the on-going
+ * background operation was in fact aborted. This also guarantees that
+ * the respective thread is done.
+ */
+static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
+{
+	int rc;
+	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = cxlds->dev;
+	struct cxl_mbox_cmd cmd = {
+		.opcode = CXL_MBOX_OP_REQUEST_ABORT_BG_OP
+	};
+
+	lockdep_assert_held(&cxl_mbox->mbox_mutex);
+
+	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, &cmd);
+	if (rc) {
+		dev_dbg(dev, "Failed to send abort request : %d\n", rc);
+		return false;
+	}
+
+	if (!cxl_mbox_background_complete(cxlds))
+		return false;
+
+	if (mds->security.sanitize_active) {
+		/*
+		 * Cancel the work and cleanup on its behalf - we hold
+		 * the mbox_mutex, cannot race with cxl_mbox_sanitize_work().
+		 */
+		cancel_delayed_work_sync(&mds->security.poll_dwork);
+		mds->security.poll_tmo_secs = 0;
+		if (mds->security.sanitize_node)
+			sysfs_notify_dirent(mds->security.sanitize_node);
+		mds->security.sanitize_active = false;
+
+		dev_dbg(cxlds->dev, "Sanitization operation aborted\n");
+	} else {
+		/*
+		 * Kick the poller and wait for it to be done - no one else
+		 * can touch mbox regs. rcuwait_wake_up() provides full
+		 * barriers such that wake up occurs before waiting on the
+		 * bgpoll atomic to be cleared.
+		 */
+		rcuwait_wake_up(&cxl_mbox->mbox_wait);
+		atomic_cond_read_acquire(&cxl_mbox->poll_bgop, !VAL);
+	}
+
+	return true;
+}
+
 static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 			     struct cxl_mbox_cmd *cmd)
 {
 	int rc;
 	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 	struct device *dev = cxlds->dev;
 
 	mutex_lock_io(&cxl_mbox->mbox_mutex);
@@ -348,10 +402,18 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 	 * each other: no new bg operation can occur in between while polling.
 	 */
 	if (cxl_is_background_cmd(cmd->opcode)) {
-		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
-			mutex_unlock(&cxl_mbox->mbox_mutex);
-			return -EBUSY;
+		if (mds->security.sanitize_active ||
+		    atomic_read_acquire(&cxl_mbox->poll_bgop)) {
+			if (!cxl_try_to_cancel_background(cxl_mbox)) {
+				mutex_unlock(&cxl_mbox->mbox_mutex);
+				return -EBUSY;
+			}
 		}
+		/*
+		 * ... at this point we know that the canceled
+		 * bgop context is gone, and we are the _only_
+		 * background command in town. Proceed to send it.
+		 */
 	}
 
 	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
@@ -394,10 +456,11 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 		cmd->return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
 					     bg_status_reg);
-		dev_dbg(dev,
-			"Mailbox background operation (0x%04x) completed\n",
-			cmd->opcode);
+
+		dev_dbg(dev, "Mailbox background operation (0x%04x) %s\n",
+			cmd->opcode, !cmd->return_code ? "completed":"aborted");
 done:
+		/* ensure clearing poll_bop is the last operation */
 		atomic_set_release(&cxl_mbox->poll_bgop, 0);
 	}
 
-- 
2.46.1

