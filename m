Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16A2C27C40
	for <linux-cxl@archiver.kernel.org>; Wed, 23 Aug 2023 20:56:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbjHWUzd (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 23 Aug 2023 16:55:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236742AbjHWUzJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 23 Aug 2023 16:55:09 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231D710C8
        for <linux-cxl@vger.kernel.org>; Wed, 23 Aug 2023 13:55:04 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 62D564C1138;
        Wed, 23 Aug 2023 20:55:03 +0000 (UTC)
Received: from pdx1-sub0-mail-a204.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 99F9C4C0186;
        Wed, 23 Aug 2023 20:55:02 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1692824102; a=rsa-sha256;
        cv=none;
        b=rUchPfgWiNNqxin19CwOmBxEjyp1gokLxHX4ziWzW6Qu4GdSIs7/YU+vRA8i/ov4Zyguhq
        6xUrNDytJ6isqpM2wbTxuq0T77rNDPlJdN4q90n413L+oArO6FLBTFPrs9xUsQupbw+5UA
        8ciFPAbSF65caH4T3ozYXAZo0iQT8gSv49BiEQRF/LwQTtQJGd6KfYbnN9rvFGkSk+kstF
        H2Bvz1cv83i9lunAzsPdtPpAV577ioXFfZlYLIZbjJxB7QxLtTAs0FXJ7IpooNzMOJ49KR
        OEbocycv0Du5FpM5rq+qfO5bm4UWllebOIrJpnY8FavtBi0jb6PH1l8quVPXVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1692824102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=oG9XylOFOT0gIi+IEkLZe44xX84xVMa62F9+kGNjOEg=;
        b=bTaOdRq1kfob4aChp1dLo4NVcBGk/9MOQWbzmYOJ8m14RvGU3zvbjs/ks5POu4nWs1WWFE
        0difUYnoIOLq11OSVT/r3EekwZ3wLTEwfCKdIXX2DY6TY4D+kbHsjlUbWVmfRtXUcnA1Wq
        +RSnsDukIJZTIceU2fcPtB3FpZwUEQV1xdT50srrYlz93ga3MLqPrcFo2AS4LPWRsvLbcM
        o1OY7AEVdKIxjwmO476YskJ6plP7xRwRJ6W/+zWHbzA5I/d3qm4swIgQ9u1u07wDJYvTxO
        3N0hG29riVfd6VyOnngLjUHiXT5mR0qtSvfiuqFz+nwrTSGxDlMe8LXz0xsVyw==
ARC-Authentication-Results: i=1;
        rspamd-7878b5d4b5-kgdgs;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Illegal-Print: 511b4660115694ba_1692824103253_2949603603
X-MC-Loop-Signature: 1692824103253:3757121709
X-MC-Ingress-Time: 1692824103253
Received: from pdx1-sub0-mail-a204.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.117.184.92 (trex/6.9.1);
        Wed, 23 Aug 2023 20:55:03 +0000
Received: from offworld (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a204.dreamhost.com (Postfix) with ESMTPSA id 4RWJPd4ZpXz62;
        Wed, 23 Aug 2023 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1692824102;
        bh=oG9XylOFOT0gIi+IEkLZe44xX84xVMa62F9+kGNjOEg=;
        h=Date:From:To:Cc:Subject:Content-Type;
        b=m42R/K1tGovb8gBauDLZcczTp6T5TCh4B639+r1mMQw4vj46pjMAwZ8yoNYyzjfie
         SKXOzC/lS9DtKD1NIPjJd4eKwp0f/vhXPpeYbzfnaNudUmjtaCVAs0OaX1p0wL7O82
         jonM0VhzrVcf9cOy5wiYGThc6xwHTwyHVQyyHM3FaPGomURzEuGqLuZqBgVBROstrV
         SXitpaYDTETw6+Ct/eXYRNuTh/woYskXmcsZQfuxFc0cocnzUO85cXogIIe94tgTG0
         lFjtzN91XSk7ZJm1CAxrCGgNlYMPXgKfUwDBjKrIo/CCCS4X84uFA4FphylQw0ACqI
         rctHBcxu0Bh8Q==
Date:   Wed, 23 Aug 2023 13:16:04 -0700
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        linuxarm@huawei.com, Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Gregory Price <gregory.price@memverge.com>,
        Viacheslav Dubeyko <slava@dubeyko.com>, fan.ni@samsung.com,
        a.manzanares@samsung.com
Subject: Re: [RFC PATCH v5 1/4] cxl: mbox: Preparatory move of functions to
 core/mbox.c and cxlmbox.h
Message-ID: <rkdwnch2fslpitax2pl5xvizpzxxfygf3w4j3gwaqame7qtjpi@ovwujhzo6gi3>
References: <20230804115414.14391-1-Jonathan.Cameron@huawei.com>
 <20230804115414.14391-2-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230804115414.14391-2-Jonathan.Cameron@huawei.com>
User-Agent: NeoMutt/20230517
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

On Fri, 04 Aug 2023, Jonathan Cameron wrote:

>A later patch will modify this code to separate out the mbox
>functionality from the memdev.  This patch is intended to make
>that a little more readable.  Related move of cxl_err(), cxl_cmd_err()
>to make them accessible from other parts of the cxl core code.
>
>Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>

>---
>v5: Move the related cxl_cmd etc header definitions as well as the
>implementation.
>
> drivers/cxl/core/mbox.c | 261 ++++++++++++++++++++++++++++++++++++++-
> drivers/cxl/cxlmbox.h   | 146 ++++++++++++++++++++++
> drivers/cxl/cxlmem.h    | 148 ++--------------------
> drivers/cxl/pci.c       | 265 +---------------------------------------
> 4 files changed, 418 insertions(+), 402 deletions(-)
>
>diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
>index ca60bb8114f2..6f359dc1c6d3 100644
>--- a/drivers/cxl/core/mbox.c
>+++ b/drivers/cxl/core/mbox.c
>@@ -1,10 +1,12 @@
> // SPDX-License-Identifier: GPL-2.0-only
> /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
>+#include <linux/io-64-nonatomic-lo-hi.h>
> #include <linux/security.h>
> #include <linux/debugfs.h>
> #include <linux/ktime.h>
> #include <linux/mutex.h>
> #include <asm/unaligned.h>
>+#include <cxlmbox.h>
> #include <cxlpci.h>
> #include <cxlmem.h>
> #include <cxl.h>
>@@ -12,6 +14,14 @@
> #include "core.h"
> #include "trace.h"
>
>+
>+/* CXL 2.0 - 8.2.8.4 */
>+#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>+
>+#define cxl_doorbell_busy(cxlds)                                                \
>+	(readl((cxlds)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>+	 CXLDEV_MBOX_CTRL_DOORBELL)
>+
> static bool cxl_raw_allow_all;
>
> /**
>@@ -219,6 +229,253 @@ static const char *cxl_mem_opcode_to_name(u16 opcode)
>	return cxl_command_names[c->info.id].name;
> }
>
>+int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>+{
>+	const unsigned long start = jiffies;
>+	unsigned long end = start;
>+
>+	while (cxl_doorbell_busy(cxlds)) {
>+		end = jiffies;
>+
>+		if (time_after(end, start + CXL_MAILBOX_TIMEOUT_MS)) {
>+			/* Check again in case preempted before timeout test */
>+			if (!cxl_doorbell_busy(cxlds))
>+				break;
>+			return -ETIMEDOUT;
>+		}
>+		cpu_relax();
>+	}
>+
>+	dev_dbg(cxlds->dev, "Doorbell wait took %dms",
>+		jiffies_to_msecs(end) - jiffies_to_msecs(start));
>+	return 0;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_pci_mbox_wait_for_doorbell, CXL);
>+
>+bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>+{
>+	u64 reg;
>+
>+	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>+	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
>+}
>+EXPORT_SYMBOL_NS_GPL(cxl_mbox_background_complete, CXL);
>+
>+/**
>+ * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>+ * @mds: The memory device driver data
>+ * @mbox_cmd: Command to send to the memory device.
>+ *
>+ * Context: Any context. Expects mbox_mutex to be held.
>+ * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
>+ *         Caller should check the return code in @mbox_cmd to make sure it
>+ *         succeeded.
>+ *
>+ * This is a generic form of the CXL mailbox send command thus only using the
>+ * registers defined by the mailbox capability ID - CXL 2.0 8.2.8.4. Memory
>+ * devices, and perhaps other types of CXL devices may have further information
>+ * available upon error conditions. Driver facilities wishing to send mailbox
>+ * commands should use the wrapper command.
>+ *
>+ * The CXL spec allows for up to two mailboxes. The intention is for the primary
>+ * mailbox to be OS controlled and the secondary mailbox to be used by system
>+ * firmware. This allows the OS and firmware to communicate with the device and
>+ * not need to coordinate with each other. The driver only uses the primary
>+ * mailbox.
>+ */
>+static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>+				   struct cxl_mbox_cmd *mbox_cmd)
>+{
>+	struct cxl_dev_state *cxlds = &mds->cxlds;
>+	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>+	struct device *dev = cxlds->dev;
>+	u64 cmd_reg, status_reg;
>+	size_t out_len;
>+	int rc;
>+
>+	lockdep_assert_held(&mds->mbox_mutex);
>+
>+	/*
>+	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
>+	 *   1. Caller reads MB Control Register to verify doorbell is clear
>+	 *   2. Caller writes Command Register
>+	 *   3. Caller writes Command Payload Registers if input payload is non-empty
>+	 *   4. Caller writes MB Control Register to set doorbell
>+	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
>+	 *   6. Caller reads MB Status Register to fetch Return code
>+	 *   7. If command successful, Caller reads Command Register to get Payload Length
>+	 *   8. If output payload is non-empty, host reads Command Payload Registers
>+	 *
>+	 * Hardware is free to do whatever it wants before the doorbell is rung,
>+	 * and isn't allowed to change anything after it clears the doorbell. As
>+	 * such, steps 2 and 3 can happen in any order, and steps 6, 7, 8 can
>+	 * also happen in any order (though some orders might not make sense).
>+	 */
>+
>+	/* #1 */
>+	if (cxl_doorbell_busy(cxlds)) {
>+		u64 md_status =
>+			readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>+
>+		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
>+			    "mailbox queue busy");
>+		return -EBUSY;
>+	}
>+
>+	/*
>+	 * With sanitize polling, hardware might be done and the poller still
>+	 * not be in sync. Ensure no new command comes in until so. Keep the
>+	 * hardware semantics and only allow device health status.
>+	 */
>+	if (mds->security.poll_tmo_secs > 0) {
>+		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
>+			return -EBUSY;
>+	}
>+
>+	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>+			     mbox_cmd->opcode);
>+	if (mbox_cmd->size_in) {
>+		if (WARN_ON(!mbox_cmd->payload_in))
>+			return -EINVAL;
>+
>+		cmd_reg |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK,
>+				      mbox_cmd->size_in);
>+		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
>+	}
>+
>+	/* #2, #3 */
>+	writeq(cmd_reg, cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>+
>+	/* #4 */
>+	dev_dbg(dev, "Sending command: 0x%04x\n", mbox_cmd->opcode);
>+	writel(CXLDEV_MBOX_CTRL_DOORBELL,
>+	       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>+
>+	/* #5 */
>+	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
>+	if (rc == -ETIMEDOUT) {
>+		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>+
>+		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status, "mailbox timeout");
>+		return rc;
>+	}
>+
>+	/* #6 */
>+	status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
>+	mbox_cmd->return_code =
>+		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>+
>+	/*
>+	 * Handle the background command in a synchronous manner.
>+	 *
>+	 * All other mailbox commands will serialize/queue on the mbox_mutex,
>+	 * which we currently hold. Furthermore this also guarantees that
>+	 * cxl_mbox_background_complete() checks are safe amongst each other,
>+	 * in that no new bg operation can occur in between.
>+	 *
>+	 * Background operations are timesliced in accordance with the nature
>+	 * of the command. In the event of timeout, the mailbox state is
>+	 * indeterminate until the next successful command submission and the
>+	 * driver can get back in sync with the hardware state.
>+	 */
>+	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>+		u64 bg_status_reg;
>+		int i, timeout;
>+
>+		/*
>+		 * Sanitization is a special case which monopolizes the device
>+		 * and cannot be timesliced. Handle asynchronously instead,
>+		 * and allow userspace to poll(2) for completion.
>+		 */
>+		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
>+			if (mds->security.poll) {
>+				/* hold the device throughout */
>+				get_device(cxlds->dev);
>+
>+				/* give first timeout a second */
>+				timeout = 1;
>+				mds->security.poll_tmo_secs = timeout;
>+				queue_delayed_work(system_wq,
>+						   &mds->security.poll_dwork,
>+						   timeout * HZ);
>+			}
>+
>+			dev_dbg(dev, "Sanitization operation started\n");
>+			goto success;
>+		}
>+
>+		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>+			mbox_cmd->opcode);
>+
>+		timeout = mbox_cmd->poll_interval_ms;
>+		for (i = 0; i < mbox_cmd->poll_count; i++) {
>+			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
>+				       cxl_mbox_background_complete(cxlds),
>+				       TASK_UNINTERRUPTIBLE,
>+				       msecs_to_jiffies(timeout)) > 0)
>+				break;
>+		}
>+
>+		if (!cxl_mbox_background_complete(cxlds)) {
>+			dev_err(dev, "timeout waiting for background (%d ms)\n",
>+				timeout * mbox_cmd->poll_count);
>+			return -ETIMEDOUT;
>+		}
>+
>+		bg_status_reg = readq(cxlds->regs.mbox +
>+				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>+		mbox_cmd->return_code =
>+			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
>+				  bg_status_reg);
>+		dev_dbg(dev,
>+			"Mailbox background operation (0x%04x) completed\n",
>+			mbox_cmd->opcode);
>+	}
>+
>+	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>+		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>+			cxl_mbox_cmd_rc2str(mbox_cmd));
>+		return 0; /* completed but caller must check return_code */
>+	}
>+
>+success:
>+	/* #7 */
>+	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>+	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
>+
>+	/* #8 */
>+	if (out_len && mbox_cmd->payload_out) {
>+		/*
>+		 * Sanitize the copy. If hardware misbehaves, out_len per the
>+		 * spec can actually be greater than the max allowed size (21
>+		 * bits available but spec defined 1M max). The caller also may
>+		 * have requested less data than the hardware supplied even
>+		 * within spec.
>+		 */
>+		size_t n;
>+
>+		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
>+		memcpy_fromio(mbox_cmd->payload_out, payload, n);
>+		mbox_cmd->size_out = n;
>+	} else {
>+		mbox_cmd->size_out = 0;
>+	}
>+
>+	return 0;
>+}
>+
>+static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>+			     struct cxl_mbox_cmd *cmd)
>+{
>+	int rc;
>+
>+	mutex_lock_io(&mds->mbox_mutex);
>+	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
>+	mutex_unlock(&mds->mbox_mutex);
>+
>+	return rc;
>+}
>+
> /**
>  * cxl_internal_send_cmd() - Kernel internal interface to send a mailbox command
>  * @mds: The driver data for the operation
>@@ -249,7 +506,7 @@ int cxl_internal_send_cmd(struct cxl_memdev_state *mds,
>
>	out_size = mbox_cmd->size_out;
>	min_out = mbox_cmd->min_out;
>-	rc = mds->mbox_send(mds, mbox_cmd);
>+	rc = cxl_pci_mbox_send(mds, mbox_cmd);
>	/*
>	 * EIO is reserved for a payload size mismatch and mbox_send()
>	 * may not return this error.
>@@ -588,7 +845,7 @@ static int handle_mailbox_cmd_from_user(struct cxl_memdev_state *mds,
>		cxl_mem_opcode_to_name(mbox_cmd->opcode),
>		mbox_cmd->opcode, mbox_cmd->size_in);
>
>-	rc = mds->mbox_send(mds, mbox_cmd);
>+	rc = cxl_pci_mbox_send(mds, mbox_cmd);
>	if (rc)
>		goto out;
>
>diff --git a/drivers/cxl/cxlmbox.h b/drivers/cxl/cxlmbox.h
>new file mode 100644
>index 000000000000..2b83b870a5e6
>--- /dev/null
>+++ b/drivers/cxl/cxlmbox.h
>@@ -0,0 +1,146 @@
>+/* SPDX-License-Identifier: GPL-2.0-only */
>+
>+#ifndef __CXLMBOX_H__
>+#define __CXLMBOX_H__
>+
>+struct cxl_dev_state;
>+int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds);
>+bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds);
>+
>+/**
>+ * struct cxl_mbox_cmd - A command to be submitted to hardware.
>+ * @opcode: (input) The command set and command submitted to hardware.
>+ * @payload_in: (input) Pointer to the input payload.
>+ * @payload_out: (output) Pointer to the output payload. Must be allocated by
>+ *		 the caller.
>+ * @size_in: (input) Number of bytes to load from @payload_in.
>+ * @size_out: (input) Max number of bytes loaded into @payload_out.
>+ *            (output) Number of bytes generated by the device. For fixed size
>+ *            outputs commands this is always expected to be deterministic. For
>+ *            variable sized output commands, it tells the exact number of bytes
>+ *            written.
>+ * @min_out: (input) internal command output payload size validation
>+ * @poll_count: (input) Number of timeouts to attempt.
>+ * @poll_interval_ms: (input) Time between mailbox background command polling
>+ *                    interval timeouts.
>+ * @return_code: (output) Error code returned from hardware.
>+ *
>+ * This is the primary mechanism used to send commands to the hardware.
>+ * All the fields except @payload_* correspond exactly to the fields described in
>+ * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
>+ * @payload_out are written to, and read from the Command Payload Registers
>+ * defined in CXL 2.0 8.2.8.4.8.
>+ */
>+struct cxl_mbox_cmd {
>+	u16 opcode;
>+	void *payload_in;
>+	void *payload_out;
>+	size_t size_in;
>+	size_t size_out;
>+	size_t min_out;
>+	int poll_count;
>+	int poll_interval_ms;
>+	u16 return_code;
>+};
>+
>+/*
>+ * Per CXL 3.0 Section 8.2.8.4.5.1
>+ */
>+#define CMD_CMD_RC_TABLE							\
>+	C(SUCCESS, 0, NULL),							\
>+	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
>+	C(INPUT, -ENXIO, "cmd input was invalid"),				\
>+	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
>+	C(INTERNAL, -ENXIO, "internal device error"),				\
>+	C(RETRY, -ENXIO, "temporary error, retry once"),			\
>+	C(BUSY, -ENXIO, "ongoing background operation"),			\
>+	C(MEDIADISABLED, -ENXIO, "media access is disabled"),			\
>+	C(FWINPROGRESS, -ENXIO,	"one FW package can be transferred at a time"), \
>+	C(FWOOO, -ENXIO, "FW package content was transferred out of order"),    \
>+	C(FWAUTH, -ENXIO, "FW package authentication failed"),			\
>+	C(FWSLOT, -ENXIO, "FW slot is not supported for requested operation"),  \
>+	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
>+	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
>+	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
>+	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
>+	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
>+	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
>+	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
>+	C(SECURITY, -ENXIO, "not valid in the current security state"),         \
>+	C(PASSPHRASE, -ENXIO, "phrase doesn't match current set passphrase"),   \
>+	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
>+	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
>+	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
>+	C(INTERRUPTED, -ENXIO, "asynchronous event occurred"),			\
>+	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
>+	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
>+	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
>+	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
>+	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
>+	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
>+
>+#undef C
>+#define C(a, b, c) CXL_MBOX_CMD_RC_##a
>+enum  { CMD_CMD_RC_TABLE };
>+#undef C
>+#define C(a, b, c) { b, c }
>+struct cxl_mbox_cmd_rc {
>+	int err;
>+	const char *desc;
>+};
>+
>+static const
>+struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] = { CMD_CMD_RC_TABLE };
>+#undef C
>+
>+static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
>+{
>+	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
>+}
>+
>+static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>+{
>+	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
>+}
>+
>+enum cxl_opcode {
>+	CXL_MBOX_OP_INVALID		= 0x0000,
>+	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>+	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>+	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>+	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
>+	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>+	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>+	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>+	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>+	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>+	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>+	CXL_MBOX_OP_GET_LOG		= 0x0401,
>+	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>+	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>+	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
>+	CXL_MBOX_OP_GET_LSA		= 0x4102,
>+	CXL_MBOX_OP_SET_LSA		= 0x4103,
>+	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
>+	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
>+	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
>+	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
>+	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
>+	CXL_MBOX_OP_GET_POISON		= 0x4300,
>+	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
>+	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
>+	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>+	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>+	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>+	CXL_MBOX_OP_SANITIZE		= 0x4400,
>+	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>+	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>+	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>+	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
>+	CXL_MBOX_OP_UNLOCK		= 0x4503,
>+	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>+	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
>+	CXL_MBOX_OP_MAX			= 0x10000
>+};
>+
>+#endif /* __CXLMBOX_H__ */
>diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
>index 706f8a6d1ef4..2b4f4c932501 100644
>--- a/drivers/cxl/cxlmem.h
>+++ b/drivers/cxl/cxlmem.h
>@@ -6,6 +6,7 @@
> #include <linux/cdev.h>
> #include <linux/uuid.h>
> #include <linux/rcuwait.h>
>+#include "cxlmbox.h"
> #include "cxl.h"
>
> /* CXL 2.0 8.2.8.5.1.1 Memory Device Status Register */
>@@ -31,6 +32,17 @@
>	(FIELD_GET(CXLMDEV_RESET_NEEDED_MASK, status) !=                       \
>	 CXLMDEV_RESET_NEEDED_NOT)
>
>+#define cxl_err(dev, status, msg)                                        \
>+	dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
>+			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>+			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>+
>+#define cxl_cmd_err(dev, cmd, status, msg)                               \
>+	dev_err_ratelimited(dev, msg " (opcode: %#x), device state %s%s\n",    \
>+			    (cmd)->opcode,                                     \
>+			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>+			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>+
> /**
>  * struct cxl_memdev - CXL bus object representing a Type-3 Memory Device
>  * @dev: driver core device object
>@@ -100,102 +112,6 @@ static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
>	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> }
>
>-/**
>- * struct cxl_mbox_cmd - A command to be submitted to hardware.
>- * @opcode: (input) The command set and command submitted to hardware.
>- * @payload_in: (input) Pointer to the input payload.
>- * @payload_out: (output) Pointer to the output payload. Must be allocated by
>- *		 the caller.
>- * @size_in: (input) Number of bytes to load from @payload_in.
>- * @size_out: (input) Max number of bytes loaded into @payload_out.
>- *            (output) Number of bytes generated by the device. For fixed size
>- *            outputs commands this is always expected to be deterministic. For
>- *            variable sized output commands, it tells the exact number of bytes
>- *            written.
>- * @min_out: (input) internal command output payload size validation
>- * @poll_count: (input) Number of timeouts to attempt.
>- * @poll_interval_ms: (input) Time between mailbox background command polling
>- *                    interval timeouts.
>- * @return_code: (output) Error code returned from hardware.
>- *
>- * This is the primary mechanism used to send commands to the hardware.
>- * All the fields except @payload_* correspond exactly to the fields described in
>- * Command Register section of the CXL 2.0 8.2.8.4.5. @payload_in and
>- * @payload_out are written to, and read from the Command Payload Registers
>- * defined in CXL 2.0 8.2.8.4.8.
>- */
>-struct cxl_mbox_cmd {
>-	u16 opcode;
>-	void *payload_in;
>-	void *payload_out;
>-	size_t size_in;
>-	size_t size_out;
>-	size_t min_out;
>-	int poll_count;
>-	int poll_interval_ms;
>-	u16 return_code;
>-};
>-
>-/*
>- * Per CXL 3.0 Section 8.2.8.4.5.1
>- */
>-#define CMD_CMD_RC_TABLE							\
>-	C(SUCCESS, 0, NULL),							\
>-	C(BACKGROUND, -ENXIO, "background cmd started successfully"),           \
>-	C(INPUT, -ENXIO, "cmd input was invalid"),				\
>-	C(UNSUPPORTED, -ENXIO, "cmd is not supported"),				\
>-	C(INTERNAL, -ENXIO, "internal device error"),				\
>-	C(RETRY, -ENXIO, "temporary error, retry once"),			\
>-	C(BUSY, -ENXIO, "ongoing background operation"),			\
>-	C(MEDIADISABLED, -ENXIO, "media access is disabled"),			\
>-	C(FWINPROGRESS, -ENXIO,	"one FW package can be transferred at a time"), \
>-	C(FWOOO, -ENXIO, "FW package content was transferred out of order"),    \
>-	C(FWAUTH, -ENXIO, "FW package authentication failed"),			\
>-	C(FWSLOT, -ENXIO, "FW slot is not supported for requested operation"),  \
>-	C(FWROLLBACK, -ENXIO, "rolled back to the previous active FW"),         \
>-	C(FWRESET, -ENXIO, "FW failed to activate, needs cold reset"),		\
>-	C(HANDLE, -ENXIO, "one or more Event Record Handles were invalid"),     \
>-	C(PADDR, -EFAULT, "physical address specified is invalid"),		\
>-	C(POISONLMT, -ENXIO, "poison injection limit has been reached"),        \
>-	C(MEDIAFAILURE, -ENXIO, "permanent issue with the media"),		\
>-	C(ABORT, -ENXIO, "background cmd was aborted by device"),               \
>-	C(SECURITY, -ENXIO, "not valid in the current security state"),         \
>-	C(PASSPHRASE, -ENXIO, "phrase doesn't match current set passphrase"),   \
>-	C(MBUNSUPPORTED, -ENXIO, "unsupported on the mailbox it was issued on"),\
>-	C(PAYLOADLEN, -ENXIO, "invalid payload length"),			\
>-	C(LOG, -ENXIO, "invalid or unsupported log page"),			\
>-	C(INTERRUPTED, -ENXIO, "asynchronous event occured"),			\
>-	C(FEATUREVERSION, -ENXIO, "unsupported feature version"),		\
>-	C(FEATURESELVALUE, -ENXIO, "unsupported feature selection value"),	\
>-	C(FEATURETRANSFERIP, -ENXIO, "feature transfer in progress"),		\
>-	C(FEATURETRANSFEROOO, -ENXIO, "feature transfer out of order"),		\
>-	C(RESOURCEEXHAUSTED, -ENXIO, "resources are exhausted"),		\
>-	C(EXTLIST, -ENXIO, "invalid Extent List"),				\
>-
>-#undef C
>-#define C(a, b, c) CXL_MBOX_CMD_RC_##a
>-enum  { CMD_CMD_RC_TABLE };
>-#undef C
>-#define C(a, b, c) { b, c }
>-struct cxl_mbox_cmd_rc {
>-	int err;
>-	const char *desc;
>-};
>-
>-static const
>-struct cxl_mbox_cmd_rc cxl_mbox_cmd_rctable[] ={ CMD_CMD_RC_TABLE };
>-#undef C
>-
>-static inline const char *cxl_mbox_cmd_rc2str(struct cxl_mbox_cmd *mbox_cmd)
>-{
>-	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].desc;
>-}
>-
>-static inline int cxl_mbox_cmd_rc2errno(struct cxl_mbox_cmd *mbox_cmd)
>-{
>-	return cxl_mbox_cmd_rctable[mbox_cmd->return_code].err;
>-}
>-
> /*
>  * CXL 2.0 - Memory capacity multiplier
>  * See Section 8.2.9.5
>@@ -490,46 +406,6 @@ to_cxl_memdev_state(struct cxl_dev_state *cxlds)
>	return container_of(cxlds, struct cxl_memdev_state, cxlds);
> }
>
>-enum cxl_opcode {
>-	CXL_MBOX_OP_INVALID		= 0x0000,
>-	CXL_MBOX_OP_RAW			= CXL_MBOX_OP_INVALID,
>-	CXL_MBOX_OP_GET_EVENT_RECORD	= 0x0100,
>-	CXL_MBOX_OP_CLEAR_EVENT_RECORD	= 0x0101,
>-	CXL_MBOX_OP_GET_EVT_INT_POLICY	= 0x0102,
>-	CXL_MBOX_OP_SET_EVT_INT_POLICY	= 0x0103,
>-	CXL_MBOX_OP_GET_FW_INFO		= 0x0200,
>-	CXL_MBOX_OP_TRANSFER_FW		= 0x0201,
>-	CXL_MBOX_OP_ACTIVATE_FW		= 0x0202,
>-	CXL_MBOX_OP_SET_TIMESTAMP	= 0x0301,
>-	CXL_MBOX_OP_GET_SUPPORTED_LOGS	= 0x0400,
>-	CXL_MBOX_OP_GET_LOG		= 0x0401,
>-	CXL_MBOX_OP_IDENTIFY		= 0x4000,
>-	CXL_MBOX_OP_GET_PARTITION_INFO	= 0x4100,
>-	CXL_MBOX_OP_SET_PARTITION_INFO	= 0x4101,
>-	CXL_MBOX_OP_GET_LSA		= 0x4102,
>-	CXL_MBOX_OP_SET_LSA		= 0x4103,
>-	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
>-	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
>-	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
>-	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
>-	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
>-	CXL_MBOX_OP_GET_POISON		= 0x4300,
>-	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
>-	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
>-	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
>-	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
>-	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
>-	CXL_MBOX_OP_SANITIZE		= 0x4400,
>-	CXL_MBOX_OP_SECURE_ERASE	= 0x4401,
>-	CXL_MBOX_OP_GET_SECURITY_STATE	= 0x4500,
>-	CXL_MBOX_OP_SET_PASSPHRASE	= 0x4501,
>-	CXL_MBOX_OP_DISABLE_PASSPHRASE	= 0x4502,
>-	CXL_MBOX_OP_UNLOCK		= 0x4503,
>-	CXL_MBOX_OP_FREEZE_SECURITY	= 0x4504,
>-	CXL_MBOX_OP_PASSPHRASE_SECURE_ERASE	= 0x4505,
>-	CXL_MBOX_OP_MAX			= 0x10000
>-};
>-
> #define DEFINE_CXL_CEL_UUID                                                    \
>	UUID_INIT(0xda9c0b5, 0xbf41, 0x4b78, 0x8f, 0x79, 0x96, 0xb1, 0x62,     \
>		  0x3b, 0x3f, 0x17)
>diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
>index 1cb1494c28fe..b11f2e7ad9fb 100644
>--- a/drivers/cxl/pci.c
>+++ b/drivers/cxl/pci.c
>@@ -10,6 +10,7 @@
> #include <linux/pci.h>
> #include <linux/aer.h>
> #include <linux/io.h>
>+#include "cxlmbox.h"
> #include "cxlmem.h"
> #include "cxlpci.h"
> #include "cxl.h"
>@@ -32,13 +33,6 @@
>  *  - Registers a CXL mailbox with cxl_core.
>  */
>
>-#define cxl_doorbell_busy(cxlds)                                                \
>-	(readl((cxlds)->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET) &                  \
>-	 CXLDEV_MBOX_CTRL_DOORBELL)
>-
>-/* CXL 2.0 - 8.2.8.4 */
>-#define CXL_MAILBOX_TIMEOUT_MS (2 * HZ)
>-
> /*
>  * CXL 2.0 ECN "Add Mailbox Ready Time" defines a capability field to
>  * dictate how long to wait for the mailbox to become ready. The new
>@@ -52,39 +46,6 @@ static unsigned short mbox_ready_timeout = 60;
> module_param(mbox_ready_timeout, ushort, 0644);
> MODULE_PARM_DESC(mbox_ready_timeout, "seconds to wait for mailbox ready");
>
>-static int cxl_pci_mbox_wait_for_doorbell(struct cxl_dev_state *cxlds)
>-{
>-	const unsigned long start = jiffies;
>-	unsigned long end = start;
>-
>-	while (cxl_doorbell_busy(cxlds)) {
>-		end = jiffies;
>-
>-		if (time_after(end, start + CXL_MAILBOX_TIMEOUT_MS)) {
>-			/* Check again in case preempted before timeout test */
>-			if (!cxl_doorbell_busy(cxlds))
>-				break;
>-			return -ETIMEDOUT;
>-		}
>-		cpu_relax();
>-	}
>-
>-	dev_dbg(cxlds->dev, "Doorbell wait took %dms",
>-		jiffies_to_msecs(end) - jiffies_to_msecs(start));
>-	return 0;
>-}
>-
>-#define cxl_err(dev, status, msg)                                        \
>-	dev_err_ratelimited(dev, msg ", device state %s%s\n",                  \
>-			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>-			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>-
>-#define cxl_cmd_err(dev, cmd, status, msg)                               \
>-	dev_err_ratelimited(dev, msg " (opcode: %#x), device state %s%s\n",    \
>-			    (cmd)->opcode,                                     \
>-			    status & CXLMDEV_DEV_FATAL ? " fatal" : "",        \
>-			    status & CXLMDEV_FW_HALT ? " firmware-halt" : "")
>-
> struct cxl_dev_id {
>	struct cxl_dev_state *cxlds;
> };
>@@ -106,14 +67,6 @@ static int cxl_request_irq(struct cxl_dev_state *cxlds, int irq,
>					 NULL, dev_id);
> }
>
>-static bool cxl_mbox_background_complete(struct cxl_dev_state *cxlds)
>-{
>-	u64 reg;
>-
>-	reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>-	return FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_PCT_MASK, reg) == 100;
>-}
>-
> static irqreturn_t cxl_pci_mbox_irq(int irq, void *id)
> {
>	u64 reg;
>@@ -168,221 +121,6 @@ static void cxl_mbox_sanitize_work(struct work_struct *work)
>	mutex_unlock(&mds->mbox_mutex);
> }
>
>-/**
>- * __cxl_pci_mbox_send_cmd() - Execute a mailbox command
>- * @mds: The memory device driver data
>- * @mbox_cmd: Command to send to the memory device.
>- *
>- * Context: Any context. Expects mbox_mutex to be held.
>- * Return: -ETIMEDOUT if timeout occurred waiting for completion. 0 on success.
>- *         Caller should check the return code in @mbox_cmd to make sure it
>- *         succeeded.
>- *
>- * This is a generic form of the CXL mailbox send command thus only using the
>- * registers defined by the mailbox capability ID - CXL 2.0 8.2.8.4. Memory
>- * devices, and perhaps other types of CXL devices may have further information
>- * available upon error conditions. Driver facilities wishing to send mailbox
>- * commands should use the wrapper command.
>- *
>- * The CXL spec allows for up to two mailboxes. The intention is for the primary
>- * mailbox to be OS controlled and the secondary mailbox to be used by system
>- * firmware. This allows the OS and firmware to communicate with the device and
>- * not need to coordinate with each other. The driver only uses the primary
>- * mailbox.
>- */
>-static int __cxl_pci_mbox_send_cmd(struct cxl_memdev_state *mds,
>-				   struct cxl_mbox_cmd *mbox_cmd)
>-{
>-	struct cxl_dev_state *cxlds = &mds->cxlds;
>-	void __iomem *payload = cxlds->regs.mbox + CXLDEV_MBOX_PAYLOAD_OFFSET;
>-	struct device *dev = cxlds->dev;
>-	u64 cmd_reg, status_reg;
>-	size_t out_len;
>-	int rc;
>-
>-	lockdep_assert_held(&mds->mbox_mutex);
>-
>-	/*
>-	 * Here are the steps from 8.2.8.4 of the CXL 2.0 spec.
>-	 *   1. Caller reads MB Control Register to verify doorbell is clear
>-	 *   2. Caller writes Command Register
>-	 *   3. Caller writes Command Payload Registers if input payload is non-empty
>-	 *   4. Caller writes MB Control Register to set doorbell
>-	 *   5. Caller either polls for doorbell to be clear or waits for interrupt if configured
>-	 *   6. Caller reads MB Status Register to fetch Return code
>-	 *   7. If command successful, Caller reads Command Register to get Payload Length
>-	 *   8. If output payload is non-empty, host reads Command Payload Registers
>-	 *
>-	 * Hardware is free to do whatever it wants before the doorbell is rung,
>-	 * and isn't allowed to change anything after it clears the doorbell. As
>-	 * such, steps 2 and 3 can happen in any order, and steps 6, 7, 8 can
>-	 * also happen in any order (though some orders might not make sense).
>-	 */
>-
>-	/* #1 */
>-	if (cxl_doorbell_busy(cxlds)) {
>-		u64 md_status =
>-			readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>-
>-		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status,
>-			    "mailbox queue busy");
>-		return -EBUSY;
>-	}
>-
>-	/*
>-	 * With sanitize polling, hardware might be done and the poller still
>-	 * not be in sync. Ensure no new command comes in until so. Keep the
>-	 * hardware semantics and only allow device health status.
>-	 */
>-	if (mds->security.poll_tmo_secs > 0) {
>-		if (mbox_cmd->opcode != CXL_MBOX_OP_GET_HEALTH_INFO)
>-			return -EBUSY;
>-	}
>-
>-	cmd_reg = FIELD_PREP(CXLDEV_MBOX_CMD_COMMAND_OPCODE_MASK,
>-			     mbox_cmd->opcode);
>-	if (mbox_cmd->size_in) {
>-		if (WARN_ON(!mbox_cmd->payload_in))
>-			return -EINVAL;
>-
>-		cmd_reg |= FIELD_PREP(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK,
>-				      mbox_cmd->size_in);
>-		memcpy_toio(payload, mbox_cmd->payload_in, mbox_cmd->size_in);
>-	}
>-
>-	/* #2, #3 */
>-	writeq(cmd_reg, cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>-
>-	/* #4 */
>-	dev_dbg(dev, "Sending command: 0x%04x\n", mbox_cmd->opcode);
>-	writel(CXLDEV_MBOX_CTRL_DOORBELL,
>-	       cxlds->regs.mbox + CXLDEV_MBOX_CTRL_OFFSET);
>-
>-	/* #5 */
>-	rc = cxl_pci_mbox_wait_for_doorbell(cxlds);
>-	if (rc == -ETIMEDOUT) {
>-		u64 md_status = readq(cxlds->regs.memdev + CXLMDEV_STATUS_OFFSET);
>-
>-		cxl_cmd_err(cxlds->dev, mbox_cmd, md_status, "mailbox timeout");
>-		return rc;
>-	}
>-
>-	/* #6 */
>-	status_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_STATUS_OFFSET);
>-	mbox_cmd->return_code =
>-		FIELD_GET(CXLDEV_MBOX_STATUS_RET_CODE_MASK, status_reg);
>-
>-	/*
>-	 * Handle the background command in a synchronous manner.
>-	 *
>-	 * All other mailbox commands will serialize/queue on the mbox_mutex,
>-	 * which we currently hold. Furthermore this also guarantees that
>-	 * cxl_mbox_background_complete() checks are safe amongst each other,
>-	 * in that no new bg operation can occur in between.
>-	 *
>-	 * Background operations are timesliced in accordance with the nature
>-	 * of the command. In the event of timeout, the mailbox state is
>-	 * indeterminate until the next successful command submission and the
>-	 * driver can get back in sync with the hardware state.
>-	 */
>-	if (mbox_cmd->return_code == CXL_MBOX_CMD_RC_BACKGROUND) {
>-		u64 bg_status_reg;
>-		int i, timeout;
>-
>-		/*
>-		 * Sanitization is a special case which monopolizes the device
>-		 * and cannot be timesliced. Handle asynchronously instead,
>-		 * and allow userspace to poll(2) for completion.
>-		 */
>-		if (mbox_cmd->opcode == CXL_MBOX_OP_SANITIZE) {
>-			if (mds->security.poll) {
>-				/* hold the device throughout */
>-				get_device(cxlds->dev);
>-
>-				/* give first timeout a second */
>-				timeout = 1;
>-				mds->security.poll_tmo_secs = timeout;
>-				queue_delayed_work(system_wq,
>-						   &mds->security.poll_dwork,
>-						   timeout * HZ);
>-			}
>-
>-			dev_dbg(dev, "Sanitization operation started\n");
>-			goto success;
>-		}
>-
>-		dev_dbg(dev, "Mailbox background operation (0x%04x) started\n",
>-			mbox_cmd->opcode);
>-
>-		timeout = mbox_cmd->poll_interval_ms;
>-		for (i = 0; i < mbox_cmd->poll_count; i++) {
>-			if (rcuwait_wait_event_timeout(&mds->mbox_wait,
>-				       cxl_mbox_background_complete(cxlds),
>-				       TASK_UNINTERRUPTIBLE,
>-				       msecs_to_jiffies(timeout)) > 0)
>-				break;
>-		}
>-
>-		if (!cxl_mbox_background_complete(cxlds)) {
>-			dev_err(dev, "timeout waiting for background (%d ms)\n",
>-				timeout * mbox_cmd->poll_count);
>-			return -ETIMEDOUT;
>-		}
>-
>-		bg_status_reg = readq(cxlds->regs.mbox +
>-				      CXLDEV_MBOX_BG_CMD_STATUS_OFFSET);
>-		mbox_cmd->return_code =
>-			FIELD_GET(CXLDEV_MBOX_BG_CMD_COMMAND_RC_MASK,
>-				  bg_status_reg);
>-		dev_dbg(dev,
>-			"Mailbox background operation (0x%04x) completed\n",
>-			mbox_cmd->opcode);
>-	}
>-
>-	if (mbox_cmd->return_code != CXL_MBOX_CMD_RC_SUCCESS) {
>-		dev_dbg(dev, "Mailbox operation had an error: %s\n",
>-			cxl_mbox_cmd_rc2str(mbox_cmd));
>-		return 0; /* completed but caller must check return_code */
>-	}
>-
>-success:
>-	/* #7 */
>-	cmd_reg = readq(cxlds->regs.mbox + CXLDEV_MBOX_CMD_OFFSET);
>-	out_len = FIELD_GET(CXLDEV_MBOX_CMD_PAYLOAD_LENGTH_MASK, cmd_reg);
>-
>-	/* #8 */
>-	if (out_len && mbox_cmd->payload_out) {
>-		/*
>-		 * Sanitize the copy. If hardware misbehaves, out_len per the
>-		 * spec can actually be greater than the max allowed size (21
>-		 * bits available but spec defined 1M max). The caller also may
>-		 * have requested less data than the hardware supplied even
>-		 * within spec.
>-		 */
>-		size_t n;
>-
>-		n = min3(mbox_cmd->size_out, mds->payload_size, out_len);
>-		memcpy_fromio(mbox_cmd->payload_out, payload, n);
>-		mbox_cmd->size_out = n;
>-	} else {
>-		mbox_cmd->size_out = 0;
>-	}
>-
>-	return 0;
>-}
>-
>-static int cxl_pci_mbox_send(struct cxl_memdev_state *mds,
>-			     struct cxl_mbox_cmd *cmd)
>-{
>-	int rc;
>-
>-	mutex_lock_io(&mds->mbox_mutex);
>-	rc = __cxl_pci_mbox_send_cmd(mds, cmd);
>-	mutex_unlock(&mds->mbox_mutex);
>-
>-	return rc;
>-}
>-
> static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> {
>	struct cxl_dev_state *cxlds = &mds->cxlds;
>@@ -416,7 +154,6 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
>		return -ETIMEDOUT;
>	}
>
>-	mds->mbox_send = cxl_pci_mbox_send;
>	mds->payload_size =
>		1 << FIELD_GET(CXLDEV_MBOX_CAP_PAYLOAD_SIZE_MASK, cap);
>
>--
>2.39.2
>
