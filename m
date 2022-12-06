Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48266C4708E
	for <linux-cxl@archiver.kernel.org>; Tue,  6 Dec 2022 01:15:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbiLFBPc (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 5 Dec 2022 20:15:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233056AbiLFBPa (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 5 Dec 2022 20:15:30 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72941EC44
        for <linux-cxl@vger.kernel.org>; Mon,  5 Dec 2022 17:15:17 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 567ED6C1D3F;
        Tue,  6 Dec 2022 01:15:17 +0000 (UTC)
Received: from pdx1-sub0-mail-a242.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id B40E56C14C4;
        Tue,  6 Dec 2022 01:15:09 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1670289310; a=rsa-sha256;
        cv=none;
        b=OYkfVgJm/PUrMH+EN4TeTGatY9GVSqdHEpP9H8RN67BagCmmvwOPwdloXWubYhzM+t5A19
        pafpAaPPag5sBGg+U8JKlsuxHwzy30WszXiFAHHNE/4DPR0BKoUXCUAb5Dnet770db9U2e
        JRLDxgZvbgnw1D0GEqYD0NFrVKZS8gvXtqoNM1BlcPh8UI/IREcCoxpZkXf/NSR/ddioOd
        nwTIOeMBQvM3IRUaaqCQEA9vDcMqW8bwq0/KgGG1sEC9rXSin0O+hJqck4UbkFVvmYDdfA
        yP1lQ7sBqH5S1JYDK+br9xW3a5QBBq5OmNJqA2FlJwMENBuFAY98QSQrTbguow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1670289309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=tb6om8zADAa++dyya+hTJtRm+uSK6TexL8wF6UgSwAY=;
        b=l52d9imVlZFL4AXWolPMrmTSEvzyAGhPD2sdZz0qahRbF0+tMJGDvL9OEjdfAP5Y9VdYR4
        HPvimmBidcqA8dWyYnBlDHinOtl2ycyUNFArMh5jgDkkjMJOxYbjU9842GP8p6bxHr9rj9
        xWmFLpeQGuLwBUJZmGEtsGxk3fz9R+2bncobYq2XMIrhd1LKN7Kof9Velm2QAGZhrPDZsh
        DaWt+ViHQShxQV1hbP5rivuGyhjI8VGF8NgswT1NNL0rjIXMOXjeocanzKIAKh5sBB+Bp8
        0KVEHlkoI9x9MEQhdvfVBJaUBIprcTrqals5pD5I9W/ZZo8Yn2tlylZDJ6ELVQ==
ARC-Authentication-Results: i=1;
        rspamd-7bd68c5946-5dcr7;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Daffy-Desert: 2c35ccb556199937_1670289313106_1198104745
X-MC-Loop-Signature: 1670289313106:1254382729
X-MC-Ingress-Time: 1670289313106
Received: from pdx1-sub0-mail-a242.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.103.24.82 (trex/6.7.1);
        Tue, 06 Dec 2022 01:15:13 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a242.dreamhost.com (Postfix) with ESMTPSA id 4NR2XD6yVmzYP;
        Mon,  5 Dec 2022 17:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1670289309;
        bh=tb6om8zADAa++dyya+hTJtRm+uSK6TexL8wF6UgSwAY=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=YBx7J+9YqXmimTrXcuTECNeUHPquB4/Ne+FxNyE3H+qaMEw/9jxQw0Lu26WrFZa3V
         aY0HAHy3etJPE5MQ5RFIJXWaVv/70jGyD8EAl9OdP+9z5BB78XJFrAJyGCnmaAEesX
         RMN6Aqp15OJVaiTEB5mtYyKA8LRu1zwe+022yf4g8NLEq8idGfiQWk0SIufzu/X8Ut
         qt7iQdi0ByDGRbiK9Pn1ymSwlL0U1kMhg4fH+N7lSr2af40NILJyYzyYFFLUKZ9JfR
         +pocEOvoyRkC751Qz8X4Z1uERXYkAXLlihfiSsNR8lJQg6FyzqxUQUoOrpBO1QqCa0
         Qka9sk7pi/dHQ==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     dan.j.williams@intel.com
Cc:     ira.weiny@intel.com, dave.jiang@intel.com,
        Jonathan.Cameron@huawei.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/3] cxl/mbox: Add background operation handling machinery
Date:   Mon,  5 Dec 2022 17:14:59 -0800
Message-Id: <20221206011501.464916-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221206011501.464916-1-dave@stgolabs.net>
References: <20221206011501.464916-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

This adds support for handling background operations, as defined in
the CXL 3.0 spec. Commands that can take too long (over ~2 seconds)
can run asynchronously in the background, these are limited to:
transfer/activate firmware, scan media, sanitize (aka overwrite)
and VPPB bind/unbind.

Completion of background operations, successful or not, can be handled
via irq or poll based. This patch deals only with polling, which
introduces some complexities as we need to handle the window in which
the original background command completed, then a new one is
successfully started before the poller wakes up and checks. This,
in theory, can occur any amount of times. One of the problems is
that previous states cannot be tracked as hw background status
registers always deal with the last command.

So in order to keep hardware and the driver in sync, there can be
windows where the hardware is ready but the driver won't be, and
thus must serialize/handle it accordingly. While this polling cost
may not be ideal: 1) background commands are rare/limited and
2) the extra busy time should be small compared to the overall
command duration and 3) devices that support mailbox interrupts
do not use this.

The implementation extends struct cxl_mem_command to become aware
of background-capable commands in a generic fashion and presents
some interfaces:

- Calls for bg operations, where each bg command can choose to implement
  whatever needed based on the nature of the operation. For example,
  while running, overwrite may only allow certain related commands to
  occur, while scan media does not have any such limitations.
  Delay times can also be different, for which ad-hoc hinting can
  be defined - for example, scan media could use some value based on
  GET_SCAN_MEDIA_CAPS and overwrite has predefined values based on
  pmem DSM specs[0]. Similarly some commands need to execute tasks
  once the command finishes, such as overwriting requires CPU flushing
  when successfully done. These are:

  cxl_mbox_bgcmd_conflicts()
  cxl_mbox_bgcmd_delay()
  cxl_mbox_bgcmd_post()

- cxl_mbox_send_cmd() is extended such that callers can distinguish,
  upon rc == 0, between completed and successfully started in the
  background.

- cxl_mbox_bgcmd_running() will atomically tell which command is
  running in the background, if any. This allows easy querying
  functionality. Similarly, there are cxl_mbox_bgcmd_start() and
  cxl_mbox_bgcmd_done() to safely mark the in-flight operation.
  While x86 serializes atomics, care must be taken with arm64, for
  example, ensuring, minimally, release/acquire semantics.

There are currently no supported commands.

[0] https://pmem.io/documents/IntelOptanePMem_DSM_Interface-V2.0.pdf

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/cxl/core/core.h |   3 +-
 drivers/cxl/core/mbox.c | 213 ++++++++++++++++++++++++++++++++++++++--
 drivers/cxl/core/port.c |   1 +
 drivers/cxl/cxl.h       |   8 ++
 drivers/cxl/cxlmem.h    |  55 ++++++++++-
 drivers/cxl/pci.c       |   4 +
 drivers/cxl/pmem.c      |   5 +-
 drivers/cxl/security.c  |  13 +--
 8 files changed, 282 insertions(+), 20 deletions(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 1d8f87be283f..2a71664a0668 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -69,6 +69,7 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
 
 int cxl_memdev_init(void);
 void cxl_memdev_exit(void);
-void cxl_mbox_init(void);
+int cxl_mbox_init(void);
+void cxl_mbox_exit(void);
 
 #endif /* __CXL_CORE_H__ */
diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
index 35dd889f1d3a..bfee9251c81c 100644
--- a/drivers/cxl/core/mbox.c
+++ b/drivers/cxl/core/mbox.c
@@ -10,6 +10,7 @@
 #include "core.h"
 
 static bool cxl_raw_allow_all;
+static struct workqueue_struct *cxl_mbox_bgpoll_wq;
 
 /**
  * DOC: cxl mbox
@@ -24,7 +25,7 @@ static bool cxl_raw_allow_all;
 	for ((cmd) = &cxl_mem_commands[0];                                     \
 	     ((cmd) - cxl_mem_commands) < ARRAY_SIZE(cxl_mem_commands); (cmd)++)
 
-#define CXL_CMD(_id, sin, sout, _flags)                                        \
+#define __CXL_CMD(_id, sin, sout, _flags, _bgops)                              \
 	[CXL_MEM_COMMAND_ID_##_id] = {                                         \
 	.info =	{                                                              \
 			.id = CXL_MEM_COMMAND_ID_##_id,                        \
@@ -33,8 +34,13 @@ static bool cxl_raw_allow_all;
 		},                                                             \
 	.opcode = CXL_MBOX_OP_##_id,                                           \
 	.flags = _flags,                                                       \
+	.bgops = _bgops,						       \
 	}
 
+#define CXL_CMD(_id, sin, sout, _flags) __CXL_CMD(_id, sin, sout, _flags, NULL)
+#define CXL_BGCMD(_id, sin, sout, _flags, _bgops)                              \
+	__CXL_CMD(_id, sin, sout, _flags | CXL_CMD_FLAG_BACKGROUND, _bgops)
+
 #define CXL_VARIABLE_PAYLOAD	~0U
 /*
  * This table defines the supported mailbox commands for the driver. This table
@@ -63,7 +69,7 @@ static struct cxl_mem_command cxl_mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
 	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
 	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
-	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
+	CXL_BGCMD(SCAN_MEDIA, 0x11, 0, 0, NULL),
 	CXL_CMD(GET_SCAN_MEDIA, 0, CXL_VARIABLE_PAYLOAD, 0),
 	CXL_CMD(GET_SECURITY_STATE, 0, 0x4, 0),
 	CXL_CMD(SET_PASSPHRASE, 0x60, 0, 0),
@@ -145,6 +151,136 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
 	return cxl_command_names[c->info.id].name;
 }
 
+static unsigned long __maybe_unused
+cxl_mbox_bgcmd_delay(struct cxl_dev_state *cxlds, u16 opcode)
+{
+	struct cxl_mem_command *c;
+	unsigned long ret = 0;
+
+	c = cxl_mem_find_command(opcode);
+	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
+		dev_WARN_ONCE(cxlds->dev, true,
+			      "Not a background command\n");
+		return 0;
+	}
+
+	if (c->bgops && c->bgops->delay)
+		ret = c->bgops->delay(cxlds);
+
+	return ret * HZ;
+}
+
+static void cxl_mbox_bgcmd_post(struct cxl_dev_state *cxlds,
+				u16 opcode, bool success)
+{
+	struct cxl_mem_command *c;
+
+	c = cxl_mem_find_command(opcode);
+	if (!c || !(c->flags & CXL_CMD_FLAG_BACKGROUND)) {
+		dev_WARN_ONCE(cxlds->dev, true,
+			      "Not a background command\n");
+		return;
+	}
+
+	if (c->bgops && c->bgops->post)
+		c->bgops->post(cxlds, success);
+}
+
+/*
+ * Ensure that ->mbox_send(@new) can run safely when a background
+ * command is running. If so, returns zero, otherwise error.
+ *
+ * check 1. bg cmd running. If not running it is fine to
+ *	    send any command. If one is running then there
+ *	    may be restrictions.
+ * check 2. @new incoming command is capable of running
+ *          in the background. If there is an in-flight bg
+ *          operation, all these are forbidden as we need
+ *          to serialize when polling.
+ * check 3. @new incoming command is not blacklisted by the
+ *          current running command.
+ */
+static int __maybe_unused
+cxl_mbox_check_cmd_bgcmd(struct cxl_dev_state *cxlds, u16 new)
+{
+	struct cxl_mem_command *c;
+
+	/* 1 */
+	if (likely(!cxl_mbox_bgcmd_running(cxlds)))
+		return 0;
+
+	c = cxl_mem_find_command(new);
+	if (!c)
+		return -EINVAL;
+
+	/* 2 */
+	if (c->flags & CXL_CMD_FLAG_BACKGROUND)
+		return -EBUSY;
+
+	/* 3 */
+	if (c->bgops && c->bgops->conflicts)
+		return c->bgops->conflicts(new);
+
+	return 0;
+}
+
+/*
+ * Background operation polling mode.
+ */
+void cxl_mbox_bgcmd_work(struct work_struct *work)
+{
+	struct cxl_dev_state *cxlds;
+	u64 bgcmd_status_reg;
+	u16 opcode;
+	u32 pct;
+
+	cxlds = container_of(work, struct cxl_dev_state, mbox_bgpoll.work);
+
+	dev_WARN_ONCE(cxlds->dev, !!cxlds->mbox_irq,
+		      "Polling mailbox when IRQs are supported\n");
+
+	bgcmd_status_reg = readq(cxlds->regs.mbox +
+				 CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
+	opcode = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK,
+			   bgcmd_status_reg);
+
+	pct = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, bgcmd_status_reg);
+	if (pct != 100) {
+		unsigned long hint;
+		u64 status_reg;
+
+		status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
+		if (!FIELD_GET(CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION,
+			       status_reg))
+			dev_WARN(cxlds->dev,
+				 "No background operation running (%u%%).\n",
+				 pct);
+
+		hint = cxl_mbox_bgcmd_delay(cxlds, opcode);
+		if (hint == 0) {
+			/*
+			 * TODO: try to do better(?). pct is updated every
+			 * ~1 sec, maybe use a heurstic based on that.
+			 */
+			hint = 5 * HZ;
+		}
+
+		queue_delayed_work(cxl_mbox_bgpoll_wq,
+				   &cxlds->mbox_bgpoll, hint);
+	} else { /* bg operation completed */
+		u16 return_code;
+
+		return_code = FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
+					bgcmd_status_reg);
+		cxl_mbox_bgcmd_post(cxlds, opcode,
+				    return_code == CXL_MBOX_CMD_RC_SUCCESS);
+
+		put_device(cxlds->dev);
+		cxl_mbox_bgcmd_done(cxlds);
+	}
+}
+EXPORT_SYMBOL_NS_GPL(cxl_mbox_bgcmd_work, CXL);
+
 /**
  * cxl_mbox_send_cmd() - Send a mailbox command to a device.
  * @cxlds: The device data for the operation
@@ -153,6 +289,7 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * @in_size: The length of the input payload
  * @out: Caller allocated buffer for the output.
  * @out_size: Expected size of output.
+ * @return_code: (optional output) HW returned code.
  *
  * Context: Any context.
  * Return:
@@ -167,8 +304,9 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
  * error. While this distinction can be useful for commands from userspace, the
  * kernel will only be able to use results when both are successful.
  */
-int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size)
+int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode,
+		      void *in, size_t in_size,
+		      void *out, size_t out_size, u16 *return_code)
 {
 	const struct cxl_mem_command *cmd = cxl_mem_find_command(opcode);
 	struct cxl_mbox_cmd mbox_cmd = {
@@ -183,12 +321,53 @@ int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
 	if (in_size > cxlds->payload_size || out_size > cxlds->payload_size)
 		return -E2BIG;
 
+	/*
+	 * With bg polling this can overlap a scenario where the
+	 * hardware can receive new requests but the driver is
+	 * not ready. Handle accordingly.
+	 */
+	if (!cxlds->mbox_irq) {
+		rc = cxl_mbox_check_cmd_bgcmd(cxlds, opcode);
+		if (rc)
+			return rc;
+	}
+
 	rc = cxlds->mbox_send(cxlds, &mbox_cmd);
+	if (return_code)
+		*return_code = mbox_cmd.return_code;
 	if (rc)
 		return rc;
 
-	if (mbox_cmd.return_code != CXL_MBOX_CMD_RC_SUCCESS)
+	switch (mbox_cmd.return_code) {
+	case CXL_MBOX_CMD_RC_BACKGROUND:
+	{
+		int err;
+
+		dev_dbg(cxlds->dev, "Opcode 0x%04x: %s\n", opcode,
+			cxl_mbox_cmd_rc2str(&mbox_cmd));
+
+		err = cxl_mbox_bgcmd_begin(cxlds, opcode);
+		if (err) {
+			dev_WARN(cxlds->dev,
+				 "Corrupted background cmd (opcode 0x%04x)\n",
+				 err);
+			return -ENXIO;
+		}
+
+		get_device(cxlds->dev);
+
+		if (!cxlds->mbox_irq) {
+			/* do first poll check asap before using any hinting */
+			queue_delayed_work(cxl_mbox_bgpoll_wq,
+					   &cxlds->mbox_bgpoll, 0);
+		}
+		break;
+	}
+	case CXL_MBOX_CMD_RC_SUCCESS:
+		break;
+	default:
 		return cxl_mbox_cmd_rc2errno(&mbox_cmd);
+	}
 
 	/*
 	 * Variable sized commands can't be validated and so it's up to the
@@ -575,7 +754,7 @@ static int cxl_xfer_log(struct cxl_dev_state *cxlds, uuid_t *uuid, u32 size, u8
 		int rc;
 
 		rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LOG, &log, sizeof(log),
-				       out, xfer_size);
+				       out, xfer_size, NULL);
 		if (rc < 0)
 			return rc;
 
@@ -628,7 +807,7 @@ static struct cxl_mbox_get_supported_logs *cxl_get_gsl(struct cxl_dev_state *cxl
 		return ERR_PTR(-ENOMEM);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SUPPORTED_LOGS, NULL, 0, ret,
-			       cxlds->payload_size);
+			       cxlds->payload_size, NULL);
 	if (rc < 0) {
 		kvfree(ret);
 		return ERR_PTR(rc);
@@ -738,7 +917,7 @@ static int cxl_mem_get_partition_info(struct cxl_dev_state *cxlds)
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_PARTITION_INFO, NULL, 0,
-			       &pi, sizeof(pi));
+			       &pi, sizeof(pi), NULL);
 
 	if (rc)
 		return rc;
@@ -771,7 +950,7 @@ int cxl_dev_state_identify(struct cxl_dev_state *cxlds)
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_IDENTIFY, NULL, 0, &id,
-			       sizeof(id));
+			       sizeof(id), NULL);
 	if (rc < 0)
 		return rc;
 
@@ -868,11 +1047,25 @@ struct cxl_dev_state *cxl_dev_state_create(struct device *dev)
 }
 EXPORT_SYMBOL_NS_GPL(cxl_dev_state_create, CXL);
 
-void __init cxl_mbox_init(void)
+int __init cxl_mbox_init(void)
 {
 	struct dentry *mbox_debugfs;
 
 	mbox_debugfs = cxl_debugfs_create_dir("mbox");
 	debugfs_create_bool("raw_allow_all", 0600, mbox_debugfs,
 			    &cxl_raw_allow_all);
+
+	/* background commands can run concurrently on different devices */
+	cxl_mbox_bgpoll_wq = alloc_workqueue("cxl_mbox_bgcmd", WQ_UNBOUND, 0);
+	if (!cxl_mbox_bgpoll_wq) {
+		debugfs_remove_recursive(mbox_debugfs);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+void cxl_mbox_exit(void)
+{
+	destroy_workqueue(cxl_mbox_bgpoll_wq);
 }
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 0d2f5eaaca7d..449767bfb5aa 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1945,6 +1945,7 @@ static void cxl_core_exit(void)
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
 	debugfs_remove_recursive(cxl_debugfs);
+	cxl_mbox_exit();
 }
 
 module_init(cxl_core_init);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index e5e1abceeca7..a10e979ef3a4 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -139,14 +139,22 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 /* CXL 2.0 8.2.8.4 Mailbox Registers */
 #define CXLDEV_MBOX_CAPS_OFFSET 0x00
 #define   CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK GENMASK(4, 0)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQNUM_MASK GENMASK(10, 7)
+#define   CXLDEV_MBOX_CAP_BG_CMD_IRQ BIT(6)
 #define CXLDEV_MBOX_CTRL_OFFSET 0x04
 #define   CXLDEV_MBOX_CTRL_DOORBELL BIT(0)
+#define   CXLDEV_MBOX_CTRL_BGCMD_IRQ BIT(2)
 #define CXLDEV_MBOX_CMD_OFFSET 0x08
 #define   CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
 #define   CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK GENMASK_ULL(36, 16)
 #define CXLDEV_MBOX_STATUS_OFFSET 0x10
+#define   CXLDEV_MBOX_STATUS_BACKGROUND_OPERATION BIT(0)
 #define   CXLDEV_MBOX_STATUS_RET_CODE_MASK GENMASK_ULL(47, 32)
+/* CXL 3.0 8.2.8.4.7 Background Command Status Register */
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_OPCODE_MASK GENMASK_ULL(15, 0)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK GENMASK_ULL(22, 16)
+#define   CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK GENMASK_ULL(47, 32)
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
 /*
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 75baeb0bbe57..e7cb2f2fadc4 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -212,6 +212,9 @@ struct cxl_endpoint_dvsec_info {
  * @serial: PCIe Device Serial Number
  * @doe_mbs: PCI DOE mailbox array
  * @mbox_send: @dev specific transport for transmitting mailbox commands
+ * @mbox_irq: @dev supports mailbox interrupts
+ * @mbox_bg: opcode for the in-flight background operation on @dev
+ * @mbox_bgpoll: self-polling delayed work item
  *
  * See section 8.2.9.5.2 Capacity Configuration and Label Storage for
  * details on capacity parameters.
@@ -248,6 +251,9 @@ struct cxl_dev_state {
 	struct xarray doe_mbs;
 
 	int (*mbox_send)(struct cxl_dev_state *cxlds, struct cxl_mbox_cmd *cmd);
+	bool mbox_irq;
+	atomic_t mbox_bg;
+	struct delayed_work __maybe_unused mbox_bgpoll;
 };
 
 enum cxl_opcode {
@@ -290,6 +296,26 @@ enum cxl_opcode {
 	UUID_INIT(0xe1819d9, 0x11a9, 0x400c, 0x81, 0x1f, 0xd6, 0x07, 0x19,     \
 		  0x40, 0x3d, 0x86)
 
+/*
+ * Supported CXL mailbox commands that can run in the background.
+ *
+ * Barriers pair with release/acquire semantics. When done,
+ * clearing ->mbox_bg must be the very last operation before
+ * finishing the command.
+ */
+static inline int cxl_mbox_bgcmd_begin(struct cxl_dev_state *cxlds, u16 opcode)
+{
+	return atomic_xchg(&cxlds->mbox_bg, opcode);
+}
+static inline int cxl_mbox_bgcmd_running(struct cxl_dev_state *cxlds)
+{
+	return atomic_read_acquire(&cxlds->mbox_bg);
+}
+static inline void cxl_mbox_bgcmd_done(struct cxl_dev_state *cxlds)
+{
+	atomic_set_release(&cxlds->mbox_bg, 0);
+}
+
 struct cxl_mbox_get_supported_logs {
 	__le16 entries;
 	u8 rsvd[6];
@@ -353,16 +379,38 @@ struct cxl_mbox_set_partition_info {
 
 #define  CXL_SET_PARTITION_IMMEDIATE_FLAG	BIT(0)
 
+/**
+ * struct cxl_mbox_bgcmd_ops - Optional ad-hoc handling of background cmds
+ * @post: Execute after the command completes
+ * @conflicts: How to handle a @new command when one is currently executing
+ *             (only for polling mode)
+ * @delay: Delay hint for polling on command completion
+ */
+struct cxl_mem_bgcommand_ops {
+	void (*post)(struct cxl_dev_state *cxlds, bool success);
+	int (*conflicts)(u16 new);
+	unsigned long (*delay)(struct cxl_dev_state *cxlds);
+};
+
 /**
  * struct cxl_mem_command - Driver representation of a memory device command
  * @info: Command information as it exists for the UAPI
  * @opcode: The actual bits used for the mailbox protocol
  * @flags: Set of flags effecting driver behavior.
+ * @bg_ops: Set of optional callbacks to handle commands that can run in
+ *          the background.
  *
  *  * %CXL_CMD_FLAG_FORCE_ENABLE: In cases of error, commands with this flag
  *    will be enabled by the driver regardless of what hardware may have
  *    advertised.
  *
+ *  * %CXL_CMD_FLAG_BACKGROUND: The command may execute asynchronously in the
+ *    background if the operation takes longer than ~2 seconds. The semantics
+ *    are:
+ *      - Only a single of these commands can run at a time.
+ *      - Depending on the nature of the operation, devices may continue to
+ *        accept new non-background commands.
+ *
  * The cxl_mem_command is the driver's internal representation of commands that
  * are supported by the driver. Some of these commands may not be supported by
  * the hardware. The driver will use @info to validate the fields passed in by
@@ -374,8 +422,10 @@ struct cxl_mem_command {
 	struct cxl_command_info info;
 	enum cxl_opcode opcode;
 	u32 flags;
+	struct cxl_mem_bgcommand_ops __maybe_unused *bgops;
 #define CXL_CMD_FLAG_NONE 0
 #define CXL_CMD_FLAG_FORCE_ENABLE BIT(0)
+#define CXL_CMD_FLAG_BACKGROUND BIT(1)
 };
 
 #define CXL_PMEM_SEC_STATE_USER_PASS_SET	0x01
@@ -414,7 +464,8 @@ enum {
 };
 
 int cxl_mbox_send_cmd(struct cxl_dev_state *cxlds, u16 opcode, void *in,
-		      size_t in_size, void *out, size_t out_size);
+		      size_t in_size, void *out, size_t out_size,
+		      u16 *return_code);
 int cxl_dev_state_identify(struct cxl_dev_state *cxlds);
 int cxl_await_media_ready(struct cxl_dev_state *cxlds);
 int cxl_enumerate_cmds(struct cxl_dev_state *cxlds);
@@ -434,6 +485,8 @@ static inline void cxl_mem_active_dec(void)
 }
 #endif
 
+void cxl_mbox_bgcmd_work(struct work_struct *work);
+
 struct cxl_hdm {
 	struct cxl_component_regs regs;
 	unsigned int decoder_count;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 621a0522b554..b21d8681beac 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -268,6 +268,10 @@ static int cxl_pci_setup_mailbox(struct cxl_dev_state *cxlds)
 		return -ENXIO;
 	}
 
+	atomic_set(&cxlds->mbox_bg, 0);
+	if (!cxlds->mbox_irq)
+		INIT_DELAYED_WORK(&cxlds->mbox_bgpoll, cxl_mbox_bgcmd_work);
+
 	dev_dbg(cxlds->dev, "Mailbox payload sized %zu",
 		cxlds->payload_size);
 
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index ab40c93c44e5..c6a6d3fd6883 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -173,7 +173,8 @@ static int cxl_pmem_get_config_data(struct cxl_dev_state *cxlds,
 	};
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_LSA, &get_lsa,
-			       sizeof(get_lsa), cmd->out_buf, cmd->in_length);
+			       sizeof(get_lsa), cmd->out_buf,
+			       cmd->in_length, NULL);
 	cmd->status = 0;
 
 	return rc;
@@ -205,7 +206,7 @@ static int cxl_pmem_set_config_data(struct cxl_dev_state *cxlds,
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_LSA, set_lsa,
 			       struct_size(set_lsa, data, cmd->in_length),
-			       NULL, 0);
+			       NULL, 0, NULL);
 
 	/*
 	 * Set "firmware" status (4-packed bytes at the end of the input
diff --git a/drivers/cxl/security.c b/drivers/cxl/security.c
index 5484d4eecfd1..825d1bd1dd16 100644
--- a/drivers/cxl/security.c
+++ b/drivers/cxl/security.c
@@ -20,7 +20,7 @@ static unsigned long cxl_pmem_get_security_flags(struct nvdimm *nvdimm,
 	int rc;
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_GET_SECURITY_STATE, NULL, 0,
-			       &sec_out, sizeof(sec_out));
+			       &sec_out, sizeof(sec_out), NULL);
 	if (rc < 0)
 		return 0;
 
@@ -67,7 +67,7 @@ static int cxl_pmem_security_change_key(struct nvdimm *nvdimm,
 	memcpy(set_pass.new_pass, new_data->data, NVDIMM_PASSPHRASE_LEN);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_SET_PASSPHRASE,
-			       &set_pass, sizeof(set_pass), NULL, 0);
+			       &set_pass, sizeof(set_pass), NULL, 0, NULL);
 	return rc;
 }
 
@@ -86,7 +86,7 @@ static int __cxl_pmem_security_disable(struct nvdimm *nvdimm,
 	memcpy(dis_pass.pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
 
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_DISABLE_PASSPHRASE,
-			       &dis_pass, sizeof(dis_pass), NULL, 0);
+			       &dis_pass, sizeof(dis_pass), NULL, 0, NULL);
 	return rc;
 }
 
@@ -108,7 +108,8 @@ static int cxl_pmem_security_freeze(struct nvdimm *nvdimm)
 	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_dev_state *cxlds = cxlmd->cxlds;
 
-	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY, NULL, 0, NULL, 0);
+	return cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_FREEZE_SECURITY,
+				 NULL, 0, NULL, 0, NULL);
 }
 
 static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
@@ -122,7 +123,7 @@ static int cxl_pmem_security_unlock(struct nvdimm *nvdimm,
 
 	memcpy(pass, key_data->data, NVDIMM_PASSPHRASE_LEN);
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_UNLOCK,
-			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0);
+			       pass, NVDIMM_PASSPHRASE_LEN, NULL, 0, NULL);
 	if (rc < 0)
 		return rc;
 
@@ -143,7 +144,7 @@ static int cxl_pmem_security_passphrase_erase(struct nvdimm *nvdimm,
 		CXL_PMEM_SEC_PASS_MASTER : CXL_PMEM_SEC_PASS_USER;
 	memcpy(erase.pass, key->data, NVDIMM_PASSPHRASE_LEN);
 	rc = cxl_mbox_send_cmd(cxlds, CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE,
-			       &erase, sizeof(erase), NULL, 0);
+			       &erase, sizeof(erase), NULL, 0, NULL);
 	if (rc < 0)
 		return rc;
 
-- 
2.38.1

