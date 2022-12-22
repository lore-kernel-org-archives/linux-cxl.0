Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3E5C4167B
	for <linux-cxl@archiver.kernel.org>; Thu, 22 Dec 2022 04:25:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbiLVEZZ (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 21 Dec 2022 23:25:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiLVEZB (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 21 Dec 2022 23:25:01 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E57CE02
        for <linux-cxl@vger.kernel.org>; Wed, 21 Dec 2022 20:25:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1671683100; x=1703219100;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=FoxUVJp1TZY5GeNX0Mx4U+Cj2wm0CMQmx0Oi0AOfnQQ=;
  b=n5HduasJEWp/zK3AAyUlv/ErkgcyB9G5ExxCRFzIXgUkehftjmmpIUhN
   Jm+vFjM3TsI4u4/4UGW1cU1rKzuRS/BTaZAj88oZZ9t9bJFTKbQaAbNdP
   i0z34zab0FwCzBuMwHJHncUKCqy5axEIQvKta1QHlti90toK6L2btPYTF
   Z1TKZ9K4hgnRCsMZrZyX8Maq0Cbx/wFyR1TmcOpMMA85WPSxOAXEt6zaj
   2Fc993tzNQZr6bEAL8WIcfcHx8OHzTFBnb0asXsIRB3GAaC9i58D2oqV0
   kpjsQcue3C5mVabMgdI+pOfH5yYSOjRJ/sS1miXMMu9ET4kvaWF3X+FjV
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="321957622"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="321957622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:25:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10568"; a="601733206"
X-IronPort-AV: E=Sophos;i="5.96,264,1665471600"; 
   d="scan'208";a="601733206"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.20.211])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2022 20:24:59 -0800
From:   Ira Weiny <ira.weiny@intel.com>
Date:   Wed, 21 Dec 2022 20:24:36 -0800
Subject: [PATCH v2 6/8] hw/cxl/events: Add event interrupt support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221221-ira-cxl-events-2022-11-17-v2-6-2ce2ecc06219@intel.com>
References: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
In-Reply-To: <20221221-ira-cxl-events-2022-11-17-v2-0-2ce2ecc06219@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>
X-Mailer: b4 0.11.0-dev-141d4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1671683093; l=11685;
 i=ira.weiny@intel.com; s=20221211; h=from:subject:message-id;
 bh=FoxUVJp1TZY5GeNX0Mx4U+Cj2wm0CMQmx0Oi0AOfnQQ=;
 b=6unsNVcmilOmHOgNMeRne8h3qpXtQKTUssIAz2mQyKSkr2Bb/l8+7c62aigLlGZlUr/N4W6DDO9Y
 /kkqNderDmERpgP2lU78aQQj/eC3gQH2d5Fyv9JUqw521/DYtPl8
X-Developer-Key: i=ira.weiny@intel.com; a=ed25519;
 pk=noldbkG+Wp1qXRrrkfY1QJpDf7QsOEthbOT7vm0PqsE=
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Replace the stubbed out CXL Get/Set Event interrupt policy mailbox
commands.  Enable those commands to control interrupts for each of the
event log types.

Skip the standard input mailbox length on the Set command due to DCD
being optional.  Perform the checks separately.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
NOTE As the spec changes it may be wise to change the standard mailbox
processing to allow for various input length checks.  But I'm not going
try and tackle that in this series.

Changes from RFC:
	Squashed mailbox and irq patches together to support event
	interrupts as a whole
	Remove redundant event_vector array
---
 hw/cxl/cxl-events.c         |  33 +++++++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 106 +++++++++++++++++++++++++++++++++++---------
 hw/mem/cxl_type3.c          |   4 +-
 include/hw/cxl/cxl_device.h |   5 ++-
 include/hw/cxl/cxl_events.h |  23 ++++++++++
 5 files changed, 146 insertions(+), 25 deletions(-)

diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index f40c9372704e..53ec8447236e 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -13,6 +13,8 @@
 #include "qemu/bswap.h"
 #include "qemu/typedefs.h"
 #include "qemu/error-report.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 
@@ -26,7 +28,7 @@ static void reset_overflow(struct cxl_event_log *log)
     log->last_overflow_timestamp = 0;
 }
 
-void cxl_event_init(CXLDeviceState *cxlds)
+void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num)
 {
     struct cxl_event_log *log;
     int i;
@@ -37,9 +39,16 @@ void cxl_event_init(CXLDeviceState *cxlds)
         log->overflow_err_count = 0;
         log->first_overflow_timestamp = 0;
         log->last_overflow_timestamp = 0;
+        log->irq_enabled = false;
+        log->irq_vec = start_msg_num++;
         qemu_mutex_init(&log->lock);
         QSIMPLEQ_INIT(&log->events);
     }
+
+    /* Override -- Dynamic Capacity uses the same vector as info */
+    cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP].irq_vec =
+                      cxlds->event_logs[CXL_EVENT_TYPE_INFO].irq_vec;
+
 }
 
 static CXLEvent *cxl_event_get_head(struct cxl_event_log *log)
@@ -219,3 +228,25 @@ ret_code cxl_event_clear_records(CXLDeviceState *cxlds,
 
     return CXL_MBOX_SUCCESS;
 }
+
+void cxl_event_irq_assert(CXLType3Dev *ct3d)
+{
+    CXLDeviceState *cxlds = &ct3d->cxl_dstate;
+    PCIDevice *pdev = &ct3d->parent_obj;
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        struct cxl_event_log *log = &cxlds->event_logs[i];
+
+        if (!log->irq_enabled || cxl_event_empty(log)) {
+            continue;
+        }
+
+        /*  Notifies interrupt, legacy IRQ is not supported */
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, log->irq_vec);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, log->irq_vec);
+        }
+    }
+}
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 97cf6db8582d..ff94191a956a 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -74,25 +74,6 @@ enum {
         #define IDENTIFY_SWITCH_DEVICE      0x0
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
 static void find_cxl_usp(PCIBus *b, PCIDevice *d, void *opaque)
 {
     PCIDevice **found_dev = opaque;
@@ -288,6 +269,88 @@ static ret_code cmd_events_clear_records(struct cxl_cmd *cmd,
     return cxl_event_clear_records(cxlds, pl);
 }
 
+static ret_code cmd_events_get_interrupt_policy(struct cxl_cmd *cmd,
+                                                CXLDeviceState *cxlds,
+                                                uint16_t *len)
+{
+    struct cxl_event_interrupt_policy *policy;
+    struct cxl_event_log *log;
+
+    policy = (struct cxl_event_interrupt_policy *)cmd->payload;
+    memset(policy, 0, sizeof(*policy));
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
+    if (log->irq_enabled) {
+        policy->info_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
+    if (log->irq_enabled) {
+        policy->warn_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
+    if (log->irq_enabled) {
+        policy->failure_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
+    if (log->irq_enabled) {
+        policy->fatal_settings = CXL_EVENT_INT_SETTING(log->irq_vec);
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
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
+                                                CXLDeviceState *cxlds,
+                                                uint16_t *len)
+{
+    struct cxl_event_interrupt_policy *policy;
+    struct cxl_event_log *log;
+
+    if (*len < CXL_EVENT_INT_SETTING_MIN_LEN) {
+        return CXL_MBOX_INVALID_PAYLOAD_LENGTH;
+    }
+
+    policy = (struct cxl_event_interrupt_policy *)cmd->payload;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_INFO];
+    log->irq_enabled = (policy->info_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_WARN];
+    log->irq_enabled = (policy->warn_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FAIL];
+    log->irq_enabled = (policy->failure_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_FATAL];
+    log->irq_enabled = (policy->fatal_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    /* DCD is optional */
+    if (*len < sizeof(*policy)) {
+        return CXL_MBOX_SUCCESS;
+    }
+
+    log = &cxlds->event_logs[CXL_EVENT_TYPE_DYNAMIC_CAP];
+    log->irq_enabled = (policy->dyn_cap_settings & CXL_EVENT_INT_MODE_MASK) ==
+                        CXL_INT_MSI_MSIX;
+
+    *len = sizeof(*policy);
+    return CXL_MBOX_SUCCESS;
+}
+
 /* 8.2.9.2.1 */
 static ret_code cmd_firmware_update_get_info(struct cxl_cmd *cmd,
                                              CXLDeviceState *cxl_dstate,
@@ -644,9 +707,10 @@ static struct cxl_cmd cxl_cmd_set[256][256] = {
     [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
         cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
     [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
-        cmd_events_get_interrupt_policy, 0, 0 },
+                                      cmd_events_get_interrupt_policy, 0, 0 },
     [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
-        cmd_events_set_interrupt_policy, 4, IMMEDIATE_CONFIG_CHANGE },
+                                      cmd_events_set_interrupt_policy,
+                                      ~0, IMMEDIATE_CONFIG_CHANGE },
     [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
         cmd_firmware_update_get_info, 0, 0 },
     [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index e74ef237dfa9..a43949cab120 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -626,7 +626,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 4;
+    unsigned short msix_num = 8;
     int i, rc;
 
     if (!cxl_setup_memory(ct3d, errp)) {
@@ -697,7 +697,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     /* CXL RAS uses AER correct INTERNAL erorrs - so enable by default */
     pci_set_long(pci_dev->config + 0x200 + PCI_ERR_COR_MASK,
                  PCI_ERR_COR_MASK_DEFAULT & ~PCI_ERR_COR_INTERNAL);
-    cxl_event_init(&ct3d->cxl_dstate);
+    cxl_event_init(&ct3d->cxl_dstate, 4);
     return;
 
 err_free_spdm_socket:
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index d7b43e74c05c..586377607c57 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -153,6 +153,8 @@ struct cxl_event_log {
     uint16_t overflow_err_count;
     uint64_t first_overflow_timestamp;
     uint64_t last_overflow_timestamp;
+    bool irq_enabled;
+    int irq_vec;
     QemuMutex lock;
     QSIMPLEQ_HEAD(, CXLEvent) events;
 };
@@ -398,7 +400,7 @@ struct CSWMBCCIDev {
     CXLDeviceState cxl_dstate;
 };
 
-void cxl_event_init(CXLDeviceState *cxlds);
+void cxl_event_init(CXLDeviceState *cxlds, int start_msg_num);
 bool cxl_event_insert(CXLDeviceState *cxlds,
                       enum cxl_event_log_type log_type,
                       struct cxl_event_record_raw *event);
@@ -408,5 +410,6 @@ ret_code cxl_event_get_records(CXLDeviceState *cxlds,
                                uint16_t *len);
 ret_code cxl_event_clear_records(CXLDeviceState *cxlds,
                                  struct cxl_clear_event_payload *pl);
+void cxl_event_irq_assert(CXLType3Dev *ct3d);
 
 #endif
diff --git a/include/hw/cxl/cxl_events.h b/include/hw/cxl/cxl_events.h
index 1798c4502cb3..2df40720320a 100644
--- a/include/hw/cxl/cxl_events.h
+++ b/include/hw/cxl/cxl_events.h
@@ -80,4 +80,27 @@ struct cxl_clear_event_payload {
     uint16_t handle[];
 };
 
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
+/* DCD is optional but other fields are not */
+#define CXL_EVENT_INT_SETTING_MIN_LEN 4
+
 #endif /* CXL_EVENTS_H */

-- 
2.38.1
