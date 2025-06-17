Received: from slateblue.cherry.relay.mailchannels.net (slateblue.cherry.relay.mailchannels.net [23.83.223.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74012E2668
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 19:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.168
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750190098; cv=pass; b=P2HLEsLz4xZgRFR+3I1Roo/3R/Ds1DesQhDCesfOg9abptIbak708awU+Ie6xcaK28STV6dSyNMY1FyHpgWUkki4BeOctHRGoXRgcUGzCtT1UxSQgZHKojaG1nzXMDN2z2PQ1XiYnKHKgMDx7gas3/3buYIEqv+dIq48hnOZfG0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750190098; c=relaxed/simple;
	bh=uDVATc8yMAaMMfI4FAhzFmeWWZjZFBBRg3pEe9ml3DI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LaGypQSJQGVjsSL9rd59LRKCpHiF9R1RkBWNLg36CHzNeSDDHcd3gc0xuKfMU9oA8xF3ahMMNqmEBKgKy6Ei2byleMO2g/TGRaPuUjcaJSDDKlSqtmAvhN/KSvq5/Q6U4uEVQy/ZgsAaNVODpHUYKq2kPZXplVjWRQRvVCGIqAE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=Kesg+xL3; arc=pass smtp.client-ip=23.83.223.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="Kesg+xL3"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 794754511B;
	Tue, 17 Jun 2025 19:38:05 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-2.trex.outbound.svc.cluster.local [100.96.75.158])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 181B6455A8;
	Tue, 17 Jun 2025 19:38:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189085; a=rsa-sha256;
	cv=none;
	b=rGKMFn602FSuMKdoKOKwvyN/BHMtyns6A+J/SZisL9UG95rZKCGZy7nr9wbd/HnZT2JKeR
	YdsdM/bAP5drUiQK0bpIsZW2uBgXoMcI9T1GEPfkbKHXqB8UwEoBpyTTjCfFZwyUm5PSnx
	VgZx8yp7fsh2TGmL7kfUFZbzxvB6ob0sq+8tT6ocVyHVnk0r1+H3RsCSXeoD24rBZ3aJuS
	TMyzCusYDPjHVKZQLtLF46Ux+E4liGpVTcEYP+6h1xupCYAFokH6CyxCilfCLMRJQ+KCuM
	RFBxlnf3XQisfx+lwBLq5V9+KNtcaDX/k5eECDNxaiJBOVKU46dzyL/zDxVefw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=nxl4PaSz3mv7yLVinvnA4XtBUL6VZHKqD4MLV3xCoa0=;
	b=FSEKN9K/FWUDtqv9cPowF9CSMn7XkJC4IZG8oLoNX8oIAaqTEzblkoBACzVfNTvAdKupKi
	p0QxrAYTK+FMdtljFCDM8Tkdg1/pEG/Xw0hP3fC3AjHXn8ZCp2MkY1tA77MDUjuiDlobxD
	+gyFKt4FJ+6+6OHOBOwBfR97tpaJoVFMJif9/10R0ntPqyhV8LMszdYZ5WUmi72dlEpFlO
	IdeHYsabENnzI6uPffN4gtMOERW5eDM3jYpk/ySk2OLy48zbv8fp4JvmMxf7ZCnXiuzLns
	TPTsHA8/YE5y1NjWrJ/Kzos4KPaixkg6l/yLNTXXXV4AGEmaUi+y2MGpeQxMZg==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-d2vbn;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Oafish-Name: 39c3cf6e5de21694_1750189085429_1844164508
X-MC-Loop-Signature: 1750189085429:520191055
X-MC-Ingress-Time: 1750189085428
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.75.158 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:05 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGN0sfYzFr;
	Tue, 17 Jun 2025 12:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189084;
	bh=nxl4PaSz3mv7yLVinvnA4XtBUL6VZHKqD4MLV3xCoa0=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=Kesg+xL3yYmPOP2YpY/XCt2s0+xUlqG+JjCO7rWYm8Qhr54oe+WPGn3nVX74IaqpW
	 Nh7jnNzR/5eofoOii2Zn/F2DCRij1tKpgrE6lNjtowibFiynvrOiFGZZbwzwxLP0K0
	 buFUe2CcLndgoPN83zGCao6C83ukEv2qRd91T3l2jyWz9M3m2STDm7e9EDzYrpKfau
	 2Bknv38QcM/k7Ae7HgmjvMJv7er+G7ntgvmIC061a9Zb1wTBcn1zC0G83KJzutKsuY
	 xukruUA/1hI8KwtpJMjIDNHCYn+ZaQgWlPfYg1o2LbcHntRZS6FPcSs5eK1moDKDNV
	 D4WbvKVSqsohw==
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
Subject: [PATCH 5/7] cxl/mbox: Allow userspace background commands
Date: Tue, 17 Jun 2025 12:36:09 -0700
Message-Id: <20250617193611.564668-6-dave@stgolabs.net>
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

CXL 3.1 introduced the ability to request that the current on-going
background command be aborted. As such userspace may be allowed to
monopolize the background operation capability if there are no
other bg commands that want to run.

The policy here are as follows:

1. Give bg-capable commands from the kernel higher priority than those
from userspace (albeit currently no command). Therefore a userspace
on-going command can be canceled so a kernel one may run instead.

2. Userspace bg commands may cancel each other on demand. It is not
up to the kernel to put any policies in place here.

3. Any previously synchronous polling timedout command that is still
running may also be aborted by any command. This window is expected
to be small.

The context of doing the cancellation request is the same as the new
incoming command, and will always hold the mbox_mutex, guaranteeing
that any successful cancel does not race with a third thread coming
in and stealing the effort.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/mbox.c |  9 ++++--
 drivers/cxl/cxlmem.h    |  4 +++
 drivers/cxl/pci.c       | 72 +++++++++++++++++++++++++++++++++++++----
 include/cxl/mailbox.h   |  2 ++
 4 files changed, 78 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index aa1b04d8a78e..abb6bb77a43d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -382,6 +382,7 @@ static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
 	*mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
 		.size_in = in_size,
+		.user = true,
 	};
 
 	if (in_size) {
@@ -787,8 +788,12 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 		int enabled = 0;
 
 		if (cmd) {
-			set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
-			enabled++;
+			/* only enable uapi bgcmds that may be canceled */
+			if (!(effect & CXL_CEL_BACKGROUND_OPERATION) ||
+			    (effect & CXL_CEL_REQ_ABORT_BACKGROUND_SUPPORTED)) {
+				set_bit(cmd->info.id, cxl_mbox->enabled_cmds);
+				enabled++;
+			}
 		}
 
 		enabled += check_features_opcodes(opcode, &ro_cmds,
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 6fe42871fbf4..ebd7679143dd 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -376,12 +376,14 @@ struct cxl_security_state {
  * @poll_dwork: polling background work item
  * @poll_tmo_secs: polling timeout
  * @opcode: async running background command
+ * @user: whether or not operation was initialized by userspace (uapi)
  */
 struct cxl_background_state {
 	DECLARE_BITMAP(enabled_cmds, CXL_BG_ENABLED_MAX);
 	struct delayed_work poll_dwork;
 	int poll_tmo_secs;
 	int opcode;
+	bool user;
 };
 
 /*
@@ -539,6 +541,7 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
 enum cxl_opcode {
 	CXL_MBOX_OP_INVALID		= 0x0000,
 	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
+	CXL_MBOX_OP_REQUEST_ABORT_BG_OP = 0x0005,
 	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
 	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
 	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
@@ -606,6 +609,7 @@ struct cxl_mbox_get_supported_logs {
  * CXL 3.2 Section 8.2.10.5.2.1; Table 8-87
  */
 #define CXL_CEL_BACKGROUND_OPERATION BIT(6)
+#define CXL_CEL_REQ_ABORT_BACKGROUND_SUPPORTED BIT(8)
 
 struct cxl_cel_entry {
 	__le16 opcode;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3648efcc7c89..6ada0f502914 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -134,7 +134,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE ||
-	    opcode == CXL_MBOX_OP_ACTIVATE_FW) {
+	    opcode == CXL_MBOX_OP_ACTIVATE_FW || mds->bg.user) {
 		mutex_lock(&cxl_mbox->mbox_mutex);
 		if (mds->bg.opcode)
 			mod_delayed_work(system_wq, &mds->bg.poll_dwork, 0);
@@ -167,6 +167,7 @@ static void cxl_mbox_bgpoll_work(struct work_struct *work)
 			"Mailbox background operation (0x%04x) ended\n",
 			mds->bg.opcode);
 		mds->bg.opcode = 0;
+		mds->bg.user = false;
 	} else {
 		int timeout = mds->bg.poll_tmo_secs + 10;
 
@@ -263,6 +264,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 	 * commands during this window.
 	 */
 	switch (mds->bg.opcode) {
+	case 0:
+		break;
 	case CXL_MBOX_OP_SANITIZE:
 		/*
 		 * Ensure no new command comes in until so. Keep the
@@ -271,12 +274,10 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
 			return -EBUSY;
 		break;
-	case CXL_MBOX_OP_ACTIVATE_FW:
+	default:
 		if (cxl_is_background_cmd(mds, mbox_cmd->opcode))
 			return -EBUSY;
 		break;
-	default:
-		break;
 	}
 
 	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
@@ -321,7 +322,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 		 * timesliced. Handle asynchronously instead.
 		 */
 		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE ||
-		    mbox_cmd->opcode == CXL_MBOX_OP_ACTIVATE_FW) {
+		    mbox_cmd->opcode == CXL_MBOX_OP_ACTIVATE_FW ||
+		    mbox_cmd->user) {
 			int timeout;
 
 			if (mds->bg.opcode)
@@ -331,6 +333,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 			timeout = 1;
 			mds->bg.poll_tmo_secs = timeout;
 			mds->bg.opcode = mbox_cmd->opcode;
+			mds->bg.user = mbox_cmd->user;
 			schedule_delayed_work(&mds->bg.poll_dwork,
 					      timeout * HZ);
 		} else {
@@ -369,6 +372,59 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 	return 0;
 }
 
+/*
+ * Attempt to cancel an on-going background command. Return true guarantees
+ * that no such operations are running and any leftover context is gone.
+ */
+static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
+{
+	int rc;
+	struct cxl_dev_state *cxlds = mbox_to_cxlds(cxl_mbox);
+	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct device *dev = cxlds->dev;
+	struct cxl_mbox_cmd cmd = {
+		.opcode = CXL_MBOX_OP_REQUEST_ABORT_BG_OP,
+	};
+
+	lockdep_assert_held(&cxl_mbox->mbox_mutex);
+
+	/* everything is finished, new bgcmd may proceed */
+	if (cxl_mbox_background_done(cxlds))
+		goto done;
+	if (!mds->bg.user) {
+		/*
+		 * Policy is around userpace being abortable:
+		 *   incoming user bgcmd -> abort on-going user bgcmd
+		 *   incoming kernel bgcmd -> abort on-going user bgcmd
+		 */
+		return false;
+	}
+
+	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, &cmd);
+	if (rc) {
+		dev_dbg(dev, "Failed to send abort request : %d\n", rc);
+		return false;
+	}
+
+	if (!cxl_mbox_background_done(cxlds))
+		return false;
+
+	dev_dbg(cxlds->dev, "Mailbox background operation aborted\n");
+done:
+	if (mds->bg.opcode) {
+		/*
+		 * Cancel the work and cleanup on its behalf - we hold
+		 * the mbox_mutex, cannot race with cxl_mbox_bgpoll_work().
+		 */
+		cancel_delayed_work_sync(&mds->bg.poll_dwork);
+		mds->bg.poll_tmo_secs = 0;
+		mds->bg.opcode = 0;
+		mds->bg.user = false;
+	}
+
+	return true;
+}
+
 static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 			     struct cxl_mbox_cmd *cmd)
 {
@@ -381,9 +437,11 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 	/*
 	 * Ensure cxl_mbox_background_done() checks are safe amongst
 	 * each other: no new bg operation can occur in between while polling.
+	 *
 	 */
 	if (cxl_is_background_cmd(mds, cmd->opcode)) {
-		if (atomic_read_acquire(&cxl_mbox->poll_bgop)) {
+		if (atomic_read_acquire(&cxl_mbox->poll_bgop) ||
+		    !cxl_try_to_cancel_background(cxl_mbox)) {
 			mutex_unlock(&cxl_mbox->mbox_mutex);
 			return -EBUSY;
 		}
@@ -401,7 +459,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 	 * command.
 	 */
 	if (cmd->opcode != CXL_MBOX_OP_SANITIZE &&
-	    cmd->opcode != CXL_MBOX_OP_ACTIVATE_FW) {
+	    cmd->opcode != CXL_MBOX_OP_ACTIVATE_FW && !cmd->user) {
 		int i, timeout;
 		u64 bg_status_reg;
 
diff --git a/include/cxl/mailbox.h b/include/cxl/mailbox.h
index f3c60158bfca..4a4119f49d3b 100644
--- a/include/cxl/mailbox.h
+++ b/include/cxl/mailbox.h
@@ -19,6 +19,7 @@
  *            variable sized output commands, it tells the exact number of bytes
  *            written.
  * @min_out: (input) internal command output payload size validation
+ * @user: (input) Whether or not command was submitted from userspace (uapi).
  * @poll_count: (input) Number of timeouts to attempt.
  * @poll_interval_ms: (input) Time between mailbox background command polling
  *                    interval timeouts.
@@ -37,6 +38,7 @@ struct cxl_mbox_cmd {
 	size_t size_in;
 	size_t size_out;
 	size_t min_out;
+	bool user;
 	int poll_count;
 	int poll_interval_ms;
 	u16 return_code;
-- 
2.39.5

