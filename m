Received: from cichlid.ash.relay.mailchannels.net (cichlid.ash.relay.mailchannels.net [23.83.222.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0757A16132A
	for <linux-cxl@vger.kernel.org>; Tue, 28 Apr 2026 21:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777411360; cv=pass; b=Qg8KYhNN7C6Pj7Vkms4cHoft8SkZtocMlADnZeg5gAs50fLfy9m0lqDodVurjrLfP88au52T9/pESkrrhZIRSc4dSuvK4qTZJ78k7328Ayox7bKFHZ0cQ4IGSVRTnSnISMZUBQMb0BXdR3wgDOZ0XR7NJpqamx9hzKbnrpDDnC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777411360; c=relaxed/simple;
	bh=OuIPZHar2qtImXxlyByvzUmur02kS0PQk8JsG5/hxGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ukL6SZMnvGhPpjp/RjY8gtbzfD9vqIgrXmKILWVUtvGTinQ2vOQZcgjjyAf663CuzFIwVeF0WYMn69D4YPT1sMs1IX/zi3ao/wtFFR42fhnY5atVCMKvu1WTQTAMeK1YADxDipvI49Eh3WQ6xuW7kLT5+HENEugFyKRv2gblPus=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=fail smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=b9gPM+FY; arc=pass smtp.client-ip=23.83.222.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="b9gPM+FY"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 221FF7229AF;
	Tue, 28 Apr 2026 21:22:32 +0000 (UTC)
Received: from pdx1-sub0-mail-a227.dreamhost.com (trex-green-9.trex.outbound.svc.cluster.local [100.97.144.153])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id B45C0722376;
	Tue, 28 Apr 2026 21:22:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1777411351;
	b=ZgR33FGgfpYggXAHoLo3mPzFcrpDLCAy/YZVtFOcF7r6Ba3E4eg+E4OMgt7LThxrXnGGV/
	x9KEMU0GmB/djFIsQyqW1obwc6JdmUVLTCKqTwebKWCENsG/ySiLrE7MMrVPzySVGQI+ND
	JtXVy/FT38fddcTsyZllfcGnZ1Aiu2IsUe+VvDbpVATrzXaYpV/8SqKEzwpK8IyvquExqH
	QJZKiIZI7AYDX0qUNufrcuMvK5rVtvlTED38mGzOnhg+yjntMOVTnrC8X+yPWSt8G8ECYz
	JEhHr1F5+e+7q7cAkSbi5mHN8qmUh+YQHOMUVnWIsOxhU3LmdAw8QsXSFuAavA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1777411351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Sm7XNmbN1V9qlDWs8WloK61huSzWCHV5yXNLn3A1D7M=;
	b=eVSh2zo9OMNzMDV7O2l43mtv3svazCfYycq9wpMdTU2eKvdWKgnuAu0wmW5YYQWzVl2C3v
	2PoCzysoduPIUFIkK1bpVp7Pn/No2yW/0va+wMuIO4Oemrf/+rGHF455n2vnw1/Znaoza9
	xS2zEQU7iQ14rNJsr3BIKNw0LwZAWI8d/o/Sw49Lme/+PLxUDi1GhfQBn2Fcnzq92tcKg5
	w9I93KEoff/g26Dqa5ssM5g2HRfe2l+6QiDcz2vF0tTvIMX/nrlmKtFzt3U1/4k5EAa1Sc
	x/bNucvCAcam0dMH2Eqa6Xz7UbiJ1DdGuQS3fAyVJE3rv5bCmFXpf4X916I0oA==
ARC-Authentication-Results: i=1;
	rspamd-55bb47d7db-r545f;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Thoughtful-Harbor: 570d48cd62fa071f_1777411351985_1797926228
X-MC-Loop-Signature: 1777411351985:2113753091
X-MC-Ingress-Time: 1777411351984
Received: from pdx1-sub0-mail-a227.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.97.144.153 (trex/7.1.5);
	Tue, 28 Apr 2026 21:22:31 +0000
Received: from offworld.lan (unknown [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a227.dreamhost.com (Postfix) with ESMTPSA id 4g4tgV5B9pz3p;
	Tue, 28 Apr 2026 14:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1777411351;
	bh=Sm7XNmbN1V9qlDWs8WloK61huSzWCHV5yXNLn3A1D7M=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=b9gPM+FYl0R2paJBqJqYB5AMYKT5BXII8w3C7k84eDJhNmRMHwp64qFa63AFezS3A
	 Q7VGJkycjtHTSLRL94cmdgu6Gbux4HYuML0rLzCip3O95TQ7Qmrx4MWfvB71KhYWyY
	 RuxM8zczAhpW6D1tTQyn5NPbpYZ8ABlMfz8EOKaY7Sb1AzHE8x/I3md+bsxibRNvyj
	 lSwCPAfm7M67s7Q3B2O8Hl9CgbUzyYizeE8/Fk+NLOyeIIr/GiM5Wcj6ymPYLhe6p+
	 F7iKvRpW0kt6mAa5KW65K+Y8n4g5cfCb/pmpiI1AfRTPAZ+KNre6eheDZNS03ZtN4g
	 RGMUI7HD0HiPg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: dave.jiang@intel.com
Cc: jic23@kernel.org,
	alison.schofield@intel.com,
	ira.weiny@intel.com,
	djbw@kernel.org,
	linux-cxl@vger.kernel.org,
	Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] cxl/mbox: Use guard() for mbox_mutex locking
Date: Tue, 28 Apr 2026 14:22:20 -0700
Message-Id: <20260428212220.711160-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the new helpers and simplify the code. No change in
semantics.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/memdev.c | 16 ++++++++--------
 drivers/cxl/pci.c         | 21 ++++++++-------------
 2 files changed, 16 insertions(+), 21 deletions(-)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 3db4e91170a8..0c9067ced7b3 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -138,10 +138,10 @@ static ssize_t security_state_show(struct device *dev,
 	int rc = 0;
 
 	/* sync with latest submission state */
-	mutex_lock(&cxl_mbox->mbox_mutex);
-	if (mds->security.sanitize_active)
-		rc = sysfs_emit(buf, "sanitize\n");
-	mutex_unlock(&cxl_mbox->mbox_mutex);
+	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
+		if (mds->security.sanitize_active)
+			rc = sysfs_emit(buf, "sanitize\n");
+	}
 	if (rc)
 		return rc;
 
@@ -1247,10 +1247,10 @@ static void sanitize_teardown_notifier(void *data)
 	 * Prevent new irq triggered invocations of the workqueue and
 	 * flush inflight invocations.
 	 */
-	mutex_lock(&cxl_mbox->mbox_mutex);
-	state = mds->security.sanitize_node;
-	mds->security.sanitize_node = NULL;
-	mutex_unlock(&cxl_mbox->mbox_mutex);
+	scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
+		state = mds->security.sanitize_node;
+		mds->security.sanitize_node = NULL;
+	}
 
 	cancel_delayed_work_sync(&mds->security.poll_dwork);
 	sysfs_put(state);
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 95bf773aab14..3462cea6e61b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -134,10 +134,11 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
-		mutex_lock(&cxl_mbox->mbox_mutex);
-		if (mds->security.sanitize_node)
-			mod_delayed_work(system_percpu_wq, &mds->security.poll_dwork, 0);
-		mutex_unlock(&cxl_mbox->mbox_mutex);
+		scoped_guard(mutex, &cxl_mbox->mbox_mutex) {
+			if (mds->security.sanitize_node)
+				mod_delayed_work(system_percpu_wq,
+						 &mds->security.poll_dwork, 0);
+		}
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
 		rcuwait_wake_up(&cxl_mbox->mbox_wait);
@@ -156,7 +157,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 
-	mutex_lock(&cxl_mbox->mbox_mutex);
+	guard(mutex)(&cxl_mbox->mbox_mutex);
 	if (cxl_mbox_background_complete(cxlds)) {
 		mds->security.poll_tmo_secs = 0;
 		if (mds->security.sanitize_node)
@@ -170,7 +171,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		mds->security.poll_tmo_secs = min(15 * 60, timeout);
 		schedule_delayed_work(&mds->security.poll_dwork, timeout * HZ);
 	}
-	mutex_unlock(&cxl_mbox->mbox_mutex);
 }
 
 /**
@@ -377,13 +377,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_mailbox *cxl_mbox,
 static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 			     struct cxl_mbox_cmd *cmd)
 {
-	int rc;
-
-	mutex_lock(&cxl_mbox->mbox_mutex);
-	rc = __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
-	mutex_unlock(&cxl_mbox->mbox_mutex);
-
-	return rc;
+	guard(mutex)(&cxl_mbox->mbox_mutex);
+	return __cxl_pci_mbox_send_cmd(cxl_mbox, cmd);
 }
 
 static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds, bool irq_avail)
-- 
2.39.5

