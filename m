Return-Path: <linux-cxl-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E28C6FD18
	for <linux-cxl@archiver.kernel.org>; Tue, 18 Apr 2023 18:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbjDRSB0 (ORCPT <rfc822;linux-cxl@archiver.kernel.org>);
        Tue, 18 Apr 2023 14:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbjDRSBY (ORCPT
        <rfc822;linux-cxl@vger.kernel.org>); Tue, 18 Apr 2023 14:01:24 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B7E1384B
        for <linux-cxl@vger.kernel.org>; Tue, 18 Apr 2023 11:01:18 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id D0A84922A40;
        Tue, 18 Apr 2023 17:55:06 +0000 (UTC)
Received: from pdx1-sub0-mail-a226.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 270009227F9;
        Tue, 18 Apr 2023 17:55:06 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1681840506; a=rsa-sha256;
        cv=none;
        b=31UUYueAbC/suiN+l7Vvt3BxcqWqUZJHrceCsy950roByDOKUF04cHioypUPwINw+/4y+w
        hSspiETliPYBeXtwL7DtMHvchm24oWAKwtr1nHkZYv0cFmUES2DY+WgHJq34YWlt2vlXtt
        HwzwXTaYwxJxO/9T4+2k7AJrZN6mM9bHagn9kdDLSK5c+fp7C7SDLcX2fRZjUPPZ3K/wmW
        4Io7CS6YrpmG+B/+rtb3ra1H55sYXPuM82E9opxHRlwAbcd+hDQREZNhdqULCUAowjPlMa
        MxaEE4Wlnz5YiocY/5daFohn13Zc5Nl9DAs1T9txbsbyXsHm8q5qo9X94zfU4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1681840506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=VD6bLHmOCXGMv/QgtQaA/I+v5UKYnbaBd/iqcXqEjLo=;
        b=vGorH7IxCVX7cN17AZvXokGQysnpa2G9ynZ/3Zqk1Fiwbdaulv/T5fOV0tIHo22B6ZAO/5
        RI1sEDZH6TinneOqBmp8nAVxDiwWAEN415gkq6q1AIpT5ZIg19XrIuYJEiO5GgDl62QEYP
        ldZ4BhKDOa8mhm5sJcOBWE6bnAhjXYGLmAOHGvdQB+52s/q/KhpIUfnsZM9uveBo8A/lhY
        LjpcCu7qgoAatfYs9IPDGnnPyHWPE4BT5L2B9S8UfsVCPKuM7D5gvvmCOQ/zs+MZnZcgF5
        j9eiipqA0+n3U3D7yco+AL0/sLmfy92TcLcZ5dgHgjgGQGyZUGaj3PTc/nyy0g==
ARC-Authentication-Results: i=1;
        rspamd-548d6c8f77-lxbh4;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Lyrical-Lonely: 032546760402fc8f_1681840506634_715316162
X-MC-Loop-Signature: 1681840506634:525926386
X-MC-Ingress-Time: 1681840506634
Received: from pdx1-sub0-mail-a226.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.125.42.190 (trex/6.7.2);
        Tue, 18 Apr 2023 17:55:06 +0000
Received: from localhost.localdomain (ip72-199-50-187.sd.sd.cox.net [72.199.50.187])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a226.dreamhost.com (Postfix) with ESMTPSA id 4Q1BQd3XCYzC2;
        Tue, 18 Apr 2023 10:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1681840505;
        bh=VD6bLHmOCXGMv/QgtQaA/I+v5UKYnbaBd/iqcXqEjLo=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=gmn+fmAhfd8wu7artzLTt38KcrTXc8Hv6vop3dSOYMuC/adfXZdqEvOHu51xqh9jP
         ZRwYRfCaIUtWPY0mzY7e7B6WTBDr/pNwTDK6hpk3EnNLBYk3DRkeccx6ZfKBuSfmSo
         DRlBtJRFUy6djuy1xvznWwUwh28z7PFSGhjHl4rMq0VKy7tkkb6abWbkwjIVftLloq
         4ie0XgAT5vKQlSjto6BeDq/rfGGujjkzb31zBSLB18tc49J8rWuq2/sXoogw4gdNRS
         szdahxqUxzd7uiexJVd7y88ADGN1EOkPoAF4V+5oW6v0pqeBvmbbqQHrtXtUeFWlnn
         sk3SdAO3Neprg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     Jonathan.Cameron@huawei.com
Cc:     dan.j.williams@intel.com, fan.ni@samsung.com,
        a.manzanares@samsung.com, dave.jiang@intel.com, dave@stgolabs.net,
        linux-cxl@vger.kernel.org
Subject: [PATCH 2/5] cxl/mbox: Wire up interrupts for background completion
Date:   Tue, 18 Apr 2023 10:23:34 -0700
Message-Id: <20230418172337.19207-3-dave@stgolabs.net>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230418172337.19207-1-dave@stgolabs.net>
References: <20230418172337.19207-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cxl.vger.kernel.org>
X-Mailing-List: linux-cxl@vger.kernel.org

Notify when the background operation is done.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 hw/cxl/cxl-device-utils.c   | 10 +++++++++-
 hw/cxl/cxl-mailbox-utils.c  | 11 +++++++++++
 hw/mem/cxl_type3.c          |  2 +-
 include/hw/cxl/cxl_device.h |  1 +
 4 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/hw/cxl/cxl-device-utils.c b/hw/cxl/cxl-device-utils.c
index 4bb4e85dae19..b10ab390234c 100644
--- a/hw/cxl/cxl-device-utils.c
+++ b/hw/cxl/cxl-device-utils.c
@@ -272,10 +272,18 @@ static void device_reg_init_common(CXLDeviceState *cxl_dstate)
 
 static void mailbox_reg_init_common(CXLDeviceState *cxl_dstate)
 {
-    /* 2048 payload size, with no interrupt */
+    const uint8_t msi_n = 11;
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
index 1a4480d42908..224bfdb4bfca 100644
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
@@ -980,9 +982,18 @@ static void bg_timercb(void *opaque)
     cxl_dstate->mbox_reg_state64[R_CXL_DEV_BG_CMD_STS] = bg_status_reg;
 
     if (cxl_dstate->bg.complete_pct == 100) {
+        CXLType3Dev *ct3d = container_of(cxl_dstate, CXLType3Dev, cxl_dstate);
+        PCIDevice *pdev = PCI_DEVICE(ct3d);
+
         cxl_dstate->bg.starttime = 0;
         /* registers are updated, allow new bg-capable cmds */
         cxl_dstate->bg.runtime = 0;
+
+        if (msix_enabled(pdev)) {
+            msix_notify(pdev, cxl_dstate->mbox_msi_n);
+        } else if (msi_enabled(pdev)) {
+            msi_notify(pdev, cxl_dstate->mbox_msi_n);
+        }
     }
 }
 
diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
index 63c28a1ed5d2..801f72c5fcae 100644
--- a/hw/mem/cxl_type3.c
+++ b/hw/mem/cxl_type3.c
@@ -777,7 +777,7 @@ static void ct3_realize(PCIDevice *pci_dev, Error **errp)
     ComponentRegisters *regs = &cxl_cstate->crb;
     MemoryRegion *mr = &regs->component_registers;
     uint8_t *pci_conf = pci_dev->config;
-    unsigned short msix_num = 10;
+    unsigned short msix_num = 12;
     int i, rc;
 
     QTAILQ_INIT(&ct3d->error_list);
diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
index dbb8a955723b..f986651b6ead 100644
--- a/include/hw/cxl/cxl_device.h
+++ b/include/hw/cxl/cxl_device.h
@@ -189,6 +189,7 @@ typedef struct cxl_device_state {
     struct {
         MemoryRegion mailbox;
         uint16_t payload_size;
+        uint8_t mbox_msi_n;
         union {
             uint8_t mbox_reg_state[CXL_MAILBOX_REGISTERS_LENGTH];
             uint16_t mbox_reg_state16[CXL_MAILBOX_REGISTERS_LENGTH / 2];
-- 
2.40.0

