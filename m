Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA81C7618E
	for <linux-cxl@archiver.kernel.org>; Fri, 21 Apr 2023 09:55:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjDUJzz (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 21 Apr 2023 05:55:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231911AbjDUJzq (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 21 Apr 2023 05:55:46 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0116BA5F4
        for <linux-cxl@vger.kernel.org>; Fri, 21 Apr 2023 02:55:38 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 52818540ED0;
        Fri, 21 Apr 2023 09:55:38 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id D08EC54106B;
        Fri, 21 Apr 2023 09:55:37 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1682070937; a=rsa-sha256;
        cv=none;
        b=F4aTRXoZVRSHEuay7Qp9HSxp6xRuVLcTMByUFSqJTHBpGHQMbZFNJGFaxvvYqaVFm3k6PV
        XmkRqbXPWpGGfT5zPkYja65/TeSyaED6oytsPDYfMkObvUgWoJyyFW63IMUqKbLacYNleF
        Dzh1cwmG5nvZViBRUh98UpwyCTIQjyhVzlE4Nvpt78+psLgloolQP594ys7lRzyA19oRUq
        yuQh3jLCG+pCcMY7eaItpOohn7Nm26H4iuXIkBCWRucUZ0t1RFvAFl5EPdc0t/sT7bQOEJ
        2aORTPnwCPa9lafmripizOK1HNw9ov7iTP+G+X4BAO51SOEnlJBNU5RgkpsSFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1682070937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=zCBMku3VfGgdCn7ZYe97U5lc/YO7zF1eaw/7wbhx38I=;
        b=JGVWa/uHHH0wPcPu8OpUYqrgy8F4CYl35Ok5XPiQpCO0enJ7zEC6AEAoKPb3Ni5rfwsDNG
        zEaC0v4vZfxCUTEw73J0XaSZN3rlQPwbAMbA6epZPk+1MVbnKPFdKHCj8UD1nv6haqEJVq
        qclfh4VE/n/QoP/m0xCi9a2K8PAdHvTgcFRP7s3AiV5BosS41jOxrWQJyYLVOk3OU4mX7t
        MofqOm3HGMnvUUvSDH6pOz/YgtwAS0mJAktnyvnNEP1lWPf2tNfu5Qq8PVP3IMzC7EgX0l
        4pETWS7lJf9A0KW1iFybFI4rFs704iq13kAI0FlVXluPLenvnkDr9B37SurfSQ==
ARC-Authentication-Results: i=1;
        rspamd-7f66b7b68c-zn4rt;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Broad-Society: 1a9a17d7714e0577_1682070938185_1637246552
X-MC-Loop-Signature: 1682070938185:2122748479
X-MC-Ingress-Time: 1682070938185
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.36 (trex/6.7.2);
        Fri, 21 Apr 2023 09:55:38 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4Q2qf06wQcz2F;
        Fri, 21 Apr 2023 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1682070937;
        bh=zCBMku3VfGgdCn7ZYe97U5lc/YO7zF1eaw/7wbhx38I=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=p7bzkLFJ43Kre5Dw5PGgiK4j2QnsFOa7oJRY9L56s2aeek4r1GuKrqk9pqbZ364By
         cm2k3I9qXqkoLCCPSJTUezs3aQsJCRHmAxz65Y+k2MKRvYcZfUQTkJZdFoyt2YMd5o
         awvyLi8P4NMs0eUQsIbdh7rxVbUPnMBKJjYTBR3o95z0PynpU8ns4hBc1lC15DA33c
         Lu7VCZcdsvDtHCS0iFnMMX86nSR/f2NVUdCBMtsLhTU9UrFzIWeYhMP7T01wGxtrQo
         fMzxwK2KTCp+3IowlANW+Y3qCelvzQzUKACnUIdcj15Qw7P3gvkUS1Kb15AMggMrr3
         Kfo+VW1nYOw6g==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     Jonathan.Cameron@huawei.com, dave.jiang@intel.com,
        alison.schofield@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 4/7] cxl/mem: Wire up Sanitation support
Date:   Fri, 21 Apr 2023 02:23:18 -0700
Message-Id: <20230421092321.12741-5-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421092321.12741-1-dave@stgolabs.net>
References: <20230421092321.12741-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement support for CXL 3.0 8.2.9.8.5.1 Sanitize. This is done by
adding a security/sanitize' memdev sysfs file, which is poll(2)-capable
for completion. Unlike all other background commands, this is the
only operation that is special and monopolizes the device for long
periods of time.

In addition to the traditional pmem security requirements, all regions
must also be offline in order to perform the operation. This permits
avoiding explicit global CPU cache management, relying instead on
attach_target() setting CXL_REGION_F_INCOHERENT upon reconnect.

The expectation is that userspace can use it such as:

    cxl disable-memdev memX
    echo 1 > /sys/bus/cxl/devices/memX/security/sanitize
    cxl wait-sanitize memX
    cxl enable-memdev memX

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl | 19 ++++++
 drivers/cxl/core/mbox.c                 | 56 ++++++++++++++++
 drivers/cxl/core/memdev.c               | 86 +++++++++++++++++++++++++
 drivers/cxl/cxlmem.h                    |  4 ++
 drivers/cxl/pci.c                       |  5 ++
 5 files changed, 170 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 3acf2f17a73f..2e98ec9220ca 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -58,6 +58,25 @@ Description:
 		affinity for this device.
 
 
+What:           /sys/bus/cxl/devices/memX/security/sanitize
+Date:           May, 2023
+KernelVersion:  v6.5
+Contact:        linux-cxl@vger.kernel.org
+Description:
+		(RW) Write a boolean 'true' string value to this attribute to
+		sanitize the device to securely re-purpose or decommission it.
+		This is done by ensuring that all user data and meta-data,
+		whether it resides in persistent capacity, volatile capacity,
+		or the LSA, is made permanently unavailable by whatever means
+		is appropriate for the media type. This functionality requires
+		the device to be not be actively decoding any HPA ranges.
+
+		Reading this file shows either "disabled" when not running, or
+		"sanitize" during the duration of the sanitize operation. This
+		sysfs entry is select/poll capable from userspace to notify upon
+		completion.
+
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index cde7270c6037..28daf7dcdec4 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -1021,6 +1021,62 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
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
+ * when security requirements are not met or invalid contexts, or -EBUSY
+ * if the device is not offline.
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
index 28a05f2fe32d..70e7158826c9 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -89,6 +89,55 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
 static struct device_attribute dev_attr_pmem_size =
 	__ATTR(size, 0444, pmem_size_show, NULL);
 
+static ssize_t security_sanitize_show(struct device *dev,
+				      struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
+	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+
+	if (cmd == CXL_MBOX_OP_SANITIZE && pct != 100)
+		return sysfs_emit(buf, "sanitize\n");
+	else
+		return sysfs_emit(buf, "disabled\n");
+}
+
+static ssize_t security_sanitize_store(struct device *dev,
+				       struct device_attribute *attr,
+				       const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	ssize_t rc;
+	bool sanitize;
+
+	rc = kstrtobool(buf, &sanitize);
+	if (rc)
+		return rc;
+
+	if (sanitize) {
+		struct cxl_port *port = dev_get_drvdata(&cxlmd->dev);
+
+		if (!port || !is_cxl_endpoint(port))
+			return -EINVAL;
+		/* ensure no regions are mapped to this memdev */
+		if (port->commit_end != -1)
+			return -EBUSY;
+
+		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
+	}
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}
+
+static struct device_attribute dev_attr_security_sanitize =
+	__ATTR(sanitize, 0644,
+	       security_sanitize_show, security_sanitize_store);
+
 static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
 			   char *buf)
 {
@@ -148,10 +197,21 @@ static struct attribute_group cxl_memdev_pmem_attribute_group = {
 	.attrs = cxl_memdev_pmem_attributes,
 };
 
+static struct attribute *cxl_memdev_security_attributes[] = {
+	&dev_attr_security_sanitize.attr,
+	NULL,
+};
+
+static struct attribute_group cxl_memdev_security_attribute_group = {
+	.name = "security",
+	.attrs = cxl_memdev_security_attributes,
+};
+
 static const struct attribute_group *cxl_memdev_attribute_groups[] = {
 	&cxl_memdev_attribute_group,
 	&cxl_memdev_ram_attribute_group,
 	&cxl_memdev_pmem_attribute_group,
+	&cxl_memdev_security_attribute_group,
 	NULL,
 };
 
@@ -324,11 +384,19 @@ static const struct file_operations cxl_memdev_fops = {
 	.llseek = noop_llseek,
 };
 
+static void put_sanitize(void *data)
+{
+	struct cxl_dev_state *cxlds = data;
+
+	sysfs_put(cxlds->sec.sanitize_state);
+}
+
 struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 {
 	struct cxl_memdev *cxlmd;
 	struct device *dev;
 	struct cdev *cdev;
+	struct kernfs_node *sec;
 	int rc;
 
 	cxlmd = cxl_memdev_alloc(cxlds, &cxl_memdev_fops);
@@ -355,6 +423,24 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	rc = devm_add_action_or_reset(cxlds->dev, cxl_memdev_unregister, cxlmd);
 	if (rc)
 		return ERR_PTR(rc);
+
+	sec = sysfs_get_dirent(dev->kobj.sd, "security");
+	if (!sec) {
+		dev_err(dev, "sysfs_get_dirent 'security' failed\n");
+		rc = -ENODEV;
+		goto err;
+	}
+	cxlds->sec.sanitize_state = sysfs_get_dirent(sec, "sanitize");
+	sysfs_put(sec);
+	if (!cxlds->sec.sanitize_state) {
+		dev_err(dev, "sysfs_get_dirent 'sanitize' failed\n");
+		rc = -ENODEV;
+		goto err;
+	}
+	rc = devm_add_action_or_reset(cxlds->dev, put_sanitize, cxlds);
+	if (rc)
+		return ERR_PTR(rc);
+
 	return cxlmd;
 
 err:
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 17e3ab3c641a..9bd33cfdc0ec 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -223,10 +223,12 @@ struct cxl_event_state {
 /**
  * struct cxl_security_state - Device security state
  *
+ * @sanitize_state: sanitation sysfs file to notify
  * @sanitize_dwork: self-polling work item for sanitation
  * @sanitize_tmo: self-polling timeout
  */
 struct cxl_security_state {
+	struct kernfs_node *sanitize_state;
 	/* below only used if device mbox irqs are not supported */
 	struct delayed_work sanitize_dwork;
 	int sanitize_tmo;
@@ -642,6 +644,8 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd);
+
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bdee5273af5a..2bc3b595f270 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -113,6 +113,9 @@ static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
 	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		if (cxlds->sec.sanitize_state)
+			sysfs_notify_dirent(cxlds->sec.sanitize_state);
+
 		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
 	} else {
 		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
@@ -138,6 +141,8 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 	if (cxl_mbox_background_complete(cxlds)) {
 		cxlds->sec.sanitize_tmo = 0;
 		put_device(cxlds->dev);
+		if (cxlds->sec.sanitize_state)
+			sysfs_notify_dirent(cxlds->sec.sanitize_state);
 
 		dev_dbg(cxlds->dev, "Sanitation operation ended\n");
 	} else {
-- 
2.40.0

