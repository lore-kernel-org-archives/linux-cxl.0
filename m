Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684519AD54
	for <linux-cxl@vger.kernel.org>; Thu, 27 Jun 2024 17:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.212.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719508068; cv=pass; b=RO4yuEjYLgZam/iuZLoO6Oo82NAYyEouaMZMea8E6HgzsAyD59yhaeMkE4QCzqYCKCuLGm3JN5qz4FnjCdA/Fvbwqj3FJhQKBF+OhI0AXHrvklAVyDC7hGQHKkWG0mZrI8O2/OZDC3fKWH/7Ncl4XEM8GfEfObjYcVWIpD2dJRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719508068; c=relaxed/simple;
	bh=dzer7AhVpuAr01ptdJchKP4pvw0G3AWhGGRlKMKVTo8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MRSwMBdh2eM9NDpTVA2sYu6cdZVEOMKPeYmTmTV5ix4SJhN8VD223rcHiRjY3ELHqStD4VAvqPyu6HRpOc4iF+p7Xg6D+YTxaE5IaexTbdhXtvGyh54rBpy44oY1mQ/06k8+ztwVdyYlEzHdanzhaayPCHOBTajGUSN0frY/oTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=L0G31c9b; arc=pass smtp.client-ip=23.83.212.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="L0G31c9b"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id DC9D86C2E9A;
	Thu, 27 Jun 2024 16:49:15 +0000 (UTC)
Received: from pdx1-sub0-mail-a315.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 64FE96C1897;
	Thu, 27 Jun 2024 16:49:15 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1719506955; a=rsa-sha256;
	cv=none;
	b=8Fumx5NEGB1N+b67PTPpxc/nuJUOECJNxE8vd9sDePSCbmRW9DdQFc8nNj6VFDhM/O1r/f
	aoEQlWdIA+TlbGQlUxTvZCVNWKYeSRqG71VMMtce8Vw58UoJhYW7qVhbh3kH0/OF6jpmeB
	nEThR3FMX+3UuScZFHcTeKa0nIhCN75ZLboIBqu+E+AppdEyqtNmD9YhfkZ2KMDYanvyEJ
	LyqAXyUQgeHyOQy5rfCGPCb309zmDt8iaR3gr3LxhbndZFLmTMwBY/x/GkSbt6gvh9pZp5
	IJBn15vpaLhTcYsBWwfg5pC526DJvJMHLuDFz5J/skhfRuzV/IvR2oDsqXfJJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1719506955;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=SU/ji+gBg7LTROW5M8fL9Y0ZEwEMckcACfj5NCNV4jE=;
	b=UtW636pFeMbOzoCrj2zjqI3Fp3pxV+lkDEl4ik0tZQTl2+TtfIvROAsf47edvgVR9NyPs/
	7nTaUA9RZD/H/+/Tj5Qjv3dzfINlLqb7To7DKlYNUwsT1qwFf4329tUoZ6MEK2TmynWWwA
	vj02zBc45pLPyQXXQsVBieaIqbMlZAn7Er4im1/1MCU5++ne45nRpicPAbKEAvj0Sw1eOC
	69tn/RMsd0w+GE00EOzVHnimfJYNHkhsjq828mu2mXQYeYW8hDIqIJbVo+wX4FtoISKK7P
	h6B7UAxF4NiLC8YPxd075BJ2PY5bN3SvW+xoJgQtdPVQBBCBtzAfZeX96W0N0w==
ARC-Authentication-Results: i=1;
	rspamd-79677bdb95-xbrrh;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Hook-Thread: 3857cb194cba52c3_1719506955703_2167640491
X-MC-Loop-Signature: 1719506955702:2857603787
X-MC-Ingress-Time: 1719506955702
Received: from pdx1-sub0-mail-a315.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.121.33.136 (trex/6.9.2);
	Thu, 27 Jun 2024 16:49:15 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a315.dreamhost.com (Postfix) with ESMTPSA id 4W94KQ5tmqz2H;
	Thu, 27 Jun 2024 09:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1719506955;
	bh=SU/ji+gBg7LTROW5M8fL9Y0ZEwEMckcACfj5NCNV4jE=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=L0G31c9bRfbg7u2/yFR+hlWOiYcTy4LLBq2j7iFJwv3PSUZ+vzqwIbWCj1dtsk3Yh
	 1XntwxvBZ4i2+0jUjWukh062kWn/1evW2S510bg5/872PHOMETt0oyxPGMxYrr8ovi
	 LtL48bP89qihBN35vDxye7N8IWIM4y8FbTjGgfEV53aD4IGFs3eHZcjb5+hMMyXaaf
	 tAjM5nILbnWfVnJeWVYkiZbQW3gGsJQwrrJAeXxP+TQCzq+vVmKE2fluOj97uf2gZW
	 iVSdeeYSEVH/x91jxC6ZbjKRbyWDpRNzbzzXWky60i2TwOQ199E8HBY+6LBpRyQK+P
	 a03MobtiaaySg==
From: Davidlohr Bueso <dave@stgolabs.net>
To: jonathan.cameron@huawei.com
Cc: vishal.l.verma@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH v3 -qemu] hw/cxl: Support firmware updates
Date: Thu, 27 Jun 2024 09:49:12 -0700
Message-ID: <20240627164912.25630-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.45.2
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

cxl update-firmware mem0 -F fw.img

<on-going fw update>

cxl update-firmware mem0
  "memdev":"mem0",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0d:00.0",
  "firmware":{
    "num_slots":2,
    "active_slot":1,
    "online_activate_capable":true,
    "slot_1_version":"BWFW VERSION 0",
    "fw_update_in_progress":true,
    "remaining_size":22400
  }
}

<completed fw update>

cxl update-firmware mem0
{
  "memdev":"mem0",
  "pmem_size":"1024.00 MiB (1073.74 MB)",
  "serial":"0",
  "host":"0000:0d:00.0",
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

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

Changes from v2: https://lore.kernel.org/linux-cxl/20240205172942.13343-1-dave@stgolabs.net/
 - Applies on top of 'cxl-2024-06-21' branch.
 - Remove bogus member in transfer fw payload. (Fan)
 - For partial xfers, only verify for overlaps when ensuring xfer order.
 - Removed slot interleaving detection for partial xfers. (Jonathan)
 - Upon init, do not stage a slot. (Jonathan)
 - For get info, left the rev1 static within: as a new slot is staged,
   it will shows both slot revs.

 hw/cxl/cxl-mailbox-utils.c  | 205 +++++++++++++++++++++++++++++++++++-
 include/hw/cxl/cxl_device.h |  15 +++
 2 files changed, 215 insertions(+), 5 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 7d60868bb6c0..77b226c19c28 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -63,6 +63,8 @@ enum {
         #define SET_INTERRUPT_POLICY   0x3
     FIRMWARE_UPDATE = 0x02,
         #define GET_INFO      0x0
+        #define TRANSFER      0x1
+        #define ACTIVATE      0x2
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -641,6 +643,9 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_FW_SLOTS 2
+#define CXL_FW_SIZE  0x02000000 /* 32 mb */
+
 /* CXL r3.1 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -671,15 +676,192 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
 
     fw_info = (void *)payload_out;
 
-    fw_info->slots_supported = 2;
-    fw_info->slot_info = BIT(0) | BIT(3);
-    fw_info->caps = 0;
-    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    fw_info->slots_supported = CXL_FW_SLOTS;
+    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
+            ((cci->fw.staged_slot & 0x7) << 3);
+    fw_info->caps = BIT(0);  /* online update supported */
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
+        /* verify no overlaps */
+        if (offset < cci->fw.prev_offset + cci->fw.prev_len) {
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
+        cci->fw.prev_offset = offset;
+        cci->fw.prev_len = length;
+        break;
+    case CXL_FW_XFER_ACTION_CONTINUE:
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
+    QEMU_BUILD_BUG_ON(sizeof(*fw_activate) != 0x2);
+
+    if (fw_activate->slot == 0 ||
+        fw_activate->slot == cci->fw.active_slot ||
+        fw_activate->slot > CXL_FW_SLOTS) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    /* ensure that an actual fw package is there */
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
@@ -2510,6 +2692,10 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
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
@@ -2639,7 +2825,9 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
                 h == cmd_media_get_poison_list ||
                 h == cmd_media_inject_poison ||
                 h == cmd_media_clear_poison ||
-                h == cmd_sanitize_overwrite) {
+                h == cmd_sanitize_overwrite ||
+                h == cmd_firmware_update_transfer ||
+                h == cmd_firmware_update_activate) {
                 return CXL_MBOX_MEDIA_DISABLED;
             }
         }
@@ -2684,6 +2872,9 @@ static void bg_timercb(void *opaque)
         cci->bg.complete_pct = 100;
         cci->bg.ret_code = ret;
         switch (cci->bg.opcode) {
+        case 0x0201: /* fw transfer */
+            __do_firmware_xfer(cci);
+            break;
         case 0x4400: /* sanitize */
         {
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
@@ -2755,6 +2946,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->bg.runtime = 0;
     cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  bg_timercb, cci);
+
+    memset(&cci->fw, 0, sizeof(cci->fw));
+    cci->fw.active_slot = 1;
+    cci->fw.slot[cci->fw.active_slot - 1] = true;
 }
 
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index cb95ccbd6140..a048e2b1b46c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -203,7 +203,21 @@ typedef struct CXLCCI {
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
+        size_t prev_offset;
+        size_t prev_len;
+        time_t last_partxfer;
+    } fw;
+
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
--
2.45.2

