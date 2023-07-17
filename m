Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DCD0EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230233AbjGQRTw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230111AbjGQRTv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:19:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE1BCB5
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:19:49 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TKW72nkz6J6sS;
        Tue, 18 Jul 2023 01:17:19 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:19:47 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <qemu-devel@nongnu.org>
CC:     <linuxarm@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Viacheslav Dubeyko <slava@dubeyko.com>,
        Shesha Bhushan Sreenivasamurthy <sheshas@marvell.com>,
        Fan Ni <fan.ni@samsung.com>, Michael Tsirkin <mst@redhat.com>,
        Jonathan Zhang <jonzhang@meta.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [RFC PATCH 06/17] cxl/mbox: Generalize the CCI command processing
Date:   Mon, 17 Jul 2023 18:16:35 +0100
Message-ID: <20230717171646.8972-7-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

By moving the parts of the mailbox command handling that are
CCI type specific out to the caller, make the main handling
code generic.  Rename it to cxl_process_cci_message() to
reflect this new generality.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  5 ++++-
 hw/cxl/cxl-device-utils.c   | 43 ++++++++++++++++++++++++++++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 42 ++++++++----------------------------
 3 files changed, 55 insertions(+), 35 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 813d4b926c..962b2bee7c 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -293,7 +293,10 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
 
 void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
 void cxl_init_cci(CXLCCI *cci, size_t payload_max);
-void cxl_process_mailbox(CXLCCI *cci);
+int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
+                            size_t len_in, uint8_t *pl_in,
+                            size_t *len_out, uint8_t *pl_out,
+                            bool *bg_started);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index caf61ab1f5..7dbc8b72d7 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -76,6 +76,22 @@ static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
     case 4:
         return cxl_dstate->mbox_reg_state32[offset / size];
     case 8:
+        if (offset == A_CXL_DEV_BG_CMD_STS) {
+            uint64_t bg_status_reg;
+            bg_status_reg = FIELD_DP64(0, CXL_DEV_BG_CMD_STS, OP, cci->bg.opcode);
+            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                       PERCENTAGE_COMP, cci->bg.complete_pct);
+            bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
+                                       RET_CODE, cci->bg.ret_code);
+            cxl_dstate->mbox_reg_state64[offset / size] = bg_status_reg; /* endian? */
+        }
+        if (offset == A_CXL_DEV_MAILBOX_STS) {
+            uint64_t status_reg = cxl_dstate->mbox_reg_state64[offset / size];
+            if (cci->bg.complete_pct) {
+                status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, BG_OP, 0);
+                cxl_dstate->mbox_reg_state64[offset / size] = status_reg;
+            }
+        }
         return cxl_dstate->mbox_reg_state64[offset / size];
     default:
         g_assert_not_reached();
@@ -154,7 +170,32 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
                          DOORBELL)) {
-        cxl_process_mailbox(cci);
+        uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
+        uint8_t cmd_set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
+        uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
+        size_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+        uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+        size_t len_out;
+        uint64_t status_reg;
+        bool bg_started;
+        int rc;
+        
+        rc = cxl_process_cci_message(cci, cmd_set, cmd, len_in, pl,
+                                     &len_out, pl, &bg_started);
+
+        /* Set bg and the return code */
+        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, bg_started ? 1 : 0);
+        status_reg = FIELD_DP64(status_reg, CXL_DEV_MAILBOX_STS, ERRNO, rc);
+        /* Set the return length */
+        command_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_CMD, COMMAND_SET, cmd_set);
+        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, cmd);
+        command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
+
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
+        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+        /* Tell the host we're done */
+        ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
+                         DOORBELL, 0);
     }
 }
 
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 399df6e3af..2db1258946 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -748,50 +748,26 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
-void cxl_process_mailbox(CXLCCI *cci)
+int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
+                            size_t len_in, uint8_t *pl_in, size_t *len_out,
+                            uint8_t *pl_out, bool *bg_started)
 {
-    uint16_t ret = CXL_MBOX_SUCCESS;
     const struct cxl_cmd *cxl_cmd;
-    uint64_t status_reg = 0;
     opcode_handler h;
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-    uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
-
-    uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
-    uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
-    uint16_t len_in = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
-    uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
-    size_t len_out = 0;
 
     cxl_cmd = &cci->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
-    if (h) {
-        if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
-            assert(len_out <= cci->payload_max);
-        } else {
-            ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
-        }
-    } else {
+    if (!h) {
         qemu_log_mask(LOG_UNIMP, "Command %04xh not implemented\n",
                       set << 8 | cmd);
-        ret = CXL_MBOX_UNSUPPORTED;
+        return CXL_MBOX_UNSUPPORTED;
     }
 
-    /* Set the return code */
-    status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, ERRNO, ret);
-
-    /* Set the return length */
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND, 0);
-    command_reg = FIELD_DP64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH, len_out);
-
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD] = command_reg;
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
+    if (len_in != cxl_cmd->in && cxl_cmd->in != ~0) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
 
-    /* Tell the host we're done */
-    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
-                     DOORBELL, 0);
+    return (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
 }
 
 void cxl_init_cci(CXLCCI *cci, size_t payload_max)
-- 
2.39.2

