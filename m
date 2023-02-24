Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5B7C64ED8
	for <linux-cxl@archiver.kernel.org>; Fri, 24 Feb 2023 19:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBXTpD (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Fri, 24 Feb 2023 14:45:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjBXTpC (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Fri, 24 Feb 2023 14:45:02 -0500
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7408E2448B
        for <linux-cxl@vger.kernel.org>; Fri, 24 Feb 2023 11:44:58 -0800 (PST)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A9FB5501335;
        Fri, 24 Feb 2023 19:44:57 +0000 (UTC)
Received: from pdx1-sub0-mail-a250.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 06E16500A6D;
        Fri, 24 Feb 2023 19:44:56 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1677267897; a=rsa-sha256;
        cv=none;
        b=ThmhuLn5FNNLFsgo+R+8Kw50wDIE5bCWZXmoOtGTpVfqs1pKfCVD6z6tVAMcN27MKVsggK
        Gd7Fl1UZcJE7SoAF3KK4R+mu7Kd50cJB92aX0jXu5ZqWKekBihtwkM+sJXBwjCXhh2LxOw
        WS+HSa76wR8PIY7sQi8LQUVobweZoFErJgE+nAGf/tENrK3HfMGjueNUuMb/IP8nn5i1u+
        E4eIKT2nLBqkPeICl0Wd+Zr4iadK7/idQW1PJaJZmXMo7Ko8QVJ3y+dClFcdbPu2EyOeHL
        CsjdsC+BjyH8YXBJzPhoRHQbI6mSz+2x1TAiXYHEKrW61g6e7JPILXzDYJ4L9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1677267897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=g1QDvSxx1O95soxKIdw14n3lX3fGIwHtaHOnHWi/7qo=;
        b=LpagVnpq7xJ5PBtowmR2zZkYS6q3p3mOFbzkH0wf0bzKirW48OwnmD4FCxvLjftYfW8Jqt
        xnN9tGIz0/KfX7UMNTr1ostDC6WR+TwooakDT0s5aLxVFhwHkLs8ehfgfX90E3r0iduBUY
        iFpeF8XvVPUFw4Pizjr8dhyOZ+gFmux0vPh/sKf21ZiM/Pj1P4EVd7iEkwhWbaVVfkVds4
        kxQMBxp0czEVyVEPhbEnZFnDpe7BQdSKU6ODW3OW5MrEY4BFhqX3hSJAh0BI56z5SQmQSb
        0B5MBkJzB3WJP1cz68ZaZsloexArqHBSf7v5Pz7e+lnXr2bqnV1M9GyigikQYg==
ARC-Authentication-Results: i=1;
        rspamd-9788b98bc-b7snb;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Invention-Lyrical: 18d8d30443a89104_1677267897568_2183879968
X-MC-Loop-Signature: 1677267897568:2392973897
X-MC-Ingress-Time: 1677267897568
Received: from pdx1-sub0-mail-a250.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.97.48.87 (trex/6.7.1);
        Fri, 24 Feb 2023 19:44:57 +0000
Received: from offworld.. (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a250.dreamhost.com (Postfix) with ESMTPSA id 4PNgMq4fD8z2d;
        Fri, 24 Feb 2023 11:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1677267896;
        bh=g1QDvSxx1O95soxKIdw14n3lX3fGIwHtaHOnHWi/7qo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=lttsjI5mHytvQhv8BDAnuhFD3zdPHvx8sJfGhMYV/hdiLAPDlL6jtViMJffh8Pbae
         Kt+DCtMcVNB9yakAb1ZXssOFow/Yx6Wb5TI94kof0vxhAlwSczT7tpIBhYvc0cGZBE
         AlZC4yO221WXi/VJBEoVyhuHO2OYCb+8bCMimGEZH0X5uv94QA2OsBmjyuDKA4VpYj
         cddg8PGjhG8WcbrhUwnWz80jE7T+pH/PKfx2OL3xOKHRqMeE6SdxAT1mJhSCjGLNBA
         a8nykVRIg5DIyKYFHcBGURMnU39FqQm8WRNX65LndVWzRUMFj35OwnP9cwGaZ6Q7CL
         7ddtZxVuEuLGg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     jonathan.cameron@huawei.com
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, linux-cxl@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 1/3] cxl/mbox: Add support for background operations
Date:   Fri, 24 Feb 2023 11:44:41 -0800
Message-Id: <20230224194443.1990440-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230224194443.1990440-1-dave@stgolabs.net>
References: <20230224194443.1990440-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Support background commands in the mailbox, and update
cmd_infostat_bg_op_sts() accordingly. This patch does
not implement mbox interrupts upon completion, so the
kernel driver must rely on polling to know when the
operation is done.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-device-utils.c   |   5 +-
 hw/cxl/cxl-mailbox-utils.c  | 103 ++++++++++++++++++++++++++++++++++--
 include/hw/cxl/cxl_device.h |  10 ++++
 3 files changed, 111 insertions(+), 7 deletions(-)

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
index b02908c4a4ba..82923bb84eb0 100644
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
@@ -808,6 +815,8 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
 #define IMMEDIATE_DATA_CHANGE (1 << 2)
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
+#define SECURITY_STATE_CHANGE (1 << 5)
+#define BACKGROUND_OPERATION (1 << 6)
 
 static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
@@ -856,12 +865,20 @@ static struct cxl_cmd cxl_cmd_set_sw[256][256] = {
         cmd_identify_switch_device, 0, 0x49 },
 };
 
+/*
+ * While the command is executing in the background, the device should
+ * update the percentage complete in the Background Command Status Register
+ * at least once per second.
+ */
+#define CXL_MBOX_BG_UPDATE_FREQ 1000UL
+
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
     struct cxl_cmd *cxl_cmd;
-    uint64_t status_reg;
+    uint64_t status_reg = 0;
     opcode_handler h;
+    uint8_t bg_started = 0;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
@@ -873,7 +890,17 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
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
@@ -884,8 +911,12 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
         ret = CXL_MBOX_UNSUPPORTED;
     }
 
-    /* Set the return code */
-    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
+done:
+    /* Set bg and the return code */
+    if (bg_started) {
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, bg_started);
+    }
+    status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, ret);
 
     /* Set the return length */
     command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
@@ -895,11 +926,70 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
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
+        /* Clear bg */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+
+        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS, RET_CODE, ret);
+
+        /* TODO add ad-hoc cmd succesful completion handling */
+
+        qemu_log("Background command %04xh finished: %s\n",
+                 cxl_dstate->bg.opcode,
+                 ret == CXL_MBOX_SUCCESS ? "success" : "aborted");
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
@@ -920,4 +1010,9 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate, bool switch_cci)
             }
         }
     }
+    cxl_dstate->bg.complete_pct = 0;
+    cxl_dstate->bg.starttime = 0;
+    cxl_dstate->bg.runtime = 0;
+    cxl_dstate->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
+                                        bg_timercb, cxl_dstate);
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
2.39.2

