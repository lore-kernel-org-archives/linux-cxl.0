Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F39EEB64DC
	for <linux-cxl@archiver.kernel.org>; Mon, 17 Jul 2023 17:17:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjGQRRw (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 17 Jul 2023 13:17:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjGQRRv (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 17 Jul 2023 13:17:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59564E3
        for <linux-cxl@vger.kernel.org>; Mon, 17 Jul 2023 10:17:47 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4R4TH92rFwz67g19;
        Tue, 18 Jul 2023 01:15:17 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 18:17:44 +0100
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
Subject: [RFC PATCH 02/17] hw/cxl/mailbox: Enable mulitple mailbox command sets
Date:   Mon, 17 Jul 2023 18:16:31 +0100
Message-ID: <20230717171646.8972-3-Jonathan.Cameron@huawei.com>
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

Until now, we have supported only a single set of comamnds.
To allow introduction of switch CCI functions, we need to
be able to pick between different sets for a given mailbox
instance.  This patch should make not functional changes, but
enable them in the following patches.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h | 12 ++++++++++++
 hw/cxl/cxl-mailbox-utils.c  | 17 ++++-------------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 887a38bdbc..2c239fca47 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -134,6 +134,17 @@ typedef enum {
     CXL_MBOX_MAX = 0x17
 } CXLRetCode;
 
+struct cxl_cmd;
+typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
+                                     CXLDeviceState *cxl_dstate, uint16_t *len);
+struct cxl_cmd {
+    const char *name;
+    opcode_handler handler;
+    ssize_t in;
+    uint16_t effect; /* Reported in CEL */
+    uint8_t *payload;
+};
+
 typedef struct CXLEvent {
     CXLEventRecordRaw data;
     QSIMPLEQ_ENTRY(CXLEvent) node;
@@ -202,6 +213,7 @@ typedef struct cxl_device_state {
     uint64_t pmem_size;
     uint64_t vmem_size;
 
+    struct cxl_cmd (*cxl_cmd_set)[256];
     CPMUState cpmu[CXL_NUM_CPMU_INSTANCES];
     CXLEventLog event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 1e0d96f64f..c8feeffbeb 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -70,16 +70,6 @@ enum {
         #define CLEAR_POISON           0x2
 };
 
-struct cxl_cmd;
-typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
-                                   CXLDeviceState *cxl_dstate, uint16_t *len);
-struct cxl_cmd {
-    const char *name;
-    opcode_handler handler;
-    ssize_t in;
-    uint16_t effect; /* Reported in CEL */
-    uint8_t *payload;
-};
 
 static CXLRetCode cmd_events_get_records(struct cxl_cmd *cmd,
                                          CXLDeviceState *cxlds,
@@ -711,7 +701,7 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
     uint8_t set = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND_SET);
     uint8_t cmd = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, COMMAND);
     uint16_t len = FIELD_EX64(command_reg, CXL_DEV_MAILBOX_CMD, LENGTH);
-    cxl_cmd = &cxl_cmd_set[set][cmd];
+    cxl_cmd = &cxl_dstate->cxl_cmd_set[set][cmd];
     h = cxl_cmd->handler;
     if (h) {
         if (len == cxl_cmd->in || cxl_cmd->in == ~0) {
@@ -746,10 +736,11 @@ void cxl_process_mailbox(CXLDeviceState *cxl_dstate)
 
 void cxl_initialize_mailbox(CXLDeviceState *cxl_dstate)
 {
+    cxl_dstate->cxl_cmd_set = cxl_cmd_set;
     for (int set = 0; set < 256; set++) {
         for (int cmd = 0; cmd < 256; cmd++) {
-            if (cxl_cmd_set[set][cmd].handler) {
-                struct cxl_cmd *c = &cxl_cmd_set[set][cmd];
+            if (cxl_dstate->cxl_cmd_set[set][cmd].handler) {
+                struct cxl_cmd *c = &cxl_dstate->cxl_cmd_set[set][cmd];
                 struct cel_log *log =
                     &cxl_dstate->cel_log[cxl_dstate->cel_size];
 
-- 
2.39.2

