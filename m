Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40C0EC77B7E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbjDUJz5 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231880AbjDUJzr (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:47 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211DEAD23
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:40 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 7996C5C06A2;
        Fri, 21 Apr 2023 09:55:39 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id F32B85C0921;
        Fri, 21 Apr 2023 09:55:36 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070939; a=rsa-sha256;
        cv=none;
        b=StyFcovHh0INJTQwy+bCsoczjhqyVCN3aeytHOjgnpgJeCa36oNEEBWZ4OB47dR1nyaMU1
        0l0dFTjPIS1oD+y8/P9Dltw4E0szPGKRaWPOMW36G5qvUf1PE27649ummr+VcwmgTgav7L
        NZTkIdod3NOnMVNtw+KPxbOtEn+/XgkSXJlgChnTqaKXmbMOqPS4K7/DE6LuC7fQiuinzu
        rnsdzclFUux26YE6Y9/6FuZ4SEAl1bvhpbozvxciFlBAigo92DZDJsE/Hdwi4RoQEUGJJM
        uZ1cMbteBPFU5cdSEJRXS6rA5eOodIBPxr9A2HVoVSZdtGCx8G1uP1QaCI5t2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070939;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=4Pae2xWs3xVr+5hrIjI80opMktp+CLoFa5aijS389mk=;
        b=51g7bEosKtOQJO/Bh0VQV5BiCgJ9dhyDJ4NzR2CVyucPm2CEoU+3RO80CO8vyTwjELDTe0
        W4stdEykBQNr+HCm/763S4wkyO2ajKLmB8AyLWHF6WX7vGiKik0n4StwmAMoa9NNpTIemT
        LlA+t1NTXnrmOzkWcoqziS4ezJarGSlRBz4KEF/Lwb3vMiRXsjmZ6dPG0NZZ2HTJHr5MW9
        D3u76PTYvuBQtdjsFWdGNSiwkg0om8jFvs/0u8qM5wdFCtZO3r1HEqe6e4bu4aJZfhB5hZ
        QQ/6+HTiYMdYujti5ipM4G6CHWp0n+meTSDM0iOj1PFgz1fY+q8WAebb451JQg==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-td2xh;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Dime-Juvenile: 349739d57aea7c3b_1682070939220_3026617073
X-MC-Loop-Signature: 1682070939220:272610871
X-MC-Ingress-Time: 1682070939220
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.36 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:39 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qf00qpGzbj;
        Fri, 21 Apr 2023 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070936;
        bh=4Pae2xWs3xVr+5hrIjI80opMktp+CLoFa5aijS389mk=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=EnyLvuyN95Eqq54y5l9Ox0N3h3c7pcTN+HjUCbRLkBnathnKNH2nB3qheJ8rZmosR
         D4Z1hFDw5sTRNWpZ4UKcgBS5siWU+idS8wMnpPJHi4xOmTPCR4Q6AC2RLWlBg0PvUr
         mS7z6IZLBrNX6Ni/veo99qv7VO3FjWNh5ku6VYVOgMg4Sln6h7DkEROKYaoeXjAoDM
         MZUelv2dVTHGwVD6VBuJtrc+P0TpZ9F0/K/b5lt1/hpD/gtiuUDU9l8v+oAPiT7gJY
         u5z6qbYpSc8AeMtW0px+lMkFrraBqJI6m13Yr0wqvH+BffO1v99f4ZLP6S/vNGoo05
         0u+DuUcYiDAfQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 3/7] cxl/mbox: Add sanitation handling machinery
Date:   Fri, 21 Apr 2023 02:23:17 -0700
Message-Id: <20230421092321.12741-4-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
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
 drivers/cxl/cxlmem.h | 16 +++++++++
 drivers/cxl/pci.c    | 79 ++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 93 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8c3302fc7738..17e3ab3c641a 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -220,6 +220,18 @@ struct cxl_event_state {
 	struct mutex log_lock;
 };
 
+/**
+ * struct cxl_security_state - Device security state
+ *
+ * @sanitize_dwork: self-polling work item for sanitation
+ * @sanitize_tmo: self-polling timeout
+ */
+struct cxl_security_state {
+	/* below only used if device mbox irqs are not supported */
+	struct delayed_work sanitize_dwork;
+	int sanitize_tmo;
+};
+
 /**
  * struct cxl_dev_state - The driver device state
  *
@@ -256,6 +268,7 @@ struct cxl_event_state {
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
  * @event: event log driver state
+ * @sec: device security state
  * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
@@ -296,6 +309,8 @@ struct cxl_dev_state {
 
 	struct cxl_event_state event;
 
+	struct cxl_security_state sec;
+
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
 };
 
@@ -327,6 +342,7 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index aa1bb74a52a1..bdee5273af5a 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -97,6 +97,8 @@ static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
 static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 {
 	struct cxl_dev_state *cxlds = id;
+	u64 reg;
+	u16 opcode;
 
 	/* spurious or raced with hw? */
 	if (!cxl_mbox_background_complete(cxlds)) {
@@ -107,12 +109,47 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 		goto done;
 	}
 
-	/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-	wake_up(&mbox_wait);
+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+
+	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
+	} else {
+		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+		wake_up(&mbox_wait);
+	}
 done:
 	return IRQ_HANDLED;
 }
 
+/*
+ * Sanitation operation polling mode.
+ */
+static void cxl_mbox_sanitize_work(struct work_struct *work)
+{
+	struct cxl_dev_state *cxlds;
+
+	cxlds = container_of(work, struct cxl_dev_state,
+			     sec.sanitize_dwork.work);
+
+	WARN_ON(cxlds->sec.sanitize_tmo == -1);
+
+	mutex_lock(&cxlds->mbox_mutex);
+	if (cxl_mbox_background_complete(cxlds)) {
+		cxlds->sec.sanitize_tmo = 0;
+		put_device(cxlds->dev);
+
+		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
+	} else {
+		int tmo = cxlds->sec.sanitize_tmo + 10;
+
+		cxlds->sec.sanitize_tmo = min(15 * 60, tmo);
+		queue_delayed_work(system_wq,
+				   &cxlds->sec.sanitize_dwork, tmo * HZ);
+	}
+	mutex_unlock(&cxlds->mbox_mutex);
+}
+
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
  * @cxlds: The device state to communicate with.
@@ -173,6 +210,16 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		return -EBUSY;
 	}
 
+	/*
+	 * With sanitize polling, hardware might be done and the poller still
+	 * not be in sync. Ensure no new command comes in until so. Keep the
+	 * hardware semantics and only allow device health status.
+	 */
+	if (unlikely(cxlds->sec.sanitize_tmo > 0)) {
+		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
+			return -EBUSY;
+	}
+
 	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
 			     mbox_cmd->opcode);
 	if (mbox_cmd->size_in) {
@@ -223,6 +270,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_dev_state *cxlds,
 		u64 bg_status_reg;
 		int i;
 
+		/*
+		 * Sanitation is a special case which monopolizes the device
+		 * in an uninterruptible state and thus cannot be timesliced.
+		 * Return immediately instead and allow userspace to poll(2)
+		 * for completion.
+		 */
+		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
+			if (cxlds->sec.sanitize_tmo != -1) {
+				/* give first timeout a second */
+				cxlds->sec.sanitize_tmo = 1;
+				/* hold the device throughout */
+				get_device(cxlds->dev);
+				queue_delayed_work(system_wq,
+						   &cxlds->sec.sanitize_dwork,
+						   cxlds->sec.sanitize_tmo * HZ);
+			}
+
+			dev_dbg(dev, "Sanitation operation started\n");
+			return 0;
+		}
+
 		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
 			mbox_cmd->opcode);
 
@@ -366,6 +434,9 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 		if (rc)
 			goto mbox_poll;
 
+		/* flag that irqs are enabled */
+		cxlds->sec.sanitize_tmo = -1;
+
 		writel(CXLDEV_MBOX_CTRL_BG_CMD_IRQ,
 		       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
@@ -373,7 +444,11 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 	}
 
 mbox_poll:
+	INIT_DELAYED_WORK(&cxlds->sec.sanitize_dwork,
+			  cxl_mbox_sanitize_work);
+	cxlds->sec.sanitize_tmo = 0;
 	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
+
 	return 0;
 }
 
-- 
2.40.0

