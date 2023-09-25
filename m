Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 864F9CE7A9D
	for <linux-cxl@archiver.kernel.org>; Mon, 25 Sep 2023 16:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231689AbjIYQTK (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Mon, 25 Sep 2023 12:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjIYQTJ (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Mon, 25 Sep 2023 12:19:09 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0730B8
        for <linux-cxl@vger.kernel.org>; Mon, 25 Sep 2023 09:19:02 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RvShY6SFyz6K7VL;
        Tue, 26 Sep 2023 00:17:49 +0800 (CST)
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhrpeml500005.china.huawei.com (7.191.163.240) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.31; Mon, 25 Sep 2023 17:19:00 +0100
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
Subject: [PATCH 15/19] hw/cxl/mbox: Wire up interrupts for background completion
Date:   Mon, 25 Sep 2023 17:11:20 +0100
Message-ID: <20230925161124.18940-16-Jonathan.Cameron@huawei.com>
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

From: Davidlohr Bueso <dave@stgolabs.net>

Notify when the background operation is done. Note that for now background
commands are only supported on the main Type 3 mailbox.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 include/hw/cxl/cxl_device.h |  1 +
 hw/cxl/cxl-device-utils.c   | 10 +++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 31 ++++++++++++++-----------------
 3 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index a99a7e6274..b7fa57fd14 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -193,6 +193,7 @@ typedef struct cxl_device_state {
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
+        uint8_t mbox_msi_n;
         union {
             uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 88f0256c79..41763688ce 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -345,10 +345,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt */
+    const uint8_t msi_n = 9;
+
+    /* 2048 payload size */
     ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
                      PAYLOAD_SIZE, CXL_MAILBOX_PAYLOAD_SHIFT);
     cxl_dstate->payload_size = CXL_MAILBOX_MAX_PAYLOAD_SIZE;
+    /* irq support */
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     BG_INT_CAP, 1);
+    ARRAY_FIELD_DP32(cxl_dstate->mbox_reg_state32, CXL_DEV_MAILBOX_CAP,
+                     MSI_N, msi_n);
+    cxl_dstate->mbox_msi_n = msi_n;
 }
 
 static void memdev_reg_init_common(CXLDeviceState *cxl_dstate) { }
diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
index 63acbc1214..3db86b4da7 100644
--- a/hw/cxl/cxl-mailbox-utils.c
+++ b/hw/cxl/cxl-mailbox-utils.c
@@ -8,6 +8,8 @@
  */
 
 #include "qemu/osdep.h"
+#include "hw/pci/msi.h"
+#include "hw/pci/msix.h"
 #include "hw/cxl/cxl.h"
 #include "hw/cxl/cxl_events.h"
 #include "hw/pci/pci.h"
@@ -1092,28 +1094,16 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
 static void bg_timercb(void *opaque)
 {
     CXLCCI *cci = opaque;
-    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->d)->cxl_dstate;
-    uint64_t bg_status_reg = 0;
     uint64_t now = qemu_clock_get_ms(QEMU_CLOCK_VIRTUAL);
     uint64_t total_time = cci->bg.starttime + cci->bg.runtime;
 
     assert(cci->bg.runtime > 0);
-    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                               OP, cci->bg.opcode);
 
     if (now >= total_time) { /* we are done */
-        uint64_t status_reg;
         uint16_t ret = CXL_MBOX_SUCCESS;
 
         cci->bg.complete_pct = 100;
-        /* Clear bg */
-        status_reg = FIELD_DP64(0, CXL_DEV_MAILBOX_STS, BG_OP, 0);
-        cxl_dstate->mbox_reg_state64[R_CXL_DEV_MAILBOX_STS] = status_reg;
-
-        bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                                   RET_CODE, ret);
-
-        /* TODO add ad-hoc cmd succesful completion handling */
+        cci->bg.ret_code = ret;
 
         qemu_log("Background command %04xh finished: %s\n",
                  cci->bg.opcode,
@@ -1124,14 +1114,21 @@ static void bg_timercb(void *opaque)
         timer_mod(cci->bg.timer, now + CXL_MBOX_BG_UPDATE_FREQ);
     }
 
-    bg_status_reg = FIELD_DP64(bg_status_reg, CXL_DEV_BG_CMD_STS,
-                               PERCENTAGE_COMP, cci->bg.complete_pct);
-    cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
-
     if (cci->bg.complete_pct == 100) {
+        /* TODO: generalize to switch CCI */
+        CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
+        CXLDeviceState *cxl_dstate = &ct3d->cxl_dstate;
+        PCIDevice *pdev = PCI_DEVICE(cci->d);
+
         cci->bg.starttime = 0;
         /* registers are updated, allow new bg-capable cmds */
         cci->bg.runtime = 0;
+
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, cxl_dstate->mbox_msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, cxl_dstate->mbox_msi_n);
+        }
     }
 }
 
-- 
2.39.2

