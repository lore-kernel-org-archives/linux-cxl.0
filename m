Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD58C6FD18
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 18:04:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjDRSES (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232340AbjDRSER (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 14:04:17 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709DD61BA
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 11:04:15 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 22C278C0FBE;
        Tue, 18 Apr 2023 17:55:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 8D57C8C0F40;
        Tue, 18 Apr 2023 17:55:05 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681840505; a=rsa-sha256;
        cv=none;
        b=JPJIr/Pc/iTngpFqOVgFDkxPgKxE2K5xTzVt9zsm4hx5wt4+Qnh9mz6ku9jFmmTwH3E39o
        DA0D22EKSpwbKQp4W7FpqtLYledCoVF+i8ddOrXJDVmMCQnjG5+XM329I8tBtnSuFbmaJs
        IHkq8ntvY/WfkY9m9YGkHO4jqvJw3mfJnrt5F6gLT7IDn9zQS1MJdQVBNaalYT4rFE8FMw
        yUdwn0gTpScR59resK/Kw1WHaNF0T61q32zoh3b631mCBXAE5NU3JRjk618mRSrjyYNX53
        Svlfh6RzQUN80yxH2ufWDvpjQcBLaCOA9Jc7VssosyhfV58i4bzg+A1isB6Z8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681840505;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=XmAzEjoPyyq2SsP40EifHb6h7nFUwyqB1i9NozkHkKI=;
        b=5vt1zUTSiuZuk6OxQLgRWlyQUCD9iFwjPSq2T1keHJtoKEgT04NXZJjepyrJLUeg7wT86L
        d0/xsIPez2m12C9Cn0aMhzhS2siUl/mc1AdFnu7iMnE6yG4Ri0gWeuI0lyNWoatA4pQyaA
        NMg7ldwTHdtDHBW7TYw67NX/Dimjzz/lfs/MCNY3wIB2jw61tHrHM3kEG4Gre7WNRWsryG
        1SClsomMzqYGNZXT6Ez0egKYoQXodJLRZS6Om6mzavdkvtp7JxsXF0tZMMsNpZs34dJYQs
        pSzD4CKU0ZHIkXLrz9GMBv6Ek1KUjlcGOQMoCqlanigEPrV9qCLejQCgGiMBkQ==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-4vvzd;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abortive-Attack: 6429c9b14ef085de_1681840505963_1479405905
X-MC-Loop-Signature: 1681840505963:1610252168
X-MC-Ingress-Time: 1681840505963
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.123.193.179 (trex/6.7.2);
        Tue, 18 Apr 2023 17:55:05 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4Q1BQc4tBJzS6;
        Tue, 18 Apr 2023 10:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681840505;
        bh=XmAzEjoPyyq2SsP40EifHb6h7nFUwyqB1i9NozkHkKI=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=ldxjpA0hknemtnC8qkG9ametbKoxrz7hugKCT22+B4dzyXWN8rxCJEnrZLeeZy/tj
         6gBpSEsZ0JjIgdbtXi06G49zRzMsrxo2F7yrh3tlrU3VLyXqBo7g2chzzizvuR8U37
         lxuHeB5jSMIFnsG5TyDfjd0L7h1VNvu2nk9WEn3rJ7Y7SDN3doySh+hQQfUgusCvWN
         iohtedVIMwAjky/MzQqc0md7nigfzaTwNYjhMTFzaSvCcn6hNEFbH+Uzr3E8Akiaym
         bqrJ8QYax8wgwqPhQHBuyBGx8FeOyRzhSVoTNVZCiFWvQutPfaq3Uhbimxp+WDDgNv
         FX6ddNHUByF6Q==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 1/5] cxl/mbox: Add support for background operations
Date:   Tue, 18 Apr 2023 10:23:33 -0700
Message-Id: <20230418172337.19207-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418172337.19207-1-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Support background commands in the mailbox, and while at it update
cmd_infostat_bg_op_sts() accordingly. This patch does not implement
mbox interrupts upon completion, so the kernel driver must rely on
polling to know when the operation is done.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-device-utils.c   |  5 +-
 hw/cxl/cxl-mailbox-utils.c  | 95 ++++++++++++++++++++++++++++++++++++-
 hw/mem/cxl_type3.c          |  2 +
 include/hw/cxl/cxl_device.h | 10 ++++
 4 files changed, 107 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 50c76c65e755..4bb4e85dae19 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -101,8 +101,7 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
     case A_CXL_DEV_MAILBOX_CMD:
         break;
     case A_CXL_DEV_BG_CMD_STS:
-        /* BG not supported */
-        /* fallthrough */
+        break;
     case A_CXL_DEV_MAILBOX_STS:
         /* Read only register, will get updated by the state machine */
         return;
@@ -273,7 +272,7 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt or background support */
+    /* 2048 payload size, with no interrupt */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b02908c4a4ba..1a4480d42908 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -350,7 +350,14 @@ static CXLRetCode cmd_infostat_bg_op_sts(struct cxl_cmd *cmd,
 
     bg_op_status = (void *)cmd->payload;
     memset(bg_op_status, 0, sizeof(*bg_op_status));
-    /* No support yet for background operations so status all 0 */
+    bg_op_status->status = ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state64,
+                                            CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP) << 1;
+    if (cxl_dstate->bg.runtime > 0) {
+        bg_op_status->status |= 1U << 0;
+    }
+    bg_op_status->opcode = cxl_dstate->bg.opcode;
+    bg_op_status->returncode = ARRAY_FIELD_EX64(cxl_dstate->mbox_reg_state64,
+                                               CXL_DEV_BG_CMD_STS, RET_CODE);
     *len = sizeof(*bg_op_status);
     return CXL_MBOX_SUCCESS;
 }
@@ -808,6 +815,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
+#define BACKGROUND_OPERATION (1 << 5)
 
 static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
@@ -856,12 +864,20 @@ static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0x49 },
 };
 
+/*
+ * While the command is executing in the background, the device should
+ * update the percentage complete in the Background Command Status Register
+ * at least once per second.
+ */
+#define CXL_MBOX_BG_UPDATE_FREQ 1000ULL
+
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
     struct cxl_cmd *cxl_cmd;
     uint64_t status_reg;
     opcode_handler h;
+    uint8_t bg_started = 0;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
@@ -873,7 +889,17 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
         if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
             cxl_cmd->payload = cxl_dstate->mbox_reg_state +
                 A_CXL_DEV_CMD_PAYLOAD;
+            /* Only one bg command at a time */
+            if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+                cxl_dstate->bg.runtime > 0) {
+                    ret = CXL_MBOX_BUSY;
+                    goto done;
+            }
             ret = (*h)(cxl_cmd, cxl_dstate, &len);
+            if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
+                ret == CXL_MBOX_BG_STARTED) {
+                bg_started = 1;
+            }
             assert(len <= cxl_dstate->payload_size);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -884,8 +910,13 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
         ret = CXL_MBOX_UNSUPPORTED;
     }
 
-    /* Set the return code */
+done:
+    /* Set the return code and background status */
     status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
+    if (bg_started) {
+        status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS,
+                                BG_OP, bg_started);
+    }
 
     /* Set the return length */
     command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
@@ -895,11 +926,66 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
 
+    if (bg_started) {
+        uint64_t bg_status_reg, now;
+
+        cxl_dstate->bg.opcode = (set << 8) | cmd;
+
+        bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP, cxl_dstate->bg.opcode);
+        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                   PERCENTAGE_COMP, 0);
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
+
+        now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+        cxl_dstate->bg.starttime = now;
+        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
+    }
+
     /* Tell the host we're done */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
                      DOORBELL, 0);
 }
 
+static void bg_timercb(void *opaque)
+{
+    CXLDeviceState *cxl_dstate = opaque;
+    uint64_t bg_status_reg = 0;
+    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    uint64_t total_time = cxl_dstate->bg.starttime + cxl_dstate->bg.runtime;
+
+    assert(cxl_dstate->bg.runtime > 0);
+    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                               OP, cxl_dstate->bg.opcode);
+
+    if (now >= total_time) { /* we are done */
+        uint64_t status_reg;
+        uint16_t ret = CXL_MBOX_SUCCESS;
+
+        cxl_dstate->bg.complete_pct = 100;
+        /* clear bg */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+
+        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
+
+        /* TODO add ad-hoc cmd succesful completion handling */
+    } else {
+        /* estimate only */
+        cxl_dstate->bg.complete_pct = 100 * now / total_time;
+        timer_mod(cxl_dstate->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
+    }
+
+    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, PERCENTAGE_COMP,
+                               cxl_dstate->bg.complete_pct);
+    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
+
+    if (cxl_dstate->bg.complete_pct == 100) {
+        cxl_dstate->bg.starttime = 0;
+        /* registers are updated, allow new bg-capable cmds */
+        cxl_dstate->bg.runtime = 0;
+    }
+}
+
 void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
 {
     if (!switch_cci) {
@@ -920,4 +1006,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
             }
         }
     }
+    cxl_dstate->bg.complete_pct = 0;
+    cxl_dstate->bg.starttime = 0;
+    cxl_dstate->bg.runtime = 0;
+    cxl_dstate->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                        bg_timercb, cxl_dstate);
 }
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 334ce92f5e0f..63c28a1ed5d2 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -870,12 +870,14 @@ static void ct3_exit(PCIDevice *pci_dev)
 {
     CXLType3Dev *ct3d = CXL_TYPE3(pci_dev);
     CXLComponentState *cxl_cstate = &ct3d->cxl_cstate;
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     ComponentRegisters *regs = &cxl_cstate->crb;
 
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     spdm_sock_fini(ct3d->doe_spdm.socket);
     g_free(regs->special_ops);
+    timer_free(cxl_dstate->bg.timer);
     if (ct3d->hostpmem) {
         address_space_destroy(&ct3d->hostpmem_as);
     }
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 1fa8522d33fa..dbb8a955723b 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -216,6 +216,16 @@ typedef struct cxl_device_state {
     struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
+
+    /* background command handling (times in ms) */
+    struct {
+        uint16_t opcode;
+        uint16_t complete_pct;
+        uint64_t starttime;
+        /* set by each bg cmd, cleared by the bg_timer when complete */
+        uint64_t runtime;
+        QEMUTimer *timer;
+    } bg;
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
-- 
2.40.0

