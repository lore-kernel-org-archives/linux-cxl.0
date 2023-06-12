Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7C63C7EE2E
	for <linux-cxl@archiver.kernel.org>; Mon, 12 Jun 2023 18:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbjFLSpa (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 12 Jun 2023 14:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjFLSp3 (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 12 Jun 2023 14:45:29 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9137189
        for <linux-cxl@vger.kernel.org>; Mon, 12 Jun 2023 11:45:27 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D1B546C2BD3;
        Mon, 12 Jun 2023 18:45:25 +0000 (UTC)
Received: from pdx1-sub0-mail-a316.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 08BC36C1C6B;
        Mon, 12 Jun 2023 18:45:25 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1686595525; a=rsa-sha256;
        cv=none;
        b=1E92gjjqBc4w2jg/gBlPAbfU/FA5Oo93nhiuH6Va23l/CMUgLV2mBasNrOWP/RyPWhYsxK
        xuvTVIA4xudvofvm/P5OzlE9Nf0ktJSnqwL2ZNWYLYukuqUgQTCThYp/a61po80C0cQmZo
        KigHfzSFD5xmLhtxL7qqbgD4TnGNfamNcZC+7mpHyhL0gzQoYt/4yG/7KP1MHeUGNqcjOz
        E6PtGcax3fslyfi8b9Vy9UGHuJyJKJdmlJvugDRLArSes/Z5RoEmvsVpGctPbHAe3Y5jsg
        +rH2NLZhlbhL/kaxdpKhkXvoTGn8J0pJj+Cs4Zq1PO/LsILP0AmbCDW+YErsNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1686595525;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=qxA8rkRFgSymGiwMHWm5egB5lIREURj6avGFeswDpLM=;
        b=HVSKI8fkf6kzvPHbIepXBOnkr2zd0Ft9Sh5vGEMXgw9uHraL8e70e+gW1q2+EcsJYTQW5A
        DhMM3aufVmCl0qspqYKeYAkRayPQHXSjdszCYqjHnXFi8Vv+sjW1lboPVUdqGYZzpWXz7q
        6g6GkiOSW+I1mu1gOAlNUEYikgWLg/lRAPCshRwlSZj0bCI/hWxZwuxaFL76joc27ISES7
        Qaa1/PqS3Tzv0Hnu4WG5pNACZFb66dNq12xavLStVucXSfUXw5bU3Yyf4fv8LT9JNV6Vxh
        rkLdAMskAP4EERy3rAiuBKh8d9Q42f7zwp0cOdAIXBssFjnYQMsG+t9kdMm9Gw==
ARC-Authentication-Results: i=1;
        rspamd-6c69b8658d-szjxp;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Stretch-Macabre: 396dc7040a5bf952_1686595525679_3940440547
X-MC-Loop-Signature: 1686595525679:2227229573
X-MC-Ingress-Time: 1686595525679
Received: from pdx1-sub0-mail-a316.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.98 (trex/6.8.1);
        Mon, 12 Jun 2023 18:45:25 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a316.dreamhost.com (Postfix) with ESMTPSA id 4Qg0xJ2pW1z63;
        Mon, 12 Jun 2023 11:45:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1686595524;
        bh=qxA8rkRFgSymGiwMHWm5egB5lIREURj6avGFeswDpLM=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=mAF4m5hvmcOVM2K5sqmX0fwetfzMzc/IN2uoeVacVHzyrH589rKI2mpTmtfnAVpL8
         NvjoFQzxvc/5eUP4J3oJVdHhdkE5IxRMfBeqsGXIi7+W+XhTNv/oJlH0qJW2JPPtl6
         tsVZNxviLg2Xyg/eKgsAOypi92dqRrmSpznRV7rb0JnAfdXHZ8V0vvOLVtIO5kzjAy
         W9GFJdpcF7DQrISoeXaj+1rxWzxxq5qZlLjxt9R2rMNVqANUClcWMrBrB9cG+QzKTO
         1KVmykFtIeIVSptT4JVaCPfvbKl1GTWb1PL39dnuc/DXIdljVfu9PdVu8vwbpc1jA6
         usRms4hJqK+yg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     dave.jiang@intel.com, vishal.l.verma@intel.com,
        Jonathan.Cameron@huawei.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Date:   Mon, 12 Jun 2023 11:10:35 -0700
Message-ID: <20230612181038.14421-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230612181038.14421-1-dave@stgolabs.net>
References: <20230612181038.14421-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
adding a security/sanitize' memdev sysfs file to trigger the operation
and extend the status file to make it poll(2)-capable for completion.
Unlike all other background commands, this is the only operation that
is special and monopolizes the device for long periods of time.

In addition to the traditional pmem security requirements, all regions
must also be offline in order to perform the operation. This permits
avoiding explicit global CPU cache management, relying instead on
attach_target() setting CXL_REGION_F_INCOHERENT upon reconnect.

The expectation is that userspace can use it such as:

    cxl disable-memdev memX
    echo 1 > /sys/bus/cxl/devices/memX/security/sanitize
    cxl wait-sanitize memX
    cxl enable-memdev memX

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 21 +++++++-
 drivers/cxl/core/mbox.c                 | 55 ++++++++++++++++++++
 drivers/cxl/core/memdev.c               | 67 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  4 ++
 drivers/cxl/pci.c                       |  6 +++
 5 files changed, 151 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 721a44d8a482..5753cba98692 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -64,8 +64,25 @@ KernelVersion:	v6.5
 Contact:	linux-cxl@vger.kernel.org
 Description:
 		(RO) Reading this file will display the CXL security state for
-		that device. Such states can be: 'disabled', or those available
-		only for persistent memory: 'locked', 'unlocked' or 'frozen'.
+		that device. Such states can be: 'disabled', 'sanitize', when
+		a sanitation is currently underway; or those available only
+		for persistent memory: 'locked', 'unlocked' or 'frozen'. This
+		sysfs entry is select/poll capable from userspace to notify
+		upon completion of a sanitize operation.
+
+
+What:           /sys/bus/cxl/devices/memX/security/sanitize
+Date:           June, 2023
+KernelVersion:  v6.5
+Contact:        linux-cxl@vger.kernel.org
+Description:
+		(WO) Write a boolean 'true' string value to this attribute to
+		sanitize the device to securely re-purpose or decommission it.
+		This is done by ensuring that all user data and meta-data,
+		whether it resides in persistent capacity, volatile capacity,
+		or the LSA, is made permanently unavailable by whatever means
+		is appropriate for the media type. This functionality requires
+		the device to be not be actively decoding any HPA ranges.
 
 
 What:		/sys/bus/cxl/devices/*/devtype
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 5993261e3e08..51c64829f20a 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1075,6 +1075,61 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
+/**
+ * cxl_mem_sanitize() - Send a sanitation command to the device.
+ * @cxlds: The device data for the operation
+ * @cmd: The specific sanitation command opcode
+ *
+ * Return: 0 if the command was executed successfully, regardless of
+ * whether or not the actual security operation is done in the background,
+ * such as for the Sanitize case.
+ * Error return values can be the result of the mailbox command, -EINVAL
+ * when security requirements are not met or invalid contexts.
+ *
+ * See CXL 3.0 @8.2.9.8.5.1 Sanitize and @8.2.9.8.5.2 Secure Erase.
+ */
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd)
+{
+	int rc;
+	u32 sec_out = 0;
+	struct cxl_get_security_output {
+		__le32 flags;
+	} out;
+	struct cxl_mbox_cmd sec_cmd = {
+		.opcode = CXL_MBOX_OP_GET_SECURITY_STATE,
+		.payload_out = &out,
+		.size_out = sizeof(out),
+	};
+	struct cxl_mbox_cmd mbox_cmd = { .opcode = cmd };
+
+	if (cmd != CXL_MBOX_OP_SANITIZE)
+		return -EINVAL;
+
+	rc = cxl_internal_send_cmd(cxlds, &sec_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
+		return rc;
+	}
+
+	/*
+	 * Prior to using these commands, any security applied to
+	 * the user data areas of the device shall be DISABLED (or
+	 * UNLOCKED for secure erase case).
+	 */
+	sec_out = le32_to_cpu(out.flags);
+	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
+		return -EINVAL;
+
+	rc = cxl_internal_send_cmd(cxlds, &mbox_cmd);
+	if (rc < 0) {
+		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
+		return rc;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 834f418b6bcb..bdd1edfd62e8 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /* Copyright(c) 2020 Intel Corporation. */
 
+#include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/device.h>
 #include <linux/slab.h>
 #include <linux/idr.h>
@@ -114,6 +115,12 @@ static ssize_t security_state_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	unsigned long state = cxlds->security.state;
+	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
+	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+
+	if (cmd == CXL_MBOX_OP_SANITIZE && pct != 100)
+		return sysfs_emit(buf, "sanitize\n");
 
 	if (!(state & CXL_PMEM_SEC_STATE_USER_PASS_SET))
 		return sysfs_emit(buf, "disabled\n");
@@ -129,6 +136,33 @@ static ssize_t security_state_show(struct device *dev,
 static struct device_attribute dev_attr_security_state =
 	__ATTR(state, 0444, security_state_show, NULL);
 
+static ssize_t security_sanitize_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
+	ssize_t rc;
+	bool sanitize;
+
+	if (kstrtobool(buf, &sanitize) || !sanitize)
+		return -EINVAL;
+
+	if (!port || !is_cxl_endpoint(port))
+		return -EINVAL;
+
+	/* ensure no regions are mapped to this memdev */
+	if (port->commit_end != -1)
+		return -EBUSY;
+
+	rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
+
+	return rc ? rc : len;
+}
+static struct device_attribute dev_attr_security_sanitize =
+	__ATTR(sanitize, 0200, NULL, security_sanitize_store);
+
 static int cxl_get_poison_by_memdev(struct cxl_memdev *cxlmd)
 {
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
@@ -376,6 +410,7 @@ static struct attribute *cxl_memdev_ram_attributes[] = {
 
 static struct attribute *cxl_memdev_security_attributes[] = {
 	&dev_attr_security_state.attr,
+	&dev_attr_security_sanitize.attr,
 	NULL,
 };
 
@@ -594,6 +629,34 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
+static void put_sanitize(void *data)
+{
+	struct cxl_dev_state *cxlds = data;
+
+	sysfs_put(cxlds->security.sanitize_node);
+}
+
+static int cxl_memdev_security_init(struct cxl_memdev *cxlmd)
+{
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct device *dev = &cxlmd->dev;
+	struct kernfs_node *sec;
+
+	sec = sysfs_get_dirent(dev->kobj.sd, "security");
+	if (!sec) {
+		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
+		return -ENODEV;
+	}
+	cxlds->security.sanitize_node = sysfs_get_dirent(sec, "state");
+	sysfs_put(sec);
+	if (!cxlds->security.sanitize_node) {
+		dev_err(dev, "sysfs_get_dirent 'state' failed\n");
+		return -ENODEV;
+	}
+
+	return devm_add_action_or_reset(cxlds->dev, put_sanitize, cxlds);
+ }
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
@@ -622,6 +685,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	if (rc)
 		goto err;
 
+	rc = cxl_memdev_security_init(cxlmd);
+	if (rc)
+		goto err;
+
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 3a9df1044144..177a76578a94 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -267,12 +267,14 @@ struct cxl_poison_state {
  * @poll: polling for sanitation is enabled, device has no mbox irq support
  * @poll_tmo_secs: polling timeout
  * @poll_dwork: polling work item
+ * @sanitize_node: sanitation sysfs file to notify
  */
 struct cxl_security_state {
 	unsigned long state;
 	bool poll;
 	int poll_tmo_secs;
 	struct delayed_work poll_dwork;
+	struct kernfs_node *sanitize_node;
 };
 
 /**
@@ -746,6 +748,8 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd);
+
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index c92eab55a5a7..d1df23c19245 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -126,6 +126,9 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		if (cxlds->security.sanitize_node)
+			sysfs_notify_dirent(cxlds->security.sanitize_node);
+
 		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
@@ -150,6 +153,9 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		cxlds->security.poll_tmo_secs = 0;
 		put_device(cxlds->dev);
 
+		if (cxlds->security.sanitize_node)
+			sysfs_notify_dirent(cxlds->security.sanitize_node);
+
 		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
 	} else {
 		int timeout = cxlds->security.poll_tmo_secs + 10;
-- 
2.41.0

