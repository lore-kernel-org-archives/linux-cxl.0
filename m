Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B09C63703
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 01:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233056AbiLFBPc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233105AbiLFBPa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 20:15:30 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134E41C43A
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 17:15:15 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id CD6C75C10CB;
        Tue,  6 Dec 2022 01:15:14 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 4DA9E5C17A5;
        Tue,  6 Dec 2022 01:15:10 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670289310; a=rsa-sha256;
        cv=none;
        b=2yDTD0fH1KCQEia8GvaihgZrajK/ipfX/7quAHa1hUZqCehGJeHwVr4HyqZy8M6TQb+CcO
        0k2zbnaEwQ/Kw5pwCEWdCQiR7pBIe2n9dHQNMXtx0ULEAvhsITS9W7a+JWGe+rqrX4+RMR
        GX5refLjhd/rW4pfeOkl62JTLDpUjTTuHsOq9o4VLitoExoAp5tJ/vdJMfrnQl6E0XpYhQ
        0iANqocx7SPN/jCfVK33ZaJhrhu/ECFAAfSKcy9d8vFhBDqH03TKJ+BJmRYCRdNllIRFWZ
        LIJ6VTgD4lnGYP8Fc8mEcM9CNUZE0ej8pJaWJLxBBA8Ps1KYVtP7cw4PvOo2zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670289310;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=7OhDJEkZsxI44+tm9bGiRQCVVJ5T6AGtZVD0+CZgVlQ=;
        b=a4/3DT1/A/061bl4+xKiI7TcK6RTto5Xwem5k1HMjPjRnrV97FHKsXDgFa1H7nDslWvMtZ
        oWmzIXx9kiiPEyBHz7GhejEJDzQ3w62btv4QQRRRsZ/HMjl8zcXychrJZDp3cdClQs/wd9
        i8mmnTgaBZ2r79QSvUpU8uffCvn9LQnWVjq3KL8WvwkwULspd7fD5BCblXJSyc58zZoo5P
        5kV+UgwugDUx3JmIQrgT1TnNOoQs6HTevbfw6ez7DH0riljapJAtdw/60RuJl9wUhjd+S6
        35lBjp4LCGXLF0/GD15jSvn4ALlQoZyPSL1jDUwntR2GOpaloXUXExQVzcj9SA==
ARC-Authentication-Results: i=1;
        rspamd-7bd68c5946-5mzh2;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Language: 28ef28492b7fffb4_1670289310648_3915094672
X-MC-Loop-Signature: 1670289310648:320980742
X-MC-Ingress-Time: 1670289310648
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.126.30.34 (trex/6.7.1);
        Tue, 06 Dec 2022 01:15:10 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4NR2XF4SPKzHn;
        Mon,  5 Dec 2022 17:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670289310;
        bh=7OhDJEkZsxI44+tm9bGiRQCVVJ5T6AGtZVD0+CZgVlQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=KQ9lr3YW+f4NV7FgGjPSi1a7stGlOWKn24eSSmZWP3MOhE9WcUIOrsmwjff6hmnoH
         OwZsH2t7eh0mmDxzYvJEdSlwPfzlL/VL9Qzu/S9af/xBlOSJldsfCvIKF8MyAch9Pe
         b+YKWZxkKa8+NtO6jQDIx3hZUcXxfz3HL4V7FWB3qAR01PeZ5ac8tN9Mg86AUCfV+b
         8eJiiy6q2MyzMDU3te2uB3baLq6Ix/LHSozxg2Y7lZrWqrdWjBT/36KU+xZEAa+fNU
         tuOtFnW1gqlS42vAvr9PJgtLzYFoRjAE2ztkeJq2O3hho9W/ym/JVlMavCb026zov3
         k5q1A4UfDhbZA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/3] cxl/mem: Support sanitation commands
Date:   Mon,  5 Dec 2022 17:15:00 -0800
Message-Id: <20221206011501.464916-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206011501.464916-1-dave@stgolabs.net>
References: <20221206011501.464916-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Implement support for the non-pmem exclusive sanitize (aka overwrite)
and secure erase commands, per CXL specs.

To properly support this feature, create a 'security' sysfs file that
when read will list the current pmem security state or overwrite, and
when written to, perform the requested operation.

As with ndctl-speak, the use cases here would be:

$> cxl sanitize --erase memX
$> cxl sanitize --overwrite memX
$> cxl sanitize --wait-overwrite memX

Where userspace can implement entirely the wait/query mechanism for
waiting for the sanitize to complete (albeit no poll support for
the security sysfs file).

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 Documentation/ABI/testing/sysfs-bus-cxl |  19 +++++
 drivers/cxl/core/mbox.c                 | 104 +++++++++++++++++++++++-
 drivers/cxl/core/memdev.c               |  54 ++++++++++++
 drivers/cxl/cxlmem.h                    |  10 +++
 include/uapi/linux/cxl_mem.h            |   2 +
 5 files changed, 188 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
index 8494ef27e8d2..18e26ae3d75f 100644
--- a/Documentation/ABI/testing/sysfs-bus-cxl
+++ b/Documentation/ABI/testing/sysfs-bus-cxl
@@ -58,6 +58,25 @@ Description:
 		affinity for this device.
 
 
+What:		/sys/bus/cxl/devices/memX/security
+Date:		December, 2022
+KernelVersion:	v6.2
+Contact:	linux-cxl@vger.kernel.org
+Description:
+		Reading this file will display the security state for that
+		device. The following states are available: disabled, frozen,
+		locked, unlocked and overwrite. When writing to the file, the
+		following commands are supported:
+		* overwrite - Sanitize the device to securely re-purpose or
+		  decommission it. This is done by ensuring that all user data
+		  and meta-data, whether it resides in persistent capacity,
+		  volatile capacity, or the label storage area, is made
+		  permanently unavailable by whatever means is appropriate for
+		  the media type. This causes all CPU caches to be flushed.
+		* erase - Secure Erase user data by changing the media encryption
+		  keys for all user data areas of the device. This causes all
+		  CPU caches to be flushed.
+
 What:		/sys/bus/cxl/devices/*/devtype
 Date:		June, 2021
 KernelVersion:	v5.14
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index bfee9251c81c..5ffdab10073d 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -4,6 +4,7 @@
 #include <linux/security.h>
 #include <linux/debugfs.h>
 #include <linux/mutex.h>
+#include <linux/memregion.h>
 #include <cxlmem.h>
 #include <cxl.h>
 
@@ -11,6 +12,7 @@
 
 static bool cxl_raw_allow_all;
 static struct workqueue_struct *cxl_mbox_bgpoll_wq;
+static struct cxl_mem_bgcommand_ops sanitize_bgops;
 
 /**
  * DOC: cxl mbox
@@ -70,6 +72,8 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
 	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
+	CXL_BGCMD(SANITIZE, 0, 0, 0, &sanitize_bgops),
+	CXL_CMD(SECURE_ERASE, 0, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
 	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
@@ -136,7 +140,6 @@ static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 	cxl_for_each_cmd(c)
 		if (c->opcode == opcode)
 			return c;
-
 	return NULL;
 }
 
@@ -887,6 +890,8 @@ int cxl_enumerate_cmds(struct cxl_dev_state *cxlds)
 	 * Setup permanently kernel exclusive commands, i.e. the
 	 * mechanism is driven through sysfs, keyctl, etc...
 	 */
+	set_bit(CXL_MEM_COMMAND_ID_SANITIZE, cxlds->exclusive_cmds);
+	set_bit(CXL_MEM_COMMAND_ID_SECURE_ERASE, cxlds->exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_SET_PASSPHRASE, cxlds->exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_DISABLE_PASSPHRASE, cxlds->exclusive_cmds);
 	set_bit(CXL_MEM_COMMAND_ID_UNLOCK, cxlds->exclusive_cmds);
@@ -970,6 +975,103 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_identify, CXL);
 
+static int sanitize_bgcmd_conflicts(u16 new)
+{
+	/* forbid anyone but health related commands */
+	if (new == CXL_MBOX_OP_GET_HEALTH_INFO)
+		return 0;
+	return -EBUSY;
+}
+
+static unsigned long sanitize_bgcmd_delay(struct cxl_dev_state *cxlds)
+{
+	unsigned int tmo;
+
+	if (!cxlds)
+		return 0;
+
+	tmo = cxlds->sec.sanitize_tmo + 10;
+	cxlds->sec.sanitize_tmo = min(15U * 60U, tmo);
+	return tmo * HZ;
+}
+
+static void sanitize_bgcmd_post(struct cxl_dev_state *cxlds, bool success)
+{
+	if (!cxlds->mbox_irq)
+		cxlds->sec.sanitize_tmo = 0;
+	if (success)
+		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+}
+
+static struct cxl_mem_bgcommand_ops sanitize_bgops = {
+	.conflicts = sanitize_bgcmd_conflicts,
+	.delay = sanitize_bgcmd_delay,
+	.post = sanitize_bgcmd_post,
+};
+
+/**
+ * cxl_mem_sanitize() - Send sanitation related commands to the device.
+ * @cxlds: The device data for the operation
+ * @op: The command opcode to send
+ *
+ * Return: 0 if the command was executed successfully, regardless of
+ * whether or not the actual security operation is done in the background.
+ * Upon error, return the result of the mailbox command or -EINVAL if
+ * security requirements are not met. CPU caches are flushed before and
+ * after succesful completion of each command.
+ *
+ * See CXL 2.0 @8.2.9.5.5 Sanitize.
+ */
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 op)
+{
+	int rc;
+	u32 sec_out;
+	struct cxl_mem_command *cmd;
+
+	cmd = cxl_mem_find_command(op);
+	if (!cmd || !test_bit(cmd->info.id, cxlds->enabled_cmds))
+		return -EINVAL;
+
+	if (!cpu_cache_has_invalidate_memregion())
+		return -EINVAL;
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE,
+			       NULL, 0, &sec_out, sizeof(sec_out), NULL);
+	if (rc)
+		return rc;
+
+	/*
+	 * Prior to using these commands, any security applied to
+	 * the user data areas of the device shall be DISABLED (or
+	 * UNLOCKED for secure erase case).
+	 */
+	if (sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET)
+		return -EINVAL;
+
+	if (op == CXL_MBOX_OP_SANITIZE) {
+		u16 ret_code; /* hw */
+
+		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+
+		rc = cxl_mbox_send_cmd(cxlds, op, NULL, 0, NULL, 0, &ret_code);
+		if (rc == 0 && ret_code != CXL_MBOX_CMD_RC_BACKGROUND)
+			cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	} else if (op == CXL_MBOX_OP_SECURE_ERASE) {
+		if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
+			return -EINVAL;
+
+		cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+
+		rc = cxl_mbox_send_cmd(cxlds, op, NULL, 0, NULL, 0, NULL);
+		if (rc == 0)
+			cpu_cache_invalidate_memregion(IORES_DESC_CXL);
+	} else
+		rc = -EINVAL;
+
+	return rc;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mem_sanitize, CXL);
+
 static int add_dpa_res(struct device *dev, struct resource *parent,
 		       struct resource *res, resource_size_t start,
 		       resource_size_t size, const char *type)
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 20ce488a7754..0b79c2b6720e 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -106,12 +106,66 @@ static ssize_t numa_node_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(numa_node);
 
+static ssize_t security_show(struct device *dev,
+			     struct device_attribute *attr, char *buf)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	u32 sec_out = 0;
+	int rc;
+
+	if (cxl_mbox_bgcmd_running(cxlds) == CXL_MBOX_OP_SANITIZE)
+		return sprintf(buf, "overwrite\n");
+
+	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE,
+			       NULL, 0, &sec_out, sizeof(sec_out), NULL);
+	if (rc)
+		return rc;
+
+	if (!(sec_out & CXL_PMEM_SEC_STATE_USER_PASS_SET))
+		return sprintf(buf, "disabled\n");
+	if (sec_out & CXL_PMEM_SEC_STATE_FROZEN)
+		return sprintf(buf, "frozen\n");
+	if (sec_out & CXL_PMEM_SEC_STATE_LOCKED)
+		return sprintf(buf, "locked\n");
+	else
+		return sprintf(buf, "unlocked\n");
+}
+
+#define CXL_SEC_CMD_SIZE 32
+static ssize_t security_store(struct device *dev,
+			      struct device_attribute *attr,
+			      const char *buf, size_t len)
+{
+	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	char cmd[CXL_SEC_CMD_SIZE+1];
+	ssize_t rc;
+
+	rc = sscanf(buf, "%"__stringify(CXL_SEC_CMD_SIZE)"s", cmd);
+	if (rc < 1)
+		return -EINVAL;
+
+	if (sysfs_streq(cmd, "overwrite"))
+		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SANITIZE);
+	else if (sysfs_streq(cmd, "erase"))
+		rc = cxl_mem_sanitize(cxlds, CXL_MBOX_OP_SECURE_ERASE);
+	else
+		rc = -EINVAL;
+
+	if (rc == 0)
+		rc = len;
+	return rc;
+}
+static DEVICE_ATTR_RW(security);
+
 static struct attribute *cxl_memdev_attributes[] = {
 	&dev_attr_serial.attr,
 	&dev_attr_firmware_version.attr,
 	&dev_attr_payload_max.attr,
 	&dev_attr_label_storage_size.attr,
 	&dev_attr_numa_node.attr,
+	&dev_attr_security.attr,
 	NULL,
 };
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index e7cb2f2fadc4..1dd1caabd41c 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -215,6 +215,7 @@ struct cxl_endpoint_dvsec_info {
  * @mbox_irq: @dev supports mailbox interrupts
  * @mbox_bg: opcode for the in-flight background operation on @dev
  * @mbox_bgpoll: self-polling delayed work item
+ * @sec: device security
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -254,6 +255,10 @@ struct cxl_dev_state {
 	bool mbox_irq;
 	atomic_t mbox_bg;
 	struct delayed_work __maybe_unused mbox_bgpoll;
+
+	struct {
+		unsigned int __maybe_unused sanitize_tmo;
+	} sec;
 };
 
 enum cxl_opcode {
@@ -279,6 +284,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
+	CXL_MBOX_OP_SANITIZE		= 0x4400,
+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
 	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
 	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
 	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
@@ -473,6 +480,7 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
 struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
 void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
+
 #ifdef CONFIG_CXL_SUSPEND
 void cxl_mem_active_inc(void);
 void cxl_mem_active_dec(void);
@@ -487,6 +495,8 @@ static inline void cxl_mem_active_dec(void)
 
 void cxl_mbox_bgcmd_work(struct work_struct *work);
 
+int cxl_mem_sanitize(struct cxl_dev_state *cxlds, u16 cmd);
+
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 82bdad4ce5de..fbf619976eb7 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -40,6 +40,8 @@
 	___C(CLEAR_POISON, "Clear Poison"),                               \
 	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
 	___C(SCAN_MEDIA, "Scan Media"),                                   \
+	___C(SANITIZE, "Sanitize"),                                       \
+	___C(SECURE_ERASE, "Secure Erase"),				  \
 	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
 	___C(GET_SECURITY_STATE, "Get Security State"),			  \
 	___C(SET_PASSPHRASE, "Set Passphrase"),				  \
-- 
2.38.1

