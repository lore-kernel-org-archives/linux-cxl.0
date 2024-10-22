Received: from tiger.tulip.relay.mailchannels.net (tiger.tulip.relay.mailchannels.net [23.83.218.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD15256D;
	Tue, 22 Oct 2024 03:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.218.248
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729568297; cv=pass; b=ufvcYtFpU4PbC7mHspn3nLLdA6Z3jHNwup8fxYagfk+pX0YbBOahs/M5PbRHK8xvG8/NAENvkZaQLJRXd48nXUicdn3AAVw+6N7717sD9mfYt0kuD7sEhPaxYHC+JcobRmV3u0Rbww63vpw+RERrJYM9g/zXFAFfqpIi1rkV6H4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729568297; c=relaxed/simple;
	bh=7D0XF6hx0jiTrgMrVL0CzhYSCpD/QNzpapqQvKUh9ms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ISHTP7moJrlit+/AImoWqSsJi750Z4lKTvmAE1+G5K0ssIv6R+A9jvsPqAF0q2V5stD7QF1ZDR9mAkZYL8K3FujCUTVE1bnKY3GwpDeCe5ebjekPY9s2rEhvLDssimeOe2LlAw0zhZqJTq0eaiji+eBhsbOiPT7VMNjAstWM9PI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=j9vNN2wN; arc=pass smtp.client-ip=23.83.218.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="j9vNN2wN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id F084C900472;
	Tue, 22 Oct 2024 03:21:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a259.dreamhost.com (100-99-177-19.trex-nlb.outbound.svc.cluster.local [100.99.177.19])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 71D019034C2;
	Tue, 22 Oct 2024 03:21:17 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1729567277; a=rsa-sha256;
	cv=none;
	b=8rgEcjUfnraCI5l8I+H2X6sMfWcIYbGfNkE9ohDKd5S8tKF2nfzH0oBG6+a6b8Ndzi+0Ck
	QgOv/4/3GLstMKgn5d4RZynhR4l1iyKjI+HF3oQ3hE6Kqb8OuvhXSu3Agz4USQIDiTj6MM
	xCTTAD9wYo4kRFXwyg+sDZgvYSjign9x+UZo2IpF/CmiWqHd4nDiwEmWG74uEof3m6hpWa
	ZzTFj0TfMWEFbcXoVPDj0y9nno9XzH7au2o/g/iDRO2c/rJ6jpOeGL/7Xh0FuXVpW+SWY0
	L0dw+7nzq/7SXVZ8mwenr3JfWPVHlZRG21m3pnxenuj2bOG8xRfBrV9GU/setA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1729567277;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=byorMJl2bYxBjm5ML9d5+2YL1dznnN5t3iQgO/ppNDI=;
	b=LW3p4T7aLdhBJZ5SOpjl2xz195FeASkAn/2wDUPEqXJIfpadA6n83dCrErKzp2Fxwnu1F0
	2srQCWn4DN3udkEjbIC4yr4yLjnHn6+vARMIM2AJIA+Sbit7PrbPFdQPMLb5Xt28hb0beW
	AlKFb9BM2t+SILnMIMk74Ui1SXzNZTZCbzCVF/HVJyTZFF5JaKm7xsX9XTkz81wIh8fGg3
	+W6LoQOKZJ22fREMve2G6dpF56hEDCRDfiXGJQyey+lLTqycXlt5MKLnDZeO3w1pobOTdX
	fZFF807DPZIpOIUE711RAWomt0Iwkh5i7QnjLpRdwcvGy3LXQ0nln+LJP/gA9Q==
ARC-Authentication-Results: i=1;
	rspamd-75d86777c9-lf85w;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Power-Harbor: 098162ca14c9e48e_1729567277808_3789994943
X-MC-Loop-Signature: 1729567277808:3442003941
X-MC-Ingress-Time: 1729567277808
Received: from pdx1-sub0-mail-a259.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.99.177.19 (trex/7.0.2);
	Tue, 22 Oct 2024 03:21:17 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a259.dreamhost.com (Postfix) with ESMTPSA id 4XXcs82XkKz9g;
	Mon, 21 Oct 2024 20:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1729567277;
	bh=byorMJl2bYxBjm5ML9d5+2YL1dznnN5t3iQgO/ppNDI=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=j9vNN2wNIIUe4sS9dVdUsjbyIrZNCt7WDTrgFtgk66oBcJPapjHp+SkcAtaZe86RV
	 VmzE2T+n8SH/amMxElSUNevx0lvYxav7HAyJGQ+FpYOnC+1ywOSgJ3GBWm+gkSKOHA
	 0UeJuAPnQf1tLUqVrulo2t/YLF8qu/jSJQE0Ep5bKMzduoEtIe8r2OdbE/wtYclbbA
	 wkVZ4oYQTQTUEG99xw55LhLtLr7VgGTberUNP5K3XY5zeyZm9IIf0m+4hSGHaApsfG
	 wGsD0XDOdc/S7d5TvFWgfCVqDgjnU3tXCucJg2uR0AT/IpwhkhFLeYm8UDZ1O+Sm+A
	 R8Mu8f1LK/srg==
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
Subject: [PATCH 3/3] cxl/pci: rename cxl_mbox_background_complete()
Date: Mon, 21 Oct 2024 20:18:09 -0700
Message-ID: <20241022031809.242591-4-dave@stgolabs.net>
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

With the abort functionality, this is a misleading name,
rename to cxl_mbox_background_done() instead.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 5da50e26e4c4..7b0fad7f6c4d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -111,7 +111,7 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
 					 dev_id);
 }
 
-static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
+static bool cxl_mbox_background_done(struct cxl_dev_state *cxlds)
 {
 	u64 reg;
 
@@ -128,7 +128,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
-	if (!cxl_mbox_background_complete(cxlds))
+	if (!cxl_mbox_background_done(cxlds))
 		return IRQ_NONE;
 
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
@@ -157,7 +157,7 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 
 	mutex_lock(&cxl_mbox->mbox_mutex);
-	if (cxl_mbox_background_complete(cxlds)) {
+	if (cxl_mbox_background_done(cxlds)) {
 		mds->security.poll_tmo_secs = 0;
 		if (mds->security.sanitize_node)
 			sysfs_notify_dirent(mds->security.sanitize_node);
@@ -359,7 +359,7 @@ static bool cxl_try_to_cancel_background(struct cxl_mailbox *cxl_mbox)
 		return false;
 	}
 
-	if (!cxl_mbox_background_complete(cxlds))
+	if (!cxl_mbox_background_done(cxlds))
 		return false;
 
 	if (mds->security.sanitize_active) {
@@ -398,7 +398,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 
 	mutex_lock_io(&cxl_mbox->mbox_mutex);
 	/*
-	 * Ensure cxl_mbox_background_complete() checks are safe amongst
+	 * Ensure cxl_mbox_background_done() checks are safe amongst
 	 * each other: no new bg operation can occur in between while polling.
 	 */
 	if (cxl_is_background_cmd(cmd->opcode)) {
@@ -434,7 +434,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 		timeout = cmd->poll_interval_ms;
 		for (i = 0; i < cmd->poll_count; i++) {
 			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
-				       cxl_mbox_background_complete(cxlds),
+				       cxl_mbox_background_done(cxlds),
 				       TASK_UNINTERRUPTIBLE,
 				       msecs_to_jiffies(timeout)) > 0)
 				break;
@@ -445,7 +445,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 		 * until the next successful command submission and the driver
 		 * can get back in sync with the hardware state.
 		 */
-		if (!cxl_mbox_background_complete(cxlds)) {
+		if (!cxl_mbox_background_done(cxlds)) {
 			dev_err(dev, "timeout waiting for background (%d ms)\n",
 				timeout * cmd->poll_count);
 			rc = -ETIMEDOUT;
-- 
2.46.1

