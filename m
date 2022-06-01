Return-Path: <linux-cxl-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9D7C433EF
	for <linux-cxl@archiver.kernel.org>; Wed,  1 Jun 2022 16:44:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiFAQoG (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Wed, 1 Jun 2022 12:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233630AbiFAQoF (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Wed, 1 Jun 2022 12:44:05 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD6690CE8
        for <linux-cxl@vger.kernel.org>; Wed,  1 Jun 2022 09:44:04 -0700 (PDT)
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LCvxh4mfLz6802M;
        Thu,  2 Jun 2022 00:39:36 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 18:44:02 +0200
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 17:44:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Paolo Bonzini <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
        "Michael S . Tsirkin" <mst@redhat.com>
CC:     <linux-cxl@vger.kernel.org>, <linuxarm@huawei.com>,
        <alex.bennee@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>,
        Igor Mammedov <imammedo@redhat.com>,
        Markus Armbruster <armbru@redhat.com>,
        "Mark Cave-Ayland" <mark.cave-ayland@ilande.co.uk>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Tong Zhang <ztong0001@gmail.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Shameerali Kolothum Thodi 
        <shameerali.kolothum.thodi@huawei.com>
Subject: [PATCH v2 3/8] hw/cxl: Push linking of CXL targets into i386/pc rather than in machine.c
Date:   Wed, 1 Jun 2022 17:42:30 +0100
Message-ID: <20220601164235.2117-4-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
References: <20220601164235.2117-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml713-chm.china.huawei.com (10.201.108.64) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Whilst here take the oportunity to shorten the function name.

Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 hw/cxl/cxl-host-stubs.c   | 2 +-
 hw/cxl/cxl-host.c         | 8 +++-----
 hw/i386/pc.c              | 5 +++++
 include/hw/cxl/cxl.h      | 2 --
 include/hw/cxl/cxl_host.h | 1 +
 softmmu/vl.c              | 2 --
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/hw/cxl/cxl-host-stubs.c b/hw/cxl/cxl-host-stubs.c
index de3e8894d5..e0d5ec8ad5 100644
--- a/hw/cxl/cxl-host-stubs.c
+++ b/hw/cxl/cxl-host-stubs.c
@@ -8,7 +8,7 @@
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_host.h"
 
-void cxl_fixed_memory_window_link_targets(Error **errp) {};
+void cxl_fmws_link_targets(CXLState *stat, Error **errp) {};
 void cxl_machine_init(Object *obj, CXLState *state) {};
 
 const MemoryRegionOps cfmws_ops;
diff --git a/hw/cxl/cxl-host.c b/hw/cxl/cxl-host.c
index 3a79c32b42..8e7738a65b 100644
--- a/hw/cxl/cxl-host.c
+++ b/hw/cxl/cxl-host.c
@@ -68,14 +68,12 @@ static void cxl_fixed_memory_window_config(CXLState *cxl_state,
     return;
 }
 
-void cxl_fixed_memory_window_link_targets(Error **errp)
+void cxl_fmws_link_targets(CXLState *cxl_state, Error **errp)
 {
-    MachineState *ms = MACHINE(qdev_get_machine());
-
-    if (ms->cxl_devices_state && ms->cxl_devices_state->fixed_windows) {
+    if (cxl_state && cxl_state->fixed_windows) {
         GList *it;
 
-        for (it = ms->cxl_devices_state->fixed_windows; it; it = it->next) {
+        for (it = cxl_state->fixed_windows; it; it = it->next) {
             CXLFixedWindow *fw = it->data;
             int i;
 
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 98e63347f2..6cecd74d58 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -732,6 +732,11 @@ void pc_machine_done(Notifier *notifier, void *data)
     PCMachineState *pcms = container_of(notifier,
                                         PCMachineState, machine_done);
     X86MachineState *x86ms = X86_MACHINE(pcms);
+    MachineState *ms = MACHINE(pcms);
+
+    if (ms->cxl_devices_state) {
+        cxl_fmws_link_targets(ms->cxl_devices_state, &error_fatal);
+    }
 
     /* set the number of CPUs */
     x86_rtc_set_cpus_count(x86ms->rtc, x86ms->boot_cpus);
diff --git a/include/hw/cxl/cxl.h b/include/hw/cxl/cxl.h
index 84078a484d..134b295b40 100644
--- a/include/hw/cxl/cxl.h
+++ b/include/hw/cxl/cxl.h
@@ -53,6 +53,4 @@ struct CXLHost {
 #define TYPE_PXB_CXL_HOST "pxb-cxl-host"
 OBJECT_DECLARE_SIMPLE_TYPE(CXLHost, PXB_CXL_HOST)
 
-void cxl_fixed_memory_window_link_targets(Error **errp);
-
 #endif
diff --git a/include/hw/cxl/cxl_host.h b/include/hw/cxl/cxl_host.h
index 87a6933de2..4d642a81fa 100644
--- a/include/hw/cxl/cxl_host.h
+++ b/include/hw/cxl/cxl_host.h
@@ -15,6 +15,7 @@
 #define CXL_HOST_H
 
 void cxl_machine_init(Object *obj, CXLState *state);
+void cxl_fmws_link_targets(CXLState *stat, Error **errp);
 
 extern const MemoryRegionOps cfmws_ops;
 
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 10d50a2af1..ecef75b77b 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -93,7 +93,6 @@
 #include "qemu/config-file.h"
 #include "qemu/qemu-options.h"
 #include "qemu/main-loop.h"
-#include "hw/cxl/cxl.h"
 #ifdef CONFIG_VIRTFS
 #include "fsdev/qemu-fsdev.h"
 #endif
@@ -2665,7 +2664,6 @@ void qmp_x_exit_preconfig(Error **errp)
 
     qemu_init_board();
     qemu_create_cli_devices();
-    cxl_fixed_memory_window_link_targets(errp);
     qemu_machine_creation_done();
 
     if (loadvm) {
-- 
2.32.0

