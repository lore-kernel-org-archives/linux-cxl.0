Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFAF1C6FD18
	for <linux-cxl@archiver.kernel.org>; Sun, 23 Apr 2023 16:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjDWQUo (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Sun, 23 Apr 2023 12:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjDWQUn (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Sun, 23 Apr 2023 12:20:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A0BE74
        for <linux-cxl@vger.kernel.org>; Sun, 23 Apr 2023 09:20:42 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Q4D1x0CGgz67pY8;
        Mon, 24 Apr 2023 00:17:41 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Sun, 23 Apr 2023 17:20:39 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <qemu-devel@nongnu.org>, Michael Tsirkin <mst@redhat.com>,
        Fan Ni <fan.ni@samsung.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Michael Roth <michael.roth@amd.com>,
        =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
        Dave Jiang <dave.jiang@intel.com>,
        Markus Armbruster <armbru@redhat.com>,
        =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
        Eric Blake <eblake@redhat.com>,
        Mike Maslenkin <mike.maslenkin@gmail.com>,
        =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
        Thomas Huth <thuth@redhat.com>
Subject: [PATCH v5 1/6] hw/cxl: rename mailbox return code type from ret_code to CXLRetCode
Date:   Sun, 23 Apr 2023 17:20:08 +0100
Message-ID: <20230423162013.4535-2-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
References: <20230423162013.4535-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Given the increasing usage of this mailbox return code type, now
is a good time to switch to QEMU style naming.

Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Reviewed-by: Fan Ni <fan.ni@samsung.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

---
v5: Picked up Philippe's tag.
---
 hw/cxl/cxl-mailbox-utils.c | 64 +++++++++++++++++++-------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index ed663cc04a..7b2aef0d67 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -23,7 +23,7 @@
  *     FOO    = 0x7f,
  *          #define BAR 0
  *  2. Implement the handler
- *    static ret_code cmd_foo_bar(struct cxl_cmd *cmd,
+ *    static CXLRetCode cmd_foo_bar(struct cxl_cmd *cmd,
  *                                  CXLDeviceState *cxl_dstate, uint16_t *len)
  *  3. Add the command to the cxl_cmd_set[][]
  *    [FOO][BAR] = { "FOO_BAR", cmd_foo_bar, x, y },
@@ -90,10 +90,10 @@ typedef enum {
     CXL_MBOX_UNSUPPORTED_MAILBOX = 0x15,
     CXL_MBOX_INVALID_PAYLOAD_LENGTH = 0x16,
     CXL_MBOX_MAX = 0x17
-} ret_code;
+} CXLRetCode;
 
 struct cxl_cmd;
-typedef ret_code (*opcode_handler)(struct cxl_cmd *cmd,
+typedef CXLRetCode (*opcode_handler)(struct cxl_cmd *cmd,
                                    CXLDeviceState *cxl_dstate, uint16_t *len);
 struct cxl_cmd {
     const char *name;
@@ -105,16 +105,16 @@ struct cxl_cmd {
 
 #define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
     uint16_t __zero##name = size;                                         \
-    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
-                               CXLDeviceState *cxl_dstate, uint16_t *len) \
+    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
+                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
     {                                                                     \
         *len = __zero##name;                                              \
         memset(cmd->payload, 0, *len);                                    \
         return CXL_MBOX_SUCCESS;                                          \
     }
 #define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
-    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
-                               CXLDeviceState *cxl_dstate, uint16_t *len) \
+    static CXLRetCode cmd_##name(struct cxl_cmd *cmd,                       \
+                                 CXLDeviceState *cxl_dstate, uint16_t *len) \
     {                                                                     \
         return CXL_MBOX_SUCCESS;                                          \
     }
@@ -125,9 +125,9 @@ DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
 DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
 
 /* 8.2.9.2.1 */
-static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
-                                             CXLDeviceState *cxl_dstate,
-                                             uint16_t *len)
+static CXLRetCode cmd_firmware_update_get_info(struct cxl_cmd *cmd,
+                                               CXLDeviceState *cxl_dstate,
+                                               uint16_t *len)
 {
     struct {
         uint8_t slots_supported;
@@ -159,9 +159,9 @@ static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.3.1 */
-static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
-                                  CXLDeviceState *cxl_dstate,
-                                  uint16_t *len)
+static CXLRetCode cmd_timestamp_get(struct cxl_cmd *cmd,
+                                    CXLDeviceState *cxl_dstate,
+                                    uint16_t *len)
 {
     uint64_t time, delta;
     uint64_t final_time = 0;
@@ -181,7 +181,7 @@ static ret_code cmd_timestamp_get(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.3.2 */
-static ret_code cmd_timestamp_set(struct cxl_cmd *cmd,
+static CXLRetCode cmd_timestamp_set(struct cxl_cmd *cmd,
                                   CXLDeviceState *cxl_dstate,
                                   uint16_t *len)
 {
@@ -201,9 +201,9 @@ static const QemuUUID cel_uuid = {
 };
 
 /* 8.2.9.4.1 */
-static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
-                                       CXLDeviceState *cxl_dstate,
-                                       uint16_t *len)
+static CXLRetCode cmd_logs_get_supported(struct cxl_cmd *cmd,
+                                         CXLDeviceState *cxl_dstate,
+                                         uint16_t *len)
 {
     struct {
         uint16_t entries;
@@ -224,9 +224,9 @@ static ret_code cmd_logs_get_supported(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.4.2 */
-static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
-                                 CXLDeviceState *cxl_dstate,
-                                 uint16_t *len)
+static CXLRetCode cmd_logs_get_log(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate,
+                                   uint16_t *len)
 {
     struct {
         QemuUUID uuid;
@@ -265,9 +265,9 @@ static ret_code cmd_logs_get_log(struct cxl_cmd *cmd,
 }
 
 /* 8.2.9.5.1.1 */
-static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
-                                           CXLDeviceState *cxl_dstate,
-                                           uint16_t *len)
+static CXLRetCode cmd_identify_memory_device(struct cxl_cmd *cmd,
+                                             CXLDeviceState *cxl_dstate,
+                                             uint16_t *len)
 {
     struct {
         char fw_revision[0x10];
@@ -309,9 +309,9 @@ static ret_code cmd_identify_memory_device(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
-                                           CXLDeviceState *cxl_dstate,
-                                           uint16_t *len)
+static CXLRetCode cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
+                                              CXLDeviceState *cxl_dstate,
+                                              uint16_t *len)
 {
     struct {
         uint64_t active_vmem;
@@ -339,9 +339,9 @@ static ret_code cmd_ccls_get_partition_info(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
-                                 CXLDeviceState *cxl_dstate,
-                                 uint16_t *len)
+static CXLRetCode cmd_ccls_get_lsa(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate,
+                                   uint16_t *len)
 {
     struct {
         uint32_t offset;
@@ -364,9 +364,9 @@ static ret_code cmd_ccls_get_lsa(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
-static ret_code cmd_ccls_set_lsa(struct cxl_cmd *cmd,
-                                 CXLDeviceState *cxl_dstate,
-                                 uint16_t *len)
+static CXLRetCode cmd_ccls_set_lsa(struct cxl_cmd *cmd,
+                                   CXLDeviceState *cxl_dstate,
+                                   uint16_t *len)
 {
     struct set_lsa_pl {
         uint32_t offset;
-- 
2.37.2

