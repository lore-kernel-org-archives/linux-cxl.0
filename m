Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CD80EB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230290AbjGQRSU (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjGQRST (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:18:19 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2466AB5
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:18:18 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TGr5qxfz67k9Y;
        Tue, 18 Jul 2023 01:15:00 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:18:15 +0100
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
Subject: [RFC PATCH 03/17] cxl/mbox: Pull the payload out of struct cxl_cmd and make instances constant
Date:   Mon, 17 Jul 2023 18:16:32 +0100
Message-ID: <20230717171646.8972-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
References: <20230717171646.8972-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Putting the pointer in the structure for command handling puts
a single variable element inside an otherwise constant structure.
Move it out as a directly passed variable and take the cxl_cmd
structures constant.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |   6 +-
 hw/cxl/cxl-mailbox-utils.c  | 106 +++++++++++++++++++++---------------
 2 files changed, 65 insertions(+), 47 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 2c239fca47..f84f6813aa 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -135,14 +135,14 @@ typedef enum {
 } CXLRetCode;
 
 struct cxl_cmd;
-typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
+typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
+                                     uint8_t *payload,
                                      CXLDeviceState *cxl_dstate, uint16_t *len);
 struct cxl_cmd {
     const char *name;
     opcode_handler handler;
     ssize_t in;
     uint16_t effect; /* Reported in CEL */
-    uint8_t *payload;
 };
 
 typedef struct CXLEvent {
@@ -213,7 +213,7 @@ typedef struct cxl_device_state {
     uint64_t pmem_size;
     uint64_t vmem_size;
 
-    struct cxl_cmd (*cxl_cmd_set)[256];
+    const struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index c8feeffbeb..f0d94b9ae4 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -71,7 +71,8 @@ enum {
 };
 
 
-static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
+                                         uint8_t *payload,
                                          CXLDeviceState *cxlds,
                                          uint16_t *len)
 {
@@ -83,9 +84,9 @@ static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_INPUT;
     }
 
-    log_type = *((uint8_t *)cmd->payload);
+    log_type = payload[0];
 
-    pl = (CXLGetEventPayload *)cmd->payload;
+    pl = (CXLGetEventPayload *)payload;
     memset(pl, 0, sizeof(*pl));
 
     max_recs = (cxlds->payload_size - CXL_EVENT_PAYLOAD_HDR_SIZE) /
@@ -97,25 +98,27 @@ static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
     return cxl_event_get_records(cxlds, pl, log_type, max_recs, len);
 }
 
-static CXLRetCode cmd_events_clear_records(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
+                                           uint8_t *payload,
                                            CXLDeviceState *cxlds,
                                            uint16_t *len)
 {
     CXLClearEventPayload *pl;
 
-    pl = (CXLClearEventPayload *)cmd->payload;
+    pl = (CXLClearEventPayload *)payload;
     *len = 0;
     return cxl_event_clear_records(cxlds, pl);
 }
 
-static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
+                                                  uint8_t *payload,
                                                   CXLDeviceState *cxlds,
                                                   uint16_t *len)
 {
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
-    policy = (CXLEventInterruptPolicy *)cmd->payload;
+    policy = (CXLEventInterruptPolicy *)payload;
     memset(policy, 0, sizeof(*policy));
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
@@ -148,7 +151,8 @@ static CXLRetCode cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
+static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
+                                                  uint8_t *payload,
                                                   CXLDeviceState *cxlds,
                                                   uint16_t *len)
 {
@@ -159,7 +163,7 @@ static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
         return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
     }
 
-    policy = (CXLEventInterruptPolicy *)cmd->payload;
+    policy = (CXLEventInterruptPolicy *)payload;
 
     log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
     log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
@@ -191,7 +195,8 @@ static CXLRetCode cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.2.1 */
-static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
+static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
+                                               uint8_t *payload,
                                                CXLDeviceState *cxl_dstate,
                                                uint16_t *len)
 {
@@ -212,7 +217,7 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    fw_info = (void *)cmd->payload;
+    fw_info = (void *)payload;
     memset(fw_info, 0, sizeof(*fw_info));
 
     fw_info->slots_supported = 2;
@@ -225,27 +230,29 @@ static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.3.1 */
-static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
+static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
+                                    uint8_t *payload,
                                     CXLDeviceState *cxl_dstate,
                                     uint16_t *len)
 {
     uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
-    stq_le_p(cmd->payload, final_time);
+    stq_le_p(payload, final_time);
     *len = 8;
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.3.2 */
-static CXLRetCode cmd_timestamp_set(struct cxl_cmd *cmd,
-                                  CXLDeviceState *cxl_dstate,
-                                  uint16_t *len)
+static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
+                                    uint8_t *payload,
+                                    CXLDeviceState *cxl_dstate,
+                                    uint16_t *len)
 {
     cxl_dstate->timestamp.set = true;
     cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
-    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)cmd->payload);
+    cxl_dstate->timestamp.host_set = le64_to_cpu(*(uint64_t *)payload);
 
     *len = 0;
     return CXL_MBOX_SUCCESS;
@@ -258,7 +265,8 @@ static const QemuUUID cel_uuid = {
 };
 
 /* 8.2.9.4.1 */
-static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
+static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
+                                         uint8_t *payload,
                                          CXLDeviceState *cxl_dstate,
                                          uint16_t *len)
 {
@@ -269,7 +277,7 @@ static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
             QemuUUID uuid;
             uint32_t size;
         } log_entries[1];
-    } QEMU_PACKED *supported_logs = (void *)cmd->payload;
+    } QEMU_PACKED *supported_logs = (void *)payload;
     QEMU_BUILD_BUG_ON(sizeof(*supported_logs) != 0x1c);
 
     supported_logs->entries = 1;
@@ -281,7 +289,8 @@ static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.4.2 */
-static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
+static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
+                                   uint8_t *payload,
                                    CXLDeviceState *cxl_dstate,
                                    uint16_t *len)
 {
@@ -289,7 +298,9 @@ static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
         QemuUUID uuid;
         uint32_t offset;
         uint32_t length;
-    } QEMU_PACKED QEMU_ALIGNED(16) *get_log = (void *)cmd->payload;
+    } QEMU_PACKED QEMU_ALIGNED(16) *get_log;
+
+    get_log = (void *)payload;
 
     /*
      * 8.2.9.4.2
@@ -315,14 +326,15 @@ static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
     /* Store off everything to local variables so we can wipe out the payload */
     *len = get_log->length;
 
-    memmove(cmd->payload, cxl_dstate->cel_log + get_log->offset,
+    memmove(payload, cxl_dstate->cel_log + get_log->offset,
            get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
 
 /* 8.2.9.5.1.1 */
-static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
+static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
+                                             uint8_t *payload,
                                              CXLDeviceState *cxl_dstate,
                                              uint16_t *len)
 {
@@ -352,7 +364,7 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
         return CXL_MBOX_INTERNAL_ERROR;
     }
 
-    id = (void *)cmd->payload;
+    id = (void *)payload;
     memset(id, 0, sizeof(*id));
 
     snprintf(id->fw_revision, 0x10, "BWFW VERSION %02d", 0);
@@ -370,7 +382,8 @@ static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
+static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
+                                              uint8_t *payload,
                                               CXLDeviceState *cxl_dstate,
                                               uint16_t *len)
 {
@@ -379,7 +392,7 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
         uint64_t active_pmem;
         uint64_t next_vmem;
         uint64_t next_pmem;
-    } QEMU_PACKED *part_info = (void *)cmd->payload;
+    } QEMU_PACKED *part_info = (void *)payload;
     QEMU_BUILD_BUG_ON(sizeof(*part_info) != 0x20);
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
@@ -400,7 +413,8 @@ static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
+static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
+                                   uint8_t *payload,
                                    CXLDeviceState *cxl_dstate,
                                    uint16_t *len)
 {
@@ -412,7 +426,7 @@ static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint32_t offset, length;
 
-    get_lsa = (void *)cmd->payload;
+    get_lsa = (void *)payload;
     offset = get_lsa->offset;
     length = get_lsa->length;
 
@@ -425,7 +439,8 @@ static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
+static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
+                                   uint8_t *payload,
                                    CXLDeviceState *cxl_dstate,
                                    uint16_t *len)
 {
@@ -434,7 +449,7 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
         uint32_t rsvd;
         uint8_t data[];
     } QEMU_PACKED;
-    struct set_lsa_pl *set_lsa_payload = (void *)cmd->payload;
+    struct set_lsa_pl *set_lsa_payload = (void *)payload;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
@@ -460,7 +475,8 @@ static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
  * make this stateful. We may want to allow longer poison lists to aid
  * testing that kernel functionality.
  */
-static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
+static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
+                                            uint8_t *payload,
                                             CXLDeviceState *cxl_dstate,
                                             uint16_t *len)
 {
@@ -482,8 +498,8 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
         } QEMU_PACKED records[];
     } QEMU_PACKED;
 
-    struct get_poison_list_pl *in = (void *)cmd->payload;
-    struct get_poison_list_out_pl *out = (void *)cmd->payload;
+    struct get_poison_list_pl *in = (void *)payload;
+    struct get_poison_list_out_pl *out = (void *)payload;
     CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
     uint16_t record_count = 0, i = 0;
     uint64_t query_start, query_length;
@@ -536,7 +552,8 @@ static CXLRetCode cmd_media_get_poison_list(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
+static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
+                                          uint8_t *payload,
                                           CXLDeviceState *cxl_dstate,
                                           uint16_t *len_unused)
 {
@@ -546,7 +563,7 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     struct inject_poison_pl {
         uint64_t dpa;
     };
-    struct inject_poison_pl *in = (void *)cmd->payload;
+    struct inject_poison_pl *in = (void *)payload;
     uint64_t dpa = ldq_le_p(&in->dpa);
     CXLPoison *p;
 
@@ -575,7 +592,8 @@ static CXLRetCode cmd_media_inject_poison(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
+static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
+                                         uint8_t *payload,
                                          CXLDeviceState *cxl_dstate,
                                          uint16_t *len_unused)
 {
@@ -589,7 +607,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
     CXLPoison *ent;
     uint64_t dpa;
 
-    struct clear_poison_pl *in = (void *)cmd->payload;
+    struct clear_poison_pl *in = (void *)payload;
 
     dpa = ldq_le_p(&in->dpa);
     if (dpa + CXL_CACHE_LINE_SIZE > cxl_dstate->mem_size) {
@@ -659,7 +677,7 @@ static CXLRetCode cmd_media_clear_poison(struct cxl_cmd *cmd,
 #define IMMEDIATE_POLICY_CHANGE (1 << 3)
 #define IMMEDIATE_LOG_CHANGE (1 << 4)
 
-static struct cxl_cmd cxl_cmd_set[256][256] = {
+static const struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
         cmd_events_get_records, 1, 0 },
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
@@ -693,21 +711,21 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
 void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
-    struct cxl_cmd *cxl_cmd;
-    uint64_t status_reg;
+    const struct cxl_cmd *cxl_cmd;
+    uint64_t status_reg = 0;
     opcode_handler h;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
     uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
+    uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
+
     cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
         if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
-            cxl_cmd->payload = cxl_dstate->mbox_reg_state +
-                A_CXL_DEV_CMD_PAYLOAD;
-            ret = (*h)(cxl_cmd, cxl_dstate, &len);
+            ret = (*h)(cxl_cmd, pl, cxl_dstate, &len);
             assert(len <= cxl_dstate->payload_size);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
@@ -740,7 +758,7 @@ void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
             if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
-                struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
+                const struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
                 struct cel_log *log =
                     &cxl_dstate->cel_log[cxl_dstate->cel_size];
 
-- 
2.39.2

