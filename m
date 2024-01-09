Received: from rusty.tulip.relay.mailchannels.net (rusty.tulip.relay.mailchannels.net [23.83.218.252])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9C13B1AC
	for <linux-cxl@vger.kernel.org>; Tue,  9 Jan 2024 08:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="q/JqrtGN"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 275AF2C1B13;
	Tue,  9 Jan 2024 07:04:59 +0000 (UTC)
Received: from pdx1-sub0-mail-a291.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 771172C1741;
	Tue,  9 Jan 2024 07:04:58 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1704783898; a=rsa-sha256;
	cv=none;
	b=mtTC5ntwMHKGq/T4BrhOtupm/6b9wSzAuhf0gsMEF9MP9EkNnd2OVAZpQ27fx7zSebFqW/
	wBN/YxNqdT+70f5eaD+S5Vdb5y8okEqMjHEnREiVmeJjegJXoIbiYQiCPHhMDKVux9LuPd
	0NDIikNhTkz5kK0lCz/BYPAs76CqPX4LbRGiTkaBl2dvRRDy8Q4FTX1ooBVxFkrR04qlE4
	fCrNdHoz8JQZ2999+tqQiIr8o/Va8B71cLKFG5VsWOOVYGLPKNzjD6Yqry8Q2WROxalTBc
	ednj1sWXxnFaBtXYGbO8/vOGCqJvo+VqaDXsZT3jbqqIUPQOXYRVhOgjf5avjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1704783898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=bg3kbom0bAqudVW+0TH4NqAVc9Bp1tVkJ/B/huFvocQ=;
	b=x2TcS+G4sG/tkv97d6OnMzvtgRsu4XIDup5I8E7gOneuwPitUUM5MrN/D+ZOsYhzt14tKe
	YvKo886SWWa2M4RviD3OwVsD5I2VUtq0kqp9BVZOyW3tgHsLFV93QLQFmwAtPPfkiXkjc1
	XXeWpmTPbx4vQERaq6+W8RZrMw7GG6nWQrLJRG42RXhWXY9dHPbTLcKpkx0hn3+bcPc97/
	kSHP7lp0vAYa/FDB8UnIAzN84kLE0SILkE+ksPhSNcq+9jFjif/6ixb+8l/dYfQ+E4030+
	oVZRP3da7ubBcmvbjE5s0rCOnEC8BT4QCAkOeTQEczMHDHYh4v4d3qIuf/oFaw==
ARC-Authentication-Results: i=1;
	rspamd-69494b7fd5-l52kv;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Abiding-Spill: 17e0394131f8bc63_1704783898865_967700851
X-MC-Loop-Signature: 1704783898865:1457627373
X-MC-Ingress-Time: 1704783898864
Received: from pdx1-sub0-mail-a291.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.96.189.200 (trex/6.9.2);
	Tue, 09 Jan 2024 07:04:58 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a291.dreamhost.com (Postfix) with ESMTPSA id 4T8MPj6Q4Lz2b;
	Mon,  8 Jan 2024 23:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1704783898;
	bh=bg3kbom0bAqudVW+0TH4NqAVc9Bp1tVkJ/B/huFvocQ=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=q/JqrtGNpi65t4qgqijVxwO1GksXsWTU23EnWWqB8DFxUqGVexsNKU8jE1hQK3/5p
	 CMwWwsrNiUxAMIQ9OjnEEf3tSyCTefi6utAWGAdByn+00v62Eo0jPWmQiB1Fxoj50a
	 1OPgOBJkK7AfvF7fX+fnuAsTDbqNCbGBMjfmHOnrI6HxIw8Y/ebWaScxAz+0p/qpPU
	 iD5pK+kc1bGOs8YQuJHAWHDtBXqZPGMw2dgdmaqZy9Js1Lr13ASmF38vE8/ACbE/uR
	 wJsGPP8c8X5qyLNT09u43/OobheOQoUIzQSmGDRFjG7VYg+jJXBUGufI5S6ozUXSjK
	 4xus4lcIpJM7Q==
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan.Cameron@huawei.com
Cc: vishal.l.verma@intel.com,
	fan.ni@samsung.com,
	a.manzanares@samsung.com,
	mounika.k@samsung.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH 2/2] hw/cxl: Add Activate FW support
Date: Mon,  8 Jan 2024 23:04:36 -0800
Message-ID: <20240109070436.21253-3-dave@stgolabs.net>
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

Per the latest 3.1 spec for supporting firmware activation.
Online mode is supported by the hw but never incurs in a
background operation.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-mailbox-utils.c | 57 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 55 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 0295ea8b29aa..7878604595dd 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -61,6 +61,7 @@ enum {
     FIRMWARE_UPDATE = 0x02,
         #define GET_INFO      0x0
         #define TRANSFER      0x1
+        #define ACTIVATE      0x2
     TIMESTAMP   = 0x03,
         #define GET           0x0
         #define SET           0x1
@@ -852,7 +853,7 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
     fw_info->slots_supported = CXL_FW_SLOTS;
     fw_info->slot_info = (cci->fw.active_slot & 0x7) |
             ((cci->fw.staged_slot & 0x7) << 3);
-    fw_info->caps = 0;
+    fw_info->caps = BIT(0);
 
     if (cci->fw.slot[0]) {
         pstrcpy(fw_info->fw_rev1, sizeof(fw_info->fw_rev1), "BWFW VERSION 0");
@@ -961,6 +962,55 @@ static void __do_firmware_xfer(CXLCCI *cci)
     cci->fw.transfering = false;
 }
 
+/* CXL r3.1 section 8.2.9.3.3: Activate FW (Opcode 0202h) */
+static CXLRetCode cmd_firmware_update_activate(const struct cxl_cmd *cmd,
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
+    } QEMU_PACKED *fw_activate;
+
+    if ((cxl_dstate->vmem_size < CXL_CAPACITY_MULTIPLIER) ||
+        (cxl_dstate->pmem_size < CXL_CAPACITY_MULTIPLIER)) {
+        return CXL_MBOX_INTERNAL_ERROR;
+    }
+
+    fw_activate = (void *)payload_in;
+
+    if (fw_activate->slot == 0 ||
+        fw_activate->slot == cci->fw.active_slot ||
+        fw_activate->slot > CXL_FW_SLOTS) {
+        return CXL_MBOX_FW_INVALID_SLOT;
+    }
+
+    /*
+     * Check that an actual fw package is there, otherwise
+     * just become a nop.
+    */
+    if (!cci->fw.slot[fw_activate->slot - 1]) {
+        return CXL_MBOX_SUCCESS;
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
 /* CXL r3.0 Section 8.2.9.4.1: Get Timestamp (Opcode 0300h) */
 static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     uint8_t *payload_in,
@@ -2273,6 +2323,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_firmware_update_get_info, 0, 0 },
     [FIRMWARE_UPDATE][TRANSFER] = { "FIRMWARE_UPDATE_TRANSFER",
         cmd_firmware_update_transfer, ~0, CXL_MBOX_BACKGROUND_OPERATION },
+    [FIRMWARE_UPDATE][ACTIVATE] = { "FIRMWARE_UPDATE_ACTIVATE",
+        cmd_firmware_update_activate, 2, CXL_MBOX_BACKGROUND_OPERATION },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set,
                          8, CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2387,7 +2439,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
             h == cmd_media_inject_poison ||
             h == cmd_media_clear_poison ||
             h == cmd_sanitize_overwrite ||
-            h == cmd_firmware_update_transfer) {
+            h == cmd_firmware_update_transfer ||
+            h == cmd_firmware_update_activate) {
             return CXL_MBOX_MEDIA_DISABLED;
         }
     }
-- 
2.43.0

