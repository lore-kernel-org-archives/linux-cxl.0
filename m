Received: from eastern.ash.relay.mailchannels.net (eastern.ash.relay.mailchannels.net [23.83.222.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A7021AB518
	for <linux-cxl@vger.kernel.org>; Tue, 13 Aug 2024 22:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723588184; cv=pass; b=BIgRLJ+dyy1FfA+BG9D32iWRpdxrU0iA2OyRtmncCwEFeAm3mwJ81XF8fdsBbXRzRdiA8/BL8qxu3rLClUa6VWJVciDVNHnYgFRMXz2jCQkK80rW76SiYrjkNdtVXDr0Dr4gZeY77O/CljnMzyM53T4HtCriLn/CLlg6Ge5lB5w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723588184; c=relaxed/simple;
	bh=WcFfrX639y9wOOky3fkEXuqJRG21mK1nV5RKc2xJtdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dPFFEWkm8hoQSjblWuSgZuvpHcWFNtVhxN+rguKia3I5K3AQxfWPcpnQ+fljVMqWpYZMj0RBtjR0hXAbd5SWSddli3EyET9TejuynefYCmGid8rB89+IHU0DL5tx9sJR+5rlMMDERCnhYX5WIaY4dA0lnKpRn/Oul4yVr5bbaTU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net; spf=pass smtp.mailfrom=stgolabs.net; dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b=PG8q4hGn; arc=pass smtp.client-ip=23.83.222.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stgolabs.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=stgolabs.net header.i=@stgolabs.net header.b="PG8q4hGn"
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 139284746D;
	Tue, 13 Aug 2024 22:13:19 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
	(Authenticated sender: dreamhost)
	by relay.mailchannels.net (Postfix) with ESMTPA id 9A9034743A;
	Tue, 13 Aug 2024 22:13:18 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1723587198; a=rsa-sha256;
	cv=none;
	b=jyKgJ9LsodWt3JOlDkW5+yAIUGoIiMCxS/sS9UC3CEaIdsLWYrdfwrfhjqDBvdNN+iUndZ
	NvFBPmC25I0MOrjFCFCIt38PXcK6wgRE9ccDTKrn9SXfLLWL8a4s78g5mdw19/JCVxEza6
	REsanLY7PkdcVI+dpm0lkBkwNMAWiVC8VEjG3Wid8euzu3xIBsoJ/mYWe7pWjTd7W/4Mba
	nr9CrHo6wLNXpZM3AhvE+ezAPmTHKJw3pu/WGnaCk4DwT773WnOf1FPP5kXTKHNC4qrm+P
	wCQwnnup72zaWnfeE/pNG9smZgTpe+6FZMNEeld0SR05+4m/NgccFZTm1+9s3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1723587198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:dkim-signature;
	bh=Hr3nJl7WCIXLbfgLM9iKt45WWjW2yClKzDTJcq6qj5M=;
	b=YW8rnnJ+Rl5qr8xbQaweh7VrDVXByZZCm+Akc4HkLCFgPfVQAcGU5MebVHxNTmUFzVXP37
	9n/awDSl6VUtCKoRh9yru3GS21ZV7AaSLLD5YGmqlpcD38l6nY60tuiD+tqN/OWvagzsHg
	6EMqDK6YcIwyXghtRjTf25B3Ozq8cBYTByAdG4MQ0mpeICHN54ugmZ56cNAx/DQiHG3ZNw
	ab+1Kbha6SrnUxwGVU8VnyehVNsqVWHi4WENGOAIvUO9M9HnO/YOprA8b76DvU0aILCNWp
	4SJHNK/TXdW04XFY79AlqkhvoglM70iXeWJsys+oJP8DFnApriIelzznjLPr4A==
ARC-Authentication-Results: i=1;
	rspamd-68c6c69487-9pxmk;
	auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Wiry-Harmony: 584b6a7c083b206e_1723587198958_2497559779
X-MC-Loop-Signature: 1723587198958:2358817111
X-MC-Ingress-Time: 1723587198958
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.103.82.141 (trex/7.0.2);
	Tue, 13 Aug 2024 22:13:18 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: dave@stgolabs.net)
	by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4Wk5Hd3MM6zfM;
	Tue, 13 Aug 2024 15:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
	s=dreamhost; t=1723587198;
	bh=Hr3nJl7WCIXLbfgLM9iKt45WWjW2yClKzDTJcq6qj5M=;
	h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
	b=PG8q4hGnvz6UMFCBJ+AIqRbGUlY/sHfpHaEkgYpJtrxvHi0znWcncWFpQwLvX2Jq3
	 1Mw+TJ+h5v695WtyfvWlxzjf6zT+rOWlbTfIYLTYA+C+8SkIbCe5kPZ8mo0ODJdpLZ
	 kKpDqp++w+tMhcPiCnVD19Vq7/S9ECZ3q+i4wExZ8IUAJ5LKtewZjNclPpoIoNdLYo
	 UHIK9jwqIp1HirpfUoFrtsiqtke6f4gYavMQ42dSjTm7KpQWG3KNde8U+6GQJZRee9
	 5GaTxkiCk842ynodG53MFl1JEJWFVAzDkFbcz+LVCBNvh4j5+6j2kkHRYmlLIw7DlM
	 KH4DyZBEcwyuA==
From: Davidlohr Bueso <dave@stgolabs.net>
To: Jonathan.Cameron@Huawei.com
Cc: ajay.opensrc@micron.com,
	fan.ni@samsung.com,
	john@jagalactic.com,
	emirakhur@micron.com,
	ajayjoshi@micron.com,
	sthanneeru@micron.com,
	ravis.opensrc@micron.com,
	arramesh@micron.com,
	tmmulgund@micron.com,
	dave@stgolabs.net,
	linux-cxl@vger.kernel.org
Subject: [PATCH] hw/cxl: Support aborting background commands
Date: Tue, 13 Aug 2024 15:12:55 -0700
Message-ID: <20240813221255.179200-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-cxl@vger.kernel.org
List-Id: <linux-cxl.vger.kernel.org>
List-Subscribe: <mailto:linux-cxl+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cxl+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As of 3.1 spec, background commands can be canceled with a new
abort command. Implement the support, which is advertised in
the CEL. No ad-hoc context undoing is necessary as all the
command logic of the running bg command is done upon completion.
Arbitrarily, the on-going background cmd will not be aborted if
already at least 85% done;

A mutex is introduced to stabilize mbox request cancel command vs
the timer callback being fired scenarios (as well as reading the
mbox registers). While some operations under critical regions
may be unnecessary (irq notifying, cmd callbacks), this is not
a path where performance is important, so simplicity is preferred.

Tested-by: Ajay Joshi <ajay.opensrc@micron.com>
Reviewed-by: Ajay Joshi <ajay.opensrc@micron.com>
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---

Changes based on the following thread:
https://lore.kernel.org/linux-cxl/20240729102010.20996-1-ajay.opensrc@micron.com

 - Added a mutex (and expanded CCI to have a destroy counterpart).
   An 'initialized' flag is added for correctly handling the reset()
   case.
 - Added the case where cancel is not done.
 - Picked up Ajay's tags but it would be good to re-review/test if
   possible.

 hw/cxl/cxl-device-utils.c    |  5 ++-
 hw/cxl/cxl-mailbox-utils.c   | 63 +++++++++++++++++++++++++++++++++---
 hw/mem/cxl_type3.c           |  8 ++++-
 include/hw/cxl/cxl_device.h  |  4 +++
 include/hw/cxl/cxl_mailbox.h |  1 +
 5 files changed, 74 insertions(+), 7 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 035d034f6dd8..1a9779ed8201 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -95,11 +95,14 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
         }
         if (offset == A_CXL_DEV_MAILBOX_STS) {
             uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
-            if (cci->bg.complete_pct) {
+
+            qemu_mutex_lock(&cci->bg.lock);
+            if (cci->bg.complete_pct == 100 || cci->bg.aborted) {
                 status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP,
                                         0);
                 cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
             }
+            qemu_mutex_unlock(&cci->bg.lock);
         }
         return cxl_dstate->mbox_reg_state64[offset / size];
     default:
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index b752920ec88a..ff12dfc3dcc4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -56,6 +56,7 @@ enum {
     INFOSTAT    = 0x00,
         #define IS_IDENTIFY   0x1
         #define BACKGROUND_OPERATION_STATUS    0x2
+        #define BACKGROUND_OPERATION_ABORT     0x5
     EVENTS      = 0x01,
         #define GET_RECORDS   0x0
         #define CLEAR_RECORDS   0x1
@@ -624,6 +625,38 @@ static CXLRetCode cmd_infostat_bg_op_sts(const struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+/* CXL r3.1 Section 8.2.9.1.5: Request Abort Background Operation (Opcode 0005h) */
+static CXLRetCode cmd_infostat_bg_op_abort(const struct cxl_cmd *cmd,
+                                           uint8_t *payload_in,
+                                           size_t len_in,
+                                           uint8_t *payload_out,
+                                           size_t *len_out,
+                                           CXLCCI *cci)
+{
+    int bg_set = cci->bg.opcode >> 8;
+    int bg_cmd = cci->bg.opcode & 0xff;
+    const struct cxl_cmd *bg_c = &cci->cxl_cmd_set[bg_set][bg_cmd];
+
+    if (!(bg_c->effect & CXL_MBOX_BACKGROUND_OPERATION_ABORT)) {
+        return CXL_MBOX_REQUEST_ABORT_NOTSUP;
+    }
+
+    qemu_mutex_lock(&cci->bg.lock);
+    if (cci->bg.runtime) {
+        /* operation is near complete, let it finish */
+        if (cci->bg.complete_pct < 85) {
+            timer_del(cci->bg.timer);
+            cci->bg.ret_code = CXL_MBOX_ABORTED;
+            cci->bg.starttime = 0;
+            cci->bg.runtime = 0;
+            cci->bg.aborted = true;
+        }
+    }
+    qemu_mutex_unlock(&cci->bg.lock);
+
+    return CXL_MBOX_SUCCESS;
+}
+
 #define CXL_FW_SLOTS 2
 #define CXL_FW_SIZE  0x02000000 /* 32 mb */
 
@@ -2665,6 +2698,8 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
 }
 
 static const struct cxl_cmd cxl_cmd_set[256][256] = {
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
@@ -2708,7 +2743,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
         (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
          CXL_MBOX_SECURITY_STATE_CHANGE |
-         CXL_MBOX_BACKGROUND_OPERATION)},
+         CXL_MBOX_BACKGROUND_OPERATION |
+         CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
     [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
         cmd_get_security_state, 0, 0 },
     [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
@@ -2721,7 +2757,8 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_CAPABILITIES",
         cmd_media_get_scan_media_capabilities, 16, 0 },
     [MEDIA_AND_POISON][SCAN_MEDIA] = { "MEDIA_AND_POISON_SCAN_MEDIA",
-        cmd_media_scan_media, 17, CXL_MBOX_BACKGROUND_OPERATION },
+        cmd_media_scan_media, 17,
+        (CXL_MBOX_BACKGROUND_OPERATION | CXL_MBOX_BACKGROUND_OPERATION_ABORT)},
     [MEDIA_AND_POISON][GET_SCAN_MEDIA_RESULTS] = {
         "MEDIA_AND_POISON_GET_SCAN_MEDIA_RESULTS",
         cmd_media_get_scan_media_results, 0, 0 },
@@ -2745,6 +2782,8 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
     [INFOSTAT][IS_IDENTIFY] = { "IDENTIFY", cmd_infostat_identify, 0, 0 },
     [INFOSTAT][BACKGROUND_OPERATION_STATUS] = { "BACKGROUND_OPERATION_STATUS",
         cmd_infostat_bg_op_sts, 0, 0 },
+    [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
+        cmd_infostat_bg_op_abort, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
     [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
                          CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
@@ -2831,6 +2870,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
         cci->bg.opcode = (set << 8) | cmd;
 
         cci->bg.complete_pct = 0;
+        cci->bg.aborted = false;
         cci->bg.ret_code = 0;
 
         now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
@@ -2844,10 +2884,12 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
 static void bg_timercb(void *opaque)
 {
     CXLCCI *cci = opaque;
-    uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
-    uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
+    uint64_t now, total_time;
+
+    qemu_mutex_lock(&cci->bg.lock);
 
-    assert(cci->bg.runtime > 0);
+    now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
+    total_time = cci->bg.starttime + cci->bg.runtime;
 
     if (now >= total_time) { /* we are done */
         uint16_t ret = CXL_MBOX_SUCCESS;
@@ -2899,6 +2941,8 @@ static void bg_timercb(void *opaque)
             msi_notify(pdev, cxl_dstate->mbox_msi_n);
         }
     }
+
+    qemu_mutex_unlock(&cci->bg.lock);
 }
 
 static void cxl_rebuild_cel(CXLCCI *cci)
@@ -2927,12 +2971,21 @@ void cxl_init_cci(CXLCCI *cci, size_t payload_max)
     cci->bg.complete_pct = 0;
     cci->bg.starttime = 0;
     cci->bg.runtime = 0;
+    cci->bg.aborted = false;
     cci->bg.timer = timer_new_ms(QEMU_CLOCK_VIRTUAL,
                                  bg_timercb, cci);
+    qemu_mutex_init(&cci->bg.lock);
 
     memset(&cci->fw, 0, sizeof(cci->fw));
     cci->fw.active_slot = 1;
     cci->fw.slot[cci->fw.active_slot - 1] = true;
+    cci->initialized = true;
+}
+
+void cxl_destroy_cci(CXLCCI *cci)
+{
+    qemu_mutex_destroy(&cci->bg.lock);
+    cci->initialized = false;
 }
 
 static void cxl_copy_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmds)[256])
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 4114163324bd..f04aa58ea85d 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -961,6 +961,7 @@ static void ct3_exit(PCIDevice *pci_dev)
     pcie_aer_exit(pci_dev);
     cxl_doe_cdat_release(cxl_cstate);
     g_free(regs->special_ops);
+    cxl_destroy_cci(&ct3d->cci);
     if (ct3d->dc.host_dc) {
         cxl_destroy_dc_regions(ct3d);
         address_space_destroy(&ct3d->dc.host_dc_as);
@@ -1209,12 +1210,17 @@ static void ct3d_reset(DeviceState *dev)
      * Bring up an endpoint to target with MCTP over VDM.
      * This device is emulating an MLD with single LD for now.
      */
+    if (ct3d->vdm_fm_owned_ld_mctp_cci.initialized) {
+        cxl_destroy_cci(&ct3d->vdm_fm_owned_ld_mctp_cci);
+    }
     cxl_initialize_t3_fm_owned_ld_mctpcci(&ct3d->vdm_fm_owned_ld_mctp_cci,
                                           DEVICE(ct3d), DEVICE(ct3d),
                                           512); /* Max payload made up */
+    if (ct3d->ld0_cci.initialized) {
+        cxl_destroy_cci(&ct3d->ld0_cci);
+    }
     cxl_initialize_t3_ld_cci(&ct3d->ld0_cci, DEVICE(ct3d), DEVICE(ct3d),
                              512); /* Max payload made up */
-
 }
 
 static Property ct3_props[] = {
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index e14e56ae4bc2..c0e8d40053db 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -176,10 +176,12 @@ typedef struct CXLCCI {
         uint16_t opcode;
         uint16_t complete_pct;
         uint16_t ret_code; /* Current value of retcode */
+        bool aborted;
         uint64_t starttime;
         /* set by each bg cmd, cleared by the bg_timer when complete */
         uint64_t runtime;
         QEMUTimer *timer;
+        QemuMutex lock; /* serializes mbox abort vs timer cb */
     } bg;
 
     /* firmware update */
@@ -201,6 +203,7 @@ typedef struct CXLCCI {
     DeviceState *d;
     /* Pointer to the device hosting the protocol conversion */
     DeviceState *intf;
+    bool initialized;
 } CXLCCI;
 
 typedef struct cxl_device_state {
@@ -316,6 +319,7 @@ void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_initialize_mailbox_swcci(CXLCCI *cci, DeviceState *intf,
                                   DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_destroy_cci(CXLCCI *cci);
 void cxl_add_cci_commands(CXLCCI *cci, const struct cxl_cmd (*cxl_cmd_set)[256],
                           size_t payload_max);
 int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
index beb048052e1b..9008402d1c46 100644
--- a/include/hw/cxl/cxl_mailbox.h
+++ b/include/hw/cxl/cxl_mailbox.h
@@ -14,5 +14,6 @@
 #define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
 #define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
 #define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
+#define CXL_MBOX_BACKGROUND_OPERATION_ABORT (1 << 7)
 
 #endif
-- 
2.45.2

