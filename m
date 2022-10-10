Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF60BC43219
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiJJWa0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:30:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbiJJWaY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:30:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483495F10A
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441023; x=1696977023;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FYIhp/lfplx+aqHt/7Dq3xswYQzfhxppIKNEfK/6qE8=;
  b=dviraB1mvHg1w7cxhBuyG6uJEQ4TkKTo7VZJO7KHAcjWkB+s0vaVOYmE
   9//blqH0y9Lox9YvDtPex1kHGzN7VWZn7+GL2Q0EofI/S/tskHN54nKBX
   P9Evozq17azea3eeiFpU47n4CaM6Gg/3M3QpFpYkTXbWHvYa5z2gqtCOY
   JSk4mDZxjNZk1/70rk8uuz9dAgiM2BhBSd6zXs1aaD2XQgYwD+rawMKO6
   2YIiJqkOeE5+gtM01AnmXiHd9grDR/nM2iXSVQb2FgtjuYw2xKM9p2cao
   fY0Cjwv2WiM8MjRCPfnzrIjzJchJBf8D/t3l8TWC8zG6U8kE2cxag7aSZ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291661254"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291661254"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:22 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628457026"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628457026"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.104.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:22 -0700
From:   ira.weiny@intel.com
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: [RFC PATCH 6/6] hw/cxl/mailbox: Wire up Get/Set Event Interrupt policy
Date:   Mon, 10 Oct 2022 15:29:44 -0700
Message-Id: <20221010222944.3923556-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Replace the stubbed out CXL Get/Set Event interrupt policy mailbox
commands.  Enable those commands to control interrupts for each of the
event log types.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hw/cxl/cxl-mailbox-utils.c  | 129 ++++++++++++++++++++++++++++++------
 include/hw/cxl/cxl_events.h |  21 ++++++
 2 files changed, 129 insertions(+), 21 deletions(-)

diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index df345f23a30c..52e8804c24ed 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -101,25 +101,6 @@ struct cxl_cmd {
     uint8_t *payload;
 };
 
-#define DEFINE_MAILBOX_HANDLER_ZEROED(name, size)                         \
-    uint16_t __zero##name = size;                                         \
-    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
-                               CXLDeviceState *cxl_dstate, uint16_t *len) \
-    {                                                                     \
-        *len = __zero##name;                                              \
-        memset(cmd->payload, 0, *len);                                    \
-        return CXL_MBOX_SUCCESS;                                          \
-    }
-#define DEFINE_MAILBOX_HANDLER_NOP(name)                                  \
-    static ret_code cmd_##name(struct cxl_cmd *cmd,                       \
-                               CXLDeviceState *cxl_dstate, uint16_t *len) \
-    {                                                                     \
-        return CXL_MBOX_SUCCESS;                                          \
-    }
-
-DEFINE_MAILBOX_HANDLER_ZEROED(events_get_interrupt_policy, 4);
-DEFINE_MAILBOX_HANDLER_NOP(events_set_interrupt_policy);
-
 static ret_code cmd_events_get_records(struct cxl_cmd *cmd,
                                        CXLDeviceState *cxlds,
                                        uint16_t *len)
@@ -218,6 +199,110 @@ static ret_code cmd_events_clear_records(struct cxl_cmd *cmd,
     return CXL_MBOX_SUCCESS;
 }
 
+static ret_code cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
+                                                CXLDeviceState *cxl_dstate,
+                                                uint16_t *len)
+{
+    struct cxl_event_interrupt_policy *policy;
+    struct cxl_event_log *log;
+
+    policy = (struct cxl_event_interrupt_policy *)cmd->payload;
+    memset(policy, 0, sizeof(*policy));
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_INFO);
+    if (log->irq_enabled) {
+        policy->info_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_WARN);
+    if (log->irq_enabled) {
+        policy->warn_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_FAIL);
+    if (log->irq_enabled) {
+        policy->failure_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_FATAL);
+    if (log->irq_enabled) {
+        policy->fatal_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_DYNAMIC_CAP);
+    if (log->irq_enabled) {
+        /* Dynamic Capacity borrows the same vector as info */
+        policy->dyn_cap_settings = CXL_INT_MSI_MSIX;
+    }
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
+static ret_code cmd_events_set_interrupt_policy(struct cxl_cmd *cmd,
+                                                CXLDeviceState *cxl_dstate,
+                                                uint16_t *len)
+{
+    struct cxl_event_interrupt_policy *policy;
+    struct cxl_event_log *log;
+
+    policy = (struct cxl_event_interrupt_policy *)cmd->payload;
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_INFO);
+    if ((policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
+                                                    CXL_INT_MSI_MSIX) {
+        log->irq_enabled = true;
+        log->irq_vec = cxl_dstate->event_vector[CXL_EVENT_TYPE_INFO];
+    } else {
+        log->irq_enabled = false;
+        log->irq_vec = 0;
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_WARN);
+    if ((policy->warn_settings & CXL_EVENT_INT_MODE_MASK) ==
+                                                    CXL_INT_MSI_MSIX) {
+        log->irq_enabled = true;
+        log->irq_vec = cxl_dstate->event_vector[CXL_EVENT_TYPE_WARN];
+    } else {
+        log->irq_enabled = false;
+        log->irq_vec = 0;
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_FAIL);
+    if ((policy->failure_settings & CXL_EVENT_INT_MODE_MASK) ==
+                                                    CXL_INT_MSI_MSIX) {
+        log->irq_enabled = true;
+        log->irq_vec = cxl_dstate->event_vector[CXL_EVENT_TYPE_FAIL];
+    } else {
+        log->irq_enabled = false;
+        log->irq_vec = 0;
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_FATAL);
+    if ((policy->fatal_settings & CXL_EVENT_INT_MODE_MASK) ==
+                                                    CXL_INT_MSI_MSIX) {
+        log->irq_enabled = true;
+        log->irq_vec = cxl_dstate->event_vector[CXL_EVENT_TYPE_FATAL];
+    } else {
+        log->irq_enabled = false;
+        log->irq_vec = 0;
+    }
+
+    log = find_event_log(cxl_dstate, CXL_EVENT_TYPE_DYNAMIC_CAP);
+    if ((policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
+                                                    CXL_INT_MSI_MSIX) {
+        log->irq_enabled = true;
+        /* Dynamic Capacity borrows the same vector as info */
+        log->irq_vec = cxl_dstate->event_vector[CXL_EVENT_TYPE_INFO];
+    } else {
+        log->irq_enabled = false;
+        log->irq_vec = 0;
+    }
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
                                              CXLDeviceState *cxl_dstate,
@@ -490,9 +575,11 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
         cmd_events_clear_records, 8, IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
-        cmd_events_get_interrupt_policy, 0, 0 },
+                                      cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
-        cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
+                                      cmd_events_set_interrupt_policy,
+                                      sizeof(struct cxl_event_interrupt_policy),
+                                      IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 255111f3dcfb..c121e504a6db 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -170,4 +170,25 @@ struct cxl_event_mem_module {
     uint8_t reserved[CXL_EVENT_MEM_MOD_RES_SIZE];
 } QEMU_PACKED;
 
+/**
+ * Event Interrupt Policy
+ *
+ * CXL rev 3.0 section 8.2.9.2.4; Table 8-52
+ */
+enum cxl_event_int_mode {
+    CXL_INT_NONE     = 0x00,
+    CXL_INT_MSI_MSIX = 0x01,
+    CXL_INT_FW       = 0x02,
+    CXL_INT_RES      = 0x03,
+};
+#define CXL_EVENT_INT_MODE_MASK 0x3
+#define CXL_EVENT_INT_SETTING(vector) ((((uint8_t)vector & 0xf) << 4) | CXL_INT_MSI_MSIX)
+struct cxl_event_interrupt_policy {
+    uint8_t info_settings;
+    uint8_t warn_settings;
+    uint8_t failure_settings;
+    uint8_t fatal_settings;
+    uint8_t dyn_cap_settings;
+} QEMU_PACKED;
+
 #endif /* CXL_EVENTS_H */
-- 
2.37.2

