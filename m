Received: from seahorse.cherry.relay.mailchannels.net (seahorse.cherry.relay.mailchannels.net [23.83.223.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F2250F5
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 08:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="ZbC6ebNj"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 557D34C0EC0;
	Tue,  9 Jan 2024 07:04:58 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id DB0164C0DFF;
	Tue,  9 Jan 2024 07:04:57 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704783897; a=rsa-sha256;
	cv=none;
	b=BxUuT9avGdpm3psTYJ0WJBagLmPWrCFNET9VxD5V4D1Pj/VVj0CGlzTXsU2nnKoaAazPrV
	Ys0v0nAFS6F5U25YsSl8yhjZhaF68Az6laFffg23Y78FHuj14su7Bp0ML2OXGfjojhKjIr
	DlRTPGHwtQhvoDcPrN1ZhTdbhY/usEQDUom9Hp4j6+f9wPRfZ8tXHt3eFnb+/dBMMX99u1
	PFINNqqVc1Ah9T39qEgN4WjFjuLgQ94aMgxxfKZPUNDehyaudfkcd525vO7HdTIh3qmSpR
	a4aiGpI+o/sqpiZ9TfowBgOx86Q5epZQ1g8UPaao7kZWLoHsCj7a4RYBsd6yjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704783897;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=6CQyhwmHW5JBJypUNS+7ZR/h8bzw3zCTsm3GSVzAMXQ=;
	b=G0UAItAQjfHp1ZxEkf1V96AdLWa/wv9A8tvlkpjfogoDCaIaEwtYWZnwBT8jLXaTHfOD8Y
	t/NUxImqyJPvI9Gsa81aOAok2MHZDjyvEpw/DnLdmdj8OnCqL8SYJrKaQTBGXySNZFv2Zl
	ni9WVEtjGpLZ+KVcRo/OLLnyZH4wW12P2rFpVpi3NOR7p4mui+fWCWXUXxgGPzwJaTtAP8
	yoRnuiu0emAvXMR+OlKm0TU/DlCkOlv29cUCNaZUmH5NgW877DP5nqpCEosKoZtSJbtZO7
	JFvxNEGGdjZBaofxMfk910c+ufB9N6mzs8iJvEkZktAH26zh324w1sV1TGxdlA==
ARC-Authentication-Results: i=1;
	rspamd-69494b7fd5-fs7ld;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abaft-Hysterical: 13cb5d9508828ec1_1704783898180_114569058
X-MC-Loop-Signature: 1704783898180:3119495825
X-MC-Ingress-Time: 1704783898180
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.122.192.135 (trex/6.9.2);
	Tue, 09 Jan 2024 07:04:58 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4T8MPj2CyLz24;
	Mon,  8 Jan 2024 23:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1704783897;
	bh=6CQyhwmHW5JBJypUNS+7ZR/h8bzw3zCTsm3GSVzAMXQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=ZbC6ebNj87Q5P36XU1hJT0LXy2XqxSv6PysWuWfj0DqXpkfn1GRtP5SCmOQIsszB8
	 GU4P/TpTP5qOqKBY9AB3aFrJLBY6UWapOVXXJaDkSEriFTf/4Co1FHE1del8Kn037g
	 zpUUkeBz4rPrnWS+YqJJkXtTR/0O/q5mqyv7c5gx/ze681zYimU35RCZKsNVy0lkFm
	 J93lD4iXAjZFKnS4APp1p26AXuc3HS/kN81FLczTF9w04ny0OUKiRO3dWoQ208hafi
	 xxP5/6kedlXXdUi37jQOQTLgx05XlyxHyBjayMmcYJAUBp41K84eHi3k0bvTWZqmns
	 Xsxb4JKIqkncQ==
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan.Cameron@huawei.com
Cc: vishal.l.verma@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	mounika.k@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 1/2] hw/cxl: Add Transfer FW support
Date: Mon,  8 Jan 2024 23:04:35 -0800
Message-ID: <20240109070436.21253-2-dave@stgolabs.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240109070436.21253-1-dave@stgolabs.net>
References: <20240109070436.21253-1-dave@stgolabs.net>
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per the latest 3.1 spec for supporting firmware update metadata
(no actual buffers). Aborting a xfer is currently unsupported
through a nop.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c  | 124 ++++++++++++++++++++++++++++++++++--
 include/hw/cxl/cxl_device.h |   9 +++
 2 files changed, 129 insertions(+), 4 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 11ec8b648baf..0295ea8b29aa 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -60,6 +60,7 @@ enum {
         #define SET_INTERRUPT_POLICY   0x3
     FIRMWARE_UPDATE = 0x02,
         #define GET_INFO      0x0
+        #define TRANSFER      0x1
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -815,6 +816,8 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+#define CXL_FW_SLOTS 2
+
 /* CXL r3.0 Section 8.2.9.3.1: Get FW Info (Opcode 0200h) */
 static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                uint8_t *payload_in,
@@ -846,15 +849,118 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     fw_info = (void *)payload_out;
     memset(fw_info, 0, sizeof(*fw_info));
 
-    fw_info->slots_supported = 2;
-    fw_info->slot_info = BIT(0) | BIT(3);
+    fw_info->slots_supported = CXL_FW_SLOTS;
+    fw_info->slot_info = (cci->fw.active_slot & 0x7) |
+            ((cci->fw.staged_slot & 0x7) << 3);
     fw_info->caps = 0;
-    pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+
+    if (cci->fw.slot[0]) {
+        pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
+    }
+    if (cci->fw.slot[1]) {
+        pstrcpy(fw_info->fw_rev2, sizeof(fw_info->fw_rev2), "BWFW VERSION 1");
+    }
+    if (cci->fw.slot[2]) {
+        pstrcpy(fw_info->fw_rev3, sizeof(fw_info->fw_rev3), "BWFW VERSION 2");
+    }
+    if (cci->fw.slot[3]) {
+        pstrcpy(fw_info->fw_rev4, sizeof(fw_info->fw_rev4), "BWFW VERSION 3");
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
+#define CXL_FW_SIZE  0x02000000 /* 32 mb */
+
+static CXLRetCode cmd_firmware_update_transfer(const struct cxl_cmd *cmd,
+                                               uint8_t *payload_in,
+                                               size_t len,
+                                               uint8_t *payload_out,
+                                               size_t *len_out,
+                                               CXLCCI *cci)
+{
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+    struct {
+        uint8_t action;
+        uint8_t slot;
+        uint8_t caps;
+        uint8_t rsvd1[2];
+        uint32_t offset;
+        uint8_t rsvd2[0x78];
+        uint8_t data[];
+    } QEMU_PACKED *fw_transfer;
+    size_t offset, length;
+
+    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    fw_transfer = (void *)payload_in;
+
+    if (cci->fw.transfering &&
+        (fw_transfer->action == CXL_FW_XFER_ACTION_FULL ||
+         fw_transfer->action == CXL_FW_XFER_ACTION_INIT)) {
+        return CXL_MBOX_FW_XFER_IN_PROGRESS;
+    }
+
+    offset = fw_transfer->offset * CXL_FW_XFER_ALIGNMENT;
+    length = len - sizeof(*fw_transfer);
+    if (offset + length > CXL_FW_SIZE) {
+        return CXL_MBOX_INVALID_INPUT;
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
+        /*
+         * Optimistically mark the slot used now (as opposed
+         * to at the end of the successful transfer). That
+         * way we don't need to keep command context.
+         */
+        cci->fw.slot[fw_transfer->slot - 1] = true;
+        break;
+    case CXL_FW_XFER_ACTION_INIT:
+        if (offset != 0) {
+            return CXL_MBOX_INVALID_INPUT;
+        }
+        /* fallthrough */
+    case CXL_FW_XFER_ACTION_CONTINUE:
+        break;
+    case CXL_FW_XFER_ACTION_ABORT: /* nop */
+        return CXL_MBOX_SUCCESS;
+    default:
+        return CXL_MBOX_INVALID_INPUT;
+    }
+
+    cci->fw.transfering = true;
+
+    cci->bg.runtime = 2 * 1000UL;
+    *len_out = 0;
+
+    return CXL_MBOX_BG_STARTED;
+}
+
+static void __do_firmware_xfer(CXLCCI *cci)
+{
+    cci->fw.transfering = false;
+}
+
 /* CXL r3.0 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
@@ -2165,6 +2271,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
                                       ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
+    [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
+        cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
                          8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2278,7 +2386,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
             h == cmd_media_get_poison_list ||
             h == cmd_media_inject_poison ||
             h == cmd_media_clear_poison ||
-            h == cmd_sanitize_overwrite) {
+            h == cmd_sanitize_overwrite ||
+            h == cmd_firmware_update_transfer) {
             return CXL_MBOX_MEDIA_DISABLED;
         }
     }
@@ -2325,6 +2434,9 @@ static void bg_timercb(void *opaque)
             CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
 
             switch (cci->bg.opcode) {
+            case 0x0201: /* fw transfer */
+                __do_firmware_xfer(cci);
+                break;
             case 0x4400: /* sanitize */
                 __do_sanitization(ct3d);
                 cxl_dev_enable_media(&ct3d->cxl_dstate);
@@ -2388,6 +2500,10 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->payload_max = payload_max;
     cxl_rebuild_cel(cci);
 
+    cci->fw.active_slot = cci->fw.staged_slot = 1;
+    memset(cci->fw.slot, 0, sizeof(cci->fw.slot));
+    cci->fw.slot[cci->fw.active_slot - 1] = true;
+
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
     cci->bg.runtime = 0;
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index b2cb280e1631..b4373bfe4d2a 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -201,6 +201,15 @@ typedef struct CXLCCI {
         uint64_t runtime;
         QEMUTimer *timer;
     } bg;
+
+    /* firmware update */
+    struct {
+        bool transfering;
+        int active_slot;
+        int staged_slot;
+        bool slot[4];
+    } fw;
+
     size_t payload_max;
     /* Pointer to device hosting the CCI */
     DeviceState *d;
-- 
2.43.0

