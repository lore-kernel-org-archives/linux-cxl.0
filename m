Received: from olivedrab.birch.relay.mailchannels.net (olivedrab.birch.relay.mailchannels.net [23.83.209.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C491D1DA617
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 19:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.209.135
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750189453; cv=pass; b=VuxkTTYytjwPwO19TeXDfSGEbHPzGbOaSp7ABKPzaT9fCDnQQSWb/jKW6n8a9uzDTWkrKSlOf2g0EISfJ3Vf/GEn9XFVyU9jvW7VrRFLi+cS4FXfCEcKhqNmcY9J+xWjFz5JUYJKnhoxEQBfsYTw+gvMa528vj6eLy1vPJkuPFM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750189453; c=relaxed/simple;
	bh=zrN3AJTyU1UQ8JezyScuRZhh1feNAepPQ7m3zi596Es=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DB83fysuGW4JmSK8D+e1rMBJ7EHLvsgPvWAyRlYmPE73xb7zQjXszt2E6cJqrsLhq8589pWAJNvvdTQyk/TH1fu9mwEaVNVGBj89BvG5bJCt4w/OQQieC6D4h11kItxGWXbfZ49dVfWuMt9MJ+isk09YFcEt+BncsfDmoKbv8Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=SBKQGAqL; arc=pass smtp.client-ip=23.83.209.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="SBKQGAqL"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 8BD61904F6D;
	Tue, 17 Jun 2025 19:38:02 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.127.188.7])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id EBAB4904D1E;
	Tue, 17 Jun 2025 19:38:01 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189082; a=rsa-sha256;
	cv=none;
	b=qYh4TymibS56JNqNHzj4w1+r9pPch2HZaqNSGUjpV2dHSmX3iVCCz0JeHIMLHsig62dEu0
	4QKY86ALwBLa8hF98IH8of3V10WNk+x+gI3mSaGeSQjb270xKN2mNByMGCWBySGaxQhOLX
	kg6Iy8STfk+o1rE6vE48TeoyiTjARmoEEMAbp+jOOX6dlb1FcD2Gj3vXnKHlwVyRmCeJzR
	+3XR0nUF6OjeTPxmjMdnSNep8GogKLN1IDyM4z/RHWWlUvMxrqV7zZnOYYM3ASP0zmtxq+
	aHlbU1nQCrczvyP5PBBRMBJICqBUcwatnS5TRngK2TMGC22voAktYILlREneUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189082;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RJ6T61v02UANFwHy8foH6PCmswZM3ZKxAsJTUOaWwZM=;
	b=Rg4XWsCO7RucuBx476zXVo9oN9TD60yVfP5hgYHxUhxbAsOyqpahBeb/MImu4TogFvqgdw
	EEMdXG46g6ym7NVkrJfy75PSHHmnCYG3ODJO7X7eobTL8g7xj60MHqm8Py4sS1HlPdIwY1
	h2s8PCmXxVxssUzL0nrvfqbHHeiDBHCaHg6oQ5X1tmVJsJy27tJZNRUBhIkYfz43FRvrJ1
	rbDXfyFKbIELsJ1PrVhjQFIXn8b6fpdg9CwLNTPnbvhmrsTeQtBd11TeZIBwOG5gqdPT3c
	d2ES1HdVD3fDI6dNiUx+i8FnArEqiZw8O80UC6cNZrKOBN6a+UhjwfErNmzTPw==
ARC-Authentication-Results: i=1;
	rspamd-6c978647c4-6g4pv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Suffer: 6f40c536487cae2d_1750189082413_3570280905
X-MC-Loop-Signature: 1750189082413:2850607163
X-MC-Ingress-Time: 1750189082412
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.127.188.7 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:02 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGK0MK2zGw;
	Tue, 17 Jun 2025 12:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189081;
	bh=RJ6T61v02UANFwHy8foH6PCmswZM3ZKxAsJTUOaWwZM=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=SBKQGAqLod/UfVeAV1PY/a1AW4DHKlXu1agaWQTr4gvifmSmeKomUyI2kSvdAOLFZ
	 +I4wfmlYNEfGCl9VYuoSEDDZB6oBSnHLNQUTXpkxNeqPQNzA5ayhpUWBwDRAtdPwBj
	 75p3iXMAx1hUSbev/Hzi2RVb+Nv+jlW+bN3Y4K89pA6GzxhYmzxvANQrWdIz6lcbj6
	 JNKT91PhbBDIpFFZKC73TUZh8LiWUERWfTRU6k6JLhRwe4h8eDEnOTef93FUcyb/Nz
	 Mmn2v2N08c8BP6BM0NeU/6ZztXc+FeLUqvD/zbO4hEj36LSQcDqZj46wAdaPeDV+xa
	 7qFHAlYxS5jUw==
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
Subject: [PATCH 2/7] cxl/mbox: Handle Activate FW as async bg
Date: Tue, 17 Jun 2025 12:36:06 -0700
Message-Id: <20250617193611.564668-3-dave@stgolabs.net>
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

Allow Activate FW to behave as Sanitize by running in an async
context. These commands cannot be timesliced, and while it was
the expectation that hardware vendors perform (offline) activating
FW in a timely fashion, this might not always be the case.

This further reduces the timeout scenarios when handling the
bg command synchronously.

Decouple the async background handling from security.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/hdm.c    |  2 +-
 drivers/cxl/core/memdev.c |  4 +-
 drivers/cxl/cxlmem.h      | 13 +++---
 drivers/cxl/pci.c         | 91 ++++++++++++++++++++++++++-------------
 4 files changed, 71 insertions(+), 39 deletions(-)

diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
index ab1007495f6b..0f6402b2faa6 100644
--- a/drivers/cxl/core/hdm.c
+++ b/drivers/cxl/core/hdm.c
@@ -795,7 +795,7 @@ static int cxl_decoder_commit(struct cxl_decoder *cxld)
 		struct cxl_memdev_state *mds =
 			to_cxl_memdev_state(cxlmd->cxlds);
 
-		if (mds && mds->security.sanitize_active) {
+		if (mds && mds->bg.opcode == CXL_MBOX_OP_SANITIZE) {
 			dev_dbg(&cxlmd->dev,
 				"attempted to commit %s during sanitize\n",
 				dev_name(&cxld->dev));
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index f88a13adf7fa..d82f8ce182d8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -140,7 +140,7 @@ static ssize_t security_state_show(struct device *dev,
 
 	/* sync with latest submission state */
 	mutex_lock(&cxl_mbox->mbox_mutex);
-	if (mds->security.sanitize_active)
+	if (mds->bg.opcode == CXL_MBOX_OP_SANITIZE)
 		rc = sysfs_emit(buf, "sanitize\n");
 	mutex_unlock(&cxl_mbox->mbox_mutex);
 	if (rc)
@@ -1097,7 +1097,7 @@ static void sanitize_teardown_notifier(void *data)
 	mds->security.sanitize_node = NULL;
 	mutex_unlock(&cxl_mbox->mbox_mutex);
 
-	cancel_delayed_work_sync(&mds->security.poll_dwork);
+	cancel_delayed_work_sync(&mds->bg.poll_dwork);
 	sysfs_put(state);
 }
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5c7fd4a6704c..6fe42871fbf4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -361,17 +361,11 @@ struct cxl_fw_state {
  *
  * @state: state of last security operation
  * @enabled_cmds: All security commands enabled in the CEL
- * @poll_tmo_secs: polling timeout
- * @sanitize_active: sanitize completion pending
- * @poll_dwork: polling work item
  * @sanitize_node: sanitation sysfs file to notify
  */
 struct cxl_security_state {
 	unsigned long state;
 	DECLARE_BITMAP(enabled_cmds, CXL_SEC_ENABLED_MAX);
-	int poll_tmo_secs;
-	bool sanitize_active;
-	struct delayed_work poll_dwork;
 	struct kernfs_node *sanitize_node;
 };
 
@@ -379,12 +373,17 @@ struct cxl_security_state {
  * struct cxl_background_state - Driver background operation state info
  *
  * @enabled_cmds: All background commands enabled in the CEL
+ * @poll_dwork: polling background work item
+ * @poll_tmo_secs: polling timeout
+ * @opcode: async running background command
  */
 struct cxl_background_state {
 	DECLARE_BITMAP(enabled_cmds, CXL_BG_ENABLED_MAX);
+	struct delayed_work poll_dwork;
+	int poll_tmo_secs;
+	int opcode;
 };
 
-
 /*
  * enum cxl_devtype - delineate type-2 from a generic type-3 device
  * @CXL_DEVTYPE_DEVMEM - Vendor specific CXL Type-2 device implementing HDM-D or
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bd100ac31672..0d8f3605dc3f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -133,10 +133,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
-	if (opcode == CXL_MBOX_OP_SANITIZE) {
+	if (opcode == CXL_MBOX_OP_SANITIZE ||
+	    opcode == CXL_MBOX_OP_ACTIVATE_FW) {
 		mutex_lock(&cxl_mbox->mbox_mutex);
-		if (mds->security.sanitize_node)
-			mod_delayed_work(system_wq, &mds->security.poll_dwork, 0);
+		if (mds->bg.opcode)
+			mod_delayed_work(system_wq, &mds->bg.poll_dwork, 0);
 		mutex_unlock(&cxl_mbox->mbox_mutex);
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
@@ -149,30 +150,51 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 /*
  * Sanitization operation polling mode.
  */
-static void cxl_mbox_sanitize_work(struct work_struct *work)
+static void cxl_mbox_bgpoll_work(struct work_struct *work)
 {
 	struct cxl_memdev_state *mds =
-		container_of(work, typeof(*mds), security.poll_dwork.work);
+		container_of(work, typeof(*mds), bg.poll_dwork.work);
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 
 	mutex_lock(&cxl_mbox->mbox_mutex);
 	if (cxl_mbox_background_complete(cxlds)) {
-		mds->security.poll_tmo_secs = 0;
-		if (mds->security.sanitize_node)
+		mds->bg.poll_tmo_secs = 0;
+		if (mds->bg.opcode == CXL_MBOX_OP_SANITIZE)
 			sysfs_notify_dirent(mds->security.sanitize_node);
-		mds->security.sanitize_active = false;
 
-		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
+		dev_dbg(cxlds->dev,
+			"Mailbox background operation (0x%04x) ended\n",
+			mds->bg.opcode);
+		mds->bg.opcode = 0;
 	} else {
-		int timeout = mds->security.poll_tmo_secs + 10;
+		int timeout = mds->bg.poll_tmo_secs + 10;
 
-		mds->security.poll_tmo_secs = min(15 * 60, timeout);
-		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
+		mds->bg.poll_tmo_secs = min(15 * 60, timeout);
+		schedule_delayed_work(&mds->bg.poll_dwork, timeout * HZ);
 	}
 	mutex_unlock(&cxl_mbox->mbox_mutex);
 }
 
+static inline bool cxl_is_background_cmd(struct cxl_memdev_state *mds,
+					 u16 opcode)
+{
+	switch (opcode) {
+	case CXL_MBOX_OP_TRANSFER_FW:
+		return test_bit(CXL_BG_ENABLED_TRANSFER_FW, mds->bg.enabled_cmds);
+	case CXL_MBOX_OP_ACTIVATE_FW:
+		return test_bit(CXL_BG_ENABLED_ACTIVATE_FW, mds->bg.enabled_cmds);
+	case CXL_MBOX_OP_DO_MAINTENANCE:
+		return test_bit(CXL_BG_ENABLED_DO_MAINTENANCE, mds->bg.enabled_cmds);
+	case CXL_MBOX_OP_SCAN_MEDIA:
+		return test_bit(CXL_BG_ENABLED_SCAN_MEDIA, mds->bg.enabled_cmds);
+	case CXL_MBOX_OP_SANITIZE:
+		return test_bit(CXL_BG_ENABLED_SANITIZE, mds->bg.enabled_cmds);
+	default:
+		return false;
+	}
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxl_mbox: CXL mailbox context
@@ -236,13 +258,25 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 	}
 
 	/*
-	 * With sanitize polling, hardware might be done and the poller still
-	 * not be in sync. Ensure no new command comes in until so. Keep the
-	 * hardware semantics and only allow device health status.
+	 * With async bg polling, hardware might be done and the poller still
+	 * not be in sync. At the very least, prevent any incoming bg-capable
+	 * commands during this window.
 	 */
-	if (mds->security.poll_tmo_secs > 0) {
+	switch (mds->bg.opcode) {
+	case CXL_MBOX_OP_SANITIZE:
+		/*
+		 * Ensure no new command comes in until so. Keep the
+		 * hardware semantics and only allow device health status.
+		 */
 		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
 			return -EBUSY;
+		break;
+	case CXL_MBOX_OP_ACTIVATE_FW:
+		if (cxl_is_background_cmd(mds, mbox_cmd->opcode))
+			return -EBUSY;
+		break;
+	default:
+		break;
 	}
 
 	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
@@ -295,28 +329,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		u64 bg_status_reg;
 		int i, timeout;
 
+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+			mbox_cmd->opcode);
+
 		/*
-		 * Sanitization is a special case which monopolizes the device
-		 * and cannot be timesliced. Handle asynchronously instead,
-		 * and allow userspace to poll(2) for completion.
+		 * Special cases which monopolize the device and cannot be
+		 * timesliced. Handle asynchronously instead.
 		 */
-		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (mds->security.sanitize_active)
+		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE ||
+		    mbox_cmd->opcode == CXL_MBOX_OP_ACTIVATE_FW) {
+			if (mds->bg.opcode)
 				return -EBUSY;
 
 			/* give first timeout a second */
 			timeout = 1;
-			mds->security.poll_tmo_secs = timeout;
-			mds->security.sanitize_active = true;
-			schedule_delayed_work(&mds->security.poll_dwork,
+			mds->bg.poll_tmo_secs = timeout;
+			mds->bg.opcode = mbox_cmd->opcode;
+			schedule_delayed_work(&mds->bg.poll_dwork,
 					      timeout * HZ);
-			dev_dbg(dev, "Sanitization operation started\n");
 			goto success;
 		}
 
-		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
-			mbox_cmd->opcode);
-
 		timeout = mbox_cmd->poll_interval_ms;
 		for (i = 0; i < mbox_cmd->poll_count; i++) {
 			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
@@ -442,7 +475,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
 
 	dev_dbg(dev, "Mailbox payload sized %zu", cxl_mbox->payload_size);
 
-	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
+	INIT_DELAYED_WORK(&mds->bg.poll_dwork, cxl_mbox_bgpoll_work);
 
 	/* background command interrupts are optional */
 	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) || !irq_avail)
-- 
2.39.5

