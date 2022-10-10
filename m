Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D98C433FE
	for <linux-cxl@archiver.kernel.org>; Mon, 10 Oct 2022 22:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiJJWa1 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 10 Oct 2022 18:30:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiJJWaX (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 10 Oct 2022 18:30:23 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE765AC68
        for <linux-cxl@vger.kernel.org>; Mon, 10 Oct 2022 15:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665441022; x=1696977022;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=oFuJH3V9v+i1P+Dh0Wc+EVn5PyOw5woJfSZ6SrKW7v0=;
  b=PI1luRx4PZ2bE2iVNd9fdhS5BhgBbiPOKU505AQg0Pf2apRKOu15ImLH
   DGayV3ZWKOUqG3b0xShwmS3W2TcEL5gb1ZF8nYN9u/Ujg0PD1Q4p/YOTb
   15gvD0C9aRmY4AGDc1IbJY6snlIilcWXT+AWXtsRhV0hbBYtSuTkqh6Sq
   tcrKCRRBqB8PAEOlZdD4VEz2uFSgVobcu2RF49nKqxIK0lyNUz2C/n9G9
   la9GoPB+3gecPKi3hDWqtUCWFu+rxa/A4oTJn3jZXBcrFFDMnwXyUXuHY
   vkCfqlev+ejANNAOsVQWqgje8r5pPEaGb5WlhllMueX49s6XTc/3inYQ/
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="291661251"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="291661251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10496"; a="628457013"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="628457013"
Received: from iweiny-mobl.amr.corp.intel.com (HELO localhost) ([10.212.104.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 15:30:21 -0700
From:   ira.weiny@intel.com
To:     Michael Tsirkin <mst@redhat.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, qemu-devel@nongnu.org,
        linux-cxl@vger.kernel.org
Subject: [RFC PATCH 5/6] hw/cxl/cxl-events: Add event interrupt support
Date:   Mon, 10 Oct 2022 15:29:43 -0700
Message-Id: <20221010222944.3923556-6-ira.weiny@intel.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20221010222944.3923556-1-ira.weiny@intel.com>
References: <20221010222944.3923556-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

To facilitate testing of event interrupt support add a QMP HMP command
to reset the event logs and issue interrupts when the guest has enabled
those interrupts.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
---
 hmp-commands.hx             | 14 +++++++
 hw/cxl/cxl-events.c         | 82 +++++++++++++++++++++++++++++++++++++
 hw/cxl/cxl-host-stubs.c     |  5 +++
 hw/mem/cxl_type3.c          |  7 +++-
 include/hw/cxl/cxl_device.h |  3 ++
 include/sysemu/sysemu.h     |  3 ++
 6 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 564f1de364df..c59a98097317 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1266,6 +1266,20 @@ SRST
   Inject PCIe AER error
 ERST
 
+    {
+        .name       = "cxl_event_inject",
+        .args_type  = "id:s",
+        .params     = "id <error_status>",
+        .help       = "inject cxl events and interrupt\n\t\t\t"
+                      "<id> = qdev device id\n\t\t\t",
+        .cmd        = hmp_cxl_event_inject,
+    },
+
+SRST
+``cxl_event_inject``
+  Inject CXL Events
+ERST
+
     {
         .name       = "netdev_add",
         .args_type  = "netdev:O",
diff --git a/hw/cxl/cxl-events.c b/hw/cxl/cxl-events.c
index c275280bcb64..6ece6f252462 100644
--- a/hw/cxl/cxl-events.c
+++ b/hw/cxl/cxl-events.c
@@ -10,8 +10,14 @@
 #include <stdint.h>
 
 #include "qemu/osdep.h"
+#include "sysemu/sysemu.h"
+#include "monitor/monitor.h"
 #include "qemu/bswap.h"
 #include "qemu/typedefs.h"
+#include "qapi/qmp/qdict.h"
+#include "hw/pci/pci.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 
@@ -68,6 +74,11 @@ uint16_t log_overflow(struct cxl_event_log *log)
     return cnt;
 }
 
+static void reset_log(struct cxl_event_log *log)
+{
+    log->cur_event = 0;
+}
+
 #define CXL_EVENT_RECORD_FLAG_PERMANENT         BIT(2)
 #define CXL_EVENT_RECORD_FLAG_MAINT_NEEDED      BIT(3)
 #define CXL_EVENT_RECORD_FLAG_PERF_DEGRADED     BIT(4)
@@ -246,3 +257,74 @@ void cxl_mock_add_event_logs(CXLDeviceState *cxlds)
     event_store_add_event(cxlds, CXL_EVENT_TYPE_FATAL,
                           (struct cxl_event_record_raw *)&dram);
 }
+
+static void cxl_reset_all_logs(CXLDeviceState *cxlds)
+{
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        struct cxl_event_log *log = find_event_log(cxlds, i);
+
+        if (!log) {
+            continue;
+        }
+
+        reset_log(log);
+    }
+}
+
+static void cxl_event_irq_assert(PCIDevice *pdev)
+{
+    CXLType3Dev *ct3d = container_of(pdev, struct CXLType3Dev, parent_obj);
+    CXLDeviceState *cxlds = &ct3d->cxl_dstate;
+    int i;
+
+    for (i = 0; i < CXL_EVENT_TYPE_MAX; i++) {
+        struct cxl_event_log *log;
+
+        log = find_event_log(cxlds, i);
+        if (!log || !log->irq_enabled || log_empty(log)) {
+            continue;
+        }
+
+        /* Notifies interrupt, legacy IRQ is not supported */
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, log->irq_vec);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, log->irq_vec);
+        }
+    }
+}
+
+static int do_cxl_event_inject(Monitor *mon, const QDict *qdict)
+{
+    const char *id = qdict_get_str(qdict, "id");
+    CXLType3Dev *ct3d;
+    PCIDevice *pdev;
+    int ret;
+
+    ret = pci_qdev_find_device(id, &pdev);
+    if (ret < 0) {
+        monitor_printf(mon,
+                       "id or cxl device path is invalid or device not "
+                       "found. %s\n", id);
+        return ret;
+    }
+
+    ct3d = container_of(pdev, struct CXLType3Dev, parent_obj);
+    cxl_reset_all_logs(&ct3d->cxl_dstate);
+
+    cxl_event_irq_assert(pdev);
+    return 0;
+}
+
+void hmp_cxl_event_inject(Monitor *mon, const QDict *qdict)
+{
+    const char *id = qdict_get_str(qdict, "id");
+
+    if (do_cxl_event_inject(mon, qdict) < 0) {
+        return;
+    }
+
+    monitor_printf(mon, "OK id: %s\n", id);
+}
diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index cae4afcdde26..61039263f25a 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -12,4 +12,9 @@ void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 void cxl_hook_up_pxb_registers(PCIBus *bus, CXLState *state, Error **errp) {};
 
+void hmp_cxl_event_inject(Monitor *mon, const QDict *qdict)
+{
+    monitor_printf(mon, "CXL devices not supported\n");
+}
+
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 2b13179d116d..b4a90136d190 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -459,7 +459,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 3;
+    unsigned short msix_num = 7;
     int i;
 
     if (!cxl_setup_memory(ct3d, errp)) {
@@ -502,6 +502,11 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
         msix_vector_use(pci_dev, i);
     }
 
+    ct3d->cxl_dstate.event_vector[CXL_EVENT_TYPE_INFO] = 6;
+    ct3d->cxl_dstate.event_vector[CXL_EVENT_TYPE_WARN] = 5;
+    ct3d->cxl_dstate.event_vector[CXL_EVENT_TYPE_FAIL] = 4;
+    ct3d->cxl_dstate.event_vector[CXL_EVENT_TYPE_FATAL] = 3;
+
     /* DOE Initailization */
     if (ct3d->spdm_port) {
         pcie_doe_init(pci_dev, &ct3d->doe_spdm, 0x160, doe_spdm_prot, true, 2);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index 46c50c1c13a6..41232d3b3476 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -84,6 +84,8 @@
 #define CXL_TEST_EVENT_CNT_MAX 15
 
 struct cxl_event_log {
+    bool irq_enabled;
+    int irq_vec;
     int cur_event;
     int nr_events;
     struct cxl_event_record_raw *events[CXL_TEST_EVENT_CNT_MAX];
@@ -129,6 +131,7 @@ typedef struct cxl_device_state {
     /* memory region for persistent memory, HDM */
     uint64_t pmem_size;
 
+    uint16_t event_vector[CXL_EVENT_TYPE_MAX];
     struct cxl_event_log event_logs[CXL_EVENT_TYPE_MAX];
 } CXLDeviceState;
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 812f66a31a90..39476cc50190 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -64,6 +64,9 @@ extern unsigned int nb_prom_envs;
 /* pcie aer error injection */
 void hmp_pcie_aer_inject_error(Monitor *mon, const QDict *qdict);
 
+/* CXL */
+void hmp_cxl_event_inject(Monitor *mon, const QDict *qdict);
+
 /* serial ports */
 
 /* Return the Chardev for serial port i, or NULL if none */
-- 
2.37.2

