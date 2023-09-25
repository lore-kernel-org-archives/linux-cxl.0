Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5537BCE7A9A
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:13:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233152AbjIYQNG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233186AbjIYQNG (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:13:06 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82F90116
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:12:57 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvSYX1RZhz6K86R;
        Tue, 26 Sep 2023 00:11:44 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:12:54 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
        Michael Tsirkin <mst@redhat.com>
CC:     <linuxarm@huawei.com>, Fan Ni <fan.ni@samsung.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Gregory Price <gregory.price@memverge.com>,
        Klaus Jensen <its@irrelevant.dk>,
        Corey Minyard <cminyard@mvista.com>,
        Klaus Jensen <k.jensen@samsung.com>
Subject: [PATCH 03/19] hw/cxl/mbox: Pull the CCI definition out of the CXLDeviceState
Date:   Mon, 25 Sep 2023 17:11:08 +0100
Message-ID: <20230925161124.18940-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
References: <20230925161124.18940-1-Jonathan.Cameron@huawei.com>
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

Enables having multiple CCIs per devices. Each CCI (mailbox) has it's own
state and command list, so they can't share a single structure.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 45 ++++++++++++++----
 hw/cxl/cxl-device-utils.c   | 31 +++++++++---
 hw/cxl/cxl-mailbox-utils.c  | 94 ++++++++++++++++++++++---------------
 hw/mem/cxl_type3.c          |  5 +-
 4 files changed, 119 insertions(+), 56 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d7a2c4009e..c883d9dd8f 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -111,12 +111,13 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+typedef struct CXLCCI CXLCCI;
 typedef struct cxl_device_state CXLDeviceState;
 struct cxl_cmd;
 typedef CXLRetCode (*opcode_handler)(const struct cxl_cmd *cmd,
                                      uint8_t *payload_in, size_t len_in,
                                      uint8_t *payload_out, size_t *len_out,
-                                     CXLDeviceState *cxl_dstate);
+                                     CXLCCI *cci);
 struct cxl_cmd {
     const char *name;
     opcode_handler handler;
@@ -140,6 +141,31 @@ typedef struct CXLEventLog {
     QSIMPLEQ_HEAD(, CXLEvent) events;
 } CXLEventLog;
 
+typedef struct CXLCCI {
+    const struct cxl_cmd (*cxl_cmd_set)[256];
+    struct cel_log {
+        uint16_t opcode;
+        uint16_t effect;
+    } cel_log[1 << 16];
+    size_t cel_size;
+
+    /* background command handling (times in ms) */
+    struct {
+        uint16_t opcode;
+        uint16_t complete_pct;
+        uint16_t ret_code; /* Current value of retcode */
+        uint64_t starttime;
+        /* set by each bg cmd, cleared by the bg_timer when complete */
+        uint64_t runtime;
+        QEMUTimer *timer;
+    } bg;
+    size_t payload_max;
+    /* Pointer to device hosting the CCI */
+    DeviceState *d;
+    /* Pointer to the device hosting the protocol conversion */
+    DeviceState *intf;
+} CXLCCI;
+
 typedef struct cxl_device_state {
     MemoryRegion device_registers;
 
@@ -173,11 +199,6 @@ typedef struct cxl_device_state {
             uint32_t mbox_reg_state32[CXL_MAILBOX_REGISTERS_LENGTH / 4];
             uint64_t mbox_reg_state64[CXL_MAILBOX_REGISTERS_LENGTH / 8];
         };
-        struct cel_log {
-            uint16_t opcode;
-            uint16_t effect;
-        } cel_log[1 << 16];
-        size_t cel_size;
     };
 
     struct {
@@ -196,10 +217,12 @@ typedef struct cxl_device_state {
 } CXLDeviceState;
 
 /* Initialize the register block for a device */
-void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev);
+void cxl_device_register_block_init(Object *obj, CXLDeviceState *dev,
+                                    CXLCCI *cci);
 
+typedef struct CXLType3Dev CXLType3Dev;
 /* Set up default values for the register block */
-void cxl_device_register_init_common(CXLDeviceState *dev);
+void cxl_device_register_init_t3(CXLType3Dev *ct3d);
 
 /*
  * CXL 2.0 - 8.2.8.1 including errata F4
@@ -245,8 +268,9 @@ CXL_DEVICE_CAPABILITY_HEADER_REGISTER(MEMORY_DEVICE,
                                       CXL_DEVICE_CAP_HDR1_OFFSET +
                                           CXL_DEVICE_CAP_REG_SIZE * 2)
 
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate);
-void cxl_process_mailbox(CXLDeviceState *cxl_dstate);
+void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max);
+void cxl_init_cci(CXLCCI *cci, size_t payload_max);
+void cxl_process_mailbox(CXLCCI *cci);
 
 #define cxl_device_cap_init(dstate, reg, cap_id, ver)                      \
     do {                                                                   \
@@ -347,6 +371,7 @@ struct CXLType3Dev {
     AddressSpace hostpmem_as;
     CXLComponentState cxl_cstate;
     CXLDeviceState cxl_dstate;
+    CXLCCI cci; /* Primary PCI mailbox CCI */
 
     /* DOE */
     DOECap doe_cdat;
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index eb7195272e..327949a805 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -62,7 +62,14 @@ static uint64_t dev_reg_read(void *opaque, hwaddr offset, unsigned size)
 
 static uint64_t mailbox_reg_read(void *opaque, hwaddr offset, unsigned size)
 {
-    CXLDeviceState *cxl_dstate = opaque;
+    CXLDeviceState *cxl_dstate;
+    CXLCCI *cci = opaque;
+
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else {
+        return 0;
+    }
 
     switch (size) {
     case 1:
@@ -123,7 +130,14 @@ static void mailbox_mem_writeq(uint64_t *reg_state, hwaddr offset,
 static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
                               unsigned size)
 {
-    CXLDeviceState *cxl_dstate = opaque;
+    CXLDeviceState *cxl_dstate;
+    CXLCCI *cci = opaque;
+
+    if (object_dynamic_cast(OBJECT(cci->intf), TYPE_CXL_TYPE3)) {
+        cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
+    } else {
+        return;
+    }
 
     if (offset >= A_CXL_DEV_CMD_PAYLOAD) {
         memcpy(cxl_dstate->mbox_reg_state + offset, &value, size);
@@ -143,7 +157,7 @@ static void mailbox_reg_write(void *opaque, hwaddr offset, uint64_t value,
 
     if (ARRAY_FIELD_EX32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CTRL,
                          DOORBELL)) {
-        cxl_process_mailbox(cxl_dstate);
+        cxl_process_mailbox(cci);
     }
 }
 
@@ -223,7 +237,8 @@ static const MemoryRegionOps caps_ops = {
     },
 };
 
-void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
+void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate,
+                                    CXLCCI *cci)
 {
     /* This will be a BAR, so needs to be rounded up to pow2 for PCI spec */
     memory_region_init(&cxl_dstate->device_registers, obj, "device-registers",
@@ -233,7 +248,7 @@ void cxl_device_register_block_init(Object *obj, CXLDeviceState *cxl_dstate)
                           "cap-array", CXL_CAPS_SIZE);
     memory_region_init_io(&cxl_dstate->device, obj, &dev_ops, cxl_dstate,
                           "device-status", CXL_DEVICE_STATUS_REGISTERS_LENGTH);
-    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cxl_dstate,
+    memory_region_init_io(&cxl_dstate->mailbox, obj, &mailbox_ops, cci,
                           "mailbox", CXL_MAILBOX_REGISTERS_LENGTH);
     memory_region_init_io(&cxl_dstate->memory_device, obj, &mdev_ops,
                           cxl_dstate, "memory device caps",
@@ -284,8 +299,9 @@ static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
 
-void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
+void cxl_device_register_init_t3(CXLType3Dev *ct3d)
 {
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     uint64_t *cap_h = cxl_dstate->caps_reg_state64;
     const int cap_count = 3;
 
@@ -303,7 +319,8 @@ void cxl_device_register_init_common(CXLDeviceState *cxl_dstate)
     cxl_device_cap_init(cxl_dstate, MEMORY_DEVICE, 0x4000, 1);
     memdev_reg_init_common(cxl_dstate);
 
-    cxl_initialize_mailbox(cxl_dstate);
+    cxl_initialize_mailbox_t3(&ct3d->cci, DEVICE(ct3d),
+                              CXL_MAILBOX_MAX_PAYLOAD_SIZE);
 }
 
 uint64_t cxl_device_get_timestamp(CXLDeviceState *cxl_dstate)
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 4bdbc2ee83..376367c118 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -73,8 +73,9 @@ enum {
 static CXLRetCode cmd_events_get_records(const struct cxl_cmd *cmd,
                                          uint8_t *payload_in, size_t len_in,
                                          uint8_t *payload_out, size_t *len_out,
-                                         CXLDeviceState *cxlds)
+                                         CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLGetEventPayload *pl;
     uint8_t log_type;
     int max_recs;
@@ -102,8 +103,9 @@ static CXLRetCode cmd_events_clear_records(const struct cxl_cmd *cmd,
                                            size_t len_in,
                                            uint8_t *payload_out,
                                            size_t *len_out,
-                                           CXLDeviceState *cxlds)
+                                           CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLClearEventPayload *pl;
 
     pl = (CXLClearEventPayload *)payload_in;
@@ -116,8 +118,9 @@ static CXLRetCode cmd_events_get_interrupt_policy(const struct cxl_cmd *cmd,
                                                   size_t len_in,
                                                   uint8_t *payload_out,
                                                   size_t *len_out,
-                                                  CXLDeviceState *cxlds)
+                                                  CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
@@ -159,8 +162,9 @@ static CXLRetCode cmd_events_set_interrupt_policy(const struct cxl_cmd *cmd,
                                                   size_t len_in,
                                                   uint8_t *payload_out,
                                                   size_t *len_out,
-                                                  CXLDeviceState *cxlds)
+                                                  CXLCCI *cci)
 {
+    CXLDeviceState *cxlds = &CXL_TYPE3(cci->d)->cxl_dstate;
     CXLEventInterruptPolicy *policy;
     CXLEventLog *log;
 
@@ -205,8 +209,9 @@ static CXLRetCode cmd_firmware_update_get_info(const struct cxl_cmd *cmd,
                                                size_t len,
                                                uint8_t *payload_out,
                                                size_t *len_out,
-                                               CXLDeviceState *cxl_dstate)
+                                               CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     struct {
         uint8_t slots_supported;
         uint8_t slot_info;
@@ -242,8 +247,9 @@ static CXLRetCode cmd_timestamp_get(const struct cxl_cmd *cmd,
                                     size_t len_in,
                                     uint8_t *payload_out,
                                     size_t *len_out,
-                                    CXLDeviceState *cxl_dstate)
+                                    CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     uint64_t final_time = cxl_device_get_timestamp(cxl_dstate);
 
     stq_le_p(payload_out, final_time);
@@ -258,8 +264,10 @@ static CXLRetCode cmd_timestamp_set(const struct cxl_cmd *cmd,
                                     size_t len_in,
                                     uint8_t *payload_out,
                                     size_t *len_out,
-                                    CXLDeviceState *cxl_dstate)
+                                    CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
+
     cxl_dstate->timestamp.set = true;
     cxl_dstate->timestamp.last_set = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
 
@@ -281,7 +289,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
                                          size_t len_in,
                                          uint8_t *payload_out,
                                          size_t *len_out,
-                                         CXLDeviceState *cxl_dstate)
+                                         CXLCCI *cci)
 {
     struct {
         uint16_t entries;
@@ -295,7 +303,7 @@ static CXLRetCode cmd_logs_get_supported(const struct cxl_cmd *cmd,
 
     supported_logs->entries = 1;
     supported_logs->log_entries[0].uuid = cel_uuid;
-    supported_logs->log_entries[0].size = 4 * cxl_dstate->cel_size;
+    supported_logs->log_entries[0].size = 4 * cci->cel_size;
 
     *len_out = sizeof(*supported_logs);
     return CXL_MBOX_SUCCESS;
@@ -307,7 +315,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
                                    size_t len_in,
                                    uint8_t *payload_out,
                                    size_t *len_out,
-                                   CXLDeviceState *cxl_dstate)
+                                   CXLCCI *cci)
 {
     struct {
         QemuUUID uuid;
@@ -330,7 +338,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
      * the only possible failure would be if the mailbox itself isn't big
      * enough.
      */
-    if (get_log->offset + get_log->length > cxl_dstate->payload_size) {
+    if (get_log->offset + get_log->length > cci->payload_max) {
         return CXL_MBOX_INVALID_INPUT;
     }
 
@@ -341,8 +349,7 @@ static CXLRetCode cmd_logs_get_log(const struct cxl_cmd *cmd,
     /* Store off everything to local variables so we can wipe out the payload */
     *len_out = get_log->length;
 
-    memmove(payload_out, cxl_dstate->cel_log + get_log->offset,
-            get_log->length);
+    memmove(payload_out, cci->cel_log + get_log->offset, get_log->length);
 
     return CXL_MBOX_SUCCESS;
 }
@@ -353,7 +360,7 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
                                              size_t len_in,
                                              uint8_t *payload_out,
                                              size_t *len_out,
-                                             CXLDeviceState *cxl_dstate)
+                                             CXLCCI *cci)
 {
     struct {
         char fw_revision[0x10];
@@ -372,9 +379,9 @@ static CXLRetCode cmd_identify_memory_device(const struct cxl_cmd *cmd,
         uint8_t qos_telemetry_caps;
     } QEMU_PACKED *id;
     QEMU_BUILD_BUG_ON(sizeof(*id) != 0x43);
-
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
 
     if ((!QEMU_IS_ALIGNED(cxl_dstate->vmem_size, CXL_CAPACITY_MULTIPLIER)) ||
         (!QEMU_IS_ALIGNED(cxl_dstate->pmem_size, CXL_CAPACITY_MULTIPLIER))) {
@@ -407,8 +414,9 @@ static CXLRetCode cmd_ccls_get_partition_info(const struct cxl_cmd *cmd,
                                               size_t len_in,
                                               uint8_t *payload_out,
                                               size_t *len_out,
-                                              CXLDeviceState *cxl_dstate)
+                                              CXLCCI *cci)
 {
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     struct {
         uint64_t active_vmem;
         uint64_t active_pmem;
@@ -442,13 +450,13 @@ static CXLRetCode cmd_ccls_get_lsa(const struct cxl_cmd *cmd,
                                    size_t len_in,
                                    uint8_t *payload_out,
                                    size_t *len_out,
-                                   CXLDeviceState *cxl_dstate)
+                                   CXLCCI *cci)
 {
     struct {
         uint32_t offset;
         uint32_t length;
     } QEMU_PACKED *get_lsa;
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     uint32_t offset, length;
 
@@ -470,7 +478,7 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
                                    size_t len_in,
                                    uint8_t *payload_out,
                                    size_t *len_out,
-                                   CXLDeviceState *cxl_dstate)
+                                   CXLCCI *cci)
 {
     struct set_lsa_pl {
         uint32_t offset;
@@ -478,7 +486,7 @@ static CXLRetCode cmd_ccls_set_lsa(const struct cxl_cmd *cmd,
         uint8_t data[];
     } QEMU_PACKED;
     struct set_lsa_pl *set_lsa_payload = (void *)payload_in;
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     const size_t hdr_len = offsetof(struct set_lsa_pl, data);
 
@@ -507,7 +515,7 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
                                             size_t len_in,
                                             uint8_t *payload_out,
                                             size_t *len_out,
-                                            CXLDeviceState *cxl_dstate)
+                                            CXLCCI *cci)
 {
     struct get_poison_list_pl {
         uint64_t pa;
@@ -529,7 +537,7 @@ static CXLRetCode cmd_media_get_poison_list(const struct cxl_cmd *cmd,
 
     struct get_poison_list_pl *in = (void *)payload_in;
     struct get_poison_list_out_pl *out = (void *)payload_out;
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     uint16_t record_count = 0, i = 0;
     uint64_t query_start, query_length;
     CXLPoisonList *poison_list = &ct3d->poison_list;
@@ -586,9 +594,9 @@ static CXLRetCode cmd_media_inject_poison(const struct cxl_cmd *cmd,
                                           size_t len_in,
                                           uint8_t *payload_out,
                                           size_t *len_out,
-                                          CXLDeviceState *cxl_dstate)
+                                          CXLCCI *cci)
 {
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
     CXLPoisonList *poison_list = &ct3d->poison_list;
     CXLPoison *ent;
     struct inject_poison_pl {
@@ -629,9 +637,10 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
                                          size_t len_in,
                                          uint8_t *payload_out,
                                          size_t *len_out,
-                                         CXLDeviceState *cxl_dstate)
+                                         CXLCCI *cci)
 {
-    CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+    CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
     CXLPoisonList *poison_list = &ct3d->poison_list;
     CXLType3Class *cvc = CXL_TYPE3_GET_CLASS(ct3d);
     struct clear_poison_pl {
@@ -745,12 +754,13 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
         cmd_media_clear_poison, 72, 0 },
 };
 
-void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
+void cxl_process_mailbox(CXLCCI *cci)
 {
     uint16_t ret = CXL_MBOX_SUCCESS;
     const struct cxl_cmd *cxl_cmd;
     uint64_t status_reg = 0;
     opcode_handler h;
+    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
     uint64_t command_reg = cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_CMD];
 
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
@@ -759,12 +769,12 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     uint8_t *pl = cxl_dstate->mbox_reg_state + A_CXL_DEV_CMD_PAYLOAD;
     size_t len_out = 0;
 
-    cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
+    cxl_cmd = &cci->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
         if (len_in == cxl_cmd->in || cxl_cmd->in == ~0) {
-            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cxl_dstate);
-            assert(len_out <= cxl_dstate->payload_size);
+            ret = (*h)(cxl_cmd, pl, len_in, pl, &len_out, cci);
+            assert(len_out <= cci->payload_max);
         } else {
             ret = CXL_MBOX_INVALID_PAYLOAD_LENGTH;
         }
@@ -790,20 +800,30 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
                      DOORBELL, 0);
 }
 
-void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
+void cxl_init_cci(CXLCCI *cci, size_t payload_max)
 {
-    cxl_dstate->cxl_cmd_set = cxl_cmd_set;
+    cci->payload_max = payload_max;
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
-            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
-                const struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
+            if (cci->cxl_cmd_set[set][cmd].handler) {
+                const struct cxl_cmd *c = &cci->cxl_cmd_set[set][cmd];
                 struct cel_log *log =
-                    &cxl_dstate->cel_log[cxl_dstate->cel_size];
+                    &cci->cel_log[cci->cel_size];
 
                 log->opcode = (set << 8) | cmd;
                 log->effect = c->effect;
-                cxl_dstate->cel_size++;
+                cci->cel_size++;
             }
         }
     }
 }
+
+void cxl_initialize_mailbox_t3(CXLCCI *cci, DeviceState *d, size_t payload_max)
+{
+    cci->cxl_cmd_set = cxl_cmd_set;
+    cci->d = d;
+
+    /* No separation for PCI MB as protocol handled in PCI device */
+    cci->intf = d;
+    cxl_init_cci(cci, payload_max);
+}
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 18ad853f5b..0529745786 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -716,7 +716,8 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         pci_dev, CXL_COMPONENT_REG_BAR_IDX,
         PCI_BASE_ADDRESS_SPACE_MEMORY | PCI_BASE_ADDRESS_MEM_TYPE_64, mr);
 
-    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate);
+    cxl_device_register_block_init(OBJECT(pci_dev), &ct3d->cxl_dstate,
+                                   &ct3d->cci);
     pci_register_bar(pci_dev, CXL_DEVICE_REG_BAR_IDX,
                      PCI_BASE_ADDRESS_SPACE_MEMORY |
                          PCI_BASE_ADDRESS_MEM_TYPE_64,
@@ -922,7 +923,7 @@ static void ct3d_reset(DeviceState *dev)
     uint32_t *write_msk = ct3d->cxl_cstate.crb.cache_mem_regs_write_mask;
 
     cxl_component_register_init_common(reg_state, write_msk, CXL2_TYPE3_DEVICE);
-    cxl_device_register_init_common(&ct3d->cxl_dstate);
+    cxl_device_register_init_t3(ct3d);
 }
 
 static Property ct3_props[] = {
-- 
2.39.2

