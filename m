Received: from panther.cherry.relay.mailchannels.net (panther.cherry.relay.mailchannels.net [23.83.223.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F482E3AF6
	for <linux-cxl@vger.kernel.org>; Tue, 17 Jun 2025 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750193795; cv=pass; b=Vb/tampmuM0HMPB4YX+oMD8EVQQnN+JQZf9XJ4I8pvjlS/IU+Jt1kLVNemZLh5ABucnqiwEpV18E/+EuzaIOjv7WAIkyQr1SMGFB+qdepDXRUavJSzYNqd6ocXfUr3zrBU0VOhAMPG5wshQAd3QtpuZRZSj2jbJ4f3vq3DPo4pU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750193795; c=relaxed/simple;
	bh=Sum+JBx3vvvD77WDrAANLddV0YMNz3ebeWJPMtdiB+Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bZL+fOj3SZ4lTgVoilJywAgLoi0K8g4Jg8ckmbjUq+I/TVIin+MMAsfN6kDMJ8czl+xOsCLf9bdQdEpT5FM7aDXUSdboCmda4aTViiZ/BVOUmmPgI68O1IBDMfEIVvkI/I1WQvClVF8zrvC3vCy4TWfciaaeu36l9AojmQiD8hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=cmf8kQuY; arc=pass smtp.client-ip=23.83.223.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="cmf8kQuY"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 94A55165407;
	Tue, 17 Jun 2025 19:38:04 +0000 (UTC)
Received: from pdx1-sub0-mail-a289.dreamhost.com (trex-green-4.trex.outbound.svc.cluster.local [100.96.195.184])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 18B54165958;
	Tue, 17 Jun 2025 19:38:04 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1750189084; a=rsa-sha256;
	cv=none;
	b=HU7/EgT9aD0Pl14Re9KRW9HnJWsfJkX7yAoRgmiS35Z8svlg38FbWN99aIr8xwOAd4U0/B
	dl6Yqp6kpKhOHpNIXnjMcSqNhh3P8GM7Opsm8wOGQTwXNFqq+YC70PLHo9jCpMO3aQHPpr
	7gM94XHAvgiH54RKkFul4ocMYbh+8qMff9sBZkXth06m1JvQnNTPUNjizzxY153e9HJO+o
	tvlgn6iibCYk3DMsK0WR632FhEXFTPV8lCX17hA9mwgdSlDW1bGqckE0kcovbrBFWu2+Ek
	XqEzU8WghP4qnx/l43iVTPzkLGB79OpeVgdAWVdJidtXvzRw7yoBycN2e9TcBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1750189084;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=Im16vMl+52aZ89i/Mx1sIb+7xJs54AQAEJk4FfHBJg8=;
	b=XsKFG83CPy4jJ70CxOs1yUGM+xjnQ5UhkCocyfnbpsFi+hCbSX12oUX2h4gA0DscWVX8qR
	PVNS2152qW1NaDpynJx0JQPRFWpqFflYdKjHPmeqLBqGtLLbUPQBlSmgViSJ7Ccd8Luqpn
	+cwO7TKOHfOgnTxJpJZsLA6uX+Xmq94WwCAv6M7wLqnB1kzfiNrXADmNCriBL9EnYyC0wC
	IniST7WbDffe2ET/cq7BBBpLkpqilfXF2Db/fPEJkA3Ebbz9ny3zWch5uOcl0/WdyqnhtL
	20I6R7GJnNr+Ynyr4sPqgRLUuyJUg45dYgMApnQt1KHhZA3omUYEaVOMo9qfqw==
ARC-Authentication-Results: i=1;
	rspamd-5859dfb5d9-x6kxz;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Turn-Ruddy: 72b8f95d607b6500_1750189084452_3908980255
X-MC-Loop-Signature: 1750189084452:3693413435
X-MC-Ingress-Time: 1750189084452
Received: from pdx1-sub0-mail-a289.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.195.184 (trex/7.0.3);
	Tue, 17 Jun 2025 19:38:04 +0000
Received: from offworld.lan (syn-076-167-199-067.res.spectrum.com [76.167.199.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a289.dreamhost.com (Postfix) with ESMTPSA id 4bMHGM00sfzJX;
	Tue, 17 Jun 2025 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1750189083;
	bh=Im16vMl+52aZ89i/Mx1sIb+7xJs54AQAEJk4FfHBJg8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=cmf8kQuYHax/sSg0Skoqxm7TzkHzds0uKqTb6rwcvoIVfdPakHypUP10+rSzMRWWa
	 N1JwP3/ribcj7wYWPpIUkGk1SOW3FbCBvmbQH7rn2cJk+b8hb13flDe2w7X6UFZyGN
	 FvsdHMSAEiVv2VIgI8UOOWWEaR1Uwk2ChQvfj5CCc4iHwkwu5TuHTUlid4635y+Vb8
	 esrqmLe5UdaKVb6iu9JsR2vYvuphs5nMwaw+qYgQsb8rS7WBRf+JANewGZXYjAEih+
	 tBklnvmUN6oWEfnIgoQHvSArKwcGl2SWOomdA4RBnLszbd+OYbadjaFhrv2khdGiZl
	 0hKmGOLGlJExw==
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
Subject: [PATCH 4/7] cxl/mbox: Stronger cxl_mbox_background_complete() semantics
Date: Tue, 17 Jun 2025 12:36:08 -0700
Message-Id: <20250617193611.564668-5-dave@stgolabs.net>
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

Account for all situations where hw has no on-going background
command. Current semantics do no change with this patch, but will
serve for later supporting cancel requests. As such rename the
helper accordingly.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/pci.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 3e6c231e9a8b..3648efcc7c89 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -111,12 +111,12 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
 					 dev_id);
 }
 
-static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
+static bool cxl_mbox_background_done(struct cxl_dev_state *cxlds)
 {
 	u64 reg;
 
-	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
-	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
+	return FIELD_GET(CXLDEV_MBOX_STATUS_BG_CMD, reg) == 0;
 }
 
 static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
@@ -128,7 +128,7 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
 
-	if (!cxl_mbox_background_complete(cxlds))
+	if (!cxl_mbox_background_done(cxlds))
 		return IRQ_NONE;
 
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
@@ -158,7 +158,7 @@ static void cxl_mbox_bgpoll_work(struct work_struct *work)
 	struct cxl_mailbox *cxl_mbox = &cxlds->cxl_mbox;
 
 	mutex_lock(&cxl_mbox->mbox_mutex);
-	if (cxl_mbox_background_complete(cxlds)) {
+	if (cxl_mbox_background_done(cxlds)) {
 		mds->bg.poll_tmo_secs = 0;
 		if (mds->bg.opcode == CXL_MBOX_OP_SANITIZE)
 			sysfs_notify_dirent(mds->security.sanitize_node);
@@ -379,7 +379,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 
 	mutex_lock(&cxl_mbox->mbox_mutex);
 	/*
-	 * Ensure cxl_mbox_background_complete() checks are safe amongst
+	 * Ensure cxl_mbox_background_done() checks are safe amongst
 	 * each other: no new bg operation can occur in between while polling.
 	 */
 	if (cxl_is_background_cmd(mds, cmd->opcode)) {
@@ -408,7 +408,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 		timeout = cmd->poll_interval_ms;
 		for (i = 0; i < cmd->poll_count; i++) {
 			if (rcuwait_wait_event_timeout(&cxl_mbox->mbox_wait,
-				       cxl_mbox_background_complete(cxlds),
+				       cxl_mbox_background_done(cxlds),
 				       TASK_UNINTERRUPTIBLE,
 				       msecs_to_jiffies(timeout)) > 0)
 				break;
@@ -419,7 +419,7 @@ static int cxl_pci_mbox_send(struct cxl_mailbox *cxl_mbox,
 		 * until the next successful command submission and the driver
 		 * can get back in sync with the hardware state.
 		 */
-		if (!cxl_mbox_background_complete(cxlds)) {
+		if (!cxl_mbox_background_done(cxlds)) {
 			dev_err(dev, "timeout waiting for background (%d ms)\n",
 				timeout * cmd->poll_count);
 			rc = -ETIMEDOUT;
-- 
2.39.5

