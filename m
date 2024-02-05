Received: from serval.cherry.relay.mailchannels.net (serval.cherry.relay.mailchannels.net [23.83.223.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD51482CB
	for <linux-cxl@vger.kernel.org>; Mon,  5 Feb 2024 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.223.163
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707154221; cv=pass; b=a8oyKJRsi7uOmLmZIW/m33/Kcc4nEktKarAZ43wMWpBqsFaElpV6pPK+5vXrF6FnGASHxMh2imYEbZeX9MkDA0q436oFJCS46rd/d4LjWRtHLM2RUvh0SQfzr6pGnM98N11vOz1xV6CLm7sBBfSGxF6ZFa06vAKbyacWMgF8ii8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707154221; c=relaxed/simple;
	bh=ZvMu0pj2Mkh2skevwKyMreIS8keoRnJAN0S60IkfD8k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uv/CsEAfk/4C/00D0YEJH0bD/YJIqqAKXT3eBjKB9VUGufcg2Evj3GeE8k1DaDRm9iCxUHQj2ELggk19L/SFS9s3DxlXqht9ncgvUoVlPIdPr0oIMUiptFH9pQr5NGi7eMZIFv5zTfUmD/3kVoegf/x4fXWo5FDPEX38REEYebQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=pKvG/G1r; arc=pass smtp.client-ip=23.83.223.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="pKvG/G1r"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 31B7E4C43B8;
	Mon,  5 Feb 2024 17:30:13 +0000 (UTC)
Received: from pdx1-sub0-mail-a248.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id AFC944C579B;
	Mon,  5 Feb 2024 17:30:12 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1707154212; a=rsa-sha256;
	cv=none;
	b=cQWhZdOhfBkvQCmMlqL0fZdVXUTbB8HfrNbMS0eWeQcIVstxNWnPiYZJ6cHiNAa7Sy13cP
	N+0TAOujVkec4yYridZEZzo8/s9HC8UgvAv5LcydWo5mTbicw5fg2VvOUQ1DWx3PDs2K/m
	CrXrJJwa/YB2K4mEn6Yq6Q0jzX7OgIPM9TktVBgcuLk1g550GlpvxFF1YvjtDynh7DAIHZ
	LZBaxzVrn6eMe1GKlW1AJjMDtLhJIc7jeJuSGOkyrnig4ddVftrX5HmbJGmGbz08aB723Z
	Qba+BFcfcQQRBN+haZ0XiiEExSmgHrvhFdIkyvbWTMbNmx4r3lXKpNGRXtmE/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1707154212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=c5UK2G5F4Ob/Im9+urX00NMcSmzH1Te3ZTEEXh1ZjY8=;
	b=XC4Om+1hKL9cNo+nt7fIBCVkbM0lYuE4XfIwqfJSyWRARNQgMbmppOJSefLMTg0y/HQBth
	cjKeMDGnW9Vn8JIhxCdQVNknlYY0oUsJz/eBCrMXJBFagV8fhVuxv//6NK2Xom9TIP8hCL
	gNRZW+X8/eTQxoA9gt1dF7sKzjerMeRfDSlX5Yf3UoDRX56iykKVhkbb5rIkx0QxnI/US6
	wWMHB2hj/VGf3Ve9uev30ZM5YYpK8POwDmoyNCib+Vqf/dNE9mU5k7GWqsS+bgGL26o/eR
	c6eVIR90LkAiBFA+xRLa52fV0V4a9AptclR9ND3dvEJuagpPC0ZCRQBpo3WK2A==
ARC-Authentication-Results: i=1;
	rspamd-55b4bfd7cb-m6cs8;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Shoe-Little: 2cd48a412f12c82b_1707154212999_2253009332
X-MC-Loop-Signature: 1707154212999:137003898
X-MC-Ingress-Time: 1707154212999
Received: from pdx1-sub0-mail-a248.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.20.149 (trex/6.9.2);
	Mon, 05 Feb 2024 17:30:12 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a248.dreamhost.com (Postfix) with ESMTPSA id 4TTD0h0LKZz5k;
	Mon,  5 Feb 2024 09:30:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1707154212;
	bh=c5UK2G5F4Ob/Im9+urX00NMcSmzH1Te3ZTEEXh1ZjY8=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=pKvG/G1r8LPMTGzPuYKe13tEbyn0RQxsMDAs57AnGj5wPcdlyslWsMv242jttPbRq
	 8eRLjF65rHCNhp3O6vLickS8rCX2G/iZCVA33AdTYu87YPWYzYyspZmg3RCZYU/UZr
	 7HAFXeIyNYi4zD9IbVS0E0A7SJQAyh5Msekev9AHv6BNWiqPMX9IqlpsdUY8eaSYkM
	 /GLJIYDwL53cD6Vj7YXjp5cFdNnnUi5C8+/zkox/WLVZ8RcbHOHCkHMhfm16IWr5lb
	 +cD67g86S83geRpTbcAFrtGUjl78/GSVf2ifNXH6/uIMkTBIErre5t2BCy9eNclpV6
	 rYUfv6NqXqM2Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: vishal.l.verma@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v2 -qemu] hw/cxl: Support firmware updates
Date: Mon,  5 Feb 2024 09:29:42 -0800
Message-ID: <20240205172942.13343-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Implement transfer and activate functionality per 3.1 spec for
supporting update metadata (no actual buffers). Transfer times
are arbitrarily set to ten and two seconds for full and part
transfers, respectively.

Testing for both a successful part fw package transfer success
and abort/cancel cases:

// on-going partial xfer
{
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":true,
    "remaining_size":1280
  }
}

// xfer complete
{
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":2,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "slot_2_version":"BWFW VERSION 1",
    "fw_update_in_progress":false
  }
}

// on-going (new) partial xfer
{
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "staged_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":false
  }
}

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
Changes from v1:
 - robustify part transfer checking (Jonathan)
 - implement abort
 - increase runtime for full transfer
 - no longer prematurely mark the slot
 - fold both cmds into a single patch

 hw/cxl/cxl-mailbox-utils.c  | 217 +++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |  16 +++
 2 files changed, 228 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 80a80f1ec29b..74054855b1fa 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -60,6 +60,8 @@ enum {
         #define SET_INTERRUPT_POLICY   0x3
     FIRMWARE_UPDATE = 0x02,
         #define GET_INFO      0x0
+        #define TRANSFER      0x1
+        #define ACTIVATE      0x2
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -815,6 +817,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_FW_SLOTS 2
+#define CXL_FW_SIZE  0x02000000 /* 32 mb */
+
 /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -846,15 +851,204 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     fw_info = (void *)payload_out;
     memset(fw_info, 0, sizeof(*fw_info));
 
-    fw_info->slots_supported = 2;
-    fw_info->slot_info = BIT(0) | BIT(3);
-    fw_info->caps = 0;
-    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    fw_info->slots_supported = CXL_FW_SLOTS;
+    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
+            ((cci->fw.staged_slot & 0x7) << 3);
+    fw_info->caps = BIT(0);
+
+    if (cci->fw.slot[0]) {
+        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    }
+    if (cci->fw.slot[1]) {
+        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
+    }
 
     *len_out = sizeof(*fw_info);
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 section 8.2.9.3.2: Transfer FW (Opcode 0201h) */
+#define CXL_FW_XFER_ALIGNMENT   128
+
+#define CXL_FW_XFER_ACTION_FULL	    0x0
+#define CXL_FW_XFER_ACTION_INIT	    0x1
+#define CXL_FW_XFER_ACTION_CONTINUE 0x2
+#define CXL_FW_XFER_ACTION_END	    0x3
+#define CXL_FW_XFER_ACTION_ABORT    0x4
+
+static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    struct {
+        uint8_t action;
+        uint8_t slot;
+        uint8_t caps;
+        uint8_t rsvd1[2];
+        uint32_t offset;
+        uint8_t rsvd2[0x78];
+        uint8_t data[];
+    } QEMU_PACKED *fw_transfer = (void *)payload_in;
+    size_t offset, length;
+
+    if (fw_transfer->action == CXL_FW_XFER_ACTION_ABORT) {
+        /*
+         * At this point there aren't any on-going transfers
+         * running in the bg - this is serialized before this
+         * call altogether. Just mark the state machine and
+         * disregard any other input.
+         */
+        cci->fw.transferring = false;
+        return CXL_MBOX_SUCCESS;
+    }
+
+    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
+    length = len - sizeof(*fw_transfer);
+    if (offset + length > CXL_FW_SIZE) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (cci->fw.transferring) {
+        if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
+            fw_transfer->action == CXL_FW_XFER_ACTION_INIT) {
+            return CXL_MBOX_FW_XFER_IN_PROGRESS;
+        }
+        /*
+         * Abort partitioned package transfer if over 30 secs
+         * between parts. As opposed to the explicit ABORT action,
+         * semantically treat this condition as an error - as
+         * if a part action were passed without a previous INIT.
+         */
+        if (difftime(time(NULL), cci->fw.last_partxfer) > 30.0) {
+            cci->fw.transferring = false;
+            return CXL_MBOX_INVALID_INPUT;
+        }
+    } else if (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
+               fw_transfer->action == CXL_FW_XFER_ACTION_END) {
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    /* allow back-to-back retransmission */
+    if ((offset != cci->fw.prev_offset || length != cci->fw.prev_len) &&
+        (fw_transfer->action == CXL_FW_XFER_ACTION_CONTINUE ||
+         fw_transfer->action == CXL_FW_XFER_ACTION_END)) {
+        /*
+         * XXX: Linux is happy to send overlapping chunks,
+         * so just verify no gaps.
+         */
+        if (offset > cci->fw.prev_offset + cci->fw.prev_len) {
+            return CXL_MBOX_FW_XFER_OUT_OF_ORDER;
+        }
+    }
+
+    switch (fw_transfer->action) {
+    case CXL_FW_XFER_ACTION_FULL: /* ignores offset */
+    case CXL_FW_XFER_ACTION_END:
+        if (fw_transfer->slot == 0 ||
+            fw_transfer->slot == cci->fw.active_slot ||
+            fw_transfer->slot > CXL_FW_SLOTS) {
+            return CXL_MBOX_FW_INVALID_SLOT;
+        }
+
+        /* mark the slot used upon bg completion */
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+        if (offset != 0) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+
+        cci->fw.transferring = true;
+        cci->fw.prev_slot = fw_transfer->slot;
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        /* forbid slot interleaving */
+        if (cci->fw.prev_slot != fw_transfer->slot) {
+            return CXL_MBOX_FW_XFER_IN_PROGRESS;
+        }
+
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    if (fw_transfer->action == CXL_FW_XFER_ACTION_FULL) {
+        cci->bg.runtime = 10 * 1000UL;
+    } else {
+        cci->bg.runtime = 2 * 1000UL;
+    }
+    /* keep relevant context for bg completion */
+    cci->fw.curr_action = fw_transfer->action;
+    cci->fw.curr_slot = fw_transfer->slot;
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
+static void __do_firmware_xfer(CXLCCI *cci)
+{
+    switch (cci->fw.curr_action) {
+    case CXL_FW_XFER_ACTION_FULL:
+    case CXL_FW_XFER_ACTION_END:
+        cci->fw.slot[cci->fw.curr_slot - 1] = true;
+        cci->fw.transferring = false;
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        time(&cci->fw.last_partxfer);
+        break;
+    default:
+        break;
+    }
+}
+
+/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
+static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    struct {
+        uint8_t action;
+        uint8_t slot;
+    } QEMU_PACKED *fw_activate = (void *)payload_in;
+
+    if (fw_activate->slot == 0 ||
+        fw_activate->slot == cci->fw.active_slot ||
+        fw_activate->slot > CXL_FW_SLOTS) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    /*
+     * XXX: Check that an actual fw package is there - spec
+     * does not mention this case.
+     */
+    if (!cci->fw.slot[fw_activate->slot - 1]) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    switch (fw_activate->action) {
+    case 0: /* online */
+        cci->fw.active_slot = fw_activate->slot;
+        break;
+    case 1: /* reset */
+        cci->fw.staged_slot = fw_activate->slot;
+        break;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    return CXL_MBOX_SUCCESS;
+}
+
 /* CXL r3.1 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
@@ -2160,6 +2354,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                       ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
+    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
+        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
+    [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
+        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
                          8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2275,7 +2473,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
             h == cmd_media_get_poison_list ||
             h == cmd_media_inject_poison ||
             h == cmd_media_clear_poison ||
-            h == cmd_sanitize_overwrite) {
+            h == cmd_sanitize_overwrite ||
+            h == cmd_firmware_update_transfer ||
+            h == cmd_firmware_update_activate) {
             return CXL_MBOX_MEDIA_DISABLED;
         }
     }
@@ -2319,6 +2519,9 @@ static void bg_timercb(void *opaque)
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
         switch (cci->bg.opcode) {
+        case 0x0201: /* fw transfer */
+            __do_firmware_xfer(cci);
+            break;
         case 0x4400: /* sanitize */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
@@ -2390,6 +2593,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->bg.runtime = 0;
     cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  bg_timercb, cci);
+
+    memset(&cci->fw, 0, sizeof(cci->fw));
+    cci->fw.active_slot = cci->fw.staged_slot = 1;
+    cci->fw.slot[cci->fw.active_slot - 1] = true;
 }
 
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d38391b26f0e..8c17ba9d2131 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -203,7 +203,22 @@ typedef struct CXLCCI {
         uint64_t runtime;
         QEMUTimer *timer;
     } bg;
+
+    /* firmware update */
+    struct {
+        uint8_t active_slot;
+        uint8_t staged_slot;
+        bool slot[4];
+        uint8_t curr_action;
+        uint8_t curr_slot;
+        /* handle partial transfers */
+        bool transferring;
+        uint8_t prev_slot;
+        size_t prev_offset;
+        size_t prev_len;
+        time_t last_partxfer;
+    } fw;
+
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
--
2.43.0

