Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FE6BC001DF
	for <linux-cxl@archiver.kernel.org>; Fri,  4 Aug 2023 11:55:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbjHDLzW (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 4 Aug 2023 07:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHDLzV (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 4 Aug 2023 07:55:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3FFBB1
        for <linux-cxl@vger.kernel.org>; Fri,  4 Aug 2023 04:55:16 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RHPFd3msgz6J6yM;
        Fri,  4 Aug 2023 19:51:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 12:55:14 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>
CC:     Dan Williams <dan.j.williams@intel.com>, <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [RFC PATCH v5 2/4] cxl: mbox: Factor out the mbox specific data for reuse in switch cci
Date:   Fri, 4 Aug 2023 12:54:12 +0100
Message-ID: <20230804115414.14391-3-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
References: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

The mbox implementation should be reusuable on devices that are
not CXL type 3 memory devices. The implementation has a number
of direct calls that assume it is such a device.  Move the data
to a separate structure under struct cxl_memdev_state and add
callbacks to deal with the non generic corners.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
V5: Add docs for callbacks and drop some pointless ones.
---
 drivers/cxl/core/core.h   |   3 +-
 drivers/cxl/core/mbox.c   | 313 +++++++++++++++++++-------------------
 drivers/cxl/core/memdev.c |  32 ++--
 drivers/cxl/core/regs.c   |  33 +++-
 drivers/cxl/cxl.h         |   4 +-
 drivers/cxl/cxlmbox.h     |  59 ++++++-
 drivers/cxl/cxlmem.h      |  28 ++--
 drivers/cxl/pci.c         | 200 ++++++++++++++++--------
 drivers/cxl/pmem.c        |   6 +-
 drivers/cxl/security.c    |  13 +-
 10 files changed, 424 insertions(+), 267 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 45e7e044cf4a..5491d3a3c095 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -51,9 +51,10 @@ static inline void cxl_region_exit(void)
 
 struct cxl_send_command;
 struct cxl_mem_query_commands;
+struct cxl_mbox;
 int cxl_query_cmd(struct cxl_memdev *cxlmd,
 		  struct cxl_mem_query_commands __user *q);
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
+int cxl_send_cmd(struct cxl_mbox *mbox, struct cxl_send_command __user *s);
 void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
 				   resource_size_t length);
 
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 6f359dc1c6d3..f279efb763ff 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -18,8 +18,8 @@
 /* CXL 2.0 - 8.2.8.4 */
 #define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
 
-#define cxl_doorbell_busy(cxlds)                                                \
-	(readl((cxlds)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
+#define cxl_doorbell_busy(mbox)						\
+	(readl((mbox)->mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
 	 CXLDEV_MBOX_CTRL_DOORBELL)
 
 static bool cxl_raw_allow_all;
@@ -121,7 +121,7 @@ static u8 security_command_sets[] = {
 	0x46, /* Security Passthrough */
 };
 
-static bool cxl_is_security_command(u16 opcode)
+bool cxl_is_security_command(u16 opcode)
 {
 	int i;
 
@@ -130,9 +130,10 @@ static bool cxl_is_security_command(u16 opcode)
 			return true;
 	return false;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_is_security_command, CXL);
 
-static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
-					 u16 opcode)
+void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
+				  u16 opcode)
 {
 	switch (opcode) {
 	case CXL_MBOX_OP_SANITIZE:
@@ -169,8 +170,9 @@ static void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
 		break;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(cxl_set_security_cmd_enabled, CXL);
 
-static bool cxl_is_poison_command(u16 opcode)
+bool cxl_is_poison_command(u16 opcode)
 {
 #define CXL_MBOX_OP_POISON_CMDS 0x43
 
@@ -179,9 +181,10 @@ static bool cxl_is_poison_command(u16 opcode)
 
 	return false;
 }
+EXPORT_SYMBOL_NS_GPL(cxl_is_poison_command, CXL);
 
-static void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
-				       u16 opcode)
+void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
+				u16 opcode)
 {
 	switch (opcode) {
 	case CXL_MBOX_OP_GET_POISON:
@@ -206,6 +209,7 @@ static void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
 		break;
 	}
 }
+EXPORT_SYMBOL_NS_GPL(cxl_set_poison_cmd_enabled, CXL);
 
 static struct cxl_mem_command *cxl_mem_find_command(u16 opcode)
 {
@@ -229,41 +233,59 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 	return cxl_command_names[c->info.id].name;
 }
 
-int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
+irqreturn_t cxl_mbox_irq(int irq, struct cxl_mbox *mbox)
+{
+	u64 reg;
+	u16 opcode;
+
+	if (!cxl_mbox_background_complete(mbox))
+		return IRQ_NONE;
+
+	reg = readq(mbox->mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
+	if (!mbox->special_irq || !mbox->special_irq(mbox, opcode)) {
+		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
+		rcuwait_wake_up(&mbox->mbox_wait);
+	}
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mbox_irq, CXL);
+
+int cxl_pci_mbox_wait_for_doorbell(struct cxl_mbox *mbox)
 {
 	const unsigned long start = jiffies;
 	unsigned long end = start;
 
-	while (cxl_doorbell_busy(cxlds)) {
+	while (cxl_doorbell_busy(mbox)) {
 		end = jiffies;
 
 		if (time_after(end, start + CXL_MAILBOX_TIMEOUT_MS)) {
 			/* Check again in case preempted before timeout test */
-			if (!cxl_doorbell_busy(cxlds))
+			if (!cxl_doorbell_busy(mbox))
 				break;
 			return -ETIMEDOUT;
 		}
 		cpu_relax();
 	}
 
-	dev_dbg(cxlds->dev, "Doorbell wait took %dms",
+	dev_dbg(mbox->dev, "Doorbell wait took %dms",
 		jiffies_to_msecs(end) - jiffies_to_msecs(start));
 	return 0;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_pci_mbox_wait_for_doorbell, CXL);
 
-bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
+bool cxl_mbox_background_complete(struct cxl_mbox *mbox)
 {
-	u64 reg;
+	u64 reg = readq(mbox->mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 
-	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
 }
 EXPORT_SYMBOL_NS_GPL(cxl_mbox_background_complete, CXL);
 
 /**
  * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
- * @mds: The memory device driver data
+ * @mbox: The mailbox
  * @mbox_cmd: Command to send to the memory device.
  *
  * Context: Any context. Expects mbox_mutex to be held.
@@ -283,17 +305,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_mbox_background_complete, CXL);
  * not need to coordinate with each other. The driver only uses the primary
  * mailbox.
  */
-static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
+static int __cxl_pci_mbox_send_cmd(struct cxl_mbox *mbox,
 				   struct cxl_mbox_cmd *mbox_cmd)
 {
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
-	struct device *dev = cxlds->dev;
+	void __iomem *payload = mbox->mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
 	u64 cmd_reg, status_reg;
 	size_t out_len;
 	int rc;
 
-	lockdep_assert_held(&mds->mbox_mutex);
+	lockdep_assert_held(&mbox->mbox_mutex);
 
 	/*
 	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
@@ -313,12 +333,15 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 	 */
 
 	/* #1 */
-	if (cxl_doorbell_busy(cxlds)) {
-		u64 md_status =
-			readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+	if (cxl_doorbell_busy(mbox)) {
+		u64 md_status = 0;
+
+		if (mbox->get_status)
+			md_status = mbox->get_status(mbox);
 
-		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
+		cxl_cmd_err(mbox->dev, mbox_cmd, md_status,
 			    "mailbox queue busy");
+
 		return -EBUSY;
 	}
 
@@ -327,10 +350,8 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 	 * not be in sync. Ensure no new command comes in until so. Keep the
 	 * hardware semantics and only allow device health status.
 	 */
-	if (mds->security.poll_tmo_secs > 0) {
-		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
-			return -EBUSY;
-	}
+	if (mbox->can_run && !mbox->can_run(mbox, mbox_cmd->opcode))
+		return -EBUSY;
 
 	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
 			     mbox_cmd->opcode);
@@ -344,24 +365,27 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 	}
 
 	/* #2, #3 */
-	writeq(cmd_reg, cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
+	writeq(cmd_reg, mbox->mbox + CXLDEV_MBOX_CMD_OFFSET);
 
 	/* #4 */
-	dev_dbg(dev, "Sending command: 0x%04x\n", mbox_cmd->opcode);
+	dev_dbg(mbox->dev, "Sending command: 0x%04x\n", mbox_cmd->opcode);
 	writel(CXLDEV_MBOX_CTRL_DOORBELL,
-	       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+	       mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
 	/* #5 */
-	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
+	rc = cxl_pci_mbox_wait_for_doorbell(mbox);
 	if (rc == -ETIMEDOUT) {
-		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		u64 md_status = 0;
+
+		if (mbox->get_status)
+			md_status = mbox->get_status(mbox);
 
-		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status, "mailbox timeout");
+		cxl_cmd_err(mbox->dev, mbox_cmd, md_status, "mailbox timeout");
 		return rc;
 	}
 
 	/* #6 */
-	status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
+	status_reg = readq(mbox->mbox + CXLDEV_MBOX_STATUS_OFFSET);
 	mbox_cmd->return_code =
 		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
 
@@ -387,60 +411,46 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 * and cannot be timesliced. Handle asynchronously instead,
 		 * and allow userspace to poll(2) for completion.
 		 */
-		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
-			if (mds->security.poll) {
-				/* hold the device throughout */
-				get_device(cxlds->dev);
-
-				/* give first timeout a second */
-				timeout = 1;
-				mds->security.poll_tmo_secs = timeout;
-				queue_delayed_work(system_wq,
-						   &mds->security.poll_dwork,
-						   timeout * HZ);
-			}
-
-			dev_dbg(dev, "Sanitization operation started\n");
+		if (mbox->special_bg && mbox->special_bg(mbox, mbox_cmd->opcode))
 			goto success;
-		}
 
-		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
+		dev_dbg(mbox->dev, "Mailbox background operation (0x%04x) started\n",
 			mbox_cmd->opcode);
 
 		timeout = mbox_cmd->poll_interval_ms;
 		for (i = 0; i < mbox_cmd->poll_count; i++) {
-			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
-				       cxl_mbox_background_complete(cxlds),
+			if (rcuwait_wait_event_timeout(&mbox->mbox_wait,
+				       cxl_mbox_background_complete(mbox),
 				       TASK_UNINTERRUPTIBLE,
 				       msecs_to_jiffies(timeout)) > 0)
 				break;
 		}
 
-		if (!cxl_mbox_background_complete(cxlds)) {
-			dev_err(dev, "timeout waiting for background (%d ms)\n",
+		if (!cxl_mbox_background_complete(mbox)) {
+			dev_err(mbox->dev, "timeout waiting for background (%d ms)\n",
 				timeout * mbox_cmd->poll_count);
 			return -ETIMEDOUT;
 		}
 
-		bg_status_reg = readq(cxlds->regs.mbox +
+		bg_status_reg = readq(mbox->mbox +
 				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 		mbox_cmd->return_code =
 			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
 				  bg_status_reg);
-		dev_dbg(dev,
+		dev_dbg(mbox->dev,
 			"Mailbox background operation (0x%04x) completed\n",
 			mbox_cmd->opcode);
 	}
 
 	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
-		dev_dbg(dev, "Mailbox operation had an error: %s\n",
+		dev_dbg(mbox->dev, "Mailbox operation had an error: %s\n",
 			cxl_mbox_cmd_rc2str(mbox_cmd));
 		return 0; /* completed but caller must check return_code */
 	}
 
 success:
 	/* #7 */
-	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
+	cmd_reg = readq(mbox->mbox + CXLDEV_MBOX_CMD_OFFSET);
 	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
 
 	/* #8 */
@@ -454,7 +464,7 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 		 */
 		size_t n;
 
-		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
+		n = min3(mbox_cmd->size_out, mbox->payload_size, out_len);
 		memcpy_fromio(mbox_cmd->payload_out, payload, n);
 		mbox_cmd->size_out = n;
 	} else {
@@ -464,21 +474,20 @@ static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
 	return 0;
 }
 
-static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
-			     struct cxl_mbox_cmd *cmd)
+static int cxl_pci_mbox_send(struct cxl_mbox *mbox, struct cxl_mbox_cmd *cmd)
 {
 	int rc;
 
-	mutex_lock_io(&mds->mbox_mutex);
-	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_lock_io(&mbox->mbox_mutex);
+	rc = __cxl_pci_mbox_send_cmd(mbox, cmd);
+	mutex_unlock(&mbox->mbox_mutex);
 
 	return rc;
 }
 
 /**
  * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
- * @mds: The driver data for the operation
+ * @mbox: The mailbox
  * @mbox_cmd: initialized command to execute
  *
  * Context: Any context.
@@ -494,19 +503,18 @@ static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
  */
-int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
-			  struct cxl_mbox_cmd *mbox_cmd)
+int cxl_internal_send_cmd(struct cxl_mbox *mbox, struct cxl_mbox_cmd *mbox_cmd)
 {
 	size_t out_size, min_out;
 	int rc;
 
-	if (mbox_cmd->size_in > mds->payload_size ||
-	    mbox_cmd->size_out > mds->payload_size)
+	if (mbox_cmd->size_in > mbox->payload_size ||
+	    mbox_cmd->size_out > mbox->payload_size)
 		return -E2BIG;
 
 	out_size = mbox_cmd->size_out;
 	min_out = mbox_cmd->min_out;
-	rc = cxl_pci_mbox_send(mds, mbox_cmd);
+	rc = cxl_pci_mbox_send(mbox, mbox_cmd);
 	/*
 	 * EIO is reserved for a payload size mismatch and mbox_send()
 	 * may not return this error.
@@ -593,39 +601,39 @@ static bool cxl_payload_from_user_allowed(u16 opcode, void *payload_in)
 	return true;
 }
 
-static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox,
-			     struct cxl_memdev_state *mds, u16 opcode,
+static int cxl_mbox_cmd_ctor(struct cxl_mbox_cmd *mbox_cmd,
+			     struct cxl_mbox *mbox, u16 opcode,
 			     size_t in_size, size_t out_size, u64 in_payload)
 {
-	*mbox = (struct cxl_mbox_cmd) {
+	*mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = opcode,
 		.size_in = in_size,
 	};
 
 	if (in_size) {
-		mbox->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
+		mbox_cmd->payload_in = vmemdup_user(u64_to_user_ptr(in_payload),
 						in_size);
-		if (IS_ERR(mbox->payload_in))
-			return PTR_ERR(mbox->payload_in);
+		if (IS_ERR(mbox_cmd->payload_in))
+			return PTR_ERR(mbox_cmd->payload_in);
 
-		if (!cxl_payload_from_user_allowed(opcode, mbox->payload_in)) {
-			dev_dbg(mds->cxlds.dev, "%s: input payload not allowed\n",
+		if (!cxl_payload_from_user_allowed(opcode, mbox_cmd->payload_in)) {
+			dev_dbg(mbox->dev, "%s: input payload not allowed\n",
 				cxl_mem_opcode_to_name(opcode));
-			kvfree(mbox->payload_in);
+			kvfree(mbox_cmd->payload_in);
 			return -EBUSY;
 		}
 	}
 
 	/* Prepare to handle a full payload for variable sized output */
 	if (out_size == CXL_VARIABLE_PAYLOAD)
-		mbox->size_out = mds->payload_size;
+		mbox_cmd->size_out = mbox->payload_size;
 	else
-		mbox->size_out = out_size;
+		mbox_cmd->size_out = out_size;
 
-	if (mbox->size_out) {
-		mbox->payload_out = kvzalloc(mbox->size_out, GFP_KERNEL);
-		if (!mbox->payload_out) {
-			kvfree(mbox->payload_in);
+	if (mbox_cmd->size_out) {
+		mbox_cmd->payload_out = kvzalloc(mbox_cmd->size_out, GFP_KERNEL);
+		if (!mbox_cmd->payload_out) {
+			kvfree(mbox_cmd->payload_in);
 			return -ENOMEM;
 		}
 	}
@@ -640,7 +648,7 @@ static void cxl_mbox_cmd_dtor(struct cxl_mbox_cmd *mbox)
 
 static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 			      const struct cxl_send_command *send_cmd,
-			      struct cxl_memdev_state *mds)
+			      struct cxl_mbox *mbox)
 {
 	if (send_cmd->raw.rsvd)
 		return -EINVAL;
@@ -650,13 +658,13 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 	 * gets passed along without further checking, so it must be
 	 * validated here.
 	 */
-	if (send_cmd->out.size > mds->payload_size)
+	if (send_cmd->out.size > mbox->payload_size)
 		return -EINVAL;
 
 	if (!cxl_mem_raw_command_allowed(send_cmd->raw.opcode))
 		return -EPERM;
 
-	dev_WARN_ONCE(mds->cxlds.dev, true, "raw command path used\n");
+	dev_WARN_ONCE(mbox->dev, true, "raw command path used\n");
 
 	*mem_cmd = (struct cxl_mem_command) {
 		.info = {
@@ -672,7 +680,7 @@ static int cxl_to_mem_cmd_raw(struct cxl_mem_command *mem_cmd,
 
 static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 			  const struct cxl_send_command *send_cmd,
-			  struct cxl_memdev_state *mds)
+			  struct cxl_mbox *mbox)
 {
 	struct cxl_mem_command *c = &cxl_mem_commands[send_cmd->id];
 	const struct cxl_command_info *info = &c->info;
@@ -687,11 +695,11 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 		return -EINVAL;
 
 	/* Check that the command is enabled for hardware */
-	if (!test_bit(info->id, mds->enabled_cmds))
+	if (!test_bit(info->id, mbox->enabled_cmds))
 		return -ENOTTY;
 
 	/* Check that the command is not claimed for exclusive kernel use */
-	if (test_bit(info->id, mds->exclusive_cmds))
+	if (test_bit(info->id, mbox->exclusive_cmds))
 		return -EBUSY;
 
 	/* Check the input buffer is the expected size */
@@ -720,7 +728,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
 /**
  * cxl_validate_cmd_from_user() - Check fields for CXL_MEM_SEND_COMMAND.
  * @mbox_cmd: Sanitized and populated &struct cxl_mbox_cmd.
- * @mds: The driver data for the operation
+ * @mbox: The mailbox.
  * @send_cmd: &struct cxl_send_command copied in from userspace.
  *
  * Return:
@@ -735,7 +743,7 @@ static int cxl_to_mem_cmd(struct cxl_mem_command *mem_cmd,
  * safe to send to the hardware.
  */
 static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
-				      struct cxl_memdev_state *mds,
+				      struct cxl_mbox *mbox,
 				      const struct cxl_send_command *send_cmd)
 {
 	struct cxl_mem_command mem_cmd;
@@ -749,20 +757,20 @@ static int cxl_validate_cmd_from_user(struct cxl_mbox_cmd *mbox_cmd,
 	 * supports, but output can be arbitrarily large (simply write out as
 	 * much data as the hardware provides).
 	 */
-	if (send_cmd->in.size > mds->payload_size)
+	if (send_cmd->in.size > mbox->payload_size)
 		return -EINVAL;
 
 	/* Sanitize and construct a cxl_mem_command */
 	if (send_cmd->id == CXL_MEM_COMMAND_ID_RAW)
-		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, mds);
+		rc = cxl_to_mem_cmd_raw(&mem_cmd, send_cmd, mbox);
 	else
-		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, mds);
+		rc = cxl_to_mem_cmd(&mem_cmd, send_cmd, mbox);
 
 	if (rc)
 		return rc;
 
 	/* Sanitize and construct a cxl_mbox_cmd */
-	return cxl_mbox_cmd_ctor(mbox_cmd, mds, mem_cmd.opcode,
+	return cxl_mbox_cmd_ctor(mbox_cmd, mbox, mem_cmd.opcode,
 				 mem_cmd.info.size_in, mem_cmd.info.size_out,
 				 send_cmd->in.payload);
 }
@@ -792,9 +800,9 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 	cxl_for_each_cmd(cmd) {
 		struct cxl_command_info info = cmd->info;
 
-		if (test_bit(info.id, mds->enabled_cmds))
+		if (test_bit(info.id, mds->mbox.enabled_cmds))
 			info.flags |= CXL_MEM_COMMAND_FLAG_ENABLED;
-		if (test_bit(info.id, mds->exclusive_cmds))
+		if (test_bit(info.id, mds->mbox.exclusive_cmds))
 			info.flags |= CXL_MEM_COMMAND_FLAG_EXCLUSIVE;
 
 		if (copy_to_user(&q->commands[j++], &info, sizeof(info)))
@@ -809,7 +817,7 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
 
 /**
  * handle_mailbox_cmd_from_user() - Dispatch a mailbox command for userspace.
- * @mds: The driver data for the operation
+ * @mbox: The mailbox.
  * @mbox_cmd: The validated mailbox command.
  * @out_payload: Pointer to userspace's output payload.
  * @size_out: (Input) Max payload size to copy out.
@@ -830,22 +838,21 @@ int cxl_query_cmd(struct cxl_memdev *cxlmd,
  *
  * See cxl_send_cmd().
  */
-static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
+static int handle_mailbox_cmd_from_user(struct cxl_mbox *mbox,
 					struct cxl_mbox_cmd *mbox_cmd,
 					u64 out_payload, s32 *size_out,
 					u32 *retval)
 {
-	struct device *dev = mds->cxlds.dev;
 	int rc;
 
-	dev_dbg(dev,
+	dev_dbg(mbox->dev,
 		"Submitting %s command for user\n"
 		"\topcode: %x\n"
 		"\tsize: %zx\n",
 		cxl_mem_opcode_to_name(mbox_cmd->opcode),
 		mbox_cmd->opcode, mbox_cmd->size_in);
 
-	rc = cxl_pci_mbox_send(mds, mbox_cmd);
+	rc = cxl_pci_mbox_send(mbox, mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -855,7 +862,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
 	 * this it will have to be ignored.
 	 */
 	if (mbox_cmd->size_out) {
-		dev_WARN_ONCE(dev, mbox_cmd->size_out > *size_out,
+		dev_WARN_ONCE(mbox->dev, mbox_cmd->size_out > *size_out,
 			      "Invalid return size\n");
 		if (copy_to_user(u64_to_user_ptr(out_payload),
 				 mbox_cmd->payload_out, mbox_cmd->size_out)) {
@@ -872,24 +879,22 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
 	return rc;
 }
 
-int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
+int cxl_send_cmd(struct cxl_mbox *mbox, struct cxl_send_command __user *s)
 {
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
-	struct device *dev = &cxlmd->dev;
 	struct cxl_send_command send;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	dev_dbg(dev, "Send IOCTL\n");
+	dev_dbg(mbox->dev, "Send IOCTL\n");
 
 	if (copy_from_user(&send, s, sizeof(send)))
 		return -EFAULT;
 
-	rc = cxl_validate_cmd_from_user(&mbox_cmd, mds, &send);
+	rc = cxl_validate_cmd_from_user(&mbox_cmd, mbox, &send);
 	if (rc)
 		return rc;
 
-	rc = handle_mailbox_cmd_from_user(mds, &mbox_cmd, send.out.payload,
+	rc = handle_mailbox_cmd_from_user(mbox, &mbox_cmd, send.out.payload,
 					  &send.out.size, &send.retval);
 	if (rc)
 		return rc;
@@ -900,14 +905,14 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s)
 	return 0;
 }
 
-static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
+static int cxl_xfer_log(struct cxl_mbox *mbox, uuid_t *uuid,
 			u32 *size, u8 *out)
 {
 	u32 remaining = *size;
 	u32 offset = 0;
 
 	while (remaining) {
-		u32 xfer_size = min_t(u32, remaining, mds->payload_size);
+		u32 xfer_size = min_t(u32, remaining, mbox->payload_size);
 		struct cxl_mbox_cmd mbox_cmd;
 		struct cxl_mbox_get_log log;
 		int rc;
@@ -926,7 +931,7 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 			.payload_out = out,
 		};
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
 
 		/*
 		 * The output payload length that indicates the number
@@ -953,18 +958,17 @@ static int cxl_xfer_log(struct cxl_memdev_state *mds, uuid_t *uuid,
 
 /**
  * cxl_walk_cel() - Walk through the Command Effects Log.
- * @mds: The driver data for the operation
+ * @mbox: The mailbox.
  * @size: Length of the Command Effects Log.
  * @cel: CEL
  *
  * Iterate over each entry in the CEL and determine if the driver supports the
  * command. If so, the command is enabled for the device and can be used later.
  */
-static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
+static void cxl_walk_cel(struct cxl_mbox *mbox, size_t size, u8 *cel)
 {
 	struct cxl_cel_entry *cel_entry;
 	const int cel_entries = size / sizeof(*cel_entry);
-	struct device *dev = mds->cxlds.dev;
 	int i;
 
 	cel_entry = (struct cxl_cel_entry *) cel;
@@ -975,42 +979,39 @@ static void cxl_walk_cel(struct cxl_memdev_state *mds, size_t size, u8 *cel)
 
 		if (!cmd && (!cxl_is_poison_command(opcode) ||
 			     !cxl_is_security_command(opcode))) {
-			dev_dbg(dev,
+			dev_dbg(mbox->dev,
 				"Opcode 0x%04x unsupported by driver\n", opcode);
 			continue;
 		}
 
 		if (cmd)
-			set_bit(cmd->info.id, mds->enabled_cmds);
+			set_bit(cmd->info.id, mbox->enabled_cmds);
 
-		if (cxl_is_poison_command(opcode))
-			cxl_set_poison_cmd_enabled(&mds->poison, opcode);
+		if (mbox->extra_cmds)
+			mbox->extra_cmds(mbox, opcode);
 
-		if (cxl_is_security_command(opcode))
-			cxl_set_security_cmd_enabled(&mds->security, opcode);
-
-		dev_dbg(dev, "Opcode 0x%04x enabled\n", opcode);
+		dev_dbg(mbox->dev, "Opcode 0x%04x enabled\n", opcode);
 	}
 }
 
-static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_memdev_state *mds)
+static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_mbox *mbox)
 {
 	struct cxl_mbox_get_supported_logs *ret;
 	struct cxl_mbox_cmd mbox_cmd;
 	int rc;
 
-	ret = kvmalloc(mds->payload_size, GFP_KERNEL);
+	ret = kvmalloc(mbox->payload_size, GFP_KERNEL);
 	if (!ret)
 		return ERR_PTR(-ENOMEM);
 
 	mbox_cmd = (struct cxl_mbox_cmd) {
 		.opcode = CXL_MBOX_OP_GET_SUPPORTED_LOGS,
-		.size_out = mds->payload_size,
+		.size_out = mbox->payload_size,
 		.payload_out = ret,
 		/* At least the record number field must be valid */
 		.min_out = 2,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
@@ -1033,22 +1034,21 @@ static const uuid_t log_uuid[] = {
 
 /**
  * cxl_enumerate_cmds() - Enumerate commands for a device.
- * @mds: The driver data for the operation
+ * @mbox: The mailbox.
  *
  * Returns 0 if enumerate completed successfully.
  *
  * CXL devices have optional support for certain commands. This function will
  * determine the set of supported commands for the hardware and update the
- * enabled_cmds bitmap in the @mds.
+ * enabled_cmds bitmap in the @mbox.
  */
-int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
+int cxl_enumerate_cmds(struct cxl_mbox *mbox)
 {
 	struct cxl_mbox_get_supported_logs *gsl;
-	struct device *dev = mds->cxlds.dev;
 	struct cxl_mem_command *cmd;
 	int i, rc;
 
-	gsl = cxl_get_gsl(mds);
+	gsl = cxl_get_gsl(mbox);
 	if (IS_ERR(gsl))
 		return PTR_ERR(gsl);
 
@@ -1058,7 +1058,7 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 		uuid_t uuid = gsl->entry[i].uuid;
 		u8 *log;
 
-		dev_dbg(dev, "Found LOG type %pU of size %d", &uuid, size);
+		dev_dbg(mbox->dev, "Found LOG type %pU of size %d", &uuid, size);
 
 		if (!uuid_equal(&uuid, &log_uuid[CEL_UUID]))
 			continue;
@@ -1069,19 +1069,19 @@ int cxl_enumerate_cmds(struct cxl_memdev_state *mds)
 			goto out;
 		}
 
-		rc = cxl_xfer_log(mds, &uuid, &size, log);
+		rc = cxl_xfer_log(mbox, &uuid, &size, log);
 		if (rc) {
 			kvfree(log);
 			goto out;
 		}
 
-		cxl_walk_cel(mds, size, log);
+		cxl_walk_cel(mbox, size, log);
 		kvfree(log);
 
 		/* In case CEL was bogus, enable some default commands. */
 		cxl_for_each_cmd(cmd)
 			if (cmd->flags & CXL_CMD_FLAG_FORCE_ENABLE)
-				set_bit(cmd->info.id, mds->enabled_cmds);
+				set_bit(cmd->info.id, mbox->enabled_cmds);
 
 		/* Found the required CEL */
 		rc = 0;
@@ -1151,13 +1151,14 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	u8 max_handles = CXL_CLEAR_EVENT_MAX_HANDLES;
 	size_t pl_size = struct_size(payload, handles, max_handles);
 	struct cxl_mbox_cmd mbox_cmd;
+	struct cxl_mbox *mbox = &mds->mbox;
 	u16 cnt;
 	int rc = 0;
 	int i;
 
 	/* Payload size may limit the max handles */
-	if (pl_size > mds->payload_size) {
-		max_handles = (mds->payload_size - sizeof(*payload)) /
+	if (pl_size > mbox->payload_size) {
+		max_handles = (mbox->payload_size - sizeof(*payload)) /
 			      sizeof(__le16);
 		pl_size = struct_size(payload, handles, max_handles);
 	}
@@ -1183,12 +1184,12 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	i = 0;
 	for (cnt = 0; cnt < total; cnt++) {
 		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
-		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
+		dev_dbg(mbox->dev, "Event log '%d': Clearing %u\n", log,
 			le16_to_cpu(payload->handles[i]));
 
 		if (i == max_handles) {
 			payload->nr_recs = i;
-			rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+			rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
 			if (rc)
 				goto free_pl;
 			i = 0;
@@ -1199,7 +1200,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
 	if (i) {
 		payload->nr_recs = i;
 		mbox_cmd.size_in = struct_size(payload, handles, i);
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(mbox, &mbox_cmd);
 		if (rc)
 			goto free_pl;
 	}
@@ -1227,14 +1228,14 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
 		.payload_in = &log_type,
 		.size_in = sizeof(log_type),
 		.payload_out = payload,
-		.size_out = mds->payload_size,
+		.size_out = mds->mbox.payload_size,
 		.min_out = struct_size(payload, records, 0),
 	};
 
 	do {
 		int rc, i;
 
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 		if (rc) {
 			dev_err_ratelimited(dev,
 				"Event log '%d': Failed to query event records : %d",
@@ -1314,7 +1315,7 @@ static int cxl_mem_get_partition_info(struct cxl_memdev_state *mds)
 		.size_out = sizeof(pi),
 		.payload_out = &pi,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc)
 		return rc;
 
@@ -1355,7 +1356,7 @@ int cxl_dev_state_identify(struct cxl_memdev_state *mds)
 		.size_out = sizeof(id),
 		.payload_out = &id,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -1412,7 +1413,7 @@ int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 	if (cmd != CXL_MBOX_OP_SANITIZE && cmd != CXL_MBOX_OP_SECURE_ERASE)
 		return -EINVAL;
 
-	rc = cxl_internal_send_cmd(mds, &sec_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &sec_cmd);
 	if (rc < 0) {
 		dev_err(cxlds->dev, "Failed to get security state : %d", rc);
 		return rc;
@@ -1431,7 +1432,7 @@ int cxl_mem_sanitize(struct cxl_memdev_state *mds, u16 cmd)
 	    sec_out & CXL_PMEM_SEC_STATE_LOCKED)
 		return -EINVAL;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0) {
 		dev_err(cxlds->dev, "Failed to sanitize device : %d", rc);
 		return rc;
@@ -1522,7 +1523,7 @@ int cxl_set_timestamp(struct cxl_memdev_state *mds)
 		.payload_in = &pi,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	/*
 	 * Command is optional. Devices may have another way of providing
 	 * a timestamp, or may return all 0s in timestamp fields.
@@ -1557,13 +1558,13 @@ int cxl_mem_get_poison(struct cxl_memdev *cxlmd, u64 offset, u64 len,
 		.opcode = CXL_MBOX_OP_GET_POISON,
 		.size_in = sizeof(pi),
 		.payload_in = &pi,
-		.size_out = mds->payload_size,
+		.size_out = mds->mbox.payload_size,
 		.payload_out = po,
 		.min_out = struct_size(po, record, 0),
 	};
 
 	do {
-		rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+		rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 		if (rc)
 			break;
 
@@ -1594,7 +1595,7 @@ static void free_poison_buf(void *buf)
 /* Get Poison List output buffer is protected by mds->poison.lock */
 static int cxl_poison_alloc_buf(struct cxl_memdev_state *mds)
 {
-	mds->poison.list_out = kvmalloc(mds->payload_size, GFP_KERNEL);
+	mds->poison.list_out = kvmalloc(mds->mbox.payload_size, GFP_KERNEL);
 	if (!mds->poison.list_out)
 		return -ENOMEM;
 
@@ -1630,7 +1631,7 @@ struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev)
 		return ERR_PTR(-ENOMEM);
 	}
 
-	mutex_init(&mds->mbox_mutex);
+	mutex_init(&mds->mbox.mbox_mutex);
 	mutex_init(&mds->event.log_lock);
 	mds->cxlds.dev = dev;
 	mds->cxlds.type = CXL_DEVTYPE_CLASSMEM;
diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 14b547c07f54..15b540bec6fa 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -58,7 +58,7 @@ static ssize_t payload_max_show(struct device *dev,
 
 	if (!mds)
 		return sysfs_emit(buf, "\n");
-	return sysfs_emit(buf, "%zu\n", mds->payload_size);
+	return sysfs_emit(buf, "%zu\n", mds->mbox.payload_size);
 }
 static DEVICE_ATTR_RO(payload_max);
 
@@ -125,7 +125,8 @@ static ssize_t security_state_show(struct device *dev,
 	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-	u64 reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	//accessor?
+	u64 reg = readq(mds->mbox.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
 	u32 pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg);
 	u16 cmd = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	unsigned long state = mds->security.state;
@@ -349,7 +350,7 @@ int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.size_in = sizeof(inject),
 		.payload_in = &inject,
 	};
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -406,7 +407,7 @@ int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa)
 		.payload_in = &clear,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc)
 		goto out;
 
@@ -535,7 +536,7 @@ void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				unsigned long *cmds)
 {
 	down_write(&cxl_memdev_rwsem);
-	bitmap_or(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
+	bitmap_or(mds->mbox.exclusive_cmds, mds->mbox.exclusive_cmds, cmds,
 		  CXL_MEM_COMMAND_ID_MAX);
 	up_write(&cxl_memdev_rwsem);
 }
@@ -550,7 +551,7 @@ void clear_exclusive_cxl_commands(struct cxl_memdev_state *mds,
 				  unsigned long *cmds)
 {
 	down_write(&cxl_memdev_rwsem);
-	bitmap_andnot(mds->exclusive_cmds, mds->exclusive_cmds, cmds,
+	bitmap_andnot(mds->mbox.exclusive_cmds, mds->mbox.exclusive_cmds, cmds,
 		      CXL_MEM_COMMAND_ID_MAX);
 	up_write(&cxl_memdev_rwsem);
 }
@@ -636,11 +637,14 @@ static struct cxl_memdev *cxl_memdev_alloc(struct cxl_dev_state *cxlds,
 static long __cxl_memdev_ioctl(struct cxl_memdev *cxlmd, unsigned int cmd,
 			       unsigned long arg)
 {
+	struct cxl_dev_state *cxlds = cxlmd->cxlds;
+	struct cxl_memdev_state *mds = container_of(cxlds, struct cxl_memdev_state, cxlds);
+
 	switch (cmd) {
 	case CXL_MEM_QUERY_COMMANDS:
 		return cxl_query_cmd(cxlmd, (void __user *)arg);
 	case CXL_MEM_SEND_COMMAND:
-		return cxl_send_cmd(cxlmd, (void __user *)arg);
+		return cxl_send_cmd(&mds->mbox, (void __user *)arg);
 	default:
 		return -ENOTTY;
 	}
@@ -705,7 +709,7 @@ static int cxl_mem_get_fw_info(struct cxl_memdev_state *mds)
 		.payload_out = &info,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -745,7 +749,7 @@ static int cxl_mem_activate_fw(struct cxl_memdev_state *mds, int slot)
 	activate.action = CXL_FW_ACTIVATE_OFFLINE;
 	activate.slot = slot;
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 }
 
 /**
@@ -779,7 +783,7 @@ static int cxl_mem_abort_fw_xfer(struct cxl_memdev_state *mds)
 
 	transfer->action = CXL_FW_TRANSFER_ACTION_ABORT;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	kfree(transfer);
 	return rc;
 }
@@ -815,7 +819,7 @@ static enum fw_upload_err cxl_fw_prepare(struct fw_upload *fwl, const u8 *data,
 		return FW_UPLOAD_ERR_INVALID_SIZE;
 
 	mds->fw.oneshot = struct_size(transfer, data, size) <
-			    mds->payload_size;
+			    mds->mbox.payload_size;
 
 	if (cxl_mem_get_fw_info(mds))
 		return FW_UPLOAD_ERR_HW_ERROR;
@@ -858,7 +862,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 	 * sizeof(*transfer) is 128.  These constraints imply that @cur_size
 	 * will always be 128b aligned.
 	 */
-	cur_size = min_t(size_t, size, mds->payload_size - sizeof(*transfer));
+	cur_size = min_t(size_t, size, mds->mbox.payload_size - sizeof(*transfer));
 
 	remaining = size - cur_size;
 	size_in = struct_size(transfer, data, cur_size);
@@ -902,7 +906,7 @@ static enum fw_upload_err cxl_fw_write(struct fw_upload *fwl, const u8 *data,
 		.poll_count = 30,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0) {
 		rc = FW_UPLOAD_ERR_RW_ERROR;
 		goto out_free;
@@ -973,7 +977,7 @@ int cxl_memdev_setup_fw_upload(struct cxl_memdev_state *mds)
 	struct fw_upload *fwl;
 	int rc;
 
-	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->enabled_cmds))
+	if (!test_bit(CXL_MEM_COMMAND_ID_GET_FW_INFO, mds->mbox.enabled_cmds))
 		return 0;
 
 	fwl = firmware_upload_register(THIS_MODULE, dev, dev_name(dev),
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 6281127b3e9d..b783bf89d687 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -244,7 +244,6 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 		void __iomem **addr;
 	} mapinfo[] = {
 		{ &map->device_map.status, &regs->status, },
-		{ &map->device_map.mbox, &regs->mbox, },
 		{ &map->device_map.memdev, &regs->memdev, },
 	};
 	int i;
@@ -268,6 +267,38 @@ int cxl_map_device_regs(const struct cxl_register_map *map,
 }
 EXPORT_SYMBOL_NS_GPL(cxl_map_device_regs, CXL);
 
+int cxl_map_mbox_regs(const struct cxl_register_map *map,
+		      void __iomem **mbox_regs)
+{
+	struct device *dev = map->dev;
+	resource_size_t phys_addr = map->resource;
+	struct mapinfo {
+		const struct cxl_reg_map *rmap;
+		void __iomem **addr;
+	} mapinfo[] = {
+		{ &map->device_map.mbox, mbox_regs, },
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(mapinfo); i++) {
+		struct mapinfo *mi = &mapinfo[i];
+		resource_size_t length;
+		resource_size_t addr;
+
+		if (!mi->rmap || !mi->rmap->valid)
+			continue;
+
+		addr = phys_addr + mi->rmap->offset;
+		length = mi->rmap->size;
+		*(mi->addr) = devm_cxl_iomap_block(dev, addr, length);
+		if (!*(mi->addr))
+			return -ENOMEM;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_NS_GPL(cxl_map_mbox_regs, CXL);
+
 static bool cxl_decode_regblock(struct pci_dev *pdev, u32 reg_lo, u32 reg_hi,
 				struct cxl_register_map *map)
 {
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 76d92561af29..dad80c5857f6 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -215,7 +215,7 @@ struct cxl_regs {
 	 * @memdev: CXL 2.0 8.2.8.5 Memory Device Registers
 	 */
 	struct_group_tagged(cxl_device_regs, device_regs,
-		void __iomem *status, *mbox, *memdev;
+		void __iomem *status, *memdev;
 	);
 
 	struct_group_tagged(cxl_pmu_regs, pmu_regs,
@@ -278,6 +278,8 @@ int cxl_map_component_regs(const struct cxl_register_map *map,
 			   unsigned long map_mask);
 int cxl_map_device_regs(const struct cxl_register_map *map,
 			struct cxl_device_regs *regs);
+int cxl_map_mbox_regs(const struct cxl_register_map *map,
+		      void __iomem **mbox_reg);
 int cxl_map_pmu_regs(struct pci_dev *pdev, struct cxl_pmu_regs *regs,
 		     struct cxl_register_map *map);
 
diff --git a/drivers/cxl/cxlmbox.h b/drivers/cxl/cxlmbox.h
index 2b83b870a5e6..eaaf51904d2a 100644
--- a/drivers/cxl/cxlmbox.h
+++ b/drivers/cxl/cxlmbox.h
@@ -3,9 +3,58 @@
 #ifndef __CXLMBOX_H__
 #define __CXLMBOX_H__
 
-struct cxl_dev_state;
-int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds);
-bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds);
+#include <linux/irqreturn.h>
+#include <linux/export.h>
+#include <linux/io.h>
+
+#include <uapi/linux/cxl_mem.h>
+
+struct device;
+
+/**
+ * struct cxl_mbox - State of a CXL mailbox
+ *
+ * @dev: A parent device used for debug prints only
+ * @payload_size: Maximum payload in bytes.
+ * @mbox_mutex: Protect the mailbox registers from concurrent access.
+ * @enabled_cmds: Bitmap of which commands are available for use.
+ * @exclusive_cmds: Bitmap of which commands are only to be used in the  kernel.
+ * @mbox_wait: rcuwait structure on which the command issuing call can wait.
+ * @special_irq: Callback to let a specific mailbox instance add a condition to
+ *               whether to call the rcuwait_wake_up() on @mbox_wait to indicate
+ *               we are done.
+ * @get_status: Used to get a memory device status value to use in debug messages.
+ * @can_run: Devices incorporating CXL mailboxes may have additional constraints
+ *           on what commands may run at a given time. This lets that information
+ *           be conveyed to the generic mailbox code.
+ * @extra_cmds: When a mailbox is first enumerated the command effects log is
+ *              parsed. Some commands detected are specific to particular
+ *              CXL components and so are controlled and tracked at that level
+ *              rather than in the generic code. This provides the component
+ *              specific code with information on which op codes are supported.
+ * @status: Status register used to discover if the mailbox is ready after power
+ *          up and similar.
+ * @mbox: Mailbox registers.
+ */
+struct cxl_mbox {
+	struct device *dev; /* Used for debug prints */
+	size_t payload_size;
+	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
+	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
+	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
+	struct rcuwait mbox_wait;
+	bool (*special_irq)(struct cxl_mbox *mbox, u16 opcode);
+	bool (*special_bg)(struct cxl_mbox *mbox, u16 opcode);
+	u64 (*get_status)(struct cxl_mbox *mbox);
+	bool (*can_run)(struct cxl_mbox *mbox, u16 opcode);
+	void (*extra_cmds)(struct cxl_mbox *mbox, u16 opcode);
+	/* Also needs access to registers */
+	void __iomem *status, *mbox;
+};
+
+irqreturn_t cxl_mbox_irq(int irq, struct cxl_mbox *mbox);
+int cxl_pci_mbox_wait_for_doorbell(struct cxl_mbox *mbox);
+bool cxl_mbox_background_complete(struct cxl_mbox *mbox);
 
 /**
  * struct cxl_mbox_cmd - A command to be submitted to hardware.
@@ -143,4 +192,8 @@ enum cxl_opcode {
 	CXL_MBOX_OP_MAX			= 0x10000
 };
 
+int cxl_internal_send_cmd(struct cxl_mbox *mbox, struct cxl_mbox_cmd *cmd);
+int cxl_enumerate_cmds(struct cxl_mbox *mbox);
+
 #endif /* __CXLMBOX_H__ */
+
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 2b4f4c932501..6489a63dc4c8 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -347,14 +347,10 @@ struct cxl_dev_state {
  * the functionality related to that like Identify Memory Device and Get
  * Partition Info
  * @cxlds: Core driver state common across Type-2 and Type-3 devices
- * @payload_size: Size of space for payload
- *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
+ * @mbox: Mailbox instance.
  * @lsa_size: Size of Label Storage Area
  *                (CXL 2.0 8.2.9.5.1.1 Identify Memory Device)
- * @mbox_mutex: Mutex to synchronize mailbox access.
  * @firmware_version: Firmware version for the memory device.
- * @enabled_cmds: Hardware commands found enabled in CEL.
- * @exclusive_cmds: Commands that are kernel-internal only
  * @total_bytes: sum of all possible capacities
  * @volatile_only_bytes: hard volatile capacity
  * @persistent_only_bytes: hard persistent capacity
@@ -367,19 +363,16 @@ struct cxl_dev_state {
  * @poison: poison driver state info
  * @security: security driver state info
  * @fw: firmware upload / activation state
- * @mbox_send: @dev specific transport for transmitting mailbox commands
  *
  * See CXL 3.0 8.2.9.8.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
  */
 struct cxl_memdev_state {
 	struct cxl_dev_state cxlds;
-	size_t payload_size;
+	struct cxl_mbox mbox;
+
 	size_t lsa_size;
-	struct mutex mbox_mutex; /* Protects device mailbox and firmware */
 	char firmware_version[0x10];
-	DECLARE_BITMAP(enabled_cmds, CXL_MEM_COMMAND_ID_MAX);
-	DECLARE_BITMAP(exclusive_cmds, CXL_MEM_COMMAND_ID_MAX);
 	u64 total_bytes;
 	u64 volatile_only_bytes;
 	u64 persistent_only_bytes;
@@ -392,10 +385,6 @@ struct cxl_memdev_state {
 	struct cxl_poison_state poison;
 	struct cxl_security_state security;
 	struct cxl_fw_state fw;
-
-	struct rcuwait mbox_wait;
-	int (*mbox_send)(struct cxl_memdev_state *mds,
-			 struct cxl_mbox_cmd *cmd);
 };
 
 static inline struct cxl_memdev_state *
@@ -727,11 +716,16 @@ enum {
 	CXL_PMEM_SEC_PASS_USER,
 };
 
-int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
-			  struct cxl_mbox_cmd *cmd);
+bool cxl_is_poison_command(u16 opcode);
+void cxl_set_poison_cmd_enabled(struct cxl_poison_state *poison,
+				u16 opcode);
+
+bool cxl_is_security_command(u16 opcode);
+void cxl_set_security_cmd_enabled(struct cxl_security_state *security,
+				  u16 opcode);
 int cxl_dev_state_identify(struct cxl_memdev_state *mds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
-int cxl_enumerate_cmds(struct cxl_memdev_state *mds);
+
 int cxl_mem_create_range_info(struct cxl_memdev_state *mds);
 struct cxl_memdev_state *cxl_memdev_state_create(struct device *dev);
 void set_exclusive_cxl_commands(struct cxl_memdev_state *mds,
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index b11f2e7ad9fb..0ec524c62196 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -47,50 +47,72 @@ module_param(mbox_ready_timeout, ushort, 0644);
 MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
 
 struct cxl_dev_id {
-	struct cxl_dev_state *cxlds;
+	struct cxl_memdev_state *mds;
 };
 
-static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
-			   irq_handler_t handler, irq_handler_t thread_fn)
+static int cxl_request_irq(struct device *dev, struct cxl_memdev_state *mds,
+			   int irq, irq_handler_t handler,
+			   irq_handler_t thread_fn)
 {
-	struct device *dev = cxlds->dev;
 	struct cxl_dev_id *dev_id;
 
 	/* dev_id must be globally unique and must contain the cxlds */
 	dev_id = devm_kzalloc(dev, sizeof(*dev_id), GFP_KERNEL);
 	if (!dev_id)
 		return -ENOMEM;
-	dev_id->cxlds = cxlds;
+	dev_id->mds = mds;
 
 	return devm_request_threaded_irq(dev, irq, handler, thread_fn,
 					 IRQF_SHARED | IRQF_ONESHOT,
 					 NULL, dev_id);
 }
 
-static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
+static bool cxl_pci_mbox_special_irq(struct cxl_mbox *mbox, u16 opcode)
 {
-	u64 reg;
-	u16 opcode;
-	struct cxl_dev_id *dev_id = id;
-	struct cxl_dev_state *cxlds = dev_id->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
-
-	if (!cxl_mbox_background_complete(cxlds))
-		return IRQ_NONE;
-
-	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
-	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK, reg);
 	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		struct cxl_memdev_state *mds =
+			container_of(mbox, struct cxl_memdev_state, mbox);
+
 		if (mds->security.sanitize_node)
 			sysfs_notify_dirent(mds->security.sanitize_node);
+		dev_dbg(mbox->dev, "Sanitization operation ended\n");
+		return true;
+	}
 
-		dev_dbg(cxlds->dev, "Sanitization operation ended\n");
-	} else {
-		/* short-circuit the wait in __cxl_pci_mbox_send_cmd() */
-		rcuwait_wake_up(&mds->mbox_wait);
+	return false;
+}
+
+static bool cxl_pci_mbox_special_bg(struct cxl_mbox *mbox, u16 opcode)
+{
+	if (opcode == CXL_MBOX_OP_SANITIZE) {
+		struct cxl_memdev_state *mds =
+			container_of(mbox, struct cxl_memdev_state, mbox);
+
+		if (mds->security.poll) {
+			/* give first timeout a second */
+			int timeout = 1;
+			/* hold the device throughout */
+			get_device(mds->cxlds.dev);
+
+			mds->security.poll_tmo_secs = timeout;
+			queue_delayed_work(system_wq,
+					&mds->security.poll_dwork,
+					timeout * HZ);
+		}
+		dev_dbg(mbox->dev, "Sanitization operation started\n");
+
+		return true;
 	}
 
-	return IRQ_HANDLED;
+	return false;
+}
+
+static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
+{
+	struct cxl_dev_id *dev_id = id;
+	struct cxl_memdev_state *mds = dev_id->mds;
+
+	return cxl_mbox_irq(irq, &mds->mbox);
 }
 
 /*
@@ -102,8 +124,8 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		container_of(work, typeof(*mds), security.poll_dwork.work);
 	struct cxl_dev_state *cxlds = &mds->cxlds;
 
-	mutex_lock(&mds->mbox_mutex);
-	if (cxl_mbox_background_complete(cxlds)) {
+	mutex_lock(&mds->mbox.mbox_mutex);
+	if (cxl_mbox_background_complete(&mds->mbox)) {
 		mds->security.poll_tmo_secs = 0;
 		put_device(cxlds->dev);
 
@@ -118,20 +140,56 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
 		queue_delayed_work(system_wq, &mds->security.poll_dwork,
 				   timeout * HZ);
 	}
-	mutex_unlock(&mds->mbox_mutex);
+	mutex_unlock(&mds->mbox.mbox_mutex);
+}
+
+static u64 cxl_pci_mbox_get_status(struct cxl_mbox *mbox)
+{
+	struct cxl_memdev_state *mds = container_of(mbox, struct cxl_memdev_state, mbox);
+
+	return readq(mds->cxlds.regs.memdev + CXLMDEV_STATUS_OFFSET);
+}
+
+static bool cxl_pci_mbox_can_run(struct cxl_mbox *mbox, u16 opcode)
+{
+	struct cxl_memdev_state *mds = container_of(mbox, struct cxl_memdev_state, mbox);
+
+	if (mds->security.poll_tmo_secs > 0) {
+		if (opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
+			return false;
+	}
+
+	return true;
+}
+
+static void cxl_pci_mbox_init_poll(struct cxl_mbox *mbox)
+{
+	struct cxl_memdev_state *mds = container_of(mbox, struct cxl_memdev_state, mbox);
+
+	mds->security.poll = true;
+	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
+}
+
+static void cxl_pci_mbox_extra_cmds(struct cxl_mbox *mbox, u16 opcode)
+{
+	struct cxl_memdev_state *mds = container_of(mbox, struct cxl_memdev_state, mbox);
+
+	if (cxl_is_poison_command(opcode))
+		cxl_set_poison_cmd_enabled(&mds->poison, opcode);
+	if (cxl_is_security_command(opcode))
+		cxl_set_security_cmd_enabled(&mds->security, opcode);
 }
 
 static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 {
-	struct cxl_dev_state *cxlds = &mds->cxlds;
-	const int cap = readl(cxlds->regs.mbox + CXLDEV_MBOX_CAPS_OFFSET);
-	struct device *dev = cxlds->dev;
+	struct cxl_mbox *mbox = &mds->mbox;
+	const int cap = readl(mbox->mbox + CXLDEV_MBOX_CAPS_OFFSET);
 	unsigned long timeout;
 	u64 md_status;
 
 	timeout = jiffies + mbox_ready_timeout * HZ;
 	do {
-		md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
+		md_status = readq(mds->cxlds.regs.memdev + CXLMDEV_STATUS_OFFSET);
 		if (md_status & CXLMDEV_MBOX_IF_READY)
 			break;
 		if (msleep_interruptible(100))
@@ -139,7 +197,7 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	} while (!time_after(jiffies, timeout));
 
 	if (!(md_status & CXLMDEV_MBOX_IF_READY)) {
-		cxl_err(dev, md_status, "timeout awaiting mailbox ready");
+		cxl_err(mbox->dev, md_status, "timeout awaiting mailbox ready");
 		return -ETIMEDOUT;
 	}
 
@@ -149,12 +207,14 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	 * __cxl_pci_mbox_send_cmd() can assume that it is the only
 	 * source for future doorbell busy events.
 	 */
-	if (cxl_pci_mbox_wait_for_doorbell(cxlds) != 0) {
-		cxl_err(dev, md_status, "timeout awaiting mailbox idle");
+	if (cxl_pci_mbox_wait_for_doorbell(mbox) != 0) {
+		md_status = readq(mds->cxlds.regs.memdev + CXLMDEV_STATUS_OFFSET);
+		cxl_err(mbox->dev, md_status, "timeout awaiting mailbox idle");
+
 		return -ETIMEDOUT;
 	}
 
-	mds->payload_size =
+	mbox->payload_size =
 		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
 
 	/*
@@ -164,43 +224,43 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
 	 * there's no point in going forward. If the size is too large, there's
 	 * no harm is soft limiting it.
 	 */
-	mds->payload_size = min_t(size_t, mds->payload_size, SZ_1M);
-	if (mds->payload_size < 256) {
-		dev_err(dev, "Mailbox is too small (%zub)",
-			mds->payload_size);
+	mbox->payload_size = min_t(size_t, mbox->payload_size, SZ_1M);
+	if (mbox->payload_size < 256) {
+		dev_err(mbox->dev, "Mailbox is too small (%zub)",
+			mbox->payload_size);
 		return -ENXIO;
 	}
 
-	dev_dbg(dev, "Mailbox payload sized %zu", mds->payload_size);
+	dev_dbg(mbox->dev, "Mailbox payload sized %zu", mbox->payload_size);
 
-	rcuwait_init(&mds->mbox_wait);
+	rcuwait_init(&mbox->mbox_wait);
 
 	if (cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ) {
 		u32 ctrl;
 		int irq, msgnum;
-		struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+		struct pci_dev *pdev = to_pci_dev(mbox->dev);
 
 		msgnum = FIELD_GET(CXLDEV_MBOX_CAP_IRQ_MSGNUM_MASK, cap);
 		irq = pci_irq_vector(pdev, msgnum);
 		if (irq < 0)
 			goto mbox_poll;
 
-		if (cxl_request_irq(cxlds, irq, cxl_pci_mbox_irq, NULL))
+		if (cxl_request_irq(mbox->dev, mds, irq, cxl_pci_mbox_irq, NULL))
 			goto mbox_poll;
 
 		/* enable background command mbox irq support */
-		ctrl = readl(cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+		ctrl = readl(mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
 		ctrl |= CXLDEV_MBOX_CTRL_BG_CMD_IRQ;
-		writel(ctrl, cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
+		writel(ctrl, mbox->mbox + CXLDEV_MBOX_CTRL_OFFSET);
 
 		return 0;
 	}
 
 mbox_poll:
-	mds->security.poll = true;
-	INIT_DELAYED_WORK(&mds->security.poll_dwork, cxl_mbox_sanitize_work);
 
-	dev_dbg(cxlds->dev, "Mailbox interrupts are unsupported");
+	cxl_pci_mbox_init_poll(mbox);
+
+	dev_dbg(mbox->dev, "Mailbox interrupts are unsupported");
 	return 0;
 }
 
@@ -324,7 +384,7 @@ static int cxl_mem_alloc_event_buf(struct cxl_memdev_state *mds)
 {
 	struct cxl_get_event_payload *buf;
 
-	buf = kvmalloc(mds->payload_size, GFP_KERNEL);
+	buf = kvmalloc(mds->mbox.payload_size, GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 	mds->event.buf = buf;
@@ -357,8 +417,7 @@ static int cxl_alloc_irq_vectors(struct pci_dev *pdev)
 static irqreturn_t cxl_event_thread(int irq, void *id)
 {
 	struct cxl_dev_id *dev_id = id;
-	struct cxl_dev_state *cxlds = dev_id->cxlds;
-	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
+	struct cxl_memdev_state *mds = dev_id->mds;
 	u32 status;
 
 	do {
@@ -366,7 +425,7 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 		 * CXL 3.0 8.2.8.3.1: The lower 32 bits are the status;
 		 * ignore the reserved upper 32 bits
 		 */
-		status = readl(cxlds->regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
+		status = readl(mds->cxlds.regs.status + CXLDEV_DEV_EVENT_STATUS_OFFSET);
 		/* Ignore logs unknown to the driver */
 		status &= CXLDEV_EVENT_STATUS_ALL;
 		if (!status)
@@ -378,9 +437,9 @@ static irqreturn_t cxl_event_thread(int irq, void *id)
 	return IRQ_HANDLED;
 }
 
-static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
+static int cxl_event_req_irq(struct cxl_memdev_state *mds, u8 setting)
 {
-	struct pci_dev *pdev = to_pci_dev(cxlds->dev);
+	struct pci_dev *pdev = to_pci_dev(mds->cxlds.dev);
 	int irq;
 
 	if (FIELD_GET(CXLDEV_EVENT_INT_MODE_MASK, setting) != CXL_INT_MSI_MSIX)
@@ -391,7 +450,7 @@ static int cxl_event_req_irq(struct cxl_dev_state *cxlds, u8 setting)
 	if (irq < 0)
 		return irq;
 
-	return cxl_request_irq(cxlds, irq, NULL, cxl_event_thread);
+	return cxl_request_irq(mds->cxlds.dev, mds, irq, NULL, cxl_event_thread);
 }
 
 static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
@@ -404,7 +463,7 @@ static int cxl_event_get_int_policy(struct cxl_memdev_state *mds,
 	};
 	int rc;
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0)
 		dev_err(mds->cxlds.dev,
 			"Failed to get event interrupt policy : %d", rc);
@@ -431,7 +490,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 		.size_in = sizeof(*policy),
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0) {
 		dev_err(mds->cxlds.dev, "Failed to set event interrupt policy : %d",
 			rc);
@@ -444,7 +503,7 @@ static int cxl_event_config_msgnums(struct cxl_memdev_state *mds,
 
 static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
 {
-	struct cxl_dev_state *cxlds = &mds->cxlds;
+	struct device *dev = mds->cxlds.dev;
 	struct cxl_event_interrupt_policy policy;
 	int rc;
 
@@ -452,27 +511,27 @@ static int cxl_event_irqsetup(struct cxl_memdev_state *mds)
 	if (rc)
 		return rc;
 
-	rc = cxl_event_req_irq(cxlds, policy.info_settings);
+	rc = cxl_event_req_irq(mds, policy.info_settings);
 	if (rc) {
-		dev_err(cxlds->dev, "Failed to get interrupt for event Info log\n");
+		dev_err(dev, "Failed to get interrupt for event Info log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.warn_settings);
+	rc = cxl_event_req_irq(mds, policy.warn_settings);
 	if (rc) {
-		dev_err(cxlds->dev, "Failed to get interrupt for event Warn log\n");
+		dev_err(dev, "Failed to get interrupt for event Warn log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.failure_settings);
+	rc = cxl_event_req_irq(mds, policy.failure_settings);
 	if (rc) {
-		dev_err(cxlds->dev, "Failed to get interrupt for event Failure log\n");
+		dev_err(dev, "Failed to get interrupt for event Failure log\n");
 		return rc;
 	}
 
-	rc = cxl_event_req_irq(cxlds, policy.fatal_settings);
+	rc = cxl_event_req_irq(mds, policy.fatal_settings);
 	if (rc) {
-		dev_err(cxlds->dev, "Failed to get interrupt for event Fatal log\n");
+		dev_err(dev, "Failed to get interrupt for event Fatal log\n");
 		return rc;
 	}
 
@@ -568,6 +627,9 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	rc = cxl_map_mbox_regs(&map, &mds->mbox.mbox);
+	if (rc)
+		return rc;
 	/*
 	 * If the component registers can't be found, the cxl_pci driver may
 	 * still be useful for management functions so don't return an error.
@@ -596,11 +658,19 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
+	mds->mbox.status = cxlds->regs.status;
+	mds->mbox.dev = &pdev->dev;
+	mds->mbox.special_irq = cxl_pci_mbox_special_irq;
+	mds->mbox.special_bg = cxl_pci_mbox_special_bg;
+	mds->mbox.get_status = cxl_pci_mbox_get_status;
+	mds->mbox.can_run = cxl_pci_mbox_can_run;
+	mds->mbox.extra_cmds = cxl_pci_mbox_extra_cmds;
+
 	rc = cxl_pci_setup_mailbox(mds);
 	if (rc)
 		return rc;
 
-	rc = cxl_enumerate_cmds(mds);
+	rc = cxl_enumerate_cmds(&mds->mbox);
 	if (rc)
 		return rc;
 
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 7cb8994f8809..31f2292a50ae 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -110,7 +110,7 @@ static int cxl_pmem_get_config_size(struct cxl_memdev_state *mds,
 	*cmd = (struct nd_cmd_get_config_size){
 		.config_size = mds->lsa_size,
 		.max_xfer =
-			mds->payload_size - sizeof(struct cxl_mbox_set_lsa),
+			mds->mbox.payload_size - sizeof(struct cxl_mbox_set_lsa),
 	};
 
 	return 0;
@@ -141,7 +141,7 @@ static int cxl_pmem_get_config_data(struct cxl_memdev_state *mds,
 		.payload_out = cmd->out_buf,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	cmd->status = 0;
 
 	return rc;
@@ -177,7 +177,7 @@ static int cxl_pmem_set_config_data(struct cxl_memdev_state *mds,
 		.size_in = struct_size(set_lsa, data, cmd->in_length),
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 
 	/*
 	 * Set "firmware" status (4-packed bytes at the end of the input
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 21856a3f408e..096ebce06596 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -6,6 +6,7 @@
 #include <linux/async.h>
 #include <linux/slab.h>
 #include <linux/memregion.h>
+#include "cxlmbox.h"
 #include "cxlmem.h"
 #include "cxl.h"
 
@@ -29,7 +30,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 		.payload_out = &out,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0)
 		return 0;
 
@@ -87,7 +88,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 		.payload_in = &set_pass,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 }
 
 static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -112,7 +113,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 		.payload_in = &dis_pass,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 }
 
 static int cxl_pmem_security_disable(struct nvdimm *nvdimm,
@@ -136,7 +137,7 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 		.opcode = CXL_MBOX_OP_FREEZE_SECURITY,
 	};
 
-	return cxl_internal_send_cmd(mds, &mbox_cmd);
+	return cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 }
 
 static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
@@ -156,7 +157,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 		.payload_in = pass,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
@@ -185,7 +186,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 		.payload_in = &erase,
 	};
 
-	rc = cxl_internal_send_cmd(mds, &mbox_cmd);
+	rc = cxl_internal_send_cmd(&mds->mbox, &mbox_cmd);
 	if (rc < 0)
 		return rc;
 
-- 
2.39.2

